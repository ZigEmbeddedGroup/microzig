//!
//! Generic driver for various stepper motor drivers
//!
//! Datasheet:
//! * A4988: https://www.allegromicro.com/~/media/Files/Datasheets/A4988-Datasheet.ashx
//! * DRV8825: https://www.ti.com/lit/ds/symlink/drv8825.pdf
//!

const std = @import("std");
const mdf = @import("../framework.zig");

pub const Stepper_Options = struct {
    ms1_pin: ?mdf.base.Digital_IO = undefined,
    ms2_pin: ?mdf.base.Digital_IO = undefined,
    ms3_pin: ?mdf.base.Digital_IO = undefined,
    dir_pin: mdf.base.Digital_IO,
    step_pin: mdf.base.Digital_IO,
    enable_pin: ?mdf.base.Digital_IO = undefined,
    clock_device: mdf.base.Clock_Device,
    motor_steps: u16 = 200,
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

pub const A4988 = struct {
    const MAX_MICROSTEP = 16;
    const STEP_HIGH_MIN = 1;
    const STEP_LOW_MIN = 1;
    const WAKEUP_TIME = 1000;
    const MS_TABLE = [_]u3{ 0b000, 0b001, 0b010, 0b011, 0b111 };
};

pub const DRV8825 = struct {
    const MAX_MICROSTEP = 32;
    const STEP_HIGH_MIN = 2; // Actually 1.9us
    const STEP_LOW_MIN = 2; // Actually 1.9us
    const WAKEUP_TIME = 1700;
    const MS_TABLE = [_]u3{ 0b000, 0b001, 0b010, 0b011, 0b100, 0b111 };
};

pub fn Stepper(comptime Driver: type) type {
    return struct {
        const Self = @This();
        driver: Driver = .{},

        microsteps: u8 = 1,
        ms1_pin: ?mdf.base.Digital_IO,
        ms2_pin: ?mdf.base.Digital_IO,
        ms3_pin: ?mdf.base.Digital_IO,
        dir_pin: mdf.base.Digital_IO,
        step_pin: mdf.base.Digital_IO,
        enable_pin: ?mdf.base.Digital_IO,
        enable_active_state: mdf.base.Digital_IO.State = .low,
        clock: mdf.base.Clock_Device,
        rpm: f64 = 0,

        // Movement state
        profile: Speed_Profile = .constant_speed,
        // Steps remaining in accel
        steps_to_cruise: u32 = 0,
        // Steps remaining in current move
        steps_remaining: u32 = 0,
        // Steps remaining in decel
        steps_to_brake: u32 = 0,
        step_pulse: mdf.time.Duration = .from_us(0),
        cruise_step_pulse: mdf.time.Duration = .from_us(0),
        remainder: mdf.time.Duration = .from_us(0),
        last_action_end: mdf.time.Absolute = .from_us(0),
        next_action_time: mdf.time.Absolute = .from_us(0),
        step_count: u32 = 0,
        dir_state: mdf.base.Digital_IO.State = .low,
        motor_steps: u16,

        pub fn init(opts: Stepper_Options) Self {
            return Self{
                .clock = opts.clock_device,
                .ms1_pin = opts.ms1_pin,
                .ms2_pin = opts.ms2_pin,
                .ms3_pin = opts.ms3_pin,
                .dir_pin = opts.dir_pin,
                .step_pin = opts.step_pin,
                .enable_pin = opts.enable_pin,
                .motor_steps = opts.motor_steps,
            };
        }

        pub fn begin(self: *Self, rpm: f64, microstep: u8) !void {
            try self.dir_pin.set_direction(.output);
            try self.dir_pin.write(.high);
            try self.step_pin.set_direction(.output);
            try self.step_pin.write(.low);

            // If MS pins are set, set them to outputs
            inline for (.{ self.ms1_pin, self.ms2_pin, self.ms3_pin }) |maybe_pin| {
                if (maybe_pin) |pin| {
                    try pin.set_direction(.output);
                }
            }

            if (self.enable_pin) |pin| {
                try pin.set_direction(.output);
                try self.disable();
            }

            self.rpm = rpm;
            // We need to set the microstep to match match what the user says, even
            // if the ms pins aren't connected.
            _ = self.init_microstep(microstep);
            // But also, if they are connected, we have to set them.
            _ = self.set_microstep(microstep) catch {};

            try self.enable();
        }

        pub fn enable(self: *Self) !void {
            if (self.enable_pin) |pin| {
                try pin.write(self.enable_active_state);
                // We only need to wait if we are using the enable pin to
                // enter/leave nSLEEP. If we are instead setting nEN, we can
                // skip this.
                if (self.enable_active_state == .high)
                    self.clock.sleep_us(Driver.WAKEUP_TIME);
            }
        }

        pub fn disable(self: *Self) !void {
            if (self.enable_pin) |pin| {
                try pin.write(if (self.enable_active_state == .high) .low else .high);
            }
        }

        pub fn set_rpm(self: Self, rpm: f64) void {
            self.rpm = rpm;
        }

        pub fn init_microstep(self: *Self, microsteps: u8) u8 {
            const unclamped = @as(u8, 1) << (@as(u3, @intCast(@bitSizeOf(u8) - 1 - @clz(microsteps))));
            // Set to nearest power of two, under MAX_MICROSTEP
            self.microsteps = @min(unclamped, Driver.MAX_MICROSTEP);
            return self.microsteps;
        }

        pub fn set_microstep(self: *Self, microsteps: u8) !u8 {
            // If any MS pins are not defined, return an error and don't change anything
            for ([_]?mdf.base.Digital_IO{ self.ms1_pin, self.ms2_pin, self.ms3_pin }) |maybe_pin| {
                if (maybe_pin) |_| {} else {
                    return MSPinsError;
                }
            }

            const new_microsteps = self.init_microstep(microsteps);
            // Set GPIOs according to values in table
            // -- 1, 2, 4, 8, 16
            // Get index of table for microsteps
            const i = @as(u3, @intCast(std.math.log2(new_microsteps)));
            const mask = Driver.MS_TABLE[i];
            try self.ms1_pin.?.write(@enumFromInt(@intFromBool((mask & 1) != 0)));
            try self.ms2_pin.?.write(@enumFromInt(@intFromBool((mask & 2) != 0)));
            try self.ms3_pin.?.write(@enumFromInt(@intFromBool((mask & 4) != 0)));

            return self.microsteps;
        }

        pub fn set_speed_profile(self: *Self, profile: Speed_Profile) void {
            self.profile = profile;
        }

        pub fn move(self: *Self, steps: i32) !void {
            // std.log.info("Running {} steps", .{steps}); // DELETEME
            self.start_move(steps);
            while (try self.next_action()) {}
        }

        pub fn rotate(self: *Self, deg: i32) !void {
            try self.move(self.calc_steps_for_rotation(deg));
        }

        pub fn start_move(self: *Self, steps: i32) void {
            self.start_move_time(steps, .from_us(0));
        }

        pub fn start_move_time(self: *Self, steps: i32, time: mdf.time.Duration) void {
            // set up new move
            self.dir_state = if (steps >= 0) .high else .low;
            self.last_action_end = self.clock.get_time_since_boot();
            self.next_action_time = self.last_action_end;
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
                    self.step_pulse = self.cruise_step_pulse;
                    if (@intFromEnum(time) > self.steps_remaining * @intFromEnum(self.step_pulse)) {
                        self.step_pulse = .from_us(@intFromFloat(@as(f64, @floatFromInt(time.to_us())) /
                            @as(f64, @floatFromInt(self.steps_remaining))));
                    }
                },
            }
        }

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

        fn delay_micros(self: Self, delay_us: mdf.time.Duration, start_us: mdf.time.Absolute) void {
            if (@intFromEnum(start_us) == 0) {
                self.clock.sleep_us(@intFromEnum(delay_us));
                return;
            }
            const deadline: mdf.time.Deadline = .init_relative(start_us, delay_us);
            while (!deadline.is_reached_by(self.clock.get_time_since_boot())) {}
        }

        /// Perform the next step, waiting until the next_action_time has been reached
        pub fn next_action(self: *Self) !bool {
            if (self.steps_remaining == 0) return false;

            // Wait until we reach the deadline
            while (!self.next_action_time.is_reached_by(self.clock.get_time_since_boot())) {}

            //  DIR pin is sampled on rising STEP edge, so it is set first
            try self.dir_pin.write(self.dir_state);
            try self.step_pin.write(.high);

            // Track when we started the step
            const start = self.clock.get_time_since_boot();
            const pulse = self.step_pulse; // save value because calcStepPulse() will overwrite it
            self.calc_step_pulse();

            // We should pull HIGH for at least 1-2us (step_high_min)
            self.clock.sleep_us(Driver.STEP_HIGH_MIN);
            try self.step_pin.write(.low);

            // Update timing reference
            self.last_action_end = self.clock.get_time_since_boot();
            const elapsed = self.last_action_end.diff(start);

            // Calculate the next interval, accounting for the time spent in this function
            self.next_action_time = if (elapsed.less_than(pulse))
                self.last_action_end.add_duration(pulse.minus(elapsed))
            else
                self.last_action_end;

            return self.steps_remaining > 0;
        }

        pub fn get_current_state(self: Self) State {
            if (self.steps_remaining <= 0)
                return .stopped;

            if (self.steps_remaining <= self.steps_to_brake)
                return .decelerating
            else if (self.step_count <= self.steps_to_cruise)
                return .accelerating
            else
                return .cruising;
        }

        // Configure what value to write to the enable pin to enable the
        // driver. This is LOW when this pin is hooked up to nENABLE, but HIGH
        // when hooked up to nSLEEP.
        pub fn set_enable_active_state(self: *Self, state: mdf.base.Digital_IO.State) void {
            self.enable_active_state = state;
        }

        pub fn start_brake(self: *Self) void {
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

        pub fn get_steps_completed(self: Self) u32 {
            return self.step_count;
        }

        pub fn get_steps_remaining(self: Self) u32 {
            return self.steps_remaining;
        }

        pub fn get_direction(self: Self) i2 {
            return switch (self.dir_state) {
                .low => 1,
                .high => -1,
            };
        }

        fn calc_steps_for_rotation(self: Self, deg: i32) i32 {
            return @divTrunc(deg * self.motor_steps * self.microsteps, 360);
        }
    };
}

