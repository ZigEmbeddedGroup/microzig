const std = @import("std");
const mdf = @import("../framework.zig");
const Digital_IO = mdf.base.Digital_IO;

const default_oscillator_frequency = 25_000_000;

pub const Register = enum(u8) {
    Mode1 = 0x00,
    Mode2 = 0x01,
    SubAdr1 = 0x02,
    SubAdr2 = 0x03,
    SubAdr3 = 0x04,
    AllCallAdr = 0x05,
    Led0OnL = 0x06,
    Led0OnH = 0x07,
    Led0OffL = 0x08,
    LedOffH = 0x09,
    AllLedOnL = 0xFA,
    AllLedOnH = 0xFB,
    AllLedOffL = 0xFC,
    AllLedOffH = 0xFD,
    PreScale = 0xFE,
};

pub const PCA9685_Config = struct {
    Datagram_Device: type = mdf.base.Datagram_Device,
    oscillator_frequency: u32 = default_oscillator_frequency,
};

pub fn init(datagram_device: anytype, frequency: u32) !PCA9685(.{ .Datagram_Device = @TypeOf(datagram_device) }) {
    const Type = PCA9685(.{
        .Datagram_Device = @TypeOf(datagram_device),
    });

    return Type.init(datagram_device, frequency);
}

pub fn PCA9685(comptime config: PCA9685_Config) type {
    return struct {
        const Self = @This();
        dd: config.Datagram_Device,

        fn init(datagram_device: config.Datagram_Device, frequency: u32) !Self {
            const self = Self{
                .dd = datagram_device,
            };

            try self.reset();

            // TODO: this can be optimized to single Mode1 read
            try self.sleep(true);
            try self.set_frequency(frequency);
            try self.sleep(false);

            try self.set_autoincrement(true);

            return self;
        }

        pub fn set_channel_duty(self: Self, channel: u4, value: u16) !void {
            if (value > 4095) return error.ValueTooBig;

            try switch (value) {
                0 => self.set_channel_pwm(channel, 0, 4096),
                4095 => self.set_channel_pwm(channel, 4096, 0),
                else => self.set_channel_pwm(channel, 0, value),
            };
        }

        pub fn set_channel_pwm(self: Self, channel: u4, on: u16, off: u16) !void {
            var buffer_on: [2]u8 = undefined;
            std.mem.writeInt(u16, &buffer_on, on, .little);

            var buff_off: [2]u8 = undefined;
            std.mem.writeInt(u16, &buff_off, off, .little);

            try self.dd.writev(&.{
                &.{@intFromEnum(Register.Led0OnL) + 4 * channel},
                &buffer_on,
                &buff_off,
            });
        }

        pub fn set_all_channels_duty(self: Self, value: u16) !void {
            if (value > 4095) return error.ValueTooBig;

            try switch (value) {
                0 => self.set_all_channels_pwm(0, 4096),
                4095 => self.set_all_channels_pwm(4096, 0),
                else => self.set_all_channels_pwm(0, value),
            };
        }

        pub fn set_all_channels_pwm(self: Self, on: u16, off: u16) !void {
            var buffer_on: [2]u8 = undefined;
            std.mem.writeInt(u16, &buffer_on, on, .little);

            var buff_off: [2]u8 = undefined;
            std.mem.writeInt(u16, &buff_off, off, .little);

            try self.dd.writev(&.{
                &.{@intFromEnum(Register.AllLedOnL)},
                &buffer_on,
                &buff_off,
            });
        }

        pub fn reset(self: Self) !void {
            try self.dd.write(&.{ 0x00, 0x00 });
        }

        pub fn sleep(self: Self, enable: bool) !void {
            const mode = try self.read_register(.Mode1);
            const value = if (enable) ((mode & 0x7f) | 0x10) else (mode & ~@as(u8, 0x10));
            try self.write_register(.Mode1, value);
        }

        pub fn set_autoincrement(self: Self, enable: bool) !void {
            const mode = try self.read_register(.Mode1);
            const value = if (enable) ((mode & 0x7f) | 0xa1) else (mode & ~@as(u8, 0xa1));
            try self.write_register(.Mode1, value);
        }

        pub fn set_frequency(self: Self, frequnecy: u32) !void {
            const prescale: u8 = @intCast(config.oscillator_frequency / (frequnecy * 4096));
            try self.write_register(.PreScale, prescale);
        }

        pub fn write_register(self: Self, register: Register, value: u8) !void {
            try self.dd.write(&.{ @intFromEnum(register), value });
        }

        pub fn read_register(self: Self, register: Register) !u8 {
            try self.dd.write(&.{@intFromEnum(register)});
            var value: [1]u8 = undefined;
            _ = try self.dd.read(&value);
            return value[0];
        }
    };
}
