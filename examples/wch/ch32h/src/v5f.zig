const microzig = @import("microzig");

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

const RCC = microzig.chip.peripherals.RCC;
const GPIOC = microzig.chip.peripherals.GPIOC;

const gpio = microzig.hal.gpio;
const clock = microzig.hal.clock;

const pin: u4 = 3;

fn delay(cycles: u32) void {
    for (0..cycles) |_| {
        asm volatile ("nop");
    }
}

pub fn main() !void {
    clock.enable_gpio(.C);

    GPIOC.CFGLR.modify(.{ .MODE3 = 0b11, .CNF3 = 0b01 });

    while (true) {
        gpio.write(.C, pin, 1);
        delay(20_000);
        gpio.write(.C, pin, 0);
        delay(20_000);
    }
}
