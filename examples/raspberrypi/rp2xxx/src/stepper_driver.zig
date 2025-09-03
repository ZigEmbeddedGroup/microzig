const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const time = rp2xxx.time;

const GPIO_Device = rp2xxx.drivers.GPIO_Device;
const A4988 = microzig.drivers.stepper.A4988;

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

pub fn panic(message: []const u8, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    std.log.err("panic: {s}", .{message});
    @breakpoint();
    while (true) {}
}

pub const microzig_options = microzig.Options{
    .logFn = rp2xxx.uart.log,
};

pub fn main() !void {
    // init uart logging
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    // Setup all pins for the stepper driver
    var pins: struct {
        ms1: GPIO_Device,
        ms2: GPIO_Device,
        ms3: GPIO_Device,
        dir: GPIO_Device,
        step: GPIO_Device,
    } = undefined;
    inline for (std.meta.fields(@TypeOf(pins)), .{ 2, 3, 4, 14, 15 }) |field, num| {
        const pin = gpio.num(num);
        pin.set_function(.sio);
        @field(pins, field.name) = GPIO_Device.init(pin);
    }

    var stepper = A4988.init(.{
        .ms1_pin = pins.ms1.digital_io(),
        .ms2_pin = pins.ms2.digital_io(),
        .ms3_pin = pins.ms3.digital_io(),
        .dir_pin = pins.dir.digital_io(),
        .step_pin = pins.step.digital_io(),
        .clock_device = rp2xxx.drivers.clock_device(),
    });

    try stepper.begin(100, 1);

    while (true) {
        const linear_profile = A4988.Speed_Profile{ .linear_speed = .{ .accel = 200, .decel = 200 } };
        const constant_profile = A4988.Speed_Profile.constant_speed;
        // Try both constant and linear acceleration profiles
        inline for (.{ constant_profile, linear_profile }) |profile| {
            stepper.set_speed_profile(
                profile,
            );
            std.log.info("profile: {s} ", .{@tagName(profile)});
            // Try different microsteps
            inline for (.{ 1, 2, 4, 8, 16 }) |ms| {
                _ = try stepper.set_microstep(ms);
                std.log.info("microsteps: {}", .{ms});
                try stepper.rotate(360);
                time.sleep_ms(250);
                try stepper.rotate(-360);
                time.sleep_ms(250);
            }
        }
    }
}
