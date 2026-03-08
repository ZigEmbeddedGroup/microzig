//! # FreeRTOS for MicroZig
//!
//! Idiomatic Zig wrappers for the FreeRTOS real-time operating system kernel.
//!
//! ## Quick Start
//! ```zig
//! const freertos = @import("freertos");
//!
//! // Create a task
//! const handle = try freertos.task.create(my_task, "demo", 512, null, 1);
//!
//! // Start the scheduler (never returns)
//! freertos.task.start_scheduler();
//! ```
//!
//! For direct access to the underlying C API, use `freertos.c.*`.

// ── Raw C Bindings (escape hatch) ───────────────────────────────────────

/// Direct access to all FreeRTOS C functions and types via `@cImport`.
/// Use this for advanced use-cases not covered by the Zig wrappers.
pub const c = @cImport({
    @cInclude("FreeRTOS.h");
    @cInclude("task.h");
    @cInclude("queue.h");
    @cInclude("semphr.h");
    @cInclude("event_groups.h");
    @cInclude("timers.h");
});

// ── Zig API Modules ─────────────────────────────────────────────────────

/// Shared types, constants, and error handling.
pub const config = @import("config.zig");

/// Task creation, deletion, control, and scheduler management.
pub const task = @import("task.zig");

/// Type-safe FIFO queues for inter-task communication.
pub const queue = @import("queue.zig");

/// Binary and counting semaphores.
pub const semaphore = @import("semaphore.zig");

/// Standard and recursive mutexes with priority inheritance.
pub const mutex = @import("mutex.zig");

/// Event groups for multi-bit synchronization.
pub const event_group = @import("event_group.zig");

/// Software timers with callback support.
pub const timer = @import("timer.zig");

/// Lightweight direct-to-task notification mechanism.
pub const notification = @import("notification.zig");

// ── ISR Exports ─────────────────────────────────────────────────────────
// These interrupt service routines are provided by the FreeRTOS port layer.
// They are exported so the vector table (RAM or flash) can reference them.

/// PendSV interrupt handler — used by the FreeRTOS port for context switching
/// between tasks. Exported so the vector table can reference it.
pub extern fn isr_pendsv() callconv(.naked) void;
/// SVCall interrupt handler — used by FreeRTOS to start the first task when
/// the scheduler begins. Exported so the vector table can reference it.
pub extern fn isr_svcall() callconv(.c) void;
/// SysTick interrupt handler — used by FreeRTOS for tick counting and
/// time-slicing. Fires at `configTICK_RATE_HZ`. Exported so the vector
/// table can reference it.
pub extern fn isr_systick() callconv(.c) void;

// ── Pico SDK Stubs ──────────────────────────────────────────────────────
// Platform-specific stubs (IRQ handler, multicore, clocks, spinlocks) are
// provided by picosdk_stubs.c, compiled as part of the freertos_lib module.
// See: src/picosdk_stubs.c

// ── FreeRTOS Hooks ──────────────────────────────────────────────────────

/// FreeRTOS stack overflow hook — called when a task exceeds its stack.
/// Traps immediately; a debugger will stop here with a meaningful backtrace.
export fn vApplicationStackOverflowHook(_: config.TaskHandle, _: [*c]u8) void {
    @trap();
}

// ── Backward Compatibility ──────────────────────────────────────────────

/// Deprecated: use `freertos.task` and `freertos.config` instead.
/// Preserved for backward compatibility with existing code.
pub const OS = struct {
    pub const MINIMAL_STACK_SIZE: usize = config.minimal_stack_size;
    pub const MAX_PRIORITIES: usize = config.max_priorities;

    /// Deprecated: use `freertos.task.start_scheduler` instead.
    pub fn vTaskStartScheduler() noreturn {
        task.start_scheduler();
    }

    /// Deprecated: use `freertos.task.delay` instead.
    pub fn vTaskDelay(ticks: c.TickType_t) void {
        task.delay(ticks);
    }

    /// Deprecated: use `freertos.task.create` instead.
    pub fn xTaskCreate(
        task_function: c.TaskFunction_t,
        name: [*:0]const u8,
        stack_depth: u16,
        parameters: ?*anyopaque,
        priority: u32,
        task_handle: ?*c.TaskHandle_t,
    ) c.BaseType_t {
        return c.xTaskCreate(
            task_function,
            name,
            stack_depth,
            parameters,
            priority,
            task_handle,
        );
    }
};
