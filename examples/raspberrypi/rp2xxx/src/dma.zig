const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const dma = rp2xxx.dma;

const uart = rp2xxx.uart.instance.num(0);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(0);

const hello: []const u8 = "Hello, world! (from DMA)";
var dst: [hello.len]u8 = undefined;

pub fn panic(message: []const u8, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    std.log.err("panic: {s}", .{message});
    @breakpoint();
    while (true) {}
}

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
};

pub fn main() !void {
    uart_tx_pin.set_function(.uart);

    uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rp2xxx.clock_config,
    });

    rp2xxx.uart.init_logger(uart);

    const channel = dma.claim_unused_channel().?;

    try channel.setup_transfer(dst[0..dst.len], hello[0..hello.len], .{
        .trigger = true,
        .enable = true,
    });
    channel.wait_for_finish_blocking();

    if (!std.mem.eql(u8, &dst, hello))
        @panic("dma failed");

    var value: u8 = 0x41;
    try channel.setup_transfer(&dst, &value, .{
        .trigger = true,
        .enable = true,
    });
    channel.wait_for_finish_blocking();

    if (!std.mem.allEqual(u8, &dst, 0x41))
        @panic("dma failed");

    while (true) {
        time.sleep_ms(1000);
    }
}
