const std = @import("std");

const microzig = @import("microzig");
const esp = microzig.hal;
const usb_serial_jtag = esp.usb_serial_jtag;
const rtos = esp.rtos;

pub const microzig_options: microzig.Options = .{
    .logFn = usb_serial_jtag.logger.log,
    .interrupts = .{
        .interrupt31 = rtos.interrupt_handler,
    },
    .log_level = .debug,
    .cpu = .{
        .interrupt_stack = .{
            .enable = true,
            .size = 4096,
        },
    },
    .hal = .{
        .rtos = .{
            .enable = true,
        },
    },
};

fn task1(queue: *rtos.Queue(u32)) void {
    for (0..5) |i| {
        queue.put_one(i, .never) catch unreachable;
        rtos.sleep(.from_ms(500));
    }
}

pub fn main() !void {
    var heap = try microzig.Allocator.init_with_heap(4096);
    const gpa = heap.allocator();

    var buffer: [1]u32 = undefined;
    var queue: rtos.Queue(u32) = .init(&buffer);

    esp.time.sleep_ms(1000);

    const task = try rtos.spawn(gpa, task1, .{&queue}, .{});
    defer rtos.wait_and_free(gpa, task);

    while (true) {
        const item = try queue.get_one(.{ .after = .from_ms(1000) });
        std.log.info("got item: {}", .{item});
    }
}
