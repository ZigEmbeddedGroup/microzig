const microzig = @import("microzig");
const std = @import("std");

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

const RCC = microzig.chip.peripherals.RCC;
const PFIC = microzig.chip.peripherals.PFIC;
const GPIOC = microzig.chip.peripherals.GPIOC;

const pin: u4 = 2;

fn delay(cycles: u32) void {
    for (0..cycles) |_| {
        asm volatile ("nop");
    }
}

pub fn main() !void {
    RCC.HB2PCENR.modify(.{ .IOPCEN = 1 });

    GPIOC.CFGLR.modify(.{ .MODE2 = 0b11, .CNF2 = 0b01 });

    PFIC.WAKEIP1.raw = 0x10000 & ~@as(u32, 0x3FF);
    PFIC.SCTLR.raw |= (1 << 5);

    while (true) {
        microzig.hal.gpio.write(GPIOC, pin, 1);
        delay(10_000);
        microzig.hal.gpio.write(GPIOC, pin, 0);
        delay(10_000);
    }
}
