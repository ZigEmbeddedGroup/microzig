const microzig = @import("microzig");

pub const compatibility = @import("hal/compatibility.zig");
pub const gpio = @import("hal/gpio.zig");
pub const i2c = @import("hal/i2c.zig");
pub const time = @import("hal/time.zig");
pub const uart = @import("hal/uart.zig");
pub const drivers = @import("hal/drivers.zig");
// TODO: adc, timers, pwm, rng, rtc, spi, interrupts, i2c, wdt, wifi, nfc, bt, zigbee

pub fn init() void {
    time.init();
}

test "hal tests" {
    _ = gpio;
    _ = i2c;
    _ = time;
    _ = uart;

    _ = drivers;
}
