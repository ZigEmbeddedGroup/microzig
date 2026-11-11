const std = @import("std");
const assert = std.debug.assert;
const log = std.log.scoped(.usb_ctrl);

pub const configuration = @import("usb/configuration.zig");
pub const descriptor = @import("usb/descriptor.zig");
pub const drivers = struct {
    pub const CDC = @import("usb/drivers/CDC.zig");
    pub const EchoExample = @import("usb/drivers/EchoExample.zig");
    pub const HID_Interrupt = @import("usb/drivers/HID.zig");
};
pub const types = @import("usb/types.zig");

pub const ack: []const u8 = "";
pub const nak: ?[]const u8 = null;

/// Helper struct for endpoint allocation for drivers.
/// Also deduplicates static strings.
pub const DescriptorAllocator = struct {
    next_ep_num: [2]u8,
    next_itf_num: u8,
    unique_endpoints: bool,
    strings: []const []const u8,

    pub fn init(unique_endpoints: bool, strings: []const []const u8) @This() {
        return .{
            .next_ep_num = @splat(1),
            .next_itf_num = 0,
            .unique_endpoints = unique_endpoints,
            .strings = strings,
        };
    }

    pub fn next_ep(self: *@This(), dir: types.Dir) types.Endpoint {
        const idx: u1 = @backingInt(dir);
        const ret = self.next_ep_num[idx];
        self.next_ep_num[idx] += 1;
        if (self.unique_endpoints)
            self.next_ep_num[idx ^ 1] += 1;
        return .{ .dir = dir, .num = @fromBackingInt(ret) };
    }

    pub fn next_itf(self: *@This()) u8 {
        defer self.next_itf_num += 1;
        return self.next_itf_num;
    }

    pub fn string(self: *@This(), str: []const u8) u8 {
        self.strings, const ret = dedup_string(self.strings, str);
        return ret;
    }

    pub fn to_const(self: *DescriptorAllocator) DescriptorAllocator {
        defer self.* = undefined;
        return self.*;
    }
};

/// Device-specific information
pub const DeviceCapabilities = struct {
    max_supported_bcd_usb: types.Version = .v1_00,
    /// Maximimum packet size on ep0
    max_packet_size0: types.PacketLength,
    /// Maximimum packet size on other endpoints
    max_packet_size: types.PacketLength,
    default_vendor: ?Options.IdStringPair = null,
    default_product: ?Options.IdStringPair = null,
};

/// Wraps a Descriptor type. Returned by the `create` method of the Descriptor.
pub fn DriverInfo(Descriptor: type) type {
    return struct {
        /// If not void, a pointer to a value of this type
        /// will be passed to driver's init function.
        Alloc: type = void,
        /// Field attributes of `Alloc`
        alloc_attrs: std.builtin.Type.Struct.FieldAttributes = .{},
        Runtime: type,
        descriptor: Descriptor,
    };
}

/// USB Device interface
/// Any device implementation used with DeviceController must implement these functions
pub const DeviceInterface = struct {
    pub const VTable = struct {
        ep_writev: *const fn (*DeviceInterface, types.Endpoint.Num, []const []const u8) types.PacketLength,
        ep_readv: *const fn (*DeviceInterface, types.Endpoint.Num, []const []u8) types.PacketLength,
        ep_listen: *const fn (*DeviceInterface, types.Endpoint.Num, types.PacketLength) void,
        ep_open: *const fn (*DeviceInterface, *const descriptor.Endpoint) void,
        set_address: *const fn (*DeviceInterface, u7) void,
    };

    vtable: *const VTable,

    /// Called by drivers to send a packet.
    pub fn ep_writev(self: *@This(), ep_num: types.Endpoint.Num, data: []const []const u8) types.PacketLength {
        return self.vtable.ep_writev(self, ep_num, data);
    }

    /// Send ack on given IN endpoint.
    pub fn ep_ack(self: *@This(), ep_num: types.Endpoint.Num) void {
        assert(0 == self.ep_writev(ep_num, &.{ack}));
    }

    /// Called by drivers to retrieve a received packet.
    /// Must be called exactly once for each packet.
    /// Buffers in `data` must collectively be long enough to fit the whole packet.
    pub fn ep_readv(self: *@This(), ep_num: types.Endpoint.Num, data: []const []u8) types.PacketLength {
        return self.vtable.ep_readv(self, ep_num, data);
    }

    /// Called by drivers to report readiness to receive up to `len` bytes.
    /// After being called it may not be called again until a packet is received.
    pub fn ep_listen(self: *@This(), ep_num: types.Endpoint.Num, len: types.PacketLength) void {
        return self.vtable.ep_listen(self, ep_num, len);
    }

    /// Opens an endpoint according to the descriptor. Note that if the endpoint
    /// direction is IN this may call the controller's `on_buffer` function,
    /// so driver initialization must be done before this function is called
    /// on IN endpoint descriptors.
    pub fn ep_open(self: *@This(), desc: *const descriptor.Endpoint) void {
        return self.vtable.ep_open(self, desc);
    }

    /// Immediately sets the device address.
    pub fn set_address(self: *@This(), addr: u7) void {
        return self.vtable.set_address(self, addr);
    }
};

