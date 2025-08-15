const std = @import("std");
const rom = @import("../rom.zig");

/// Asserts that data with the given code exists in the bootrom.
pub inline fn lookup_data(info: DataInfo) info.PtrType {
    const rom_table_lookup: *const LookupFn = @ptrFromInt(ROM_TABLE_LOOKUP.*);
    const data_table: *const anyopaque = @ptrFromInt(DATA_TABLE.*);
    const code = comptime std.mem.readInt(u16, &info.code, .little);

    return @alignCast(@ptrCast(rom_table_lookup(data_table, code)));
}

/// Asserts that a function with the given code exists in the bootrom.
pub inline fn lookup_function(info: FunctionInfo) *const info.Signature {
    const rom_table_lookup: *const LookupFn = @ptrFromInt(ROM_TABLE_LOOKUP.*);
    const func_table: *const anyopaque = @ptrFromInt(FUNC_TABLE.*);
    const code = comptime std.mem.readInt(u16, &info.code, .little);

    return @alignCast(@ptrCast(rom_table_lookup(func_table, code)));
}

// TODO: maybe support copying the table to ram as well?
pub inline fn lookup_float_function(info: FloatFunctionInfo) *const info.Signature {
    if (info.min_version) |min_version| {
        if (rom.get_version_number() < min_version) @panic("function not available in this bootrom version");
    }

    const table: [*]const usize = rom.lookup_and_cache_data(.soft_float_table);
    return @ptrFromInt(table[info.offset / 4]);
}

pub inline fn lookup_double_function(info: DoubleFunctionInfo) *const info.Signature {
    if (info.min_version) |min_version| {
        if (rom.get_version_number() < min_version) @panic("function not available in this bootrom version");
    }

    const table: [*]const usize = rom.lookup_and_cache_data(.soft_double_table);
    return @ptrFromInt(table[info.offset / 4]);
}

pub const DataInfo = struct {
    code: [2]u8,
    min_version: ?u8 = null,
    PtrType: type,

    pub const copyright_string: DataInfo = .{ .code = .{ 'C', 'R' }, .PtrType = [*]const u8 };
    pub const git_revision: DataInfo = .{ .code = .{ 'G', 'R' }, .PtrType = [*]const u32 };
    pub const fplib_start: DataInfo = .{ .code = .{ 'F', 'S' }, .PtrType = *const anyopaque };
    pub const soft_float_table: DataInfo = .{ .code = .{ 'S', 'F' }, .PtrType = [*]const usize };
    pub const fplib_end: DataInfo = .{ .code = .{ 'F', 'E' }, .PtrType = *const anyopaque };
    pub const soft_double_table: DataInfo = .{ .code = .{ 'S', 'D' }, .min_version = 2, .PtrType = [*]const usize };
};

pub const FunctionInfo = struct {
    code: [2]u8,
    Signature: type,

    pub const popcount32: FunctionInfo = .{ .code = .{ 'P', '3' }, .Signature = fn (value: u32) callconv(.c) u32 };
    pub const reverse32: FunctionInfo = .{ .code = .{ 'R', '3' }, .Signature = fn (value: u32) callconv(.c) u32 };
    pub const clz32: FunctionInfo = .{ .code = .{ 'L', '3' }, .Signature = fn (value: u32) callconv(.c) u32 };
    pub const ctz32: FunctionInfo = .{ .code = .{ 'T', '3' }, .Signature = fn (value: u32) callconv(.c) u32 };

    pub const memset: FunctionInfo = .{ .code = .{ 'M', 'S' }, .Signature = fn (ptr: [*]u8, c: u8, n: usize) callconv(.c) [*]u8 };
    pub const memset4: FunctionInfo = .{ .code = .{ 'S', '4' }, .Signature = fn (ptr: [*]u32, c: u8, n: usize) callconv(.c) [*]u32 };
    pub const memcpy: FunctionInfo = .{ .code = .{ 'M', 'C' }, .Signature = fn (dest: [*]u8, src: [*]const u8, n: usize) callconv(.c) [*]u8 };
    pub const memcpy44: FunctionInfo = .{ .code = .{ 'C', '4' }, .Signature = fn (dest: [*]u32, src: [*]const u32, n: usize) callconv(.c) [*]u8 };

    pub const connect_internal_flash: FunctionInfo = .{ .code = .{ 'I', 'F' }, .Signature = fn () callconv(.c) void };
    pub const flash_exit_xip: FunctionInfo = .{ .code = .{ 'E', 'X' }, .Signature = fn () callconv(.c) void };
    pub const flash_range_erase: FunctionInfo = .{ .code = .{ 'R', 'E' }, .Signature = fn (addr: u32, count: usize, block_size: u32, block_cmd: u8) callconv(.c) void };
    pub const flash_range_program: FunctionInfo = .{ .code = .{ 'R', 'P' }, .Signature = fn (addr: u32, data: [*]const u8, count: usize) callconv(.c) void };
    pub const flash_flush_cache: FunctionInfo = .{ .code = .{ 'F', 'C' }, .Signature = fn () callconv(.c) void };
    pub const flash_enter_cmd_xip: FunctionInfo = .{ .code = .{ 'C', 'X' }, .Signature = fn () callconv(.c) void };

    // TODO: Is the signature correct?
    pub const debug_trampoline: FunctionInfo = .{ .code = .{ 'D', 'T' }, .Signature = fn () callconv(.c) void };
    // TODO: Is the signature correct?
    pub const debug_trampoline_end: FunctionInfo = .{ .code = .{ 'D', 'E' }, .Signature = fn () callconv(.c) void };

    pub const reset_to_usb_boot: FunctionInfo = .{ .code = .{ 'U', 'B' }, .Signature = fn (gpio_activity_pin_mask: u32, disable_interface_mask: u32) callconv(.c) noreturn };
    pub const wait_for_vector: FunctionInfo = .{ .code = .{ 'W', 'V' }, .Signature = fn () callconv(.c) noreturn };
};

