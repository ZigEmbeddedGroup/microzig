const std = @import("std");
const log = std.log;
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const esp = microzig.hal;
const gpio = esp.gpio;
const systimer = esp.systimer;
const usb_serial_jtag = esp.usb_serial_jtag;

pub const microzig_options: microzig.Options = .{
    .logFn = usb_serial_jtag.logger.log,
    .interrupts = .{
        .interrupt30 = .{ .c = esp.Scheduler.generic_interrupt_handler },
        .interrupt31 = .{ .naked = esp.Scheduler.isr_yield_handler },
    },
    .log_level = .debug,
    .cpu = .{
        .interrupt_stack_size = 4096,
    },
};

var heap_buf: [10 * 1024]u8 = undefined;
var scheduler: esp.Scheduler = undefined;
var mutex: esp.Scheduler.Mutex = .{};
// var sem: esp.Scheduler.Semaphore = .init(1);

fn task1(_: ?*anyopaque) callconv(.c) noreturn {
    var i: u32 = 0;
    while (true) : (i += 1) {
        // queue.putOneUncancelable(&scheduler, i);
        {
            mutex.lock(&scheduler);
            defer mutex.unlock(&scheduler);
            std.log.info("hello from task 1: {}", .{i});
            scheduler.sleep(1_000_000 * systimer.ticks_per_us());
            std.log.info("hello from task 1 still locking mutex", .{});
        }
        scheduler.sleep(500_000 * systimer.ticks_per_us());
    }
}

fn task2(_: ?*anyopaque) callconv(.c) noreturn {
    var i: u32 = 0;
    while (true) : (i += 1) {
        // queue.putOneUncancelable(&scheduler, i);
        {
            mutex.lock(&scheduler);
            defer mutex.unlock(&scheduler);
            std.log.info("hello from task 2: {}", .{i});
            scheduler.sleep(5_000_000 * systimer.ticks_per_us());
            std.log.info("hello from task 2 still locking mutex", .{});
        }
        scheduler.sleep(5_000_000 * systimer.ticks_per_us());
    }
}

pub fn main() !void {
    var heap = microzig.Allocator.init_with_buffer(&heap_buf);
    const allocator = heap.allocator();
    scheduler.init(allocator);

    esp.time.sleep_ms(1000);

    try scheduler.raw_alloc_spawn_with_options(task1, null, .{
        // .priority = .high,
    });

    try scheduler.raw_alloc_spawn_with_options(task2, null, .{
        // .priority = .high,
    });

    // try sem.take(&scheduler, 500_000 * systimer.ticks_per_us());
    // log.info("got semaphore once", .{});
    // try sem.take(&scheduler, 2_000_000 * systimer.ticks_per_us());

    while (true) {
        scheduler.yield(.reschedule);
        microzig.cpu.wfi();
        // const value = queue.getOneUncancelable(&scheduler);
        // std.log.info("received {}", .{value});
        // {
        //     mutex.lock(&scheduler);
        //     defer mutex.unlock(&scheduler);
        // scheduler.sleep(500_000 * systimer.ticks_per_us());
        // }
    }
}
