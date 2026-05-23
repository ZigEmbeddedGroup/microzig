const std = @import("std");

pub fn main(init: std.process.Init) !u8 {
    const io = init.io;
    const argv = try init.minimal.args.toSlice(init.arena.allocator());
    if (argv.len != 3) {
        std.log.err("usage: lpc-patchelf <input> <output>", .{});
        return 1;
    }

    const input_file_name = argv[1];
    const output_file_name = argv[2];

    try std.Io.Dir.copyFile(
        std.Io.Dir.cwd(),
        input_file_name,
        std.Io.Dir.cwd(),
        output_file_name,
        io,
        .{},
    );

    var file = try std.Io.Dir.cwd().openFile(io, output_file_name, .{ .mode = .read_write });
    defer file.close(io);

    var read_buf: [4096]u8 = undefined;
    var write_buf: [4096]u8 = undefined;
    var file_reader = file.reader(io, &read_buf);
    var file_writer = file.writer(io, &write_buf);

    const header = try std.elf.Header.read(&file_reader.interface);

    var iter = header.iterateProgramHeaders(&file_reader);
    while (try iter.next()) |phdr| {
        if (phdr.p_type != std.elf.PT_LOAD) {
            continue;
        }

        if (phdr.p_paddr != 0) {
            // std.log.warn("LOAD program header is not located at address 0x00000000!", .{});
            break;
        }

        const boot_sector_items = 8;
        const boot_sector_size = @sizeOf([boot_sector_items]u32);

        if (phdr.p_filesz < boot_sector_size) {
            std.log.warn("boot header is too small! Expected {} bytes, but sector only has {} bytes!", .{
                boot_sector_size,
                phdr.p_filesz,
            });
            continue;
        }

        try file_reader.seekTo(phdr.p_offset);

        var checksum: u32 = 0;

        var i: usize = 0;
        while (i < boot_sector_items - 1) : (i += 1) {
            const item = try file_reader.interface.takeInt(u32, .little);
            checksum -%= item;
        }

        try file_writer.interface.writeInt(u32, checksum, .little);
    }

    try file_writer.interface.flush();
    return 0;
}
