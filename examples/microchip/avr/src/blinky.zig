const std = @import("std");
const microzig = @import("microzig");

// LED is PB5
const port = microzig.chip.peripherals.PORTB;

pub fn main() void {
    port.DDRB |= (1 << 5);
    port.PORTB |= 0x00;

    while (true) {
        microzig.core.experimental.debug.busy_sleep(1_000);
        port.PINB |= (1 << 5);
    }
}
