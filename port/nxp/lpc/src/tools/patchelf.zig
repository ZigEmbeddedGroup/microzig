const std = @import("std");

pub fn main() !u8 {
    const argv = try std.process.argsAlloc(std.heap.page_allocator);
    defer std.process.argsFree(std.heap.page_allocator, argv);

    if (argv.len != 3) {
        std.log.err("usage: lpc-patchelf <input> <output>", .{});
        return 1;
    }

    const input_file_name = argv[1];
    const output_file_name = argv[2];

    try std.fs.Dir.copyFile(
        std.fs.cwd(),
        input_file_name,
        std.fs.cwd(),
        output_file_name,
        .{},
    );

    var file = try std.fs.cwd().openFile(output_file_name, .{ .mode = .read_write });
    defer file.close();

    const header = try std.elf.Header.read(file);

    var iter = header.program_header_iterator(file);
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

        try file.seekTo(phdr.p_offset);
        var reader = file.reader();
        var writer = file.writer();

        var checksum: u32 = 0;

        var i: usize = 0;
        while (i < boot_sector_items - 1) : (i += 1) {
            const item = try reader.readInt(u32, .little);
            checksum -%= item;
        }

        try writer.writeInt(u32, checksum, .little);
    }

    return 0;
}
