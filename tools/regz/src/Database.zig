gpa: Allocator,
sql: sqlite.Db,
diags: sqlite.Diagnostics = .{},

const Database = @This();
const std = @import("std");
const Allocator = std.mem.Allocator;
const assert = std.debug.assert;

const sqlite = @import("sqlite");
const xml = @import("xml.zig");
const svd = @import("svd.zig");
const atdf = @import("atdf.zig");
const gen = @import("gen.zig");
const Patch = @import("patch.zig").Patch;
const SQL_Options = @import("SQL_Options.zig");
const Arch = @import("arch.zig").Arch;

const log = std.log.scoped(.db);

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

    // TODO: SQL opts
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

        // TODO:
        //  CHECK ((struct_id IS NULL AND name IS NULL) OR (struct_id IS NOT NULL AND name IS NOT NULL)),
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
        comptime fmt: []const u8,
        options: std.fmt.FormatOptions,
        writer: anytype,
    ) !void {
        _ = fmt;
        _ = options;

        try writer.print("Register: id={} struct_id={?} name='{s}' size_bits={} offset_bytes={} desc='{?s}'", .{
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
};

pub const StructLayout = enum {
    auto,
    @"extern",
    @"packed",

    pub const BaseType = []const u8;
};

fn gen_field_list(comptime T: type, opts: struct { prefix: ?[]const u8 = null }) []const u8 {
    var buf = std.BoundedArray(u8, 4096).init(0) catch unreachable;
    const writer = buf.writer();
    inline for (@typeInfo(T).@"struct".fields, 0..) |field, i| {
        if (i != 0)
            writer.writeAll(", ") catch unreachable;

        if (opts.prefix) |prefix|
            writer.print("{s}.", .{prefix}) catch unreachable;

        writer.print("{s}", .{field.name}) catch unreachable;
    }

    const buf_copy = buf;
    return buf_copy.slice();
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

fn gen_sql_table(comptime name: []const u8, comptime T: type) []const u8 {
    return gen_sql_table_impl(name, T) catch unreachable;
}

fn gen_sql_table_impl(comptime name: []const u8, comptime T: type) ![]const u8 {
    var buf = try std.BoundedArray(u8, 4096).init(0);

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

    const writer = buf.writer();
    try writer.print("CREATE TABLE {s} (\n", .{name});
    var first = true;
    inline for (info.@"struct".fields) |field| {
        if (first) {
            first = false;
        } else {
            try writer.writeAll(",\n");
        }
        try writer.print("  {s}", .{field.name});
        try writer.print(" {s}", .{zig_type_to_sql_type(field.type)});

        const field_type_info = @typeInfo(field.type);
        if (field_type_info != .optional)
            try writer.writeAll(" NOT NULL");

        if (T.sql_opts.primary_key) |primary_key| {
            if (std.mem.eql(u8, primary_key.name, field.name)) {
                try writer.writeAll(" PRIMARY KEY");

                if (primary_key.autoincrement)
                    try writer.writeAll(" AUTOINCREMENT");
            }
        }
    }

    for (T.sql_opts.foreign_keys) |foreign_key| {
        try writer.writeAll(",\n");

        const field = for (@typeInfo(T).@"struct".fields) |field| {
            if (std.mem.eql(u8, field.name, foreign_key.name))
                break field;
        } else unreachable;

        try writer.print("  FOREIGN KEY ({s}) REFERENCES {s}(id) ON DELETE {s} ON UPDATE {s}\n", .{
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

    try writer.writeAll(");\n");

    const buf_copy = buf;
    return buf_copy.slice();
}

const schema: []const []const u8 = &.{
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
};

fn ID(comptime T: type, comptime table_name: []const u8) type {
    return enum(T) {
        pub const BaseType = u32;
        pub const table = table_name;

        _,

        pub fn format(
            id: @This(),
            comptime fmt: []const u8,
            options: std.fmt.FormatOptions,
            writer: anytype,
        ) !void {
            _ = fmt;
            _ = options;

            const ID_Type = @TypeOf(id);
            try writer.print("{s}({})", .{ ID_Type.table, @intFromEnum(id) });
        }
    };
}

fn init(db: *Database, allocator: Allocator) !void {
    const sql = try sqlite.Db.init(.{
        .diags = &db.diags,
        .open_flags = .{
            .write = true,
        },
    });

    db.* = Database{
        .gpa = allocator,
        .sql = sql,
    };
    errdefer db.deinit();

    // Good starting point to improve SQLite's poor defaults
    _ = try db.sql.pragma(void, .{}, "journal_mode", "WAL");
    _ = try db.sql.pragma(void, .{}, "synchronous", "NORMAL");
    _ = try db.sql.pragma(void, .{}, "foreign_keys", "true");

    // Create tables and indexes
    inline for (schema) |query| {
        log.debug("query: {s}", .{query});
        try db.exec(query, .{});
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
    db.sql.deinit();
}

pub fn destroy(db: *Database) void {
    const allocator = db.gpa;
    db.deinit();
    allocator.destroy(db);
}

pub fn create_from_doc(allocator: Allocator, format: Format, doc: xml.Doc) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    switch (format) {
        .svd => try svd.load_into_db(db, doc),
        .atdf => try atdf.load_into_db(db, doc),
    }

    return db;
}

pub fn create_from_xml(allocator: Allocator, format: Format, xml_text: []const u8) !*Database {
    var doc = try xml.Doc.from_memory(xml_text);
    defer doc.deinit();

    return create_from_doc(allocator, format, doc);
}

pub const CreateDeviceOptions = struct {
    name: []const u8,
    description: ?[]const u8 = null,
    arch: Arch,
};

fn exec(db: *Database, comptime query: []const u8, args: anytype) !void {
    db.sql.execDynamic(query, .{ .diags = &db.diags }, args) catch |err| {
        std.log.err("Failed Query:\n{s}", .{query});
        if (err == error.SQLiteError)
            std.log.err("{}", .{db.diags});

        return err;
    };
}

pub fn create_device(db: *Database, opts: CreateDeviceOptions) !DeviceID {
    log.debug("create_device: name={s} arch={} desc={?s}", .{
        opts.name,
        opts.arch,
        opts.description,
    });

    var savepoint = try db.sql.savepoint("create_device");
    defer savepoint.rollback();

    try db.exec(
        \\INSERT INTO devices
        \\  (name, description, arch)
        \\VALUES
        \\  (?, ?, ?)
    , .{
        .name = opts.name,
        .description = opts.description,
        .arch = opts.arch,
    });

    const row_id = db.sql.getLastInsertRowID();
    savepoint.commit();
    return @enumFromInt(row_id);
}

fn get_id_by_name(db: *Database, comptime T: type, name: []const u8) !?T {
    var stmt = try db.sql.prepare(
        std.fmt.comptimePrint("SELECT id FROM {s} WHERE name = ?", .{T.table}),
    );
    defer stmt.deinit();

    return try stmt.one(T, .{}, .{ .name = name });
}

pub fn get_peripheral_by_name(db: *Database, name: []const u8) !?PeripheralID {
    return db.get_id_by_name(PeripheralID, name);
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
        .parent_id = parent,
        .name = name,
    });
}

pub fn get_peripheral_by_struct_id(db: *Database, allocator: Allocator, struct_id: StructID) !?Peripheral {
    log.debug("get_peripheral_by_struct_id: strut_id={}", .{struct_id});
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM peripherals
        \\WHERE struct_id = ?
    , .{
        comptime gen_field_list(Peripheral, .{}),
    });

    return try db.get_one_alloc(Peripheral, allocator, query, .{
        .struct_id = struct_id,
    });
}

pub fn get_struct_decl_by_struct_id(db: *Database, allocator: Allocator, struct_id: StructID) !?StructDecl {
    log.debug("get_struct_decl_by_struct_id: struct_id={}", .{struct_id});
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM struct_decls
        \\WHERE struct_id = ?
    , .{
        comptime gen_field_list(StructDecl, .{}),
    });

    return try db.get_one_alloc(StructDecl, allocator, query, .{
        .struct_id = struct_id,
    });
}

fn get_one(db: *Database, comptime T: type, comptime query: []const u8, args: anytype) !?T {
    return db.sql.one(T, query, .{ .diags = &db.diags }, args) catch |err| {
        std.log.err("Failed Query:\n{s}", .{query});
        if (err == error.SQLiteError)
            std.log.err("{}", .{db.diags});

        return err;
    };
}

fn one(db: *Database, comptime T: type, comptime query: []const u8, args: anytype) !T {
    return try db.get_one(T, query, args) orelse return error.MissingEntity;
}

pub fn get_peripheral_struct(db: *Database, peripheral: PeripheralID) !StructID {
    const query = "SELECT struct_id FROM peripherals WHERE id = ?";
    return db.one(StructID, query, .{
        .id = peripheral,
    });
}

pub fn get_register_struct(db: *Database, register: RegisterID) !?StructID {
    const query = "SELECT struct_id FROM registers WHERE id = ?";
    const row = try db.one(struct { struct_id: ?StructID }, query, .{
        .id = register,
    });

    return row.struct_id;
}

pub fn get_device_id_by_name(db: *Database, name: []const u8) !?DeviceID {
    const query = "SELECT id FROM devices WHERE name = ?";
    return db.sql.one(DeviceID, query, .{}, .{ .name = name });
}

pub fn get_device_by_name(db: *Database, allocator: Allocator, name: []const u8) !Device {
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM devices
        \\WHERE name = ?
    , .{
        comptime gen_field_list(Device, .{}),
    });

    return db.one_alloc(Device, allocator, query, .{
        .name = name,
    });
}

fn get_name_for_id(db: *Database, allocator: Allocator, id: anytype) ![]const u8 {
    const query = std.fmt.comptimePrint("SELECT name FROM {s} WHERE id = ?", .{
        @TypeOf(id).table,
    });

    return db.one_alloc([]const u8, allocator, query, .{
        .id = id,
    });
}

pub fn get_peripheral_name(db: *Database, allocator: Allocator, peripheral_id: PeripheralID) ![]const u8 {
    return db.get_name_for_id(allocator, peripheral_id);
}

fn all(db: *Database, comptime T: type, comptime query: []const u8, allocator: Allocator, args: anytype) ![]T {
    var stmt = db.sql.prepareWithDiags(query, .{
        .diags = &db.diags,
    }) catch |err| {
        if (err == error.SQLiteError) {
            log.err("query failed: {s}", .{query});
            log.err("{}", .{db.diags});
        }

        return err;
    };
    defer stmt.deinit();

    return stmt.all(T, allocator, .{
        .diags = &db.diags,
    }, args) catch |err| {
        if (err == error.SQLiteError) {
            log.err("query failed: {s}", .{query});
            log.err("{}", .{db.diags});
        }

        return err;
    };
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
        .parent_id = parent,
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
        \\    );
    , .{
        comptime gen_field_list(Register, .{ .prefix = "r" }),
    });

    return db.all(Register, query, allocator, .{
        .struct_id = struct_id,
        .mode_id = mode_id,
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
        .struct_id = struct_id,
    });
}

