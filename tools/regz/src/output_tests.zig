//! Common test conditions for code generation and regzon
const std = @import("std");
const Allocator = std.mem.Allocator;

const Database = @import("Database.zig");

pub fn peripheral_type_with_register_and_field(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
        .description = "test peripheral",
    });

    const struct_id = try db.get_peripheral_struct(peripheral_id);

    const register_id = try db.create_register(struct_id, .{
        .name = "TEST_REGISTER",
        .description = "test register",
        .size_bits = 32,
        .offset_bytes = 0,
    });

    try db.add_register_field(register_id, .{
        .name = "TEST_FIELD",
        .description = "test field",
        .size_bits = 1,
        .offset_bits = 0,
    });

    return db;
}

pub fn peripheral_instantiation(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });
    const struct_id = try db.get_peripheral_struct(peripheral_id);

    const register_id = try db.create_register(struct_id, .{
        .name = "TEST_REGISTER",
        .size_bits = 32,
        .offset_bytes = 0,
        .reset_mask = 0x1,
        .reset_value = 0x1,
    });

    _ = try db.add_register_field(register_id, .{
        .name = "TEST_FIELD",
        .size_bits = 1,
        .offset_bits = 0,
    });

    const device_id = try db.create_device(.{
        .name = "TEST_DEVICE",
        .arch = .cortex_m0,
    });

    _ = try db.create_device_peripheral(device_id, .{
        .name = "TEST0",
        .offset_bytes = 0x1000,
        .struct_id = struct_id,
    });

    return db;
}

pub fn peripherals_with_shared_type(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });

    const struct_id = try db.get_peripheral_struct(peripheral_id);

    const register_id = try db.create_register(struct_id, .{
        .name = "TEST_REGISTER",
        .size_bits = 32,
        .offset_bytes = 0,
    });

    try db.add_register_field(register_id, .{
        .name = "TEST_FIELD",
        .size_bits = 1,
        .offset_bits = 0,
    });

    const device_id = try db.create_device(.{
        .name = "TEST_DEVICE",
        .arch = .cortex_m0,
    });

    _ = try db.create_device_peripheral(
        device_id,
        .{
            .name = "TEST0",
            .offset_bytes = 0x1000,
            .struct_id = struct_id,
        },
    );
    _ = try db.create_device_peripheral(
        device_id,
        .{
            .name = "TEST1",
            .offset_bytes = 0x2000,
            .struct_id = struct_id,
        },
    );

    return db;
}

pub fn peripheral_with_modes(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{ .name = "TEST_PERIPHERAL" });
    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const register1_id = try db.create_register(
        struct_id,
        .{ .name = "TEST_REGISTER1", .size_bits = 32, .offset_bytes = 0 },
    );
    const register2_id = try db.create_register(
        struct_id,
        .{ .name = "TEST_REGISTER2", .size_bits = 32, .offset_bytes = 0 },
    );
    const common_reg_id = try db.create_register(
        struct_id,
        .{ .name = "COMMON_REGISTER", .size_bits = 32, .offset_bytes = 4 },
    );

    try db.add_register_field(common_reg_id, .{
        .name = "TEST_FIELD",
        .size_bits = 1,
        .offset_bits = 0,
    });

    const mode1_id = try db.create_mode(struct_id, .{
        .name = "TEST_MODE1",
        .value = "0x00",
        .qualifier = "TEST_PERIPHERAL.TEST_MODE1.COMMON_REGISTER.TEST_FIELD",
    });
    const mode2_id = try db.create_mode(struct_id, .{
        .name = "TEST_MODE2",
        .value = "0x01",
        .qualifier = "TEST_PERIPHERAL.TEST_MODE2.COMMON_REGISTER.TEST_FIELD",
    });

    try db.add_register_mode(register1_id, mode1_id);
    try db.add_register_mode(register2_id, mode2_id);

    return db;
}

