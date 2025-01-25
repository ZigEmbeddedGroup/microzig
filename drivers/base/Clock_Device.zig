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
/// If the implementation requires no `object` pointer,
/// you can safely use `undefined` here.
object: *anyopaque,

/// Virtual table for the digital i/o functions.
vtable: *const VTable,

/// API
pub fn is_reached(td: Clock_Device, time: mdf.time.Absolute) bool {
    const now = td.get_time_since_boot();
    return time.is_reached_by(now);
}

pub fn make_timeout(td: Clock_Device, timeout: mdf.time.Duration) mdf.time.Absolute {
    return @as(mdf.time.Absolute, @enumFromInt(td.get_time_since_boot().to_us() + timeout.to_us()));
}

pub fn make_timeout_us(td: Clock_Device, timeout_us: u64) mdf.time.Absolute {
    return @as(mdf.time.Absolute, @enumFromInt(td.get_time_since_boot().to_us() + timeout_us));
}

pub fn sleep_ms(td: Clock_Device, time_ms: u32) void {
    td.sleep_us(time_ms * 1000);
}

pub fn sleep_us(td: Clock_Device, time_us: u64) void {
    const end_time = td.make_timeout_us(time_us);
    while (!td.is_reached(end_time)) {}
}

/// VTable methods
pub fn get_time_since_boot(td: Clock_Device) mdf.time.Absolute {
    return td.vtable.get_time_since_boot(td.object);
}

pub const VTable = struct {
    get_time_since_boot: *const fn (*anyopaque) mdf.time.Absolute,
};

pub const Test_Device = struct {
    time: u64 = 0,

    pub fn init() Test_Device {
        return Test_Device{};
    }

    pub fn elapse_time(dev: *Test_Device, time_us: u64) void {
        dev.time += time_us;
    }

    pub fn set_time(dev: *Test_Device, time_us: u64) void {
        dev.time = time_us;
    }

    pub fn clock_device(dev: *Test_Device) Clock_Device {
        return Clock_Device{
            .object = dev,
            .vtable = &vtable,
        };
    }

    pub fn get_time_since_boot_fn(ctx: *anyopaque) mdf.time.Absolute {
        const dev: *Test_Device = @ptrCast(@alignCast(ctx));
        return @enumFromInt(dev.time);
    }

    const vtable = VTable{
        .get_time_since_boot = Test_Device.get_time_since_boot_fn,
    };
};

test Test_Device {
    var ttd = Test_Device.init();

    const td = ttd.clock_device();

    // Check if time elapses between calls
    try std.testing.expectEqual(0, td.get_time_since_boot().to_us());
    ttd.elapse_time(2);
    try std.testing.expectEqual(2, td.get_time_since_boot().to_us());

    try std.testing.expect(!td.is_reached(@enumFromInt(4)));
    ttd.elapse_time(2);
    try std.testing.expect(td.is_reached(@enumFromInt(4)));

    // Timeouts
    try std.testing.expectEqual(
        54,
        @intFromEnum(td.make_timeout(mdf.time.Duration.from_us(50))),
    );
    ttd.elapse_time(50);
    try std.testing.expectEqual(
        104,
        @intFromEnum(td.make_timeout_us(50)),
    );
}
