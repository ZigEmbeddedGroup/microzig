//! Code generation and associated tests
const std = @import("std");
const Allocator = std.mem.Allocator;
const assert = std.debug.assert;

const Database = @import("Database.zig");
const EntityId = Database.EntityId;
const EntitySet = Database.EntitySet;

const arm = @import("arch/arm.zig");
const avr = @import("arch/avr.zig");

const log = std.log.scoped(.gen);

const EntityWithOffsetAndSize = struct {
    id: EntityId,
    offset: u64,
    size: u64,
};

const EntityWithOffset = struct {
    id: EntityId,
    offset: u64,

    fn less_than(_: void, lhs: EntityWithOffset, rhs: EntityWithOffset) bool {
        return lhs.offset < rhs.offset;
    }
};

pub fn to_zig(db: Database, out_writer: anytype) !void {
    var buffer = std.ArrayList(u8).init(db.arena.allocator());
    defer buffer.deinit();

    const writer = buffer.writer();
    try writer.writeAll(
        \\const micro = @import("microzig");
        \\const mmio = micro.mmio;
        \\
    );
    try write_devices(db, writer);
    try write_types(db, writer);
    try writer.writeByte(0);

    // format the generated code
    var ast = try std.zig.Ast.parse(db.gpa, @ptrCast([:0]const u8, buffer.items[0 .. buffer.items.len - 1]), .zig);
    defer ast.deinit(db.gpa);

    // TODO: ast check?
    const text = try ast.render(db.gpa);
    defer db.gpa.free(text);

    try out_writer.writeAll(text);
}

