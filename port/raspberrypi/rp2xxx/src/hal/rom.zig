//! Access to functions and data in the RP2040 bootrom
//!
//! The Bootrom contains a number of public functions that provide useful RP2040 functionality
//! that might be needed in the absence of any other code on the device,
//! as well as highly optimized versions of certain key functionality
//! that would otherwise have to take up space in most user binaries.
//!
//! The functions include:
//! 1. Fast Bit Counting / Manipulation Functions
//! 2. Fast Bulk Memory Fill / Copy Functions
//! 3. Flash Access Functions
//! 4. Debugging Support Functions
//! 5. Miscellaneous Functions

const std = @import("std");
const microzig = @import("microzig");
const chip = microzig.hal.compatibility.chip;

/// Function codes to lookup public functions that provide useful RP2040 functionality
pub const Code = enum(u32) {
    popcount32 = rom_table_code('P', '3'), // Only avaiable on: RP2040
    reverse32 = rom_table_code('R', '3'), // Only avaiable on: RP2040
    clz32 = rom_table_code('L', '3'), // Only avaiable on: RP2040
    ctz32 = rom_table_code('T', '3'), // Only avaiable on: RP2040
    memset = rom_table_code('M', 'S'), // Only avaiable on: RP2040
    memset4 = rom_table_code('S', '4'), // Only avaiable on: RP2040
    memcpy = rom_table_code('M', 'C'), // Only avaiable on: RP2040
    memcpy44 = rom_table_code('C', '4'), // Only avaiable on: RP2040
    connect_internal_flash = rom_table_code('I', 'F'),
    flash_exit_xip = rom_table_code('E', 'X'),
    flash_range_erase = rom_table_code('R', 'E'),
    flash_range_program = rom_table_code('R', 'P'),
    flash_flush_cache = rom_table_code('F', 'C'),
    flash_enter_cmd_xip = rom_table_code('C', 'X'),
    debug_trampoline = rom_table_code('D', 'T'),
    debug_trampoline_end = rom_table_code('D', 'E'),
    reset_to_usb_boot = rom_table_code('U', 'B'),
    wait_for_vector = rom_table_code('W', 'V'),
};

