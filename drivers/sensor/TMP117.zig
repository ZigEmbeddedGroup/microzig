//!
//! Generic driver for the Texas Instruments TMP117 Temperature Sensor.
//! Works with the TPM116 sensor as well.
//!
//! Datasheet:
//! * TMP117: https://www.ti.com/lit/ds/symlink/tmp117.pdf
//!
const std = @import("std");
const mdf = @import("../framework.zig");

pub const TMP117 = struct {
    const Self = @This();
    dev: mdf.base.Datagram_Device,

    const register = enum(u8) {
        temp_result = 0x00,
        configuration = 0x01,
        thigh_limit = 0x02,
        tlow_limit = 0x03,
        EEPROM_UL = 0x04,
        EEPROM1 = 0x05,
        EEPROM2 = 0x06,
        temp_offset = 0x07,
        EEPROM3 = 0x08,
        device_id = 0x0F,
    };

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

    pub const DeviceId = packed struct {
        device_id: u12,
        revision: u4,
    };

    pub fn init(dev: mdf.base.Datagram_Device) !Self {
        return Self{ .dev = dev };
    }

    pub inline fn read_raw(self: *const Self, reg: Self.register) !u16 {
        try self.dev.write(&[_]u8{@intFromEnum(reg)});
        var buf: [2]u8 = undefined;
        const size = try self.dev.read(&buf);
        if (size != 2) return error.ReadError;
        return std.mem.readInt(u16, &buf, .big);
    }

    pub inline fn write_raw(self: *const Self, reg: Self.register, v: u16) !void {
        // TODO endian-aware int to slice
        var buf: [2]u8 = undefined;
        std.mem.writeInt(u16, &buf, v, .big);
        return self.dev.writev(&[_][]const u8{ &.{@intFromEnum(reg)}, &buf });
    }

    pub fn configure_raw(self: *const Self, config: u16) !void {
        return self.write_raw(Self.register.configuration, config);
    }

    pub fn write_configuration(self: *const Self, config: Configuration) !void {
        return self.write_raw(Self.register.configuration, @bitCast(config));
    }

    pub fn read_configuration(self: *const Self) !Configuration {
        return @bitCast(try self.read_raw(Self.register.configuration));
    }

    pub fn set_high_limit(self: *const Self, temp_c: f32) !void {
        if (temp_c > 256 or temp_c < -256)
            return error.TemperatureOutOfRange;
        const limit = try to_temp_units(temp_c);
        return self.write_raw(Self.register.thigh_limit, limit);
    }

    pub fn set_low_limit(self: *const Self, temp_c: f32) !void {
        if (temp_c > 256 or temp_c < -256)
            return error.TemperatureOutOfRange;
        const limit = try to_temp_units(temp_c);
        return self.write_raw(Self.register.tlow_limit, limit);
    }

    pub fn read_temperature(self: *const Self) !f32 {
        const units: i16 = @bitCast(try self.read_raw(Self.register.temp_result));
        return to_temp(units);
    }

    pub fn read_temperature_f(self: *const Self) !f32 {
        return Self.c_to_f(try self.read_temperature());
    }

    pub fn unlock_eeprom(self: *const Self) !void {
        return self.write_raw(Self.register.EEPROM_UL, 0xFFFF);
    }

    pub fn is_eeprom_busy(self: *const Self) !bool {
        return (try self.read_configuration()).EEPROM_BUSY;
    }

    pub fn write_eeprom(self: *const Self, index: u8, v: u16) !void {
        const reg = switch (index) {
            1 => Self.register.EEPROM1,
            2 => Self.register.EEPROM2,
            3 => Self.register.EEPROM3,
            else => return error.BadIndex,
        };
        return self.write_raw(reg, v);
    }

    pub fn read_eeprom(self: *const Self, index: u8) !u16 {
        const reg = switch (index) {
            1 => Self.register.EEPROM1,
            2 => Self.register.EEPROM2,
            3 => Self.register.EEPROM3,
            else => return error.BadIndex,
        };
        return self.read_raw(reg);
    }

    pub fn set_temperature_offset(self: *const Self, degrees_c: f32) !void {
        if (degrees_c > 256 or degrees_c < -256)
            return error.TemperatureOutOfRange;
        return self.write_raw(Self.register.temp_offset, try to_temp_units(degrees_c));
    }

    pub fn read_device_id(self: *const Self) !DeviceId {
        return @bitCast(try self.read_raw(Self.register.device_id));
    }

    fn to_temp_units(temp_c: f32) !u16 {
        return @intFromFloat(temp_c / 7.8125E-3);
    }

    pub fn to_temp(units: i16) f32 {
        return @as(f32, @floatFromInt(units)) * 7.8125E-3;
    }

    pub fn c_to_f(temp_c: f32) f32 {
        return (temp_c * 9 / 5) + 32;
    }
};
