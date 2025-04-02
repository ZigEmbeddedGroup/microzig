//!
//! Generic driver for the Texas Instruments TMP117 Temperature Sensor
//!
//! Datasheet:
//! * TMP117: https://www.ti.com/lit/ds/symlink/tmp117.pdf
//!
const std = @import("std");
const mdf = @import("../framework.zig");
const Datagram_Device = mdf.base.Datagram_Device;

// TODO: Support other similar temperature sensors. Make this a generic with an enum for the specific?
// TMP116 is the same, just less accurate. Exact same interface
pub const TMP117 = struct {
    const Self = @This();
    // TODO: Enum?
    const TEMPERATURE_RESULT = 0x00;
    const CONFIGURATION = 0x01;
    const TEMPERATURE_HIGH = 0x02;
    const TEMPERATURE_LOW = 0x03;
    const EEPROM_UNLOCK = 0x04;
    const EEPROM1 = 0x05;
    const EEPROM2 = 0x06;
    // Used to add/subtract from read temperature for calibration
    const TEMPERATURE_OFFSET = 0x07;
    const EEPROM3 = 0x08;
    const DEVICE_ID = 0x0F;

    channel: Datagram_Device,

    pub const Configuration = packed struct {
        reserved0: u1 = 0,
        Soft_Reset: bool = false,
        DR: u1 = 0,
        POL: u1 = 0,
        TNA: u1 = 0,
        AVG: u2 = 0,
        CONV: u3 = 0,
        MOD: u2 = 0,
        EEPROM_BUSY: bool = false,
        Data_Ready: bool = false,
        LOW_Alert: bool = false,
        HIGH_Alert: bool = false,
    };

    pub fn init(
        // TODO: Does channel make sense?
        channel: mdf.base.Datagram_Device,
    ) !Self {
        return Self{ .channel = channel };
    }

    pub fn read_raw(self: *const Self, register: u8) !u16 {
        // TODO: Up to 7? Use an enum?
        try self.channel.write(&[_]u8{register});
        var buf: [2]u8 = undefined;
        const size = try self.channel.read(&buf);
        // TODO: Better error name
        if (size != 2) return error.BadRead;
        return std.mem.readInt(u16, &buf, .big);
    }

    pub fn write_raw(self: *const Self, register: u8, v: u16) !void {
        // TODO: Up to 7? Use an enum?
        // TODO endian-aware int to slice
        var buf: [2]u8 = undefined;
        std.mem.writeInt(u16, &buf, v, .big);
        try self.channel.writev(&[_][]const u8{ &.{register}, &buf });
    }

    // TODO: Nuke?
    pub fn configure_raw(self: *const Self, config: u16) !void {
        return self.write_raw(Self.CONFIGURATION, config);
    }

    pub fn write_configuration(self: *const Self, config: Configuration) !void {
        try self.write_raw(Self.CONFIGURATION, @bitCast(config));
    }

    pub fn read_configuration(self: *const Self) !Configuration {
        const v = try self.read_raw(Self.CONFIGURATION);
        return @bitCast(v);
    }

    pub fn set_high_limit(self: *const Self, temp_c: f32) !void {
        const limit = try from_temp(temp_c);
        try self.write_raw(Self.TEMPERATURE_HIGH, limit);
    }

    pub fn set_low_limit(self: *const Self, temp_c: f32) !void {
        const limit = try from_temp(temp_c);
        try self.write_raw(Self.TEMPERATURE_LOW, limit);
    }

    pub fn read_temperature(self: *const Self) !f32 {
        const units: i16 = @bitCast(try self.read_raw(Self.TEMPERATURE_RESULT));
        return to_temp(units);
    }

    pub fn read_temperature_f(self: *const Self) !f32 {
        const temp_c = try self.read_temperature();
        return Self.c_to_f(temp_c);
    }

    pub const DeviceId = packed struct {
        device_id: u12,
        revision: u4,
    };

    pub fn read_device_id(self: *const Self) !DeviceId {
        const did = try self.read_raw(Self.DEVICE_ID);
        return @bitCast(did);
    }

    fn from_temp(temp_c: f32) !u16 {
        if (temp_c > 256 or temp_c < -256)
            return error.TemperatureOutOfRange;
        return @intFromFloat(temp_c / 7.8125E-3);
    }

    pub fn to_temp(units: i16) f32 {
        return @as(f32, @floatFromInt(units)) * 7.8125E-3;
    }

    pub fn c_to_f(temp_c: f32) f32 {
        return (temp_c * 9 / 5) + 32;
    }
};
