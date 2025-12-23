const std = @import("std");
const microzig = @import("microzig");
const systick = microzig.cpu.peripherals.systick;
const hal = microzig.hal;

var tick_per_us: u64 = 0;
var period: u32 = 0;

const SystickError = error{
    ClkOverflow,
    ClkUnderflow,
};

const MAX_COUNTER = 0xFFFFFF;

// For now we need a clock source that is less than 16Mhz so
// the counter could hold value for an interupt every second.
// We will choose the best clock source for that.
// HAL should provide both value.
// See: https://developer.arm.com/documentation/dui0497/a/cortex-m0-peripherals/optional-system-timer--systick/systick-control-and-status-register
pub fn init() SystickError!void {
    const use_processor_clk = if (hal.get_sys_clk() > MAX_COUNTER) false else true;
    const sys_freq = if (use_processor_clk) hal.get_sys_clk() else hal.get_systick_clk();

    if (sys_freq > MAX_COUNTER) {
        return SystickError.ClkOverflow;
    }

    tick_per_us = sys_freq / 1_000_000;
    period = 0;

    if (tick_per_us == 0) {
        // We need a clock source that is at least capable of us resolution (>1Mhz)
        return SystickError.ClkUnderflow;
    }

    systick.LOAD.modify(.{
        // Let's fire the handler every second.
        .RELOAD = @as(u24, @intCast(sys_freq)),
    });
    systick.VAL.modify(.{
        .CURRENT = @as(u24, @intCast(sys_freq)),
    });
    if (use_processor_clk) {
        systick.CTRL.modify(.{
            .CLKSOURCE = 1,
        });
    }
    systick.CTRL.modify(.{
        .TICKINT = 1,
        .ENABLE = 1,
    });
}

pub fn deinit() void {
    systick.CTRL.modify(.{
        .TICKINT = 0,
        .ENABLE = 0,
    });
    systick.LOAD.modify(.{
        .RELOAD = 0,
    });
    systick.VAL.modify(.{
        .CURRENT = 0,
    });
    tick_per_us = 0;
    period = 0;
}

pub fn is_initialized() bool {
    return tick_per_us > 0;
}

// Low level function to build clock device from it.
pub fn get_time_since_boot() u64 {
    const reload = systick.LOAD.read().RELOAD;
    const ticks = reload - systick.VAL.read().CURRENT;
    const p = microzig.cpu.atomic.load(u32, &period, .acquire);
    const us = (@as(u64, p) * 1_000_000) + @as(u64, ticks / tick_per_us);
    return us;
}

pub fn SysTick_handler() callconv(.c) void {
    _ = microzig.cpu.atomic.add(u32, &period, 1);
}