// Way beyond anything reasonable
const max_recursion_depth = 32;

pub fn get_nested_struct_fields(
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
        .struct_id = struct_id,
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
    allocator: Allocator,
    struct_id: StructID,
) ![]NestedStructField {
    var ret: std.ArrayList(NestedStructField) = .init(allocator);
    defer ret.deinit();

    const nested_struct_fields = try db.get_nested_struct_fields(allocator, struct_id);
    defer allocator.free(nested_struct_fields);

    var size_cache: std.AutoArrayHashMap(StructID, u64) = .init(allocator);
    defer size_cache.deinit();

    for (nested_struct_fields) |*nsf| {
        if (nsf.size_bytes != null)
            continue;

        var depth: u8 = 0;
        const size_bytes = try db.recursively_calculate_struct_size(&depth, &size_cache, allocator, nsf.struct_id);
        std.log.debug("Calculated struct size: struct_id={} size_bytes={}", .{ nsf.struct_id, size_bytes });
        nsf.size_bytes = if (size_bytes > 0) size_bytes else continue;
        try ret.append(nsf.*);
    }

    return ret.toOwnedSlice();
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
        .struct_id = struct_id,
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
        .struct_id = struct_id,
    });
}

pub fn enum_has_name_collision(db: *Database, enum_id: EnumID) !bool {
    const query =
        \\SELECT e2.id
        \\FROM enums AS e1
        \\JOIN enums AS e2
        \\  ON e1.struct_id = e2.struct_id
        \\  AND e1.name = e2.name
        \\  AND e1.id != e2.id
        \\WHERE e1.id = ?;
    ;
    return null != (try db.get_one(EnumID, query, .{ .enum_id = enum_id }));
}

