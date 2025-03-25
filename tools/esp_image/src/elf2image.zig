const std = @import("std");
const Sha256 = std.crypto.hash.sha2.Sha256;
const clap = @import("clap");

// pub const std_options: std.Options = .{
//     .log_level = .debug,
// };

pub fn main() !void {
    var debug_allocator: std.heap.DebugAllocator(.{}) = .init;
    defer _ = debug_allocator.deinit();
    const allocator = debug_allocator.allocator();

    const args = comptime clap.parseParamsComptime(
        \\--help                    Show this message
        \\--output <str>            Path to save the generated file
        \\--chip-id <ChipId>        Chip id
        \\--min-rev-full <u16>      Minimal chip revision (in format: major * 100 + minor)
        \\--max-rev-full <u16>      Maximal chip revision (in format: major * 100 + minor)
        \\--dont-append-digest      Don't append a SHA256 digest of the entire image after the checksum
        \\--flash-freq <FlashFreq>  SPI Flash frequency
        \\--flash-mode <FlashMode>  SPI Flash mode
        \\--flash-size <FlashSize>  SPI Flash size in megabytes
        \\--use-segments            Use program headers instead of section headers
        \\<str>
        \\
    );

    var diag = clap.Diagnostic{};
    var res = clap.parse(clap.Help, &args, .{
        .u16 = clap.parsers.int(u16, 10),
        .str = clap.parsers.string,
        .ChipId = clap.parsers.enumeration(ChipId),
        .FlashFreq = clap.parsers.enumeration(FlashFreq),
        .FlashMode = clap.parsers.enumeration(FlashMode),
        .FlashSize = clap.parsers.enumeration(FlashSize),
    }, .{
        .diagnostic = &diag,
        .allocator = allocator,
    }) catch |err| {
        diag.report(std.io.getStdErr().writer(), err) catch {};
        return err;
    };
    defer res.deinit();

    if (res.args.help != 0)
        return clap.help(std.io.getStdErr().writer(), clap.Help, &args, .{});

    const elf_path = res.positionals[0] orelse return error.MissingInputFile;
    const output_path = res.args.output orelse return error.MissingOutputFile;
    const chip_id = res.args.@"chip-id" orelse return error.MissingChipId;
    const min_rev: u16 = res.args.@"min-rev-full" orelse 0x0000;
    const max_rev: u16 = res.args.@"max-rev-full" orelse 0xffff;
    const no_digest = res.args.@"dont-append-digest" != 0;
    const flash_freq: FlashFreq = res.args.@"flash-freq" orelse .@"40m";
    const flash_mode: FlashMode = res.args.@"flash-mode" orelse .dio;
    const flash_size: FlashSize = res.args.@"flash-size" orelse .@"4mb";
    const use_segments = res.args.@"use-segments" != 0;

    const chip = chips.get(chip_id) orelse {
        return error.UnimplementedChip;
    };

    const elf_file = try std.fs.cwd().openFile(elf_path, .{});
    defer elf_file.close();
    const elf_header = try std.elf.Header.read(elf_file);

    const entry_point: u32 = @intCast(elf_header.entry);

    var flash_segments: std.ArrayListUnmanaged(Segment) = .empty;
    defer flash_segments.deinit(allocator);
    defer for (flash_segments.items) |segment| {
        segment.deinit(allocator);
    };

    var ram_segments: std.ArrayListUnmanaged(Segment) = .empty;
    defer ram_segments.deinit(allocator);
    defer for (ram_segments.items) |segment| {
        segment.deinit(allocator);
    };

    {
        var info_list: std.ArrayListUnmanaged(SegmentInfo) = .empty;
        defer info_list.deinit(allocator);

        if (use_segments) {
            var it = elf_header.program_header_iterator(elf_file);
            while (try it.next()) |hdr| {
                if (hdr.p_type == std.elf.PT_LOAD and hdr.p_memsz > 0 and hdr.p_filesz > 0) {
                    try info_list.append(allocator, .{
                        .addr = @as(u32, @intCast(hdr.p_paddr)),
                        .file_offset = @as(u32, @intCast(hdr.p_offset)),
                        .size = @as(u32, @intCast(hdr.p_filesz)),
                    });
                }
            }
        } else {
            var it = elf_header.section_header_iterator(elf_file);
            while (try it.next()) |hdr| {
                if (hdr.sh_type == std.elf.SHT_PROGBITS and hdr.sh_flags & std.elf.SHF_ALLOC != 0 and hdr.sh_size > 0) {
                    try info_list.append(allocator, .{
                        .addr = @as(u32, @intCast(hdr.sh_addr)),
                        .file_offset = @as(u32, @intCast(hdr.sh_offset)),
                        .size = @as(u32, @intCast(hdr.sh_size)),
                    });
                }
            }
        }

        if (info_list.items.len == 0) {
            return error.NoSegments;
        }
        std.sort.insertion(SegmentInfo, info_list.items, {}, SegmentInfo.lessThan);

        for (info_list.items) |segment_info| {
            if ((chip.irom_map_start <= segment_info.addr and segment_info.addr < chip.irom_map_end) or
                (chip.drom_map_start <= segment_info.addr and segment_info.addr < chip.drom_map_end))
            {
                try flash_segments.append(allocator, try .init(allocator, segment_info, elf_file));
            } else {
                try ram_segments.append(allocator, try .init(allocator, segment_info, elf_file));
            }
        }
    }

    // TODO: maybe also check if sections overlap

    // merge segments
    try do_segment_merge(allocator, &flash_segments);
    try do_segment_merge(allocator, &ram_segments);

    for (flash_segments.items) |segment| {
        std.log.debug("flash segment at addr 0x{x} of size 0x{x}", .{ segment.addr, segment.size });
    }

    for (ram_segments.items) |segment| {
        std.log.debug("ram segment at addr 0x{x} of size 0x{x}", .{ segment.addr, segment.size });
    }

    var segment_data: std.ArrayListUnmanaged(u8) = .empty;
    defer segment_data.deinit(allocator);

    var segment_count: u8 = 0;
    var checksum: u8 = checksum_xor_byte;
    {
        const writer = segment_data.writer(allocator);

        for (flash_segments.items) |*segment| {
            while (segment.get_flash_align_padding_len(segment_data.items.len + image_header_len)) |pad_len| {
                if (ram_segments.items.len > 0 and pad_len > segment_header_len) {
                    const ram_seg = &ram_segments.items[ram_segments.items.len - 1];
                    try ram_seg.write_to(allocator, writer, pad_len, &checksum);
                    if (ram_seg.size == 0) {
                        ram_segments.items.len -= 1;
                    }
                } else {
                    var padding_seg: Segment = try .init_padding(allocator, pad_len);
                    defer padding_seg.deinit(allocator);
                    try padding_seg.write_to(allocator, writer, null, &checksum);
                }
                segment_count += 1;
            }

            try segment.write_to(allocator, writer, null, &checksum);
            segment_count += 1;
        }

        for (ram_segments.items) |*segment| {
            try segment.write_to(allocator, writer, null, &checksum);
            segment_count += 1;
        }
    }

    const output_file = try std.fs.cwd().createFile(output_path, .{});
    defer output_file.close();
    const output_file_writer = output_file.writer();

    var sha256: Sha256 = .init(.{});

    var multi_writer = std.io.multiWriter(.{ output_file_writer, sha256.writer() });
    const multi_writer_writer = multi_writer.writer();

    const file_header: FileHeader = .{
        .number_of_segments = segment_count,
        .flash_mode = flash_mode,
        .flash_size = flash_size,
        .flash_freq = flash_freq,
        .entry_point = entry_point,
    };

    const extended_file_header: ExtendedFileHeader = .{
        .wp = .disabled,
        .flash_pins_drive_settings = 0, // TODO: should we make this configurable + packed struct?
        .chip_id = chip_id,
        .min_rev = min_rev,
        .max_rev = max_rev,
        .hash = !no_digest,
    };

    try file_header.write_to(multi_writer_writer);
    try extended_file_header.write_to(multi_writer_writer);

    try multi_writer_writer.writeAll(segment_data.items);

    // TODO: secure pad

    const position = try output_file.getPos();
    const padding: [16]u8 = @splat(0);
    try multi_writer_writer.writeAll(padding[0 .. 15 - position % 16]);
    try multi_writer_writer.writeByte(checksum);

    if (!no_digest) {
        try output_file_writer.writeAll(&sha256.finalResult());
    }
}

