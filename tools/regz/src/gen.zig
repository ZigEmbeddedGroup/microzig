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
const NestedStructField = Database.NestedStructField;

const Properties = @import("properties.zig").Properties;
const Directory = @import("Directory.zig");
const VirtualFilesystem = @import("VirtualFilesystem.zig");
const arm = @import("arch/arm.zig");
const avr = @import("arch/avr.zig");
const riscv = @import("arch/riscv.zig");

const log = std.log.scoped(.gen);

pub const ToZigOptions = struct {};

pub fn to_zig(db: *Database, dir: Directory, opts: ToZigOptions) !void {
    var arena = std.heap.ArenaAllocator.init(db.gpa);
    defer arena.deinit();

    try write_device_files(db, arena.allocator(), dir, opts);
    try write_types_files(db, arena.allocator(), dir, opts);
}

fn write_device_files(
    db: *Database,
    arena: Allocator,
    dir: Directory,
    opts: ToZigOptions,
) !void {
    const devices = try db.get_devices(arena);
    for (devices) |device| {
        write_device_file(db, arena, &device, dir, opts) catch |err| {
            log.warn("failed to write device: {}", .{err});
        };
    }
}

fn write_imports(opts: ToZigOptions, types_public: bool, types_path: []const u8, writer: *std.Io.Writer) !void {
    _ = opts;
    const public: []const u8 = if (types_public) "pub" else "";
    try writer.print(
        \\const microzig = @import("microzig");
        \\const mmio = microzig.mmio;
        \\
        \\{s} const types = @import("{s}");
        \\
        \\
    , .{ public, types_path });
}

fn write_device_file(
    db: *Database,
    arena: Allocator,
    device: *const Database.Device,
    dir: Directory,
    opts: ToZigOptions,
) !void {
    var buf: std.Io.Writer.Allocating = .init(arena);
    const writer = &buf.writer;

    if (device.description) |description| {
        try write_file_comment(arena, description, writer);
    }

    try write_imports(opts, true, "types.zig", writer);

    try writer.writeAll(@embedFile("properties.zig") ++
        \\
        \\pub const Interrupt = struct {
        \\    name: [:0]const u8,
        \\    index: i16,
        \\    description: ?[:0]const u8,
        \\};
        \\
    );

    const raw_properties = try db.get_device_properties(arena, device.id);
    const properties = process_properties(raw_properties);

    try writer.writeAll("\npub const properties: Properties = ");
    try std.zon.stringify.serialize(properties, .{}, writer);
    try writer.writeAll(";\n");

    if (raw_properties.len > 0) {
        try writer.writeAll("\npub const raw_properties = struct {\n");
        for (raw_properties) |prop| {
            try writer.print("pub const {f} = ", .{
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
        try writer.writeAll("\npub const peripherals = struct {\n");
        for (device_peripherals) |instance| {
            write_device_peripheral(db, arena, &instance, writer) catch |err| {
                log.warn("failed to serialize peripheral instance: {}", .{err});
            };
        }
        try writer.writeAll("};\n");
    }

    try writer.writeByte(0);

    var ast = try std.zig.Ast.parse(arena, to_zero_sentinel(buf.written()), .zig);
    defer ast.deinit(arena);

    if (ast.errors.len > 0) {
        log.err("Failed to parse:\n{s}", .{buf.written()});
        for (ast.errors) |err| {
            std.log.err("err: {}", .{err});
            var err_msg: std.Io.Writer.Allocating = .init(arena);
            defer err_msg.deinit();

            try ast.renderError(err, &err_msg.writer);
            std.log.err("  {s}", .{err_msg.written()});
        }
        return error.FailedToParse;
    }

    var rendered_buffer: std.Io.Writer.Allocating = .init(arena);
    const fixups: std.zig.Ast.Render.Fixups = .{};

    try ast.render(arena, &rendered_buffer.writer, fixups);

    const filename = try std.fmt.allocPrint(arena, "{s}.zig", .{device.name});
    try dir.create_file(filename, rendered_buffer.written());
}

fn write_types_files(db: *Database, arena: Allocator, dir: Directory, opts: ToZigOptions) !void {
    try dir.create_file("types.zig",
        \\pub const peripherals = @import("types/peripherals.zig");
        \\
    );

    try write_peripherals_files(db, arena, dir, opts);
}

fn write_peripherals_files(db: *Database, arena: Allocator, dir: Directory, opts: ToZigOptions) !void {
    var index_content: std.Io.Writer.Allocating = .init(arena);
    const index_writer = &index_content.writer;

    const peripherals = try db.get_peripherals(arena);
    for (peripherals) |peripheral| {
        var periph_content: std.Io.Writer.Allocating = .init(arena);
        const writer = &periph_content.writer;

        try write_imports(opts, false, "../../types.zig", writer);
        write_peripheral(db, arena, &peripheral, writer) catch |err| {
            log.warn("failed to generate peripheral '{s}': {}", .{
                peripheral.name,
                err,
            });

            continue;
        };

        const path = try std.fmt.allocPrint(arena, "types/peripherals/{s}.zig", .{
            peripheral.name,
        });

        try writer.writeByte(0);
        var ast = try std.zig.Ast.parse(arena, to_zero_sentinel(periph_content.written()), .zig);
        defer ast.deinit(arena);

        if (ast.errors.len > 0) {
            log.err("Failed to parse:\n{s}", .{periph_content.written()});
            for (ast.errors) |err| {
                std.log.err("err: {}", .{err});
                var err_msg: std.Io.Writer.Allocating = .init(arena);
                defer err_msg.deinit();

                try ast.renderError(err, &err_msg.writer);
                std.log.err("  {s}", .{err_msg.written()});
            }
            return error.FailedToParse;
        }

        var rendered_buffer: std.Io.Writer.Allocating = .init(arena);
        const fixups: std.zig.Ast.Render.Fixups = .{};
        try ast.render(arena, &rendered_buffer.writer, fixups);

        try dir.create_file(path, rendered_buffer.written());

        if (try db.struct_is_zero_sized(arena, peripheral.struct_id)) {
            try index_writer.print(
                \\pub const {f} = @import("peripherals/{s}.zig");
                \\
            , .{
                std.zig.fmtId(peripheral.name),
                peripheral.name,
            });
        } else {
            try index_writer.print(
                \\pub const {f} = @import("peripherals/{s}.zig").{f};
                \\
            , .{
                std.zig.fmtId(peripheral.name),
                peripheral.name,
                std.zig.fmtId(peripheral.name),
            });
        }
    }

    try dir.create_file("types/peripherals.zig", index_content.written());
}

pub fn write_file_comment(allocator: Allocator, comment: []const u8, writer: *std.Io.Writer) !void {
    try write_comment(allocator, "//!", comment, writer);
}

pub fn write_doc_comment(allocator: Allocator, comment: []const u8, writer: *std.Io.Writer) !void {
    try write_comment(allocator, "///", comment, writer);
}

pub fn write_regular_comment(allocator: Allocator, comment: []const u8, writer: *std.Io.Writer) !void {
    try write_comment(allocator, "//", comment, writer);
}

fn write_comment(allocator: Allocator, comptime comment_prefix: []const u8, comment: []const u8, writer: *std.Io.Writer) !void {
    var tokenized: std.Io.Writer.Allocating = .init(allocator);
    defer tokenized.deinit();
    const tokenized_writer = &tokenized.writer;

    var first = true;
    var tok_it = std.mem.tokenizeAny(u8, comment, "\n\r \t");
    while (tok_it.next()) |token| {
        if (!first)
            first = false
        else
            try tokenized_writer.writeByte(' ');

        try tokenized_writer.writeAll(token);
    }

    const unescaped = try std.mem.replaceOwned(u8, allocator, tokenized.written(), "\\n", "\n");
    defer allocator.free(unescaped);

    var line_it = std.mem.tokenizeScalar(u8, unescaped, '\n');
    while (line_it.next()) |line|
        try writer.print("{s}{s}\n", .{ comment_prefix, line });
}

fn write_string(str: []const u8, writer: *std.Io.Writer) !void {
    if (std.mem.containsAtLeast(u8, str, 1, "\n")) {
        try writer.writeByte('\n');
        var line_it = std.mem.splitScalar(u8, str, '\n');
        while (line_it.next()) |line|
            try writer.print("\\\\{s}\n", .{line});
    } else {
        try writer.print("\"{s}\"", .{str});
    }
}

fn write_device(db: *Database, arena: Allocator, device: *const Database.Device, out_writer: *std.Io.Writer) !void {
    var buf: std.Io.Writer.Allocating = .init(arena);
    const writer = &buf.writer;

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

    try out_writer.writeAll(buf.written());
}

const TypeID = union(enum) {
    @"enum": EnumID,
    @"struct": StructID,
};

// generates a string for a type in the `types` namespace of the generated
// code. Since this is only used in code generation, just going to stuff it in
// the arena allocator
fn types_reference(db: *Database, allocator: Allocator, type_id: TypeID) ![]const u8 {
    var full_name_components: std.ArrayList([]const u8) = .empty;
    defer full_name_components.deinit(allocator);

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

                try full_name_components.insert(allocator, 0, name_copy);
            },
            .@"struct" => |id| if (try db.get_struct_decl(allocator, id)) |struct_decl| {
                defer struct_decl.deinit(allocator);

                log.debug("got struct_decl: {}", .{struct_decl});
                const name_copy = try allocator.dupe(u8, struct_decl.name);
                errdefer allocator.free(name_copy);

                try full_name_components.insert(allocator, 0, name_copy);
                current_id = .{ .@"struct" = struct_decl.parent_id };
            } else if (try db.get_peripheral_by_struct_id(allocator, id)) |peripheral| {
                defer peripheral.deinit(allocator);

                const name_copy = try allocator.dupe(u8, peripheral.name);
                errdefer allocator.free(name_copy);

                try full_name_components.insert(allocator, 0, name_copy);
                break;
            } else @panic("A struct should have some sort of decl entry"),
        }
    } else @panic("Hit limit for reference length");

    if (full_name_components.items.len == 0)
        return error.CantReference;

    var full_name: std.Io.Writer.Allocating = .init(allocator);
    defer full_name.deinit();
    const writer = &full_name.writer;

    try writer.writeAll("types.peripherals");

    for (full_name_components.items) |component|
        try writer.print(".{f}", .{
            std.zig.fmtId(component),
        });

    log.debug("generated type ref: {s}", .{full_name.written()});
    return try full_name.toOwnedSlice();
}

