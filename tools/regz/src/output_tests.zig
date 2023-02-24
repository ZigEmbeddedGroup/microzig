//! Common test conditions for code generation and regzon
const std = @import("std");
const Allocator = std.mem.Allocator;

const Database = @import("Database.zig");
const EntitySet = Database.EntitySet;

pub fn peripheral_type_with_register_and_field(allocator: Allocator) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
        //.description = "test peripheral",
    });

    const register_id = try db.create_register(peripheral_id, .{
        .name = "TEST_REGISTER",
        //.description = "test register",
        .size = 32,
        .offset = 0,
    });

    _ = try db.create_field(register_id, .{
        .name = "TEST_FIELD",
        //.description = "test field",
        .size = 1,
        .offset = 0,
    });

    return db;
}

pub fn peripheral_instantiation(allocator: Allocator) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });

    const register_id = try db.create_register(peripheral_id, .{
        .name = "TEST_REGISTER",
        .size = 32,
        .offset = 0,
    });

    _ = try db.create_field(register_id, .{
        .name = "TEST_FIELD",
        .size = 1,
        .offset = 0,
    });

    const device_id = try db.create_device(.{
        .name = "TEST_DEVICE",
    });

    _ = try db.create_peripheral_instance(device_id, peripheral_id, .{
        .name = "TEST0",
        .offset = 0x1000,
    });

    return db;
}

pub fn peripherals_with_shared_type(allocator: Allocator) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });

    const register_id = try db.create_register(peripheral_id, .{
        .name = "TEST_REGISTER",
        .size = 32,
        .offset = 0,
    });

    _ = try db.create_field(register_id, .{
        .name = "TEST_FIELD",
        .size = 1,
        .offset = 0,
    });

    const device_id = try db.create_device(.{
        .name = "TEST_DEVICE",
    });

    _ = try db.create_peripheral_instance(device_id, peripheral_id, .{ .name = "TEST0", .offset = 0x1000 });
    _ = try db.create_peripheral_instance(device_id, peripheral_id, .{ .name = "TEST1", .offset = 0x2000 });

    return db;
}

pub fn peripheral_with_modes(allocator: Allocator) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    const mode1_id = db.create_entity();
    try db.add_name(mode1_id, "TEST_MODE1");
    try db.types.modes.put(db.gpa, mode1_id, .{
        .value = "0x00",
        .qualifier = "TEST_PERIPHERAL.TEST_MODE1.COMMON_REGISTER.TEST_FIELD",
    });

    const mode2_id = db.create_entity();
    try db.add_name(mode2_id, "TEST_MODE2");
    try db.types.modes.put(db.gpa, mode2_id, .{
        .value = "0x01",
        .qualifier = "TEST_PERIPHERAL.TEST_MODE2.COMMON_REGISTER.TEST_FIELD",
    });

    var register1_modeset = EntitySet{};
    try register1_modeset.put(db.gpa, mode1_id, {});

    var register2_modeset = EntitySet{};
    try register2_modeset.put(db.gpa, mode2_id, {});

    const peripheral_id = try db.create_peripheral(.{ .name = "TEST_PERIPHERAL" });
    try db.add_child("type.mode", peripheral_id, mode1_id);
    try db.add_child("type.mode", peripheral_id, mode2_id);

    const register1_id = try db.create_register(peripheral_id, .{ .name = "TEST_REGISTER1", .size = 32, .offset = 0 });
    const register2_id = try db.create_register(peripheral_id, .{ .name = "TEST_REGISTER2", .size = 32, .offset = 0 });
    const common_reg_id = try db.create_register(peripheral_id, .{ .name = "COMMON_REGISTER", .size = 32, .offset = 4 });

    try db.attrs.modes.put(db.gpa, register1_id, register1_modeset);
    try db.attrs.modes.put(db.gpa, register2_id, register2_modeset);

    _ = try db.create_field(common_reg_id, .{
        .name = "TEST_FIELD",
        .size = 1,
        .offset = 0,
    });

    // TODO: study the types of qualifiers that come up. it's possible that
    // we'll have to read different registers or read registers without fields.
    //
    // might also have registers with enum values
    // naive implementation goes through each mode and follows the qualifier,
    // next level will determine if they're reading the same address even if
    // different modes will use different union members

    return db;
}

