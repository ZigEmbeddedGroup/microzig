const std = @import("std");
const microzig = @import("microzig");
const systick = microzig.cpu.peripherals.systick;
const hal = microzig.hal;

var ns_per_ticks: u64 = 0;
var accumulated_ticks: u32 = 0;

const SystickError = error{
    ClkOverflow,
    ClkUnderflow,
};

const MAX_COUNTER = 0xFFFFFF;

// HAL should provide clock source for systick as well as ahb.
// We will choose from the fastest clock source.
// See: https://developer.arm.com/documentation/dui0497/a/cortex-m0-peripherals/optional-system-timer--systick/systick-control-and-status-register
pub fn init() SystickError!void {
    if (microzig.cpu.using_ram_vector_table) {
        microzig.cpu.ram_vector_table.SysTick = .{ .c = SysTick_handler };
    } else {
        const vector_table: *microzig.cpu.VectorTable = @ptrFromInt(0x0);
        // SysTick_Handler need to be setup in the interrupt table
        std.debug.assert(vector_table.SysTick.* == @intFromPtr(&SysTick_handler));
    }

    const use_processor_clk = if (hal.get_sys_clk() > hal.get_systick_clk()) false else true;
    const sys_freq = if (use_processor_clk) hal.get_sys_clk() else hal.get_systick_clk();

    ns_per_ticks = 1_024_000_000 / sys_freq;
    accumulated_ticks = 0;

    if (ns_per_ticks > 1024) {
        // We need a clock source that is at least capable of us resolution (>1Mhz)
        return SystickError.ClkUnderflow;
    }

    systick.LOAD.modify(.{
        .RELOAD = 0xFFFFFF,
    });
    systick.VAL.modify(.{
        .CURRENT = 0xFFFFFF,
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
    ns_per_ticks = 0;
    accumulated_ticks = 0;
}

pub fn is_initialized() bool {
    return ns_per_ticks > 0;
}

// Low level function to build clock device from it.
pub fn get_time_since_boot() u64 {
    const reload = systick.LOAD.read().RELOAD;
    const ticks = @as(u64, @intCast(reload - systick.VAL.read().CURRENT));
    const all_ticks = @as(u64, @intCast(microzig.cpu.atomic.load(u32, &accumulated_ticks, .acquire))) << 24 | ticks;
    const ns = all_ticks * ns_per_ticks;
    return ns >> 10;
}

pub fn SysTick_handler() callconv(.c) void {
    _ = microzig.cpu.atomic.add(u32, &accumulated_ticks, 1);
}
