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
        task: *const fn (ptr: *anyopaque) void,
        control_transfer: *const fn (ptr: *anyopaque, data: []const u8) void,
        submit_tx_buffer: *const fn (ptr: *anyopaque, ep_in: EpNum, buffer_end: [*]const u8) void,
        signal_rx_ready: *const fn (ptr: *anyopaque, ep_out: EpNum, max_len: usize) void,
        endpoint_open: *const fn (ptr: *anyopaque, ep: types.Endpoint, transfer_type: types.TransferType, buf_size_hint: usize) anyerror!?[]u8,
    };
    ptr: *anyopaque,
    vtable: *const Vtable,

    pub fn task(this: @This()) void {
        this.vtable.task(this.ptr);
    }
    pub fn control_transfer(this: @This(), data: []const u8) void {
        assert(data.len != 0);
        this.vtable.control_transfer(this.ptr, data);
    }
    pub fn control_ack(this: @This()) void {
        this.vtable.control_transfer(this.ptr, "");
    }
    pub fn submit_tx_buffer(this: @This(), ep_in: EpNum, buffer_end: [*]const u8) void {
        this.vtable.submit_tx_buffer(this.ptr, ep_in, buffer_end);
    }
    pub fn signal_rx_ready(this: @This(), ep_out: EpNum, max_len: usize) void {
        this.vtable.signal_rx_ready(this.ptr, ep_out, max_len);
    }
    pub fn endpoint_open(this: @This(), ep: types.Endpoint, transfer_type: types.TransferType, buf_size_hint: usize) anyerror!?[]u8 {
        return this.vtable.endpoint_open(this.ptr, ep, transfer_type, buf_size_hint);
    }
};

/// Manufacturer, product and serial number strings.
pub const Strings = struct {
    manufacturer: []const u8,
    product: []const u8,
    serial: []const u8,
};

pub const Config = struct {
    pub fn NameValue(T: type) type {
        return struct { name: [:0]const u8, value: T };
    }

    /// String descriptor language.
    pub const Language = enum(u16) {
        English = 0x0409,
    };

    /// Bit set of device attributes.
    attributes: descriptor.Configuration.Attributes,
    /// Maximum device current consumption..
    max_current: descriptor.Configuration.MaxCurrent = .from_ma(100),
    /// String descriptor language.
    language: Language = .English,
    /// Device version number as Binary Coded Decimal.
    bcd_device: u16 = 0x01_00,
    /// Class, subclass and protocol of device.
    device_triple: descriptor.Device.DeviceTriple = .unspecified,
    /// Manufacturer, product and serial number strings.
    strings: Strings,
    /// Vendor ID.
    vid: u16,
    /// Product ID.
    pid: u16,
    /// Device version number as Binary Coded Decimal.
    bcd_usb: u16 = 0x02_00,
    /// Maximum endpoint size.
    max_transfer_size: comptime_int,
    // Eventually the fields below could be in an array to support multiple drivers.
    Driver: type,
    driver_endpoints: []const NameValue(EpNum),
    driver_strings: []const NameValue([]const u8),
};

/// And endpoint and its corresponding buffer.
pub const EndpointAndBuffer = union(types.Dir) {
    Out: struct { ep_num: EpNum, buffer: []const u8 },
    In: struct { ep_num: EpNum, buffer: []u8 },
};

pub const PacketUnhandled = error{UsbPacketUnhandled};
pub const ACK = "";

