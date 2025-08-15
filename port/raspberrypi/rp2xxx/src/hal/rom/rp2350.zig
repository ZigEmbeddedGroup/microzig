const std = @import("std");
const rom = @import("../rom.zig");
const arch = @import("../compatibility.zig").arch;

pub inline fn lookup_data(comptime info: DataInfo) ?info.PtrType {
    info.mask.check_arch();

    const code = comptime std.mem.readInt(u16, &info.code, .little);

    const rom_data_lookup_fn: *const LookupFn = @ptrFromInt(if (rom.get_version_number() < 2)
        ROM_DATA_LOOKUP_A1.*
    else
        ROM_DATA_LOOKUP_A2.*);
    return @alignCast(@ptrCast(rom_data_lookup_fn(code, 0x40))); // 0x40 = data mask
}

pub inline fn lookup_function(comptime info: FunctionInfo) ?*const info.Signature {
    info.mask.check_arch();

    const code = comptime std.mem.readInt(u16, &info.code, .little);

    const rom_table_lookup_fn: *const LookupFn = @ptrFromInt(if (rom.get_version_number() < 2)
        ROM_TABLE_LOOKUP_A1.*
    else
        ROM_TABLE_LOOKUP_A2.*);
    return @alignCast(@ptrCast(rom_table_lookup_fn(code, @intFromEnum(info.mask))));
}

pub const DataInfo = struct {
    code: [2]u8,
    mask: Mask,
    PtrType: type,

    pub const git_revision: DataInfo = .{ .code = .{ 'G', 'R' }, .mask = .riscv_or_arm_s, .PtrType = *const u32 };
    pub const git_revision_ns: DataInfo = .{ .code = .{ 'G', 'R' }, .mask = .arm_ns, .PtrType = *const u32 };
};

pub const FunctionInfo = struct {
    code: [2]u8,
    mask: Mask,
    Signature: type,

    pub const connect_internal_flash: FunctionInfo = .{ .code = .{ 'I', 'F' }, .mask = .riscv_or_arm_s, .Signature = fn () callconv(.c) void };
    pub const flash_enter_cmd_xip: FunctionInfo = .{ .code = .{ 'C', 'X' }, .mask = .riscv_or_arm_s, .Signature = fn () callconv(.c) void };
    pub const flash_exit_xip: FunctionInfo = .{ .code = .{ 'E', 'X' }, .mask = .riscv_or_arm_s, .Signature = fn () callconv(.c) void };
    pub const flash_flush_cache: FunctionInfo = .{ .code = .{ 'F', 'C' }, .mask = .riscv_or_arm_s, .Signature = fn () callconv(.c) void };
    pub const flash_range_erase: FunctionInfo = .{ .code = .{ 'R', 'E' }, .mask = .riscv_or_arm_s, .Signature = fn (u32, usize, u32, u8) callconv(.c) void };
    pub const flash_range_program: FunctionInfo = .{ .code = .{ 'R', 'P' }, .mask = .riscv_or_arm_s, .Signature = fn (u32, [*]const u8, usize) callconv(.c) void };
    pub const flash_reset_address_translate: FunctionInfo = .{ .code = .{ 'R', 'A' }, .mask = .riscv_or_arm_s, .Signature = fn () callconv(.c) void };
    pub const flash_select_xip_read_mode: FunctionInfo = .{ .code = .{ 'S', 'X' }, .mask = .riscv_or_arm_s, .Signature = fn () callconv(.c) void };

    pub const flash_op: FunctionInfo = .{ .code = .{ 'F', 'O' }, .mask = .riscv_or_arm_s, .Signature = fn (u32, u32, u32, u32) callconv(.c) i32 };
    pub const flash_op_ns: FunctionInfo = .{ .code = .{ 'F', 'O' }, .mask = .arm_ns, .Signature = fn (u32, u32, u32, u32) callconv(.c) i32 };
    pub const flash_runtime_to_storage_addr: FunctionInfo = .{ .code = .{ 'F', 'A' }, .mask = .riscv_or_arm_s, .Signature = fn (u32) callconv(.c) i32 };
    pub const flash_runtime_to_storage_addr_ns: FunctionInfo = .{ .code = .{ 'F', 'A' }, .mask = .arm_ns, .Signature = fn (u32) callconv(.c) i32 };

    pub const reboot: FunctionInfo = .{ .code = .{ 'R', 'B' }, .mask = .riscv_or_arm_s, .Signature = fn (flags: u32, delay_ms: u32, p0: u32, p1: u32) callconv(.c) i32 };
    pub const reboot_ns: FunctionInfo = .{ .code = .{ 'R', 'B' }, .mask = .arm_ns, .Signature = fn (flags: u32, delay_ms: u32, p0: u32, p1: u32) callconv(.c) i32 };
};

pub const Mask = enum(u32) {
    riscv = 0x0001,
    arm_s = 0x0004,
    arm_ns = 0x0010,

    pub const riscv_or_arm_s: Mask = switch (arch) {
        .arm => .arm_s,
        .riscv => .riscv,
    };

    inline fn check_arch(mask: Mask) void {
        switch (arch) {
            .arm => if (mask == .riscv) @compileError("Function not available on ARM"),
            .riscv => if (mask != .riscv) @compileError("Function not available on RISC-V"),
        }
    }
};

pub fn check_result(ret: i32) Error!void {
    const err_code: ?ErrorCode = .from_int(ret);
    return if (err_code) |code| code.map_to_error() else {};
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

    pub fn from_int(x: i32) ?ErrorCode {
        return std.meta.intToEnum(ErrorCode, x) catch null;
    }

    pub fn map_to_error(err_code: ErrorCode) Error {
        return switch (err_code) {
            .not_permitted => Error.NotPermitted,
            .invalid_argument => Error.InvalidArgument,
            .invalid_address => Error.InvalidAddress,
            .bad_alignment => Error.BadAlignment,
            .invalid_state => Error.InvalidState,
            .buffer_too_small => Error.BufferTooSmall,
            .precondition_not_met => Error.PreconditionNotMet,
            .modified_data => Error.ModifiedData,
            .invalid_data => Error.InvalidData,
            .not_found => Error.NotFound,
            .unsupported_modification => Error.UnsupportedModification,
            .lock_required => Error.LockRequired,
        };
    }
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
