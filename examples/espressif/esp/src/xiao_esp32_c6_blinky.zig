//! Blinks the user led of a Seeed Studio XIAO ESP32C6 and logs over the usb serial/jtag port,
//! which is the USB-C connector of the board, so no extra adapter is needed.

const std = @import("std");
const microzig = @import("microzig");
const board = microzig.board;
const hal = microzig.hal;
const usb_serial_jtag = hal.usb_serial_jtag;
const time = hal.time;

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{
    .logFn = usb_serial_jtag.logger.log,
});

comptime {
    _ = microzig.export_startup();
}

pub fn main() !void {
    board.init_led();

    // Power the rf switch and point it at the ceramic antenna on the module.
    board.antenna.apply(.internal);

    std.log.info("Hello from a {s}!", .{"XIAO ESP32C6"});

    var on = false;
    while (true) {
        on = !on;
        board.set_led(on);

        std.log.info("led {s}", .{if (on) "on" else "off"});
        time.sleep_ms(500);
    }
}
