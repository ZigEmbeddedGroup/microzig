const std = @import("std");
const usb = @import("../../usb.zig");
const EP_Num = usb.types.Endpoint.Num;
const log = std.log.scoped(.usb_echo);

/// This is an example driver that sends any data received on ep2 to ep1.
pub const EchoExampleDriver = struct {
    /// The descriptors need to have the same memory layout as the sent data.
    pub const Descriptor = extern struct {
        const desc = usb.descriptor;

        example_interface: desc.Interface,
        ep_out: desc.Endpoint,
        ep_in: desc.Endpoint,

        /// This function is used during descriptor creation. If multiple instances
        /// of a driver are used, a descriptor will be created for each.
        /// Endpoint numbers are allocated automatically, this function should
        /// use placeholder .ep0 values on all endpoints.
        pub fn create(
            alloc: *usb.DescriptorAllocator,
            first_string: u8,
            max_supported_packet_size: usb.types.Len,
        ) @This() {
            return .{
                .example_interface = .{
                    .interface_number = alloc.next_itf(),
                    .alternate_setting = 0,
                    .num_endpoints = 2,
                    .interface_triple = .vendor_specific,
                    .interface_s = first_string,
                },
                .ep_out = .bulk(alloc.next_ep(.Out), max_supported_packet_size),
                .ep_in = .bulk(alloc.next_ep(.In), max_supported_packet_size),
            };
        }
    };

    /// This is a mapping from endpoint descriptor field names to handler
    /// function names. Counterintuitively, usb devices send data on 'in'
    /// endpoints and receive on 'out' endpoints.
    pub const handlers: usb.DriverHadlers(@This()) = .{
        .ep_in = on_tx_ready,
        .ep_out = on_rx,
    };

    device: *usb.DeviceInterface,
    ep_tx: EP_Num,

    /// This function is called when the host chooses a configuration
    /// that contains this driver. `self` points to undefined memory.
    pub fn init(self: *@This(), desc: *const Descriptor, device: *usb.DeviceInterface) void {
        self.* = .{
            .device = device,
            .ep_tx = desc.ep_in.endpoint.num,
        };
        device.ep_listen(
            desc.ep_out.endpoint.num,
            @intCast(desc.ep_out.max_packet_size.into()),
        );
    }

    /// Used for interface configuration through endpoint 0.
    /// Data returned by this function is sent on endpoint 0.
    pub fn class_request(self: *@This(), setup: *const usb.types.SetupPacket) ?[]const u8 {
        _ = self;
        _ = setup;
        return usb.ack;
    }

    /// Each endpoint (as defined in the descriptor) has its own handler.
    /// Endpoint number is passed as an argument so that it does not need
    /// to be stored in the driver.
    pub fn on_tx_ready(self: *@This(), ep_tx: EP_Num) void {
        log.info("tx ready", .{});
        // Mark transmission as available
        @atomicStore(EP_Num, &self.ep_tx, ep_tx, .seq_cst);
    }

    pub fn on_rx(self: *@This(), ep_rx: EP_Num) void {
        var buf: [64]u8 = undefined;
        // Read incoming packet into a local buffer
        const len_rx = self.device.ep_readv(ep_rx, &.{&buf});
        log.info("Received: {s}", .{buf[0..len_rx]});
        // Check if we can transmit
        const ep_tx = @atomicLoad(EP_Num, &self.ep_tx, .seq_cst);
        if (ep_tx != .ep0) {
            // Mark transmission as not available
            @atomicStore(EP_Num, &self.ep_tx, .ep0, .seq_cst);
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
