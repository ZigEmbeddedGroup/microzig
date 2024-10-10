const std = @import("std");
const assert = std.debug.assert;

pub const Lock = struct {
    impl: u32,

    pub fn claim() Lock {
        @panic("TODO");
    }

    pub fn unlock(lock: Lock) void {
        _ = lock;
        @panic("TODO");
    }
};

const rw_bits = @as(u32, 0x0) << 12;
const xor_bits = @as(u32, 0x1) << 12;
const set_bits = @as(u32, 0x2) << 12;
const clear_bits = @as(u32, 0x3) << 12;

/// Returns a base register offset by 0x3000 for its atomic clear on write equivalent address
pub fn clear_alias_raw(ptr: anytype) *volatile u32 {
    return @ptrFromInt(@intFromPtr(ptr) | clear_bits);
}

/// Returns a base register offset by 0x2000 for its atomic set on write equivalent address
pub fn set_alias_raw(ptr: anytype) *volatile u32 {
    return @ptrFromInt(@intFromPtr(ptr) | set_bits);
}

/// Returns a base register offset by 0x1000 for its atomic XOR on write equivalent address
pub fn xor_alias_raw(ptr: anytype) *volatile u32 {
    return @ptrFromInt(@intFromPtr(ptr) | xor_bits);
}

/// Returns a base register offset by 0x3000 for its atomic clear on write equivalent address
pub fn clear_alias(ptr: anytype) @TypeOf(ptr) {
    return @ptrFromInt(@intFromPtr(ptr) | clear_bits);
}

/// Returns a base register offset by 0x2000 for its atomic set on write equivalent address
pub fn set_alias(ptr: anytype) @TypeOf(ptr) {
    return @ptrFromInt(@intFromPtr(ptr) | set_bits);
}

/// Returns a base register offset by 0x1000 for its atomic XOR on write equivalent address
pub fn xor_alias(ptr: anytype) @TypeOf(ptr) {
    return @ptrFromInt(@intFromPtr(ptr) | xor_bits);
}

pub inline fn tight_loop_contents() void {
    asm volatile ("" ::: "memory");
}