pub fn get_enum(
    db: *Database,
    allocator: Allocator,
    id: EnumID,
) !Enum {
    log.debug("get_enum: id={}", .{id});
    const query = std.fmt.comptimePrint("SELECT {s} FROM enums WHERE id = ?", .{
        comptime gen_field_list(Enum, .{}),
    });

    return db.one_alloc(Enum, allocator, query, .{
        .id = id,
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
        .enum_id = enum_id,
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
        .enum_id = enum_id,
        .name = name,
    });
}

pub fn get_interrupts(db: *Database, allocator: Allocator, device_id: DeviceID) ![]Interrupt {
    const query = std.fmt.comptimePrint("SELECT {s} FROM interrupts WHERE device_id = ? ORDER BY idx ASC", .{
        comptime gen_field_list(Interrupt, .{}),
    });
    var stmt = try db.sql.prepare(query);
    defer stmt.deinit();

    return stmt.all(Interrupt, allocator, .{}, .{
        .device_id = device_id,
    });
}

const c = sqlite.c;

pub fn backup(db: *Database, path: [:0]const u8) !void {
    var backup_db = try sqlite.Db.init(.{
        .mode = .{
            .File = path,
        },
        .open_flags = .{
            .write = true,
            .create = true,
        },
    });
    defer backup_db.deinit();

    const backup_step = c.sqlite3_backup_init(backup_db.db, "main", db.sql.db, "main");
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

// TODO: if we ever need a "get struct fields" function, refactor this to use it
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
        .register_id = register_id,
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
        .register_id = register_id,
        .name = name,
    });
}

