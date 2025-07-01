//!
//! Driver for TMC2209 stepper motor driver
//!
//! Datasheet:
//! * TMC2209: https://www.analog.com/media/en/technical-documentation/data-sheets/tmc2209_datasheet_rev1.09.pdf
//!

const std = @import("std");
const mdf = @import("../framework.zig");

pub const TMC2209_Config = struct {
    uart: mdf.base.Stream_Device,
    clock: mdf.base.Clock_Device,
    address: u8,
    pulse_frequency: f32 = 0.715, // frequency of the built in pulse generator
    steps: u32 = 200, // number of steps per revolution of the motor
    ramp_pause: u32 = 50,
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

    const read_request = packed struct {
        sync: u8 = 0x5,
        addr: u8,
        register: u8,
        crc: u8 = 0,
    };

    ramp: [40]f32 = undefined,
    microsteps: u32 = 1,
    current_freq: f32 = 0,
    pulse_frequency: f32,
    steps: u32,
    uart: mdf.base.Stream_Device,
    clock_device: mdf.base.Clock_Device,
    address: u8,
    ramp_pause: u32,

    pub fn init(cfg: TMC2209_Config) !Self {
        return .{
            .uart = cfg.uart,
            .clock_device = cfg.clock,
            .address = cfg.address,
            .steps = cfg.steps,
            .pulse_frequency = cfg.pulse_frequency,
            .ramp_pause = cfg.ramp_pause,
        };
    }

    pub fn spreadcycle(self: *Self) !void {
        const nc = nodeConf{ .val = .{ .sendDelay = 2 } };
        try self.write(nc.register, @bitCast(nc.val));
        const gc = gconf{ .val = .{ .enSpreadcycle = 1, .pdnDisable = 1, .mStepRegSelect = 1, .indexStep = 1 } };
        try self.write(gc.register, @bitCast(gc.val));
        const ir = iholdRun{ .val = .{ .ihold = 1, .irun = 31 } };
        try self.write(ir.register, @bitCast(ir.val));
        const pw = pwmConf{ .val = .{ .pwmAutoscale = 1, .pwmAutograd = 1, .pwmReg = 8 } };
        try self.write(pw.register, @bitCast(pw.val));
    }

    // velocity = hz / 0.715 * steps * microsteps
    pub fn move(self: *Self, hz: f32) !void {
        if (hz > 20 or hz < -20) {
            return error.InvalidMoveFrequency;
        }

        //uint32((r / 0.715) * float64(m.steps) * float64(m.microsteps))
        const x: f32 = @floatFromInt((self.steps * self.microsteps));
        for (self.get_ramp(hz)[0..]) |val| {
            const v = vactual{
                .val = .{ .velocity = @intFromFloat(val * (x / self.pulse_frequency)) },
            };

            try self.write(v.register, @bitCast(v.val));
            self.clock_device.sleep_ms(self.ramp_pause);
        }
        self.current_freq = hz;
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

    pub fn write(self: *Self, register: u8, data: u32) !void {
        const req = write_request{
            .addr = self.address,
            .register = register | 0x80,
            .data = std.mem.nativeToBig(u32, data),
        };

        var buf = std.mem.toBytes(req);
        buf[7] = self.crc(buf[0..7]);
        const n = try self.uart.write(&buf);
        if (n != 8) {
            return error.WriteError;
        }
        self.clock_device.sleep_ms(10);
    }

    pub fn read(self: *Self, register: anytype) !void {
        const req = read_request{
            .addr = self.address,
            .register = register.register & 0x7f,
        };

        var buf = std.mem.toBytes(req);
        buf[3] = self.crc(buf[0..3]);
        const w1 = try self.uart.write(&buf);
        if (w1 != 4) {
            return error.InvalidWrite;
        }

        std.log.debug("read request {x}", .{buf});

        self.clock_device.sleep_ms(10);

        // the read request will be in the rx buffer since the tx and rx pins are physically connected
        _ = try self.uart.read(&buf);

        std.log.debug("read crud {x}", .{buf});

        var resp: [8]u8 = undefined;
        const r1 = try self.uart.read(&resp);
        std.log.debug("read resp {x}", .{resp});
        if (r1 != 8) {
            return error.InvalidRead;
        }

        if (!(resp[0] == 0x5 and resp[1] == 0xff)) {
            return error.InvalidRead;
        }

        const checksum = self.crc(resp[0..7]);
        if (checksum != resp[7]) {
            return error.InvalidRead;
        }

        register.val = @bitCast(std.mem.readInt(u32, resp[3..7], .big));
        self.clock_device.sleep_ms(10);
    }

    fn get_ramp(self: *Self, target_freq: f32) []f32 {
        if (self.current_freq == target_freq) {
            self.ramp[0] = target_freq;
            return self.ramp[0..1];
        }

        const step: f32 = if (target_freq > self.current_freq) 1 else -1;
        var i: usize = 0;
        var val = self.current_freq + step;

        while ((step > 0 and val < target_freq) or (step < 0 and val > target_freq)) {
            self.ramp[i] = val;
            val += step;
            i += 1;
        }

        self.ramp[i] = target_freq;
        std.log.debug("ramp (i: {d}): {d}", .{ i, self.ramp[0 .. i + 1] });

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
            mStepRegSelect: u1 = 0,
            multistepFilt: u1 = 0,
            _reserved: u23 = 0,
        } = undefined,
    };

    const gstat = struct {
        register: u8 = 0x01,
        val: packed struct(u32) {
            reset: u1 = 0,
            drvErr: u1 = 0,
            uvCp: u1 = 0,
            _reserved: u29 = 0,
        } = undefined,
    };

    const ifcnt = struct {
        register: u8 = 0x02,
        val: packed struct(u32) {
            ifcnt: u8 = 0,
            _reserved: u24 = 0,
        } = undefined,
    };

    const nodeConf = struct {
        register: u8 = 0x03,
        val: packed struct(u32) {
            sendDelay: u32 = 0,
        } = undefined,
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
        } = undefined,
    };

    const iholdRun = struct {
        register: u8 = 0x10,
        val: packed struct(u32) {
            ihold: u5 = 0,
            irun: u5 = 0,
            iholddelay: u4 = 0,
            _reserved: u18 = 0,
        } = undefined,
    };

    const tPowerDown = struct {
        register: u8 = 0x11,
        val: packed struct(u32) {
            delayTime: u8 = 0,
            _reserved: u24 = 0,
        } = undefined,
    };

    const tStep = struct {
        register: u8 = 0x12,
        val: packed struct(u32) {
            stepTime: u20 = 0,
            _reserved: u12 = 0,
        } = undefined,
    };

    const tpwmthrs = struct {
        register: u8 = 0x13,
        val: packed struct(u32) {
            threshold: u32 = 0,
        } = undefined,
    };

    const tcoolthrs = struct {
        register: u8 = 0x14,
        val: packed struct(u32) {
            velocity: u32 = 0,
        } = undefined,
    };

    const vactual = struct {
        register: u8 = 0x22,
        val: packed struct(u32) {
            velocity: i32 = 0,
        } = undefined,
    };

    const sgthrs = struct {
        register: u8 = 0x40,
        val: packed struct(u32) {
            threshold: u32 = 0,
        } = undefined,
    };

    const sgresult = struct {
        register: u8 = 0x41,
        val: packed struct(u32) {
            threshold: u10 = 0,
            _reserved: u22 = 0,
        } = undefined,
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
        } = undefined,
    };

    const mscnt = struct {
        register: u8 = 0x6a,
        val: packed struct(u32) {
            position: u10 = 0,
            _reserved: u22 = 0,
        } = undefined,
    };

    const mscuract = struct {
        register: u8 = 0x6b,
        val: packed struct(u32) {
            curB: u8 = 0,
            curA: u8 = 0,
            _reserved: u16 = 0,
        } = undefined,
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
        } = undefined,
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
        } = undefined,
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
        } = undefined,
    };

    const pwmScale = struct {
        register: u8 = 0x71,
        val: packed struct(u32) {
            pwmScaleSum: u8 = 0,
            pwmScaleAuto: i9 = 0,
            _reserved: u15 = 0,
        } = undefined,
    };

    const pwmAuto = struct {
        register: u8 = 0x72,
        val: packed struct(u32) {
            pwmOfsAuto: i8 = 0,
            pwmGradAuto: i8 = 0,
            _reserved: u16 = 0,
        } = undefined,
    };
};

