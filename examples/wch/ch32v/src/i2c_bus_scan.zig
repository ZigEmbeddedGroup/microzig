const std = @import("std");
const microzig = @import("microzig");
const mdf = microzig.drivers;
const hal = microzig.hal;
const gpio = hal.gpio;
const i2c = hal.i2c;

const RCC = microzig.chip.peripherals.RCC;
const AFIO = microzig.chip.peripherals.AFIO;

const usart = hal.usart.instance.USART2;
const usart_tx_pin = gpio.Pin.init(0, 2); // PA2

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = hal.usart.log,
};

pub fn main() !void {
    // Board brings up clocks and time
    microzig.board.init();

    // Enable peripheral clocks for USART2 and GPIOA
    RCC.APB2PCENR.modify(.{
        .IOPAEN = 1, // Enable GPIOA clock
        .AFIOEN = 1, // Enable AFIO clock
    });
    RCC.APB1PCENR.modify(.{
        .USART2EN = 1, // Enable USART2 clock
    });

    // Ensure USART2 is NOT remapped (default PA2/PA3, not PD5/PD6)
    AFIO.PCFR1.modify(.{ .USART2_RM = 0 });

    // Configure PA2 as alternate function push-pull for USART2 TX
    usart_tx_pin.set_output_mode(.alternate_function_push_pull, .max_50MHz);

    // Initialize USART2 at 115200 baud
    usart.apply(.{ .baud_rate = 115200 });

    hal.usart.init_logger(usart);

    // I2C1 is on PB6 (SCL) and PB7 (SDA)
    const scl_pin = hal.gpio.Pin.init(1, 6); // GPIOB pin 6
    const sda_pin = hal.gpio.Pin.init(1, 7); // GPIOB pin 7

    // Enable peripheral clocks
    RCC.APB2PCENR.modify(.{
        .IOPBEN = 1, // Enable GPIOB clock (AFIOEN already enabled)
    });
    RCC.APB1PCENR.modify(.{
        .I2C1EN = 1, // Enable I2C1 clock
    });

    // Ensure I2C1 is NOT remapped (default PB6/PB7)
    AFIO.PCFR1.modify(.{ .I2C1_RM = 0 });

    // Configure GPIO pins for I2C (alternate function, open drain, 50MHz)
    scl_pin.set_output_mode(.alternate_function_open_drain, .max_50MHz);
    sda_pin.set_output_mode(.alternate_function_open_drain, .max_50MHz);

    // Initialize I2C at 100kHz
    const instance = i2c.instance.I2C1;
    instance.apply(.{ .baud_rate = 100_000 });

    for (0..std.math.maxInt(u7)) |addr| {
        const a: i2c.Address = @enumFromInt(addr);

        var rx_data: [1]u8 = undefined;
        _ = instance.read_blocking(a, &rx_data, null) catch |e| {
            // _ = instance.read_blocking(a, &rx_data, mdf.time.Duration.from_ms(10)) catch |e| {
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