test {
    const TestGPIO = mdf.base.Digital_IO.Test_Device;
    const TestTime = mdf.base.Clock_Device.Test_Device;
    var dp = TestGPIO.init(.output, .high);
    var sp = TestGPIO.init(.output, .high);
    var ttd = TestTime.init();
    _ = Stepper(A4988).init(.{
        .dir_pin = dp.digital_io(),
        .step_pin = sp.digital_io(),
        .clock_device = ttd.clock_device(),
    });
    _ = Stepper(DRV8825).init(.{
        .dir_pin = dp.digital_io(),
        .step_pin = sp.digital_io(),
        .clock_device = ttd.clock_device(),
    });
}

test "begin" {
    const TestGPIO = mdf.base.Digital_IO.Test_Device;
    const TestTime = mdf.base.Clock_Device.Test_Device;
    var dp = TestGPIO.init(.output, .high);
    var sp = TestGPIO.init(.output, .high);
    var ttd = TestTime.init();
    var stepper = Stepper(A4988).init(.{
        .dir_pin = dp.digital_io(),
        .step_pin = sp.digital_io(),
        .clock_device = ttd.clock_device(),
    });
    try stepper.begin(100, 1);
    try std.testing.expect(stepper.microsteps == 1);
    try stepper.begin(100, 2);
    try std.testing.expect(stepper.microsteps == 2);
}