test "set microsteps" {
    const Test_Stream = mdf.base.Stream_Device.Test_Device;
    const Test_Clock = mdf.base.Clock_Device.Test_Device;
    const data = [_]u8{};

    var td = Test_Stream.init(&data, true);
    defer td.deinit();
    td.connected = true;

    var tc = Test_Clock.init();

    var stepper = try TMC2209.init(.{ .address = 3, .uart = td.stream_device(), .clock = tc.clock_device() });

    try stepper.set_microsteps(16);

    const sent = [_]u8{ 0x05, 0x03, 0xec, 0x14, 0x00, 0x00, 0x05, 0xd9 };
    try td.expect_sent(&sent);
}

// illustrate the use of the TMS2209 register structs, thus exposing all the UART functionality of the driver
test "write" {
    const Test_Stream = mdf.base.Stream_Device.Test_Device;
    const Test_Clock = mdf.base.Clock_Device.Test_Device;
    const data = [_]u8{};

    var td = Test_Stream.init(&data, true);
    defer td.deinit();
    td.connected = true;

    var tc = Test_Clock.init();

    var stepper = try TMC2209.init(.{ .address = 0, .uart = td.stream_device(), .clock = tc.clock_device() });

    const cf = TMC2209.chopconf{ .val = .{ .toff = 5, .mres = 4, .intpol = 1 } };
    try stepper.write(cf.register, @bitCast(cf.val));

    const sent = [_]u8{ 0x05, 0x00, 0xec, 0x14, 0x00, 0x00, 0x05, 0x43 };
    try td.expect_sent(&sent);
}