fn write_interrupt_list(
    db: *Database,
    arena: Allocator,
    device: *const Device,
    out_writer: *std.Io.Writer,
) !void {
    var buf: std.Io.Writer.Allocating = .init(arena);
    const writer = &buf.writer;

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

    try out_writer.writeAll(buf.written());
}

fn write_vector_table(
    db: *Database,
    arena: Allocator,
    device: *const Device,
    out_writer: *std.Io.Writer,
) !void {
    var buf: std.Io.Writer.Allocating = .init(arena);
    const writer = &buf.writer;

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

    try out_writer.writeAll(buf.written());
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
    out_writer: *std.Io.Writer,
) !void {
    log.debug("writing periph instance", .{});

    var buf: std.Io.Writer.Allocating = .init(arena);
    const writer = &buf.writer;

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

    try writer.print("pub const {f}: *volatile {s}{s} = @ptrFromInt(0x{x});\n", .{
        std.zig.fmtId(instance.name),
        array_prefix,
        type_ref,
        instance.offset_bytes,
    });

    try out_writer.writeAll(buf.written());
}

fn write_struct(
    db: *Database,
    arena: Allocator,
    block_size_bytes: ?u64,
    struct_id: StructID,
    writer: *std.Io.Writer,
) anyerror!void {
    const registers = try db.get_struct_registers(arena, struct_id);
    const nested_struct_fields = try db.get_nested_struct_fields_with_calculated_size(arena, struct_id);
    const modes = try db.get_struct_modes(arena, struct_id);

    const zero_sized = registers.len == 0 and nested_struct_fields.len == 0;
    const has_modes = modes.len > 0;
    try writer.print(
        \\{s} {s} {{
        \\
    , .{
        if (zero_sized) "" else "extern",
        if (has_modes) "union" else "struct",
    });

    try write_struct_body(db, arena, block_size_bytes, struct_id, writer);
    try writer.writeAll("\n}");
}

fn write_struct_body(
    db: *Database,
    arena: Allocator,
    block_size_bytes: ?u64,
    struct_id: StructID,
    writer: *std.Io.Writer,
) !void {
    const registers = try db.get_struct_registers(arena, struct_id);
    const nested_struct_fields = try db.get_nested_struct_fields_with_calculated_size(arena, struct_id);
    const modes = try db.get_struct_modes(arena, struct_id);

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
    try write_registers_and_nested_structs(db, arena, struct_id, block_size_bytes, modes, registers, nested_struct_fields, writer);
}

fn write_struct_decl(
    db: *Database,
    arena: Allocator,
    name: []const u8,
    description: ?[]const u8,
    block_size_bytes: ?u64,
    struct_id: StructID,
    out_writer: *std.Io.Writer,
) !void {
    log.debug("writing struct decl: name='{s}'", .{name});

    var buf: std.Io.Writer.Allocating = .init(arena);
    const writer = &buf.writer;

    try writer.writeByte('\n');
    if (description) |d|
        try write_doc_comment(arena, d, writer);

    try writer.print("pub const {f} = ", .{
        std.zig.fmtId(name),
    });

    try write_struct(db, arena, block_size_bytes, struct_id, writer);
    try writer.writeAll(";\n");

    try out_writer.writeAll(buf.written());
}

fn write_peripheral(
    db: *Database,
    arena: Allocator,
    peripheral: *const Peripheral,
    out_writer: *std.Io.Writer,
) !void {
    log.debug("writing peripheral: name='{s}'", .{peripheral.name});
    if (try db.struct_is_zero_sized(arena, peripheral.struct_id)) {
        try write_struct_body(
            db,
            arena,
            peripheral.size_bytes,
            peripheral.struct_id,
            out_writer,
        );
    } else {
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
}

fn write_newline_if_written(writer: *std.Io.Writer, written: *bool) !void {
    if (written.*)
        try writer.writeByte('\n')
    else
        written.* = true;
}

fn write_enum(db: *Database, arena: Allocator, e: *const Enum, out_writer: *std.Io.Writer) !void {
    var buf: std.Io.Writer.Allocating = .init(arena);
    const writer = &buf.writer;

    // TODO: handle this instead of assert
    // assert(std.math.ceilPowerOfTwo(field_set.count()) <= size);

    if (e.description) |description|
        try write_doc_comment(arena, description, writer);

    try writer.print("pub const {f} = enum(u{}) {{\n", .{
        std.zig.fmtId(e.name.?),
        e.size_bits,
    });
    try write_enum_fields(db, arena, e, writer);
    try writer.writeAll("};\n");

    try out_writer.writeAll(buf.written());
}

fn write_default_enum_value(db: *Database, arena: Allocator, e: *const Enum, default: u64, writer: *std.Io.Writer) !void {
    const enum_fields = try db.get_enum_fields(arena, e.id, .{ .distinct = true });
    for (enum_fields) |enum_field| {
        if (enum_field.value == default) {
            try writer.print(".{f}", .{std.zig.fmtId(enum_field.name)});
            return;
        }
    }

    try writer.print("@enumFromInt(0x{X})", .{default});
}

fn write_enum_fields(db: *Database, arena: Allocator, e: *const Enum, out_writer: *std.Io.Writer) !void {
    var buf: std.Io.Writer.Allocating = .init(arena);
    const writer = &buf.writer;

    const enum_fields = try db.get_enum_fields(arena, e.id, .{ .distinct = true });

    for (enum_fields) |enum_field|
        try write_enum_field(arena, &enum_field, e.size_bits, writer);

    // if the enum doesn't completely fill the integer then make it a non-exhaustive enum
    if (enum_fields.len < std.math.pow(u64, 2, e.size_bits))
        try writer.writeAll("_,\n");

    try out_writer.writeAll(buf.written());
}

fn write_enum_field(
    arena: Allocator,
    enum_field: *const EnumField,
    size: u64,
    writer: *std.Io.Writer,
) !void {
    // TODO: use size to print the hex value (pad with zeroes accordingly)
    _ = size;
    if (enum_field.description) |description|
        try write_doc_comment(arena, description, writer);

    try writer.print("{f} = 0x{x},\n", .{ std.zig.fmtId(enum_field.name), enum_field.value });
}

fn write_mode_enum_and_fn(
    db: *Database,
    arena: Allocator,
    modes: []const Mode,
    out_writer: *std.Io.Writer,
) !void {
    var buf: std.Io.Writer.Allocating = .init(arena);
    const writer = &buf.writer;

    try writer.writeAll("pub const Mode = enum {\n");

    for (modes) |mode| {
        try writer.print("{f},\n", .{std.zig.fmtId(mode.name)});
    }

    try writer.writeAll(
        \\};
        \\
        \\pub fn get_mode(self: *volatile @This()) Mode {
        \\
    );

    for (modes) |mode| {
        var components: std.ArrayList([]const u8) = .empty;
        defer components.deinit(db.gpa);

        var tok_it = std.mem.tokenizeScalar(u8, mode.qualifier, '.');
        while (tok_it.next()) |token|
            try components.append(db.gpa, token);

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
        try writer.print("=> return .{f},\n", .{std.zig.fmtId(mode.name)});
        try writer.writeAll("else => {},\n");
        try writer.writeAll("}\n");
        try writer.writeAll("}\n");
    }

    try writer.writeAll("\nunreachable;\n");
    try writer.writeAll("}\n");

    try out_writer.writeAll(buf.written());
}

fn write_registers_and_nested_structs(
    db: *Database,
    arena: Allocator,
    struct_id: StructID,
    block_size_bytes: ?u64,
    modes: []const Mode,
    registers: []Register,
    nested_struct_fields: []NestedStructField,
    out_writer: *std.Io.Writer,
) !void {
    log.debug("write_registers: modes.len={}", .{modes.len});
    if (modes.len > 0)
        try write_registers_with_modes(db, arena, struct_id, block_size_bytes, modes, out_writer)
    else
        try write_registers_and_nested_structs_base(db, arena, block_size_bytes, registers, nested_struct_fields, out_writer);
}

fn write_registers_with_modes(
    db: *Database,
    arena: Allocator,
    struct_id: StructID,
    block_size_bytes: ?u64,
    modes: []const Mode,
    out_writer: *std.Io.Writer,
) !void {
    log.debug("write_registers_with_modes", .{});

    var buf: std.Io.Writer.Allocating = .init(arena);
    const writer = &buf.writer;

    for (modes) |mode| {
        const registers = try db.get_registers_with_mode(arena, struct_id, mode.id);
        try writer.print("{f}: extern struct {{\n", .{
            std.zig.fmtId(mode.name),
        });

        // TODO: moded nested_struct_field

        try write_registers_and_nested_structs_base(db, arena, block_size_bytes, registers, &.{}, writer);
        try writer.writeAll("},\n");
    }

    try out_writer.writeAll(buf.written());
}

const StructFieldIterator = struct {
    registers: []const Register,
    nested_struct_fields: []const NestedStructField,
    offset: u64 = 0,
    register_idx: usize = 0,
    nested_struct_field_idx: usize = 0,
    byte_offset: usize = 0,

    fn init(registers: []const Register, nested_struct_fields: []const NestedStructField) StructFieldIterator {
        assert(std.sort.isSorted(Register, registers, {}, Register.less_than));
        assert(std.sort.isSorted(NestedStructField, nested_struct_fields, {}, NestedStructField.less_than));
        return .{
            .registers = registers,
            .nested_struct_fields = nested_struct_fields,
        };
    }

    fn registers_done(it: *const StructFieldIterator) bool {
        return it.register_idx >= it.registers.len;
    }

    fn nested_struct_fields_done(it: *const StructFieldIterator) bool {
        return it.nested_struct_field_idx >= it.nested_struct_fields.len;
    }

    const Entry = union(enum) {
        reserved: struct {
            offset_bytes: usize,
            size_bytes: usize,
        },
        register: Register,
        nested_struct_field: NestedStructField,

        fn get_offset_bytes(entry: *const Entry) u64 {
            return switch (entry.*) {
                .reserved => |reserved| reserved.offset_bytes,
                .register => |register| register.offset_bytes,
                .nested_struct_field => |nsf| nsf.offset_bytes,
            };
        }

        fn get_size_bytes(entry: *const Entry) u64 {
            return switch (entry.*) {
                .reserved => |reserved| reserved.size_bytes,
                .register => |register| register.get_size_bytes(),
                .nested_struct_field => |nsf| nsf.size_bytes.?,
            };
        }
    };

    fn current_register(it: *StructFieldIterator) ?Register {
        return if (it.registers_done()) null else it.registers[it.register_idx];
    }

    fn current_nested_struct_field(it: *StructFieldIterator) ?NestedStructField {
        return if (it.nested_struct_fields_done()) null else it.nested_struct_fields[it.nested_struct_field_idx];
    }

    fn get_count_registers_matching_offset(it: *StructFieldIterator) u32 {
        var count: u32 = 0;
        for (it.registers[it.register_idx..]) |register| {
            if (register.offset_bytes != it.offset)
                break;

            count += 1;
        }

        return count;
    }

    fn get_count_nested_struct_fields_matching_offset(it: *StructFieldIterator) u32 {
        var count: u32 = 0;
        for (it.nested_struct_fields[it.nested_struct_field_idx..]) |nested_struct_field| {
            if (nested_struct_field.offset_bytes != it.offset)
                break;

            count += 1;
        }

        return count;
    }

    fn get_current_register_offset(it: *StructFieldIterator) ?u64 {
        return if (it.current_register()) |register| register.offset_bytes else null;
    }

    fn get_current_nested_struct_field_offset(it: *StructFieldIterator) ?u64 {
        return if (it.current_nested_struct_field()) |nested_struct_field| nested_struct_field.offset_bytes else null;
    }

    fn catchup_registers(it: *StructFieldIterator) void {
        while (true) : (it.register_idx += 1) {
            if (it.current_register()) |register| {
                if (register.offset_bytes >= it.offset)
                    return;
            } else return;
        }
    }

    fn catchup_nested_struct_fields(it: *StructFieldIterator) void {
        while (true) : (it.nested_struct_field_idx += 1) {
            if (it.current_nested_struct_field()) |nsf| {
                if (nsf.offset_bytes >= it.offset)
                    return;
            } else return;
        }
    }

    fn next(it: *StructFieldIterator) ?Entry {
        while (true) {
            if (it.registers_done() and it.nested_struct_fields_done())
                return null;

            it.catchup_registers();
            it.catchup_nested_struct_fields();

            const next_register_offset = it.get_current_register_offset();
            const next_nested_struct_field_offset = it.get_current_nested_struct_field_offset();

            const next_offset = if (next_register_offset != null and next_nested_struct_field_offset != null)
                @min(next_register_offset.?, next_nested_struct_field_offset.?)
            else
                next_register_offset orelse
                    next_nested_struct_field_offset orelse break;

            if (it.offset != next_offset) {
                defer it.offset = next_offset;
                return .{
                    .reserved = .{
                        .offset_bytes = it.offset,
                        .size_bytes = next_offset - it.offset,
                    },
                };
            }

            const ret = blk: {
                if (next_register_offset) |register_offset| {
                    if (next_offset == register_offset) {
                        const num_matching_offset = it.get_count_registers_matching_offset();
                        assert(num_matching_offset >= 1);

                        // select the first one with the smalles size
                        var smallest_size: ?u64 = null;
                        for (it.registers[it.register_idx .. it.register_idx + num_matching_offset]) |register| {
                            if (smallest_size) |current_smallest| {
                                const register_size_bytes = register.get_size_bytes();
                                if (register_size_bytes == 0) {
                                    continue;
                                }

                                if (register_size_bytes < current_smallest)
                                    smallest_size = register_size_bytes;
                            } else {
                                smallest_size = register.get_size_bytes();
                            }
                        }

                        const register = if (smallest_size) |size_bytes| for (it.registers[it.register_idx .. it.register_idx + num_matching_offset]) |register| {
                            if (register.get_size_bytes() == size_bytes)
                                break register;
                        } else unreachable else {
                            continue;
                        };

                        const ret = Entry{
                            .register = register,
                        };

                        it.register_idx += num_matching_offset;
                        break :blk ret;
                    }
                }

                const num_matching_offset = it.get_count_nested_struct_fields_matching_offset();
                assert(num_matching_offset >= 1);

                // select the first one with the smalles size
                var smallest_size: ?u64 = null;
                for (it.nested_struct_fields[it.nested_struct_field_idx .. it.nested_struct_field_idx + num_matching_offset]) |nested_struct_field| {
                    if (smallest_size) |current_smallest| {
                        const nested_struct_field_size_bytes = nested_struct_field.size_bytes.?;
                        if (nested_struct_field_size_bytes == 0) {
                            continue;
                        }

                        if (nested_struct_field_size_bytes < current_smallest)
                            smallest_size = nested_struct_field_size_bytes;
                    } else {
                        smallest_size = nested_struct_field.size_bytes.?;
                    }
                }

                const nested_struct_field = if (smallest_size) |size_bytes| for (it.nested_struct_fields[it.nested_struct_field_idx .. it.nested_struct_field_idx + num_matching_offset]) |nested_struct_field| {
                    if (nested_struct_field.size_bytes.? == size_bytes)
                        break nested_struct_field;
                } else unreachable else {
                    continue;
                };

                const ret = Entry{
                    .nested_struct_field = nested_struct_field,
                };

                it.nested_struct_field_idx += num_matching_offset;
                break :blk ret;
            };

            it.offset += ret.get_size_bytes();
            return ret;
        }
        return null;
    }
};

fn write_nested_struct_field(db: *Database, arena: Allocator, nsf: *const NestedStructField, writer: *std.Io.Writer) !void {
    if (nsf.description) |description|
        try write_doc_comment(arena, description, writer);

    var offset_buf: [80]u8 = undefined;
    const offset_str: []const u8 =
        try std.fmt.bufPrint(&offset_buf, "offset: 0x{x:0>2}", .{nsf.offset_bytes});
    try write_doc_comment(arena, offset_str, writer);

    try writer.print("{f}: ", .{std.zig.fmtId(nsf.name)});
    var array_prefix_buf: [80]u8 = undefined;
    const array_prefix: []const u8 = if (nsf.count) |count|
        try std.fmt.bufPrint(&array_prefix_buf, "[{}]", .{count})
    else
        "";
    try writer.print("{s}", .{array_prefix});

    // TODO: if it's a struct decl then refer to it by name
    if (try db.get_struct_decl_by_struct_id(arena, nsf.struct_id)) |struct_decl| {
        // TODO full reference?
        try writer.print("{f},\n", .{std.zig.fmtId(struct_decl.name)});
    } else {
        try write_struct(db, arena, null, nsf.struct_id, writer);
        try writer.writeAll(",\n");
    }
}

fn write_registers_and_nested_structs_base(
    db: *Database,
    arena: Allocator,
    block_size_bytes: ?u64,
    registers: []Register,
    nested_struct_fields: []NestedStructField,
    out_writer: *std.Io.Writer,
) !void {
    log.debug("registers.len={} nested_struct_fields.len={}", .{ registers.len, nested_struct_fields.len });
    var it: StructFieldIterator = .init(registers, nested_struct_fields);

    var buf: std.Io.Writer.Allocating = .init(arena);
    const writer = &buf.writer;

    var minimum_size: u64 = 0;
    while (it.next()) |entry| {
        switch (entry) {
            .reserved => |reserved| {
                try writer.print("/// offset: 0x{x:0>2}\n", .{reserved.offset_bytes});
                try writer.print("reserved{}: [{}]u8,\n", .{ reserved.offset_bytes, reserved.size_bytes });
            },
            .register => |register| try write_register(db, arena, &register, writer),
            .nested_struct_field => |nsf| try write_nested_struct_field(db, arena, &nsf, writer),
        }

        minimum_size = entry.get_offset_bytes() + entry.get_size_bytes();
    }

    if (block_size_bytes) |size| {
        if (minimum_size > size)
            @panic("peripheral size too small, parsing should have caught this");

        log.debug("minimum_size={}, size={}", .{ minimum_size, size });
        if (minimum_size != size)
            try writer.print("padding: [{}]u8,\n", .{
                size - minimum_size,
            });
    }

    try out_writer.writeAll(buf.written());
}

fn write_register(
    db: *Database,
    arena: Allocator,
    register: *const Register,
    out_writer: *std.Io.Writer,
) !void {
    log.debug("write_register: {f}", .{register.*});

    var buf: std.Io.Writer.Allocating = .init(arena);
    const writer = &buf.writer;

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

    const register_reset: ?RegisterReset = if (register.reset_mask != null and register.reset_value != null) .{
        .mask = register.reset_mask.?,
        .value = register.reset_value.?,
    } else null;

    // TODO: named struct type
    const fields = try db.get_register_fields(arena, register.id, .{});
    if (fields.len > 0) {
        try writer.print("{f}: {s}mmio.Mmio(packed struct(u{}) {{\n", .{
            std.zig.fmtId(register.name),
            array_prefix,
            register.size_bits,
        });

        try write_fields(db, arena, fields, register.size_bits, register_reset, writer);
        try writer.writeAll("}),\n");
    } else if (array_prefix.len != 0) {
        try writer.print("{f}: {s}u{},\n", .{
            std.zig.fmtId(register.name),
            array_prefix,
            register.size_bits,
        });
    } else {
        try writer.print("{f}: u{}", .{
            std.zig.fmtId(register.name),
            register.size_bits,
        });

        // Just assume non-masked areas are zero I guess
        if (register_reset) |rr| {
            const mask = (@as(u64, 1) << @intCast(register.size_bits)) - 1;
            try writer.print(" = 0x{X}", .{rr.value & mask});
        }

        try writer.writeAll(",\n");
    }

    try out_writer.writeAll(buf.written());
}

/// Determine if a field comes before another, i.e. has a lower bit offset in the register
/// (or should be preferred to another, if they incorrectly have the same offset).
fn field_comes_before(_: void, a: Database.StructField, b: Database.StructField) bool {
    return a.offset_bits < b.offset_bits or (a.offset_bits == b.offset_bits and a.size_bits < b.size_bits);
}

const RegisterReset = struct {
    mask: u64,
    value: u64,
};

fn get_field_default(field: Database.StructField, maybe_register_reset: ?RegisterReset) ?u64 {
    const register_reset = maybe_register_reset orelse return null;
    const field_mask: u64 = ((@as(u64, 1) << @intCast(field.size_bits)) - 1) << @intCast(field.offset_bits);
    if (@popCount(field_mask & register_reset.mask) != field.size_bits)
        return null;

    return (register_reset.value & field_mask) >> @intCast(field.offset_bits);
}

fn write_fields(
    db: *Database,
    arena: Allocator,
    fields: []const Database.StructField,
    register_size_bits: u64,
    register_reset: ?RegisterReset,
    out_writer: *std.Io.Writer,
) !void {
    // We first expand every 'array field' into its consituent fields,
    // named e.g. `@OISN[0]`, `@OISN[1]`, etc. for `field.name` OISN.
    var expanded_fields: std.ArrayList(Database.StructField) = .empty;
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
                try expanded_fields.append(arena, subfield);
            }
        } else try expanded_fields.append(arena, field);
    }
    // the 'count' and 'stride' of each entry of `expanded_fields` are never used below

    // Fields are not assumed to be in order of offset, but they often are,
    // so we use a stable sort algorithm that is fast on almost sorted data.
    // (One examples where fields are not in order, is with array fields that 'interleave',
    // where both have stride > size_bits: Above those are appended out of order.)
    std.sort.insertion(Database.StructField, expanded_fields.items, {}, field_comes_before);

    var buf: std.Io.Writer.Allocating = .init(arena);
    const writer = &buf.writer;

    var offset: u64 = 0;

    for (expanded_fields.items) |field| {
        log.debug("next field: offset={} field.offset_bits={}", .{ offset, field.offset_bits });
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
            if (e.size_bits != field.size_bits) {
                log.warn("{f}: fails to match the size of {s}, with sizes of {} and {} respectively. Not assigning type.", .{
                    enum_id, field.name, e.size_bits, field.size_bits,
                });
                try writer.print("{f}: u{},\n", .{ std.zig.fmtId(field.name), field.size_bits });
            } else if (e.name) |enum_name| {
                if (e.struct_id == null or try db.enum_has_name_collision(enum_id)) {
                    try writer.print(
                        \\{f}: enum(u{}) {{
                        \\
                    , .{
                        std.zig.fmtId(field.name),
                        e.size_bits,
                    });

                    try write_enum_fields(db, arena, &e, writer);
                    try writer.writeAll("}");
                } else {
                    try writer.print(
                        \\{f}:  {f}
                    , .{
                        std.zig.fmtId(field.name),
                        std.zig.fmtId(enum_name),
                    });
                }

                if (get_field_default(field, register_reset)) |default| {
                    try writer.writeAll(" = ");
                    try write_default_enum_value(db, arena, &e, default, writer);
                }

                try writer.writeAll(",\n");
            } else {
                try writer.print(
                    \\{f}: enum(u{}) {{
                    \\
                , .{
                    std.zig.fmtId(field.name),
                    e.size_bits,
                });

                try write_enum_fields(db, arena, &e, writer);
                try writer.writeAll("}");
                if (get_field_default(field, register_reset)) |default| {
                    try writer.writeAll(" = ");
                    try write_default_enum_value(db, arena, &e, default, writer);
                }

                try writer.writeAll(",\n");
            }
        } else {
            try writer.print("{f}: u{}", .{ std.zig.fmtId(field.name), field.size_bits });

            if (get_field_default(field, register_reset)) |default| {
                try writer.print(" = 0x{X}", .{default});
            }

            try writer.print(",\n", .{});
        }

        log.debug("adding size bits to offset: offset={} field.size_bits={}", .{ offset, field.size_bits });
        offset += field.size_bits;
    }

    log.debug("before padding: offset={} register_size_bits={}", .{ offset, register_size_bits });
    assert(offset <= register_size_bits);
    if (offset < register_size_bits) {
        log.debug("writing padding", .{});
        try writer.print("padding: u{} = 0,\n", .{register_size_bits - offset});
    } else {
        log.debug("No padding", .{});
    }

    try out_writer.writeAll(buf.written());
}

fn to_zero_sentinel(buf: []const u8) [:0]const u8 {
    return buf[0 .. buf.len - 1 :0];
}

fn process_properties(raw_props: []const Database.DeviceProperty) Properties {
    var properties: Properties = .{};

    for (raw_props) |prop| {
        if (std.mem.eql(u8, prop.key, "cpu.nvicPrioBits") or
            std.mem.eql(u8, prop.key, "__NVIC_PRIO_BITS"))
        {
            if (prop.value) |value| {
                properties.interrupt_priority_bits = std.fmt.parseInt(u8, value, 10) catch blk: {
                    log.warn("failed to parse `interrupt_priority_bits` property value: expected integer, got `{s}`", .{value});
                    break :blk null;
                };
            } else {
                log.warn("`interrupt_priority_bits` property candidate detected but it has no value", .{});
            }
        }

        if (std.mem.eql(u8, prop.key, "cpu.vtorPresent") or
            std.mem.eql(u8, prop.key, "__VTOR_PRESENT"))
        {
            if (prop.value) |value| {
                properties.has_vtor = raw_property_value_to_bool(value) catch blk: {
                    log.warn("failed to parse `has_vtor` property value: expected boolean, got `{s}`", .{value});
                    break :blk null;
                };
            } else {
                log.warn("`has_vtor` property candidate detected but it has no value", .{});
            }
        }

        if (std.mem.eql(u8, prop.key, "cpu.mpuPresent") or
            std.mem.eql(u8, prop.key, "__MPU_PRESENT"))
        {
            if (prop.value) |value| {
                properties.has_mpu = raw_property_value_to_bool(value) catch blk: {
                    log.warn("failed to interpret `has_mpu` property value: expected boolean, got `{s}`", .{value});
                    break :blk null;
                };
            } else {
                log.warn("`has_mpu` property candidate detected but it has no value", .{});
            }
        }

        if (std.mem.eql(u8, prop.key, "cpu.fpuPresent") or
            std.mem.eql(u8, prop.key, "__FPU_PRESENT"))
        {
            if (prop.value) |value| {
                properties.has_fpu = raw_property_value_to_bool(value) catch blk: {
                    log.warn("failed to interpret `has_fpu` property value: expected boolean, got `{s}`", .{value});
                    break :blk null;
                };
            } else {
                log.warn("`has_fpu` property candidate detected but it has no value", .{});
            }
        }
    }

    return properties;
}

fn raw_property_value_to_bool(value: []const u8) !bool {
    inline for (&.{ "false", "true" }, 0..) |str, i| {
        if (std.mem.eql(u8, value, str)) {
            return i == 1;
        }
    }

    inline for (&.{ "0", "1" }, 0..) |str, i| {
        if (std.mem.eql(u8, value, str)) {
            return i == 1;
        }
    }

    log.warn("failed to interpret `{s}` as bool", .{value});
    return error.BadValue;
}

const tests = @import("output_tests.zig");

fn expect_register(expected: *const Register, actual: *const Register) !void {
    try std.testing.expectEqual(expected.id, actual.id);
    try std.testing.expectEqual(expected.struct_id, actual.struct_id);
    try std.testing.expectEqualStrings(expected.name, actual.name);
    if (expected.description) |desc|
        try std.testing.expectEqual(desc, actual.description.?)
    else
        try std.testing.expectEqual(null, actual.description);
    try std.testing.expectEqual(expected.size_bits, actual.size_bits);
    try std.testing.expectEqual(expected.offset_bytes, actual.offset_bytes);
    try std.testing.expectEqual(expected.count, actual.count);
    try std.testing.expectEqual(expected.access, actual.access);
    try std.testing.expectEqual(expected.reset_mask, actual.reset_mask);
    try std.testing.expectEqual(expected.reset_value, actual.reset_value);
}

fn expect_nested_struct_field(expected: *const NestedStructField, actual: *const NestedStructField) !void {
    try std.testing.expectEqual(expected.parent_id, actual.parent_id);
    try std.testing.expectEqual(expected.struct_id, actual.struct_id);
    try std.testing.expectEqualStrings(expected.name, actual.name);
    if (expected.description) |desc|
        try std.testing.expectEqual(desc, actual.description.?)
    else
        try std.testing.expectEqual(null, actual.description);
    try std.testing.expectEqual(expected.size_bytes, actual.size_bytes);
    try std.testing.expectEqual(expected.offset_bytes, actual.offset_bytes);
    try std.testing.expectEqual(expected.count, actual.count);
}

test "gen.StructFieldIterator.single register" {
    const expected: Register = .{
        .id = @enumFromInt(1),
        .struct_id = @enumFromInt(1),
        .description = "This is a description",
        .name = "TEST_REGISTER",
        .size_bits = 32,
        .offset_bytes = 0,
        .access = .read_write,
        .reset_mask = 0xFF,
        .reset_value = 0xAA,
        .count = null,
    };

    var it: StructFieldIterator = .init(&.{expected}, &.{});
    const first = it.next();
    try std.testing.expect(first != null);

    const actual_tag: std.meta.Tag(@TypeOf(first.?)) = first.?;
    try std.testing.expectEqual(.register, actual_tag);

    const actual = first.?.register;
    try expect_register(&expected, &actual);
    try std.testing.expect(it.next() == null);
}

test "gen.StructFieldIterator.two registers perfect overlap" {
    const registers: []const Register = &.{
        .{
            .id = @enumFromInt(1),
            .struct_id = @enumFromInt(1),
            .description = "This is a description",
            .name = "TEST_REGISTER1",
            .size_bits = 32,
            .offset_bytes = 0,
            .access = .read_write,
            .reset_mask = 0xFF,
            .reset_value = 0xAA,
            .count = null,
        },
        .{
            .id = @enumFromInt(2),
            .struct_id = @enumFromInt(2),
            .description = "This is a description",
            .name = "TEST_REGISTER2",
            .size_bits = 32,
            .offset_bytes = 0,
            .access = .read_write,
            .reset_mask = 0xFF,
            .reset_value = 0xAA,
            .count = null,
        },
    };

    var it: StructFieldIterator = .init(registers, &.{});
    const first = it.next();
    try std.testing.expect(first != null);

    const actual_tag: std.meta.Tag(@TypeOf(first.?)) = first.?;
    try std.testing.expectEqual(.register, actual_tag);

    // The first one listed is chosen in this case
    const actual = first.?.register;
    try expect_register(&registers[0], &actual);
    try std.testing.expect(it.next() == null);
}

test "gen.StructFieldIterator.two registers overlap but one is smaller" {
    const registers: []const Register = &.{
        .{
            .id = @enumFromInt(1),
            .struct_id = @enumFromInt(1),
            .description = "This is a description",
            .name = "TEST_REGISTER1",
            .size_bits = 32,
            .offset_bytes = 0,
            .access = .read_write,
            .reset_mask = 0xFF,
            .reset_value = 0xAA,
            .count = null,
        },
        .{
            .id = @enumFromInt(2),
            .struct_id = @enumFromInt(2),
            .description = "This is a description",
            .name = "TEST_REGISTER2",
            .size_bits = 16,
            .offset_bytes = 0,
            .access = .read_write,
            .reset_mask = 0xFF,
            .reset_value = 0xAA,
            .count = null,
        },
    };

    var it: StructFieldIterator = .init(registers, &.{});
    const first = it.next();
    try std.testing.expect(first != null);

    const actual_tag: std.meta.Tag(@TypeOf(first.?)) = first.?;
    try std.testing.expectEqual(.register, actual_tag);

    // The first one listed is chosen in this case
    const actual = first.?.register;
    try expect_register(&registers[1], &actual);
    try std.testing.expect(it.next() == null);
}

test "gen.StructFieldIterator.two registers overlap with different offsets" {
    const registers: []const Register = &.{
        .{
            .id = @enumFromInt(1),
            .struct_id = @enumFromInt(1),
            .description = "This is a description",
            .name = "TEST_REGISTER1",
            .size_bits = 32,
            .offset_bytes = 0,
            .access = .read_write,
            .reset_mask = 0xFF,
            .reset_value = 0xAA,
            .count = null,
        },
        .{
            .id = @enumFromInt(2),
            .struct_id = @enumFromInt(2),
            .description = "This is a description",
            .name = "TEST_REGISTER2",
            .size_bits = 16,
            .offset_bytes = 2,
            .access = .read_write,
            .reset_mask = 0xFF,
            .reset_value = 0xAA,
            .count = null,
        },
    };

    var it: StructFieldIterator = .init(registers, &.{});
    const first = it.next();
    try std.testing.expect(first != null);

    const actual_tag: std.meta.Tag(@TypeOf(first.?)) = first.?;
    try std.testing.expectEqual(.register, actual_tag);

    // The first one listed is chosen in this case
    const actual = first.?.register;
    try expect_register(&registers[0], &actual);
    try std.testing.expect(it.next() == null);
}

test "gen.StructFieldIterator.one nested struct field" {
    const expected = NestedStructField{
        .parent_id = @enumFromInt(1),
        .struct_id = @enumFromInt(2),
        .offset_bytes = 0,
        .name = "TEST_NESTED",
        .description = "a desc",
        .count = null,
        .size_bytes = 8,
    };

    var it: StructFieldIterator = .init(&.{}, &.{expected});
    const first = it.next();
    try std.testing.expect(first != null);

    const actual_tag: std.meta.Tag(@TypeOf(first.?)) = first.?;
    try std.testing.expectEqual(.nested_struct_field, actual_tag);

    const actual = first.?.nested_struct_field;
    try expect_nested_struct_field(&expected, &actual);
    try std.testing.expect(it.next() == null);
}

test "gen.StructFieldIterator.one nested struct field and a register" {
    const expected_register: Register = .{
        .id = @enumFromInt(1),
        .struct_id = @enumFromInt(3),
        .description = "This is a description",
        .name = "TEST_REGISTER",
        .size_bits = 32,
        .offset_bytes = 0,
        .access = .read_write,
        .reset_mask = 0xFF,
        .reset_value = 0xAA,
        .count = null,
    };

    const expected_nsf = NestedStructField{
        .parent_id = @enumFromInt(1),
        .struct_id = @enumFromInt(2),
        .offset_bytes = 8,
        .name = "TEST_NESTED",
        .description = "a desc",
        .count = null,
        .size_bytes = 8,
    };

    var it: StructFieldIterator = .init(&.{expected_register}, &.{expected_nsf});

    // First result is a register
    const first = it.next();
    try std.testing.expect(first != null);

    const register_tag: std.meta.Tag(@TypeOf(first.?)) = first.?;
    try std.testing.expectEqual(.register, register_tag);

    const actual_register = first.?.register;
    try expect_register(&expected_register, &actual_register);

    // Second result is some reserved bytes
    const second = it.next();
    try std.testing.expect(second != null);

    const reserved_tag: std.meta.Tag(@TypeOf(second.?)) = second.?;
    try std.testing.expectEqual(.reserved, reserved_tag);

    const actual_reserved = second.?.reserved;
    try std.testing.expectEqual(4, actual_reserved.offset_bytes);
    try std.testing.expectEqual(4, actual_reserved.size_bytes);

    // Third result is a nested struct field
    const third = it.next();
    try std.testing.expect(third != null);

    const nsf_tag: std.meta.Tag(@TypeOf(third.?)) = third.?;
    try std.testing.expectEqual(.nested_struct_field, nsf_tag);

    const actual_nsf = third.?.nested_struct_field;
    try expect_nested_struct_field(&expected_nsf, &actual_nsf);

    try std.testing.expect(it.next() == null);
}

const ExpectedOutput = struct {
    path: []const u8,
    content: []const u8,
};

fn expect_output(expected_outputs: []const ExpectedOutput, vfs: *VirtualFilesystem) !void {
    try std.testing.expectEqual(expected_outputs.len, vfs.files.count());
    for (expected_outputs) |eo| {
        const file_id = try vfs.get_file(eo.path) orelse unreachable;
        try std.testing.expectEqualStrings(eo.content, vfs.get_content(file_id));
    }
}

test "gen.peripheral instantiation" {
    var db = try tests.peripheral_instantiation(std.testing.allocator);
    defer db.destroy();

    var buffer: std.Io.Writer.Allocating = .init(std.testing.allocator);
    defer buffer.deinit();

    var vfs: VirtualFilesystem = .init(std.testing.allocator);
    defer vfs.deinit();

    try db.to_zig(vfs.dir(), .{});
    try expect_output(&.{
        .{
            .path = "TEST_DEVICE.zig",
            .content =
            \\const microzig = @import("microzig");
            \\const mmio = microzig.mmio;
            \\
            \\pub const types = @import("types.zig");
            \\
            \\pub const Properties = struct {
            \\    has_vtor: ?bool = null,
            \\    has_mpu: ?bool = null,
            \\    has_fpu: ?bool = null,
            \\    interrupt_priority_bits: ?u8 = null,
            \\};
            \\
            \\pub const Interrupt = struct {
            \\    name: [:0]const u8,
            \\    index: i16,
            \\    description: ?[:0]const u8,
            \\};
            \\
            \\pub const properties: Properties = .{
            \\    .has_vtor = null,
            \\    .has_mpu = null,
            \\    .has_fpu = null,
            \\    .interrupt_priority_bits = null,
            \\};
            \\
            \\pub const peripherals = struct {
            \\    pub const TEST0: *volatile types.peripherals.TEST_PERIPHERAL = @ptrFromInt(0x1000);
            \\};
            \\
            ,
        },
        .{
            .path = "types.zig",
            .content =
            \\pub const peripherals = @import("types/peripherals.zig");
            \\
            ,
        },
        .{
            .path = "peripherals.zig",
            .content =
            \\pub const TEST_PERIPHERAL = @import("peripherals/TEST_PERIPHERAL.zig").TEST_PERIPHERAL;
            \\
            ,
        },
        .{
            .path = "peripherals/TEST_PERIPHERAL.zig",
            .content =
            \\const microzig = @import("microzig");
            \\const mmio = microzig.mmio;
            \\
            \\const types = @import("../../types.zig");
            \\
            \\pub const TEST_PERIPHERAL = extern struct {
            \\    /// offset: 0x00
            \\    TEST_REGISTER: mmio.Mmio(packed struct(u32) {
            \\        TEST_FIELD: u1 = 0x1,
            \\        padding: u31 = 0,
            \\    }),
            \\};
            \\
            ,
        },
    }, &vfs);
}

test "gen.peripherals with a shared type" {
    var db = try tests.peripherals_with_shared_type(std.testing.allocator);
    defer db.destroy();

    var buffer: std.Io.Writer.Allocating = .init(std.testing.allocator);
    defer buffer.deinit();

    var vfs: VirtualFilesystem = .init(std.testing.allocator);
    defer vfs.deinit();

    try db.to_zig(vfs.dir(), .{});
    try expect_output(&.{
        .{
            .path = "TEST_DEVICE.zig",
            .content =
            \\const microzig = @import("microzig");
            \\const mmio = microzig.mmio;
            \\
            \\pub const types = @import("types.zig");
            \\
            \\pub const Properties = struct {
            \\    has_vtor: ?bool = null,
            \\    has_mpu: ?bool = null,
            \\    has_fpu: ?bool = null,
            \\    interrupt_priority_bits: ?u8 = null,
            \\};
            \\
            \\pub const Interrupt = struct {
            \\    name: [:0]const u8,
            \\    index: i16,
            \\    description: ?[:0]const u8,
            \\};
            \\
            \\pub const properties: Properties = .{
            \\    .has_vtor = null,
            \\    .has_mpu = null,
            \\    .has_fpu = null,
            \\    .interrupt_priority_bits = null,
            \\};
            \\
            \\pub const peripherals = struct {
            \\    pub const TEST0: *volatile types.peripherals.TEST_PERIPHERAL = @ptrFromInt(0x1000);
            \\    pub const TEST1: *volatile types.peripherals.TEST_PERIPHERAL = @ptrFromInt(0x2000);
            \\};
            \\
            ,
        },
        .{
            .path = "types.zig",
            .content =
            \\pub const peripherals = @import("types/peripherals.zig");
            \\
            ,
        },
        .{
            .path = "peripherals.zig",
            .content =
            \\pub const TEST_PERIPHERAL = @import("peripherals/TEST_PERIPHERAL.zig").TEST_PERIPHERAL;
            \\
            ,
        },
        .{
            .path = "peripherals/TEST_PERIPHERAL.zig",
            .content =
            \\const microzig = @import("microzig");
            \\const mmio = microzig.mmio;
            \\
            \\const types = @import("../../types.zig");
            \\
            \\pub const TEST_PERIPHERAL = extern struct {
            \\    /// offset: 0x00
            \\    TEST_REGISTER: mmio.Mmio(packed struct(u32) {
            \\        TEST_FIELD: u1,
            \\        padding: u31 = 0,
            \\    }),
            \\};
            \\
            ,
        },
    }, &vfs);
}

//test "gen.peripheral with modes" {
//    var db = try tests.peripheral_with_modes(std.testing.allocator);
//    defer db.destroy();
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        pub const TEST_PERIPHERAL = extern union {
//        \\            pub const Mode = enum {
//        \\                TEST_MODE1,
//        \\                TEST_MODE2,
//        \\            };
//        \\
//        \\            pub fn get_mode(self: *volatile @This()) Mode {
//        \\                {
//        \\                    const value = self.TEST_MODE1.COMMON_REGISTER.read().TEST_FIELD;
//        \\                    switch (value) {
//        \\                        0,
//        \\                        => return .TEST_MODE1,
//        \\                        else => {},
//        \\                    }
//        \\                }
//        \\                {
//        \\                    const value = self.TEST_MODE2.COMMON_REGISTER.read().TEST_FIELD;
//        \\                    switch (value) {
//        \\                        1,
//        \\                        => return .TEST_MODE2,
//        \\                        else => {},
//        \\                    }
//        \\                }
//        \\
//        \\                unreachable;
//        \\            }
//        \\
//        \\            TEST_MODE1: extern struct {
//        \\                /// offset: 0x00
//        \\                TEST_REGISTER1: u32,
//        \\                /// offset: 0x04
//        \\                COMMON_REGISTER: mmio.Mmio(packed struct(u32) {
//        \\                    TEST_FIELD: u1,
//        \\                    padding: u31 = 0,
//        \\                }),
//        \\            },
//        \\            TEST_MODE2: extern struct {
//        \\                /// offset: 0x00
//        \\                TEST_REGISTER2: u32,
//        \\                /// offset: 0x04
//        \\                COMMON_REGISTER: mmio.Mmio(packed struct(u32) {
//        \\                    TEST_FIELD: u1,
//        \\                    padding: u31 = 0,
//        \\                }),
//        \\            },
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}

//test "gen.peripheral with enum" {
//    var db = try tests.peripheral_with_enum(std.testing.allocator);
//    defer db.destroy();
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        pub const TEST_PERIPHERAL = extern struct {
//        \\            pub const TEST_ENUM = enum(u4) {
//        \\                TEST_ENUM_FIELD1 = 0x0,
//        \\                TEST_ENUM_FIELD2 = 0x1,
//        \\                _,
//        \\            };
//        \\
//        \\            /// offset: 0x00
//        \\            TEST_REGISTER: u8,
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
//
//test "gen.peripheral with enum, enum is exhausted of values" {
//    var db = try tests.peripheral_with_enum_and_its_exhausted_of_values(std.testing.allocator);
//    defer db.destroy();
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        pub const TEST_PERIPHERAL = extern struct {
//        \\            pub const TEST_ENUM = enum(u1) {
//        \\                TEST_ENUM_FIELD1 = 0x0,
//        \\                TEST_ENUM_FIELD2 = 0x1,
//        \\            };
//        \\
//        \\            /// offset: 0x00
//        \\            TEST_REGISTER: u8,
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
//
test "gen.field with named enum" {
    var db = try tests.field_with_named_enum(std.testing.allocator);
    defer db.destroy();

    var buffer: std.Io.Writer.Allocating = .init(std.testing.allocator);
    defer buffer.deinit();

    var vfs: VirtualFilesystem = .init(std.testing.allocator);
    defer vfs.deinit();

    try db.to_zig(vfs.dir(), .{});
    try expect_output(&.{
        .{
            .path = "types.zig",
            .content =
            \\pub const peripherals = @import("types/peripherals.zig");
            \\
            ,
        },
        .{
            .path = "peripherals.zig",
            .content =
            \\pub const TEST_PERIPHERAL = @import("peripherals/TEST_PERIPHERAL.zig").TEST_PERIPHERAL;
            \\
            ,
        },
        .{
            .path = "peripherals/TEST_PERIPHERAL.zig",
            .content =
            \\const microzig = @import("microzig");
            \\const mmio = microzig.mmio;
            \\
            \\const types = @import("../../types.zig");
            \\
            \\pub const TEST_PERIPHERAL = extern struct {
            \\    pub const TEST_ENUM = enum(u4) {
            \\        TEST_ENUM_FIELD1 = 0x0,
            \\        TEST_ENUM_FIELD2 = 0x1,
            \\        _,
            \\    };
            \\
            \\    /// offset: 0x00
            \\    TEST_REGISTER: mmio.Mmio(packed struct(u8) {
            \\        TEST_FIELD: TEST_ENUM,
            \\        padding: u4 = 0,
            \\    }),
            \\};
            \\
            ,
        },
    }, &vfs);
}

test "gen.field with named enum and named default" {
    var db = try tests.field_with_named_enum_and_named_default(std.testing.allocator);
    defer db.destroy();

    var buffer: std.Io.Writer.Allocating = .init(std.testing.allocator);
    defer buffer.deinit();

    var vfs: VirtualFilesystem = .init(std.testing.allocator);
    defer vfs.deinit();

    try db.to_zig(vfs.dir(), .{});
    try expect_output(&.{
        .{
            .path = "types.zig",
            .content =
            \\pub const peripherals = @import("types/peripherals.zig");
            \\
            ,
        },
        .{
            .path = "peripherals.zig",
            .content =
            \\pub const TEST_PERIPHERAL = @import("peripherals/TEST_PERIPHERAL.zig").TEST_PERIPHERAL;
            \\
            ,
        },
        .{
            .path = "peripherals/TEST_PERIPHERAL.zig",
            .content =
            \\const microzig = @import("microzig");
            \\const mmio = microzig.mmio;
            \\
            \\const types = @import("../../types.zig");
            \\
            \\pub const TEST_PERIPHERAL = extern struct {
            \\    pub const TEST_ENUM = enum(u4) {
            \\        TEST_ENUM_FIELD1 = 0x0,
            \\        TEST_ENUM_FIELD2 = 0x1,
            \\        _,
            \\    };
            \\
            \\    /// offset: 0x00
            \\    TEST_REGISTER: mmio.Mmio(packed struct(u8) {
            \\        TEST_FIELD: TEST_ENUM = .TEST_ENUM_FIELD2,
            \\        padding: u4 = 0,
            \\    }),
            \\};
            \\
            ,
        },
    }, &vfs);
}

test "gen.field with named enum and unnamed default" {
    var db = try tests.field_with_named_enum_and_unnamed_default(std.testing.allocator);
    defer db.destroy();

    var buffer: std.Io.Writer.Allocating = .init(std.testing.allocator);
    defer buffer.deinit();

    var vfs: VirtualFilesystem = .init(std.testing.allocator);
    defer vfs.deinit();

    try db.to_zig(vfs.dir(), .{});
    try expect_output(&.{
        .{
            .path = "types.zig",
            .content =
            \\pub const peripherals = @import("types/peripherals.zig");
            \\
            ,
        },
        .{
            .path = "peripherals.zig",
            .content =
            \\pub const TEST_PERIPHERAL = @import("peripherals/TEST_PERIPHERAL.zig").TEST_PERIPHERAL;
            \\
            ,
        },
        .{
            .path = "peripherals/TEST_PERIPHERAL.zig",
            .content =
            \\const microzig = @import("microzig");
            \\const mmio = microzig.mmio;
            \\
            \\const types = @import("../../types.zig");
            \\
            \\pub const TEST_PERIPHERAL = extern struct {
            \\    pub const TEST_ENUM = enum(u4) {
            \\        TEST_ENUM_FIELD1 = 0x0,
            \\        TEST_ENUM_FIELD2 = 0x1,
            \\        _,
            \\    };
            \\
            \\    /// offset: 0x00
            \\    TEST_REGISTER: mmio.Mmio(packed struct(u8) {
            \\        TEST_FIELD: TEST_ENUM = @enumFromInt(0xA),
            \\        padding: u4 = 0,
            \\    }),
            \\};
            \\
            ,
        },
    }, &vfs);
}

test "gen.field with anonymous enum" {
    var db = try tests.field_with_anonymous_enum(std.testing.allocator);
    defer db.destroy();

    var buffer: std.Io.Writer.Allocating = .init(std.testing.allocator);
    defer buffer.deinit();

    var vfs: VirtualFilesystem = .init(std.testing.allocator);
    defer vfs.deinit();

    try db.to_zig(vfs.dir(), .{});
    try expect_output(&.{
        .{
            .path = "types.zig",
            .content =
            \\pub const peripherals = @import("types/peripherals.zig");
            \\
            ,
        },
        .{
            .path = "peripherals.zig",
            .content =
            \\pub const TEST_PERIPHERAL = @import("peripherals/TEST_PERIPHERAL.zig").TEST_PERIPHERAL;
            \\
            ,
        },
        .{
            .path = "peripherals/TEST_PERIPHERAL.zig",
            .content =
            \\const microzig = @import("microzig");
            \\const mmio = microzig.mmio;
            \\
            \\const types = @import("../../types.zig");
            \\
            \\pub const TEST_PERIPHERAL = extern struct {
            \\    /// offset: 0x00
            \\    TEST_REGISTER: mmio.Mmio(packed struct(u8) {
            \\        TEST_FIELD: enum(u4) {
            \\            TEST_ENUM_FIELD1 = 0x0,
            \\            TEST_ENUM_FIELD2 = 0x1,
            \\            _,
            \\        },
            \\        padding: u4 = 0,
            \\    }),
            \\};
            \\
            ,
        },
    }, &vfs);
}

test "gen.field with anonymous enum and default" {
    var db = try tests.field_with_anonymous_enum_and_default(std.testing.allocator);
    defer db.destroy();

    var buffer: std.Io.Writer.Allocating = .init(std.testing.allocator);
    defer buffer.deinit();

    var vfs: VirtualFilesystem = .init(std.testing.allocator);
    defer vfs.deinit();

    try db.to_zig(vfs.dir(), .{});
    try expect_output(&.{
        .{
            .path = "types.zig",
            .content =
            \\pub const peripherals = @import("types/peripherals.zig");
            \\
            ,
        },
        .{
            .path = "peripherals.zig",
            .content =
            \\pub const TEST_PERIPHERAL = @import("peripherals/TEST_PERIPHERAL.zig").TEST_PERIPHERAL;
            \\
            ,
        },
        .{
            .path = "peripherals/TEST_PERIPHERAL.zig",
            .content =
            \\const microzig = @import("microzig");
            \\const mmio = microzig.mmio;
            \\
            \\const types = @import("../../types.zig");
            \\
            \\pub const TEST_PERIPHERAL = extern struct {
            \\    /// offset: 0x00
            \\    TEST_REGISTER: mmio.Mmio(packed struct(u8) {
            \\        TEST_FIELD: enum(u4) {
            \\            TEST_ENUM_FIELD1 = 0x0,
            \\            TEST_ENUM_FIELD2 = 0x1,
            \\            _,
            \\        } = .TEST_ENUM_FIELD2,
            \\        padding: u4 = 0,
            \\    }),
            \\};
            \\
            ,
        },
    }, &vfs);
}

//test "gen.namespaced register groups" {
//    var db = try tests.namespaced_register_groups(std.testing.allocator);
//    defer db.destroy();
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const devices = struct {
//        \\    pub const ATmega328P = struct {
//        \\        pub const peripherals = struct {
//        \\            pub const PORTB: *volatile types.peripherals.PORT.PORTB = @ptrFromInt(0x23);
//        \\            pub const PORTC: *volatile types.peripherals.PORT.PORTC = @ptrFromInt(0x26);
//        \\        };
//        \\    };
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        pub const PORT = struct {
//        \\            pub const PORTB = extern struct {
//        \\                /// offset: 0x00
//        \\                PORTB: u8,
//        \\                /// offset: 0x01
//        \\                DDRB: u8,
//        \\                /// offset: 0x02
//        \\                PINB: u8,
//        \\            };
//        \\
//        \\            pub const PORTC = extern struct {
//        \\                /// offset: 0x00
//        \\                PORTC: u8,
//        \\                /// offset: 0x01
//        \\                DDRC: u8,
//        \\                /// offset: 0x02
//        \\                PINC: u8,
//        \\            };
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
//
//test "gen.peripheral with reserved register" {
//    var db = try tests.peripheral_with_reserved_register(std.testing.allocator);
//    defer db.destroy();
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const devices = struct {
//        \\    pub const ATmega328P = struct {
//        \\        pub const peripherals = struct {
//        \\            pub const PORTB: *volatile types.peripherals.PORTB = @ptrFromInt(0x23);
//        \\        };
//        \\    };
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        pub const PORTB = extern struct {
//        \\            /// offset: 0x00
//        \\            PORTB: u32,
//        \\            /// offset: 0x04
//        \\            reserved4: [4]u8,
//        \\            /// offset: 0x08
//        \\            PINB: u32,
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
//
//test "gen.peripheral with count" {
//    var db = try tests.peripheral_with_count(std.testing.allocator);
//    defer db.destroy();
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const devices = struct {
//        \\    pub const ATmega328P = struct {
//        \\        pub const peripherals = struct {
//        \\            pub const PORTB: *volatile [4]types.peripherals.PORTB = @ptrFromInt(0x23);
//        \\        };
//        \\    };
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        pub const PORTB = extern struct {
//        \\            /// offset: 0x00
//        \\            PORTB: u8,
//        \\            /// offset: 0x01
//        \\            DDRB: u8,
//        \\            /// offset: 0x02
//        \\            PINB: u8,
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
//
//test "gen.peripheral with count, padding required" {
//    var db = try tests.peripheral_with_count_padding_required(std.testing.allocator);
//    defer db.destroy();
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const devices = struct {
//        \\    pub const ATmega328P = struct {
//        \\        pub const peripherals = struct {
//        \\            pub const PORTB: *volatile [4]types.peripherals.PORTB = @ptrFromInt(0x23);
//        \\        };
//        \\    };
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        pub const PORTB = extern struct {
//        \\            /// offset: 0x00
//        \\            PORTB: u8,
//        \\            /// offset: 0x01
//        \\            DDRB: u8,
//        \\            /// offset: 0x02
//        \\            PINB: u8,
//        \\            padding: [1]u8,
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
//
//test "gen.register with count" {
//    var db = try tests.register_with_count(std.testing.allocator);
//    defer db.destroy();
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const devices = struct {
//        \\    pub const ATmega328P = struct {
//        \\        pub const peripherals = struct {
//        \\            pub const PORTB: *volatile types.peripherals.PORTB = @ptrFromInt(0x23);
//        \\        };
//        \\    };
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        pub const PORTB = extern struct {
//        \\            /// offset: 0x00
//        \\            PORTB: [4]u8,
//        \\            /// offset: 0x04
//        \\            DDRB: u8,
//        \\            /// offset: 0x05
//        \\            PINB: u8,
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
//
//test "gen.register with count and fields" {
//    var db = try tests.register_with_count_and_fields(std.testing.allocator);
//    defer db.destroy();
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const devices = struct {
//        \\    pub const ATmega328P = struct {
//        \\        pub const peripherals = struct {
//        \\            pub const PORTB: *volatile types.peripherals.PORTB = @ptrFromInt(0x23);
//        \\        };
//        \\    };
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        pub const PORTB = extern struct {
//        \\            /// offset: 0x00
//        \\            PORTB: [4]mmio.Mmio(packed struct(u8) {
//        \\                TEST_FIELD: u4,
//        \\                padding: u4 = 0,
//        \\            }),
//        \\            /// offset: 0x04
//        \\            DDRB: u8,
//        \\            /// offset: 0x05
//        \\            PINB: u8,
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
//
//test "gen.field with count, width of one, offset, and padding" {
//    var db = try tests.field_with_count_width_of_one_offset_and_padding(std.testing.allocator);
//    defer db.destroy();
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        pub const PORTB = extern struct {
//        \\            /// offset: 0x00
//        \\            PORTB: mmio.Mmio(packed struct(u8) {
//        \\                reserved2: u2 = 0,
//        \\                TEST_FIELD0: u1,
//        \\                TEST_FIELD1: u1,
//        \\                TEST_FIELD2: u1,
//        \\                TEST_FIELD3: u1,
//        \\                TEST_FIELD4: u1,
//        \\                padding: u1 = 0,
//        \\            }),
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
//
//test "gen.field with count, multi-bit width, offset, and padding" {
//    var db = try tests.field_with_count_multi_bit_width_offset_and_padding(std.testing.allocator);
//    defer db.destroy();
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        pub const PORTB = extern struct {
//        \\            /// offset: 0x00
//        \\            PORTB: mmio.Mmio(packed struct(u8) {
//        \\                reserved2: u2 = 0,
//        \\                TEST_FIELD0: u2,
//        \\                TEST_FIELD1: u2,
//        \\                padding: u2 = 0,
//        \\            }),
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
//
//test "gen.interrupts.avr" {
//    var db = try tests.interrupts_avr(std.testing.allocator);
//    defer db.destroy();
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const devices = struct {
//        \\    pub const ATmega328P = struct {
//        \\        pub const interrupts: []const Interrupt = &.{
//        \\            .{ .name = "TEST_VECTOR1", .index = 1, .description = null },
//        \\            .{ .name = "TEST_VECTOR2", .index = 3, .description = null },
//        \\        };
//        \\
//        \\        pub const VectorTable = extern struct {
//        \\            const Handler = microzig.interrupt.Handler;
//        \\            const unhandled = microzig.interrupt.unhandled;
//        \\
//        \\            RESET: Handler,
//        \\            TEST_VECTOR1: Handler = unhandled,
//        \\            reserved2: [1]u16 = undefined,
//        \\            TEST_VECTOR2: Handler = unhandled,
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
//
//test "gen.peripheral type with register and field" {
//    var db = try tests.peripheral_type_with_register_and_field(std.testing.allocator);
//    defer db.destroy();
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        /// test peripheral
//        \\        pub const TEST_PERIPHERAL = extern struct {
//        \\            /// test register
//        \\            /// offset: 0x00
//        \\            TEST_REGISTER: mmio.Mmio(packed struct(u32) {
//        \\                /// test field
//        \\                TEST_FIELD: u1,
//        \\                padding: u31 = 0,
//        \\            }),
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
//
//test "gen.name collisions in enum name cause them to be anonymous" {
//    var db = try tests.enums_with_name_collision(std.testing.allocator);
//    defer db.destroy();
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        pub const TEST_PERIPHERAL = extern struct {
//        \\            /// offset: 0x00
//        \\            TEST_REGISTER: mmio.Mmio(packed struct(u8) {
//        \\                TEST_FIELD1: enum(u4) {
//        \\                    TEST_ENUM_FIELD1 = 0x0,
//        \\                    TEST_ENUM_FIELD2 = 0x1,
//        \\                    _,
//        \\                },
//        \\                TEST_FIELD2: enum(u4) {
//        \\                    TEST_ENUM_FIELD1 = 0x0,
//        \\                    TEST_ENUM_FIELD2 = 0x1,
//        \\                    _,
//        \\                },
//        \\            }),
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
//
//test "gen.pick one enum field in value collisions" {
//    var db = try tests.enum_with_value_collision(std.testing.allocator);
//    defer db.destroy();
//
//    try db.backup("value_collision.regz");
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        pub const TEST_PERIPHERAL = extern struct {
//        \\            /// offset: 0x00
//        \\            TEST_REGISTER: mmio.Mmio(packed struct(u8) {
//        \\                TEST_FIELD: enum(u4) {
//        \\                    TEST_ENUM_FIELD1 = 0x0,
//        \\                    _,
//        \\                },
//        \\                padding: u4 = 0,
//        \\            }),
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
//
//test "gen.pick one enum field in name collisions" {
//    var db = try tests.enum_fields_with_name_collision(std.testing.allocator);
//    defer db.destroy();
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        pub const TEST_PERIPHERAL = extern struct {
//        \\            /// offset: 0x00
//        \\            TEST_REGISTER: mmio.Mmio(packed struct(u8) {
//        \\                TEST_FIELD: enum(u4) {
//        \\                    TEST_ENUM_FIELD1 = 0x0,
//        \\                    _,
//        \\                },
//        \\                padding: u4 = 0,
//        \\            }),
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
//
//test "gen.register fields with name collision" {
//    var db = try tests.register_fields_with_name_collision(std.testing.allocator);
//    defer db.destroy();
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        /// test peripheral
//        \\        pub const TEST_PERIPHERAL = extern struct {
//        \\            /// test register
//        \\            /// offset: 0x00
//        \\            TEST_REGISTER: mmio.Mmio(packed struct(u32) {
//        \\                /// test field 1
//        \\                TEST_FIELD: u1,
//        \\                padding: u31 = 0,
//        \\            }),
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
//
//test "gen.nested struct field in a peripheral" {
//    var db = try tests.nested_struct_field_in_a_peripheral(std.testing.allocator, 0);
//    defer db.destroy();
//
//    try db.backup("nested_struct_field_in_a_peripheral.regz");
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        /// test peripheral
//        \\        pub const TEST_PERIPHERAL = extern struct {
//        \\            /// test nested struct
//        \\            /// offset: 0x00
//        \\            TEST_NESTED: extern struct {
//        \\                /// test register
//        \\                /// offset: 0x00
//        \\                TEST_REGISTER: mmio.Mmio(packed struct(u32) {
//        \\                    /// test field 1
//        \\                    TEST_FIELD: u1,
//        \\                    padding: u31 = 0,
//        \\                }),
//        \\            },
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
//
//test "gen.nested struct field in a peripheral that has a named type" {
//    var db = try tests.nested_struct_field_in_a_peripheral_that_has_a_named_type(std.testing.allocator, 0);
//    defer db.destroy();
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        /// test peripheral
//        \\        pub const TEST_PERIPHERAL = extern struct {
//        \\            pub const TEST_NESTED_TYPE = extern struct {
//        \\                /// test register
//        \\                /// offset: 0x00
//        \\                TEST_REGISTER: mmio.Mmio(packed struct(u32) {
//        \\                    /// test field 1
//        \\                    TEST_FIELD: u1,
//        \\                    padding: u31 = 0,
//        \\                }),
//        \\            };
//        \\
//        \\            /// test nested struct
//        \\            /// offset: 0x00
//        \\            TEST_NESTED: TEST_NESTED_TYPE,
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
//
//test "gen.nested struct field in a peripheral with offset" {
//    var db = try tests.nested_struct_field_in_a_peripheral(std.testing.allocator, 4);
//    defer db.destroy();
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        /// test peripheral
//        \\        pub const TEST_PERIPHERAL = extern struct {
//        \\            /// offset: 0x00
//        \\            reserved0: [4]u8,
//        \\            /// test nested struct
//        \\            /// offset: 0x04
//        \\            TEST_NESTED: extern struct {
//        \\                /// test register
//        \\                /// offset: 0x00
//        \\                TEST_REGISTER: mmio.Mmio(packed struct(u32) {
//        \\                    /// test field 1
//        \\                    TEST_FIELD: u1,
//        \\                    padding: u31 = 0,
//        \\                }),
//        \\            },
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
//
//test "gen.nested struct field in nested struct field" {
//    var db = try tests.nested_struct_field_in_a_nested_struct_field(std.testing.allocator);
//    defer db.destroy();
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        /// test peripheral
//        \\        pub const TEST_PERIPHERAL = extern struct {
//        \\            /// test nested struct
//        \\            /// offset: 0x00
//        \\            TEST_NESTED: extern struct {
//        \\                /// offset: 0x00
//        \\                TEST_NESTED_NESTED: extern struct {
//        \\                    /// test register
//        \\                    /// offset: 0x00
//        \\                    TEST_REGISTER: mmio.Mmio(packed struct(u32) {
//        \\                        /// test field 1
//        \\                        TEST_FIELD: u1,
//        \\                        padding: u31 = 0,
//        \\                    }),
//        \\                },
//        \\            },
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
//
//test "gen.nested struct field next to register" {
//    var db = try tests.nested_struct_field_next_to_register(std.testing.allocator);
//    defer db.destroy();
//
//    var buffer = std.array_list.Managed(u8).init(std.testing.allocator);
//    defer buffer.deinit();
//
//    try db.to_zig(buffer.writer(), .{ .for_microzig = true });
//    try std.testing.expectEqualStrings(
//        \\const microzig = @import("microzig");
//        \\const mmio = microzig.mmio;
//        \\
//        \\pub const Interrupt = struct {
//        \\    name: [:0]const u8,
//        \\    index: i16,
//        \\    description: ?[:0]const u8,
//        \\};
//        \\
//        \\pub const types = struct {
//        \\    pub const peripherals = struct {
//        \\        /// test peripheral
//        \\        pub const TEST_PERIPHERAL = extern struct {
//        \\            pub const TEST_NESTED_TYPE = extern struct {
//        \\                /// test register
//        \\                /// offset: 0x00
//        \\                TEST_REGISTER: mmio.Mmio(packed struct(u32) {
//        \\                    /// test field 1
//        \\                    TEST_FIELD: u1,
//        \\                    padding: u31 = 0,
//        \\                }),
//        \\            };
//        \\
//        \\            /// test nested struct
//        \\            /// offset: 0x00
//        \\            TEST_NESTED: TEST_NESTED_TYPE,
//        \\            /// test register
//        \\            /// offset: 0x04
//        \\            TEST_REGISTER: mmio.Mmio(packed struct(u32) {
//        \\                /// test field 1
//        \\                TEST_FIELD: u1,
//        \\                padding: u31 = 0,
//        \\            }),
//        \\        };
//        \\    };
//        \\};
//        \\
//    , buffer.items);
//}
