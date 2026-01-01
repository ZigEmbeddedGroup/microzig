gpa: Allocator,
conn: zqlite.Conn,

const Database = @This();
const std = @import("std");
const Allocator = std.mem.Allocator;
const assert = std.debug.assert;

const zqlite = @import("zqlite");
const c = zqlite.c;

const xml = @import("xml.zig");
const svd = @import("svd.zig");
const atdf = @import("atdf.zig");
const embassy = @import("embassy.zig");
const gen = @import("gen.zig");
const Patch = @import("patch.zig").Patch;
const SQL_Options = @import("SQL_Options.zig");
const Arch = @import("arch.zig").Arch;
pub const Directory = @import("Directory.zig");

const log = std.log.scoped(.db);
const file_size_max = 100 * 1024 * 1024;

// Actual instances will have "Instance" in the type name for the ID
pub const DeviceID = ID(u32, "devices");
pub const InterruptID = ID(u32, "interrupts");
pub const DevicePeripheralID = ID(u32, "device_peripherals");

// Lots of operations use types so we omit "Type" in the type name for the ID
pub const PeripheralID = ID(u32, "peripherals");
pub const EnumID = ID(u32, "enums");
pub const RegisterID = ID(u32, "registers");
pub const ModeID = ID(u32, "modes");
pub const StructID = ID(u32, "structs");

pub const Device = struct {
    id: DeviceID,
    name: []const u8,
    description: ?[]const u8,
    arch: Arch,

    pub const sql_opts = SQL_Options{
        .primary_key = .{ .name = "id", .autoincrement = true },
    };
};

pub const DevicePeripheral = struct {
    id: DevicePeripheralID,
    name: []const u8,
    description: ?[]const u8,
    device_id: DeviceID,
    offset_bytes: u64,
    count: ?u64,
    struct_id: StructID,

    pub const sql_opts = SQL_Options{
        .primary_key = .{ .name = "id", .autoincrement = true },
        .foreign_keys = &.{
            .{ .name = "struct_id", .on_delete = .cascade, .on_update = .cascade },
        },
    };
};

pub const Mode = struct {
    id: ModeID,
    struct_id: StructID,
    name: []const u8,
    description: ?[]const u8,
    value: []const u8,
    qualifier: []const u8,

    pub const sql_opts = SQL_Options{
        .primary_key = .{ .name = "id", .autoincrement = true },
        .foreign_keys = &.{
            .{ .name = "struct_id", .on_delete = .cascade, .on_update = .cascade },
        },
    };
};

pub const Interrupt = struct {
    id: InterruptID,
    device_id: DeviceID,
    name: []const u8,
    description: ?[]const u8,
    idx: i32,

    pub const sql_opts = SQL_Options{
        .primary_key = .{ .name = "id", .autoincrement = true },
        .foreign_keys = &.{
            .{ .name = "device_id", .on_delete = .cascade, .on_update = .cascade },
        },
    };

    pub fn deinit(interrupt: *const Interrupt, allocator: Allocator) void {
        if (interrupt.description) |desc|
            allocator.free(desc);

        allocator.free(interrupt.name);
    }
};

pub const Enum = struct {
    id: EnumID,
    struct_id: ?StructID,
    size_bits: u8,
    name: ?[]const u8 = null,
    description: ?[]const u8 = null,

    pub const sql_opts = SQL_Options{
        .primary_key = .{ .name = "id", .autoincrement = true },
        .foreign_keys = &.{
            .{ .name = "struct_id", .on_delete = .cascade, .on_update = .cascade },
        },
    };

    pub fn deinit(e: *const Enum, allocator: Allocator) void {
        if (e.name) |name|
            allocator.free(name);

        if (e.description) |desc|
            allocator.free(desc);
    }
};

pub const Register = struct {
    id: RegisterID,
    struct_id: ?StructID,
    name: []const u8,
    description: ?[]const u8,
    size_bits: u64,
    offset_bytes: u64,
    count: ?u64,
    access: Access,
    reset_mask: ?u64,
    reset_value: ?u64,

    pub const sql_opts = SQL_Options{
        .primary_key = .{ .name = "id", .autoincrement = true },
        .foreign_keys = &.{
            .{ .name = "struct_id", .on_delete = .cascade, .on_update = .cascade },
        },
    };

    pub fn from_row(allocator: Allocator, row: zqlite.Row) !Register {
        const name = try allocator.dupe(u8, row.text(2));
        const description: ?[]const u8 = if (row.nullableText(3)) |text| try allocator.dupe(u8, text) else null;
        return Register{
            .id = @enumFromInt(row.int(0)),
            .struct_id = if (row.nullableInt(1)) |value| @enumFromInt(value) else null,
            .name = name,
            .description = description,
            .size_bits = @intCast(row.int(4)),
            .offset_bytes = @intCast(row.int(5)),
            .count = if (row.nullableInt(6)) |value| @intCast(value) else null,
            .access = std.meta.stringToEnum(Access, row.text(7)) orelse return error.InvalidAccess,
            .reset_mask = if (row.nullableInt(8)) |value| @intCast(value) else null,
            .reset_value = if (row.nullableInt(9)) |value| @intCast(value) else null,
        };
    }

    pub fn get_size_bytes(register: *const Register) u32 {
        const single_size_bytes = register.size_bits / 8;
        return if (register.count) |count|
            @intCast(count * single_size_bytes)
        else
            @intCast(single_size_bytes);
    }

    pub fn less_than(_: void, lhs: Register, rhs: Register) bool {
        return lhs.offset_bytes < rhs.offset_bytes;
    }

    pub fn format(
        register: Register,
        writer: *std.Io.Writer,
    ) !void {
        try writer.print("Register: id={f} struct_id={?f} name='{s}' size_bits={} offset_bytes={} desc='{?s}'", .{
            register.id,
            register.struct_id,
            register.name,
            register.size_bits,
            register.offset_bytes,
            register.description,
        });
    }
};

pub const EnumField = struct {
    enum_id: EnumID,
    name: []const u8,
    description: ?[]const u8,
    value: u64,

    pub const sql_opts = SQL_Options{
        .foreign_keys = &.{
            .{ .name = "enum_id", .on_delete = .cascade, .on_update = .cascade },
        },
        .unique_constraints = &.{
            &.{ "enum_id", "name" },
        },
    };
};

pub const Struct = struct {
    id: StructID,

    pub const sql_opts = SQL_Options{
        .primary_key = .{ .name = "id", .autoincrement = true },
    };
};

pub const StructField = struct {
    struct_id: StructID,
    name: []const u8,
    description: ?[]const u8,
    size_bits: u8,
    offset_bits: u8,
    enum_id: ?EnumID,
    count: ?u16,
    stride: ?u8,

    pub const sql_opts = SQL_Options{
        .foreign_keys = &.{
            .{ .name = "struct_id", .on_delete = .cascade, .on_update = .cascade },
            .{ .name = "enum_id", .on_delete = .cascade, .on_update = .cascade },
        },
        .unique_constraints = &.{
            &.{ "struct_id", "name" },
        },
        // .checks = .{
        //      .{ .name = "count", .expr = "{} >= 1",
        // },
    };

    pub fn get_size_bits(field: *const StructField) u32 {
        if (field.count != null and field.count.? > 1 and field.stride > field.size_bits)
            log.warn("get_size_bits() result is unreliable for field array {s} with stride {d} bits > size {d} bits", .{ field.name, field.stride, field.size_bits });
        return if (field.count) |count|
            @intCast(field.size_bits * count)
        else
            field.size_bits;
    }
};

pub const StructDecl = struct {
    parent_id: StructID,
    struct_id: StructID,
    name: []const u8,
    description: ?[]const u8,
    size_bytes: ?u64,

    pub const sql_opts = SQL_Options{
        .foreign_keys = &.{
            .{ .name = "parent_id", .on_delete = .cascade, .on_update = .cascade },
            .{ .name = "struct_id", .on_delete = .cascade, .on_update = .cascade },
        },
        .unique_constraints = &.{
            &.{ "parent_id", "name" },
            &.{"struct_id"},
        },
    };

    pub fn deinit(decl: *const StructDecl, allocator: Allocator) void {
        if (decl.description) |desc|
            allocator.free(desc);

        allocator.free(decl.name);
    }
};

