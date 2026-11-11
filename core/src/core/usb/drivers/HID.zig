const std = @import("std");
const usb = @import("../../usb.zig");
const assert = std.debug.assert;
const log = std.log.scoped(.usb_hid_int_driver);

const Driver = @This();

pub const Descriptor = extern struct {
    const desc = usb.descriptor;

    interface: desc.Interface,
    hid: desc.HID,
    ep_out: desc.Endpoint,
    ep_in: desc.Endpoint,
};

/// HID Driver with an IN and OUT endpoint
pub fn Runtime(InReport: type, OutReport: type, report_descriptor: []const u8) type {
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

        pub const handlers: usb.DriverHandlers(Descriptor, @This()) = .{
            .ep_in = on_tx_ready,
            .ep_out = on_rx,
        };

        device: *usb.DeviceInterface,
        descriptor: *const Descriptor,
        tx_ready: std.atomic.Value(bool),
        rx_ready: std.atomic.Value(bool),

        pub fn init(
            self: *@This(),
            _: Driver,
            descriptor: *const Descriptor,
            device: *usb.DeviceInterface,
        ) void {
            log.debug("init", .{});
            self.* = .{
                .device = device,
                .descriptor = descriptor,
                .tx_ready = .init(true),
                .rx_ready = .init(false),
            };
            device.ep_listen(
                descriptor.ep_out.endpoint.num,
                @intCast(descriptor.ep_out.max_packet_size.native()),
            );
        }

        pub fn class_request(self: *@This(), setup: *const usb.types.SetupPacket) ?[]const u8 {
            log.debug("class_request {any}", .{setup});
            switch (setup.request_type.type) {
                .standard => {
                    const hid_desc_type: usb.descriptor.HID.CsType = @fromBackingInt(@intCast(setup.value.native() >> 8));
                    const request_code: usb.types.SetupRequest = @fromBackingInt(setup.request);

                    if (request_code == .get_descriptor and hid_desc_type == .HID)
                        return std.mem.asBytes(&self.descriptor.hid)
                    else if (request_code == .get_descriptor and hid_desc_type == .Report)
                        return report_descriptor;
                },
                .class => {
                    const hid_request_type: RequestType = @fromBackingInt(setup.request);
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

        pub fn on_rx(self: *@This(), ep: usb.types.Endpoint.Num) void {
            log.debug("rx ({t})", .{ep});
            self.rx_ready.store(true, .seq_cst);
        }

        pub fn send_report(self: *@This(), report: *const InReport) bool {
            if (!self.tx_ready.load(.seq_cst)) return false;

            self.tx_ready.store(false, .seq_cst);

            const len = self.device.ep_writev(
                self.descriptor.ep_in.endpoint.num,
                &.{std.mem.asBytes(report)},
            );

            log.debug("sent report {} {any}", .{ len, report });

            return true;
        }

        pub fn receive_report(self: *@This()) ?OutReport {
            if (!self.rx_ready.load(.seq_cst)) return null;

            self.rx_ready.store(false, .seq_cst);

            var report: OutReport = undefined;
            const ep_num = self.descriptor.ep_out.endpoint.num;
            const len = self.device.ep_readv(ep_num, &.{std.mem.asBytes(&report)});
            self.device.ep_listen(ep_num, @intCast(self.descriptor.ep_out.max_packet_size.native()));

            log.debug("received report {} {any}", .{ len, report });

            return report;
        }
    };
}

const ClassCode = usb.types.ClassSubclassProtocol.ClassCode.HID;

subclass: ClassCode.Subclass(),
protocol: ClassCode.Protocol(),

itf_string: []const u8 = "",
poll_interval: u8,
country_code: usb.descriptor.HID.CountryCode = .NotSupported,
report_descriptor: []const usb.HID_report.Item,
InReport: type,
OutReport: type,

pub fn driver_info(
    comptime self: Driver,
    comptime device_capabilities: usb.DeviceCapabilities,
    alloc: *usb.DescriptorAllocator,
) usb.DriverInfo(Descriptor) {
    assert(@sizeOf(self.InReport) <= device_capabilities.max_packet_size);
    assert(@sizeOf(self.OutReport) <= device_capabilities.max_packet_size);
    const report_descriptor = usb.HID_report.Item.create_report(self.report_descriptor);
    return .{
        .Runtime = Runtime(
            self.InReport,
            self.OutReport,
            report_descriptor,
        ),
        .descriptor = .{
            .interface = .{
                .interface_number = alloc.next_itf(),
                .alternate_setting = 0,
                .num_endpoints = 2,
                .interface_triple = .from(.HID, self.subclass, self.protocol),
                .interface_s = alloc.string(self.itf_string),
            },
            .hid = .{
                .country_code = self.country_code,
                .num_descriptors = 1,
                .report_length = .from(report_descriptor.len),
            },
            .ep_out = .interrupt(
                alloc.next_ep(.out),
                @sizeOf(self.OutReport),
                self.poll_interval,
            ),
            .ep_in = .interrupt(
                alloc.next_ep(.in),
                @sizeOf(self.InReport),
                self.poll_interval,
            ),
        },
    };
}
