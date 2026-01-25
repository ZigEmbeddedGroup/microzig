const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const usb = microzig.core.usb;
const USB_Device = rp2xxx.usb.Polled(.{});

pub const Modifiers = packed struct(u8) {
    lctrl: bool,
    lshift: bool,
    lalt: bool,
    lgui: bool,
    rctrl: bool,
    rshift: bool,
    ralt: bool,
    rgui: bool,

    pub const none: @This() = @bitCast(@as(u8, 0));
};

pub const Code = enum(u8) {
    // Codes taken from https://gist.github.com/mildsunrise/4e231346e2078f440969cdefb6d4caa3
    // zig fmt: off
    reserved = 0x00, error_roll_over, post_fail, error_undefined,
    a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z,
    top_1, top_2, top_3, top_4, top_5, top_6, top_7, top_8, top_9, top_0,
    enter, escape, delete, tab, space,
    @"-", @"=", @"[", @"]", @"\\", @"non_us_#", @";", @"'", @"`", @",", @".", @"/",
    caps_lock,
    f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12,
    print_screen, scroll_lock, pause, insert, home, page_up, delete_forward, end, page_down,
    right_arrow, left_arrow, down_arrow, up_arrow, num_lock,
    kpad_div, kpad_mul, kpad_sub, kpad_add, kpad_enter,
    kpad_1, kpad_2, kpad_3, kpad_4, kpad_5, kpad_6, kpad_7, kpad_8, kpad_9, kpad_0,
    kpad_delete, @"non_us_\\", application, power, @"kpad_=",
    f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24,
    lctrl = 224, lshift, lalt, lgui, rctrl, rshift, ralt, rgui,
    // zig fmt: on
    _,
};

pub const KeyboardReport = extern struct {
    modifiers: Modifiers,
    reserved: u8 = 0,
    keys: [6]Code,

    comptime {
        std.debug.assert(@sizeOf(@This()) == 8);
    }

    pub const empty: @This() = .{ .modifiers = .none, .keys = @splat(.reserved) };
};

const hid = usb.descriptor.hid;

const Keyboard = usb.drivers.hid.InInterruptDriver(.{
    .subclass = .Boot,
    .protocol = .Boot,
    .report_descriptor = &.{
        .{ .global_usage_page = .desktop },
        .{ .local_usage = hid.DesktopUsage.keyboard[0] },
        .{ .main_collection = .Application },
        // Input: modifier key bitmap
        .{ .data = .{
            .usage = .{ .global_page = .keyboard },
            .usage_range = .{ 0xE0, 0xE7 },
            .count = 8,
            .Child = bool,
            .dir = .In,
            .type = .dynamic,
        } },
        // Reserved 8 bits
        .{ .data_static = .{ .In, u8 } },
        // Output: indicator LEDs
        .{ .data = .{
            .usage = .{ .global_page = .led },
            .usage_range = .{ 1, 5 },
            .count = 5,
            .Child = bool,
            .dir = .Out,
            .type = .dynamic,
        } },
        // Padding
        .{ .data_static = .{ .Out, u3 } },
        // Input: up to 6 pressed key codes
        .{ .data = .{
            .usage = .{ .global_page = .keyboard },
            .usage_range = .{ 0x00, 0xff },
            .count = 6,
            .Child = u8,
            .dir = .In,
            .type = .selector,
        } },
        // End
        .main_collection_end,
    },
    .Report = KeyboardReport,
});

comptime {
    const fido = usb.drivers.hid.ReportItem.create_report(&.{
        .{ .global_usage_page = .fido },
        .{ .local_usage = hid.FidoAllianceUsage.u2fhid[0] },
        .{ .main_collection = .Application },
        .{ .data = .{
            .usage = .{ .local = hid.FidoAllianceUsage.data_in[0] },
            .count = 64,
            .Child = u8,
            .dir = .In,
            .type = .dynamic,
        } },
        .{ .data = .{
            .usage = .{ .local = hid.FidoAllianceUsage.data_out[0] },
            .count = 64,
            .Child = u8,
            .dir = .Out,
            .type = .dynamic,
        } },
        .main_collection_end,
    });

    const generic = usb.drivers.hid.ReportItem.create_report(&.{
        .{ .global_usage_page = .vendor },
        .{ .local_usage = 1 },
        .{ .main_collection = .Application },
        .{ .data = .{
            .usage = .{ .local = 2 },
            .count = 64,
            .Child = u8,
            .dir = .In,
            .type = .dynamic,
        } },
        .{ .data = .{
            .usage = .{ .local = 3 },
            .count = 64,
            .Child = u8,
            .dir = .Out,
            .type = .dynamic,
        } },
        .main_collection_end,
    });

    std.debug.assert(std.mem.eql(u8, generic, &hid.ReportDescriptorGenericInOut));
    std.debug.assert(std.mem.eql(u8, fido, &hid.ReportDescriptorFidoU2f));
    std.debug.assert(std.mem.eql(u8, Keyboard.report_descriptor, &hid.ReportDescriptorKeyboard));
}

var usb_device: USB_Device = undefined;

var usb_controller: usb.DeviceController(.{
    .bcd_usb = USB_Device.max_supported_bcd_usb,
    .device_triple = .unspecified,
    .vendor = USB_Device.default_vendor_id,
    .product = USB_Device.default_product_id,
    .bcd_device = .v1_00,
    .serial = "someserial",
    .max_supported_packet_size = USB_Device.max_supported_packet_size,
    .configurations = &.{.{
        .attributes = .{ .self_powered = false },
        .max_current_ma = 50,
        .Drivers = struct { keyboard: Keyboard, reset: rp2xxx.usb.ResetDriver(null, 0) },
    }},
}, .{.{
    .keyboard = .{ .itf_string = "Boot Keyboard", .poll_interval = 1 },
    .reset = "",
}}) = .init;

pub fn panic(message: []const u8, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    std.log.err("panic: {s}", .{message});
    @breakpoint();
    while (true) {}
}

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .log_scope_levels = &.{
        .{ .scope = .usb_dev, .level = .warn },
        .{ .scope = .usb_ctrl, .level = .warn },
        .{ .scope = .usb_hid, .level = .warn },
    },
    .logFn = rp2xxx.uart.log,
};

const pin_config: rp2xxx.pins.GlobalConfiguration = .{
    .GPIO0 = .{ .function = .UART0_TX },
    .GPIO25 = .{ .name = "led", .direction = .out },
};

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

    var old: u64 = time.get_time_since_boot().to_us();
    var new: u64 = 0;
    const message: []const Code = &.{ .h, .e, .l, .l, .o, .space, .w, .o, .r, .l, .d, .caps_lock, .enter };
    var idx: usize = 0;

    while (true) {
        // You can now poll for USB events
        usb_device.poll(&usb_controller);

        if (usb_controller.drivers()) |drivers| {
            new = time.get_time_since_boot().to_us();
            const time_since_last = new - old;
            if (time_since_last < 2_000_000) {
                idx += @intFromBool(if (idx & 1 == 0 and idx < 2 * message.len)
                    drivers.keyboard.send_report(
                        &.{ .modifiers = .none, .keys = .{message[@intCast(idx / 2)]} ++ .{.reserved} ** 5 },
                    )
                else
                    drivers.keyboard.send_report(&.empty));
            } else {
                old = new;
                idx = 0;
                pins.led.toggle();
            }
        }
    }
}
