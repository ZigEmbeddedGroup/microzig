const std = @import("std");
const usb = @import("../../usb.zig");
const log = std.log.scoped(.usb_echo);

/// This is an example driver that sends any data received on ep2 to ep1.
pub const EchoExampleDriver = struct {
    /// The descriptors need to have the same memory layout as the sent data.
    pub const Descriptor = extern struct {
        example_interface: usb.descriptor.Interface,
        ep_in: usb.descriptor.Endpoint,
        ep_out: usb.descriptor.Endpoint,

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
                    .num_endpoints = 2,
                    .interface_class = 0xFF,
                    .interface_subclass = 0xFF,
                    .interface_protocol = 0xFF,
                    .interface_s = first_string,
                },
                .ep_in = .{
                    .endpoint = .in(@enumFromInt(first_endpoint_in)),
                    .attributes = .bulk,
                    .max_packet_size = .from(64),
                    .interval = 0,
                },
                .ep_out = .{
                    .endpoint = .out(@enumFromInt(first_endpoint_out + 1)),
                    .attributes = .bulk,
                    .max_packet_size = .from(64),
                    .interval = 0,
                },
            };
        }
    };

    /// This is a mapping from endpoint descriptor field names to handler
    /// function names. Counterintuitively, usb devices send data on 'in'
    /// endpoints and receive on 'out' endpoints.
    pub const handlers = .{
        .ep_in = "on_tx_ready",
        .ep_out = "on_rx",
    };

    device: *usb.DeviceInterface,
    ep_tx: usb.types.Endpoint.Num,

    /// This function is called when the host chooses a configuration
    /// that contains this driver.
    pub fn init(desc: *const Descriptor, device: *usb.DeviceInterface) @This() {
        const self: @This() = .{
            .device = device,
            .ep_tx = desc.ep_in.endpoint.num,
        };
        // Listen for first packet
        device.ep_listen(desc.ep_out.endpoint.num, 64);
        return self;
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
    pub fn on_tx_ready(self: *@This(), ep_tx: usb.types.Endpoint.Num) void {
        log.info("tx ready", .{});
        // Mark transmission as available
        @atomicStore(usb.types.Endpoint.Num, &self.ep_tx, ep_tx, .seq_cst);
    }

    pub fn on_rx(self: *@This(), ep_rx: usb.types.Endpoint.Num) void {
        var buf: [64]u8 = undefined;
        // Read incoming packet into a local buffer
        const len_rx = self.device.ep_readv(ep_rx, &.{&buf});
        log.info("Received: {s}", .{buf[0..len_rx]});
        // Check if we can transmit
        const ep_tx = @atomicLoad(usb.types.Endpoint.Num, &self.ep_tx, .seq_cst);
        if (ep_tx != .ep0) {
            // Mark transmission as not available
            @atomicStore(usb.types.Endpoint.Num, &self.ep_tx, .ep0, .seq_cst);
            // Send received packet
            log.info("Sending {} bytes", .{len_rx});
            const len_tx = self.device.ep_writev(ep_tx, &.{buf[0..len_rx]});
            if (len_tx != len_rx)
                log.err("Only sent {} bytes", .{len_tx});
        }
        // Listen for next packet
        self.device.ep_listen(ep_rx, 64);
    }
};
