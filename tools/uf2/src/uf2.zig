const std = @import("std");
const testing = std.testing;
const assert = std.debug.assert;
const LibExeObjStep = std.build.LibExeObjStep;
const Allocator = std.mem.Allocator;
const GeneratedFile = std.build.GeneratedFile;

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
    families: std.AutoHashMap(FamilyId, void),
    // TODO: keep track of contained files

    const Self = @This();

    pub fn init(allocator: std.mem.Allocator) Archive {
        return Self{
            .allocator = allocator,
            .blocks = std.ArrayList(Block).init(allocator),
            .families = std.AutoHashMap(FamilyId, void).init(allocator),
        };
    }

    pub fn deinit(self: *Self) void {
        self.blocks.deinit();
        self.families.deinit();
    }

    pub fn add_elf(self: *Self, path: []const u8, opts: Options) !void {
        // TODO: ensures this reports an error if there is a collision
        if (opts.family_id) |family_id|
            try self.families.putNoClobber(family_id, {});

        const file = try std.fs.cwd().openFile(path, .{});
        defer file.close();

        const Segment = struct {
            addr: u32,
            file_offset: u32,
            size: u32,

            fn lessThan(_: void, lhs: @This(), rhs: @This()) bool {
                return lhs.addr < rhs.addr;
            }
        };

        var segments = std.ArrayList(Segment).init(self.allocator);
        defer segments.deinit();

        const header = try std.elf.Header.read(file);
        var it = header.program_header_iterator(file);
        while (try it.next()) |prog_hdr|
            if (prog_hdr.p_type == std.elf.PT_LOAD and prog_hdr.p_memsz > 0 and prog_hdr.p_filesz > 0) {
                try segments.append(.{
                    .addr = @as(u32, @intCast(prog_hdr.p_paddr)),
                    .file_offset = @as(u32, @intCast(prog_hdr.p_offset)),
                    .size = @as(u32, @intCast(prog_hdr.p_memsz)),
                });
            };

        if (segments.items.len == 0)
            return error.NoSegments;

        std.sort.insertion(Segment, segments.items, {}, Segment.lessThan);
        // TODO: check for overlaps, assert no zero sized segments

        var first = true;
        for (segments.items) |segment| {
            var segment_offset: u32 = 0;
            while (segment_offset < segment.size) {
                const addr = segment.addr + segment_offset;
                if (first or addr >= self.blocks.items[self.blocks.items.len - 1].target_addr + prog_page_size) {
                    try self.blocks.append(.{
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
                        .data = .{0} ** 476,
                    });
                    first = false;
                }

                const block = &self.blocks.items[self.blocks.items.len - 1];
                const block_offset = addr - block.target_addr;
                const n_bytes = @min(prog_page_size - block_offset, segment.size - segment_offset);

                try file.seekTo(segment.file_offset + segment_offset);
                try file.reader().readNoEof(block.data[block_offset..][0..n_bytes]);

                segment_offset += n_bytes;
            }
        }

        if (opts.bundle_source)
            @panic("TODO: bundle source in UF2 file");
    }

    pub fn write_to(self: *Self, writer: anytype) !void {
        for (self.blocks.items, 0..) |*block, i| {
            block.block_number = @as(u32, @intCast(i));
            block.total_blocks = @as(u32, @intCast(self.blocks.items.len));
            try block.write_to(writer);
        }
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
            try self.blocks.append(.{
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

    comptime {
        assert(@sizeOf(Flags) == @sizeOf(u32));
    }
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

    pub fn from_reader(reader: anytype) !Block {
        var block: Block = undefined;
        inline for (std.meta.fields(Block)) |field| {
            switch (field.type) {
                u32 => @field(block, field.name) = try reader.readInt(u32, .little),
                [476]u8 => {
                    const n = try reader.readAll(&@field(block, field.name));
                    if (n != @sizeOf(field.type))
                        return error.EndOfStream;
                },
                else => {
                    assert(4 == @sizeOf(field.type));
                    @field(block, field.name) =
                        @as(field.type, @bitCast(try reader.readInt(u32, .little)));
                },
            }
        }

        return block;
    }

    pub fn write_to(self: Block, writer: anytype) !void {
        inline for (std.meta.fields(Block)) |field| {
            switch (field.type) {
                u32 => try writer.writeInt(u32, @field(self, field.name), .little),
                [476]u8 => try writer.writeAll(&@field(self, field.name)),
                else => {
                    assert(4 == @sizeOf(field.type));
                    try writer.writeInt(
                        u32,
                        @as(u32, @bitCast(@field(self, field.name))),
                        .little,
                    );
                },
            }
        }
    }
};

fn expectEqualBlock(expected: Block, actual: Block) !void {
    try testing.expectEqual(@as(u32, first_magic), actual.magic_start1);
    try testing.expectEqual(expected.magic_start1, actual.magic_start1);
    try testing.expectEqual(@as(u32, second_magic), actual.magic_start2);
    try testing.expectEqual(expected.magic_start2, actual.magic_start2);

    try testing.expectEqual(expected.flags, actual.flags);
    try testing.expectEqual(expected.target_addr, actual.target_addr);
    try testing.expectEqual(expected.payload_size, actual.payload_size);
    try testing.expectEqual(expected.block_number, actual.block_number);
    try testing.expectEqual(expected.total_blocks, actual.total_blocks);
    try testing.expectEqual(
        expected.file_size_or_family_id.file_size,
        actual.file_size_or_family_id.file_size,
    );
    try testing.expectEqual(expected.data, actual.data);

    try testing.expectEqual(@as(u32, last_magic), actual.magic_end);
    try testing.expectEqual(expected.magic_end, actual.magic_end);
}

test "Block loopback" {
    var buf: [512]u8 = undefined;
    var fbs = std.io.fixedBufferStream(&buf);

    var prng = std.rand.DefaultPrng.init(0xf163bfab);
    var rand = prng.random();
    var expected = Block{
        .flags = @as(Flags, @bitCast(rand.int(u32))),
        .target_addr = rand.int(u32),
        .payload_size = rand.int(u32),
        .block_number = rand.int(u32),
        .total_blocks = rand.int(u32),
        .file_size_or_family_id = .{
            .file_size = rand.int(u32),
        },
        .data = undefined,
    };
    rand.bytes(&expected.data);

    try expected.write_to(fbs.writer());

    // needs to be reset for reader
    fbs.reset();
    const actual = try Block.from_reader(fbs.reader());

    try expectEqualBlock(expected, actual);
}

pub const FamilyId = enum(u32) {
    ATMEGA32 = 0x16573617,
    SAML21 = 0x1851780a,
    NRF52 = 0x1b57745f,
    ESP32 = 0x1c5f21b0,
    STM32L1 = 0x1e1f432d,
    STM32L0 = 0x202e3a91,
    STM32WL = 0x21460ff0,
    LPC55 = 0x2abc77ec,
    STM32G0 = 0x300f5633,
    GD32F350 = 0x31d228c6,
    STM32L5 = 0x04240bdf,
    STM32G4 = 0x4c71240a,
    MIMXRT10XX = 0x4fb2d5bd,
    STM32F7 = 0x53b80f00,
    SAMD51 = 0x55114460,
    STM32F4 = 0x57755a57,
    FX2 = 0x5a18069b,
    STM32F2 = 0x5d1a0a2e,
    STM32F1 = 0x5ee21072,
    NRF52833 = 0x621e937a,
    STM32F0 = 0x647824b6,
    SAMD21 = 0x68ed2b88,
    STM32F3 = 0x6b846188,
    STM32F407 = 0x6d0922fa,
    STM32H7 = 0x6db66082,
    STM32WB = 0x70d16653,
    ESP8266 = 0x7eab61ed,
    KL32L2 = 0x7f83e793,
    STM32F407VG = 0x8fb060fe,
    NRF52840 = 0xada52840,
    ESP32S2 = 0xbfdd4eee,
    ESP32S3 = 0xc47e5767,
    ESP32C3 = 0xd42ba06c,
    ESP32C2 = 0x2b88d29c,
    ESP32H2 = 0x332726f6,
    RP2040 = 0xe48bff56,
    STM32L4 = 0x00ff6919,
    GD32VF103 = 0x9af03e33,
    CSK4 = 0x4f6ace52,
    CSK6 = 0x6e7348a8,
    M0SENSE = 0x11de784a,
    _,
};