fn do_segment_merge(allocator: std.mem.Allocator, segment_list: *std.ArrayListUnmanaged(Segment)) !void {
    if (segment_list.items.len >= 2) {
        var i: usize = segment_list.items.len - 1;
        while (i > 0) : (i -= 1) {
            const seg_a = &segment_list.items[i - 1];
            const seg_b = segment_list.items[i];
            if (seg_a.addr + seg_a.size == seg_b.addr) {
                try seg_a.merge(allocator, seg_b);
                seg_b.deinit(allocator);
                _ = segment_list.orderedRemove(i);
            }
        }
    }
}

const irom_align = 0x10000;
const segment_header_len = 0x8;
const image_header_len = 0x18;
const checksum_xor_byte = 0xEF;

pub const FlashMode = enum(u8) {
    qio = 0,
    qout = 1,
    dio = 2,
    dout = 3,
};

pub const FlashSize = enum(u4) {
    @"1mb" = 0,
    @"2mb" = 1,
    @"4mb" = 2,
    @"8mb" = 3,
    @"16mb" = 4,
};

pub const FlashFreq = enum(u4) {
    @"40m" = 0,
    @"26m" = 1,
    @"20m" = 2,
    @"80m" = 3,
};

pub const ChipId = enum(u16) {
    esp32 = 0x0000,
    esp32_s2 = 0x0002,
    esp32_c3 = 0x0005,
    esp32_s3 = 0x0009,
    esp32_c2 = 0x000c,
    esp32_c6 = 0x000d,
    esp32_h2 = 0x0010,
    esp32_p4 = 0x0012,
};