pub const StructRegister = struct {
    struct_id: StructID,
    register_id: RegisterID,

    pub const sql_opts = SQL_Options{
        .foreign_keys = &.{
            .{ .name = "struct_id", .on_delete = .cascade, .on_update = .cascade },
            .{ .name = "register_id", .on_delete = .cascade, .on_update = .cascade },
        },
    };
};

pub const NestedStructField = struct {
    parent_id: StructID,
    struct_id: StructID,
    offset_bytes: u32,
    name: []const u8,
    description: ?[]const u8 = null,
    count: ?u64 = null,
    size_bytes: ?u64 = null,

    pub const sql_opts = SQL_Options{
        .foreign_keys = &.{
            .{ .name = "parent_id", .on_delete = .cascade, .on_update = .cascade },
            .{ .name = "struct_id", .on_delete = .cascade, .on_update = .cascade },
        },
    };

    pub fn less_than(_: void, lhs: NestedStructField, rhs: NestedStructField) bool {
        return lhs.offset_bytes < rhs.offset_bytes;
    }
};

pub const Peripheral = struct {
    id: PeripheralID,
    struct_id: StructID,
    name: []const u8,
    description: ?[]const u8,
    size_bytes: ?u64,

    pub const sql_opts = SQL_Options{
        .primary_key = .{ .name = "id", .autoincrement = true },
    };

    pub fn deinit(peripheral: *const Peripheral, allocator: Allocator) void {
        if (peripheral.description) |desc|
            allocator.free(desc);

        allocator.free(peripheral.name);
    }
};

pub const RegisterMode = struct {
    mode_id: ModeID,
    register_id: RegisterID,

    pub const sql_opts = SQL_Options{
        .foreign_keys = &.{
            .{ .name = "mode_id", .on_delete = .cascade, .on_update = .cascade },
            .{ .name = "register_id", .on_delete = .cascade, .on_update = .cascade },
        },
    };
};

pub const DeviceProperty = struct {
    device_id: DeviceID,
    key: []const u8,
    value: ?[]const u8,
    description: ?[]const u8,

    pub const sql_opts = SQL_Options{
        .unique_constraints = &.{
            &.{ "device_id", "key" },
        },
    };
};

// not sure how to communicate the *_once values in generated code
// besides adding it to documentation comments
pub const Access = enum {
    read_write,
    read_only,
    write_only,
    write_once,
    read_write_once,

    pub const BaseType = []const u8;
    pub const default = .read_write;

    pub fn to_string(access: Access) []const u8 {
        return inline for (@typeInfo(Access).@"enum".fields) |field| {
            if (@field(Access, field.name) == access)
                break field.name;
        } else unreachable;
    }
};

pub const StructLayout = enum {
    auto,
    @"extern",
    @"packed",

    pub const BaseType = []const u8;
};

fn gen_field_list(comptime T: type, opts: struct { prefix: ?[]const u8 = null }) []const u8 {
    var buf: [4096]u8 = undefined;
    var fbs: std.Io.Writer = .fixed(&buf);

    inline for (@typeInfo(T).@"struct".fields, 0..) |field, i| {
        if (i != 0)
            fbs.writeAll(", ") catch unreachable;

        if (opts.prefix) |prefix|
            fbs.print("{s}.", .{prefix}) catch unreachable;

        fbs.print("{s}", .{field.name}) catch unreachable;
    }

    const buf_copy = buf;
    return buf_copy[0..fbs.buffered().len];
}

fn zig_type_to_sql_type(comptime T: type) []const u8 {
    const info = @typeInfo(T);
    return switch (info) {
        .int => "INTEGER",
        .pointer => |ptr| if (ptr.child == u8) "TEXT" else unreachable,
        .@"enum" => zig_type_to_sql_type(T.BaseType),
        .optional => |opt| zig_type_to_sql_type(opt.child),
        else => {
            @compileLog(T);
            unreachable;
        },
    };
}

fn gen_sql_table(comptime name: []const u8, comptime T: type) [:0]const u8 {
    return gen_sql_table_impl(name, T) catch unreachable;
}

fn gen_sql_table_impl(comptime name: []const u8, comptime T: type) ![:0]const u8 {
    var buf: [4096]u8 = undefined;
    var fbs: std.Io.Writer = .fixed(&buf);

    // check that primary key and foreign keys exist
    var primary_key_found = T.sql_opts.primary_key == null;

    const info = @typeInfo(T);
    inline for (info.@"struct".fields) |field| {
        if (T.sql_opts.primary_key) |primary_key| {
            if (std.mem.eql(u8, primary_key.name, field.name))
                primary_key_found = true;
        }
    }

    assert(primary_key_found);

    try fbs.print("CREATE TABLE {s} (\n", .{name});
    var first = true;
    inline for (info.@"struct".fields) |field| {
        if (first) {
            first = false;
        } else {
            try fbs.writeAll(",\n");
        }
        try fbs.print("  {s}", .{field.name});
        try fbs.print(" {s}", .{zig_type_to_sql_type(field.type)});

        const field_type_info = @typeInfo(field.type);
        if (field_type_info != .optional)
            try fbs.writeAll(" NOT NULL");

        if (T.sql_opts.primary_key) |primary_key| {
            if (std.mem.eql(u8, primary_key.name, field.name)) {
                try fbs.writeAll(" PRIMARY KEY");

                if (primary_key.autoincrement)
                    try fbs.writeAll(" AUTOINCREMENT");
            }
        }
    }

    for (T.sql_opts.unique_constraints) |unique_constraint| {
        try fbs.writeAll(",\nUNIQUE(");
        first = true;
        for (unique_constraint) |col_name| {
            if (first) {
                first = false;
            } else {
                try fbs.writeAll(", ");
            }
            try fbs.writeAll(col_name);
        }
        try fbs.writeAll(")");
    }

    for (T.sql_opts.foreign_keys) |foreign_key| {
        try fbs.writeAll(",\n");

        const field = for (@typeInfo(T).@"struct".fields) |field| {
            if (std.mem.eql(u8, field.name, foreign_key.name))
                break field;
        } else unreachable;

        try fbs.print("  FOREIGN KEY ({s}) REFERENCES {s}(id) ON DELETE {s} ON UPDATE {s}\n", .{
            foreign_key.name,
            (switch (@typeInfo(field.type)) {
                .optional => |opt| opt.child,
                else => field.type,
            }).table,
            foreign_key.on_delete.to_string(),
            foreign_key.on_update.to_string(),
        });
    }

    // foreign keys

    try fbs.writeAll(");\n");
    try fbs.writeByte(0);

    const buf_copy = buf;
    return @ptrCast(buf_copy[0 .. fbs.buffered().len - 1]);
}

const schema: []const [:0]const u8 = &.{
    gen_sql_table("registers", Register),
    gen_sql_table("modes", Mode),
    gen_sql_table("register_modes", RegisterMode),
    gen_sql_table("peripherals", Peripheral),
    gen_sql_table("structs", Struct),
    gen_sql_table("struct_fields", StructField),
    gen_sql_table("struct_decls", StructDecl),
    gen_sql_table("struct_registers", StructRegister),
    gen_sql_table("nested_struct_fields", NestedStructField),
    gen_sql_table("enums", Enum),
    gen_sql_table("enum_fields", EnumField),
    gen_sql_table("devices", Device),
    gen_sql_table("device_properties", DeviceProperty),
    gen_sql_table("interrupts", Interrupt),
    gen_sql_table("device_peripherals", DevicePeripheral),
    // indexes
    "CREATE INDEX idx_struct_fields_struct_id_offset_bits ON struct_fields(struct_id, offset_bits);",
    "CREATE INDEX idx_interrupts_device_id_idx ON interrupts(device_id, idx)",
    "CREATE INDEX idx_device_peripherals_device_id_offset_bytes ON device_peripherals(device_id, offset_bytes)",
    "CREATE INDEX idx_struct_registers_struct_id ON struct_registers(struct_id)",
    "CREATE INDEX idx_registers_id_offset_bytes ON registers(id, offset_bytes)",
    "CREATE INDEX idx_enums_struct_id_name ON enums (struct_id, name)",
    "CREATE INDEX idx_enum_fields_enum_id_value ON enum_fields(enum_id, value)",
};

