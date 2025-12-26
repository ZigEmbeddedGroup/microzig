const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;

// Even though microzig is imported and used in this blinky program, I still
// need to explicitly "use" it. If I don't, I get a linking _warning_ saying
// that I'm missing a symbol that the linkerscript (created by MicroZig)
// expects, and I get an empty program. If I "use" it explicitly, all is fine.
comptime {
    _ = microzig;
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