/// Signatures of all public bootrom functions
pub const signatures = struct {
    /// Returns the 32 bit pointer into the ROM if found or NULL otherwise
    const rom_table_lookup = fn (table: [*]const u16, code: u32) callconv(.C) *anyopaque;
    /// Signature for popcount32: Return a count of the number of 1 bits in value
    const popcount32 = fn (value: u32) callconv(.C) u32;
    /// Signature for reverse32: Return the bits of value in the reverse order
    const reverse32 = fn (value: u32) callconv(.C) u32;
    /// Signature for clz32: Return the number of consecutive high order 0 bits of value
    const clz32 = fn (value: u32) callconv(.C) u32;
    /// Signature for ctz32: Return the number of consecutive low order 0 bits of value
    const ctz32 = fn (value: u32) callconv(.C) u32;
    /// Signature of memset: Sets n bytes start at ptr to the value c and returns ptr
    const memset = fn (ptr: [*]u8, c: u8, n: u32) callconv(.C) [*]u8;
    /// Signature of memset4: Sets n bytes start at ptr to the value c and returns ptr;
    /// must be word (32-bit) aligned!
    const memset4 = fn (ptr: [*]u32, c: u8, n: u32) callconv(.C) [*]u32;
    /// Signature of memcpy: Copies n bytes starting at src to dest and returns dest.
    /// The results are undefined if the regions overlap.
    const memcpy = fn (dest: [*]u8, src: [*]const u8, n: u32) callconv(.C) [*]u8;
    /// Signature of memcpy44: Copies n bytes starting at src to dest and returns dest;
    /// must be word (32-bit) aligned!
    const memcpy44 = fn (dest: [*]u32, src: [*]const u32, n: u32) callconv(.C) [*]u8;
    /// Signature of connect_internal_flash: Restore all QSPI pad controls to their
    /// default state, and connect the SSI to the QSPI pads
    const connect_internal_flash = fn () callconv(.C) void;
    /// Signature of flash_exit_xip: First set up the SSI for serial-mode operations,
    /// then issue the fixed XIP exit sequence described in Section 2.8.1.2. Note that
    /// the bootrom code uses the IO forcing logic to drive the CS pin, which must be
    /// cleared before returning the SSI to XIP mode (e.g. by a call to _flash_flush_cache).
    /// This function configures the SSI with a fixed SCK clock divisor of /6.
    const flash_exit_xip = fn () callconv(.C) void;
    /// Signature of flash_range_erase: Erase a count bytes, starting at addr (offset from
    /// start of flash). Optionally, pass a block erase command e.g. D8h block erase,
    /// and the size of the block erased by this command — this function will use the
    /// larger block erase where possible, for much higher erase speed. addr must be aligned
    /// to a 4096-byte sector, and count must be a multiple of 4096 bytes.
    const flash_range_erase = fn (
        addr: u32,
        count: usize,
        block_size: u32,
        block_cmd: u8,
    ) callconv(.C) void;
    /// Signature of flash_range_program: Program data to a range of flash addresses
    /// starting at addr (offset from the start of flash) and count bytes in size.
    /// addr must be aligned to a 256-byte boundary, and count must be a multiple of 256.
    const flash_range_program = fn (addr: u32, data: [*]const u8, count: usize) callconv(.C) void;
    /// Signature of flash_flush_cache: Flush and enable the XIP cache. Also clears the IO
    /// forcing on QSPI CSn, so that the SSI can drive the flash chip select as normal.
    const flash_flush_cache = fn () callconv(.C) void;
    /// Signature of flash_enter_cmd_xip: Configure the SSI to generate
    /// a standard 03h serial read command, with 24 address bits, upon each XIP access.
    /// This is a very slow XIP configuration, but is very widely supported.
    /// The debugger calls this function after performing a flash erase/programming operation,
    /// so that the freshly-programmed code and data is visible to the debug host,
    /// without having to know exactly what kind of flash device is connected.
    const flash_enter_cmd_xip = fn () callconv(.C) void;
    /// Signature of debug_trampoline: Simple debugger trampoline for break-on-return.
    /// This methods helps the debugger call ROM routines without setting hardware breakpoints.
    /// The function address is passed in r7 and args are passed through r0 … r3 as per ABI.
    /// This method does not return but executes a BKPT #0 at the end
    const debug_trampoline = fn () callconv(.C) void;
    /// Signature of debug_trampoline_end: This is the address of the final BKPT #0 instruction
    /// of debug_trampoline. This can be compared with the program counter to detect
    /// completion of the debug_trampoline call.
    const debug_trampoline_end = fn () callconv(.C) void;
    /// Signature of reset_to_usb_boot: Resets the RP2040 and uses the watchdog facility
    /// to re-start in BOOTSEL mode:
    /// - gpio_activity_pin_mask is provided to enable an "activity light" via
    ///   GPIO attached LED for the USB Mass Storage Device:
    ///   - 0 No pins are used as per a cold boot.
    ///   - Otherwise a single bit set indicating which GPIO pin should be set to output and raised
    ///     whenever there is mass storage activity from the host.
    /// - disable_interface_mask may be used to control the exposed USB interfaces:
    ///   - 0 To enable both interfaces (as per a cold boot)
    ///   - 1 To disable the USB Mass Storage Interface (see Section 2.8.4)
    ///   - 2 To disable the USB PICOBOOT Interface (see Section 2.8.5)
    const reset_to_usb_boot = fn (gpio_activity_mask: u32, disable_interface_mask: u32) callconv(.C) noreturn;
    /// Signature of wait_for_vector: This is the method that is entered by core 1 on reset to wait
    /// to be launched by core 0. There are few cases where you should call this method (resetting
    /// core 1 is much better). This method does not return and should only ever be called on core 1.
    const wait_for_vector = fn () callconv(.C) noreturn;
};

/// Return a bootrom lookup code based on two ASCII characters
///
/// These codes are uses to lookup data or function addresses in the bootrom
///
/// # Parameters
/// * `c1` - the first character
/// * `c2` - the second character
///
/// # Returns
///
/// A 32 bit address pointing into bootrom
pub fn rom_table_code(c1: u8, c2: u8) u32 {
    return @as(u32, c1) | (@as(u32, c2) << 8);
}

