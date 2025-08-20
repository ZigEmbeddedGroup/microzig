const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const flash = rp2xxx.flash;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const usb = microzig.core.usb;

const led = gpio.num(25);
const uart = rp2xxx.uart.instance.num(0);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(0);

const usb_templates = usb.templates.DescriptorsConfigTemplates;
const usb_packet_size = 64;
const usb_config_len = usb_templates.config_descriptor_len + usb_templates.hid_in_out_descriptor_len;
const usb_config_descriptor =
    usb_templates.config_descriptor(1, 1, 0, usb_config_len, 0xc0, .from_ma(100)) ++
    usb_templates.hid_in_out_descriptor(0, 0, 0, usb.hid.ReportDescriptorGenericInOut.len, .ep1, .ep1, usb_packet_size, 0);

// This is our device configuration
const UsbDev = usb.Usb(.{
    .Device = rp2xxx.usb.Usb(.{}),
    .Drivers = struct {
        hid: usb.hid.HidClassDriver,
    },
    .descriptors = .create(
        .{
            .bcd_usb = .v1_1,
            .device_triple = .{
                .class = .Unspecified,
                .subclass = 0,
                .protocol = 0,
            },
            .max_packet_size0 = 64,
            .vendor = 0xCafe,
            .product = 2,
            .bcd_device = 0x0100,
            // Those are indices to the descriptor strings
            // Make sure to provide enough string descriptors!
            .manufacturer_s = 1,
            .product_s = 2,
            .serial_s = 3,
            .num_configurations = 1,
        },
        &usb_config_descriptor,
        .English,
        &.{
            "Raspberry Pi",
            "Pico Test Device",
            "cafebabe",
        },
    ),
    .usb_configurations = .{.create(&.{.{
        .name = "hid",
        .driver = usb.hid.HidClassDriver,
    }})},
});
var usb_dev: UsbDev = .init;

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
    usb_dev.drivers_data.hid = .{ .report_descriptor = &usb.hid.ReportDescriptorGenericInOut };

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
    usb_dev.init_device(&.{usb_dev.drivers_data.hid.driver()});
    var old: u64 = time.get_time_since_boot().to_us();
    var new: u64 = 0;
    while (true) {
        // You can now poll for USB events
        usb_dev.interface().task();

        new = time.get_time_since_boot().to_us();
        if (new - old > 500000) {
            old = new;
            led.toggle();
        }
    }
}
