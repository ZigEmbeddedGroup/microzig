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

const CdcDriver = microzig.core.usb.cdc.CdcClassDriver;

// This is our device configuration
const Usb = rp2xxx.usb.Usb(.{ .controller_config = .{
    .attributes = .{ .self_powered = false },
    .drivers = &.{.{
        .name = "serial",
        .Type = CdcDriver,
        .endpoints = &.{
            .{ .name = "notifi", .value = .ep1 },
            .{ .name = "data", .value = .ep2 },
        },
        .strings = &.{
            .{ .name = "name", .value = "Board CDC" },
        },
    }},
} });
var usb: Usb = undefined;

// Poll the USB device for events until all data is sent.
fn write_all(serial: *CdcDriver, data: []const u8) void {
    var offset: usize = 0;
    while (offset < data.len) {
        offset += serial.write(data[offset..]);
        serial.flush(usb.interface());
        usb.poll();
    }
}

pub fn main() !void {
    pin_config.apply();

    uart.apply(.{
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
        usb.poll();

        const usb_serial = if (usb.controller.drivers) |*drivers|
            &drivers.serial
        else // This means the USB connection has not yet been established
            continue;

        const now = time.get_time_since_boot().to_us();
        if (now - last_led_toggle > delay_us) {
            last_led_toggle += delay_us;
            pins.led.toggle();

            i +%= 1;
            std.log.info("cdc test: {}\r\n", .{i});

            var tx_buf: [1024]u8 = undefined;
            const text = try std.fmt.bufPrint(&tx_buf, "This is very very long text sent from RP Pico by USB CDC to your device: {}\r\n", .{i});
            write_all(usb_serial, text);
        }

        // read and print host command if present
        var rx_buf: [64]u8 = undefined;
        const len = usb_serial.read(usb.interface(), &rx_buf);
        if (len > 0) {
            write_all(usb_serial, "Your message to me was: '");
            write_all(usb_serial, rx_buf[0..len]);
            write_all(usb_serial, "'\r\n");
        }
    }
}
