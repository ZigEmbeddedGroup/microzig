// const std = @import("std");
const microzig = @import("microzig");
const mspm0 = microzig.hal;

pub const panic = microzig.panic;
pub const std_options = microzig.std_options(.{});
comptime {
    _ = microzig.export_startup();
}

pub fn main() void {
    mspm0.gpio.enable(.gpioa);

    const led = mspm0.gpio.num(.gpioa, 22);

    led.set_function(1);
    led.set_direction(.out);

    while (true) {
        led.toggle();

        for (0..2_000_000) |_|
            asm volatile ("nop");
    }
}
