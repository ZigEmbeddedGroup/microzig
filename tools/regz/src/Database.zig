gpa: Allocator,
arena: *ArenaAllocator,
next_entity_id: u32,

// attributes are extra information that each entity might have, in some
// contexts they're required, in others they're optional
attrs: struct {
    name: HashMap(EntityId, []const u8) = .{},
    description: HashMap(EntityId, []const u8) = .{},
    offset: HashMap(EntityId, u64) = .{},
    access: HashMap(EntityId, Access) = .{},
    group: HashMap(EntityId, void) = .{},
    count: HashMap(EntityId, u64) = .{},
    size: HashMap(EntityId, u64) = .{},
    reset_value: HashMap(EntityId, u64) = .{},
    reset_mask: HashMap(EntityId, u64) = .{},
    version: HashMap(EntityId, []const u8) = .{},

    // a register or bitfield can be valid in one or more modes of their parent
    modes: HashMap(EntityId, Modes) = .{},

    // a field type might have an enum type. This is an array hash map
    // because it's iterated when inferring enum size
    @"enum": ArrayHashMap(EntityId, EntityId) = .{},

    parent: HashMap(EntityId, EntityId) = .{},
} = .{},

children: struct {
    modes: ArrayHashMap(EntityId, EntitySet) = .{},
    interrupts: ArrayHashMap(EntityId, EntitySet) = .{},
    peripherals: ArrayHashMap(EntityId, EntitySet) = .{},
    register_groups: ArrayHashMap(EntityId, EntitySet) = .{},
    registers: ArrayHashMap(EntityId, EntitySet) = .{},
    fields: ArrayHashMap(EntityId, EntitySet) = .{},
    enums: ArrayHashMap(EntityId, EntitySet) = .{},
    enum_fields: ArrayHashMap(EntityId, EntitySet) = .{},
} = .{},

types: struct {
    // atdf has modes which make registers into unions
    modes: ArrayHashMap(EntityId, Mode) = .{},

    peripherals: ArrayHashMap(EntityId, void) = .{},
    register_groups: ArrayHashMap(EntityId, void) = .{},
    registers: ArrayHashMap(EntityId, void) = .{},
    fields: ArrayHashMap(EntityId, void) = .{},
    enums: ArrayHashMap(EntityId, void) = .{},
    enum_fields: ArrayHashMap(EntityId, u32) = .{},
} = .{},

instances: struct {
    devices: ArrayHashMap(EntityId, Device) = .{},
    interrupts: ArrayHashMap(EntityId, i32) = .{},
    peripherals: ArrayHashMap(EntityId, EntityId) = .{},
} = .{},

const std = @import("std");
const Allocator = std.mem.Allocator;
const ArenaAllocator = std.heap.ArenaAllocator;
const assert = std.debug.assert;
const HashMap = std.AutoHashMapUnmanaged;
const ArrayHashMap = std.AutoArrayHashMapUnmanaged;

const xml = @import("xml.zig");
const svd = @import("svd.zig");
const atdf = @import("atdf.zig");
const dslite = @import("dslite.zig");
const gen = @import("gen.zig");
const regzon = @import("regzon.zig");

const TypeOfField = @import("testing.zig").TypeOfField;

const Database = @This();
const log = std.log.scoped(.database);

pub const EntityId = u32;
pub const EntitySet = ArrayHashMap(EntityId, void);
pub const RegisterKind = enum { register, register_group };

