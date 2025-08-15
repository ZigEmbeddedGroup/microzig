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

pub inline fn get_version_number() u8 {
    const VERSION_NUMBER: *const u8 = @ptrFromInt(0x0000_0013);
    return VERSION_NUMBER.*;
}

pub const lookup_data = chip_specific.lookup_data;
pub const lookup_function = chip_specific.lookup_function;

// NOTE: don't inline because that creates a copy of the cache per function call
pub fn lookup_and_cache_data(comptime info: chip_specific.DataInfo) info.PtrType {
    const S = struct {
        var data: ?info.PtrType = null;
    };

    if (S.data == null) S.data = lookup_data(info);
    return S.data.?;
}

// NOTE: don't inline because that creates a copy of the cache per function call
pub fn lookup_and_cache_function(comptime info: chip_specific.FunctionInfo) *const info.Signature {
    const S = struct {
        var f: ?*const info.Signature = null;
    };

    if (S.f == null) S.f = lookup_function(info);
    return S.f.?;
}

pub const DataInfo = chip_specific.DataInfo;
pub const FunctionInfo = chip_specific.FunctionInfo;

pub const chip_specific = switch (chip) {
    .RP2040 => @import("rom/rp2040.zig"),
    .RP2350 => @import("rom/rp2350.zig"),
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Fast Bit Counting / Manipulation Functions (Datasheet p. 135)
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/// Return a count of the number of 1 bits in value
pub fn popcount32(value: u32) u32 {
    return switch (chip) {
        .RP2040 => return lookup_and_cache_function(.popcount32)(value),
        // RP2350, supports fast assembly version
        .RP2350 => return @popCount(value),
    };
}

/// Return a count of the number of 1 bits in value
pub fn reverse32(value: u32) u32 {
    return switch (chip) {
        .RP2040 => return lookup_and_cache_function(.reverse32)(value),
        // RP2350, supports fast assembly version
        .RP2350 => return @bitReverse(value),
    };
}

/// Return the number of consecutive high order 0 bits of value
pub fn clz32(value: u32) u32 {
    return switch (chip) {
        .RP2040 => return lookup_and_cache_function(.clz32)(value),
        // RP2350, supports fast assembly version
        .RP2350 => return @clz(value),
    };
}

/// Return the number of consecutive low order 0 bits of value
pub fn ctz32(value: u32) u32 {
    return switch (chip) {
        .RP2040 => return lookup_and_cache_function(.ctz32)(value),
        // RP2350, supports fast assembly version
        .RP2350 => return @ctz(value),
    };
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Fast Bulk Memory Fill / Copy Functions (Datasheet p. 136)
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/// Sets all bytes of dest to the value c and returns ptr
pub fn memset(dest: []u8, c: u8) []u8 {
    return switch (chip) {
        .RP2040 => return lookup_and_cache_function(.memset)(dest.ptr, c, dest.len),
        .RP2350 => @memset(dest, c),
    };
}

/// Copies n bytes from src to dest; The number of bytes copied is the size of the smaller slice
pub fn memcpy(dest: []u8, src: []const u8) []u8 {
    return switch (chip) {
        .RP2040 => return lookup_and_cache_function(.memcpy)(dest.ptr, src.ptr, dest.len),
        .RP2350 => @memcpy(dest, src),
    };
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Flash Access Functions (Datasheet p. 137)
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// NOTE: inline these because they are used in the flash hal which has has
// functions that *must* be in ram

/// Restore all QSPI pad controls to their default state, and connect the SSI to
/// the QSPI pads
pub inline fn connect_internal_flash() void {
    lookup_function(.connect_internal_flash)();
}

/// Configure the SSI to generate a standard 03h serial read command, with 24
/// address bits, upon each XIP access. This is a very slow XIP configuration,
/// but is very widely supported. The debugger calls this function after
/// performing a flash erase/programming operation, so that the
/// freshly-programmed code and data is visible to the debug host, without
/// having to know exactly what kind of flash device is connected.
pub inline fn flash_enter_cmd_xip() void {
    lookup_function(.flash_enter_cmd_xip)();
}

/// First set up the SSI for serial-mode operations, then issue the fixed XIP
/// exit sequence described in Section 2.8.1.2. Note that the bootrom code uses
/// the IO forcing logic to drive the CS pin, which must be cleared before
/// returning the SSI to XIP mode (e.g. by a call to _flash_flush_cache). This
/// function configures the SSI with a fixed SCK clock divisor of /6.
pub inline fn flash_exit_xip() void {
    lookup_function(.flash_exit_xip)();
}

/// This is the method that is entered by core 1 on reset to wait to be launched by core 0.
/// There are few cases where you should call this method (resetting core 1 is much better).
/// This method does not return and should only ever be called on core 1.
pub inline fn flash_flush_cache() void {
    lookup_function(.flash_flush_cache)();
}

/// Erase a count bytes, starting at addr (offset from start of flash).
/// Optionally, pass a block erase command e.g. D8h block erase, and the size of
/// the block erased by this command — this function will use the larger block
/// erase where possible, for much higher erase speed. addr must be aligned to a
/// 4096-byte sector, and count must be a multiple of 4096 bytes.
pub inline fn flash_range_erase(addr: u32, count: usize, block_size: u32, block_cmd: u8) void {
    lookup_function(.flash_range_erase)(addr, count, block_size, block_cmd);
}

/// Program data to a range of flash addresses starting at addr (offset from the
/// start of flash) and count bytes in size. addr must be aligned to a 256-byte
/// boundary, and the length of data must be a multiple of 256.
pub inline fn flash_range_program(addr: u32, data: []const u8) void {
    lookup_function(.flash_range_program)(addr, data.ptr, data.len);
}

/// Reset to USB bootloader.
pub fn reset_to_usb_boot() !void {
    switch (chip) {
        .RP2040 => lookup_function(.reset_to_usb_boot)(0, 0),
        .RP2350 => {
            // 0x0002 - reset to bootsel
            // 0x0100 - block until reset
            _ = lookup_function(.reboot)(0x0002 | 0x0100, 10, 0, 0);
            unreachable;
        },
    }
}

comptime {
    // export intrinsics
    _ = chip_specific;
}
