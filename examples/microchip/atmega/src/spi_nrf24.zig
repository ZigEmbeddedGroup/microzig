//! Drives the nRF24L01+ of an Emakefun RF-Nano V3.0 with the generic driver
//! and reports over USART0 (115200 8N1). Each key press sends one payload and
//! prints the result; packets received in between are printed too. With no
//! other radio listening, sends end with "no ACK".
//!
//! The radio is on the SPI with CS on D8 (PB0) and CE on D7 (PD7), through the
//! HAL's driver adapters; the clock is `hal.time` (Timer0).

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

/// Same address as the Emakefun Peer2peer examples (0xF0F0F0F066). To get
/// an ACK, the other radio must also use channel 76 (the driver's default),
/// 1 Mbps, 2-byte CRC, auto-ack and a fixed 1-byte payload.
const address = [_]u8{ 0x66, 0xF0, 0xF0, 0xF0, 0xF0 };

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
        hal.drivers.clock_device(),
    );

    // The radio needs up to 100 ms after power-up before it can be set up.
    hal.time.sleep_ms(100);

    try radio.apply(.{ .address = address, .payload_size = 1 });
    try radio.start_listening();

    uart.write_blocking("Press a key to send it.\r\n");

    while (true) {
        var payload: [1]u8 = undefined;
        var received = false;
        try radio.receive(&payload, &received);
        if (received) {
            uart.write_blocking("received: ");
            uart.write_byte_blocking(payload[0]);
            uart.write_blocking("\r\n");
        }

        if (!uart.is_readable()) continue;
        uart.read_byte_blocking(&payload[0]) catch continue;

        try radio.stop_listening();
        if (radio.send(&payload)) |_| {
            uart.write_blocking("[sent]\r\n");
        } else |err| switch (err) {
            error.MaxRetries => uart.write_blocking("[no ACK]\r\n"),
            else => return err,
        }
        try radio.start_listening();
    }
}
