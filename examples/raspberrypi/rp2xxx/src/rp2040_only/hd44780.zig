const std = @import("std");
const microzig = @import("microzig");
const drivers = microzig.drivers;
const lcd = drivers.display.HD44780;
const PCF8574 = drivers.IO_expander.PCF8574;
const State = drivers.base.Digital_IO.State;

const rp2040 = microzig.hal;
const i2c = rp2040.i2c;
const I2C_Device = rp2040.drivers.I2C_Device;
const gpio = rp2040.gpio;
const peripherals = microzig.chip.peripherals;
const timer = rp2040.time;

const i2c0 = i2c.instance.num(0);

const i2c_device = I2C_Device.init(i2c0, @enumFromInt(0x27), null);

pub fn delay_us(time_delay: u32) void {
    timer.sleep_us(time_delay);
}

const msg = "hello world - From Zig";

pub fn main() !void {
    const scl_pin = gpio.num(5);
    const sda_pin = gpio.num(4);
    inline for (&.{ scl_pin, sda_pin }) |pin| {
        pin.set_slew_rate(.slow);
        pin.set_schmitt_trigger_enabled(true);
        pin.set_function(.i2c);
    }

    i2c0.apply(.{
        .clock_config = rp2040.clock_config,
    });
    var expander = PCF8574(.{ .Datagram_Device = I2C_Device }).init(i2c_device);
    const pins_config = lcd(.{}).pins_struct{
        .high_pins = .{
            expander.digital_IO(4),
            expander.digital_IO(5),
            expander.digital_IO(6),
            expander.digital_IO(7),
        },
        .BK = expander.digital_IO(3),
        .RS = expander.digital_IO(0),
        .EN1 = expander.digital_IO(2),
    };
    var my_lcd = lcd(.{}).init(
        pins_config,
        delay_us,
    );

    try my_lcd.init_device(.{});
    try my_lcd.set_backlight(1);
    try my_lcd.write(msg);

    while (true) {
        try my_lcd.shift_display_left();
        timer.sleep_ms(300);
    }
}