// concrete arch's that we support in codegen, for stuff like interrupt
// table generation
pub const Arch = enum {
    unknown,

    // arm
    arm_v81_mml,
    arm_v8_mbl,
    arm_v8_mml,
    cortex_a15,
    cortex_a17,
    cortex_a5,
    cortex_a53,
    cortex_a57,
    cortex_a7,
    cortex_a72,
    cortex_a8,
    cortex_a9,
    cortex_m0,
    cortex_m0plus,
    cortex_m1,
    cortex_m23,
    cortex_m3,
    cortex_m33,
    cortex_m35p,
    cortex_m4,
    cortex_m55,
    cortex_m7,
    sc000, // kindof like an m3
    sc300,
    // old
    arm926ej_s,

    // avr
    avr8,
    avr8l,
    avr8x,
    avr8xmega,

    // mips
    mips,

    pub fn to_string(arch: Arch) []const u8 {
        return inline for (@typeInfo(Arch).Enum.fields) |field| {
            if (@field(Arch, field.name) == arch)
                break field.name;
        } else unreachable;
    }

    pub fn is_arm(arch: Arch) bool {
        return switch (arch) {
            .cortex_m0,
            .cortex_m0plus,
            .cortex_m1,
            .sc000, // kindof like an m3
            .cortex_m23,
            .cortex_m3,
            .cortex_m33,
            .cortex_m35p,
            .cortex_m55,
            .sc300,
            .cortex_m4,
            .cortex_m7,
            .arm_v8_mml,
            .arm_v8_mbl,
            .arm_v81_mml,
            .cortex_a5,
            .cortex_a7,
            .cortex_a8,
            .cortex_a9,
            .cortex_a15,
            .cortex_a17,
            .cortex_a53,
            .cortex_a57,
            .cortex_a72,
            .arm926ej_s,
            => true,
            else => false,
        };
    }

    pub fn is_avr(arch: Arch) bool {
        return switch (arch) {
            .avr8,
            .avr8l,
            .avr8x,
            .avr8xmega,
            => true,
            else => false,
        };
    }

    pub fn is_mips(arch: Arch) bool {
        return switch (arch) {
            .mips => true,
            else => false,
        };
    }
};

// not sure how to communicate the *_once values in generated code
// besides adding it to documentation comments
pub const Access = enum {
    read_write,
    read_only,
    write_only,
    write_once,
    read_write_once,
};

pub const Device = struct {
    arch: Arch,
    properties: std.StringHashMapUnmanaged([]const u8) = .{},

    pub fn deinit(self: *Device, gpa: Allocator) void {
        self.properties.deinit(gpa);
    }
};

pub const Mode = struct {
    qualifier: []const u8,
    value: []const u8,
};

/// a collection of modes that applies to a register or bitfield
pub const Modes = EntitySet;

fn deinit_map_and_values(allocator: std.mem.Allocator, map: anytype) void {
    var it = map.iterator();
    while (it.next()) |entry|
        entry.value_ptr.deinit(allocator);

    map.deinit(allocator);
}

pub fn deinit(db: *Database) void {
    // attrs
    db.attrs.name.deinit(db.gpa);
    db.attrs.description.deinit(db.gpa);
    db.attrs.offset.deinit(db.gpa);
    db.attrs.access.deinit(db.gpa);
    db.attrs.group.deinit(db.gpa);
    db.attrs.count.deinit(db.gpa);
    db.attrs.size.deinit(db.gpa);
    db.attrs.reset_value.deinit(db.gpa);
    db.attrs.reset_mask.deinit(db.gpa);
    db.attrs.version.deinit(db.gpa);
    db.attrs.@"enum".deinit(db.gpa);
    db.attrs.parent.deinit(db.gpa);
    deinit_map_and_values(db.gpa, &db.attrs.modes);

    // children
    deinit_map_and_values(db.gpa, &db.children.interrupts);
    deinit_map_and_values(db.gpa, &db.children.peripherals);
    deinit_map_and_values(db.gpa, &db.children.register_groups);
    deinit_map_and_values(db.gpa, &db.children.registers);
    deinit_map_and_values(db.gpa, &db.children.fields);
    deinit_map_and_values(db.gpa, &db.children.enums);
    deinit_map_and_values(db.gpa, &db.children.enum_fields);
    deinit_map_and_values(db.gpa, &db.children.modes);

    // types
    db.types.peripherals.deinit(db.gpa);
    db.types.register_groups.deinit(db.gpa);
    db.types.registers.deinit(db.gpa);
    db.types.fields.deinit(db.gpa);
    db.types.enums.deinit(db.gpa);
    db.types.enum_fields.deinit(db.gpa);
    db.types.modes.deinit(db.gpa);

    // instances
    deinit_map_and_values(db.gpa, &db.instances.devices);
    db.instances.interrupts.deinit(db.gpa);
    db.instances.peripherals.deinit(db.gpa);

    db.arena.deinit();
    db.gpa.destroy(db.arena);
}

