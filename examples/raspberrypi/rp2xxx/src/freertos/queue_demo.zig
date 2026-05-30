//! FreeRTOS Queue Demo — Producer/Consumer pattern.
//!
//! Demonstrates type-safe queue communication between two tasks.
//! A producer task sends incrementing numbers to a queue,
//! and a consumer task receives and logs them.

const std = @import("std");
const microzig = @import("microzig");

const freertos = @import("freertos");

const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
});

comptime {
    _ = microzig.export_startup();
}

pub const microzig_options: microzig.Options = .{
    .cpu = .{
        .ram_vector_table = true,
    },
};

/// The queue shared between producer and consumer.
var message_queue: freertos.queue.Queue(u32) = undefined;

pub fn main() !void {
    uart_tx_pin.set_function(.uart);

    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });

    rp2xxx.uart.init_logger(uart);

    // Create a queue that holds up to 5 u32 values
    message_queue = try freertos.queue.create(u32, 5);

    // Create producer and consumer tasks
    _ = try freertos.task.create(
        producer_task,
        "producer",
        freertos.config.minimal_stack_size * 4,
        null,
        2,
    );
    _ = try freertos.task.create(
        consumer_task,
        "consumer",
        freertos.config.minimal_stack_size * 4,
        null,
        1,
    );

    freertos.task.start_scheduler();
}

/// Sends an incrementing counter to the shared queue every 1000ms.
/// Blocks indefinitely if the queue is full (`max_delay`).
fn producer_task(_: ?*anyopaque) callconv(.c) void {
    var counter: u32 = 0;
    while (true) : (counter +%= 1) {
        message_queue.send(&counter, freertos.config.max_delay) catch {
            std.log.err("Failed to send to queue", .{});
            continue;
        };
        std.log.info("[producer] sent: {}", .{counter});
        freertos.task.delay(1000);
    }
}

/// Blocks waiting for items on the shared queue and logs each received value.
/// Runs at lower priority than the producer, so it processes items after they are sent.
fn consumer_task(_: ?*anyopaque) callconv(.c) void {
    while (true) {
        const value = message_queue.receive(freertos.config.max_delay) catch {
            std.log.err("Failed to receive from queue", .{});
            continue;
        };
        std.log.info("[consumer] received: {}", .{value});
    }
}
