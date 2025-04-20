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
    max_rpm: f64 = 30,
};

const Direction = enum { forward, backward };

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
        max_rpm: f64,
        step_table: []const u4 = Driver.STEP_TABLE_FULL[0..],
        microsteps: u2 = 1,

        // Movement state
        step_index: u4 = 0,
        // Steps remaining in current move
        steps_remaining: u32 = 0,
        // Steps remaining in decel
        steps_to_brake: u32 = 0,
        // The length of the next pulse
        step_pulse: mdf.time.Duration = .from_us(0),
        last_action_end: mdf.time.Absolute = .from_us(0),
        next_action_interval: mdf.time.Duration = .from_us(0),
        direction: Direction = .forward,
        motor_steps: u16,

        pub fn init(opts: Stepper_Options) Self {
            return Self{
                .clock = opts.clock_device,
                .in = .{ opts.in1_pin, opts.in2_pin, opts.in3_pin, opts.in4_pin },
                .motor_steps = opts.motor_steps,
                .max_rpm = opts.max_rpm,
            };
        }

        pub fn begin(self: *Self, rpm: f64, microsteps: u2) !void {
            try self.set_rpm(rpm);
            _ = try self.set_microstep(microsteps);

            try self.enable();
        }

        /// Set control pins to output so that we can drive coils
        pub fn enable(self: *Self) !void {
            inline for (self.in) |pin| {
                try pin.set_direction(.output);
            }
        }

        /// Set pins in high-impedence mode to reduce power consumption. This will stop holding the
        /// stepper motor's position.
        pub fn disable(self: *Self) !void {
            inline for (self.in) |pin| {
                try pin.set_direction(.input);
            }
        }

        pub fn set_rpm(self: *Self, rpm: f64) !void {
            if (rpm > self.max_rpm) return error.TooFast;
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

        /// Synchronously run the specified number of steps
        pub fn move(self: *Self, steps: i32) !void {
            self.start_move(steps);
            while (try self.run()) {}
        }

        /// Synchronously rotate the specified number of degrees
        pub fn rotate(self: *Self, deg: i32) !void {
            const steps = self.calc_steps_for_rotation(deg);
            try self.move(steps);
        }

        /// Initialize a move, determining how many steps, how long for each pulse, and which
        /// direction to run.
        pub fn start_move(self: *Self, steps: i32) void {
            // Start the move with no timeout duration
            self.start_move_time(steps, .from_us(0));
        }

        /// Initialize a move, with a maximum duration. A duration of 0 means no deadline.
        pub fn start_move_time(self: *Self, steps: i32, time: mdf.time.Duration) void {
            // set up new move
            self.direction = if (steps >= 0) .forward else .backward;
            self.last_action_end = self.clock.get_time_since_boot();
            self.next_action_interval = .from_us(0);
            self.steps_remaining = @abs(steps);

            self.step_pulse = get_step_pulse(self.motor_steps, self.microsteps, self.rpm);
            // If we have a deadline, we might have to shorten the pulse
            // NOTE: This might make the motor behave incorrectly, if it can't step that
            // fast.
            if (@intFromEnum(time) > self.steps_remaining * @intFromEnum(self.step_pulse)) {
                self.step_pulse = .from_us(@intFromFloat(@as(f64, @floatFromInt(time.to_us())) /
                    @as(f64, @floatFromInt(self.steps_remaining))));
            }
        }

        /// Calculate the duration of a step pulse for a stepper with `steps` steps, `microsteps`
        /// microsteps, at `rpm` rpm.
        inline fn get_step_pulse(steps: i32, microsteps: u8, rpm: f64) mdf.time.Duration {
            return @enumFromInt(@as(u64, @intFromFloat(60.0 * 1000000 /
                @as(f64, @floatFromInt(steps)) /
                @as(f64, @floatFromInt(microsteps)) / rpm)));
        }

        /// Delay delay_us from start_us. This accounts for time spent elsewhere since start_us
        fn delay_micros(self: Self, delay_us: mdf.time.Duration, start_us: mdf.time.Absolute) void {
            // If `start_us` is zero, that means to wait the whole delay.
            if (@intFromEnum(start_us) == 0) {
                self.clock.sleep_us(@intFromEnum(delay_us));
                return;
            }
            const deadline: mdf.time.Deadline = .init_relative(start_us, delay_us);
            while (!deadline.is_reached_by(self.clock.get_time_since_boot())) {}
        }

        /// Run the current step and calculate the next one
        fn run(self: *Self) !bool {
            if (self.steps_remaining == 0)
                return false;
            // Wait until for the next action interval, since the last action ended
            self.delay_micros(self.next_action_interval, self.last_action_end);
            // Execute step
            try self.step(self.direction);
            // Absolute time now
            const step_start = self.clock.get_time_since_boot();

            // Calculate the duration of the next step
            const pulse = self.step_pulse; // save value because calc_step_pulse() will overwrite it

            // We need to hold the pins for at least STEP_MIN_US
            self.clock.sleep_us(Driver.STEP_MIN_US);

            // Update timing reference
            self.last_action_end = self.clock.get_time_since_boot();

            // Update steps remaining
            self.steps_remaining -= 1;

            // Calculate the next intervanl, accounting for the time spent in this function
            // TODO: Make the interval a deadline?
            const elapsed = self.last_action_end.diff(step_start);
            self.next_action_interval = if (elapsed.less_than(pulse)) pulse.minus(elapsed) else .from_us(1);
            return self.steps_remaining > 0;
        }

        /// Change outputs to the next step in the cycle
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

        pub fn stop(self: *Self) void {
            const rv = self.steps_remaining;
            self.steps_remaining = 0;
            return rv;
        }

        fn calc_steps_for_rotation(self: *Self, deg: i32) i32 {
            return @divTrunc(deg * self.motor_steps * self.microsteps, 360);
        }
    };
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
