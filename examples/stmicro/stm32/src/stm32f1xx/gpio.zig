const std = @import("std");
const microzig = @import("microzig");

const stm32 = microzig.hal;
const rcc = stm32.rcc;
const gpio = stm32.gpio;
const time = stm32.time;

pub fn main() !void {

    // select RTC clock source based on your board's configuration
    try rcc.apply_clock(.{
        .HSEOSC = @enumFromInt(8_000_000),
        .RTCClkSource = .RCC_RTCCLKSOURCE_HSE_DIV128,
    });
    // Initialize RTC as time source (recommended only when microsecond resolution is not needed)
    time.init();
    rcc.enable_clock(.GPIOC);
    const led = gpio.Pin.from_port(.C, 13);

    led.set_output_mode(.general_purpose_push_pull, .max_50MHz);
    while (true) {
        time.sleep_ms(1);
        led.toggle();
    }
}
