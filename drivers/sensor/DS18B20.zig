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
    // const CMD_MATCH_ROM = 0x55;
    const CMD_SKIP_ROM = 0xCC;
    // const CMD_ALARM_SEARCH = 0xEC;

    // function commands
    const CMD_CONVERT_T = 0x44;
    const CMD_WRITE_SCRATCHPAD = 0x4E;
    const CMD_READ_SCRATCHPAD = 0xBE;
    const CMD_COPY_SCRATCHPAD = 0x48;
    // const CMD_REACLL_SCRATCHPAD = 0xB8;
    // const CMD_READ_POWER_SUPPLY = 0xB4;

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

    pub const Error = error{DeviceNotPresent};

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
    pub fn read_single_rom_code(self: *const Self) ![8]u8 {
        if (try self.reset() == false) return Error.DeviceNotPresent;

        try self.write_byte(CMD_READ_ROM);

        var rom_code: [8]u8 = undefined;

        for (0..7) |i| {
            rom_code[i] = try self.read_byte();
        }

        return rom_code;
    }

    pub fn set_resolution(self: *const DS18B20, resolution: Resolution) !void {
        if (!(try self.reset())) return error.DeviceNotFound;
        try self.write_byte(CMD_SKIP_ROM);
        try self.write_byte(CMD_READ_SCRATCHPAD);

        _ = try self.read_byte(); // Temperature LSB
        _ = try self.read_byte(); // Temperature MSB
        const th = try self.read_byte();
        const tl = try self.read_byte();
        const old_config = try self.read_byte();

        const res_bits: u8 = @as(u8, @intFromEnum(resolution));
        const config_cleared = old_config & ~@as(u8, 0b01100000);
        const new_config = config_cleared | (res_bits << 5);

        if (!(try self.reset())) return error.DeviceNotFound;
        try self.write_byte(CMD_SKIP_ROM);
        try self.write_byte(CMD_WRITE_SCRATCHPAD);

        try self.write_byte(th);
        try self.write_byte(tl);
        try self.write_byte(new_config);
    }

    pub fn read_resolution(self: *const Self) !Resolution {
        if (try self.reset() == false) return Error.DeviceNotPresent;

        try self.write_byte(CMD_SKIP_ROM);
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

    pub fn read_alarms(self: *const Self) !Alarms {
        if (try self.reset() == false) return Error.DeviceNotPresent;

        try self.write_byte(CMD_SKIP_ROM);
        try self.write_byte(CMD_READ_SCRATCHPAD);

        _ = try self.read_byte(); // temp LSB
        _ = try self.read_byte(); // temp MSB
        const th = try self.read_byte(); // TH register
        const tl = try self.read_byte(); // TL register

        return .{ .th = th, .tl = tl };
    }

    pub fn write_alarms(self: *const Self, alarms: Alarms) !void {
        if (!(try self.reset())) return error.DeviceNotFound;
        try self.write_byte(CMD_SKIP_ROM);
        try self.write_byte(CMD_READ_SCRATCHPAD);

        _ = try self.read_byte(); // temp LSB
        _ = try self.read_byte(); // temp MSB
        _ = try self.read_byte(); // old th
        _ = try self.read_byte(); // old tl
        const config = try self.read_byte();

        if (!(try self.reset())) return error.DeviceNotFound;
        try self.write_byte(CMD_SKIP_ROM);
        try self.write_byte(CMD_WRITE_SCRATCHPAD);

        try self.write_byte(alarms.th);
        try self.write_byte(alarms.tl);
        try self.write_byte(config);
    }

    pub fn save_config_to_eeprom(self: *const DS18B20) !void {
        if (!(try self.reset())) return error.DeviceNotFound;
        try self.write_byte(CMD_SKIP_ROM);
        try self.write_byte(CMD_COPY_SCRATCHPAD);

        // The DS18B20 needs 10ms to write to EEPROM.
        self.clock_dev.sleep_ms(10);
    }

    pub fn initiate_temperature_conversion(self: *const Self) !void {
        if (try self.reset() == false) return Error.DeviceNotPresent;

        try self.write_byte(CMD_SKIP_ROM);
        try self.write_byte(CMD_CONVERT_T);
    }

    pub fn read_temperature(self: *const Self, resolution: ?Resolution) !f32 {
        if (try self.reset() == false) return Error.DeviceNotPresent;

        try self.write_byte(CMD_SKIP_ROM);
        try self.write_byte(CMD_READ_SCRATCHPAD);

        const lsb = try self.read_byte();
        const msb = try self.read_byte();

        const raw_temp: i16 = @bitCast(@as(u16, msb) << 8 | lsb);

        const factor =  (resolution orelse try self.read_resolution()).factor();

        return @as(f32, @floatFromInt(raw_temp)) * factor;
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
        var i: u4 = 0;
        var temp_data = data;
        while (i < 8) : (i += 1) {
            try self.write_bit(@truncate(temp_data & 0x01));
            temp_data >>= 1;
        }
    }

    fn read_bit(self: *const DS18B20) !u1 {
        self.clock_dev.sleep_us(T_RECOVER);

        try self.pin.set_direction(.output);
        try self.pin.write(.low);
        self.clock_dev.sleep_us(2);
        try self.pin.set_direction(.input);

        self.clock_dev.sleep_us(T_READ_SAMPLE);
        const bit = try self.pin.read();

        self.clock_dev.sleep_us(T_SLOT - T_READ_SAMPLE - 2);
        return bit.value();
    }

    pub fn read_byte(self: *const DS18B20) !u8 {
        var result: u8 = 0;
        var i: u4 = 0;
        while (i < 8) : (i += 1) {
            if (try self.read_bit() == 1) {
                result |= (@as(u8, 1) << @intCast(i));
            }
        }
        return result;
    }
};
