const std = @import("std");
const mdf = @import("../framework.zig");

/// Driver for the DS18B20 1-Wire temperature sensor.
///
/// Supports single drop and multi drop configurations.
/// For multi drop, the ROM code must be used to address individual devices.
/// If no target is provided, the command is sent to all devices on the bus.
/// For a single drop configuration, the target can be omitted because
/// the only device present will be addressed automatically.
///
/// Supports configuration of alarms and resolution.
/// Temperature is returned in Celsius.
/// Supports reading power supply mode (parasite or external).
/// Supports saving and recalling configuration to/from EEPROM.
/// Requires a digital I/O interface and a clock device for timing.
/// Based on the DS18B20 datasheet (https://www.maximintegrated.com/en/products/analog/sensors-and-sensor-interface/DS18B20.html).
pub const DS18B20 = struct {
    const Self = @This();

    pin: mdf.base.Digital_IO,
    clock_dev: mdf.base.Clock_Device,

    // timing constants in microseconds
    const T_RESET_US = 480;
    const T_PRESENCE_WAIT_US = 70;
    const T_SLOT_US = 70;
    const T_WRITE_1_US = 10;
    const T_WRITE_0_US = 60;
    const T_READ_SAMPLE_US = 10;
    const T_RECOVER_US = 1;

    const Command = enum(u8) {

        // ROM commands
        // search_rom = 0xF0, // not implemented
        // alarm_search = 0xEC, // not implemented
        read_rom = 0x33,
        match_rom = 0x55,
        skip_rom = 0xCC,

        // function commands
        convert_t = 0x44,
        write_scratchpad = 0x4E,
        read_scratchpad = 0xBE,
        copy_scratchpad = 0x48,
        reacll_scratchpad = 0xB8,
        read_power_supply = 0xB4,
    };

    pub const Alarms = struct { th: u8, tl: u8 };

    pub const Resolution = enum(u2) {
        half_degree_9 = 0, // 9-bit  (0.5°C)   - 93.75ms max conversion
        quarter_degree_10 = 1, // 10-bit (0.25°C)  - 187.5ms max conversion
        eighth_degree_11 = 2, // 11-bit (0.125°C) - 375ms max conversion
        sixteenth_degree_12 = 3, // 12-bit (0.0625°C)- 750ms max conversion (Default)

        fn factor(self: Resolution) f32 {
            return switch (self) {
                .half_degree_9 => 0.5,
                .quarter_degree_10 => 0.25,
                .eighth_degree_11 => 0.125,
                .sixteenth_degree_12 => 0.0625,
            };
        }

        fn fromInt(value: u2) Resolution {
            return @enumFromInt(value);
        }
    };

    pub const PowerSupply = enum {
        parasite,
        external,
    };

    pub const Error = error{
        device_not_present,
        rom_crc_mismatch,
    };

    pub const RomCode = struct {
        value: [8]u8,
    };

    pub const Config = struct {
        alarms: Alarms,
        resolution: Resolution,
    };

    pub fn init(pin: mdf.base.Digital_IO, clock_dev: mdf.base.Clock_Device) !Self {
        try pin.set_direction(.input);
        return .{ .pin = pin, .clock_dev = clock_dev };
    }

    /// Resets the bus and checks for device presence.
    /// A reset is required to initialize the communication with the device
    /// (see the datasheet for details about the communication protocol).
    /// If any device is present on the bus, it will signal the master its presence
    /// (i.e. pull the line low) as a response to the reset pulse.
    /// Returns true if a device is present, false otherwise.
    pub fn reset(self: *const Self) !bool {
        try self.pin.set_direction(.output);
        try self.pin.write(.low);
        self.clock_dev.sleep_us(T_RESET_US);

        try self.pin.set_direction(.input);
        self.clock_dev.sleep_us(T_PRESENCE_WAIT_US);

        const device_is_present = try self.pin.read();

        self.clock_dev.sleep_us(T_RESET_US - T_PRESENCE_WAIT_US);

        return (device_is_present == .low);
    }

    /// Reads the ROM code of a single device on the bus.
    /// Returns an error if no device is present.
    /// Must only be used if only one device is present on the bus (single drop)
    pub fn read_single_rom_code(self: *const Self) !RomCode {
        if (try self.reset() == false) return Error.device_not_present;

        try self.write_command(.read_rom);

        var rom_code: [8]u8 = undefined;

        for (0..8) |i| {
            rom_code[i] = try self.read_byte();
        }

        if (crc8(&rom_code) != 0) {
            return Error.rom_crc_mismatch;
        }

        return .{ .value = rom_code };
    }

    /// Writes the configuration to the device.
    /// If alarms or resolution are null, the current value is preserved.
    /// An error is returned if the device is not present.
    /// If target is null, the command is sent to all devices on the bus.
    /// The configuration can be saved to EEPROM using save_config_to_eeprom()
    /// and recalled using recall_config_from_eeprom().
    /// The alarms consist of two bytes: TH and TL registers. They can be used
    /// to trigger an alarm when the temperature exceeds the set limits or to
    /// store user data if the alarm functionality is not used.
    pub fn write_config(self: *const Self, args: struct { alarms: ?Alarms = null, resolution: ?Resolution = null, target: ?RomCode = null }) !void {
        if (!(try self.reset())) return error.DeviceNotFound;
        try self.select_target(args.target);

        if (args.alarms == null and args.resolution == null) return;

        const result = blk: {
            if (args.alarms == null or args.resolution == null) {
                try self.write_command(.read_scratchpad);

                _ = try self.read_byte(); // Temperature LSB
                _ = try self.read_byte(); // Temperature MSB
                const th_read = try self.read_byte();
                const tl_read = try self.read_byte();
                const config_read = try self.read_byte();

                break :blk .{
                    if (args.alarms) |alarms| alarms.th else th_read,
                    if (args.alarms) |alarms| alarms.tl else tl_read,
                    if (args.resolution) |_| @as(u8, 0x7F) else config_read,
                };
            } else {
                break :blk .{ args.alarms.?.th, args.alarms.?.tl, @as(u8, 0x7F) };
            }
        };
        const th, const tl, const config = result;

        const new_config: u8 = if (args.resolution) |res| (@as(u8, @intFromEnum(res)) << 5) else config;

        if (!(try self.reset())) return error.DeviceNotFound;
        try self.select_target(args.target);
        try self.write_command(.write_scratchpad);

        try self.write_byte(th);
        try self.write_byte(tl);
        try self.write_byte(new_config);
    }

    /// Reads the configuration from the device.
    /// An error is returned if the device is not present.
    /// If target is null, the command is sent to all devices on the bus.
    /// Returns the alarms (TH and TL registers) and resolution.
    pub fn read_config(self: *const Self, args: struct { target: ?RomCode = null }) !Config {
        if (try self.reset() == false) return Error.device_not_present;

        try self.select_target(args.target);
        try self.write_command(.read_scratchpad);

        _ = try self.read_byte(); // temp LSB
        _ = try self.read_byte(); // temp MSB
        const th = try self.read_byte(); // TH register
        const tl = try self.read_byte(); // TL register
        const config = try self.read_byte();

        const resolution_bits: u2 = @truncate(config >> 5);

        return .{
            .alarms = .{ .th = th, .tl = tl },
            .resolution = .fromInt(resolution_bits),
        };
    }

    /// Saves the current configuration to EEPROM.
    /// An error is returned if the device is not present.
    /// If target is null, the command is sent to all devices on the bus.
    pub fn save_config_to_eeprom(self: *const DS18B20, args: struct { target: ?RomCode = null }) !void {
        if (!(try self.reset())) return error.DeviceNotFound;
        try self.select_target(args.target);
        try self.write_command(.copy_scratchpad);

        // The DS18B20 needs 10ms to write to EEPROM.
        self.clock_dev.sleep_ms(10);
    }

    /// Recalls the configuration from EEPROM.
    /// An error is returned if the device is not present.
    /// If target is null, the command is sent to all devices on the bus.
    pub fn recall_config_from_eeprom(self: *const DS18B20, args: struct { target: ?RomCode = null }) !void {
        if (!(try self.reset())) return error.DeviceNotFound;
        try self.select_target(args.target);
        try self.write_command(.reacll_scratchpad);
    }

    /// Reads the power supply mode of the device.
    /// An error is returned if the device is not present.
    /// If target is null, the command is sent to all devices on the bus.
    pub fn read_power_supply(self: *const DS18B20, args: struct { target: ?RomCode = null }) !PowerSupply {
        if (!(try self.reset())) return error.DeviceNotFound;
        try self.select_target(args.target);
        try self.write_command(.read_power_supply);

        const supply = try self.read_bit();
        return if (supply == 1) .external else .parasite;
    }

    /// Initiates a temperature conversion.
    /// This must be done prior to reading the temperature.
    /// Depending on the resolution, the conversion may take up to 750ms.
    /// An error is returned if the device is not present.
    pub fn initiate_temperature_conversion(self: *const Self, args: struct { target: ?RomCode = null }) !void {
        if (try self.reset() == false) return Error.device_not_present;

        try self.select_target(args.target);
        try self.write_command(.convert_t);
    }

    /// Reads the temperature from the sensor.
    /// The conversion must be initiated prior to calling this function using
    /// initiate_temperature_conversion().
    /// If resolution is provided, it is used to calculate the temperature.
    /// Otherwise, the resolution is read from the sensor.
    /// Returns temperature in Celsius.
    /// An error is returned if the device is not present.
    pub fn read_temperature(self: *const Self, args: struct { target: ?RomCode = null, resolution: ?Resolution = null }) !f32 {
        if (try self.reset() == false) return Error.device_not_present;

        try self.select_target(args.target);
        try self.write_command(.read_scratchpad);

        const lsb = try self.read_byte();
        const msb = try self.read_byte();

        const resolution = args.resolution orelse (try self.read_config(.{ .target = args.target })).resolution;
        return convert_temperature_to_celsius(lsb, msb, resolution);
    }

    fn convert_temperature_to_celsius(lsb: u8, msb: u8, resolution: Resolution) f32 {
        var raw_temp: i16 = @bitCast(@as(u16, msb) << 8 | lsb);
        raw_temp = raw_temp >> (3 - @intFromEnum(resolution));

        return @as(f32, @floatFromInt(raw_temp)) * resolution.factor();
    }

    /// Computes the CRC8 of the given data using the polynomial x^8 + x^5 + x^4 + 1
    /// which is represented by the byte 0x8C.
    /// This is used to verify the integrity of the ROM code.
    fn crc8(data: []const u8) u8 {
        var crc: u8 = 0;
        for (data) |byte| {
            var in_byte = byte;
            for (0..8) |_| {
                const mix = (crc ^ in_byte) & 0x01;
                crc >>= 1;
                if (mix == 1) {
                    crc ^= 0x8C;
                }
                in_byte >>= 1;
            }
        }
        return crc;
    }

    fn select_target(self: *const Self, target: ?RomCode) !void {
        if (target) |rom| {
            try self.write_command(.match_rom);
            for (rom.value) |b| {
                try self.write_byte(b);
            }
        } else {
            try self.write_command(.skip_rom);
        }
    }

    fn write_bit(self: *const DS18B20, bit: u1) !void {
        self.clock_dev.sleep_us(T_RECOVER_US);

        try self.pin.set_direction(.output);
        try self.pin.write(.low);

        if (bit == 1) {
            self.clock_dev.sleep_us(T_WRITE_1_US);
            try self.pin.set_direction(.input);
            self.clock_dev.sleep_us(T_SLOT_US - T_WRITE_1_US);
        } else {
            self.clock_dev.sleep_us(T_WRITE_0_US);
            try self.pin.set_direction(.input);
            self.clock_dev.sleep_us(T_SLOT_US - T_WRITE_0_US);
        }
    }

    pub fn write_command(self: *const DS18B20, command: Command) !void {
        try self.write_byte(@intFromEnum(command));
    }

    pub fn write_byte(self: *const DS18B20, data: u8) !void {
        var temp_data = data;
        for (0..8) |_| {
            try self.write_bit(@truncate(temp_data & 0x01));
            temp_data >>= 1;
        }
    }

    fn read_bit(self: *const DS18B20) !u1 {
        self.clock_dev.sleep_us(T_RECOVER_US);

        try self.pin.set_direction(.output);
        try self.pin.write(.low);
        self.clock_dev.sleep_us(1);
        try self.pin.set_direction(.input);

        self.clock_dev.sleep_us(T_READ_SAMPLE_US - 1);
        const bit = try self.pin.read();

        self.clock_dev.sleep_us(T_SLOT_US - T_READ_SAMPLE_US - 1);
        return bit.value();
    }

    pub fn read_byte(self: *const DS18B20) !u8 {
        var result: u8 = 0;
        for (0..8) |i| {
            if (try self.read_bit() == 1) {
                result |= (@as(u8, 1) << @intCast(i));
            }
        }
        return result;
    }
};

