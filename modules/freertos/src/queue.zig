//! Type-safe FreeRTOS queue wrapper for inter-task communication.
//!
//! FreeRTOS queues are FIFO buffers that allow tasks (and ISRs) to send
//! and receive fixed-size items. This wrapper adds compile-time type safety.
//!
//! ## Example
//! ```zig
//! var q = try freertos.queue.create(u32, 10);
//! defer q.destroy();
//!
//! try q.send(&@as(u32, 42), freertos.config.max_delay);
//! const value = try q.receive(freertos.config.max_delay);
//! ```

const config = @import("config.zig");
const c = @import("root.zig").c;

const TickType = config.TickType;
const Error = config.Error;

// ── ISR Result Types ────────────────────────────────────────────────────

/// Result from an ISR send operation.
pub const ISR_Result = struct {
    /// Whether the operation succeeded (queue was not full/empty).
    success: bool,
    /// Whether a higher-priority task was woken and a context switch is needed.
    higher_priority_task_woken: bool,
};

/// Result from an ISR receive operation.
pub fn IsrReceiveResult(comptime T: type) type {
    return struct {
        /// The received item.
        item: T,
        /// Whether a higher-priority task was woken.
        higher_priority_task_woken: bool,
    };
}

// ── Generic Queue ───────────────────────────────────────────────────────

/// A type-safe FreeRTOS queue holding items of type `T`.
pub fn Queue(comptime T: type) type {
    return struct {
        const Self = @This();
        /// Underlying FreeRTOS C handle. Use `freertos.c` for direct C API access.
        handle: c.QueueHandle_t,

        /// Create a new queue that can hold `length` items of type `T`.
        /// Returns `error.OutOfMemory` if the kernel heap is exhausted.
        pub fn create(length: u32) Error!Self {
            const handle = c.xQueueCreate(
                @as(config.U_BaseType, @intCast(length)),
                @as(config.U_BaseType, @intCast(@sizeOf(T))),
            );
            return .{ .handle = try config.check_handle(c.QueueHandle_t, handle) };
        }

        /// Delete the queue and free its memory.
        pub fn destroy(self: Self) void {
            c.vQueueDelete(self.handle);
        }

        // ── Send ────────────────────────────────────────────────────

        /// Send an item to the back of the queue.
        /// Blocks up to `timeout` ticks if the queue is full.
        pub fn send(self: Self, item: *const T, timeout: TickType) Error!void {
            const rc = c.xQueueSendToBack(self.handle, item, timeout);
            if (rc != c.pdPASS) return error.QueueFull;
        }

        /// Send an item to the front of the queue.
        pub fn send_to_front(self: Self, item: *const T, timeout: TickType) Error!void {
            const rc = c.xQueueSendToFront(self.handle, item, timeout);
            if (rc != c.pdPASS) return error.QueueFull;
        }

        /// Overwrite the item in a queue of length 1.
        /// Always succeeds (never blocks).
        pub fn overwrite(self: Self, item: *const T) void {
            _ = c.xQueueOverwrite(self.handle, item);
        }

        /// Send an item from an ISR context.
        pub fn send_from_isr(self: Self, item: *const T) ISR_Result {
            var woken: c.BaseType_t = c.pdFALSE;
            const rc = c.xQueueSendToBackFromISR(self.handle, item, &woken);
            return .{
                .success = rc == c.pdPASS,
                .higher_priority_task_woken = woken != c.pdFALSE,
            };
        }

        /// Send an item to the front from an ISR context.
        pub fn send_to_front_from_isr(self: Self, item: *const T) ISR_Result {
            var woken: c.BaseType_t = c.pdFALSE;
            const rc = c.xQueueSendToFrontFromISR(self.handle, item, &woken);
            return .{
                .success = rc == c.pdPASS,
                .higher_priority_task_woken = woken != c.pdFALSE,
            };
        }

        // ── Receive ─────────────────────────────────────────────────

        /// Receive an item from the queue, removing it.
        /// Blocks up to `timeout` ticks if the queue is empty.
        pub fn receive(self: Self, timeout: TickType) Error!T {
            var item: T = undefined;
            const rc = c.xQueueReceive(self.handle, &item, timeout);
            if (rc != c.pdPASS) return error.QueueEmpty;
            return item;
        }

        /// Peek at the front item without removing it.
        pub fn peek(self: Self, timeout: TickType) Error!T {
            var item: T = undefined;
            const rc = c.xQueuePeek(self.handle, &item, timeout);
            if (rc != c.pdPASS) return error.QueueEmpty;
            return item;
        }

        /// Receive an item from ISR context.
        pub fn receive_from_isr(self: Self) ?IsrReceiveResult(T) {
            var item: T = undefined;
            var woken: c.BaseType_t = c.pdFALSE;
            const rc = c.xQueueReceiveFromISR(self.handle, &item, &woken);
            if (rc != c.pdPASS) return null;
            return .{
                .item = item,
                .higher_priority_task_woken = woken != c.pdFALSE,
            };
        }

        // ── Status ──────────────────────────────────────────────────

        /// Get the number of items currently in the queue.
        pub fn messages_waiting(self: Self) u32 {
            return @intCast(c.uxQueueMessagesWaiting(self.handle));
        }

        /// Get the number of free spaces remaining in the queue.
        pub fn spaces_available(self: Self) u32 {
            return @intCast(c.uxQueueSpacesAvailable(self.handle));
        }

        /// Reset the queue to its empty state.
        pub fn reset(self: Self) void {
            _ = c.xQueueReset(self.handle);
        }

        /// Check if the queue is empty (ISR-safe).
        pub fn is_empty_from_isr(self: Self) bool {
            return c.xQueueIsQueueEmptyFromISR(self.handle) != c.pdFALSE;
        }

        /// Check if the queue is full (ISR-safe).
        pub fn is_full_from_isr(self: Self) bool {
            return c.xQueueIsQueueFullFromISR(self.handle) != c.pdFALSE;
        }
    };
}

// ── Top-Level Convenience ───────────────────────────────────────────────

/// Create a new queue holding items of type `T` with the given capacity.
pub fn create(comptime T: type, length: u32) Error!Queue(T) {
    return Queue(T).create(length);
}