pub fn peripheral_with_enum(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });

    const struct_id = try db.get_peripheral_struct(peripheral_id);

    const enum_id = try db.create_enum(struct_id, .{
        .name = "TEST_ENUM",
        .size_bits = 4,
    });

    try db.add_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD1", .value = 0 });
    try db.add_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD2", .value = 1 });

    _ = try db.create_register(struct_id, .{
        .name = "TEST_REGISTER",
        .size_bits = 8,
        .offset_bytes = 0,
    });

    return db;
}

pub fn peripheral_with_enum_and_its_exhausted_of_values(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });

    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const enum_id = try db.create_enum(struct_id, .{
        .name = "TEST_ENUM",
        .size_bits = 1,
    });

    try db.add_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD1", .value = 0 });
    try db.add_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD2", .value = 1 });

    _ = try db.create_register(struct_id, .{
        .name = "TEST_REGISTER",
        .size_bits = 8,
        .offset_bytes = 0,
    });

    return db;
}

pub fn field_with_named_enum(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });

    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const enum_id = try db.create_enum(struct_id, .{
        .name = "TEST_ENUM",
        .size_bits = 4,
    });

    try db.add_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD1", .value = 0 });
    try db.add_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD2", .value = 1 });

    const register_id = try db.create_register(struct_id, .{
        .name = "TEST_REGISTER",
        .size_bits = 8,
        .offset_bytes = 0,
    });

    try db.add_register_field(register_id, .{
        .name = "TEST_FIELD",
        .size_bits = 4,
        .offset_bits = 0,
        .enum_id = enum_id,
    });

    return db;
}

pub fn field_with_named_enum_and_named_default(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });

    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const enum_id = try db.create_enum(struct_id, .{
        .name = "TEST_ENUM",
        .size_bits = 4,
    });

    try db.add_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD1", .value = 0 });
    try db.add_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD2", .value = 1 });

    const register_id = try db.create_register(struct_id, .{
        .name = "TEST_REGISTER",
        .size_bits = 8,
        .offset_bytes = 0,
        .reset_mask = 0xF,
        .reset_value = 0x1,
    });

    try db.add_register_field(register_id, .{
        .name = "TEST_FIELD",
        .size_bits = 4,
        .offset_bits = 0,
        .enum_id = enum_id,
    });

    return db;
}

pub fn field_with_anonymous_enum(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });

    const enum_id = try db.create_enum(null, .{
        .size_bits = 4,
    });

    try db.add_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD1", .value = 0 });
    try db.add_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD2", .value = 1 });

    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const register_id = try db.create_register(struct_id, .{
        .name = "TEST_REGISTER",
        .size_bits = 8,
        .offset_bytes = 0,
    });

    try db.add_register_field(register_id, .{
        .name = "TEST_FIELD",
        .size_bits = 4,
        .offset_bits = 0,
        .enum_id = enum_id,
    });

    return db;
}

pub fn field_with_anonymous_enum_and_default(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });

    const enum_id = try db.create_enum(null, .{
        .size_bits = 4,
    });

    try db.add_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD1", .value = 0 });
    try db.add_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD2", .value = 1 });

    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const register_id = try db.create_register(struct_id, .{
        .name = "TEST_REGISTER",
        .size_bits = 8,
        .offset_bytes = 0,
        .reset_mask = 0xF,
        .reset_value = 0x1,
    });

    try db.add_register_field(register_id, .{
        .name = "TEST_FIELD",
        .size_bits = 4,
        .offset_bits = 0,
        .enum_id = enum_id,
    });

    return db;
}

