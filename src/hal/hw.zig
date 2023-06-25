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

pub fn clear_alias_raw(ptr: anytype) *volatile u32 {
    return @ptrFromInt(*volatile u32, @intFromPtr(ptr) | clear_bits);
}

pub fn set_alias_raw(ptr: anytype) *volatile u32 {
    return @ptrFromInt(*volatile u32, @intFromPtr(ptr) | set_bits);
}

pub fn xor_alias_raw(ptr: anytype) *volatile u32 {
    return @ptrFromInt(*volatile u32, @intFromPtr(ptr) | xor_bits);
}

pub fn clear_alias(ptr: anytype) @TypeOf(ptr) {
    return @ptrFromInt(@TypeOf(ptr), @intFromPtr(ptr) | clear_bits);
}

pub fn set_alias(ptr: anytype) @TypeOf(ptr) {
    return @ptrFromInt(@TypeOf(ptr), @intFromPtr(ptr) | set_bits);
}

pub fn xor_alias(ptr: anytype) @TypeOf(ptr) {
    return @ptrFromInt(@TypeOf(ptr), @intFromPtr(ptr) | xor_bits);
}

pub inline fn tight_loop_contents() void {
    asm volatile ("" ::: "memory");
}
