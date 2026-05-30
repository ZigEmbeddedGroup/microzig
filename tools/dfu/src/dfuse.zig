const std = @import("std");
const assert = std.debug.assert;
const dfu = @import("dfu.zig");
const Allocator = std.mem.Allocator;
pub const Options = dfu.Options;

const dfuse_prefix_size: u32 = 11;
const target_prefix_size: u32 = 274;
const element_header_size: u32 = 8;

const Prefix = struct {
    signature: [5]u8 = "DfuSe".*,
    version: u8 = 0x01,
    dfu_image_size: u32,
    targets_count: u8,

    pub fn write_to(self: *const Prefix, writer: *std.Io.Writer) !void {
        try writer.writeAll(&self.signature);
        try writer.writeByte(self.version);
        try writer.writeInt(u32, self.dfu_image_size, .little);
        try writer.writeByte(self.targets_count);
    }
};

const TargetPrefix = struct {
    signature: [6]u8 = "Target".*,
    alternate_setting: u8 = 0,
    is_named: bool = false,
    name: [255]u8 = @splat(0),
    size: u32,
    elements_count: u32,

    pub fn write_to(self: *const TargetPrefix, writer: *std.Io.Writer) !void {
        try writer.writeAll(&self.signature);
        try writer.writeByte(self.alternate_setting);
        try writer.writeInt(u32, @intFromBool(self.is_named), .little);
        try writer.writeAll(&self.name);
        try writer.writeInt(u32, self.size, .little);
        try writer.writeInt(u32, self.elements_count, .little);
    }
};

const ElementHeader = struct {
    address: u32,
    size: u32,

    pub fn write_to(self: *const ElementHeader, writer: *std.Io.Writer) !void {
        try writer.writeInt(u32, self.address, .little);
        try writer.writeInt(u32, self.size, .little);
    }
};

const ElementRange = struct {
    start_addr: u32,
    end_addr: u32,
    segment_start_index: usize,
    segment_end_index: usize,

    fn size(self: ElementRange) u32 {
        return self.end_addr - self.start_addr;
    }
};

/// Iterates over sorted segments and merges touching address ranges.
/// Each yielded range maps to one DfuSe element and carries both the merged
/// address span and the source segment index interval.
const ElementRangeIterator = struct {
    segments: []const Segment,
    index: usize = 0,

    fn init(segments: []const Segment) ElementRangeIterator {
        return .{ .segments = segments };
    }

    fn next(self: *ElementRangeIterator) ?ElementRange {
        if (self.index >= self.segments.len) return null;

        const segment_start_index = self.index;
        assert(self.segments[self.index].size > 0);
        const start_addr = self.segments[self.index].address;
        var end_addr = start_addr + self.segments[self.index].size;

        self.index += 1;
        while (self.index < self.segments.len and self.segments[self.index].address <= end_addr) : (self.index += 1) {
            assert(self.segments[self.index].size > 0);
            end_addr = @max(end_addr, self.segments[self.index].address + self.segments[self.index].size);
        }

        return .{
            .start_addr = start_addr,
            .end_addr = end_addr,
            .segment_start_index = segment_start_index,
            .segment_end_index = self.index,
        };
    }
};

const Segment = struct {
    address: u32,
    file_offset: u64,
    size: u32,

    pub fn less_than(_: void, lhs: @This(), rhs: @This()) bool {
        return lhs.address < rhs.address;
    }
};

/// Convert an ELF file into a single-target DfuSe image.
pub fn from_elf(
    allocator: Allocator,
    reader: *std.fs.File.Reader,
    writer: *std.Io.Writer,
    opts: Options,
) !void {
    var segments: std.ArrayList(Segment) = .empty;
    defer segments.deinit(allocator);

    try collect_segments(allocator, reader, &segments);
    std.sort.insertion(Segment, segments.items, {}, Segment.less_than);

    if (segments.items.len > 0) {
        assert(segments.items[0].size > 0);
        for (segments.items[1..], segments.items[0 .. segments.items.len - 1]) |seg, prev| {
            assert(prev.address <= seg.address);
            assert(seg.size > 0);
        }
    }

    try ensure_no_overlaps(segments.items);

    var buffer: [4096]u8 = undefined;
    var dfu_writer = dfu.DfuWriter.init(writer, &buffer, opts);
    const out = dfu_writer.writer();

    const target_size = calculate_target_size(segments.items);
    const dfu_image_size = dfuse_prefix_size + target_prefix_size + target_size;

    // Currently, we only support a single target
    const targets_count = 1;
    const prefix: Prefix = .{
        .dfu_image_size = dfu_image_size,
        .targets_count = targets_count,
    };
    try prefix.write_to(out);

    const elements_count = count_elements(segments.items);
    const target_prefix: TargetPrefix = .{
        .size = target_size,
        .elements_count = elements_count,
    };
    try target_prefix.write_to(out);

    try write_elements(reader, out, segments.items);
    try dfu_writer.finalize();
}

fn collect_segments(
    allocator: Allocator,
    reader: *std.fs.File.Reader,
    segments: *std.ArrayList(Segment),
) !void {
    const header = try std.elf.Header.read(&reader.interface);

    var it = header.iterateProgramHeaders(reader);
    while (try it.next()) |prog_hdr| {
        if (prog_hdr.p_type != std.elf.PT_LOAD or prog_hdr.p_filesz == 0) continue;

        const address = std.math.cast(u32, prog_hdr.p_paddr) orelse return error.AddressOverflow;
        const size = std.math.cast(u32, prog_hdr.p_filesz) orelse return error.SegmentTooLarge;

        try segments.append(allocator, .{
            .address = address,
            .file_offset = prog_hdr.p_offset,
            .size = size,
        });
    }

    if (segments.items.len == 0) return error.NoLoadableSegments;
}

fn count_elements(segments: []const Segment) u32 {
    var count: u32 = 0;
    var ranges = ElementRangeIterator.init(segments);
    while (ranges.next()) |_| {
        count += 1;
    }
    return count;
}

fn ensure_no_overlaps(segments: []const Segment) !void {
    if (segments.len < 2) return;

    for (segments[0..(segments.len - 1)], segments[1..]) |prev, curr| {
        const prev_end = prev.address + prev.size;
        if (prev_end > curr.address) {
            return error.OverlappingSegments;
        }
    }
}

fn calculate_target_size(segments: []const Segment) u32 {
    var size: u32 = 0;
    var ranges = ElementRangeIterator.init(segments);
    while (ranges.next()) |range| {
        assert(range.size() > 0);
        size += element_header_size + range.size();
    }
    return size;
}

fn write_elements(reader: *std.fs.File.Reader, writer: *std.Io.Writer, segments: []const Segment) !void {
    var ranges = ElementRangeIterator.init(segments);
    while (ranges.next()) |range| {
        const element_size = range.size();
        assert(element_size > 0);

        const elem_header: ElementHeader = .{
            .address = range.start_addr,
            .size = element_size,
        };
        try elem_header.write_to(writer);

        var current_addr = range.start_addr;
        var seg_idx = range.segment_start_index;
        while (seg_idx < range.segment_end_index) : (seg_idx += 1) {
            const seg = segments[seg_idx];

            assert(seg.address == current_addr);
            try reader.seekTo(seg.file_offset);
            try reader.interface.streamExact(writer, seg.size);
            current_addr += seg.size;
        }

        assert(current_addr == range.end_addr);
    }
}
