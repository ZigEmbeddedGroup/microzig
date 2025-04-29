const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const hal = microzig.hal;
const gpio = hal.gpio;
const systimer = hal.systimer;
const usb_serial_jtag = hal.usb_serial_jtag;

pub const microzig_options: microzig.Options = .{
    .log_level = .debug,
    .logFn = usb_serial_jtag.logger.logFn,
    .interrupts = .{
        .interrupt1 = timer_interrupt,
    },
};

const alarm = systimer.alarm(0);

// the `.trap` link section is placed in iram in image boot mode or irom in direct boot mode.
fn timer_interrupt(_: *microzig.cpu.TrapFrame) linksection(".trap") callconv(.c) void {
    std.log.info("timer interrupt!", .{});

    alarm.clear_interrupt();
}

pub fn main() !void {
    std.log.info("hello world!", .{});

    // unit0 is already enabled as it is used by `hal.time`.
    alarm.set_unit(.unit0);

    // sets the period to one second.
    alarm.set_period(@intCast(1_000_000 * systimer.ticks_per_us()));

    // to enable period mode you have to first clear the mode bit.
    alarm.set_mode(.target);
    alarm.set_mode(.period);

    alarm.set_interrupt_enabled(true);
    alarm.set_enabled(true);

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