pub fn namespaced_register_groups(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    // peripheral
    const peripheral_id = try db.create_peripheral(.{
        .name = "PORT",
    });
    const struct_id = try db.get_peripheral_struct(peripheral_id);

    // register_groups
    const portb_group_id = try db.create_nested_struct(struct_id, .{ .name = "PORTB" });
    const portc_group_id = try db.create_nested_struct(struct_id, .{ .name = "PORTC" });

    // registers
    _ = try db.create_register(portb_group_id, .{ .name = "PORTB", .size_bits = 8, .offset_bytes = 0 });
    _ = try db.create_register(portb_group_id, .{ .name = "DDRB", .size_bits = 8, .offset_bytes = 1 });
    _ = try db.create_register(portb_group_id, .{ .name = "PINB", .size_bits = 8, .offset_bytes = 2 });
    _ = try db.create_register(portc_group_id, .{ .name = "PORTC", .size_bits = 8, .offset_bytes = 0 });
    _ = try db.create_register(portc_group_id, .{ .name = "DDRC", .size_bits = 8, .offset_bytes = 1 });
    _ = try db.create_register(portc_group_id, .{ .name = "PINC", .size_bits = 8, .offset_bytes = 2 });

    // device
    const device_id = try db.create_device(.{ .name = "ATmega328P", .arch = .avr8 });

    // instances
    _ = try db.create_device_peripheral(device_id, .{
        .name = "PORTB",
        .offset_bytes = 0x23,
        .struct_id = portb_group_id,
    });

    _ = try db.create_device_peripheral(device_id, .{
        .name = "PORTC",
        .offset_bytes = 0x26,
        .struct_id = portc_group_id,
    });

    return db;
}

pub fn peripheral_with_reserved_register(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "PORTB",
    });
    const struct_id = try db.get_peripheral_struct(peripheral_id);

    _ = try db.create_register(struct_id, .{ .name = "PORTB", .size_bits = 32, .offset_bytes = 0 });
    _ = try db.create_register(struct_id, .{ .name = "PINB", .size_bits = 32, .offset_bytes = 8 });

    const device_id = try db.create_device(.{
        .name = "ATmega328P",
        .arch = .avr8,
    });

    _ = try db.create_device_peripheral(device_id, .{
        .name = "PORTB",
        .offset_bytes = 0x23,
        .struct_id = struct_id,
    });

    return db;
}

pub fn peripheral_with_count(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const device_id = try db.create_device(.{ .name = "ATmega328P", .arch = .avr8 });

    const peripheral_id = try db.create_peripheral(.{
        .name = "PORTB",
        .size_bytes = 3,
    });

    const struct_id = try db.get_peripheral_struct(peripheral_id);
    _ = try db.create_device_peripheral(device_id, .{
        .name = "PORTB",
        .offset_bytes = 0x23,
        .count = 4,
        .struct_id = struct_id,
    });

    _ = try db.create_register(struct_id, .{ .name = "PORTB", .size_bits = 8, .offset_bytes = 0 });
    _ = try db.create_register(struct_id, .{ .name = "DDRB", .size_bits = 8, .offset_bytes = 1 });
    _ = try db.create_register(struct_id, .{ .name = "PINB", .size_bits = 8, .offset_bytes = 2 });

    return db;
}

pub fn peripheral_with_count_padding_required(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const device_id = try db.create_device(.{ .name = "ATmega328P", .arch = .avr8 });

    const peripheral_id = try db.create_peripheral(.{
        .name = "PORTB",
        .size_bytes = 4,
    });

    const struct_id = try db.get_peripheral_struct(peripheral_id);

    _ = try db.create_device_peripheral(device_id, .{
        .name = "PORTB",
        .offset_bytes = 0x23,
        .count = 4,
        .struct_id = struct_id,
    });

    _ = try db.create_register(struct_id, .{ .name = "PORTB", .size_bits = 8, .offset_bytes = 0 });
    _ = try db.create_register(struct_id, .{ .name = "DDRB", .size_bits = 8, .offset_bytes = 1 });
    _ = try db.create_register(struct_id, .{ .name = "PINB", .size_bits = 8, .offset_bytes = 2 });

    return db;
}

