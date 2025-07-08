const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;

const rpxxxx = microzig.hal;
const gpio = rpxxxx.gpio;
const clocks = rpxxxx.clocks;
const rptime = rpxxxx.time;

const led = gpio.num(25);
const uart0 = rpxxxx.uart.instance.num(0);
const baud_rate = 9600;
const uart0_tx_pin = gpio.num(0);
const uart0_rx_pin = gpio.num(1);

pub fn main() !void {
    init();

    var data: [4]u8 = undefined;
    while (true) {
        uart0.read_blocking(data[0..3], null) catch {
            led.toggle();
            uart0.clear_errors();
            continue;
        };

        const n = received(&data);
        uart0.write_blocking(data[0..n], null) catch {
            led.toggle();
            uart0.clear_errors();
        };

        toggle(n);

        data = .{ 0, 0, 0, 0 };
    }
}

fn toggle(n: usize) void {
    for (0..n * 2) |_| {
        led.toggle();
        rptime.sleep_ms(250);
    }
}

fn received(data: []u8) u4 {
    var i: u4 = 0;
    for (data[0..]) |x| {
        if (x == 0) {
            return i;
        }
        i += 1;
    }
    return 0;
}

fn init() void {
    led.set_function(.sio);
    led.set_direction(.out);

    uart0_tx_pin.set_function(.uart);
    uart0_rx_pin.set_function(.uart);

    uart0.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rpxxxx.clock_config,
    });
}
