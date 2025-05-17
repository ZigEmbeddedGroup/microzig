const std = @import("std");
const microzig = @import("microzig");

// For now it's only implemented for single hart systems (esp32c3). No need for fences.

const largest_atomic_size = @sizeOf(usize);

inline fn atomic_store(comptime T: type, ptr: *volatile T, val: T, _: i32) void {
    if (@sizeOf(T) > largest_atomic_size) {
        @compileError("only supports types with a size of less than 4");
    }

    ptr.* = val;
}

inline fn atomic_load(comptime T: type, ptr: *volatile T, _: i32) T {
    if (@sizeOf(T) > largest_atomic_size) {
        @compileError("only supports types with a size of less than 4");
    }

    return ptr.*;
}

inline fn atomic_rmw(comptime T: type, ptr: *volatile T, val: T, _: i32, comptime op: std.builtin.AtomicRmwOp) T {
    const cs = microzig.interrupt.enter_critical_section();
    defer cs.leave();

    const tmp = ptr.*;

    switch (op) {
        .Xchg => ptr.* = val,
        .Add => ptr.* += val,
        .Sub => ptr.* -= val,
        .And => ptr.* &= val,
        .Or => ptr.* |= val,
        .Xor => ptr.* ^= val,
        .Nand => ptr.* = ~(ptr.* & val),
        .Max => ptr.* = @max(ptr.*, val),
        .Min => ptr.* = @min(ptr.*, val),
    }

    return tmp;
}

inline fn atomic_compare_exchange(comptime T: type, ptr: *volatile T, expected: *T, desired: T, _: i32, _: i32) bool {
    const cs = microzig.interrupt.enter_critical_section();
    defer cs.leave();

    const old_value = ptr.*;

    if (old_value == expected.*) {
        ptr.* = desired;
        return true;
    } else {
        expected.* = old_value;
        return false;
    }
}

export fn __atomic_store_1(ptr: *u8, val: u8, model: i32) callconv(.c) void {
    atomic_store(u8, ptr, val, model);
}

export fn __atomic_store_2(ptr: *u16, val: u16, model: i32) callconv(.c) void {
    atomic_store(u16, ptr, val, model);
}

export fn __atomic_store_4(ptr: *u32, val: u32, model: i32) callconv(.c) void {
    atomic_store(u32, ptr, val, model);
}

export fn __atomic_load_1(ptr: *u8, model: i32) callconv(.c) u8 {
    return atomic_load(u8, ptr, model);
}

export fn __atomic_load_2(ptr: *u16, model: i32) callconv(.c) u16 {
    return atomic_load(u16, ptr, model);
}

export fn __atomic_load_4(ptr: *u32, model: i32) callconv(.c) u32 {
    return atomic_load(u32, ptr, model);
}

export fn __atomic_exchange_1(ptr: *u8, val: u8, model: i32) callconv(.c) u8 {
    return atomic_rmw(u8, ptr, val, model, .Xchg);
}

export fn __atomic_exchange_2(ptr: *u16, val: u16, model: i32) callconv(.c) u16 {
    return atomic_rmw(u16, ptr, val, model, .Xchg);
}

export fn __atomic_exchange_4(ptr: *u32, val: u32, model: i32) callconv(.c) u32 {
    return atomic_rmw(u32, ptr, val, model, .Xchg);
}

export fn __atomic_fetch_add_1(ptr: *u8, val: u8, model: i32) callconv(.c) u8 {
    return atomic_rmw(u8, ptr, val, model, .Add);
}

export fn __atomic_fetch_add_2(ptr: *u16, val: u16, model: i32) callconv(.c) u16 {
    return atomic_rmw(u16, ptr, val, model, .Add);
}

export fn __atomic_fetch_add_4(ptr: *u32, val: u32, model: i32) callconv(.c) u32 {
    return atomic_rmw(u32, ptr, val, model, .Add);
}

export fn __atomic_fetch_sub_1(ptr: *u8, val: u8, model: i32) callconv(.c) u8 {
    return atomic_rmw(u8, ptr, val, model, .Sub);
}

export fn __atomic_fetch_sub_2(ptr: *u16, val: u16, model: i32) callconv(.c) u16 {
    return atomic_rmw(u16, ptr, val, model, .Sub);
}

export fn __atomic_fetch_sub_4(ptr: *u32, val: u32, model: i32) callconv(.c) u32 {
    return atomic_rmw(u32, ptr, val, model, .Sub);
}

export fn __atomic_fetch_and_1(ptr: *u8, val: u8, model: i32) callconv(.c) u8 {
    return atomic_rmw(u8, ptr, val, model, .And);
}