pub fn init(allocator: std.mem.Allocator) !Database {
    const arena = try allocator.create(ArenaAllocator);
    arena.* = std.heap.ArenaAllocator.init(allocator);
    return Database{
        .gpa = allocator,
        .arena = arena,
        .next_entity_id = 0,
    };
}

// TODO: figure out how to do completions: bash, zsh, fish, powershell, cmd
fn init_from_atdf_xml(allocator: Allocator, doc: xml.Doc) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    try atdf.load_into_db(&db, doc);
    return db;
}

fn init_from_atdf(allocator: Allocator, text: []const u8) !Database {
    var doc = try xml.Doc.from_memory(text);
    defer doc.deinit();

    return init_from_atdf_xml(allocator, doc);
}

fn init_from_svd_xml(allocator: Allocator, doc: xml.Doc) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    try svd.load_into_db(&db, doc);
    return db;
}

fn init_from_svd(allocator: Allocator, text: []const u8) !Database {
    var doc = try xml.Doc.from_memory(text);
    defer doc.deinit();

    return init_from_svd_xml(allocator, doc);
}

fn init_from_dslite_xml(allocator: Allocator, doc: xml.Doc) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    try dslite.load_into_db(&db, doc);
    return db;
}

fn init_from_dslite(allocator: Allocator, text: []const u8) !Database {
    var doc = try xml.Doc.from_memory(text);
    defer doc.deinit();

    return init_from_dslite_xml(allocator, doc);
}

fn init_from_json(allocator: Allocator, text: []const u8) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    try regzon.load_into_db(&db, text);
    return db;
}

pub const Schema = enum {
    atdf,
    dslite,
    json,
    svd,
    xml,
};

pub fn init_from_memory(allocator: Allocator, text: []const u8, schema: ?Schema) !Database {
    if (schema) |s| {
        return switch (s) {
            .json => try Database.init_from_json(allocator, text),
            .atdf => try Database.init_from_atdf(allocator, text),
            .svd => Database.init_from_svd(allocator, text),
            .dslite => Database.init_from_dslite(allocator, text),
            .xml => return error.Todo,
        };
    }

    // try to determine schema
    if (text.len == 0) return error.StreamTooShort;

    if (text[0] == '{')
        return try Database.init_from_json(allocator, text);

    if (text[0] == '<') {
        var doc = try xml.Doc.from_memory(text);
        defer doc.deinit();

        const root = try doc.get_root_element();
        const root_name = root.get_name();
        if (std.mem.eql(u8, root_name, "device"))
            return try Database.init_from_svd_xml(allocator, doc)
        else if (std.mem.eql(u8, root_name, "avr-tools-device-file"))
            return try Database.init_from_atdf_xml(allocator, doc);
    }

    log.err("unable do detect register schema type", .{});
    return error.Explained;
}

pub fn init_from_reader(allocator: Allocator, reader: std.io.AnyReader, schema: ?Schema) !Database {
    var buffered = std.io.bufferedReader(reader);
    const buffered_reader = buffered.reader().any();
    const text = try buffered_reader.readAllAlloc(allocator, std.math.maxInt(usize));
    defer allocator.free(text);
    return init_from_memory(allocator, text, schema);
}

pub fn create_entity(db: *Database) EntityId {
    defer db.next_entity_id += 1;
    return db.next_entity_id;
}

pub fn destroy_entity(db: *Database, id: EntityId) void {
    // note that if something can be a child, you must remove it from the child
    // set of its parent
    switch (db.get_entity_type(id) orelse return) {
        .register => {
            log.debug("{}: destroying register", .{id});
            if (db.attrs.parent.get(id)) |parent_id| {
                if (db.children.registers.getEntry(parent_id)) |entry| {
                    _ = entry.value_ptr.swapRemove(id);
                }
            }

            // if has a parent, remove it from the set
            // remove all attributes

            // TODO: remove fields
            _ = db.types.registers.swapRemove(id);
        },
        .peripheral => {
            log.debug("{}: destroying peripheral", .{id});
            // TODO: remove children
            _ = db.types.peripherals.swapRemove(id);
            _ = db.instances.peripherals.swapRemove(id);
        },
        else => {},
    }

    db.remove_children(id);
    db.remove_attrs(id);
}

