const std = @import("std");

export fn __assert(
    assertion: ?[*:0]const u8,
    file: ?[*:0]const u8,
    line: c_uint,
) noreturn {
    var buf: [256]u8 = undefined;
    const str = std.fmt.bufPrint(&buf, "assertion failed: '{?s}' in file {?s} line {}", .{ assertion, file, line }) catch {
        @panic("assertion failed");
    };

    @panic(str);
}