pub const FloatFunctionInfo = struct {
    offset: usize,
    min_version: ?u8 = null,
    Signature: type,

    pub const fadd: FloatFunctionInfo = .{ .offset = 0x00, .Signature = fn (f32, f32) callconv(.c) f32 };
    pub const fsub: FloatFunctionInfo = .{ .offset = 0x04, .Signature = fn (f32, f32) callconv(.c) f32 };
    pub const fmul: FloatFunctionInfo = .{ .offset = 0x08, .Signature = fn (f32, f32) callconv(.c) f32 };
    pub const fdiv: FloatFunctionInfo = .{ .offset = 0x0c, .Signature = fn (f32, f32) callconv(.c) f32 };

    pub const fsqrt: FloatFunctionInfo = .{ .offset = 0x18, .Signature = fn (f32) callconv(.c) f32 };
    pub const float_to_int: FloatFunctionInfo = .{ .offset = 0x1c, .Signature = fn (f32) callconv(.c) i32 };
    pub const float_to_fix: FloatFunctionInfo = .{ .offset = 0x20, .Signature = fn (f32, i32) callconv(.c) i32 };
    pub const float_to_uint: FloatFunctionInfo = .{ .offset = 0x24, .Signature = fn (f32) callconv(.c) u32 };
    pub const float_to_ufix: FloatFunctionInfo = .{ .offset = 0x28, .Signature = fn (f32, i32) callconv(.c) u32 };
    pub const int_to_float: FloatFunctionInfo = .{ .offset = 0x2c, .Signature = fn (i32) callconv(.c) f32 };
    pub const fix_to_float: FloatFunctionInfo = .{ .offset = 0x30, .Signature = fn (i32, i32) callconv(.c) f32 };
    pub const uint_to_float: FloatFunctionInfo = .{ .offset = 0x34, .Signature = fn (u32) callconv(.c) f32 };
    pub const ufix_to_float: FloatFunctionInfo = .{ .offset = 0x38, .Signature = fn (u32, i32) callconv(.c) f32 };
    pub const fcos: FloatFunctionInfo = .{ .offset = 0x3c, .Signature = fn (f32) callconv(.c) f32 };
    pub const fsin: FloatFunctionInfo = .{ .offset = 0x40, .Signature = fn (f32) callconv(.c) f32 };
    pub const ftan: FloatFunctionInfo = .{ .offset = 0x44, .Signature = fn (f32) callconv(.c) f32 };
    pub const fexp: FloatFunctionInfo = .{ .offset = 0x4c, .Signature = fn (f32) callconv(.c) f32 };
    pub const fln: FloatFunctionInfo = .{ .offset = 0x50, .Signature = fn (f32) callconv(.c) f32 };

    pub const fcmp: FloatFunctionInfo = .{ .offset = 0x54, .min_version = 2, .Signature = fn (f32, f32) callconv(.c) i32 };
    pub const fatan2: FloatFunctionInfo = .{ .offset = 0x58, .min_version = 2, .Signature = fn (f32, f32) callconv(.c) f32 };
    pub const int64_to_float: FloatFunctionInfo = .{ .offset = 0x5c, .min_version = 2, .Signature = fn (i64) callconv(.c) f32 };
    pub const fix64_to_float: FloatFunctionInfo = .{ .offset = 0x60, .min_version = 2, .Signature = fn (i64, i32) callconv(.c) f32 };
    pub const uint64_to_float: FloatFunctionInfo = .{ .offset = 0x64, .min_version = 2, .Signature = fn (u64) callconv(.c) f32 };
    pub const ufix64_to_float: FloatFunctionInfo = .{ .offset = 0x68, .min_version = 2, .Signature = fn (u64, i32) callconv(.c) f32 };
    pub const float_to_int64: FloatFunctionInfo = .{ .offset = 0x6c, .min_version = 2, .Signature = fn (f32) callconv(.c) i64 };
    pub const float_to_fix64: FloatFunctionInfo = .{ .offset = 0x70, .min_version = 2, .Signature = fn (f32, i32) callconv(.c) i64 };
    pub const float_to_uint64: FloatFunctionInfo = .{ .offset = 0x74, .min_version = 2, .Signature = fn (f32) callconv(.c) u64 };
    pub const float_to_ufix64: FloatFunctionInfo = .{ .offset = 0x78, .min_version = 2, .Signature = fn (f32, i32) callconv(.c) u64 };
    pub const float_to_double: FloatFunctionInfo = .{ .offset = 0x7c, .min_version = 2, .Signature = fn (f32) callconv(.c) f64 };

    /// The sin result is in r0 (official return value) and the cos
    /// result is in r1. Is it possible to express the signature in
    /// terms of this?
    pub const fsincos: FloatFunctionInfo = .{ .offset = 0x48, .min_version = 3, .Signature = fn (f32) callconv(.c) f32 };
};

