const std = @import("std");
const root = @import("root");

/// Is `true` when microzig has a clock frequency available.
pub const has_clock = @hasDecl(root, "cpu_frequency");

/// Returns `true` when the frequency can change at runtime.
pub const is_dynamic = has_clock and !@typeInfo(@TypeOf(&root.cpu_frequency)).Pointer.is_const;

/// Ensures that microzig has a clock available. This will @compileError when no clock is available, otherwise, it will be a no-op.
pub fn ensure() void {
    if (!has_clock)
        @compileError("microzig requires the clock frequency to perform this operation. Please export a const or var cpu_frequency from your root file that contains the cpu frequency in hertz!");
}

/// Returns the current cpu frequency in hertz.
pub fn get() callconv(.Inline) u32 {
    ensure();
    return root.cpu_frequency;
}