pub fn EndpointHandler(Driver: type) type {
    return fn (*Driver, types.Endpoint.Num) void;
}

pub fn DriverHandlers(Descriptor: type, Runtime: type) type {
    var field_names: []const [:0]const u8 = &.{};

    const info = @typeInfo(Descriptor).@"struct";
    for (info.field_names, info.field_types) |field_name, field_type| switch (field_type) {
        descriptor.Endpoint => field_names = field_names ++ .{field_name},
        else => {},
    };

    return @Struct(.auto, null, field_names, &@splat(EndpointHandler(Runtime)), &@splat(.{}));
}

pub const Options = struct {
    pub const IdStringPair = struct {
        id: u16,
        str: []const u8,
    };

    /// Usb specification version. `null` means highest supported by device.
    bcd_usb: ?types.Version = null,
    /// Class, subclass and protocol of this device.
    device_triple: types.ClassSubclassProtocol,
    /// Vendor id and string. `null` means default provided by device
    vendor: ?IdStringPair = null,
    /// Product id and string. `null` means default provided by device
    product: ?IdStringPair = null,
    /// Device version.
    bcd_device: types.Version,
    /// String descriptor 0.
    language: descriptor.String.Language = .English,
    /// Serial number string.
    serial: []const u8,
    /// Largest packet length the hardware supports. Must be a power of 2 and at least 8.
    device_capabilities: DeviceCapabilities,
};

pub fn validate_controller(T: type) void {
    comptime {
        const info = @typeInfo(T);
        if (info != .pointer or info.pointer.attrs.@"const" or info.pointer.size != .one)
            @compileError("Expected a mutable pointer to the usb controller, got: " ++ @typeName(T));
        const Controller = info.pointer.child;
        _ = Controller;
        // More checks
    }
}

pub fn validate_device(Device: type) void {
    if (!@hasDecl(Device, "device_capabilities"))
        @compileError("USB device " ++ @typeName(Device) ++ " is missing a device_capabilities declaration.");
    if (@TypeOf(Device.device_capabilities) != DeviceCapabilities)
        @compileError("USB device " ++ @typeName(Device) ++ ".device_capabilities has incorrect type.\n" ++
            "Got: " ++ @typeName(@TypeOf(DeviceCapabilities)) ++ ", expected usb.DeviceCapabilities");
}

