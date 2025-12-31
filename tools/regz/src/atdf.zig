const std = @import("std");
const ArenaAllocator = std.heap.ArenaAllocator;
const Allocator = std.mem.Allocator;
const assert = std.debug.assert;

const Database = @import("Database.zig");
const DevicePeripheralID = Database.DevicePeripheralID;
const PeripheralID = Database.PeripheralID;
const EnumID = Database.EnumID;
const DeviceID = Database.DeviceID;
const StructID = Database.StructID;
const RegisterID = Database.RegisterID;

const xml = @import("xml.zig");
const Arch = @import("arch.zig").Arch;

const log = std.log.scoped(.atdf);

const InterruptGroupEntry = struct {
    name: []const u8,
    index: i32,
    description: ?[]const u8,
};

const Context = struct {
    db: *Database,
    arena: std.heap.ArenaAllocator,
    interrupt_groups: std.StringHashMapUnmanaged(std.ArrayList(InterruptGroupEntry)) = .empty,
    inferred_register_group_offsets: std.AutoArrayHashMapUnmanaged(StructID, u64) = .{},

    fn init(db: *Database) Context {
        return Context{
            .db = db,
            .arena = std.heap.ArenaAllocator.init(db.gpa),
        };
    }

    fn deinit(ctx: *Context) void {
        {
            var it = ctx.interrupt_groups.iterator();
            while (it.next()) |entry|
                entry.value_ptr.deinit(ctx.db.gpa);
        }

        ctx.interrupt_groups.deinit(ctx.db.gpa);
        ctx.arena.deinit();
    }
};

pub fn load_into_db(db: *Database, doc: xml.Doc) !void {
    var ctx = Context.init(db);
    defer ctx.deinit();

    const root = try doc.get_root_element();
    var module_it = root.iterate(&.{"modules"}, &.{"module"});
    while (module_it.next()) |entry|
        try load_module_type(&ctx, entry);

    var device_it = root.iterate(&.{"devices"}, &.{"device"});
    while (device_it.next()) |entry|
        try load_device(&ctx, entry);
}

fn load_device(ctx: *Context, node: xml.Node) !void {
    validate_attrs(node, &.{
        "architecture",
        "name",
        "family",
        "series",
    });

    const name = node.get_attribute("name") orelse return error.NoDeviceName;
    const arch_str = node.get_attribute("architecture") orelse return error.NoDeviceArch;
    const arch = arch_from_str(arch_str);
    const family = node.get_attribute("family") orelse return error.NoDeviceFamily;

    const db = ctx.db;

    const device_id = try db.create_device(.{
        .name = name,
        .arch = arch,
    });

    try db.add_device_property(device_id, .{ .key = "family", .value = family });
    if (node.get_attribute("series")) |series|
        try db.add_device_property(device_id, .{ .key = "series", .value = series });

    var module_it = node.iterate(&.{"peripherals"}, &.{"module"});
    while (module_it.next()) |module_node|
        load_module_instances(ctx, module_node, device_id) catch |err| {
            log.warn("failed to instantiate module: {}", .{err});
        };

    if (node.find_child(&.{"interrupts"})) |interrupts_node|
        try load_interrupts(ctx, interrupts_node, device_id);

    var param_it = node.iterate(&.{"parameters"}, &.{"param"});
    while (param_it.next()) |param_node|
        try load_param(ctx, param_node, device_id);
}

fn load_param(ctx: *Context, node: xml.Node, device_id: DeviceID) !void {
    const db = ctx.db;
    validate_attrs(node, &.{
        "name",
        "value",
        "caption",
    });

    const name = node.get_attribute("name") orelse return error.MissingParamName;
    const value = node.get_attribute("value") orelse return error.MissingParamName;
    const desc = node.get_attribute("caption");

    try db.add_device_property(device_id, .{
        .key = name,
        .value = value,
        .description = desc,
    });
}

fn load_interrupts(ctx: *Context, node: xml.Node, device_id: DeviceID) !void {
    var interrupt_it = node.iterate(&.{}, &.{"interrupt"});
    while (interrupt_it.next()) |interrupt_node|
        try load_interrupt(ctx, interrupt_node, device_id);

    var interrupt_group_it = node.iterate(&.{}, &.{"interrupt-group"});
    while (interrupt_group_it.next()) |interrupt_group_node|
        try load_interrupt_group(ctx, interrupt_group_node, device_id);
}

fn load_interrupt_group(ctx: *Context, node: xml.Node, device_id: DeviceID) !void {
    const db = ctx.db;
    const module_instance = node.get_attribute("module-instance") orelse return error.MissingModuleInstance;
    const name_in_module = node.get_attribute("name-in-module") orelse return error.MissingNameInModule;
    const index_str = node.get_attribute("index") orelse return error.MissingInterruptGroupIndex;
    const index = try std.fmt.parseInt(i32, index_str, 0);

    if (ctx.interrupt_groups.get(name_in_module)) |group_list| {
        for (group_list.items) |entry| {
            const full_name = try std.mem.join(db.gpa, "_", &.{ module_instance, entry.name });
            defer db.gpa.free(full_name);

            _ = try db.create_interrupt(device_id, .{
                .name = full_name,
                .idx = entry.index + index,
                .description = entry.description,
            });
        }
    }
}

fn arch_from_str(str: []const u8) Arch {
    return if (std.mem.eql(u8, "ARM926EJ-S", str))
        .arm926ej_s
    else if (std.mem.eql(u8, "AVR8", str))
        .avr8
    else if (std.mem.eql(u8, "AVR8L", str))
        .avr8l
    else if (std.mem.eql(u8, "AVR8X", str))
        .avr8x
    else if (std.mem.eql(u8, "AVR8_XMEGA", str))
        .avr8xmega
    else if (std.mem.eql(u8, "CORTEX-A5", str))
        .cortex_a5
    else if (std.mem.eql(u8, "CORTEX-A7", str))
        .cortex_a7
    else if (std.mem.eql(u8, "CORTEX-M0PLUS", str))
        .cortex_m0plus
    else if (std.mem.eql(u8, "CORTEX-M23", str))
        .cortex_m23
    else if (std.mem.eql(u8, "CORTEX-M4", str))
        .cortex_m4
    else if (std.mem.eql(u8, "CORTEX-M7", str))
        .cortex_m7
    else if (std.mem.eql(u8, "MIPS", str))
        .mips
    else
        .unknown;
}

