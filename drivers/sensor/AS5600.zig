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
    dev: mdf.base.I2C_Device,
    // TODO: Always 0x36, could make it a const
    address: mdf.base.I2C_Device.Address,

    const register = enum(u8) {
        // TODO: Maybe add how long each register is?
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

    pub const Status = enum(u8) {
        MD = 1 << 5,
        ML = 1 << 4,
        MH = 1 << 3,
    };

    pub fn init(dev: mdf.base.I2C_Device, address: mdf.base.I2C_Device.Address) Self {
        return Self{ .dev = dev, .address = address };
    }

    pub inline fn read1_raw(self: *const Self, reg: Self.register) !u8 {
        try self.dev.write(self.address, &[_]u8{@intFromEnum(reg)});
        var buf: [1]u8 = undefined;
        const size = try self.dev.read(self.address, &buf);
        if (size != 1) return error.ReadError;
        return buf[0];
    }

    pub inline fn read2_raw(self: *const Self, reg: Self.register) !u16 {
        try self.dev.write(self.address, &[_]u8{@intFromEnum(reg)});
        var buf: [2]u8 = undefined;
        const size = try self.dev.read(self.address, &buf);
        if (size != 2) return error.ReadError;
        return std.mem.readInt(u16, &buf, .big);
    }

    pub inline fn write_raw(self: *const Self, reg: Self.register, v: u16) !void {
        return self.dev.write(
            self.address,
            &([1]u8{@intFromEnum(reg)} ++ @as([2]u8, @bitCast(std.mem.nativeToBig(u16, v)))),
        );
    }

    // TODO: Write method
    pub fn read_zero_position(self: *const Self) !u16 {
        const zpos = self.read2_raw(register.ZPOS);
        return zpos & 0xFFF;
    }

    // TODO: Write method
    pub fn read_max_position(self: *const Self) !u16 {
        const mpos = self.read2_raw(register.MPOS);
        return mpos & 0xFFF;
    }

    // TODO: Write method
    pub fn read_max_angle(self: *const Self) !u16 {
        const mang = self.read2_raw(register.MANG);
        return mang & 0xFFF;
    }

    pub fn read_configuration(self: *const Self) !u16 {
        const configuration = self.read2_raw(register.CONF);
        return @bitCast(configuration);
    }

    pub fn write_configuration(self: *const Self, config: Configuration) !void {
        return self.write_raw(Self.register.CONF, @bitCast(config));
    }

    pub fn read_raw_angle(self: *const Self) !u16 {
        return self.read2_raw(register.RAW_ANGLE);
    }

    pub fn read_angle(self: *const Self) !u16 {
        return self.read2_raw(register.ANGLE);
    }

    pub fn read_status(self: *const Self) !Status {
        const s = try self.read1_raw(register.STATUS);
        return @bitCast(s & (0b111 << 3));
    }

    pub fn read_magnitude(self: *const Self) !u16 {
        return self.read2_raw(register.MAGNITUDE);
    }

    pub fn configure_range(self: *const Self) !void {
        _ = self;
        // NOTE: We set ZPOS for the start position, but we have the choice between configuring the
        // max position (MPOS) or the maximiium angle (MANG)
        return;
    }
};
