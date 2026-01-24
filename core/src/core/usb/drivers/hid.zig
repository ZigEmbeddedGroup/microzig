const std = @import("std");
const usb = @import("../../usb.zig");
const assert = std.debug.assert;
const EP_Num = usb.types.Endpoint.Num;
const log = std.log.scoped(.usb_hid);

pub const KeyboardOptions = struct {
    boot_protocol: bool = true,
};

pub fn Keyboard(options: KeyboardOptions) type {
    return struct {
        pub const report_descriptor = usb.descriptor.hid.ReportDescriptorKeyboard;

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
                @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0",
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

        pub const Report = extern struct {
            modifiers: Modifiers,
            reserved: u8 = 0,
            keys: [6]Code,

            comptime {
                assert(@sizeOf(@This()) == 8);
            }

            pub const empty: @This() = .{ .modifiers = .none, .keys = @splat(.reserved) };
        };

        pub const Descriptor = extern struct {
            const desc = usb.descriptor;

            interface: desc.Interface,
            hid: desc.hid.HID,
            ep_in: desc.Endpoint,

            pub const Options = struct {
                itf_string: []const u8 = "",
                poll_interval: u8,
            };

            pub fn create(
                alloc: *usb.DescriptorAllocator,
                max_supported_packet_size: usb.types.Len,
                desc_options: Options,
            ) usb.DescriptorCreateResult(@This()) {
                _ = max_supported_packet_size;
                return .{ .descriptor = .{
                    .interface = .{
                        .interface_number = alloc.next_itf(),
                        .alternate_setting = 0,
                        .num_endpoints = 1,
                        .interface_triple = .from(
                            .HID,
                            if (options.boot_protocol) .Boot else .Unspecified,
                            if (options.boot_protocol) .Boot else .None,
                        ),
                        .interface_s = alloc.string(desc_options.itf_string),
                    },
                    .hid = .{
                        .bcd_hid = .from(0x0111),
                        .country_code = .NotSupported,
                        .num_descriptors = 1,
                        .report_length = .from(@sizeOf(@TypeOf(report_descriptor))),
                    },
                    .ep_in = .interrupt(
                        alloc.next_ep(.In),
                        if (options.boot_protocol) 8 else unreachable,
                        desc_options.poll_interval,
                    ),
                } };
            }
        };

        pub const handlers: usb.DriverHadlers(@This()) = .{
            .ep_in = on_tx_ready,
        };

        device: *usb.DeviceInterface,
        descriptor: *const Descriptor,
        tx_ready: std.atomic.Value(bool),

        pub fn init(self: *@This(), desc: *const Descriptor, device: *usb.DeviceInterface, data: []const u8) void {
            log.debug("Keyboard init", .{});
            assert(data.len == 0);
            self.* = .{
                .device = device,
                .descriptor = desc,
                .tx_ready = .init(true),
            };
        }

        pub fn class_request(self: *@This(), setup: *const usb.types.SetupPacket) ?[]const u8 {
            switch (setup.request_type.type) {
                .Standard => {
                    const hid_desc_type: usb.descriptor.hid.HID.Type = @enumFromInt(setup.value.into() >> 8);
                    const request_code: usb.types.SetupRequest = @enumFromInt(setup.request);

                    if (request_code == .GetDescriptor and hid_desc_type == .HID)
                        return std.mem.asBytes(&self.descriptor.hid)
                    else if (request_code == .GetDescriptor and hid_desc_type == .Report)
                        return std.mem.asBytes(&report_descriptor);
                },
                .Class => {
                    const hid_request_type: usb.descriptor.hid.RequestType = @enumFromInt(setup.request);
                    switch (hid_request_type) {
                        .SetIdle => {
                            // TODO: https://github.com/ZigEmbeddedGroup/microzig/issues/454
                            // The host is attempting to limit bandwidth by requesting that
                            // the device only return report data when its values actually change,
                            // or when the specified duration elapses. In practice, the device can
                            // still send reports as often as it wants, but for completeness this
                            // should be implemented eventually.
                            //
                            return usb.ack;
                        },
                        .SetProtocol => {
                            // TODO: https://github.com/ZigEmbeddedGroup/microzig/issues/454
                            // The device should switch the format of its reports from the boot
                            // keyboard/mouse protocol to the format described in its report descriptor,
                            // or vice versa.
                            //
                            // For now, this request is ACKed without doing anything; in practice,
                            // the OS will reuqest the report protocol anyway, so usually only one format is needed.
                            // Unless the report format matches the boot protocol exactly (see ReportDescriptorKeyboard),
                            // our device might not work in a limited BIOS environment.
                            //
                            return usb.ack;
                        },
                        .SetReport => {
                            // TODO: https://github.com/ZigEmbeddedGroup/microzig/issues/454
                            // This request sends a feature or output report to the device,
                            // e.g. turning on the caps lock LED. This must be handled in an
                            // application-specific way, so notify the application code of the event.
                            //
                            return usb.ack;
                        },
                        else => {},
                    }
                },
                else => {},
            }
            return usb.nak;
        }

        pub fn on_tx_ready(self: *@This(), ep: EP_Num) void {
            log.debug("tx ready ({t})", .{ep});
            self.tx_ready.store(true, .seq_cst);
        }

        pub fn send_report(self: *@This(), report: *const Report) bool {
            if (!self.tx_ready.load(.seq_cst)) return false;

            self.tx_ready.store(false, .seq_cst);

            const len = self.device.ep_writev(
                self.descriptor.ep_in.endpoint.num,
                &.{std.mem.asBytes(report)},
            );

            log.debug("sent report {} {any}", .{ len, report });

            return true;
        }
    };
}