// This function is intended to normalize the struct layout of some peripheral
// instances. Like in ATmega328P there will be register groups with offset of 0
// and then the registers themselves have their absolute offset. We'd like to
// make it easier to dedupe generated types, so this will move the offset of
// the register group to the beginning of its registers (and adjust registers
// accordingly). This should make it easier to determine what register groups
// might be of the same "type".
fn infer_peripheral_offsets(ctx: *Context) !void {
    const db = ctx.db;
    // only infer the peripheral offset if there is only one instance for a given type.
    var type_counts = std.AutoArrayHashMap(PeripheralID, struct { count: usize, instance_id: DevicePeripheralID }).init(db.gpa);
    defer type_counts.deinit();

    for (db.instances.peripherals.keys(), db.instances.peripherals.values()) |instance_id, type_id| {
        if (type_counts.getEntry(type_id)) |entry|
            entry.value_ptr.count += 1
        else
            try type_counts.put(type_id, .{
                .count = 1,
                .instance_id = instance_id,
            });
    }

    for (type_counts.keys(), type_counts.values()) |type_id, result| {
        if (result.count != 1)
            continue;

        infer_peripheral_offset(ctx, type_id, result.instance_id) catch |err|
            log.warn("failed to infer peripheral instance offset: {}", .{err});
    }
}

fn infer_peripheral_offset(ctx: *Context, type_id: PeripheralID, instance_id: DevicePeripheralID) !void {
    const db = ctx.db;

    var min_offset: ?u64 = null;
    var max_size: u64 = 8;
    // first find the min offset of all the registers for this peripheral
    const register_set = db.children.registers.get(type_id) orelse return;
    for (register_set.keys()) |register_id| {
        const offset = db.attrs.offset.get(register_id) orelse continue;
        if (min_offset == null)
            min_offset = offset
        else
            min_offset = @min(min_offset.?, offset);

        if (db.attrs.size.get(register_id)) |size|
            max_size = @max(max_size, size);
    }

    if (min_offset == null)
        return error.NoRegisters;

    const assumed_align = @min(@divExact(std.math.ceilPowerOfTwoAssert(u64, max_size), 8), 8);
    const old_instance_offset = db.attrs.offset.get(instance_id) orelse 0;
    const new_instance_offset = std.mem.alignBackward(u64, old_instance_offset + min_offset.?, assumed_align);
    const offset_delta = @as(i65, new_instance_offset) - @as(i65, old_instance_offset);

    try db.attrs.offset.put(db.gpa, instance_id, new_instance_offset);

    for (register_set.keys()) |register_id| {
        if (db.attrs.offset.getEntry(register_id)) |offset_entry|
            offset_entry.value_ptr.* = @intCast(offset_entry.value_ptr.* - offset_delta);
    }
}

fn infer_enum_size(allocator: Allocator, module_node: xml.Node, value_group_node: xml.Node) !u8 {
    const value_group_name = value_group_node.get_attribute("name") orelse return error.MissingName;

    const max_value = blk: {
        var max_value: u64 = 0;
        var value_it = value_group_node.iterate(&.{}, &.{"value"});
        while (value_it.next()) |value_node| {
            const value_str = value_node.get_attribute("value") orelse continue;
            const value = try std.fmt.parseInt(u64, value_str, 0);
            max_value = @max(value, max_value);
        }

        break :blk max_value;
    };

    var field_sizes: std.ArrayList(u64) = .empty;
    defer field_sizes.deinit(allocator);

    var register_it = module_node.iterate(&.{"register-group"}, &.{"register"});
    while (register_it.next()) |register_node| {
        var bitfield_it = register_node.iterate(&.{}, &.{"bitfield"});
        while (bitfield_it.next()) |bitfield_node| {
            if (bitfield_node.get_attribute("values")) |values| {
                if (std.mem.eql(u8, values, value_group_name)) {
                    log.debug("found values={s}", .{values});
                    const mask_str = bitfield_node.get_attribute("mask") orelse continue;
                    const mask = try std.fmt.parseInt(u64, mask_str, 0);
                    try field_sizes.append(allocator, @popCount(mask));
                }
            }
        }
    }

    log.debug("found field usage count of: {}", .{field_sizes.items.len});

    // if all the field sizes are the same, and the max value can fit in there,
    // then set the size of the enum. If there are no usages of an enum, then
    // assign it the smallest value possible
    return if (field_sizes.items.len == 0)
        if (max_value == 0)
            1
        else
            std.math.log2_int(u64, max_value) + 1
    else blk: {
        var ret: ?u64 = null;
        for (field_sizes.items) |field_size| {
            if (ret == null)
                ret = field_size
            else if (ret.? != field_size)
                return error.InconsistentEnumSizes;
        }

        if (max_value > 0 and (std.math.log2_int(u64, max_value) + 1) > ret.?) {
            log.warn("Uses of this enum are smaller than the calculated size", .{});
            return std.math.log2_int(u64, max_value);
        }

        break :blk @intCast(ret.?);
    };
}

fn get_inlined_register_group(parent_node: xml.Node, parent_name: []const u8) ?xml.Node {
    var register_group_it = parent_node.iterate(&.{}, &.{"register-group"});
    const rg_node = register_group_it.next() orelse return null;
    const rg_name = rg_node.get_attribute("name") orelse return null;
    log.debug("rg name is {s}, parent is {s}", .{ rg_name, parent_name });
    if (register_group_it.next() != null) {
        log.debug("register group not alone", .{});
        return null;
    }

    return if (std.mem.eql(u8, rg_name, parent_name))
        rg_node
    else
        null;
}

// module instances are listed under atdf-tools-device-file.modules.
fn load_module_type(ctx: *Context, node: xml.Node) !void {
    validate_attrs(node, &.{
        "oldname",
        "name",
        "id",
        "version",
        "caption",
        "name2",
    });

    const db = ctx.db;

    const name = node.get_attribute("name") orelse return error.ModuleTypeMissingName;
    //const desc = node.get_attribute("caption");
    //const periph_id = try db.create_peripheral(.{
    //    .name = name,
    //    .description = desc,
    //});

    const struct_id = try db.create_struct(.{});

    var value_group_it = node.iterate(&.{}, &.{"value-group"});
    while (value_group_it.next()) |value_group_node|
        try load_enum(ctx, node, value_group_node, struct_id);

    var interrupt_group_it = node.iterate(&.{}, &.{"interrupt-group"});
    while (interrupt_group_it.next()) |interrupt_group_node|
        try load_module_interrupt_group(ctx, interrupt_group_node);

    const peripheral = try db.create_peripheral(.{
        .struct_id = struct_id,
        .name = name,
    });

    // special case but the most common, if there is only one register
    // group and it's name matches the peripheral, then inline the
    // registers. This operation needs to be done in
    // `loadModuleInstance()` as well
    if (get_inlined_register_group(node, name)) |register_group_node| {
        try load_register_group_children(ctx, register_group_node, peripheral, struct_id);
    } else {
        var register_group_it = node.iterate(&.{}, &.{"register-group"});
        while (register_group_it.next()) |register_group_node|
            try load_register_group(ctx, register_group_node, peripheral);
    }
}

fn load_module_interrupt_group(ctx: *Context, node: xml.Node) !void {
    const name = node.get_attribute("name") orelse return error.MissingInterruptGroupName;
    try ctx.interrupt_groups.put(ctx.db.gpa, name, .{});

    var interrupt_it = node.iterate(&.{}, &.{"interrupt"});
    while (interrupt_it.next()) |interrupt_node|
        try load_module_interrupt_group_entry(ctx, interrupt_node, name);
}

