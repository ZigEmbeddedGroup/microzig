const std = @import("std");

comptime {
    _ = @import("modules/ctype.zig");
    _ = @import("modules/errno.zig");
    _ = @import("modules/math.zig");
    _ = @import("modules/setjmp.zig");
    _ = @import("modules/stdlib.zig");
    _ = @import("modules/string.zig");
    _ = @import("modules/uchar.zig");
}
