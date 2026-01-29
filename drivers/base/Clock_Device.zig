//!
//! An abstract clock device
//!
//! Clock_Devices can be used to track time & sleep
//!

const std = @import("std");
const mdf = @import("../framework.zig");

const Clock_Device = @This();

/// Pointer to the object implementing the driver.
///
/// If the implementation requires no `ptr` pointer,
/// you can safely use `undefined` here.
ptr: *anyopaque,

/// Virtual table for the digital i/o functions.
vtable: *const VTable,

/// Object created by make_timeout to perform to hold
/// a duration.
pub const Timeout = struct {
    clock: Clock_Device,
    time: mdf.time.Absolute,

    pub fn is_reached(self: @This()) bool {
        return self.clock.is_reached(self.time);
    }

    pub fn diff(self: @This()) mdf.time.Duration {
        return self.time.diff(self.clock.get_time_since_boot());
    }
};

pub fn is_reached(td: Clock_Device, time: mdf.time.Absolute) bool {
    const now = td.get_time_since_boot();
    return time.is_reached_by(now);
}

pub fn make_timeout(td: Clock_Device, timeout: mdf.time.Duration) Timeout {
    return .{
        .clock = td,
        .time = td.get_time_since_boot().add_duration(timeout),
    };
}

pub fn sleep_ms(td: Clock_Device, time_ms: u32) void {
    td.sleep_us(time_ms * 1000);
}

pub fn sleep_us(td: Clock_Device, time_us: u64) void {
    // If the device provides a custom sleep implementation, use it
    if (td.vtable.sleep) |sleep_fn| {
        sleep_fn(td.ptr, time_us);
        return;
    }

    // Otherwise, fall back to polling
    const end_time = td.make_timeout(.from_us(time_us));
    while (!end_time.is_reached()) {}
}

/// VTable methods
pub fn get_time_since_boot(td: Clock_Device) mdf.time.Absolute {
    return td.vtable.get_time_since_boot(td.ptr);
}

pub const VTable = struct {
    get_time_since_boot: *const fn (*anyopaque) mdf.time.Absolute,
    sleep: ?*const fn (*anyopaque, u64) void = null,
};

pub const Test_Device = struct {
    time: u64 = 0,
    total_sleep_time: u64 = 0,

    pub fn init() Test_Device {
        return Test_Device{};
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

    pub fn clock_device(dev: *Test_Device) Clock_Device {
        return Clock_Device{
            .ptr = dev,
            .vtable = &vtable,
        };
    }

    pub fn get_time_since_boot_fn(ctx: *anyopaque) mdf.time.Absolute {
        const dev: *Test_Device = @ptrCast(@alignCast(ctx));
        return @enumFromInt(dev.time);
    }

    pub fn sleep_fn(ctx: *anyopaque, time_us: u64) void {
        const dev: *Test_Device = @ptrCast(@alignCast(ctx));
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

    // Time reached
    try std.testing.expect(!td.is_reached(.from_us(3)));
    ttd.elapse_time(2);
    try std.testing.expect(td.is_reached(.from_us(3)));

    // Timeouts
    const timeout = td.make_timeout(.from_us(50));
    ttd.elapse_time(40);
    try std.testing.expectEqual(mdf.time.Duration.from_us(10), timeout.diff());
    ttd.elapse_time(10);
    try std.testing.expect(timeout.is_reached());

    try std.testing.expectEqual(0, ttd.get_total_sleep_time());
    td.sleep_ms(1000);
    try std.testing.expectEqual(1_000_000, ttd.get_total_sleep_time());
}