pub fn register_with_count(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const device_id = try db.create_device(.{
        .name = "ATmega328P",
        .arch = .avr8,
    });

    const peripheral_id = try db.create_peripheral(.{
        .name = "PORTB",
    });
    const struct_id = try db.get_peripheral_struct(peripheral_id);

    _ = try db.create_device_peripheral(device_id, .{
        .name = "PORTB",
        .offset_bytes = 0x23,
        .struct_id = struct_id,
    });

    _ = try db.create_register(struct_id, .{ .name = "PORTB", .size_bits = 8, .offset_bytes = 0, .count = 4 });
    _ = try db.create_register(struct_id, .{ .name = "DDRB", .size_bits = 8, .offset_bytes = 4 });
    _ = try db.create_register(struct_id, .{ .name = "PINB", .size_bits = 8, .offset_bytes = 5 });

    return db;
}

pub fn register_with_count_and_fields(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const device_id = try db.create_device(.{
        .name = "ATmega328P",
        .arch = .avr8,
    });

    const peripheral_id = try db.create_peripheral(.{
        .name = "PORTB",
    });

    const struct_id = try db.get_peripheral_struct(peripheral_id);

    _ = try db.create_device_peripheral(device_id, .{
        .name = "PORTB",
        .offset_bytes = 0x23,
        .struct_id = struct_id,
    });

    const portb_id = try db.create_register(struct_id, .{
        .name = "PORTB",
        .size_bits = 8,
        .offset_bytes = 0,
        .count = 4,
    });

    _ = try db.create_register(struct_id, .{ .name = "DDRB", .size_bits = 8, .offset_bytes = 4 });
    _ = try db.create_register(struct_id, .{ .name = "PINB", .size_bits = 8, .offset_bytes = 5 });

    try db.add_register_field(portb_id, .{
        .name = "TEST_FIELD",
        .size_bits = 4,
        .offset_bits = 0,
    });

    return db;
}

pub fn field_with_count_width_of_one_offset_and_padding(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "PORTB",
    });

    const struct_id = try db.get_peripheral_struct(peripheral_id);

    const portb_id = try db.create_register(struct_id, .{
        .name = "PORTB",
        .size_bits = 8,
        .offset_bytes = 0,
    });

    inline for (0..5) |i| {
        const suffix = std.fmt.comptimePrint("{d}", .{i});
        try db.add_register_field(portb_id, .{
            .name = "TEST_FIELD" ++ suffix,
            .size_bits = 1,
            .offset_bits = 2 + i,
        });
    }

    return db;
}

pub fn field_with_count_multi_bit_width_offset_and_padding(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "PORTB",
    });

    const struct_id = try db.get_peripheral_struct(peripheral_id);

    const portb_id = try db.create_register(struct_id, .{
        .name = "PORTB",
        .size_bits = 8,
        .offset_bytes = 0,
    });

    inline for (0..2) |i| {
        const suffix = std.fmt.comptimePrint("{d}", .{i});
        try db.add_register_field(portb_id, .{
            .name = "TEST_FIELD" ++ suffix,
            .size_bits = 2,
            .offset_bits = 2 + (i * 2),
        });
    }

    return db;
}

pub fn interrupts_avr(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const device_id = try db.create_device(.{
        .name = "ATmega328P",
        .arch = .avr8,
    });

    _ = try db.create_interrupt(device_id, .{
        .name = "TEST_VECTOR1",
        .idx = 1,
    });

    _ = try db.create_interrupt(device_id, .{
        .name = "TEST_VECTOR2",
        .idx = 3,
    });

    return db;
}

pub fn enums_with_name_collision(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });

    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const enum1_id = try db.create_enum(struct_id, .{
        .name = "ENUM",
        .size_bits = 4,
    });

    try db.add_enum_field(enum1_id, .{ .name = "TEST_ENUM_FIELD1", .value = 0 });
    try db.add_enum_field(enum1_id, .{ .name = "TEST_ENUM_FIELD2", .value = 1 });

    const enum2_id = try db.create_enum(struct_id, .{
        .name = "ENUM",
        .size_bits = 4,
    });

    try db.add_enum_field(enum2_id, .{ .name = "TEST_ENUM_FIELD1", .value = 0 });
    try db.add_enum_field(enum2_id, .{ .name = "TEST_ENUM_FIELD2", .value = 1 });

    const register_id = try db.create_register(struct_id, .{
        .name = "TEST_REGISTER",
        .size_bits = 8,
        .offset_bytes = 0,
    });

    try db.add_register_field(register_id, .{
        .name = "TEST_FIELD1",
        .size_bits = 4,
        .offset_bits = 0,
        .enum_id = enum1_id,
    });
    try db.add_register_field(register_id, .{
        .name = "TEST_FIELD2",
        .size_bits = 4,
        .offset_bits = 4,
        .enum_id = enum2_id,
    });

    return db;
}

