const std = @import("std");
const builtin = @import("builtin");
const assert = std.debug.assert;
const enumFromInt = std.meta.intToEnum;

pub const cdc = @import("usb/cdc.zig");
pub const descriptor = @import("usb/descriptor.zig");
pub const hid = @import("usb/hid.zig");
pub const types = @import("usb/types.zig");

test "tests" {
    _ = cdc;
    _ = descriptor;
    _ = hid;
    _ = types;
}

const EpNum = types.Endpoint.Num;

pub const DeviceInterface = struct {
    pub const Vtable = struct {
        submit_tx_buffer: *const fn (ptr: *anyopaque, ep_in: EpNum, buffer_end: [*]const u8) void,
        signal_rx_ready: *const fn (ptr: *anyopaque, ep_out: EpNum, max_len: usize) void,
        endpoint_open: *const fn (ptr: *anyopaque, desc: *const descriptor.Endpoint) ?[]u8,
    };
    ptr: *anyopaque,
    vtable: *const Vtable,

    /// Called by drivers when a tx buffer is filled.
    /// Submitting an empty buffer signals an ACK.
    /// A buffer can only be submitted once.
    pub fn submit_tx_buffer(this: @This(), ep_in: EpNum, buffer_end: [*]const u8) void {
        this.vtable.submit_tx_buffer(this.ptr, ep_in, buffer_end);
    }
    /// Called by drivers to report readiness to receive up to `len` bytes.
    /// Must be called exactly once before each packet.
    pub fn signal_rx_ready(this: @This(), ep_out: EpNum, max_len: usize) void {
        this.vtable.signal_rx_ready(this.ptr, ep_out, max_len);
    }
    /// Opens an endpoint according to the descriptor.
    pub fn endpoint_open(this: @This(), desc: *const descriptor.Endpoint) ?[]u8 {
        return this.vtable.endpoint_open(this.ptr, desc);
    }
};

pub const Config = struct {
    /// Manufacturer, product and serial number strings.
    pub const DeviceStrings = struct {
        manufacturer: []const u8,
        product: []const u8,
        serial: []const u8,
    };

    pub fn NameValue(T: type) type {
        return struct { name: [:0]const u8, value: T };
    }

    pub const Driver = struct {
        name: [:0]const u8,
        Type: type,
        endpoints: []const NameValue(EpNum),
        strings: []const NameValue([]const u8),
    };

    /// Bit set of device attributes.
    attributes: descriptor.Configuration.Attributes,
    /// Maximum device current consumption..
    max_current: descriptor.Configuration.MaxCurrent = .from_ma(100),
    /// String descriptor language.
    language: descriptor.Language = .English,
    /// Device version number as Binary Coded Decimal.
    bcd_device: u16 = 0x01_00,
    /// Class, subclass and protocol of device.
    device_triple: descriptor.Device.DeviceTriple = .unspecified,
    /// Manufacturer, product and serial number strings. Leave at null for device default.
    strings: ?DeviceStrings = null,
    /// Vendor ID. Leave at null for device default.
    vid: ?u16 = null,
    /// Product ID. Leave at null for device default.
    pid: ?u16 = null,
    /// Device version number as Binary Coded Decimal. Leave at null for device default.
    bcd_usb: ?u16 = null,
    /// Maximum endpoint size. Leave at null for device default.
    max_transfer_size: ?comptime_int = null,
    // Eventually the fields below could be in an array to support multiple drivers.
    drivers: []const Driver,
};

/// Information about a usb driver, each is required to return this struct via `.info()`.
pub fn DriverInfo(T: type, Descriptors: type) type {
    return struct {
        /// All configuration descriptors concatenated in an extern struct.
        descriptors: Descriptors,
        /// Handlers of setup packets for each used interface.
        interface_handlers: []const struct { itf: u8, func: fn (*T, *const types.SetupPacket) ?[]const u8 },
        /// Functions called an endpoint is ready to send.
        endpoint_in_handlers: []const struct { ep_num: EpNum, func: fn (*T, []u8) void },
        /// Functions called when data is received on an endpoint.
        endpoint_out_handlers: []const struct { ep_num: EpNum, func: fn (*T, []const u8) void },
    };
}

pub const PacketUnhandled = error{UsbPacketUnhandled};
pub const ACK = "";
pub const NAK = null;

