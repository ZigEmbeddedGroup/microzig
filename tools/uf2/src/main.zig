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

const prog_page_size = 256;
const uf2_alignment = 4;

pub const Uf2Step = struct {
    step: std.build.Step,
    exe: *LibExeObjStep,
    opts: Options,
    path: ?[]const u8 = null,

    pub const Options = struct {
        bundle_source: bool = true,
        family_id: ?FamilyId = null,
    };

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
        };

        ret.step.dependOn(&exe.step);
        return ret;
    }

    /// uf2 is typically used to flash via a mass storage device, this step
    /// writes the file contents to the mounted directory
    pub fn addFlashOperation(self: *Uf2Step, path: []const u8) *std.build.WriteFileStep {
        _ = self;
        _ = path;

        @panic("TODO");
    }

    fn make(step: *std.build.Step) !void {
        const self = @fieldParentPtr(Uf2Step, "step", step);
        const file_source = self.exe.getOutputSource();
        const exe_path = file_source.getPath(self.exe.builder);

        const dest_path = try std.mem.join(self.exe.builder.allocator, "", &.{
            exe_path,
            ".uf2",
        });

        var archive = try Archive.initFromElf(
            self.exe.builder.allocator,
            self.exe,
            self.opts.family_id,
        );
        defer archive.deinit();

        const dest_file = try std.fs.cwd().createFile(dest_path, .{});
        defer dest_file.close();

        try archive.writeTo(dest_file.writer());
        self.path = dest_path;
    }
};

pub const Archive = struct {
    blocks: std.ArrayList(Block),

    const Self = @This();

    pub fn init(allocator: std.mem.Allocator) Archive {
        return Self{
            .blocks = std.ArrayList(Block).init(allocator),
        };
    }

    pub fn deinit(self: *Self) void {
        self.blocks.deinit();
    }

    pub fn initFromElf(
        allocator: std.mem.Allocator,
        exe: *LibExeObjStep,
        family_id_opt: ?FamilyId,
    ) !Archive {
        var archive = Self.init(allocator);
        errdefer archive.deinit();

        const file_source = exe.getOutputSource();
        const exe_path = file_source.getPath(exe.builder);
        const exe_file = try std.fs.cwd().openFile(exe_path, .{});
        defer exe_file.close();

        const header = try std.elf.Header.read(exe_file);
        var it = header.program_header_iterator(exe_file);

        while (try it.next()) |prog_hdr| if (prog_hdr.p_type == std.elf.PT_LOAD) {
            const num_blocks = (prog_hdr.p_filesz + prog_page_size - 1) / prog_page_size;
            try archive.blocks.appendNTimes(.{
                .flags = .{
                    .not_main_flash = false,
                    .file_container = false,
                    .family_id_present = family_id_opt != null,
                    .md5_checksum_present = false,
                    .extension_tags_present = false,
                },
                .target_addr = undefined,
                .payload_size = undefined,
                .block_number = undefined,
                .total_blocks = undefined,
                .file_size_or_family_id = .{
                    .family_id = if (family_id_opt) |family_id| family_id else @intToEnum(FamilyId, 0),
                },
                .data = undefined,
            }, num_blocks);
            errdefer {
                var i: usize = 0;
                while (i < num_blocks) : (i += 1)
                    _ = archive.blocks.pop();
            }

            try exe_file.seekTo(prog_hdr.p_offset);
            const new_blocks = archive.blocks.items[archive.blocks.items.len - num_blocks ..];
            for (new_blocks) |*block, i| {
                block.target_addr = @intCast(u32, prog_hdr.p_paddr + (i * prog_page_size));
                // not super sure about aligning this forward, would end up
                // reading extra bytes from the elf file, maybe they're
                // zeroed out normal? TODO: add an assert for this
                block.payload_size = if (i == new_blocks.len - 1)
                    @intCast(u32, prog_hdr.p_filesz % prog_page_size)
                else
                    prog_page_size;

                const dest_size = std.math.min(block.payload_size, prog_page_size);
                const n_read = try exe_file.reader().readAll(block.data[0..dest_size]);
                if (n_read != block.payload_size) {
                    return error.InvalidElf;
                }

                // set rest of data block to zero
                std.mem.set(u8, block.data[block.payload_size..], 0);

                // this is to follow the spec of the payload being aligned,
                // this will just have zero padding in the final flashing
                if (!std.mem.isAligned(block.payload_size, uf2_alignment)) {
                    assert(block.payload_size < prog_page_size);
                    block.payload_size = @intCast(u32, std.mem.alignForward(block.payload_size, uf2_alignment));
                }

                assert(std.mem.isAligned(block.target_addr, uf2_alignment));
            }
        };

        return archive;
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
                // offset in file (seekTo() is called on this) (FOUR_BYTE_ALIGNED)
                .target_addr = target_addr,
                // data in this block (FOUR BYTE ALIGNED)
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

    fn fromReader(reader: anytype) !Block {
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
                    @field(block, field.name) = @bitCast(field.field_type, try reader.readIntLittle(u32));
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
                    try writer.writeIntLittle(u32, @bitCast(u32, @field(self, field.name)));
                },
            }
        }
    }
};

fn expectEqualBlock(expected: Block, actual: Block) !void {
    try testing.expectEqual(first_magic, actual.magic_start1);
    try testing.expectEqual(expected.magic_start1, actual.magic_start1);
    try testing.expectEqual(second_magic, actual.magic_start2);
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

    try testing.expectEqual(last_magic, actual.magic_end);
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
