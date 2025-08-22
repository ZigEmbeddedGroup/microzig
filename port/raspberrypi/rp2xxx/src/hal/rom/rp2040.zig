const std = @import("std");
const rom = @import("../rom.zig");

pub inline fn lookup_data(code: Data) ?*const anyopaque {
    const rom_table_lookup: *const LookupFn = @ptrFromInt(ROM_TABLE_LOOKUP.*);
    const data_table: *const anyopaque = @ptrFromInt(DATA_TABLE.*);
    return rom_table_lookup(data_table, @intFromEnum(code));
}

pub inline fn lookup_function(code: Function) ?*const anyopaque {
    const rom_table_lookup: *const LookupFn = @ptrFromInt(ROM_TABLE_LOOKUP.*);
    const func_table: *const anyopaque = @ptrFromInt(FUNC_TABLE.*);
    return rom_table_lookup(func_table, @intFromEnum(code));
}

// TODO: maybe support copying the table to ram as well?
pub inline fn lookup_float_function(f: SoftFloatFunction) *const anyopaque {
    if (f.min_version() > 1) {
        if (rom.get_version_number() < f.min_version())
            @panic("function not available in this bootrom version");
    }

    const table: [*]const usize = @alignCast(@ptrCast(rom.lookup_and_cache_data(.soft_float_table)));
    return @ptrFromInt(table[@intFromEnum(f) / 4]);
}

pub inline fn lookup_double_function(f: SoftDoubleFunction) *const anyopaque {
    if (rom.get_version_number() < f.min_version())
        @panic("function not available in this bootrom version");

    const table: [*]const usize = @alignCast(@ptrCast(rom.lookup_and_cache_data(.soft_double_table)));
    return @ptrFromInt(table[@intFromEnum(f) / 4]);
}

pub const Data = enum(u16) {
    copyright_string = cod(.{ 'C', 'R' }),
    git_revision = cod(.{ 'G', 'R' }),
    fplib_start = cod(.{ 'F', 'S' }),
    soft_float_table = cod(.{ 'S', 'F' }),
    fplib_end = cod(.{ 'F', 'E' }),
    soft_double_table = cod(.{ 'S', 'D' }),

    _,
};

pub const Function = enum(u16) {
    popcount32 = cod(.{ 'P', '3' }),
    reverse32 = cod(.{ 'R', '3' }),
    clz32 = cod(.{ 'L', '3' }),
    ctz32 = cod(.{ 'T', '3' }),

    memset = cod(.{ 'M', 'S' }),
    memset4 = cod(.{ 'S', '4' }),
    memcpy = cod(.{ 'M', 'C' }),
    memcpy44 = cod(.{ 'C', '4' }),

    connect_internal_flash = cod(.{ 'I', 'F' }),
    flash_exit_xip = cod(.{ 'E', 'X' }),
    flash_range_erase = cod(.{ 'R', 'E' }),
    flash_range_program = cod(.{ 'R', 'P' }),
    flash_flush_cache = cod(.{ 'F', 'C' }),
    flash_enter_cmd_xip = cod(.{ 'C', 'X' }),

    // TODO: Is the signature correct?
    debug_trampoline = cod(.{ 'D', 'T' }),
    // TODO: Is the signature correct?
    debug_trampoline_end = cod(.{ 'D', 'E' }),

    reset_to_usb_boot = cod(.{ 'U', 'B' }),
    wait_for_vector = cod(.{ 'W', 'V' }),

    _,
};

fn cod(code: [2]u8) u16 {
    return std.mem.readInt(u16, &code, .little);
}

pub const SoftFloatFunction = enum(u8) {
    fadd = 0x00,
    fsub = 0x04,
    fmul = 0x08,
    fdiv = 0x0c,

    fsqrt = 0x18,
    float_to_int = 0x1c,
    float_to_fix = 0x20,
    float_to_uint = 0x24,
    float_to_ufix = 0x28,
    int_to_float = 0x2c,
    fix_to_float = 0x30,
    uint_to_float = 0x34,
    ufix_to_float = 0x38,
    fcos = 0x3c,
    fsin = 0x40,
    ftan = 0x44,
    fexp = 0x4c,
    fln = 0x50,

    fcmp = 0x54,
    fatan2 = 0x58,
    int64_to_float = 0x5c,
    fix64_to_float = 0x60,
    uint64_to_float = 0x64,
    ufix64_to_float = 0x68,
    float_to_int64 = 0x6c,
    float_to_fix64 = 0x70,
    float_to_uint64 = 0x74,
    float_to_ufix64 = 0x78,
    float_to_double = 0x7c,

    fsincos = 0x48,

    inline fn min_version(f: SoftFloatFunction) u8 {
        return switch (f) {
            .fcmp,
            .fatan2,
            .int64_to_float,
            .fix64_to_float,
            .uint64_to_float,
            .ufix64_to_float,
            .float_to_int64,
            .float_to_fix64,
            .float_to_uint64,
            .float_to_ufix64,
            .float_to_double,
            => 2,
            .fsincos => 3,
            else => 1,
        };
    }
};

