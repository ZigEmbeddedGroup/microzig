// nanoCH32V203
// https://github.com/wuxx/nanoCH32V203
// CH32V203C8T6
pub const microzig = @import("microzig");
pub const chip = @import("chip");
const ch32v = microzig.hal;

pub const product_string = "nanoCH32v203";

/// Clock configuration for this board
pub const clock_config: ch32v.clocks.Config = .{
    .source = .hse,
    .target_frequency = 48_000_000,
    .hse_frequency = 8_000_000,
};

/// CPU frequency is derived from clock config
pub const cpu_frequency = clock_config.target_frequency;

/// Board-specific init
pub fn init() void {
    ch32v.clocks.init(clock_config);
    ch32v.time.init();
    ch32v.clocks.enable_usbfs_clock();
}

/// Default UART: USART1 on PA9
pub const uart_setup: ch32v.usart.Setup = .{
    .instance = .USART1,
    .tx_pin = ch32v.gpio.Pin.init(0, 9), // PA9
    .rx_pin = ch32v.gpio.Pin.init(0, 10), // PA10
};

/// Default I2C: I2C1 on PB6 (SCL) / PB7 (SDA)
pub const i2c_setup: ch32v.i2c.Setup = .{
    .instance = ch32v.i2c.instance.I2C1,
    .scl_pin = ch32v.gpio.Pin.init(1, 6), // PB6
    .sda_pin = ch32v.gpio.Pin.init(1, 7), // PB7
};

/// Default SPI: SPI1 on PA5 (SCK) / PA6 (MISO) / PA7 (MOSI)
pub const spi_setup: ch32v.spi.Setup = .{
    .instance = ch32v.spi.instance.SPI1,
    .sck_pin = ch32v.gpio.Pin.init(0, 5), // PA5
    .mosi_pin = ch32v.gpio.Pin.init(0, 7), // PA7
    .miso_pin = ch32v.gpio.Pin.init(0, 6), // PA6
};

pub const pin_config = ch32v.pins.GlobalConfiguration{
    .GPIOA = .{
        .PIN15 = .{
            .name = "led",
            .mode = .{ .output = .general_purpose_push_pull },
        },
    },
};
