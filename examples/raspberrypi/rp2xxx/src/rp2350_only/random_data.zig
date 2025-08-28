const std = @import("std");
const microzig = @import("microzig");

const hal = microzig.hal;

const rand = hal.rand;
const time = hal.time;
const uart = hal.uart;

const trng = rand.trng;

const uart0 = uart.instance.num(0);

const pin_config = hal.pins.GlobalConfiguration{
    .GPIO0 = .{ .name = "gpio0", .function = .UART0_TX },
};

const pins = pin_config.pins();

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = uart.log,
};

pub fn main() !void {
    pin_config.apply();

    uart0.apply(.{
        .clock_config = hal.clock_config,
    });

    uart.init_logger(uart0);

    std.log.info("Hello, World!", .{});

    // Return a random u32.

    const random_num = trng.random_blocking();
    std.log.info("Random number: 0x{x:08}", .{random_num});

    // Fill a buffer with random data.

    var random_bytes: [64]u8 = undefined;

    const start_time = time.get_time_since_boot();

    trng.random_bytes_blocking(&random_bytes);

    const end_time = time.get_time_since_boot();

    for (0..8) |i| {
        std.log.info("Random byte {d:2}: 0x{x:02} 0x{x:02} 0x{x:02} 0x{x:02} 0x{x:02} 0x{x:02} 0x{x:02} 0x{x:02}", .{ i, random_bytes[i * 8], random_bytes[i * 8 + 1], random_bytes[i * 8 + 2], random_bytes[i * 8 + 3], random_bytes[i * 8 + 4], random_bytes[i * 8 + 5], random_bytes[i * 8 + 6], random_bytes[i * 8 + 7] });
    }

    std.log.info("64 Random bytes took {} µs", .{end_time.to_us() - start_time.to_us()});

    while (true) {
        time.sleep_ms(1000);
    }
}
