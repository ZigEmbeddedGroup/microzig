const std = @import("std");
const usb = @import("../../usb.zig");
const assert = std.debug.assert;
const EP_Num = usb.types.Endpoint.Num;
const log = std.log.scoped(.usb_hid);

pub fn HidClassDriver(report_descriptor: anytype) type {
    return struct {
        pub const Descriptor = extern struct {
            const desc = usb.descriptor;

            interface: desc.Interface,
            hid: desc.hid.HID,
            ep_out: desc.Endpoint,
            ep_in: desc.Endpoint,

            pub const Options = struct {
                itf_string: []const u8 = "",
                boot_protocol: bool,
                poll_interval: u8,
            };

            pub fn create(
                alloc: *usb.DescriptorAllocator,
                max_supported_packet_size: usb.types.Len,
                options: Options,
            ) usb.DescriptorCreateResult(@This()) {
                return .{ .descriptor = .{
                    .interface = .{
                        .interface_number = alloc.next_itf(),
                        .alternate_setting = 0,
                        .num_endpoints = 2,
                        .interface_triple = .from(
                            .HID,
                            if (options.boot_protocol) .Boot else .Unspecified,
                            if (options.boot_protocol) .Boot else .None,
                        ),
                        .interface_s = alloc.string(options.itf_string),
                    },
                    .hid = hid_descriptor,
                    .ep_out = .interrupt(alloc.next_ep(.Out), max_supported_packet_size, options.poll_interval),
                    .ep_in = .interrupt(alloc.next_ep(.In), max_supported_packet_size, options.poll_interval),
                } };
            }
        };

        const hid_descriptor: usb.descriptor.hid.HID = .{
            .bcd_hid = .from(0x0111),
            .country_code = .NotSupported,
            .num_descriptors = 1,
            .report_length = .from(@sizeOf(@TypeOf(report_descriptor))),
        };

        pub const handlers: usb.DriverHadlers(@This()) = .{
            .ep_out = on_rx,
            .ep_in = on_tx_ready,
        };

        device: *usb.DeviceInterface,
        descriptor: *const Descriptor,

        pub fn init(self: *@This(), desc: *const Descriptor, device: *usb.DeviceInterface, data: []const u8) void {
            assert(data.len == 0);
            self.* = .{
                .device = device,
                .descriptor = desc,
            };
        }

        pub fn class_request(self: *@This(), setup: *const usb.types.SetupPacket) ?[]const u8 {
            _ = self;
            switch (setup.request_type.type) {
                .Standard => {
                    const hid_desc_type: usb.descriptor.hid.HID.Type = @enumFromInt(setup.value.into() >> 8);
                    const request_code: usb.types.SetupRequest = @enumFromInt(setup.request);

                    if (request_code == .GetDescriptor and hid_desc_type == .HID)
                        return std.mem.asBytes(&hid_descriptor)
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
            _ = self;
            _ = ep;
        }

        pub fn on_rx(self: *@This(), ep: EP_Num) void {
            _ = self;
            _ = ep;
        }
    };
}
