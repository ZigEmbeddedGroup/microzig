//! implementation of `stdlib.h`

const std = @import("std");

/// https://en.cppreference.com/w/c/string/byte/atoi
export fn atoi(str: ?[*:0]const c_char) c_int {
    const s = str orelse return 0;

    var i: usize = 0;
    while (std.ascii.isWhitespace(@bitCast(s[i]))) {
        i += 1;
    }

    const slice = std.mem.sliceTo(s + i, 0);

    return std.fmt.parseInt(c_int, @ptrCast(slice), 10) catch return 0;
}
