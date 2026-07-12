const std = @import("std");
const xml = @import("xml");

const BitRange = @import("BitRange.zig");
const Database = @import("Database.zig");
const DeviceID = Database.DeviceID;
const PeripheralID = Database.PeripheralID;
const RegisterID = Database.RegisterID;
const StructID = Database.StructID;
const EnumID = Database.EnumID;
const Arch = @import("arch.zig").Arch;

const log = std.log.scoped(.target_db);

const ModuleEntry = struct {
    peripheral_id: PeripheralID,
    base_offset: u64,
};

pub fn load_into_db(db: *Database, io: std.Io, path: []const u8, device: ?[]const u8) !void {
    var targetdb_dir = try std.Io.Dir.cwd().openDir(io, path, .{});
    defer targetdb_dir.close(io);

    var devices_dir = try targetdb_dir.openDir(io, "devices", .{ .iterate = true });
    defer devices_dir.close(io);

    var modules = std.StringHashMap(ModuleEntry).init(db.gpa);
    defer {
        var key_it = modules.keyIterator();
        while (key_it.next()) |key| {
            db.gpa.free(key.*);
        }
        modules.deinit();
    }

    var it = devices_dir.iterate();
    while (try it.next(io)) |entry| {
        if (entry.kind != .file)
            continue;

        if (!std.mem.startsWith(u8, entry.name, "MSP430") and
            !std.mem.startsWith(u8, entry.name, "MSPM0") and
            !std.mem.startsWith(u8, entry.name, "tm4c"))
            continue;

        if (device) |d| {
            if (std.mem.eql(u8, d, entry.name[0 .. entry.name.len - ".xml".len])) {
                try load_device(db, io, devices_dir, entry.name, &modules);
                return;
            }
        } else {
            try load_device(db, io, devices_dir, entry.name, &modules);
        }
    } else if (device != null) {
        return error.DeviceMissing;
    }
}

fn load_device(
    db: *Database,
    io: std.Io,
    devices_dir: std.Io.Dir,
    filename: []const u8,
    modules: *std.StringHashMap(ModuleEntry),
) !void {
    const device_text = try devices_dir.readFileAlloc(io, filename, db.gpa, .limited(1024 * 1024));
    defer db.gpa.free(device_text);

    var doc = try xml.Doc.from_memory(device_text);
    defer doc.deinit();

    const root = try doc.get_root_element();

    const cpu_node = root.find_child(&.{"cpu"}) orelse blk: {
        const router_node = root.find_child(&.{"router"}) orelse return error.MissingField;
        const subpath_node = router_node.find_child(&.{"subpath"}) orelse return error.MissingField;
        break :blk subpath_node.find_child(&.{"cpu"}) orelse return error.MissingField;
    };

    const arch: Arch = .from_string(cpu_node.get_attribute("isa") orelse return error.MissingField);

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
    if (arch.is_cortex_m()) {
        var fpu_check_it = cpu_node.iterate(&.{}, &.{"instance"});
        var has_fpu = false;
        while (fpu_check_it.next()) |instance_node| {
            if (std.mem.eql(u8, "FPU", instance_node.get_attribute("id") orelse continue)) {
                has_fpu = true;
                break;
            }
        }

        try db.add_device_property(device_id, .{
            .key = "cpu.fpuPresent",
            .value = if (has_fpu) "true" else "false",
        });
    }

    var instance_it = cpu_node.iterate(&.{}, &.{"instance"});

    while (instance_it.next()) |instance_node| {
        try load_instance(db, io, device_id, devices_dir, instance_node, modules);
    }
}

