const std = @import("std");
const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;

fn delay(cycles: u32) void {
    var i: u32 = 0;
    while (i < cycles) : (i += 1) {
        asm volatile ("nop");
    }
}

pub fn main() !void {
    // Set P0.24 to output (Blue LED)
    peripherals.P0.DIRSET.modify(.{ .PIN24 = .Output });

    while (true) {
        // Turn LED on (active low)
        peripherals.P0.OUTCLR.modify(.{ .PIN24 = .High });
        delay(3000000);

        // Turn LED off
        peripherals.P0.OUTSET.modify(.{ .PIN24 = .High });
        delay(3000000);
    }
}