/// Convert a 16 bit pointer stored at the given rom address into a pointer
///
/// # Parameters
/// * `rom_addr` - address of the 16-bit pointer in rom
///
/// # Returns
///
/// The converted pointer
pub inline fn rom_hword_as_ptr(rom_addr: u32) *anyopaque {
    const ptr_to_ptr: *const u16 = @ptrFromInt(rom_addr);
    return @ptrFromInt(ptr_to_ptr.*);
}

/// Lookup a bootrom function by code (inline)
///
/// # Parameters
/// * `code` - code of the function (see codes)
///
/// # Returns
///
/// A anyopaque pointer to the function; must be cast by the caller
pub inline fn _rom_func_lookup(code: Code) *const anyopaque {
    const rom_table_lookup: *const signatures.rom_table_lookup = @alignCast(@ptrCast(rom_hword_as_ptr(0x18)));
    const func_table: [*]const u16 = @ptrCast(@alignCast(rom_hword_as_ptr(0x14)));
    return rom_table_lookup(func_table, @intFromEnum(code));
}

/// Lookup a bootrom function by code
///
/// # Parameters
/// * `code` - code of the function (see codes)
///
/// # Returns
///
/// A anyopaque pointer to the function; must be cast by the caller
pub fn rom_func_lookup(code: Code) *const anyopaque {
    return _rom_func_lookup(code);
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Fast Bit Counting / Manipulation Functions (Datasheet p. 135)
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/// Return a count of the number of 1 bits in value
pub fn popcount32(value: u32) u32 {
    if (chip == .RP2350) {
        // RP2350, supports fast assembly version
        return @popCount(value);
    }

    const S = struct {
        var f: ?*const signatures.popcount32 = null;
    };

    if (S.f == null) S.f = @ptrCast(_rom_func_lookup(Code.popcount32));
    return S.f.?(value);
}

/// Return a count of the number of 1 bits in value
pub fn reverse32(value: u32) u32 {
    if (chip == .RP2350) {
        // RP2350, supports fast assembly version
        return @bitReverse(value);
    }

    const S = struct {
        var f: ?*const signatures.reverse32 = null;
    };

    if (S.f == null) S.f = @ptrCast(_rom_func_lookup(Code.reverse32));
    return S.f.?(value);
}

/// Return the number of consecutive high order 0 bits of value
pub fn clz32(value: u32) u32 {
    if (chip == .RP2350) {
        // RP2350, supports fast assembly version
        return @clz(value);
    }

    const S = struct {
        var f: ?*const signatures.clz32 = null;
    };

    if (S.f == null) S.f = @ptrCast(_rom_func_lookup(Code.clz32));
    return S.f.?(value);
}

/// Return the number of consecutive low order 0 bits of value
pub fn ctz32(value: u32) u32 {
    if (chip == .RP2350) {
        // RP2350, supports fast assembly version
        return @ctz(value);
    }

    const S = struct {
        var f: ?*const signatures.ctz32 = null;
    };

    if (S.f == null) S.f = @ptrCast(_rom_func_lookup(Code.ctz32));
    return S.f.?(value);
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Fast Bulk Memory Fill / Copy Functions (Datasheet p. 136)
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/// Sets all bytes of dest to the value c and returns ptr
pub fn memset(dest: []u8, c: u8) []u8 {
    if (chip == .RP2350) {
        @memset(dest, c);
        return dest;
    }

    const S = struct {
        var f: ?*const signatures.memset = null;
    };

    if (S.f == null) S.f = @ptrCast(_rom_func_lookup(Code.memset));
    return S.f.?(dest.ptr, c, dest.len)[0..dest.len];
}

/// Copies n bytes from src to dest; The number of bytes copied is the size of the smaller slice
pub fn memcpy(dest: []u8, src: []const u8) []u8 {
    if (chip == .RP2350) {
        // For some reason @memcpy crash chip with HardFault interrupt (UNALIGNED)
        std.mem.copyForwards(u8, dest, src);
        return dest;
    }

    const S = struct {
        var f: ?*const signatures.memcpy = null;
    };

    const n = if (dest.len <= src.len) dest.len else src.len;

    if (S.f == null) S.f = @alignCast(@ptrCast(_rom_func_lookup(Code.memcpy)));
    return S.f.?(dest.ptr, src.ptr, n)[0..n];
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Flash Access Functions (Datasheet p. 137)
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/// Restore all QSPI pad controls to their default state, and connect the SSI to the QSPI pads
pub inline fn connect_internal_flash() *const signatures.connect_internal_flash {
    return @alignCast(@ptrCast(_rom_func_lookup(Code.connect_internal_flash)));
}

/// First set up the SSI for serial-mode operations, then issue the fixed XIP exit
/// sequence described in Section 2.8.1.2. Note that the bootrom code uses the IO
/// forcing logic to drive the CS pin, which must be cleared before returning the
/// SSI to XIP mode (e.g. by a call to _flash_flush_cache). This function configures
/// the SSI with a fixed SCK clock divisor of /6.
pub inline fn flash_exit_xip() *const signatures.flash_exit_xip {
    return @alignCast(@ptrCast(_rom_func_lookup(Code.flash_exit_xip)));
}

/// Erase a count bytes, starting at addr (offset from start of flash). Optionally,
/// pass a block erase command e.g. D8h block erase, and the size of the block
/// erased by this command — this function will use the larger block erase where
/// possible, for much higher erase speed. addr must be aligned to a 4096-byte sector,
/// and count must be a multiple of 4096 bytes.
pub inline fn flash_range_erase() *const signatures.flash_range_erase {
    return @alignCast(@ptrCast(_rom_func_lookup(Code.flash_range_erase)));
}

/// Program data to a range of flash addresses starting at addr (offset from the
/// start of flash) and count bytes in size. addr must be aligned to a 256-byte
/// boundary, and the length of data must be a multiple of 256.
pub inline fn flash_range_program() *const signatures.flash_range_program {
    return @alignCast(@ptrCast(_rom_func_lookup(Code.flash_range_program)));
}

/// Flush and enable the XIP cache. Also clears the IO forcing on QSPI CSn, so that
/// the SSI can drive the flash chip select as normal.
pub inline fn flash_flush_cache() *const signatures.flash_flush_cache {
    return @alignCast(@ptrCast(_rom_func_lookup(Code.flash_flush_cache)));
}

/// Configure the SSI to generate a standard 03h serial read command, with 24 address
/// bits, upon each XIP access. This is a very slow XIP configuration, but is very
/// widely supported. The debugger calls this function after performing a flash
/// erase/programming operation, so that the freshly-programmed code and data is
/// visible to the debug host, without having to know exactly what kind of flash
/// device is connected.
pub inline fn flash_enter_cmd_xip() *const signatures.flash_enter_cmd_xip {
    return @alignCast(@ptrCast(_rom_func_lookup(Code.flash_enter_cmd_xip)));
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Miscellaneous Functions (Datasheet p. 137)
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/// Resets the RP2040 and uses the watchdog facility to re-start in BOOTSEL mode:
/// - gpio_activity_pin_mask is provided to enable an "activity light" via
///   GPIO attached LED for the USB Mass Storage Device:
///   - 0 No pins are used as per a cold boot.
///   - Otherwise a single bit set indicating which GPIO pin should be set to output
///     and raised whenever there is mass storage activity from the host.
/// - disable_interface_mask may be used to control the exposed USB interfaces:
///   - 0 To enable both interfaces (as per a cold boot)
///   - 1 To disable the USB Mass Storage Interface (see Section 2.8.4)
///   - 2 To disable the USB PICOBOOT Interface (see Section 2.8.5)
pub inline fn reset_to_usb_boot() *const signatures.reset_to_usb_boot {
    return @alignCast(@ptrCast(_rom_func_lookup(Code.reset_to_usb_boot)));
}

/// This is the method that is entered by core 1 on reset to wait to be launched by core 0.
/// There are few cases where you should call this method (resetting core 1 is much better).
/// This method does not return and should only ever be called on core 1.
pub inline fn wait_for_vector() *const signatures.wait_for_vector {
    return @alignCast(@ptrCast(_rom_func_lookup(Code.wait_for_vector)));
}
