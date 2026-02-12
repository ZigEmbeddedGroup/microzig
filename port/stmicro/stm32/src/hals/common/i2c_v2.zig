const std = @import("std");
const microzig = @import("microzig");
const enums = @import("enums.zig");

const I2C_Type = enums.I2C_Type;
const I2C_Peripherals = microzig.chip.types.peripherals.i2c_v2.I2C;
const hal = microzig.hal;
const drivers = microzig.drivers.base;

pub const Address = drivers.I2C_Device.Address;
const InterfaceError = drivers.I2C_Device.InterfaceError;
const I2CError = drivers.I2C_Device.Error;

pub const ConfigError = error{
    PCLKUnderflow,
    PCLKOverflow,
};

// 100Khz for now
const TimingSpec_Standard = .{
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

const TIMINGR = blk: for (@typeInfo(I2C_Peripherals).@"struct".fields) |field|
{
    if (std.mem.eql(u8, "TIMINGR", field.name)) {
        break :blk field.type;
    }
} else @compileError("No TIMINGR register");

const I2C = struct {
    regs: *volatile I2C_Peripherals,
    timingr: TIMINGR.underlying_type,

    fn compute_presc(comptime instance: I2C_Type) ConfigError!struct { f32, u4 } {
        // Let first see if we need to prescale.
        // 100Khz = 10us period ~ 5us for SCLL/SCLH
        const device_clock = @as(f32, @floatFromInt(hal.rcc.get_clock(enums.to_peripheral(instance))));
        const t_sckl = 1_000_000.0 / device_clock;

        if (t_sckl > 0.1) {
            return .{ t_sckl, 0 };
        }

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

    fn compute_hold_time(t_presc: f32) ConfigError!u4 {
        const real_sdadel = (TimingSpec_Standard.t_fall + TimingSpec_Standard.t_min_vd_ack - TimingSpec_Standard.t_max_af) / t_presc;
        if (real_sdadel > 15.0) {
            std.log.info("Hold time is too short consider lowering the i2cclk frequency", .{});
            return ConfigError.PCLKOverflow;
        }
        const sdadel = @as(u4, @intFromFloat(@round(real_sdadel)));
        // TODO check fi max value is less the 1 and return an error
        return if (sdadel == 0) 1 else sdadel;
    }

    fn compute_setup_time(t_presc: f32) ConfigError!u4 {
        const real_scdel = (TimingSpec_Standard.t_rise + TimingSpec_Standard.t_su_dat) / t_presc;
        if (real_scdel > 15.0) {
            std.log.info("Setup time is too short consider lowering the i2cclk frequency", .{});
            return ConfigError.PCLKOverflow;
        }
        const scdel = @as(u4, @intFromFloat(@round(real_scdel)));
        // TODO check fi max value is less the 1 and return an error
        return if (scdel == 0) 1 else scdel;
    }

    fn compute_low_time(t_presc: f32) ConfigError!u8 {
        const real_scll = ((TimingSpec_Standard.t_low - TimingSpec_Standard.t_min_af - 2 * t_presc) / t_presc) - 1;
        if (real_scll > 256.0) {
            std.log.info("Clock low time is too short consider lowering the i2cclk frequency", .{});
            return ConfigError.PCLKOverflow;
        }
        return @as(u8, @intFromFloat(@round(real_scll)));
    }

    fn compute_high_time(t_presc: f32) ConfigError!u8 {
        const real_sclh = ((TimingSpec_Standard.t_high - TimingSpec_Standard.t_min_af - 2 * t_presc) / t_presc) - 1;
        if (real_sclh > 256.0) {
            std.log.info("Clock high time is too short consider lowering the i2cclk frequency", .{});
            return ConfigError.PCLKOverflow;
        }
        return @as(u8, @intFromFloat(@round(real_sclh)));
    }

    fn check_error(i2c: *const I2C) I2CError!void {
        const status = i2c.regs.ISR.read();

        if (status.NACKF == 1) {
            return I2CError.NoAcknowledge;
        }
        if (status.BERR == 1) {
            return I2CError.UnknownAbort;
        }
    }

    // TODO this should configure
    // Interupt,
    // Frequency
    // Others...
    pub fn apply(i2c: *const I2C) void {
        const regs = i2c.regs;

        regs.CR1.modify(.{ .PE = 0 });

        regs.TIMINGR.write(i2c.timingr);

        regs.CR1.modify(.{ .PE = 1 });
    }

    pub fn read_blocking(i2c: *const I2C, addr: Address, chunks: []u8) I2CError!void {
        const regs = i2c.regs;

        regs.CR2.modify(.{
            .NBYTES = @as(u8, @intCast(chunks.len)),
            .SADD = @as(u10, @intCast(@intFromEnum(addr))) << 1,
            .DIR = .Read,
        });
        regs.CR2.modify(.{
            .START = 1,
        });

        for (0..chunks.len) |index| {
            try i2c.check_error();
            while (regs.ISR.read().RXNE != 1) {}
            chunks[index] = regs.RXDR.read().RXDATA;
        }

        regs.CR2.modify(.{
            .STOP = 1,
        });
    }

    fn write_blocking_intern(i2c: *const I2C, addr: Address, comptime restart: bool, chunks: []const u8) I2CError!void {
        const regs = i2c.regs;

        regs.CR2.modify(.{
            .NBYTES = @as(u8, @intCast(chunks.len)),
            .SADD = @as(u10, @intCast(@intFromEnum(addr))) << 1,
            .AUTOEND = if (restart) .Software else .Automatic,
            .DIR = .Write,
        });

        regs.CR2.modify(.{
            .START = 1,
        });

        for (chunks) |byte| {
            try i2c.check_error();
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

    pub fn write_blocking_restart(i2c: *const I2C, address: Address, data: []const u8) I2CError!void {
        return i2c.write_blocking_intern(address, true, data);
    }

    pub fn write_blocking(i2c: *const I2C, address: Address, data: []const u8) I2CError!void {
        return i2c.write_blocking_intern(address, false, data);
    }

    /// Initialize a given I2C peripheral and compute the
    /// TIMINGR register base on the clock frequency.
    /// Be aware that this require FPU.
    ///
    /// Note: This can be run at comptime if rcc clock is comptime known
    /// and remove the need of FPU.
    pub fn init(comptime instance: I2C_Type) ConfigError!I2C {
        hal.rcc.enable_clock(enums.to_peripheral(instance));
        const t_presc, const presc = try compute_presc(instance);
        const scdel = try compute_setup_time(t_presc);
        const sdadel = try compute_hold_time(t_presc);
        const scll = try compute_low_time(t_presc);
        const sclh = try compute_high_time(t_presc);

        const timingr: TIMINGR.underlying_type = .{
            .PRESC = presc,
            .SCLDEL = scdel,
            .SDADEL = sdadel,
            .SCLL = scll,
            .SCLH = sclh,
        };

        return .{ .regs = enums.get_regs(I2C_Peripherals, instance), .timingr = timingr };
    }
};

pub const I2C_Device = struct {
    i2c: I2C,
    const device_vtable = drivers.I2C_Device.VTable{
        .writev_fn = I2C_Device.writev_fn,
        .readv_fn = I2C_Device.readv_fn,
        .writev_then_readv_fn = I2C_Device.writev_then_readv_fn,
    };
    fn writev_fn(dev: *anyopaque, addr: Address, datagrams: []const []const u8) InterfaceError!void {
        const i2c: *I2C_Device = @ptrCast(@alignCast(dev));
        addr.check_reserved() catch {
            return InterfaceError.TargetAddressReserved;
        };
        for (datagrams) |chunk| {
            try i2c.i2c.write_blocking(addr, chunk);
        }
    }

    fn readv_fn(dev: *anyopaque, addr: Address, datagrams: []const []u8) InterfaceError!usize {
        const i2c: *I2C_Device = @ptrCast(@alignCast(dev));
        addr.check_reserved() catch {
            return InterfaceError.TargetAddressReserved;
        };
        var read: usize = 0;
        for (datagrams) |chunk| {
            try i2c.i2c.read_blocking(addr, chunk);
            read += chunk.len;
        }
        return read;
    }

    fn writev_then_readv_fn(
        dev: *anyopaque,
        addr: Address,
        write_chunks: []const []const u8,
        read_chunks: []const []u8,
    ) InterfaceError!void {
        const i2c: *I2C_Device = @ptrCast(@alignCast(dev));
        addr.check_reserved() catch {
            return InterfaceError.TargetAddressReserved;
        };
        for (write_chunks, 0..) |chunk, index| {
            try i2c.i2c.write_blocking_restart(addr, chunk);
            try i2c.i2c.read_blocking(addr, read_chunks[index]);
        }
    }

    pub fn apply(i2c: *const I2C_Device) void {
        i2c.i2c.apply();
    }

    pub fn init(comptime instance: I2C_Type) ConfigError!I2C_Device {
        return .{ .i2c = try I2C.init(instance) };
    }

    pub fn i2c_device(i2c: *I2C_Device) drivers.I2C_Device {
        return .{ .ptr = i2c, .vtable = &device_vtable };
    }
};
