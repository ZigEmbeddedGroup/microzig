//! Sharp Memory LCD (nice!view) Display over SPI
//!
//! This example demonstrates using the SPI HAL with the Sharp Memory LCD driver
//! for the nice!view display (160x68 monochrome memory LCD).
//!
//! Hardware setup:
//! - nice!view display connected to SPI1:
//!   - CS:   PA3 (Chip Select - ACTIVE HIGH!)
//!   - SCK:  PA5
//!   - MOSI: PA7
//!   - VCC:  3.3V
//!   - GND:  GND
//! - UART logging on USART2:
//!   - TX:   PA2 (115200 baud)
//!
//! This demonstrates:
//! - Sharp Memory LCD driver usage
//! - LSB-first SPI configuration (uncommon)
//! - CS active-high mode (uncommon)
//! - Line-major framebuffer with LSB-first pixel ordering
//! - Compile-time VCOM disabled (nice!view doesn't need it)
//! - UART logging for debugging
//!
//! Protocol details:
//! - 3-wire SPI (no D/C pin)
//! - LSB-first bit order (bit 0 = leftmost pixel)
//! - CS active-high (inverted from typical SPI)
//! - 2 MHz max clock speed
//!

const std = @import("std");
const microzig = @import("microzig");
const mdf = microzig.drivers;
const hal = microzig.hal;
const gpio = hal.gpio;
const spi = hal.spi;

const usart = hal.usart.instance.USART2;
const usart_tx_pin = gpio.Pin.init(0, 2); // PA2

pub const microzig_options = microzig.Options{
    .log_level = .info,
    .logFn = hal.usart.log,
};

// Pin definitions
const sck_pin = gpio.Pin.init(0, 5); // PA5
const mosi_pin = gpio.Pin.init(0, 7); // PA7
const cs_pin = gpio.Pin.init(0, 3); // PA3

