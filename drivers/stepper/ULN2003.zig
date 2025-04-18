//!
//! Generic driver for ULN2003 'dumb' stepper motor driver, typically used for unipolar stepper
//! motors such as the 28BYJ-48
//!
//! Datasheet:
//! * ULN2003: https://www.ti.com/lit/ds/symlink/uln2003a.pdf
//!

const std = @import("std");
const mdf = @import("../framework.zig");

pub const Stepper_Options = struct {
    in1_pin: mdf.base.Digital_IO,
    in2_pin: mdf.base.Digital_IO,
    in3_pin: mdf.base.Digital_IO,
    in4_pin: mdf.base.Digital_IO,
    clock_device: mdf.base.Clock_Device,
    motor_steps: u16 = 512,
    // motor_steps: u16 = 2048,
};

pub const MSPinsError = error.MSPinsError;
pub const Speed_Profile = union(enum) {
    constant_speed,
    linear_speed: struct {
        accel: u16 = 1000,
        decel: u16 = 1000,
    },
};

pub const State = enum {
    stopped,
    accelerating,
    cruising,
    decelerating,
};

const Direction = enum { forward, backward };

// TODO:
// E.g. A4988?
// DRIVER    = 1, ///< Stepper Driver, 2 driver pins required
// FULL2WIRE = 2, ///< 2 wire stepper, 2 motor pins required
// FULL3WIRE = 3, ///< 3 wire stepper, such as HDD spindle, 3 motor pins required
// HALF3WIRE = 6, ///< 3 wire half stepper, such as HDD spindle, 3 motor pins required
// NOTE: These are4 pin, just that 'half' is microstepping
// FULL4WIRE = 4, ///< 4 wire full stepper, 4 motor pins required
// HALF4WIRE = 8  ///< 4 wire half stepper, 4 motor pins required

pub const ULN2003 = struct {
    const STEP_MIN_US = 2;
    const STEP_TABLE_FULL = [_]u4{ 0b1010, 0b0110, 0b0101, 0b1001 };
    const STEP_TABLE_HALF = [_]u4{ 0b1000, 0b1010, 0b0010, 0b0110, 0b0100, 0b0101, 0b0001, 0b1001 };
};

