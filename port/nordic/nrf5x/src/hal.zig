const microzig = @import("microzig");

pub const compatibility = @import("hal/compatibility.zig");
pub const gpio = @import("hal/gpio.zig");
pub const uart = @import("hal/uart.zig");
// TODO: adc, timers, pwm, rng, rtc, spi, interrupts, i2c, wdt, wifi, nfc, bt, zigbee

test "hal tests" {
    _ = gpio;
}
