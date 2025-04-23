const std = @import("std");
const microzig = @import("microzig");
const Timeout = @import("drivers.zig").Timeout;

const I2CREGS = *volatile microzig.chip.types.peripherals.i2c_v1.I2C;
const DUTY = microzig.chip.types.peripherals.i2c_v1.DUTY;
const F_S = microzig.chip.types.peripherals.i2c_v1.F_S;
const peripherals = microzig.chip.peripherals;
const mdf = microzig.drivers;

pub const Mode = enum {
    standard,
    fast,
};

pub const AddressMode = enum {
    @"7bits",
    @"10bits",
};

pub const Address = struct {
    mode: AddressMode = .@"7bits",
    addr: u10,

    pub fn new(addr: u7) Address {
        return .{
            .addr = addr,
        };
    }

    pub fn new_10bits(addr: u10) Address {
        return .{
            .addr = addr,
            .mode = .@"10bits",
        };
    }
};

pub const Config = struct {
    pclk: usize,
    speed: usize,
    mode: Mode = .standard,
    enable_duty: bool = false,
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

pub const IOError = error{
    AckFailure,
    ArbitrationLoss,
    BusError,
    BusTimeout,
    Timeout,

    //https://www.st.com/content/ccc/resource/technical/document/errata_sheet/f5/50/c9/46/56/db/4a/f6/CD00197763.pdf/files/CD00197763.pdf/jcr:content/translations/en.CD00197763.pdf
    //Timeout during start and stop may indicate that the bus is stuck, therefore it is necessary to reset the I2C
    //the user must also ensure that the timeout period is long enough to complete the operation
    UnrecoverableError,
};

fn freq_to_ns(freq: usize) usize {
    return 1_000_000_000 / @as(u64, freq);
}
fn calc_Trise(pclk: usize, Tmax: usize) usize {
    const Tpclk: f32 = @floatFromInt(freq_to_ns(pclk));
    const fTmax: f32 = @floatFromInt(Tmax);
    const Trise: usize = @intFromFloat(@ceil((fTmax / Tpclk) + 1));
    return Trise;
}

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

pub const I2C = enum(u3) {
    _,
    fn get_regs(i2c: I2C) I2CREGS {
        return switch (@intFromEnum(i2c)) {
            0 => if (@hasDecl(peripherals, "I2C1")) peripherals.I2C1 else @panic("invalid i2c"),
            1 => if (@hasDecl(peripherals, "I2C2")) peripherals.I2C2 else @panic("invalid i2c"),
            2 => if (@hasDecl(peripherals, "I2C3")) peripherals.I2C3 else @panic("invalid i2c"),
            3 => if (@hasDecl(peripherals, "I2C4")) peripherals.I2C4 else @panic("invalid i2c"),
            else => @panic("invalid i2c"),
        };
    }

    fn validate_pclk(pclk: usize, mode: Mode) !void {
        if (pclk > 50_000_000) return comptime_fail_or_error("pclk needs to be < 50_000_000", .{}, ConfigError.PCLKOverflow);
        switch (mode) {
            .standard => {
                if (pclk < 2_000_000) return comptime_fail_or_error("pclk needs to be >= 2_000_000 in standard mode", .{}, ConfigError.PCLKUnderflow);
            },
            .fast => {
                if (pclk < 4_000_000) return comptime_fail_or_error("pclk needs to be >= 4_000_000 in fast mode", .{}, ConfigError.PCLKUnderflow);
            },
        }
    }

    fn validate_speed(speed: usize, mode: Mode) !void {
        if (speed == 0) return comptime_fail_or_error("Invalid I2C speed", .{}, ConfigError.SpeedUnderdlow);
        switch (mode) {
            .standard => {
                if (speed > 100_000) {
                    return comptime_fail_or_error("speed: {d} is too high for standard mode", .{speed}, ConfigError.SpeedOverflow);
                }
            },
            .fast => {
                if (speed > 400_000) {
                    return comptime_fail_or_error("speed: {d} is too high for fast mode", .{speed}, ConfigError.SpeedOverflow);
                }
            },
        }
    }

    fn validate_Trise(pclk: usize, mode: Mode) !usize {
        const Tmax = switch (mode) {
            .standard => 1000,
            .fast => 300,
        };

        const Trise = calc_Trise(pclk, Tmax);
        if ((Trise == 0) or (Trise > 63)) return comptime_fail_or_error("I2C config error: rise time invalid", .{}, ConfigError.InvalidTrise);
        return Trise;
    }

    fn validate_CCR(config: Config) !usize {
        const pclk = config.pclk;
        const speed = config.speed;
        const duty: ?bool = if (config.mode == .standard) null else config.enable_duty;
        const CCR = calc_CCR(pclk, speed, duty);
        switch (config.mode) {
            .fast => {
                if (CCR < 4) return comptime_fail_or_error("Invalid CCR", .{}, ConfigError.InvalidCCR);
            },
            else => {},
        }

        return CCR;
    }

    pub fn apply(i2c: I2C, comptime config: Config) void {
        const mode = config.mode;
        const pclk = config.pclk;
        comptime validate_pclk(pclk, mode) catch unreachable;
        comptime validate_speed(config.speed, mode) catch unreachable;
        const Trise = comptime validate_Trise(pclk, mode) catch unreachable;
        const CCR = comptime validate_CCR(config) catch unreachable;

        i2c.apply_internal(config, CCR, Trise);
    }

    pub fn runtime_apply(i2c: I2C, config: Config) ConfigError!void {
        const mode = config.mode;
        const pclk = config.pclk;
        try validate_pclk(pclk, mode);
        try validate_speed(config.speed, mode);
        const Trise = try validate_Trise(pclk, mode);
        const CCR = try validate_CCR(config);

        i2c.apply_internal(config, CCR, Trise);
    }

    fn apply_internal(i2c: I2C, config: Config, CCR: usize, Trise: usize) void {
        const regs = get_regs(i2c);
        const val: u6 = @intCast(config.pclk / 1_000_000);
        const duty: usize = if (config.enable_duty) 1 else 0;
        const mode: F_S = @enumFromInt(@intFromEnum(config.mode));

        regs.CR1.modify(.{ .PE = 0 });
        i2c.reset();

        regs.CR2.modify(.{ .FREQ = val });

        regs.TRISE.modify(.{ .TRISE = @as(u6, @intCast(Trise)) });

        regs.CCR.modify(.{
            .CCR = @as(u12, @intCast(CCR)),
            .DUTY = @as(DUTY, @enumFromInt(duty)),
            .F_S = mode,
        });

        regs.CR1.modify(.{ .PE = 1 });
    }

    fn reset(i2c: I2C) void {
        const regs = get_regs(i2c);
        regs.CR1.modify(.{ .SWRST = 1 });
        regs.CR1.modify(.{ .SWRST = 0 });
    }

    fn check_error(i2c: I2C, timeout: ?Timeout) IOError!void {
        const regs = get_regs(i2c);
        const status = regs.SR1.read();

        var io_err: ?IOError = null;

        if (status.AF == 1) {
            io_err = IOError.AckFailure;
        } else if (status.ARLO == 1) {
            io_err = IOError.ArbitrationLoss;
        } else if (status.BERR == 1) {
            io_err = IOError.BusError;
        } else if (status.TIMEOUT == 1) {
            io_err = IOError.BusTimeout;
        } else if (timeout) |check| {
            if (check.check_timeout()) {
                io_err = IOError.Timeout;
            }
        }

        //generate a stop condition if there is an error
        //if stop condition is not generated in time, i2c bus need to be reset
        if (io_err) |err| {
            try i2c.STOP(timeout);
            return err;
        }
    }

    pub fn clear_errors(i2c: I2C) void {
        const regs = get_regs(i2c);
        regs.SR1.modify(.{
            .AF = 0,
            .ARLO = 0,
            .BERR = 0,
        });
    }

    fn START(i2c: I2C, timeout: ?Timeout) IOError!void {
        const regs = get_regs(i2c);

        regs.CR1.modify(.{
            .ACK = 1,
            .START = 1,
        });

        //if start condition is not generated in time, i2c bus need to be reset
        //NOTE: this is a workaround for the errata 2.9.4
        while (regs.SR1.read().START != 1) {
            i2c.check_error(timeout) catch return IOError.UnrecoverableError;
        }
    }

    fn STOP(i2c: I2C, timeout: ?Timeout) IOError!void {
        const regs = get_regs(i2c);

        //if stop is already set, just wait for it to be cleared
        if (regs.CR1.read().STOP != 1) {
            regs.CR1.modify(.{
                .ACK = 0,
                .STOP = 1,
            });
        }

        //if stop condition is not generated in time, i2c bus need to be reset
        //if the bus still busy after stop condition, it means that the bus is in an error state, errata: 2.9.7
        while ((regs.CR1.read().STOP != 0) or i2c.is_busy()) {
            if (timeout) |check| {
                if (check.check_timeout()) return IOError.UnrecoverableError;
            }
        }
    }

    fn send_7bits_addr(i2c: I2C, addr: u10, IO: u1, timeout: ?Timeout) IOError!void {
        const regs = get_regs(i2c);
        const addr7 = @as(u8, @intCast(addr));
        const byte: u8 = (addr7 << 1) + IO;
        regs.DR.modify(.{ .DR = byte });

        while (regs.SR1.read().ADDR != 1) {
            try i2c.check_error(timeout);
        }

        std.mem.doNotOptimizeAway(regs.SR2.raw);
    }

    fn set_addr(i2c: I2C, address: Address, rw: u1, timeout: ?Timeout) IOError!void {
        switch (address.mode) {
            .@"7bits" => try i2c.send_7bits_addr(address.addr, rw, timeout),
            .@"10bits" => @panic("10bits address not supported yet"),
        }
    }

    pub fn readv_blocking(i2c: I2C, addr: Address, chunks: []const []u8, timeout: ?Timeout) IOError!void {
        for (chunks) |chunk| {
            try i2c.read_blocking(addr, chunk, timeout);
        }
    }

    pub fn writev_blocking(i2c: I2C, addr: Address, chunks: []const []u8, timeout: ?Timeout) IOError!void {
        for (chunks) |chunk| {
            try i2c.write_blocking(addr, chunk, timeout);
        }
    }

    pub fn write_blocking(i2c: I2C, address: Address, data: []const u8, timeout: ?Timeout) IOError!void {
        const regs = get_regs(i2c);
        try i2c.START(timeout);
        try i2c.set_addr(address, 0, timeout);

        for (data) |bytes| {
            regs.DR.modify(.{
                .DR = bytes,
            });

            while (regs.SR1.read().TXE != 1) {
                try i2c.check_error(timeout);
            }
        }

        while (regs.SR1.read().BTF != 1) {
            try i2c.check_error(timeout);
        }

        try i2c.STOP(timeout);
    }

    pub fn read_blocking(i2c: I2C, address: Address, data: []u8, timeout: ?Timeout) IOError!void {
        const regs = get_regs(i2c);

        try i2c.START(timeout);
        try i2c.set_addr(address, 1, timeout);

        regs.CR1.modify(.{
            .ACK = 1,
        });

        for (0..data.len) |index| {
            if (index == data.len - 1) {
                //disable ACk on last byte
                regs.CR1.modify(.{
                    .ACK = 0,
                });
            }
            while (regs.SR1.read().RXNE != 1) {
                try i2c.check_error(timeout);
            }

            data[index] = regs.DR.read().DR;
        }

        while (regs.SR1.read().BTF != 1) {
            try i2c.check_error(timeout);
        }

        try i2c.STOP(timeout);
    }

    ///use this function to check if the i2c is busy in multi-master mode
    /// NOTE: in single master mode
    /// having a busy state before the start condition means that the bus is in an error state.
    pub fn is_busy(i2c: I2C) bool {
        const regs = get_regs(i2c);
        return regs.SR2.read().BUSY == 1;
    }
};
