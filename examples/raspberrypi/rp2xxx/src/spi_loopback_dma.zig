const std = @import("std");
const microzig = @import("microzig");
const common = @import("common.zig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const dma = rp2xxx.dma;

const BUF_LEN = 0x100;
const spi = rp2xxx.spi.instance.SPI0;

pub const std_options = microzig.std_options(.{
    .log_level = .debug,
    .logFn = common.log,
});

pub const panic = microzig.panic;

comptime {
    _ = microzig.export_startup();
}

pub fn main() !void {
    common.init_logger();

    var out_buf = std.mem.zeroes([BUF_LEN]u8);
    var in_buf: [BUF_LEN]u8 = undefined;
    for (0..8) |i| {
        for (in_buf[(8 * i)..(8 * (i + 1))], "hey you!") |*dst, c|
            dst.* = c;
    }

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
        time.sleep_ms(1000);
    }
}
