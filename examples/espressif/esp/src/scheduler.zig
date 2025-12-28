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
var queue: esp.Scheduler.Queue(u32) = .init(&.{});

fn task1(_: ?*anyopaque) callconv(.c) noreturn {
    for (0..5) |i| {
        queue.put_one(&scheduler, i) catch {
            std.log.err("failed to put item", .{});
            continue;
        };
        scheduler.sleep(.from_ms(500));
    }
    queue.close(&scheduler);
    while (true) {
        microzig.cpu.wfi();
    }
}

pub fn main() !void {
    var heap = microzig.Allocator.init_with_buffer(&heap_buf);
    const allocator = heap.allocator();
    scheduler.init(allocator);

    esp.time.sleep_ms(1000);

    _ = try scheduler.raw_alloc_spawn_with_options(task1, null, .{
        // .priority = .high,
    });

    while (true) {
        const item = try queue.get_one(&scheduler);
        std.log.info("got item: {}", .{item});
    }
}
