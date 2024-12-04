const std = @import("std");
const microzig = @import("microzig");
const drivers = microzig.drivers;
const lcd_driver = drivers.display.hd44780;
const lcd = drivers.display.HD44780;

const rp2040 = microzig.hal;
const i2c = rp2040.i2c;
const I2C_Device = rp2040.drivers.I2C_Device;
const gpio = rp2040.gpio;
const peripherals = microzig.chip.peripherals;
const timer = rp2040.time;

const i2c0 = i2c.instance.num(0);

const i2c_device = I2C_Device.init(i2c0, @enumFromInt(0x27));

pub fn delay_us(time_delay: u32) void {
    timer.sleep_us(time_delay);
}

pub fn main() !void {
    const scl_pin = gpio.num(5);
    const sda_pin = gpio.num(4);
    inline for (&.{ scl_pin, sda_pin }) |pin| {
        pin.set_slew_rate(.slow);
        pin.set_schmitt_trigger(.enabled);
        pin.set_function(.i2c);
    }

    try i2c0.apply(.{
        .clock_config = rp2040.clock_config,
    });

    const msg = "hello world - From Zig";
    var my_lcd = lcd(.{ .Datagram_Device = I2C_Device }).init(
        i2c_device,
        delay_us,
    );

    try my_lcd.init_device(.{});
    try my_lcd.write(msg);

    while (true) {
        try my_lcd.shift_display_right();
        timer.sleep_ms(350);
    }
}
