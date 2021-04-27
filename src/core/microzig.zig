const std = @import("std");

/// Module that helps with interrupt handling.
pub const interrupts = @import("interrupts.zig");

/// The microzig panic handler. Will disable interrupts and loop endlessly.
/// Export this symbol from your main file to enable microzig:
/// ```
/// const micro = @import("microzig");
/// pub const panic = micro.panic;
/// ```
pub fn panic(message: []const u8, stack_trace: ?*std.builtin.StackTrace) noreturn {
    while (true) {
        interrupts.cli();

        // "this loop has side effects, don't optimize the endless loop away please. thanks!"
        asm volatile ("" ::: "memory");
    }
}
