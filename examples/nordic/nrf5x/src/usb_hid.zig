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

pub const panic = microzig.panic;

pub const std_options = microzig.std_options(.{
    .log_level = .debug,
    .log_scope_levels = &.{
        .{ .scope = .usb_dev, .level = .warn },
        .{ .scope = .usb_ctrl, .level = .warn },
        .{ .scope = .usb_hid_int_driver, .level = .warn },
    },
    .logFn = nrf.uart.log,
});

comptime {
    _ = microzig.export_startup();
}

const hid_driver_options: usb.drivers.HID_Interrupt = .{
    .subclass = .Boot,
    .protocol = .Boot,
    .itf_string = "Boot Keyboard",
    .poll_interval = 1,
    .report = &usb.HID_report.boot_keyboard,
};

var usb_device: USBD = undefined;

var usb_controller: usb.DeviceController(.{
    .device_triple = .unspecified,
    .bcd_device = .v1_00,
    .serial = "someserial",
    .device_capabilities = USBD.device_capabilities,
}, &.{usb.configuration.Create(
    .{ .attributes = .{ .self_powered = false }, .max_current_ma = 50 },
    .{ .keyboard = hid_driver_options },
)}) = .init;

pub fn main() !void {
    board.init();

    uart.apply(.{
        .tx_pin = board.uart_tx,
        .rx_pin = board.uart_rx,
    });

    nrf.uart.init_logger(uart);

    clocks.hfxo.start();
    usb_device = .init();

    var old: u64 = time.get_time_since_boot().to_us();
    var new: u64 = 0;
    const message: []const usb.HID_report.Keycode = &.{ .h, .e, .l, .l, .o, .space, .w, .o, .r, .l, .d, .caps_lock, .enter };
    var idx: usize = 0;

    while (true) {
        // You can now poll for USB events
        usb_device.poll(&usb_controller);

        if (usb_controller.drivers()) |drivers| {
            new = time.get_time_since_boot().to_us();
            if (new - old > 2_000_000) {
                old = new;
                idx = 0;
            } else {
                std.log.info("report {}", .{idx});
                var report = std.mem.zeroes(@TypeOf(drivers.keyboard).ReportIn);
                if (idx & 1 == 0 and idx < 2 * message.len)
                    report.keys[0] = message[@intCast(idx / 2)];
                idx += @intFromBool(drivers.keyboard.send_report(&report));
            }

            if (drivers.keyboard.receive_report()) |report|
                board.led1.put(@intFromBool(report.led.caps_lock));
        }
    }
}
