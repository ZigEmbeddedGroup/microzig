//! # FreeRTOS Hello Task Example
//!
//! The simplest FreeRTOS example — creates a single task that prints
//! "Hello from FreeRTOS!" every 500ms via UART. Demonstrates the basic
//! pattern: create a task, start the scheduler, let FreeRTOS manage execution.
//!
//! ## Primitives Used
//! - **Task**: `freertos.task.create` / `freertos.task.delay`
//! - **Scheduler**: `freertos.task.start_scheduler`
//!
//! ## Hardware Tested
//! - XIAO RP2350 (RP2350 ARM Cortex-M33)
//! - Raspberry Pi Pico (RP2040)

const std = @import("std");
const microzig = @import("microzig");

const freertos = @import("freertos");

const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
    .cpu = .{
        .ram_vector_table = true,
    },
};

/// Initialize UART logging, create a single FreeRTOS task, and start the scheduler.
/// The scheduler never returns — FreeRTOS takes over execution from this point.
pub fn main() !void {
    uart_tx_pin.set_function(.uart);

    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });

    rp2xxx.uart.init_logger(uart, &.{});

    // Create a task using the new idiomatic API
    _ = try freertos.task.create(
        hello_task,
        "hello_task",
        freertos.config.minimal_stack_size * 8,
        null,
        freertos.config.max_priorities - 1,
    );

    // Start the scheduler (never returns)
    freertos.task.start_scheduler();
}

/// FreeRTOS task entry point — logs a greeting with an incrementing counter
/// every 500ms. Runs forever; FreeRTOS preempts it as needed.
pub fn hello_task(_: ?*anyopaque) callconv(.c) void {
    var i: u32 = 0;
    while (true) : (i += 1) {
        std.log.info("Hello from FreeRTOS task {}", .{i});
        freertos.task.delay(500);
    }
}
