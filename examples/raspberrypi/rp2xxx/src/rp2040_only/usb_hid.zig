const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const flash = rp2xxx.flash;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;

const led = gpio.num(25);
const uart = rp2xxx.uart.instance.num(0);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(0);

// This is our device configuration
const Usb = rp2xxx.usb.Usb(.{ .Controller = microzig.core.usb.Controller(.{
    .device_triple = .{
        .class = .Miscellaneous,
        .subclass = 2,
        .protocol = 1,
    },
    .attributes = .{ .self_powered = true },
    .Driver = microzig.core.usb.hid.HidClassDriver,
    .driver_endpoints = &.{
        .{ .name = "main", .value = .ep1 },
    },
    .driver_strings = &.{
        .{ .name = "name", .value = "Board HID" },
    },
}) });
var usb: Usb = undefined;

pub fn panic(message: []const u8, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    std.log.err("panic: {s}", .{message});
    @breakpoint();
    while (true) {}
}

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
};

pub fn main() !void {
    // init uart logging
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    led.set_function(.sio);
    led.set_direction(.out);
    led.put(1);

    // Then initialize the USB device using the configuration defined above
    usb = .init();
    usb.controller.driver_data = .{ .report_descriptor = &microzig.core.usb.descriptor.hid.report.GenericInOut };

    var old: u64 = time.get_time_since_boot().to_us();
    var new: u64 = 0;
    while (true) {
        // You can now poll for USB events
        usb.interface().task();

        new = time.get_time_since_boot().to_us();
        if (new - old > 500000) {
            old = new;
            led.toggle();
        }
    }
}
