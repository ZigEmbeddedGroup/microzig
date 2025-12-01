const std = @import("std");
const microzig = @import("microzig");
const emus_type = @import("enums_type.zig");

const I2CType = emus_type.I2CType;
const I2C_t = microzig.chip.types.peripherals.i2c_v2.I2C;
const peripherals = microzig.chip.peripherals;
const hal = microzig.hal;

pub const AddressMode = enum {
    @"7bits",
    @"10bits",
};

pub const Address = struct {
    mode: AddressMode = .@"7bits",
    addr: u10,

    pub fn new(addr: u7) Address {
        return .{ .addr = addr };
    }

    pub fn new_10bits(addr: u10) Address {
        return .{
            .addr = addr,
            .mode = .@"10bits",
        };
    }
};

pub const Config = struct {
    speed: usize,
};

pub const ConfigError = error{
    PCLKUnderflow,
    PCLKOverflow,
    SpeedOverflow,
    SpeedUnderflow,
    InvalidAddress,
    InvalidTrise,
    InvalidCCR,
};

// pub const Error = drivers.I2C_Device.Error || error{
//     ArbitrationLoss,
//     BusError,
//     BusTimeout,
//     UnrecoverableError,
// };

// 100khz for now
const TimmingSpec_Standard = .{
    .t_low = 4.7,
    .t_high = 4.0,
    .t_rise = 1.0,
    .t_fall = 0.3,
    .t_su_dat = 0.25,
    .t_max_vd_ack = 3.45,
    .t_min_vd_ack = 0.01,
    .t_max_af = 0.26,
    .t_min_af = 0.05,
};

fn calc_CCR(pclk: usize, speed: usize, duty: ?bool) usize {
    const mult_val: f32 = if (duty) |val| if (val) 25 else 3 else 2;
    const fpclk: f32 = @floatFromInt(pclk);
    const fspeed: f32 = @floatFromInt(speed);
    return @as(usize, @intFromFloat(@ceil(fpclk / (mult_val * fspeed))));
}

fn comptime_fail_or_error(msg: []const u8, fmt_args: anytype, err: ConfigError) ConfigError {
    if (@inComptime()) {
        @compileError(std.fmt.comptimePrint(msg, fmt_args));
    } else {
        return err;
    }
}

