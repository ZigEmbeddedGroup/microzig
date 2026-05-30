//! FreeRTOS software timer wrappers.
//!
//! Software timers execute a callback function at a configured interval.
//! Timer callbacks run in the context of the timer service (daemon) task.
//!
//! ## Example
//! ```zig
//! var tmr = try freertos.timer.create("heartbeat", 1000, true, null, heartbeat_cb);
//! try tmr.start(0);
//! ```

const config = @import("config.zig");
const c = @import("root.zig").c;

const TickType = config.TickType;
const Error = config.Error;
const TaskHandle = config.TaskHandle;

/// Timer callback function type.
pub const CallbackFn = config.TimerCallbackFunction;

/// Result from an ISR timer operation.
pub const ISR_Result = struct {
    /// Whether the command was successfully posted to the timer queue.
    success: bool,
    higher_priority_task_woken: bool,
};

/// A FreeRTOS software timer.
pub const Timer = struct {
    /// Underlying FreeRTOS C handle. Use `freertos.c` for direct C API access.
    handle: c.TimerHandle_t,

    // ── Control ─────────────────────────────────────────────────────
    //
    // NOTE: The C macros (xTimerStart, xTimerStop, etc.) pass `NULL` for
    // `pxHigherPriorityTaskWoken`.  Zig's cImport cannot coerce the
    // untyped `NULL` (`?*anyopaque`) to `[*c]BaseType_t`, so we call
    // the underlying `xTimerGenericCommandFromTask` / `FromISR` directly.

    /// Start the timer. If already running, this resets it.
    /// `command_timeout` is how long to wait to post the command to the
    /// timer command queue.
    pub fn start(self: Timer, command_timeout: TickType) Error!void {
        const rc = c.xTimerGenericCommandFromTask(self.handle, c.tmrCOMMAND_START, c.xTaskGetTickCount(), null, command_timeout);
        if (rc != c.pdPASS) return error.Timeout;
    }

    /// Stop the timer.
    pub fn stop(self: Timer, command_timeout: TickType) Error!void {
        const rc = c.xTimerGenericCommandFromTask(self.handle, c.tmrCOMMAND_STOP, 0, null, command_timeout);
        if (rc != c.pdPASS) return error.Timeout;
    }

    /// Reset the timer — restarts counting from now.
    /// If the timer was not running, this starts it.
    pub fn reset(self: Timer, command_timeout: TickType) Error!void {
        const rc = c.xTimerGenericCommandFromTask(self.handle, c.tmrCOMMAND_RESET, c.xTaskGetTickCount(), null, command_timeout);
        if (rc != c.pdPASS) return error.Timeout;
    }

    /// Change the timer's period and restart it.
    pub fn change_period(self: Timer, new_period: TickType, command_timeout: TickType) Error!void {
        const rc = c.xTimerGenericCommandFromTask(self.handle, c.tmrCOMMAND_CHANGE_PERIOD, new_period, null, command_timeout);
        if (rc != c.pdPASS) return error.Timeout;
    }

    /// Delete the timer. Unlike other primitives' `destroy()`, timer deletion sends a
    /// command to the timer daemon queue, which can fail if the queue is full.
    /// Use `destroy_blocking()` for a fire-and-forget variant that waits indefinitely.
    pub fn destroy(self: Timer, command_timeout: TickType) Error!void {
        const rc = c.xTimerGenericCommandFromTask(self.handle, c.tmrCOMMAND_DELETE, 0, null, command_timeout);
        if (rc != c.pdPASS) return error.Timeout;
    }

    /// Delete the timer, waiting indefinitely for the command to be accepted.
    /// This cannot fail and is safe to use in `defer`.
    pub fn destroy_blocking(self: Timer) void {
        _ = c.xTimerGenericCommandFromTask(
            self.handle,
            c.tmrCOMMAND_DELETE,
            0,
            null,
            config.max_delay,
        );
    }

    // ── ISR Variants ────────────────────────────────────────────────

    /// Start the timer from an ISR context.
    pub fn start_from_isr(self: Timer) ISR_Result {
        var woken: c.BaseType_t = c.pdFALSE;
        const rc = c.xTimerGenericCommandFromISR(self.handle, c.tmrCOMMAND_START_FROM_ISR, c.xTaskGetTickCountFromISR(), &woken, 0);
        return .{
            .success = rc == c.pdPASS,
            .higher_priority_task_woken = woken != c.pdFALSE,
        };
    }

    /// Stop the timer from an ISR context.
    pub fn stop_from_isr(self: Timer) ISR_Result {
        var woken: c.BaseType_t = c.pdFALSE;
        const rc = c.xTimerGenericCommandFromISR(self.handle, c.tmrCOMMAND_STOP_FROM_ISR, 0, &woken, 0);
        return .{
            .success = rc == c.pdPASS,
            .higher_priority_task_woken = woken != c.pdFALSE,
        };
    }

    /// Reset the timer from an ISR context.
    pub fn reset_from_isr(self: Timer) ISR_Result {
        var woken: c.BaseType_t = c.pdFALSE;
        const rc = c.xTimerGenericCommandFromISR(self.handle, c.tmrCOMMAND_RESET_FROM_ISR, c.xTaskGetTickCountFromISR(), &woken, 0);
        return .{
            .success = rc == c.pdPASS,
            .higher_priority_task_woken = woken != c.pdFALSE,
        };
    }

    /// Change the timer period from an ISR context.
    pub fn change_period_from_isr(self: Timer, new_period: TickType) ISR_Result {
        var woken: c.BaseType_t = c.pdFALSE;
        const rc = c.xTimerGenericCommandFromISR(self.handle, c.tmrCOMMAND_CHANGE_PERIOD_FROM_ISR, new_period, &woken, 0);
        return .{
            .success = rc == c.pdPASS,
            .higher_priority_task_woken = woken != c.pdFALSE,
        };
    }

    // ── Queries ─────────────────────────────────────────────────────

    /// Check if the timer is currently active (running).
    pub fn is_active(self: Timer) bool {
        return c.xTimerIsTimerActive(self.handle) != c.pdFALSE;
    }

    /// Get the human-readable timer name.
    pub fn get_name(self: Timer) [*:0]const u8 {
        return c.pcTimerGetName(self.handle);
    }

    /// Get the timer's period in ticks.
    pub fn get_period(self: Timer) TickType {
        return c.xTimerGetPeriod(self.handle);
    }

    /// Get the tick time at which the timer will expire.
    pub fn get_expiry_time(self: Timer) TickType {
        return c.xTimerGetExpiryTime(self.handle);
    }

    /// Get the timer's user-defined ID pointer.
    pub fn get_id(self: Timer) ?*anyopaque {
        return c.pvTimerGetTimerID(self.handle);
    }

    /// Set the timer's user-defined ID pointer.
    pub fn set_id(self: Timer, id: ?*anyopaque) void {
        c.vTimerSetTimerID(self.handle, id);
    }

    /// Check whether the timer auto-reloads.
    pub fn get_auto_reload(self: Timer) bool {
        return c.uxTimerGetReloadMode(self.handle) != 0;
    }

    /// Set whether the timer auto-reloads.
    pub fn set_auto_reload(self: Timer, auto_reload: bool) void {
        c.vTimerSetReloadMode(self.handle, if (auto_reload) @as(c.UBaseType_t, 1) else @as(c.UBaseType_t, 0));
    }
};

