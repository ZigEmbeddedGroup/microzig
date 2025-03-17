const std = @import("std");
const Sha256 = std.crypto.hash.sha2.Sha256;
const clap = @import("clap");

pub const std_options: std.Options = .{
    .log_level = .debug,
};

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
    const flash_mode: FlashMode = res.args.@"flash-mode" orelse .qio;
    const flash_size: FlashSize = res.args.@"flash-size" orelse .@"4mb";

    const elf_file = try std.fs.cwd().openFile(elf_path, .{});
    defer elf_file.close();
    const elf_header = try std.elf.Header.read(elf_file);

    const output_file = try std.fs.cwd().createFile(output_path, .{});
    defer output_file.close();

    const output_file_writer = output_file.writer();

    var sha256: Sha256 = .init(.{});

    var multi_writer = std.io.multiWriter(.{ output_file_writer, sha256.writer() });
    const multi_writer_writer = multi_writer.writer();

    const entry_point: u32 = @intCast(elf_header.entry);

    var segments: std.ArrayListUnmanaged(Segment) = .empty;
    defer segments.deinit(allocator);
    defer for (segments.items) |segment| {
        segment.deinit(allocator);
    };

    {
        var info_list: std.ArrayListUnmanaged(SegmentInfo) = .empty;
        defer info_list.deinit(allocator);

        var it = elf_header.section_header_iterator(elf_file);
        while (try it.next()) |hdr| {
            if (hdr.sh_size > 0) {
                std.log.debug("segment: {}", .{hdr});
                try info_list.append(allocator, .{
                    .addr = @as(u32, @intCast(hdr.sh_addr)),
                    .file_offset = @as(u32, @intCast(hdr.sh_offset)),
                    .size = @as(u32, @intCast(hdr.sh_size)),
                });
            }
        }

        if (info_list.items.len == 0) {
            return error.NoSegments;
        }
        std.sort.insertion(SegmentInfo, info_list.items, {}, SegmentInfo.lessThan);

        for (info_list.items) |segment_info| {
            try segments.append(allocator, try Segment.init(allocator, segment_info, elf_file));
        }
    }

    const file_header: FileHeader = .{
        .number_of_segments = @intCast(segments.items.len),
        .flash_mode = flash_mode,
        .flash_size = flash_size,
        .flash_freq = flash_freq,
        .entry_point = entry_point,
    };

    const extended_file_header: ExtendedFileHeader = .{
        .wp = .disabled, // TODO: should we make this configurable
        .flash_pins_drive_settings = 0, // TODO: should we make this configurable + packed struct?
        .chip_id = chip_id,
        .min_rev = min_rev,
        .max_rev = max_rev,
        .hash = !no_digest,
    };

    try file_header.write_to(multi_writer_writer);
    try extended_file_header.write_to(multi_writer_writer);

    var checksum: u8 = 0xEF;
    for (segments.items) |segment| {
        try segment.write_to(multi_writer_writer);

        for (segment.data) |byte| {
            checksum ^= byte;
        }
    }

    const position = try output_file.getPos();
    const padding: [16]u8 = @splat(0);
    try multi_writer_writer.writeAll(padding[0 .. 15 - position % 16]);
    try multi_writer_writer.writeByte(checksum);

    if (!no_digest) {
        try output_file_writer.writeAll(&sha256.finalResult());
    }
}

fn get_arg(args: []const []const u8, key: []const u8) !?[]const u8 {
    const key_idx = for (args, 0..) |arg, i| {
        if (std.mem.eql(u8, key, arg))
            break i;
    } else return null;

    if (key_idx >= args.len - 1) {
        std.log.err("missing value for {s}", .{key});
        return error.MissingArgValue;
    }

    const value = args[key_idx + 1];
    if (std.mem.startsWith(u8, value, "--")) {
        std.log.err("missing value for {s}", .{key});
        return error.MissingArgValue;
    }

    return value;
}

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
    esp32s2 = 0x0002,
    esp32c3 = 0x0005,
    esp32s3 = 0x0009,
    esp32c2 = 0x000c,
    esp32c6 = 0x000d,
    esp32h2 = 0x0010,
    esp32p4 = 0x0012,
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
            @intFromEnum(self.flash_size) | @intFromEnum(self.flash_freq),
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
    data: []const u8,

    pub fn init(allocator: std.mem.Allocator, segment_info: SegmentInfo, elf_file: std.fs.File) !Segment {
        try elf_file.seekTo(segment_info.file_offset);

        const data = try allocator.alloc(u8, segment_info.size);
        errdefer allocator.free(data);

        const n = try elf_file.readAll(data);
        if (n != segment_info.size) {
            return error.InvalidSegment;
        }

        return .{
            .addr = segment_info.addr,
            .data = data,
        };
    }

    pub fn deinit(self: Segment, allocator: std.mem.Allocator) void {
        allocator.free(self.data);
    }

    pub fn write_to(self: Segment, writer: anytype) !void {
        try writer.writeInt(u32, @intCast(self.addr), .little);
        try writer.writeInt(u32, @intCast(self.data.len), .little);
        try writer.writeAll(self.data);
    }
};