pub const Format = enum {
    svd,
    atdf,
    // embassy's stm32-data format: https://github.com/embassy-rs/stm32-data-generated
    embassy,

    pub fn is_XML(format: Format) bool {
        return switch (format) {
            .svd, .atdf => true,
            .embassy => false,
        };
    }
};

fn ID(comptime T: type, comptime table_name: []const u8) type {
    return enum(T) {
        pub const BaseType = u32;
        pub const table = table_name;

        _,

        pub fn format(
            id: @This(),
            writer: *std.Io.Writer,
        ) !void {
            const ID_Type = @TypeOf(id);
            try writer.print("{s}({})", .{ ID_Type.table, @intFromEnum(id) });
        }
    };
}

fn init(db: *Database, allocator: Allocator) !void {
    const flags = zqlite.OpenFlags.Create | zqlite.OpenFlags.EXResCode;
    const conn = try zqlite.open(":memory:", flags);
    db.* = Database{
        .gpa = allocator,
        .conn = conn,
    };
    errdefer db.deinit();

    // Good starting point to improve SQLite's poor defaults
    try db.conn.execNoArgs("PRAGMA journal_mode=WAL");
    try db.conn.execNoArgs("PRAGMA synchronous=NORMAL");
    try db.conn.execNoArgs("PRAGMA foreign_keys=true");

    // Create tables and indexes
    inline for (schema) |query| {
        log.debug("query: {s}", .{query});
        try db.conn.execNoArgs(query);
    }

    log.debug("finished loading schema", .{});
}

pub fn create(allocator: Allocator) !*Database {
    const db = try allocator.create(Database);
    errdefer allocator.destroy(db);

    try db.init(allocator);
    return db;
}

fn deinit(db: *Database) void {
    db.conn.close();
}

pub fn destroy(db: *Database) void {
    const allocator = db.gpa;
    db.deinit();
    allocator.destroy(db);
}

pub fn create_from_doc(allocator: Allocator, format: Format, doc: xml.Doc) !*Database {
    var db = try Database.create(allocator);
    errdefer {
        std.log.err("sqlite: {s}", .{db.conn.lastError()});
        db.destroy();
    }

    switch (format) {
        .svd => try svd.load_into_db(db, doc),
        .atdf => try atdf.load_into_db(db, doc),
        .embassy => return error.InvalidFormat,
    }

    return db;
}

pub fn create_from_path(allocator: Allocator, format: Format, path: []const u8) !*Database {
    return switch (format) {
        .embassy => blk: {
            var db = try Database.create(allocator);
            errdefer {
                std.log.err("sqlite: {s}", .{db.conn.lastError()});
                db.destroy();
            }

            try embassy.load_into_db(db, path);
            break :blk db;
        },
        .svd, .atdf => blk: {
            const text = try std.fs.cwd().readFileAlloc(allocator, path, file_size_max);
            defer allocator.free(text);

            break :blk create_from_xml(allocator, format, text);
        },
    };
}

pub fn create_from_xml(allocator: Allocator, format: Format, xml_text: []const u8) !*Database {
    assert(format.is_XML());
    var doc = try xml.Doc.from_memory(xml_text);
    defer doc.deinit();

    return create_from_doc(allocator, format, doc);
}

pub const CreateDeviceOptions = struct {
    name: []const u8,
    description: ?[]const u8 = null,
    arch: Arch,
};

pub fn create_device(db: *Database, opts: CreateDeviceOptions) !DeviceID {
    log.debug("create_device: name={s} arch={} desc={?s}", .{
        opts.name,
        opts.arch,
        opts.description,
    });

    const row = try db.conn.row(
        \\INSERT INTO devices
        \\  (name, description, arch)
        \\VALUES
        \\  (?, ?, ?)
        \\RETURNING id
        \\
    , .{
        opts.name,
        opts.description,
        opts.arch.to_string(),
    }) orelse unreachable;
    defer row.deinit();

    return @enumFromInt(row.int(0));
}

pub fn get_peripheral_by_name(db: *Database, name: []const u8) !?PeripheralID {
    const row = try db.conn.row("SELECT id FROM peripherals WHERE name = ?", .{
        name,
    }) orelse return null;
    defer row.deinit();

    return @enumFromInt(row.int(0));
}

/// Get the struct ID for a struct decl with `name` in parent struct
pub fn get_struct_decl_id_by_name(db: *Database, parent: StructID, name: []const u8) !StructID {
    const row = try db.conn.row("SELECT struct_id FROM struct_decls WHERE parent_id = ? and name = ?", .{
        @intFromEnum(parent),
        name,
    }) orelse return error.MissingEntity;
    defer row.deinit();

    return @enumFromInt(row.int(0));
}

pub fn get_struct_decl_by_name(db: *Database, allocator: Allocator, parent: StructID, name: []const u8) !StructDecl {
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM struct_decls
        \\WHERE parent_id = ? AND name = ?
    , .{
        comptime gen_field_list(StructDecl, .{}),
    });

    return db.one_alloc(StructDecl, allocator, query, .{
        @intFromEnum(parent),
        name,
    });
}

pub fn get_peripheral_by_struct_id(db: *Database, allocator: Allocator, struct_id: StructID) !?Peripheral {
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM peripherals
        \\WHERE struct_id = ?
    , .{
        comptime gen_field_list(Peripheral, .{}),
    });

    return try db.get_one_alloc(Peripheral, allocator, query, .{
        @intFromEnum(struct_id),
    });
}

pub fn get_struct_decl_by_struct_id(db: *Database, allocator: Allocator, struct_id: StructID) !?StructDecl {
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM struct_decls
        \\WHERE struct_id = ?
    , .{
        comptime gen_field_list(StructDecl, .{}),
    });

    return try db.get_one_alloc(StructDecl, allocator, query, .{
        @intFromEnum(struct_id),
    });
}

pub fn get_peripheral_struct(db: *Database, peripheral: PeripheralID) !StructID {
    const row = try db.conn.row("SELECT struct_id FROM peripherals WHERE id = ? LIMIT 1", .{
        @intFromEnum(peripheral),
    }) orelse return error.MissingEntity;
    defer row.deinit();

    return @enumFromInt(row.int(0));
}

pub fn get_register_struct(db: *Database, register: RegisterID) !?StructID {
    const row = try db.conn.row("SELECT struct_id FROM registers WHERE id = ?", .{
        @intFromEnum(register),
    }) orelse return null;
    defer row.deinit();

    return if (row.nullableInt(0)) |int| @enumFromInt(int) else null;
}

pub fn get_device_id_by_name(db: *Database, name: []const u8) !?DeviceID {
    const row = try db.conn.row("SELECT id FROM devices WHERE name = ?", .{
        name,
    }) orelse return null;
    defer row.deinit();

    return @enumFromInt(row.int(0));
}

fn scan_row(comptime T: type, allocator: Allocator, row: zqlite.Row) !T {
    var entry: T = undefined;
    inline for (@typeInfo(T).@"struct".fields, 0..) |field, i| {
        if (@typeInfo(field.type) == .@"enum") {
            if (@hasDecl(field.type, "to_string"))
                @field(entry, field.name) = std.meta.stringToEnum(field.type, row.text(i)) orelse return error.Unknown
            else
                @field(entry, field.name) = @enumFromInt(row.int(i));
        } else if (@typeInfo(field.type) == .int) {
            @field(entry, field.name) = @intCast(row.int(i));
        } else switch (field.type) {
            []const u8 => {
                @field(entry, field.name) = try allocator.dupe(u8, row.text(i));
            },
            ?[]const u8 => {
                @field(entry, field.name) = if (row.nullableText(i)) |text| try allocator.dupe(u8, text) else null;
            },
            ?u64, ?u16, ?u8 => {
                @field(entry, field.name) = if (row.nullableInt(i)) |value| @intCast(value) else null;
            },
            ?StructID, ?EnumID => {
                @field(entry, field.name) = if (row.nullableInt(i)) |value| @enumFromInt(value) else null;
            },
            else => @compileError(std.fmt.comptimePrint("unhandled column type: {s}", .{@typeName(field.type)})),
        }
    }

    return entry;
}

