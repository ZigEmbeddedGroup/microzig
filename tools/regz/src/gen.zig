const std = @import("std");
const Allocator = std.mem.Allocator;
const assert = std.debug.assert;

const Database = @import("Database.zig");
const Register = Database.Register;
const Device = Database.Device;
const Enum = Database.Enum;
const EnumField = Database.EnumField;
const Peripheral = Database.Peripheral;
const Mode = Database.Mode;
const DevicePeripheral = Database.DevicePeripheral;
const EnumID = Database.EnumID;
const StructID = Database.StructID;

const arm = @import("arch/arm.zig");
const avr = @import("arch/avr.zig");
const riscv = @import("arch/riscv.zig");

const log = std.log.scoped(.gen);

pub const ToZigOptions = struct {
    for_microzig: bool = false,
};

pub fn to_zig(db: *Database, out_writer: anytype, opts: ToZigOptions) !void {
    var arena = std.heap.ArenaAllocator.init(db.gpa);
    defer arena.deinit();

    const allocator = arena.allocator();

    var buffer = std.ArrayList(u8).init(allocator);
    defer buffer.deinit();

    const writer = buffer.writer();
    if (opts.for_microzig) {
        try writer.writeAll(
            \\const microzig = @import("microzig");
            \\const mmio = microzig.mmio;
            \\
        );
    } else {
        try writer.writeAll(
            \\const mmio = @import("mmio");
            \\
        );
    }

    try writer.writeAll(
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
    );

    try write_devices(db, allocator, writer);
    try write_types(db, allocator, writer);
    try writer.writeByte(0);

    // format the generated code
    var ast = try std.zig.Ast.parse(allocator, buffer.items[0 .. buffer.items.len - 1 :0], .zig);
    defer ast.deinit(allocator);

    if (ast.errors.len > 0) {
        log.err("Failed to parse:\n{s}", .{buffer.items});
        try out_writer.writeAll(buffer.items);
        for (ast.errors) |err| {
            std.log.err("err: {}", .{err});
            var err_msg = std.ArrayList(u8).init(allocator);
            defer err_msg.deinit();

            try ast.renderError(err, err_msg.writer());
            std.log.err("  {s}", .{err_msg.items});
        }
        return error.FailedToParse;
    }

    const text = try ast.render(allocator);
    defer allocator.free(text);

    try out_writer.writeAll(text);
}