test "A4988: set microstep with ms pins set" {
    const TestGPIO = mdf.base.Digital_IO.Test_Device;
    const TestTime = mdf.base.Clock_Device.Test_Device;
    var dp = TestGPIO.init(.output, .high);
    var sp = TestGPIO.init(.output, .high);
    var ms1 = TestGPIO.init(.output, .high);
    var ms2 = TestGPIO.init(.output, .high);
    var ms3 = TestGPIO.init(.output, .high);
    var ttd = TestTime.init();
    var stepper = Stepper(A4988).init(.{
        .dir_pin = dp.digital_io(),
        .step_pin = sp.digital_io(),
        .ms1_pin = ms1.digital_io(),
        .ms2_pin = ms2.digital_io(),
        .ms3_pin = ms3.digital_io(),
        .clock_device = ttd.clock_device(),
    });
    const tcs = .{
        // arg vs. clamped result vs. values of MS{3,2,1}
        .{ 1, 1, .{ .low, .low, .low } },
        .{ 2, 2, .{ .low, .low, .high } },
        .{ 3, 2, .{ .low, .low, .high } },
        .{ 4, 4, .{ .low, .high, .low } },
        .{ 7, 4, .{ .low, .high, .low } },
        .{ 8, 8, .{ .low, .high, .high } },
        .{ 16, 16, .{ .high, .high, .high } },
        .{ 32, 16, .{ .high, .high, .high } },
        .{ 62, 16, .{ .high, .high, .high } },
    };
    inline for (tcs) |tc| {
        const m = try stepper.set_microstep(tc[0]);
        try std.testing.expectEqual(tc[1], m);
        inline for (tc[2], .{ ms3, ms2, ms1 }) |expected, pin| {
            try std.testing.expectEqual(expected, pin.state);
        }
    }
}

