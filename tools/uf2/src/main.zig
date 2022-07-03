//! This package is for assembling uf2 files from ELF binaries. This format is
//! used for flashing a microcontroller over a mass storage interface, such as
//! the pi pico.
//!
//! See https://github.com/microsoft/uf2#file-containers for how we're going to
//! embed file source into the format
//!
//! For use in a build.zig:
//!
//! ```zig
//! const uf2_file = uf2.Uf2Step.create(exe, .{});
//! const flash_op = uf2_file.addFlashOperation("/mnt/something");
//! const flash_step = builder.addStep("flash");
//! flash_step.dependOn(&flash_op.step);
//! ```
//!
//! TODO: allow for multiple builds in one archive

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

pub const Uf2Step = struct {
    step: std.build.Step,
    exe: *LibExeObjStep,
    opts: Options,
    output_file: GeneratedFile,

    pub fn create(exe: *LibExeObjStep, opts: Options) *Uf2Step {
        assert(exe.kind == .exe);
        var ret = exe.builder.allocator.create(Uf2Step) catch
            @panic("failed to allocate");
        ret.* = .{
            .step = std.build.Step.init(
                .custom,
                "uf2",
                exe.builder.allocator,
                make,
            ),
            .exe = exe,
            .opts = opts,
            .output_file = .{ .step = &ret.step },
        };

        ret.step.dependOn(&exe.step);
        return ret;
    }

    /// uf2 is typically used to flash via a mass storage device, this step
    /// writes the file contents to the mounted directory
    pub fn addFlashOperation(self: *Uf2Step, path: []const u8) *FlashOpStep {
        return FlashOpStep.create(self, path);
    }

    pub fn install(uf2_step: *Uf2Step) void {
        const builder = uf2_step.exe.builder;
        const name = std.mem.join(builder.allocator, "", &.{ uf2_step.exe.name, ".uf2" }) catch @panic("failed to join");
        const install_step = builder.addInstallFileWithDir(.{
            .generated = &uf2_step.output_file,
        }, .bin, name);
        builder.getInstallStep().dependOn(&uf2_step.step);
        builder.getInstallStep().dependOn(&install_step.step);
    }

    fn make(step: *std.build.Step) !void {
        const uf2_step = @fieldParentPtr(Uf2Step, "step", step);
        const file_source = uf2_step.exe.getOutputSource();
        const exe_path = file_source.getPath(uf2_step.exe.builder);
        const dest_path = try std.mem.join(uf2_step.exe.builder.allocator, "", &.{
            exe_path,
            ".uf2",
        });

        var archive = Archive.init(uf2_step.exe.builder.allocator);
        errdefer archive.deinit();

        try archive.addElf(exe_path, uf2_step.opts);

        const dest_file = try std.fs.cwd().createFile(dest_path, .{});
        defer dest_file.close();

        try archive.writeTo(dest_file.writer());
        uf2_step.output_file.path = dest_path;
    }
};

