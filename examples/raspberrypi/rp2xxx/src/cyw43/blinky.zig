const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const cyw43 = rp2xxx.cyw43;
const time = rp2xxx.time;

pub fn main() !void {
    try cyw43.init();

    while (true) {
        cyw43.gpio.put(.led, true);
        time.sleep_ms(250);
        cyw43.gpio.put(.led, false);
        time.sleep_ms(250);
    }
}
