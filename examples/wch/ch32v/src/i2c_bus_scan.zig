const std = @import("std");
const microzig = @import("microzig");
const mdf = microzig.drivers;
const hal = microzig.hal;
const gpio = hal.gpio;
const i2c = hal.i2c;

const usart = hal.usart.instance.USART2;
const usart_tx_pin = gpio.Pin.init(0, 2); // PA2

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = hal.usart.log,
};

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

    // I2C1 is on PB6 (SCL) and PB7 (SDA)
    const scl_pin = hal.gpio.Pin.init(1, 6); // GPIOB pin 6
    const sda_pin = hal.gpio.Pin.init(1, 7); // GPIOB pin 7

    // Configure I2C pins for alternate function (open-drain required for I2C)
    scl_pin.configure_alternate_function(.open_drain, .max_50MHz);
    sda_pin.configure_alternate_function(.open_drain, .max_50MHz);

    // Initialize I2C at 100kHz (uses default pins PB6/PB7)
    const instance = i2c.instance.I2C1;
    instance.apply(.{});

    for (0..std.math.maxInt(u7)) |addr| {
        const a: i2c.Address = @enumFromInt(addr);

        var rx_data: [1]u8 = undefined;
        _ = instance.read_blocking(a, &rx_data, null) catch |e| {
            // Expected errors for non-present devices
            if (e != i2c.Error.NoAcknowledge and e != i2c.Error.Timeout) {
                std.log.warn("Unexpected error at 0x{X:0>2}: {}", .{ addr, e });
            }
            continue;
        };
        std.log.info("I2C device found at address {X}.", .{addr});
    }

    // Infinite loop
    while (true) {
        hal.time.sleep_ms(1000);
    }
}