fn load_module_interrupt_group_entry(
    ctx: *Context,
    node: xml.Node,
    group_name: []const u8,
) !void {
    assert(ctx.interrupt_groups.contains(group_name));
    const list = ctx.interrupt_groups.getEntry(group_name).?.value_ptr;

    try list.append(ctx.db.gpa, .{
        .name = node.get_attribute("name") orelse return error.MissingInterruptName,
        .index = if (node.get_attribute("index")) |index_str|
            try std.fmt.parseInt(i32, index_str, 0)
        else
            return error.MissingInterruptIndex,
        .description = node.get_attribute("caption"),
    });
}

fn load_register_group_children(
    ctx: *Context,
    node: xml.Node,
    peripheral: PeripheralID,
    parent: StructID,
) !void {
    var mode_it = node.iterate(&.{}, &.{"mode"});
    while (mode_it.next()) |mode_node|
        load_mode(ctx, mode_node, parent) catch |err| {
            log.err("{f}: failed to load mode: {}", .{ parent, err });
            return err;
        };

    var register_it = node.iterate(&.{}, &.{"register"});
    while (register_it.next()) |register_node|
        try load_register(ctx, register_node, parent);

    var register_group_it = node.iterate(&.{}, &.{"register-group"});
    while (register_group_it.next()) |register_group_node|
        try load_nested_register_group(ctx, register_group_node, peripheral, parent);
}

fn load_nested_register_group(
    ctx: *Context,
    node: xml.Node,
    peripheral: PeripheralID,
    parent: StructID,
) !void {
    const db = ctx.db;
    log.debug("load_nested_register_group: peripheral={f} parent={f}", .{ peripheral, parent });

    validate_attrs(node, &.{
        "name",
        "name-in-module",
        "offset",
        "size",
        "count",
        "caption",
    });

    const name = node.get_attribute("name") orelse return error.MissingRegisterName;
    const name_in_module = node.get_attribute("name-in-module") orelse return error.MissingNameInModule;

    const peripheral_struct_id = try db.get_peripheral_struct(peripheral);
    log.debug("  peripheral_struct_id={f}", .{peripheral_struct_id});
    const struct_id = try db.get_struct_decl_id_by_name(peripheral_struct_id, name_in_module);
    log.debug("  struct_id={f}", .{struct_id});

    try db.add_nested_struct_field(parent, .{
        .name = name,
        .struct_id = struct_id,
        .offset_bytes = if (node.get_attribute("offset")) |offset_str|
            try std.fmt.parseInt(u64, offset_str, 0)
        else
            return error.MissingRegisterOffset,
        .description = node.get_attribute("caption"),

        .size_bytes = if (node.get_attribute("size")) |size_str|
            try std.fmt.parseInt(u64, size_str, 0)
        else
            null,
        .count = if (node.get_attribute("count")) |count_str|
            try std.fmt.parseInt(u64, count_str, 0)
        else
            null,
    });
}

fn infer_register_group_offset(ctx: *Context, node: xml.Node, struct_id: StructID) !void {
    // collect register offsets
    var min: ?u64 = null;
    var register_it = node.iterate(&.{}, &.{ "register", "register-group" });
    while (register_it.next()) |register_node| {
        const offset_str = register_node.get_attribute("offset") orelse continue;
        const offset_bytes = std.fmt.parseInt(u64, offset_str, 0) catch continue;
        min = @min(if (min) |m| m else offset_bytes, offset_bytes);
    }

    if (min) |m| {
        try ctx.inferred_register_group_offsets.put(ctx.arena.allocator(), struct_id, m);
        log.debug("inferred offset of {f}: {} bytes", .{ struct_id, m });
    }
}

// loads a register group which is under a peripheral or under another
// register-group
fn load_register_group(ctx: *Context, node: xml.Node, parent: PeripheralID) !void {
    const db = ctx.db;

    validate_attrs(node, &.{
        "name",
        "caption",
        "aligned",
        "section",
        "size",
    });

    const parent_struct_id = try db.get_peripheral_struct(parent);
    const struct_id = try db.create_nested_struct(parent_struct_id, .{
        .name = node.get_attribute("name") orelse return error.NoName,
        .description = node.get_attribute("caption"),
        .size_bytes = if (node.get_attribute("size")) |size_str|
            try std.fmt.parseInt(u64, size_str, 0)
        else
            null,
    });

    try infer_register_group_offset(ctx, node, struct_id);
    try load_register_group_children(ctx, node, parent, struct_id);
}

fn load_mode(ctx: *Context, node: xml.Node, parent: StructID) !void {
    const db = ctx.db;

    validate_attrs(node, &.{
        "value",
        "mask",
        "name",
        "qualifier",
        "caption",
    });

    _ = try db.create_mode(parent, .{
        .name = node.get_attribute("name") orelse return error.MissingModeName,
        .description = node.get_attribute("caption"),
        .value = node.get_attribute("value") orelse return error.MissingModeValue,
        .qualifier = node.get_attribute("qualifier") orelse return error.MissingModeQualifier,
    });
}

// Search for modes that the parent entity owns, and if the name matches, then
// we have our entry. If not found then the input is malformed.
fn assign_modes_to_register(
    ctx: *Context,
    register_id: RegisterID,
    parent: StructID,
    mode_names: []const u8,
) !void {
    log.debug("assigning mode_names='{s}' to {f} from {f}", .{ mode_names, register_id, parent });
    const db = ctx.db;

    const modes = try db.get_struct_modes(ctx.arena.allocator(), parent);
    var tok_it = std.mem.tokenizeScalar(u8, mode_names, ' ');
    outer: while (tok_it.next()) |mode_str| {
        for (modes) |mode| {
            if (std.mem.eql(u8, mode.name, mode_str)) {
                try db.add_register_mode(register_id, mode.id);
                continue :outer;
            }
        } else {
            log.warn("failed to find mode '{s}'", .{
                mode_str,
            });

            return error.MissingMode;
        }
    }
}

