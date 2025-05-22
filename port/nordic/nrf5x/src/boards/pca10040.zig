const microzig = @import("microzig");
const nrf = microzig.hal;
const gpio = nrf.gpio;

pub const led_active_state = 0;
pub const button_active_state = 0;
pub const button_pull = .pullup;

pub const leds: []const gpio.Pin = &.{ led1, led2, led3, led4 };
pub const led1 = gpio.num(0, 17);
pub const led2 = gpio.num(0, 18);
pub const led3 = gpio.num(0, 19);
pub const led4 = gpio.num(0, 20);

pub const buttons: []const gpio.Pin = &.{ button1, button2, button3, button4 };
pub const button1 = gpio.num(0, 13);
pub const button2 = gpio.num(0, 14);
pub const button3 = gpio.num(0, 15);
pub const button4 = gpio.num(0, 16);

// UART
pub const uart_rts = gpio.num(0, 5);
pub const uart_tx = gpio.num(0, 6);
pub const uart_cts = gpio.num(0, 7);
pub const uart_rx = gpio.num(0, 8);
pub const hwfc = true;

pub fn init() void {
    for (leds) |led|
        led.set_direction(.out);

    for (buttons) |button|
        button.set_direction(.in);
}
