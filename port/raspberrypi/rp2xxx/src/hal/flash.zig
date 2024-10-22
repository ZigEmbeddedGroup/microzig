//! See [rp2040 docs](https://datasheets.raspberrypi.com/rp2040/rp2040-datasheet.pdf), page 136.
const rom = @import("rom.zig");

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;

const IO_QSPI = peripherals.IO_QSPI;
const XIP_SSI = peripherals.SSI;

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

/// Force the chip select using IO overrides, in case RAM-resident IRQs
/// are still running, and the FIFO bottoms out
pub inline fn force_cs(high: bool) void {
    @call(.never_inline, _force_cs, .{high});
}

fn _force_cs(high: bool) linksection(".time_critical") void {
    const value = v: {
        var value: u32 = 0x2;
        if (high) {
            value = 0x3;
        }
        break :v value << 8;
    };

    const IO_QSPI_GPIO_QSPI_SS_CTRL: *volatile u32 = @ptrFromInt(@intFromPtr(IO_QSPI) + 0x0C);
    IO_QSPI_GPIO_QSPI_SS_CTRL.* = (IO_QSPI_GPIO_QSPI_SS_CTRL.* ^ value) & 0x300;
}

/// Execute a command on the flash chip
///
/// Configures flash for serial mode operation, sends a command, receives response
/// and then configures flash back to XIP mode
pub inline fn cmd(tx_buf: []const u8, rx_buf: []u8) void {
    @call(.never_inline, _cmd, .{ tx_buf, rx_buf });
}

fn _cmd(tx_buf: []const u8, rx_buf: []u8) linksection(".time_critical") void {
    boot2.flash_init();
    asm volatile ("" ::: "memory"); // memory barrier
    rom.connect_internal_flash()();
    rom.flash_exit_xip()();
    force_cs(false);

    // can't use peripherals, because its functions are not in ram
    const XIP_SSI_SR: *volatile u32 = @ptrFromInt(@intFromPtr(XIP_SSI) + 0x28);
    const XIP_SSI_DR0: *volatile u8 = @ptrFromInt(@intFromPtr(XIP_SSI) + 0x60);

    const len = tx_buf.len;
    var tx_remaining = len;
    var rx_remaining = len;
    const fifo_depth = 16 - 2;
    while (tx_remaining > 0 or rx_remaining > 0) {
        const can_put = XIP_SSI_SR.* & 0x2 != 0; // TFNF
        const can_get = XIP_SSI_SR.* & 0x8 != 0; // RFNE

        if (can_put and tx_remaining > 0 and rx_remaining < tx_remaining + fifo_depth) {
            XIP_SSI_DR0.* = tx_buf[len - tx_remaining];
            tx_remaining -= 1;
        }
        if (can_get and rx_remaining > 0) {
            rx_buf[len - rx_remaining] = XIP_SSI_DR0.*;
            rx_remaining -= 1;
        }
    }

    force_cs(true);
    rom.flash_flush_cache()();
    boot2.flash_enable_xip();
}

const id_dummy_len = 4;
const id_data_len = 8;
const id_total_len = 1 + id_dummy_len + id_data_len;
var id_buf: ?[id_data_len]u8 = null;

/// Read the flash chip's ID which is unique to each RP2040
pub fn id() [id_data_len]u8 {
    if (id_buf) |b| {
        return b;
    }

    var tx_buf: [id_total_len]u8 = undefined;
    var rx_buf: [id_total_len]u8 = undefined;
    tx_buf[0] = @intFromEnum(Command.ruid_cmd);
    cmd(&tx_buf, &rx_buf);

    id_buf = undefined;
    @memcpy(&id_buf.?, rx_buf[1 + id_dummy_len ..]);

    return id_buf.?;
}