fn load_register(
    ctx: *Context,
    node: xml.Node,
    parent: StructID,
) !void {
    const db = ctx.db;
    log.debug("load_register: parent={f}", .{parent});

    validate_attrs(node, &.{
        "rw",
        "name",
        "access-size",
        "modes",
        "initval",
        "size",
        "access",
        "mask",
        "bit-addressable",
        "atomic-op",
        "ocd-rw",
        "caption",
        "count",
        "offset",
    });

    const name = node.get_attribute("name") orelse return error.MissingRegisterName;

    const register_group_offset = ctx.inferred_register_group_offsets.get(parent) orelse 0;
    log.debug("{f} inferred offset: {}", .{ parent, register_group_offset });

    const register_id = try db.create_register(parent, .{
        .name = name,
        .description = node.get_attribute("caption"),
        .size_bits = if (node.get_attribute("size")) |size_str|
            @as(u64, 8) * try std.fmt.parseInt(u64, size_str, 0)
        else
            return error.MissingRegisterSize,
        .offset_bytes = if (node.get_attribute("offset")) |offset_str|
            try std.fmt.parseInt(u64, offset_str, 0) - register_group_offset
        else
            return error.MissingRegisterOffset,
        .count = if (node.get_attribute("count")) |count_str|
            try std.fmt.parseInt(u64, count_str, 0)
        else
            null,
        .reset_value = if (node.get_attribute("initval")) |initval_str|
            try std.fmt.parseInt(u64, initval_str, 0)
        else
            null,
        .access = if (node.get_attribute("rw")) |access_str|
            try access_from_string(access_str)
        else
            .read_write,
    });

    if (node.get_attribute("modes")) |modes| {
        assign_modes_to_register(ctx, register_id, parent, modes) catch {
            log.warn("failed to find mode '{s}' for register '{s}'", .{
                modes,
                name,
            });
        };
    }

    //// assumes that modes are parsed before registers in the register group
    //var mode_it = node.iterate(&.{}, &.{"mode"});
    //while (mode_it.next()) |mode_node|
    //    load_mode(ctx, mode_node, .{ .register = register_id }) catch |err| {
    //        log.err("{}: failed to load mode: {}", .{ register_id, err });
    //    };

    var field_it = node.iterate(&.{}, &.{"bitfield"});
    while (field_it.next()) |field_node|
        load_field(ctx, field_node, parent, register_id) catch {};
}

fn load_field(ctx: *Context, node: xml.Node, peripheral_struct_id: StructID, parent: RegisterID) !void {
    const db = ctx.db;
    const arena = ctx.arena.allocator();
    validate_attrs(node, &.{
        "caption",
        "lsb",
        "mask",
        "modes",
        "name",
        "rw",
        "value",
        "values",
    });

    const name = node.get_attribute("name") orelse return error.MissingFieldName;
    const mask_str = node.get_attribute("mask") orelse return error.MissingFieldMask;
    const mask = std.fmt.parseInt(u64, mask_str, 0) catch |err| {
        log.warn("failed to parse mask '{s}' of bitfield '{s}'", .{
            mask_str,
            name,
        });

        return err;
    };

    const offset = @ctz(mask);
    const leading_zeroes = @clz(mask);

    // if the bitfield is discontiguous then we'll break it up into single bit
    // fields. This assumes that the order of the bitfields is in order
    if (@popCount(mask) != @as(u64, 64) - leading_zeroes - offset) {
        var bit_count: u32 = 0;
        var i = offset;
        while (i < 32) : (i += 1) {
            if (0 != (@as(u64, 1) << @as(u5, @intCast(i))) & mask) {
                const field_name = try std.fmt.allocPrint(db.gpa, "{s}_bit{}", .{
                    name,
                    bit_count,
                });
                defer db.gpa.free(field_name);

                bit_count += 1;

                // FIXME: field specific r/w
                //if (node.get_attribute("rw")) |access_str| blk: {
                //    const access = access_from_string(access_str) catch break :blk;
                //    switch (access) {
                //        .read_only, .write_only => try db.attrs.access.put(
                //            db.gpa,
                //            id,
                //            access,
                //        ),
                //        else => {},
                //    }
                //}

                try db.add_register_field(parent, .{
                    .name = field_name,
                    .description = node.get_attribute("caption"),
                    .size_bits = 1,
                    .offset_bits = i,
                });

                // FIXME: struct field modes
                if (node.get_attribute("modes")) |modes| {
                    _ = modes;
                    // TODO: modes
                    //assign_modes_to_entity(ctx, id, register_id, modes) catch {
                    //    log.warn("failed to find mode '{s}' for field '{s}'", .{
                    //        modes,
                    //        name,
                    //    });
                    //};
                }

                // discontiguous fields like this don't get to have enums
            }
        }
    } else {
        const width = @popCount(mask);

        log.debug("field: name={s}", .{name});
        if (node.get_attribute("values")) |values|
            log.debug("  values={s}", .{values});

        // FIXME: field based access
        //if (node.get_attribute("rw")) |access_str| blk: {
        //    const access = access_from_string(access_str) catch break :blk;
        //    switch (access) {
        //        .read_only, .write_only => try db.attrs.access.put(
        //            db.gpa,
        //            id,
        //            access,
        //        ),
        //        else => {},
        //    }
        //}

        try db.add_register_field(parent, .{
            .name = name,
            .description = node.get_attribute("caption"),
            .size_bits = width,
            .offset_bits = offset,
            .enum_id = if (node.get_attribute("values")) |values| blk: {
                const e = db.get_enum_by_name(arena, peripheral_struct_id, values) catch |err| {
                    log.warn("{s} failed to get_enum_by_name: {s}", .{ name, values });
                    return err;
                };
                break :blk e.id;
            } else null,
        });

        // FIXME: struct_field modes
        if (node.get_attribute("modes")) |modes| {
            _ = modes;
            // TODO: modes
            //assign_modes_to_entity(ctx, id, register_id, modes) catch {
            //    log.warn("failed to find mode '{s}' for field '{s}'", .{
            //        modes,
            //        name,
            //    });
            //};
        }

        // values _should_ match to a known enum
        // TODO: namespace the enum to the appropriate register, register_group, or peripheral

    }
}

fn access_from_string(str: []const u8) !Database.Access {
    return if (std.mem.eql(u8, "RW", str))
        .read_write
    else if (std.mem.eql(u8, "R", str))
        .read_only
    else if (std.mem.eql(u8, "W", str))
        .write_only
    else
        error.InvalidAccessStr;
}

fn load_enum(
    ctx: *Context,
    module_node: xml.Node,
    node: xml.Node,
    struct_id: StructID,
) !void {
    const db = ctx.db;

    validate_attrs(node, &.{
        "name",
        "caption",
    });

    const size_bits = try infer_enum_size(ctx.db.gpa, module_node, node);

    const name = node.get_attribute("name") orelse return error.MissingEnumName;
    const desc = node.get_attribute("caption");
    const enum_id = try db.create_enum(struct_id, .{
        .name = name,
        .description = desc,
        .size_bits = size_bits,
    });

    log.debug("{f}: name={s} inferred_size={}", .{ enum_id, name, size_bits });

    var value_it = node.iterate(&.{}, &.{"value"});
    while (value_it.next()) |value_node|
        load_enum_field(ctx, value_node, enum_id) catch {};
}

