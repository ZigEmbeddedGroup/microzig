//! FreeRTOS event groups — multi-bit synchronization primitives.
//!
//! Event groups allow tasks to wait on combinations of event bits,
//! enabling rendezvous-style synchronization between multiple tasks.
//!
//! ## Example
//! ```zig
//! var events = try freertos.event_group.create();
//! defer events.destroy();
//!
//! // Task A sets bit 0:
//! _ = events.set_bits(0x01);
//!
//! // Task B waits for bits 0 and 1:
//! const bits = try events.wait_bits(0x03, .{ .wait_for_all = true, .timeout = 1000 });
//! ```

const config = @import("config.zig");
const c = @import("root.zig").c;

const TickType = config.TickType;
const EventBits = config.EventBits;
const Error = config.Error;

/// Options for `wait_bits`.
pub const WaitOptions = struct {
    /// Clear the waited-for bits on exit (before returning).
    clear_on_exit: bool = true,
    /// Wait for ALL bits (true) or ANY bit (false).
    wait_for_all: bool = false,
    /// Maximum ticks to wait. Defaults to wait forever.
    timeout: TickType = config.max_delay,
};

/// Result from an ISR set-bits operation.
pub const ISR_Result = struct {
    /// Whether the operation succeeded (command posted to timer daemon queue).
    success: bool,
    /// Whether a higher-priority task was woken and a context switch is needed.
    higher_priority_task_woken: bool,
};

/// A FreeRTOS event group.
pub const EventGroup = struct {
    /// Underlying FreeRTOS C handle. Use `freertos.c` for direct C API access.
    handle: c.EventGroupHandle_t,

    /// Delete the event group and free its memory.
    pub fn destroy(self: EventGroup) void {
        c.vEventGroupDelete(self.handle);
    }

    /// Set one or more event bits.
    /// Returns the event group value after the bits were set.
    pub fn set_bits(self: EventGroup, bits: EventBits) EventBits {
        return c.xEventGroupSetBits(self.handle, bits);
    }

    /// Clear one or more event bits.
    /// Returns the event group value *before* the bits were cleared.
    pub fn clear_bits(self: EventGroup, bits: EventBits) EventBits {
        return c.xEventGroupClearBits(self.handle, bits);
    }

    /// Get the current event bit values.
    pub fn get_bits(self: EventGroup) EventBits {
        // xEventGroupGetBits is a macro for xEventGroupClearBits(h, 0)
        return c.xEventGroupClearBits(self.handle, 0);
    }

    /// Block until the specified bits are set, with configurable options.
    ///
    /// Returns the event group value at the time the bits were set (or
    /// at timeout). Returns `error.Timeout` if the bits were not set
    /// within the timeout period.
    pub fn wait_bits(self: EventGroup, bits_to_wait: EventBits, opts: WaitOptions) Error!EventBits {
        const result = c.xEventGroupWaitBits(
            self.handle,
            bits_to_wait,
            if (opts.clear_on_exit) c.pdTRUE else c.pdFALSE,
            if (opts.wait_for_all) c.pdTRUE else c.pdFALSE,
            opts.timeout,
        );
        // If the function returned due to timeout, the awaited bits won't all be set.
        if (opts.wait_for_all) {
            if (result & bits_to_wait != bits_to_wait) return error.Timeout;
        } else {
            if (result & bits_to_wait == 0) return error.Timeout;
        }
        return result;
    }

    /// Atomically set bits and then wait for a different set of bits.
    /// Used for rendezvous / barrier synchronization.
    ///
    /// Returns `error.Timeout` if the wait-for bits were not set in time.
    pub fn sync(
        self: EventGroup,
        bits_to_set: EventBits,
        bits_to_wait: EventBits,
        timeout: TickType,
    ) Error!EventBits {
        const result = c.xEventGroupSync(self.handle, bits_to_set, bits_to_wait, timeout);
        if (result & bits_to_wait != bits_to_wait) return error.Timeout;
        return result;
    }

    /// Set bits from an ISR context (deferred to the timer daemon task).
    pub fn set_bits_from_isr(self: EventGroup, bits: EventBits) ISR_Result {
        var woken: c.BaseType_t = c.pdFALSE;
        const rc = c.xEventGroupSetBitsFromISR(self.handle, bits, &woken);
        return .{
            .success = rc == c.pdPASS,
            .higher_priority_task_woken = woken != c.pdFALSE,
        };
    }

    /// Get current event bits from an ISR context.
    pub fn get_bits_from_isr(self: EventGroup) EventBits {
        return c.xEventGroupGetBitsFromISR(self.handle);
    }
};

// ── Creation ────────────────────────────────────────────────────────────

/// Create a new event group.
/// Returns `error.OutOfMemory` if the kernel heap is exhausted.
pub fn create() Error!EventGroup {
    const handle = c.xEventGroupCreate();
    return .{ .handle = try config.check_handle(c.EventGroupHandle_t, handle) };
}
