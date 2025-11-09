const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = @import("../hal.zig");
const Io = microzig.core.Io;

/// See Io.VTable for function descriptions.
pub const vtable: Io.VTable = .{
    .monotonic_clock = rp2xxx.time.get_time_since_boot,
    .dma_memcpy = dma_memcpy,
};

pub fn dma_memcpy(dst: *anyopaque, src: *const anyopaque, size: usize) !Io.DmaResult {
    const channel = rp2xxx.dma.claim_unused_channel().?;
    try channel.setup_transfer(
        @as([*]u8, @ptrCast(dst))[0..size],
        @as([*]const u8, @ptrCast(src))[0..size],
        .{ .trigger = true, .enable = true },
    );
    return .{
        .await = &dma_await,
        .channel = @intFromEnum(channel),
    };
}

pub fn dma_await(result: *Io.DmaResult, io: *Io.RoundRobin) void {
    const channel = rp2xxx.dma.channel(@intCast(result.channel));
    const ctrl = &channel.get_regs().ctrl_trig;
    var mask: @TypeOf(ctrl.*).underlying_type = @bitCast(@as(u32, 0));
    mask.BUSY = 1;
    io.pause(&.{ .bits_mask_all_low = .{ .ptr = @ptrCast(@volatileCast(ctrl)), .mask = @bitCast(mask) } });
}
