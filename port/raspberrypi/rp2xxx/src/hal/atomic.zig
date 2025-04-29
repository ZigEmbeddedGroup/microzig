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

fn atomic_load(comptime T: type, ptr: *volatile T, _: i32) T {
    const save = atomic_lock();
    defer atomic_unlock(save);
    const val = ptr.*;
    return val;
}

fn atomic_rmw_and(comptime T: type, ptr: *volatile T, val: T, _: i32) T {
    const save = atomic_lock();
    defer atomic_unlock(save);
    const tmp = ptr.*;
    ptr.* = tmp & val;
    return tmp;
}

fn atomic_rmw_or(comptime T: type, ptr: *volatile T, val: T, _: i32) T {
    const save = atomic_lock();
    defer atomic_unlock(save);
    const tmp = ptr.*;
    ptr.* = tmp | val;
    return tmp;
}

fn __atomic_fetch_and_4(ptr: *u32, val: u32, model: i32) callconv(.c) u32 {
    return atomic_rmw_and(u32, ptr, val, model);
}

fn __atomic_fetch_or_4(ptr: *u32, val: u32, model: i32) callconv(.c) u32 {
    return atomic_rmw_or(u32, ptr, val, model);
}

fn __atomic_load_4(src: *u32, model: i32) callconv(.c) u32 {
    return atomic_load(u32, src, model);
}

const linkage: std.builtin.GlobalLinkage = if (builtin.is_test)
    .internal
else if (builtin.object_format == .c)
    .strong
else
    .weak;

const visibility: std.builtin.SymbolVisibility = .default;

// Based on: https://github.com/ziglang/zig/blob/79460d4a3eef8eb927b02a7eda8bc9999a766672/lib/compiler_rt/atomics.zig
// and: https://github.com/raspberrypi/pico-sdk/blob/ee68c78d0afae2b69c03ae1a72bf5cc267a2d94c/src/rp2_common/pico_atomic/atomic.c
// TODO: export all the rest atomics

comptime {
    // This export should only happen for the RP2040 due to the ARMv6-M ISA used by the ARM Cortex-M0+.
    if (chip == .RP2040) {
        @export(&__atomic_fetch_and_4, .{ .name = "__atomic_fetch_and_4", .linkage = linkage, .visibility = visibility });
        @export(&__atomic_fetch_or_4, .{ .name = "__atomic_fetch_or_4", .linkage = linkage, .visibility = visibility });

        @export(&__atomic_load_4, .{ .name = "__atomic_load_4", .linkage = linkage, .visibility = visibility });
    }
}
