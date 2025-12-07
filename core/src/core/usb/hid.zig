const std = @import("std");
const usb = @import("../usb.zig");
const descriptor = usb.descriptor;
const types = usb.types;

pub const Options = struct {
    max_packet_size: u16,
    boot_protocol: bool,
    endpoint_interval: u8,
};

pub fn HidClassDriver(options: Options, report_descriptor: anytype) type {
    return struct {
        pub const Descriptor = extern struct {
            interface: descriptor.Interface,
            hid: descriptor.hid.Hid,
            ep_out: descriptor.Endpoint,
            ep_in: descriptor.Endpoint,

            pub fn create(
                first_interface: u8,
                string_ids: anytype,
                endpoints: anytype,
            ) @This() {
                return .{
                    .interface = .{
                        .interface_number = first_interface,
                        .alternate_setting = 0,
                        .num_endpoints = 2,
                        .interface_class = 3,
                        .interface_subclass = @intFromBool(options.boot_protocol),
                        .interface_protocol = @intFromBool(options.boot_protocol),
                        .interface_s = string_ids.name,
                    },
                    .hid = hid_descriptor,
                    .ep_out = .{
                        .endpoint = .out(endpoints.out),
                        .attributes = .{ .transfer_type = .Interrupt, .usage = .data },
                        .max_packet_size = .from(options.max_packet_size),
                        .interval = options.endpoint_interval,
                    },
                    .ep_in = .{
                        .endpoint = .in(endpoints.in),
                        .attributes = .{ .transfer_type = .Interrupt, .usage = .data },
                        .max_packet_size = .from(options.max_packet_size),
                        .interval = options.endpoint_interval,
                    },
                };
            }
        };

        const hid_descriptor: descriptor.hid.Hid = .{
            .bcd_hid = .from(0x0111),
            .country_code = .NotSupported,
            .num_descriptors = 1,
            .report_length = .from(@sizeOf(@TypeOf(report_descriptor))),
        };

        device: types.UsbDevice,
        ep_in: u8,
        ep_out: u8,

        pub fn init(desc: *const Descriptor, device: types.UsbDevice) @This() {
            return .{
                .device = device,
                .ep_in = @bitCast(desc.ep_in.endpoint),
                .ep_out = @bitCast(desc.ep_out.endpoint),
            };
        }

        fn class_control(ptr: *anyopaque, stage: types.ControlStage, setup: *const types.SetupPacket) bool {
            var self: *@This() = @ptrCast(@alignCast(ptr));

            switch (setup.request_type.type) {
                .Standard => {
                    if (stage == .Setup) {
                        const hid_desc_type = std.meta.intToEnum(descriptor.hid.Hid.Type, (setup.value >> 8) & 0xff) catch return false;
                        const request_code = std.meta.intToEnum(types.SetupRequest, setup.request) catch return false;

                        if (request_code == .GetDescriptor and hid_desc_type == .Hid) {
                            self.device.control_transfer(setup, @ptrCast(&hid_descriptor));
                        } else if (request_code == .GetDescriptor and hid_desc_type == .Report) {
                            self.device.control_transfer(setup, @ptrCast(&report_descriptor));
                        } else {
                            return false;
                        }
                    }
                },
                .Class => {
                    const hid_request_type = std.meta.intToEnum(descriptor.hid.RequestType, setup.request) catch return false;
                    switch (hid_request_type) {
                        .SetIdle => {
                            if (stage == .Setup) {
                                // TODO: The host is attempting to limit bandwidth by requesting that
                                // the device only return report data when its values actually change,
                                // or when the specified duration elapses. In practice, the device can
                                // still send reports as often as it wants, but for completeness this
                                // should be implemented eventually.
                                //
                                // https://github.com/ZigEmbeddedGroup/microzig/issues/454
                                self.device.control_transfer(setup, usb.ack);
                            }
                        },
                        .SetProtocol => {
                            if (stage == .Setup) {
                                // TODO: The device should switch the format of its reports from the
                                // boot keyboard/mouse protocol to the format described in its report descriptor,
                                // or vice versa.
                                //
                                // For now, this request is ACKed without doing anything; in practice,
                                // the OS will reuqest the report protocol anyway, so usually only one format is needed.
                                // Unless the report format matches the boot protocol exactly (see ReportDescriptorKeyboard),
                                // our device might not work in a limited BIOS environment.
                                //
                                // https://github.com/ZigEmbeddedGroup/microzig/issues/454
                                self.device.control_transfer(setup, usb.ack);
                            }
                        },
                        .SetReport => {
                            if (stage == .Setup) {
                                // TODO: This request sends a feature or output report to the device,
                                // e.g. turning on the caps lock LED. This must be handled in an
                                // application-specific way, so notify the application code of the event.
                                //
                                // https://github.com/ZigEmbeddedGroup/microzig/issues/454
                                self.device.control_transfer(setup, usb.ack);
                            }
                        },
                        else => {
                            return false;
                        },
                    }
                },
                else => {
                    return false;
                },
            }

            return true;
        }

        fn transfer(_: *anyopaque, _: types.Endpoint, _: []u8) void {}

        pub fn driver(self: *@This()) types.UsbClassDriver {
            return .{
                .ptr = self,
                .fn_class_control = class_control,
                .fn_transfer = transfer,
            };
        }
    };
}
