//! Access to functions and data in the RP2040 bootrom
//!
//! The Bootrom contains a number of public functions that provide useful RP2040 functionality that might be needed in
//! the absence of any other code on the device, as well as highly optimized versions of certain key functionality that would
//! otherwise have to take up space in most user binaries.
//!
//! The functions include:
//! 1. Fast Bit Counting / Manipulation Functions
//! 2. Fast Bulk Memory Fill / Copy Functions
//! 3. Flash Access Functions
//! 4. Debugging Support Functions
//! 5. Miscellaneous Functions

const std = @import("std");
const builtin = @import("builtin");
const microzig = @import("microzig");
const chip = microzig.hal.compatibility.chip;

pub const rom_func_table_ptr: usize = switch (builtin.cpu.arch) {
    .thumb => 0x00000014,
    .riscv32 => 0x00007df6,
    else => @compileError("unsupported architecture"),
};

pub const rom_table_lookup_val_ptr: usize = switch (builtin.cpu.arch) {
    .thumb => 0x00000016,
    .riscv32 => 0x00007df8,
    else => @compileError("unsupported architecture"),
};

pub const rom_table_lookup_entry_ptr: usize = switch (builtin.cpu.arch) {
    .thumb => 0x00000018,
    .riscv32 => 0x00007dfa,
    else => @compileError("unsupported architecture"),
};

