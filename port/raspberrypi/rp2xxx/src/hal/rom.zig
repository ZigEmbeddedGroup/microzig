//! Access to functions and data in the RP2XXX bootrom.
//!
//! The Bootrom contains a number of public functions that provide useful RP2040
//! functionality that might be needed in the absence of any other code on the
//! device, as well as highly optimized versions of certain key functionality
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
const compatibility = @import("compatibility.zig");
const arch = compatibility.arch;
const chip = compatibility.chip;
const options = microzig.options.hal;

pub fn get_version_number() u8 {
    const VERSION_NUMBER: *const u8 = @ptrFromInt(0x0000_0013);
    return VERSION_NUMBER.*;
}

pub const chip_specific = switch (chip) {
    .RP2040 => struct {
        const LookupFn = fn (table: *const anyopaque, code: u32) callconv(.c) ?*const anyopaque;

        const ROM_TABLE_LOOKUP: *const u16 = @ptrFromInt(0x0000_0018);

        const FUNC_TABLE: *const u16 = @ptrFromInt(0x0000_0014);
        const DATA_TABLE: *const u16 = @ptrFromInt(0x0000_0016);

        inline fn rom_fn_lookup(code: [2]u8) ?*const anyopaque {
            const rom_table_lookup: *const LookupFn = @ptrFromInt(ROM_TABLE_LOOKUP.*);
            const func_table: *const anyopaque = @ptrFromInt(FUNC_TABLE.*);
            return rom_table_lookup(func_table, std.mem.readInt(u16, &code, .little));
        }

        inline fn rom_data_lookup(code: [2]u8) ?*const anyopaque {
            const rom_table_lookup: *const LookupFn = @ptrFromInt(ROM_TABLE_LOOKUP.*);
            const data_table: *const anyopaque = @ptrFromInt(DATA_TABLE.*);
            return rom_table_lookup(data_table, std.mem.readInt(u16, &code, .little));
        }

        pub inline fn get_rom_data(comptime info: RomDataInfo) info.Type {
            return @alignCast(@ptrCast(chip_specific.rom_data_lookup(info.code)));
        }

        pub fn get_rom_data_cached(comptime info: RomDataInfo) info.Type {
            const S = struct {
                var f: ?info.Type = null;
            };

            if (S.f == null) S.f = get_rom_data(info);
            return S.f.?;
        }

        pub const RomDataInfo = struct {
            Type: type,
            code: [2]u8,
            min_version: ?u8 = null,

            pub const copyright_string: RomDataInfo = .{ .Type = [*]const u8, .code = .{ 'C', 'R' } };
            pub const git_revision: RomDataInfo = .{ .Type = [*]const u32, .code = .{ 'G', 'R' } };
            pub const fplib_start: RomDataInfo = .{ .Type = *const anyopaque, .code = .{ 'F', 'S' } };
            pub const soft_float_table: RomDataInfo = .{ .Type = *const anyopaque, .code = .{ 'S', 'F' } };
            pub const fplib_end: RomDataInfo = .{ .Type = *const anyopaque, .code = .{ 'F', 'E' } };
            pub const soft_double_table: RomDataInfo = .{ .Type = *const anyopaque, .code = .{ 'S', 'D' }, .min_version = 2 };
        };

        pub inline fn get_rom_fn(comptime info: RomFnInfo) *const info.Signature {
            return @alignCast(@ptrCast(chip_specific.rom_fn_lookup(info.code)));
        }

        pub fn get_rom_fn_cached(comptime info: RomFnInfo) *const info.Signature {
            const S = struct {
                var f: ?*const info.Signature = null;
            };

            if (S.f == null) S.f = get_rom_fn(info);
            return S.f.?;
        }

        pub const RomFnInfo = struct {
            Signature: type,
            code: [2]u8,

            pub const popcount32: RomFnInfo = .{ .Signature = fn (value: u32) callconv(.c) u32, .code = .{ 'P', '3' } };
            pub const reverse32: RomFnInfo = .{ .Signature = fn (value: u32) callconv(.c) u32, .code = .{ 'R', '3' } };
            pub const clz32: RomFnInfo = .{ .Signature = fn (value: u32) callconv(.c) u32, .code = .{ 'L', '3' } };
            pub const ctz32: RomFnInfo = .{ .Signature = fn (value: u32) callconv(.c) u32, .code = .{ 'T', '3' } };

            pub const memset: RomFnInfo = .{ .Signature = fn (ptr: [*]u8, c: u8, n: usize) callconv(.c) [*]u8, .code = .{ 'M', 'S' } };
            pub const memset4: RomFnInfo = .{ .Signature = fn (ptr: [*]u32, c: u8, n: usize) callconv(.c) [*]u32, .code = .{ 'S', '4' } };
            pub const memcpy: RomFnInfo = .{ .Signature = fn (dest: [*]u8, src: [*]const u8, n: usize) callconv(.c) [*]u8, .code = .{ 'M', 'C' } };
            pub const memcpy44: RomFnInfo = .{ .Signature = fn (dest: [*]u32, src: [*]const u32, n: usize) callconv(.c) [*]u8, .code = .{ 'C', '4' } };

            pub const connect_internal_flash: RomFnInfo = .{ .Signature = fn () callconv(.c) void, .code = .{ 'I', 'F' } };
            pub const flash_exit_xip: RomFnInfo = .{ .Signature = fn () callconv(.c) void, .code = .{ 'E', 'X' } };
            pub const flash_range_erase: RomFnInfo = .{ .Signature = fn (addr: u32, count: usize, block_size: u32, block_cmd: u8) callconv(.c) void, .code = .{ 'R', 'E' } };
            pub const flash_range_program: RomFnInfo = .{ .Signature = fn (addr: u32, data: [*]const u8, count: usize) callconv(.c) void, .code = .{ 'R', 'P' } };
            pub const flash_flush_cache: RomFnInfo = .{ .Signature = fn () callconv(.c) void, .code = .{ 'F', 'C' } };
            pub const flash_enter_cmd_xip: RomFnInfo = .{ .Signature = fn () callconv(.c) void, .code = .{ 'C', 'X' } };

            // TODO: Is the signature correct?
            pub const debug_trampoline: RomFnInfo = .{ .Signature = fn () callconv(.c) void, .code = .{ 'D', 'T' } };
            // TODO: Is the signature correct?
            pub const debug_trampoline_end: RomFnInfo = .{ .Signature = fn () callconv(.c) void, .code = .{ 'D', 'E' } };

            pub const reset_to_usb_boot: RomFnInfo = .{ .Signature = fn (gpio_activity_pin_mask: u32, disable_interface_mask: u32) callconv(.c) noreturn, .code = .{ 'U', 'B' } };
            pub const wait_for_vector: RomFnInfo = .{ .Signature = fn () callconv(.c) noreturn, .code = .{ 'W', 'V' } };
        };

        // TODO: maybe support copying the table to ram as well?
        pub inline fn get_float_fn(info: FloatFnInfo) *const info.Signature {
            if (info.min_version) |min_version| {
                if (get_version_number() < min_version) @panic("function not available in this bootrom version");
            }

            const table: [*]const usize = @alignCast(@ptrCast(get_rom_data_cached(.soft_float_table)));
            return @ptrFromInt(table[info.offset / 4]);
        }

        pub const FloatFnInfo = struct {
            Signature: type,
            offset: usize,
            min_version: ?u8 = null,

            pub const fadd: FloatFnInfo = .{ .Signature = fn (f32, f32) callconv(.c) f32, .offset = 0x00 };
            pub const fsub: FloatFnInfo = .{ .Signature = fn (f32, f32) callconv(.c) f32, .offset = 0x04 };
            pub const fmul: FloatFnInfo = .{ .Signature = fn (f32, f32) callconv(.c) f32, .offset = 0x08 };
            pub const fdiv: FloatFnInfo = .{ .Signature = fn (f32, f32) callconv(.c) f32, .offset = 0x0c };

            pub const fsqrt: FloatFnInfo = .{ .Signature = fn (f32) callconv(.c) f32, .offset = 0x18 };
            pub const float_to_int: FloatFnInfo = .{ .Signature = fn (f32) callconv(.c) i32, .offset = 0x1c };
            pub const float_to_fix: FloatFnInfo = .{ .Signature = fn (f32, i32) callconv(.c) i32, .offset = 0x20 };
            pub const float_to_uint: FloatFnInfo = .{ .Signature = fn (f32) callconv(.c) u32, .offset = 0x24 };
            pub const float_to_ufix: FloatFnInfo = .{ .Signature = fn (f32, i32) callconv(.c) u32, .offset = 0x28 };
            pub const int_to_float: FloatFnInfo = .{ .Signature = fn (i32) callconv(.c) f32, .offset = 0x2c };
            pub const fix_to_float: FloatFnInfo = .{ .Signature = fn (i32, i32) callconv(.c) f32, .offset = 0x30 };
            pub const uint_to_float: FloatFnInfo = .{ .Signature = fn (u32) callconv(.c) f32, .offset = 0x34 };
            pub const ufix_to_float: FloatFnInfo = .{ .Signature = fn (u32, i32) callconv(.c) f32, .offset = 0x38 };
            pub const fcos: FloatFnInfo = .{ .Signature = fn (f32) callconv(.c) f32, .offset = 0x3c };
            pub const fsin: FloatFnInfo = .{ .Signature = fn (f32) callconv(.c) f32, .offset = 0x40 };
            pub const ftan: FloatFnInfo = .{ .Signature = fn (f32) callconv(.c) f32, .offset = 0x44 };
            pub const fexp: FloatFnInfo = .{ .Signature = fn (f32) callconv(.c) f32, .offset = 0x4c };
            pub const fln: FloatFnInfo = .{ .Signature = fn (f32) callconv(.c) f32, .offset = 0x50 };

            pub const fcmp: FloatFnInfo = .{ .Signature = fn (f32, f32) callconv(.c) i32, .offset = 0x54, .min_version = 2 };
            pub const fatan2: FloatFnInfo = .{ .Signature = fn (f32, f32) callconv(.c) f32, .offset = 0x58, .min_version = 2 };
            pub const int64_to_float: FloatFnInfo = .{ .Signature = fn (i64) callconv(.c) f32, .offset = 0x5c, .min_version = 2 };
            pub const fix64_to_float: FloatFnInfo = .{ .Signature = fn (i64, i32) callconv(.c) f32, .offset = 0x60, .min_version = 2 };
            pub const uint64_to_float: FloatFnInfo = .{ .Signature = fn (u64) callconv(.c) f32, .offset = 0x64, .min_version = 2 };
            pub const ufix64_to_float: FloatFnInfo = .{ .Signature = fn (u64, i32) callconv(.c) f32, .offset = 0x68, .min_version = 2 };
            pub const float_to_int64: FloatFnInfo = .{ .Signature = fn (f32) callconv(.c) i64, .offset = 0x6c, .min_version = 2 };
            pub const float_to_fix64: FloatFnInfo = .{ .Signature = fn (f32, i32) callconv(.c) i64, .offset = 0x70, .min_version = 2 };
            pub const float_to_uint64: FloatFnInfo = .{ .Signature = fn (f32) callconv(.c) u64, .offset = 0x74, .min_version = 2 };
            pub const float_to_ufix64: FloatFnInfo = .{ .Signature = fn (f32, i32) callconv(.c) u64, .offset = 0x78, .min_version = 2 };
            pub const float_to_double: FloatFnInfo = .{ .Signature = fn (f32) callconv(.c) f64, .offset = 0x7c, .min_version = 2 };

            /// The sin result is in r0 (official return value) and the cos
            /// result is in r1. Is it possible to express the signature in
            /// terms of this?
            pub const fsincos: FloatFnInfo = .{ .Signature = fn (f32) callconv(.c) f32, .offset = 0x48, .min_version = 3 };
        };

        pub inline fn get_double_fn(info: DoubleFnInfo) *const info.Signature {
            if (info.min_version) |min_version| {
                if (get_version_number() < min_version) @panic("function not available in this bootrom version");
            }

            const table: [*]const usize = @alignCast(@ptrCast(get_rom_data_cached(.soft_double_table)));
            return @ptrFromInt(table[info.offset / 4]);
        }

        // Only available from v2 onwards
        pub const DoubleFnInfo = struct {
            Signature: type,
            offset: usize,
            min_version: ?u8 = null,

            pub const dadd: DoubleFnInfo = .{ .Signature = fn (f64, f64) callconv(.c) f64, .offset = 0x00 };
            pub const dsub: DoubleFnInfo = .{ .Signature = fn (f64, f64) callconv(.c) f64, .offset = 0x04 };
            pub const dmul: DoubleFnInfo = .{ .Signature = fn (f64, f64) callconv(.c) f64, .offset = 0x08 };
            pub const ddiv: DoubleFnInfo = .{ .Signature = fn (f64, f64) callconv(.c) f64, .offset = 0x0c };

            pub const dsqrt: DoubleFnInfo = .{ .Signature = fn (f64) callconv(.c) f64, .offset = 0x18 };
            pub const double_to_int: DoubleFnInfo = .{ .Signature = fn (f64) callconv(.c) i64, .offset = 0x1c };
            pub const double_to_fix: DoubleFnInfo = .{ .Signature = fn (f64, i32) callconv(.c) i64, .offset = 0x20 };
            pub const double_to_uint: DoubleFnInfo = .{ .Signature = fn (f64) callconv(.c) u64, .offset = 0x24 };
            pub const double_to_ufix: DoubleFnInfo = .{ .Signature = fn (f64, i32) callconv(.c) u64, .offset = 0x28 };
            pub const int_to_double: DoubleFnInfo = .{ .Signature = fn (i32) callconv(.c) f64, .offset = 0x2c };
            pub const fix_to_double: DoubleFnInfo = .{ .Signature = fn (i32, i32) callconv(.c) f64, .offset = 0x30 };
            pub const uint_to_double: DoubleFnInfo = .{ .Signature = fn (u32) callconv(.c) f64, .offset = 0x34 };
            pub const ufix_to_double: DoubleFnInfo = .{ .Signature = fn (u32, i32) callconv(.c) f64, .offset = 0x38 };
            pub const dcos: DoubleFnInfo = .{ .Signature = fn (f64) callconv(.c) f64, .offset = 0x3c };
            pub const dsin: DoubleFnInfo = .{ .Signature = fn (f64) callconv(.c) f64, .offset = 0x40 };
            pub const dtan: DoubleFnInfo = .{ .Signature = fn (f64) callconv(.c) f64, .offset = 0x44 };
            pub const dexp: DoubleFnInfo = .{ .Signature = fn (f64) callconv(.c) f64, .offset = 0x4c };
            pub const dln: DoubleFnInfo = .{ .Signature = fn (f64) callconv(.c) f64, .offset = 0x50 };

            pub const dcmp: DoubleFnInfo = .{ .Signature = fn (f64, f64) callconv(.c) i32, .offset = 0x54 };
            pub const datan2: DoubleFnInfo = .{ .Signature = fn (f64, f64) callconv(.c) f64, .offset = 0x58 };
            pub const int64_to_double: DoubleFnInfo = .{ .Signature = fn (i64) callconv(.c) f64, .offset = 0x5c };
            pub const fix64_to_double: DoubleFnInfo = .{ .Signature = fn (i64, i32) callconv(.c) f64, .offset = 0x60 };
            pub const uint64_to_double: DoubleFnInfo = .{ .Signature = fn (u64) callconv(.c) f64, .offset = 0x64 };
            pub const ufix64_to_double: DoubleFnInfo = .{ .Signature = fn (u64, i32) callconv(.c) f64, .offset = 0x68 };
            pub const double_to_int64: DoubleFnInfo = .{ .Signature = fn (f64) callconv(.c) i64, .offset = 0x6c };
            pub const double_to_fix64: DoubleFnInfo = .{ .Signature = fn (f64, i32) callconv(.c) i64, .offset = 0x70 };
            pub const double_to_uint64: DoubleFnInfo = .{ .Signature = fn (f64) callconv(.c) u64, .offset = 0x74 };
            pub const double_to_ufix64: DoubleFnInfo = .{ .Signature = fn (f64, i32) callconv(.c) u64, .offset = 0x78 };
            pub const double_to_float: DoubleFnInfo = .{ .Signature = fn (f64) callconv(.c) f32, .offset = 0x7c };

            /// The sin result is in r0/r1 (official return value) and the cos
            /// result is in r2/r3. Is it possible to express the signature in
            /// terms of this?
            pub const sincos: DoubleFnInfo = .{ .Signature = fn (f64) callconv(.c) f64, .offset = 0x48, .min_version = 3 };
        };
    },
    .RP2350 => struct {
        const ROM_TABLE_LOOKUP_A1: *const u32 = switch (arch) {
            .arm => @ptrFromInt(0x0000_0018),
            .riscv => @ptrFromInt(0x0000_7DF8),
        };
        const ROM_TABLE_LOOKUP_A2: *const u16 = switch (arch) {
            .arm => @ptrFromInt(0x0000_0016),
            .riscv => @ptrFromInt(0x0000_7DFA),
        };

        const ROM_DATA_LOOKUP_A1: *const u32 = switch (arch) {
            .arm => @ptrFromInt(ROM_TABLE_LOOKUP_A1),
            .riscv => @ptrFromInt(0x0000_7DF8),
        };
        const ROM_DATA_LOOKUP_A2: *const u16 = switch (arch) {
            .arm => @ptrFromInt(ROM_TABLE_LOOKUP_A2),
            .riscv => @ptrFromInt(0x0000_7DF4),
        };

        const LookupFn = fn (code: u32, mask: u32) callconv(.c) ?*const anyopaque;

        pub const Mask = enum(u32) {
            riscv = 0x0001,
            arm_s = 0x0004,
            arm_ns = 0x0010,

            pub const riscv_or_arm_s: Mask = switch (arch) {
                .arm => .arm_s,
                .riscv => .riscv,
            };

            inline fn validate(mask: Mask) void {
                switch (arch) {
                    .arm => if (mask == .riscv) @compileError("Function not available on ARM"),
                    .riscv => if (mask != .riscv) @compileError("Function not available on RISC-V"),
                }
            }
        };

        inline fn rom_fn_lookup(code: [2]u8, mask: Mask) ?*const anyopaque {
            const rom_table_lookup_fn: *const LookupFn = @ptrFromInt(if (get_version_number() < 2)
                ROM_TABLE_LOOKUP_A1.*
            else
                ROM_TABLE_LOOKUP_A2.*);
            return rom_table_lookup_fn(std.mem.readInt(u16, &code, .little), @intFromEnum(mask));
        }

        inline fn rom_data_lookup(code: [2]u8) ?*const anyopaque {
            const rom_data_lookup_fn: *const LookupFn = @ptrFromInt(if (get_version_number() < 2)
                ROM_DATA_LOOKUP_A1.*
            else
                ROM_DATA_LOOKUP_A2.*);
            return rom_data_lookup_fn(std.mem.readInt(u16, &code, .little), 0x40); // 0x40 = data mask
        }

        pub inline fn get_rom_fn(comptime info: RomFnInfo) *const info.Signature {
            info.mask.validate();
            return @alignCast(@ptrCast(chip_specific.rom_fn_lookup(info.code, info.mask)));
        }

        pub fn get_rom_fn_cached(comptime info: RomFnInfo) *const info.Signature {
            info.mask.validate();

            const S = struct {
                var f: ?*const info.Signature = null;
            };

            if (S.f == null) S.f = @alignCast(@ptrCast(chip_specific.rom_fn_lookup(info.code, info.mask)));
            return S.f.?;
        }

        pub const RomFnInfo = struct {
            Signature: type,
            code: [2]u8,
            mask: Mask,

            pub const connect_internal_flash: RomFnInfo = .{ .Signature = fn () callconv(.c) void, .code = .{ 'I', 'F' }, .mask = .riscv_or_arm_s };
            pub const flash_enter_cmd_xip: RomFnInfo = .{ .Signature = fn () callconv(.c) void, .code = .{ 'C', 'X' }, .mask = .riscv_or_arm_s };
            pub const flash_exit_xip: RomFnInfo = .{ .Signature = fn () callconv(.c) void, .code = .{ 'E', 'X' }, .mask = .riscv_or_arm_s };
            pub const flash_flush_cache: RomFnInfo = .{ .Signature = fn () callconv(.c) void, .code = .{ 'F', 'C' }, .mask = .riscv_or_arm_s };
            pub const flash_range_erase: RomFnInfo = .{ .Signature = fn (u32, usize, u32, u8) callconv(.c) void, .code = .{ 'R', 'E' }, .mask = .riscv_or_arm_s };
            pub const flash_range_program: RomFnInfo = .{ .Signature = fn (u32, [*]const u8, usize) callconv(.c) void, .code = .{ 'R', 'P' }, .mask = .riscv_or_arm_s };
            pub const flash_reset_address_translate: RomFnInfo = .{ .Signature = fn () callconv(.c) void, .code = .{ 'R', 'A' }, .mask = .riscv_or_arm_s };
            pub const flash_select_xip_read_mode: RomFnInfo = .{ .Signature = fn () callconv(.c) void, .code = .{ 'S', 'X' }, .mask = .riscv_or_arm_s };

            pub const flash_op: RomFnInfo = .{ .Signature = fn (u32, u32, u32, u32) callconv(.c) i32, .code = .{ 'F', 'O' }, .mask = .riscv_or_arm_s };
            pub const flash_op_ns: RomFnInfo = .{ .Signature = fn (u32, u32, u32, u32) callconv(.c) i32, .code = .{ 'F', 'O' }, .mask = .arm_ns };
            pub const flash_runtime_to_storage_addr: RomFnInfo = .{ .Signature = fn (u32) callconv(.c) i32, .code = .{ 'F', 'A' }, .mask = .riscv_or_arm_s };
            pub const flash_runtime_to_storage_addr_ns: RomFnInfo = .{ .Signature = fn (u32) callconv(.c) i32, .code = .{ 'F', 'A' }, .mask = .arm_ns };

            pub const reboot: RomFnInfo = .{ .Signature = fn (flags: u32, delay_ms: u32, p0: u32, p1: u32) callconv(.c) i32, .code = .{ 'R', 'B' }, .mask = .riscv_or_arm_s };
            pub const reboot_ns: RomFnInfo = .{ .Signature = fn (flags: u32, delay_ms: u32, p0: u32, p1: u32) callconv(.c) i32, .code = .{ 'R', 'B' }, .mask = .arm_ns };
        };

        pub const ErrorCode = enum(i32) {
            not_permitted = -4,
            invalid_argument = -5,
            invalid_address = -10,
            bad_alignment = -11,
            invalid_state = -12,
            buffer_too_small = -13,
            precondition_not_met = -14,
            modified_data = -15,
            invalid_data = -16,
            not_found = -17,
            unsupported_modification = -18,
            lock_required = -19,

            fn from_int(x: i32) ?ErrorCode {
                return std.meta.intToEnum(ErrorCode, x) catch null;
            }
        };
    },
};

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Fast Bit Counting / Manipulation Functions (Datasheet p. 135)
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/// Return a count of the number of 1 bits in value
pub fn popcount32(value: u32) u32 {
    return switch (chip) {
        .RP2040 => return chip_specific.get_rom_fn_cached(.popcount32)(value),
        // RP2350, supports fast assembly version
        .RP2350 => return @popCount(value),
    };
}

