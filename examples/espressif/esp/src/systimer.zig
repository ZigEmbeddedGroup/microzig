const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const systimer = hal.systimer;
const usb_serial_jtag = hal.usb_serial_jtag;

pub const microzig_options: microzig.Options = .{
    .logFn = usb_serial_jtag.logger.log,
    .interrupts = .{
        .interrupt1 = .{ .c = timer_interrupt },
    },
};

const alarm = systimer.alarm(0);

fn timer_interrupt(_: *microzig.cpu.TrapFrame) linksection(".ram_text") callconv(.c) void {
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
