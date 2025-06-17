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
    pulse_frequency: f32 = 0.715, // frequency of the built in pulse generator
    steps: u32 = 200, // number of steps per revolution of the motor
};

pub const TMC2209 = struct {
    const Self = @This();

    const write_request = packed struct {
        sync: u8 = 0x5,
        addr: u8,
        register: u8,
        data: u32,
        crc: u8 = 0,
    };

    ramp: [40]f32 = undefined,
    microsteps: u32 = 1,
    hz: f32 = 0,
    pulse_frequency: f32,
    steps: u32,
    uart: mdf.base.Datagram_Device,
    clock_device: mdf.base.Clock_Device,
    address: u8,

    pub fn init(cfg: TMC2209_Config) !Self {
        return .{
            .uart = cfg.uart,
            .clock_device = cfg.clock,
            .address = cfg.address,
            .steps = cfg.steps,
            .pulse_frequency = cfg.pulse_frequency,
        };
    }

    // velocity = hz / 0.715 * steps * microsteps
    // 0.715 is the built in pulse generator
    pub fn move(self: *Self, hz: f32) !void {
        if (hz > 20 or hz < -20) {
            return error.InvalidMoveFrequency;
        }

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

    fn write(self: *Self, register: u8, data: u32) !void {
        const req = write_request{
            .addr = self.address,
            .register = register | 0x80,
            .data = std.mem.nativeToBig(u32, data),
        };

        var buf = std.mem.toBytes(req);
        buf[7] = self.crc(buf[0..7]);
        try self.uart.write(&buf);
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
        } else {
            val = self.hz - 1;
            while (val > hz) {
                self.ramp[i] = val;
                val -= 1;
                i += 1;
            }
        }

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

    const gconf = struct {
        register: u8 = 0x00,
        val: packed struct(u32) {
            iScaleAnalog: u1 = 0,
            internalRsense: u1 = 0,
            enSpreadcycle: u1 = 0,
            shaft: u1 = 0,
            indexOtpw: u1 = 0,
            indexStep: u1 = 0,
            pdnDisable: u1 = 0,
            mstepRegSelect: u1 = 0,
            multistepFilt: u1 = 0,
            _reserved: u23 = 0,
        },
    };

    const gstat = struct {
        register: u8 = 0x01,
        val: packed struct(u32) {
            reset: u1 = 0,
            drvErr: u1 = 0,
            uvCp: u1 = 0,
            _reserved: u29 = 0,
        },
    };

    const ifcnt = struct {
        register: u8 = 0x02,
        val: packed struct(u32) {
            ifcnt: u8 = 0,
            _reserved: u24 = 0,
        },
    };

    const nodeConf = struct {
        register: u8 = 0x03,
        val: packed struct(u32) {
            sendDelay: u32 = 0,
        },
    };

    const ioin = struct {
        register: u8 = 0x06,
        val: packed struct(u32) {
            enn: u1 = 0,
            reserved0: u1 = 0,
            ms1: u1 = 0,
            ms2: u1 = 0,
            diag: u1 = 0,
            reserved1: u1 = 0,
            pdnSerial: u1 = 0,
            step: u1 = 0,
            spreadEn: u1 = 0,
            dir: u1 = 0,
            reserved2: u14 = 0,
            version: u8 = 0,
        },
    };

    const iholdRun = struct {
        register: u8 = 0x10,
        val: packed struct(u32) {
            ihold: u5 = 0,
            irun: u5 = 0,
            iholddelay: u4 = 0,
            _reserved: u23 = 0,
        },
    };

    const tPowerDown = struct {
        register: u8 = 0x11,
        val: packed struct(u32) {
            delayTime: u8 = 0,
            _reserved: u24 = 0,
        },
    };

    const tStep = struct {
        register: u8 = 0x12,
        val: packed struct(u32) {
            stepTime: u20 = 0,
            _reserved: u12 = 0,
        },
    };

    const tpwmthrs = struct {
        register: u8 = 0x13,
        val: packed struct(u32) {
            threshold: u32 = 0,
        },
    };

    const tcoolthrs = struct {
        register: u8 = 0x14,
        val: packed struct(u32) {
            velocity: u32 = 0,
        },
    };

    const vactual = struct {
        register: u8 = 0x22,
        val: packed struct(u32) {
            velocity: i32 = 0,
        },
    };

    const sgthrs = struct {
        register: u8 = 0x40,
        val: packed struct(u32) {
            threshold: u32 = 0,
        },
    };

    const sgresult = struct {
        register: u8 = 0x41,
        val: packed struct(u32) {
            threshold: u10 = 0,
            _reserved: u22 = 0,
        },
    };

    const coolconf = struct {
        register: u8 = 0x42,
        val: packed struct(u32) {
            semin: u1 = 0,
            sedn: u2 = 0,
            semax: u4 = 0,
            seup: u3 = 0,
            semin2: u6 = 0,
            coolStepEnable: u1 = 0,
            _reserved: u15 = 0,
        },
    };

    const mscnt = struct {
        register: u8 = 0x6a,
        val: packed struct(u32) {
            position: u10 = 0,
            _reserved: u22 = 0,
        },
    };

    const mscuract = struct {
        register: u8 = 0x6b,
        val: packed struct(u32) {
            curB: u8 = 0,
            curA: u8 = 0,
            _reserved: u16 = 0,
        },
    };

    const chopconf = struct {
        register: u8 = 0x6C,
        val: packed struct(u32) {
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

    const drvStatus = struct {
        register: u8 = 0x6F,
        val: packed struct(u32) {
            stst: u1 = 0,
            stealth: u1 = 0,
            reserved: u6 = 0,
            reserved2: u3 = 0,
            csActual: u5 = 0,
            reserved3: u4 = 0,
            t157: u1 = 0,
            t150: u1 = 0,
            t143: u1 = 0,
            t120: u1 = 0,
            olb: u1 = 0,
            ola: u1 = 0,
            s2vsb: u1 = 0,
            s2vsa: u1 = 0,
            s2gb: u1 = 0,
            s2ga: u1 = 0,
            ot: u1 = 0,
            otpw: u1 = 0,
        },
    };

    const pwmConf = struct {
        register: u8 = 0x70,
        val: packed struct(u32) {
            pwmOfs: u8 = 0,
            pwmGrad: u8 = 0,
            pwmFreq: u3 = 0,
            pwmAutoscale: u1 = 0,
            pwmAutograd: u1 = 0,
            freewheel: u3 = 0,
            pwmReg: u4 = 0,
            pwmLim: u4 = 0,
        },
    };

    const pwmScale = struct {
        register: u8 = 0x71,
        val: packed struct(u32) {
            pwmScaleSum: u8 = 0,
            pwmScaleAuto: i9 = 0,
            _reserved: u15 = 0,
        },
    };

    const pwmAuto = struct {
        register: u8 = 0x72,
        val: packed struct(u32) {
            pwmOfsAuto: i8 = 0,
            pwmGradAuto: i8 = 0,
            _reserved: u16 = 0,
        },
    };
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

    var stepper = try TMC2209.init(.{ .address = 3, .uart = td.datagram_device(), .clock = tc.clock_device() });

    // move frequency is -20 to 20 (my motor can get up to about 14 hz, but maybe there are better motors that handle more?)
    try std.testing.expectError(error.InvalidMoveFrequency, stepper.move(20.1));
    try std.testing.expectError(error.InvalidMoveFrequency, stepper.move(-20.1));

    try stepper.set_microsteps(16);
    try stepper.move(5);
    try stepper.move(-5);

    const sent = [_][]const u8{
        &.{ 0x05, 0x03, 0xec, 0x14, 0x00, 0x00, 0x05, 0xd9 }, // set microsteps
        &.{ 0x05, 0x03, 0xa2, 0x00, 0x00, 0x11, 0x7b, 0x9e }, // ramp up to 5 hz
        &.{ 0x05, 0x03, 0xa2, 0x00, 0x00, 0x22, 0xf7, 0x18 }, // ramp up to 5 hz
        &.{ 0x05, 0x03, 0xa2, 0x00, 0x00, 0x34, 0x72, 0x2b }, // ramp up to 5 hz
        &.{ 0x05, 0x03, 0xa2, 0x00, 0x00, 0x45, 0xee, 0xe4 }, // ramp up to 5 hz
        &.{ 0x05, 0x03, 0xa2, 0x00, 0x00, 0x57, 0x69, 0xbe }, // ramp up to 5 hz
        &.{ 0x05, 0x03, 0xa2, 0x00, 0x00, 0x45, 0xee, 0xe4 }, // ramp down to -5 hz
        &.{ 0x05, 0x03, 0xa2, 0x00, 0x00, 0x34, 0x72, 0x2b }, // ramp down to -5 hz
        &.{ 0x05, 0x03, 0xa2, 0x00, 0x00, 0x22, 0xf7, 0x18 }, // ramp down to -5 hz
        &.{ 0x05, 0x03, 0xa2, 0x00, 0x00, 0x11, 0x7b, 0x9e }, // ramp down to -5 hz
        &.{ 0x05, 0x03, 0xa2, 0x00, 0x00, 0x00, 0x00, 0x94 }, // ramp down to -5 hz
        &.{ 0x05, 0x03, 0xa2, 0xff, 0xff, 0xee, 0x85, 0xc9 }, // ramp down to -5 hz
        &.{ 0x05, 0x03, 0xa2, 0xff, 0xff, 0xdd, 0x09, 0x4f }, // ramp down to -5 hz
        &.{ 0x05, 0x03, 0xa2, 0xff, 0xff, 0xcb, 0x8e, 0xbb }, // ramp down to -5 hz
        &.{ 0x05, 0x03, 0xa2, 0xff, 0xff, 0xba, 0x12, 0x74 }, // ramp down to -5 hz
        &.{ 0x05, 0x03, 0xa2, 0xff, 0xff, 0xa8, 0x97, 0xe9 }, // ramp down to -5 hz
    };
    try td.expect_sent(&sent);
}
