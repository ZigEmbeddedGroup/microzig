const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const flash = rp2xxx.flash;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;

const uart = rp2xxx.uart.instance.num(0);

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
const Usb = rp2xxx.usb.Usb(.{ .controller_config = .{
    .device_triple = .{
        .class = .Miscellaneous,
        .subclass = 2,
        .protocol = 1,
    },
    .attributes = .{ .self_powered = false },
    .drivers = &.{.{
        .name = "hid",
        .Type = microzig.core.usb.hid.HidClassDriver,
        .endpoints = &.{
            .{ .name = "main", .value = .ep1 },
        },
        .strings = &.{
            .{ .name = "name", .value = "Board HID" },
        },
    }},
} });
var usb: Usb = undefined;

pub fn main() !void {
    pin_config.apply();

    // init uart logging
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    // Then initialize the USB device using the configuration defined above
    usb = .init();

    pins.led.put(1);
    var last_led_toggle: u64 = time.get_time_since_boot().to_us();
    const delay_us = 500_000;

    while (true) {
        // You can now poll for USB events
        usb.poll();

        const hid = if (usb.controller.drivers) |*drivers|
            &drivers.hid
        else // This means the USB connection has not yet been established
            continue;
        hid.report_descriptor = &microzig.core.usb.descriptor.hid.report.GenericInOut;

        const now = time.get_time_since_boot().to_us();
        if (now - last_led_toggle > delay_us) {
            last_led_toggle += delay_us;
            pins.led.toggle();
        }
    }
}
