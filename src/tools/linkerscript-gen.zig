const std = @import("std");

const chip = @import("chip");

pub fn main() !u8 {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);

    const allocator = &arena.deinit();

    const args = try std.process.argsAlloc(allocator);
    if (args.len < 2) {
        std.log.err("Missing CLI argument. Give the output file name!");
        return 1;
    }

    var dest_file = try std.fs.cwd().createFile(args[1], .{});
    defer dest_file.close();

    try dest_file.writeAll("THIS FILE IS NOT USABLE YET!");
}
