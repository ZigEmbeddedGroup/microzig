const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const usb = microzig.core.usb;
const USB_Device = rp2xxx.usb.Polled(.{});
const HID_Driver = usb.drivers.hid.HidClassDriver(
    .{ .boot_protocol = true, .poll_interval = 0 },
    usb.descriptor.hid.ReportDescriptorKeyboard,
);

var usb_device: USB_Device = undefined;

var usb_controller: usb.DeviceController(.{
    .device_descriptor = .{
        .bcd_usb = USB_Device.max_supported_bcd_usb,
        .device_triple = .unspecified,
        .max_packet_size0 = USB_Device.max_supported_packet_size,
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
        .Drivers = struct { hid: HID_Driver },
    }},
    .max_supported_packet_size = USB_Device.max_supported_packet_size,
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

const pin_config: rp2xxx.pins.GlobalConfiguration = .{
    .GPIO0 = .{ .function = .UART0_TX },
    .GPIO25 = .{ .name = "led", .direction = .out },
};

const pins = pin_config.pins();

pub fn main() !void {
    pin_config.apply();

    const uart = rp2xxx.uart.instance.num(0);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    pins.led.put(1);

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
                pins.led.toggle();
            }
        }
    }
}