fn all(db: *Database, comptime T: type, comptime query: []const u8, allocator: Allocator, args: anytype) ![]T {
    var rows = try db.conn.rows(query, args);
    defer rows.deinit();

    var list: std.ArrayList(T) = .{};
    while (rows.next()) |row| {
        try list.append(allocator, try scan_row(T, allocator, row));
    }

    if (rows.err) |err| {
        return err;
    }

    return list.toOwnedSlice(allocator);
}

pub fn get_devices(db: *Database, allocator: Allocator) ![]Device {
    const query = std.fmt.comptimePrint("SELECT {s} FROM devices ORDER BY name ASC", .{
        comptime gen_field_list(Device, .{}),
    });
    return db.all(Device, query, allocator, .{});
}

pub fn get_struct_decls(db: *Database, allocator: Allocator, parent: StructID) ![]StructDecl {
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM struct_decls
        \\WHERE parent_id = ?
        \\ORDER BY name ASC
    , .{
        comptime gen_field_list(StructDecl, .{}),
    });

    return db.all(StructDecl, query, allocator, .{
        @intFromEnum(parent),
    });
}

pub fn get_registers_with_mode(
    db: *Database,
    allocator: Allocator,
    struct_id: StructID,
    mode_id: ModeID,
) ![]Register {
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM struct_registers AS sr
        \\JOIN registers AS r ON r.id = sr.register_id
        \\LEFT JOIN register_modes rm ON rm.register_id = r.id
        \\WHERE
        \\    sr.struct_id = ?
        \\  AND (
        \\        rm.mode_id = ? OR rm.mode_id IS NULL
        \\    )
        \\ORDER BY r.offset_bytes;
    , .{
        comptime gen_field_list(Register, .{ .prefix = "r" }),
    });

    return db.all(Register, query, allocator, .{
        @intFromEnum(struct_id),
        @intFromEnum(mode_id),
    });
}

pub fn get_struct_registers(
    db: *Database,
    allocator: Allocator,
    struct_id: StructID,
) ![]Register {
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM struct_registers AS sr
        \\JOIN structs AS s ON sr.struct_id = s.id
        \\JOIN registers AS r ON sr.register_id = r.id
        \\WHERE s.id = ?
        \\ORDER BY r.offset_bytes ASC
    , .{
        comptime gen_field_list(Register, .{ .prefix = "r" }),
    });

    return db.all(Register, query, allocator, .{
        @intFromEnum(struct_id),
    });
}

// Way beyond anything reasonable
const max_recursion_depth = 32;

fn get_nested_struct_fields(
    db: *Database,
    allocator: Allocator,
    struct_id: StructID,
) ![]NestedStructField {
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM nested_struct_fields AS nsf
        \\JOIN structs AS s ON nsf.struct_id = s.id
        \\WHERE nsf.parent_id = ?
        \\ORDER BY nsf.offset_bytes ASC
    , .{
        comptime gen_field_list(NestedStructField, .{ .prefix = "nsf" }),
    });

    return db.all(NestedStructField, query, allocator, .{
        @intFromEnum(struct_id),
    });
}

fn recursively_calculate_struct_size(
    db: *Database,
    depth: *u8,
    cache: *std.AutoArrayHashMap(StructID, u64),
    allocator: Allocator,
    struct_id: StructID,
) !u64 {
    if (depth.* >= max_recursion_depth)
        return error.MaxRecursionDepth;

    const registers = try db.get_struct_registers(allocator, struct_id);
    defer allocator.free(registers);

    const nested_struct_fields = try db.get_nested_struct_fields(allocator, struct_id);
    defer allocator.free(nested_struct_fields);

    var max_end: ?u32 = null;
    for (registers) |register| {
        const register_end = register.offset_bytes + ((register.size_bits / 8) * (register.count orelse 1));
        if (max_end) |end| {
            if (register_end > end)
                max_end = @intCast(register_end);
        } else {
            max_end = @intCast(register_end);
        }
    }

    for (nested_struct_fields) |nsf| {
        const nested_struct_field_end = nsf.offset_bytes + ((nsf.size_bytes orelse
            cache.get(nsf.struct_id) orelse
            try db.recursively_calculate_struct_size(depth, cache, allocator, nsf.struct_id)) * (nsf.count orelse 1));
        if (max_end) |end| {
            if (nested_struct_field_end > end)
                max_end = @intCast(nested_struct_field_end);
        } else {
            max_end = @intCast(nested_struct_field_end);
        }
    }

    return max_end orelse 0;
}

/// This queries for the nested struct fields for a given struct, and
/// calculates the byte size of that field if it is not explicit. If the size
/// is calculated to be zero, the nested struct field will not be reported.
pub fn get_nested_struct_fields_with_calculated_size(
    db: *Database,
    gpa: Allocator,
    struct_id: StructID,
) ![]NestedStructField {
    var ret: std.ArrayList(NestedStructField) = .empty;
    defer ret.deinit(gpa);

    const nested_struct_fields = try db.get_nested_struct_fields(gpa, struct_id);
    defer gpa.free(nested_struct_fields);

    log.debug("nested_struct_fields.len={} struct_id={f}", .{ nested_struct_fields.len, struct_id });

    var size_cache: std.AutoArrayHashMap(StructID, u64) = .init(gpa);
    defer size_cache.deinit();

    for (nested_struct_fields) |*nsf| {
        if (nsf.size_bytes != null) {
            try ret.append(gpa, nsf.*);
            continue;
        }

        var depth: u8 = 0;
        const size_bytes = try db.recursively_calculate_struct_size(&depth, &size_cache, gpa, nsf.struct_id);
        std.log.debug("Calculated struct size: struct_id={f} size_bytes={}", .{ nsf.struct_id, size_bytes });
        nsf.size_bytes = if (size_bytes > 0) size_bytes else continue;
        try ret.append(gpa, nsf.*);
    }

    return ret.toOwnedSlice(gpa);
}

pub fn get_struct_modes(
    db: *Database,
    allocator: Allocator,
    struct_id: StructID,
) ![]Mode {
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM modes
        \\WHERE struct_id = ?
    , .{
        comptime gen_field_list(Mode, .{}),
    });

    return db.all(Mode, query, allocator, .{
        @intFromEnum(struct_id),
    });
}

pub const GetEnumsOptions = struct {
    distinct: bool = false,
};
pub fn get_enums(
    db: *Database,
    allocator: Allocator,
    struct_id: StructID,
    comptime opts: GetEnumsOptions,
) ![]const Enum {
    const query = if (opts.distinct)
        std.fmt.comptimePrint(
            \\SELECT {s}
            \\FROM enums AS e
            \\WHERE struct_id = ?
            \\AND name IS NOT NULL
            \\AND NOT EXISTS (
            \\    SELECT 1
            \\    FROM enums AS e2
            \\    WHERE e.struct_id = e2.struct_id
            \\      AND e.name = e2.name
            \\      AND e.id <> e2.id
            \\)
            \\ORDER BY e.name ASC;
        , .{
            comptime gen_field_list(Enum, .{ .prefix = "e" }),
        })
    else
        std.fmt.comptimePrint(
            \\SELECT {s}
            \\FROM enums
            \\WHERE struct_id = ?
            \\ORDER BY name ASC
        , .{
            comptime gen_field_list(Enum, .{}),
        });

    return db.all(Enum, query, allocator, .{
        @intFromEnum(struct_id),
    });
}

pub fn enum_has_name_collision(db: *Database, enum_id: EnumID) !bool {
    const row = try db.conn.row(
        \\SELECT e2.id
        \\FROM enums AS e1
        \\JOIN enums AS e2
        \\  ON e1.struct_id = e2.struct_id
        \\  AND e1.name = e2.name
        \\  AND e1.id != e2.id
        \\WHERE e1.id = ?;
    , .{@intFromEnum(enum_id)}) orelse return false;
    defer row.deinit();

    return true;
}

pub fn get_enum(
    db: *Database,
    allocator: Allocator,
    id: EnumID,
) !Enum {
    log.debug("get_enum: id={f}", .{id});
    const query = std.fmt.comptimePrint("SELECT {s} FROM enums WHERE id = ?", .{
        comptime gen_field_list(Enum, .{}),
    });

    return db.one_alloc(Enum, allocator, query, .{
        @intFromEnum(id),
    });
}

