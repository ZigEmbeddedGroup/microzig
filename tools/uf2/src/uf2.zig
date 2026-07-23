const std = @import("std");
const assert = std.debug.assert;
const Allocator = std.mem.Allocator;

pub const FamilyId = @import("family_id.zig").FamilyId;

const prog_page_size = 256;

pub const FileEntry = struct {
    name: []const u8,
    start_block: u64,
    end_block: u64,
    family_id: ?FamilyId,
};

pub const Archive = struct {
    allocator: Allocator,
    io: std.Io,
    blocks: std.ArrayList(Block),
    families: std.AutoArrayHashMapUnmanaged(FamilyId, void),
    files: std.ArrayList(FileEntry),

    // TODO: keep track of contained files

    pub fn init(allocator: std.mem.Allocator, io: std.Io) Archive {
        return .{ .allocator = allocator, .blocks = .empty, .families = .empty, .files = .empty, .io = io };
    }

    pub fn deinit(self: *Archive) void {
        self.blocks.deinit(self.allocator);
        self.families.deinit(self.allocator);
        //free file name at line 236
        for (self.files.items) |*file| {
            self.allocator.free(file.name);
        }
        self.files.deinit(self.allocator);
    }

    pub fn write_to(self: *Archive, writer: *std.Io.Writer) !void {
        for (self.blocks.items, 0..) |*block, i| {
            block.block_number = @as(u32, @intCast(i));
            block.total_blocks = @as(u32, @intCast(self.blocks.items.len));
            try writer.writeStruct(block.*, .little);
        }
        try writer.flush();
    }

    pub const ReadFromOptions = struct {
        /// If true, checks if any new block has a family_id already present in
        /// the archive.
        check_family_id_collision: bool = true,
    };

    /// Reads UF2 blocks from a reader. Reader buffer size must be at least 512
    /// bytes.
    pub fn read_from(self: *Archive, reader: *std.Io.Reader, options: ReadFromOptions) !void {
        var new_family_ids: std.AutoArrayHashMapUnmanaged(FamilyId, void) = .empty;
        defer new_family_ids.deinit(self.allocator);

        while (reader.takeStruct(Block, .little)) |block| {
            if (block.flags.family_id_present) {
                const family_id = block.file_size_or_family_id.family_id;

                // Check if family id is already present in the archive
                if (try new_family_ids.fetchPut(self.allocator, family_id, {}) == null and
                    try self.families.fetchPut(self.allocator, family_id, {}) != null)
                {
                    if (options.check_family_id_collision) {
                        return error.FamilyIdCollision;
                    }
                }
            }

            try self.blocks.append(self.allocator, block);
        } else |err| switch (err) {
            error.EndOfStream => {},
            else => return err,
        }
    }

    pub const ELF_Options = struct {
        // TODO: when implemented set to true by default
        bundle_source: bool = false,
        family_id: ?FamilyId = null,
    };

    /// Adds an elf to the archive. Returns error if the family id (if
    /// specified) is already present in the archive.
    pub fn add_elf(self: *Archive, reader: *std.Io.File.Reader, opts: ELF_Options) !void {
        if (opts.family_id) |family_id|
            if (try self.families.fetchPut(self.allocator, family_id, {}) != null)
                return error.FamilyIdCollision;

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
                                @as(FamilyId, @enumFromInt(@as(u32, 0))),
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

    pub fn add_file(self: *Archive, path: []const u8) !void {
        if (self.has_file(path)) return error.FileAlreadyAdded;
        const file = if (std.fs.path.isAbsolute(path))
            try std.Io.Dir.openFileAbsolute(self.io, path, .{})
        else
            try std.Io.Dir.cwd().openFile(self.io, path, .{});
        defer file.close(self.io);

        const file_size = @as(u32, @intCast((try file.stat(self.io)).size));
        const start_block = @as(u32, @intCast(self.blocks.items.len));

        var path_pos: u32 = 0;

        var target_addr: u32 = 0;
        var read_buf: [512]u8 = undefined;
        var reader = file.reader(self.io, &read_buf);
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

            const block = &self.blocks.items[self.blocks.items.len - 1];
            if (target_addr < file_size) {
                // copying file content into block
                const n_read = try reader.interface.readSliceShort(block.data[0..]);
                target_addr += @as(u32, @intCast(n_read));
                block.payload_size = @as(u32, @intCast(n_read));
                if (n_read != block.data.len) {
                    if (n_read < block.data.len) {
                        const copy_len = @min(block.data.len - n_read, path.len);
                        path_pos = @intCast(copy_len);
                        @memcpy(block.data[n_read..][0..copy_len], path[0..copy_len]);
                        if (n_read + copy_len < block.data.len) {
                            block.data[n_read + copy_len] = 0;
                            break;
                        }
                    }
                }
            } else {
                // 文件已读完，只复制剩余的路径
                const copy_len = @min(block.data.len, path.len - path_pos);
                @memcpy(block.data[0..copy_len], path[path_pos..][0..copy_len]);
                path_pos += @intCast(copy_len);
                if (copy_len < block.data.len) {
                    block.data[copy_len] = 0;
                    break;
                }
            }
        }
        // add file record
        try self.files.append(self.allocator, .{
            .name = try self.allocator.dupe(u8, path),
            .start_block = start_block,
            .end_block = @as(u32, @intCast(self.blocks.items.len)),
            .family_id = null,
        });
    }

    pub fn get_files(self: *const Archive) []const FileEntry {
        return self.files.items;
    }

    pub fn has_file(self: *const Archive, name: []const u8) bool {
        for (self.files.items) |file| {
            if (std.mem.eql(u8, file.name, name)) {
                return true;
            }
        }
        return false;
    }

    pub fn get_file(self: *const Archive, name: []const u8) ?FileEntry {
        for (self.files.items) |file| {
            if (std.mem.eql(u8, file.name, name)) {
                return file;
            }
        }
        return null;
    }

    pub fn get_file_blocks(self: *const Archive, file_index: usize) ?struct { start: u64, end: u64 } {
        if (file_index >= self.files.items.len) return null;
        const file = self.files.items[file_index];
        return .{
            .start = file.start_block,
            .end = file.end_block,
        };
    }

    pub fn print_files(self: *const Archive) void {
        std.log.info("Archive contains {d} files:", .{self.files.items.len});
        for (self.files.items, 0..) |file, i| {
            const blocks = file.end_block - file.start_block;
            std.log.info("  [{d}] {s}: {d} blocks", .{ i, file.name, blocks });
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

test "Archive read and write" {
    const data_1_block_1: Block = .{
        .flags = .{
            .not_main_flash = false,
            .file_container = false,
            .family_id_present = true,
            .md5_checksum_present = false,
            .extension_tags_present = false,
        },
        .target_addr = 0x10000000,
        .payload_size = prog_page_size,
        .block_number = undefined,
        .total_blocks = undefined,
        .file_size_or_family_id = .{
            .family_id = .RP2040,
        },
        .data = @splat(0),
    };
    const data_1_block_2: Block = .{
        .flags = .{
            .not_main_flash = false,
            .file_container = false,
            .family_id_present = true,
            .md5_checksum_present = false,
            .extension_tags_present = false,
        },
        .target_addr = 0x10000000,
        .payload_size = prog_page_size,
        .block_number = undefined,
        .total_blocks = undefined,
        .file_size_or_family_id = .{
            .family_id = .RP2350_ARM_S,
        },
        .data = @splat(0),
    };
    const data_2_block_1: Block = .{
        .flags = .{
            .not_main_flash = false,
            .file_container = false,
            .family_id_present = true,
            .md5_checksum_present = false,
            .extension_tags_present = false,
        },
        .target_addr = 0x10000100,
        .payload_size = prog_page_size,
        .block_number = 1,
        .total_blocks = 2,
        .file_size_or_family_id = .{
            .family_id = .RP2350_ARM_S,
        },
        .data = @splat(0),
    };

    var data_1: std.Io.Writer.Allocating = .init(std.testing.allocator);
    defer data_1.deinit();
    try data_1.writer.writeStruct(data_1_block_1, .little);
    try data_1.writer.writeStruct(data_1_block_2, .little);

    var data_2: std.Io.Writer.Allocating = .init(std.testing.allocator);
    defer data_2.deinit();
    try data_2.writer.writeStruct(data_2_block_1, .little);

    var data_1_reader: std.Io.Reader = .fixed(data_1.written());

    var archive = Archive.init(std.testing.allocator, std.testing.io);
    defer archive.deinit();

    try archive.read_from(&data_1_reader, .{});

    var output: std.Io.Writer.Allocating = .init(std.testing.allocator);
    defer output.deinit();

    try archive.write_to(&output.writer);

    try std.testing.expectEqualSlices(FamilyId, archive.families.keys(), &.{ .RP2040, .RP2350_ARM_S });

    // these are set by write_to
    std.mem.writeInt(u32, data_1.written()[@offsetOf(Block, "block_number")..][0..4], 0, .little);
    std.mem.writeInt(u32, data_1.written()[@offsetOf(Block, "total_blocks")..][0..4], 2, .little);
    std.mem.writeInt(u32, data_1.written()[@sizeOf(Block)..][@offsetOf(Block, "block_number")..][0..4], 1, .little);
    std.mem.writeInt(u32, data_1.written()[@sizeOf(Block)..][@offsetOf(Block, "total_blocks")..][0..4], 2, .little);
    try std.testing.expectEqualSlices(u8, data_1.written(), output.written());

    // test name collisions
    var data_2_reader: std.Io.Reader = .fixed(data_2.written());
    try std.testing.expectError(error.FamilyIdCollision, archive.read_from(&data_2_reader, .{}));
}
test "File tracking" {
    const allocator = std.testing.allocator;
    const io = std.testing.io;
    var archive = Archive.init(allocator, io);
    defer archive.deinit();

    // 创建临时测试文件
    {
        var file = try std.Io.Dir.cwd().createFile(io, "test1.uf2", .{});
        defer file.close(io);
        // 写入一些数据 先至少一个 block，然后再写入更多数据。
        var buf: [512]u8 = @splat(0);
        var writer_buf: [512]u8 = undefined;
        var writer = file.writer(io, &writer_buf);
        try writer.interface.writeAll(&buf);
        try writer.flush();
    }
    defer std.Io.Dir.cwd().deleteFile(io, "test1.uf2") catch {};

    {
        var file = try std.Io.Dir.cwd().createFile(io, "test2.uf2", .{});
        defer file.close(io);
        var buf: [512]u8 = @splat(0);
        var writer_buf: [512]u8 = undefined;
        var writer = file.writer(io, &writer_buf);
        try writer.interface.writeAll(&buf);
        try writer.flush();
    }
    defer std.Io.Dir.cwd().deleteFile(io, "test2.uf2") catch {};

    // 添加测试文件
    try archive.add_file("test1.uf2");
    try archive.add_file("test2.uf2");

    // 验证文件记录
    try std.testing.expectEqual(@as(usize, 2), archive.files.items.len);
    try std.testing.expectEqualStrings("test1.uf2", archive.files.items[0].name);
    try std.testing.expectEqualStrings("test2.uf2", archive.files.items[1].name);

    // 验证 block 范围
    const file1_blocks = archive.get_file_blocks(0).?;
    try std.testing.expect(file1_blocks.start < file1_blocks.end);

    // 测试重复检测
    try std.testing.expectError(error.FileAlreadyAdded, archive.add_file("test1.uf2"));

    // 测试 has_file
    try std.testing.expect(archive.has_file("test1.uf2"));
    try std.testing.expect(!archive.has_file("test3.uf2"));
}
test "File tracking comprehensive" {
    const allocator = std.testing.allocator;
    const io = std.testing.io;
    var archive = Archive.init(allocator, io);
    defer archive.deinit();

    // 创建测试文件
    {
        var file = try std.Io.Dir.cwd().createFile(io, "test1.uf2", .{});
        defer file.close(io);
        // 写入超过 476 字节（触发多 block）
        var buf: [1024]u8 = @splat(0x41); // 全部填 'A'
        var writer_buf: [1024]u8 = undefined;
        var writer = file.writer(io, &writer_buf);
        try writer.interface.writeAll(&buf);
        try writer.flush();
    }
    defer std.Io.Dir.cwd().deleteFile(io, "test1.uf2") catch {};

    {
        var file = try std.Io.Dir.cwd().createFile(io, "test2.uf2", .{});
        defer file.close(io);
        var buf: [512]u8 = @splat(0x42); // 全部填 'B'
        var writer_buf: [512]u8 = undefined;
        var writer = file.writer(io, &writer_buf);
        try writer.interface.writeAll(&buf);
        try writer.flush();
    }
    defer std.Io.Dir.cwd().deleteFile(io, "test2.uf2") catch {};

    // 测试 1: 添加文件
    try archive.add_file("test1.uf2");
    try archive.add_file("test2.uf2");
    try std.testing.expectEqual(@as(usize, 2), archive.files.items.len);

    // 测试 2: 验证 block 范围不重叠
    const file1 = archive.get_file_blocks(0).?;
    const file2 = archive.get_file_blocks(1).?;
    try std.testing.expect(file1.end <= file2.start);

    // 测试 3: 验证 block 数据
    const block0 = archive.blocks.items[file1.start];
    try std.testing.expectEqual(@as(u8, 0x41), block0.data[0]); // 文件1的数据
    if (block0.payload_size < block0.data.len) {
        try std.testing.expectEqual(@as(u8, 0), block0.data[block0.payload_size]); // null terminator
    }

    // 测试 4: 重复检测
    try std.testing.expectError(error.FileAlreadyAdded, archive.add_file("test1.uf2"));

    // 测试 5: has_file
    try std.testing.expect(archive.has_file("test1.uf2"));
    try std.testing.expect(!archive.has_file("nonexistent.uf2"));

    // 测试 6: get_files
    const files = archive.get_files();
    try std.testing.expectEqual(@as(usize, 2), files.len);
    try std.testing.expectEqualStrings("test1.uf2", files[0].name);
}

test "File tracking - deinit cleanup" {
    const allocator = std.testing.allocator;
    const io = std.testing.io;
    var archive = Archive.init(allocator, io);

    // 添加文件
    {
        var file = try std.Io.Dir.cwd().createFile(io, "cleanup_test.uf2", .{});
        defer file.close(io);
        var buf: [512]u8 = @splat(0);
        var writer_buf: [512]u8 = undefined;
        var writer = file.writer(io, &writer_buf);
        try writer.interface.writeAll(&buf);
        try writer.flush();
    }
    defer std.Io.Dir.cwd().deleteFile(io, "cleanup_test.uf2") catch {};

    try archive.add_file("cleanup_test.uf2");
    try std.testing.expectEqual(@as(usize, 1), archive.files.items.len);

    // deinit 应该释放所有内存
    archive.deinit();

    // 重新初始化验证没有内存泄漏
    var archive2 = Archive.init(allocator, io);
    defer archive2.deinit();
    try std.testing.expectEqual(@as(usize, 0), archive2.files.items.len);
}

test "File tracking - long path" {
    const allocator = std.testing.allocator;
    const io = std.testing.io;
    var archive = Archive.init(allocator, io);
    defer archive.deinit();

    // 创建一个长路径文件名（超过 block 容量）
    const long_name = "very_long_filename_that_should_exceed_block_capacity.uf2";
    {
        var file = try std.Io.Dir.cwd().createFile(io, long_name, .{});
        defer file.close(io);
        var buf: [256]u8 = @splat(0);
        var writer_buf: [256]u8 = undefined;
        var writer = file.writer(io, &writer_buf);
        try writer.interface.writeAll(&buf);
        try writer.flush();
    }
    defer std.Io.Dir.cwd().deleteFile(io, long_name) catch {};

    try archive.add_file(long_name);
    try std.testing.expectEqual(@as(usize, 1), archive.files.items.len);
    try std.testing.expectEqualStrings(long_name, archive.files.items[0].name);
}
