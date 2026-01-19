const std = @import("std");
const microzig = @import("microzig");
const syscon = @import("syscon.zig");
const chip = microzig.chip;
const peripherals = chip.peripherals;
const assert = std.debug.assert;

/// A Low-Power Flexible Communications interface (LP FlexComm).
/// To initialize Uart, SPI or I2C, use `LPUart` or `LPI2c` instead.
///
/// Note that the module's clock is not the same as the interface's clock.
/// If the module's clock is disabled, writing to flexcomm control registers do nothing.
/// The interface's clock is the one used to control the speed of the communication.
pub const FlexComm = enum(u4) {
    _,

    pub const LP_UART = @import("flexcomm/LP_UART.zig").LP_UART;
    pub const LP_I2C = @import("flexcomm/LP_I2C.zig").LP_I2C;

    pub const Type = enum(u3) { none = 0, UART = 1, SPI = 2, I2C = 3, @"UART+I2C" = 7 };

    pub const RegTy = *volatile chip.types.peripherals.LP_FLEXCOMM0;
    const Registers: [10]RegTy = .{
        peripherals.LP_FLEXCOMM0,
        peripherals.LP_FLEXCOMM1,
        peripherals.LP_FLEXCOMM2,
        peripherals.LP_FLEXCOMM3,
        peripherals.LP_FLEXCOMM4,
        peripherals.LP_FLEXCOMM5,
        peripherals.LP_FLEXCOMM6,
        peripherals.LP_FLEXCOMM7,
        peripherals.LP_FLEXCOMM8,
        peripherals.LP_FLEXCOMM9,
    };

    /// Returns the corresponding flexcomm interface.
    /// `n` can be at most 9 (inclusive).
    pub fn num(n: u4) FlexComm {
        assert(n <= 9);
        return @enumFromInt(n);
    }

    /// Initialize a Uart / SPI / I2C interface on a given flexcomm interface.
    ///
    /// Release the reset and enable the module's clock.
    pub fn init(flexcomm: FlexComm, ty: Type) void {
        const module = flexcomm.get_module();

        syscon.module_reset_release(module);
        syscon.module_enable_clock(module);
        flexcomm.get_regs().PSELID.modify_one("PERSEL", @enumFromInt(@intFromEnum(ty)));
    }

    /// Deinit the interface by disabling the clock and asserting the module's reset.
    pub fn deinit(flexcomm: FlexComm) void {
        const module = flexcomm.get_module();

        syscon.module_disable_clock(module);
        syscon.module_reset_assert(module);
    }

    pub const Clock = enum(u3) {
        none = 0,
        PLL = 1,
        FRO_12MHz = 2,
        fro_hf_div = 3,
        clk_1m = 4,
        usb_pll = 5,
        lp_oscillator = 6,
        _, // also no clock

        const ClockTy = @FieldType(@TypeOf(chip.peripherals.SYSCON0.FCCLKSEL[0]).underlying_type, "SEL");

        pub fn from(clk: ClockTy) Clock {
            return @enumFromInt(@intFromEnum(clk));
        }

        pub fn to(clk: Clock) ClockTy {
            return @enumFromInt(@intFromEnum(clk));
        }
    };

    /// Configures the clock of the interface.
    /// `divider` must be between 1 and 256 (inclusive).
    ///
    /// To stop the clock, see `FlexComm.stop_clock`.
    pub fn set_clock(flexcomm: FlexComm, clock: Clock, divider: u16) void {
        assert(divider > 0 and divider <= 256);
        const n = flexcomm.get_n();
        chip.peripherals.SYSCON0.FLEXCOMMCLKDIV[n].write(.{
            .DIV = @intCast(divider - 1),
            .RESET = .RELEASED,
            .HALT = .RUN,
            .UNSTAB = .STABLE, // read-only field
        });
        chip.peripherals.SYSCON0.FCCLKSEL[n].modify_one("SEL", clock.to());
    }

    /// Stops the interface's clock.
    pub fn stop_clock(flexcomm: FlexComm) void {
        chip.peripherals.SYSCON0.FLEXCOMMCLKDIV[flexcomm.get_n()].modify("HALT", .HALT);
    }

    /// Starts the interface's clock.
    pub fn start_clock(flexcomm: FlexComm) void {
        chip.peripherals.SYSCON0.FLEXCOMMCLKDIV[flexcomm.get_n()].modify("HALT", .RUN);
    }

    /// Computes the current clock speed of the interface in Hz (taking into account the divider).
    /// Returns 0 if the clock is disabled.
    pub fn get_clock(flexcomm: FlexComm) u32 {
        const n = flexcomm.get_n();
        const div = chip.peripherals.SYSCON0.FLEXCOMMCLKDIV[n].read();
        if (div.HALT == .HALT) return 0;

        const clock = Clock.from(chip.peripherals.SYSCON0.FCCLKSEL[n].read().SEL);
        // TODO: complete this function (see the sdk's implementation)
        const freq: u32 = switch (clock) {
            // .PLL   => 1,
            .FRO_12MHz => 12_000_000,
            // .fro_hf_div => 3,
            .clk_1m => 1_000_000,
            // .usb_pll=> 5,
            // .lp_oscillator => 6,
            else => @panic("TODO"),
            // else => 0
        };

        return freq / (@as(u32, div.DIV) + 1);
    }

    fn get_n(flexcomm: FlexComm) u4 {
        return @intFromEnum(flexcomm);
    }

    fn get_regs(flexcomm: FlexComm) RegTy {
        // We can't do `base + n * offset` to get the register since the offset
        // is not constant for flexcomm registers
        return FlexComm.Registers[flexcomm.get_n()];
    }

    fn get_module(flexcomm: FlexComm) syscon.Module {
        return @enumFromInt(@intFromEnum(syscon.Module.FC0) + flexcomm.get_n());
    }
};
