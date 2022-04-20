const std = @import("std");
const uf2 = @import("main.zig");

pub fn main() !void {
    var args = try std.process.argsAlloc(std.heap.page_allocator);
    defer std.process.argsFree(std.heap.page_allocator, args);

    if (args.len == 3) {
        var archive = uf2.Archive.init(std.heap.page_allocator);
        defer archive.deinit();

        try archive.addElf(args[1], .{
            .family_id = .RP2040,
        });
        const out_file = try std.fs.cwd().createFile(args[2], .{});
        defer out_file.close();

        try archive.writeTo(out_file.writer());
    } else if (args.len == 2) {
        const file = try std.fs.cwd().openFile(args[1], .{});
        defer file.close();

        var blocks = std.ArrayList(uf2.Block).init(std.heap.page_allocator);
        defer blocks.deinit();

        while (true) {
            const block = uf2.Block.fromReader(file.reader()) catch |err| switch (err) {
                error.EndOfStream => break,
                else => return err,
            };
            try blocks.append(block);
        }

        for (blocks.items) |block|
            std.log.info("payload: {}, target_addr: 0x{x}", .{
                block.payload_size,
                block.target_addr,
            });
    }
}