pub fn field_with_named_enum_and_unnamed_default(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });

    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const enum_id = try db.create_enum(struct_id, .{
        .name = "TEST_ENUM",
        .size_bits = 4,
    });

    try db.add_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD1", .value = 0 });
    try db.add_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD2", .value = 1 });

    const register_id = try db.create_register(struct_id, .{
        .name = "TEST_REGISTER",
        .size_bits = 8,
        .offset_bytes = 0,
        .reset_mask = 0xF,
        .reset_value = 0xA,
    });

    try db.add_register_field(register_id, .{
        .name = "TEST_FIELD",
        .size_bits = 4,
        .offset_bits = 0,
        .enum_id = enum_id,
    });

    return db;
}

pub fn enum_with_value_collision(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });

    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const enum_id = try db.create_enum(null, .{
        .name = "ENUM",
        .size_bits = 4,
    });

    try db.add_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD1", .value = 0 });
    try db.add_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD2", .value = 0 });

    const register_id = try db.create_register(struct_id, .{
        .name = "TEST_REGISTER",
        .size_bits = 8,
        .offset_bytes = 0,
    });

    try db.add_register_field(register_id, .{
        .name = "TEST_FIELD",
        .size_bits = 4,
        .offset_bits = 0,
        .enum_id = enum_id,
    });
    return db;
}

pub fn enum_fields_with_name_collision(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
    });

    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const enum_id = try db.create_enum(null, .{
        .name = "ENUM",
        .size_bits = 4,
    });

    try db.add_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD1", .value = 0 });
    try db.add_enum_field(enum_id, .{ .name = "TEST_ENUM_FIELD1", .value = 1 });

    const register_id = try db.create_register(struct_id, .{
        .name = "TEST_REGISTER",
        .size_bits = 8,
        .offset_bytes = 0,
    });

    try db.add_register_field(register_id, .{
        .name = "TEST_FIELD",
        .size_bits = 4,
        .offset_bits = 0,
        .enum_id = enum_id,
    });
    return db;
}

pub fn register_fields_with_name_collision(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
        .description = "test peripheral",
    });

    const struct_id = try db.get_peripheral_struct(peripheral_id);

    const register_id = try db.create_register(struct_id, .{
        .name = "TEST_REGISTER",
        .description = "test register",
        .size_bits = 32,
        .offset_bytes = 0,
    });

    try db.add_register_field(register_id, .{
        .name = "TEST_FIELD",
        .description = "test field 1",
        .size_bits = 1,
        .offset_bits = 0,
    });
    try db.add_register_field(register_id, .{
        .name = "TEST_FIELD",
        .description = "test field 2",
        .size_bits = 1,
        .offset_bits = 1,
    });

    return db;
}

pub fn nested_struct_field_in_a_peripheral(allocator: Allocator, offset_bytes: u64) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
        .description = "test peripheral",
    });

    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const nested_struct_id = try db.create_struct(.{});

    const register_id = try db.create_register(nested_struct_id, .{
        .name = "TEST_REGISTER",
        .description = "test register",
        .size_bits = 32,
        .offset_bytes = 0,
    });

    try db.add_register_field(register_id, .{
        .name = "TEST_FIELD",
        .description = "test field 1",
        .size_bits = 1,
        .offset_bits = 0,
    });

    try db.add_nested_struct_field(struct_id, .{
        .name = "TEST_NESTED",
        .description = "test nested struct",
        .offset_bytes = offset_bytes,
        .struct_id = nested_struct_id,
    });

    return db;
}

