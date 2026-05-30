//! FreeRTOS direct-to-task notification wrappers.
//!
//! Task notifications are a lightweight, high-performance alternative to
//! binary semaphores, counting semaphores, event groups, and mailboxes.
//! Each task has a small array of 32-bit notification values (one per index).
//!
//! ## Example
//! ```zig
//! // Lightweight binary semaphore pattern (index 0):
//! try freertos.notification.give(task_handle);
//!
//! // In the receiving task:
//! _ = try freertos.notification.take(true, freertos.config.max_delay);
//! ```

const config = @import("config.zig");
const c = @import("root.zig").c;

const TickType = config.TickType;
const TaskHandle = config.TaskHandle;
const Error = config.Error;

/// Notification action — determines how the notification value is updated.
pub const Action = enum(u32) {
    /// Don't update the value, just send the notification.
    none = c.eNoAction,
    /// Bitwise-OR `value` into the notification value.
    set_bits = c.eSetBits,
    /// Increment the notification value (ignores `value` parameter).
    increment = c.eIncrement,
    /// Set the notification value, overwriting any unread value.
    set_value_overwrite = c.eSetValueWithOverwrite,
    /// Set the notification value only if the previous was read.
    set_value_no_overwrite = c.eSetValueWithoutOverwrite,
};

/// Result from an ISR notification operation.
pub const ISR_Result = struct {
    /// Whether the notification was successfully sent.
    success: bool,
    /// Whether a higher-priority task was woken and a context switch is needed.
    higher_priority_task_woken: bool,
};

// ── Send Notifications ──────────────────────────────────────────────────

/// Send a notification to a task at the default index (0).
///
/// Returns `error.Failure` only when `action` is `.set_value_no_overwrite`
/// and the target task had an unread notification.
pub fn notify(task_handle: TaskHandle, value: u32, action: Action) Error!void {
    const rc = c.xTaskGenericNotify(
        task_handle,
        0, // index
        value,
        @intFromEnum(action),
        null, // don't care about previous value
    );
    if (rc != c.pdPASS) return error.Failure;
}

/// Send a notification at a specific index.
pub fn notify_indexed(task_handle: TaskHandle, index: u32, value: u32, action: Action) Error!void {
    const rc = c.xTaskGenericNotify(
        task_handle,
        @intCast(index),
        value,
        @intFromEnum(action),
        null,
    );
    if (rc != c.pdPASS) return error.Failure;
}

/// Send a notification and retrieve the previous notification value.
pub fn notify_and_query(task_handle: TaskHandle, value: u32, action: Action) Error!u32 {
    var previous: u32 = 0;
    const rc = c.xTaskGenericNotify(
        task_handle,
        0,
        value,
        @intFromEnum(action),
        &previous,
    );
    if (rc != c.pdPASS) return error.Failure;
    return previous;
}

/// Increment the notification value at index 0 (lightweight "give" semaphore pattern).
pub fn give(task_handle: TaskHandle) Error!void {
    return notify(task_handle, 0, .increment);
}

// ── ISR Send ────────────────────────────────────────────────────────────

/// Send a notification from an ISR at the default index (0).
pub fn notify_from_isr(task_handle: TaskHandle, value: u32, action: Action) ISR_Result {
    var woken: c.BaseType_t = c.pdFALSE;
    const rc = c.xTaskGenericNotifyFromISR(
        task_handle,
        0,
        value,
        @intFromEnum(action),
        null,
        &woken,
    );
    return .{
        .success = rc == c.pdPASS,
        .higher_priority_task_woken = woken != c.pdFALSE,
    };
}

/// "Give" from ISR — increment the notification value at index 0.
pub fn give_from_isr(task_handle: TaskHandle) ISR_Result {
    return notify_from_isr(task_handle, 0, .increment);
}

// ── Wait / Receive ──────────────────────────────────────────────────────

/// Wait for a notification at the default index (0).
///
/// - `bits_clear_on_entry`: Bits to clear in the notification value on entry.
/// - `bits_clear_on_exit`: Bits to clear after reading the value.
/// - `timeout`: Maximum ticks to wait.
///
/// Returns the notification value, or `error.Timeout` if timed out.
pub fn wait(bits_clear_on_entry: u32, bits_clear_on_exit: u32, timeout: TickType) Error!u32 {
    var value: u32 = 0;
    const rc = c.xTaskGenericNotifyWait(
        0, // index
        bits_clear_on_entry,
        bits_clear_on_exit,
        &value,
        timeout,
    );
    if (rc != c.pdPASS) return error.Timeout;
    return value;
}

/// Wait for a notification at a specific index.
pub fn wait_indexed(index: u32, bits_clear_on_entry: u32, bits_clear_on_exit: u32, timeout: TickType) Error!u32 {
    var value: u32 = 0;
    const rc = c.xTaskGenericNotifyWait(
        @intCast(index),
        bits_clear_on_entry,
        bits_clear_on_exit,
        &value,
        timeout,
    );
    if (rc != c.pdPASS) return error.Timeout;
    return value;
}

/// Lightweight binary/counting semaphore using task notifications.
///
/// If `clear_on_exit` is true, the notification value is cleared to 0 on exit.
/// If `clear_on_exit` is false, the notification value is decremented.
/// Returns the notification value *before* modification, or `Timeout` if the
/// value was zero throughout the wait.
pub fn take(clear_on_exit: bool, timeout: TickType) Error!u32 {
    const value = c.ulTaskGenericNotifyTake(
        0, // notification index
        if (clear_on_exit) c.pdTRUE else c.pdFALSE,
        timeout,
    );
    if (value == 0) return error.Timeout;
    return value;
}

// ── State Management ────────────────────────────────────────────────────

/// Clear the notification pending state at the default index (0).
/// Returns `true` if a notification was pending.
pub fn clear_state(task_handle: ?TaskHandle) bool {
    return config.check_true(c.xTaskGenericNotifyStateClear(task_handle, 0));
}

/// Clear the notification pending state at a specific index.
pub fn clear_state_indexed(task_handle: ?TaskHandle, index: u32) bool {
    return config.check_true(c.xTaskGenericNotifyStateClear(task_handle, @intCast(index)));
}

/// Clear specific bits in the notification value at the default index (0).
/// Returns the notification value *before* the bits were cleared.
pub fn clear_bits(task_handle: ?TaskHandle, bits_to_clear: u32) u32 {
    return c.ulTaskGenericNotifyValueClear(task_handle, 0, bits_to_clear);
}

/// Clear specific bits at a specific index.
pub fn clear_bits_indexed(task_handle: ?TaskHandle, index: u32, bits_to_clear: u32) u32 {
    return c.ulTaskGenericNotifyValueClear(task_handle, @intCast(index), bits_to_clear);
}
