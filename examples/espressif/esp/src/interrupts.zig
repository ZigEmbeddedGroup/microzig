const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const gpio = microzig.hal.gpio;
const uart = microzig.hal.uart;
const SYSTEM = peripherals.SYSTEM;
const SYSTIMER = peripherals.SYSTIMER;

pub const microzig_options: microzig.Options = .{
    .interrupts = .{
        .interrupt1 = timer_interrupt,
    },
};

// the `.trap` link section is placed in iram in image boot mode or irom in direct boot mode.
fn timer_interrupt(_: *microzig.cpu.InterruptStack) linksection(".trap") callconv(.c) void {
    uart.write(0, "timer interrupt!\n");

    SYSTIMER.INT_CLR.modify(.{ .TARGET0_INT_CLR = 1 });
}

pub fn main() !void {
    SYSTEM.PERIP_CLK_EN0.modify(.{
        .SYSTIMER_CLK_EN = 1,
    });

    SYSTIMER.CONF.modify(.{
        .TIMER_UNIT0_WORK_EN = 1,
        .TIMER_UNIT0_CORE0_STALL_EN = 0,
    });

    SYSTIMER.TARGET0_CONF.modify(.{
        .TARGET0_PERIOD = 16_000_000,
        .TARGET0_PERIOD_MODE = 0,
        .TARGET0_TIMER_UNIT_SEL = 0,
    });

    SYSTIMER.COMP0_LOAD.write(.{
        .TIMER_COMP0_LOAD = 1,
        .padding = 0,
    });

    SYSTIMER.TARGET0_CONF.modify(.{
        .TARGET0_PERIOD_MODE = 1,
    });

    SYSTIMER.CONF.modify(.{ .TARGET0_WORK_EN = 1 });
    SYSTIMER.INT_ENA.modify(.{ .TARGET0_INT_ENA = 1 });

    microzig.cpu.interrupt.set_priority_threshold(.zero);

    microzig.cpu.interrupt.set_type(.interrupt1, .level);
    microzig.cpu.interrupt.set_priority(.interrupt1, .highest);
    microzig.cpu.interrupt.map(.systimer_target0, .interrupt1);
    microzig.cpu.interrupt.enable(.interrupt1);

    microzig.cpu.interrupt.enable_interrupts();

    while (true) {
        microzig.cpu.wfi();
    }
}
