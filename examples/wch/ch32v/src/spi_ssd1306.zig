//! SSD1306 OLED Display over SPI
//!
//! This example demonstrates using the SPI HAL with the SSD1306 OLED display driver.
//!
//! Hardware setup:
//! - SSD1306 128x64 OLED display (SPI mode) connected to SPI1:
//!   - CS:   PA4 (Chip Select)
//!   - D/C:  PA3 (Data/Command)
//!   - SCK:  PA5
//!   - MOSI: PA7
//!   - RST:  PA2 (optional, can tie to VCC with 10K pull-up)
//!   - VCC:  3.3V
//!   - GND:  GND
//!
//! This demonstrates:
//! - SPI_Datagram_Device wrapper usage
//! - Integration with existing SSD1306 driver
//! - Vectored I/O for command+data packets
//! - CS management via connect/disconnect
//!

const std = @import("std");
const microzig = @import("microzig");
const mdf = microzig.drivers;
const hal = microzig.hal;
const gpio = hal.gpio;
const spi = hal.spi;

pub const microzig_options = microzig.Options{
    .log_level = .info,
};

// Pin definitions
const sck_pin = gpio.Pin.init(0, 5); // PA5
const mosi_pin = gpio.Pin.init(0, 7); // PA7
const cs_pin = gpio.Pin.init(0, 4); // PA4
const dc_pin = gpio.Pin.init(0, 3); // PA3 (Data/Command)
const rst_pin = gpio.Pin.init(0, 2); // PA2 (Reset, optional)

pub fn main() !void {
    // Board brings up clocks and time
    microzig.board.init();

    // Configure SPI pins
    sck_pin.configure_alternate_function(.push_pull, .max_50MHz);
    mosi_pin.configure_alternate_function(.push_pull, .max_50MHz);

    // Configure control pins
    cs_pin.enable_clock();
    cs_pin.set_output_mode(.general_purpose_push_pull, .max_50MHz);
    dc_pin.enable_clock();
    dc_pin.set_output_mode(.general_purpose_push_pull, .max_50MHz);
    rst_pin.enable_clock();
    rst_pin.set_output_mode(.general_purpose_push_pull, .max_50MHz);

    // Initialize pins to safe states
    cs_pin.put(1); // CS high (inactive)
    dc_pin.put(1); // D/C high (data mode)
    rst_pin.put(1); // RST high (not in reset)

    // Initialize SPI1 with DMA support
    const spi1 = spi.instance.SPI1;

    // SPI configuration for SSD1306
    // Mode 0 (CPOL=0, CPHA=0), MSB first, up to 10 MHz
    const spi_config = spi.Config{
        .baud_rate = 8_000_000, // 8 MHz (well within SSD1306's 10 MHz max)
        .polarity = .idle_low,
        .phase = .first_edge,
        .bit_order = .msb_first,
        .dma = .{
            .tx_channel = .Ch3,
            .rx_channel = .Ch2,
            .threshold = 16,
        },
    };

    spi1.apply(spi_config);

    // Create SPI Datagram Device wrapper
    const SPI_DD = hal.drivers.SPI_Datagram_Device(spi_config);
    var spi_dev = SPI_DD.init(
        spi1,
        cs_pin,
        false, // CS is active low
        mdf.time.Duration.from_ms(100),
    );

    // Hardware reset (recommended for SSD1306)
    rst_pin.put(0); // Assert reset
    hal.time.sleep_ms(10);
    rst_pin.put(1); // Release reset
    hal.time.sleep_ms(10);

    // Create Digital_IO wrapper for D/C pin
    var dc_io = DP_PinWrapper{};

    // Initialize SSD1306 driver using the init function directly
    const ssd1306 = microzig.drivers.display.ssd1306;
    var display = ssd1306.init(
        .spi_4wire,
        spi_dev.datagram_device(),
        dc_io.digital_io(),
    ) catch |err| {
        @panic(@errorName(err));
    };

    // Clear the display
    display.clear_screen(false) catch |err| {
        @panic(@errorName(err));
    };

    // Draw a checkerboard pattern
    var framebuffer: [1024]u8 = undefined; // 128x64 / 8 = 1024 bytes

    // Create checkerboard pattern (8x8 squares)
    for (0..64) |y| {
        const page = y / 8;
        const bit = @as(u3, @truncate(y % 8));
        for (0..128) |x| {
            const is_white = ((x / 8) + (y / 8)) % 2 == 0;
            const byte_idx = page * 128 + x;
            if (is_white) {
                framebuffer[byte_idx] |= (@as(u8, 1) << bit);
            } else {
                framebuffer[byte_idx] &= ~(@as(u8, 1) << bit);
            }
        }
    }

    // Write framebuffer to display
    display.write_gdram(&framebuffer) catch |err| {
        @panic(@errorName(err));
    };

    // Infinite loop
    while (true) {
        hal.time.sleep_ms(1000);
    }
}

// Digital_IO wrapper for D/C pin
const DP_PinWrapper = struct {
    pub fn digital_io(self: *DP_PinWrapper) mdf.base.Digital_IO {
        _ = self;
        const S = struct {
            const vtable: mdf.base.Digital_IO.VTable = .{
                .set_direction_fn = set_direction_fn,
                .set_bias_fn = set_bias_fn,
                .write_fn = write_fn,
                .read_fn = read_fn,
            };

            fn set_direction_fn(_: *anyopaque, _: mdf.base.Digital_IO.Direction) mdf.base.Digital_IO.SetDirError!void {
                // D/C pin is always output, nothing to do
            }

            fn set_bias_fn(_: *anyopaque, _: ?mdf.base.Digital_IO.State) mdf.base.Digital_IO.SetBiasError!void {
                // No bias control needed
            }

            fn write_fn(_: *anyopaque, state: mdf.base.Digital_IO.State) mdf.base.Digital_IO.WriteError!void {
                dc_pin.put(switch (state) {
                    .low => 0,
                    .high => 1,
                });
            }

            fn read_fn(_: *anyopaque) mdf.base.Digital_IO.ReadError!mdf.base.Digital_IO.State {
                return if (dc_pin.read() == 1) .high else .low;
            }
        };

        return .{
            .ptr = undefined,
            .vtable = &S.vtable,
        };
    }
};