/// Function codes to lookup public functions that provide useful RP2040 functionality
pub const Code = enum(u16) {
    pub const DisableInterfaceMask = enum(u32) {
        enable_all = 0,
        disable_mass_storage = 1,
        disable_picoboot = 2,
    };

    /// Return a count of the number of 1 bits in value
    popcount32 = rom_table_code('P', '3'), // Only avaiable on: RP2040

    /// Return the bits of value in the reverse order
    reverse32 = rom_table_code('R', '3'), // Only avaiable on: RP2040

    /// Return the number of consecutive high order 0 bits of value
    clz32 = rom_table_code('L', '3'), // Only avaiable on: RP2040

    /// Return the number of consecutive low order 0 bits of value
    ctz32 = rom_table_code('T', '3'), // Only avaiable on: RP2040

    /// Sets n bytes start at ptr to the value c and returns ptr
    memset = rom_table_code('M', 'S'), // Only avaiable on: RP2040

    /// Sets n bytes start at ptr to the value c and returns ptr; must be word (32-bit) aligned!
    memset4 = rom_table_code('S', '4'), // Only avaiable on: RP2040

    /// Copies n bytes starting at src to dest and returns dest. The results are undefined if the regions overlap.
    memcpy = rom_table_code('M', 'C'), // Only avaiable on: RP2040

    /// Copies n bytes starting at src to dest and returns dest; must be word (32-bit) aligned!
    memcpy44 = rom_table_code('C', '4'), // Only avaiable on: RP2040

    /// Restore all QSPI pad controls to their default state, and connect the SSI to the QSPI pads
    connect_internal_flash = rom_table_code('I', 'F'),

    /// First set up the SSI for serial-mode operations, then issue the fixed XIP exit sequence described in
    /// Section 2.8.1.2. Note that the bootrom code uses the IO forcing logic to drive the CS pin, which must be
    /// cleared before returning the SSI to XIP mode (e.g. by a call to _flash_flush_cache). This function
    /// configures the SSI with a fixed SCK clock divisor of /6.
    flash_exit_xip = rom_table_code('E', 'X'),

    /// Erase a count bytes, starting at addr (offset from start of flash). Optionally, pass a block erase command
    /// e.g. D8h block erase, and the size of the block erased by this command — this function will use the larger
    /// block erase where possible, for much higher erase speed. addr must be aligned to a 4096-byte sector, and
    /// count must be a multiple of 4096 bytes.
    flash_range_erase = rom_table_code('R', 'E'),

    /// Program data to a range of flash addresses starting at addr (offset from the start of flash) and count bytes
    /// in size. addr must be aligned to a 256-byte boundary, and count must be a multiple of 256.
    flash_range_program = rom_table_code('R', 'P'),

    /// Flush and enable the XIP cache. Also clears the IO forcing on QSPI CSn, so that the SSI can drive the
    /// flash chip select as normal.
    flash_flush_cache = rom_table_code('F', 'C'),

    /// Configure the SSI to generate a standard 03h serial read command, with 24 address bits, upon each XIP
    /// access. This is a very slow XIP configuration, but is very widely supported. The debugger calls this
    /// function after performing a flash erase/programming operation, so that the freshly-programmed code
    /// and data is visible to the debug host, without having to know exactly what kind of flash device is
    /// connected.
    flash_enter_cmd_xip = rom_table_code('C', 'X'),

    /// Simple debugger trampoline for break-on-return.
    /// This methods helps the debugger call ROM routines without setting hardware breakpoints. The function
    /// address is passed in r7 and args are passed through r0 … r3 as per ABI.
    /// This method does not return but executes a BKPT #0 at the end
    debug_trampoline = rom_table_code('D', 'T'), // Only avaiable on: RP2040

    /// This is the address of the final BKPT #0 instruction of debug_trampoline. This can be compared with the
    /// program counter to detect completion of the debug_trampoline call
    debug_trampoline_end = rom_table_code('D', 'E'), // Only avaiable on: RP2040

    /// Resets the RP2040 and uses the watchdog facility to re-start in BOOTSEL mode:
    reset_to_usb_boot = rom_table_code('U', 'B'), // Only avaiable on: RP2040, a more capable alternative is available

    /// This is the method that is entered by core 1 on reset to wait to be launched by core 0. There are few
    /// cases where you should call this method (resetting core 1 is much better). This method does not return
    /// and should only ever be called on core 1
    wait_for_vector = rom_table_code('W', 'V'), // Only avaiable on: RP2040 (?)

    /// Signatures of all public bootrom functions
    pub fn signature(self: @This()) type {
        return switch (self) {
            .popcount32 => fn (value: u32) callconv(.C) u32,
            .reverse32 => fn (value: u32) callconv(.C) u32,
            .clz32 => fn (value: u32) callconv(.C) u32,
            .ctz32 => fn (value: u32) callconv(.C) u32,
            .memset => fn (ptr: [*]u8, c: u8, n: u32) callconv(.C) [*]u8,
            .memset4 => fn (ptr: [*]u32, c: u8, n: u32) callconv(.C) [*]u32,
            .memcpy => fn (dest: [*]u8, src: [*]const u8, n: u32) callconv(.C) [*]u8,
            .memcpy44 => fn (dest: [*]u32, src: [*]const u32, n: u32) callconv(.C) [*]u8,
            .connect_internal_flash => fn () callconv(.C) void,
            .flash_exit_xip => fn () callconv(.C) void,
            .flash_range_erase => fn (addr: u32, count: usize, block_size: u32, block_cmd: u8) callconv(.C) void,
            .flash_range_program => fn (addr: u32, data: [*]const u8, count: usize) callconv(.C) void,
            .flash_flush_cache => fn () callconv(.C) void,
            .flash_enter_cmd_xip => fn () callconv(.C) void,
            .debug_trampoline => fn () callconv(.C) void,
            .debug_trampoline_end => fn () callconv(.C) void,
            .reset_to_usb_boot => fn (gpio_activity_pin_mask: u32, disable_interface_mask: DisableInterfaceMask) callconv(.C) noreturn,
            .wait_for_vector => fn () callconv(.C) noreturn,
        };
    }
};