// Only available from v2 onwards
pub const DoubleFunctionInfo = struct {
    offset: usize,
    min_version: ?u8 = null,
    Signature: type,

    pub const dadd: DoubleFunctionInfo = .{ .offset = 0x00, .Signature = fn (f64, f64) callconv(.c) f64 };
    pub const dsub: DoubleFunctionInfo = .{ .offset = 0x04, .Signature = fn (f64, f64) callconv(.c) f64 };
    pub const dmul: DoubleFunctionInfo = .{ .offset = 0x08, .Signature = fn (f64, f64) callconv(.c) f64 };
    pub const ddiv: DoubleFunctionInfo = .{ .offset = 0x0c, .Signature = fn (f64, f64) callconv(.c) f64 };

    pub const dsqrt: DoubleFunctionInfo = .{ .offset = 0x18, .Signature = fn (f64) callconv(.c) f64 };
    pub const double_to_int: DoubleFunctionInfo = .{ .offset = 0x1c, .Signature = fn (f64) callconv(.c) i64 };
    pub const double_to_fix: DoubleFunctionInfo = .{ .offset = 0x20, .Signature = fn (f64, i32) callconv(.c) i64 };
    pub const double_to_uint: DoubleFunctionInfo = .{ .offset = 0x24, .Signature = fn (f64) callconv(.c) u64 };
    pub const double_to_ufix: DoubleFunctionInfo = .{ .offset = 0x28, .Signature = fn (f64, i32) callconv(.c) u64 };
    pub const int_to_double: DoubleFunctionInfo = .{ .offset = 0x2c, .Signature = fn (i32) callconv(.c) f64 };
    pub const fix_to_double: DoubleFunctionInfo = .{ .offset = 0x30, .Signature = fn (i32, i32) callconv(.c) f64 };
    pub const uint_to_double: DoubleFunctionInfo = .{ .offset = 0x34, .Signature = fn (u32) callconv(.c) f64 };
    pub const ufix_to_double: DoubleFunctionInfo = .{ .offset = 0x38, .Signature = fn (u32, i32) callconv(.c) f64 };
    pub const dcos: DoubleFunctionInfo = .{ .offset = 0x3c, .Signature = fn (f64) callconv(.c) f64 };
    pub const dsin: DoubleFunctionInfo = .{ .offset = 0x40, .Signature = fn (f64) callconv(.c) f64 };
    pub const dtan: DoubleFunctionInfo = .{ .offset = 0x44, .Signature = fn (f64) callconv(.c) f64 };
    pub const dexp: DoubleFunctionInfo = .{ .offset = 0x4c, .Signature = fn (f64) callconv(.c) f64 };
    pub const dln: DoubleFunctionInfo = .{ .offset = 0x50, .Signature = fn (f64) callconv(.c) f64 };

    pub const dcmp: DoubleFunctionInfo = .{ .offset = 0x54, .Signature = fn (f64, f64) callconv(.c) i32 };
    pub const datan2: DoubleFunctionInfo = .{ .offset = 0x58, .Signature = fn (f64, f64) callconv(.c) f64 };
    pub const int64_to_double: DoubleFunctionInfo = .{ .offset = 0x5c, .Signature = fn (i64) callconv(.c) f64 };
    pub const fix64_to_double: DoubleFunctionInfo = .{ .offset = 0x60, .Signature = fn (i64, i32) callconv(.c) f64 };
    pub const uint64_to_double: DoubleFunctionInfo = .{ .offset = 0x64, .Signature = fn (u64) callconv(.c) f64 };
    pub const ufix64_to_double: DoubleFunctionInfo = .{ .offset = 0x68, .Signature = fn (u64, i32) callconv(.c) f64 };
    pub const double_to_int64: DoubleFunctionInfo = .{ .offset = 0x6c, .Signature = fn (f64) callconv(.c) i64 };
    pub const double_to_fix64: DoubleFunctionInfo = .{ .offset = 0x70, .Signature = fn (f64, i32) callconv(.c) i64 };
    pub const double_to_uint64: DoubleFunctionInfo = .{ .offset = 0x74, .Signature = fn (f64) callconv(.c) u64 };
    pub const double_to_ufix64: DoubleFunctionInfo = .{ .offset = 0x78, .Signature = fn (f64, i32) callconv(.c) u64 };
    pub const double_to_float: DoubleFunctionInfo = .{ .offset = 0x7c, .Signature = fn (f64) callconv(.c) f32 };

    /// The sin result is in r0/r1 (official return value) and the cos
    /// result is in r2/r3. Is it possible to express the signature in
    /// terms of this?
    pub const sincos: DoubleFunctionInfo = .{ .offset = 0x48, .min_version = 3, .Signature = fn (f64) callconv(.c) f64 };
};