pub fn peripheral_with_enum(allocator: Allocator) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });

    const enum_id = try db.create_enum(peripheral_id, .{
        .name = "TEST_ENUM",
        .size = 4,
    });

    _ = try db.create_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD1", .value = 0 });
    _ = try db.create_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD2", .value = 1 });

    _ = try db.create_register(peripheral_id, .{
        .name = "TEST_REGISTER",
        .size = 8,
        .offset = 0,
    });

    return db;
}

pub fn peripheral_with_enum_and_its_exhausted_of_values(allocator: Allocator) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });

    const enum_id = try db.create_enum(peripheral_id, .{
        .name = "TEST_ENUM",
        .size = 1,
    });

    _ = try db.create_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD1", .value = 0 });
    _ = try db.create_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD2", .value = 1 });

    _ = try db.create_register(peripheral_id, .{
        .name = "TEST_REGISTER",
        .size = 8,
        .offset = 0,
    });

    return db;
}

pub fn field_with_named_enum(allocator: Allocator) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });

    const enum_id = try db.create_enum(peripheral_id, .{
        .name = "TEST_ENUM",
        .size = 4,
    });

    _ = try db.create_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD1", .value = 0 });
    _ = try db.create_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD2", .value = 1 });

    const register_id = try db.create_register(peripheral_id, .{
        .name = "TEST_REGISTER",
        .size = 8,
        .offset = 0,
    });

    _ = try db.create_field(register_id, .{
        .name = "TEST_FIELD",
        .size = 4,
        .offset = 0,
        .enum_id = enum_id,
    });

    return db;
}

pub fn field_with_anonymous_enum(allocator: Allocator) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });

    const enum_id = try db.create_enum(peripheral_id, .{
        .size = 4,
    });

    _ = try db.create_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD1", .value = 0 });
    _ = try db.create_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD2", .value = 1 });

    const register_id = try db.create_register(peripheral_id, .{
        .name = "TEST_REGISTER",
        .size = 8,
        .offset = 0,
    });

    _ = try db.create_field(register_id, .{
        .name = "TEST_FIELD",
        .size = 4,
        .offset = 0,
        .enum_id = enum_id,
    });

    return db;
}

pub fn namespaced_register_groups(allocator: Allocator) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    // peripheral
    const peripheral_id = try db.create_peripheral(.{
        .name = "PORT",
    });

    // register_groups
    const portb_group_id = try db.create_register_group(peripheral_id, .{ .name = "PORTB" });
    const portc_group_id = try db.create_register_group(peripheral_id, .{ .name = "PORTC" });

    // registers
    _ = try db.create_register(portb_group_id, .{ .name = "PORTB", .size = 8, .offset = 0 });
    _ = try db.create_register(portb_group_id, .{ .name = "DDRB", .size = 8, .offset = 1 });
    _ = try db.create_register(portb_group_id, .{ .name = "PINB", .size = 8, .offset = 2 });
    _ = try db.create_register(portc_group_id, .{ .name = "PORTC", .size = 8, .offset = 0 });
    _ = try db.create_register(portc_group_id, .{ .name = "DDRC", .size = 8, .offset = 1 });
    _ = try db.create_register(portc_group_id, .{ .name = "PINC", .size = 8, .offset = 2 });

    // device
    const device_id = try db.create_device(.{ .name = "ATmega328P" });

    // instances
    _ = try db.create_peripheral_instance(device_id, portb_group_id, .{ .name = "PORTB", .offset = 0x23 });
    _ = try db.create_peripheral_instance(device_id, portc_group_id, .{ .name = "PORTC", .offset = 0x26 });

    return db;
}

pub fn peripheral_with_reserved_register(allocator: Allocator) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    const peripheral_id = try db.create_peripheral(.{
        .name = "PORTB",
    });

    _ = try db.create_register(peripheral_id, .{ .name = "PORTB", .size = 32, .offset = 0 });
    _ = try db.create_register(peripheral_id, .{ .name = "PINB", .size = 32, .offset = 8 });

    const device_id = try db.create_device(.{
        .name = "ATmega328P",
    });

    _ = try db.create_peripheral_instance(device_id, peripheral_id, .{
        .name = "PORTB",
        .offset = 0x23,
    });

    return db;
}