pub fn main() !void {
    // Board brings up clocks and time
    microzig.board.init();

    // Configure USART2 TX pin (PA2) for logging
    usart_tx_pin.configure_alternate_function(.push_pull, .max_50MHz);

    // Initialize USART2 at 115200 baud
    usart.apply(.{
        .baud_rate = 115200,
        .remap = .default,
    });

    hal.usart.init_logger(usart);

    std.log.info("Sharp Memory LCD (nice!view) Test", .{});
    std.log.info("===================================", .{});
    std.log.info("", .{});
    std.log.info("Display: 160x68 monochrome memory LCD", .{});
    std.log.info("Protocol: 3-wire SPI, LSB-first, CS active-high", .{});
    std.log.info("", .{});

    // Configure SPI pins
    std.log.info("Configuring SPI pins...", .{});
    sck_pin.configure_alternate_function(.push_pull, .max_50MHz);
    mosi_pin.configure_alternate_function(.push_pull, .max_50MHz);

    // Configure control pins
    cs_pin.enable_clock();
    cs_pin.set_output_mode(.general_purpose_push_pull, .max_50MHz);

    // Initialize pins to safe states
    cs_pin.put(0); // CS low (idle state for Sharp - inverted logic)

    // Initialize SPI1 with DMA support
    const spi1 = spi.instance.SPI1;

    // SPI configuration for Sharp Memory LCD
    // CRITICAL: LSB-first bit order, CS active-high!
    // Mode 0 (CPOL=0, CPHA=0), up to 2 MHz
    std.log.info("Configuring SPI1...", .{});
    std.log.info("  Baud rate: 1 MHz (matching ZMK device tree)", .{});
    std.log.info("  Bit order: LSB-first (CRITICAL for Sharp!)", .{});
    std.log.info("  CS polarity: Active-HIGH (CRITICAL for Sharp!)", .{});
    const spi_config = spi.Config{
        .baud_rate = 1_000_000, // 1 MHz
        .polarity = .idle_low,
        .phase = .first_edge,
        .bit_order = .lsb_first, // CRITICAL: Sharp uses LSB-first!
        .dma = .{
            .tx_channel = .Ch3,
            .rx_channel = .Ch2,
        },
    };

    // Note: spi.apply() automatically enables SPI1 clock
    spi1.apply(spi_config);

    // Create SPI Datagram Device wrapper
    const SPI_DD = hal.drivers.SPI_Datagram_Device(spi_config);
    var spi_dev = SPI_DD.init(
        spi1,
        cs_pin,
        true, // Sharp needs CS HIGH during transmission (active-high)
        mdf.time.Duration.from_ms(100),
    );

    // Initialize Sharp Memory LCD driver for nice!view (160x68, no VCOM)
    std.log.info("", .{});
    std.log.info("Initializing Sharp Memory LCD driver...", .{});
    const disp_height = 68;
    const disp_width = 160;
    const Display = mdf.display.Sharp_Memory_LCD(.{
        .width = disp_width,
        .height = disp_height,
        // WARNING: This can be required for actual sharp LCD panels to avoid damaging the LCD.
        // .vcom_mode = .software,
        .vcom_mode = .none, // nice!view doesn't need VCOM
    });

    var display = Display.init(spi_dev.datagram_device(), {}) catch |err| {
        std.log.err("Failed to initialize display: {s}", .{@errorName(err)});
        @panic(@errorName(err));
    };
    std.log.info("  Display initialized successfully", .{});
    std.log.info("  Framebuffer size: {} bytes", .{Display.Framebuffer.size_bytes});

    // Clear the display
    std.log.info("", .{});
    std.log.info("Clearing display...", .{});
    display.clear_screen() catch |err| {
        std.log.err("Failed to clear display: {s}", .{@errorName(err)});
        @panic(@errorName(err));
    };
    std.log.info("  Display cleared", .{});

    // Give it a moment to clear
    hal.time.sleep_ms(10);

    // Create framebuffer and draw test pattern
    std.log.info("", .{});
    std.log.info("Creating framebuffer and drawing test pattern...", .{});
    var fb = Display.Framebuffer.init(.white);

    // Draw a checkerboard pattern (10x10 pixel squares)
    std.log.info("  Drawing checkerboard (10x10 pixel squares)...", .{});
    for (0..disp_height) |y| {
        for (0..disp_width) |x| {
            const is_black = ((x / 10) + (y / 10)) % 2 == 1;
            if (is_black) {
                fb.set_pixel(x, y, .black);
            }
        }
    }

    // Draw a border around the display
    std.log.info("  Drawing border...", .{});
    fb.draw_hline(0, 0, disp_width, .black); // Top
    fb.draw_hline(0, disp_height - 1, disp_width, .black); // Bottom
    fb.draw_vline(0, 0, disp_height, .black); // Left
    fb.draw_vline(disp_width - 1, 0, disp_height, .black); // Right

    // Write framebuffer to display
    std.log.info("", .{});
    std.log.info("Writing framebuffer to display...", .{});
    const start_time = hal.time.get_time_since_boot();
    display.write_full_display(&fb) catch |err| {
        std.log.err("Failed to write display: {s}", .{@errorName(err)});
        @panic(@errorName(err));
    };
    const elapsed = hal.time.get_time_since_boot().to_us() - start_time.to_us();
    std.log.info("  Display updated successfully in {} us", .{elapsed});
    std.log.info("  Frame rate: ~{} Hz", .{1_000_000 / elapsed});

    // Success! The display should now show a checkerboard pattern with a border
    std.log.info("", .{});
    std.log.info("Test complete! Display should show checkerboard pattern.", .{});
    std.log.info("", .{});

    var color: mdf.display.sharp_memory_lcd.Color = .black;
    while (true) {
        std.log.info("flipping", .{});
        fb.draw_hline(0, 0, disp_width, color); // Top
        fb.draw_hline(0, disp_height - 1, disp_width, color); // Bottom
        fb.draw_vline(0, 0, disp_height, color); // Left
        fb.draw_vline(disp_width - 1, 0, disp_height, color); // Right

        // Write framebuffer to display
        display.write_full_display(&fb) catch |err| {
            std.log.err("Failed to write display: {s}", .{@errorName(err)});
            @panic(@errorName(err));
        };
        color = color.invert();
        hal.time.sleep_ms(1000);
    }
}
