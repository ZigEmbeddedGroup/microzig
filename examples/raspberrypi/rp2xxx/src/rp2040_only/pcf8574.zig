const std = @import("std");
const microzig = @import("microzig");

const drivers = microzig.drivers;
const PCF8574 = drivers.IO_expander.PCF8574;
const State = drivers.base.Digital_IO.State;

const rp2040 = microzig.hal;
const i2c = rp2040.i2c;
const I2C_Device = rp2040.drivers.I2C_Device;
const gpio = rp2040.gpio;
const timer = rp2040.time;

const i2c0 = i2c.instance.num(0);

const i2c_device = I2C_Device.init(i2c0, null);

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
    var expander = PCF8574(.{ .I2C_Device = I2C_Device }).init(i2c_device, @enumFromInt(0x27));
    var led = expander.digital_IO(3);
    while (true) {
        try led.write(State.high);
        timer.sleep_ms(500);
        try led.write(State.low);
        timer.sleep_ms(500);
    }
}