fn load_enum_field(
    ctx: *Context,
    node: xml.Node,
    enum_id: EnumID,
) !void {
    const db = ctx.db;

    validate_attrs(node, &.{
        "name",
        "caption",
        "value",
    });

    const name = node.get_attribute("name") orelse return error.MissingEnumFieldName;
    const value_str = node.get_attribute("value") orelse {
        log.warn("enum missing value: {s}", .{name});
        return error.MissingEnumFieldValue;
    };

    const value = std.fmt.parseInt(u32, value_str, 0) catch |err| {
        log.warn("failed to parse enum value '{s}' of enum field '{s}'", .{
            value_str,
            name,
        });
        return err;
    };

    const desc = node.get_attribute("caption");
    try db.add_enum_field(enum_id, .{
        .name = name,
        .description = desc,
        .value = value,
    });
}

// module instances are listed under atdf-tools-device-file.devices.device.peripherals
fn load_module_instances(
    ctx: *Context,
    node: xml.Node,
    device_id: DeviceID,
) !void {
    const db = ctx.db;
    const module_name = node.get_attribute("name") orelse return error.MissingModuleName;
    const peripheral_id = try db.get_peripheral_by_name(module_name) orelse return error.MissingPeripheral;

    var instance_it = node.iterate(&.{}, &.{"instance"});
    while (instance_it.next()) |instance_node|
        try load_module_instance(ctx, instance_node, device_id, peripheral_id);
}

fn peripheral_is_inlined(ctx: *Context, struct_id: StructID) !bool {
    // inlined peripherals do not have any register groups
    const struct_decls = try ctx.db.get_struct_decls(ctx.arena.allocator(), struct_id);
    log.debug("{f} has {} struct decls. Is inlined: {}", .{ struct_id, struct_decls.len, struct_decls.len == 0 });
    return (struct_decls.len == 0);
}

fn load_module_instance(
    ctx: *Context,
    node: xml.Node,
    device_id: DeviceID,
    peripheral_id: PeripheralID,
) !void {
    validate_attrs(node, &.{
        "oldname",
        "name",
        "caption",
    });

    const struct_id = try ctx.db.get_peripheral_struct(peripheral_id);

    //
    // register-group never has an offset in a module, so we can safely assume
    // that they're used as variants of a peripheral, and never used like
    // clusters in SVD.
    return if (try peripheral_is_inlined(ctx, struct_id))
        load_module_instance_from_peripheral(ctx, node, device_id, peripheral_id)
    else
        load_module_instance_from_register_group(ctx, node, device_id, peripheral_id);
}

fn load_module_instance_from_peripheral(
    ctx: *Context,
    node: xml.Node,
    device_id: DeviceID,
    peripheral_id: PeripheralID,
) !void {
    const db = ctx.db;
    log.debug("load_module_instance_from_peripheral", .{});
    const name = node.get_attribute("name") orelse return error.MissingInstanceName;
    const desc = node.get_attribute("caption");

    const offset_bytes: u64 = if (get_inlined_register_group(node, name)) |register_group_node| blk: {
        log.debug("inlining {s}", .{name});
        const offset_str = register_group_node.get_attribute("offset") orelse return error.MissingPeripheralOffset;
        const offset = try std.fmt.parseInt(u64, offset_str, 0);
        break :blk offset;
    } else {
        return error.Todo;
        //unreachable;
        //var register_group_it = node.iterate(&.{}, &.{"register-group"});
        //while (register_group_it.next()) |register_group_node|
        //    loadRegisterGroupInstance(db, register_group_node, id, peripheral_type_id) catch {
        //        log.warn("skipping register group instance in {s}", .{name});
        //    };
    };

    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const instance_id = try db.create_device_peripheral(device_id, .{
        .struct_id = struct_id,
        .name = name,
        .description = desc,
        .offset_bytes = offset_bytes,
    });

    var signal_it = node.iterate(&.{"signals"}, &.{"signal"});
    while (signal_it.next()) |signal_node|
        try load_signal(ctx, signal_node, instance_id);
}

fn load_module_instance_from_register_group(
    ctx: *Context,
    node: xml.Node,
    device_id: DeviceID,
    peripheral_id: PeripheralID,
) !void {
    log.debug("load_module_instance_from_register_group", .{});
    const db = ctx.db;
    const register_group_node = blk: {
        var it = node.iterate(&.{}, &.{"register-group"});
        const ret = it.next() orelse return error.MissingInstanceRegisterGroup;
        if (it.next() != null) {
            return error.TodoInstanceWithMultipleRegisterGroups;
        }

        break :blk ret;
    };

    const name = node.get_attribute("name") orelse return error.MissingInstanceName;
    const name_in_module = register_group_node.get_attribute("name-in-module") orelse return error.MissingNameInModule;
    const offset_str = register_group_node.get_attribute("offset") orelse return error.MissingOffset;
    const offset = try std.fmt.parseInt(u64, offset_str, 0);
    const desc = node.get_attribute("caption");
    const parent_id = try db.get_peripheral_struct(peripheral_id);
    const struct_decl = try db.get_struct_decl_by_name(ctx.arena.allocator(), parent_id, name_in_module);

    _ = try db.create_device_peripheral(device_id, .{
        // If offset is zero then it's likely that the register group uses absolute
        // offsets
        .offset_bytes = if (offset == 0)
            ctx.inferred_register_group_offsets.get(struct_decl.struct_id) orelse offset
        else
            offset,
        .name = name,
        .description = desc,
        .struct_id = struct_decl.struct_id,
    });
}

fn load_register_group_instance(
    ctx: *Context,
    node: xml.Node,
    peripheral_id: DevicePeripheralID,
    peripheral_type_id: PeripheralID,
) !void {
    const db = ctx.db;
    validate_attrs(node, &.{
        "name",
        "address-space",
        "version",
        "size",
        "name-in-module",
        "caption",
        "id",
        "offset",
    });

    const id = db.create_entity();
    errdefer db.destroy_entity(id);

    log.debug("{}: creating register group instance", .{id});
    const name = node.get_attribute("name") orelse return error.MissingInstanceName;
    const name_in_module = node.get_attribute("name-in-module") orelse {
        log.warn("no 'name-in-module' for register group '{s}'", .{
            name,
        });

        return error.MissingNameInModule;
    };

    const type_id = blk: {
        var type_it = (db.children.register_groups.get(peripheral_type_id) orelse
            return error.MissingRegisterGroupType).iterator();

        while (type_it.next()) |entry| {
            if (db.attrs.name.get(entry.key_ptr.*)) |entry_name|
                if (std.mem.eql(u8, entry_name, name_in_module))
                    break :blk entry.key_ptr.*;
        } else return error.MissingRegisterGroupType;
    };

    try db.instances.register_groups.put(db.gpa, id, type_id);
    try db.add_name(id, name);
    if (node.get_attribute("caption")) |caption|
        try db.add_description(id, caption);

    // size is in bytes
    if (node.get_attribute("size")) |size_str| {
        const size = try std.fmt.parseInt(u64, size_str, 0);
        try db.add_size(id, size);
    }

    if (node.get_attribute("offset")) |offset_str| {
        const offset = try std.fmt.parseInt(u64, offset_str, 0);
        try db.add_offset(id, offset);
    }

    try db.add_child("instance.register_group", peripheral_id, id);
}

