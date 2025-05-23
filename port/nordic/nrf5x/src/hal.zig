const microzig = @import("microzig");

pub const compatibility = @import("hal/compatibility.zig");
pub const gpio = @import("hal/gpio.zig");
pub const time = @import("hal/time.zig");
pub const uart = @import("hal/uart.zig");
// TODO: adc, timers, pwm, rng, rtc, spi, interrupts, i2c, wdt, wifi, nfc, bt, zigbee

pub fn init() void {
    time.init();
}

test "hal tests" {
    _ = gpio;
    _ = time;
    _ = uart;
}