pub const chips: std.enums.EnumMap(ChipId, Chip) = .init(.{
    .esp32_c3 = .{
        .irom_map_start = 0x42000000,
        .irom_map_end = 0x42800000,
        .drom_map_start = 0x3C000000,
        .drom_map_end = 0x3C800000,
    },
});

const Chip = struct {
    irom_map_start: usize,
    irom_map_end: usize,
    drom_map_start: usize,
    drom_map_end: usize,
};

const FileHeader = struct {
    number_of_segments: u8,
    flash_mode: FlashMode,
    flash_size: FlashSize,
    flash_freq: FlashFreq,
    entry_point: u32,

    pub fn write_to(self: FileHeader, writer: anytype) !void {
        try writer.writeAll(&.{
            0xE9,
            self.number_of_segments,
            @intFromEnum(self.flash_mode),
            (@as(u8, @intFromEnum(self.flash_size)) << 4) | @intFromEnum(self.flash_freq),
        });
        try writer.writeInt(u32, self.entry_point, .little);
    }
};

const ExtendedFileHeader = struct {
    pub const WpPin = enum(u8) {
        disabled = 0xee,
    };

    wp: WpPin,
    flash_pins_drive_settings: u24,
    chip_id: ChipId,
    min_rev: u16,
    max_rev: u16,
    hash: bool,

    pub fn write_to(self: ExtendedFileHeader, writer: anytype) !void {
        try writer.writeByte(@intFromEnum(self.wp));
        try writer.writeInt(u24, self.flash_pins_drive_settings, .little);
        try writer.writeInt(u16, @intFromEnum(self.chip_id), .little);
        try writer.writeByte(0);
        try writer.writeInt(u16, self.min_rev, .little);
        try writer.writeInt(u16, self.max_rev, .little);
        try writer.writeAll(&.{ 0, 0, 0, 0 });
        try writer.writeByte(@intFromBool(self.hash));
    }
};

const SegmentInfo = struct {
    addr: usize,
    file_offset: usize,
    size: usize,

    pub fn lessThan(_: void, lhs: SegmentInfo, rhs: SegmentInfo) bool {
        return lhs.addr < rhs.addr;
    }
};

