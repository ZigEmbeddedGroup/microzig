const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const time = rp2xxx.time;
const GPIO_Device = rp2xxx.drivers.GPIO_Device;
const ClockDevice = rp2xxx.drivers.ClockDevice;
const stepper_driver = microzig.drivers.new_stepper;
const ULN2003 = stepper_driver.Stepper(stepper_driver.ULN2003);

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

    const led = gpio.num(25);
    led.set_function(.sio);
    led.set_direction(.out);
    var cd = ClockDevice{};

    // Setup all pins for the stepper driver
    var pins: struct {
        in1: GPIO_Device,
        in2: GPIO_Device,
        in3: GPIO_Device,
        in4: GPIO_Device,
    } = undefined;
    inline for (std.meta.fields(@TypeOf(pins)), .{ 17, 16, 14, 15 }) |field, num| {
        const pin = gpio.num(num);
        pin.set_function(.sio);
        @field(pins, field.name) = GPIO_Device.init(pin);
    }

    var stepper = ULN2003.init(.{
        .in1_pin = pins.in1.digital_io(),
        .in2_pin = pins.in2.digital_io(),
        .in3_pin = pins.in3.digital_io(),
        .in4_pin = pins.in4.digital_io(),
        .clock_device = cd.clock_device(),
    });

    try stepper.begin(60, 1);

    while (true) {
        // const linear_profile = stepper_driver.Speed_Profile{ .linear_speed = .{ .accel = 2000, .decel = 2000 } };
        // const constant_profile = stepper_driver.Speed_Profile.constant_speed;
        // Try both constant and linear acceleration profiles
        // inline for (.{ constant_profile, linear_profile }) |profile| {
        // stepper.set_speed_profile(
        //     profile,
        // );
        // Try different microsteps
        // inline for (.{ 1, 2 }) |ms| {
        // _ = try stepper.set_microstep(ms);
        // for (0..8) |_| {
        // std.log.info("Rotating", .{});
        try stepper.rotate(180);
        // try stepper.step(.forward);
        time.sleep_ms(250);
        try stepper.rotate(-180);
        time.sleep_ms(250);
        led.toggle();
        // }
        // }
        // time.sleep_ms(1000);
        time.sleep_ms(5);
    }
    // }
}