/// This is an abstract USB device controller that gets events from
/// a usb device and distributes them to usb drivers, depending on config.
pub fn Controller(comptime config: Config) type {
    return struct {
        /// Driver data is stored within the controller.
        const DriverData = blk: {
            const Field = std.builtin.Type.StructField;
            var fields: []const Field = &.{};
            for (config.drivers) |drv| {
                fields = fields ++ .{Field{
                    .name = drv.name,
                    .type = drv.Type,
                    .default_value_ptr = null,
                    .is_comptime = false,
                    .alignment = @alignOf(drv.Type),
                }};
            }
            break :blk @Type(.{ .@"struct" = .{
                .layout = .auto,
                .fields = fields,
                .decls = &.{},
                .is_tuple = false,
            } });
        };

        drivers: ?DriverData,

        /// String descriptors. Each driver can add its own, and its `.init()` gets the list of IDs.
        const string = blk: {
            var desc: []const []const u8 = &.{&config.language.serialize()};

            desc = desc ++ .{descriptor.string(config.strings.?.manufacturer)};
            desc = desc ++ .{descriptor.string(config.strings.?.product)};
            desc = desc ++ .{descriptor.string(config.strings.?.serial)};

            const Field = std.builtin.Type.StructField;
            var fields: []const Field = &.{};
            for (config.drivers) |drv| {
                var fields_s: []const Field = &.{};

                for (config.drivers[0].strings) |fld| {
                    const id: u8 = desc.len;
                    fields_s = fields_s ++ .{Field{
                        .name = fld.name,
                        .type = @TypeOf(id),
                        .default_value_ptr = @ptrCast(&id),
                        .is_comptime = true,
                        .alignment = @alignOf(@TypeOf(id)),
                    }};
                    desc = desc ++ .{descriptor.string(fld.value)};
                }

                const DrvStrings = @Type(.{ .@"struct" = .{
                    .layout = .auto,
                    .fields = fields_s,
                    .decls = &.{},
                    .is_tuple = false,
                } });

                fields = fields ++ .{Field{
                    .name = drv.name,
                    .type = DrvStrings,
                    .default_value_ptr = @ptrCast(&DrvStrings{}),
                    .is_comptime = true,
                    .alignment = @alignOf(DrvStrings),
                }};
            }
            break :blk .{
                .descriptors = desc,
                .ids = @Type(.{ .@"struct" = .{
                    .layout = .auto,
                    .fields = fields,
                    .decls = &.{},
                    .is_tuple = false,
                } }),
            };
        };

        /// Used descriptors and endpoint handlers.
        const driver_info = blk: {
            const Field = std.builtin.Type.StructField;
            var fields: []const Field = &.{};

            var next_interface = 0;

            for (config.drivers) |drv| {
                var ep_fields: []const Field = &.{};

                for (drv.endpoints) |fld| {
                    ep_fields = ep_fields ++ .{Field{
                        .name = fld.name,
                        .type = @TypeOf(fld.value),
                        .default_value_ptr = @ptrCast(&fld.value),
                        .is_comptime = true,
                        .alignment = @alignOf(@TypeOf(fld.value)),
                    }};
                }

                const ep_struct = @Type(.{ .@"struct" = .{
                    .layout = .auto,
                    .fields = ep_fields,
                    .decls = &.{},
                    .is_tuple = false,
                } });

                const string_ids = @field(string.ids{}, drv.name);
                const info = drv.Type.info(next_interface, string_ids, ep_struct{});
                fields = fields ++ .{Field{
                    .name = drv.name,
                    .type = @TypeOf(info),
                    .default_value_ptr = @ptrCast(&info),
                    .is_comptime = false,
                    .alignment = @alignOf(@TypeOf(info)),
                }};
                for (@typeInfo(@TypeOf(info.descriptors)).@"struct".fields) |fld| {
                    if (fld.type == descriptor.Interface)
                        next_interface += 1;
                }
            }

            break :blk @Type(.{ .@"struct" = .{
                .layout = .auto,
                .fields = fields,
                .decls = &.{},
                .is_tuple = false,
            } }){};
        };

        pub const init: @This() = .{ .drivers = null };

        /// Deinitializes the drivers if the controller has been configured.
        pub fn deinit(this: *@This()) void {
            if (this.drivers) |*drivers| {
                inline for (config.drivers) |drv|
                    @field(drivers, drv.name).deinit();
            }
            this.* = .init;
        }

        /// Called whenever a GET_DESCRIPTOR request is received.
        pub fn get_descriptor(setup: *const types.SetupPacket) ?[]const u8 {
            const device_descriptor: descriptor.Device = comptime .{
                .bcd_usb = .from(config.bcd_usb.?),
                .device_triple = config.device_triple,
                .max_packet_size0 = config.max_transfer_size.?,
                .vendor = .from(config.vid.?),
                .product = .from(config.pid.?),
                .bcd_device = .from(config.bcd_device),
                .manufacturer_s = 1,
                .product_s = 2,
                .serial_s = 3,
                .num_configurations = 1,
            };

            const config_descriptor = comptime blk: {
                var ret: [:0]const u8 = "";
                var num_interfaces = 0;

                for (config.drivers) |drv| {
                    const info = @field(driver_info, drv.name);
                    for (@typeInfo(@TypeOf(info.descriptors)).@"struct".fields) |fld| {
                        if (fld.type == descriptor.Interface)
                            num_interfaces += 1;
                    }
                    ret = ret ++ info.descriptors.serialize();
                }

                break :blk (descriptor.Configuration{
                    .total_length = .from(@sizeOf(descriptor.Configuration) + ret.len),
                    .num_interfaces = num_interfaces,
                    .configuration_value = 1,
                    .configuration_s = 0,
                    .attributes = config.attributes,
                    .max_current = config.max_current,
                }).serialize() ++ ret;
            };

            if (enumFromInt(descriptor.Type, setup.value >> 8)) |descriptor_type| {
                const data: []const u8 = switch (descriptor_type) {
                    .Device => comptime &device_descriptor.serialize(),
                    .Configuration => config_descriptor,
                    .String => if (setup.value & 0xff < string.descriptors.len)
                        string.descriptors[setup.value & 0xff]
                    else
                        comptime descriptor.string(""),
                    .DeviceQualifier => comptime &device_descriptor.qualifier().serialize(),
                    else => return null,
                };
                return data[0..@min(data.len, setup.length)];
            } else |_| return null;
        }

        /// Called whenever a SET_CONFIGURATION request is received.
        pub fn set_configuration(this: *@This(), device: DeviceInterface, setup: *const types.SetupPacket) bool {
            if (setup.value == 0) {
                this.deinit();
                return true;
            }

            if (setup.value != 1 or this.drivers != null) return true;

            this.drivers = undefined;
            inline for (config.drivers) |drv| {
                const descriptors = @field(driver_info, drv.name).descriptors;
                const fields = @typeInfo(@TypeOf(descriptors)).@"struct".fields;

                inline for (fields) |fld| {
                    if (fld.type != descriptor.Endpoint) continue;
                    const desc_ep = @field(descriptors, fld.name);
                    if (desc_ep.endpoint.dir != .Out) continue;
                    _ = device.endpoint_open(&desc_ep);
                }

                @field(this.drivers.?, drv.name) = .init(device, &descriptors);

                inline for (fields) |fld| {
                    if (fld.type != descriptor.Endpoint) continue;
                    const desc_ep = @field(descriptors, fld.name);
                    if (desc_ep.endpoint.dir != .In) continue;

                    if (device.endpoint_open(&desc_ep)) |buf|
                        this.on_tx_ready(desc_ep.endpoint.num, buf) catch {
                            std.log.warn("initial buffer unhandled on {any}", .{desc_ep.endpoint.num});
                        };
                }
            }
            return true;
        }

        /// Called whenever a SET_FEATURE request is received.
        pub fn set_feature(this: *@This(), feature_selector: u8, index: u16, value: bool) bool {
            _ = this;
            _ = index;
            _ = value;
            switch (enumFromInt(types.FeatureSelector, feature_selector) catch return false) {
                .DeviceRemoteWakeup, .EndpointHalt => return true,
                // TODO: https://github.com/ZigEmbeddedGroup/microzig/issues/453
                .TestMode => return false,
            }
        }

        /// Called whenever a setup packet is received.
        pub fn interface_setup(this: *@This(), setup: *const types.SetupPacket) ?[]const u8 {
            if (this.drivers) |*drivers| {
                inline for (config.drivers) |drv| {
                    const ptr = &@field(drivers, drv.name);
                    inline for (@field(driver_info, drv.name).interface_handlers) |handler| {
                        if (handler.itf == setup.index & 0xFF)
                            return handler.func(ptr, setup);
                    }
                }
            }
            return NAK;
        }

        /// Called whenever a tx buffer is ready.
        pub fn on_tx_ready(this: *@This(), ep_num: EpNum, buf: []u8) PacketUnhandled!void {
            if (this.drivers) |*drivers| {
                inline for (config.drivers) |drv| {
                    const ptr = &@field(drivers, drv.name);
                    inline for (@field(driver_info, drv.name).endpoint_in_handlers) |handler| {
                        if (handler.ep_num == ep_num)
                            return handler.func(ptr, buf);
                    }
                }
            }
            return error.UsbPacketUnhandled;
        }

        /// Called whenever a packet is received from the host.
        pub fn on_data_rx(this: *@This(), ep_num: EpNum, buf: []const u8) PacketUnhandled!void {
            if (this.drivers) |*drivers| {
                inline for (config.drivers) |drv| {
                    const ptr = &@field(drivers, drv.name);
                    inline for (@field(driver_info, drv.name).endpoint_out_handlers) |handler| {
                        if (handler.ep_num == ep_num)
                            return handler.func(ptr, buf);
                    }
                }
            }
            return error.UsbPacketUnhandled;
        }
    };
}
