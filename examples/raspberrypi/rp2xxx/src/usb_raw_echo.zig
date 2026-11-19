const microzig = @import("microzig");
const common = @import("common.zig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const usb = microzig.core.usb;
// Port-specific type which implements the DeviceInterface interface, used by the USB core to
// read from/write to the peripheral.
const USB_Device = rp2xxx.usb.Polled(.{});

var usb_device: USB_Device = undefined;

// Generate a device controller with descriptor and handlers setup for CDC (USB_Serial) and
// picotool-controlled reset (ResetDriver).
var usb_controller: usb.DeviceController(.{
    .device_triple = .unspecified,
    .bcd_device = .v1_00,
    .serial = "someserial",
    .device_capabilities = USB_Device.device_capabilities,
}, &.{usb.Configuration(
    .{ .attributes = .{ .self_powered = false }, .max_current_ma = 50 },
    .{
        .echo = usb.drivers.EchoExample{},
        .reset = rp2xxx.usb.ResetDriver(null, 0){},
    },
)}) = .init;

pub const std_options = microzig.std_options(.{
    .log_level = .debug,
    .log_scope_levels = &.{
        .{ .scope = .usb_dev, .level = .warn },
        .{ .scope = .usb_ctrl, .level = .warn },
        .{ .scope = .usb_echo, .level = .warn },
    },
    .logFn = common.log,
});

comptime {
    _ = microzig.export_startup();
}

pub const panic = microzig.panic;

const pin_config = microzig.board.pin_config;

pub fn main() !void {
    common.init_logger();
    const pins = pin_config.apply();

    pins.led.put(1);

    // Then initialize the USB device using the configuration defined above
    usb_device = .init();

    var old: u64 = time.get_time_since_boot().to_us();
    var new: u64 = 0;

    while (true) {
        // You can now poll for USB events
        usb_device.poll(&usb_controller);

        // Ensure that the host as finished enumerating our USB device
        if (usb_controller.drivers()) |_| {
            new = time.get_time_since_boot().to_us();
            if (new - old > 500_000) {
                old = new;
                pins.led.toggle();
            }
        }
    }
}
