const rom = @import("rom.zig");

pub const Command = enum(u8) {
    block_erase = 0xd8,
    ruid_cmd = 0x4b,
};

pub const PAGE_SIZE = 256;
pub const SECTOR_SIZE = 4096;
pub const BLOCK_SIZE = 65536;

/// Bus reads to a 16MB memory window start at this address
pub const XIP_BASE = 0x10000000;

pub const boot2 = struct {
    /// Size of the second stage bootloader in bytes
    const BOOT2_SIZE_BYTES = 64;

    /// Buffer for the second stage bootloader
    var copyout: [BOOT2_SIZE_BYTES]u32 = undefined;
    var copyout_valid: bool = false;

    /// Copy the 2nd stage bootloader into memory
    pub fn flash_init() linksection(".time_critical") void {
        if (copyout_valid) return;
        const bootloader = @as([*]u32, @ptrFromInt(XIP_BASE));
        var i: usize = 0;
        while (i < BOOT2_SIZE_BYTES) : (i += 1) {
            copyout[i] = bootloader[i];
        }
        copyout_valid = true;
    }

    pub fn flash_enable_xip() linksection(".time_critical") void {
        // TODO: use the second stage bootloader instead of cmd_xip
        //const bootloader: []u32 = copyout[1..];

        //const f = @ptrCast(*fn () void, bootloader.ptr);
        //f();

        rom.flash_enter_cmd_xip()();
    }
};

/// Erase count bytes starting at offset (offset from start of flash)
///
/// The offset must be aligned to a 4096-byte sector, and count must
/// be a multiple of 4096 bytes!
pub fn range_erase(offset: u32, count: u32) linksection(".time_critical") void {
    // TODO: add sanity checks, e.g., offset + count < flash size

    boot2.flash_init();

    // TODO: __compiler_memory_barrier

    rom.connect_internal_flash()();
    rom.flash_exit_xip()();
    rom.flash_range_erase()(offset, count, BLOCK_SIZE, @intFromEnum(Command.block_erase));
    rom.flash_flush_cache()();

    boot2.flash_enable_xip();
}

/// Program data to flash starting at offset (offset from the start of flash)
///
/// The offset must be aligned to a 256-byte boundary, and the length of data
/// must be a multiple of 256!
pub fn range_program(offset: u32, data: []const u8) linksection(".time_critical") void {
    // TODO: add sanity checks, e.g., offset + count < flash size

    boot2.flash_init();

    // TODO: __compiler_memory_barrier

    rom.connect_internal_flash()();
    rom.flash_exit_xip()();
    rom.flash_range_program()(offset, data.ptr, data.len);
    rom.flash_flush_cache()();

    boot2.flash_enable_xip();
}
