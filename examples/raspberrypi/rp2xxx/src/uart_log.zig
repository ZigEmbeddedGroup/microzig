const std = @import("std");
const microzig = @import("microzig");
const common = @import("common.zig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;

const led = gpio.num(25);

pub const std_options = microzig.std_options(.{
    .log_level = .debug,
    .logFn = common.log,
});

pub const panic = microzig.panic;

comptime {
    _ = microzig.export_startup();
}

pub fn main() !void {
    common.init_logger();

    led.set_function(.sio);
    led.set_direction(.out);
    led.put(1);

    var i: u32 = 0;
    while (true) : (i += 1) {
        led.put(1);
        std.log.info("what {}", .{i});
        time.sleep_ms(500);

        led.put(0);
        time.sleep_ms(500);
    }
}
