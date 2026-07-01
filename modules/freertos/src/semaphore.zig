//! FreeRTOS semaphore wrappers — binary and counting semaphores.
//!
//! Semaphores are signaling primitives used for synchronization between
//! tasks and between tasks and ISRs. They are distinct from mutexes:
//! semaphores signal events, mutexes protect resources.
//!
//! ## Example
//! ```zig
//! var sem = try freertos.semaphore.create_binary();
//! defer sem.destroy();
//!
//! // In producer task or ISR:
//! try sem.give();
//!
//! // In consumer task:
//! try sem.take(freertos.config.max_delay);
//! ```

const config = @import("config.zig");
const c = @import("root.zig").c;

const TickType = config.TickType;
const Error = config.Error;

/// Result from an ISR give/take operation.
pub const ISR_Result = struct {
    /// Whether the operation succeeded.
    success: bool,
    /// Whether a higher-priority task was woken and a context switch is needed.
    higher_priority_task_woken: bool,
};

/// A FreeRTOS semaphore (binary or counting).
pub const Semaphore = struct {
    /// Underlying FreeRTOS C handle. Use `freertos.c` for direct C API access.
    handle: c.SemaphoreHandle_t,

    /// Delete the semaphore and free its memory.
    pub fn destroy(self: Semaphore) void {
        c.vSemaphoreDelete(self.handle);
    }

    /// Acquire (take) the semaphore, blocking up to `timeout` ticks.
    /// Returns `error.Timeout` if the semaphore could not be acquired.
    pub fn take(self: Semaphore, timeout: TickType) Error!void {
        const rc = c.xSemaphoreTake(self.handle, timeout);
        if (rc != c.pdPASS) return error.Timeout;
    }

    /// Release (give) the semaphore.
    /// Returns `error.Failure` if the semaphore could not be given
    /// (e.g., it was not previously taken, for a binary semaphore).
    pub fn give(self: Semaphore) Error!void {
        const rc = c.xSemaphoreGive(self.handle);
        if (rc != c.pdPASS) return error.Failure;
    }

    /// Release the semaphore from an ISR context.
    pub fn give_from_isr(self: Semaphore) ISR_Result {
        var woken: c.BaseType_t = c.pdFALSE;
        const rc = c.xSemaphoreGiveFromISR(self.handle, &woken);
        return .{
            .success = rc == c.pdPASS,
            .higher_priority_task_woken = woken != c.pdFALSE,
        };
    }

    /// Take the semaphore from an ISR context (binary and counting only).
    pub fn take_from_isr(self: Semaphore) ISR_Result {
        var woken: c.BaseType_t = c.pdFALSE;
        const rc = c.xSemaphoreTakeFromISR(self.handle, &woken);
        return .{
            .success = rc == c.pdPASS,
            .higher_priority_task_woken = woken != c.pdFALSE,
        };
    }

    /// Get the current count of a counting semaphore, or 1/0 for binary.
    pub fn get_count(self: Semaphore) u32 {
        return @intCast(c.uxSemaphoreGetCount(self.handle));
    }
};

// ── Creation Functions ──────────────────────────────────────────────────

/// Create a binary semaphore (starts in the "empty" / not-given state).
/// Returns `error.OutOfMemory` if the kernel heap is exhausted.
pub fn create_binary() Error!Semaphore {
    const handle = c.xSemaphoreCreateBinary();
    return .{ .handle = try config.check_handle(c.SemaphoreHandle_t, handle) };
}

/// Create a counting semaphore.
/// - `max_count`: Maximum count value.
/// - `initial_count`: Starting count value.
pub fn create_counting(max_count: u32, initial_count: u32) Error!Semaphore {
    const handle = c.xSemaphoreCreateCounting(
        @intCast(max_count),
        @intCast(initial_count),
    );
    return .{ .handle = try config.check_handle(c.SemaphoreHandle_t, handle) };
}
