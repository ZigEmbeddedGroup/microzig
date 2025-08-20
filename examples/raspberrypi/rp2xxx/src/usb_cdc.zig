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
const uart_rx_pin = gpio.num(1);

const usb_templates = usb.templates.DescriptorsConfigTemplates;
const usb_config_len = usb_templates.config_descriptor_len + usb_templates.cdc_descriptor_len;
const usb_config_descriptor =
    usb_templates.config_descriptor(1, 2, 0, usb_config_len, 0xc0, .from_ma(100)) ++
    usb_templates.cdc_descriptor(0, 4, .ep1, 8, .ep2, .ep2, 64);

// This is our device configuration
const UsbDev = usb.Usb(.{
    .Device = rp2xxx.usb.Usb(.{}),
    .Drivers = struct {
        serial: usb.cdc.CdcClassDriver,
    },
    .descriptors = .create(
        .{
            .bcd_usb = .v1_1,
            .device_triple = .{
                .class = .Miscellaneous,
                .subclass = 2,
                .protocol = 1,
            },
            .max_packet_size0 = 64,
            .vendor = 0x2E8A,
            .product = 0x000a,
            .bcd_device = 0x0100,
            .manufacturer_s = 1,
            .product_s = 2,
            .serial_s = 0,
            .num_configurations = 1,
        },
        &usb_config_descriptor,
        .English,
        &.{
            "Raspberry Pi",
            "Pico Test Device",
            "someserial",
            "Board CDC",
        },
    ),
    .usb_configurations = .{.create(&.{.{
        .name = "serial",
        .driver = microzig.core.usb.cdc.CdcClassDriver,
        // .endpoints_in = .{ .ep1 = "notifi", .ep2 = "data" },
        // .endpoints_out = .{ .ep2 = "data" },
        .strings = &.{.{ .name = "cdc", .value = "Board CDC" }},
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
    usb_dev.drivers_data.serial = .{};

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
    usb_dev.init_device(&.{usb_dev.drivers_data.serial.driver()});
    var old: u64 = time.get_time_since_boot().to_us();
    var new: u64 = 0;

    var i: u32 = 0;
    while (true) {
        // You can now poll for USB events
        usb_dev.interface().task();

        new = time.get_time_since_boot().to_us();
        if (new - old > 500000) {
            old = new;
            led.toggle();
            i += 1;
            std.log.info("cdc test: {}\r\n", .{i});

            var tx_buf: [1024]u8 = undefined;
            const text = try std.fmt.bufPrint(&tx_buf, "This is very very long text sent from RP Pico by USB CDC to your device: {}\r\n", .{i});
            usb_dev.drivers_data.serial.writeAll(usb_dev.interface(), text);
        }

        // read and print host command if present
        var rx_buf: [64]u8 = undefined;
        const len = usb_dev.drivers_data.serial.read(usb_dev.interface(), &rx_buf);
        if (len > 0) {
            usb_dev.drivers_data.serial.writeAll(usb_dev.interface(), "Your message to me was: '");
            usb_dev.drivers_data.serial.writeAll(usb_dev.interface(), rx_buf[0..len]);
            usb_dev.drivers_data.serial.writeAll(usb_dev.interface(), "'\r\n");
        }
    }
}
