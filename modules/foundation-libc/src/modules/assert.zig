const std = @import("std");
const builtin = @import("builtin");

export fn foundation_libc_assert(
    assertion: ?[*:0]const u8,
    file: ?[*:0]const u8,
    line: c_uint,
) noreturn {
    switch (builtin.mode) {
        .Debug, .ReleaseSafe => {
            var buf: [256]u8 = undefined;
            const str = std.fmt.bufPrint(&buf, "assertion failed: '{?s}' in file {?s} line {}", .{ assertion, file, line }) catch {
                @panic("assertion failed");
            };
            @panic(str);
        },
        .ReleaseSmall => @panic("assertion failed"),
        .ReleaseFast => unreachable,
    }
}
