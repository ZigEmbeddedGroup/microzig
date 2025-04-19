const std = @import("std");
const mdf = @import("../framework.zig");

/// Calculate the duration of a step pulse for a stepper with `steps` steps, `microsteps`
/// microsteps, at `rpm` rpm.
pub inline fn get_step_pulse(steps: i32, microsteps: u8, rpm: f64) mdf.time.Duration {
    return @enumFromInt(@as(u64, @intFromFloat(60.0 * 1000000 /
        @as(f64, @floatFromInt(steps)) /
        @as(f64, @floatFromInt(microsteps)) / rpm)));
}

pub inline fn calc_steps_for_rotation(steps: i32, microsteps: u8, deg: i32) i32 {
    return @divTrunc(deg * steps * microsteps, 360);
}

test "calculate step pulse" {
    // 30 rpm = 1/2 per second = 250 steps = 4ms
    try std.testing.expectEqual(4000, get_step_pulse(500, 1, 30).to_us());
    // 30 rpm = 1/2 per second, 2 microsteps = 500 steps = 2ms
    try std.testing.expectEqual(2000, get_step_pulse(500, 2, 30).to_us());
    // 10 rpm = 1/6 per second = 100 steps = 10ms
    try std.testing.expectEqual(10000, get_step_pulse(600, 1, 10).to_us());
    // 10 rpm = 1/6 per second, 2 ms = 200 steps = 5ms
    try std.testing.expectEqual(5000, get_step_pulse(600, 2, 10).to_us());
}

test "calculate steps" {
    try std.testing.expectEqual(512, calc_steps_for_rotation(512, 1, 360));
    try std.testing.expectEqual(1024, calc_steps_for_rotation(512, 2, 360));
    try std.testing.expectEqual(-800, calc_steps_for_rotation(200, 4, -360));
}
