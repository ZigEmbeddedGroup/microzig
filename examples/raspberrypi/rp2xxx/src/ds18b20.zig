const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;

const DS18B20 = microzig.drivers.sensor.DS18B20;

const pin_config: rp2xxx.pins.GlobalConfiguration = .{
    .GPIO25 = .{
        .name = "led",
        .direction = .out,
    },
    .GPIO9 = .{
        .name = "ds18b20",
        .direction = .in,
        .pull = .up,
    },
};

const pins = pin_config.pins();

pub fn main() !void {
    pin_config.apply();

    var ds18b20_gpio = rp2xxx.drivers.GPIO_Device.init(pins.ds18b20);
    const clock_device = rp2xxx.drivers.clock_device();

    const ds18b20 = try DS18B20.init(ds18b20_gpio.digital_io(), clock_device);

    // set desired resolution
    try ds18b20.write_config(.{ .resolution = .SixteenthDegree12 });

    // read rom code of connected sensor (assuming only one sensor is connected)
    // the tom code can be used to address individual devices in a multi drop environment
    // const rom_code = try ds18b20.read_single_rom_code();

    while (true) {
        // trigger a new temperature conversion
        try ds18b20.initiate_temperature_conversion(.{});

        // wait for conversion to complete (depends on resolution)
        time.sleep_ms(750);

        // read temperature
        _ = try ds18b20.read_temperature(.{});
        pins.led.toggle();
    }
}
