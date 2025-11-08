//!
//! Generic driver for the ams AS5600 Position Sensor.
//!
//! Datasheet:
//! * https://www.mouser.com/datasheet/2/588/AS5600_DS000365_5-00-1877365.pdf
//!
const std = @import("std");
const mdf = @import("../framework.zig");

pub const AS5600 = struct {
    const Self = @This();
    const address: mdf.base.I2C_Device.Address = @enumFromInt(0x36);
    dev: mdf.base.I2C_Device,

    const register = enum(u8) {
        ZMCO = 0x00,
        ZPOS = 0x01,
        MPOS = 0x03,
        MANG = 0x05,
        CONF = 0x07,
        RAW_ANGLE = 0x0C,
        ANGLE = 0x0E,
        STATUS = 0x0B,
        AGC = 0x1A,
        MAGNITUDE = 0x1B,
        BURN = 0xFF,
    };

    pub const Configuration = packed struct(u14) {
        PM: enum(u2) {
            nom = 0b00,
            lpm1 = 0b01,
            lpm2 = 0b10,
            lpm3 = 0b11,
        } = .nom,
        HYST: enum(u2) {
            off = 0b00,
            @"1lsb" = 0b01,
            @"2lsbs" = 0b10,
            @"3lsbs" = 0b11,
        } = .off,
        OUTS: enum(u2) {
            full_analog = 0b00,
            reduced_analog = 0b01,
            digital_pwm = 0b10,
        } = .full_analog,
        PWMF: enum(u2) {
            @"115Hz" = 0b00,
            @"230Hz" = 0b01,
            @"460Hz" = 0b10,
            @"920Hz" = 0b11,
        } = .@"115Hz",
        SF: enum(u2) {
            @"2x" = 0b11,
            @"4x" = 0b10,
            @"8x" = 0b01,
            @"16x" = 0b00,
        } = .@"16x",
        FTH: enum(u3) {
            slow = 0b000,
            @"6lsbs" = 0b001,
            @"7lsbs" = 0b010,
            @"9lsbs" = 0b011,
            @"10lsbs" = 0b111,
            @"18lsbs" = 0b100,
            @"21lsbs" = 0b101,
            @"24lsbs" = 0b110,
        } = .slow,
        WD: enum(u1) { off = 0, on = 1 } = .off,
    };

    pub const Status = packed struct(u8) {
        reserved0: u3 = 0,
        // Magnet too strong
        MH: u1 = 0,
        // Magnet too weak
        ML: u1 = 0,
        // Magnet detected
        MD: u1 = 0,
        reserved6: u2 = 0,
    };

    pub fn init(dev: mdf.base.I2C_Device) Self {
        return Self{ .dev = dev };
    }

    pub fn read1_raw(self: *const Self, reg: Self.register) !u8 {
        try self.dev.write(Self.address, &[_]u8{@intFromEnum(reg)});
        var buf: [1]u8 = undefined;
        const size = try self.dev.read(Self.address, &buf);
        if (size != 1) return error.ReadError;
        return buf[0];
    }

    pub fn read2_raw(self: *const Self, reg: Self.register) !u16 {
        try self.dev.write(Self.address, &[_]u8{@intFromEnum(reg)});
        var buf: [2]u8 = undefined;
        const size = try self.dev.read(Self.address, &buf);
        if (size != 2) return error.ReadError;
        return std.mem.readInt(u16, &buf, .big);
    }

    pub fn write_raw(self: *const Self, reg: Self.register, v: u16) !void {
        return self.dev.write(
            Self.address,
            &([1]u8{@intFromEnum(reg)} ++ @as([2]u8, @bitCast(std.mem.nativeToBig(u16, v)))),
        );
    }

    pub fn read_zero_position(self: *const Self) !u16 {
        const zpos = self.read2_raw(register.ZPOS);
        return zpos & 0xFFF;
    }

    pub fn write_zero_position(self: *const Self, position: u12) !void {
        // Read-modify-write because the high 4 bits might store config
        var zpos = try self.read2_raw(register.ZPOS);
        zpos = (zpos & 0xF000) | position;
        try self.write_raw(register.ZPOS, zpos);
    }

    pub fn read_max_position(self: *const Self) !u16 {
        const mpos = self.read2_raw(register.MPOS);
        return mpos & 0xFFF;
    }

    pub fn write_max_position(self: *const Self, max: u12) !void {
        // Read-modify-write because the high 4 bits might store config
        var mpos = try self.read2_raw(register.MPOS);
        mpos = (mpos & 0xF000) | max;
        try self.write_raw(register.MPOS, mpos);
    }

    pub fn read_max_angle(self: *const Self) !u16 {
        const mang = self.read2_raw(register.MANG);
        return mang & 0xFFF;
    }

    pub fn write_max_angle(self: *const Self, max: u12) !void {
        // Read-modify-write because the high 4 bits might store config
        var mang = try self.read2_raw(register.MANG);
        mang = (mang & 0xF000) | max;
        try self.write_raw(register.MANG, mang);
    }

    pub fn read_configuration(self: *const Self) !u16 {
        const configuration = self.read2_raw(register.CONF);
        return @bitCast(configuration);
    }

    pub fn write_configuration(self: *const Self, config: Configuration) !void {
        return self.write_raw(Self.register.CONF, @bitCast(config));
    }

    pub fn read_raw_angle(self: *const Self) !f32 {
        const angle = (try self.read2_raw(register.ANGLE)) & 0xFFF;
        return @as(f32, @floatFromInt(angle)) * 360 / 4096;
    }

    pub fn read_angle(self: *const Self) !f32 {
        const angle = (try self.read2_raw(register.ANGLE)) & 0xFFF;
        return @as(f32, @floatFromInt(angle)) * 360 / 4096;
    }

    pub fn read_status(self: *const Self) !Status {
        const s = try self.read1_raw(register.STATUS);
        return @bitCast(s & (0b111 << 3));
    }

    pub fn read_magnitude(self: *const Self) !u16 {
        return self.read2_raw(register.MAGNITUDE);
    }

    // TODO: Write burn functions. Scary.
};
