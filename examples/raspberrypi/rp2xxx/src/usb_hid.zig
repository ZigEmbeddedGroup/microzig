const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;

const usb = microzig.core.usb;

const led = gpio.num(25);
const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

const HidDriver = usb.hid.HidClassDriver(
    .{ .max_packet_size = 64, .boot_protocol = true, .endpoint_interval = 0 },
    usb.descriptor.hid.ReportDescriptorKeyboard,
);

const usb_config_descriptor = microzig.core.usb.descriptor.Configuration.create(
    0,
    .{ .self_powered = true },
    100,
    HidDriver.Descriptor.create(1, .{ .name = 4 }, .{ .out = .ep1, .in = .ep1 }),
);

const usb_dev = rp2xxx.usb.Usb(.{}, usb_config_descriptor, usb.Config{
    .device_descriptor = .{
        .bcd_usb = .from(0x0200),
        .device_triple = .{
            .class = .Unspecified,
            .subclass = 0,
            .protocol = 0,
        },
        .max_packet_size0 = 64,
        .vendor = .from(0x2E8A),
        .product = .from(0x000A),
        .bcd_device = .from(0x0100),
        .manufacturer_s = 1,
        .product_s = 2,
        .serial_s = 3,
        .num_configurations = 1,
    },
    .lang_descriptor = .English,
    .string_descriptors = &.{
        .from_str("Raspberry Pi"),
        .from_str("Pico Test Device"),
        .from_str("someserial"),
        .from_str("Boot Keyboard"),
    },
    .Drivers = struct { hid: HidDriver },
});

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
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    led.set_function(.sio);
    led.set_direction(.out);
    led.put(1);

    // Then initialize the USB device using the configuration defined above
    usb_dev.init_device();

    var old: u64 = time.get_time_since_boot().to_us();
    var new: u64 = 0;
    while (true) {
        // You can now poll for USB events
        usb_dev.task(
            false, // debug output over UART [Y/n]
        );

        if (usb_dev.drivers()) |drivers| {
            _ = drivers; // TODO

            new = time.get_time_since_boot().to_us();
            if (new - old > 500000) {
                old = new;
                led.toggle();
            }
        }
    }
}
