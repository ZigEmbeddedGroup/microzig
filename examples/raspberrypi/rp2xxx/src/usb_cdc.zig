const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const flash = rp2xxx.flash;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;

const led = gpio.num(25);
const uart = rp2xxx.uart.instance.num(0);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(12);
const uart_rx_pin = gpio.num(1);

// This is our device configuration
const Usb = rp2xxx.usb.Usb(.{ .Controller = microzig.core.usb.Controller(.{
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
    led.set_function(.sio);
    led.set_direction(.out);
    led.put(1);

    inline for (&.{ uart_tx_pin, uart_rx_pin }) |pin|
        pin.set_function(.uart);

    uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rp2xxx.clock_config,
    });

    rp2xxx.uart.init_logger(uart);

    // Then initialize the USB device using the configuration defined above
    usb = .init();
    usb.controller.driver_data = .{};

    var old: u64 = time.get_time_since_boot().to_us();
    var new: u64 = 0;

    var i: u32 = 0;
    while (true) {
        // You can now poll for USB events
        usb.interface().task();

        new = time.get_time_since_boot().to_us();
        if (new - old > 500000) {
            old = new;
            led.toggle();
            i += 1;
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
