//! This is an example driver that sends any data received on ep2 to ep1.
//! Also acts as the specification of the USB driver interface.

const std = @import("std");
const usb = @import("../../usb.zig");
const assert = std.debug.assert;
const log = std.log.scoped(.usb_echo);

const Driver = @This();

/// Binary representation of the device descriptor as sent to the host.
/// Make sure to use `extern` layout and endian-aware field types,
/// such as `usb.types.LeInt(uXX/iXX)`.
pub const Descriptor = extern struct {
    const desc = usb.descriptor;

    itf: desc.Interface,
    /// Endpoint descriptor names are special.
    /// Later, they are matched to endpoint handler functions
    ep_out: desc.Endpoint,
    ep_in: desc.Endpoint,
};

/// Runtime data and code associated with an instance of the driver.
/// Avoid using global variables here, so that multiple driver instances
/// can be used at the same time.
pub const Runtime = struct {
    /// This is a mapping from endpoint descriptor field names to handler function names.
    /// 'in' and 'out' are from the perspective of the host.
    /// USB devices send data on 'in' endpoints and receive on 'out' endpoints.
    pub const handlers: usb.DriverHandlers(Descriptor, @This()) = .{
        .ep_in = on_tx_ready,
        .ep_out = on_rx,
    };

    /// Fields in this struct have no special meaning to MicroZig
    device: *usb.DeviceInterface,
    descriptor: *const Descriptor,
    packet_buffer: []u8,
    tx_ready: std.atomic.Value(bool),

    /// This function is called when the host chooses a configuration that contains this driver. `self`
    /// points to undefined memory. `data` is of the length specified in `Descriptor.create()`.
    pub fn init(
        self: *@This(),
        _: Driver,
        descriptor: *const Descriptor,
        device: *usb.DeviceInterface,
        data: []u8,
    ) void {
        assert(data.len == descriptor.ep_in.max_packet_size.native());
        self.* = .{
            .device = device,
            .descriptor = descriptor,
            .packet_buffer = data,
            .tx_ready = .init(false),
        };
        device.ep_listen(
            descriptor.ep_out.endpoint.num,
            @intCast(descriptor.ep_out.max_packet_size.native()),
        );
    }

    /// Used for interface configuration through endpoint 0.
    /// Data returned by this function is sent on endpoint 0.
    pub fn class_request(self: *@This(), setup: *const usb.types.SetupPacket) ?[]const u8 {
        _ = self;
        log.debug("setup: {x}, {}, {}", .{ setup.request, setup.length.native(), setup.value.native() });
        return usb.ack;
    }

    /// Transmit handler callback.
    /// Each endpoint (as defined in the descriptor) has its own handler.
    /// Endpoint number is passed as an argument so that it does not need to be stored in the driver.
    pub fn on_tx_ready(self: *@This(), ep_tx: usb.types.Endpoint.Num) void {
        log.info("tx ready ({t})", .{ep_tx});
        // Mark transmission as available
        self.tx_ready.store(true, .seq_cst);
    }

    /// Receive handler callback.
    /// Endpoint number is passed as an argument so that it does not need to be stored in the driver.
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
};

/// `Runtime` type can be generic, in which case the driver type
/// is the only paramater passed. It may be a good idea to make this function
/// a wrapper around another, that only takes a subset of the parameters.
/// This way the generic types are much more readable in zig error output
/// and potentially less code is duplicated when using multiple driver instances
/// with different options. See HID.zig for an example.

// Each field represents a configuration option of the driver.
// The values are declared by user code and available during initialization.
// May not have any fields if the driver does not require configuration.
// Common use case for this type of configuration is for descriptor data
// that is not used by the driver at runtime, like descriptor strings.
itf_string: []const u8 = "",

/// This function is used during descriptor creation. Endpoint and interface numbers are
/// allocated through the `alloc` parameter. Third argument contains the maximum supported
/// packet length, which varies by implementation. If multiple instances of a driver are used,
/// this function is called for each, with different arguments.
/// Aside from the descriptor, this function can return a type that is later used
pub fn driver_info(
    self: @This(),
    comptime device_capabilities: usb.DeviceCapabilities,
    alloc: *usb.DescriptorAllocator,
) usb.DriverInfo(Descriptor) {
    return .{
        .Runtime = Runtime,
        .descriptor = .{
            .itf = .{
                .interface_number = alloc.next_itf(),
                .alternate_setting = 0,
                .num_endpoints = 2,
                .interface_triple = .vendor_specific,
                .interface_s = alloc.string(self.itf_string),
            },
            .ep_out = .bulk(alloc.next_ep(.out), device_capabilities.max_packet_size),
            .ep_in = .bulk(alloc.next_ep(.in), device_capabilities.max_packet_size),
        },
        // Buffers whose length is only known after creating the
        // descriptor can be allocated at this stage.
        .alloc_bytes = device_capabilities.max_packet_size,
    };
}
