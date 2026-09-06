const microzig = @import("microzig");

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

const RCC = microzig.chip.peripherals.RCC;
const GPIOA = microzig.chip.peripherals.GPIOA;

const pin: u4 = 1;

fn delay(cycles: u32) void {
    for (0..cycles) |_| {
        asm volatile ("nop");
    }
}

pub fn main() !void {
    // Enable the GPIOA peripheral clock (IOPAEN = RCC_HB2PCENR bit 2).
    RCC.HB2PCENR.modify(.{ .IOPAEN = 1 });

    // PA1: general purpose push-pull output, 50 MHz (MODE=0b11, CNF=0b00).
    GPIOA.CFGLR.modify(.{ .MODE1 = 0b11, .CNF1 = 0b00 });

    while (true) {
        microzig.hal.gpio.write(GPIOA, pin, 1);
        delay(250_000);
        microzig.hal.gpio.write(GPIOA, pin, 0);
        delay(250_000);
    }
}
