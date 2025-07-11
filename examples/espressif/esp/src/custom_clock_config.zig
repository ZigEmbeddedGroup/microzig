const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const clocks = hal.clocks;
const usb_serial_jtag = hal.usb_serial_jtag;

pub const microzig_options: microzig.Options = .{
    .logFn = usb_serial_jtag.logger.log,
};

// Clock config with a cpu speed of 20mhz.
const clock_config: clocks.Config = .init_comptime(20_000_000);

// Have to override init() so we can apply our own custom pre-main startup procedure.
pub fn init() void {
    // Use the recommended init sequence with a custom clock config.
    hal.init_sequence(clock_config);
}

pub fn main() !void {
    var ticks: u32 = 0;
    while (true) {
        std.log.info("Hello from Zig! Tick number {}.", .{ticks});
        ticks += 1;

        hal.rom.delay_us(1_000_000);
    }
}
