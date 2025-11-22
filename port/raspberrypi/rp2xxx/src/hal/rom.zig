//! Access to functions and data in the RP2XXX bootrom.
//!
//! The Bootrom contains a number of public functions that provide useful
//! functionality that might be needed in the absence of any other code on the
//! device, as well as highly optimized versions of certain key functionality
//! that would otherwise have to take up space in most user binaries.

const std = @import("std");
const microzig = @import("microzig");
const compatibility = @import("compatibility.zig");
const arch = compatibility.arch;
const chip = compatibility.chip;
const options = microzig.options.hal;

/// Returns the ROM version number.
pub inline fn get_version_number() u8 {
    const VERSION_NUMBER: *const u8 = @ptrFromInt(0x0000_0013);
    return VERSION_NUMBER.*;
}

pub const lookup_data = chip_specific.lookup_data;
pub const lookup_function = chip_specific.lookup_function;

pub fn lookup_and_cache_data(comptime code: Data) ?*const anyopaque {
    const S = struct {
        const _code = code;
        var data: ?*const anyopaque = null;
    };

    if (S.data == null) S.data = lookup_data(code);
    return S.data;
}

pub fn lookup_and_cache_function(comptime code: Function) ?*const anyopaque {
    const S = struct {
        const _code = code;
        var f: ?*const anyopaque = null;
    };

    if (S.f == null) S.f = lookup_function(code);
    return S.f;
}

pub const Data = chip_specific.Data;
pub const Function = chip_specific.Function;

pub const signatures = chip_specific.signatures;