/// Return a count of the number of 1 bits in value
pub fn reverse32(value: u32) u32 {
    return switch (chip) {
        .RP2040 => return chip_specific.get_rom_fn_cached(.reverse32)(value),
        // RP2350, supports fast assembly version
        .RP2350 => return @bitReverse(value),
    };
}

/// Return the number of consecutive high order 0 bits of value
pub fn clz32(value: u32) u32 {
    return switch (chip) {
        .RP2040 => return chip_specific.get_rom_fn_cached(.clz32)(value),
        // RP2350, supports fast assembly version
        .RP2350 => return @clz(value),
    };
}

/// Return the number of consecutive low order 0 bits of value
pub fn ctz32(value: u32) u32 {
    return switch (chip) {
        .RP2040 => return chip_specific.get_rom_fn_cached(.ctz32)(value),
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
        .RP2040 => return chip_specific.get_rom_fn_cached(.memset)(dest.ptr, c, dest.len),
        .RP2350 => @memset(dest, c),
    };
}

/// Copies n bytes from src to dest; The number of bytes copied is the size of the smaller slice
pub fn memcpy(dest: []u8, src: []const u8) []u8 {
    return switch (chip) {
        .RP2040 => return chip_specific.get_rom_fn_cached(.memcpy)(dest.ptr, src.ptr, dest.len),
        .RP2350 => @memcpy(dest, src),
    };
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Flash Access Functions (Datasheet p. 137)
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/// Restore all QSPI pad controls to their default state, and connect the SSI to
/// the QSPI pads
pub inline fn connect_internal_flash() void {
    chip_specific.get_rom_fn(.connect_internal_flash)();
}

/// Configure the SSI to generate a standard 03h serial read command, with 24
/// address bits, upon each XIP access. This is a very slow XIP configuration,
/// but is very widely supported. The debugger calls this function after
/// performing a flash erase/programming operation, so that the
/// freshly-programmed code and data is visible to the debug host, without
/// having to know exactly what kind of flash device is connected.
pub inline fn flash_enter_cmd_xip() void {
    chip_specific.get_rom_fn(.flash_enter_cmd_xip)();
}

/// First set up the SSI for serial-mode operations, then issue the fixed XIP
/// exit sequence described in Section 2.8.1.2. Note that the bootrom code uses
/// the IO forcing logic to drive the CS pin, which must be cleared before
/// returning the SSI to XIP mode (e.g. by a call to _flash_flush_cache). This
/// function configures the SSI with a fixed SCK clock divisor of /6.
pub inline fn flash_exit_xip() void {
    chip_specific.get_rom_fn(.flash_exit_xip)();
}

/// This is the method that is entered by core 1 on reset to wait to be launched by core 0.
/// There are few cases where you should call this method (resetting core 1 is much better).
/// This method does not return and should only ever be called on core 1.
pub inline fn flash_flush_cache() void {
    chip_specific.get_rom_fn(.flash_flush_cache)();
}

/// Erase a count bytes, starting at addr (offset from start of flash).
/// Optionally, pass a block erase command e.g. D8h block erase, and the size of
/// the block erased by this command — this function will use the larger block
/// erase where possible, for much higher erase speed. addr must be aligned to a
/// 4096-byte sector, and count must be a multiple of 4096 bytes.
pub inline fn flash_range_erase(addr: u32, count: usize, block_size: u32, block_cmd: u8) void {
    chip_specific.get_rom_fn(.flash_range_erase)(addr, count, block_size, block_cmd);
}

/// Program data to a range of flash addresses starting at addr (offset from the
/// start of flash) and count bytes in size. addr must be aligned to a 256-byte
/// boundary, and the length of data must be a multiple of 256.
pub inline fn flash_range_program(addr: u32, data: []const u8) void {
    chip_specific.get_rom_fn(.flash_range_program)(addr, data.ptr, data.len);
}

/// Reset to USB bootloader function based on rom.
pub fn reset_to_usb_boot() void {
    switch (chip) {
        .RP2040 => chip_specific.get_rom_fn(.reset_to_usb_boot)(0, 0),
        .RP2350 => {
            // 0x0002 - reset to bootsel
            // 0x0100 - block until reset
            const ret = chip_specific.get_rom_fn(.reboot)(0x0002 | 0x0100, 0, 0, 0);

            // shouldn't return error
            const code: ?chip_specific.ErrorCode = .from_int(ret);
            std.debug.assert(code == null);
        },
    }
}

const intrinsics = switch (chip) {
    .RP2040 => struct {
        fn __popcountsi2(x: u32) callconv(.c) u32 {
            return chip_specific.get_rom_fn_cached(.popcount32)(x);
        }

        fn __clzsi2(x: u32) callconv(.c) u32 {
            return chip_specific.get_rom_fn_cached(.clz32)(x);
        }

        fn __ctzsi2(x: u32) callconv(.c) u32 {
            return chip_specific.get_rom_fn_cached(.ctz32)(x);
        }

        fn __bitreversi2(x: u32) callconv(.c) u32 {
            return chip_specific.get_rom_fn_cached(.reverse32)(x);
        }

        fn __aeabi_memset(dest: [*c]u8, c: u8, n: usize) callconv(.{ .arm_aapcs = .{} }) void {
            _ = chip_specific.get_rom_fn_cached(.memset)(dest, c, n);
        }

        fn __aeabi_memset4(dest: [*c]u32, c: u8, n: usize) callconv(.{ .arm_aapcs = .{} }) void {
            _ = chip_specific.get_rom_fn_cached(.memset4)(dest, c, n);
        }

        fn __aeabi_memclr(dest: [*c]u8, n: usize) callconv(.{ .arm_aapcs = .{} }) void {
            _ = chip_specific.get_rom_fn_cached(.memset)(dest, 0, n);
        }

        fn __aeabi_memclr4(dest: [*c]u32, n: usize) callconv(.{ .arm_aapcs = .{} }) void {
            _ = chip_specific.get_rom_fn_cached(.memset4)(dest, 0, n);
        }

        fn __aeabi_memcpy(dest: [*c]u8, src: [*c]const u8, n: usize) callconv(.{ .arm_aapcs = .{} }) void {
            _ = chip_specific.get_rom_fn_cached(.memcpy)(dest, src, n);
        }

        fn __aeabi_memcpy4(dest: [*c]u32, src: [*c]const u32, n: usize) callconv(.{ .arm_aapcs = .{} }) void {
            _ = chip_specific.get_rom_fn_cached(.memcpy44)(dest, src, n);
        }

        // TODO: soft float and double

        // fn sqrtf(x: f32) callconv(.c) f32 {
        //     return chip_specific.get_float_fn(.fsqrt)(x);
        // }
        //
        // fn sqrt(x: f64) callconv(.c) f64 {
        //     return chip_specific.get_double_fn(.dsqrt)(x);
        // }
        //
        // fn logf(x: f32) callconv(.c) f32 {
        //     return chip_specific.get_float_fn(.fln)(x);
        // }
        //
        // fn log(x: f64) callconv(.c) f64 {
        //     return chip_specific.get_double_fn(.dln)(x);
        // }
        //
        // fn expf(x: f32) callconv(.c) f32 {
        //     return chip_specific.get_float_fn(.fexp)(x);
        // }
        //
        // fn exp(x: f64) callconv(.c) f64 {
        //     return chip_specific.get_double_fn(.dexp)(x);
        // }
        //
        // // slower than default
        // fn sinf(x: f32) callconv(.c) f32 {
        //     return chip_specific.get_float_fn(.fsin)(x);
        // }
        //
        // // slower than default
        // fn sin(x: f64) callconv(.c) f64 {
        //     return chip_specific.get_double_fn(.dsin)(x);
        // }
        //
        // // slower than default
        // fn cosf(x: f32) callconv(.c) f32 {
        //     return chip_specific.get_float_fn(.fcos)(x);
        // }
        //
        // // slower than default
        // fn cos(x: f64) callconv(.c) f64 {
        //     return chip_specific.get_double_fn(.dcos)(x);
        // }
        //
        // // slower than default
        // fn tanf(x: f32) callconv(.c) f32 {
        //     return chip_specific.get_float_fn(.ftan)(x);
        // }
        //
        // // slower than default
        // fn tan(x: f64) callconv(.c) f64 {
        //     return chip_specific.get_double_fn(.dtan)(x);
        // }
        //
        // fn atan2f(x: f32, y: f32) callconv(.c) f32 {
        //     return chip_specific.get_float_fn(.fatan2)(x, y);
        // }
        //
        // fn atan2(x: f64, y: f64) callconv(.c) f64 {
        //     return chip_specific.get_double_fn(.datan2)(x, y);
        // }

        comptime {
            for (&.{ "__popcountsi2", "__popcountdi2" }) |name| {
                @export(&__popcountsi2, .{ .name = name, .linkage = .strong });
            }

            for (&.{ "__clzsi2", "__clzdi2" }) |name| {
                @export(&__clzsi2, .{ .name = name, .linkage = .strong });
            }

            for (&.{ "__ctzsi2", "__ctzdi2" }) |name| {
                @export(&__ctzsi2, .{ .name = name, .linkage = .strong });
            }

            for (&.{ "__bitreversi2", "__bitreversedi2", "__rbit", "__rbitl" }) |name| {
                @export(&__bitreversi2, .{ .name = name, .linkage = .strong });
            }

            @export(&__aeabi_memset, .{ .name = "__aeabi_memset", .linkage = .strong });
            for (&.{ "__aeabi_memset4", "__aeabi_memset8" }) |name| {
                @export(&__aeabi_memset4, .{ .name = name, .linkage = .strong });
            }

            @export(&__aeabi_memclr, .{ .name = "__aeabi_memclr", .linkage = .strong });
            for (&.{ "__aeabi_memclr4", "__aeabi_memclr8" }) |name| {
                @export(&__aeabi_memclr4, .{ .name = name, .linkage = .strong });
            }

            @export(&__aeabi_memcpy, .{ .name = "__aeabi_memcpy", .linkage = .strong });
            for (&.{ "__aeabi_memcpy4", "__aeabi_memcpy8" }) |name| {
                @export(&__aeabi_memcpy4, .{ .name = name, .linkage = .strong });
            }

            // @export(&sqrtf, .{ .name = "sqrtf", .linkage = .strong });
            // @export(&logf, .{ .name = "logf", .linkage = .strong });
            // @export(&expf, .{ .name = "expf", .linkage = .strong });
            // @export(&sinf, .{ .name = "sinf", .linkage = .strong });
            // @export(&cosf, .{ .name = "cosf", .linkage = .strong });
            // @export(&tanf, .{ .name = "tanf", .linkage = .strong });
            // @export(&atan2f, .{ .name = "atan2f", .linkage = .strong });
            //
            // if (options.bootrom_v2_math_intrinsics) {
            //     @export(&sqrt, .{ .name = "sqrt", .linkage = .strong });
            //     @export(&log, .{ .name = "log", .linkage = .strong });
            //     @export(&exp, .{ .name = "exp", .linkage = .strong });
            //     @export(&sin, .{ .name = "sin", .linkage = .strong });
            //     @export(&cos, .{ .name = "cos", .linkage = .strong });
            //     @export(&tan, .{ .name = "tan", .linkage = .strong });
            //     @export(&atan2, .{ .name = "atan2", .linkage = .strong });
            // }
        }
    },
    .RP2350 => {},
};

comptime {
    _ = intrinsics;
}
