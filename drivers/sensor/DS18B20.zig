const std = @import("std");
const mdf = @import("../framework.zig");

pub const Resolution = enum {
    HalfDegree9,
    QuarterDegree10,
    EightDegree11,
    SixteenthDegree12,
};

pub const DS18B20Error = error {
    DeviceNotPresent
};

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
    // const CMD_SKIP_ROM = 0xCC;
    // const CMD_ALARM_SEARCH = 0xEC;

    // function commands
    // const CMD_CONVERT_T = 0x44;
    // const CMD_WRITE_SCRATCHPAD = 0x4E;
    // const CMD_READ_SCRATCHPAD = 0xBE;
    // const CMD_COPY_SCRATCHPAD = 0x48;
    // const CMD_REACLL_SCRATCHPAD = 0xB8;
    // const CMD_READ_POWER_SUPPLY = 0xB4;

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
        if (try self.reset() == false) return DS18B20Error.DeviceNotPresent;

        try self.write_byte(CMD_READ_ROM);

        var rom_code: [8]u8 = undefined;

        for (0..7) |i| {
            rom_code[i] = try self.read_byte();
        }

        return rom_code;
    }

    pub fn set_resolution(self: *const Self, _: Resolution) !void {
        if (try self.reset() == false) return DS18B20Error.DeviceNotPresent;

        // TODO implement setting resolution
    }

    pub fn read_temperature(self: *const Self) !f32 {
        // TODO implement reading temperature
        try self.pin.write(.high);
        self.clock_dev.sleep_us(60000);
        try self.pin.write(.low);
        return 17.32;
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
