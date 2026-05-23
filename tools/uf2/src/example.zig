const std = @import("std");
const uf2 = @import("uf2");

pub fn main(init: std.process.Init) !void {
    const gpa = init.gpa;
    const io = init.io;
    const args = try init.minimal.args.toSlice(init.arena.allocator());

    if (args.len == 3) {
        var archive = uf2.Archive.init(gpa);
        defer archive.deinit();

        const file = try std.Io.Dir.cwd().openFile(io, args[1], .{});
        defer file.close(io);

        var buf: [4096]u8 = undefined;
        var reader = file.reader(io, &buf);

        try archive.add_elf(&reader, .{
            .family_id = .RP2040,
        });
        const out_file = try std.Io.Dir.cwd().createFile(io, args[2], .{});
        defer out_file.close(io);

        var write_buf: [4096]u8 = undefined;
        var writer = out_file.writer(io, &write_buf);
        try archive.write_to(&writer.interface);
    } else if (args.len == 2) {
        const file = try std.Io.Dir.cwd().openFile(io, args[1], .{});
        defer file.close(io);

        // Buffer must be at least 512 bytes (the size of `uf2.Block`)
        var buf: [4096]u8 = undefined;
        var reader = file.reader(io, &buf);

        var archive: uf2.Archive = .init(gpa);
        defer archive.deinit();
        try archive.read_from(&reader.interface, .{});

        for (archive.families.keys()) |family_id|
            std.log.info("family_id: {t}", .{family_id});

        for (archive.blocks.items) |block|
            std.log.info("payload: {}, target_addr: 0x{x}", .{
                block.payload_size,
                block.target_addr,
            });
    }
}
