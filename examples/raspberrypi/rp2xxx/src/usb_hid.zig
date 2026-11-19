const std = @import("std");
const microzig = @import("microzig");
const common = @import("common.zig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const usb = microzig.core.usb;
const USB_Device = rp2xxx.usb.Polled(.{});

pub const std_options = microzig.std_options(.{
    .log_level = .debug,
    .log_scope_levels = &.{
        .{ .scope = .usb_dev, .level = .warn },
        .{ .scope = .usb_ctrl, .level = .warn },
        .{ .scope = .usb_hid_int_driver, .level = .warn },
    },
    .logFn = common.log,
});

pub const panic = microzig.panic;

comptime {
    _ = microzig.export_startup();
}

const hid_driver_options: usb.drivers.HID_Interrupt = .{
    .subclass = .Boot,
    .protocol = .Boot,
    .itf_string = "Boot Keyboard",
    .poll_interval = 1,
    .report = .boot_keyboard,
};

var usb_device: USB_Device = undefined;

var usb_controller: usb.DeviceController(.{
    .device_triple = .unspecified,
    .bcd_device = .v1_00,
    .serial = "someserial",
    .device_capabilities = USB_Device.device_capabilities,
}, &.{usb.Configuration(
    .{ .attributes = .{ .self_powered = false }, .max_current_ma = 50 },
    .{
        .keyboard = hid_driver_options,
        .reset = rp2xxx.usb.ResetDriver(null, 0){},
    },
)}) = .init;

const pin_config: rp2xxx.pins.GlobalConfiguration = .{
    .GPIO0 = .{ .function = .UART0_TX },
    .GPIO25 = .{ .name = "led", .direction = .out },
};

pub fn main() !void {
    common.init_logger();

    const pins = pin_config.apply();

    pins.led.put(1);

    // Then initialize the USB device using the configuration defined above
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
                var report = std.mem.zeroes(@TypeOf(drivers.keyboard).ReportIn);
                if (idx & 1 == 0 and idx < 2 * message.len)
                    report.keys[0] = message[@intCast(idx / 2)];
                idx += @intFromBool(drivers.keyboard.send_report(&report));
            }

            if (drivers.keyboard.receive_report()) |report|
                pins.led.put(@intFromBool(report.led.caps_lock));
        }
    }
}
