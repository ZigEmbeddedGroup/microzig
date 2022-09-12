const builtin = @import("builtin");
const std = @import("std");

const debug = std.debug;
const heap = std.heap;
const mem = std.mem;
const process = std.process;
const testing = std.testing;

/// An example of what methods should be implemented on an arg iterator.
pub const ExampleArgIterator = struct {
    pub fn next(iter: *ExampleArgIterator) ?[]const u8 {
        _ = iter;
        return "2";
    }
};

/// An argument iterator which iterates over a slice of arguments.
/// This implementation does not allocate.
pub const SliceIterator = struct {
    args: []const []const u8,
    index: usize = 0,

    pub fn next(iter: *SliceIterator) ?[]const u8 {
        if (iter.args.len <= iter.index)
            return null;

        defer iter.index += 1;
        return iter.args[iter.index];
    }
};

test "SliceIterator" {
    const args = [_][]const u8{ "A", "BB", "CCC" };
    var iter = SliceIterator{ .args = &args };

    for (args) |a|
        try testing.expectEqualStrings(a, iter.next().?);

    try testing.expectEqual(@as(?[]const u8, null), iter.next());
}
