const std = @import("std");
const microzig = @import("microzig");
const emus_type = @import("enums_type.zig");

const I2CType = emus_type.I2CType;
const I2C_t = microzig.chip.types.peripherals.i2c_v2.I2C;
const peripherals = microzig.chip.peripherals;
const hal = microzig.hal;
const drivers = microzig.drivers.base;

pub const Address = drivers.I2C_Device.Address;
const InterfaceError = drivers.I2C_Device.InterfaceError;

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

fn get_regs(comptime instance: I2CType) *volatile I2C_t {
    return @field(microzig.chip.peripherals, @tagName(instance));
}

const I2C = struct {
    regs: *volatile I2C_t,

    fn compute_presc() ConfigError!struct { f32, u4 } {
        // Let first see if we need to prescale.
        // 100Khz = 10us period ~ 5us for SCLL/SCLH
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
        const real_sdadel = (TimingSpec_Standard.t_fall + TimingSpec_Standard.t_min_vd_ack - TimingSpec_Standard.t_max_af) / t_presc;
        if (real_sdadel > 15.0) {
            std.log.info("Hold time is too short consider lowering the i2cclk frequency", .{});
            return ConfigError.PCLKOverflow;
        }
        const sdadel = @as(u4, @intFromFloat(@round(real_sdadel)));
        // TODO check fi max value is less the 1 and return an error
        return if (sdadel == 0) 1 else sdadel;
    }

    fn comput_setup_time(t_presc: f32) ConfigError!u4 {
        const real_scdel = (TimingSpec_Standard.t_rise + TimingSpec_Standard.t_su_dat) / t_presc;
        if (real_scdel > 15.0) {
            std.log.info("Setup time is too short consider lowering the i2cclk frequency", .{});
            return ConfigError.PCLKOverflow;
        }
        const scdel = @as(u4, @intFromFloat(@round(real_scdel)));
        // TODO check fi max value is less the 1 and return an error
        return if (scdel == 0) 1 else scdel;
    }

    fn comput_low_time(t_presc: f32) ConfigError!u8 {
        const real_scll = ((TimingSpec_Standard.t_low - TimingSpec_Standard.t_min_af - 2 * t_presc) / t_presc) - 1;
        if (real_scll > 256.0) {
            std.log.info("Clock low time is too short consider lowering the i2cclk frequency", .{});
            return ConfigError.PCLKOverflow;
        }
        return @as(u8, @intFromFloat(@round(real_scll)));
    }

    fn comput_high_time(t_presc: f32) ConfigError!u8 {
        const real_sclh = ((TimingSpec_Standard.t_high - TimingSpec_Standard.t_min_af - 2 * t_presc) / t_presc) - 1;
        if (real_sclh > 256.0) {
            std.log.info("Clock high time is too short consider lowering the i2cclk frequency", .{});
            return ConfigError.PCLKOverflow;
        }
        return @as(u8, @intFromFloat(@round(real_sclh)));
    }

    // TODO this should configure
    // Interupt,
    // Frequency
    // Others...
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

    pub fn read_blocking(i2c: *const I2C, addr: Address, chunks: []u8) void {
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
            while (regs.ISR.read().RXNE != 1) {}
            chunks[index] = regs.RXDR.read().RXDATA;
        }

        regs.CR2.modify(.{
            .STOP = 1,
        });
    }

    fn write_blocking_intern(i2c: *const I2C, addr: Address, comptime restart: bool, chunks: []const u8) void {
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
        return i2c.write_blocking_intern(address, true, data);
    }

    pub fn write_blocking(i2c: *const I2C, address: Address, data: []const u8) void {
        return i2c.write_blocking_intern(address, false, data);
    }

    pub fn init(comptime instance: I2CType) I2C {
        hal.rcc.enable_i2c(instance, .SYS);
        return .{ .regs = get_regs(instance) };
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
            i2c.i2c.write_blocking(addr, chunk);
        }
    }

    fn readv_fn(dev: *anyopaque, addr: Address, datagrams: []const []u8) InterfaceError!usize {
        const i2c: *I2C_Device = @ptrCast(@alignCast(dev));
        addr.check_reserved() catch {
            return InterfaceError.TargetAddressReserved;
        };
        var read: usize = 0;
        for (datagrams) |chunk| {
            i2c.i2c.read_blocking(addr, chunk);
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
            i2c.i2c.write_blocking_restart(addr, chunk);
            i2c.i2c.read_blocking(addr, read_chunks[index]);
        }
    }

    pub fn apply(i2c: *const I2C_Device) ConfigError!void {
        try i2c.i2c.apply();
    }

    pub fn init(comptime instance: I2CType) I2C_Device {
        return .{ .i2c = I2C.init(instance) };
    }

    pub fn i2c_device(i2c: *I2C_Device) drivers.I2C_Device {
        return .{ .ptr = i2c, .vtable = &device_vtable };
    }
};