fn remove_attrs(db: *Database, id: EntityId) void {
    inline for (@typeInfo(TypeOfField(Database, "attrs")).Struct.fields) |field| {
        if (@hasDecl(field.type, "swapRemove"))
            _ = @field(db.attrs, field.name).swapRemove(id)
        else if (@hasDecl(field.type, "remove"))
            _ = @field(db.attrs, field.name).remove(id)
        else
            unreachable;
    }
}

fn remove_children(db: *Database, id: EntityId) void {
    inline for (@typeInfo(TypeOfField(Database, "children")).Struct.fields) |field| {
        if (@field(db.children, field.name).fetchSwapRemove(id)) |children_entry| {
            var children_set = children_entry.value;
            defer children_set.deinit(db.gpa);

            for (children_set.keys()) |child_id|
                // this will get rid of the parent attr
                db.destroy_entity(child_id);
        }
    }
}

pub fn create_device(
    db: *Database,
    opts: struct {
        // required for now
        name: []const u8,
        description: ?[]const u8 = null,
        arch: Arch = .unknown,
    },
) !EntityId {
    const id = db.create_entity();
    errdefer db.destroy_entity(id);

    log.debug("{}: creating device", .{id});
    try db.instances.devices.put(db.gpa, id, .{
        .arch = opts.arch,
    });

    try db.add_name(id, opts.name);
    if (opts.description) |d|
        try db.add_description(id, d);

    return id;
}

pub fn create_peripheral_instance(
    db: *Database,
    device_id: EntityId,
    type_id: EntityId,
    opts: struct {
        // required for now
        name: []const u8,
        description: ?[]const u8 = null,
        // required for now
        offset: u64,
        // count for an array
        count: ?u64 = null,
    },
) !EntityId {
    assert(db.entity_is("instance.device", device_id));
    assert(db.entity_is("type.peripheral", type_id) or
        db.entity_is("type.register_group", type_id));

    const id = db.create_entity();
    errdefer db.destroy_entity(id);

    log.debug("{}: creating peripheral instance", .{id});
    try db.instances.peripherals.put(db.gpa, id, type_id);
    try db.add_name(id, opts.name);
    try db.add_offset(id, opts.offset);

    if (opts.description) |d|
        try db.add_description(id, d);

    if (opts.count) |c|
        try db.add_count(id, c);

    try db.add_child("instance.peripheral", device_id, id);
    return id;
}

pub fn create_peripheral(
    db: *Database,
    opts: struct {
        name: []const u8,
        description: ?[]const u8 = null,
        size: ?u64 = null,
    },
) !EntityId {
    const id = db.create_entity();
    errdefer db.destroy_entity(id);

    log.debug("{}: creating peripheral", .{id});

    try db.types.peripherals.put(db.gpa, id, {});
    try db.add_name(id, opts.name);

    if (opts.description) |d|
        try db.add_description(id, d);

    if (opts.size) |s|
        try db.add_size(id, s);

    return id;
}

pub fn create_register_group(
    db: *Database,
    parent_id: EntityId,
    opts: struct {
        name: []const u8,
        description: ?[]const u8 = null,
    },
) !EntityId {
    assert(db.entity_is("type.peripheral", parent_id));

    const id = db.create_entity();
    errdefer db.destroy_entity(id);

    log.debug("{}: creating register group", .{id});
    try db.types.register_groups.put(db.gpa, id, {});
    try db.add_name(id, opts.name);

    if (opts.description) |d|
        try db.add_description(id, d);

    try db.add_child("type.register_group", parent_id, id);
    return id;
}

pub fn create_register(
    db: *Database,
    parent_id: EntityId,
    opts: struct {
        // make name required for now
        name: []const u8,
        description: ?[]const u8 = null,
        /// offset is in bytes
        offset: u64,
        /// size is in bits
        size: u64,
        kind: RegisterKind = .register,
        /// count if there is an array
        count: ?u64 = null,
        access: ?Access = null,
        reset_mask: ?u64 = null,
        reset_value: ?u64 = null,
    },
) !EntityId {
    assert(db.entity_is("type.peripheral", parent_id) or
        db.entity_is("type.register_group", parent_id));

    const id = db.create_entity();
    errdefer db.destroy_entity(id);

    log.debug("{}: creating register", .{id});

    try db.types.registers.put(db.gpa, id, {});
    try db.add_name(id, opts.name);
    if (opts.description) |d|
        try db.add_description(id, d);

    try db.add_offset(id, opts.offset);
    try db.add_size(id, opts.size);

    switch (opts.kind) {
        .register => {},
        .register_group => try db.add_group(id),
    }

    if (opts.count) |c|
        try db.add_count(id, c);

    if (opts.access) |a|
        try db.add_access(id, a);

    if (opts.reset_mask) |rm|
        try db.add_reset_mask(id, rm);

    if (opts.reset_value) |rv|
        try db.add_reset_value(id, rv);

    try db.add_child("type.register", parent_id, id);

    return id;
}

