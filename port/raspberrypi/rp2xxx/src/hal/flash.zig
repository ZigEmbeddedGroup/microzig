const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const IO_QSPI = peripherals.IO_QSPI;
const XIP_SSI = peripherals.SSI;

const rom = @import("rom.zig");
const compatibility = @import("compatibility.zig");

pub const Command = enum(u8) {
    block_erase = 0xd8,
    ruid_cmd = 0x4b,
};

pub const PAGE_SIZE = 256;
pub const SECTOR_SIZE = 4096;
pub const BLOCK_SIZE = 65536;

/// Bus reads to a 16MB memory window start at this address.
pub const XIP_BASE = 0x10000000;

/// After the bootrom enters the user application, a copy of the flash XIP
/// setup function is found here on RP2350.
pub const BOOTRAM_BASE = 0x400e0000;

/// Infrastructure for reentering XIP mode after exiting for programming.
pub const boot2 = if (!microzig.config.ram_image and compatibility.arch == .arm) struct {
    const BOOT2_SIZE_WORDS = 64;

    var copyout: [BOOT2_SIZE_WORDS]u32 = undefined;
    var copyout_valid: bool = false;

    /// Copies the XIP setup function into RAM:
    /// - On RP2040 this *is* the second stage bootloader
    /// - On RP2350 it is found at BOOTRAM_BASE.
    pub export fn flash_init() linksection(".ram_text") void {
        if (copyout_valid) return;
        const bootloader = @as([*]u32, @ptrFromInt(switch (compatibility.chip) {
            .RP2040 => XIP_BASE,
            .RP2350 => BOOTRAM_BASE,
        }));
        var i: usize = 0;
        while (i < BOOT2_SIZE_WORDS) : (i += 1) {
            copyout[i] = bootloader[i];
        }
        asm volatile ("" ::: .{ .memory = true }); // memory barrier
        copyout_valid = true;
    }

    /// Configure the SSI and the external flash for XIP using the XIP setup
    /// function that was copied out to `copyout`.
    pub export fn flash_enable_xip() linksection(".ram_text") void {

        // Calling boot2 as a function works because it accepts a return vector in
        // LR (and doesn't trash r4-r7). Bootrom passes NULL in LR, instructing
        // boot2 to enter flash vector table's reset handler.
        @as(*const fn () callconv(.c) void, @ptrFromInt(@intFromPtr(&copyout) + 1))();
    }
} else struct {
    // no op
    pub inline fn flash_init() linksection(".ram_text") void {}

    // Fallback. This is a very slow XIP configuration, but is very widely
    // supported.
    pub inline fn flash_enable_xip() linksection(".ram_text") void {
        rom.flash_enter_cmd_xip();
    }
};

/// Erase count bytes starting at offset (offset from start of flash)
///
/// The offset must be aligned to a 4096-byte sector, and count must be a
/// multiple of 4096 bytes!
pub inline fn range_erase(offset: u32, count: u32) void {
    // Do not inline `_range_erase`!
    @call(.never_inline, _range_erase, .{ offset, count });
}

export fn _range_erase(offset: u32, count: u32) linksection(".ram_text") void {
    // TODO: add sanity checks, e.g., offset + count < flash size

    asm volatile ("" ::: .{ .memory = true }); // memory barrier

    boot2.flash_init();

    rom.connect_internal_flash();
    rom.flash_exit_xip();
    rom.flash_range_erase(offset, count, BLOCK_SIZE, @intFromEnum(Command.block_erase));
    rom.flash_flush_cache();

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

export fn _range_program(offset: u32, data: [*]const u8, len: usize) linksection(".ram_text") void {
    // TODO: add sanity checks, e.g., offset + count < flash size

    asm volatile ("" ::: .{ .memory = true }); // memory barrier

    boot2.flash_init();

    rom.connect_internal_flash();
    rom.flash_exit_xip();
    rom.flash_range_program(offset, data[0..len]);
    rom.flash_flush_cache();

    boot2.flash_enable_xip();
}

/// Force the chip select using IO overrides, in case RAM-resident IRQs are
/// still running, and the FIFO bottoms out
pub inline fn force_cs(high: bool) void {
    @call(.never_inline, _force_cs, .{high});
}

fn _force_cs(high: bool) linksection(".ram_text") void {
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
/// Configures flash for serial mode operation, sends a command, receives
/// response and then configures flash back to XIP mode
pub inline fn cmd(tx_buf: []const u8, rx_buf: []u8) void {
    @call(.never_inline, _cmd, .{ tx_buf, rx_buf });
}

fn _cmd(tx_buf: []const u8, rx_buf: []u8) linksection(".ram_text") void {
    boot2.flash_init();
    asm volatile ("" ::: .{ .memory = true }); // memory barrier
    rom.connect_internal_flash();
    rom.flash_exit_xip();
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
    rom.flash_flush_cache();
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
