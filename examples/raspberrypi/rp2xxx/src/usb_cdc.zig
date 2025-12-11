const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;

const usb = microzig.core.usb;

const led = gpio.num(25);
const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

const UsbSerial = usb.cdc.CdcClassDriver(.{ .max_packet_size = 64 });

const usb_config_descriptor = microzig.core.usb.descriptor.Configuration.create(
    0,
    .{ .self_powered = true },
    100,
    UsbSerial.Descriptor.create(1, .{ .name = 4 }, .{ .notifi = .ep1, .data_out = .ep2, .data_in = .ep2 }),
);

const usb_dev = rp2xxx.usb.Device(.{});

var usb_ctrl: usb.DeviceController(usb_config_descriptor, usb.Config{
    .device_descriptor = .{
        .bcd_usb = .from(0x0200),
        .device_triple = .{
            .class = .Miscellaneous,
            .subclass = 2,
            .protocol = 1,
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
        .from_str("Board CDC"),
    },
    .Drivers = struct { serial: UsbSerial },
}) = undefined;

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
    usb_dev.init();
    usb_ctrl = .init(&usb_dev.interface);

    var old: u64 = time.get_time_since_boot().to_us();
    var new: u64 = 0;

    var i: u32 = 0;
    while (true) {
        // You can now poll for USB events
        usb_ctrl.task(
            false, // debug output over UART [Y/n]
        );

        if (usb_ctrl.drivers()) |drivers| {
            new = time.get_time_since_boot().to_us();
            if (new - old > 500000) {
                old = new;
                led.toggle();
                i += 1;
                std.log.info("cdc test: {}\r\n", .{i});

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
pub fn usb_cdc_write(serial: *UsbSerial, comptime fmt: []const u8, args: anytype) void {
    const text = std.fmt.bufPrint(&usb_tx_buff, fmt, args) catch &.{};

    var write_buff = text;
    while (write_buff.len > 0) {
        write_buff = serial.write(write_buff);
        usb_ctrl.task(false);
    }
    // Short messages are not sent right away; instead, they accumulate in a buffer, so we have to force a flush to send them
    _ = serial.write_flush();
    usb_ctrl.task(false);
}

var usb_rx_buff: [1024]u8 = undefined;

// Receive data from host
// NOTE: Read code was not tested extensively. In case of issues, try to call USB task before every read operation
pub fn usb_cdc_read(
    serial: *UsbSerial,
) []const u8 {
    var total_read: usize = 0;
    var read_buff: []u8 = usb_rx_buff[0..];

    while (true) {
        const len = serial.read(read_buff);
        read_buff = read_buff[len..];
        total_read += len;
        if (len == 0) break;
    }

    return usb_rx_buff[0..total_read];
}
