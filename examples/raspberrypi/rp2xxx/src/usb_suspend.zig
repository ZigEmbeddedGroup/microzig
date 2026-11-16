const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const usb = microzig.core.usb;

const Deadline = microzig.drivers.time.Deadline;

// Port-specific type which implements the DeviceInterface interface, used by the USB core to
// read from/write to the peripheral.
const USB_Device = rp2xxx.usb.Polled(.{});

var usb_device: USB_Device = undefined;

// Generate a device controller with descriptor and handler sfor the picotool-controlled reset (ResetDriver).
var usb_controller: usb.DeviceController(.{
    .device_triple = .unspecified,
    .bcd_device = .v1_00,
    .serial = "someserial",
    .device_capabilities = USB_Device.device_capabilities,
    .on_suspend = on_suspend,
    .on_resume = on_resume,
}, &.{usb.Configuration(
    .{
        .attributes = .{
            .self_powered = false,
            // this is required so the usb stack responds to DeviceRemoteWakeup set/clear feature
            // from the host
            .can_remote_wakeup = true,
        },
        .max_current_ma = 50,
    },
    .{
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
    .logFn = rp2xxx.uart.log,
});

pub const panic = microzig.panic;

comptime {
    _ = microzig.export_startup();
}

const pin_config = microzig.board.pin_config;

var wakeup_deadline: ?Deadline = null;
fn on_suspend() void {
    // try to wake up the host after 5 seconds.
    wakeup_deadline = rp2xxx.time.deadline_in_ms(5 * std.time.ms_per_s);
}

fn on_resume() void {
    wakeup_deadline = null;
}

pub fn main() !void {
    const pins = pin_config.apply();

    const uart = rp2xxx.uart.instance.num(0);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    pins.led.put(1);

    // Then initialize the USB device using the configuration defined above
    usb_device = .init();

    var led_deadline: Deadline = time.deadline_in_ms(500);

    while (true) {
        // You can now poll for USB events
        usb_device.poll(&usb_controller);

        if (wakeup_deadline) |deadline| {
            if (deadline.is_reached_by(rp2xxx.time.get_time_since_boot())) {
                // try to wake up the host
                usb_controller.remote_wakeup(&usb_device.interface) catch |err| switch (err) {
                    error.NotSupported => unreachable,
                    error.NotEnabledByHost => {
                        std.log.warn("Host didn't enabled remote wakeup", .{});
                        // on succesfull remote_wakeup it is guranteed that on_resume will be called
                        // but in the case of error.NotEnabledByHost let's disable it manually, so we don't spam the host
                        wakeup_deadline = null;
                    },
                    error.NotConfigured => unreachable, // on_suspend guarantee that the controller is already configured
                    error.NotSuspended => unreachable, // the deadline is disabled in on_resume, so we whould never hit this
                };
            }
        }

        if (usb_controller.suspended()) {
            // do something when the device is suspended
        }

        // Ensure that the host has finished enumerating our USB device
        if (usb_controller.drivers()) |_| {
            if (led_deadline.is_reached_by(time.get_time_since_boot())) {
                led_deadline = time.deadline_in_ms(500);
                pins.led.toggle();
            }
        }
    }
}
