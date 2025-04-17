//TODO: add timeout

const std = @import("std");
const microzig = @import("microzig");
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

const Config = struct {
    pclk: usize,
    speed: usize,
    mode: Mode = .standard,
    enable_duty: bool = false,
};

const ConfigError = error{
    PCLKUnderflow,
    PCLKOverflow,
    SpeedOverflow,
    SpeedUnderdlow,
    InvalidAddress,
    InvalidTrise,
    InvalidCCR,
};

const IOError = error{
    ACK_FAILURE,
    ARBITRATION_LOST,
    BUS_ERROR,
    BUS_TIMEOUT,
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

    fn validade_pclk(pclk: usize, mode: Mode) !void {
        if (pclk > 50_000_000) return comptime_fail_or_error("pclk need to be < 50_000_000", .{}, ConfigError.PCLKOverflow);
        switch (mode) {
            .standard => {
                if (pclk < 2_000_000) return comptime_fail_or_error("pclk need to be >= 2_000_000 in standart mode", .{}, ConfigError.PCLKUnderflow);
            },
            .fast => {
                if (pclk < 4_000_000) return comptime_fail_or_error("pclk need to be >= 4_000_000 in fast mode", .{}, ConfigError.PCLKUnderflow);
            },
        }
    }

    fn validade_speed(speed: usize, mode: Mode) !void {
        if (speed == 0) return comptime_fail_or_error("Invalid I2C speed", .{}, ConfigError.SpeedUnderdlow);
        switch (mode) {
            .standard => {
                if (speed > 100_000) {
                    return comptime_fail_or_error("speed: {d} is too high for stardart mode", .{speed}, ConfigError.SpeedOverflow);
                }
            },
            .fast => {
                if (speed > 400_000) {
                    return comptime_fail_or_error("speed: {d} is too high for fast mode", .{speed}, ConfigError.SpeedOverflow);
                }
            },
        }
    }

    fn validade_Trise(pclk: usize, mode: Mode) !usize {
        const Tmax = switch (mode) {
            .standard => 1000,
            .fast => 300,
        };

        const Trise = calc_Trise(pclk, Tmax);
        if ((Trise == 0) or (Trise > 63)) return comptime_fail_or_error("I2C config error: rise time invalid", .{}, ConfigError.InvalidTrise);
        return Trise;
    }

    fn validade_CCR(config: Config) !usize {
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
        comptime validade_pclk(pclk, mode) catch unreachable;
        comptime validade_speed(config.speed, mode) catch unreachable;
        const Trise = comptime validade_Trise(pclk, mode) catch unreachable;
        const CCR = comptime validade_CCR(config) catch unreachable;

        i2c.apply_internal(config, CCR, Trise);
    }

    pub fn runtime_apply(i2c: I2C, config: Config) ConfigError!void {
        const mode = config.mode;
        const pclk = config.pclk;
        try validade_pclk(pclk, mode);
        try validade_speed(config.speed, mode);
        const Trise = try validade_Trise(pclk, mode);
        const CCR = try validade_CCR(config);

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

    fn check_error(i2c: I2C) IOError!void {
        const regs = get_regs(i2c);
        const status = regs.SR1.read();
        if (status.AF == 1) {
            return IOError.ACK_FAILURE;
        } else if (status.ARLO == 1) {
            return IOError.ARBITRATION_LOST;
        } else if (status.BERR == 1) {
            return IOError.BUS_ERROR;
        } else if (status.TIMEOUT == 1) {
            return IOError.BUS_TIMEOUT;
        }
    }

    pub fn clear_errors(i2c: I2C) void {
        const regs = get_regs(i2c);
        regs.SR1.modify(.{
            .AF = 0,
            .ARLO = 0,
            .BERR = 0,
        });
        while (i2c.is_busy()) {
            i2c.STOP();
        }
    }

    fn is_busy(i2c: I2C) bool {
        const regs = get_regs(i2c);
        return regs.SR2.read().BUSY == 1;
    }

    fn START(i2c: I2C) IOError!void {
        //NOTE: check busy line here?
        const regs = get_regs(i2c);

        while (i2c.is_busy()) {
            try i2c.check_error();
        }
        regs.CR1.modify(.{
            .ACK = 1,
            .START = 1,
        });
        while (regs.SR1.read().START != 1) {
            try i2c.check_error();
        }
    }

    fn STOP(i2c: I2C) void {
        const regs = get_regs(i2c);
        regs.CR1.modify(.{
            .ACK = 0,
            .STOP = 1,
        });

        while (regs.CR1.read().STOP != 0) {}
    }

    fn send_10bits_addr(i2c: I2C, addr: u10, IO: u1) IOError!void {
        _ = i2c;
        _ = addr;
        _ = IO;
        //TODO
    }

    fn send_7bits_addr(i2c: I2C, addr: u10, IO: u1) IOError!void {
        const regs = get_regs(i2c);
        const addr7 = @as(u8, @intCast(addr));
        const byte: u8 = (addr7 << 1) + IO;
        regs.DR.modify(.{ .DR = byte });

        while (regs.SR1.read().ADDR != 1) {
            try i2c.check_error();
        }

        std.mem.doNotOptimizeAway(regs.SR2.raw);
    }

    fn set_addr(i2c: I2C, address: Address, rw: u1) IOError!void {
        switch (address.mode) {
            .@"7bits" => try i2c.send_7bits_addr(address.addr, rw),
            .@"10bits" => try i2c.send_10bits_addr(address.addr, rw),
        }
    }

    pub fn readv_blocking(i2c: I2C, addr: Address, chunks: []const []u8, timeout: ?mdf.time.Duration) IOError!void {
        for (chunks) |chunk| {
            try i2c.read_blocking(addr, chunk, timeout);
        }
    }

    pub fn writev_blocking(i2c: I2C, addr: Address, chunks: []const []u8, timeout: ?mdf.time.Duration) IOError!void {
        for (chunks) |chunk| {
            try i2c.write_blocking(addr, chunk, timeout);
        }
    }

    pub fn write_blocking(i2c: I2C, address: Address, data: []const u8, _: ?mdf.time.Duration) IOError!void {
        const regs = get_regs(i2c);
        try i2c.START();
        try i2c.set_addr(address, 0);

        for (data) |bytes| {
            regs.DR.modify(.{
                .DR = bytes,
            });

            while (regs.SR1.read().TXE != 1) {
                try i2c.check_error();
            }
        }

        while (regs.SR1.read().BTF != 1) {
            try i2c.check_error();
        }

        i2c.STOP();
    }

    pub fn read_blocking(i2c: I2C, address: Address, data: []u8, _: ?mdf.time.Duration) IOError!void {
        const regs = get_regs(i2c);

        try i2c.START();
        try i2c.set_addr(address, 1);

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
                try i2c.check_error();
            }

            data[index] = regs.DR.read().DR;
        }

        while (regs.SR1.read().BTF != 1) {
            try i2c.check_error();
        }

        i2c.STOP();
    }
};
