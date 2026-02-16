const std = @import("std");
const xml = @import("../xml.zig");

const Database = @import("../Database.zig");
const DeviceID = Database.DeviceID;
const PeripheralID = Database.PeripheralID;
const RegisterID = Database.RegisterID;
const StructID = Database.StructID;
const EnumID = Database.EnumID;
const Arch = @import("../arch.zig").Arch;

const log = std.log.scoped(.target_db);

const ModuleEntry = struct {
    peripheral_id: PeripheralID,
    base_offset: u64,
};

fn parse_isa_to_arch(isa: []const u8) Arch {
    // Convert ISA string (e.g., "CORTEX_M4", "MSP430") to lowercase and match to Arch enum
    var buf: [32]u8 = undefined;
    if (isa.len > buf.len) return .unknown;

    const lower = std.ascii.lowerString(&buf, isa);

    // Try to match against all Arch enum values
    inline for (@typeInfo(Arch).@"enum".fields) |field| {
        if (std.mem.eql(u8, lower, field.name)) {
            return @field(Arch, field.name);
        }
    }

    log.warn("Unknown ISA: {s}, defaulting to unknown arch", .{isa});
    return .unknown;
}

pub fn load_into_db(db: *Database, path: []const u8, device: ?[]const u8) !void {
    var targetdb_dir = try std.fs.cwd().openDir(path, .{});
    defer targetdb_dir.close();

    var devices_dir = try targetdb_dir.openDir("devices", .{ .iterate = true });
    defer devices_dir.close();

    var modules = std.StringHashMap(ModuleEntry).init(db.gpa);
    defer {
        var key_it = modules.keyIterator();
        while (key_it.next()) |key| {
            db.gpa.free(key.*);
        }
        modules.deinit();
    }

    var it = devices_dir.iterate();
    while (try it.next()) |entry| {
        if (entry.kind != .file)
            continue;

        if (!std.mem.startsWith(u8, entry.name, "MSP430") and !std.mem.startsWith(u8, entry.name, "tm4c"))
            continue;

        if (device) |d| {
            if (std.mem.eql(u8, d, entry.name[0 .. entry.name.len - ".xml".len])) {
                try load_device(db, devices_dir, entry.name, &modules);
                return;
            }
        } else {
            try load_device(db, devices_dir, entry.name, &modules);
        }
    } else if (device != null) {
        return error.DeviceMissing;
    }
}

fn load_device(db: *Database, devices_dir: std.fs.Dir, filename: []const u8, modules: *std.StringHashMap(ModuleEntry)) !void {
    const device_file = try devices_dir.openFile(filename, .{});
    defer device_file.close();

    const device_text = try device_file.readToEndAlloc(db.gpa, 1024 * 1024);
    defer db.gpa.free(device_text);

    var doc = try xml.Doc.from_memory(device_text);
    defer doc.deinit();

    const root = try doc.get_root_element();

    const cpu_node = root.find_child(&.{"cpu"}) orelse if (root.find_child(&.{"router"})) |router_node| blk: {
        const subpath_node = router_node.find_child(&.{"subpath"}) orelse return error.MissingField;
        break :blk subpath_node.find_child(&.{"cpu"}) orelse return error.MissingField;
    } else return error.MissingField;

    const isa_str = cpu_node.get_attribute("isa") orelse return error.MissingField;
    const arch = parse_isa_to_arch(isa_str);

    const device_id = try db.create_device(.{
        .arch = arch,
        .description = root.get_attribute("description"),
        .name = root.get_attribute("id") orelse return error.MissingField,
    });

    const include_it = root.iterate(&.{}, &.{"include"});
    const property_it = root.iterate(&.{}, &.{"property"});

    _ = include_it;
    _ = property_it;

    // Detect FPU presence for Cortex-M chips by checking for FPU instance
    if (std.mem.startsWith(u8, isa_str, "CORTEX_M")) {
        var fpu_check_it = cpu_node.iterate(&.{}, &.{"instance"});
        var has_fpu = false;
        while (fpu_check_it.next()) |instance_node| {
            if (instance_node.get_attribute("id")) |id| {
                if (std.mem.eql(u8, id, "FPU")) {
                    has_fpu = true;
                    break;
                }
            }
        }

        try db.add_device_property(device_id, .{
            .key = "cpu.fpuPresent",
            .value = if (has_fpu) "true" else "false",
        });
    }

    var instance_it = cpu_node.iterate(&.{}, &.{"instance"});

    while (instance_it.next()) |instance_node| {
        try load_instance(db, device_id, devices_dir, instance_node, modules);
    }
}

