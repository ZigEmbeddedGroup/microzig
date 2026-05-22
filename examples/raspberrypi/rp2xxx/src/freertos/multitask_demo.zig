//! FreeRTOS Multitask Demo — Sensor Dashboard
//!
//! Showcases queues, mutexes, timers, event groups, notifications, and
//! semaphores working together across 4 cooperating tasks:
//!
//!   sensor_task  — produces fake readings → queue + notification
//!   logger_task  — consumes the queue, prints data under mutex
//!   watchdog_task — waits on event-group bit set by a periodic timer
//!   stats_task   — periodically reports task count and tick count
//!
//! A binary semaphore acts as a startup gate so every task begins in sync.

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

// ── Shared Primitives ───────────────────────────────────────────────────

/// Queue carrying sensor readings from sensor_task → logger_task.
var sensor_queue: freertos.queue.Queue(u32) = undefined;

/// Mutex protecting serial output (shared by logger_task and stats_task).
var uart_mutex: freertos.mutex.Mutex = undefined;

/// Event group: timer callback sets WATCHDOG_BIT, watchdog_task waits on it.
var watchdog_events: freertos.event_group.EventGroup = undefined;

/// Binary semaphore used as a startup gate — all tasks block until released.
var startup_gate: freertos.semaphore.Semaphore = undefined;

/// Handle to the logger task, used for direct-to-task notifications.
var logger_handle: freertos.config.TaskHandle = undefined;

/// Periodic 3-second heartbeat timer.
var heartbeat_timer: freertos.timer.Timer = undefined;

const WATCHDOG_BIT: freertos.config.EventBits = 0x01;

// ── Main ────────────────────────────────────────────────────────────────

/// Initialize hardware, create all shared FreeRTOS primitives (queue, mutex,
/// event group, semaphore, timer), spawn the four tasks, release the startup
/// gate, and hand control to the FreeRTOS scheduler (which never returns).
pub fn main() !void {
    // Hardware setup
    uart_tx_pin.set_function(.uart);
    uart.apply(.{ .clock_config = rp2xxx.clock_config });
    rp2xxx.uart.init_logger(uart);

    std.log.info("[main] Starting FreeRTOS multitask demo...", .{});

    // Create shared primitives
    sensor_queue = try freertos.queue.create(u32, 10);
    uart_mutex = try freertos.mutex.create();
    watchdog_events = try freertos.event_group.create();
    startup_gate = try freertos.semaphore.create_binary();

    // 3-second auto-reload timer that fires the heartbeat callback
    heartbeat_timer = try freertos.timer.create(
        "heartbeat",
        3000,
        true,
        null,
        heartbeat_timer_callback,
    );

    // Create the four tasks (highest priority first)
    _ = try freertos.task.create(sensor_task, "sensor", 2048, null, 3);
    logger_handle = try freertos.task.create(logger_task, "logger", 2048, null, 2);
    _ = try freertos.task.create(watchdog_task, "watchdog", 2048, null, 1);
    _ = try freertos.task.create(stats_task, "stats", 2048, null, 1);

    std.log.info("[main] All tasks created, releasing startup gate", .{});

    // Release the startup gate — tasks cascade through take/give
    startup_gate.give() catch {};

    // Hand control to FreeRTOS (never returns)
    freertos.task.start_scheduler();
}

// ── Sensor Task ─────────────────────────────────────────────────────────
/// Simulates reading a sensor every 500 ms.  Sends the reading to a queue
/// and pings logger_task via a lightweight notification.
fn sensor_task(_: ?*anyopaque) callconv(.c) void {
    wait_for_startup_gate();

    var reading: u32 = 0;
    while (true) : (reading +%= 1) {
        // Enqueue the reading for the logger
        sensor_queue.send(&reading, freertos.config.max_delay) catch continue;

        // Lightweight signal — wake the logger
        freertos.notification.give(logger_handle) catch {};

        // Log the reading under mutex
        uart_mutex.acquire(freertos.config.max_delay) catch {};
        std.log.info("[sensor] reading: {}", .{reading});
        uart_mutex.release() catch {};

        freertos.task.delay(500);
    }
}

// ── Logger Task ─────────────────────────────────────────────────────────
/// Waits for a notification, then drains the sensor queue and prints each
/// reading under the UART mutex.
fn logger_task(_: ?*anyopaque) callconv(.c) void {
    wait_for_startup_gate();

    while (true) {
        // Block until sensor_task sends a notification
        _ = freertos.notification.take(true, freertos.config.max_delay) catch continue;

        // Drain every pending reading from the queue
        while (true) {
            const value = sensor_queue.receive(0) catch break;
            uart_mutex.acquire(freertos.config.max_delay) catch {};
            std.log.info("[logger] logged sensor data: {}", .{value});
            uart_mutex.release() catch {};
        }
    }
}

// ── Watchdog Task ───────────────────────────────────────────────────────
/// Blocks on an event-group bit that the heartbeat timer callback sets
/// every 3 seconds, then logs a heartbeat message.
fn watchdog_task(_: ?*anyopaque) callconv(.c) void {
    wait_for_startup_gate();

    // Arm the heartbeat timer now that the scheduler (and its timer queue) is running.
    heartbeat_timer.start(0) catch |err| {
        std.log.err("[watchdog] timer start failed: {}", .{err});
    };

    var beat: u32 = 0;
    while (true) {
        // Wait for the timer to signal
        _ = watchdog_events.wait_bits(WATCHDOG_BIT, .{
            .clear_on_exit = true,
            .wait_for_all = false,
            .timeout = freertos.config.max_delay,
        }) catch continue;

        beat += 1;

        uart_mutex.acquire(freertos.config.max_delay) catch {};
        std.log.info("[watchdog] heartbeat #{} (tick: {})", .{
            beat,
            freertos.task.get_tick_count(),
        });
        uart_mutex.release() catch {};
    }
}

// ── Stats Task ──────────────────────────────────────────────────────────
/// Every 5 seconds, reports the number of active tasks, uptime, and
/// current queue depth.
fn stats_task(_: ?*anyopaque) callconv(.c) void {
    wait_for_startup_gate();

    while (true) {
        freertos.task.delay(5000);

        uart_mutex.acquire(freertos.config.max_delay) catch {};
        std.log.info("[stats] tasks: {}, uptime: {} ticks, queue depth: {}/10", .{
            freertos.task.get_count(),
            freertos.task.get_tick_count(),
            sensor_queue.messages_waiting(),
        });
        uart_mutex.release() catch {};
    }
}

// ── Timer Callback ──────────────────────────────────────────────────────
/// Runs in the timer-daemon context; sets the watchdog event bit so
/// watchdog_task unblocks.
fn heartbeat_timer_callback(_: freertos.config.TimerHandle) callconv(.c) void {
    _ = watchdog_events.set_bits(WATCHDOG_BIT);
}

// ── Startup Gate Helper ─────────────────────────────────────────────────
/// Every task calls this once at entry.  The binary semaphore cascades:
/// each task takes → gives back, so the next one can proceed.
fn wait_for_startup_gate() void {
    startup_gate.take(freertos.config.max_delay) catch return;
    startup_gate.give() catch {};
}
