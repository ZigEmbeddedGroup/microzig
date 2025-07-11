const std = @import("std");
const microzig = @import("microzig");
const WS2812 = microzig.drivers.led.WS2812;
const Color = microzig.drivers.led.ws2812.Color;
const hal = microzig.hal;
const gpio = hal.gpio;

pub const microzig_options: microzig.Options = .{
    .logFn = hal.usb_serial_jtag.logger.log,
};

pub fn main() !void {
    gpio.num(8).connect_peripheral_to_output(.fspid);

    const spi_bus: hal.spi.SPI_Bus = .init(.spi2);
    spi_bus.apply(.{
        .clock_config = hal.clock_config,
        .baud_rate = 3_000_000,
        .bit_order = .msb_first,
    });

    const spi_dev: hal.drivers.SPI_Device = .init(spi_bus, .single_one_wire, null);
    var clock_dev: hal.drivers.ClockDevice = .{};

    var ws2812: WS2812(.{
        .max_led_count = 1,
        .Datagram_Device = hal.drivers.SPI_Device,
    }) = .init(
        spi_dev,
        clock_dev.clock_device(),
    );

    const red: Color = .{ .r = 10, .g = 0, .b = 0 };
    const green: Color = .{ .r = 0, .g = 10, .b = 0 };
    const blue: Color = .{ .r = 0, .g = 0, .b = 10 };

    while (true) {
        try ws2812.write(&.{red});
        std.log.info("red", .{});
        hal.time.sleep_ms(1_000);
        try ws2812.write(&.{green});
        std.log.info("green", .{});
        hal.time.sleep_ms(1_000);
        try ws2812.write(&.{blue});
        std.log.info("blue", .{});
        hal.time.sleep_ms(1_000);
    }
}
