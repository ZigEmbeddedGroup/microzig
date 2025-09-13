const std = @import("std");

// TODO: Refactor esp-image to allow reading esp images in freestanding. The
// elf specific image generation functionality should be kept in elf2image.

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

pub const AppDesc = extern struct {
    pub const MAGIC: u32 = 0xABCD5432;

    magic: u32 = MAGIC,
    secure_version: u32 = 0,
    reserved0: [2]u32 = std.mem.zeroes([2]u32),
    version: [32]u8 = std.mem.zeroes([32]u8),
    project_name: [32]u8 = std.mem.zeroes([32]u8),
    time: [16]u8 = std.mem.zeroes([16]u8),
    date: [16]u8 = std.mem.zeroes([16]u8),
    idf_ver: [32]u8 = std.mem.zeroes([32]u8),
    app_elf_sha256: [32]u8 = std.mem.zeroes([32]u8),
    min_efuse_blk_rev_full: u16 = 0,
    max_efuse_blk_rev_full: u16 = 0xffff,
    mmu_page_size: FlashMMU_PageSize = DEFAULT_FLASH_MMU_PAGE_SIZE,
    reserved1: [3]u8 = std.mem.zeroes([3]u8),
    reserved2: [18]u32 = std.mem.zeroes([18]u32),
};

comptime {
    std.debug.assert(@sizeOf(AppDesc) == 256);
}