pub fn create_field(
    db: *Database,
    parent_id: EntityId,
    opts: struct {
        // make name required for now
        name: []const u8,
        description: ?[]const u8 = null,
        /// offset is in bits
        offset: ?u64 = null,
        /// size is in bits
        size: ?u64 = null,
        enum_id: ?EntityId = null,
        count: ?u64 = null,
    },
) !EntityId {
    assert(db.entity_is("type.register", parent_id));

    const id = db.create_entity();
    errdefer db.destroy_entity(id);

    log.debug("{}: creating field", .{id});
    try db.types.fields.put(db.gpa, id, {});
    try db.add_name(id, opts.name);
    if (opts.description) |d|
        try db.add_description(id, d);

    if (opts.offset) |o|
        try db.add_offset(id, o);

    if (opts.size) |s|
        try db.add_size(id, s);

    if (opts.count) |c|
        try db.add_count(id, c);

    if (opts.enum_id) |enum_id| {
        assert(db.entity_is("type.enum", enum_id));
        if (db.attrs.size.get(enum_id)) |enum_size|
            if (opts.size) |size|
                assert(size == enum_size);

        try db.attrs.@"enum".put(db.gpa, id, enum_id);
    }

    try db.add_child("type.field", parent_id, id);

    return id;
}

pub fn create_enum(
    db: *Database,
    parent_id: EntityId,
    opts: struct {
        name: ?[]const u8 = null,
        description: ?[]const u8 = null,
        size: ?u64 = null,
    },
) !EntityId {
    assert(db.entity_is("type.peripheral", parent_id));

    const id = db.create_entity();
    errdefer db.destroy_entity(id);

    log.debug("{}: creating enum", .{id});
    try db.types.enums.put(db.gpa, id, {});

    if (opts.name) |n|
        try db.add_name(id, n);

    if (opts.description) |d|
        try db.add_description(id, d);

    if (opts.size) |s|
        try db.add_size(id, s);

    try db.add_child("type.enum", parent_id, id);
    return id;
}

pub fn create_enum_field(
    db: *Database,
    parent_id: EntityId,
    opts: struct {
        name: []const u8,
        description: ?[]const u8 = null,
        value: u32,
    },
) !EntityId {
    assert(db.entity_is("type.enum", parent_id));

    const id = db.create_entity();
    errdefer db.destroy_entity(id);

    log.debug("{}: creating enum field", .{id});
    try db.types.enum_fields.put(db.gpa, id, opts.value);
    try db.add_name(id, opts.name);

    if (opts.description) |d|
        try db.add_description(id, d);

    try db.add_child("type.enum_field", parent_id, id);
    return id;
}

pub fn create_mode(db: *Database, parent_id: EntityId, opts: struct {
    name: []const u8,
    description: ?[]const u8 = null,
    value: []const u8,
    qualifier: []const u8,
}) !EntityId {
    // TODO: what types of parents can it have?
    const id = db.create_entity();
    errdefer db.destroy_entity(id);

    log.debug("{}: creating mode", .{id});
    try db.types.modes.put(db.gpa, id, .{
        .value = try db.arena.allocator().dupe(u8, opts.value),
        .qualifier = try db.arena.allocator().dupe(u8, opts.qualifier),
    });
    try db.add_name(id, opts.name);

    if (opts.description) |d|
        try db.add_description(id, d);

    try db.add_child("type.mode", parent_id, id);
    return id;
}

