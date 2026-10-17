//! Blinks the LED once per second, timed with `hal.time` (Timer0).

const microzig = @import("microzig");
const hal = microzig.hal;

pub const panic = microzig.panic;
pub const std_options = microzig.std_options(.{});

pub const microzig_options: microzig.Options = .{
    .interrupts = .{ .TIMER0_OVF = hal.time.timer0_overflow },
};

comptime {
    _ = microzig.export_startup();
}

const led = hal.gpio.pin(.b, 5);

pub fn main() void {
    hal.time.init();
    microzig.interrupt.enable_interrupts();

    led.set_direction(.output);
    while (true) {
        led.toggle();
        hal.time.sleep_ms(500);
    }
}
