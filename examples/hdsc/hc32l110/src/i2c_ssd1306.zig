const std = @import("std");
const microzig = @import("microzig");

const hal = microzig.hal;
const time = microzig.time;
const i2c = hal.i2c;
const gpio = hal.gpio;
const clocks = hal.clocks;
const peripherals = microzig.chip.peripherals;

const drivers = microzig.drivers;
const display = drivers.display;
const ssd1306 = display.ssd1306;

const i2c0 = i2c.instance.num(0);

const sda_pin = gpio.num(0, 1);
const scl_pin = gpio.num(0, 2);

var framebuffer: drivers.display.ssd1306.Framebuffer = .init(.black);

pub fn main() !void {
    clocks.gate.enable(.Gpio);
    clocks.gate.enable(.I2c);

    inline for (&.{ scl_pin, sda_pin }) |pin| {
        pin.set_direction(.out);
        pin.set_pull(.disabled);
        pin.set_open_drain(.enabled);
        pin.set_drive_strength(.normal);
        pin.set_analog(.disabled);
    }
    // TODO:
    sda_pin.set_function(2);
    scl_pin.set_function(2);

    try i2c0.apply(.{ .baud = 32 });
    i2c0.enable();

    const i2c_device = i2c0.device(.new(0x3c));
    const disp = ssd1306.init(.i2c, i2c_device, null) catch |err|
        switch (err) {
            error.Timeout => while (true) {},
            else => return err,
        };

    var color: display.colors.BlackWhite = .white;

    while (true) {
        framebuffer.clear(color);
        color = if (color == .black) .white else .black;

        try disp.write_full_display(framebuffer.bit_stream());
        hal.time.sleep_ms(100);
    }
}
