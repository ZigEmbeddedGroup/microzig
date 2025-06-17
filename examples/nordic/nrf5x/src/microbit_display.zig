const std = @import("std");
const microzig = @import("microzig");
const nrf = microzig.hal;
const time = nrf.time;
const microbit = microzig.board;

pub fn main() !void {
    const col_1 = nrf.gpio.num(0, 4);
    const row_1 = nrf.gpio.num(0, 13);

    inline for (&.{ col_1, row_1 }) |pin| {
        pin.set_direction(.out);
    }

    while (true) {
        col_1.put(0);
        row_1.put(1);

        time.sleep_ms(1000);

        col_1.put(1);
        row_1.put(0);

        time.sleep_ms(1000);
    }
}