pub const GetEnumFieldOptions = struct {
    /// Ensure that there are no name or value collisions. Simply picks the
    /// first entry in the table.
    distinct: bool = true,
};

pub fn get_enum_fields(
    db: *Database,
    allocator: Allocator,
    enum_id: EnumID,
    comptime opts: GetEnumFieldOptions,
) ![]const EnumField {
    const query = if (opts.distinct)
        std.fmt.comptimePrint(
            \\WITH duplicates AS (
            \\    SELECT
            \\        enum_id,
            \\        name,
            \\        value,
            \\        description,
            \\        ROW_NUMBER() OVER (PARTITION BY name) AS name_row,
            \\        ROW_NUMBER() OVER (PARTITION BY value) AS value_row
            \\    FROM
            \\        enum_fields
            \\    WHERE
            \\        enum_id = ?
            \\),
            \\filtered AS (
            \\    SELECT *
            \\    FROM duplicates
            \\    WHERE name_row = 1 AND value_row = 1
            \\)
            \\SELECT
            \\    {s}
            \\FROM
            \\    filtered
            \\ORDER BY
            \\    value ASC
        , .{
            comptime gen_field_list(EnumField, .{}),
        })
    else
        std.fmt.comptimePrint(
            \\SELECT {s}
            \\FROM enum_fields
            \\WHERE enum_id = ?
            \\ORDER BY value ASC
        , .{
            comptime gen_field_list(EnumField, .{}),
        });

    return db.all(EnumField, query, allocator, .{
        @intFromEnum(enum_id),
    });
}

pub fn get_enum_field_by_name(
    db: *Database,
    allocator: Allocator,
    enum_id: EnumID,
    name: []const u8,
) !EnumField {
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM enum_fields
        \\WHERE enum_id = ? AND name = ?
    , .{
        comptime gen_field_list(EnumField, .{}),
    });

    return db.one_alloc(EnumField, allocator, query, .{
        @intFromEnum(enum_id),
        name,
    });
}

pub fn get_interrupts(db: *Database, allocator: Allocator, device_id: DeviceID) ![]Interrupt {
    const query = std.fmt.comptimePrint("SELECT {s} FROM interrupts WHERE device_id = ? ORDER BY idx ASC", .{
        comptime gen_field_list(Interrupt, .{}),
    });

    const interrupts = try db.all(Interrupt, query, allocator, .{@intFromEnum(device_id)});
    return interrupts;
}

pub fn backup(db: *Database, path: [:0]const u8) !void {
    const flags = zqlite.OpenFlags.Create;
    const backup_db = try zqlite.open(path, flags);
    defer backup_db.close();

    const backup_step = c.sqlite3_backup_init(@ptrCast(backup_db.conn), "main", @ptrCast(db.conn.conn), "main");
    if (backup_step != null) {
        _ = c.sqlite3_backup_step(backup_step, -1);
        _ = c.sqlite3_backup_finish(backup_step);
    }
}

pub const GetRegisterFieldsOptions = struct {
    /// Ensures that there is no overlap between fields, and that there is no
    /// name collisions
    distinct: bool = true,
};

pub fn get_register_fields(
    db: *Database,
    allocator: Allocator,
    register_id: RegisterID,
    comptime opts: GetRegisterFieldsOptions,
) ![]StructField {
    const query = if (opts.distinct)
        std.fmt.comptimePrint(
            \\WITH OrderedFields AS (
            \\    SELECT
            \\        sf.struct_id,
            \\        sf.name,
            \\        sf.description,
            \\        sf.size_bits,
            \\        sf.offset_bits,
            \\        sf.enum_id,
            \\        sf.count,
            \\        sf.stride,
            \\        ROW_NUMBER() OVER (
            \\            PARTITION BY sf.struct_id, sf.offset_bits
            \\            ORDER BY sf.offset_bits ASC, sf.size_bits ASC
            \\        ) AS row_num
            \\    FROM struct_fields AS sf
            \\    INNER JOIN registers AS r ON r.struct_id = sf.struct_id
            \\    WHERE r.id = ?
            \\),
            \\DistinctFields AS (
            \\    SELECT
            \\        struct_id,
            \\        name,
            \\        description,
            \\        size_bits,
            \\        offset_bits,
            \\        enum_id,
            \\        count,
            \\        stride
            \\    FROM OrderedFields
            \\    WHERE row_num = 1
            \\)
            \\SELECT {s}
            \\FROM DistinctFields
            \\GROUP BY name, struct_id
            \\ORDER BY offset_bits ASC
        , .{
            comptime gen_field_list(StructField, .{}),
        })
    else
        std.fmt.comptimePrint(
            \\SELECT {s}
            \\FROM struct_fields AS sf
            \\JOIN registers AS r ON sf.struct_id = r.struct_id
            \\WHERE r.id = ?
            \\ORDER BY sf.offset_bits ASC;
        , .{
            comptime gen_field_list(StructField, .{ .prefix = "sf" }),
        });
    return db.all(StructField, query, allocator, .{
        @intFromEnum(register_id),
    });
}

pub fn get_register_field_by_name(
    db: *Database,
    allocator: Allocator,
    register_id: RegisterID,
    name: []const u8,
) !StructField {
    const query =
        std.fmt.comptimePrint(
            \\SELECT {s}
            \\FROM struct_fields AS sf
            \\JOIN registers AS r ON sf.struct_id = r.struct_id
            \\WHERE r.id = ? AND sf.name = ?
        , .{
            comptime gen_field_list(StructField, .{ .prefix = "sf" }),
        });
    return db.one_alloc(StructField, allocator, query, .{
        @intFromEnum(register_id),
        name,
    });
}

pub fn get_interrupt_name(db: *Database, allocator: Allocator, interrupt_id: InterruptID) ![]const u8 {
    const query = "SELECT name FROM interrupts WHERE id = ?";
    return db.one_alloc([]const u8, allocator, query, .{
        @intFromEnum(interrupt_id),
    });
}

pub fn get_struct_decl(db: *Database, allocator: Allocator, struct_id: StructID) !?StructDecl {
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM struct_decls
        \\WHERE struct_id = ?
    , .{
        comptime gen_field_list(StructDecl, .{}),
    });

    return try db.get_one_alloc(StructDecl, allocator, query, .{
        @intFromEnum(struct_id),
    });
}

pub fn get_peripherals(db: *Database, allocator: Allocator) ![]Peripheral {
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM peripherals
        \\ORDER BY name ASC
    , .{
        comptime gen_field_list(Peripheral, .{}),
    });
    return db.all(Peripheral, query, allocator, .{});
}

pub fn get_peripheral(db: *Database, allocator: Allocator, peripheral_id: PeripheralID) !Peripheral {
    const query = std.fmt.comptimePrint("SELECT {s} FROM peripherals WHERE id = ?", .{
        comptime gen_field_list(Peripheral, .{}),
    });
    return db.one_alloc(Peripheral, allocator, query, .{
        @intFromEnum(peripheral_id),
    });
}

pub fn get_device_properties(db: *Database, allocator: Allocator, device_id: DeviceID) ![]DeviceProperty {
    const query = std.fmt.comptimePrint("SELECT {s} FROM device_properties WHERE device_id = ? ORDER BY key ASC", .{
        comptime gen_field_list(DeviceProperty, .{}),
    });

    return db.all(DeviceProperty, query, allocator, .{@intFromEnum(device_id)});
}

pub fn get_device_peripherals(db: *Database, allocator: Allocator, device_id: DeviceID) ![]DevicePeripheral {
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM device_peripherals
        \\WHERE device_id = ?
        \\ORDER BY offset_bytes ASC
    , .{
        comptime gen_field_list(DevicePeripheral, .{}),
    });

    return db.all(DevicePeripheral, query, allocator, .{
        @intFromEnum(device_id),
    });
}

pub fn get_device_peripheral_by_name(db: *Database, allocator: Allocator, device_id: DeviceID, name: []const u8) !DevicePeripheral {
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM device_peripherals
        \\WHERE device_id = ? and name = ?
    , .{
        comptime gen_field_list(DevicePeripheral, .{}),
    });

    return db.one_alloc(DevicePeripheral, allocator, query, .{
        @intFromEnum(device_id),
        name,
    });
}

