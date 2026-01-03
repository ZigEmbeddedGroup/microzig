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

var rbuf = [_]u8{0x41} ** 128;

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

    // USART2_TX uses DMA1 Channel 7
    const chan = dma.Channel.Ch7;

    const USART2 = microzig.chip.peripherals.USART2;

    // Create a peripheral target for USART2 TX data register
    const usart2_tx = dma.PeripheralTarget{ .addr = @intFromPtr(&USART2.DATAR) };

    while (true) {
        // Clear the target buffer
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

        const end = time.get_time_since_boot();
        std.log.info("DMA took {}", .{end.diff(start)});

        // Compare
        // Clear the target buffer
        std.log.info("Starting CPU transfer of {} bytes", .{rbuf.len});
        const startc = time.get_time_since_boot();
        try usart.write_blocking(&rbuf, .no_deadline);
        const endc = time.get_time_since_boot();
        std.log.info("memcpy took {}", .{endc.diff(startc)});
        hal.time.sleep_ms(1000);
    }
}
