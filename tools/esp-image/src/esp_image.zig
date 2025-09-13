const std = @import("std");

// TODO: Refactor esp-image to allow reading esp images in freestanding. The
// elf specific image generation functionality should be kept in elf2image.

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
    mmu_page_size: u8 = 0,
    reserved1: [3]u8 = std.mem.zeroes([3]u8),
    reserved2: [18]u32 = std.mem.zeroes([18]u32),
};

comptime {
    std.debug.assert(@sizeOf(AppDesc) == 256);
}
