const std = @import("std");
const rom = @import("../rom.zig");
const arch = @import("../compatibility.zig").arch;

/// Asserts that data with the given code exists in the bootrom.
pub inline fn lookup_data(data: Data) ?*const anyopaque {
    const rom_data_lookup_fn: *const LookupFn = @ptrFromInt(if (rom.get_version_number() < 2)
        ROM_DATA_LOOKUP_A1.*
    else
        ROM_DATA_LOOKUP_A2.*);
    return @ptrCast(@alignCast(rom_data_lookup_fn(@intFromEnum(data), 0x40))); // 0x40 = data mask
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
    return @ptrCast(@alignCast(rom_table_lookup_fn(@intFromEnum(function), mask)));
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
    flash_devinfo16_ptr = cod(.{ 'F', 'D' }),
    partition_table_ptr = cod(.{ 'P', 'T' }),
    xip_setup_func_ptr = cod(.{ 'X', 'F' }),
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

    get_partition_table_info = cod(.{ 'G', 'P' }),
    get_sys_info = cod(.{ 'G', 'S' }),

    get_b_partition = cod(.{ 'G', 'B' }),
    get_uf2_target_partition = cod(.{ 'G', 'U' }),
    pick_ab_partition = cod(.{ 'A', 'B' }),
    load_partition_table = cod(.{ 'L', 'P' }),

    set_bootrom_stack = cod(.{ 'S', 'S' }),
    bootrom_state_reset = cod(.{ 'S', 'R' }),

    chain_image = cod(.{ 'C', 'I' }),
    explicit_buy = cod(.{ 'E', 'B' }),

    set_ns_api_permission = cod(.{ 'S', 'P' }),
    set_rom_callback = cod(.{ 'R', 'C' }),
    validate_ns_buffer = cod(.{ 'V', 'B' }),

    reboot = cod(.{ 'R', 'B' }),
    otp_access = cod(.{ 'O', 'A' }),

    secure_call = cod(.{ 'S', 'C' }),

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

    pub const get_partition_table_info = fn (out_buffer: [*]u32, out_buffer_word_size: u32, flags_and_partition: u32) callconv(.c) i32;
    pub const get_sys_info = fn (out_buffer: [*]u32, out_buffer_word_size: u32, flags: u32) callconv(.c) i32;

    pub const get_b_partition = fn (partition_a: u32) callconv(.c) i32;
    pub const get_uf2_target_partition = fn (
        workarea_base: [*]u8,
        workarea_size: u32,
        family_id: u32,
        partition_out: *extern struct {
            permissions_and_location: u32,
            permissions_and_flags: u32,
        },
    ) callconv(.c) i32;
    pub const pick_ab_partition = fn (workarea_base: [*]u8, workarea_size: u32, partition_a_num: u32) callconv(.c) i32;
    pub const load_partition_table = fn (workarea_base: [*]u8, workarea_size: u32, force_reload: bool) callconv(.c) i32;

    pub const set_bootrom_stack = fn (base_size: [2]u32) callconv(.c) i32;
    pub const bootrom_state_reset = fn (flags: u32) callconv(.c) void;

    pub const chann_image = fn (workarea_base: [*]u8, workarea_size: u32, region_base: i32, region_size: u32) callconv(.c) i32;
    pub const explicit_buy = fn (buffer: [*]u8, buffer_size: u32) callconv(.c) i32;

    pub const set_ns_api_permission = fn (ns_api_num: u32, allowed: bool) callconv(.c) i32;
    pub const set_rom_callback = fn (callback_number: u32, rom_callback: ?*const anyopaque) callconv(.c) i32;
    pub const validate_ns_buffer = fn (addr: ?*const anyopaque, size: u32, write: u32, ok: *u32) callconv(.c) i32;

    pub const reboot = fn (flags: u32, delay_ms: u32, p0: u32, p1: u32) callconv(.c) i32;
    pub const otp_access = fn (buf: [*]u8, buf_len: u32, row_and_flags: u32) callconv(.c) i32;

    pub const secure_call = fn (...) callconv(.c) i32;
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
