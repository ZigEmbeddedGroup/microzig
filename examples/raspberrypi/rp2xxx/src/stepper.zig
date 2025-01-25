const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const time = rp2xxx.time;
const GPIO_Device = rp2xxx.drivers.GPIO_Device;
const ClockDevice = rp2xxx.drivers.ClockDevice;
const stepper_driver = microzig.drivers.stepper;
const A4988 = stepper_driver.Stepper(stepper_driver.A4988);

pub fn main() !void {
    const led = gpio.num(8);
    led.set_function(.sio);
    led.set_direction(.out);
    var cd = ClockDevice{};

    const dir_pin = gpio.num(14);
    dir_pin.set_function(.sio);
    var dp = GPIO_Device.init(dir_pin);

    const step_pin = gpio.num(15);
    step_pin.set_function(.sio);
    var sp = GPIO_Device.init(step_pin);

    const ms1_pin = gpio.num(1);
    const ms2_pin = gpio.num(2);
    const ms3_pin = gpio.num(3);
    ms1_pin.set_function(.sio);
    ms2_pin.set_function(.sio);
    ms3_pin.set_function(.sio);
    var ms1 = GPIO_Device.init(ms1_pin);
    var ms2 = GPIO_Device.init(ms2_pin);
    var ms3 = GPIO_Device.init(ms3_pin);

    var stepper = A4988.init(.{
        .dir_pin = dp.digital_io(),
        .step_pin = sp.digital_io(),
        .ms1_pin = ms1.digital_io(),
        .ms2_pin = ms2.digital_io(),
        .ms3_pin = ms3.digital_io(),
        .clock_device = cd.clock_device(),
    });

    try stepper.begin(300, 1);
    // Only needed if you set the enable pin
    // try stepper.enable();

    while (true) {
        const linear_profile = stepper_driver.Speed_Profile{ .linear_speed = .{ .accel = 2000, .decel = 2000 } };
        const constant_profile = stepper_driver.Speed_Profile.constant_speed;
        // Try both constant and linear acceleration profiles
        inline for (.{ constant_profile, linear_profile }) |profile| {
            stepper.set_speed_profile(
                profile,
            );
            // Try different microsteps
            inline for (.{ 2, 4, 8, 16 }) |ms| {
                _ = try stepper.set_microstep(ms);
                try stepper.rotate(360);
                time.sleep_ms(250);
                try stepper.rotate(-360);
                time.sleep_ms(250);
            }
            time.sleep_ms(1000);
        }
    }
}
