//!
//! Driver for TMC2209 stepper motor driver
//!
//! Datasheet:
//! * TMC2209: https://www.analog.com/media/en/technical-documentation/data-sheets/tmc2209_datasheet_rev1.09.pdf
//!

const std = @import("std");
const mdf = @import("../framework.zig");

pub const TMC2209_Config = struct {
    uart: mdf.base.Datagram_Device,
    clock: mdf.base.Clock_Device,
    address: u8,
};

pub const TMC2209 = struct {
    const Self = @This();

    const control_register = packed struct {};

    const chopconf = struct {
        register: u8 = 0x6C,
        val: packed struct {
            toff: u4 = 0,
            hstrt: u3 = 0,
            hend: u4 = 0,
            reserved: u4 = 0,
            tbl: u2 = 0,
            vsense: u1 = 0,
            reserved2: u6 = 0,
            mres: u4 = 0,
            intpol: u1 = 0,
            dedge: u1 = 0,
            diss2g: u1 = 0,
            diss2vs: u1 = 0,
        },
    };

    const vactual = struct {
        register: u8 = 0x22,
        val: packed struct {
            velocity: u32 = 0,
        },
    };

    const rows: u5 = 24;

    buf: [8]u8 = undefined,
    ramp: [20]f32 = undefined,
    microsteps: u32 = 1,
    steps: u32 = 200, // number of steps per revolution of the motor
    hz: f32 = 0,
    pulse_frequency: f32 = 0.715,
    uart: mdf.base.Datagram_Device,
    clock_device: mdf.base.Clock_Device,
    address: u8,

    pub fn init(cfg: TMC2209_Config) !Self {
        return .{
            .uart = cfg.uart,
            .clock_device = cfg.clock,
            .address = cfg.address,
        };
    }

    fn write(self: *Self, register: u8, data: u32) !void {
        const req = packed struct { sync: u8 = 0x5, addr: u8, register: u8, data: u32, crc: u8 = 0 }{
            .addr = self.address,
            .register = register | 0x80,
            .data = std.mem.nativeToBig(u32, data),
        };

        var buf = std.mem.toBytes(req);
        buf[7] = self.crc(buf[0..7]);
        try self.uart.write(&buf);
    }

    // velocity = hz / 0.715 * steps * microsteps
    // 0.715 is the built in pulse generator
    pub fn move(self: *Self, hz: f32) !void {
        var steps: f32 = 0;
        for (self.calculate_ramp(hz)[0..]) |val| {
            steps = @floatFromInt(self.steps * self.microsteps);
            const v = vactual{
                .val = .{ .velocity = @intFromFloat(val / self.pulse_frequency * steps) },
            };

            try self.write(v.register, @bitCast(v.val));
            self.clock_device.sleep_ms(50);
        }
        self.hz = hz;
    }

    pub fn set_microsteps(self: *Self, microsteps: u32) !void {
        self.microsteps = microsteps;
        const cf = chopconf{
            .val = .{
                .toff = 5,
                .mres = self.mres(microsteps),
                .intpol = 1,
            },
        };
        try self.write(cf.register, @bitCast(cf.val));
    }

    fn calculate_ramp(self: *Self, hz: f32) []f32 {
        var val: f32 = 0;
        var i: usize = 0;
        if (hz > self.hz) {
            val = self.hz + 1;
            while (val < hz) {
                self.ramp[i] = val;
                val += 1;
                i += 1;
            }
        } else if (hz < 0 and hz < self.hz) {
            val = self.hz - 1;
            while (val > hz) {
                self.ramp[i] = val;
                val -= 1;
                i += 1;
            }
        } else {}

        self.ramp[i] = hz;
        return self.ramp[0 .. i + 1];
    }

    fn mres(_: *Self, microsteps: u32) u4 {
        var value: u4 = 0;
        var ms: u32 = microsteps;

        if (ms == 0) {
            ms = 1;
        }

        while ((ms & 0x01) == 0) {
            value += 1;
            ms >>= 1;
        }

        if (value > 8) {
            value = 8;
        }

        return 8 - value;
    }

    fn crc(_: *Self, buf: []u8) u8 {
        var result: u8 = 0;
        var b: u8 = 0;
        for (buf[0..]) |x| {
            b = x;
            for (0..8) |_| {
                if ((result >> 7) ^ (b & 0x01) == 1) {
                    result = (result << 1) ^ 0x07;
                } else {
                    result = result << 1;
                }
                b = b >> 1;
            }
        }
        return result;
    }
};

test "set microsteps" {
    const Test_Datagram = mdf.base.Datagram_Device.Test_Device;
    const Test_Clock = mdf.base.Clock_Device.Test_Device;
    const data = [_][]const u8{};

    var td = Test_Datagram.init(&data, true);
    defer td.deinit();
    td.connected = true;

    var tc = Test_Clock.init();

    var stepper = try TMC2209.init(.{ .address = 0, .uart = td.datagram_device(), .clock = tc.clock_device() });

    try stepper.set_microsteps(16);

    const sent = [_][]const u8{
        &.{ 0x05, 0x00, 0xec, 0x14, 0x00, 0x00, 0x05, 0x43 },
    };
    try td.expect_sent(&sent);
}

test "move" {
    const Test_Datagram = mdf.base.Datagram_Device.Test_Device;
    const Test_Clock = mdf.base.Clock_Device.Test_Device;
    const data = [_][]const u8{};

    var td = Test_Datagram.init(&data, true);
    defer td.deinit();
    td.connected = true;

    var tc = Test_Clock.init();

    var stepper = try TMC2209.init(.{ .address = 0, .uart = td.datagram_device(), .clock = tc.clock_device() });

    try stepper.set_microsteps(16);
    try stepper.move(5);

    const sent = [_][]const u8{
        &.{ 0x05, 0x00, 0xec, 0x14, 0x00, 0x00, 0x05, 0x43 }, //set microsteps
        &.{ 0x5, 0x0, 0xa2, 0x0, 0x0, 0x11, 0x7b, 0x04 },
        &.{ 0x5, 0x0, 0xa2, 0x0, 0x0, 0x22, 0xf7, 0x82 },
        &.{ 0x5, 0x0, 0xa2, 0x0, 0x0, 0x34, 0x72, 0xb1 },
        &.{ 0x5, 0x0, 0xa2, 0x0, 0x0, 0x45, 0xee, 0x7e },
        &.{ 0x5, 0x0, 0xa2, 0x0, 0x0, 0x57, 0x69, 0x24 },
    };
    try td.expect_sent(&sent);
}
