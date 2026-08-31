const std = @import("std");
const flags = @import("flags");

pub fn main(init: std.process.Init) !void {
    const gpa = init.gpa;
    const io = init.io;
    const args = try init.minimal.args.toSlice(init.arena.allocator());

    _ = io;
    _ = args;
    _ = gpa;
}