pub fn Stepper(comptime Driver: type) type {
    return struct {
        const Self = @This();
        driver: Driver = .{},

        in: [4]mdf.base.Digital_IO,
        clock: mdf.base.Clock_Device,
        rpm: f64 = 0,
        step_table: []const u4 = Driver.STEP_TABLE_FULL[0..],
        microsteps: u2 = 1,

        // Movement state
        step_index: u4 = 0,
        profile: Speed_Profile = .constant_speed,
        // Steps remaining in accel
        steps_to_cruise: u32 = 0,
        // Steps remaining in current move
        steps_remaining: u32 = 0,
        // Steps remaining in decel
        steps_to_brake: u32 = 0,
        // The length of the next pulse
        step_pulse: mdf.time.Duration = .from_us(0),
        cruise_step_pulse: mdf.time.Duration = .from_us(0),
        remainder: mdf.time.Duration = .from_us(0),
        last_action_end: mdf.time.Absolute = .from_us(0),
        next_action_interval: mdf.time.Duration = .from_us(0),
        step_count: u32 = 0,
        direction: Direction = .forward,
        motor_steps: u16,

        pub fn init(opts: Stepper_Options) Self {
            return Self{
                .clock = opts.clock_device,
                .in = .{ opts.in1_pin, opts.in2_pin, opts.in3_pin, opts.in4_pin },
                .motor_steps = opts.motor_steps,
            };
        }

        pub fn begin(self: *Self, rpm: f64, microsteps: u2) !void {
            self.rpm = rpm;
            _ = try self.set_microstep(microsteps);

            try self.enable();
        }

        pub fn enable(self: *Self) !void {
            inline for (self.in) |pin| {
                try pin.set_direction(.output);
            }
        }

        /// Set pins in high-impedence mode to reduce power consumption. This will stop holding the
        /// stepper motor's position.
        pub fn disable(self: *Self) !void {
            inline for (self.in) |pin| {
                pin.set_direction(.input);
            }
        }

        pub fn set_rpm(self: Self, rpm: f64) void {
            self.rpm = rpm;
        }

        pub fn set_microstep(self: *Self, microsteps: u2) !void {
            if (self.microsteps == microsteps) return;

            switch (microsteps) {
                1 => {
                    self.step_table = Driver.STEP_TABLE_FULL[0..];
                    self.step_index = self.step_index >> 1;
                },
                2 => {
                    self.step_table = Driver.STEP_TABLE_HALF[0..];
                    self.step_index = self.step_index * 2;
                },
                else => return error.InvalidMicrosteps,
            }

            self.microsteps = microsteps;
        }

        pub fn set_speed_profile(self: *Self, profile: Speed_Profile) void {
            self.profile = profile;
        }

        /// Synchronously run the specified number of steps
        pub fn move(self: *Self, steps: i32) !void {
            self.start_move(steps);
            var action = try self.run();
            while (@intFromEnum(action) != 0) : (action = try self.run()) {}
        }

        /// Synchronously rotate the specified number of degrees
        pub fn rotate(self: *Self, deg: i32) !void {
            const steps = self.calc_steps_for_rotation(deg);
            std.log.info("Steps for rotating {} degrees: {}", .{ deg, steps });
            try self.move(steps);
        }

        pub fn start_move(self: *Self, steps: i32) void {
            self.start_move_time(steps, .from_us(0));
        }

        pub fn start_move_time(self: *Self, steps: i32, time: mdf.time.Duration) void {
            // set up new move
            self.direction = if (steps >= 0) .forward else .backward;
            self.last_action_end = .from_us(0);
            self.steps_remaining = @abs(steps);
            self.step_count = 0;
            self.remainder = .from_us(0);
            switch (self.profile) {
                .linear_speed => |p| {
                    const microstep_f: f64 = @floatFromInt(self.microsteps);
                    const accel_f: f64 = @floatFromInt(p.accel);
                    const decel_f: f64 = @floatFromInt(p.decel);
                    // speed is in [steps/s]
                    var speed: f64 = (self.rpm * @as(f64, @floatFromInt(self.motor_steps))) / 60;
                    if (@intFromEnum(time) > 0) {
                        // Calculate a new speed to finish in the time requested
                        const t: f64 = @as(f64, @floatFromInt(time.to_us())) / 1e+6; // convert to seconds
                        const d: f64 = @as(f64, @floatFromInt(self.steps_remaining)) / microstep_f; // convert to full steps
                        const a2: f64 = 1.0 / accel_f + 1.0 / decel_f;
                        const sqrt_candidate = t * t - 2 * a2 * d; // in √b^2-4ac
                        if (sqrt_candidate >= 0)
                            speed = @min(speed, (t - std.math.sqrt(sqrt_candidate)) / a2);
                    }
                    // How many microsteps from 0 to target speed
                    self.steps_to_cruise = @intFromFloat(@as(f64, microstep_f * (speed * speed)) / (2 * accel_f));
                    // How many microsteps are needed from cruise speed to a full stop
                    self.steps_to_brake = @intFromFloat(@as(f64, @floatFromInt(self.steps_to_cruise)) * accel_f / decel_f);
                    if (self.steps_remaining < self.steps_to_cruise + self.steps_to_brake) {
                        // Cannot reach max speed, will need to brake early
                        self.steps_to_cruise = @intFromFloat(@as(f64, @floatFromInt(self.steps_remaining)) * decel_f / (accel_f + decel_f));
                        self.steps_to_brake = self.steps_remaining - self.steps_to_cruise;
                    }
                    // Initial pulse (c0) including error correction factor 0.676 [us]
                    self.step_pulse = @enumFromInt(@as(u64, @intFromFloat((1e+6) * 0.676 * std.math.sqrt(2.0 / accel_f / microstep_f))));
                    // Save cruise timing since we will no longer have the calculated target speed later
                    self.cruise_step_pulse = @enumFromInt(@as(u64, @intFromFloat(1e+6 / speed / microstep_f)));
                },
                .constant_speed => {
                    self.steps_to_cruise = 0;
                    self.steps_to_brake = 0;
                    self.cruise_step_pulse = get_step_pulse(self.motor_steps, self.microsteps, self.rpm);
                    // NOTE: This is correct // DELETEME
                    // std.log.info("Step pulse: {} us", .{self.cruise_step_pulse.to_us()}); // DELETEME
                    self.step_pulse = self.cruise_step_pulse;
                    // if (@intFromEnum(time) > self.steps_remaining * @intFromEnum(self.step_pulse)) {
                    //     self.step_pulse = .from_us(@intFromFloat(@as(f64, @floatFromInt(time.to_us())) /
                    //         @as(f64, @floatFromInt(self.steps_remaining))));
                    // }
                },
            }
        }

        /// Calculate the duration of a step pulse for a stepper with `steps` steps, `microsteps`
        /// microsteps, at `rpm` rpm.
        inline fn get_step_pulse(steps: i32, microsteps: u8, rpm: f64) mdf.time.Duration {
            return @enumFromInt(@as(u64, @intFromFloat(60.0 * 1000000 /
                @as(f64, @floatFromInt(steps)) /
                @as(f64, @floatFromInt(microsteps)) / rpm)));
        }

        fn calc_step_pulse(self: *Self) void {
            // this should not happen, but avoids strange calculations
            if (self.steps_remaining <= 0) {
                return;
            }
            self.steps_remaining -= 1;
            self.step_count += 1;

            if (self.profile == .linear_speed) {
                switch (self.get_current_state()) {
                    .accelerating => {
                        if (self.step_count < self.steps_to_cruise) {
                            var numerator = 2 * @intFromEnum(self.step_pulse) + @intFromEnum(self.remainder);
                            const denominator = 4 * self.step_count + 1;
                            // Pulse shrinks as we are nearer to cruising speed, based on step_count
                            self.step_pulse = self.step_pulse.minus(@enumFromInt(numerator / denominator));
                            // Update based on new step_pulse
                            numerator = 2 * @intFromEnum(self.step_pulse) + @intFromEnum(self.remainder);
                            self.remainder = @enumFromInt(numerator % denominator);
                        } else {
                            // The series approximates target, set the final value to what it should be instead
                            self.step_pulse = self.cruise_step_pulse;
                            self.remainder = .from_us(0);
                        }
                    },
                    .decelerating => {
                        var numerator = 2 * @intFromEnum(self.step_pulse) + @intFromEnum(self.remainder);
                        const denominator = 4 * self.steps_remaining + 1;
                        // Pulse grows as we are near stopped, based on steps_remaining
                        self.step_pulse = self.step_pulse.plus(@enumFromInt(numerator / denominator));
                        // Update based on new step_pulse
                        numerator = 2 * @intFromEnum(self.step_pulse) + @intFromEnum(self.remainder);
                        self.remainder = @enumFromInt(numerator % denominator);
                    },
                    // If not accelerating or decelerating, we are either stopped
                    // or cruising, in which case, the step_pulse is already
                    // correct.
                    else => {},
                }
            }
        }

        /// Delay delay_us from start_us. This accounts for time spent elsewhere since start_us
        fn delay_micros(self: Self, delay_us: mdf.time.Duration, start_us: mdf.time.Absolute) void {
            if (@intFromEnum(start_us) == 0) {
                self.clock.sleep_us(@intFromEnum(delay_us));
                return;
            }
            const deadline: mdf.time.Deadline = .init_relative(start_us, delay_us);
            while (!deadline.is_reached_by(self.clock.get_time_since_boot())) {}
        }

        /// Run the current step and calculate the next one
        fn run(self: *Self) !mdf.time.Duration {
            if (self.steps_remaining > 0) {
                // Wait until for the next action interval, since the last action ended
                //   DELETEME>>
                std.log.info("remaining: {}. Delaying for {any}us from {any}us (now: {any}us)", .{
                    self.steps_remaining,
                    self.next_action_interval.to_us(),
                    self.last_action_end.to_us(),
                    self.clock.get_time_since_boot().to_us(),
                });
                //   DELETEME<<
                self.delay_micros(self.next_action_interval, self.last_action_end);
                try self.step(self.direction);
                // Absolute time now
                const start = self.clock.get_time_since_boot();
                const pulse = self.step_pulse; // save value because calc_step_pulse() will overwrite it
                self.calc_step_pulse();
                // We need to hold the pins for at least STEP_MIN_US
                self.clock.sleep_us(Driver.STEP_MIN_US);
                // Account for the time calculating and min sleeping
                self.last_action_end = self.clock.get_time_since_boot();
                const elapsed = self.last_action_end.diff(start);
                self.next_action_interval = if (elapsed.less_than(pulse)) pulse.minus(elapsed) else @enumFromInt(1);
            } else {
                // end of move
                self.last_action_end = .from_us(0);
                self.next_action_interval = .from_us(0);
            }
            return self.next_action_interval;
        }

        /// Change outputs to the next step in the cycle
        // TODO: Not pub?
        pub fn step(self: *Self, direction: Direction) !void {
            // TODO: respect direction
            const pattern = self.step_table[self.step_index];
            const len = self.step_table.len;
            const mask: u4 = @truncate(len - 1); // This is 3 for len=4, 7 for len=8
            switch (direction) {
                .forward => self.step_index = @intCast((self.step_index + 1) & mask),
                .backward => self.step_index = @intCast((self.step_index + mask) & mask),
            }
            // std.log.info("t1 {b:0>4} t2 {b:0>4}", .{ Driver.STEP_TABLE_FULL, Driver.STEP_TABLE_HALF });
            // std.log.info("pattern {b:0>4} index {}", .{ pattern, self.step_index });
            // Update all pins based on the bit pattern
            for (0.., self.in) |i, pin| {
                try pin.write(@enumFromInt(@intFromBool((pattern & (@as(u4, 1) << @intCast(i))) != 0)));
            }
        }

        fn get_current_state(self: Self) State {
            if (self.steps_remaining <= 0)
                return .stopped;

            if (self.steps_remaining <= self.steps_to_brake)
                return .decelerating
            else if (self.step_count <= self.steps_to_cruise)
                return .accelerating
            else
                return .cruising;
        }

        fn start_brake(self: *Self) void {
            switch (self.get_current_state()) {
                .cruising => self.steps_remaining = self.steps_to_brake,
                .accelerating => self.steps_remaining = self.step_count * self.profile.accel / self.profile.decel,
                else => {}, // Do nothing, already decelerating or stopped.
            }
        }

        pub fn stop(self: *Self) void {
            const rv = self.steps_remaining;
            self.steps_remaining = 0;
            return rv;
        }

        fn get_steps_completed(self: Self) u32 {
            return self.step_count;
        }

        fn calc_steps_for_rotation(self: Self, deg: i32) i32 {
            return @divTrunc(deg * self.motor_steps * self.microsteps, 360);
        }
    };
}