test "A4988: set microstep without ms pins set" {
    const TestGPIO = mdf.base.Digital_IO.Test_Device;
    const TestTime = mdf.base.Clock_Device.Test_Device;
    var dp = TestGPIO.init(.output, .high);
    var sp = TestGPIO.init(.output, .high);
    var ttd = TestTime.init();
    var stepper = Stepper(A4988).init(.{
        .dir_pin = dp.digital_io(),
        .step_pin = sp.digital_io(),
        .clock_device = ttd.clock_device(),
    });
    const rv = stepper.set_microstep(1);
    try std.testing.expectError(MSPinsError, rv);
    const tcs = .{
        // arg vs. clamped result
        .{ 1, 1 },
        .{ 2, 2 },
        .{ 3, 2 },
        .{ 4, 4 },
        .{ 7, 4 },
        .{ 8, 8 },
        .{ 16, 16 },
        .{ 32, 16 },
        .{ 62, 16 },
    };
    inline for (tcs) |tc| {
        const m = stepper.init_microstep(tc[0]);
        try std.testing.expectEqual(tc[1], m);
    }
}

test "DRV8825: set microstep with ms pins set" {
    const TestGPIO = mdf.base.Digital_IO.Test_Device;
    const TestTime = mdf.base.Clock_Device.Test_Device;
    var dp = TestGPIO.init(.output, .high);
    var sp = TestGPIO.init(.output, .high);
    var ms1 = TestGPIO.init(.output, .high);
    var ms2 = TestGPIO.init(.output, .high);
    var ms3 = TestGPIO.init(.output, .high);
    var ttd = TestTime.init();
    var stepper = Stepper(DRV8825).init(.{
        .dir_pin = dp.digital_io(),
        .step_pin = sp.digital_io(),
        .ms1_pin = ms1.digital_io(),
        .ms2_pin = ms2.digital_io(),
        .ms3_pin = ms3.digital_io(),
        .clock_device = ttd.clock_device(),
    });
    const tcs = .{
        // arg vs. clamped result vs. values of MS{3,2,1}
        .{ 1, 1, .{ .low, .low, .low } },
        .{ 2, 2, .{ .low, .low, .high } },
        .{ 3, 2, .{ .low, .low, .high } },
        .{ 4, 4, .{ .low, .high, .low } },
        .{ 7, 4, .{ .low, .high, .low } },
        .{ 8, 8, .{ .low, .high, .high } },
        .{ 16, 16, .{ .high, .low, .low } },
        .{ 32, 32, .{ .high, .high, .high } },
        .{ 62, 32, .{ .high, .high, .high } },
    };
    inline for (tcs) |tc| {
        const m = try stepper.set_microstep(tc[0]);
        try std.testing.expectEqual(tc[1], m);
        inline for (tc[2], .{ ms3, ms2, ms1 }) |expected, pin| {
            try std.testing.expectEqual(expected, pin.state);
        }
    }
}

test "DRV8825: set microstep without ms pins set" {
    const TestGPIO = mdf.base.Digital_IO.Test_Device;
    const TestTime = mdf.base.Clock_Device.Test_Device;
    var dp = TestGPIO.init(.output, .high);
    var sp = TestGPIO.init(.output, .high);
    var ttd = TestTime.init();
    var stepper = Stepper(DRV8825).init(.{
        .dir_pin = dp.digital_io(),
        .step_pin = sp.digital_io(),
        .clock_device = ttd.clock_device(),
    });
    const rv = stepper.set_microstep(1);
    try std.testing.expectError(MSPinsError, rv);
    const tcs = .{
        // arg vs. clamped result
        .{ 1, 1 },
        .{ 2, 2 },
        .{ 3, 2 },
        .{ 4, 4 },
        .{ 7, 4 },
        .{ 8, 8 },
        .{ 16, 16 },
        .{ 32, 32 },
        .{ 62, 32 },
    };
    inline for (tcs) |tc| {
        const m = stepper.init_microstep(tc[0]);
        try std.testing.expectEqual(tc[1], m);
    }
}
