const std = @import("std");
const microzig = @import("microzig");
const time = microzig.drivers.time;

const rp2040 = microzig.hal;
const uart = rp2040.uart;
const gpio = rp2040.gpio;
const clocks = rp2040.clocks;

const echo_uart = uart.instance.num(0);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(0);
const uart_rx_pin = gpio.num(1);

pub fn main() !void {
    inline for (&.{ uart_tx_pin, uart_rx_pin }) |pin| {
        pin.set_function(.uart);
    }

    echo_uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rp2040.clock_config,
        //.parity = .none,
        //.stop_bits = .one,
        //.flow_control = .none
    });

    var data: [1]u8 = .{0};
    while (true) {
        //read one byte, timeout disabled
        echo_uart.read_blocking(&data, null) catch {
            echo_uart.clear_errors(); //You need to clear UART errors before making a new transaction
            continue;
        };

        //tries to write one byte with 100ms timeout
        echo_uart.write_blocking(&data, time.Duration.from_ms(100)) catch {
            echo_uart.clear_errors();
        };
    }
}
