const std = @import("std");
const microzig = @import("microzig");

pub const panic = microzig.panic;

const usart = microzig.hal.usart;
const usart1 = usart.usart1;
const dma = microzig.hal.dma;

pub const std_options = microzig.std_options(.{ .logFn = usart.log });

// IDLE line detection marks the end of a received burst.
pub const microzig_options: microzig.Options = .{
    .interrupts = .{ .USART1 = on_usart1_idle },
};

comptime {
    _ = microzig.export_startup();
}

const cpu = microzig.cpu;
const clocks = microzig.hal.clocks;

const rx_ch = dma.dma1_ch6;
const tx_ch = dma.dma1_ch7;

const rx_len = 64;
var rx_buf: [rx_len]u8 = undefined;
var last_pos: usize = 0;

var echo_buf: [rx_len]u8 = undefined;
var echo_len: usize = 0;
var echo_pending = false;

fn on_usart1_idle() callconv(cpu.riscv_calling_convention) void {
    // Reading DATAR also clears IDLE (WCH's own DMA+IDLE example does the
    // same). It may steal a byte in a rare race, which is acceptable here.
    // TODO: what if we don't want to lose a byte under any circumstances?
    usart1.clear_idle();

    const curr: usize = rx_len - @as(usize, rx_ch.remaining());
    var n: usize = 0;
    if (curr >= last_pos) {
        @memcpy(echo_buf[0 .. curr - last_pos], rx_buf[last_pos..curr]);
        n = curr - last_pos;
    } else {
        const first = rx_len - last_pos;
        @memcpy(echo_buf[0..first], rx_buf[last_pos..]);
        @memcpy(echo_buf[first .. first + curr], rx_buf[0..curr]);
        n = first + curr;
    }
    last_pos = curr;
    echo_len = n;
    @atomicStore(bool, &echo_pending, n != 0, .release);
}

pub fn main() !void {
    clocks.init();
    usart1.apply(.{
        .baud_rate = 115200,
        .tx_pin = .{ .gpio = .GPIOA, .number = 9 },
        .rx_pin = .{ .gpio = .GPIOA, .number = 10 },
        .tx_dma = true,
        .rx_dma = true,
    });
    usart1.init_logger();

    usart1.set_interrupts(.{ .idle = true });
    usart1.enable_interrupt();

    std.log.info("usart dma echo ready", .{});

    // Circular RX: DMA keeps filling rx_buf, IDLE tells us when a burst ended.
    rx_ch.apply(rx_buf[0..], usart1.dma_target(.rx), .{
        .circular = true,
        .priority = .very_high,
    });
    rx_ch.start();

    while (true) {
        while (!@atomicLoad(bool, &echo_pending, .acquire))
            cpu.wfi();
        @atomicStore(bool, &echo_pending, false, .release);

        const n = echo_len;
        tx_ch.apply(usart1.dma_target(.tx), echo_buf[0..n], .{ .priority = .very_high });
        tx_ch.start();
        tx_ch.wait_blocking() catch {};
    }
}