// ── Creation ────────────────────────────────────────────────────────────

/// Create a new software timer.
///
/// - `name`: Human-readable name for debugging.
/// - `period`: Timer period in ticks.
/// - `auto_reload`: If true, the timer restarts automatically after expiry.
/// - `id`: User-defined pointer stored with the timer (accessible via `get_id`).
/// - `callback`: Function called when the timer expires.
///
/// Returns `error.OutOfMemory` if the kernel heap is exhausted.
pub fn create(
    name: [*:0]const u8,
    period: TickType,
    auto_reload: bool,
    id: ?*anyopaque,
    callback: CallbackFn,
) Error!Timer {
    const handle = c.xTimerCreate(
        name,
        period,
        if (auto_reload) c.pdTRUE else c.pdFALSE,
        id,
        callback,
    );
    return .{ .handle = try config.check_handle(c.TimerHandle_t, handle) };
}

/// Get the handle of the timer service (daemon) task.
pub fn get_daemon_task_handle() TaskHandle {
    return c.xTimerGetTimerDaemonTaskHandle();
}

/// Defer a function call to the timer daemon task from a normal task context.
pub fn pend_function_call(
    function: c.PendedFunction_t,
    param1: ?*anyopaque,
    param2: u32,
    timeout: TickType,
) Error!void {
    const rc = c.xTimerPendFunctionCall(function, param1, param2, timeout);
    if (rc != c.pdPASS) return error.Timeout;
}

/// Defer a function call to the timer daemon task from an ISR context.
pub fn pend_function_call_from_isr(
    function: c.PendedFunction_t,
    param1: ?*anyopaque,
    param2: u32,
) ISR_Result {
    var woken: c.BaseType_t = c.pdFALSE;
    const rc = c.xTimerPendFunctionCallFromISR(function, param1, param2, &woken);
    return .{
        .success = rc == c.pdPASS,
        .higher_priority_task_woken = woken != c.pdFALSE,
    };
}
