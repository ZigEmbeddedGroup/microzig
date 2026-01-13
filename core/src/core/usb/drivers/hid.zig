const std = @import("std");
const usb = @import("../../usb.zig");
const descriptor = usb.descriptor;
const types = usb.types;

pub const Options = struct {
    boot_protocol: bool,
    poll_interval: u8,
};

pub fn HidClassDriver(options: Options, report_descriptor: anytype) type {
    return struct {
        pub const Descriptor = extern struct {
            interface: descriptor.Interface,
            hid: descriptor.hid.Hid,
            ep_out: descriptor.Endpoint,
            ep_in: descriptor.Endpoint,

            pub fn create(
                alloc: *usb.DescriptorAllocator,
                first_string: u8,
                max_supported_packet_size: usb.types.Len,
            ) @This() {
                return .{
                    .interface = .{
                        .interface_number = alloc.next_itf(),
                        .alternate_setting = 0,
                        .num_endpoints = 2,
                        .interface_triple = .from(
                            .Hid,
                            if (options.boot_protocol) .Boot else .Unspecified,
                            if (options.boot_protocol) .Boot else .None,
                        ),
                        .interface_s = first_string,
                    },
                    .hid = hid_descriptor,
                    .ep_out = .interrupt(alloc.next_ep(.Out), max_supported_packet_size, options.poll_interval),
                    .ep_in = .interrupt(alloc.next_ep(.In), max_supported_packet_size, options.poll_interval),
                };
            }
        };

        const hid_descriptor: descriptor.hid.Hid = .{
            .bcd_hid = .from(0x0111),
            .country_code = .NotSupported,
            .num_descriptors = 1,
            .report_length = .from(@sizeOf(@TypeOf(report_descriptor))),
        };

        pub const handlers = .{
            .ep_out = "on_rx",
            .ep_in = "on_tx_ready",
        };

        device: *usb.DeviceInterface,
        ep_in: types.Endpoint.Num,
        ep_out: types.Endpoint.Num,

        pub fn init(self: *@This(), desc: *const Descriptor, device: *usb.DeviceInterface) void {
            self.* = .{
                .device = device,
                .ep_in = desc.ep_in.endpoint.num,
                .ep_out = desc.ep_out.endpoint.num,
            };
        }

        pub fn class_control(self: *@This(), stage: types.ControlStage, setup: *const types.SetupPacket) ?[]const u8 {
            _ = self;
            if (stage == .Setup) switch (setup.request_type.type) {
                .Standard => {
                    const hid_desc_type = std.meta.intToEnum(descriptor.hid.Hid.Type, setup.value.into() >> 8) catch return usb.nak;
                    const request_code = std.meta.intToEnum(types.SetupRequest, setup.request) catch return usb.nak;

                    if (request_code == .GetDescriptor and hid_desc_type == .Hid)
                        return @as([]const u8, @ptrCast(&hid_descriptor))
                    else if (request_code == .GetDescriptor and hid_desc_type == .Report)
                        return @as([]const u8, @ptrCast(&report_descriptor));
                },
                .Class => {
                    const hid_request_type = std.meta.intToEnum(descriptor.hid.RequestType, setup.request) catch return usb.nak;
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
            };
            return usb.nak;
        }

        pub fn on_tx_ready(self: *@This(), ep: types.Endpoint.Num) void {
            _ = self;
            _ = ep;
        }

        pub fn on_rx(self: *@This(), ep: types.Endpoint.Num) void {
            _ = self;
            _ = ep;
        }
    };
}
