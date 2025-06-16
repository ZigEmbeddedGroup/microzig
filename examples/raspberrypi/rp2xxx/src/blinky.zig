const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;

pub const microzig_options: microzig.Options = .{
    .cpu = .{
        .ram_vector_table = true,
    },
};

const pin_config = rp2xxx.pins.GlobalConfiguration{
    .GPIO0 = .{
        .name = "led",
        .direction = .out,
    },
};

const pins = pin_config.pins();

pub fn main() !void {
    pin_config.apply();

    while (true) {
        pins.led.toggle();
        time.sleep_ms(250);
    }
}
