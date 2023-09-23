const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const TIMG0 = peripherals.TIMG0;
const RTC_CNTL = peripherals.RTC_CNTL;
const INTERRUPT_CORE0 = peripherals.INTERRUPT_CORE0;
const GPIO = peripherals.GPIO;
const IO_MUX = peripherals.IO_MUX;

const dogfood: u32 = 0x50D83AA1;
const super_dogfood: u32 = 0x8F1D312A;

const LED_R_PIN = 3; // GPIO
const LED_G_PIN = 4; // GPIO
const LED_B_PIN = 5; // GPIO

const led_pins = [_]u32{
    LED_R_PIN,
    LED_G_PIN,
    LED_B_PIN,
};

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

    GPIO.ENABLE.modify(.{
        .DATA = (1 << LED_R_PIN) |
            (1 << LED_G_PIN) |
            (1 << LED_B_PIN),
    });

    for (led_pins) |pin| {
        IO_MUX.GPIO[pin].modify(.{
            .MCU_OE = 1, // 1: output enabled
            .SLP_SEL = 0, // Set to 1 to put the pin in sleep mode. (R/W)
            .MCU_WPD = 0, // 0: internal pull-down disabled. (R/W)
            .MCU_WPU = 0, // 0: internal pull-up disabled. (R/W)
            .MCU_IE = 0, // 0: input disabled. (R/W)
            .FUN_WPD = 0, // 0: internal pull-down disabled. (R/W)
            .FUN_WPU = 0, // 0: internal pull-up disabled. (R/W)
            .FUN_IE = 0, // 0: input disabled. (R/W)
            .FUN_DRV = 3, // Select the drive strength of the pin. 0: ~5 mA; 1: ~ 10 mA; 2: ~ 20 mA; 3: ~40mA. (R/W)
            .MCU_SEL = 1, // 1: GPIO
            .FILTER_EN = 0, // 0: Filter disabled. (R/W)
        });

        GPIO.FUNC_OUT_SEL_CFG[pin].write(.{
            // If a value 128 is written to this field, bit n of GPIO_OUT_REG and GPIO_ENABLE_REG will be selected as the output value and output enable. (R/W)
            .OUT_SEL = 0x80,

            .INV_SEL = 0x00, // 0: Do not invert the output value
            .OEN_SEL = 0x01, // 1: Force the output enable signal to be sourced from bit n of GPIO_ENABLE_REG. (R/W)
            .OEN_INV_SEL = 0x00, // 0: Do not invert the output enable signal

            .padding = 0,
        });
    }

    microzig.hal.uart.write(0, "Hello from Zig!\r\n");

    while (true) {
        GPIO.OUT.modify(.{ .DATA_ORIG = (1 << LED_R_PIN) });
        microzig.hal.uart.write(0, "R");
        microzig.core.experimental.debug.busy_sleep(100_000);

        GPIO.OUT.modify(.{ .DATA_ORIG = (1 << LED_G_PIN) });
        microzig.hal.uart.write(0, "G");
        microzig.core.experimental.debug.busy_sleep(100_000);

        GPIO.OUT.modify(.{ .DATA_ORIG = (1 << LED_B_PIN) });
        microzig.hal.uart.write(0, "B");
        microzig.core.experimental.debug.busy_sleep(100_000);
    }
}
