const microzig = @import("microzig");

const esp = microzig.hal;
const gpio = esp.gpio;

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

pub fn main() !void {
    var input_pin = gpio.num(0);
    input_pin.apply(.{
        .input_enable = true,
    });

    var led_pin = gpio.num(8);
    led_pin.apply(.{
        .output_enable = true,
    });

    while (true) {
        led_pin.put(input_pin.read());
    }
}
