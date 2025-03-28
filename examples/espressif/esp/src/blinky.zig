const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const gpio = microzig.hal.gpio;
const uart = microzig.hal.uart;
const TIMG0 = peripherals.TIMG0;
const RTC_CNTL = peripherals.RTC_CNTL;
const INTERRUPT_CORE0 = peripherals.INTERRUPT_CORE0;

const dogfood: u32 = 0x50D83AA1;
const super_dogfood: u32 = 0x8F1D312A;

pub fn main() !void {
    // Feed and disable watchdog 0
    TIMG0.WDTWPROTECT.raw = dogfood;
    TIMG0.WDTCONFIG0.raw = 0;
    TIMG0.WDTWPROTECT.raw = 0;

    // Feed and disable rtc watchdog
    RTC_CNTL.WDTWPROTECT.raw = dogfood;
    RTC_CNTL.WDTCONFIG0.raw = 0;
    RTC_CNTL.WDTWPROTECT.raw = 0;

    // Feed and disable rtc super watchdog
    RTC_CNTL.SWD_WPROTECT.raw = super_dogfood;
    RTC_CNTL.SWD_CONF.modify(.{ .SWD_DISABLE = 1 });
    RTC_CNTL.SWD_WPROTECT.raw = 0;

    // Disable all interrupts
    INTERRUPT_CORE0.CPU_INT_ENABLE.raw = 0;

    const pin_config = gpio.Pin.Config{
        .output_enable = true,
        .drive_strength = gpio.DriveStrength.@"40mA",
    };

    const led_r_pin = gpio.instance.GPIO3;
    const led_g_pin = gpio.instance.GPIO4;
    const led_b_pin = gpio.instance.GPIO5;

    led_r_pin.apply(pin_config);
    led_g_pin.apply(pin_config);
    led_b_pin.apply(pin_config);

    uart.write(0, "Hello from Zig!\r\n");

    while (true) {
        led_r_pin.write(gpio.Level.high);
        led_g_pin.write(gpio.Level.low);
        led_b_pin.write(gpio.Level.low);
        uart.write(0, "R");
        microzig.core.experimental.debug.busy_sleep(100_000);

        led_r_pin.write(gpio.Level.low);
        led_g_pin.write(gpio.Level.high);
        led_b_pin.write(gpio.Level.low);
        uart.write(0, "G");
        microzig.core.experimental.debug.busy_sleep(100_000);

        led_r_pin.write(gpio.Level.low);
        led_g_pin.write(gpio.Level.low);
        led_b_pin.write(gpio.Level.high);
        uart.write(0, "B");
        microzig.core.experimental.debug.busy_sleep(100_000);
    }
}