pub fn get_interrupt_name(db: *Database, allocator: Allocator, interrupt_id: InterruptID) ![]const u8 {
    const query = "SELECT name FROM interrupts WHERE id = ?";
    return db.one_alloc([]const u8, allocator, query, .{
        .id = interrupt_id,
    });
}

pub fn get_interrupt_description(db: *Database, allocator: Allocator, interrupt_id: InterruptID) !?[]const u8 {
    const query = "SELECT description FROM interrupts WHERE id = ?";
    return db.get_one_alloc([]const u8, allocator, query, .{
        .id = interrupt_id,
    });
}

pub fn get_struct(db: *Database, struct_id: StructID) !Struct {
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM structs
        \\WHERE struct_id = ?
    , .{
        comptime gen_field_list(Struct, .{}),
    });

    return try db.one(Struct, query, .{
        .struct_id = struct_id,
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
        .struct_id = struct_id,
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
        .id = peripheral_id,
    });
}

pub fn get_device_properties(db: *Database, allocator: Allocator, device_id: DeviceID) ![]DeviceProperty {
    const query = std.fmt.comptimePrint("SELECT {s} FROM device_properties WHERE device_id = ? ORDER BY key ASC", .{
        comptime gen_field_list(DeviceProperty, .{}),
    });
    var stmt = try db.sql.prepare(query);
    defer stmt.deinit();

    return stmt.all(DeviceProperty, allocator, .{}, .{
        .device_id = device_id,
    });
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
        .device_id = device_id,
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
        .device_id = device_id,
        .name = name,
    });
}