const Segment = struct {
    addr: usize,
    size: usize,
    data: []u8,

    pub fn init(allocator: std.mem.Allocator, segment_info: SegmentInfo, elf_file: std.fs.File) !Segment {
        try elf_file.seekTo(segment_info.file_offset);

        const data = try allocator.alloc(u8, segment_info.size + segment_info.size % 4);
        errdefer allocator.free(data);

        const n = try elf_file.readAll(data[0..segment_info.size]);
        if (n != segment_info.size) {
            return error.InvalidSegment;
        }

        @memset(data[segment_info.size..], 0);

        return .{
            .addr = segment_info.addr,
            .size = data.len,
            .data = data,
        };
    }

    pub fn init_padding(allocator: std.mem.Allocator, size: usize) !Segment {
        const data = try allocator.alloc(u8, size);
        errdefer allocator.free(data);
        @memset(data, 0);

        return .{
            .addr = 0,
            .size = size,
            .data = data,
        };
    }

    pub fn deinit(self: Segment, allocator: std.mem.Allocator) void {
        allocator.free(self.data);
    }

    pub fn get_flash_align_padding_len(self: Segment, file_pos: usize) ?usize {
        const align_past: i32 = @as(i32, @intCast(self.addr % irom_align)) - segment_header_len;
        var pad_len: i32 = (irom_align - @as(i32, @intCast(file_pos % irom_align))) + align_past;
        if (pad_len == 0 or pad_len == irom_align) {
            return null;
        }

        pad_len -= segment_header_len;
        if (pad_len < 0) {
            pad_len += irom_align;
        }
        return @intCast(pad_len);
    }

    pub fn merge(self: *Segment, allocator: std.mem.Allocator, other: Segment) !void {
        std.debug.assert(self.addr + self.size == other.addr);

        const new_size = self.size + other.size;
        self.data = try allocator.realloc(self.data, new_size);
        @memcpy(self.data[self.size..], other.data[0..other.size]);
        self.size = new_size;
    }

    pub fn write_to(self: *Segment, allocator: std.mem.Allocator, writer: anytype, len: ?usize, checksum: *u8) !void {
        if (self.size != 0) {
            const consume_len = if (len) |consume_len| @min(self.size, consume_len) else self.size;
            try writer.writeInt(u32, @intCast(self.addr), .little);
            try writer.writeInt(u32, @intCast(consume_len), .little);
            try writer.writeAll(self.data[0..consume_len]);

            for (self.data[0..consume_len]) |byte| {
                checksum.* ^= byte;
            }

            const remaining_len = self.size - consume_len;
            std.mem.copyBackwards(u8, self.data[0..remaining_len], self.data[consume_len..self.size]);
            if (allocator.resize(self.data, remaining_len)) {
                self.data.len = remaining_len;
            }

            self.addr += consume_len;
            self.size = remaining_len;
        }
    }
};

test "Segment.get_padding_len" {
    var allocator = std.testing.allocator;
    const segment: Segment = .{
        .addr = 0x42000020,
        .size = 0x20,
        .data = try allocator.alloc(u8, 0x20),
    };
    defer segment.deinit(allocator);

    try std.testing.expectEqual(segment.get_flash_align_padding_len(0x9900), 0x6710);
    try std.testing.expectEqual(segment.get_flash_align_padding_len(0xfff8), 0x18);
    try std.testing.expectEqual(segment.get_flash_align_padding_len(0x10018), null);
}

test "do_segment_merge" {
    var allocator = std.testing.allocator;

    var segment_list: std.ArrayListUnmanaged(Segment) = .empty;
    defer segment_list.deinit(allocator);
    defer for (segment_list.items) |segment| {
        segment.deinit(allocator);
    };

    try segment_list.append(allocator, .{
        .addr = 0x42000020,
        .size = 0x20,
        .data = try allocator.alloc(u8, 0x20),
    });
    try segment_list.append(allocator, .{
        .addr = 0x42000040,
        .size = 0x20,
        .data = try allocator.alloc(u8, 0x20),
    });

    @memset(segment_list.items[0].data, 'a');
    @memset(segment_list.items[1].data, 'b');

    try do_segment_merge(allocator, &segment_list);

    try std.testing.expectEqual(segment_list.items.len, 1);
    try std.testing.expectEqual(segment_list.items[0].addr, 0x42000020);
    try std.testing.expectEqual(segment_list.items[0].size, 0x40);
    try std.testing.expectEqualStrings(segment_list.items[0].data, &(@as([0x20]u8, @splat('a')) ++ @as([0x20]u8, @splat('b'))));
}

test "Segment.write_to" {
    var allocator = std.testing.allocator;
    var segment: Segment = .{
        .addr = 0x42000020,
        .size = 0x20,
        .data = try allocator.alloc(u8, 0x20),
    };
    defer segment.deinit(allocator);

    @memset(segment.data, 'a');

    var segment_data: std.ArrayListUnmanaged(u8) = .empty;
    defer segment_data.deinit(allocator);
    const writer = segment_data.writer(allocator);

    var checksum: u8 = checksum_xor_byte;
    try segment.write_to(allocator, writer, 0x10, &checksum);
    try segment.write_to(allocator, writer, null, &checksum);

    try std.testing.expectEqual(std.mem.readInt(u32, segment_data.items[0..4], .little), 0x42000020);
    try std.testing.expectEqual(std.mem.readInt(u32, segment_data.items[4..8], .little), 0x10);
    try std.testing.expectEqualStrings(segment_data.items[8..24], &@as([16]u8, @splat('a')));
    try std.testing.expectEqual(std.mem.readInt(u32, segment_data.items[24..28], .little), 0x42000030);
    try std.testing.expectEqual(std.mem.readInt(u32, segment_data.items[28..32], .little), 0x10);
    try std.testing.expectEqualStrings(segment_data.items[32..48], &@as([16]u8, @splat('a')));
    try std.testing.expectEqual(segment.size, 0);
}