pub const chip_specific = switch (chip) {
    .RP2040 => @import("rom/rp2040.zig"),
    .RP2350 => @import("rom/rp2350.zig"),
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Fast Bit Counting / Manipulation Functions (Datasheet p. 135)
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/// Counts the number of 1 ones in the binary representation of x.
pub fn popcount32(x: u32) u32 {
    switch (chip) {
        .RP2040 => {
            const f: *const signatures.popcount32 = @ptrCast(@alignCast(lookup_and_cache_function(.popcount32)));
            return f(x);
        },
        // RP2350, supports fast assembly version
        .RP2350 => return @popCount(x),
    }
}

/// Reverses the bits of x.
pub fn reverse32(x: u32) u32 {
    switch (chip) {
        .RP2040 => {
            const f: *const signatures.reverse32 = @ptrCast(@alignCast(lookup_and_cache_function(.reverse32)));
            return f(x);
        },
        // RP2350, supports fast assembly version
        .RP2350 => return @bitReverse(x),
    }
}

/// Returns the number of consecutive high order 0 bits of x.
pub fn clz32(x: u32) u32 {
    switch (chip) {
        .RP2040 => {
            const f: *const signatures.clz32 = @ptrCast(@alignCast(lookup_and_cache_function(.clz32)));
            return f(x);
        },
        // RP2350, supports fast assembly version
        .RP2350 => return @clz(x),
    }
}

/// Returns the number of consecutive low order 0 bits of x.
pub fn ctz32(x: u32) u32 {
    switch (chip) {
        .RP2040 => {
            const f: *const signatures.ctz32 = @ptrCast(@alignCast(lookup_and_cache_function(.ctz32)));
            return f(x);
        },
        // RP2350, supports fast assembly version
        .RP2350 => return @ctz(x),
    }
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Fast Bulk Memory Fill / Copy Functions (Datasheet p. 136)
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/// Sets all bytes of dest to the value c and returns ptr.
pub fn memset(dest: []u8, c: u8) []u8 {
    switch (chip) {
        .RP2040 => {
            const f: *const signatures.memset = @ptrCast(@alignCast(lookup_and_cache_function(.memset)));
            return f(dest.ptr, c, dest.len)[0..dest.len];
        },
        .RP2350 => {
            @memset(dest, c);
            return dest;
        },
    }
}

/// Copies bytes from src to dest (must have the same length).
pub fn memcpy(dest: []u8, src: []const u8) []u8 {
    std.debug.assert(dest.len == src.len);
    switch (chip) {
        .RP2040 => {
            const f: *const signatures.memcpy = @ptrCast(@alignCast(lookup_and_cache_function(.memcpy)));
            return f(dest.ptr, src.ptr, dest.len)[0..dest.len];
        },
        .RP2350 => {
            @memcpy(dest, src);
            return dest;
        },
    }
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Flash Access Functions (Datasheet p. 137)
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// NOTE: inline these because they are used in the flash hal which has has
// functions that *must* be in ram

/// Restore all QSPI pad controls to their default state, and connect the SSI to
/// the QSPI pads
pub inline fn connect_internal_flash() void {
    const f: *const signatures.connect_internal_flash = @ptrCast(@alignCast(lookup_function(.connect_internal_flash)));
    f();
}

/// Configure the SSI to generate a standard 03h serial read command, with 24
/// address bits, upon each XIP access. This is a very slow XIP configuration,
/// but is very widely supported. The debugger calls this function after
/// performing a flash erase/programming operation, so that the
/// freshly-programmed code and data is visible to the debug host, without
/// having to know exactly what kind of flash device is connected.
pub inline fn flash_enter_cmd_xip() void {
    const f: *const signatures.flash_enter_cmd_xip = @ptrCast(@alignCast(lookup_function(.flash_enter_cmd_xip)));
    f();
}

/// First set up the SSI for serial-mode operations, then issue the fixed XIP
/// exit sequence described in Section 2.8.1.2. Note that the bootrom code uses
/// the IO forcing logic to drive the CS pin, which must be cleared before
/// returning the SSI to XIP mode (e.g. by a call to _flash_flush_cache). This
/// function configures the SSI with a fixed SCK clock divisor of /6.
pub inline fn flash_exit_xip() void {
    const f: *const signatures.flash_exit_xip = @ptrCast(@alignCast(lookup_function(.flash_exit_xip)));
    f();
}

/// This is the method that is entered by core 1 on reset to wait to be launched by core 0.
/// There are few cases where you should call this method (resetting core 1 is much better).
/// This method does not return and should only ever be called on core 1.
pub inline fn flash_flush_cache() void {
    const f: *const signatures.flash_flush_cache = @ptrCast(@alignCast(lookup_function(.flash_flush_cache)));
    f();
}

/// Erase a count bytes, starting at addr (offset from start of flash).
/// Optionally, pass a block erase command e.g. D8h block erase, and the size of
/// the block erased by this command — this function will use the larger block
/// erase where possible, for much higher erase speed. addr must be aligned to a
/// 4096-byte sector, and count must be a multiple of 4096 bytes.
pub inline fn flash_range_erase(addr: u32, count: usize, block_size: u32, block_cmd: u8) void {
    const f: *const signatures.flash_range_erase = @ptrCast(@alignCast(lookup_function(.flash_range_erase)));
    f(addr, count, block_size, block_cmd);
}

/// Program data to a range of flash addresses starting at addr (offset from the
/// start of flash) and count bytes in size. addr must be aligned to a 256-byte
/// boundary, and the length of data must be a multiple of 256.
pub inline fn flash_range_program(addr: u32, data: []const u8) void {
    const f: *const signatures.flash_range_program = @ptrCast(@alignCast(lookup_function(.flash_range_program)));
    f(addr, data.ptr, data.len);
}

/// Reset to USB bootloader.
pub fn reset_to_usb_boot() void {
    switch (chip) {
        .RP2040 => {
            const f: *const signatures.reset_to_usb_boot = @ptrCast(@alignCast(lookup_function(.reset_to_usb_boot)));
            f(0, 0);
        },
        .RP2350 => {
            // 0x0002 - reset to bootsel
            // 0x0100 - block until reset
            const f: *const signatures.reboot = @ptrCast(@alignCast(lookup_function(.reboot)));
            _ = f(0x0002 | 0x0100, 10, 0, 0);
            unreachable;
        },
    }
}