fn load_signal(
    ctx: *Context,
    node: xml.Node,
    peripheral_id: DevicePeripheralID,
) !void {
    _ = ctx;
    _ = peripheral_id;
    validate_attrs(node, &.{
        "group",
        "index",
        "pad",
        "function",
        "field",
        "ioset",
    });
}

fn load_interrupt(
    ctx: *Context,
    node: xml.Node,
    device_id: DeviceID,
) !void {
    const db = ctx.db;
    validate_attrs(node, &.{
        "index",
        "name",
        "irq-caption",
        "alternate-name",
        "irq-index",
        "caption",
        "module-instance",
        "irq-name",
        "alternate-caption",
    });

    const name = node.get_attribute("name") orelse return error.MissingInterruptName;
    const index_str = node.get_attribute("index") orelse return error.MissingInterruptIndex;
    const index = std.fmt.parseInt(i32, index_str, 0) catch |err| {
        log.warn("failed to parse value '{s}' of interrupt '{s}'", .{
            index_str,
            name,
        });
        return err;
    };

    const full_name = if (node.get_attribute("module-instance")) |module_instance|
        try std.mem.join(db.gpa, "_", &.{ module_instance, name })
    else
        try db.gpa.dupe(u8, name);
    defer db.gpa.free(full_name);

    _ = try db.create_interrupt(device_id, .{
        .name = full_name,
        .idx = index,
        .description = node.get_attribute("caption"),
    });
}

// For now just emit warning logs when the input has attributes that it shouldn't have
fn validate_attrs(node: xml.Node, attrs: []const []const u8) void {
    var it = node.iterate_attrs();
    while (it.next()) |attr| {
        for (attrs) |expected_attr| {
            if (std.mem.eql(u8, attr.key, expected_attr))
                break;
        } else log.warn("line {}: the '{s}' isn't usually found in the '{s}' element, this could mean unhandled ATDF behaviour or your input is malformed", .{
            node.impl.line,
            attr.key,
            std.mem.span(node.impl.name),
        });
    }
}

const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const expectEqualStrings = std.testing.expectEqualStrings;

test "atdf.register with bitfields and enum" {
    const text =
        \\<avr-tools-device-file>
        \\  <modules>
        \\    <module caption="Real-Time Counter" id="I2116" name="RTC">
        \\      <register-group caption="Real-Time Counter" name="RTC" size="0x20">
        \\        <register caption="Control A"
        \\                  initval="0x00"
        \\                  name="CTRLA"
        \\                  offset="0x00"
        \\                  rw="RW"
        \\                  size="1">
        \\          <bitfield caption="Enable"
        \\                    mask="0x01"
        \\                    name="RTCEN"
        \\                    rw="RW"/>
        \\          <bitfield caption="Correction enable"
        \\                    mask="0x04"
        \\                    name="CORREN"
        \\                    rw="RW"/>
        \\          <bitfield caption="Prescaling Factor"
        \\                    mask="0x78"
        \\                    name="PRESCALER"
        \\                    rw="RW"
        \\                    values="RTC_PRESCALER"/>
        \\          <bitfield caption="Run In Standby"
        \\                    mask="0x80"
        \\                    name="RUNSTDBY"
        \\                    rw="RW"/>
        \\        </register>
        \\      </register-group>
        \\      <value-group caption="Prescaling Factor select" name="RTC_PRESCALER">
        \\         <value caption="RTC Clock / 1" name="DIV1" value="0x00"/>
        \\         <value caption="RTC Clock / 2" name="DIV2" value="0x01"/>
        \\      </value-group>
        \\    </module>
        \\  </modules>
        \\</avr-tools-device-file>
    ;
    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .atdf, doc);
    defer db.destroy();

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    const peripheral_id = try db.get_peripheral_by_name("RTC") orelse return error.NoPeripheral;
    const struct_id = try db.get_peripheral_struct(peripheral_id);

    // RTC_PRESCALER enum checks
    // =========================
    const rtc_prescaler = try db.get_enum_by_name(allocator, struct_id, "RTC_PRESCALER");

    try expectEqualStrings("Prescaling Factor select", rtc_prescaler.description.?);

    // DIV1 enum field checks
    // ======================
    const div1 = try db.get_enum_field_by_name(allocator, rtc_prescaler.id, "DIV1");

    try expectEqualStrings("RTC Clock / 1", div1.description.?);
    try expectEqual(@as(u64, 0), div1.value);

    // DIV2 enum field checks
    // ======================
    const div2 = try db.get_enum_field_by_name(allocator, rtc_prescaler.id, "DIV2");

    try expectEqualStrings("RTC Clock / 2", div2.description.?);
    try expectEqual(@as(u32, 1), div2.value);

    // CTRLA register checks
    // ===============
    const ctrla = try db.get_register_by_name(allocator, struct_id, "CTRLA");

    // access is read-write, so its entry is omitted (we assume read-write by default)
    try expectEqual(.read_write, ctrla.access);

    // check name and description
    try expectEqualStrings("CTRLA", ctrla.name);
    try expectEqualStrings("Control A", ctrla.description.?);

    // reset value of the register is 0 (initval attribute)
    try expectEqual(@as(u64, 0), ctrla.reset_value);

    // byte offset is 0
    try expectEqual(@as(u32, 0), ctrla.offset_bytes);

    // size of register is 8 bits, note that ATDF measures in bytes
    try expectEqual(@as(u8, 8), ctrla.size_bits);

    // there will 4 registers total, they will all be children of the one register
    const ctrla_fields = try db.get_register_fields(allocator, ctrla.id, .{ .distinct = false });
    try expectEqual(@as(usize, 4), ctrla_fields.len);

    // RTCEN field checks
    // ============
    const rtcen = ctrla_fields[0];

    try expectEqualStrings("RTCEN", rtcen.name);
    try expectEqualStrings("Enable", rtcen.description.?);
    try expectEqual(@as(u32, 0), rtcen.offset_bits);
    try expectEqual(@as(u8, 1), rtcen.size_bits);

    // CORREN field checks
    // ============
    const corren = ctrla_fields[1];

    try expectEqualStrings("CORREN", corren.name);
    try expectEqual(@as(u32, 2), corren.offset_bits);
    try expectEqual(@as(u8, 1), corren.size_bits);

    // PRESCALER field checks
    // ============
    const prescaler = ctrla_fields[2];

    try expectEqualStrings("PRESCALER", prescaler.name);
    try expectEqualStrings("Prescaling Factor", prescaler.description.?);
    try expectEqual(@as(u32, 3), prescaler.offset_bits);
    try expectEqual(@as(u8, 4), prescaler.size_bits);
    try expectEqual(rtc_prescaler.id, prescaler.enum_id);

    // RUNSTDBY field checks
    // ============
    const runstdby = ctrla_fields[3];

    try expectEqualStrings("RUNSTDBY", runstdby.name);
    try expectEqualStrings("Run In Standby", runstdby.description.?);
    try expectEqual(@as(u32, 7), runstdby.offset_bits);
    try expectEqual(@as(u8, 1), runstdby.size_bits);
}

