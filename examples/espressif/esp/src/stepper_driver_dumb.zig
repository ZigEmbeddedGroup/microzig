const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const gpio = hal.gpio;
const time = hal.time;

const GPIO_Device = hal.drivers.GPIO_Device;
const ClockDevice = hal.drivers.ClockDevice;
const ULN2003 = microzig.drivers.stepper.ULN2003;

const usb_serial_jtag = hal.usb_serial_jtag;

pub const microzig_options = microzig.Options{
    .logFn = usb_serial_jtag.logger.logFn,
};

pub fn main() !void {
    var cd = ClockDevice{};

    // Setup all pins for the stepper driver
    var pins: struct {
        in1: GPIO_Device,
        in2: GPIO_Device,
        in3: GPIO_Device,
        in4: GPIO_Device,
    } = undefined;
    inline for (std.meta.fields(@TypeOf(pins)), .{ 5, 6, 7, 8 }) |field, num| {
        const pin = gpio.num(num);
        // Give the pin a sane default config
        pin.apply(.{});
        @field(pins, field.name) = GPIO_Device.init(pin);
    }

    var stepper = ULN2003.init(.{
        .in1_pin = pins.in1.digital_io(),
        .in2_pin = pins.in2.digital_io(),
        .in3_pin = pins.in3.digital_io(),
        .in4_pin = pins.in4.digital_io(),
        .clock_device = cd.clock_device(),
    });

    try stepper.begin(20, 1);

    while (true) {
        // Try different microsteps
        inline for (.{ 1, 2 }) |ms| {
            _ = try stepper.set_microstep(ms);
            std.log.info("microsteps: {}", .{ms});
            try stepper.rotate(360);
            time.sleep_ms(250);
            try stepper.rotate(-360);
            time.sleep_ms(250);
        }
        time.sleep_ms(1000);
    }
}