pub fn nested_struct_field_in_a_peripheral_that_has_a_named_type(allocator: Allocator, offset_bytes: u64) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
        .description = "test peripheral",
    });

    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const nested_struct_id = try db.create_nested_struct(struct_id, .{
        .name = "TEST_NESTED_TYPE",
    });

    const register_id = try db.create_register(nested_struct_id, .{
        .name = "TEST_REGISTER",
        .description = "test register",
        .size_bits = 32,
        .offset_bytes = 0,
    });

    try db.add_register_field(register_id, .{
        .name = "TEST_FIELD",
        .description = "test field 1",
        .size_bits = 1,
        .offset_bits = 0,
    });

    try db.add_nested_struct_field(struct_id, .{
        .name = "TEST_NESTED",
        .description = "test nested struct",
        .offset_bytes = offset_bytes,
        .struct_id = nested_struct_id,
    });

    return db;
}

pub fn nested_struct_field_in_a_nested_struct_field(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
        .description = "test peripheral",
    });

    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const nested_struct_id = try db.create_struct(.{});
    const nested_nested_struct_id = try db.create_struct(.{});

    const register_id = try db.create_register(nested_nested_struct_id, .{
        .name = "TEST_REGISTER",
        .description = "test register",
        .size_bits = 32,
        .offset_bytes = 0,
    });

    try db.add_register_field(register_id, .{
        .name = "TEST_FIELD",
        .description = "test field 1",
        .size_bits = 1,
        .offset_bits = 0,
    });

    try db.add_nested_struct_field(struct_id, .{
        .name = "TEST_NESTED",
        .description = "test nested struct",
        .offset_bytes = 0,
        .struct_id = nested_struct_id,
    });

    try db.add_nested_struct_field(nested_struct_id, .{
        .name = "TEST_NESTED_NESTED",
        .offset_bytes = 0,
        .struct_id = nested_nested_struct_id,
    });

    return db;
}

pub fn nested_struct_field_next_to_register(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{
        .name = "TEST_PERIPHERAL",
        .description = "test peripheral",
    });

    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const nested_struct_id = try db.create_nested_struct(struct_id, .{
        .name = "TEST_NESTED_TYPE",
    });

    const register1_id = try db.create_register(nested_struct_id, .{
        .name = "TEST_REGISTER",
        .description = "test register",
        .size_bits = 32,
        .offset_bytes = 0,
    });

    try db.add_register_field(register1_id, .{
        .name = "TEST_FIELD",
        .description = "test field 1",
        .size_bits = 1,
        .offset_bits = 0,
    });

    try db.add_nested_struct_field(struct_id, .{
        .name = "TEST_NESTED",
        .description = "test nested struct",
        .offset_bytes = 0,
        .struct_id = nested_struct_id,
    });

    const register2_id = try db.create_register(struct_id, .{
        .name = "TEST_REGISTER",
        .description = "test register",
        .size_bits = 32,
        .offset_bytes = 4,
    });

    try db.add_register_field(register2_id, .{
        .name = "TEST_FIELD",
        .description = "test field 1",
        .size_bits = 1,
        .offset_bits = 0,
    });

    return db;
}

pub fn register_with_decl(allocator: Allocator) !*Database {
    var db = try Database.create(allocator);
    errdefer db.destroy();

    const peripheral_id = try db.create_peripheral(.{ .name = "TEST_PERIPHERAL" });

    const struct_id = try db.get_peripheral_struct(peripheral_id);
    const register_id = try db.create_register(struct_id, .{
        .name = "TEST_REGISTER",
        .size_bits = 32,
        .offset_bytes = 0,
    });

    try db.add_register_field(register_id, .{
        .name = "TEST_FIELD",
        .size_bits = 1,
        .offset_bits = 0,
    });

    try db.create_register_decl(struct_id, register_id, "REGISTER_DECL", .{});

    return db;
}
