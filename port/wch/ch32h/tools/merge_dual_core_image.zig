//! merge_dual_core_image - merge the CH32H417 V3F and V5F firmware ELFs into
//! one flash image. PT_LOAD segments inside the CodeFlash window are placed at
//! their load address (V3F @ 0x0, V5F @ <v5f_offset>), gaps 0xFF-padded.
//!
//! Usage: merge_dual_core_image <v3f.elf> <v5f.elf> <v5f_offset> <out.bin>

const std = @import("std");

/// CodeFlash of the CH32H417 (960 KB at 0x0000_0000).
const flash_base: u64 = 0x0000_0000;
const flash_size: u64 = 960 * 1024;

const Segment = struct {
    paddr: u64,
    data: []const u8,
};

fn extract_flash_segments(allocator: std.mem.Allocator, elf_data: []const u8) ![]Segment {
    var reader: std.Io.Reader = .fixed(elf_data);
    const elf_header = try std.elf.Header.read(&reader);
    if (elf_header.machine != .RISCV) return error.NotARiscvElf;

    var segments: std.ArrayList(Segment) = .empty;
    var it = elf_header.iterateProgramHeadersBuffer(elf_data);
    while (try it.next()) |phdr| {
        if (phdr.type != .LOAD) continue;
        if (phdr.filesz == 0) continue;
        if (phdr.paddr < flash_base or phdr.paddr + phdr.filesz > flash_base + flash_size) continue;
        try segments.append(allocator, .{
            .paddr = phdr.paddr,
            .data = elf_data[@intCast(phdr.offset)..][0..@intCast(phdr.filesz)],
        });
    }
    if (segments.items.len == 0) return error.NoFlashSegments;
    return segments.items;
}

/// Writes all segments of one core into the image buffer at
/// `(paddr - flash_base) + image_offset`, extending the buffer as needed.
fn place_segments(
    allocator: std.mem.Allocator,
    image: *std.ArrayList(u8),
    segments: []const Segment,
    image_offset: u64,
) !void {
    for (segments) |seg| {
        const start = (seg.paddr - flash_base) + image_offset;
        const end = start + seg.data.len;
        if (end > image.items.len) {
            const old_len = image.items.len;
            try image.resize(allocator, @intCast(end));
            @memset(image.items[old_len..], 0xFF); // erased flash pattern
        }
        // Reject overlaps: they indicate a broken memory layout.
        for (image.items[@intCast(start)..@intCast(end)]) |byte| {
            if (byte != 0xFF) return error.OverlappingSegments;
        }
        @memcpy(image.items[@intCast(start)..@intCast(end)], seg.data);
    }
}

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const allocator = init.arena.allocator();
    const args = try init.minimal.args.toSlice(allocator);

    if (args.len != 5) {
        std.log.err("usage: {s} <v3f.elf> <v5f.elf> <v5f_offset> <out.bin>", .{args[0]});
        return error.InvalidArguments;
    }

    const v3f_elf = try std.Io.Dir.cwd().readFileAlloc(io, args[1], allocator, .limited(64 * 1024 * 1024));
    const v5f_elf = try std.Io.Dir.cwd().readFileAlloc(io, args[2], allocator, .limited(64 * 1024 * 1024));
    const v5f_offset = try std.fmt.parseInt(u64, args[3], 0);

    const v3f_segments = try extract_flash_segments(allocator, v3f_elf);
    const v5f_segments = try extract_flash_segments(allocator, v5f_elf);

    // Sanity check.
    for (v5f_segments) |seg| {
        if (seg.paddr - flash_base < v5f_offset) {
            std.log.err(
                "v5f segment at flash offset 0x{x} lies before the expected v5f image offset 0x{x}",
                .{ seg.paddr - flash_base, v5f_offset },
            );
            return error.UnexpectedV5fOffset;
        }
    }

    var image: std.ArrayList(u8) = .empty;
    try place_segments(allocator, &image, v3f_segments, 0);
    try place_segments(allocator, &image, v5f_segments, 0);

    std.log.info("merged image: {d} bytes ({d} v3f segments at 0x0, {d} v5f segments at 0x{x})", .{
        image.items.len, v3f_segments.len, v5f_segments.len, v5f_offset,
    });

    try std.Io.Dir.cwd().writeFile(io, .{ .sub_path = args[4], .data = image.items });
}