/// for uf2, a flash op is just copying a file to a directory.
pub const FlashOpStep = struct {
    step: std.build.Step,
    uf2_step: *Uf2Step,
    mass_storage_path: []const u8,

    pub fn create(uf2_step: *Uf2Step, mass_storage_path: []const u8) *FlashOpStep {
        var ret = uf2_step.exe.builder.allocator.create(FlashOpStep) catch
            @panic("failed to allocate flash operation step");
        ret.* = .{
            .step = std.build.Step.init(
                .custom,
                "flash_op",
                uf2_step.exe.builder.allocator,
                make,
            ),
            .uf2_step = uf2_step,
            .mass_storage_path = mass_storage_path,
        };

        ret.step.dependOn(&uf2_step.step);
        return ret;
    }

    fn openMassStorage(self: FlashOpStep) !std.fs.Dir {
        return if (std.fs.path.isAbsolute(self.mass_storage_path))
            try std.fs.openDirAbsolute(self.mass_storage_path, .{})
        else
            try std.fs.cwd().openDir(self.mass_storage_path, .{});
    }

    fn make(step: *std.build.Step) !void {
        const self = @fieldParentPtr(FlashOpStep, "step", step);

        var mass_storage = self.openMassStorage() catch |err| switch (err) {
            error.FileNotFound => {
                std.log.err("failed to open mass storage device: '{s}'", .{
                    self.mass_storage_path,
                });
                return err;
            },
            else => return err,
        };
        defer mass_storage.close();

        try std.fs.cwd().copyFile(
            self.uf2_step.path.?,
            mass_storage,
            std.fs.path.basename(self.uf2_step.path.?),
            .{},
        );
    }
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

    pub fn addElf(self: *Self, path: []const u8, opts: Options) !void {
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
                    .addr = @intCast(u32, prog_hdr.p_paddr),
                    .file_offset = @intCast(u32, prog_hdr.p_offset),
                    .size = @intCast(u32, prog_hdr.p_memsz),
                });
            };

        if (segments.items.len == 0)
            return error.NoSegments;

        std.sort.sort(Segment, segments.items, {}, Segment.lessThan);
        // TODO: check for overlaps, assert no zero sized segments

        var blocks = std.ArrayList(Block).init(self.allocator);
        defer blocks.deinit();

        const last_segment_end = last_segment_end: {
            const last_segment = &segments.items[segments.items.len - 1];
            break :last_segment_end last_segment.addr + last_segment.size;
        };

        var segment_idx: usize = 0;
        var addr = std.mem.alignBackwardGeneric(u32, segments.items[0].addr, prog_page_size);
        while (addr < last_segment_end and segment_idx < segments.items.len) {
            const segment = &segments.items[segment_idx];
            const segment_end = segment.addr + segment.size;

            // if the last segment is not full, then there was a partial write
            // of the end of the last segment, and we've started processing a
            // new segment
            if (blocks.items.len > 0 and blocks.items[blocks.items.len - 1].payload_size != prog_page_size) {
                const block = &blocks.items[blocks.items.len - 1];
                assert(segment.addr >= block.target_addr);
                const block_end = block.target_addr + prog_page_size;

                if (segment.addr < block_end) {
                    const n_bytes = std.math.min(segment.size, block_end - segment.addr);
                    try file.seekTo(segment.file_offset);
                    const block_offset = segment.addr - block.target_addr;
                    const n_read = try file.reader().readAll(block.data[block_offset .. block_offset + n_bytes]);
                    if (n_read != n_bytes)
                        return error.ExpectedMoreElf;

                    addr += n_bytes;
                    block.payload_size += n_bytes;

                    // in this case the segment can fit in the page and there
                    // is room for an additional segment
                    if (block.payload_size < prog_page_size) {
                        segment_idx += 1;
                        continue;
                    }
                } else {
                    block.payload_size = prog_page_size;
                    addr = std.mem.alignBackwardGeneric(u32, segment.addr, prog_page_size);
                }
            }

            try blocks.append(.{
                .flags = .{
                    .not_main_flash = false,
                    .file_container = false,
                    .family_id_present = opts.family_id != null,
                    .md5_checksum_present = false,
                    .extension_tags_present = false,
                },
                .target_addr = addr,
                .payload_size = std.math.min(prog_page_size, segment_end - addr),
                .block_number = undefined,
                .total_blocks = undefined,
                .file_size_or_family_id = .{
                    .family_id = if (opts.family_id) |family_id|
                        family_id
                    else
                        @intToEnum(FamilyId, 0),
                },
                .data = std.mem.zeroes([476]u8),
            });

            const block = &blocks.items[blocks.items.len - 1];

            // in the case where padding is prepended to the block
            if (addr < segment.addr)
                addr = segment.addr;

            const n_bytes = (block.target_addr + block.payload_size) - addr;
            assert(n_bytes <= prog_page_size);

            try file.seekTo(segment.file_offset + addr - segment.addr);
            const block_offset = addr - block.target_addr;
            const n_read = try file.reader().readAll(block.data[block_offset .. block_offset + n_bytes]);
            if (n_read != n_bytes)
                return error.ExpectedMoreElf;

            addr += n_bytes;

            assert(addr <= segment_end);
            if (addr == segment_end)
                segment_idx += 1;
        }

        // pad last page with zeros
        if (blocks.items.len > 0)
            blocks.items[blocks.items.len - 1].payload_size = prog_page_size;

        try self.blocks.appendSlice(blocks.items);
        if (opts.bundle_source)
            @panic("TODO");
    }

    pub fn writeTo(self: *Self, writer: anytype) !void {
        for (self.blocks.items) |*block, i| {
            block.block_number = @intCast(u32, i);
            block.total_blocks = @intCast(u32, self.blocks.items.len);
            try block.writeTo(writer);
        }
    }

    pub fn addFile(self: *Self, path: []const u8) !void {
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
                    path_pos = std.math.min(block.len - n_read, path.len);
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
                const n_copied = std.math.min(block.data.len, path[path_pos..].len);
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

pub const Flags = packed struct {
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

    pub fn fromReader(reader: anytype) !Block {
        var block: Block = undefined;
        inline for (std.meta.fields(Block)) |field| {
            switch (field.field_type) {
                u32 => @field(block, field.name) = try reader.readIntLittle(u32),
                [476]u8 => {
                    const n = try reader.readAll(&@field(block, field.name));
                    if (n != @sizeOf(field.field_type))
                        return error.EndOfStream;
                },
                else => {
                    assert(4 == @sizeOf(field.field_type));
                    @field(block, field.name) =
                        @bitCast(field.field_type, try reader.readIntLittle(u32));
                },
            }
        }

        return block;
    }

    fn writeTo(self: Block, writer: anytype) !void {
        inline for (std.meta.fields(Block)) |field| {
            switch (field.field_type) {
                u32 => try writer.writeIntLittle(u32, @field(self, field.name)),
                [476]u8 => try writer.writeAll(&@field(self, field.name)),
                else => {
                    assert(4 == @sizeOf(field.field_type));
                    try writer.writeIntLittle(
                        u32,
                        @bitCast(u32, @field(self, field.name)),
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

    var rand = std.rand.DefaultPrng.init(0xf163bfab).random();
    var expected = Block{
        .flags = @bitCast(Flags, rand.int(u32)),
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

    try expected.writeTo(fbs.writer());

    // needs to be reset for reader
    fbs.reset();
    const actual = try Block.fromReader(fbs.reader());

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
    _,
};
