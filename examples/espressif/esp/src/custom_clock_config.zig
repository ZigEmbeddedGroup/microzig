const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const clocks = hal.clocks;
const uart = hal.uart;

// Clock config with a cpu speed of 20mhz.
const clock_config: clocks.Config = .init_comptime(20_000_000);

// Have to override init() so we can apply our own custom pre-main startup procedure.
pub fn init() void {
    // Use the recommended init sequence with a custom clock config.
    hal.init_sequence(clock_config);
}

pub fn main() !void {
    while (true) {
        uart.write(0, "Hello from zig!\n");
        hal.rom.delay_us(1_000_000);
    }
}