pub fn create_interrupt(db: *Database, device_id: EntityId, opts: struct {
    name: []const u8,
    index: i32,
    description: ?[]const u8 = null,
}) !EntityId {
    assert(db.entity_is("instance.device", device_id));

    const id = db.create_entity();
    errdefer db.destroy_entity(id);

    log.debug("{}: creating interrupt", .{id});
    try db.instances.interrupts.put(db.gpa, id, opts.index);
    try db.add_name(id, opts.name);

    if (opts.description) |d|
        try db.add_description(id, d);

    try db.add_child("instance.interrupt", device_id, id);
    return id;
}

pub fn add_name(db: *Database, id: EntityId, name: []const u8) !void {
    if (name.len == 0)
        return;

    log.debug("{}: adding name: {s}", .{ id, name });
    try db.attrs.name.putNoClobber(
        db.gpa,
        id,
        try db.arena.allocator().dupe(u8, name),
    );
}

pub fn add_description(
    db: *Database,
    id: EntityId,
    description: []const u8,
) !void {
    if (description.len == 0)
        return;

    log.debug("{}: adding description: {s}", .{ id, description });
    try db.attrs.description.putNoClobber(
        db.gpa,
        id,
        try db.arena.allocator().dupe(u8, description),
    );
}

pub fn add_version(db: *Database, id: EntityId, version: []const u8) !void {
    if (version.len == 0)
        return;

    log.debug("{}: adding version: {s}", .{ id, version });
    try db.attrs.version.putNoClobber(
        db.gpa,
        id,
        try db.arena.allocator().dupe(u8, version),
    );
}

pub fn add_size(db: *Database, id: EntityId, size: u64) !void {
    log.debug("{}: adding size: {}", .{ id, size });
    try db.attrs.size.putNoClobber(db.gpa, id, size);
}

pub fn add_offset(db: *Database, id: EntityId, offset: u64) !void {
    log.debug("{}: adding offset: 0x{x}", .{ id, offset });
    try db.attrs.offset.putNoClobber(db.gpa, id, offset);
}

pub fn add_reset_value(db: *Database, id: EntityId, reset_value: u64) !void {
    log.debug("{}: adding reset value: {}", .{ id, reset_value });
    try db.attrs.reset_value.putNoClobber(db.gpa, id, reset_value);
}

pub fn add_reset_mask(db: *Database, id: EntityId, reset_mask: u64) !void {
    log.debug("{}: adding register mask: 0x{x}", .{ id, reset_mask });
    try db.attrs.reset_mask.putNoClobber(db.gpa, id, reset_mask);
}

pub fn add_access(db: *Database, id: EntityId, access: Access) !void {
    log.debug("{}: adding access: {}", .{ id, access });
    try db.attrs.access.putNoClobber(db.gpa, id, access);
}

pub fn add_group(db: *Database, id: EntityId) !void {
    log.debug("{}: adding register group", .{id});
    try db.attrs.group.putNoClobber(db.gpa, id, {});
}

pub fn add_count(db: *Database, id: EntityId, count: u64) !void {
    log.debug("{}: adding count: {}", .{ id, count });
    try db.attrs.count.putNoClobber(db.gpa, id, count);
}

pub fn add_child(
    db: *Database,
    comptime entity_location: []const u8,
    parent_id: EntityId,
    child_id: EntityId,
) !void {
    log.debug("{}: ({s}) is child of: {}", .{
        child_id,
        entity_location,
        parent_id,
    });

    assert(db.entity_is(entity_location, child_id));
    comptime var it = std.mem.tokenizeScalar(u8, entity_location, '.');
    // the tables are in plural form but "type.peripheral" feels better to me
    // for calling this function
    _ = comptime it.next();
    const table = comptime (it.next() orelse unreachable) ++ "s";

    const result = try @field(db.children, table).getOrPut(db.gpa, parent_id);
    if (!result.found_existing)
        result.value_ptr.* = .{};

    try result.value_ptr.put(db.gpa, child_id, {});
    try db.attrs.parent.putNoClobber(db.gpa, child_id, parent_id);
}

pub fn add_device_property(
    db: *Database,
    id: EntityId,
    key: []const u8,
    value: []const u8,
) !void {
    log.debug("{}: adding device attr: {s}={s}", .{ id, key, value });
    if (db.instances.devices.getEntry(id)) |entry|
        try entry.value_ptr.properties.put(
            db.gpa,
            try db.arena.allocator().dupe(u8, key),
            try db.arena.allocator().dupe(u8, value),
        )
    else
        unreachable;
}

