const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const flash = rp2xxx.flash;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;

const uart = rp2xxx.uart.instance.num(0);
const logger_baud_rate = 1_000_000;

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
};

const pin_config: rp2xxx.pins.GlobalConfiguration = .{
    .GPIO12 = .{ .function = .UART0_TX },
    .GPIO25 = .{ .name = "led", .direction = .out },
};
const pins = pin_config.pins();

// This is our device configuration
const Usb = rp2xxx.usb.Usb(.{ .Controller = microzig.core.usb.Controller(.{
    .strings = rp2xxx.usb.default.strings,
    .vid = rp2xxx.usb.default.vid,
    .pid = rp2xxx.usb.default.pid,
    .max_transfer_size = rp2xxx.usb.default.transfer_size,
    .attributes = .{ .self_powered = true },
    .Driver = microzig.core.usb.cdc.CdcClassDriver,
    .driver_endpoints = &.{
        .{ .name = "notifi", .value = .ep1 },
        .{ .name = "data", .value = .ep2 },
    },
    .driver_strings = &.{
        .{ .name = "name", .value = "Board CDC" },
    },
}) });
var usb: Usb = undefined;

pub fn main() !void {
    pin_config.apply();

    uart.apply(.{
        .baud_rate = logger_baud_rate,
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    // Then initialize the USB device using the configuration defined above
    usb = .init();

    pins.led.put(1);
    var last_led_toggle: u64 = time.get_time_since_boot().to_us();
    const delay_us = 500_000;

    var i: u32 = 0;
    while (true) {
        // You can now poll for USB events
        usb.interface().task();

        const now = time.get_time_since_boot().to_us();
        if (now - last_led_toggle > delay_us) {
            last_led_toggle += delay_us;
            pins.led.toggle();

            i +%= 1;
            std.log.info("cdc test: {}\r\n", .{i});

            var tx_buf: [1024]u8 = undefined;
            const text = try std.fmt.bufPrint(&tx_buf, "This is very very long text sent from RP Pico by USB CDC to your device: {}\r\n", .{i});
            usb.controller.driver_data.writeAll(usb.interface(), text);
        }

        // read and print host command if present
        var rx_buf: [64]u8 = undefined;
        const len = usb.controller.driver_data.read(usb.interface(), &rx_buf);
        if (len > 0) {
            usb.controller.driver_data.writeAll(usb.interface(), "Your message to me was: '");
            usb.controller.driver_data.writeAll(usb.interface(), rx_buf[0..len]);
            usb.controller.driver_data.writeAll(usb.interface(), "'\r\n");
        }
    }
}
