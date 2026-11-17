//! Sends a counter with the nRF24L01+ Emakefun RF-Nano v3.0
//! once per second

const std = @import("std");
const microzig = @import("microzig");

const nrf24l01 = microzig.drivers.wireless.nrf24l01;
const hal = microzig.hal;
const board = microzig.board;
const uart = hal.uart;

pub const panic = microzig.panic;
pub const std_options = microzig.std_options(.{});

comptime {
    _ = microzig.export_startup();
}

pub const microzig_options: microzig.Options = .{
    .interrupts = .{ .TIMER0_OVF = hal.time.timer0_overflow },
};

const radio_config: nrf24l01.Config = .{
    .address = .{ 0x66, 0xF0, 0xF0, 0xF0, 0xF0 },
    .payload_size = nrf24l01.max_payload_size,
};

const send_interval_ms = 1000;

var payload: [nrf24l01.max_payload_size]u8 = @splat(0);

pub fn main() void {
    hal.time.init();
    microzig.interrupt.enable_interrupts();

    board.uart_setup.apply(.{ .baud_rate = 115_200 });
    board.spi_setup.apply(.{ .baud_rate = 1_000_000 });

    run() catch |err| uart.write_blocking(switch (err) {
        error.Timeout => "[radio timeout]\r\n",
        else => "[radio error]\r\n",
    });
}

fn run() !void {
    var radio = nrf24l01.init(
        hal.drivers.SPI_DatagramDevice(hal.gpio.pin(.b, 0)).init(),
        hal.drivers.GPIO_Device(hal.gpio.pin(.d, 7)){},
        hal.drivers.ClockDevice{},
    );

    hal.time.sleep_ms(100);
    try radio.apply(radio_config);

    while (true) : (payload[0] +%= 1) {
        if (radio.send(&payload)) |_| {
            uart.write_blocking("sent ");
        } else |err| switch (err) {
            error.MaxRetries => uart.write_blocking("[no ACK] "),
            else => return err,
        }

        uart.write_blocking(&std.fmt.hex(payload[0]));
        uart.write_blocking("\r\n");
        hal.time.sleep_ms(send_interval_ms);
    }
}