fn write_devices(db: *Database, arena: Allocator, writer: anytype) !void {
    const devices = try db.get_devices(arena);
    if (devices.len == 0)
        return;

    try writer.writeAll(
        \\
        \\pub const devices = struct {
        \\
    );

    // TODO: order devices alphabetically
    for (devices) |device| {
        write_device(db, arena, &device, writer) catch |err| {
            log.warn("failed to write device: {}", .{err});
        };
    }

    try writer.writeAll("};\n");
}

pub fn write_doc_comment(allocator: Allocator, comment: []const u8, writer: anytype) !void {
    try write_comment(allocator, "///", comment, writer);
}

pub fn write_regular_comment(allocator: Allocator, comment: []const u8, writer: anytype) !void {
    try write_comment(allocator, "//", comment, writer);
}

fn write_comment(allocator: Allocator, comptime comment_prefix: []const u8, comment: []const u8, writer: anytype) !void {
    var tokenized = std.ArrayList(u8).init(allocator);
    defer tokenized.deinit();

    var first = true;
    var tok_it = std.mem.tokenizeAny(u8, comment, "\n\r \t");
    while (tok_it.next()) |token| {
        if (!first)
            first = false
        else
            try tokenized.writer().writeByte(' ');

        try tokenized.writer().writeAll(token);
    }

    const unescaped = try std.mem.replaceOwned(u8, allocator, tokenized.items, "\\n", "\n");
    defer allocator.free(unescaped);

    var line_it = std.mem.tokenizeScalar(u8, unescaped, '\n');
    while (line_it.next()) |line|
        try writer.print("{s}{s}\n", .{ comment_prefix, line });
}

fn write_string(str: []const u8, writer: anytype) !void {
    if (std.mem.containsAtLeast(u8, str, 1, "\n")) {
        try writer.writeByte('\n');
        var line_it = std.mem.splitScalar(u8, str, '\n');
        while (line_it.next()) |line|
            try writer.print("\\\\{s}\n", .{line});
    } else {
        try writer.print("\"{s}\"", .{str});
    }
}

fn write_device(db: *Database, arena: Allocator, device: *const Database.Device, out_writer: anytype) !void {
    var buffer = std.ArrayList(u8).init(arena);
    defer buffer.deinit();

    const writer = buffer.writer();
    if (device.description) |description| {
        try write_doc_comment(arena, description, writer);
    }

    try writer.print(
        \\pub const {} = struct {{
        \\
    , .{std.zig.fmtId(device.name)});

    const properties = try db.get_device_properties(arena, device.id);
    if (properties.len > 0) {
        try writer.writeAll("pub const properties = struct {\n");
        for (properties) |prop| {
            try writer.print("pub const {} = ", .{
                std.zig.fmtId(prop.key),
            });

            try write_string(prop.value orelse "", writer);
            try writer.writeAll(";\n");
        }

        try writer.writeAll("};\n");
    }

    write_interrupt_list(db, arena, device, writer) catch |err|
        log.warn("failed to write interrupt list: {}", .{err});

    write_vector_table(db, arena, device, writer) catch |err|
        log.warn("failed to write vector table: {}", .{err});

    const device_peripherals = try db.get_device_peripherals(arena, device.id);
    log.debug("peripheral instances: {}", .{device_peripherals.len});
    if (device_peripherals.len > 0) {
        try writer.writeAll("pub const peripherals = struct {\n");
        for (device_peripherals) |instance| {
            write_device_peripheral(db, arena, &instance, writer) catch |err| {
                log.warn("failed to serialize peripheral instance: {}", .{err});
            };
        }
        try writer.writeAll("};\n");
    }

    try writer.writeAll("};\n");

    try out_writer.writeAll(buffer.items);
}

const TypeID = union(enum) {
    @"enum": EnumID,
    @"struct": StructID,
};

// generates a string for a type in the `types` namespace of the generated
// code. Since this is only used in code generation, just going to stuff it in
// the arena allocator
fn types_reference(db: *Database, allocator: Allocator, type_id: TypeID) ![]const u8 {
    var full_name_components = std.ArrayList([]const u8).init(allocator);
    defer full_name_components.deinit();

    var current_id = type_id;

    // hard limit for walking up the tree, there's probably a bug if we hit
    // this;
    const depth_max: u32 = 8;
    var depth: u32 = 0;
    while (depth < depth_max) : (depth += 1) {
        log.debug("current_id={}", .{current_id});
        switch (current_id) {
            .@"enum" => |id| {
                const e = try db.get_enum(allocator, id);
                defer e.deinit(allocator);

                if (e.struct_id) |struct_id|
                    current_id = .{ .@"struct" = struct_id }
                else
                    return error.MissingParent;

                const name_copy = try allocator.dupe(u8, e.name.?);
                errdefer allocator.free(name_copy);

                try full_name_components.insert(0, name_copy);
            },
            .@"struct" => |id| if (try db.get_struct_decl(allocator, id)) |struct_decl| {
                defer struct_decl.deinit(allocator);

                log.debug("got struct_decl: {}", .{struct_decl});
                const name_copy = try allocator.dupe(u8, struct_decl.name);
                errdefer allocator.free(name_copy);

                try full_name_components.insert(0, name_copy);
                current_id = .{ .@"struct" = struct_decl.parent_id };
            } else if (try db.get_peripheral_by_struct_id(allocator, id)) |peripheral| {
                defer peripheral.deinit(allocator);

                const name_copy = try allocator.dupe(u8, peripheral.name);
                errdefer allocator.free(name_copy);

                try full_name_components.insert(0, name_copy);
                break;
            } else @panic("A struct should have some sort of decl entry"),
        }
    } else @panic("Hit limit for reference length");

    if (full_name_components.items.len == 0)
        return error.CantReference;

    var full_name = std.ArrayList(u8).init(allocator);
    defer full_name.deinit();

    const writer = full_name.writer();
    try writer.writeAll("types.peripherals");

    for (full_name_components.items) |component|
        try writer.print(".{}", .{
            std.zig.fmtId(component),
        });

    log.debug("generated type ref: {s}", .{full_name.items});
    return full_name.toOwnedSlice();
}

fn write_interrupt_list(
    db: *Database,
    arena: Allocator,
    device: *const Device,
    out_writer: anytype,
) !void {
    var buffer = std.ArrayList(u8).init(arena);
    defer buffer.deinit();

    const writer = buffer.writer();

    const interrupts = try db.get_interrupts(arena, device.id);
    defer {
        for (interrupts) |interrupt| interrupt.deinit(arena);
        arena.free(interrupts);
    }

    if (interrupts.len > 0) {
        // HACK: Temporary solution and very very hacky way to ensure that interrupt names and indices
        // are unique. A proper solution should reside in the database.

        const NameSet = std.StringHashMapUnmanaged(void);
        var name_set: NameSet = .{};
        defer name_set.deinit(arena);

        const IdxSet = std.AutoHashMapUnmanaged(i32, void);
        var idx_set: IdxSet = .{};
        defer idx_set.deinit(arena);

        try writer.writeAll(
            \\
            \\pub const interrupts: []const Interrupt = &.{
            \\
        );

        for (interrupts) |interrupt| {
            {
                const gop = try name_set.getOrPut(arena, interrupt.name);
                if (gop.found_existing) {
                    log.debug("skipping interrupt: {s}", .{interrupt.name});
                    continue;
                }
            }

            {
                const gop = try idx_set.getOrPut(arena, interrupt.idx);
                if (gop.found_existing) {
                    log.debug("skipping interrupt: {s}", .{interrupt.name});
                    continue;
                }
            }

            try writer.writeAll(".{ .name = ");
            try write_string(interrupt.name, writer);
            try writer.print(", .index = {}, .description = ", .{interrupt.idx});
            if (interrupt.description) |description| {
                try write_string(description, writer);
            } else {
                try writer.writeAll("null");
            }
            try writer.writeAll(" },\n");
        }

        try writer.writeAll("};\n");
    }

    try out_writer.writeAll(buffer.items);
}

fn write_vector_table(
    db: *Database,
    arena: Allocator,
    device: *const Device,
    out_writer: anytype,
) !void {
    var buffer = std.ArrayList(u8).init(arena);
    defer buffer.deinit();

    const writer = buffer.writer();

    if (device.arch.is_arm())
        try arm.write_interrupt_vector(db, arena, device, writer)
    else if (device.arch.is_avr())
        try avr.write_interrupt_vector(db, arena, device, writer)
    else if (device.arch.is_riscv())
        try riscv.write_interrupt_vector(db, arena, device, writer)
    else if (device.arch == .unknown)
        return
    else
        unreachable;

    try out_writer.writeAll(buffer.items);
}

fn get_device_peripheral_description(
    db: *Database,
    arena: Allocator,
    instance: *const DevicePeripheral,
) !?[]const u8 {
    return if (instance.description) |description|
        description
    else if (try db.get_peripheral_by_struct_id(arena, instance.struct_id)) |peripheral|
        peripheral.description
    else if (try db.get_struct_decl_by_struct_id(arena, instance.struct_id)) |struct_decl|
        struct_decl.description
    else
        null;
}

fn write_device_peripheral(
    db: *Database,
    arena: Allocator,
    instance: *const DevicePeripheral,
    out_writer: anytype,
) !void {
    log.debug("writing periph instance", .{});
    var buffer = std.ArrayList(u8).init(arena);
    defer buffer.deinit();

    const writer = buffer.writer();
    const type_ref = try types_reference(db, arena, .{ .@"struct" = instance.struct_id });

    if (try get_device_peripheral_description(db, arena, instance)) |description|
        try write_doc_comment(arena, description, writer);

    // TODO: get description
    //else if (s.description) |desc|
    //    try write_doc_comment(arena, desc, writer);

    var array_prefix_buf: [80]u8 = undefined;
    const array_prefix = if (instance.count) |count|
        try std.fmt.bufPrint(&array_prefix_buf, "[{}]", .{count})
    else
        "";

    try writer.print("pub const {}: *volatile {s}{s} = @ptrFromInt(0x{x});\n", .{
        std.zig.fmtId(instance.name),
        array_prefix,
        type_ref,
        instance.offset_bytes,
    });

    try out_writer.writeAll(buffer.items);
}

fn write_types(db: *Database, arena: Allocator, writer: anytype) !void {
    const peripherals = try db.get_peripherals(arena);
    if (peripherals.len == 0)
        return;

    try writer.writeAll(
        \\
        \\pub const types = struct {
        \\
    );

    try writer.writeAll("pub const peripherals = struct {\n");

    for (peripherals) |peripheral| {
        write_peripheral(db, arena, &peripheral, writer) catch |err| {
            log.warn("failed to generate peripheral '{s}': {}", .{
                peripheral.name,
                err,
            });
        };
    }

    try writer.writeAll("};\n");

    try writer.writeAll("};\n");
}

fn write_struct_decl(
    db: *Database,
    arena: Allocator,
    name: []const u8,
    description: ?[]const u8,
    block_size_bytes: ?u64,
    struct_id: StructID,
    out_writer: anytype,
) !void {
    log.debug("writing struct decl: name='{s}'", .{name});
    var buffer = std.ArrayList(u8).init(arena);
    defer buffer.deinit();

    const registers = try db.get_struct_registers(arena, struct_id);
    const modes = try db.get_struct_modes(arena, struct_id);

    const writer = buffer.writer();
    try writer.writeByte('\n');
    if (description) |d|
        try write_doc_comment(arena, d, writer);

    const zero_sized = registers.len == 0;
    const has_modes = modes.len > 0;
    try writer.print(
        \\pub const {} = {s} {s} {{
        \\
    , .{
        std.zig.fmtId(name),
        if (zero_sized) "" else "extern",
        if (has_modes) "union" else "struct",
    });

    var written = false;
    if (modes.len > 0) {
        try write_newline_if_written(writer, &written);
        try write_mode_enum_and_fn(db, arena, modes, writer);
    }

    const enums = try db.get_enums(arena, struct_id, .{ .distinct = true });
    for (enums) |e| {
        try write_newline_if_written(writer, &written);
        try write_enum(db, arena, &e, writer);
    }

    const struct_decls = try db.get_struct_decls(arena, struct_id);
    for (struct_decls) |sd| {
        try write_newline_if_written(writer, &written);
        try write_struct_decl(
            db,
            arena,
            sd.name,
            sd.description,
            sd.size_bytes,
            sd.struct_id,
            writer,
        );
    }

    try write_newline_if_written(writer, &written);
    try write_registers(db, arena, struct_id, block_size_bytes, modes, registers, writer);

    try writer.writeAll("\n}");
    try writer.writeAll(";\n");

    try out_writer.writeAll(buffer.items);
}

fn write_peripheral(
    db: *Database,
    arena: Allocator,
    peripheral: *const Peripheral,
    out_writer: anytype,
) !void {
    log.debug("writing peripheral: name='{s}'", .{peripheral.name});
    try write_struct_decl(
        db,
        arena,
        peripheral.name,
        peripheral.description,
        peripheral.size_bytes,
        peripheral.struct_id,
        out_writer,
    );
}

fn write_newline_if_written(writer: anytype, written: *bool) !void {
    if (written.*)
        try writer.writeByte('\n')
    else
        written.* = true;
}

fn write_enum(db: *Database, arena: Allocator, e: *const Enum, out_writer: anytype) !void {
    var buffer = std.ArrayList(u8).init(arena);
    defer buffer.deinit();

    const writer = buffer.writer();

    // TODO: handle this instead of assert
    // assert(std.math.ceilPowerOfTwo(field_set.count()) <= size);

    if (e.description) |description|
        try write_doc_comment(arena, description, writer);

    try writer.print("pub const {} = enum(u{}) {{\n", .{
        std.zig.fmtId(e.name.?),
        e.size_bits,
    });
    try write_enum_fields(db, arena, e, writer);
    try writer.writeAll("};\n");

    try out_writer.writeAll(buffer.items);
}

fn write_enum_fields(db: *Database, arena: Allocator, e: *const Enum, out_writer: anytype) !void {
    var buffer = std.ArrayList(u8).init(arena);
    defer buffer.deinit();

    const writer = buffer.writer();
    const enum_fields = try db.get_enum_fields(arena, e.id, .{ .distinct = true });

    for (enum_fields) |enum_field|
        try write_enum_field(arena, &enum_field, e.size_bits, writer);

    // if the enum doesn't completely fill the integer then make it a non-exhaustive enum
    if (enum_fields.len < std.math.pow(u64, 2, e.size_bits))
        try writer.writeAll("_,\n");

    try out_writer.writeAll(buffer.items);
}

fn write_enum_field(
    arena: Allocator,
    enum_field: *const EnumField,
    size: u64,
    writer: anytype,
) !void {
    // TODO: use size to print the hex value (pad with zeroes accordingly)
    _ = size;
    if (enum_field.description) |description|
        try write_doc_comment(arena, description, writer);

    try writer.print("{} = 0x{x},\n", .{ std.zig.fmtId(enum_field.name), enum_field.value });
}

fn write_mode_enum_and_fn(
    db: *Database,
    arena: Allocator,
    modes: []const Mode,
    out_writer: anytype,
) !void {
    var buffer = std.ArrayList(u8).init(arena);
    defer buffer.deinit();

    const writer = buffer.writer();
    try writer.writeAll("pub const Mode = enum {\n");

    for (modes) |mode| {
        try writer.print("{},\n", .{std.zig.fmtId(mode.name)});
    }

    try writer.writeAll(
        \\};
        \\
        \\pub fn get_mode(self: *volatile @This()) Mode {
        \\
    );

    for (modes) |mode| {
        var components = std.ArrayList([]const u8).init(db.gpa);
        defer components.deinit();

        var tok_it = std.mem.tokenizeScalar(u8, mode.qualifier, '.');
        while (tok_it.next()) |token|
            try components.append(token);

        const field_name = components.items[components.items.len - 1];
        const access_path = try std.mem.join(arena, ".", components.items[1 .. components.items.len - 1]);
        try writer.writeAll("{\n");
        try writer.print("const value = self.{s}.read().{s};\n", .{
            access_path,
            field_name,
        });
        try writer.writeAll("switch (value) {\n");

        tok_it = std.mem.tokenizeScalar(u8, mode.value, ' ');
        while (tok_it.next()) |token| {
            const value = try std.fmt.parseInt(u64, token, 0);
            try writer.print("{},\n", .{value});
        }
        try writer.print("=> return .{},\n", .{std.zig.fmtId(mode.name)});
        try writer.writeAll("else => {},\n");
        try writer.writeAll("}\n");
        try writer.writeAll("}\n");
    }

    try writer.writeAll("\nunreachable;\n");
    try writer.writeAll("}\n");

    try out_writer.writeAll(buffer.items);
}

fn write_registers(
    db: *Database,
    arena: Allocator,
    struct_id: StructID,
    block_size_bytes: ?u64,
    modes: []const Mode,
    registers: []const Register,
    out_writer: anytype,
) !void {
    log.debug("write_registers: modes.len={}", .{modes.len});
    if (modes.len > 0)
        try write_registers_with_modes(db, arena, struct_id, block_size_bytes, modes, out_writer)
    else
        try write_registers_base(db, arena, block_size_bytes, registers, out_writer);
}

fn write_registers_with_modes(
    db: *Database,
    arena: Allocator,
    struct_id: StructID,
    block_size_bytes: ?u64,
    modes: []const Mode,
    out_writer: anytype,
) !void {
    log.debug("write_registers_with_modes", .{});
    var buffer = std.ArrayList(u8).init(arena);
    defer buffer.deinit();

    const writer = buffer.writer();
    for (modes) |mode| {
        const registers = try db.get_registers_with_mode(arena, struct_id, mode.id);
        try writer.print("{}: extern struct {{\n", .{
            std.zig.fmtId(mode.name),
        });

        try write_registers_base(db, arena, block_size_bytes, registers, writer);
        try writer.writeAll("},\n");
    }

    try out_writer.writeAll(buffer.items);
}

fn write_registers_base(
    db: *Database,
    arena: Allocator,
    block_size_bytes: ?u64,
    registers: []const Register,
    out_writer: anytype,
) !void {
    log.debug("write_registers_base", .{});
    // Fields are assumed to be in order of offset, it's possible there are
    // registers that overlap so we're going to filter out some registers so
    // there's no overlap
    var non_overlapping = std.ArrayList(Register).init(arena);
    for (registers) |register| {
        if (non_overlapping.items.len == 0) {
            try non_overlapping.append(register);
            continue;
        }

        const last_register = &non_overlapping.items[non_overlapping.items.len - 1];
        const last_register_end_bytes = last_register.offset_bytes + last_register.get_size_bytes();

        // If there's no overlap then append and continue
        if (last_register_end_bytes <= register.offset_bytes) {
            try non_overlapping.append(register);
        } else if (last_register.offset_bytes == register.offset_bytes and
            register.get_size_bytes() < last_register.get_size_bytes())
        {
            // Edge case for overlapping
            //
            // If a register's offset comes before another, it has precedence,
            // but if the offsets are the exact same, and the new one is
            // smaller, then the new will replace the old.
            last_register.* = register;
        }
    }

    // registers _should_ be sorted by the time they make their way here
    var buffer = std.ArrayList(u8).init(arena);
    defer buffer.deinit();

    const writer = buffer.writer();
    var offset: u64 = 0;
    for (non_overlapping.items) |register| {
        // Pad out space between registers with 'reserved' byte arrays
        if (offset < register.offset_bytes) {
            try writer.print("/// offset: 0x{x:0>2}\n", .{offset});
            try writer.print("reserved{}: [{}]u8,\n", .{ register.offset_bytes, register.offset_bytes - offset });
            offset = register.offset_bytes;
        }

        assert(offset == register.offset_bytes);
        try write_register(db, arena, &register, writer);
        offset += register.get_size_bytes();
    }

    if (block_size_bytes) |size| {
        if (offset > size)
            @panic("peripheral size too small, parsing should have caught this");

        log.debug("offset={}, size={}", .{ offset, size });
        if (offset != size)
            try writer.print("padding: [{}]u8,\n", .{
                size - offset,
            });
    }

    try out_writer.writeAll(buffer.items);
}

fn write_register(
    db: *Database,
    arena: Allocator,
    register: *const Register,
    out_writer: anytype,
) !void {
    log.debug("write_register: {}", .{register.*});
    var buffer = std.ArrayList(u8).init(arena);
    defer buffer.deinit();

    const writer = buffer.writer();
    if (register.description) |description|
        try write_doc_comment(arena, description, writer);

    // Add offset comment
    var offset_buf: [80]u8 = undefined;
    const offset_str: []const u8 =
        try std.fmt.bufPrint(&offset_buf, "offset: 0x{x:0>2}", .{register.offset_bytes});
    try write_doc_comment(arena, offset_str, writer);

    var array_prefix_buf: [80]u8 = undefined;
    const array_prefix: []const u8 = if (register.count) |count|
        try std.fmt.bufPrint(&array_prefix_buf, "[{}]", .{count})
    else
        "";

    // TODO: named struct type
    const fields = try db.get_register_fields(arena, register.id, .{});
    if (fields.len > 0) {
        try writer.print("{}: {s}mmio.Mmio(packed struct(u{}) {{\n", .{
            std.zig.fmtId(register.name),
            array_prefix,
            register.size_bits,
        });

        try write_fields(db, arena, fields, register.size_bits, writer);
        try writer.writeAll("}),\n");
    } else {
        try writer.print("{}: {s}u{},\n", .{
            std.zig.fmtId(register.name),
            array_prefix,
            register.size_bits,
        });
    }

    try out_writer.writeAll(buffer.items);
}

/// Determine if a field comes before another, i.e. has a lower bit offset in the register
/// (or should be preferred to another, if they incorrectly have the same offset).
fn field_comes_before(_: void, a: Database.StructField, b: Database.StructField) bool {
    return a.offset_bits < b.offset_bits or (a.offset_bits == b.offset_bits and a.size_bits < b.size_bits);
}

fn write_fields(
    db: *Database,
    arena: Allocator,
    fields: []const Database.StructField,
    register_size_bits: u64,
    out_writer: anytype,
) !void {
    // We first expand every 'array field' into its consituent fields,
    // named e.g. `@OISN[0]`, `@OISN[1]`, etc. for `field.name` OISN.
    var expanded_fields = std.ArrayList(Database.StructField).init(arena);
    for (fields) |field| {
        if (field.count) |count| {
            var stride = field.stride orelse field.size_bits;
            if (stride < field.size_bits) {
                log.warn("array field stride {d} for field {s} is too small, assuming stride == field size ({d}) instead", .{ stride, field.name, field.size_bits });
                stride = field.size_bits;
            }
            for (0..count) |i| {
                var subfield = field;
                subfield.count = undefined;
                subfield.stride = undefined;
                subfield.offset_bits = field.offset_bits + @as(u8, @intCast(stride * i));
                subfield.name = try std.fmt.allocPrint(arena, "{s}[{d}]", .{ field.name, i });
                subfield.description = try std.fmt.allocPrint(arena, "({d}/{d} of {s}) {s}", .{ i + 1, count, field.name, field.description orelse "" });
                try expanded_fields.append(subfield);
            }
        } else try expanded_fields.append(field);
    }
    // the 'count' and 'stride' of each entry of `expanded_fields` are never used below

    // Fields are not assumed to be in order of offset, but they often are,
    // so we use a stable sort algorithm that is fast on almost sorted data.
    // (One examples where fields are not in order, is with array fields that 'interleave',
    // where both have stride > size_bits: Above those are appended out of order.)
    std.sort.insertion(Database.StructField, expanded_fields.items, {}, field_comes_before);

    var buffer = std.ArrayList(u8).init(arena);
    defer buffer.deinit();
    const writer = buffer.writer();
    var offset: u64 = 0;

    for (expanded_fields.items) |field| {
        if (offset > field.offset_bits) {
            // It's possible there are fields that overlap so
            // we're going to filter out some fields so there's no overlap.
            //
            // Edge case for overlapping
            //
            // If the offset of this field is the exact same as for another shorter field,
            // then (because of the `field_comes_before()` sort order) we will already have seen the shorter field,
            // and here we are skipping the longer field.
            const message = try std.fmt.allocPrint(arena, "skipped overlapping field {s} at offset {d} bits", .{ field.name, field.offset_bits });
            log.debug("{s}", .{message});
            try write_regular_comment(arena, message, writer);
            continue;
        }
        if (offset + field.size_bits > register_size_bits) {
            const message = try std.fmt.allocPrint(arena, "skipped too long field {s} at offset {d} bits, length {d} bits", .{ field.name, field.offset_bits, field.size_bits });
            log.warn("{s}", .{message});
            try write_regular_comment(arena, message, writer);
            continue;
        }
        if (offset < field.offset_bits) {
            try writer.print("reserved{}: u{} = 0,\n", .{ field.offset_bits, field.offset_bits - offset });
            offset = field.offset_bits;
        }
        assert(offset == field.offset_bits);

        if (field.description) |description|
            try write_doc_comment(arena, description, writer);

        if (field.enum_id) |enum_id| {
            const e = try db.get_enum(arena, enum_id);
            if (e.name) |enum_name| {
                if (e.struct_id == null or try db.enum_has_name_collision(enum_id)) {
                    try writer.print(
                        \\{}: enum(u{}) {{
                        \\
                    , .{
                        std.zig.fmtId(field.name),
                        e.size_bits,
                    });

                    try write_enum_fields(db, arena, &e, writer);
                    try writer.writeAll("},\n");
                } else {
                    try writer.print(
                        \\{}:  {},
                        \\
                    , .{
                        std.zig.fmtId(field.name),
                        std.zig.fmtId(enum_name),
                    });
                }
            } else {
                try writer.print(
                    \\{}: enum(u{}) {{
                    \\
                , .{
                    std.zig.fmtId(field.name),
                    e.size_bits,
                });

                try write_enum_fields(db, arena, &e, writer);
                try writer.writeAll("},\n");
            }
        } else {
            try writer.print("{}: u{},\n", .{ std.zig.fmtId(field.name), field.size_bits });
        }

        offset += field.size_bits;
    }

    assert(offset <= register_size_bits);
    if (offset < register_size_bits)
        try writer.print("padding: u{} = 0,\n", .{register_size_bits - offset});

    try out_writer.writeAll(buffer.items);
}

const tests = @import("output_tests.zig");

test "gen.peripheral instantiation" {
    var db = try tests.peripheral_instantiation(std.testing.allocator);
    defer db.destroy();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
        \\pub const devices = struct {
        \\    pub const TEST_DEVICE = struct {
        \\        pub const peripherals = struct {
        \\            pub const TEST0: *volatile types.peripherals.TEST_PERIPHERAL = @ptrFromInt(0x1000);
        \\        };
        \\    };
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const TEST_PERIPHERAL = extern struct {
        \\            /// offset: 0x00
        \\            TEST_REGISTER: mmio.Mmio(packed struct(u32) {
        \\                TEST_FIELD: u1,
        \\                padding: u31 = 0,
        \\            }),
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.peripherals with a shared type" {
    var db = try tests.peripherals_with_shared_type(std.testing.allocator);
    defer db.destroy();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
        \\pub const devices = struct {
        \\    pub const TEST_DEVICE = struct {
        \\        pub const peripherals = struct {
        \\            pub const TEST0: *volatile types.peripherals.TEST_PERIPHERAL = @ptrFromInt(0x1000);
        \\            pub const TEST1: *volatile types.peripherals.TEST_PERIPHERAL = @ptrFromInt(0x2000);
        \\        };
        \\    };
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const TEST_PERIPHERAL = extern struct {
        \\            /// offset: 0x00
        \\            TEST_REGISTER: mmio.Mmio(packed struct(u32) {
        \\                TEST_FIELD: u1,
        \\                padding: u31 = 0,
        \\            }),
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.peripheral with modes" {
    var db = try tests.peripheral_with_modes(std.testing.allocator);
    defer db.destroy();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
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
        \\                        0,
        \\                        => return .TEST_MODE1,
        \\                        else => {},
        \\                    }
        \\                }
        \\                {
        \\                    const value = self.TEST_MODE2.COMMON_REGISTER.read().TEST_FIELD;
        \\                    switch (value) {
        \\                        1,
        \\                        => return .TEST_MODE2,
        \\                        else => {},
        \\                    }
        \\                }
        \\
        \\                unreachable;
        \\            }
        \\
        \\            TEST_MODE1: extern struct {
        \\                /// offset: 0x00
        \\                TEST_REGISTER1: u32,
        \\                /// offset: 0x04
        \\                COMMON_REGISTER: mmio.Mmio(packed struct(u32) {
        \\                    TEST_FIELD: u1,
        \\                    padding: u31 = 0,
        \\                }),
        \\            },
        \\            TEST_MODE2: extern struct {
        \\                /// offset: 0x00
        \\                TEST_REGISTER2: u32,
        \\                /// offset: 0x04
        \\                COMMON_REGISTER: mmio.Mmio(packed struct(u32) {
        \\                    TEST_FIELD: u1,
        \\                    padding: u31 = 0,
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
    defer db.destroy();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
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
        \\            /// offset: 0x00
        \\            TEST_REGISTER: u8,
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.peripheral with enum, enum is exhausted of values" {
    var db = try tests.peripheral_with_enum_and_its_exhausted_of_values(std.testing.allocator);
    defer db.destroy();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const TEST_PERIPHERAL = extern struct {
        \\            pub const TEST_ENUM = enum(u1) {
        \\                TEST_ENUM_FIELD1 = 0x0,
        \\                TEST_ENUM_FIELD2 = 0x1,
        \\            };
        \\
        \\            /// offset: 0x00
        \\            TEST_REGISTER: u8,
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.field with named enum" {
    var db = try tests.field_with_named_enum(std.testing.allocator);
    defer db.destroy();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
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
        \\            /// offset: 0x00
        \\            TEST_REGISTER: mmio.Mmio(packed struct(u8) {
        \\                TEST_FIELD: TEST_ENUM,
        \\                padding: u4 = 0,
        \\            }),
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.field with anonymous enum" {
    var db = try tests.field_with_anonymous_enum(std.testing.allocator);
    defer db.destroy();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const TEST_PERIPHERAL = extern struct {
        \\            /// offset: 0x00
        \\            TEST_REGISTER: mmio.Mmio(packed struct(u8) {
        \\                TEST_FIELD: enum(u4) {
        \\                    TEST_ENUM_FIELD1 = 0x0,
        \\                    TEST_ENUM_FIELD2 = 0x1,
        \\                    _,
        \\                },
        \\                padding: u4 = 0,
        \\            }),
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.namespaced register groups" {
    var db = try tests.namespaced_register_groups(std.testing.allocator);
    defer db.destroy();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
        \\pub const devices = struct {
        \\    pub const ATmega328P = struct {
        \\        pub const peripherals = struct {
        \\            pub const PORTB: *volatile types.peripherals.PORT.PORTB = @ptrFromInt(0x23);
        \\            pub const PORTC: *volatile types.peripherals.PORT.PORTC = @ptrFromInt(0x26);
        \\        };
        \\    };
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const PORT = struct {
        \\            pub const PORTB = extern struct {
        \\                /// offset: 0x00
        \\                PORTB: u8,
        \\                /// offset: 0x01
        \\                DDRB: u8,
        \\                /// offset: 0x02
        \\                PINB: u8,
        \\            };
        \\
        \\            pub const PORTC = extern struct {
        \\                /// offset: 0x00
        \\                PORTC: u8,
        \\                /// offset: 0x01
        \\                DDRC: u8,
        \\                /// offset: 0x02
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
    defer db.destroy();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
        \\pub const devices = struct {
        \\    pub const ATmega328P = struct {
        \\        pub const peripherals = struct {
        \\            pub const PORTB: *volatile types.peripherals.PORTB = @ptrFromInt(0x23);
        \\        };
        \\    };
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const PORTB = extern struct {
        \\            /// offset: 0x00
        \\            PORTB: u32,
        \\            /// offset: 0x04
        \\            reserved8: [4]u8,
        \\            /// offset: 0x08
        \\            PINB: u32,
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.peripheral with count" {
    var db = try tests.peripheral_with_count(std.testing.allocator);
    defer db.destroy();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
        \\pub const devices = struct {
        \\    pub const ATmega328P = struct {
        \\        pub const peripherals = struct {
        \\            pub const PORTB: *volatile [4]types.peripherals.PORTB = @ptrFromInt(0x23);
        \\        };
        \\    };
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const PORTB = extern struct {
        \\            /// offset: 0x00
        \\            PORTB: u8,
        \\            /// offset: 0x01
        \\            DDRB: u8,
        \\            /// offset: 0x02
        \\            PINB: u8,
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.peripheral with count, padding required" {
    var db = try tests.peripheral_with_count_padding_required(std.testing.allocator);
    defer db.destroy();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
        \\pub const devices = struct {
        \\    pub const ATmega328P = struct {
        \\        pub const peripherals = struct {
        \\            pub const PORTB: *volatile [4]types.peripherals.PORTB = @ptrFromInt(0x23);
        \\        };
        \\    };
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const PORTB = extern struct {
        \\            /// offset: 0x00
        \\            PORTB: u8,
        \\            /// offset: 0x01
        \\            DDRB: u8,
        \\            /// offset: 0x02
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
    defer db.destroy();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
        \\pub const devices = struct {
        \\    pub const ATmega328P = struct {
        \\        pub const peripherals = struct {
        \\            pub const PORTB: *volatile types.peripherals.PORTB = @ptrFromInt(0x23);
        \\        };
        \\    };
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const PORTB = extern struct {
        \\            /// offset: 0x00
        \\            PORTB: [4]u8,
        \\            /// offset: 0x04
        \\            DDRB: u8,
        \\            /// offset: 0x05
        \\            PINB: u8,
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.register with count and fields" {
    var db = try tests.register_with_count_and_fields(std.testing.allocator);
    defer db.destroy();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
        \\pub const devices = struct {
        \\    pub const ATmega328P = struct {
        \\        pub const peripherals = struct {
        \\            pub const PORTB: *volatile types.peripherals.PORTB = @ptrFromInt(0x23);
        \\        };
        \\    };
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const PORTB = extern struct {
        \\            /// offset: 0x00
        \\            PORTB: [4]mmio.Mmio(packed struct(u8) {
        \\                TEST_FIELD: u4,
        \\                padding: u4 = 0,
        \\            }),
        \\            /// offset: 0x04
        \\            DDRB: u8,
        \\            /// offset: 0x05
        \\            PINB: u8,
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.field with count, width of one, offset, and padding" {
    var db = try tests.field_with_count_width_of_one_offset_and_padding(std.testing.allocator);
    defer db.destroy();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const PORTB = extern struct {
        \\            /// offset: 0x00
        \\            PORTB: mmio.Mmio(packed struct(u8) {
        \\                reserved2: u2 = 0,
        \\                TEST_FIELD0: u1,
        \\                TEST_FIELD1: u1,
        \\                TEST_FIELD2: u1,
        \\                TEST_FIELD3: u1,
        \\                TEST_FIELD4: u1,
        \\                padding: u1 = 0,
        \\            }),
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.field with count, multi-bit width, offset, and padding" {
    var db = try tests.field_with_count_multi_bit_width_offset_and_padding(std.testing.allocator);
    defer db.destroy();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const PORTB = extern struct {
        \\            /// offset: 0x00
        \\            PORTB: mmio.Mmio(packed struct(u8) {
        \\                reserved2: u2 = 0,
        \\                TEST_FIELD0: u2,
        \\                TEST_FIELD1: u2,
        \\                padding: u2 = 0,
        \\            }),
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.interrupts.avr" {
    var db = try tests.interrupts_avr(std.testing.allocator);
    defer db.destroy();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
        \\pub const devices = struct {
        \\    pub const ATmega328P = struct {
        \\        pub const interrupts: []const Interrupt = &.{
        \\            .{ .name = "TEST_VECTOR1", .index = 1, .description = null },
        \\            .{ .name = "TEST_VECTOR2", .index = 3, .description = null },
        \\        };
        \\
        \\        pub const VectorTable = extern struct {
        \\            const Handler = microzig.interrupt.Handler;
        \\            const unhandled = microzig.interrupt.unhandled;
        \\
        \\            RESET: Handler,
        \\            TEST_VECTOR1: Handler = unhandled,
        \\            reserved2: [1]u16 = undefined,
        \\            TEST_VECTOR2: Handler = unhandled,
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.peripheral type with register and field" {
    var db = try tests.peripheral_type_with_register_and_field(std.testing.allocator);
    defer db.destroy();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        /// test peripheral
        \\        pub const TEST_PERIPHERAL = extern struct {
        \\            /// test register
        \\            /// offset: 0x00
        \\            TEST_REGISTER: mmio.Mmio(packed struct(u32) {
        \\                /// test field
        \\                TEST_FIELD: u1,
        \\                padding: u31 = 0,
        \\            }),
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.name collisions in enum name cause them to be anonymous" {
    var db = try tests.enums_with_name_collision(std.testing.allocator);
    defer db.destroy();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const TEST_PERIPHERAL = extern struct {
        \\            /// offset: 0x00
        \\            TEST_REGISTER: mmio.Mmio(packed struct(u8) {
        \\                TEST_FIELD1: enum(u4) {
        \\                    TEST_ENUM_FIELD1 = 0x0,
        \\                    TEST_ENUM_FIELD2 = 0x1,
        \\                    _,
        \\                },
        \\                TEST_FIELD2: enum(u4) {
        \\                    TEST_ENUM_FIELD1 = 0x0,
        \\                    TEST_ENUM_FIELD2 = 0x1,
        \\                    _,
        \\                },
        \\            }),
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.pick one enum field in value collisions" {
    var db = try tests.enum_with_value_collision(std.testing.allocator);
    defer db.destroy();

    try db.backup("value_collision.regz");

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const TEST_PERIPHERAL = extern struct {
        \\            /// offset: 0x00
        \\            TEST_REGISTER: mmio.Mmio(packed struct(u8) {
        \\                TEST_FIELD: enum(u4) {
        \\                    TEST_ENUM_FIELD1 = 0x0,
        \\                    _,
        \\                },
        \\                padding: u4 = 0,
        \\            }),
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.pick one enum field in name collisions" {
    var db = try tests.enum_fields_with_name_collision(std.testing.allocator);
    defer db.destroy();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        pub const TEST_PERIPHERAL = extern struct {
        \\            /// offset: 0x00
        \\            TEST_REGISTER: mmio.Mmio(packed struct(u8) {
        \\                TEST_FIELD: enum(u4) {
        \\                    TEST_ENUM_FIELD1 = 0x0,
        \\                    _,
        \\                },
        \\                padding: u4 = 0,
        \\            }),
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

test "gen.register fields with name collision" {
    var db = try tests.register_fields_with_name_collision(std.testing.allocator);
    defer db.destroy();

    var buffer = std.ArrayList(u8).init(std.testing.allocator);
    defer buffer.deinit();

    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
    try std.testing.expectEqualStrings(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
        \\pub const types = struct {
        \\    pub const peripherals = struct {
        \\        /// test peripheral
        \\        pub const TEST_PERIPHERAL = extern struct {
        \\            /// test register
        \\            /// offset: 0x00
        \\            TEST_REGISTER: mmio.Mmio(packed struct(u32) {
        \\                /// test field 1
        \\                TEST_FIELD: u1,
        \\                padding: u31 = 0,
        \\            }),
        \\        };
        \\    };
        \\};
        \\
    , buffer.items);
}

// FIXME: Additional unit tests to create
//
// - Registers with shared struct
// - Complex struct as field in a peripheral
// - Moded Register
// - Moded Field
