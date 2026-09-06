const microzig = @import("microzig");

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

const RCC = microzig.chip.peripherals.RCC;
const GPIOC = microzig.chip.peripherals.GPIOC;

const pin: u4 = 3;

fn delay(cycles: u32) void {
    for (0..cycles) |_| {
        asm volatile ("nop");
    }
}

pub fn main() !void {
    RCC.HB2PCENR.modify(.{ .IOPCEN = 1 });

    GPIOC.CFGLR.modify(.{ .MODE3 = 0b11, .CNF3 = 0b01 });

    while (true) {
        microzig.hal.gpio.write(GPIOC, pin, 1);
        delay(20_000);
        microzig.hal.gpio.write(GPIOC, pin, 0);
        delay(20_000);
    }
}