pub fn get_interrupt_by_name(
    db: *Database,
    device_id: DeviceID,
    name: []const u8,
) !?InterruptID {
    const row = try db.conn.row("SELECT id FROM interrupts WHERE device_id = ? AND name = ?", .{
        @intFromEnum(device_id),
        name,
    }) orelse return null;
    defer row.deinit();

    return @enumFromInt(row.int(0));
}

pub fn get_enum_by_name(
    db: *Database,
    allocator: Allocator,
    struct_id: StructID,
    name: []const u8,
) !Enum {
    log.debug("get_enum_by_name: struct_id={f} name='{s}'", .{ struct_id, name });
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM enums
        \\WHERE struct_id = ? AND name = ?
    , .{
        comptime gen_field_list(Enum, .{}),
    });

    return db.one_alloc(Enum, allocator, query, .{
        @intFromEnum(struct_id),
        name,
    }) catch |err| switch (err) {
        error.MissingEntity => {
            // lookup the enum among the parents
            var parent_id = struct_id;
            var i: u8 = 0;
            const max_depth = 10;
            while (i <= max_depth) : (i += 1) {
                parent_id = db.get_parent_struct_id(parent_id) catch {
                    return err;
                };

                log.debug("get_enum_by_name: parent_id={f} name='{s}'", .{ parent_id, name });
                return db.one_alloc(Enum, allocator, query, .{
                    @intFromEnum(parent_id),
                    name,
                }) catch {
                    continue;
                };
            }
            return err;
        },
        else => {
            return err;
        },
    };
}

fn get_parent_struct_id(db: *Database, struct_id: StructID) !StructID {
    const row = try db.conn.row("SELECT parent_id FROM struct_decls WHERE struct_id = ?", .{
        @intFromEnum(struct_id),
    }) orelse return error.MissingEntity;
    defer row.deinit();

    return @enumFromInt(row.int(0));
}

fn one_alloc(
    db: *Database,
    comptime T: type,
    allocator: Allocator,
    comptime query: []const u8,
    args: anytype,
) !T {
    return try db.get_one_alloc(T, allocator, query, args) orelse return error.MissingEntity;
}

fn get_one_alloc(
    db: *Database,
    comptime T: type,
    allocator: Allocator,
    comptime query: []const u8,
    args: anytype,
) !?T {
    const row = try db.conn.row(query, args) orelse return null;
    defer row.deinit();

    return try scan_row(T, allocator, row);
}

pub fn get_interrupt_idx(db: *Database, interrupt_id: InterruptID) !i32 {
    const row = try db.conn.row("SELECT idx FROM interrupts WHERE id = ?", .{
        @intFromEnum(interrupt_id),
    }) orelse return error.MissingEntity;
    defer row.deinit();

    return @intCast(row.int(0));
}

pub const AddNestedStructFieldOptions = struct {
    name: []const u8,
    struct_id: StructID,
    offset_bytes: u64,
    description: ?[]const u8 = null,
    size_bytes: ?u64 = null,
    count: ?u64 = null,
};

pub fn add_nested_struct_field(
    db: *Database,
    parent: StructID,
    opts: AddNestedStructFieldOptions,
) !void {
    try db.conn.exec(
        \\INSERT INTO nested_struct_fields
        \\  (parent_id, struct_id, name, description, offset_bytes, size_bytes, count)
        \\VALUES
        \\  (?, ?, ?, ?, ?, ?, ?)
    , .{
        @intFromEnum(parent),
        @intFromEnum(opts.struct_id),
        opts.name,
        opts.description,
        opts.offset_bytes,
        opts.size_bytes,
        opts.count,
    });

    log.debug("add_nested_struct_field: parent={f} name='{s}' struct_id={f} offset_bytes={} size_bytes={?} count={?}", .{
        parent,
        opts.name,
        opts.struct_id,
        opts.offset_bytes,
        opts.size_bytes,
        opts.count,
    });
}

pub const CreateNestedStructOptions = struct {
    name: []const u8,
    description: ?[]const u8 = null,
    size_bytes: ?u64 = null,
};

pub fn create_nested_struct(
    db: *Database,
    parent: StructID,
    opts: CreateNestedStructOptions,
) !StructID {
    const struct_id = try db.create_struct(.{});
    try db.conn.exec(
        \\INSERT INTO struct_decls
        \\  (parent_id, struct_id, name, description, size_bytes)
        \\VALUES
        \\  (?, ?, ?, ?, ?)
    , .{
        @intFromEnum(parent),
        @intFromEnum(struct_id),
        opts.name,
        opts.description,
        opts.size_bytes,
    });

    log.debug("created struct_decl: parent={f} struct_id={f} name='{s}' description='{?s}' size_bytes={?}", .{
        parent,
        struct_id,
        opts.name,
        opts.description,
        opts.size_bytes,
    });
    return struct_id;
}

pub const AddDevicePropertyOptions = struct {
    key: []const u8,
    value: ?[]const u8 = null,
    description: ?[]const u8 = null,
};

pub fn add_device_property(db: *Database, device_id: DeviceID, opts: AddDevicePropertyOptions) !void {
    try db.conn.exec(
        \\INSERT INTO device_properties
        \\  (device_id, key, value, description)
        \\VALUES
        \\  (?, ?, ?, ?)
    , .{
        @intFromEnum(device_id),
        opts.key,
        opts.value,
        opts.description,
    });
}

pub fn get_device_property(
    db: *Database,
    allocator: Allocator,
    device_id: DeviceID,
    key: []const u8,
) !?[]const u8 {
    const row = try db.conn.row("SELECT value FROM device_properties WHERE device_id = ? AND key = ?", .{
        @intFromEnum(device_id),
        key,
    }) orelse return null;
    defer row.deinit();

    return if (row.nullableText(0)) |text| try allocator.dupe(u8, text) else null;
}

const CreateInterruptOptions = struct {
    name: []const u8,
    description: ?[]const u8 = null,
    idx: i32,
};

pub fn create_interrupt(db: *Database, device_id: DeviceID, opts: CreateInterruptOptions) !InterruptID {
    log.debug("create_interrupt: device_id={f} name={s} idx={} desc={?s}", .{
        device_id,
        opts.name,
        opts.idx,
        opts.description,
    });

    const row = try db.conn.row(
        \\INSERT INTO interrupts
        \\  (device_id, name, description, idx)
        \\VALUES
        \\  (?, ?, ?, ?)
        \\RETURNING id
    , .{
        @intFromEnum(device_id),
        opts.name,
        opts.description,
        opts.idx,
    }) orelse unreachable;
    defer row.deinit();

    return @enumFromInt(row.int(0));
}

pub const CreatePeripheralOptions = struct {
    struct_id: ?StructID = null,
    name: []const u8,
    description: ?[]const u8 = null,
    size_bytes: ?u64 = null,
};

/// Create a peripheral type.
///
/// The code generated for a peripheral can be a struct itself, or a namespace
/// containing structs. In the latter case, a peripheral
pub fn create_peripheral(db: *Database, opts: CreatePeripheralOptions) !PeripheralID {
    errdefer std.log.err("sqlite: {s}", .{db.conn.lastError()});

    try db.conn.transaction();
    errdefer db.conn.rollback();

    const struct_id = opts.struct_id orelse try db.create_struct(.{});

    const peripheral_id: PeripheralID = blk: {
        const row = try db.conn.row("INSERT INTO peripherals (struct_id, name, description, size_bytes) VALUES (?, ?, ?, ?) RETURNING id", .{
            @intFromEnum(struct_id),
            opts.name,
            opts.description,
            opts.size_bytes,
        }) orelse unreachable;
        defer row.deinit();

        break :blk @enumFromInt(row.int(0));
    };

    try db.conn.commit();
    log.debug("created {f}: struct_id={f} name={s} size_bytes={?} desc={?s}", .{
        peripheral_id,
        struct_id,
        opts.name,
        opts.size_bytes,
        opts.description,
    });

    return peripheral_id;
}

pub const CreateDevicePeripheralOptions = struct {
    struct_id: StructID,
    name: []const u8,
    description: ?[]const u8 = null,
    offset_bytes: u64,
    count: ?u64 = null,
};