pub fn get_interrupt_by_name(
    db: *Database,
    device_id: DeviceID,
    name: []const u8,
) !?InterruptID {
    const query = "SELECT id FROM interrupts WHERE device_id = ? AND name = ?";
    return db.sql.one(InterruptID, query, .{}, .{
        .device_id = device_id,
        .name = name,
    });
}

pub fn get_enum_by_name(
    db: *Database,
    allocator: Allocator,
    struct_id: StructID,
    name: []const u8,
) !Enum {
    log.debug("get_enum_by_name: struct_id={} name='{s}'", .{ struct_id, name });
    const query = std.fmt.comptimePrint(
        \\SELECT {s}
        \\FROM enums
        \\WHERE struct_id = ? AND name = ?
    , .{
        comptime gen_field_list(Enum, .{}),
    });

    return db.one_alloc(Enum, allocator, query, .{
        .struct_id = struct_id,
        .name = name,
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

                log.debug("get_enum_by_name: parent_id={} name='{s}'", .{ parent_id, name });
                return db.one_alloc(Enum, allocator, query, .{
                    .struct_id = parent_id,
                    .name = name,
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
    var stmt = try db.sql.prepare("SELECT parent_id FROM struct_decls WHERE struct_id = ?");
    defer stmt.deinit();

    const row = try stmt.one(StructID, .{}, .{
        .struct_id = struct_id,
    });

    return if (row) |parent_id| parent_id else error.MissingEntity;
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
    return db.sql.oneAlloc(T, allocator, query, .{ .diags = &db.diags }, args) catch |err| {
        log.err("Failed query:\n{s}", .{query});
        if (err == error.SQLiteError) {
            log.err("{}", .{db.diags});
        }

        return err;
    };
}

pub fn get_enum_description(
    db: *Database,
    allocator: Allocator,
    enum_id: EnumID,
) !?[]const u8 {
    const query = "SELECT description FROM enums WHERE id = ?";
    return db.get_one_alloc([]const u8, allocator, query, .{ .id = enum_id });
}

pub fn get_interrupt_idx(db: *Database, interrupt_id: InterruptID) !i32 {
    var stmt = try db.sql.prepare("SELECT idx FROM interrupts WHERE id = ?");
    defer stmt.deinit();

    const row = try stmt.one(i32, .{}, .{
        .id = interrupt_id,
    });

    return if (row) |idx| idx else error.NoInterruptForID;
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
    try db.exec(
        \\INSERT INTO nested_struct_fields
        \\  (parent_id, struct_id, name, description, offset_bytes, size_bytes, count)
        \\VALUES
        \\  (?, ?, ?, ?, ?, ?, ?)
    , .{
        .parent_id = parent,
        .struct_id = opts.struct_id,
        .name = opts.name,
        .description = opts.description,
        .offset_bytes = opts.offset_bytes,
        .size_bytes = opts.size_bytes,
        .count = opts.count,
    });

    log.debug("add_nested_struct_field: parent={} name='{s}' struct_id={} offset_bytes={} size_bytes={?} count={?}", .{
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
    var savepoint = try db.sql.savepoint("create_interrupt");
    defer savepoint.rollback();

    const struct_id = try db.create_struct(.{});
    try db.exec(
        \\INSERT INTO struct_decls
        \\  (parent_id, struct_id, name, description, size_bytes)
        \\VALUES
        \\  (?, ?, ?, ?, ?)
    , .{
        .parent_id = parent,
        .struct_id = struct_id,
        .name = opts.name,
        .description = opts.description,
        .size_bytes = opts.size_bytes,
    });

    savepoint.commit();
    log.debug("created struct_decl: parent={} struct_id={} name='{s}' description='{?s}' size_bytes={?}", .{
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
    try db.exec(
        \\INSERT INTO device_properties
        \\  (device_id, key, value, description)
        \\VALUES
        \\  (?, ?, ?, ?)
    , .{
        .device_id = @intFromEnum(device_id),
        .key = opts.key,
        .value = opts.value,
        .description = opts.description,
    });
}

pub fn get_device_property(db: *Database, allocator: Allocator, device_id: DeviceID, key: []const u8) !?[]const u8 {
    var stmt = try db.sql.prepare(
        \\SELECT
        \\  value
        \\FROM
        \\  device_properties
        \\WHERE
        \\  device_id = ? AND
        \\  key = ?
    );
    defer stmt.deinit();

    return try stmt.oneAlloc([]const u8, allocator, .{}, .{
        .device_id = @intFromEnum(device_id),
        .key = key,
    });
}

const CreateInterruptOptions = struct {
    name: []const u8,
    description: ?[]const u8 = null,
    idx: i32,
};

pub fn create_interrupt(db: *Database, device_id: DeviceID, opts: CreateInterruptOptions) !InterruptID {
    log.debug("create_interrupt: device_id={} name={s} idx={} desc={?s}", .{
        device_id,
        opts.name,
        opts.idx,
        opts.description,
    });

    var savepoint = try db.sql.savepoint("create_interrupt");
    defer savepoint.rollback();

    try db.exec(
        \\INSERT INTO interrupts
        \\  (device_id, name, description, idx)
        \\VALUES
        \\  (?, ?, ?, ?)
    , .{
        .device_id = @intFromEnum(device_id),
        .name = opts.name,
        .description = opts.description,
        .idx = opts.idx,
    });

    const row_id = db.sql.getLastInsertRowID();
    savepoint.commit();
    return @enumFromInt(row_id);
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
    var savepoint = try db.sql.savepoint("create_peripheral");
    defer savepoint.rollback();

    const struct_id = opts.struct_id orelse try db.create_struct(.{});

    try db.exec("INSERT INTO peripherals (struct_id, name, description, size_bytes) VALUES (?, ?, ?, ?)", .{
        .struct_id = struct_id,
        .name = opts.name,
        .description = opts.description,
        .size_bytes = opts.size_bytes,
    });

    const peripheral_id: PeripheralID = @enumFromInt(db.sql.getLastInsertRowID());
    savepoint.commit();

    log.debug("created {}: struct_id={?} name={s} size_bytes={?} desc={?s}", .{
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
    log.debug("create_device_peripherals: device_id={} struct_id={} name={s} offset=0x{X} desc={?s}", .{
        device_id,
        opts.struct_id,
        opts.name,
        opts.offset_bytes,
        opts.description,
    });

    var savepoint = try db.sql.savepoint("create_perip_inst");
    defer savepoint.rollback();

    try db.exec(
        \\INSERT INTO device_peripherals
        \\  (device_id, struct_id, name, description, offset_bytes, count)
        \\VALUES
        \\  (?, ?, ?, ?, ?, ?)
    , .{
        .device_id = @intFromEnum(device_id),
        .struct_id = opts.struct_id,
        .name = opts.name,
        .description = opts.description,
        .offset_bytes = opts.offset_bytes,
        .count = opts.count,
    });

    const row_id = db.sql.getLastInsertRowID();
    savepoint.commit();
    return @enumFromInt(row_id);
}

pub const CreateModeOptions = struct {
    name: []const u8,
    description: ?[]const u8 = null,
    value: []const u8,
    qualifier: []const u8,
};

pub fn create_mode(db: *Database, parent: StructID, opts: CreateModeOptions) !ModeID {
    var savepoint = try db.sql.savepoint("create_mode");
    defer savepoint.rollback();
    log.debug("create_mode: name={s} parent={}", .{ opts.name, parent });

    try db.exec(
        \\INSERT INTO modes
        \\  (name, struct_id, description, value, qualifier)
        \\VALUES
        \\  (?, ?, ?, ?, ?)
    , .{
        .name = opts.name,
        .struct_id = parent,
        .description = opts.description,
        .value = opts.value,
        .qualifier = opts.qualifier,
    });

    const mode_id: ModeID = @enumFromInt(db.sql.getLastInsertRowID());
    savepoint.commit();

    log.debug(
        "created {}: struct_id={} name='{s}' value='{s}' qualifier='{s}'",
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
    log.debug("add_register_mode: mode_id={} register_id={}", .{ mode_id, register_id });
    try db.exec(
        \\INSERT INTO register_modes
        \\  (register_id, mode_id)
        \\VALUES
        \\  (?, ?)
    , .{
        .register_id = register_id,
        .mode_id = mode_id,
    });
}

pub fn create_register(db: *Database, parent: StructID, opts: CreateRegisterOptions) !RegisterID {
    var savepoint = try db.sql.savepoint("create_register");
    defer savepoint.rollback();

    try db.exec(
        \\INSERT INTO registers
        \\  (name, description, offset_bytes, size_bits, count, access, reset_mask, reset_value)
        \\VALUES
        \\  (?, ?, ?, ?, ?, ?, ?, ?)
    , .{
        .name = opts.name,
        .description = opts.description,
        .offset_bytes = opts.offset_bytes,
        .size_bits = opts.size_bits,
        .count = opts.count,
        .access = opts.access,
        .reset_mask = opts.reset_mask,
        .reset_value = opts.reset_value,
    });

    const register_id: RegisterID = @enumFromInt(db.sql.getLastInsertRowID());
    try db.exec(
        \\INSERT INTO struct_registers
        \\  (struct_id, register_id)
        \\VALUES
        \\  (?, ?)
    , .{
        .struct_id = parent,
        .register_id = register_id,
    });

    savepoint.commit();

    log.debug("created {}: name='{s}' parent_id={} offset_bytes={} size_bits={}", .{
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

    return try db.one_alloc(Register, allocator, query, .{
        .struct_id = struct_id,
        .name = name,
    });
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
    var savepoint = try db.sql.savepoint("add_register_field");
    defer savepoint.rollback();

    const struct_id = try db.get_register_struct(parent) orelse blk: {
        const struct_id = try db.create_struct(.{});

        try db.exec("UPDATE registers SET struct_id = ? WHERE id = ?", .{
            .struct_id = struct_id,
            .id = parent,
        });

        log.debug("{} now has {}", .{ parent, struct_id });
        break :blk struct_id;
    };

    try db.add_struct_field(struct_id, opts);
    savepoint.commit();
}

pub fn add_struct_field(db: *Database, parent: StructID, opts: AddStructFieldOptions) !void {
    var savepoint = try db.sql.savepoint("add_struct_field");
    defer savepoint.rollback();

    try db.exec(
        \\INSERT INTO struct_fields
        \\  (struct_id, name, description, size_bits, offset_bits, enum_id, count, stride)
        \\VALUES
        \\  (?, ?, ?, ?, ?, ?, ?, ?)
    , .{
        .struct_id = parent,
        .name = opts.name,
        .description = opts.description,
        .size_bits = opts.size_bits,
        .offset_bits = opts.offset_bits,
        .enum_id = opts.enum_id,
        .count = opts.count,
        .stride = opts.stride,
    });

    savepoint.commit();

    log.debug("add_struct_field: parent={} name='{s}' offset_bits={} size_bits={} enum_id={?} count={?} stride={?}", .{
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
    var savepoint = try db.sql.savepoint("create_enum");
    defer savepoint.rollback();

    try db.exec(
        \\INSERT INTO enums
        \\  (struct_id, name, description, size_bits)
        \\VALUES
        \\  (?, ?, ?, ?)
    , .{
        .struct_id = struct_id,
        .name = opts.name,
        .description = opts.description,
        .size_bits = opts.size_bits,
    });

    const enum_id: EnumID = @enumFromInt(db.sql.getLastInsertRowID());
    savepoint.commit();

    log.debug("created {}: struct_id={?} name='{?s}' description='{?s}' size_bits={}", .{
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
    try db.exec(
        \\INSERT INTO enum_fields
        \\  (enum_id, name, description, value)
        \\VALUES
        \\  (?, ?, ?, ?)
    , .{
        .enum_id = enum_id,
        .name = opts.name,
        .description = opts.description,
        .value = opts.value,
    });
}

pub const CreateStructOptions = struct {};

pub fn create_struct(db: *Database, opts: CreateStructOptions) !StructID {
    _ = opts;
    var savepoint = try db.sql.savepoint("create_struct");
    defer savepoint.rollback();

    try db.exec("INSERT INTO structs DEFAULT VALUES", .{});

    const struct_id: StructID = @enumFromInt(db.sql.getLastInsertRowID());
    savepoint.commit();

    log.debug("created {}", .{struct_id});
    return struct_id;
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

pub fn get_struct_ref(db: *Database, ref: []const u8) !StructID {
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

pub fn get_enum_ref(db: *Database, ref: []const u8) !EnumID {
    var arena = std.heap.ArenaAllocator.init(db.gpa);
    defer arena.deinit();

    // An enum that can be referenced has a struct as a parent
    const enum_name, const struct_ref = try get_ref_last_component(ref);
    const struct_id = try db.get_struct_ref(struct_ref orelse return error.InvalidRef);

    // TODO: create a `get_enum_id_by_name()` function
    const e = try db.get_enum_by_name(arena.allocator(), struct_id, enum_name);
    return e.id;
}

pub fn get_register_ref(db: *Database, ref: []const u8) !RegisterID {
    var arena = std.heap.ArenaAllocator.init(db.gpa);
    defer arena.deinit();

    const register_name, const struct_ref = try get_ref_last_component(ref);
    const struct_id = try db.get_struct_ref(struct_ref orelse return error.InvalidRef);
    const register = try db.get_register_by_name(arena.allocator(), struct_id, register_name);
    return register.id;
}

pub fn set_register_field_enum_id(db: *Database, register_id: RegisterID, field_name: []const u8, enum_id: EnumID) !void {
    try db.exec(
        \\UPDATE struct_fields
        \\SET enum_id = ?
        \\WHERE struct_id = (
        \\    SELECT struct_id
        \\    FROM registers
        \\    WHERE id = ?
        \\)
        \\AND name = ?;
    , .{
        .enum_id = enum_id,
        .register_id = register_id,
        .name = field_name,
    });

    log.debug("set_register_field_enum_id: register_id={} field_name={s} enum_id={}", .{
        register_id,
        field_name,
        enum_id,
    });
}

pub fn cleanup_unused_enums(db: *Database) !void {
    try db.exec(
        \\DELETE FROM enums
        \\WHERE id NOT IN (
        \\    SELECT DISTINCT enum_id
        \\    FROM struct_fields
        \\    WHERE enum_id IS NOT NULL
        \\)
    , .{});
}

pub fn apply_patch(db: *Database, ndjson: []const u8) !void {
    var list = std.ArrayList(std.json.Parsed(Patch)).init(db.gpa);
    defer {
        for (list.items) |*entry| entry.deinit();
        list.deinit();
    }

    var line_it = std.mem.tokenizeScalar(u8, ndjson, '\n');
    while (line_it.next()) |line| {
        const p = try Patch.from_json_str(db.gpa, line);
        errdefer p.deinit();
        try list.append(p);
    }

    for (list.items) |patch| {
        switch (patch.value) {
            .override_arch => |override_arch| {
                const device_id = try db.get_device_id_by_name(override_arch.device_name) orelse {
                    return error.DeviceNotFound;
                };

                try db.exec(
                    \\UPDATE devices
                    \\SET arch = ?
                    \\WHERE id = ?;
                , .{
                    .arch = override_arch.arch,
                    .device_id = device_id,
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
                const enum_id = try db.get_enum_ref(set_enum_type.to);
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

pub fn to_zig(db: *Database, out_writer: anytype, opts: ToZigOptions) !void {
    try gen.to_zig(db, out_writer, opts);
}

test "all" {
    @setEvalBranchQuota(2000);
    _ = atdf;
    _ = gen;
    _ = svd;
}
