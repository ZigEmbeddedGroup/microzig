const std = @import("std");
const Sha256 = std.crypto.hash.sha2.Sha256;
const flags = @import("flags");
const esp_image = @import("esp_image");

const ChipId = esp_image.ChipId;
const FlashFreq = esp_image.FlashFreq;
const FlashMode = esp_image.FlashMode;
const FlashSize = esp_image.FlashSize;
const Flash_MMU_PageSize = esp_image.Flash_MMU_PageSize;

pub const std_options: std.Options = .{
    .log_level = .warn,
};

var elf_file_reader_buf: [1024]u8 = undefined;
var elf_file_hashing_buf: [std.crypto.hash.sha2.Sha256.digest_length]u8 = undefined;
var output_writer_buf: [1024]u8 = undefined;

const CLI_Args = struct {
    help: bool = false,
    output: ?[]const u8 = null,
    chip_id: ?ChipId = null,
    min_rev: u16 = 0x0000,
    max_rev: u16 = 0xFFFF,
    no_digest: bool = false,
    flash_freq: ?FlashFreq = null,
    flash_mode: ?FlashMode = null,
    flash_size: ?FlashSize = null,
    flash_mmu_page_size: ?Flash_MMU_PageSize = null,
    segments: bool = false,

    pub const default: CLI_Args = .{};

    pub const usage =
        \\--help                                     Show this message
        \\--output=<str>                             Path to save the generated file
        \\--chip_id=<ChipId>                         Chip id
        \\--min_rev=<u16>                            Minimal chip revision (in format: major * 100 + minor)
        \\--max_rev=<u16>                            Maximal chip revision (in format: major * 100 + minor)
        \\--no_digest                                Don't append a SHA256 digest of the entire image after the checksum
        \\--flash_freq=<FlashFreq>                   SPI Flash frequency
        \\--flash_mode=<FlashMode>                   SPI Flash mode
        \\--flash_size=<FlashSize>                   SPI Flash size in megabytes
        \\--flash_mmu-page_size=<FlashMMU_PageSize>  Flash MMU page size
        \\--segments                                 Use program headers instead of section headers
        \\<str>
        \\
    ;
};

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    const gpa = init.gpa;
    const args = try init.minimal.args.toSlice(init.arena.allocator());
    const cli_args, const positionals = try flags.parse(CLI_Args, init.arena.allocator(), args);

    var stdout = std.Io.File.stderr().writer(io, &.{});
    if (cli_args.help) {
        try stdout.interface.print("{s}", .{CLI_Args.usage});
        return;
    }

    const elf_path = if (positionals.len > 0) positionals[0] else return error.MissingInputFile;
    const output_path = cli_args.output orelse return error.MissingOutputFile;
    const chip_id = cli_args.chip_id orelse return error.MissingChipId;
    const chip = chips.get(chip_id) orelse {
        std.log.err("support for chip `{s}` is not implemented yet", .{@tagName(chip_id)});
        return error.UnimplementedChip;
    };

    const flash_freq = cli_args.flash_freq orelse return error.MissingFlashFreq;
    const flash_mode = cli_args.flash_mode orelse return error.MissingFlashMode;
    const flash_size = cli_args.flash_size orelse return error.MissingFlashSize;
    var flash_mmu_page_size: Flash_MMU_PageSize = esp_image.DEFAULT_FLASH_MMU_PAGE_SIZE;
    if (cli_args.flash_mmu_page_size) |page_size_override| {
        if (chip.supported_flash_mmu_page_sizes) |supported_flash_mmu_page_sizes| {
            if (std.mem.indexOfScalar(Flash_MMU_PageSize, supported_flash_mmu_page_sizes, page_size_override) != null) {
                flash_mmu_page_size = page_size_override;
            } else {
                std.log.err("flash mmu page size `{t}` is not supported by chip `{t}`... using default `{t}`", .{
                    flash_mmu_page_size,
                    chip_id,
                    esp_image.DEFAULT_FLASH_MMU_PAGE_SIZE,
                });
            }
        }
    }

    const elf_file = try std.Io.Dir.cwd().openFile(io, elf_path, .{});
    defer elf_file.close(io);

    var elf_file_reader = elf_file.reader(io, &elf_file_reader_buf);
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
    defer flash_segments.deinit(gpa);
    defer for (flash_segments.items) |segment| {
        segment.deinit(gpa);
    };

    var ram_segments: std.ArrayList(Segment) = .empty;
    defer ram_segments.deinit(gpa);
    defer for (ram_segments.items) |segment| {
        segment.deinit(gpa);
    };

    {
        var info_list: std.ArrayList(SegmentInfo) = .empty;
        defer info_list.deinit(gpa);

        if (cli_args.segments) {
            var it = elf_header.iterateProgramHeaders(&elf_file_reader);
            while (try it.next()) |hdr| {
                if (hdr.p_type == std.elf.PT_LOAD and hdr.p_memsz > 0 and hdr.p_filesz > 0) {
                    try info_list.append(gpa, .{
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
                    try info_list.append(gpa, .{
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
                try flash_segments.append(gpa, try .init(gpa, segment_info, &elf_file_reader));
            } else {
                try ram_segments.append(gpa, try .init(gpa, segment_info, &elf_file_reader));
            }
        }
    }

    // TODO: move app desc to the start of the image. This is currently done
    // accidentally on esp32c3 because of the memory map (DROM comes before
    // IROM).

    // TODO: maybe also check if sections overlap

    // merge segments
    try do_segment_merge(gpa, &flash_segments);
    try do_segment_merge(gpa, &ram_segments);

    for (flash_segments.items) |segment| {
        std.log.debug("flash segment at addr 0x{x} of size 0x{x}", .{ segment.addr, segment.size });
    }

    for (ram_segments.items) |segment| {
        std.log.debug("ram segment at addr 0x{x} of size 0x{x}", .{ segment.addr, segment.size });
    }

    if (flash_segments.items.len > 0) {
        var reader: std.Io.Reader = .fixed(flash_segments.items[0].data);
        var app_desc: esp_image.AppDesc = try reader.takeStruct(esp_image.AppDesc, .little);

        if (app_desc.magic == esp_image.AppDesc.MAGIC) {
            std.log.debug("detected app_desc... we shall modify it", .{});

            var writer: std.Io.Writer = .fixed(flash_segments.items[0].data);
            // TODO: override time and date
            app_desc.min_efuse_blk_rev_full = cli_args.min_rev;
            app_desc.max_efuse_blk_rev_full = cli_args.max_rev;
            app_desc.mmu_page_size = flash_mmu_page_size;
            app_desc.app_elf_sha256 = elf_file_hash;
            try writer.writeStruct(app_desc, .little);
        }
    }

    var segment_data: std.Io.Writer.Allocating = .init(gpa);
    defer segment_data.deinit();

    var segment_count: u8 = 0;
    var checksum: u8 = esp_image.CHECKSUM_XOR_BYTE;
    {
        for (flash_segments.items) |*segment| {
            while (segment.get_flash_align_padding_len(segment_data.writer.end + esp_image.IMAGE_HEADER_LEN, flash_mmu_page_size)) |pad_len| {
                if (ram_segments.items.len > 0 and pad_len > esp_image.SEGMENT_HEADER_LEN) {
                    const ram_seg = &ram_segments.items[ram_segments.items.len - 1];
                    try ram_seg.write_to(gpa, &segment_data.writer, pad_len, &checksum);
                    if (ram_seg.size == 0) {
                        ram_segments.items.len -= 1;
                    }
                } else {
                    var padding_seg: Segment = try .init_padding(gpa, pad_len);
                    defer padding_seg.deinit(gpa);
                    try padding_seg.write_to(gpa, &segment_data.writer, null, &checksum);
                }
                segment_count += 1;
            }

            try segment.write_to(gpa, &segment_data.writer, null, &checksum);
            segment_count += 1;
        }

        for (ram_segments.items) |*segment| {
            try segment.write_to(gpa, &segment_data.writer, null, &checksum);
            segment_count += 1;
        }
    }

    const output_file = try std.Io.Dir.cwd().createFile(io, output_path, .{});
    defer output_file.close(io);
    var output_file_writer = output_file.writer(io, &.{});

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
        .min_rev = cli_args.min_rev,
        .max_rev = cli_args.max_rev,
        .hash = !cli_args.no_digest,
    };

    try file_header.write_to(&sha256_hasher.writer);
    try extended_file_header.write_to(&sha256_hasher.writer);

    try sha256_hasher.writer.writeAll(segment_data.written());

    // TODO: Add secure boot option (v1 or v2) and append a signature if enabled.

    try sha256_hasher.writer.flush(); // flush before getting the position
    try sha256_hasher.writer.splatByteAll(0, 15 - output_file_writer.pos % 16);
    try sha256_hasher.writer.writeByte(checksum);

    try sha256_hasher.writer.flush();

    if (!cli_args.no_digest) {
        try output_file_writer.interface.writeAll(&sha256_hasher.hasher.finalResult());
        try output_file_writer.interface.flush();
    }
}

fn do_segment_merge(gpa: std.mem.Allocator, segment_list: *std.ArrayList(Segment)) !void {
    if (segment_list.items.len >= 2) {
        var i: usize = segment_list.items.len - 1;
        while (i > 0) : (i -= 1) {
            const seg_a = &segment_list.items[i - 1];
            const seg_b = segment_list.items[i];
            if (seg_a.addr + seg_a.size == seg_b.addr) {
                try seg_a.merge(gpa, seg_b);
                seg_b.deinit(gpa);
                _ = segment_list.orderedRemove(i);
            }
        }
    }
}

pub const chips: std.enums.EnumMap(esp_image.ChipId, Chip) = .init(.{
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
    supported_flash_mmu_page_sizes: ?[]const esp_image.Flash_MMU_PageSize = null,
};

const FileHeader = struct {
    number_of_segments: u8,
    flash_mode: esp_image.FlashMode,
    flash_size: esp_image.FlashSize,
    flash_freq: esp_image.FlashFreq,
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
    chip_id: esp_image.ChipId,
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

    pub fn init(gpa: std.mem.Allocator, segment_info: SegmentInfo, elf_file_reader: *std.Io.File.Reader) !Segment {
        try elf_file_reader.seekTo(segment_info.file_offset);

        const data = try gpa.alloc(u8, segment_info.size + segment_info.size % 4);
        errdefer gpa.free(data);

        try elf_file_reader.interface.readSliceAll(data[0..segment_info.size]);
        @memset(data[segment_info.size..], 0);

        return .{
            .addr = segment_info.addr,
            .size = data.len,
            .data = data,
        };
    }

    pub fn init_padding(gpa: std.mem.Allocator, size: usize) !Segment {
        const data = try gpa.alloc(u8, size);
        errdefer gpa.free(data);
        @memset(data, 0);

        return .{
            .addr = 0,
            .size = size,
            .data = data,
        };
    }

    pub fn deinit(self: Segment, gpa: std.mem.Allocator) void {
        gpa.free(self.data);
    }

    pub fn get_flash_align_padding_len(self: Segment, file_pos: usize, flash_mmu_page_size: Flash_MMU_PageSize) ?usize {
        const align_to = flash_mmu_page_size.in_bytes();

        const align_past: i32 = @as(i32, @intCast(self.addr % align_to)) - esp_image.SEGMENT_HEADER_LEN;
        var pad_len: i32 = align_past + @as(i32, @intCast(align_to - file_pos % align_to));
        if (pad_len == 0 or pad_len == align_to) {
            return null;
        }

        pad_len -= esp_image.SEGMENT_HEADER_LEN;
        if (pad_len < 0) {
            pad_len += @intCast(align_to);
        }
        return @intCast(pad_len);
    }

    pub fn merge(self: *Segment, gpa: std.mem.Allocator, other: Segment) !void {
        std.debug.assert(self.addr + self.size == other.addr);

        const new_size = self.size + other.size;
        self.data = try gpa.realloc(self.data, new_size);
        @memcpy(self.data[self.size..], other.data[0..other.size]);
        self.size = new_size;
    }

    pub fn write_to(self: *Segment, gpa: std.mem.Allocator, writer: anytype, len: ?usize, checksum: *u8) !void {
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
            if (gpa.resize(self.data, remaining_len)) {
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

    try std.testing.expectEqual(segment.get_flash_align_padding_len(0x9900, .@"64k"), 0x6710);
    try std.testing.expectEqual(segment.get_flash_align_padding_len(0xfff8, .@"64k"), 0x18);
    try std.testing.expectEqual(segment.get_flash_align_padding_len(0x10018, .@"64k"), null);
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

    var segment_data: std.Io.Writer.Allocating = .init(std.testing.allocator);
    defer segment_data.deinit();

    const writer = &segment_data.writer;

    var checksum: u8 = esp_image.CHECKSUM_XOR_BYTE;
    try segment.write_to(allocator, writer, 0x10, &checksum);
    try segment.write_to(allocator, writer, null, &checksum);

    try std.testing.expectEqual(std.mem.readInt(u32, writer.buffered()[0..4], .little), 0x42000020);
    try std.testing.expectEqual(std.mem.readInt(u32, writer.buffered()[4..8], .little), 0x10);
    try std.testing.expectEqualStrings(writer.buffered()[8..24], &@as([16]u8, @splat('a')));
    try std.testing.expectEqual(std.mem.readInt(u32, writer.buffered()[24..28], .little), 0x42000030);
    try std.testing.expectEqual(std.mem.readInt(u32, writer.buffered()[28..32], .little), 0x10);
    try std.testing.expectEqualStrings(writer.buffered()[32..48], &@as([16]u8, @splat('a')));
    try std.testing.expectEqual(segment.size, 0);
}