pub fn create_device_peripheral(
    db: *Database,
    device_id: DeviceID,
    opts: CreateDevicePeripheralOptions,
) !DevicePeripheralID {
    log.debug("create_device_peripherals: device_id={f} struct_id={f} name={s} offset=0x{X} desc={?s}", .{
        device_id,
        opts.struct_id,
        opts.name,
        opts.offset_bytes,
        opts.description,
    });

    const row = try db.conn.row(
        \\INSERT INTO device_peripherals
        \\  (device_id, struct_id, name, description, offset_bytes, count)
        \\VALUES
        \\  (?, ?, ?, ?, ?, ?)
        \\RETURNING id
    , .{
        @intFromEnum(device_id),
        @intFromEnum(opts.struct_id),
        opts.name,
        opts.description,
        opts.offset_bytes,
        opts.count,
    }) orelse unreachable;
    defer row.deinit();

    return @enumFromInt(row.int(0));
}

pub const CreateModeOptions = struct {
    name: []const u8,
    description: ?[]const u8 = null,
    value: []const u8,
    qualifier: []const u8,
};

pub fn create_mode(db: *Database, parent: StructID, opts: CreateModeOptions) !ModeID {
    log.debug("create_mode: name={s} parent={f}", .{ opts.name, parent });
    const row = try db.conn.row(
        \\INSERT INTO modes
        \\  (name, struct_id, description, value, qualifier)
        \\VALUES
        \\  (?, ?, ?, ?, ?)
        \\RETURNING id
    , .{
        opts.name,
        @intFromEnum(parent),
        opts.description,
        opts.value,
        opts.qualifier,
    }) orelse unreachable;
    defer row.deinit();

    const mode_id: ModeID = @enumFromInt(row.int(0));
    log.debug(
        "created {f}: struct_id={f} name='{s}' value='{s}' qualifier='{s}'",
        .{ mode_id, parent, opts.name, opts.value, opts.qualifier },
    );

    return mode_id;
}

pub const CreateRegisterOptions = struct {
    // make name required for now
    name: []const u8,
    description: ?[]const u8 = null,
    /// offset is in bytes
    offset_bytes: u64,
    /// size is in bits
    size_bits: u64,
    /// count if there is an array
    count: ?u64 = null,
    access: Access = .read_write,
    reset_mask: ?u64 = null,
    reset_value: ?u64 = null,
};

pub fn add_register_mode(db: *Database, register_id: RegisterID, mode_id: ModeID) !void {
    log.debug("add_register_mode: mode_id={f} register_id={f}", .{ mode_id, register_id });
    try db.conn.exec(
        \\INSERT INTO register_modes
        \\  (register_id, mode_id)
        \\VALUES
        \\  (?, ?)
    , .{
        @intFromEnum(register_id),
        @intFromEnum(mode_id),
    });
}

pub fn create_register(db: *Database, parent: StructID, opts: CreateRegisterOptions) !RegisterID {
    try db.conn.transaction();
    errdefer db.conn.rollback();

    const register_id: RegisterID = blk: {
        const row = try db.conn.row(
            \\INSERT INTO registers
            \\  (name, description, offset_bytes, size_bits, count, access, reset_mask, reset_value)
            \\VALUES
            \\  (?, ?, ?, ?, ?, ?, ?, ?)
            \\RETURNING id
        , .{
            opts.name,
            opts.description,
            opts.offset_bytes,
            opts.size_bits,
            opts.count,
            opts.access.to_string(),
            opts.reset_mask,
            opts.reset_value,
        }) orelse unreachable;
        defer row.deinit();
        break :blk @enumFromInt(row.int(0));
    };

    try db.conn.exec("INSERT INTO struct_registers (struct_id, register_id) VALUES (?, ?)", .{
        @intFromEnum(parent),
        @intFromEnum(register_id),
    });

    try db.conn.commit();
    log.debug("created {f}: name='{s}' parent_id={f} offset_bytes={} size_bits={}", .{
        register_id,
        opts.name,
        parent,
        opts.offset_bytes,
        opts.size_bits,
    });

    return register_id;
}

pub fn get_register_by_name(
    db: *Database,
    allocator: Allocator,
    struct_id: StructID,
    name: []const u8,
) !Register {
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM registers AS r
        \\JOIN struct_registers AS sr ON sr.register_id = r.id
        \\WHERE sr.struct_id = ? AND name = ?
    , .{
        comptime gen_field_list(Register, .{ .prefix = "r" }),
    });

    const row = try db.conn.row(query, .{
        @intFromEnum(struct_id),
        name,
    }) orelse return error.MissingEntity;
    defer row.deinit();

    return Register.from_row(allocator, row);
}

pub const AddStructFieldOptions = struct {
    name: []const u8,
    description: ?[]const u8 = null,
    size_bits: u8,
    offset_bits: u8,
    enum_id: ?EnumID = null,
    count: ?u16 = null,
    stride: ?u8 = null,
};

pub fn add_register_field(db: *Database, parent: RegisterID, opts: AddStructFieldOptions) !void {
    // if there's no struct for a register then we need to create one
    try db.conn.transaction();
    errdefer db.conn.rollback();

    const struct_id = try db.get_register_struct(parent) orelse blk: {
        const struct_id = try db.create_struct(.{});

        try db.conn.exec("UPDATE registers SET struct_id = ? WHERE id = ?", .{
            @intFromEnum(struct_id),
            @intFromEnum(parent),
        });

        log.debug("{f} now has {f}", .{ parent, struct_id });
        break :blk struct_id;
    };

    try db.add_struct_field(struct_id, opts);
    try db.conn.commit();
}

fn add_struct_field(db: *Database, parent: StructID, opts: AddStructFieldOptions) !void {
    try db.conn.exec(
        \\INSERT INTO struct_fields
        \\  (struct_id, name, description, size_bits, offset_bits, enum_id, count, stride)
        \\VALUES
        \\  (?, ?, ?, ?, ?, ?, ?, ?)
    , .{
        @intFromEnum(parent),
        opts.name,
        opts.description,
        opts.size_bits,
        opts.offset_bits,
        if (opts.enum_id) |enum_id| @intFromEnum(enum_id) else null,
        opts.count,
        opts.stride,
    });

    log.debug("add_struct_field: parent={f} name='{s}' offset_bits={} size_bits={} enum_id={?f} count={?} stride={?}", .{
        parent,
        opts.name,
        opts.offset_bits,
        opts.size_bits,
        opts.enum_id,
        opts.count,
        opts.stride,
    });
}

pub const CreateEnumOptions = struct {
    name: ?[]const u8 = null,
    description: ?[]const u8 = null,
    size_bits: u8,
};

pub fn create_enum(db: *Database, struct_id: ?StructID, opts: CreateEnumOptions) !EnumID {
    const row = try db.conn.row(
        \\INSERT INTO enums
        \\  (struct_id, name, description, size_bits)
        \\VALUES
        \\  (?, ?, ?, ?)
        \\RETURNING id
    , .{
        if (struct_id) |si| @intFromEnum(si) else null,
        opts.name,
        opts.description,
        opts.size_bits,
    }) orelse unreachable;
    defer row.deinit();

    const enum_id: EnumID = @enumFromInt(row.int(0));
    log.debug("created {f}: struct_id={?f} name='{?s}' description='{?s}' size_bits={}", .{
        enum_id,
        struct_id,
        opts.name,
        opts.description,
        opts.size_bits,
    });

    return enum_id;
}

pub const CreateEnumFieldOptions = struct {
    name: []const u8,
    description: ?[]const u8 = null,
    value: u64,
};

pub fn add_enum_field(db: *Database, enum_id: EnumID, opts: CreateEnumFieldOptions) !void {
    try db.conn.exec(
        \\INSERT INTO enum_fields
        \\  (enum_id, name, description, value)
        \\VALUES
        \\  (?, ?, ?, ?)
    , .{
        @intFromEnum(enum_id),
        opts.name,
        opts.description,
        opts.value,
    });
}

pub const CreateStructOptions = struct {};

