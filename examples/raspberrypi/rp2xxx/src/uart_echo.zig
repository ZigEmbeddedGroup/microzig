const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;

const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const clocks = rp2xxx.clocks;

const led = gpio.num(25);
const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);
const uart_rx_pin = gpio.num(1);

pub fn main() !void {
    led.set_function(.sio);
    led.set_direction(.out);
    led.put(1);
    inline for (&.{ uart_tx_pin, uart_rx_pin }) |pin| {
        pin.set_function(.uart);
    }

    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });

    var data: [1]u8 = .{0};
    while (true) {
        // Read one byte, timeout disabled
        uart.read_blocking(&data, null) catch {
            // You need to clear UART errors before making a new transaction
            uart.clear_errors();
            continue;
        };

        //tries to write one byte with 100ms timeout
        uart.write_blocking(&data, time.Duration.from_ms(100)) catch {
            uart.clear_errors();
        };
        // Toggle the led every time we think we've received a character so we
        // know something is going on.
        led.toggle();
    }
}
