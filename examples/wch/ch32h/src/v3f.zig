const microzig = @import("microzig");

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

const RCC = microzig.chip.peripherals.RCC;
const GPIOC = microzig.chip.peripherals.GPIOC;

const pin: u4 = 2;

fn delay(cycles: u32) void {
    for (0..cycles) |_| {
        asm volatile ("nop");
    }
}

pub fn main() !void {
    // Enable the GPIOA peripheral clock (IOPAEN = RCC_HB2PCENR bit 2).
    RCC.HB2PCENR.modify(.{ .IOPCEN = 1 });

    // PC2: general purpose open-drain output, 50 MHz.
    GPIOC.CFGLR.modify(.{ .MODE2 = 0b11, .CNF2 = 0b01 });

    while (true) {
        microzig.hal.gpio.write(GPIOC, pin, 1);
        delay(100_000);
        microzig.hal.gpio.write(GPIOC, pin, 0);
        delay(100_000);
    }
}
