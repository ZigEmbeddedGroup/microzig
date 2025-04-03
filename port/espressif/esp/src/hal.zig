pub const gpio = @import("hal/gpio.zig");
pub const uart = @import("hal/uart.zig");
pub const compatibility = @import("hal/compatibility.zig");
pub const rom = @import("hal/rom.zig");
pub const clocks = @import("hal/clocks.zig");

pub fn init() void {
    const default_clock_frequency: u32 = switch (compatibility.chip) {
        .esp32_c3 => 80_000_000,
    };

    const config = clocks.Config.init(default_clock_frequency) catch unreachable; // guaranteed to not fail
    clocks.apply(config);

    // TODO: reset peripherals
}