pub fn create_struct(db: *Database, opts: CreateStructOptions) !StructID {
    _ = opts;

    const row = try db.conn.row("INSERT INTO structs DEFAULT VALUES RETURNING id", .{}) orelse unreachable;
    defer row.deinit();

    const struct_id: StructID = @enumFromInt(row.int(0));
    log.debug("created {f}", .{struct_id});
    return struct_id;
}

pub fn struct_is_zero_sized(db: *Database, allocator: Allocator, struct_id: StructID) !bool {
    const registers = try db.get_struct_registers(allocator, struct_id);
    defer allocator.free(registers);

    const nested_struct_fields = try db.get_nested_struct_fields_with_calculated_size(allocator, struct_id);
    defer allocator.free(nested_struct_fields);

    return (registers.len == 0) and (nested_struct_fields.len == 0);
}

/// Returns the last part of the reference, and the beginning part of the
/// reference
fn get_ref_last_component(ref: []const u8) !struct { []const u8, ?[]const u8 } {
    var it = std.mem.splitScalar(u8, ref, '.');
    var last: ?[]const u8 = null;
    while (it.next()) |comp| {
        last = comp;
    }

    return if (last) |l|
        if (l.len == ref.len)
            .{ l, null }
        else
            .{ l, ref[0 .. ref.len - l.len - 1] }
    else
        error.EmptyRef;
}

fn strip_ref_prefix(expected_prefix: []const u8, ref: []const u8) ![]const u8 {
    var prefix_it = std.mem.splitScalar(u8, expected_prefix, '.');
    var ref_it = std.mem.splitScalar(u8, ref, '.');

    while (prefix_it.next()) |prefix_comp| {
        const ref_comp = ref_it.next() orelse return error.RefTooShort;

        if (!std.mem.eql(u8, prefix_comp, ref_comp))
            return error.RefPrefixNotExpected;
    }

    const index = ref_it.index orelse return error.RefTooShort;
    return ref[index..];
}

fn get_struct_ref(db: *Database, ref: []const u8) !StructID {
    var arena = std.heap.ArenaAllocator.init(db.gpa);
    defer arena.deinit();

    const base_ref = try strip_ref_prefix("types.peripherals", ref);
    const struct_name, const rest_ref = try get_ref_last_component(base_ref);
    return if (rest_ref) |rest| blk: {
        var it = std.mem.splitScalar(u8, rest, '.');
        const peripheral_name = it.next() orelse return error.NoPeripheral;
        const peripheral_id = try db.get_peripheral_by_name(peripheral_name) orelse return error.NoPeripheral;
        var struct_id = try db.get_peripheral_struct(peripheral_id);
        if (it.index == null) {
            return if (std.mem.eql(u8, struct_name, peripheral_name))
                struct_id
            else
                error.NoPeripheral;
        }

        break :blk while (it.next()) |name| {
            const struct_decl = try db.get_struct_decl_by_name(arena.allocator(), struct_id, name);
            if (it.index == null and std.mem.eql(u8, struct_name, struct_decl.name))
                break struct_decl.struct_id;

            struct_id = struct_decl.struct_id;
        } else error.RefNotFound;
    } else blk: {
        // just getting a peripheral
        const peripheral_id = try db.get_peripheral_by_name(struct_name) orelse return error.NoPeripheral;
        break :blk try db.get_peripheral_struct(peripheral_id);
    };
}

fn get_enum_ref(db: *Database, ref: []const u8) !EnumID {
    var arena = std.heap.ArenaAllocator.init(db.gpa);
    defer arena.deinit();

    // An enum that can be referenced has a struct as a parent
    const enum_name, const struct_ref = try get_ref_last_component(ref);
    const struct_id = try db.get_struct_ref(struct_ref orelse return error.InvalidRef);

    const e = try db.get_enum_by_name(arena.allocator(), struct_id, enum_name);
    return e.id;
}

fn get_register_ref(db: *Database, ref: []const u8) !RegisterID {
    var arena = std.heap.ArenaAllocator.init(db.gpa);
    defer arena.deinit();

    const register_name, const struct_ref = try get_ref_last_component(ref);
    const struct_id = try db.get_struct_ref(struct_ref orelse return error.InvalidRef);
    const register = try db.get_register_by_name(arena.allocator(), struct_id, register_name);
    return register.id;
}

fn set_register_field_enum_id(db: *Database, register_id: RegisterID, field_name: []const u8, enum_id: ?EnumID) !void {
    try db.conn.exec(
        \\UPDATE struct_fields
        \\SET enum_id = ?
        \\WHERE struct_id = (
        \\    SELECT struct_id
        \\    FROM registers
        \\    WHERE id = ?
        \\)
        \\AND name = ?;
    , .{
        if (enum_id) |eid| @intFromEnum(eid) else null,
        @intFromEnum(register_id),
        field_name,
    });

    log.debug("set_register_field_enum_id: register_id={f} field_name={s} enum_id={?f}", .{
        register_id,
        field_name,
        enum_id,
    });
}

fn cleanup_unused_enums(db: *Database) !void {
    try db.conn.exec(
        \\DELETE FROM enums
        \\WHERE id NOT IN (
        \\    SELECT DISTINCT enum_id
        \\    FROM struct_fields
        \\    WHERE enum_id IS NOT NULL
        \\)
    , .{});
}

pub fn apply_patch(db: *Database, zon_text: [:0]const u8, diags: *std.zon.parse.Diagnostics) !void {
    const patches = try std.zon.parse.fromSlice([]const Patch, db.gpa, zon_text, diags, .{});
    defer std.zon.parse.free(db.gpa, patches);

    for (patches) |patch| {
        switch (patch) {
            .override_arch => |override_arch| {
                const device_id = try db.get_device_id_by_name(override_arch.device_name) orelse {
                    return error.DeviceNotFound;
                };

                try db.conn.exec(
                    \\UPDATE devices
                    \\SET arch = ?
                    \\WHERE id = ?;
                , .{
                    override_arch.arch.to_string(),
                    @intFromEnum(device_id),
                });
            },
            .set_device_property => |set_prop| {
                const device_id = try db.get_device_id_by_name(set_prop.device_name) orelse {
                    return error.DeviceNotFound;
                };

                try db.conn.exec(
                    \\INSERT INTO device_properties
                    \\  (device_id, key, value, description)
                    \\VALUES
                    \\  (?, ?, ?, ?)
                    \\ON CONFLICT(device_id, key)
                    \\DO UPDATE SET
                    \\  value = excluded.value,
                    \\  description = excluded.description;
                , .{
                    @intFromEnum(device_id),
                    set_prop.key,
                    set_prop.value,
                    set_prop.description,
                });
            },
            .add_enum => |add_enum| {
                const struct_id = try db.get_struct_ref(add_enum.parent);

                const enum_id = try db.create_enum(struct_id, .{
                    .name = add_enum.@"enum".name,
                    .description = add_enum.@"enum".description,
                    .size_bits = add_enum.@"enum".bitsize,
                });

                for (add_enum.@"enum".fields) |enum_field| {
                    try db.add_enum_field(enum_id, .{
                        .name = enum_field.name,
                        .description = enum_field.description,
                        .value = enum_field.value,
                    });
                }
            },
            .set_enum_type => |set_enum_type| {
                const enum_id = if (set_enum_type.to) |to| try db.get_enum_ref(to) else null;
                const field_name, const register_ref = try get_ref_last_component(set_enum_type.of);
                const register_id = try db.get_register_ref(register_ref orelse return error.InvalidRef);
                try db.set_register_field_enum_id(register_id, field_name, enum_id);
                try db.cleanup_unused_enums();
            },
            .add_interrupt => |add_interrupt| {
                const device_id = try db.get_device_id_by_name(add_interrupt.device_name) orelse {
                    return error.DeviceNotFound;
                };

                _ = try db.create_interrupt(device_id, .{
                    .name = add_interrupt.name,
                    .description = add_interrupt.description,
                    .idx = add_interrupt.idx,
                });
            },
        }
    }
}

pub const ToZigOptions = gen.ToZigOptions;

pub fn to_zig(db: *Database, output_dir: Directory, opts: ToZigOptions) !void {
    try gen.to_zig(db, output_dir, opts);
}

test "all" {
    @setEvalBranchQuota(2000);
    _ = atdf;
    _ = gen;
    _ = svd;
}
