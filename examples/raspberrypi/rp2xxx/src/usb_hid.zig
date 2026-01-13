const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;

const usb = microzig.core.usb;

const led = gpio.num(25);
const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

const HidDriver = usb.drivers.hid.HidClassDriver(
    .{ .boot_protocol = true, .poll_interval = 0 },
    usb.descriptor.hid.ReportDescriptorKeyboard,
);

var usb_device: rp2xxx.usb.Polled(.{}) = undefined;

var usb_controller: usb.DeviceController(.{
    .device_descriptor = .{
        .bcd_usb = .from(0x0200),
        .device_triple = .unspecified,
        .max_packet_size0 = 64,
        .vendor = .from(0x2E8A),
        .product = .from(0x000A),
        .bcd_device = .from(0x0100),
        .manufacturer_s = 1,
        .product_s = 2,
        .serial_s = 3,
        .num_configurations = 1,
    },
    .string_descriptors = &.{
        .from_lang(.English),
        .from_str("Raspberry Pi"),
        .from_str("Pico Test Device"),
        .from_str("someserial"),
        .from_str("Boot Keyboard"),
    },
    .configurations = &.{.{
        .num = 1,
        .configuration_s = 0,
        .attributes = .{ .self_powered = false },
        .max_current_ma = 50,
        .Drivers = struct { hid: HidDriver },
    }},
    .max_supported_packet_size = @TypeOf(usb_device).max_supported_packet_size,
}) = .init;

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
    usb_device = .init();

    var old: u64 = time.get_time_since_boot().to_us();
    var new: u64 = 0;
    while (true) {
        // You can now poll for USB events
        usb_device.poll(&usb_controller);

        if (usb_controller.drivers()) |drivers| {
            _ = drivers; // TODO

            new = time.get_time_since_boot().to_us();
            if (new - old > 500000) {
                old = new;
                led.toggle();
            }
        }
    }
}
