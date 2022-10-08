const std = @import("std");
const microzig = @import("microzig");

const dogfood: u32 = 0x50D83AA1;
const super_dogfood: u32 = 0x8F1D312A;

pub fn main() !void {
    microzig.chip.registers.TIMG0.WDTWPROTECT.raw = dogfood;
    microzig.chip.registers.TIMG0.WDTCONFIG0.raw = 0;
    microzig.chip.registers.TIMG0.WDTWPROTECT.raw = 0;

    microzig.chip.registers.RTC_CNTL.WDTWPROTECT.raw = dogfood;
    microzig.chip.registers.RTC_CNTL.WDTCONFIG0.raw = 0;
    microzig.chip.registers.RTC_CNTL.WDTWPROTECT.raw = 0;

    microzig.chip.registers.RTC_CNTL.SWD_WPROTECT.raw = super_dogfood;
    microzig.chip.registers.RTC_CNTL.SWD_CONF.modify(.{ .SWD_DISABLE = 1 });
    microzig.chip.registers.RTC_CNTL.SWD_WPROTECT.raw = 0;

    microzig.chip.registers.INTERRUPT_CORE0.CPU_INT_ENABLE.* = 0;

    microzig.hal.gpio.init(LED_R_PIN, .{
        .direction = .output,
        .direct_io = true,
    });
    microzig.hal.gpio.init(LED_G_PIN, .{
        .direction = .output,
        .direct_io = true,
    });
    microzig.hal.gpio.init(LED_B_PIN, .{
        .direction = .output,
        .direct_io = true,
    });

    microzig.hal.uart.write(0, "Hello from Zig!\r\n");

    while (true) {
        microzig.chip.registers.GPIO.OUT.modify(.{ .DATA_ORIG = (1 << LED_R_PIN) });
        microzig.hal.uart.write(0, "R");
        microzig.debug.busySleep(1_000_000);
        microzig.chip.registers.GPIO.OUT.modify(.{ .DATA_ORIG = (1 << LED_G_PIN) });
        microzig.hal.uart.write(0, "G");
        microzig.debug.busySleep(1_000_000);
        microzig.chip.registers.GPIO.OUT.modify(.{ .DATA_ORIG = (1 << LED_B_PIN) });
        microzig.hal.uart.write(0, "B");
        microzig.debug.busySleep(1_000_000);
    }
}

const LED_R_PIN = 3; // GPIO
const LED_G_PIN = 16; // GPIO
const LED_B_PIN = 17; // GPIO
