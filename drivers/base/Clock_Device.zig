//!
//! An abstract clock device
//!
//! Clock_Devices can be used to track time & sleep
//!

const std = @import("std");
const mdf = @import("../framework.zig");

const Clock_Device = @This();

/// Virtual table for the digital i/o functions.
vtable: *const VTable,

/// Make this object using:
/// `const timeout = clock.make_timeout(Duration.from_us(100))`
///
/// This is handy when you need to communicate with peripherale
/// within a duration.
pub const Timeout = struct {
    clock: *Clock_Device,
    time: mdf.time.Absolute,

    pub fn is_reached(self: @This()) bool {
        return self.clock.is_reached(self.time);
    }

    pub fn diff(self: @This()) mdf.time.Duration {
        return self.time.diff(self.clock.get_time_since_boot());
    }
};

fn is_reached(td: *Clock_Device, time: mdf.time.Absolute) bool {
    const now = td.get_time_since_boot();
    return time.is_reached_by(now);
}

/// API
pub fn make_timeout(td: *Clock_Device, timeout: mdf.time.Duration) Timeout {
    return .{
        .clock = td,
        .time = @as(mdf.time.Absolute, @enumFromInt(td.get_time_since_boot().to_us() + timeout.to_us())),
    };
}

pub fn make_timeout_us(td: *Clock_Device, timeout_us: u64) Timeout {
    return .{
        .clock = td,
        .time = @as(mdf.time.Absolute, @enumFromInt(td.get_time_since_boot().to_us() + timeout_us)),
    };
}

pub fn sleep_ms(td: *Clock_Device, time_ms: u32) void {
    td.sleep_us(time_ms * 1000);
}

pub fn sleep_us(td: *Clock_Device, time_us: u64) void {
    // If the device provides a custom sleep implementation, use it
    if (td.vtable.sleep) |sleep_fn| {
        sleep_fn(td, time_us);
        return;
    }

    // Otherwise, fall back to polling
    const end_time = td.make_timeout_us(time_us);
    while (!end_time.is_reached()) {}
}

/// VTable methods
pub fn get_time_since_boot(td: *Clock_Device) mdf.time.Absolute {
    return td.vtable.get_time_since_boot(td);
}

pub const VTable = struct {
    get_time_since_boot: *const fn (td: *Clock_Device) mdf.time.Absolute,
    sleep: ?*const fn (td: *Clock_Device, u64) void = null,
};

pub const Test_Device = struct {
    time: u64 = 0,
    total_sleep_time: u64 = 0,
    interface: Clock_Device,

    pub fn init() Test_Device {
        return Test_Device{ .interface = .{ .vtable = &vtable } };
    }

    pub fn elapse_time(dev: *Test_Device, time_us: u64) void {
        dev.time += time_us;
    }

    pub fn set_time(dev: *Test_Device, time_us: u64) void {
        dev.time = time_us;
    }

    pub fn get_total_sleep_time(dev: *Test_Device) u64 {
        return dev.total_sleep_time;
    }

    pub fn reset_sleep_time(dev: *Test_Device) void {
        dev.total_sleep_time = 0;
    }

    pub fn clock_device(dev: *Test_Device) *Clock_Device {
        return &dev.interface;
    }

    pub fn get_time_since_boot_fn(ctx: *Clock_Device) mdf.time.Absolute {
        const dev: *Test_Device = @alignCast(@fieldParentPtr("interface", ctx));
        return @enumFromInt(dev.time);
    }

    pub fn sleep_fn(ctx: *Clock_Device, time_us: u64) void {
        const dev: *Test_Device = @alignCast(@fieldParentPtr("interface", ctx));
        dev.total_sleep_time += time_us;
        dev.time += time_us;
    }

    const vtable = VTable{
        .get_time_since_boot = Test_Device.get_time_since_boot_fn,
        .sleep = Test_Device.sleep_fn,
    };
};

test Test_Device {
    var ttd = Test_Device.init();

    const td = ttd.clock_device();

    // Check if time elapses between calls
    try std.testing.expectEqual(0, td.get_time_since_boot().to_us());
    ttd.elapse_time(2);
    try std.testing.expectEqual(2, td.get_time_since_boot().to_us());

    // Timeouts
    const timeout = td.make_timeout(@enumFromInt(2));
    try std.testing.expect(!timeout.is_reached());
    ttd.elapse_time(2);
    try std.testing.expect(timeout.is_reached());

    try std.testing.expectEqual(
        54,
        @intFromEnum(td.make_timeout(mdf.time.Duration.from_us(50)).time),
    );
    ttd.elapse_time(50);
    try std.testing.expectEqual(104, @intFromEnum(td.make_timeout_us(50).time));

    try std.testing.expectEqual(0, ttd.get_total_sleep_time());
    td.sleep_ms(1000);
    try std.testing.expectEqual(1_000_000, ttd.get_total_sleep_time());
}
