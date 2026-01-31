const microzig = @import("microzig");
const hal = microzig.hal;

const pin_led_red = hal.GPIO.num(3, 12);

pub fn main() void {
    pin_led_red.init();
    pin_led_red.set_direction(.out);
    pin_led_red.put(1); // Turn off

    while (true) {
        pin_led_red.toggle();
        delay_cycles(96_000_000 / 80);
    }
}

fn delay_cycles(cycles: u32) void {
    for (0..cycles) |_| {
        asm volatile ("nop");
    }
}
