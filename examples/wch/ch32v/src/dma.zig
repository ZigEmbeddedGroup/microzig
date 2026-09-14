const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const board = microzig.board;
const dma = hal.dma;

const uart = board.uart_setup;

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{
    .log_level = .debug,
    .logFn = hal.usart.log,
});

comptime {
    _ = microzig.export_startup();
}

// Should be in flash .rodata
const rbuf: [1024]u32 = @splat(0x12345678);
// Should be in RAM .bss
var wbuf: [1024]u32 = @splat(0);

inline fn read_stk_cnt() u64 {
    const PFIC = microzig.chip.peripherals.PFIC;
    while (true) {
        const high1: u32 = PFIC.STK_CNTH.raw;
        const low: u32 = PFIC.STK_CNTL.raw;
        const high2: u32 = PFIC.STK_CNTH.raw;

        // If high didn't change, we have a consistent reading
        if (high1 == high2) {
            return (@as(u64, high1) << 32) | @as(u64, low);
        }
        // Otherwise low rolled over between reads, try again
    }
}

pub fn main() !void {
    // Board brings up clocks and time
    board.init();

    // Initialize UART for logging
    uart.apply(.{ .baud_rate = 115200 });
    hal.usart.init_logger(uart.instance);

    const chan = dma.Channel.Ch7;

    std.log.info("Testing with {}", .{@TypeOf(rbuf)});
    // Clear the target buffer
    @memset(&wbuf, 0);
    std.log.info("Starting DMA transfer of {} {}s", .{ rbuf.len, @TypeOf(rbuf[0]) });
    const start = read_stk_cnt();

    // Automatically detects direction, increment, data size from types!
    // This is about 6x faster than using the CPU to memcpy
    chan.setup_transfer(
        &wbuf,
        &rbuf, // source (memory)
        .{ .priority = .VeryHigh },
    );
    chan.wait_for_finish_blocking();

    const end = read_stk_cnt();
    std.log.info("DMA took {} ticks", .{end - start});

    // Sanity-check DMA result
    if (!std.mem.eql(@TypeOf(wbuf[0]), wbuf[0..], rbuf[0..])) {
        std.log.err("DMA copy mismatch! result does not match source", .{});
    }

    // Compare
    // Clear the target buffer
    @memset(&wbuf, 0);
    std.log.info("Starting CPU transfer of {} {}s", .{ rbuf.len, @TypeOf(rbuf[0]) });
    const startc2 = read_stk_cnt();
    @memcpy(&wbuf, &rbuf);
    const endc2 = read_stk_cnt();
    std.log.info("memcpy took {} ticks", .{endc2 - startc2});

    while (true) {
        hal.time.sleep_ms(10000);
    }
}
