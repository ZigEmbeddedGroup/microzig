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
    const TEMPERATURE_OFFSET = 0x07;
    const EEPROM3 = 0x08;
    const DEVICE_ID = 0x0F;

    channel: Datagram_Device,

    pub fn init(
        // TODO: Does channel make sense?
        // SMBus?
        channel: mdf.base.Datagram_Device,
    ) !Self {
        return Self{ .channel = channel };
    }

    pub fn configure_raw(self: *const Self, config: u16) !void {
        const bytes = [_]u8{ Self.CONFIGURATION, @truncate(config), @truncate(config >> 8) };
        try self.channel.write(&bytes);
    }

    pub fn set_high_limit(self: *const Self, temp_c: f32) !void {
        const limit = try get_temperature_units(temp_c);
        const bytes = [_]u8{ Self.TEMPERATURE_HIGH, @truncate(limit), @truncate(limit >> 8) };
        try self.channel.write(&bytes);
    }

    pub fn set_low_limit(self: *const Self, temp_c: f32) !void {
        const limit = try get_temperature_units(temp_c);
        // var bytes = [3]u8{ Self.TEMPERATURE_LOW, 0, 0 };
        const bytes = [_]u8{Self.TEMPERATURE_LOW} ++ std.mem.toBytes(limit);
        std.mem.writeInt(u16, bytes[1..], limit, .little);
        try self.channel.write(&bytes);
    }

    pub fn get_temperature_units(temp_c: f32) !u16 {
        if (temp_c > 256 or temp_c < -256)
            return error.TemperatureOutOfRange;
        return @intFromFloat(temp_c * 7.8125E-6);
    }
};
