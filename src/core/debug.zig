const std = @import("std");
const micro = @import("microzig.zig");

pub fn busySleep(comptime limit: comptime_int) void {
    if (limit <= 0) @compileError("limit must be non-negative!");

    comptime var bits = 0;
    inline while ((1 << bits) <= limit) {
        bits += 1;
    }

    const I = std.meta.Int(.unsigned, bits);

    var i: I = 0;
    while (i < limit) : (i += 1) {
        @import("std").mem.doNotOptimizeAway(i);
    }
}

const DebugErr = error{};
fn writerWrite(ctx: void, string: []const u8) DebugErr!usize {
    _ = ctx;
    write(string);
    return string.len;
}

const DebugWriter = std.io.Writer(void, DebugErr, writerWrite);

pub fn write(string: []const u8) void {
    if (!micro.config.has_board and !@hasDecl(micro.board, "debugWrite"))
        return;

    micro.board.debugWrite(string);
}

pub fn writer() DebugWriter {
    return DebugWriter{ .context = {} };
}
