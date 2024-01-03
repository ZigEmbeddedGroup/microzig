//! implementation of `string.h`

const std = @import("std");

/// https://en.cppreference.com/w/c/string/byte/strchr
export fn strchr(str: ?[*:0]const c_char, ch: c_int) ?[*:0]c_char {
    const s = str orelse return null;

    const searched: c_char = @bitCast(@as(u8, @truncate(@as(c_uint, @bitCast(ch)))));

    var i: usize = 0;
    while (true) {
        const actual = s[i];
        if (actual == searched)
            return @constCast(s + i);
        if (actual == 0)
            return null;
        i += 1;
    }
}

/// https://en.cppreference.com/w/c/string/byte/strlen
export fn strlen(str: ?[*:0]const c_char) usize {
    const s = str orelse return 0;
    return std.mem.len(s);
}

/// https://en.cppreference.com/w/c/string/byte/strncmp
export fn strncmp(lhs: ?[*:0]const c_char, rhs: ?[*:0]const c_char, count: usize) c_int {
    const lhs_s: [*:0]const u8 = @ptrCast(lhs orelse return if (rhs != null) 1 else 0);
    const rhs_s: [*:0]const u8 = @ptrCast(rhs orelse return if (lhs != null) -1 else 0);

    var i: usize = 0;
    while (i < count) {
        const l = lhs_s[i];
        const r = rhs_s[i];

        const d = @as(c_int, l) - @as(c_int, r);
        if (d != 0)
            return d;

        if (l == 0 and r == 0)
            return 0;
        std.debug.assert(l != 0);
        std.debug.assert(r != 0);

        i += 1;
    }
    return 0;
}
