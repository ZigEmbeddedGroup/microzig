const std = @import("std");
const rom = @import("../rom.zig");
const arch = @import("../compatibility.zig").arch;

/// Asserts that data with the given code exists in the bootrom.
pub inline fn lookup_data(data: Data) ?*const anyopaque {
    const rom_data_lookup_fn: *const LookupFn = @ptrFromInt(if (rom.get_version_number() < 2)
        ROM_DATA_LOOKUP_A1.*
    else
        ROM_DATA_LOOKUP_A2.*);
    return @alignCast(@ptrCast(rom_data_lookup_fn(@intFromEnum(data), 0x40))); // 0x40 = data mask
}

/// Asserts that a function with the given code exists in the bootrom.
pub inline fn lookup_function(function: Function) ?*const anyopaque {
    const rom_table_lookup_fn: *const LookupFn = @ptrFromInt(if (rom.get_version_number() < 2)
        ROM_TABLE_LOOKUP_A1.*
    else
        ROM_TABLE_LOOKUP_A2.*);

    const mask = switch (arch) {
        .arm => if (is_secure_mode()) masks.arm_s else masks.arm_ns,
        .riscv => masks.riscv,
    };
    return @alignCast(@ptrCast(rom_table_lookup_fn(@intFromEnum(function), mask)));
}

fn is_secure_mode() bool {
    return (asm volatile ("tt %[result], %[target]"
        : [result] "=r" (-> u32),
        : [target] "r" (0),
    ) & (1 << 22)) != 0;
}

const masks = struct {
    const riscv: u32 = 0x0001;
    const arm_s: u32 = 0x0004;
    const arm_ns: u32 = 0x0010;
    const data: u32 = 0x0040;
};

pub const Data = enum(u16) {
    git_revision = cod(.{ 'G', 'R' }),
    _,
};

pub const Function = enum(u16) {
    connect_internal_flash = cod(.{ 'I', 'F' }),
    flash_enter_cmd_xip = cod(.{ 'C', 'X' }),
    flash_exit_xip = cod(.{ 'E', 'X' }),
    flash_flush_cache = cod(.{ 'F', 'C' }),
    flash_range_erase = cod(.{ 'R', 'E' }),
    flash_range_program = cod(.{ 'R', 'P' }),
    flash_reset_address_trans = cod(.{ 'R', 'A' }),
    flash_select_xip_read_mode = cod(.{ 'S', 'X' }),

    flash_op = cod(.{ 'F', 'O' }),
    flash_runtime_to_storage_addr = cod(.{ 'F', 'A' }),

    reboot = cod(.{ 'R', 'B' }),

    _,
};

fn cod(code: [2]u8) u16 {
    return std.mem.readInt(u16, &code, .little);
}

pub const signatures = struct {
    pub const connect_internal_flash = fn () callconv(.c) void;
    pub const flash_enter_cmd_xip = fn () callconv(.c) void;
    pub const flash_exit_xip = fn () callconv(.c) void;
    pub const flash_flush_cache = fn () callconv(.c) void;
    pub const flash_range_erase = fn (addr: u32, count: usize, block_size: u32, block_cmd: u8) callconv(.c) void;
    pub const flash_range_program = fn (addr: u32, data: [*]const u8, count: usize) callconv(.c) void;
    pub const flash_reset_address_trans = fn () callconv(.c) void;
    pub const flash_select_xip_read_mode = fn (mode: u8, clkdiv: u8) callconv(.c) void;

    pub const flash_op = fn (u32, u32, u32, u32) callconv(.c) i32;
    pub const flash_runtime_to_storage_addr = fn (u32) callconv(.c) i32;

    pub const reboot = fn (flags: u32, delay_ms: u32, p0: u32, p1: u32) callconv(.c) i32;
};

pub fn check_result(ret: i32) Error!u32 {
    return switch (ret) {
        -4 => Error.NotPermitted,
        -5 => Error.InvalidArgument,
        -10 => Error.InvalidAddress,
        -11 => Error.BadAlignment,
        -12 => Error.InvalidState,
        -13 => Error.BufferTooSmall,
        -14 => Error.PreconditionNotMet,
        -15 => Error.ModifiedData,
        -16 => Error.InvalidData,
        -17 => Error.NotFound,
        -18 => Error.UnsupportedModification,
        -19 => Error.LockRequired,
        else => if (ret >= 0)
            @intCast(ret)
        else
            Error.UnexpectedErrorCode,
    };
}

pub const Error = error{
    NotPermitted,
    InvalidArgument,
    InvalidAddress,
    BadAlignment,
    InvalidState,
    BufferTooSmall,
    PreconditionNotMet,
    ModifiedData,
    InvalidData,
    NotFound,
    UnsupportedModification,
    LockRequired,
    UnexpectedErrorCode,
};

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
