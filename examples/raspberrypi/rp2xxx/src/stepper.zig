const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const time = rp2xxx.time;
const GPIO_Device = rp2xxx.drivers.GPIO_Device;
const ClockDevice = rp2xxx.drivers.ClockDevice;
const stepper_driver = microzig.drivers.stepper;
const A4988 = stepper_driver.Stepper(stepper_driver.A4988);

////
const uart = rp2xxx.uart.instance.num(0);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(0);

pub fn panic(message: []const u8, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    std.log.err("panic: {s}", .{message});
    @breakpoint();
    while (true) {}
}

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.logFn,
};
////
pub fn main() !void {
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);
    const led = gpio.num(8);
    led.set_function(.sio);
    led.set_direction(.out);
    var cd = ClockDevice{};

    // Setup all pins for the stepper driver
    var pins: struct {
        ms1: GPIO_Device,
        ms2: GPIO_Device,
        ms3: GPIO_Device,
        dir: GPIO_Device,
        step: GPIO_Device,
    } = undefined;
    inline for (std.meta.fields(@TypeOf(pins)), .{ 1, 2, 3, 14, 15 }) |field, num| {
        const pin = gpio.num(num);
        pin.set_function(.sio);
        @field(pins, field.name) = GPIO_Device.init(pin);
    }

    var stepper = A4988.init(.{
        // .ms1_pin = pins.ms1.digital_io(),
        // .ms2_pin = pins.ms2.digital_io(),
        // .ms3_pin = pins.ms3.digital_io(),
        .dir_pin = pins.dir.digital_io(),
        .step_pin = pins.step.digital_io(),
        .clock_device = cd.clock_device(),
    });

    try stepper.begin(200, 1);
    // Only needed if you set the enable pin
    // try stepper.enable();

    while (true) {
        // const linear_profile = stepper_driver.Speed_Profile{ .linear_speed = .{ .accel = 2000, .decel = 2000 } };
        // const constant_profile = stepper_driver.Speed_Profile.constant_speed;
        // Try both constant and linear acceleration profiles
        // inline for (.{ constant_profile, linear_profile }) |profile| {
        //     stepper.set_speed_profile(
        //         profile,
        //     );
        // Try different microsteps
        // inline for (.{ 2, 4, 8, 16 }) |ms| {
        //     _ = try stepper.set_microstep(ms);
        try stepper.rotate(360);
        time.sleep_ms(250);
        try stepper.rotate(-360);
        time.sleep_ms(250);
        // }
        // time.sleep_ms(1000);
        // }
    }
}