test {
    const TestGPIO = mdf.base.Digital_IO.Test_Device;
    const TestTime = mdf.base.Clock_Device.Test_Device;
    var in1 = TestGPIO.init(.output, .high);
    var in2 = TestGPIO.init(.output, .high);
    var in3 = TestGPIO.init(.output, .high);
    var in4 = TestGPIO.init(.output, .high);
    var ttd = TestTime.init();
    _ = Stepper(ULN2003).init(.{
        .in1_pin = in1.digital_io(),
        .in2_pin = in2.digital_io(),
        .in3_pin = in3.digital_io(),
        .in4_pin = in4.digital_io(),
        .clock_device = ttd.clock_device(),
    });
}

test "begin" {
    const TestGPIO = mdf.base.Digital_IO.Test_Device;
    const TestTime = mdf.base.Clock_Device.Test_Device;
    var in1 = TestGPIO.init(.output, .high);
    var in2 = TestGPIO.init(.output, .high);
    var in3 = TestGPIO.init(.output, .high);
    var in4 = TestGPIO.init(.output, .high);
    var ttd = TestTime.init();
    var stepper = Stepper(ULN2003).init(.{
        .in1_pin = in1.digital_io(),
        .in2_pin = in2.digital_io(),
        .in3_pin = in3.digital_io(),
        .in4_pin = in4.digital_io(),
        .clock_device = ttd.clock_device(),
    });
    try stepper.begin(100, 1);
    try std.testing.expectEqual(1, stepper.microsteps);
    try stepper.begin(100, 2);
    try std.testing.expectEqual(2, stepper.microsteps);
}

