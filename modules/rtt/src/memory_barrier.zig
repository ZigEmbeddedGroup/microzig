const std = @import("std");
const builtin = @import("builtin");

pub const MemoryBarrierFn = fn () callconv(.Inline) void;

pub inline fn emptyMemoryBarrier() void {}

inline fn armMemoryBarrier() void {
    asm volatile ("DMB" ::: "memory");
}

inline fn errorMemoryBarrier() void {
    @compileError(std.fmt.comptimePrint("Unsupported architecture for built in memory barrier: {any}, please provide custom memory barrier support via Config.memory_barrier_fn field", .{builtin.cpu.arch}));
}
/// Resolves built in memory barrier support for a specific platform.
pub fn resolveMemoryBarrier() struct { memory_barrier_fn: MemoryBarrierFn } {
    const current_arch = builtin.cpu.arch;
    switch (current_arch) {
        .arm, .armeb, .thumb, .thumbeb => {},
        // Nothing other than ARM has explicit memory barrier support yet
        else => return .{ .memory_barrier_fn = errorMemoryBarrier },
    }

    // All currently supported ARM chips
    if (builtin.cpu.features.isEnabled(@intFromEnum(std.Target.arm.Feature.v6m)) or
        builtin.cpu.features.isEnabled(@intFromEnum(std.Target.arm.Feature.v8m)) or
        builtin.cpu.features.isEnabled(@intFromEnum(std.Target.arm.Feature.v7m)) or
        builtin.cpu.features.isEnabled(@intFromEnum(std.Target.arm.Feature.v7em)) or
        builtin.cpu.features.isEnabled(@intFromEnum(std.Target.arm.Feature.v8m_main)) or
        builtin.cpu.features.isEnabled(@intFromEnum(std.Target.arm.Feature.v7a)) or
        builtin.cpu.features.isEnabled(@intFromEnum(std.Target.arm.Feature.v7r)))
    {
        // Something to note here is not all Cortex-M chips need a DMB instruction since some
        // don't support CPU reordering of instructions. However, these end up getting ignored
        // by the processor in this case so it's safe to provide it for all ARM chips for now.
        return .{ .memory_barrier_fn = armMemoryBarrier };
    } else {
        return .{ .memory_barrier_fn = errorMemoryBarrier };
    }
}