/// USB device controller
///
/// Responds to host requests and dispatches to the appropriate drivers.
/// When this type is build (at comptime), it builds descriptor and handler tables based on the
/// provided options.
pub fn DeviceController(options: Options, Configurations: []const type) type {
    // Currently only a single configuration is supported.
    std.debug.assert(Configurations.len == 1);

    return struct {
        /// This parses the drivers' descriptors and creates:
        /// * the configuration descriptor
        /// * table of handlers for endpoints
        /// * table of handlers for interfaces
        const descriptor_parse_result = blk: {
            const max_psize0 = options.device_capabilities.max_packet_size0;
            const max_psize = options.device_capabilities.max_packet_size;
            if (max_psize0 < 8 or !std.math.isPowerOfTwo(max_psize0) or max_psize < 8 or !std.math.isPowerOfTwo(max_psize))
                @compileError("Maximum packet size must be a power of two and at least 8");

            const vendor = options.vendor orelse
                (options.device_capabilities.default_vendor orelse
                    @compileError("Vendor ID not provided and device does not specify a default."));

            const product = options.product orelse
                (options.device_capabilities.default_product orelse
                    @compileError("Product ID not provided and device does not specify a default."));

            var strings: []const []const u8 = &.{};
            strings, const manufacturer_s = dedup_string(strings, vendor.str);
            strings, const product_s = dedup_string(strings, product.str);
            strings, const serial_s = dedup_string(strings, options.serial);

            const desc_device: descriptor.Device = .{
                .bcd_usb = options.bcd_usb orelse options.device_capabilities.max_supported_bcd_usb,
                .device_triple = options.device_triple,
                .max_packet_size0 = max_psize0,
                .vendor = .from(vendor.id),
                .product = .from(product.id),
                .bcd_device = options.bcd_device,
                .manufacturer_s = manufacturer_s,
                .product_s = product_s,
                .serial_s = serial_s,
                .num_configurations = Configurations.len,
            };

            var configs: @Tuple(Configurations) = undefined;
            for (0..Configurations.len) |i|
                configs[i], strings = Configurations[i].create(options.device_capabilities, strings);

            var desc_string: []const descriptor.String = &.{.from_lang(options.language)};
            for (strings) |s|
                desc_string = desc_string ++ [1]descriptor.String{.from_str(s)};

            break :blk .{
                .device_descriptor = desc_device,
                .string_descriptors = desc_string,
                .configurations = configs,
            };
        };

        const device_descriptor = descriptor_parse_result.device_descriptor;
        const string_descriptors = descriptor_parse_result.string_descriptors;
        const configurations = descriptor_parse_result.configurations;

        const config_descriptor = configurations[0].Descriptor{};
        const endpoint2handler = configurations[0].EndpointHandlers{};

        /// If not zero, change the device address at the next opportunity.
        /// Necessary because when the host sets the device address,
        /// the acknowledgement step must use the _old_ address.
        new_address: u8,
        /// 0 - no config set
        cfg_num: u16,
        /// Ep0 data waiting to be sent
        tx_slice: ?[]const u8,
        /// Driver state
        driver_data: ?configurations[0].RuntimeData,
        /// Additional driver allocations (size is comptime-known)
        driver_alloc: configurations[0].DriverAlloc,

        /// Initial values
        pub const init: @This() = .{
            .new_address = 0,
            .cfg_num = 0,
            .tx_slice = null,
            .driver_data = null,
            .driver_alloc = undefined,
        };

        /// Returns a pointer to the drivers
        /// or null in case host has not yet configured the device.
        pub fn drivers(self: *@This()) ?*configurations[0].RuntimeData {
            return if (self.driver_data) |*ret| ret else null;
        }

        /// Called by the device implementation when a setup request has been received.
        pub fn on_setup_req(self: *@This(), device_itf: *DeviceInterface, setup: *const types.SetupPacket) void {
            log.debug("on_setup_req", .{});

            const ret = switch (setup.request_type.recipient) {
                .device => self.process_device_setup(device_itf, setup),
                .interface => self.process_interface_setup(setup),
                else => nak,
            };
            if (ret) |data| {
                if (data.len == 0)
                    device_itf.ep_ack(.ep0)
                else {
                    const limited = data[0..@min(data.len, setup.length.native())];
                    const len = device_itf.ep_writev(.ep0, &.{limited});
                    assert(len <= device_descriptor.max_packet_size0);
                    self.tx_slice = limited[len..];
                }
            }
        }

        /// Called by the device implementation when a packet has been sent or received.
        pub fn on_buffer(self: *@This(), device_itf: *DeviceInterface, comptime ep: types.Endpoint) void {
            log.debug("on_buffer {t} {t}", .{ ep.num, ep.dir });

            const driver = comptime configurations[0].endpoint2driver[@backingInt(ep.dir)][@backingInt(ep.num)];
            const handler = comptime @field(endpoint2handler, @tagName(ep.dir))[@backingInt(ep.num)];

            if (comptime ep == types.Endpoint.in(.ep0)) {
                // We use this opportunity to finish the delayed
                // SetAddress request, if there is one:
                if (self.new_address != 0) {
                    device_itf.set_address(@intCast(self.new_address));
                    self.new_address = 0;
                }

                if (self.tx_slice) |slice| {
                    if (slice.len > 0) {
                        const len = device_itf.ep_writev(.ep0, &.{slice});
                        self.tx_slice = slice[len..];
                    } else {
                        // Otherwise, we've just finished sending tx_slice.
                        // We expect an ensuing status phase where the host
                        // sends us a zero-byte DATA packet via EP0 OUT.
                        // device_itf.ep_listen(.ep0, 0);
                        self.tx_slice = null;

                        // W could call an ACK phase callback here,
                        // but none of the drivers so far need it.
                    }
                }
            } else if (comptime ep == types.Endpoint.out(.ep0))
                log.warn("Unhandled packet on ep0 Out", .{});

            if (comptime driver.len != 0)
                handler(&@field(self.driver_data.?, driver), ep.num);
        }

        /// Called by the device implementation on bus reset.
        pub fn on_bus_reset(self: *@This(), device_itf: *DeviceInterface) void {
            log.debug("on_bus_reset", .{});

            self.process_set_config(device_itf, 0);

            // Reset our state.
            self.* = .init;
        }

        // Utility functions

        fn process_device_setup(self: *@This(), device_itf: *DeviceInterface, setup: *const types.SetupPacket) ?[]const u8 {
            switch (setup.request_type.type) {
                .standard => {
                    const request: types.SetupRequest = @fromBackingInt(setup.request);
                    log.debug("Device setup: {any}", .{request});
                    switch (request) {
                        .get_status => {
                            const attr = config_descriptor.first.attributes;
                            const status: types.DeviceStatus = comptime .create(attr.self_powered, false);
                            return std.mem.asBytes(&status);
                        },
                        .set_address => self.new_address = @truncate(setup.value.native()),
                        .set_configuration => self.process_set_config(device_itf, setup.value.native()),
                        .get_descriptor => return get_descriptor(setup.value.native()),
                        .set_feature => {
                            const feature: types.FeatureSelector = @fromBackingInt(@intCast(setup.value.native() >> 8));
                            switch (feature) {
                                .DeviceRemoteWakeup, .EndpointHalt => {},
                                // TODO: https://github.com/ZigEmbeddedGroup/microzig/issues/453
                                .TestMode => return nak,
                                else => return nak,
                            }
                        },
                        else => {
                            log.warn("Unsupported standard request: {}", .{setup.request});
                            return nak;
                        },
                    }
                    return ack;
                },
                else => |t| {
                    log.warn("Unhandled device setup request: {any}", .{t});
                    return nak;
                },
            }
        }

        fn process_interface_setup(self: *@This(), setup: *const types.SetupPacket) ?[]const u8 {
            const itf_num: u8 = @truncate(setup.index.native());
            const num_interfaces = configurations[0].interface2driver.len;
            switch (itf_num) {
                inline else => |itf| if (comptime itf < num_interfaces)
                    return @field(self.driver_data.?, configurations[0].interface2driver[itf]).class_request(setup)
                else {
                    log.warn("Interface index ({}) out of range ({})", .{ itf_num, num_interfaces });
                    return nak;
                },
            }
        }

        // Return the appropriate descriptor type as determined by the top 8 bits of the value.
        fn get_descriptor(value: u16) ?[]const u8 {
            const asBytes = std.mem.asBytes;
            const desc_type: descriptor.Type = @fromBackingInt(@intCast(value >> 8));
            const desc_idx: u8 = @truncate(value);
            log.debug("Request for {any} descriptor {}", .{ desc_type, desc_idx });
            return switch (desc_type) {
                .device => asBytes(&device_descriptor),
                .device_qualifier => asBytes(comptime &device_descriptor.qualifier()),
                .configuration => asBytes(&config_descriptor),
                .string => if (desc_idx < string_descriptors.len)
                    string_descriptors[desc_idx].data
                else {
                    log.warn(
                        "Descriptor index ({}) out of range ({})",
                        .{ desc_idx, string_descriptors.len },
                    );
                    return nak;
                },
                else => nak,
            };
        }

        fn process_set_config(self: *@This(), device_itf: *DeviceInterface, cfg_num: u16) void {
            if (cfg_num == self.cfg_num) return;

            if (self.driver_data) |*data_old|
                configurations[0].deinit(device_itf, data_old);

            self.cfg_num = cfg_num;
            if (cfg_num == 0)
                self.driver_data = null
            else {
                // We support just one config for now so ignore config index
                self.driver_data = @as(configurations[0].RuntimeData, undefined);
                configurations[0].init(device_itf, &self.driver_data.?, &self.driver_alloc, config_descriptor);
            }
        }
    };
}

fn dedup_string(
    comptime strings: []const []const u8,
    comptime new: []const u8,
) struct { []const []const u8, u8 } {
    if (new.len == 0)
        return .{ strings, 0 };
    // deduplicate
    for (strings, 1..) |s, i| {
        if (std.mem.eql(u8, s, new))
            return .{ strings, i };
    }
    const new_strings = strings ++ .{new};
    return .{ new_strings, @intCast(new_strings.len) };
}
