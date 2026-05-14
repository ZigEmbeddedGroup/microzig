const gpio = @import("gpio.zig");

pub const Sense = gpio.Sense;

pub fn configure(pin: gpio.Pin, pullup: bool, sense: Sense) void {
    gpio.configure_input(pin, pullup, sense);
}

pub fn clear_flag(pin: gpio.Pin) void {
    gpio.clear_interrupt(pin);
}