fn load_instance(
    db: *Database,
    io: std.Io,
    device_id: DeviceID,
    devices_dir: std.Io.Dir,
    node: xml.Node,
    modules: *std.StringHashMap(ModuleEntry),
) !void {
    const name = node.get_attribute("id") orelse return error.MissingField;
    const href = node.get_attribute("href") orelse return error.MissingField;

    const baseaddr = try node.get_attribute_int(u64, "baseaddr") orelse return error.MissingField;

    // Check if we've already loaded this module file
    const module_entry = if (modules.get(href)) |module_entry| blk: {
        // Reuse existing peripheral type
        log.debug("Reusing peripheral type for module file: {s}", .{href});
        break :blk module_entry;
    } else blk: {
        // Load the module file for the first time
        log.debug("Loading new peripheral type from module file: {s}", .{href});

        const module_text = try devices_dir.readFileAlloc(io, href, db.gpa, .limited(1024 * 1024));
        defer db.gpa.free(module_text);

        var doc = try xml.Doc.from_memory(module_text);
        defer doc.deinit();

        const root = try doc.get_root_element();
        if (root.get_attribute("hidden")) |hidden_str| {
            if (std.mem.eql(u8, hidden_str, "true"))
                return;
        }

        const new_peripheral_id = try db.create_peripheral(.{
            .name = name,
            .description = root.get_attribute("description"),
        });

        // Detect format: check if first register has an offset attribute
        var register_it = root.iterate(&.{}, &.{ "register", "group" });
        const base_offset_opt: ?u63 = if (register_it.next()) |first_register| base_blk: {
            var min_offset: u63 = try first_register.get_attribute_int(u63, "offset") orelse break :base_blk null;
            while (register_it.next()) |register_node| {
                const offset = try register_node.get_attribute_int(u63, "offset") orelse
                    return error.MissingField;
                min_offset = @min(min_offset, offset);
            }
            break :base_blk min_offset;
        } else null;

        const struct_id = try db.get_peripheral_struct(new_peripheral_id);

        if (base_offset_opt) |base_offset| {
            var group_it = root.iterate(&.{}, &.{"group"});
            register_it = root.iterate(&.{}, &.{"register"});
            var group_offset: i64 = 0;

            while (true) {
                while (register_it.next()) |register_node| {
                    _ = try load_register(db, struct_id, group_offset - @as(i64, base_offset), null, register_node);
                }
                const group = group_it.next() orelse break;
                group_offset = try group.get_attribute_int(u63, "offset") orelse return error.MissingField;
                register_it = group.iterate(&.{}, &.{"register"});
            }
        } else {
            var next_offset: u63 = 0;
            register_it = root.iterate(&.{}, &.{"register"});
            while (register_it.next()) |register_node| {
                next_offset += try load_register(db, struct_id, 0, next_offset, register_node);
            }
        }

        // Cache the peripheral type and base offset for this module file
        const new_module_entry = ModuleEntry{
            .peripheral_id = new_peripheral_id,
            .base_offset = @intCast(base_offset_opt orelse 0),
        };
        const href_copy = try db.gpa.dupe(u8, href);
        try modules.put(href_copy, new_module_entry);

        break :blk new_module_entry;
    };

    // Create the device peripheral instance with the peripheral type
    _ = try db.create_device_peripheral(device_id, .{
        .name = name,
        .description = node.get_attribute("description"),
        .struct_id = try db.get_peripheral_struct(module_entry.peripheral_id),
        .offset_bytes = baseaddr + module_entry.base_offset,
    });
}

fn load_register(db: *Database, struct_id: StructID, base_offset: i64, next_offset: ?u63, node: xml.Node) !u63 {
    const offset = next_offset orelse try node.get_attribute_int(u63, "offset") orelse return error.MissingField;
    const width_bits = try node.get_attribute_int(u63, "width") orelse return error.MissingField;
    const count = try node.get_attribute_int(u63, "instances");

    const register_id = try db.create_register(struct_id, .{
        .name = node.get_attribute("acronym") orelse
            node.get_attribute("id") orelse
            return error.MissingField,
        .description = node.get_attribute("description"),
        .offset_bytes = std.math.cast(u64, base_offset + @as(i64, offset)) orelse return error.NegativeOffset,
        .size_bits = width_bits,
        .count = count orelse null,
    });

    var bitfield_it = node.iterate(&.{}, &.{"bitfield"});
    while (bitfield_it.next()) |bitfield_node| {
        try load_bitfield(db, register_id, bitfield_node);
    }

    // Update offset for next register (width in bits converted to bytes)
    return (count orelse 1) * try std.math.divExact(u63, width_bits, 8);
}

fn load_bitfield(db: *Database, register_id: RegisterID, node: xml.Node) !void {
    const name = node.get_attribute("id") orelse return error.MissingField;
    const description = node.get_attribute("description");

    const bit_range: BitRange = try .parse_xml(node);

    const access_str = node.get_attribute("rwaccess");
    const access: Database.Access = if (access_str) |str|
        if (std.mem.eql(u8, str, "RW"))
            .read_write
        else if (std.mem.eql(u8, str, "R/W"))
            .read_write
        else if (std.mem.eql(u8, str, "R"))
            .read_only
        else if (std.mem.eql(u8, str, "W"))
            .write_only
        else blk: {
            log.info("unrecognized access string: '{s}'", .{str});
            break :blk .read_write;
        }
    else
        .read_write;

    const enum_id: ?EnumID = if (node.find_child(&.{"bitenum"}) != null) blk: {
        const enum_id = try db.create_enum(null, .{
            .size_bits = bit_range.width,
        });

        var bitenum_it = node.iterate(&.{}, &.{"bitenum"});
        while (bitenum_it.next()) |bitenum_node| {
            try db.add_enum_field(enum_id, .{
                .name = bitenum_node.get_attribute("id") orelse return error.MissingField,
                .description = bitenum_node.get_attribute("description"),
                .value = try bitenum_node.get_attribute_int(u64, "value") orelse return error.MissingField,
            });
        }

        break :blk enum_id;
    } else null;

    try db.add_register_field(register_id, .{
        .name = name,
        .description = description,
        .enum_id = enum_id,
        .access = access,
        .offset_bits = bit_range.offset,
        .size_bits = bit_range.width,
    });
}
