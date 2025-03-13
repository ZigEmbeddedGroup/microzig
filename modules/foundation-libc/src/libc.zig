const std = @import("std");
const builtin = @import("builtin");

pub const h = @cImport({
    @cInclude("assert.h");
    @cInclude("ctype.h");
    @cInclude("errno.h");
    @cInclude("inttypes.h");
    @cInclude("math.h");
    @cInclude("setjmp.h");
    @cInclude("stdlib.h");
    @cInclude("string.h");
    @cInclude("tgmath.h");
    @cInclude("uchar.h");

    @cInclude("foundation/libc.h");
});

comptime {
    // Some assertions over the target platform:
    std.debug.assert(@bitSizeOf(c_char) == 8);

    // Ensure hierarchy:
    std.debug.assert(@bitSizeOf(c_short) >= @bitSizeOf(c_char));
    std.debug.assert(@bitSizeOf(c_int) >= @bitSizeOf(c_short));
    std.debug.assert(@bitSizeOf(c_long) >= @bitSizeOf(c_int));
    std.debug.assert(@bitSizeOf(c_longlong) >= @bitSizeOf(c_long));

    // Ensure same-sized signed and unsigned
    std.debug.assert(@bitSizeOf(c_ushort) == @bitSizeOf(c_short));
    std.debug.assert(@bitSizeOf(c_uint) == @bitSizeOf(c_int));
    std.debug.assert(@bitSizeOf(c_ulong) == @bitSizeOf(c_long));
    std.debug.assert(@bitSizeOf(c_ulonglong) == @bitSizeOf(c_longlong));
}

comptime {
    // Drag in all implementations, so they are compiled:
    _ = @import("modules/assert.zig");
    _ = @import("modules/ctype.zig");
    _ = @import("modules/errno.zig");
    _ = @import("modules/math.zig");
    _ = @import("modules/setjmp.zig");
    _ = @import("modules/stdlib.zig");
    _ = @import("modules/string.zig");
    _ = @import("modules/uchar.zig");
}

/// Invokes safety-checked undefined behaviour, use this to implement
/// UB checks in the libc itself.
pub fn undefined_behaviour(comptime string: []const u8) noreturn {
    switch (builtin.mode) {
        // In debug mode, trigger a breakpoint so it's easier to detect the situation
        // of the undefined behaviour:
        .Debug => {
            @breakpoint();
            @panic("UNDEFINED BEHAVIOUR: " ++ string);
        },

        // Safe modes have nice messages with
        .ReleaseSafe => @panic("UNDEFINED BEHAVIOUR DETECTED: " ++ string),

        .ReleaseSmall => @panic("UB"),

        .ReleaseFast => unreachable,
    }
}

/// Zig panic handler, forwards panics to `foundation_libc_panic_handler`.
pub fn panic(msg: []const u8, maybe_error_return_trace: ?*std.builtin.StackTrace, maybe_return_address: ?usize) noreturn {
    _ = maybe_error_return_trace;
    _ = maybe_return_address;
    h.foundation_libc_panic_handler(msg.ptr, msg.len);
    unreachable;
}

/// default implementation for `foundation_libc_panic_handler`.
fn fallback_panic_handler(msg_ptr: [*]const u8, msg_len: usize) callconv(.c) noreturn {
    _ = msg_ptr;
    _ = msg_len;
    @trap();
}
comptime {
    const ptr = &fallback_panic_handler;
    @export(ptr, std.builtin.ExportOptions{
        .name = "foundation_libc_panic_handler",
        .linkage = .weak,
        .visibility = .default,
    });
}
