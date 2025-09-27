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

        // Buffer must be at least 512 bytes (the size of `uf2.Block`)
        var buf: [4096]u8 = undefined;
        var reader = file.reader(&buf);

        var archive: uf2.Archive = .init(std.heap.page_allocator);
        defer archive.deinit();
        try archive.read_from(&reader.interface);

        for (archive.blocks.items) |block|
            std.log.info("payload: {}, target_addr: 0x{x}", .{
                block.payload_size,
                block.target_addr,
            });
    }
}
