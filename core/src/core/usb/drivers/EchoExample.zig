//! This is an example driver that sends any data received on ep2 to ep1.
const std = @import("std");
const usb = @import("../../usb.zig");
const assert = std.debug.assert;
const log = std.log.scoped(.usb_echo);

/// The descriptors need to have the same memory layout as the sent data.
pub const Descriptor = extern struct {
    const desc = usb.descriptor;

    itf: desc.Interface,
    ep_out: desc.Endpoint,
    ep_in: desc.Endpoint,

    /// This function is used during descriptor creation. Endpoint and
    /// interface numbers are allocated through the `alloc` parameter.
    /// Third argument can be of any type, it's passed by the user when
    /// creating the device controller type. If multiple instances of
    /// a driver are used, this function is called for each, with different
    /// arguments. Passing arguments through this function is preffered to
    /// making the whole driver generic.
    pub fn create(
        alloc: *usb.DescriptorAllocator,
        max_supported_packet_size: usb.types.Len,
        itf_string: []const u8,
    ) usb.DescriptorCreateResult(@This()) {
        return .{
            .descriptor = .{
                .itf = .{
                    .interface_number = alloc.next_itf(),
                    .alternate_setting = 0,
                    .num_endpoints = 2,
                    .interface_triple = .vendor_specific,
                    .interface_s = alloc.string(itf_string),
                },
                .ep_out = .bulk(alloc.next_ep(.Out), max_supported_packet_size),
                .ep_in = .bulk(alloc.next_ep(.In), max_supported_packet_size),
            },
            // Buffers whose length is only known after creating the
            // descriptor can be allocated at this stage.
            .alloc_bytes = max_supported_packet_size,
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
descriptor: *const Descriptor,
packet_buffer: []u8,
tx_ready: std.atomic.Value(bool),

/// This function is called when the host chooses a configuration
/// that contains this driver. `self` points to undefined memory.
/// `data` is of the length specified in `Descriptor.create()`.
pub fn init(self: *@This(), desc: *const Descriptor, device: *usb.DeviceInterface, data: []u8) void {
    assert(data.len == desc.ep_in.max_packet_size.into());
    self.* = .{
        .device = device,
        .descriptor = desc,
        .packet_buffer = data,
        .tx_ready = .init(false),
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
pub fn on_tx_ready(self: *@This(), ep_tx: usb.types.Endpoint.Num) void {
    log.info("tx ready ({t})", .{ep_tx});
    // Mark transmission as available
    self.tx_ready.store(true, .seq_cst);
}

pub fn on_rx(self: *@This(), ep_rx: usb.types.Endpoint.Num) void {
    var buf: [64]u8 = undefined;
    // Read incoming packet into a local buffer
    const len_rx = self.device.ep_readv(ep_rx, &.{&buf});
    log.info("Received on {t}: {s}", .{ ep_rx, buf[0..len_rx] });

    // Check if we can transmit
    if (self.tx_ready.load(.seq_cst)) {
        // Mark transmission as not available
        self.tx_ready.store(false, .seq_cst);
        // Send received packet
        log.info("Sending {} bytes", .{len_rx});
        const len_tx = self.device.ep_writev(
            self.descriptor.ep_in.endpoint.num,
            &.{buf[0..len_rx]},
        );
        if (len_tx != len_rx)
            log.err("Only sent {} bytes", .{len_tx});
    }
    // Listen for next packet
    self.device.ep_listen(ep_rx, 64);
}