const intrinsics = struct {
    fn __popcountsi2(x: u32) callconv(.c) u32 {
        return rom.lookup_and_cache_function(.popcount32)(x);
    }

    fn __clzsi2(x: u32) callconv(.c) u32 {
        return rom.lookup_and_cache_function(.clz32)(x);
    }

    fn __ctzsi2(x: u32) callconv(.c) u32 {
        return rom.lookup_and_cache_function(.ctz32)(x);
    }

    fn __bitreversi2(x: u32) callconv(.c) u32 {
        return rom.lookup_and_cache_function(.reverse32)(x);
    }

    fn __aeabi_memset(dest: [*c]u8, c: u8, n: usize) callconv(.{ .arm_aapcs = .{} }) void {
        _ = rom.lookup_and_cache_function(.memset)(dest, c, n);
    }

    fn __aeabi_memset4(dest: [*c]u32, c: u8, n: usize) callconv(.{ .arm_aapcs = .{} }) void {
        _ = rom.lookup_and_cache_function(.memset4)(dest, c, n);
    }

    fn __aeabi_memclr(dest: [*c]u8, n: usize) callconv(.{ .arm_aapcs = .{} }) void {
        _ = rom.lookup_and_cache_function(.memset)(dest, 0, n);
    }

    fn __aeabi_memclr4(dest: [*c]u32, n: usize) callconv(.{ .arm_aapcs = .{} }) void {
        _ = rom.lookup_and_cache_function(.memset4)(dest, 0, n);
    }

    fn __aeabi_memcpy(dest: [*c]u8, src: [*c]const u8, n: usize) callconv(.{ .arm_aapcs = .{} }) void {
        _ = rom.lookup_and_cache_function(.memcpy)(dest, src, n);
    }

    fn __aeabi_memcpy4(dest: [*c]u32, src: [*c]const u32, n: usize) callconv(.{ .arm_aapcs = .{} }) void {
        _ = rom.lookup_and_cache_function(.memcpy44)(dest, src, n);
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
};

comptime {
    _ = intrinsics;
}

const ROM_TABLE_LOOKUP: *const u16 = @ptrFromInt(0x0000_0018);

const FUNC_TABLE: *const u16 = @ptrFromInt(0x0000_0014);
const DATA_TABLE: *const u16 = @ptrFromInt(0x0000_0016);

const LookupFn = fn (table: *const anyopaque, code: u32) callconv(.c) ?*const anyopaque;
