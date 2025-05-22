const microzig = @import("microzig");
const nrf = microzig.hal;
const gpio = nrf.gpio;

pub const led_active_state = 0;
pub const button_active_state = 0;
pub const button_pull = .pullup;

pub const led1 = gpio.num(0, 23);
pub const led_r = led1;
pub const led2 = gpio.num(0, 22);
pub const led_g = led2;
pub const led3 = gpio.num(0, 24);
pub const led_b = led3;
pub const leds: []const gpio.Pin = &.{ led1, led2, led3 };

pub const buttons: []const gpio.Pin = &.{button1};
pub const button1 = gpio.num(1, 18); // Reset, has external pullup

// UART
// NOTE: Any GPIO can be mapped to any peripheral
pub const uart_rts = gpio.num(0, 9);
pub const uart_cts = gpio.num(0, 10);
pub const uart_rx = gpio.num(0, 4);
pub const uart_tx = gpio.num(0, 5);
pub const hwfc = true;

pub fn init() void {
    for (leds) |led| {
        led.set_direction(.out);
        // LEDs are active low so let's start with them off
        led.put(1);
    }

    for (buttons) |button|
        button.set_direction(.in);
}
