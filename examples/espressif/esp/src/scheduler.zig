const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const esp = microzig.hal;
const gpio = esp.gpio;
const systimer = esp.systimer;
const usb_serial_jtag = esp.usb_serial_jtag;

pub const microzig_options: microzig.Options = .{
    .logFn = usb_serial_jtag.logger.log,
    .interrupts = .{
        .interrupt1 = timer_interrupt,
    },
    .log_level = .debug,
};

const alarm = systimer.alarm(0);

fn timer_interrupt(_: *microzig.cpu.TrapFrame) linksection(".ram_text") callconv(.c) void {
    std.log.info("timer interrupt!", .{});

    alarm.clear_interrupt();
}

var scheduler: esp.Scheduler = undefined;
var mutex: esp.Scheduler.Mutex = .init;

fn task1(_: ?*anyopaque) callconv(.c) void {
    mutex.lock(&scheduler);
    std.log.info("task 1", .{});
    scheduler.yield(.{});
    std.log.info("task 1 end", .{});
    mutex.unlock(&scheduler);
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

    esp.time.sleep_ms(1000);

    var heap = microzig.Allocator.init_with_heap(4096);
    const allocator = heap.allocator();
    scheduler.init(allocator);
    try scheduler.raw_alloc_spawn_with_options(task1, null, .{});

    mutex.lock(&scheduler);
    std.log.info("main", .{});
    scheduler.yield(.{});
    std.log.info("main revisited", .{});
    scheduler.yield(.{});
    std.log.info("main ending", .{});
    scheduler.yield(.{});
    mutex.unlock(&scheduler);

    while (true) {
        microzig.cpu.wfi();
    }
}
