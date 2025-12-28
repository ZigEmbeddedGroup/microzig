const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;

// You have to export the microzig cpu startup logic
comptime {
    microzig.cpu.export_startup_logic();
}

// Our no-op is needed otherwise we get missing posix compile errors -- A separate issue.
pub const std_options: std.Options = .{
    .logFn = microzig.options.logFn,
};

const pin_config: rp2xxx.pins.GlobalConfiguration = .{
    .GPIO25 = .{
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