/// Union of all possible function signatures returned by flash lookup
pub const RomFuncPtr = blk: {
    var ret = @typeInfo(extern union {}).Union;
    for (@typeInfo(Code).Enum.fields) |fld| {
        const sig = *const @field(Code, fld.name).signature();
        ret.fields = ret.fields ++ .{.{ .name = fld.name, .type = sig, .alignment = @alignOf(sig) }};
    }
    break :blk @Type(.{ .Union = ret });
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
pub fn rom_table_code(c1: u8, c2: u8) u16 {
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
    const ptr_to_ptr: *u16 = @ptrFromInt(rom_addr);
    return @ptrFromInt(ptr_to_ptr.*);
}

/// Lookup a bootrom function by code (comptime)
///
/// # Parameters
/// * `code` - code of the function (see codes)
///
/// # Returns
///
/// A anyopaque pointer to the function; must be cast by the caller
pub inline fn _rom_func_lookup(comptime code: Code) *const code.signature() {
    return @field(@call(.always_inline, rom_func_lookup, .{code}), @tagName(code));
}

/// Lookup a bootrom function by code
///
/// # Parameters
/// * `code` - code of the function (see codes)
///
/// # Returns
///
/// A anyopaque pointer to the function; must be cast by the caller
pub fn rom_func_lookup(code: Code) *RomFuncPtr {
    const rom_table_lookup: *fn (table: [*]u16, code: u32) *RomFuncPtr = @ptrCast(rom_hword_as_ptr(rom_table_lookup_entry_ptr));
    const func_table: [*]u16 = @ptrCast(@alignCast(rom_hword_as_ptr(0x14)));
    return rom_table_lookup(func_table, @intFromEnum(code));
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Fast Bit Counting / Manipulation Functions (Datasheet p. 135)
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/// Return a count of the number of 1 bits in value
pub fn popcount32(value: u32) u32 {
    const S = struct {
        var f: ?*const Code.popcount32.signature() = null;
    };

    switch (chip) {
        .RP2040 => {
            if (S.f == null)
                S.f = _rom_func_lookup(Code.popcount32);
            return S.f.?(value);
        },
        .RP2350 => return @popCount(value),
    }
}

/// Return a count of the number of 1 bits in value
pub fn reverse32(value: u32) u32 {
    const S = struct {
        var f: ?*const Code.reverse32.signature() = null;
    };

    switch (chip) {
        .RP2040 => {
            if (S.f == null)
                S.f = _rom_func_lookup(Code.reverse32);
            return S.f.?(value);
        },
        // RP2350, supports fast assembly version
        .RP2350 => return @bitReverse(value),
    }
}

/// Return the number of consecutive high order 0 bits of value
pub fn clz32(value: u32) u32 {
    const S = struct {
        var f: ?*const Code.clz32.signature() = null;
    };

    switch (chip) {
        .RP2040 => {
            if (S.f == null)
                S.f = _rom_func_lookup(Code.clz32);
            return S.f.?(value);
        },
        // RP2350, supports fast assembly version
        .RP2350 => return @clz(value),
    }
}

/// Return the number of consecutive low order 0 bits of value
pub fn ctz32(value: u32) u32 {
    const S = struct {
        var f: ?*const Code.ctz32.signature() = null;
    };

    switch (chip) {
        .RP2040 => {
            if (S.f == null)
                S.f = _rom_func_lookup(Code.ctz32);
            return S.f.?(value);
        },
        // RP2350, supports fast assembly version
        .RP2350 => return @ctz(value),
    }
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Fast Bulk Memory Fill / Copy Functions (Datasheet p. 136)
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/// Sets all bytes of dest to the value c and returns ptr
pub fn memset(dest: []u8, c: u8) []u8 {
    const S = struct {
        var f: ?*const Code.memset.signature() = null;
    };

    switch (chip) {
        .RP2040 => {
            if (S.f == null)
                S.f = _rom_func_lookup(Code.memset);
            return S.f.?(dest.ptr, c, dest.len)[0..dest.len];
        },
        .RP2350 => {
            @memset(dest, c);
            return dest;
        },
    }
}

/// Copies n bytes from src to dest; The number of bytes copied is the size of the smaller slice
pub fn memcpy(dest: []u8, src: []const u8) []u8 {
    const S = struct {
        var f: ?*const Code.memcpy.signature() = null;
    };

    switch (chip) {
        .RP2040 => {
            const n = @min(dest.len, src.len);
            if (S.f == null)
                S.f = _rom_func_lookup(Code.memcpy);
            return S.f.?(dest.ptr, src.ptr, n)[0..n];
        },
        // For some reason @memcpy crash chip with HardFault interrupt (UNALIGNED)
        .RP2350 => {
            std.mem.copyForwards(u8, dest, src);
            return dest;
        },
    }
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Flash Access Functions (Datasheet p. 137)
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/// Restore all QSPI pad controls to their default state, and connect the SSI to the QSPI pads
pub inline fn connect_internal_flash() *const Code.connect_internal_flash.signature() {
    return _rom_func_lookup(Code.connect_internal_flash);
}

/// First set up the SSI for serial-mode operations, then issue the fixed XIP exit
/// sequence described in Section 2.8.1.2. Note that the bootrom code uses the IO
/// forcing logic to drive the CS pin, which must be cleared before returning the
/// SSI to XIP mode (e.g. by a call to _flash_flush_cache). This function configures
/// the SSI with a fixed SCK clock divisor of /6.
pub inline fn flash_exit_xip() *const Code.flash_exit_xip.signature() {
    return _rom_func_lookup(Code.flash_exit_xip);
}

/// Erase a count bytes, starting at addr (offset from start of flash). Optionally,
/// pass a block erase command e.g. D8h block erase, and the size of the block
/// erased by this command — this function will use the larger block erase where
/// possible, for much higher erase speed. addr must be aligned to a 4096-byte sector,
/// and count must be a multiple of 4096 bytes.
pub inline fn flash_range_erase() *const Code.flash_range_erase.signature() {
    return _rom_func_lookup(Code.flash_range_erase);
}

/// Program data to a range of flash addresses starting at addr (offset from the
/// start of flash) and count bytes in size. addr must be aligned to a 256-byte
/// boundary, and the length of data must be a multiple of 256.
pub inline fn flash_range_program() *const Code.flash_range_program.signature() {
    return _rom_func_lookup(Code.flash_range_program);
}

/// Flush and enable the XIP cache. Also clears the IO forcing on QSPI CSn, so that
/// the SSI can drive the flash chip select as normal.
pub inline fn flash_flush_cache() *const Code.flash_flush_cache.signature() {
    return _rom_func_lookup(Code.flash_flush_cache);
}

/// Configure the SSI to generate a standard 03h serial read command, with 24 address
/// bits, upon each XIP access. This is a very slow XIP configuration, but is very
/// widely supported. The debugger calls this function after performing a flash
/// erase/programming operation, so that the freshly-programmed code and data is
/// visible to the debug host, without having to know exactly what kind of flash
/// device is connected.
pub inline fn flash_enter_cmd_xip() *const Code.flash_enter_cmd_xip.signature() {
    return _rom_func_lookup(Code.flash_enter_cmd_xip);
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Debugging Support Functions (Datasheet p. 137)
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/// Simple debugger trampoline for break-on-return.
/// This methods helps the debugger call ROM routines without setting hardware breakpoints. The function
/// address is passed in r7 and args are passed through r0 … r3 as per ABI.
/// This method does not return but executes a BKPT #0 at the end
pub inline fn debug_trampoline() *const Code.debug_trampoline.signature() {
    switch (chip) {
        .RP2040 => return _rom_func_lookup(Code.debug_trampoline),
        .RP2350 => @compileError("not available on RP2350"),
    }
}

/// This is the address of the final BKPT #0 instruction of debug_trampoline. This can be compared with the
/// program counter to detect completion of the debug_trampoline call
pub inline fn debug_trampoline_end() *const Code.debug_trampoline_end.signature() {
    switch (chip) {
        .RP2040 => return _rom_func_lookup(Code.debug_trampoline_end),
        .RP2350 => @compileError("not available on RP2350"),
    }
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Miscellaneous Functions (Datasheet p. 137)
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/// Resets the RP2040 and uses the watchdog facility to re-start in BOOTSEL mode:
pub inline fn reset_to_usb_boot() *const Code.reset_to_usb_boot.signature() {
    switch (chip) {
        .RP2040 => return _rom_func_lookup(Code.reset_to_usb_boot),
        .RP2350 => @compileError("not available on RP2350"),
    }
}

/// This is the method that is entered by core 1 on reset to wait to be launched by core 0. There are few
/// cases where you should call this method (resetting core 1 is much better). This method does not return
/// and should only ever be called on core 1
pub inline fn wait_for_vector() *const Code.wait_for_vector.signature() {
    switch (chip) {
        .RP2040 => return _rom_func_lookup(Code.wait_for_vector),
        .RP2350 => @compileError("not available on RP2350"),
    }
}
