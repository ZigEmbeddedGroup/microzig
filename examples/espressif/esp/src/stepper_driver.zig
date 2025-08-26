const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const gpio = hal.gpio;
const time = hal.time;

const GPIO_Device = hal.drivers.GPIO_Device;
const A4988 = microzig.drivers.stepper.A4988;

const usb_serial_jtag = hal.usb_serial_jtag;

pub const microzig_options = microzig.Options{
    .logFn = usb_serial_jtag.logger.log,
};

pub fn main() !void {
    // Setup all pins for the stepper driver
    var pins: struct {
        ms1: GPIO_Device,
        ms2: GPIO_Device,
        ms3: GPIO_Device,
        dir: GPIO_Device,
        step: GPIO_Device,
    } = undefined;
    inline for (std.meta.fields(@TypeOf(pins)), .{ 0, 1, 2, 20, 10 }) |field, num| {
        const pin = gpio.num(num);
        // Give the pin a sane default config
        pin.apply(.{});
        @field(pins, field.name) = GPIO_Device.init(pin);
    }

    var stepper = A4988.init(.{
        .ms1_pin = pins.ms1.digital_io(),
        .ms2_pin = pins.ms2.digital_io(),
        .ms3_pin = pins.ms3.digital_io(),
        .dir_pin = pins.dir.digital_io(),
        .step_pin = pins.step.digital_io(),
        .clock_device = hal.drivers.clock_device(),
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
