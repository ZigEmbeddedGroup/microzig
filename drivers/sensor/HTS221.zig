//!
//! Generic driver for the HTS221
//!  Capacitive digital sensor for relative humidity and temperature.
//!
//! Datasheet:
//! * HTS221: https://www.st.com/resource/en/datasheet/hts221.pdf
//!
const std = @import("std");
const mdf_base = @import("../framework.zig").base;
const InterfaceError = mdf_base.I2C_Device.InterfaceError;

const assert = std.debug.assert;

pub const Config = struct {
    temperatureAverageSample: HTS221.AVGT,
    humidityAverageSample: HTS221.AVGH,
    outputDataRate: HTS221.ODR,
};

pub const HTS221 = struct {
    const address: mdf_base.I2C_Device.Address = @enumFromInt(0b1011111);
    const RegsAddr = enum(u8) {
        WHO_AM_I = 0x0F,
        AV_CONF = 0x10,
        CTRL_REG1 = 0x20,
        H_OUT = 0x28,
        T_OUT = 0x2A,
        STATUS_REG = 0x27,

        // Calibration register
        H0_RH_X2 = 0x30,
        H1_RH_X2 = 0x31,
        T0_DEGC_X8 = 0x32,
        T1_DEGC_X8 = 0x33,
        T01_DEGC_MSB_x8 = 0x35,
        H0_T0_OUT = 0x36,
        H1_T0_OUT = 0x3A,
        T0_OUT = 0x3C,
        T1_OUT = 0x3E,

        fn v(self: @This()) u8 {
            return @intFromEnum(self);
        }

        fn auto_v(self: @This()) u8 {
            return @intFromEnum(self) | 0x80;
        }
    };

    const ODR = enum(u2) {
        OneShot,
        OneHz,
        SevenHz,
        TwelveHalfHz,
    };

    const AVGT = enum(u3) {
        Avg2,
        Avg4,
        Avg8,
        Avg16,
        Avg32,
        Avg64,
        Avg128,
        Avg256,
    };

    const AVGH = enum(u3) {
        Avg4,
        Avg8,
        Avg16,
        Avg32,
        Avg64,
        Avg128,
        Avg256,
        Avg512,
    };

    const CTRL_REG1 = packed struct(u8) {
        ODR: ODR,
        BDU: u1,
        reserved0: u4,
        PD: u1,
    };

    const STATUS_REG = packed struct(u8) {
        T_DA: u1,
        H_DA: u1,
        reserved0: u6,
    };

    const AV_CONF = packed struct(u8) {
        AVGH: AVGH,
        AVGT: AVGT,
        reserved0: u2,
    };

    const T01_DEGC_MSB = packed struct(u8) {
        T0MSB: i2,
        T1MSB: i2,
        reserved0: u4,
    };

    dev: *mdf_base.I2C_Device,

    // Needs to be initialized with calibration value.
    t_slop: f32 = 0.0,
    t_b0: f32 = 0.0,
    h_slop: f32 = 0.0,
    h_b0: f32 = 0.0,

    // internal read buffer
    read_buffer: [2]u8 = .{ 0, 0 },

    fn read_register(self: *@This(), comptime Regs: type, reg: RegsAddr) InterfaceError!Regs {
        const raw = try self.read_one_byte(reg);
        return @as(Regs, @bitCast(raw));
    }

    fn read_one_byte(self: *@This(), register: RegsAddr) InterfaceError!u8 {
        try self.dev.write_then_read(address, &[_]u8{register.v()}, self.read_buffer[0..1]);
        return self.read_buffer[0];
    }

    // LSB is always read first.
    fn read_two_byte(self: *@This(), register: RegsAddr) InterfaceError!u16 {
        try self.dev.write_then_read(address, &[_]u8{register.auto_v()}, &self.read_buffer);
        return @as(u16, @intCast(self.read_buffer[0])) | (@as(u16, @intCast(self.read_buffer[1])) << 8);
    }

    fn init_temp_calibration(self: *@This()) InterfaceError!void {
        // Get the MSB of degC calibration value.
        const t01_msb_reg = try self.read_register(T01_DEGC_MSB, RegsAddr.T01_DEGC_MSB_x8);
        const t0msb = @as(i10, @intCast(t01_msb_reg.T0MSB)) << 8;
        const t1msb = @as(i10, @intCast(t01_msb_reg.T1MSB)) << 8;

        const t0_degc_lsb = @as(u10, @intCast(try self.read_one_byte(RegsAddr.T0_DEGC_X8)));
        const t0_deg = @as(f32, @floatFromInt(@as(i10, @bitCast(t0_degc_lsb)) | t0msb)) / 8.0;

        const t1_degc_lsb = @as(u10, @intCast(try self.read_one_byte(RegsAddr.T1_DEGC_X8)));
        const t1_deg = @as(f32, @floatFromInt(@as(i10, @bitCast(t1_degc_lsb)) | t1msb)) / 8.0;

        const t0_raw = try self.read_two_byte(RegsAddr.T0_OUT);
        const T0 = @as(f32, @floatFromInt(@as(i16, @bitCast(t0_raw))));

        const t1_raw = try self.read_two_byte(RegsAddr.T1_OUT);
        const T1 = @as(f32, @floatFromInt(@as(i16, @bitCast(t1_raw))));

        self.t_slop = ((t1_deg - t0_deg) / (T1 - T0));
        self.t_b0 = t0_deg - T0 * self.t_slop;
    }

    fn init_humidity_calibration(self: *@This()) InterfaceError!void {
        const h0_rh_x2 = try self.read_one_byte(RegsAddr.H0_RH_X2);
        const h0_rh = @as(f32, @floatFromInt(h0_rh_x2)) / 2.0;

        const h1_rh_x2 = try self.read_one_byte(RegsAddr.H1_RH_X2);
        const h1_rh = @as(f32, @floatFromInt(h1_rh_x2)) / 2.0;

        const h0_raw = try self.read_two_byte(RegsAddr.H0_T0_OUT);
        const H0 = @as(f32, @floatFromInt(@as(i16, @bitCast(h0_raw))));

        const h1_raw = try self.read_two_byte(RegsAddr.H1_T0_OUT);
        const H1 = @as(f32, @floatFromInt(@as(i16, @bitCast(h1_raw))));

        self.h_slop = ((h1_rh - h0_rh) / (H1 - H0));
        self.h_b0 = h0_rh - H0 * self.h_slop;
    }

    fn setup_output_rate(self: *@This(), rate: ODR) InterfaceError!void {
        var reg = try self.read_register(CTRL_REG1, RegsAddr.CTRL_REG1);
        reg.ODR = rate;
        try self.dev.write(address, &[_]u8{ RegsAddr.CTRL_REG1.v(), @bitCast(reg) });
    }

    fn setup_average(self: *@This(), avgt: AVGT, avgh: AVGH) InterfaceError!void {
        var reg = try self.read_register(AV_CONF, RegsAddr.AV_CONF);
        reg.AVGH = avgh;
        reg.AVGT = avgt;
        try self.dev.write(address, &[_]u8{ RegsAddr.AV_CONF.v(), @bitCast(reg) });
    }

    pub fn turn_on(self: *@This()) InterfaceError!void {
        var reg = try self.read_register(CTRL_REG1, RegsAddr.CTRL_REG1);
        reg.PD = 1;
        try self.dev.write(address, &[_]u8{ RegsAddr.CTRL_REG1.v(), @bitCast(reg) });
    }

    pub fn turn_off(self: *@This()) InterfaceError!void {
        var reg = try self.read_register(CTRL_REG1, RegsAddr.CTRL_REG1);
        reg.PD = 0;
        try self.dev.write(address, &[_]u8{ RegsAddr.CTRL_REG1.v(), @bitCast(reg) });
    }

    pub fn configure(self: *@This(), config: Config) InterfaceError!void {
        try self.init_temp_calibration();
        try self.init_humidity_calibration();
        try self.setup_output_rate(config.outputDataRate);
        try self.setup_average(config.temperatureAverageSample, config.humidityAverageSample);
    }

    pub fn temperature_ready(self: *@This()) InterfaceError!bool {
        const status = try self.read_register(STATUS_REG, RegsAddr.STATUS_REG);
        return status.T_DA == 1;
    }

    pub fn humidity_ready(self: *@This()) InterfaceError!bool {
        const status = try self.read_register(STATUS_REG, RegsAddr.STATUS_REG);
        return status.H_DA == 1;
    }

    pub fn read_temperature(self: *@This()) InterfaceError!f32 {
        const raw_t = try self.read_two_byte(RegsAddr.T_OUT);
        const inter = @as(f32, @floatFromInt(@as(i16, @bitCast(raw_t))));
        return self.t_b0 + inter * self.t_slop;
    }

    pub fn read_humidity(self: *@This()) InterfaceError!f32 {
        const raw_h = try self.read_two_byte(RegsAddr.H_OUT);
        const inter = @as(f32, @floatFromInt(@as(i16, @bitCast(raw_h))));
        return self.h_b0 + inter * self.h_slop;
    }

    pub fn init(dev: *mdf_base.I2C_Device) @This() {
        return .{ .dev = dev };
    }
};
