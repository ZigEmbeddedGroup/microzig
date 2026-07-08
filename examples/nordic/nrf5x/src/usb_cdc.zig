//! Adapted from
//! examples/raspberrypi/rp2xxx/src/usb_cdc.zig

const std = @import("std");
const microzig = @import("microzig");
const nrf = microzig.hal;
const board = microzig.board;
const usb = microzig.core.usb;
const time = nrf.time;
const USBD = nrf.usbd.USBD;
const clocks = nrf.clocks;
const uart = nrf.uart.num(0);

const USB_Serial = usb.drivers.CDC;

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{
    .log_level = .debug,
    .log_scope_levels = &.{
        .{ .scope = .usb_dev, .level = .warn },
        .{ .scope = .usb_ctrl, .level = .warn },
        .{ .scope = .usb_cdc, .level = .warn },
    },
    .logFn = nrf.uart.log,
});

comptime {
    _ = microzig.export_startup();
}

var usb_device: USBD = undefined;

// Generate a device controller with descriptor and handlers setup for CDC (USB_Serial)
var usb_controller: usb.DeviceController(.{
    .bcd_usb = USBD.max_supported_bcd_usb,
    .device_triple = .unspecified,
    .vendor = USBD.default_vendor_id,
    .product = USBD.default_product_id,
    .bcd_device = .v1_00,
    .serial = "someserial",
    .max_supported_packet_size = USBD.max_supported_packet_size,
    .configurations = &.{.{
        .attributes = .{ .self_powered = false },
        .max_current_ma = 50,
        .Drivers = struct { serial: USB_Serial },
    }},
}, .{.{
    .serial = .{ .itf_notifi = "Board CDC", .itf_data = "Board CDC Data" },
}}) = .init;

pub fn main() !void {
    board.init();

    uart.apply(.{
        .tx_pin = board.uart_tx,
        .rx_pin = board.uart_rx,
    });

    nrf.uart.init_logger(uart);

    clocks.hfxo.start();
    usb_device = .init();

    var old: u64 = 0;
    var new: u64 = 0;

    var i: u32 = 0;

    while (true) {
        // You can now poll for USB events
        usb_device.poll(&usb_controller);

        // Ensure that the host as finished enumerating our USB device
        if (usb_controller.drivers()) |drivers| {
            new = time.get_time_since_boot().to_us();
            if (new - old > 500_000) {
                old = new;
                board.led1.toggle();
                i += 1;
                std.log.info("cdc test: {}", .{i});

                usb_cdc_write(&drivers.serial, "This is very very long text sent from nRF52 by USB CDC to your device: {}\r\n", .{i});
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

/// Transfer data to host
/// NOTE: After each USB chunk transfer, we have to call the USB task so that bus TX events can be
/// handled
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

/// Receive data from host
/// NOTE: Read code was not tested extensively. In case of issues, try to call USB task before every
/// read operation
pub fn usb_cdc_read(serial: *USB_Serial) []const u8 {
    var rx_len: usize = 0;

    while (true) {
        const len = serial.read(usb_rx_buff[rx_len..]);
        rx_len += len;
        if (len == 0) break;
    }

    return usb_rx_buff[0..rx_len];
}
