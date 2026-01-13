const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const usb = microzig.core.usb;
const USB_Device = rp2xxx.usb.Polled(.{});
const USB_Serial = usb.drivers.cdc.CdcClassDriver(.{ .max_packet_size = USB_Device.max_supported_packet_size });

var usb_device: USB_Device = undefined;

var usb_controller: usb.DeviceController(.{
    .device_descriptor = .{
        .bcd_usb = USB_Device.max_supported_bcd_usb,
        .device_triple = .from(.Miscellaneous, @enumFromInt(2), @enumFromInt(1)),
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
        .from_str("Board CDC"),
    },
    .configurations = &.{.{
        .num = 1,
        .configuration_s = 0,
        .attributes = .{ .self_powered = false },
        .max_current_ma = 50,
        .Drivers = struct { serial: USB_Serial },
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

    var i: u32 = 0;
    while (true) {
        // You can now poll for USB events
        usb_device.poll(&usb_controller);

        if (usb_controller.drivers()) |drivers| {
            new = time.get_time_since_boot().to_us();
            if (new - old > 500000) {
                old = new;
                pins.led.toggle();
                i += 1;
                std.log.info("cdc test: {}", .{i});

                usb_cdc_write(&drivers.serial, "This is very very long text sent from RP Pico by USB CDC to your device: {}\r\n", .{i});
            }

            // read and print host command if present
            const message = usb_cdc_read(&drivers.serial);
            if (message.len > 0) {
                usb_cdc_write(&drivers.serial, "Your message to me was: {s}\r\n", .{message});
            }
        }
    }
}

var usb_tx_buff: [1024]u8 = undefined;

// Transfer data to host
// NOTE: After each USB chunk transfer, we have to call the USB task so that bus TX events can be handled
pub fn usb_cdc_write(serial: *USB_Serial, comptime fmt: []const u8, args: anytype) void {
    var tx = std.fmt.bufPrint(&usb_tx_buff, fmt, args) catch &.{};

    while (tx.len > 0) {
        tx = tx[serial.write(tx)..];
        usb_device.poll(&usb_controller);
    }
    // Short messages are not sent right away; instead, they accumulate in a buffer, so we have to force a flush to send them
    while (!serial.flush())
        usb_device.poll(&usb_controller);
}

var usb_rx_buff: [1024]u8 = undefined;

// Receive data from host
// NOTE: Read code was not tested extensively. In case of issues, try to call USB task before every read operation
pub fn usb_cdc_read(
    serial: *USB_Serial,
) []const u8 {
    var rx_len: usize = 0;

    while (true) {
        const len = serial.read(usb_rx_buff[rx_len..]);
        rx_len += len;
        if (len == 0) break;
    }

    return usb_rx_buff[0..rx_len];
}