export fn __atomic_fetch_and_2(ptr: *u16, val: u16, model: i32) callconv(.c) u16 {
    return atomic_rmw(u16, ptr, val, model, .And);
}

export fn __atomic_fetch_and_4(ptr: *u32, val: u32, model: i32) callconv(.c) u32 {
    return atomic_rmw(u32, ptr, val, model, .And);
}

export fn __atomic_fetch_or_1(ptr: *u8, val: u8, model: i32) callconv(.c) u8 {
    return atomic_rmw(u8, ptr, val, model, .Or);
}

export fn __atomic_fetch_or_2(ptr: *u16, val: u16, model: i32) callconv(.c) u16 {
    return atomic_rmw(u16, ptr, val, model, .Or);
}

export fn __atomic_fetch_or_4(ptr: *u32, val: u32, model: i32) callconv(.c) u32 {
    return atomic_rmw(u32, ptr, val, model, .Or);
}

export fn __atomic_fetch_xor_1(ptr: *u8, val: u8, model: i32) callconv(.c) u8 {
    return atomic_rmw(u8, ptr, val, model, .Xor);
}

export fn __atomic_fetch_xor_2(ptr: *u16, val: u16, model: i32) callconv(.c) u16 {
    return atomic_rmw(u16, ptr, val, model, .Xor);
}

export fn __atomic_fetch_xor_4(ptr: *u32, val: u32, model: i32) callconv(.c) u32 {
    return atomic_rmw(u32, ptr, val, model, .Xor);
}

export fn __atomic_fetch_nand_1(ptr: *u8, val: u8, model: i32) callconv(.c) u8 {
    return atomic_rmw(u8, ptr, val, model, .Nand);
}

export fn __atomic_fetch_nand_2(ptr: *u16, val: u16, model: i32) callconv(.c) u16 {
    return atomic_rmw(u16, ptr, val, model, .Nand);
}

export fn __atomic_fetch_nand_4(ptr: *u32, val: u32, model: i32) callconv(.c) u32 {
    return atomic_rmw(u32, ptr, val, model, .Nand);
}

export fn __atomic_fetch_max_1(ptr: *u8, val: u8, model: i32) callconv(.c) u8 {
    return atomic_rmw(u8, ptr, val, model, .Max);
}

export fn __atomic_fetch_max_2(ptr: *u16, val: u16, model: i32) callconv(.c) u16 {
    return atomic_rmw(u16, ptr, val, model, .Max);
}

export fn __atomic_fetch_max_4(ptr: *u32, val: u32, model: i32) callconv(.c) u32 {
    return atomic_rmw(u32, ptr, val, model, .Max);
}

export fn __atomic_fetch_min_1(ptr: *u8, val: u8, model: i32) callconv(.c) u8 {
    return atomic_rmw(u8, ptr, val, model, .Min);
}

export fn __atomic_fetch_min_2(ptr: *u16, val: u16, model: i32) callconv(.c) u16 {
    return atomic_rmw(u16, ptr, val, model, .Min);
}

export fn __atomic_fetch_min_4(ptr: *u32, val: u32, model: i32) callconv(.c) u32 {
    return atomic_rmw(u32, ptr, val, model, .Min);
}

export fn __atomic_compare_exchange_1(ptr: *u8, expected: *u8, desired: u8, success: i32, failure: i32) callconv(.c) bool {
    return atomic_compare_exchange(u8, ptr, expected, desired, success, failure);
}

export fn __atomic_compare_exchange_2(ptr: *u16, expected: *u16, desired: u16, success: i32, failure: i32) callconv(.c) bool {
    return atomic_compare_exchange(u16, ptr, expected, desired, success, failure);
}

export fn __atomic_compare_exchange_4(ptr: *u32, expected: *u32, desired: u32, success: i32, failure: i32) callconv(.c) bool {
    return atomic_compare_exchange(u32, ptr, expected, desired, success, failure);
}

// esp-idf implements these. might be useful
export fn __atomic_load(size: u32, src: [*]u8, dest: [*]u8, _: i32) callconv(.c) void {
    const cs = microzig.interrupt.enter_critical_section();
    defer cs.leave();
    @memcpy(dest[0..size], src);
}

export fn __atomic_store(size: u32, dest: [*]u8, src: [*]u8, _: i32) callconv(.c) void {
    const cs = microzig.interrupt.enter_critical_section();
    defer cs.leave();
    @memcpy(dest[0..size], src);
}

export fn __atomic_exchange(size: u32, ptr: [*]u8, val: [*]u8, old: [*]u8, _: i32) callconv(.c) void {
    const cs = microzig.interrupt.enter_critical_section();
    defer cs.leave();
    @memcpy(old[0..size], ptr);
    @memcpy(ptr[0..size], val);
}
