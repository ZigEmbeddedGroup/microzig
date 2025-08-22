//! USB HID
//!
//! ## Interfaces
//!
//! HID class devices use Control and Interrupt pipes for communication
//!
//! 1. Control for USB control and data classes, reports, data from host
//! 2. Interrupt for asynchronous and low latency data to the device
//!
//! ## Settings
//!
//! ### UsbInterfaceDescriptor related settings:
//! The class type for a HID class device is defined by the Interface descriptor.
//! The subclass field is used to identify Boot Devices.
//!
//! * `interface_subclass` - 1 if boot interface, 0 else (most of the time)
//! * `interface_protocol` - 0 if no boot interface, 1 if keyboard boot interface, 2 if mouse BI
//!
//! ## Nice to know
//!
//! The host usually won't ask for the HID descriptor even if the other descriptors
//! indicate that the given device is a HID device, i. e., you should just pass the
//! HID descriptor together with the configuration descriptor.
//!
//! ## Descriptors
//!
//! ### Report
//!
//! A Report descriptor describes each piece of data that the device generates
//! and what the data is actually measuring (e.g., position or button state). The
//! descriptor consists of one or more items and answers the following questions:
//!
//! 1. Where should the input be routed to (e.g., mouse or joystick API)?
//! 2. Should the software assign a functionality to the input?
//!
//! ### Physical
//!
//! ...
//!
//! ### HID
//!
//! The HID descriptor identifies the length and type of subordinate descriptors for device.

const std = @import("std");
const enumFromInt = std.meta.intToEnum;

const usb = @import("../usb.zig");
const descriptor = usb.descriptor;
const types = usb.types;
const bos = usb.utils.BosConfig;

pub const InDescriptor = extern struct {
    desc1: descriptor.Interface,
    desc2: descriptor.hid.Hid,
    desc3: descriptor.Endpoint,

    fn create(first_interface: u8, string_index: u8, boot_protocol: u8, report_desc_len: u16, endpoint_in: types.Endpoint.Num, endpoint_size: u16, endpoint_interval: u16) @This() {
        return .{
            .desc1 = .{
                .interface_number = first_interface,
                .alternate_setting = 0,
                .num_endpoints = 1,
                .interface_class = 3,
                .interface_subclass = if (boot_protocol > 0) 1 else 0,
                .interface_protocol = boot_protocol,
                .interface_s = string_index,
            },
            .desc2 = .{
                .bcd_hid = .from(0x0111),
                .country_code = 0,
                .num_descriptors = 1,
                .report_length = .from(report_desc_len),
            },
            .desc3 = .{
                .endpoint = .in(endpoint_in),
                .attributes = .{ .transfer_type = .Interrupt, .usage = .data },
                .max_packet_size = endpoint_size,
                .interval = endpoint_interval,
            },
        };
    }
};

pub const InOutDescriptor = extern struct {
    interface: descriptor.Interface,
    hid: descriptor.hid.Hid,
    ep_out: descriptor.Endpoint,
    ep_in: descriptor.Endpoint,

    fn create(first_interface: u8, string_index: u8, boot_protocol: u8, report_desc_len: u16, endpoint_out: types.Endpoint.Num, endpoint_in: types.Endpoint.Num, endpoint_size: u16, endpoint_interval: u16) @This() {
        return .{
            .interface = .{
                .interface_number = first_interface,
                .alternate_setting = 0,
                .num_endpoints = 2,
                .interface_class = 3,
                .interface_subclass = if (boot_protocol > 0) 1 else 0,
                .interface_protocol = boot_protocol,
                .interface_s = string_index,
            },
            .hid = .{
                .bcd_hid = .from(0x0111),
                .country_code = 0,
                .num_descriptors = 1,
                .report_length = .from(report_desc_len),
            },
            .ep_out = .{
                .endpoint = .out(endpoint_out),
                .attributes = .{ .transfer_type = .Interrupt, .usage = .data },
                .max_packet_size = .from(endpoint_size),
                .interval = endpoint_interval,
            },
            .ep_in = .{
                .endpoint = .in(endpoint_in),
                .attributes = .{ .transfer_type = .Interrupt, .usage = .data },
                .max_packet_size = .from(endpoint_size),
                .interval = endpoint_interval,
            },
        };
    }
};

pub const HidClassDriver = struct {
    pub const num_interfaces = 1;

    ep_in: types.Endpoint.Num = .ep0,
    ep_out: types.Endpoint.Num = .ep0,
    hid_descriptor: []const u8 = &.{},
    report_descriptor: []const u8,

    pub fn config_descriptor(first_interface: u8, string_ids: anytype, endpoints: anytype) InOutDescriptor {
        return .create(
            first_interface,
            string_ids.name,
            0,
            descriptor.hid.report.GenericInOut.len,
            endpoints.main,
            endpoints.main,
            64,
            0,
        );
    }

    /// This function is called when the host chooses a configuration that contains this driver.
    pub fn init(_: usb.DeviceInterface, desc: *const InOutDescriptor) @This() {
        return .{
            .hid_descriptor = std.mem.asBytes(&desc.hid),
            .report_descriptor = undefined,
            .ep_in = desc.ep_in.endpoint.num,
            .ep_out = desc.ep_out.endpoint.num,
        };
    }

    pub fn interface_setup(ptr: *@This(), setup: *const types.SetupPacket) ?[]const u8 {
        const self: *@This() = @ptrCast(@alignCast(ptr));

        switch (setup.request_type.type) {
            .Standard => {
                const hid_desc_type = enumFromInt(descriptor.hid.SubType, (setup.value >> 8) & 0xff) catch return null;
                const request_code = enumFromInt(types.SetupRequest, setup.request) catch return null;

                if (request_code != .GetDescriptor) return usb.ACK;

                const data = switch (hid_desc_type) {
                    .Hid => self.hid_descriptor,
                    .Report => self.report_descriptor,
                    else => return null,
                };

                return data[0..@min(data.len, setup.length)];
            },
            .Class => return switch (enumFromInt(
                descriptor.hid.RequestType,
                setup.request,
            ) catch return null) {
                // TODO: The host is attempting to limit bandwidth by requesting that
                // the device only return report data when its values actually change,
                // or when the specified duration elapses. In practice, the device can
                // still send reports as often as it wants, but for completeness this
                // should be implemented eventually.
                //
                // https://github.com/ZigEmbeddedGroup/microzig/issues/454
                .SetIdle => usb.ACK,

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
                .SetProtocol => usb.ACK,

                // TODO: This request sends a feature or output report to the device,
                // e.g. turning on the caps lock LED. This must be handled in an
                // application-specific way, so notify the application code of the event.
                //
                // https://github.com/ZigEmbeddedGroup/microzig/issues/454
                .SetReport => usb.ACK,
                else => null,
            },
            else => return null,
        }
        return usb.ACK;
    }

    pub fn on_tx_ready(_: *@This(), _: usb.DeviceInterface, _: []u8) void {}
    pub fn on_data_rx(_: *@This(), _: usb.DeviceInterface, _: []const u8) void {}
};
