//! FreeRTOS mutex wrappers — standard and recursive mutexes.
//!
//! Mutexes provide mutual exclusion with priority inheritance, preventing
//! priority inversion. Use mutexes to protect shared resources; use
//! semaphores for signaling/synchronization.
//!
//! ## Example
//! ```zig
//! var mtx = try freertos.mutex.create();
//! defer mtx.destroy();
//!
//! try mtx.acquire(freertos.config.max_delay);
//! defer mtx.release() catch {};
//!
//! // ... access shared resource ...
//! ```

const config = @import("config.zig");
const c = @import("root.zig").c;

const TickType = config.TickType;
const Error = config.Error;
const TaskHandle = config.TaskHandle;

/// A FreeRTOS mutex with priority inheritance.
pub const Mutex = struct {
    /// Underlying FreeRTOS C handle. Use `freertos.c` for direct C API access.
    handle: c.SemaphoreHandle_t,

    /// Delete the mutex and free its memory.
    pub fn destroy(self: Mutex) void {
        c.vSemaphoreDelete(self.handle);
    }

    /// Acquire (lock) the mutex, blocking up to `timeout` ticks.
    /// Returns `error.Timeout` if the mutex could not be acquired.
    pub fn acquire(self: Mutex, timeout: TickType) Error!void {
        const rc = c.xSemaphoreTake(self.handle, timeout);
        if (rc != c.pdPASS) return error.Timeout;
    }

    /// Release (unlock) the mutex.
    /// Returns `error.Failure` if the calling task does not hold the mutex.
    pub fn release(self: Mutex) Error!void {
        const rc = c.xSemaphoreGive(self.handle);
        if (rc != c.pdPASS) return error.Failure;
    }

    /// Get the handle of the task that currently holds this mutex.
    /// Returns `null` if the mutex is not held.
    pub fn get_holder(self: Mutex) ?TaskHandle {
        return c.xSemaphoreGetMutexHolder(self.handle);
    }

    /// Get the mutex holder from an ISR context.
    pub fn get_holder_from_isr(self: Mutex) ?TaskHandle {
        return c.xSemaphoreGetMutexHolderFromISR(self.handle);
    }
};

/// A FreeRTOS recursive mutex — can be acquired multiple times by the same task.
pub const Recursive = struct {
    /// Underlying FreeRTOS C handle. Use `freertos.c` for direct C API access.
    handle: c.SemaphoreHandle_t,

    /// Delete the recursive mutex and free its memory.
    pub fn destroy(self: Recursive) void {
        c.vSemaphoreDelete(self.handle);
    }

    /// Acquire the recursive mutex, blocking up to `timeout` ticks.
    /// The same task can acquire it multiple times; each acquire must be
    /// matched by a corresponding release.
    pub fn acquire(self: Recursive, timeout: TickType) Error!void {
        const rc = c.xSemaphoreTakeRecursive(self.handle, timeout);
        if (rc != c.pdPASS) return error.Timeout;
    }

    /// Release the recursive mutex (one level).
    pub fn release(self: Recursive) Error!void {
        const rc = c.xSemaphoreGiveRecursive(self.handle);
        if (rc != c.pdPASS) return error.Failure;
    }
};

// ── Creation Functions ──────────────────────────────────────────────────

/// Create a standard mutex with priority inheritance.
/// Returns `error.OutOfMemory` if the kernel heap is exhausted.
pub fn create() Error!Mutex {
    const handle = c.xSemaphoreCreateMutex();
    return .{ .handle = try config.check_handle(c.SemaphoreHandle_t, handle) };
}

/// Create a recursive mutex.
/// Returns `error.OutOfMemory` if the kernel heap is exhausted.
pub fn create_recursive() Error!Recursive {
    const handle = c.xSemaphoreCreateRecursiveMutex();
    return .{ .handle = try config.check_handle(c.SemaphoreHandle_t, handle) };
}
