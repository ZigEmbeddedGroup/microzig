const microzig = @import("microzig");
const nrf = microzig.hal;
const gpio = nrf.gpio;

pub const led = gpio.num(0, 15);
pub const uart_tx = gpio.num(0, 9);
pub const uart_rx = gpio.num(0, 10);

pub fn init() void {
    led.set_direction(.out);
    led.put(0);
}
