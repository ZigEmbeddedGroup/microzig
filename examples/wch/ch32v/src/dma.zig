const std = @import("std");
const microzig = @import("microzig");
const mdf = microzig.drivers;
const hal = microzig.hal;
const gpio = hal.gpio;
const dma = hal.dma;
const time = hal.time;

const usart = hal.usart.instance.USART2;
const usart_tx_pin = gpio.Pin.init(0, 2); // PA2

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = hal.usart.log,
};

// Reduced buffer size for testing - 4096 bytes takes ~350ms at 115200 baud
var rbuf = [_]u8{0x41} ** 32;
var wbuf: [32]u8 = undefined;

pub fn main() !void {
    // Board brings up clocks and time
    microzig.board.init();

    // Configure USART2 TX pin (PA2) for alternate function (disable GPIO)
    usart_tx_pin.configure_alternate_function(.push_pull, .max_50MHz);

    // Initialize USART2 at 115200 baud (uses default pins PA2/PA3)
    usart.apply(.{
        .baud_rate = 115200,
        .remap = .default,
    });

    hal.usart.init_logger(usart);
    std.log.info("Hello", .{});

    // USART2_TX uses DMA1 Channel 7
    const chan = dma.Channel.Ch7;

    const USART2 = microzig.chip.peripherals.USART2;

    // Create a peripheral target for USART2 TX data register
    const usart2_tx = dma.PeripheralTarget{ .addr = @intFromPtr(&USART2.DATAR) };

    while (true) {
        // Clear the target buffer
        @memset(&wbuf, 0);
        std.log.info("Starting DMA transfer of {} bytes", .{rbuf.len});
        const start = time.get_time_since_boot();

        // Enable USART DMA transmitter mode - required for peripheral to generate DMA requests
        USART2.CTLR3.modify(.{ .DMAT = 1 });

        // Automatically detects direction, increment, data size from types!
        chan.setup_transfer(
            usart2_tx, // destination (peripheral)
            &rbuf, // source (memory)
            .{ .priority = .High },
        );
        chan.wait_for_finish_blocking();

        // Disable USART DMA mode after transfer
        USART2.CTLR3.modify(.{ .DMAT = 0 });
        chan.stop();

        const comp = chan.is_complete();
        const cnt = chan.get_remaining_count();
        const end = time.get_time_since_boot();
        std.log.info("DMA took {} complete={} remaining={}", .{
            end.diff(start),
            comp,
            cnt,
        });
        std.log.info("DMA test buffer: {x}", .{wbuf[0..rbuf.len]});

        // Compare
        // Clear the target buffer
        @memset(&wbuf, 0);
        std.log.info("Starting CPU copy", .{});
        const startc = time.get_time_since_boot();
        @memcpy(&wbuf, &rbuf);
        const endc = time.get_time_since_boot();
        std.log.info("memcpy took {}", .{endc.diff(startc)});
        hal.time.sleep_ms(1000);
    }
}
