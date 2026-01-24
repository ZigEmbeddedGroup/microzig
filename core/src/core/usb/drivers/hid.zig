const std = @import("std");
const usb = @import("../../usb.zig");
const assert = std.debug.assert;

const ClassCode = usb.types.ClassSubclassProtocol.ClassCode.HID;

pub const InInterruptOptions = struct {
    subclass: ClassCode.Subclass(),
    protocol: ClassCode.Protocol(),
    Report: type,
    report_descriptor: []const u8,
};

/// HID reports over a single IN endpoint
pub fn InInterruptDriver(options: InInterruptOptions) type {
    const log = std.log.scoped(.usb_hid_int_driver);

    return struct {
        pub const RequestType = enum(u8) {
            GetReport = 0x01,
            GetIdle = 0x02,
            GetProtocol = 0x03,
            SetReport = 0x09,
            SetIdle = 0x0a,
            SetProtocol = 0x0b,
            _,
        };

        const Report = options.Report;

        pub const Descriptor = extern struct {
            const desc = usb.descriptor;

            interface: desc.Interface,
            hid: desc.HID,
            ep_in: desc.Endpoint,

            pub const Options = struct {
                itf_string: []const u8 = "",
                poll_interval: u8,
                country_code: desc.HID.CountryCode = .NotSupported,
            };

            pub fn create(
                alloc: *usb.DescriptorAllocator,
                max_supported_packet_size: usb.types.Len,
                desc_options: Options,
            ) usb.DescriptorCreateResult(@This()) {
                assert(@sizeOf(Report) <= max_supported_packet_size);
                return .{ .descriptor = .{
                    .interface = .{
                        .interface_number = alloc.next_itf(),
                        .alternate_setting = 0,
                        .num_endpoints = 1,
                        .interface_triple = .from(.HID, options.subclass, options.protocol),
                        .interface_s = alloc.string(desc_options.itf_string),
                    },
                    .hid = .{
                        .country_code = desc_options.country_code,
                        .num_descriptors = 1,
                        .report_length = .from(options.report_descriptor.len),
                    },
                    .ep_in = .interrupt(
                        alloc.next_ep(.In),
                        @sizeOf(Report),
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
            log.debug("InInterruptDriver init", .{});
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
                    const hid_desc_type: usb.descriptor.HID.CsType = @enumFromInt(setup.value.into() >> 8);
                    const request_code: usb.types.SetupRequest = @enumFromInt(setup.request);

                    if (request_code == .GetDescriptor and hid_desc_type == .HID)
                        return std.mem.asBytes(&self.descriptor.hid)
                    else if (request_code == .GetDescriptor and hid_desc_type == .Report)
                        return options.report_descriptor;
                },
                .Class => {
                    const hid_request_type: RequestType = @enumFromInt(setup.request);
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

        pub fn on_tx_ready(self: *@This(), ep: usb.types.Endpoint.Num) void {
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