test "set microsteps" {
    const TestGPIO = mdf.base.Digital_IO.Test_Device;
    const TestTime = mdf.base.Clock_Device.Test_Device;
    var in1 = TestGPIO.init(.output, .high);
    var in2 = TestGPIO.init(.output, .high);
    var in3 = TestGPIO.init(.output, .high);
    var in4 = TestGPIO.init(.output, .high);
    var ttd = TestTime.init();
    var stepper = Stepper(ULN2003).init(.{
        .in1_pin = in1.digital_io(),
        .in2_pin = in2.digital_io(),
        .in3_pin = in3.digital_io(),
        .in4_pin = in4.digital_io(),
        .clock_device = ttd.clock_device(),
    });
    try stepper.set_microstep(1);
    try stepper.set_microstep(2);
    try std.testing.expectError(error.InvalidMicrosteps, stepper.set_microstep(0));
    try std.testing.expectError(error.InvalidMicrosteps, stepper.set_microstep(3));
}

test "step" {
    const TestGPIO = mdf.base.Digital_IO.Test_Device;
    const TestTime = mdf.base.Clock_Device.Test_Device;
    var in1 = TestGPIO.init(.output, .high);
    var in2 = TestGPIO.init(.output, .high);
    var in3 = TestGPIO.init(.output, .high);
    var in4 = TestGPIO.init(.output, .high);
    var ttd = TestTime.init();
    var stepper = Stepper(ULN2003).init(.{
        .in1_pin = in1.digital_io(),
        .in2_pin = in2.digital_io(),
        .in3_pin = in3.digital_io(),
        .in4_pin = in4.digital_io(),
        .clock_device = ttd.clock_device(),
    });
    try stepper.begin(100, 1);
    for ([_]u3{ 0, 1, 2, 3, 0 }) |i| {
        try std.testing.expectEqual(i, stepper.step_index);
        try stepper.step(.forward);
    }
    for ([_]u3{ 1, 0, 3, 2, 1 }) |i| {
        try std.testing.expectEqual(i, stepper.step_index);
        try stepper.step(.backward);
    }
    try stepper.set_microstep(2);
    for ([_]u3{ 0, 1, 2, 3, 4, 5, 6, 7, 0 }) |i| {
        try std.testing.expectEqual(i, stepper.step_index);
        try stepper.step(.forward);
    }
    for ([_]u3{ 1, 0, 7, 6, 5, 4, 3, 2, 1 }) |i| {
        try std.testing.expectEqual(i, stepper.step_index);
        try stepper.step(.backward);
    }
}