test "atdf.register with mode" {
    const text =
        \\<avr-tools-device-file>
        \\  <modules>
        \\    <module caption="16-bit Timer/Counter Type A" id="I2117" name="TCA">
        \\      <register-group caption="16-bit Timer/Counter Type A" name="TCA" size="0x40">
        \\        <mode caption="Single Mode"
        \\              name="SINGLE"
        \\              qualifier="TCA.SINGLE.CTRLD.SPLITM"
        \\              value="0"/>
        \\        <mode caption="Split Mode"
        \\              name="SPLIT"
        \\              qualifier="TCA.SPLIT.CTRLD.SPLITM"
        \\              value="1"/>
        \\        <register caption="Control A"
        \\                  initval="0x00"
        \\                  modes="SINGLE"
        \\                  name="CTRLA"
        \\                  offset="0x00"
        \\                  rw="RW"
        \\                  size="1"/>
        \\      </register-group>
        \\    </module>
        \\  </modules>
        \\</avr-tools-device-file>
        \\
    ;

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .atdf, doc);
    defer db.destroy();

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const tca_id = try db.get_peripheral_by_name("TCA") orelse return error.MissingRegsister;
    const struct_id = try db.get_peripheral_struct(tca_id);
    const modes = try db.get_struct_modes(arena.allocator(), struct_id);

    try expectEqual(2, modes.len);

    // the name of the mode is 'SINGLE'
    try expectEqualStrings("SINGLE", modes[0].name);
    try expectEqualStrings("0", modes[0].value);
    try expectEqualStrings("TCA.SINGLE.CTRLD.SPLITM", modes[0].qualifier);

    try expectEqualStrings("SPLIT", modes[1].name);
    try expectEqualStrings("1", modes[1].value);
    try expectEqualStrings("TCA.SPLIT.CTRLD.SPLITM", modes[1].qualifier);
}

test "atdf.instance of register group" {
    const text =
        \\<avr-tools-device-file>
        \\  <devices>
        \\    <device name="ATmega328P" architecture="AVR8" family="megaAVR">
        \\      <peripherals>
        \\        <module name="PORT">
        \\          <instance name="PORTB" caption="I/O Port">
        \\            <register-group name="PORTB"
        \\                            name-in-module="PORTB"
        \\                            offset="0x00"
        \\                            address-space="data"
        \\                            caption="I/O Port"/>
        \\          </instance>
        \\          <instance name="PORTC" caption="I/O Port">
        \\            <register-group name="PORTC"
        \\                            name-in-module="PORTC"
        \\                            offset="0x00"
        \\                            address-space="data"
        \\                            caption="I/O Port"/>
        \\          </instance>
        \\        </module>
        \\      </peripherals>
        \\    </device>
        \\  </devices>
        \\  <modules>
        \\    <module caption="I/O Port" name="PORT">
        \\      <register-group caption="I/O Port" name="PORTB">
        \\        <register caption="Port B Data Register"
        \\                  name="PORTB"
        \\                  offset="0x25"
        \\                  size="1"
        \\                  mask="0xFF"/>
        \\        <register caption="Port B Data Direction Register"
        \\                  name="DDRB"
        \\                  offset="0x24"
        \\                  size="1"
        \\                  mask="0xFF"/>
        \\        <register caption="Port B Input Pins"
        \\                  name="PINB"
        \\                  offset="0x23"
        \\                  size="1"
        \\                  mask="0xFF"
        \\                  ocd-rw="R"/>
        \\      </register-group>
        \\      <register-group caption="I/O Port" name="PORTC">
        \\        <register caption="Port C Data Register"
        \\                  name="PORTC"
        \\                  offset="0x28"
        \\                  size="1"
        \\                  mask="0x7F"/>
        \\        <register caption="Port C Data Direction Register"
        \\                  name="DDRC"
        \\                  offset="0x27"
        \\                  size="1"
        \\                  mask="0x7F"/>
        \\        <register caption="Port C Input Pins"
        \\                  name="PINC"
        \\                  offset="0x26"
        \\                  size="1"
        \\                  mask="0x7F"
        \\                  ocd-rw="R"/>
        \\      </register-group>
        \\      <register-group caption="I/O Port" name="PORTD">
        \\        <register caption="Port D Data Register"
        \\                  name="PORTD"
        \\                  offset="0x2B"
        \\                  size="1"
        \\                  mask="0xFF"/>
        \\        <register caption="Port D Data Direction Register"
        \\                  name="DDRD"
        \\                  offset="0x2A"
        \\                  size="1"
        \\                  mask="0xFF"/>
        \\        <register caption="Port D Input Pins"
        \\                  name="PIND"
        \\                  offset="0x29"
        \\                  size="1"
        \\                  mask="0xFF"
        \\                  ocd-rw="R"/>
        \\      </register-group>
        \\    </module>
        \\  </modules>
        \\</avr-tools-device-file>
        \\
    ;

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .atdf, doc);
    defer db.destroy();

    const device_id = try db.get_device_id_by_name("ATmega328P") orelse return error.NoDevice;

    const portb_instance = try db.get_device_peripheral_by_name(arena.allocator(), device_id, "PORTB");
    try expectEqual(@as(u64, 0x23), portb_instance.offset_bytes);

    // Register assertions
    const ddrb = try db.get_register_by_name(arena.allocator(), portb_instance.struct_id, "DDRB");
    try expectEqual(@as(u64, 0x1), ddrb.offset_bytes);

    const pinb = try db.get_register_by_name(arena.allocator(), portb_instance.struct_id, "PINB");
    try expectEqual(@as(u64, 0x0), pinb.offset_bytes);
}

test "atdf.interrupts" {
    const text =
        \\<avr-tools-device-file>
        \\  <devices>
        \\    <device name="ATmega328P" architecture="AVR8" family="megaAVR">
        \\      <interrupts>
        \\        <interrupt name="TEST_VECTOR1" index="1"/>
        \\        <interrupt name="TEST_VECTOR2" index="5"/>
        \\      </interrupts>
        \\    </device>
        \\  </devices>
        \\</avr-tools-device-file>
        \\
    ;

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .atdf, doc);
    defer db.destroy();

    const device_id = try db.get_device_id_by_name("ATmega328P") orelse return error.NoDevice;
    const vector1_id = try db.get_interrupt_by_name(device_id, "TEST_VECTOR1") orelse return error.NoInterrupt;
    try expectEqual(@as(i32, 1), try db.get_interrupt_idx(vector1_id));

    const vector2_id = try db.get_interrupt_by_name(device_id, "TEST_VECTOR2") orelse return error.NoInterrupt;
    try expectEqual(@as(i32, 5), try db.get_interrupt_idx(vector2_id));
}