fn write_devices(db: Database, writer: anytype) !void {
    if (db.instances.devices.count() == 0)
        return;

    try writer.writeAll(
        \\
        \\pub const devices = struct {
        \\
    );

    // TODO: order devices alphabetically
    for (db.instances.devices.keys()) |device_id| {
        write_device(db, device_id, writer) catch |err| {
            log.warn("failed to write device: {}", .{err});
        };
    }

    try writer.writeAll("};\n");
}

pub fn write_comment(allocator: Allocator, comment: []const u8, writer: anytype) !void {
    var tokenized = std.ArrayList(u8).init(allocator);
    defer tokenized.deinit();

    var first = true;
    var tok_it = std.mem.tokenize(u8, comment, "\n\r \t");
    while (tok_it.next()) |token| {
        if (!first)
            first = false
        else
            try tokenized.writer().writeByte(' ');

        try tokenized.writer().writeAll(token);
    }

    const unescaped = try std.mem.replaceOwned(u8, allocator, tokenized.items, "\\n", "\n");
    defer allocator.free(unescaped);

    var line_it = std.mem.tokenize(u8, unescaped, "\n");
    while (line_it.next()) |line|
        try writer.print("/// {s}\n", .{line});
}

fn write_string(str: []const u8, writer: anytype) !void {
    if (std.mem.containsAtLeast(u8, str, 1, "\n")) {
        try writer.writeByte('\n');
        var line_it = std.mem.split(u8, str, "\n");
        while (line_it.next()) |line|
            try writer.print("\\\\{s}\n", .{line});
    } else {
        try writer.print("\"{s}\"", .{str});
    }
}

fn write_device(db: Database, device_id: EntityId, out_writer: anytype) !void {
    assert(db.entity_is("instance.device", device_id));
    const name = db.attrs.name.get(device_id) orelse return error.MissingDeviceName;

    var buffer = std.ArrayList(u8).init(db.arena.allocator());
    defer buffer.deinit();

    const writer = buffer.writer();
    // TODO: multiline?
    if (db.attrs.description.get(device_id)) |description|
        try write_comment(db.arena.allocator(), description, writer);

    try writer.print(
        \\pub const {s} = struct {{
        \\
    , .{std.zig.fmtId(name)});

    // TODO: alphabetic order
    const properties = db.instances.devices.get(device_id).?.properties;
    if (properties.count() > 0) {
        try writer.writeAll("pub const properties = struct {\n");
        var it = properties.iterator();
        while (it.next()) |entry| {
            try writer.print("pub const {s} = ", .{
                std.zig.fmtId(entry.key_ptr.*),
            });

            try write_string(entry.value_ptr.*, writer);
            try writer.writeAll(";\n");
        }

        try writer.writeAll("};\n\n");
    }

    write_vector_table(db, device_id, writer) catch |err|
        log.warn("failed to write vector table: {}", .{err});

    if (db.children.peripherals.get(device_id)) |peripheral_set| {
        var list = std.ArrayList(EntityWithOffset).init(db.gpa);
        defer list.deinit();

        for (peripheral_set.keys()) |peripheral_id| {
            const offset = db.attrs.offset.get(peripheral_id) orelse return error.MissingPeripheralInstanceOffset;
            try list.append(.{ .id = peripheral_id, .offset = offset });
        }

        std.sort.insertion(EntityWithOffset, list.items, {}, EntityWithOffset.less_than);

        try writer.writeAll("pub const peripherals = struct {\n");
        for (list.items) |periph|
            write_peripheral_instance(db, periph.id, periph.offset, writer) catch |err| {
                log.warn("failed to serialize peripheral instance: {}", .{err});
            };

        try writer.writeAll("};\n");
    }

    try writer.writeAll("};\n");
    try out_writer.writeAll(buffer.items);
}

// generates a string for a type in the `types` namespace of the generated
// code. Since this is only used in code generation, just going to stuff it in
// the arena allocator
fn types_reference(db: Database, type_id: EntityId) ![]const u8 {
    // TODO: assert type_id is a type
    var full_name_components = std.ArrayList([]const u8).init(db.gpa);
    defer full_name_components.deinit();

    var id = type_id;

    // hard limit for walking up the tree, if we hit it there's a bug
    const count_max: u32 = 8;
    var count: u32 = 0;
    while (count < count_max) : (count += 1) {
        if (db.attrs.name.get(id)) |next_name|
            try full_name_components.insert(0, next_name)
        else
            return error.MissingTypeName;

        if (db.attrs.parent.get(id)) |parent_id|
            id = parent_id
        else
            break;
    } else @panic("hit limit for reference length");

    if (full_name_components.items.len == 0)
        return error.CantReference;

    var full_name = std.ArrayList(u8).init(db.arena.allocator());
    const writer = full_name.writer();
    try writer.writeAll("types");

    // determine the namespace under 'types' the reference is under
    const root_parent_entity_type = db.get_entity_type(id).?;
    inline for (@typeInfo(Database.EntityType).Enum.fields) |field| {
        if (root_parent_entity_type == @field(Database.EntityType, field.name)) {
            try writer.print(".{s}s", .{field.name});
            break;
        }
    }

    for (full_name_components.items) |component|
        try writer.print(".{s}", .{
            std.zig.fmtId(component),
        });

    return full_name.toOwnedSlice();
}

fn write_vector_table(
    db: Database,
    device_id: EntityId,
    out_writer: anytype,
) !void {
    assert(db.entity_is("instance.device", device_id));

    var buffer = std.ArrayList(u8).init(db.arena.allocator());
    defer buffer.deinit();

    const writer = buffer.writer();
    const arch = db.instances.devices.get(device_id).?.arch;
    if (arch.is_arm())
        try arm.write_interrupt_vector(db, device_id, writer)
    else if (arch.is_avr())
        try avr.write_interrupt_vector(db, device_id, writer)
    else if (arch == .unknown)
        return
    else
        unreachable;

    try out_writer.writeAll(buffer.items);
}

fn write_peripheral_instance(db: Database, instance_id: EntityId, offset: u64, out_writer: anytype) !void {
    assert(db.entity_is("instance.peripheral", instance_id));
    var buffer = std.ArrayList(u8).init(db.arena.allocator());
    defer buffer.deinit();

    const writer = buffer.writer();
    const name = db.attrs.name.get(instance_id) orelse return error.MissingPeripheralInstanceName;
    const type_id = db.instances.peripherals.get(instance_id).?;
    assert(db.attrs.name.contains(type_id));
    const type_ref = try types_reference(db, type_id);

    if (db.attrs.description.get(instance_id)) |description|
        try write_comment(db.arena.allocator(), description, writer)
    else if (db.attrs.description.get(type_id)) |description|
        try write_comment(db.arena.allocator(), description, writer);

    var array_prefix_buf: [80]u8 = undefined;
    const array_prefix = if (db.attrs.count.get(instance_id)) |count|
        try std.fmt.bufPrint(&array_prefix_buf, "[{}]", .{count})
    else
        "";

    try writer.print("pub const {s} = @intToPtr(*volatile {s}{s}, 0x{x});\n", .{
        std.zig.fmtId(name),
        array_prefix,
        type_ref,
        offset,
    });

    try out_writer.writeAll(buffer.items);
}

// Top level types are any types without a parent. In order for them to be
// rendered in the `types` namespace they need a name
fn has_top_level_named_types(db: Database) bool {
    inline for (@typeInfo(@TypeOf(db.types)).Struct.fields) |field| {
        for (@field(db.types, field.name).keys()) |id| {
            if (!db.attrs.parent.contains(id) and
                db.attrs.name.contains(id))
            {
                return true;
            }
        }
    }

    return false;
}

fn write_types(db: Database, writer: anytype) !void {
    if (!has_top_level_named_types(db))
        return;

    try writer.writeAll(
        \\
        \\pub const types = struct {
        \\
    );

    if (db.types.peripherals.count() > 0) {
        try writer.writeAll("pub const peripherals = struct {\n");

        for (db.types.peripherals.keys()) |peripheral_id| {
            write_peripheral(db, peripheral_id, writer) catch |err| {
                log.warn("failed to generate peripheral '{s}': {}", .{
                    db.attrs.name.get(peripheral_id) orelse "<unknown>",
                    err,
                });
            };
        }

        try writer.writeAll("};\n");
    }

    try writer.writeAll("};\n");
}

// a peripheral is zero sized if it doesn't have any registers, and if none of
// its register groups have an offset
fn is_peripheral_zero_sized(db: Database, peripheral_id: EntityId) bool {
    if (db.children.registers.contains(peripheral_id)) {
        return false;
    } else {
        log.debug("no registers found", .{});
    }

    return if (db.children.register_groups.get(peripheral_id)) |register_group_set| blk: {
        for (register_group_set.keys()) |register_group_id| {
            if (db.attrs.offset.contains(register_group_id))
                break :blk false;
        }

        break :blk true;
    } else true;
}

fn write_peripheral(
    db: Database,
    peripheral_id: EntityId,
    out_writer: anytype,
) !void {
    assert(db.entity_is("type.peripheral", peripheral_id) or
        db.entity_is("type.register_group", peripheral_id));

    // peripheral types should always have a name (responsibility of parsing to get this done)
    const name = db.attrs.name.get(peripheral_id) orelse unreachable;

    // for now only serialize flat peripherals with no register groups
    // TODO: expand this
    if (db.children.register_groups.get(peripheral_id)) |register_group_set| {
        for (register_group_set.keys()) |register_group_id| {
            if (db.attrs.offset.contains(register_group_id)) {
                log.warn("TODO: implement register groups with offset in peripheral type ({s})", .{name});
                return;
            }
        }
    }

    var buffer = std.ArrayList(u8).init(db.arena.allocator());
    defer buffer.deinit();

    var registers = try get_ordered_register_list(db, peripheral_id);
    defer registers.deinit();

    const writer = buffer.writer();
    try writer.writeByte('\n');
    if (db.attrs.description.get(peripheral_id)) |description|
        try write_comment(db.arena.allocator(), description, writer);

    const zero_sized = is_peripheral_zero_sized(db, peripheral_id);
    const has_modes = db.children.modes.contains(peripheral_id);
    try writer.print(
        \\pub const {s} = {s} {s} {{
        \\
    , .{
        std.zig.fmtId(name),
        if (zero_sized) "" else "extern",
        if (has_modes) "union" else "struct",
    });

    var written = false;
    if (db.children.modes.get(peripheral_id)) |mode_set| {
        try write_newline_if_written(writer, &written);
        try write_mode_enum_and_fn(db, mode_set, writer);
    }

    if (db.children.enums.get(peripheral_id)) |enum_set|
        try write_enums(db, &written, enum_set, writer);

    // namespaced registers
    if (db.children.register_groups.get(peripheral_id)) |register_group_set| {
        for (register_group_set.keys()) |register_group_id| {
            // a register group with an offset means that it has a location within the peripheral
            if (db.attrs.offset.contains(register_group_id))
                continue;

            try write_newline_if_written(writer, &written);
            try write_peripheral(db, register_group_id, writer);
        }
    }

    try write_newline_if_written(writer, &written);
    try write_registers(db, peripheral_id, writer);

    try writer.writeAll("\n}");
    try writer.writeAll(";\n");

    try out_writer.writeAll(buffer.items);
}

fn write_newline_if_written(writer: anytype, written: *bool) !void {
    if (written.*)
        try writer.writeByte('\n')
    else
        written.* = true;
}

fn write_enums(db: Database, written: *bool, enum_set: EntitySet, writer: anytype) !void {
    for (enum_set.keys()) |enum_id| {
        try write_newline_if_written(writer, written);
        try write_enum(db, enum_id, writer);
    }
}

fn write_enum(db: Database, enum_id: EntityId, out_writer: anytype) !void {
    var buffer = std.ArrayList(u8).init(db.arena.allocator());
    defer buffer.deinit();

    const writer = buffer.writer();
    const name = db.attrs.name.get(enum_id) orelse return;
    const size = db.attrs.size.get(enum_id) orelse return error.MissingEnumSize;

    // TODO: handle this instead of assert
    // assert(std.math.ceilPowerOfTwo(field_set.count()) <= size);

    if (db.attrs.description.get(enum_id)) |description|
        try write_comment(db.arena.allocator(), description, writer);

    try writer.print("pub const {s} = enum(u{}) {{\n", .{
        std.zig.fmtId(name),
        size,
    });
    try write_enum_fields(db, enum_id, writer);
    try writer.writeAll("};\n");

    try out_writer.writeAll(buffer.items);
}

fn write_enum_fields(db: Database, enum_id: u32, out_writer: anytype) !void {
    var buffer = std.ArrayList(u8).init(db.arena.allocator());
    defer buffer.deinit();

    const writer = buffer.writer();
    const size = db.attrs.size.get(enum_id) orelse return error.MissingEnumSize;
    const field_set = db.children.enum_fields.get(enum_id) orelse return error.MissingEnumFields;
    for (field_set.keys()) |enum_field_id|
        try write_enum_field(db, enum_field_id, size, writer);

    // if the enum doesn't completely fill the integer then make it a non-exhaustive enum
    if (field_set.count() < std.math.pow(u64, 2, size))
        try writer.writeAll("_,\n");

    try out_writer.writeAll(buffer.items);
}

fn write_enum_field(
    db: Database,
    enum_field_id: EntityId,
    size: u64,
    writer: anytype,
) !void {
    const name = db.attrs.name.get(enum_field_id) orelse return error.MissingEnumFieldName;
    const value = db.types.enum_fields.get(enum_field_id) orelse return error.MissingEnumFieldValue;

    // TODO: use size to print the hex value (pad with zeroes accordingly)
    _ = size;
    if (db.attrs.description.get(enum_field_id)) |description|
        try write_comment(db.arena.allocator(), description, writer);

    try writer.print("{s} = 0x{x},\n", .{ std.zig.fmtId(name), value });
}

fn write_mode_enum_and_fn(
    db: Database,
    mode_set: EntitySet,
    out_writer: anytype,
) !void {
    var buffer = std.ArrayList(u8).init(db.arena.allocator());
    defer buffer.deinit();

    const writer = buffer.writer();
    try writer.writeAll("pub const Mode = enum {\n");

    for (mode_set.keys()) |mode_id| {
        const mode_name = db.attrs.name.get(mode_id) orelse unreachable;
        try writer.print("{s},\n", .{std.zig.fmtId(mode_name)});
    }

    try writer.writeAll(
        \\};
        \\
        \\pub fn get_mode(self: *volatile @This()) Mode {
        \\
    );

    for (mode_set.keys()) |mode_id| {
        const mode_name = db.attrs.name.get(mode_id) orelse unreachable;

        var components = std.ArrayList([]const u8).init(db.gpa);
        defer components.deinit();

        const mode = db.types.modes.get(mode_id).?;
        var tok_it = std.mem.tokenize(u8, mode.qualifier, ".");
        while (tok_it.next()) |token|
            try components.append(token);

        const field_name = components.items[components.items.len - 1];
        _ = try db.get_entity_id_by_name("type.field", field_name);

        const access_path = try std.mem.join(db.arena.allocator(), ".", components.items[1 .. components.items.len - 1]);
        try writer.writeAll("{\n");
        try writer.print("const value = self.{s}.read().{s};\n", .{
            access_path,
            field_name,
        });
        try writer.writeAll("switch (value) {\n");

        tok_it = std.mem.tokenize(u8, mode.value, " ");
        while (tok_it.next()) |token| {
            const value = try std.fmt.parseInt(u64, token, 0);
            try writer.print("{},\n", .{value});
        }
        try writer.print("=> return .{s},\n", .{std.zig.fmtId(mode_name)});
        try writer.writeAll("else => {},\n");
        try writer.writeAll("}\n");
        try writer.writeAll("}\n");
    }

    try writer.writeAll("\nunreachable;\n");
    try writer.writeAll("}\n");

    try out_writer.writeAll(buffer.items);
}

fn write_registers(db: Database, parent_id: EntityId, out_writer: anytype) !void {
    var registers = try get_ordered_register_list(db, parent_id);
    defer registers.deinit();

    if (db.children.modes.get(parent_id)) |modes|
        try write_registers_with_modes(db, parent_id, modes, registers, out_writer)
    else
        try write_registers_base(db, parent_id, registers.items, out_writer);
}

fn write_registers_with_modes(
    db: Database,
    parent_id: EntityId,
    mode_set: EntitySet,
    registers: std.ArrayList(EntityWithOffset),
    out_writer: anytype,
) !void {
    const allocator = db.arena.allocator();
    var buffer = std.ArrayList(u8).init(db.arena.allocator());
    defer buffer.deinit();

    const writer = buffer.writer();
    for (mode_set.keys()) |mode_id| {
        const mode_name = db.attrs.name.get(mode_id) orelse unreachable;

        // filter registers for this mode
        var moded_registers = std.ArrayList(EntityWithOffset).init(allocator);
        for (registers.items) |register| {
            if (db.attrs.modes.get(register.id)) |reg_mode_set| {
                for (reg_mode_set.keys()) |reg_mode_id| {
                    if (reg_mode_id == mode_id)
                        try moded_registers.append(register);
                }
                // if no mode is specified, then it should always be present
            } else try moded_registers.append(register);
        }

        try writer.print("{s}: extern struct {{\n", .{
            std.zig.fmtId(mode_name),
        });

        try write_registers_base(db, parent_id, moded_registers.items, writer);
        try writer.writeAll("},\n");
    }

    try out_writer.writeAll(buffer.items);
}

fn write_registers_base(
    db: Database,
    parent_id: EntityId,
    registers: []const EntityWithOffset,
    out_writer: anytype,
) !void {
    // registers _should_ be sorted when then make their way here
    assert(std.sort.isSorted(EntityWithOffset, registers, {}, EntityWithOffset.less_than));
    var buffer = std.ArrayList(u8).init(db.arena.allocator());
    defer buffer.deinit();

    const writer = buffer.writer();

    // don't have to care about modes
    // prioritize smaller fields that come earlier
    var offset: u64 = 0;
    var i: u32 = 0;

    while (i < registers.len) {
        if (offset < registers[i].offset) {
            try writer.print("reserved{}: [{}]u8,\n", .{ registers[i].offset, registers[i].offset - offset });
            offset = registers[i].offset;
        } else if (offset > registers[i].offset) {
            if (db.attrs.name.get(registers[i].id)) |name|
                log.warn("skipping register: {s}", .{name});

            i += 1;
            continue;
        }

        var end = i;
        while (end < registers.len and registers[end].offset == offset) : (end += 1) {}
        const next = blk: {
            var ret: ?EntityWithOffsetAndSize = null;
            for (registers[i..end]) |register| {
                const size = if (db.attrs.size.get(register.id)) |size|
                    if (db.attrs.count.get(register.id)) |count|
                        size * count
                    else
                        size
                else
                    unreachable;

                if (ret == null or (size < ret.?.size))
                    ret = .{
                        .id = register.id,
                        .offset = register.offset,
                        .size = size,
                    };
            }

            break :blk ret orelse unreachable;
        };

        try write_register(db, next.id, writer);
        // TODO: round up to next power of two
        assert(next.size % 8 == 0);
        offset += next.size / 8;
        i = end;
    }

    // TODO: name collision
    if (db.attrs.size.get(parent_id)) |size| {
        if (offset > size)
            @panic("peripheral size too small, parsing should have caught this");

        if (offset != size)
            try writer.print("padding: [{}]u8,\n", .{
                size - offset,
            });
    }

    try out_writer.writeAll(buffer.items);
}

fn write_register(
    db: Database,
    register_id: EntityId,
    out_writer: anytype,
) !void {
    var buffer = std.ArrayList(u8).init(db.arena.allocator());
    defer buffer.deinit();

    const name = db.attrs.name.get(register_id) orelse unreachable;
    const size = db.attrs.size.get(register_id) orelse unreachable;

    const writer = buffer.writer();
    if (db.attrs.description.get(register_id)) |description|
        try write_comment(db.arena.allocator(), description, writer);

    var array_prefix_buf: [80]u8 = undefined;
    const array_prefix = if (db.attrs.count.get(register_id)) |count|
        try std.fmt.bufPrint(&array_prefix_buf, "[{}]", .{count})
    else
        "";

    if (db.children.fields.get(register_id)) |field_set| {
        var fields = std.ArrayList(EntityWithOffset).init(db.gpa);
        defer fields.deinit();

        for (field_set.keys()) |field_id|
            try fields.append(.{
                .id = field_id,
                .offset = db.attrs.offset.get(field_id) orelse continue,
            });

        std.sort.insertion(EntityWithOffset, fields.items, {}, EntityWithOffset.less_than);
        try writer.print("{s}: {s}mmio.Mmio(packed struct(u{}) {{\n", .{
            std.zig.fmtId(name),
            array_prefix,
            size,
        });

        try write_fields(db, fields.items, size, writer);
        try writer.writeAll("}),\n");
    } else try writer.print("{s}: {s}u{},\n", .{
        std.zig.fmtId(name),
        array_prefix,
        size,
    });

    try out_writer.writeAll(buffer.items);
}

fn write_fields(
    db: Database,
    fields: []const EntityWithOffset,
    register_size: u64,
    out_writer: anytype,
) !void {
    assert(std.sort.isSorted(EntityWithOffset, fields, {}, EntityWithOffset.less_than));
    var buffer = std.ArrayList(u8).init(db.arena.allocator());
    defer buffer.deinit();

    // don't have to care about modes
    // prioritize smaller fields that come earlier
    const writer = buffer.writer();
    var offset: u64 = 0;
    var i: u32 = 0;
    while (i < fields.len and offset < register_size) {
        if (offset < fields[i].offset) {
            try writer.print("reserved{}: u{},\n", .{ fields[i].offset, fields[i].offset - offset });
            offset = fields[i].offset;
        } else if (offset > fields[i].offset) {
            if (db.attrs.name.get(fields[i].id)) |name|
                log.warn("skipping field: {s}, offset={}, field_offset={}", .{
                    name,
                    offset,
                    fields[i].offset,
                });

            i += 1;
            continue;
        }

        var end = i;
        while (end < fields.len and fields[end].offset == offset) : (end += 1) {}
        const next = blk: {
            var ret: ?EntityWithOffsetAndSize = null;
            for (fields[i..end]) |field| {
                const size = if (db.attrs.size.get(field.id)) |size|
                    if (db.attrs.count.get(field.id)) |count|
                        size * count
                    else
                        size
                else
                    unreachable;

                if (ret == null or (size < ret.?.size))
                    ret = .{
                        .id = field.id,
                        .offset = field.offset,
                        .size = size,
                    };
            }

            break :blk ret orelse unreachable;
        };

        const name = db.attrs.name.get(next.id) orelse unreachable;
        if (offset + next.size > register_size) {
            log.warn("register '{s}' is outside register boundaries: offset={}, size={}, register_size={}", .{
                name,
                next.offset,
                next.size,
                register_size,
            });
            break;
        }

        if (db.attrs.description.get(next.id)) |description|
            try write_comment(db.arena.allocator(), description, writer);

        if (db.attrs.count.get(fields[i].id)) |count| {
            if (db.attrs.@"enum".contains(fields[i].id))
                log.warn("TODO: field array with enums", .{});

            try writer.print("{s}: packed struct(u{}) {{ ", .{
                std.zig.fmtId(name),
                next.size,
            });

            var j: u32 = 0;
            while (j < count) : (j += 1) {
                if (j > 0)
                    try writer.writeAll(", ");

                try writer.print("u{}", .{next.size / count});
            }

            try writer.writeAll(" },\n");
        } else if (db.attrs.@"enum".get(fields[i].id)) |enum_id| {
            if (db.attrs.name.get(enum_id)) |enum_name| {
                try writer.print(
                    \\{s}: packed union {{
                    \\    raw: u{},
                    \\    value: {s},
                    \\}},
                    \\
                , .{
                    std.zig.fmtId(name),
                    next.size,
                    std.zig.fmtId(enum_name),
                });
            } else {
                try writer.print(
                    \\{s}: packed union {{
                    \\    raw: u{},
                    \\    value: enum(u{}) {{
                    \\
                , .{
                    std.zig.fmtId(name),
                    next.size,
                    next.size,
                });
                try write_enum_fields(db, enum_id, writer);
                try writer.writeAll("},\n},\n");
            }
        } else {
            try writer.print("{s}: u{},\n", .{ name, next.size });
        }

        offset += next.size;
        i = end;
    }

    assert(offset <= register_size);
    if (offset < register_size)
        try writer.print("padding: u{},\n", .{register_size - offset});

    try out_writer.writeAll(buffer.items);
}

fn get_ordered_register_list(
    db: Database,
    parent_id: EntityId,
) !std.ArrayList(EntityWithOffset) {
    var registers = std.ArrayList(EntityWithOffset).init(db.gpa);
    errdefer registers.deinit();

    // get list of registers
    if (db.children.registers.get(parent_id)) |register_set| {
        for (register_set.keys()) |register_id| {
            const offset = db.attrs.offset.get(register_id) orelse continue;
            try registers.append(.{ .id = register_id, .offset = offset });
        }
    }

    std.sort.insertion(EntityWithOffset, registers.items, {}, EntityWithOffset.less_than);
    return registers;
}

const tests = @import("output_tests.zig");

test "gen.peripheral type with register and field" {
    var db = try tests.peripheral_type_with_register_and_field(std.testing.allocator);
    defer db.deinit();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer());
    try std.testing.expectEqualStrings(
        \\const micro = @import("microzig");
        \\const mmio = micro.mmio;
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const TEST_PERIPHERAL = extern struct {
        \\            TEST_REGISTER: mmio.Mmio(packed struct(u32) {
        \\                TEST_FIELD: u1,
        \\                padding: u31,
        \\            }),
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.peripheral instantiation" {
    var db = try tests.peripheral_instantiation(std.testing.allocator);
    defer db.deinit();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer());
    try std.testing.expectEqualStrings(
        \\const micro = @import("microzig");
        \\const mmio = micro.mmio;
        \\
        \\pub const devices = struct {
        \\    pub const TEST_DEVICE = struct {
        \\        pub const peripherals = struct {
        \\            pub const TEST0 = @intToPtr(*volatile types.peripherals.TEST_PERIPHERAL, 0x1000);
        \\        };
        \\    };
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const TEST_PERIPHERAL = extern struct {
        \\            TEST_REGISTER: mmio.Mmio(packed struct(u32) {
        \\                TEST_FIELD: u1,
        \\                padding: u31,
        \\            }),
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.peripherals with a shared type" {
    var db = try tests.peripherals_with_shared_type(std.testing.allocator);
    defer db.deinit();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer());
    try std.testing.expectEqualStrings(
        \\const micro = @import("microzig");
        \\const mmio = micro.mmio;
        \\
        \\pub const devices = struct {
        \\    pub const TEST_DEVICE = struct {
        \\        pub const peripherals = struct {
        \\            pub const TEST0 = @intToPtr(*volatile types.peripherals.TEST_PERIPHERAL, 0x1000);
        \\            pub const TEST1 = @intToPtr(*volatile types.peripherals.TEST_PERIPHERAL, 0x2000);
        \\        };
        \\    };
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const TEST_PERIPHERAL = extern struct {
        \\            TEST_REGISTER: mmio.Mmio(packed struct(u32) {
        \\                TEST_FIELD: u1,
        \\                padding: u31,
        \\            }),
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.peripheral with modes" {
    var db = try tests.peripheral_with_modes(std.testing.allocator);
    defer db.deinit();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer());
    try std.testing.expectEqualStrings(
        \\const micro = @import("microzig");
        \\const mmio = micro.mmio;
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const TEST_PERIPHERAL = extern union {
        \\            pub const Mode = enum {
        \\                TEST_MODE1,
        \\                TEST_MODE2,
        \\            };
        \\
        \\            pub fn get_mode(self: *volatile @This()) Mode {
        \\                {
        \\                    const value = self.TEST_MODE1.COMMON_REGISTER.read().TEST_FIELD;
        \\                    switch (value) {
        \\                        0 => return .TEST_MODE1,
        \\                        else => {},
        \\                    }
        \\                }
        \\                {
        \\                    const value = self.TEST_MODE2.COMMON_REGISTER.read().TEST_FIELD;
        \\                    switch (value) {
        \\                        1 => return .TEST_MODE2,
        \\                        else => {},
        \\                    }
        \\                }
        \\
        \\                unreachable;
        \\            }
        \\
        \\            TEST_MODE1: extern struct {
        \\                TEST_REGISTER1: u32,
        \\                COMMON_REGISTER: mmio.Mmio(packed struct(u32) {
        \\                    TEST_FIELD: u1,
        \\                    padding: u31,
        \\                }),
        \\            },
        \\            TEST_MODE2: extern struct {
        \\                TEST_REGISTER2: u32,
        \\                COMMON_REGISTER: mmio.Mmio(packed struct(u32) {
        \\                    TEST_FIELD: u1,
        \\                    padding: u31,
        \\                }),
        \\            },
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.peripheral with enum" {
    var db = try tests.peripheral_with_enum(std.testing.allocator);
    defer db.deinit();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer());
    try std.testing.expectEqualStrings(
        \\const micro = @import("microzig");
        \\const mmio = micro.mmio;
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const TEST_PERIPHERAL = extern struct {
        \\            pub const TEST_ENUM = enum(u4) {
        \\                TEST_ENUM_FIELD1 = 0x0,
        \\                TEST_ENUM_FIELD2 = 0x1,
        \\                _,
        \\            };
        \\
        \\            TEST_REGISTER: u8,
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.peripheral with enum, enum is exhausted of values" {
    var db = try tests.peripheral_with_enum_and_its_exhausted_of_values(std.testing.allocator);
    defer db.deinit();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer());
    try std.testing.expectEqualStrings(
        \\const micro = @import("microzig");
        \\const mmio = micro.mmio;
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const TEST_PERIPHERAL = extern struct {
        \\            pub const TEST_ENUM = enum(u1) {
        \\                TEST_ENUM_FIELD1 = 0x0,
        \\                TEST_ENUM_FIELD2 = 0x1,
        \\            };
        \\
        \\            TEST_REGISTER: u8,
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.field with named enum" {
    var db = try tests.field_with_named_enum(std.testing.allocator);
    defer db.deinit();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer());
    try std.testing.expectEqualStrings(
        \\const micro = @import("microzig");
        \\const mmio = micro.mmio;
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const TEST_PERIPHERAL = extern struct {
        \\            pub const TEST_ENUM = enum(u4) {
        \\                TEST_ENUM_FIELD1 = 0x0,
        \\                TEST_ENUM_FIELD2 = 0x1,
        \\                _,
        \\            };
        \\
        \\            TEST_REGISTER: mmio.Mmio(packed struct(u8) {
        \\                TEST_FIELD: packed union {
        \\                    raw: u4,
        \\                    value: TEST_ENUM,
        \\                },
        \\                padding: u4,
        \\            }),
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.field with anonymous enum" {
    var db = try tests.field_with_anonymous_enum(std.testing.allocator);
    defer db.deinit();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer());
    try std.testing.expectEqualStrings(
        \\const micro = @import("microzig");
        \\const mmio = micro.mmio;
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const TEST_PERIPHERAL = extern struct {
        \\            TEST_REGISTER: mmio.Mmio(packed struct(u8) {
        \\                TEST_FIELD: packed union {
        \\                    raw: u4,
        \\                    value: enum(u4) {
        \\                        TEST_ENUM_FIELD1 = 0x0,
        \\                        TEST_ENUM_FIELD2 = 0x1,
        \\                        _,
        \\                    },
        \\                },
        \\                padding: u4,
        \\            }),
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.namespaced register groups" {
    var db = try tests.namespaced_register_groups(std.testing.allocator);
    defer db.deinit();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer());
    try std.testing.expectEqualStrings(
        \\const micro = @import("microzig");
        \\const mmio = micro.mmio;
        \\
        \\pub const devices = struct {
        \\    pub const ATmega328P = struct {
        \\        pub const peripherals = struct {
        \\            pub const PORTB = @intToPtr(*volatile types.peripherals.PORT.PORTB, 0x23);
        \\            pub const PORTC = @intToPtr(*volatile types.peripherals.PORT.PORTC, 0x26);
        \\        };
        \\    };
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const PORT = struct {
        \\            pub const PORTB = extern struct {
        \\                PORTB: u8,
        \\                DDRB: u8,
        \\                PINB: u8,
        \\            };
        \\
        \\            pub const PORTC = extern struct {
        \\                PORTC: u8,
        \\                DDRC: u8,
        \\                PINC: u8,
        \\            };
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.peripheral with reserved register" {
    var db = try tests.peripheral_with_reserved_register(std.testing.allocator);
    defer db.deinit();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer());
    try std.testing.expectEqualStrings(
        \\const micro = @import("microzig");
        \\const mmio = micro.mmio;
        \\
        \\pub const devices = struct {
        \\    pub const ATmega328P = struct {
        \\        pub const peripherals = struct {
        \\            pub const PORTB = @intToPtr(*volatile types.peripherals.PORTB, 0x23);
        \\        };
        \\    };
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const PORTB = extern struct {
        \\            PORTB: u32,
        \\            reserved8: [4]u8,
        \\            PINB: u32,
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.peripheral with count" {
    var db = try tests.peripheral_with_count(std.testing.allocator);
    defer db.deinit();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer());
    try std.testing.expectEqualStrings(
        \\const micro = @import("microzig");
        \\const mmio = micro.mmio;
        \\
        \\pub const devices = struct {
        \\    pub const ATmega328P = struct {
        \\        pub const peripherals = struct {
        \\            pub const PORTB = @intToPtr(*volatile [4]types.peripherals.PORTB, 0x23);
        \\        };
        \\    };
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const PORTB = extern struct {
        \\            PORTB: u8,
        \\            DDRB: u8,
        \\            PINB: u8,
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.peripheral with count, padding required" {
    var db = try tests.peripheral_with_count_padding_required(std.testing.allocator);
    defer db.deinit();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer());
    try std.testing.expectEqualStrings(
        \\const micro = @import("microzig");
        \\const mmio = micro.mmio;
        \\
        \\pub const devices = struct {
        \\    pub const ATmega328P = struct {
        \\        pub const peripherals = struct {
        \\            pub const PORTB = @intToPtr(*volatile [4]types.peripherals.PORTB, 0x23);
        \\        };
        \\    };
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const PORTB = extern struct {
        \\            PORTB: u8,
        \\            DDRB: u8,
        \\            PINB: u8,
        \\            padding: [1]u8,
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.register with count" {
    var db = try tests.register_with_count(std.testing.allocator);
    defer db.deinit();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer());
    try std.testing.expectEqualStrings(
        \\const micro = @import("microzig");
        \\const mmio = micro.mmio;
        \\
        \\pub const devices = struct {
        \\    pub const ATmega328P = struct {
        \\        pub const peripherals = struct {
        \\            pub const PORTB = @intToPtr(*volatile types.peripherals.PORTB, 0x23);
        \\        };
        \\    };
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const PORTB = extern struct {
        \\            PORTB: [4]u8,
        \\            DDRB: u8,
        \\            PINB: u8,
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.register with count and fields" {
    var db = try tests.register_with_count_and_fields(std.testing.allocator);
    defer db.deinit();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer());
    try std.testing.expectEqualStrings(
        \\const micro = @import("microzig");
        \\const mmio = micro.mmio;
        \\
        \\pub const devices = struct {
        \\    pub const ATmega328P = struct {
        \\        pub const peripherals = struct {
        \\            pub const PORTB = @intToPtr(*volatile types.peripherals.PORTB, 0x23);
        \\        };
        \\    };
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const PORTB = extern struct {
        \\            PORTB: [4]mmio.Mmio(packed struct(u8) {
        \\                TEST_FIELD: u4,
        \\                padding: u4,
        \\            }),
        \\            DDRB: u8,
        \\            PINB: u8,
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.field with count, width of one, offset, and padding" {
    var db = try tests.field_with_count_width_of_one_offset_and_padding(std.testing.allocator);
    defer db.deinit();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer());
    try std.testing.expectEqualStrings(
        \\const micro = @import("microzig");
        \\const mmio = micro.mmio;
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const PORTB = extern struct {
        \\            PORTB: mmio.Mmio(packed struct(u8) {
        \\                reserved2: u2,
        \\                TEST_FIELD: packed struct(u5) { u1, u1, u1, u1, u1 },
        \\                padding: u1,
        \\            }),
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.field with count, multi-bit width, offset, and padding" {
    var db = try tests.field_with_count_multi_bit_width_offset_and_padding(std.testing.allocator);
    defer db.deinit();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer());
    try std.testing.expectEqualStrings(
        \\const micro = @import("microzig");
        \\const mmio = micro.mmio;
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const PORTB = extern struct {
        \\            PORTB: mmio.Mmio(packed struct(u8) {
        \\                reserved2: u2,
        \\                TEST_FIELD: packed struct(u4) { u2, u2 },
        \\                padding: u2,
        \\            }),
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.interrupts.avr" {
    var db = try tests.interrupts_avr(std.testing.allocator);
    defer db.deinit();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer());
    try std.testing.expectEqualStrings(
        \\const micro = @import("microzig");
        \\const mmio = micro.mmio;
        \\
        \\pub const devices = struct {
        \\    pub const ATmega328P = struct {
        \\        pub const VectorTable = extern struct {
        \\            const Handler = micro.interrupt.Handler;
        \\            const unhandled = micro.interrupt.unhandled;
        \\
        \\            RESET: Handler = unhandled,
        \\            TEST_VECTOR1: Handler = unhandled,
        \\            reserved2: [1]u16 = undefined,
        \\            TEST_VECTOR2: Handler = unhandled,
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}
