//! FreeRTOS configuration types, error handling, and shared constants.
//!
//! This module provides idiomatic Zig types that map to FreeRTOS C types,
//! following the error-handling pattern established by `modules/network/`.

const c = @import("root.zig").c;

// ── Type Aliases ────────────────────────────────────────────────────────

/// Tick count type used for delays and timeouts.
pub const TickType = c.TickType_t;

/// Base signed integer type (used for pdTRUE/pdFALSE).
pub const BaseType = c.BaseType_t;

/// Base unsigned integer type.
pub const U_BaseType = c.UBaseType_t;

/// Opaque task handle.
pub const TaskHandle = c.TaskHandle_t;

/// Opaque queue handle.
pub const QueueHandle = c.QueueHandle_t;

/// Opaque semaphore handle (alias for QueueHandle in FreeRTOS).
pub const SemaphoreHandle = c.SemaphoreHandle_t;

/// Opaque event group handle.
pub const EventGroupHandle = c.EventGroupHandle_t;

/// Event bits type.
pub const EventBits = c.EventBits_t;

/// Opaque timer handle.
pub const TimerHandle = c.TimerHandle_t;

/// Task function signature: `fn(?*anyopaque) callconv(.c) void`.
pub const TaskFunction = c.TaskFunction_t;

/// Timer callback signature.
pub const TimerCallbackFunction = c.TimerCallbackFunction_t;

/// Stack depth type.
pub const StackDepthType = c.configSTACK_DEPTH_TYPE;

// ── Constants ───────────────────────────────────────────────────────────

/// Maximum delay value (wait forever).
pub const max_delay: TickType = c.portMAX_DELAY;

/// Minimum stack size for a task (in words, from FreeRTOSConfig.h).
pub const minimal_stack_size: u32 = c.configMINIMAL_STACK_SIZE;

/// Maximum number of task priorities.
pub const max_priorities: u32 = c.configMAX_PRIORITIES;

/// Tick rate in Hz.
pub const tick_rate_hz: u32 = c.configTICK_RATE_HZ;

// ── Error Handling ──────────────────────────────────────────────────────

/// Errors that FreeRTOS operations can return.
pub const Error = error{
    /// Memory allocation failed (heap exhausted).
    OutOfMemory,
    /// Operation timed out before completing.
    Timeout,
    /// Queue/semaphore is full — cannot send.
    QueueFull,
    /// Queue is empty — cannot receive.
    QueueEmpty,
    /// Generic FreeRTOS failure (pdFAIL).
    Failure,
};

/// Convert a FreeRTOS BaseType_t return code to a Zig error.
/// pdPASS (1) returns void; pdFAIL (0) returns `error.Failure`.
pub fn check_base_type(rc: BaseType) Error!void {
    if (rc != c.pdPASS) return error.Failure;
}

/// Check a boolean-style return where pdTRUE means success.
pub fn check_true(rc: BaseType) bool {
    return rc == c.pdTRUE;
}

/// Convert a nullable C handle to a Zig optional, returning OutOfMemory if null.
pub fn check_handle(comptime T: type, handle: T) Error!T {
    if (handle == null) return error.OutOfMemory;
    return handle;
}
