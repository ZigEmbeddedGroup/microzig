// Based on: https://github.com/ziglang/zig/blob/79460d4a3eef8eb927b02a7eda8bc9999a766672/lib/compiler_rt/atomics.zig
// and: https://github.com/raspberrypi/pico-sdk/blob/ee68c78d0afae2b69c03ae1a72bf5cc267a2d94c/src/rp2_common/pico_atomic/atomic.c

const std = @import("std");
const builtin = @import("builtin");
const microzig = @import("microzig");

const chip = microzig.hal.compatibility.chip;
const CriticalSection = microzig.interrupt.CriticalSection;

const atomic_spinlock: microzig.hal.multicore.Spinlock = .atomics;

inline fn atomic_lock() CriticalSection {
    return atomic_spinlock.lock_irq();
}

inline fn atomic_unlock(critical_section: CriticalSection) void {
    atomic_spinlock.unlock_irq(critical_section);
}

fn atomic_store(comptime T: type, ptr: *volatile T, val: T, _: i32) void {
    const save = atomic_lock();
    defer atomic_unlock(save);
    ptr.* = val;
}

fn atomic_load(comptime T: type, ptr: *volatile T, _: i32) T {
    const save = atomic_lock();
    defer atomic_unlock(save);
    const val = ptr.*;
    return val;
}

fn atomic_rmw(comptime T: type, ptr: *volatile T, val: T, _: i32, comptime op: std.builtin.AtomicRmwOp) T {
    const save = atomic_lock();
    defer atomic_unlock(save);
    const tmp = ptr.*;

    switch (op) {
        .Xchg => ptr.* = val,
        .Add => ptr.* += val,
        .Sub => ptr.* -= val,
        .And => ptr.* &= val,
        .Or => ptr.* |= val,
        .Xor => ptr.* ^= val,
        .Nand => ptr.* = ~ptr.* & val,
        .Max => ptr.* = @max(ptr.*, val),
        .Min => ptr.* = @min(ptr.*, val),
    }

    return tmp;
}

fn atomic_compare_exchange(comptime T: type, ptr: *volatile T, expected: *T, desired: T, _: i32, _: i32) bool {
    const save = atomic_lock();
    defer atomic_unlock(save);
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
