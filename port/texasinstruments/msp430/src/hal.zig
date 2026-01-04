const microzig = @import("microzig");

pub const gpio = @import("hal/gpio.zig");
pub const watchdog = @import("hal/watchdog.zig");

test {
    _ = gpio;
    _ = watchdog;
}
