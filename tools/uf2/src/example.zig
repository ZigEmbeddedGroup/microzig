const std = @import("std");
const uf2 = @import("uf2.zig");

pub fn main() !void {
    const args = try std.process.argsAlloc(std.heap.page_allocator);
    defer std.process.argsFree(std.heap.page_allocator, args);

    if (args.len == 3) {
        var archive = uf2.Archive.init(std.heap.page_allocator);
        defer archive.deinit();

        const file = try std.fs.cwd().openFile(args[1], .{});
        defer file.close();

        var buf: [4096]u8 = undefined;
        var reader = file.reader(&buf);

        try archive.add_elf(&reader, .{
            .family_id = .RP2040,
        });
        const out_file = try std.fs.cwd().createFile(args[2], .{});
        defer out_file.close();

        var write_buf: [4096]u8 = undefined;
        var writer = out_file.writer(&write_buf);
        try archive.write_to(&writer.interface);
    } else if (args.len == 2) {
        const file = try std.fs.cwd().openFile(args[1], .{});
        defer file.close();

        var blocks = std.array_list.Managed(uf2.Block).init(std.heap.page_allocator);
        defer blocks.deinit();

        var buf: [4096]u8 = undefined;
        var reader = file.reader(&buf);
        while (true) {
            const block = uf2.Block.from_reader(&reader.interface) catch |err| switch (err) {
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