test "atdf.interrupts with module-instance" {
    const text =
        \\<avr-tools-device-file>
        \\  <devices>
        \\    <device name="ATmega328P" architecture="AVR8" family="megaAVR">
        \\      <interrupts>
        \\        <interrupt index="1" module-instance="CRCSCAN" name="NMI"/>
        \\        <interrupt index="2" module-instance="BOD" name="VLM"/>
        \\      </interrupts>
        \\    </device>
        \\  </devices>
        \\</avr-tools-device-file>
        \\
    ;

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .atdf, doc);
    defer db.destroy();

    const device_id = try db.get_device_id_by_name("ATmega328P") orelse return error.NoDevice;

    const crcscan_nmi_id = try db.get_interrupt_by_name(device_id, "CRCSCAN_NMI") orelse return error.NoInterrupt;
    try expectEqual(@as(i32, 1), try db.get_interrupt_idx(crcscan_nmi_id));

    const bod_vlm_id = try db.get_interrupt_by_name(device_id, "BOD_VLM") orelse return error.NoInterrupt;
    try expectEqual(@as(i32, 2), try db.get_interrupt_idx(bod_vlm_id));
}

test "atdf.interrupts with interrupt-groups" {
    const text =
        \\<avr-tools-device-file>
        \\  <devices>
        \\    <device name="ATmega328P" architecture="AVR8" family="megaAVR">
        \\      <interrupts>
        \\        <interrupt-group index="1" module-instance="PORTB" name-in-module="PORT"/>
        \\      </interrupts>
        \\    </device>
        \\  </devices>
        \\  <modules>
        \\    <module name="PORTB">
        \\      <interrupt-group name="PORT">
        \\        <interrupt index="0" name="INT0"/>
        \\        <interrupt index="1" name="INT1"/>
        \\      </interrupt-group>
        \\    </module>
        \\  </modules>
        \\</avr-tools-device-file>
        \\
    ;

    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .atdf, doc);
    defer db.destroy();

    const device_id = try db.get_device_id_by_name("ATmega328P") orelse return error.NoDevice;

    const portb_int0_id = try db.get_interrupt_by_name(device_id, "PORTB_INT0") orelse return error.NoInterrupt;
    try expectEqual(@as(i32, 1), try db.get_interrupt_idx(portb_int0_id));

    const portb_int1_id = try db.get_interrupt_by_name(device_id, "PORTB_INT1") orelse return error.NoInterrupt;
    try expectEqual(@as(i32, 2), try db.get_interrupt_idx(portb_int1_id));
}

test "atdf.non-consecutive bitfield with enum" {
    // In this example, WDP is a bitfield with non-consecutive bits. We break
    // up the field into individual bits, and do not associate the fields with the enum.
    //
    // As a future improvement, we could create a comptime remapping of the
    // bits, but it's hardly worth the effor for such a small edge case at this
    // moment.
    const text =
        \\<avr-tools-device-file>
        \\  <modules>
        \\    <module caption="Watchdog Timer" name="WDT">
        \\      <register-group caption="Watchdog Timer" name="WDT">
        \\        <register caption="Watchdog Timer Control Register" name="WDTCSR" offset="0x60" size="1" ocd-rw="R">
        \\          <bitfield caption="Watchdog Timeout Interrupt Flag" mask="0x80" name="WDIF"/>
        \\          <bitfield caption="Watchdog Timeout Interrupt Enable" mask="0x40" name="WDIE"/>
        \\          <bitfield caption="Watchdog Timer Prescaler Bits" mask="0x27" name="WDP" values="WDOG_TIMER_PRESCALE_4BITS"/>
        \\          <bitfield caption="Watchdog Change Enable" mask="0x10" name="WDCE"/>
        \\          <bitfield caption="Watch Dog Enable" mask="0x08" name="WDE"/>
        \\        </register>
        \\      </register-group>
        \\      <value-group name="WDOG_TIMER_PRESCALE_4BITS">
        \\        <value caption="Oscillator Cycles 2K" name="OSCILLATOR_CYCLES_2K" value="0x00"/>
        \\        <value caption="Oscillator Cycles 4K" name="OSCILLATOR_CYCLES_4K" value="0x01"/>
        \\        <value caption="Oscillator Cycles 8K" name="OSCILLATOR_CYCLES_8K" value="0x02"/>
        \\        <value caption="Oscillator Cycles 16K" name="OSCILLATOR_CYCLES_16K" value="0x03"/>
        \\        <value caption="Oscillator Cycles 32K" name="OSCILLATOR_CYCLES_32K" value="0x04"/>
        \\        <value caption="Oscillator Cycles 64K" name="OSCILLATOR_CYCLES_64K" value="0x05"/>
        \\        <value caption="Oscillator Cycles 128K" name="OSCILLATOR_CYCLES_128K" value="0x06"/>
        \\        <value caption="Oscillator Cycles 256K" name="OSCILLATOR_CYCLES_256K" value="0x07"/>
        \\        <value caption="Oscillator Cycles 512K" name="OSCILLATOR_CYCLES_512K" value="0x08"/>
        \\        <value caption="Oscillator Cycles 1024K" name="OSCILLATOR_CYCLES_1024K" value="0x09"/>
        \\      </value-group>
        \\    </module>
        \\  </modules>
        \\</avr-tools-device-file>
    ;
    const doc = try xml.Doc.from_memory(text);
    var db = try Database.create_from_doc(std.testing.allocator, .atdf, doc);
    defer db.destroy();

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    const peripheral_id = try db.get_peripheral_by_name("WDT") orelse return error.NoPeripheral;
    const struct_id = try db.get_peripheral_struct(peripheral_id);

    // Check for enum existence
    _ = try db.get_enum_by_name(allocator, struct_id, "WDOG_TIMER_PRESCALE_4BITS");

    const wdtcsr = try db.get_register_by_name(allocator, struct_id, "WDTCSR");

    // There will 5 registers total, but one will be split into 4, totalling in 8.
    const fields = try db.get_register_fields(allocator, wdtcsr.id, .{ .distinct = false });
    try expectEqual(@as(usize, 8), fields.len);

    // WDP_bit0 field checks
    // ============
    const wdp_bit0 = fields[0];
    try expectEqualStrings("WDP_bit0", wdp_bit0.name);
    try expectEqual(null, wdp_bit0.enum_id);

    // WDP_bit1 field checks
    // ============
    const wdp_bit1 = fields[1];
    try expectEqualStrings("WDP_bit1", wdp_bit1.name);
    try expectEqual(null, wdp_bit1.enum_id);

    // WDP_bit2 field checks
    // ============
    const wdp_bit2 = fields[2];
    try expectEqualStrings("WDP_bit2", wdp_bit2.name);
    try expectEqual(null, wdp_bit2.enum_id);

    // WDP_bit3 field checks
    // ============
    const wdp_bit3 = fields[5]; // notice the field index
    try expectEqualStrings("WDP_bit3", wdp_bit3.name);
    try expectEqual(null, wdp_bit3.enum_id);
}
