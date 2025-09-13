const std = @import("std");
const Sha256 = std.crypto.hash.sha2.Sha256;
const clap = @import("clap");
const esp_image = @import("esp_image");
const AppDesc = esp_image.AppDesc;

pub const std_options: std.Options = .{
    .log_level = .warn,
};

var elf_file_reader_buf: [1024]u8 = undefined;
var elf_file_hashing_buf: [std.crypto.hash.sha2.Sha256.digest_length]u8 = undefined;
var output_writer_buf: [1024]u8 = undefined;

pub fn main() !void {
    var debug_allocator: std.heap.DebugAllocator(.{}) = .init;
    defer _ = debug_allocator.deinit();
    const allocator = debug_allocator.allocator();

    const args = comptime clap.parseParamsComptime(
        \\--help                                     Show this message
        \\--output <str>                             Path to save the generated file
        \\--chip-id <ChipId>                         Chip id
        \\--min-rev-full <u16>                       Minimal chip revision (in format: major * 100 + minor)
        \\--max-rev-full <u16>                       Maximal chip revision (in format: major * 100 + minor)
        \\--dont-append-digest                       Don't append a SHA256 digest of the entire image after the checksum
        \\--flash-freq <FlashFreq>                   SPI Flash frequency
        \\--flash-mode <FlashMode>                   SPI Flash mode
        \\--flash-size <FlashSize>                   SPI Flash size in megabytes
        \\--flash-mmu-page-size <FlashMMU_PageSize>  Flash MMU page size
        \\--use-segments                             Use program headers instead of section headers
        \\<str>
        \\
    );

    const stderr = std.fs.File.stderr();
    var stderr_writer = stderr.writer(&.{});

    var diag: clap.Diagnostic = .{};
    var res = clap.parse(clap.Help, &args, .{
        .u16 = clap.parsers.int(u16, 10),
        .str = clap.parsers.string,
        .ChipId = clap.parsers.enumeration(ChipId),
        .FlashFreq = clap.parsers.enumeration(FlashFreq),
        .FlashMode = clap.parsers.enumeration(FlashMode),
        .FlashSize = clap.parsers.enumeration(FlashSize),
        .FlashMMU_PageSize = clap.parsers.enumeration(FlashMMU_PageSize),
    }, .{
        .diagnostic = &diag,
        .allocator = allocator,
    }) catch |err| {
        diag.report(&stderr_writer.interface, err) catch {};
        return err;
    };
    defer res.deinit();

    if (res.args.help != 0) {
        return clap.help(&stderr_writer.interface, clap.Help, &args, .{});
    }

    const elf_path = res.positionals[0] orelse return error.MissingInputFile;
    const output_path = res.args.output orelse return error.MissingOutputFile;

    const chip_id = res.args.@"chip-id" orelse return error.MissingChipId;
    const chip = chips.get(chip_id) orelse {
        std.log.err("support for chip `{s}` is not implemented yet", .{@tagName(chip_id)});
        return error.UnimplementedChip;
    };

    const min_rev: u16 = res.args.@"min-rev-full" orelse 0x0000;
    const max_rev: u16 = res.args.@"max-rev-full" orelse 0xffff;
    const no_digest = res.args.@"dont-append-digest" != 0;
    const flash_freq: FlashFreq = res.args.@"flash-freq" orelse .@"40m";
    const flash_mode: FlashMode = res.args.@"flash-mode" orelse .dio;
    const flash_size: FlashSize = res.args.@"flash-size" orelse .@"4mb";

    var flash_mmu_page_size: FlashMMU_PageSize = DEFAULT_FLASH_MMU_PAGE_SIZE;
    if (res.args.@"flash-mmu-page-size") |page_size_override| {
        if (chip.supported_flash_mmu_page_sizes) |supported_flash_mmu_page_sizes| {
            if (std.mem.indexOfScalar(FlashMMU_PageSize, supported_flash_mmu_page_sizes, page_size_override) != null) {
                flash_mmu_page_size = page_size_override;
            } else {
                std.log.err("flash mmu page size `{t}` is not supported by chip `{t}`... using default `{t}`", .{
                    flash_mmu_page_size,
                    chip_id,
                    DEFAULT_FLASH_MMU_PAGE_SIZE,
                });
            }
        }
    }

    const use_segments = res.args.@"use-segments" != 0;

    const elf_file = try std.fs.cwd().openFile(elf_path, .{});
    defer elf_file.close();
    var elf_file_reader = elf_file.reader(&elf_file_reader_buf);

    var elf_file_hash: [std.crypto.hash.sha2.Sha256.digest_length]u8 = undefined;
    {
        var hashing: std.Io.Writer.Hashing(std.crypto.hash.sha2.Sha256) = .init(&elf_file_hashing_buf);
        _ = try elf_file_reader.interface.streamRemaining(&hashing.writer);
        hashing.hasher.final(&elf_file_hash);
        try elf_file_reader.seekTo(0);
    }

    const elf_header = try std.elf.Header.read(&elf_file_reader.interface);

    const entry_point: u32 = @intCast(elf_header.entry);

    var flash_segments: std.ArrayList(Segment) = .empty;
    defer flash_segments.deinit(allocator);
    defer for (flash_segments.items) |segment| {
        segment.deinit(allocator);
    };

    var ram_segments: std.ArrayList(Segment) = .empty;
    defer ram_segments.deinit(allocator);
    defer for (ram_segments.items) |segment| {
        segment.deinit(allocator);
    };

    {
        var info_list: std.ArrayList(SegmentInfo) = .empty;
        defer info_list.deinit(allocator);

        if (use_segments) {
            var it = elf_header.iterateProgramHeaders(&elf_file_reader);
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
            var it = elf_header.iterateSectionHeaders(&elf_file_reader);
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
            std.log.err("no segments found in elf", .{});
            return error.NoSegments;
        }
        std.sort.insertion(SegmentInfo, info_list.items, {}, SegmentInfo.less_than);

        for (info_list.items) |segment_info| {
            if ((chip.irom_map_start <= segment_info.addr and segment_info.addr < chip.irom_map_end) or
                (chip.drom_map_start <= segment_info.addr and segment_info.addr < chip.drom_map_end))
            {
                try flash_segments.append(allocator, try .init(allocator, segment_info, &elf_file_reader));
            } else {
                try ram_segments.append(allocator, try .init(allocator, segment_info, &elf_file_reader));
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

    if (flash_segments.items.len > 0) {
        var reader: std.Io.Reader = .fixed(flash_segments.items[0].data);
        var app_desc: AppDesc = try reader.takeStruct(AppDesc, .little);

        if (app_desc.magic == AppDesc.MAGIC) {
            // should we modify the app_desc (apart from the elf sha256)?
            std.log.debug("detected app_desc... we shall modify it", .{});

            var writer: std.Io.Writer = .fixed(flash_segments.items[0].data);
            // TODO: override time and date
            app_desc.min_efuse_blk_rev_full = min_rev;
            app_desc.max_efuse_blk_rev_full = max_rev;
            app_desc.mmu_page_size = @intFromEnum(flash_mmu_page_size);
            app_desc.app_elf_sha256 = elf_file_hash;
            try writer.writeStruct(app_desc, .little);
        }
    }

    var segment_data: std.Io.Writer.Allocating = .init(allocator);
    defer segment_data.deinit();

    var segment_count: u8 = 0;
    var checksum: u8 = CHECKSUM_XOR_BYTE;
    {
        for (flash_segments.items) |*segment| {
            while (segment.get_flash_align_padding_len(segment_data.writer.end + IMAGE_HEADER_LEN, flash_mmu_page_size)) |pad_len| {
                if (ram_segments.items.len > 0 and pad_len > SEGMENT_HEADER_LEN) {
                    const ram_seg = &ram_segments.items[ram_segments.items.len - 1];
                    try ram_seg.write_to(allocator, &segment_data.writer, pad_len, &checksum);
                    if (ram_seg.size == 0) {
                        ram_segments.items.len -= 1;
                    }
                } else {
                    var padding_seg: Segment = try .init_padding(allocator, pad_len);
                    defer padding_seg.deinit(allocator);
                    try padding_seg.write_to(allocator, &segment_data.writer, null, &checksum);
                }
                segment_count += 1;
            }

            try segment.write_to(allocator, &segment_data.writer, null, &checksum);
            segment_count += 1;
        }

        for (ram_segments.items) |*segment| {
            try segment.write_to(allocator, &segment_data.writer, null, &checksum);
            segment_count += 1;
        }
    }

    const output_file = try std.fs.cwd().createFile(output_path, .{});
    defer output_file.close();
    var output_file_writer = output_file.writer(&.{});

    var sha256_hasher = output_file_writer.interface.hashed(Sha256.init(.{}), &output_writer_buf);

    const file_header: FileHeader = .{
        .number_of_segments = segment_count,
        .flash_mode = flash_mode,
        .flash_size = flash_size,
        .flash_freq = flash_freq,
        .entry_point = entry_point,
    };

    const extended_file_header: ExtendedFileHeader = .{
        .wp = .disabled,
        .flash_pins_drive_settings = 0, // TODO: figure out what to set this to
        .chip_id = chip_id,
        .min_rev = min_rev,
        .max_rev = max_rev,
        .hash = !no_digest,
    };

    try file_header.write_to(&sha256_hasher.writer);
    try extended_file_header.write_to(&sha256_hasher.writer);

    try sha256_hasher.writer.writeAll(segment_data.written());

    // TODO: Add secure boot option (v1 or v2) and append a signature if enabled.

    try sha256_hasher.writer.flush(); // flush before getting the position
    try sha256_hasher.writer.splatByteAll(0, 15 - output_file_writer.pos % 16);
    try sha256_hasher.writer.writeByte(checksum);

    try sha256_hasher.writer.flush();

    if (!no_digest) {
        try output_file_writer.interface.writeAll(&sha256_hasher.hasher.finalResult());
        try output_file_writer.interface.flush();
    }
}

fn do_segment_merge(allocator: std.mem.Allocator, segment_list: *std.ArrayList(Segment)) !void {
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

pub const SEGMENT_HEADER_LEN = 0x8;
pub const IMAGE_HEADER_LEN = 0x18;
pub const CHECKSUM_XOR_BYTE = 0xEF;
pub const DEFAULT_FLASH_MMU_PAGE_SIZE: FlashMMU_PageSize = .@"64k";

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

pub const FlashMMU_PageSize = enum(u8) {
    @"8k" = 13,
    @"16k" = 14,
    @"32k" = 15,
    @"64k" = 16,

    pub fn in_bytes(self: FlashMMU_PageSize) usize {
        return @as(usize, 1) << @intCast(@intFromEnum(self));
    }
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
    supported_flash_mmu_page_sizes: ?[]const FlashMMU_PageSize = null,
};

const FileHeader = struct {
    number_of_segments: u8,
    flash_mode: FlashMode,
    flash_size: FlashSize,
    flash_freq: FlashFreq,
    entry_point: u32,

    pub fn write_to(self: FileHeader, writer: *std.Io.Writer) !void {
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

    pub fn write_to(self: ExtendedFileHeader, writer: *std.Io.Writer) !void {
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

    pub fn less_than(_: void, lhs: SegmentInfo, rhs: SegmentInfo) bool {
        return lhs.addr < rhs.addr;
    }
};

const Segment = struct {
    addr: usize,
    size: usize,
    data: []u8,

    pub fn init(allocator: std.mem.Allocator, segment_info: SegmentInfo, elf_file_reader: *std.fs.File.Reader) !Segment {
        try elf_file_reader.seekTo(segment_info.file_offset);

        const data = try allocator.alloc(u8, segment_info.size + segment_info.size % 4);
        errdefer allocator.free(data);

        try elf_file_reader.interface.readSliceAll(data[0..segment_info.size]);
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

    pub fn get_flash_align_padding_len(self: Segment, file_pos: usize, flash_mmu_page_size: FlashMMU_PageSize) ?usize {
        const align_to = flash_mmu_page_size.in_bytes();

        const align_past: i32 = @as(i32, @intCast(self.addr % align_to)) - SEGMENT_HEADER_LEN;
        var pad_len: i32 = align_past + @as(i32, @intCast(align_to - file_pos % align_to));
        if (pad_len == 0 or pad_len == align_to) {
            return null;
        }

        pad_len -= SEGMENT_HEADER_LEN;
        if (pad_len < 0) {
            pad_len += @intCast(align_to);
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

    var segment_list: std.ArrayList(Segment) = .empty;
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

    var segment_data: std.ArrayList(u8) = .empty;
    defer segment_data.deinit(allocator);
    const writer = segment_data.writer(allocator);

    var checksum: u8 = CHECKSUM_XOR_BYTE;
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