// TODO: assert that entity is only found in one table
pub fn entity_is(db: Database, comptime entity_location: []const u8, id: EntityId) bool {
    comptime var it = std.mem.tokenizeScalar(u8, entity_location, '.');
    // the tables are in plural form but "type.peripheral" feels better to me
    // for calling this function
    const group = comptime (it.next() orelse unreachable) ++ "s";
    const table = comptime (it.next() orelse unreachable) ++ "s";

    // TODO: nice error messages, like group should either be 'type' or 'instance'
    return @field(@field(db, group), table).contains(id);
}

pub fn get_entity_id_by_name(
    db: Database,
    comptime entity_location: []const u8,
    name: []const u8,
) !EntityId {
    comptime var tok_it = std.mem.tokenizeScalar(u8, entity_location, '.');
    // the tables are in plural form but "type.peripheral" feels better to me
    // for calling this function
    const group = comptime (tok_it.next() orelse unreachable) ++ "s";
    const table = comptime (tok_it.next() orelse unreachable) ++ "s";

    return for (@field(@field(db, group), table).keys()) |id| {
        const entry_name = db.attrs.name.get(id) orelse continue;
        if (std.mem.eql(u8, name, entry_name)) {
            assert(db.entity_is(entity_location, id));
            return id;
        }
    } else error.NameNotFound;
}

pub const EntityType = enum {
    peripheral,
    register_group,
    register,
    field,
    @"enum",
    enum_field,
    mode,
    device,
    interrupt,
    peripheral_instance,

    pub fn is_instance(entity_type: EntityType) bool {
        return switch (entity_type) {
            .device, .interrupt, .peripheral_instance => true,
            else => false,
        };
    }

    pub fn is_type(entity_type: EntityType) bool {
        return !entity_type.is_type();
    }
};

pub fn get_entity_type(
    db: Database,
    id: EntityId,
) ?EntityType {
    inline for (@typeInfo(TypeOfField(Database, "types")).Struct.fields) |field| {
        if (@field(db.types, field.name).contains(id))
            return @field(EntityType, field.name[0 .. field.name.len - 1]);
    }

    inline for (@typeInfo(TypeOfField(Database, "instances")).Struct.fields) |field| {
        if (@field(db.instances, field.name).contains(id))
            return if (std.mem.eql(u8, "peripheral", field.name))
                .peripheral_instance
            else
                @field(EntityType, field.name[0 .. field.name.len - 1]);
    }

    return null;
}

// assert that the database is in valid state
pub fn assert_valid(db: Database) void {
    // entity id's should only ever be the primary key in one of the type or
    // instance maps.
    var id: u32 = 0;
    while (id < db.next_entity_id) : (id += 1) {
        var count: u32 = 0;
        inline for (.{ "types", "instances" }) |area| {
            inline for (@typeInfo(@TypeOf(@field(db, area))).Struct.fields) |field| {
                if (@field(@field(db, area), field.name).contains(id))
                    count += 1;
            }
        }

        assert(count <= 1); // entity id found in more than one place
    }

    // TODO: check for circular dependencies in relationships
}

/// stringify entire database to JSON, you choose what formatting options you
/// want
pub fn json_stringify(
    db: Database,
    opts: std.json.StringifyOptions,
    writer: anytype,
) !void {
    var obj = try regzon.to_json(db);
    defer obj.deinit();

    try std.json.stringify(obj.value, opts, writer);
}

pub fn format(
    db: Database,
    comptime fmt: []const u8,
    options: std.fmt.FormatOptions,
    writer: anytype,
) !void {
    _ = db;
    _ = options;
    _ = fmt;
    _ = writer;
}

pub fn to_zig(db: Database, out_writer: anytype, standalone: bool) !void {
    try gen.to_zig(db, out_writer, standalone);
}

test "all" {
    @setEvalBranchQuota(2000);
    std.testing.refAllDeclsRecursive(atdf);
    std.testing.refAllDeclsRecursive(dslite);
    std.testing.refAllDeclsRecursive(gen);
    std.testing.refAllDeclsRecursive(regzon);
    std.testing.refAllDeclsRecursive(svd);
}
