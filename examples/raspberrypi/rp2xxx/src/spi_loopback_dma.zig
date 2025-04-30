const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const dma = rp2xxx.dma;

const uart = rp2xxx.uart.instance.num(0);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(0);

const BUF_LEN = 0x100;
const spi = rp2xxx.spi.instance.SPI0;

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.logFn,
};

// Communicate with another RP2040 over spi
pub fn main() !void {
    uart_tx_pin.set_function(.uart);

    uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rp2xxx.clock_config,
    });

    rp2xxx.uart.init_logger(uart);

    var in_buf: [BUF_LEN]u8 = .{ 'h', 'e', 'y', ' ', 'y', 'o', 'u', '!' } ** (BUF_LEN / 8);
    var out_buf = std.mem.zeroes([BUF_LEN]u8);

    try spi.apply(.{ .clock_config = rp2xxx.clock_config });
    spi.set_loopback_mode(true);

    const tx_channel = dma.claim_unused_channel().?;
    const rx_channel = dma.claim_unused_channel().?;

    try tx_channel.setup_transfer(spi.tx(), &in_buf, .{ .enable = true });
    try rx_channel.setup_transfer(&out_buf, spi.rx(), .{ .enable = true });

    dma.multi_channel_trigger(&.{ tx_channel, rx_channel });

    rx_channel.wait_for_finish_blocking();

    if (!std.mem.eql(u8, &in_buf, &out_buf)) @panic("dma failed");

    std.log.info("dma finished", .{});

    while (true) {
        time.sleep_ms(1 * 1000);
    }
}