pub const SoftDoubleFunction = enum(u8) {
    dadd = 0x00,
    dsub = 0x04,
    dmul = 0x08,
    ddiv = 0x0c,

    dsqrt = 0x18,
    double_to_int = 0x1c,
    double_to_fix = 0x20,
    double_to_uint = 0x24,
    double_to_ufix = 0x28,
    int_to_double = 0x2c,
    fix_to_double = 0x30,
    uint_to_double = 0x34,
    ufix_to_double = 0x38,
    dcos = 0x3c,
    dsin = 0x40,
    dtan = 0x44,
    dexp = 0x4c,
    dln = 0x50,

    dcmp = 0x54,
    datan2 = 0x58,
    int64_to_double = 0x5c,
    fix64_to_double = 0x60,
    uint64_to_double = 0x64,
    ufix64_to_double = 0x68,
    double_to_int64 = 0x6c,
    double_to_fix64 = 0x70,
    double_to_uint64 = 0x74,
    double_to_ufix64 = 0x78,
    double_to_float = 0x7c,

    sincos = 0x48,

    inline fn min_version(f: SoftFloatFunction) u8 {
        return switch (f) {
            .sincos => 3,
            else => 2,
        };
    }
};

pub const signatures = struct {
    pub const popcount32 = fn (value: u32) callconv(.c) u32;
    pub const reverse32 = fn (value: u32) callconv(.c) u32;
    pub const clz32 = fn (value: u32) callconv(.c) u32;
    pub const ctz32 = fn (value: u32) callconv(.c) u32;

    pub const memset = fn (ptr: [*]u8, c: u8, n: usize) callconv(.c) [*]u8;
    pub const memset4 = fn (ptr: [*]u32, c: u8, n: usize) callconv(.c) [*]u32;
    pub const memcpy = fn (dest: [*]u8, src: [*]const u8, n: usize) callconv(.c) [*]u8;
    pub const memcpy44 = fn (dest: [*]u32, src: [*]const u32, n: usize) callconv(.c) [*]u8;

    pub const connect_internal_flash = fn () callconv(.c) void;
    pub const flash_exit_xip = fn () callconv(.c) void;
    pub const flash_range_erase = fn (addr: u32, count: usize, block_size: u32, block_cmd: u8) callconv(.c) void;
    pub const flash_range_program = fn (addr: u32, data: [*]const u8, count: usize) callconv(.c) void;
    pub const flash_flush_cache = fn () callconv(.c) void;
    pub const flash_enter_cmd_xip = fn () callconv(.c) void;

    // TODO: Is the signature correct?
    pub const debug_trampoline = fn () callconv(.c) void;
    // TODO: Is the signature correct?
    pub const debug_trampoline_end = fn () callconv(.c) void;

    pub const reset_to_usb_boot = fn (gpio_activity_pin_mask: u32, disable_interface_mask: u32) callconv(.c) noreturn;
    pub const wait_for_vector = fn () callconv(.c) noreturn;
};

