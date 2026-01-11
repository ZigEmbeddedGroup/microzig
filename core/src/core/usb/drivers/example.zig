const std = @import("std");
const usb = @import("../../usb.zig");
const descriptor = usb.descriptor;

pub const ExampleDriver = struct {
    /// The descriptors need to have the same memory layout as the sent data.
    pub const Descriptor = extern struct {
        example_interface: descriptor.Interface,
        ep_in1: descriptor.Endpoint,
        ep_in2: descriptor.Endpoint,
        ep_out: descriptor.Endpoint,

        /// This function is used during descriptor creation. If multiple instances
        /// of a driver are used, a descriptor will be created for each.
        pub fn create(
            first_interface: u8,
            first_string: u8,
            first_endpoint_in: u4,
            first_endpoint_out: u4,
        ) @This() {
            return .{
                .example_interface = .{
                    .interface_number = first_interface,
                    .alternate_setting = 0,
                    .num_endpoints = 3,
                    .interface_class = 0,
                    .interface_subclass = 0,
                    .interface_protocol = 0,
                    .interface_s = first_string,
                },
                .ep_in1 = .{
                    .endpoint = .in(@enumFromInt(first_endpoint_in)),
                    .attributes = .interrupt,
                    .max_packet_size = .from(64),
                    .interval = 16,
                },
                .ep_in2 = .{
                    .endpoint = .in(@enumFromInt(first_endpoint_in + 1)),
                    .attributes = .bulk,
                    .max_packet_size = .from(64),
                    .interval = 0,
                },
                .ep_out = .{
                    .endpoint = .out(@enumFromInt(first_endpoint_out)),
                    .attributes = .bulk,
                    .max_packet_size = .from(64),
                    .interval = 0,
                },
            };
        }
    };

    /// This is a mapping from endpoint descriptor field names
    /// to handler function names.
    pub const handlers = .{
        .ep_in1 = "handler1",
        .ep_in2 = "handler2",
        .ep_out = "handler3",
    };

    /// This function is called when the host chooses a configuration
    /// that contains this driver.
    pub fn init(desc: *const Descriptor, device: *usb.DeviceInterface) @This() {
        defer device.ep_listen(desc.ep_out.endpoint.num, 64);
        return .{};
    }

    /// Used for configuration through endpoint 0.
    /// Data returned by this function is sent on endpoint 0.
    pub fn class_control(self: *@This(), stage: usb.types.ControlStage, setup: *const usb.types.SetupPacket) ?[]const u8 {
        _ = self;
        _ = setup;
        if (stage == .Setup)
            return usb.ack
        else
            return usb.nak;
    }

    /// Each endpoint (as defined in the descriptor) has its own handler.
    /// Endpoint number is passed as an argument so that it does not need
    /// to be stored in the driver.
    pub fn handler1(self: *@This(), ep_num: usb.types.Endpoint.Num) void {
        _ = self;
        _ = ep_num;
    }

    pub fn handler2(self: *@This(), ep_num: usb.types.Endpoint.Num) void {
        _ = self;
        _ = ep_num;
    }

    pub fn handler3(self: *@This(), ep_num: usb.types.Endpoint.Num) void {
        _ = self;
        _ = ep_num;
    }
};
