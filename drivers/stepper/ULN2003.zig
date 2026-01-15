//!
//! Generic driver for ULN2003 'dumb' stepper motor driver, typically used for unipolar stepper
//! motors such as the 28BYJ-48
//!
//! Datasheet:
//! * ULN2003: https://www.ti.com/lit/ds/symlink/uln2003a.pdf
//!

const std = @import("std");
const mdf = @import("../framework.zig");
const common = @import("common.zig");

pub const Stepper_Options = struct {
    in1_pin: mdf.base.Digital_IO,
    in2_pin: mdf.base.Digital_IO,
    in3_pin: mdf.base.Digital_IO,
    in4_pin: mdf.base.Digital_IO,
    clock_device: *mdf.base.Clock_Device,
    motor_steps: u16 = 512,
    max_rpm: f64 = 30,
};

const Direction = enum { forward, backward };

pub const ULN2003 = struct {
    const Self = @This();
    const STEP_MIN_US = 2;
    const STEP_TABLE_FULL = [_]u4{ 0b1000, 0b0100, 0b0010, 0b0001 };
    const STEP_TABLE_HALF = [_]u4{ 0b1000, 0b1100, 0b0100, 0b0110, 0b0010, 0b0011, 0b0001, 0b1001 };

    in: [4]mdf.base.Digital_IO,
    clock: *mdf.base.Clock_Device,
    rpm: f64 = 0,
    max_rpm: f64,
    step_table: []const u4 = STEP_TABLE_FULL[0..],
    microsteps: u2 = 1,

    // Movement state
    step_index: u4 = 0,
    // Steps remaining in current move
    steps_remaining: u32 = 0,
    // The length of the next pulse
    step_pulse: mdf.time.Duration = .from_us(0),
    last_action_end: mdf.time.Absolute = .from_us(0),
    next_action_deadline: mdf.time.Absolute = .from_us(0),
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
        if (rpm > self.max_rpm) return error.InvalidRPM;
        self.rpm = rpm;
    }

    pub fn set_microstep(self: *Self, microsteps: u2) !void {
        if (self.microsteps == microsteps) return;

        switch (microsteps) {
            1 => {
                self.step_table = STEP_TABLE_FULL[0..];
                self.step_index = self.step_index >> 1;
            },
            2 => {
                self.step_table = STEP_TABLE_HALF[0..];
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
        try self.move(common.calc_steps_for_rotation(self.motor_steps, self.microsteps, deg));
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
        self.next_action_deadline = self.last_action_end;
        self.steps_remaining = @abs(steps);

        self.step_pulse = common.get_step_pulse(self.motor_steps, self.microsteps, self.rpm);
        // If we have a deadline, we might have to shorten the pulse
        // NOTE: This might make the motor behave incorrectly, if it can't step that
        // fast.
        if (time.to_us() > self.steps_remaining * self.step_pulse.to_us()) {
            self.step_pulse = .from_us(@intFromFloat(@as(f64, @floatFromInt(time.to_us())) /
                @as(f64, @floatFromInt(self.steps_remaining))));
        }
    }

    /// Run the current step and calculate the next one
    fn run(self: *Self) !bool {
        if (self.steps_remaining == 0)
            return false;
        // Wait until for the next action interval, since the last action ended
        while (!self.next_action_deadline.is_reached_by(self.clock.get_time_since_boot())) {}
        // Execute step
        try self.step(self.direction);
        // Absolute time now
        const step_start = self.clock.get_time_since_boot();

        // Calculate the duration of the next step
        const pulse = self.step_pulse; // save value because calc_step_pulse() will overwrite it

        // We need to hold the pins for at least STEP_MIN_US
        self.clock.sleep_us(STEP_MIN_US);

        // Update timing reference
        self.last_action_end = self.clock.get_time_since_boot();

        // Update steps remaining
        self.steps_remaining -= 1;

        // Calculate the next interval, accounting for the time spent in this function
        const elapsed = self.last_action_end.diff(step_start);
        self.next_action_deadline = if (elapsed.less_than(pulse))
            self.last_action_end.add_duration(pulse.minus(elapsed))
        else
            self.last_action_end;
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
};

// Testing
const TestGPIO = mdf.base.Digital_IO.Test_Device;
const TestTime = mdf.base.Clock_Device.Test_Device;
const TestDevice = struct {
    in1: TestGPIO,
    in2: TestGPIO,
    in3: TestGPIO,
    in4: TestGPIO,
    clock: TestTime,
};
fn create_test_device() TestDevice {
    return .{
        .in1 = TestGPIO.init(.output, .high),
        .in2 = TestGPIO.init(.output, .high),
        .in3 = TestGPIO.init(.output, .high),
        .in4 = TestGPIO.init(.output, .high),
        .clock = TestTime.init(),
    };
}

test "begin" {
    var td = create_test_device();
    var stepper = ULN2003.init(.{
        .in1_pin = td.in1.digital_io(),
        .in2_pin = td.in2.digital_io(),
        .in3_pin = td.in3.digital_io(),
        .in4_pin = td.in4.digital_io(),
        .clock_device = td.clock.clock_device(),
    });
    try stepper.begin(20, 1);
    try std.testing.expectEqual(1, stepper.microsteps);
    try stepper.begin(20, 2);
    try std.testing.expectEqual(2, stepper.microsteps);
}

test "set microsteps/rpm" {
    var td = create_test_device();
    var stepper = ULN2003.init(.{
        .in1_pin = td.in1.digital_io(),
        .in2_pin = td.in2.digital_io(),
        .in3_pin = td.in3.digital_io(),
        .in4_pin = td.in4.digital_io(),
        .clock_device = td.clock.clock_device(),
        .max_rpm = 20,
    });
    try stepper.set_microstep(1);
    try stepper.set_microstep(2);
    try std.testing.expectError(error.InvalidMicrosteps, stepper.set_microstep(0));
    try std.testing.expectError(error.InvalidMicrosteps, stepper.set_microstep(3));
    try stepper.set_rpm(10);
    try stepper.set_rpm(20);
    try std.testing.expectError(error.InvalidRPM, stepper.set_rpm(30));
}

test "step" {
    var td = create_test_device();
    var stepper = ULN2003.init(.{
        .in1_pin = td.in1.digital_io(),
        .in2_pin = td.in2.digital_io(),
        .in3_pin = td.in3.digital_io(),
        .in4_pin = td.in4.digital_io(),
        .clock_device = td.clock.clock_device(),
    });
    try stepper.begin(20, 1);
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