pub const soft_float_signatures = struct {
    pub const fadd = fn (f32, f32) callconv(.c) f32;
    pub const fsub = fn (f32, f32) callconv(.c) f32;
    pub const fmul = fn (f32, f32) callconv(.c) f32;
    pub const fdiv = fn (f32, f32) callconv(.c) f32;

    pub const fsqrt = fn (f32) callconv(.c) f32;
    pub const float_to_int = fn (f32) callconv(.c) i32;
    pub const float_to_fix = fn (f32, i32) callconv(.c) i32;
    pub const float_to_uint = fn (f32) callconv(.c) u32;
    pub const float_to_ufix = fn (f32, i32) callconv(.c) u32;
    pub const int_to_float = fn (i32) callconv(.c) f32;
    pub const fix_to_float = fn (i32, i32) callconv(.c) f32;
    pub const uint_to_float = fn (u32) callconv(.c) f32;
    pub const ufix_to_float = fn (u32, i32) callconv(.c) f32;
    pub const fcos = fn (f32) callconv(.c) f32;
    pub const fsin = fn (f32) callconv(.c) f32;
    pub const ftan = fn (f32) callconv(.c) f32;
    pub const fexp = fn (f32) callconv(.c) f32;
    pub const fln = fn (f32) callconv(.c) f32;

    pub const fcmp = fn (f32, f32) callconv(.c) i32;
    pub const fatan2 = fn (f32, f32) callconv(.c) f32;
    pub const int64_to_float = fn (i64) callconv(.c) f32;
    pub const fix64_to_float = fn (i64, i32) callconv(.c) f32;
    pub const uint64_to_float = fn (u64) callconv(.c) f32;
    pub const ufix64_to_float = fn (u64, i32) callconv(.c) f32;
    pub const float_to_int64 = fn (f32) callconv(.c) i64;
    pub const float_to_fix64 = fn (f32, i32) callconv(.c) i64;
    pub const float_to_uint64 = fn (f32) callconv(.c) u64;
    pub const float_to_ufix64 = fn (f32, i32) callconv(.c) u64;
    pub const float_to_double = fn (f32) callconv(.c) f64;

    /// The sin result is in r0 (official return value) and the cos
    /// result is in r1. Is it possible to express the signature in
    /// terms of this?
    pub const fsincos = fn (f32) callconv(.c) f32;
};

pub const soft_double_signatures = struct {
    pub const dadd = fn (f64, f64) callconv(.c) f64;
    pub const dsub = fn (f64, f64) callconv(.c) f64;
    pub const dmul = fn (f64, f64) callconv(.c) f64;
    pub const ddiv = fn (f64, f64) callconv(.c) f64;

    pub const dsqrt = fn (f64) callconv(.c) f64;
    pub const double_to_int = fn (f64) callconv(.c) i64;
    pub const double_to_fix = fn (f64, i32) callconv(.c) i64;
    pub const double_to_uint = fn (f64) callconv(.c) u64;
    pub const double_to_ufix = fn (f64, i32) callconv(.c) u64;
    pub const int_to_double = fn (i32) callconv(.c) f64;
    pub const fix_to_double = fn (i32, i32) callconv(.c) f64;
    pub const uint_to_double = fn (u32) callconv(.c) f64;
    pub const ufix_to_double = fn (u32, i32) callconv(.c) f64;
    pub const dcos = fn (f64) callconv(.c) f64;
    pub const dsin = fn (f64) callconv(.c) f64;
    pub const dtan = fn (f64) callconv(.c) f64;
    pub const dexp = fn (f64) callconv(.c) f64;
    pub const dln = fn (f64) callconv(.c) f64;

    pub const dcmp = fn (f64, f64) callconv(.c) i32;
    pub const datan2 = fn (f64, f64) callconv(.c) f64;
    pub const int64_to_double = fn (i64) callconv(.c) f64;
    pub const fix64_to_double = fn (i64, i32) callconv(.c) f64;
    pub const uint64_to_double = fn (u64) callconv(.c) f64;
    pub const ufix64_to_double = fn (u64, i32) callconv(.c) f64;
    pub const double_to_int64 = fn (f64) callconv(.c) i64;
    pub const double_to_fix64 = fn (f64, i32) callconv(.c) i64;
    pub const double_to_uint64 = fn (f64) callconv(.c) u64;
    pub const double_to_ufix64 = fn (f64, i32) callconv(.c) u64;
    pub const double_to_float = fn (f64) callconv(.c) f32;

    /// The sin result is in r0/r1 (official return value) and the cos
    /// result is in r2/r3. Is it possible to express the signature in
    /// terms of this?
    pub const sincos = fn (f64) callconv(.c) f64;
};

const ROM_TABLE_LOOKUP: *const u16 = @ptrFromInt(0x0000_0018);

const FUNC_TABLE: *const u16 = @ptrFromInt(0x0000_0014);
const DATA_TABLE: *const u16 = @ptrFromInt(0x0000_0016);

const LookupFn = fn (table: *const anyopaque, code: u32) callconv(.c) ?*const anyopaque;