/// Create a USB device controller.
///
/// This is an abstract USB device controller implementation that requires
/// the USB device driver to implement a handful of functions to work correctly:
///
/// * `usb_init_device() ?[]u8` - Initialize the USB device controller (e.g. enable interrupts, etc.). Returns the ep0 tx buffer, if any.
/// * `set_address(addr: u7) void` - Set device address.
/// * `get_events() anytype` - Returns what events need to be handled (rx/tx completed, bus reset etc., specific to device).
/// * `submit_tx_buffer(ep_in: EpNum, buffer_end: [*]const u8) void` - Send the specified buffer to the host.
/// * `signal_rx_ready(ep_out: EpNum, len: usize) void` - Receive n bytes over the specified endpoint.
/// * `bus_reset_clear() void` - Called after handling a bus reset.
///
/// As well as some declarations:
///
/// * `max_endpoints_count` - How many endpoints are supported, up to 16.
/// * `max_transfer_size` - How many bytes can be transferred in one packet.
/// * `bcd_usb` - Version of USB specification supported by device.
/// * `default_strings` - Default manufacturer, product and serial (optional).
/// * `default_vid_pid` - Default VID and PID (optional).
pub fn Controller(comptime config: Config) type {
    return struct {
        driver_by_interface: [16]?*config.Driver,
        driver_by_endpoint_in: [16]?*config.Driver,
        driver_by_endpoint_out: [16]?*config.Driver,
        // 0 - no config set
        cfg_num: u16,
        driver_data: config.Driver,

        pub const default: @This() = .{
            .driver_by_interface = @splat(null),
            .driver_by_endpoint_in = @splat(null),
            .driver_by_endpoint_out = @splat(null),
            .cfg_num = 0,
            .driver_data = undefined,
        };

        const device_descriptor: descriptor.Device = .{
            .bcd_usb = .from(config.bcd_usb),
            .device_triple = config.device_triple,
            .max_packet_size0 = config.max_transfer_size,
            .vendor = .from(config.vid),
            .product = .from(config.pid),
            .bcd_device = .from(config.bcd_device),
            .manufacturer_s = 1,
            .product_s = 2,
            .serial_s = 3,
            .num_configurations = 1,
        };

        const config_descriptor = blk: {
            const Field = std.builtin.Type.StructField;
            var fields: []const Field = &.{};
            for (config.driver_endpoints) |fld| {
                fields = fields ++ .{Field{
                    .name = fld.name,
                    .type = @TypeOf(fld.value),
                    .default_value_ptr = @ptrCast(&fld.value),
                    .is_comptime = true,
                    .alignment = @alignOf(@TypeOf(fld.value)),
                }};
            }
            const endpoints_struct = @Type(.{ .@"struct" = .{
                .layout = .auto,
                .fields = fields,
                .decls = &.{},
                .is_tuple = false,
            } });

            const driver = config.Driver.config_descriptor(0, string.ids{}, endpoints_struct{});
            assert(@alignOf(@TypeOf(driver)) == 1);
            assert(@typeInfo(@TypeOf(driver)).@"struct".layout == .@"extern");

            const Ret = extern struct {
                first: descriptor.Configuration,
                driver: @TypeOf(driver),

                fn serialize(x: @This()) [@sizeOf(@This())]u8 {
                    return @bitCast(x);
                }
            };

            break :blk Ret{
                .first = .{
                    .total_length = .from(@sizeOf(Ret)),
                    .num_interfaces = config.Driver.num_interfaces,
                    .configuration_value = 1,
                    .configuration_s = 0,
                    .attributes = config.attributes,
                    .max_current = config.max_current,
                },
                .driver = driver,
            };
        };

        const string = blk: {
            // String 0 indicates language. First byte is length.
            const lang: types.U16Le = .from(@intFromEnum(config.language));
            var desc: []const []const u8 = &.{&.{
                0x04,
                @intFromEnum(descriptor.Type.String),
                lang.lo,
                lang.hi,
            }};

            desc = desc ++ .{descriptor.string(config.strings.manufacturer)};
            desc = desc ++ .{descriptor.string(config.strings.product)};
            desc = desc ++ .{descriptor.string(config.strings.serial)};

            const Field = std.builtin.Type.StructField;
            var fields: []const Field = &.{};
            for (config.driver_strings) |fld| {
                const id: u8 = desc.len;
                fields = fields ++ .{Field{
                    .name = fld.name,
                    .type = @TypeOf(id),
                    .default_value_ptr = @ptrCast(&id),
                    .is_comptime = true,
                    .alignment = @alignOf(@TypeOf(id)),
                }};
                desc = desc ++ .{descriptor.string(fld.value)};
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

        pub fn init() @This() {
            return .default;
        }

        pub fn deinit(_: *@This()) void {}

        pub fn get_descriptor(setup: *const types.SetupPacket) ?[]const u8 {
            if (enumFromInt(descriptor.Type, setup.value >> 8)) |descriptor_type| {
                const data: []const u8 = switch (descriptor_type) {
                    .Device => comptime &device_descriptor.serialize(),
                    .Configuration => comptime &config_descriptor.serialize(),
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

        pub fn set_configuration(this: *@This(), device: DeviceInterface, setup: *const types.SetupPacket) void {
            defer device.control_ack();
            if (this.cfg_num == setup.value) return;
            defer this.cfg_num = setup.value;

            if (this.cfg_num > 0) {
                this.driver_by_interface = @splat(null);
                this.driver_by_endpoint_in = @splat(null);
                this.driver_by_endpoint_out = @splat(null);
                // TODO: call umount callback if any
            }

            if (setup.value == 0) return;

            { // Eventually do this for every driver
                const driver = config_descriptor.driver;
                comptime var fields = @typeInfo(@TypeOf(driver)).@"struct".fields;

                var assoc_itf_count: u8 = 1;
                // New class starts optionally from InterfaceAssociation followed by mandatory Interface
                if (fields[0].type == descriptor.InterfaceAssociation) {
                    assoc_itf_count = @field(driver, fields[0].name).interface_count;
                    fields = fields[1..];
                }

                assert(fields[0].type == descriptor.Interface);
                const desc_itf = @field(driver, fields[0].name);
                for (0..assoc_itf_count) |itf_offset| {
                    const itf_num = desc_itf.interface_number + itf_offset;
                    this.driver_by_interface[itf_num] = &this.driver_data;
                }
                fields = fields[1..];

                inline for (fields) |fld| {
                    if (fld.type != descriptor.Endpoint) continue;
                    const desc_ep = @field(driver, fld.name);
                    if (desc_ep.endpoint.dir != .Out) continue;

                    this.driver_by_endpoint_out[desc_ep.endpoint.num.to_int()] = &this.driver_data;
                    _ = device.endpoint_open(
                        desc_ep.endpoint,
                        desc_ep.attributes.transfer_type,
                        desc_ep.max_packet_size.into(),
                    ) catch unreachable;
                }

                this.driver_data = .init(device, &driver);

                inline for (fields) |fld| {
                    if (fld.type != descriptor.Endpoint) continue;
                    const desc_ep = @field(driver, fld.name);
                    if (desc_ep.endpoint.dir != .In) continue;

                    this.driver_by_endpoint_in[desc_ep.endpoint.num.to_int()] = &this.driver_data;
                    if (device.endpoint_open(
                        desc_ep.endpoint,
                        desc_ep.attributes.transfer_type,
                        desc_ep.max_packet_size.into(),
                    ) catch unreachable) |buf|
                        this.driver_data.on_tx_ready(device, buf);
                }
            }
        }

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

        pub fn interface_setup(this: @This(), setup: *const types.SetupPacket) ?[]const u8 {
            if (this.driver_by_interface[setup.index & 0xFF]) |drv|
                return drv.interface_setup(setup);
            return null;
        }

        pub fn on_tx_ready(this: *@This(), device: DeviceInterface, ep_num: EpNum, buf: []u8) PacketUnhandled!void {
            if (ep_num == .ep0)
                return error.UsbPacketUnhandled
            else if (this.driver_by_endpoint_in[ep_num.to_int()]) |drv|
                // TODO: Route different endpoints to different functions.
                return drv.on_tx_ready(device, buf);
        }

        pub fn on_data_rx(this: *@This(), device: DeviceInterface, ep_num: EpNum, buf: []const u8) PacketUnhandled!void {
            if (ep_num == .ep0)
                return error.UsbPacketUnhandled
            else if (this.driver_by_endpoint_out[ep_num.to_int()]) |drv|
                // TODO: Route different endpoints to different functions.
                return drv.on_data_rx(device, buf);
        }
    };
}