fn load_instance(db: *Database, device_id: DeviceID, devices_dir: std.fs.Dir, node: xml.Node, modules: *std.StringHashMap(ModuleEntry)) !void {
    const name = node.get_attribute("id") orelse return error.MissingField;
    const href = node.get_attribute("href") orelse return error.MissingField;

    const baseaddr_str = node.get_attribute("baseaddr") orelse return error.MissingField;
    const baseaddr = try std.fmt.parseInt(u64, baseaddr_str, 0);

    // Check if we've already loaded this module file
    const module_entry = if (modules.get(href)) |module_entry| blk: {
        // Reuse existing peripheral type
        log.debug("Reusing peripheral type for module file: {s}", .{href});
        break :blk module_entry;
    } else blk: {
        // Load the module file for the first time
        log.debug("Loading new peripheral type from module file: {s}", .{href});

        const module_file = try devices_dir.openFile(href, .{});
        defer module_file.close();

        const module_text = try module_file.readToEndAlloc(db.gpa, 1024 * 1024);
        defer db.gpa.free(module_text);

        var doc = try xml.Doc.from_memory(module_text);
        defer doc.deinit();

        const root = try doc.get_root_element();
        if (root.get_attribute("hidden")) |hidden_str| {
            if (std.mem.eql(u8, hidden_str, "true"))
                return;
        }

        const description = root.get_attribute("description");
        const new_peripheral_id = try db.create_peripheral(.{
            .name = name,
            .description = description,
        });

        // Detect format: check if first register has an offset attribute
        var register_it = root.iterate(&.{}, &.{"register"});
        const has_explicit_offsets = if (register_it.next()) |first_register|
            first_register.get_attribute("offset") != null
        else
            false;

        const base_offset: u64 = if (has_explicit_offsets) base_blk: {
            // Original format: registers have explicit offset attributes
            var min_offset: ?u64 = null;
            register_it = root.iterate(&.{}, &.{"register"});
            while (register_it.next()) |register_node| {
                const offset_str = register_node.get_attribute("offset") orelse return error.MissingField;
                const offset = try std.fmt.parseInt(u64, std.mem.trim(u8, offset_str, " "), 0);
                min_offset = if (min_offset) |current|
                    @min(current, offset)
                else
                    offset;
            }
            break :base_blk min_offset orelse return error.MissingField;
        } else 0;

        const struct_id = try db.get_peripheral_struct(new_peripheral_id);

        if (has_explicit_offsets) {
            register_it = root.iterate(&.{}, &.{"register"});
            while (register_it.next()) |register_node| {
                try load_register(db, struct_id, base_offset, register_node);
            }
        } else {
            var current_offset: u64 = 0;
            register_it = root.iterate(&.{}, &.{"register"});
            while (register_it.next()) |register_node| {
                try load_register_sequential(db, struct_id, &current_offset, register_node);
            }
        }

        // Cache the peripheral type and base offset for this module file
        const new_module_entry = ModuleEntry{
            .peripheral_id = new_peripheral_id,
            .base_offset = base_offset,
        };
        const href_copy = try db.gpa.dupe(u8, href);
        try modules.put(href_copy, new_module_entry);

        break :blk new_module_entry;
    };

    // Create the device peripheral instance with the peripheral type
    const description = node.get_attribute("description");
    const struct_id = try db.get_peripheral_struct(module_entry.peripheral_id);

    _ = try db.create_device_peripheral(device_id, .{
        .name = name,
        .description = description,
        .struct_id = struct_id,
        .offset_bytes = baseaddr + module_entry.base_offset,
    });
}

fn load_register(db: *Database, struct_id: StructID, base_offset: u64, node: xml.Node) !void {
    const offset_str = node.get_attribute("offset") orelse return error.MissingField;
    const abs_offset = try std.fmt.parseInt(u64, std.mem.trim(u8, offset_str, " "), 0);

    const width_str = node.get_attribute("width") orelse return error.MissingField;
    const width_bits = try std.fmt.parseInt(u64, width_str, 0);

    const register_id = try db.create_register(struct_id, .{
        .name = node.get_attribute("acronym") orelse return error.MissingField,
        .description = node.get_attribute("description"),
        .offset_bytes = abs_offset - base_offset,
        .size_bits = width_bits,
    });

    var bitfield_it = node.iterate(&.{}, &.{"bitfield"});
    while (bitfield_it.next()) |bitfield_node| {
        try load_bitfield(db, register_id, bitfield_node);
    }
}

fn load_register_sequential(db: *Database, struct_id: StructID, current_offset: *u64, node: xml.Node) !void {
    const width_str = node.get_attribute("width") orelse return error.MissingField;
    const width_bits = try std.fmt.parseInt(u64, width_str, 0);

    const register_id = try db.create_register(struct_id, .{
        .name = node.get_attribute("acronym") orelse return error.MissingField,
        .description = node.get_attribute("description"),
        .offset_bytes = current_offset.*,
        .size_bits = width_bits,
    });

    // Update offset for next register (width in bits converted to bytes)
    current_offset.* += width_bits / 8;

    var bitfield_it = node.iterate(&.{}, &.{"bitfield"});
    while (bitfield_it.next()) |bitfield_node| {
        try load_bitfield(db, register_id, bitfield_node);
    }
}

fn load_bitfield(db: *Database, register_id: RegisterID, node: xml.Node) !void {
    const name = node.get_attribute("id") orelse return error.MissingField;
    const description = node.get_attribute("description");

    const width_str = node.get_attribute("width") orelse return error.MissingField;
    const width_bits = try std.fmt.parseInt(u8, width_str, 0);

    const end_str = node.get_attribute("end") orelse return error.MissingField;
    const end_bit = try std.fmt.parseInt(u8, end_str, 0);

    const access_str = node.get_attribute("rwaccess");
    const access: Database.Access = if (access_str) |str| .parse_short(str) else .default;

    const enum_id: ?EnumID = if (node.find_child(&.{"bitenum"}) != null) blk: {
        const enum_id = try db.create_enum(null, .{
            .size_bits = width_bits,
        });

        var bitenum_it = node.iterate(&.{}, &.{"bitenum"});
        while (bitenum_it.next()) |bitenum_node| {
            const value_str = bitenum_node.get_attribute("value") orelse return error.MissingField;
            try db.add_enum_field(enum_id, .{
                .name = bitenum_node.get_attribute("id") orelse return error.MissingField,
                .description = bitenum_node.get_attribute("description"),
                .value = try std.fmt.parseInt(u64, value_str, 0),
            });
        }

        break :blk enum_id;
    } else null;

    try db.add_register_field(register_id, .{
        .name = name,
        .description = description,
        .enum_id = enum_id,
        .access = access,
        .offset_bits = end_bit,
        .size_bits = width_bits,
    });
}