fn get_regs(comptime instance: I2CType) *volatile I2C_t {
    return @field(microzig.chip.peripherals, @tagName(instance));
}
pub const I2C = struct {
    regs: *volatile I2C_t,

    fn compute_presc() ConfigError!struct { f32, u4 } {
        // Let first see if we need to prescal.
        // 100Khx = 10us period ~ 5us for SCLL/SCLH
        const t_sckl = 1_000_000.0 / @as(f32, @floatFromInt(hal.rcc.current_clock.sys_clk));

        // t_presc = 0.1us accomonddate for most timing register
        const ideal_presc = @as(u32, @intFromFloat(@round(0.1 / t_sckl))) - 1;

        if (ideal_presc > 15) {
            std.log.info("i2cclk frequency is too high in other to set prescal", .{});
            return ConfigError.PCLKOverflow;
        }
        const presc = @as(u4, @intCast(ideal_presc));
        const t_presc = t_sckl * @as(f32, @floatFromInt(presc + 1));

        return .{ t_presc, presc };
    }

    fn comput_hold_time(t_presc: f32) ConfigError!u4 {
        const real_sdadel = (TimmingSpec_Standard.t_fall + TimmingSpec_Standard.t_min_vd_ack - TimmingSpec_Standard.t_max_af) / t_presc;
        if (real_sdadel > 15.0) {
            std.log.info("Hold time is too short consider lowering the i2cclk frequency", .{});
            return ConfigError.PCLKOverflow;
        }
        const sdadel = @as(u4, @intFromFloat(@round(real_sdadel)));
        // TODO check fi max value is less the 1 and return an error
        return if (sdadel == 0) 1 else sdadel;
    }

    fn comput_setup_time(t_presc: f32) ConfigError!u4 {
        const real_scdel = (TimmingSpec_Standard.t_rise + TimmingSpec_Standard.t_su_dat) / t_presc;
        if (real_scdel > 15.0) {
            std.log.info("Setup time is too short consider lowering the i2cclk frequency", .{});
            return ConfigError.PCLKOverflow;
        }
        const scdel = @as(u4, @intFromFloat(@round(real_scdel)));
        // TODO check fi max value is less the 1 and return an error
        return if (scdel == 0) 1 else scdel;
    }

    fn comput_low_time(t_presc: f32) ConfigError!u8 {
        const real_scll = ((TimmingSpec_Standard.t_low - TimmingSpec_Standard.t_min_af - 2 * t_presc) / t_presc) - 1;
        if (real_scll > 256.0) {
            std.log.info("Clock low time is too short consider lowering the i2cclk frequency", .{});
            return ConfigError.PCLKOverflow;
        }
        return @as(u8, @intFromFloat(@round(real_scll)));
    }

    fn comput_high_time(t_presc: f32) ConfigError!u8 {
        const real_sclh = ((TimmingSpec_Standard.t_high - TimmingSpec_Standard.t_min_af - 2 * t_presc) / t_presc) - 1;
        if (real_sclh > 256.0) {
            std.log.info("Clock high time is too short consider lowering the i2cclk frequency", .{});
            return ConfigError.PCLKOverflow;
        }
        return @as(u8, @intFromFloat(@round(real_sclh)));
    }

    pub fn apply(i2c: *const I2C) ConfigError!void {
        const regs = i2c.regs;

        const t_presc, const presc = try compute_presc();
        const scdel = try comput_setup_time(t_presc);
        const sdadel = try comput_hold_time(t_presc);
        const scll = try comput_low_time(t_presc);
        const sclh = try comput_high_time(t_presc);

        regs.CR1.modify(.{ .PE = 0 });

        std.log.info("TIMINGR register: SCEDL {}, SDADEL {}, SCLL {}, SCLH {}\r\n", .{ scdel, sdadel, scll, sclh });

        regs.TIMINGR.modify(.{
            .PRESC = presc,
            .SCLDEL = scdel,
            .SDADEL = sdadel,
            .SCLL = scll,
            .SCLH = sclh,
        });

        regs.CR1.modify(.{ .PE = 1 });
    }

    pub fn readv_blocking(i2c: *const I2C, addr: Address, chunks: []u8) void {
        const regs = i2c.regs;

        regs.CR2.modify(.{
            .NBYTES = @as(u8, @intCast(chunks.len)),
            .SADD = addr.addr << 1,
            .DIR = .Read,
        });
        regs.CR2.modify(.{
            .START = 1,
        });

        for (0..chunks.len) |index| {
            while (regs.ISR.read().RXNE != 1) {}
            chunks[index] = regs.RXDR.read().RXDATA;
        }

        regs.CR2.modify(.{
            .STOP = 1,
        });
    }

    fn writev_blocking(i2c: *const I2C, addr: Address, comptime restart: bool, chunks: []const u8) void {
        const regs = i2c.regs;

        regs.CR2.modify(.{
            .NBYTES = @as(u8, @intCast(chunks.len)),
            .SADD = addr.addr << 1,
            .AUTOEND = if (restart) .Software else .Automatic,
            .DIR = .Write,
        });

        regs.CR2.modify(.{
            .START = 1,
        });

        for (chunks) |byte| {
            while (regs.ISR.read().TXIS != 1) {}
            regs.TXDR.modify(.{
                .TXDATA = byte,
            });
        }

        if (!restart) {
            while (regs.ISR.read().STOPF != 1) {}
        } else {
            while (regs.ISR.read().TC != 1) {}
        }
    }

    pub fn write_blocking_restart(i2c: *const I2C, address: Address, data: []const u8) void {
        return i2c.writev_blocking(address, true, data);
    }

    pub fn write_blocking(i2c: *const I2C, address: Address, data: []const u8) void {
        return i2c.writev_blocking(address, false, data);
    }

    pub fn read_blocking(i2c: *const I2C, address: Address, data: []u8) void {
        return i2c.readv_blocking(address, data);
    }

    ///use this function to check if the i2c is busy in multi-master mode
    ///NOTE: in single master mode
    ///having a busy state before the start condition means that the bus is in an error state.
    pub fn is_busy(i2c: *const I2C) bool {
        const regs = i2c.regs;
        return regs.SR2.read().BUSY == 1;
    }

    pub fn init(comptime instance: I2CType) I2C {
        hal.rcc.enable_i2c(instance, .SYS);
        return .{ .regs = get_regs(instance) };
    }
};
