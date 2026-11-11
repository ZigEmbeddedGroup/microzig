const std = @import("std");
const microzig = @import("microzig");

pub const panic = microzig.panic;

const usart = microzig.hal.usart;
const usart1 = usart.usart1;
const dma = microzig.hal.dma;

pub const std_options = microzig.std_options(.{ .logFn = usart.log });

pub const microzig_options: microzig.Options = .{
    .interrupts = .{ .DMA1_Channel3 = on_done },
};

comptime {
    _ = microzig.export_startup();
}

const cpu = microzig.cpu;
const clocks = microzig.hal.clocks;

const ch = dma.dma1_ch3;

const src = [_]u32{
    0x01020304, 0x05060708, 0x090A0B0C, 0x0D0E0F10,
    0x11121314, 0x15161718, 0x191A1B1C, 0x1D1E1F20,
};
var dst: [src.len]u32 = @splat(0);

var done = false;

fn on_done() callconv(cpu.riscv_calling_convention) void {
    ch.clear_flags(.{ .transfer_complete = true });
    @atomicStore(bool, &done, true, .release);
}

pub fn main() !void {
    clocks.init();
    usart1.apply(.{
        .baud_rate = 115200,
        .tx_pin = .{ .gpio = .GPIOA, .number = 9 },
        .rx_pin = .{ .gpio = .GPIOA, .number = 10 },
    });
    usart1.init_logger();

    // Memory-to-memory copy, completion reported through the channel IRQ.
    ch.apply(dst[0..], src[0..], .{
        .priority = .very_high,
        .interrupts = .{ .transfer_complete = true },
    });
    ch.enable_interrupt();
    ch.start();

    while (!@atomicLoad(bool, &done, .acquire))
        cpu.wfi();

    if (!std.mem.eql(u32, &dst, &src))
        @panic("dma mem2mem mismatch");

    std.log.info("dma mem2mem ok", .{});
    while (true) {}
}