pub fn peripheral_with_count(allocator: Allocator) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    const device_id = try db.create_device(.{ .name = "ATmega328P" });

    const peripheral_id = try db.create_peripheral(.{
        .name = "PORTB",
        .size = 3,
    });

    _ = try db.create_peripheral_instance(device_id, peripheral_id, .{
        .name = "PORTB",
        .offset = 0x23,
        .count = 4,
    });

    _ = try db.create_register(peripheral_id, .{ .name = "PORTB", .size = 8, .offset = 0 });
    _ = try db.create_register(peripheral_id, .{ .name = "DDRB", .size = 8, .offset = 1 });
    _ = try db.create_register(peripheral_id, .{ .name = "PINB", .size = 8, .offset = 2 });

    return db;
}

pub fn peripheral_with_count_padding_required(allocator: Allocator) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    const device_id = try db.create_device(.{ .name = "ATmega328P" });

    const peripheral_id = try db.create_peripheral(.{
        .name = "PORTB",
        .size = 4,
    });

    _ = try db.create_peripheral_instance(device_id, peripheral_id, .{
        .name = "PORTB",
        .offset = 0x23,
        .count = 4,
    });

    _ = try db.create_register(peripheral_id, .{ .name = "PORTB", .size = 8, .offset = 0 });
    _ = try db.create_register(peripheral_id, .{ .name = "DDRB", .size = 8, .offset = 1 });
    _ = try db.create_register(peripheral_id, .{ .name = "PINB", .size = 8, .offset = 2 });

    return db;
}

pub fn register_with_count(allocator: Allocator) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    const device_id = try db.create_device(.{ .name = "ATmega328P" });

    const peripheral_id = try db.create_peripheral(.{
        .name = "PORTB",
    });

    _ = try db.create_peripheral_instance(device_id, peripheral_id, .{
        .name = "PORTB",
        .offset = 0x23,
    });

    _ = try db.create_register(peripheral_id, .{ .name = "PORTB", .size = 8, .offset = 0, .count = 4 });
    _ = try db.create_register(peripheral_id, .{ .name = "DDRB", .size = 8, .offset = 4 });
    _ = try db.create_register(peripheral_id, .{ .name = "PINB", .size = 8, .offset = 5 });

    return db;
}

pub fn register_with_count_and_fields(allocator: Allocator) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    const device_id = try db.create_device(.{ .name = "ATmega328P" });

    const peripheral_id = try db.create_peripheral(.{
        .name = "PORTB",
    });

    _ = try db.create_peripheral_instance(device_id, peripheral_id, .{
        .name = "PORTB",
        .offset = 0x23,
    });

    const portb_id = try db.create_register(peripheral_id, .{
        .name = "PORTB",
        .size = 8,
        .offset = 0,
        .count = 4,
    });

    _ = try db.create_register(peripheral_id, .{ .name = "DDRB", .size = 8, .offset = 4 });
    _ = try db.create_register(peripheral_id, .{ .name = "PINB", .size = 8, .offset = 5 });

    _ = try db.create_field(portb_id, .{
        .name = "TEST_FIELD",
        .size = 4,
        .offset = 0,
    });

    return db;
}

pub fn field_with_count_width_of_one_offset_and_padding(allocator: Allocator) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    const peripheral_id = try db.create_peripheral(.{
        .name = "PORTB",
    });

    const portb_id = try db.create_register(peripheral_id, .{
        .name = "PORTB",
        .size = 8,
        .offset = 0,
    });

    _ = try db.create_field(portb_id, .{
        .name = "TEST_FIELD",
        .size = 1,
        .offset = 2,
        .count = 5,
    });

    return db;
}

pub fn field_with_count_multi_bit_width_offset_and_padding(allocator: Allocator) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    const peripheral_id = try db.create_peripheral(.{
        .name = "PORTB",
    });

    const portb_id = try db.create_register(peripheral_id, .{
        .name = "PORTB",
        .size = 8,
        .offset = 0,
    });

    _ = try db.create_field(portb_id, .{
        .name = "TEST_FIELD",
        .size = 2,
        .offset = 2,
        .count = 2,
    });

    return db;
}

pub fn interrupts_avr(allocator: Allocator) !Database {
    var db = try Database.init(allocator);
    errdefer db.deinit();

    const device_id = try db.create_device(.{
        .name = "ATmega328P",
        .arch = .avr8,
    });

    _ = try db.create_interrupt(device_id, .{
        .name = "TEST_VECTOR1",
        .index = 1,
    });

    _ = try db.create_interrupt(device_id, .{
        .name = "TEST_VECTOR2",
        .index = 3,
    });

    return db;
}
