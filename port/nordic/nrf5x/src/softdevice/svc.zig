// SVC (Supervisor Call) mechanism for Nordic SoftDevice.
//
// The SoftDevice uses SVC instructions to dispatch function calls from
// application code. Parameters are passed in r0-r3 per ARM calling
// convention. The SVC number is encoded in the instruction immediate.

const std = @import("std");

fn comptime_num(comptime num: u32) []const u8 {
    return std.fmt.comptimePrint("{d}", .{num});
}

pub inline fn svcall0(comptime num: u32) u32 {
    return asm volatile ("svc " ++ comptime_num(num)
        : [ret] "={r0}" (-> u32),
        :
        : .{ .memory = true });
}

pub inline fn svcall1(comptime num: u32, p0: usize) u32 {
    return asm volatile ("svc " ++ comptime_num(num)
        : [ret] "={r0}" (-> u32),
        : [p0] "{r0}" (p0),
        : .{ .memory = true });
}

pub inline fn svcall2(comptime num: u32, p0: usize, p1: usize) u32 {
    return asm volatile ("svc " ++ comptime_num(num)
        : [ret] "={r0}" (-> u32),
        : [p0] "{r0}" (p0),
          [p1] "{r1}" (p1),
        : .{ .memory = true });
}

pub inline fn svcall3(comptime num: u32, p0: usize, p1: usize, p2: usize) u32 {
    return asm volatile ("svc " ++ comptime_num(num)
        : [ret] "={r0}" (-> u32),
        : [p0] "{r0}" (p0),
          [p1] "{r1}" (p1),
          [p2] "{r2}" (p2),
        : .{ .memory = true });
}

pub inline fn svcall4(comptime num: u32, p0: usize, p1: usize, p2: usize, p3: usize) u32 {
    return asm volatile ("svc " ++ comptime_num(num)
        : [ret] "={r0}" (-> u32),
        : [p0] "{r0}" (p0),
          [p1] "{r1}" (p1),
          [p2] "{r2}" (p2),
          [p3] "{r3}" (p3),
        : .{ .memory = true });
}