test "spreadcycle" {
    const Test_Stream = mdf.base.Stream_Device.Test_Device;
    const Test_Clock = mdf.base.Clock_Device.Test_Device;
    const data = [_]u8{
        0x05, 0x00, 0x02, 0x8f,
        0x05, 0xff, 0x02, 0x00,
        0x00, 0x00, 0x02, 0x8b,
        0x05, 0x00, 0x02, 0x8f,
        0x05, 0xff, 0x02, 0x00,
        0x00, 0x00, 0x07, 0xe2,
    };

    var td = Test_Stream.init(&data, true);
    defer td.deinit();
    td.connected = true;

    var tc = Test_Clock.init();

    var stepper = try TMC2209.init(.{ .address = 0, .uart = td.stream_device(), .clock = tc.clock_device() });

    try stepper.spreadcycle();

    const sent = [_]u8{
        0x05, 0x00, 0x83, 0x00, 0x00, 0x00, 0x02, 0xD1,
        0x05, 0x00, 0x80, 0x00, 0x00, 0x00, 0xE4, 0xBC,
        0x05, 0x00, 0x90, 0x00, 0x00, 0x03, 0xE1, 0x21,
        0x05, 0x00, 0xF0, 0x08, 0x18, 0x00, 0x00, 0x8F,
    };
    try td.expect_sent(&sent);
}

test "read" {
    const Test_Stream = mdf.base.Stream_Device.Test_Device;
    const Test_Clock = mdf.base.Clock_Device.Test_Device;

    const data = [_]u8{
        0x00, 0x00, 0x00, 0x00,
        0x05, 0xff, 0xec, 0x14,
        0x00, 0x00, 0x05, 0xec,
    };

    var td = Test_Stream.init(&data, true);
    defer td.deinit();
    td.connected = true;

    var tc = Test_Clock.init();

    var stepper = try TMC2209.init(.{ .address = 0, .uart = td.stream_device(), .clock = tc.clock_device() });

    var cf = TMC2209.chopconf{};
    try stepper.read(&cf);

    try std.testing.expectEqual(5, cf.val.toff);
    try std.testing.expectEqual(4, cf.val.mres);
    try std.testing.expectEqual(1, cf.val.intpol);
    try std.testing.expectEqual(0, cf.val.dedge);

    const sent = [_]u8{ 0x05, 0x00, 0x6c, 0xca };
    try td.expect_sent(&sent);
}

test "move" {
    const Test_Stream = mdf.base.Stream_Device.Test_Device;
    const Test_Clock = mdf.base.Clock_Device.Test_Device;
    const data = [_]u8{};

    var td = Test_Stream.init(&data, true);
    defer td.deinit();
    td.connected = true;

    var tc = Test_Clock.init();

    var stepper = try TMC2209.init(.{ .address = 3, .uart = td.stream_device(), .clock = tc.clock_device() });

    // move frequency is -20 to 20 (my motor can get up to about 14 hz, but maybe there are better motors that handle more?)
    try std.testing.expectError(error.InvalidMoveFrequency, stepper.move(20.1));
    try std.testing.expectError(error.InvalidMoveFrequency, stepper.move(-20.1));

    try stepper.set_microsteps(16);
    try stepper.move(-1);
    try stepper.move(5);

    const sent = [_]u8{
        0x05, 0x03, 0xec, 0x14, 0x00, 0x00, 0x05, 0xd9, // set microsteps
        0x05, 0x03, 0xa2, 0xff, 0xff, 0xee, 0x85, 0xc9, // move -1
        0x05, 0x03, 0xA2, 0x00, 0x00, 0x00, 0x00, 0x94, // move 0
        0x05, 0x03, 0xA2, 0x00, 0x00, 0x11, 0x7B, 0x9E, // move 1
        0x05, 0x03, 0xA2, 0x00, 0x00, 0x22, 0xF7, 0x18, // move 2
        0x05, 0x03, 0xA2, 0x00, 0x00, 0x34, 0x72, 0x2B, // move 3
        0x05, 0x03, 0xA2, 0x00, 0x00, 0x45, 0xEE, 0xE4, // move 4
        0x05, 0x03, 0xA2, 0x00, 0x00, 0x57, 0x69, 0xBE, // move 5
    };
    try td.expect_sent(&sent);
}
