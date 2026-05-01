const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;

const pin_config = rp2xxx.pins.GlobalConfiguration{
    .GPIO25 = .{ .name = "led", .function = .PWM4_B },
};

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

pub fn main() !void {
    const pins = pin_config.apply();
    pins.led.slice().set_wrap(100);
    pins.led.slice().enable();

    while (true) {
        for (0..101) |level| {
            pins.led.set_level(@truncate(level));
            time.sleep_ms(10);
        }
        for (1..100) |level| {
            pins.led.set_level(@truncate(100 - level));
            time.sleep_ms(10);
        }
    }
}
