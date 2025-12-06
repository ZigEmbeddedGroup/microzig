const std = @import("std");
const mdf = @import("../framework.zig");

pub const DS18B20 = struct {
    const Self = @This();

    pin: mdf.base.Digital_IO,
    clock_dev: mdf.base.Clock_Device,

    // timing constants
    const T_RESET = 480;
    const T_PRESENCE_WAIT = 70;
    const T_SLOT = 70;
    const T_WRITE_1 = 10;
    const T_WRITE_0 = 60;
    const T_READ_SAMPLE = 10;
    const T_RECOVER = 1;

    // ROM commands
    // const CMD_SEARCH_ROM = 0xF0;
    const CMD_READ_ROM = 0x33;
    const CMD_MATCH_ROM = 0x55;
    const CMD_SKIP_ROM = 0xCC;
    // const CMD_ALARM_SEARCH = 0xEC;

    // function commands
    const CMD_CONVERT_T = 0x44;
    const CMD_WRITE_SCRATCHPAD = 0x4E;
    const CMD_READ_SCRATCHPAD = 0xBE;
    const CMD_COPY_SCRATCHPAD = 0x48;
    const CMD_REACLL_SCRATCHPAD = 0xB8;
    const CMD_READ_POWER_SUPPLY = 0xB4;

    pub const Alarms = struct { th: u8, tl: u8 };

    pub const Resolution = enum(u2) {
        HalfDegree9 = 0, // 9-bit  (0.5°C)   - 93.75ms max conversion
        QuarterDegree10 = 1, // 10-bit (0.25°C)  - 187.5ms max conversion
        EightDegree11 = 2, // 11-bit (0.125°C) - 375ms max conversion
        SixteenthDegree12 = 3, // 12-bit (0.0625°C)- 750ms max conversion (Default)

        fn factor(self: Resolution) f32 {
            return switch (self) {
                .HalfDegree9 => 0.5,
                .QuarterDegree10 => 0.25,
                .EightDegree11 => 0.125,
                .SixteenthDegree12 => 0.0625,
            };
        }
    };

    pub const PowerSupply = enum {
        Parasite,
        External,
    };

    pub const RomCode = struct {
        value: [8]u8,
    };

    pub const Error = error{
        DeviceNotPresent,
        RomCrcMismatch,
    };

    pub fn init(pin: mdf.base.Digital_IO, clock_dev: mdf.base.Clock_Device) !Self {
        try pin.set_direction(.input);
        return .{ .pin = pin, .clock_dev = clock_dev };
    }

    /// Resets the bus and checks for device presence.
    /// Returns true if a device is present, false otherwise.
    pub fn reset(self: *const Self) !bool {
        try self.pin.set_direction(.output);
        try self.pin.write(.low);
        self.clock_dev.sleep_us(T_RESET);

        try self.pin.set_direction(.input);
        self.clock_dev.sleep_us(T_PRESENCE_WAIT);

        const presence = try self.pin.read();

        self.clock_dev.sleep_us(T_RESET - T_PRESENCE_WAIT);

        return (presence == .low);
    }

    /// Reads the ROM code of a single device on the bus.
    /// Returns an error if no device is present.
    /// Must only be used if only one device is present on the bus (single drop)
    pub fn read_single_rom_code(self: *const Self) !RomCode {
        if (try self.reset() == false) return Error.DeviceNotPresent;

        try self.write_byte(CMD_READ_ROM);

        var rom_code: [8]u8 = undefined;

        for (0..8) |i| {
            rom_code[i] = try self.read_byte();
        }

        if (crc8(&rom_code) != 0) {
            return Error.RomCrcMismatch;
        }

        return .{ .value = rom_code };
    }

    pub fn set_resolution(self: *const Self, args: struct { resolution: Resolution, target: ?RomCode = null }) !void {
        if (!(try self.reset())) return error.DeviceNotFound;
        try self.select_target(args.target);
        try self.write_byte(CMD_READ_SCRATCHPAD);

        _ = try self.read_byte(); // Temperature LSB
        _ = try self.read_byte(); // Temperature MSB
        const th = try self.read_byte();
        const tl = try self.read_byte();
        const old_config = try self.read_byte();

        const res_bits: u8 = @as(u8, @intFromEnum(args.resolution));
        const config_cleared = old_config & ~@as(u8, 0b01100000);
        const new_config = config_cleared | (res_bits << 5);

        if (!(try self.reset())) return error.DeviceNotFound;
        try self.select_target(args.target);
        try self.write_byte(CMD_WRITE_SCRATCHPAD);

        try self.write_byte(th);
        try self.write_byte(tl);
        try self.write_byte(new_config);
    }

    pub fn read_resolution(self: *const Self, args: struct { target: ?RomCode = null }) !Resolution {
        if (try self.reset() == false) return Error.DeviceNotPresent;

        try self.select_target(args.target);
        try self.write_byte(CMD_READ_SCRATCHPAD);

        _ = try self.read_byte(); // temp LSB
        _ = try self.read_byte(); // temp MSB
        _ = try self.read_byte(); // TH register
        _ = try self.read_byte(); // TL register
        const config = try self.read_byte();

        const resolution_bits: u2 = @intCast((config >> 5) & 0x03);

        return switch (resolution_bits) {
            0 => .HalfDegree9,
            1 => .QuarterDegree10,
            2 => .EightDegree11,
            3 => .SixteenthDegree12,
        };
    }

    pub fn read_alarms(self: *const Self, args: struct { target: ?RomCode = null }) !Alarms {
        if (try self.reset() == false) return Error.DeviceNotPresent;

        try self.select_target(args.target);
        try self.write_byte(CMD_READ_SCRATCHPAD);

        _ = try self.read_byte(); // temp LSB
        _ = try self.read_byte(); // temp MSB
        const th = try self.read_byte(); // TH register
        const tl = try self.read_byte(); // TL register

        return .{ .th = th, .tl = tl };
    }

    pub fn write_alarms(self: *const Self, args: struct { target: ?RomCode = null, alarms: Alarms }) !void {
        if (!(try self.reset())) return error.DeviceNotFound;
        try self.select_target(args.target);
        try self.write_byte(CMD_READ_SCRATCHPAD);

        _ = try self.read_byte(); // temp LSB
        _ = try self.read_byte(); // temp MSB
        _ = try self.read_byte(); // old th
        _ = try self.read_byte(); // old tl
        const config = try self.read_byte();

        if (!(try self.reset())) return error.DeviceNotFound;
        try self.select_target(args.target);
        try self.write_byte(CMD_WRITE_SCRATCHPAD);

        try self.write_byte(args.alarms.th);
        try self.write_byte(args.alarms.tl);
        try self.write_byte(config);
    }

    pub fn save_config_to_eeprom(self: *const DS18B20, args: struct { target: ?RomCode = null }) !void {
        if (!(try self.reset())) return error.DeviceNotFound;
        try self.select_target(args.target);
        try self.write_byte(CMD_COPY_SCRATCHPAD);

        // The DS18B20 needs 10ms to write to EEPROM.
        self.clock_dev.sleep_ms(10);
    }

    pub fn recall_config_from_eeprom(self: *const DS18B20, args: struct { target: ?RomCode = null }) !void {
        if (!(try self.reset())) return error.DeviceNotFound;
        try self.select_target(args.target);
        try self.write_byte(CMD_REACLL_SCRATCHPAD);
    }

    pub fn read_power_supply(self: *const DS18B20, args: struct { target: ?RomCode = null }) !PowerSupply {
        if (!(try self.reset())) return error.DeviceNotFound;
        try self.select_target(args.target);
        try self.write_byte(CMD_READ_POWER_SUPPLY);

        const supply = try self.read_bit();
        return if (supply == 1) .External else .Parasite;
    }

    /// Initiates a temperature conversion.
    /// This must be done prior to reading the temperature.
    /// Depending on the resolution, the conversion may take up to 750ms.
    /// An error is returned if the device is not present.
    pub fn initiate_temperature_conversion(self: *const Self, args: struct { target: ?RomCode = null }) !void {
        if (try self.reset() == false) return Error.DeviceNotPresent;

        try self.select_target(args.target);
        try self.write_byte(CMD_CONVERT_T);
    }

    /// Reads the temperature from the sensor.
    /// The conversion must be initiated prior to calling this function using
    /// initiate_temperature_conversion().
    /// If resolution is provided, it is used to calculate the temperature.
    /// Otherwise, the resolution is read from the sensor.
    /// Returns temperature in Celsius.
    /// An error is returned if the device is not present.
    pub fn read_temperature(self: *const Self, args: struct { target: ?RomCode = null, resolution: ?Resolution = null }) !f32 {
        if (try self.reset() == false) return Error.DeviceNotPresent;

        try self.select_target(args.target);
        try self.write_byte(CMD_READ_SCRATCHPAD);

        const lsb = try self.read_byte();
        const msb = try self.read_byte();

        const resolution = args.resolution orelse try self.read_resolution(.{ .target = args.target });
        return convert_temperature(lsb, msb, resolution);
    }

    fn convert_temperature(lsb: u8, msb: u8, resolution: Resolution) f32 {
        var raw_temp: i16 = @bitCast(@as(u16, msb) << 8 | lsb);
        raw_temp = raw_temp >> (3 - @intFromEnum(resolution));

        return @as(f32, @floatFromInt(raw_temp)) * resolution.factor();
    }

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
            try self.write_byte(CMD_MATCH_ROM);
            for (rom.value) |b| {
                try self.write_byte(b);
            }
        } else {
            try self.write_byte(CMD_SKIP_ROM);
        }
    }

    fn write_bit(self: *const DS18B20, bit: u1) !void {
        self.clock_dev.sleep_us(T_RECOVER);

        try self.pin.set_direction(.output);
        try self.pin.write(.low);

        if (bit == 1) {
            self.clock_dev.sleep_us(T_WRITE_1);
            try self.pin.set_direction(.input);
            self.clock_dev.sleep_us(T_SLOT - T_WRITE_1);
        } else {
            self.clock_dev.sleep_us(T_WRITE_0);
            try self.pin.set_direction(.input);
            self.clock_dev.sleep_us(T_SLOT - T_WRITE_0);
        }
    }

    pub fn write_byte(self: *const DS18B20, data: u8) !void {
        var temp_data = data;
        for (0..8) |_| {
            try self.write_bit(@truncate(temp_data & 0x01));
            temp_data >>= 1;
        }
    }

    fn read_bit(self: *const DS18B20) !u1 {
        self.clock_dev.sleep_us(T_RECOVER);

        try self.pin.set_direction(.output);
        try self.pin.write(.low);
        self.clock_dev.sleep_us(1);
        try self.pin.set_direction(.input);

        self.clock_dev.sleep_us(T_READ_SAMPLE - 1);
        const bit = try self.pin.read();

        self.clock_dev.sleep_us(T_SLOT - T_READ_SAMPLE - 1);
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
    const temp = DS18B20.convert_temperature(0xA2, 0x00, .HalfDegree9);
    try std.testing.expectEqual(10.0, temp);
}

test "convert_temperature_quarter_degree_10_negative" {
    const temp = DS18B20.convert_temperature(0x90, 0xFC, .QuarterDegree10);
    try std.testing.expectEqual(-55.0, temp);
}

test "convert_temperature_eight_degree_11" {
    const temp = DS18B20.convert_temperature(0xA2, 0x00, .EightDegree11);
    try std.testing.expectEqual(10.125, temp);
}

test "convert_temperature_sixteenth_degree_12" {
    const temp = DS18B20.convert_temperature(0x91, 0x01, .SixteenthDegree12);
    try std.testing.expectEqual(25.0625, temp);
}

test "convert_temperature_sixteenth_degree_12_negative" {
    const temp = DS18B20.convert_temperature(0x6F, 0xFE, .SixteenthDegree12);
    try std.testing.expectEqual(-25.0625, temp);
}