test "crc_is_valid_1" {
    var rom: [8]u8 = .{ 0x28, 0xFF, 0x64, 0x1F, 0x49, 0x96, 0x77, 0x49 };
    const crc = DS18B20.crc8(&rom);
    try std.testing.expectEqual(0, crc);
}

test "crc_is_valid_2" {
    var rom: [8]u8 = .{ 0x28, 0x01, 0x1A, 0x76, 0x09, 0x00, 0x00, 0xC7 };
    const crc = DS18B20.crc8(&rom);
    try std.testing.expectEqual(0, crc);
}

test "convert_temperature_half_degree_9" {
    const temp = DS18B20.convert_temperature_to_celsius(0xA2, 0x00, .half_degree_9);
    try std.testing.expectEqual(10.0, temp);
}

test "convert_temperature_quarter_degree_10_negative" {
    const temp = DS18B20.convert_temperature_to_celsius(0x90, 0xFC, .quarter_degree_10);
    try std.testing.expectEqual(-55.0, temp);
}

test "convert_temperature_eight_degree_11" {
    const temp = DS18B20.convert_temperature_to_celsius(0xA2, 0x00, .eighth_degree_11);
    try std.testing.expectEqual(10.125, temp);
}

test "convert_temperature_sixteenth_degree_12" {
    const temp = DS18B20.convert_temperature_to_celsius(0x91, 0x01, .sixteenth_degree_12);
    try std.testing.expectEqual(25.0625, temp);
}

test "convert_temperature_sixteenth_degree_12_negative" {
    const temp = DS18B20.convert_temperature_to_celsius(0x6F, 0xFE, .sixteenth_degree_12);
    try std.testing.expectEqual(-25.0625, temp);
}
