const std = @import("std");

const flash_base: u64 = 0x0;
const flash_size: u64 = 960 * 1024;

const Segment = struct {
    paddr: u64,
    data: []const u8,
};

fn extract_flash_segments(gpa: std.mem.Allocator, elf_data: []const u8) ![]Segment {
    var reader: std.Io.Reader = .fixed(elf_data);
    const elf_header = try std.elf.Header.read(&reader);
    if (elf_header.machine != .RISCV) return error.NotARiscvElf;

    var segments: std.ArrayList(Segment) = .empty;
    defer segments.deinit(gpa);

    var it = elf_header.iterateProgramHeadersBuffer(elf_data);
    while (try it.next()) |phdr| {
        if (phdr.type != .LOAD) continue;
        if (phdr.filesz == 0) continue;
        if (phdr.paddr < flash_base or phdr.paddr + phdr.filesz > flash_base + flash_size) continue;
        try segments.append(gpa, .{
            .paddr = phdr.paddr,
            .data = elf_data[@intCast(phdr.offset)..][0..@intCast(phdr.filesz)],
        });
    }

    if (segments.items.len == 0) return error.NoFlashSegments;
    return segments.toOwnedSlice(gpa);
}

fn place_segments(
    gpa: std.mem.Allocator,
    image: *std.ArrayList(u8),
    segments: []const Segment,
    image_offset: u64,
) !void {
    for (segments) |seg| {
        const start = (seg.paddr - flash_base) + image_offset;
        const end = start + seg.data.len;
        if (end > image.items.len) {
            const old_len = image.items.len;
            try image.resize(gpa, @intCast(end));
            @memset(image.items[old_len..], 0xFF);
        }
        for (image.items[@intCast(start)..@intCast(end)]) |byte| {
            if (byte != 0xFF) return error.OverlappingSegments;
        }
        @memcpy(image.items[@intCast(start)..@intCast(end)], seg.data);
    }
}

pub fn main(init: std.process.Init) !void {
    const gpa = init.gpa;
    const io = init.io;

    const args = try init.minimal.args.toSlice(gpa);
    defer gpa.free(args);

    if (args.len != 4) return error.ArgsError;

    const v3f_elf_path = args[1];
    const v5f_elf_path = args[2];
    const merged_elf_path = args[3];

    const v3f_elf = try std.Io.Dir.cwd().readFileAlloc(io, v3f_elf_path, gpa, .limited(64 * 1024 * 1024));
    const v5f_elf = try std.Io.Dir.cwd().readFileAlloc(io, v5f_elf_path, gpa, .limited(64 * 1024 * 1024));
    const v5f_offset = 0x10000;
    defer gpa.free(v3f_elf);
    defer gpa.free(v5f_elf);

    const v3f_segments = try extract_flash_segments(gpa, v3f_elf);
    const v5f_segments = try extract_flash_segments(gpa, v5f_elf);
    defer gpa.free(v3f_segments);
    defer gpa.free(v5f_segments);

    // Sanity check
    for (v5f_segments) |seg| {
        if (seg.paddr - flash_base < v5f_offset) {
            return error.UnexpectedV5fOffset;
        }
    }

    var image: std.ArrayList(u8) = .empty;
    try place_segments(gpa, &image, v3f_segments, 0);
    try place_segments(gpa, &image, v5f_segments, 0);
    defer image.deinit(gpa);

    try std.Io.Dir.cwd().writeFile(io, .{
        .data = image.items,
        .sub_path = merged_elf_path,
        .flags = .{},
    });
}
