const std = @import("std");
const testing = std.testing;
const assert = std.debug.assert;
const Allocator = std.mem.Allocator;

pub const FamilyId = @import("family_id.zig").FamilyId;

const prog_page_size = 256;
const uf2_alignment = 4;

pub const Options = struct {
    // TODO: when implemented set to true by default
    bundle_source: bool = false,
    family_id: ?FamilyId = null,
};

pub const Archive = struct {
    allocator: Allocator,
    blocks: std.ArrayList(Block),
    families: std.AutoArrayHashMapUnmanaged(FamilyId, void),
    // TODO: keep track of contained files

    const Self = @This();

    pub fn init(allocator: std.mem.Allocator) Archive {
        return .{
            .allocator = allocator,
            .blocks = .empty,
            .families = .empty,
        };
    }

    pub fn deinit(self: *Self) void {
        self.blocks.deinit(self.allocator);
        self.families.deinit(self.allocator);
    }

    /// Reads UF2 blocks from a reader. Reader buffer size must be at least 512
    /// bytes.
    pub fn read_from(self: *Self, reader: *std.Io.Reader) !void {
        while (reader.takeStruct(Block, .little)) |block| {
            if (block.flags.family_id_present) {
                const family_id = block.file_size_or_family_id.family_id;
                try self.families.put(self.allocator, family_id, {});
            }
            try self.blocks.append(self.allocator, block);
        } else |err| switch (err) {
            error.EndOfStream => {},
            else => return err,
        }
    }

    pub fn write_to(self: *Self, writer: *std.Io.Writer) !void {
        for (self.blocks.items, 0..) |*block, i| {
            block.block_number = @as(u32, @intCast(i));
            block.total_blocks = @as(u32, @intCast(self.blocks.items.len));
            try writer.writeStruct(block.*, .little);
        }
        try writer.flush();
    }

    pub fn add_elf(self: *Self, reader: *std.fs.File.Reader, opts: Options) !void {
        // TODO: ensures this reports an error if there is a collision
        if (opts.family_id) |family_id|
            try self.families.putNoClobber(self.allocator, family_id, {});

        const Segment = struct {
            addr: u32,
            file_offset: u32,
            size: u32,

            fn less_than(_: void, lhs: @This(), rhs: @This()) bool {
                return lhs.addr < rhs.addr;
            }
        };

        var segments: std.ArrayList(Segment) = .empty;
        defer segments.deinit(self.allocator);

        const header = try std.elf.Header.read(&reader.interface);
        var it = header.iterateProgramHeaders(reader);
        while (try it.next()) |prog_hdr|
            if (prog_hdr.p_type == std.elf.PT_LOAD and prog_hdr.p_memsz > 0 and prog_hdr.p_filesz > 0) {
                std.log.debug("segment: {}", .{prog_hdr});
                try segments.append(self.allocator, .{
                    .addr = @as(u32, @intCast(prog_hdr.p_paddr)),
                    .file_offset = @as(u32, @intCast(prog_hdr.p_offset)),
                    .size = @as(u32, @intCast(prog_hdr.p_memsz)),
                });
            };

        if (segments.items.len == 0)
            return error.NoSegments;

        std.sort.insertion(Segment, segments.items, {}, Segment.less_than);
        // TODO: check for overlaps, assert no zero sized segments

        var first = true;
        for (segments.items) |segment| {
            var segment_offset: u32 = 0;
            while (segment_offset < segment.size) {
                const addr = segment.addr + segment_offset;
                if (first or addr >= self.blocks.items[self.blocks.items.len - 1].target_addr + prog_page_size) {
                    try self.blocks.append(self.allocator, .{
                        .flags = .{
                            .not_main_flash = false,
                            .file_container = false,
                            .family_id_present = opts.family_id != null,
                            .md5_checksum_present = false,
                            .extension_tags_present = false,
                        },
                        .target_addr = std.mem.alignBackward(u32, addr, prog_page_size),
                        .payload_size = prog_page_size,
                        .block_number = undefined,
                        .total_blocks = undefined,
                        .file_size_or_family_id = .{
                            .family_id = if (opts.family_id) |family_id|
                                family_id
                            else
                                @as(FamilyId, @enumFromInt(0)),
                        },
                        .data = @splat(0),
                    });
                    first = false;
                }

                const block = &self.blocks.items[self.blocks.items.len - 1];
                const block_offset = addr - block.target_addr;
                const n_bytes = @min(prog_page_size - block_offset, segment.size - segment_offset);

                try reader.seekTo(segment.file_offset + segment_offset);
                try reader.interface.readSliceAll(block.data[block_offset..][0..n_bytes]);

                segment_offset += n_bytes;
            }
        }

        if (opts.bundle_source)
            @panic("TODO: bundle source in UF2 file");
    }

    pub fn add_file(self: *Self, path: []const u8) !void {
        const file = if (std.fs.path.isAbsolute(path))
            try std.fs.openFileAbsolute(path, .{})
        else
            try std.fs.cwd().openFile(path, .{});
        defer file.close();

        const file_size = (try file.metadata()).size();

        var path_pos: u32 = 0;

        var target_addr: u32 = 0;
        while (true) {
            try self.blocks.append(self.allocator, .{
                .flags = .{
                    .not_main_flash = true,
                    .file_container = true,
                    .family_id_present = false,
                    .md5_checksum_present = false,
                    .extension_tags_present = false,
                },
                .target_addr = target_addr,
                .payload_size = 0,
                .block_number = undefined,
                .total_blocks = undefined,
                .file_size_or_family_id = .{
                    .file_size = file_size,
                },
                .data = undefined,
            });
            errdefer _ = self.blocks.pop();

            const block = &self.blocks.items[self.blocks.len - 1];
            if (target_addr < file_size) {
                // copying file content into block
                const n_read = file.reader().readAll(&block.data) catch |err| switch (err) {
                    error.EndOfStream => 0,
                    else => return err,
                };

                target_addr += n_read;
                block.payload_size = n_read;
                if (n_read != @sizeOf(block.data)) {
                    std.mem.copy(u8, block.data[n_read..], path);
                    path_pos = @min(block.len - n_read, path.len);
                    if (n_read + path_pos < block.data.len) {
                        // write null terminator too and we're done
                        block.data[n_read + path_pos] = 0;
                        break;
                    }
                }
            } else {
                // copying null terminated path into block, likely crossing a
                // block boundary
                std.mem.copy(u8, &block.data, path[path_pos..]);
                const n_copied = @min(block.data.len, path[path_pos..].len);
                path_pos += n_copied;
                if (n_copied < block.data.len) {
                    // write null terminator and peace out
                    block.data[n_copied] = 0;
                    break;
                }
            }
        }
    }
};

pub const Flags = packed struct(u32) {
    not_main_flash: bool,
    reserved: u11 = 0,
    file_container: bool,
    family_id_present: bool,
    md5_checksum_present: bool,
    extension_tags_present: bool,
    padding: u16 = 0,
};

const first_magic = 0x0a324655;
const second_magic = 0x9e5d5157;
const last_magic = 0x0ab16f30;

pub const Block = extern struct {
    magic_start1: u32 = first_magic,
    magic_start2: u32 = second_magic,
    flags: Flags,
    target_addr: u32,
    payload_size: u32,
    block_number: u32,
    total_blocks: u32,
    file_size_or_family_id: extern union {
        file_size: u32,
        /// From uf2 documentation:
        ///
        /// > It is recommended that new bootloaders require the field to be
        ///   set appropriately, and refuse to flash UF2 files without it
        ///
        /// So if your chip is not in the official list, then PR it or don't
        /// follow this recommendation in your bootloader
        family_id: FamilyId,
    },
    data: [476]u8,
    magic_end: u32 = last_magic,

    comptime {
        assert(512 == @sizeOf(Block));
    }
};
