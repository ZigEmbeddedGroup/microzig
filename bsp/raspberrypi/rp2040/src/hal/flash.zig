//! See [rp2040 docs](https://datasheets.raspberrypi.com/rp2040/rp2040-datasheet.pdf), page 136.
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

/// Flash code related to the second stage boot loader
pub const boot2 = struct {
    /// Size of the second stage bootloader in words
    const BOOT2_SIZE_WORDS = 64;

    /// Buffer for the second stage bootloader
    ///
    /// The only job of the second stage bootloader is to configure the SSI and
    /// the external flash for the best possible execute-in-place (XIP) performance.
    /// Until the SSI is correctly configured for the attached flash device, it's not
    /// possible to access flash via the XIP address window, i.e., we have to copy
    /// the bootloader into sram before calling `rom.flash_exit_xip`. This is required
    /// if we want to erase and/or write to flash.
    ///
    /// At the end we can then just make a subroutine call to copyout, to configure
    /// the SSI and flash. The second stage bootloader will return to the calling function
    /// if a return address is provided in `lr`.
    var copyout: [BOOT2_SIZE_WORDS]u32 = undefined;
    var copyout_valid: bool = false;

    /// Copy the 2nd stage bootloader into memory
    ///
    /// This is required by `_range_erase` and `_range_program` so we can later setup
    /// XIP via the second stage bootloader.
    pub export fn flash_init() linksection(".time_critical") void {
        if (copyout_valid) return;
        const bootloader = @as([*]u32, @ptrFromInt(XIP_BASE));
        var i: usize = 0;
        while (i < BOOT2_SIZE_WORDS) : (i += 1) {
            copyout[i] = bootloader[i];
        }
        copyout_valid = true;
    }

    /// Configure the SSI and the external flash for XIP by calling the second stage
    /// bootloader that was copied out to `copyout`.
    pub export fn flash_enable_xip() linksection(".time_critical") void {
        // The bootloader is in thumb mode
        asm volatile (
            \\adds r0, #1
            \\blx r0
            :
            : [copyout] "{r0}" (@intFromPtr(&copyout)),
            : "r0", "lr"
        );
    }
};

/// Erase count bytes starting at offset (offset from start of flash)
///
/// The offset must be aligned to a 4096-byte sector, and count must
/// be a multiple of 4096 bytes!
pub inline fn range_erase(offset: u32, count: u32) void {
    // Do not inline `_range_erase`!
    @call(.never_inline, _range_erase, .{ offset, count });
}

export fn _range_erase(offset: u32, count: u32) linksection(".time_critical") void {
    // TODO: add sanity checks, e.g., offset + count < flash size

    asm volatile ("" ::: "memory"); // memory barrier

    boot2.flash_init();

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
pub inline fn range_program(offset: u32, data: []const u8) void {
    // Do not inline `_range_program`!
    @call(.never_inline, _range_program, .{ offset, data.ptr, data.len });
}

export fn _range_program(offset: u32, data: [*]const u8, len: usize) linksection(".time_critical") void {
    // TODO: add sanity checks, e.g., offset + count < flash size

    asm volatile ("" ::: "memory"); // memory barrier

    boot2.flash_init();

    rom.connect_internal_flash()();
    rom.flash_exit_xip()();
    rom.flash_range_program()(offset, data, len);
    rom.flash_flush_cache()();

    boot2.flash_enable_xip();
}
