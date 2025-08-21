//! Abstract USB device implementation
//!
//! This can be used to setup a USB device.
//!
//! ## Usage
//!
//! 1. Define the functions (`pub const F = struct { ... }`) required by `Usb()` (see below)
//! 2. Call `pub const device = Usb(F)`
//! 3. Define the device configuration (DeviceConfiguration)
//! 4. Initialize the device in main by calling `usb.init_device(device_conf)`
//! 5. Call `usb.task()` within the main loop

const std = @import("std");
const builtin = @import("builtin");
const enumFromInt = std.meta.intToEnum;

/// USB primitive types
pub const types = @import("usb/types.zig");
/// USB Human Interface Device (HID)
pub const hid = @import("usb/hid.zig");
pub const cdc = @import("usb/cdc.zig");
pub const vendor = @import("usb/vendor.zig");
pub const utils = @import("usb/utils.zig");
pub const templates = @import("usb/templates.zig");
pub const descriptor = @import("usb/descriptor.zig");

const FeatureSelector = types.FeatureSelector;
const Dir = types.Dir;
const Endpoint = types.Endpoint;
const SetupRequest = types.SetupRequest;
const BosConfig = utils.BosConfig;

pub const ControllerInterface = struct {
    const Vtable = struct {
        task: *const fn (ptr: *anyopaque) void,
        control_transfer: *const fn (ptr: *anyopaque, data: []const u8) void,
        endpoint_open: *const fn (ptr: *anyopaque, ep_desc: []const u8) anyerror!?[]u8,
        submit_tx_buffer: *const fn (ptr: *anyopaque, ep_in: Endpoint.Num, buffer_end: [*]const u8) void,
        endpoint_rx: *const fn (ptr: *anyopaque, ep_out: Endpoint.Num, len: usize) void,
    };

    ptr: *anyopaque,
    vtable: *const Vtable,

    pub fn task(this: @This()) void {
        return this.vtable.task(this.ptr);
    }

    pub fn control_transfer(this: @This(), data: []const u8) void {
        if (data.len == 0)
            std.log.err("data empty", .{})
        else
            this.vtable.control_transfer(this.ptr, data);
    }

    pub fn control_ack(this: @This()) void {
        this.vtable.control_transfer(this.ptr, "");
    }

    pub fn endpoint_open(this: @This(), ep_desc: []const u8) anyerror!?[]u8 {
        return this.vtable.endpoint_open(this.ptr, ep_desc);
    }

    pub fn submit_tx_buffer(this: @This(), ep_in: Endpoint.Num, buffer_end: [*]const u8) void {
        return this.vtable.submit_tx_buffer(this.ptr, ep_in, buffer_end);
    }

    pub fn endpoint_rx(this: @This(), ep_out: Endpoint.Num, len: usize) void {
        return this.vtable.endpoint_rx(this.ptr, ep_out, len);
    }
};

/// USB Class driver interface
pub const DriverInterface = struct {
    pub const Vtable = struct {
        open: *const fn (ptr: *anyopaque, ctrl: ControllerInterface, cfg: []const u8) anyerror!usize,
        class_control: *const fn (ptr: *anyopaque, ctrl: ControllerInterface, stage: types.ControlStage, setup: *const types.SetupPacket) bool,
        on_tx_ready: *const fn (ptr: *anyopaque, ctrl: ControllerInterface, data: []u8) void,
        on_data_rx: *const fn (ptr: *anyopaque, ctrl: ControllerInterface, data: []const u8) void,
    };

    ptr: *anyopaque,
    vtable: *const Vtable,

    /// Driver open (set config) operation. Must return length of consumed driver config data.
    pub fn open(this: @This(), ctrl: ControllerInterface, cfg: []const u8) anyerror!usize {
        return this.vtable.open(this.ptr, ctrl, cfg);
    }

    pub fn class_control(this: @This(), ctrl: ControllerInterface, stage: types.ControlStage, setup: *const types.SetupPacket) bool {
        return this.vtable.class_control(this.ptr, ctrl, stage, setup);
    }

    pub fn on_tx_ready(this: @This(), ctrl: ControllerInterface, data: []u8) void {
        return this.vtable.on_tx_ready(this.ptr, ctrl, data);
    }

    pub fn on_data_rx(this: @This(), ctrl: ControllerInterface, len: []const u8) void {
        return this.vtable.on_data_rx(this.ptr, ctrl, len);
    }
};

pub const Config = struct {
    pub fn NameValue(T: type) type {
        return struct {
            name: [:0]const u8,
            value: T,
        };
    }

    /// Vendor id and product id combo.
    pub const VidPid = struct {
        product: u16,
        vendor: u16,
    };

    pub const Strings = struct {
        manufacturer: []const u8,
        product: []const u8,
        serial: []const u8,
    };

    pub const Language = enum(u16) {
        English = 0x0409,
    };

    Device: type,
    device_triple: descriptor.Device.DeviceTriple = .{
        .class = .Unspecified,
        .subclass = 0,
        .protocol = 0,
    },
    id: ?VidPid = null,
    bcd_device: u16 = 0x01_00,
    strings: ?Strings = null,
    attributes: descriptor.Configuration.Attributes,
    max_current: descriptor.Configuration.MaxCurrent = .from_ma(100),
    language: Language = .English,
    // Eventually the fields below could be in an array to support multiple configurations.
    Driver: type,
    driver_endpoints: []const NameValue(types.Endpoint.Num),
    driver_strings: []const NameValue([]const u8),
};

/// Create a USB device
///
/// # Arguments
///
/// This is a abstract USB device implementation that requires a handful of functions
/// to work correctly:
///
/// * `usb_init_device(*DeviceConfiguration) - Initialize the USB device controller (e.g. enable interrupts, etc.)
/// * `usb_start_tx(*EndpointConfiguration, []const u8)` - Transmit the given bytes over the specified endpoint
/// * `usb_start_rx(*usb.EndpointConfiguration, n: usize)` - Receive n bytes over the specified endpoint
/// * `get_interrupts() InterruptStatus` - Return which interrupts haven't been handled yet
/// * `get_setup_packet() SetupPacket` - Return the USB setup packet received (called if SetupReq received). Make sure to clear the status flag yourself!
/// * `bus_reset() void` - Called on a bus reset interrupt
/// * `set_address(addr: u7) void` - Set the given address
/// * `get_EPBIter(*const DeviceConfiguration) EPBIter` - Return an endpoint buffer iterator. Each call to next returns an unhandeled endpoint buffer with data. How next is implemented depends on the system.
/// The functions must be grouped under the same name space and passed to the fuction at compile time.
/// The functions will be accessible to the user through the `Dev` field.
pub fn Usb(comptime config: Config) type {
    return struct {
        pub const max_packet_size = config.Device.max_packet_size;

        pub const interface_vtable: ControllerInterface.Vtable = .{
            .task = &task,
            .control_transfer = &control_transfer,
            .endpoint_open = &endpoint_open,
            .endpoint_rx = &endpoint_rx,
            .submit_tx_buffer = &submit_tx_buffer,
        };

        const device_descriptor: descriptor.Device = .{
            .bcd_usb = .from(config.Device.bcd_usb),
            .device_triple = config.device_triple,
            .max_packet_size0 = config.Device.max_transfer_size,
            .vendor = .from(if (config.id) |id| id.vendor else config.Device.default_vidpid.vendor),
            .product = .from(if (config.id) |id| id.product else config.Device.default_vidpid.product),
            .bcd_device = .from(config.bcd_device),
            .manufacturer_s = 1,
            .product_s = 2,
            .serial_s = 3,
            .num_configurations = 1,
        };

        const config_descriptor: []const u8 = blk: {
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

            const driver_desc = config.Driver.config_descriptor(string.ids{}, endpoints_struct{});
            break :blk &(descriptor.Configuration{
                .total_length = .from(@sizeOf(descriptor.Configuration) + driver_desc.len),
                .num_interfaces = config.Driver.num_interfaces,
                .configuration_value = 1,
                .configuration_s = 0,
                .attributes = config.attributes,
                .max_current = config.max_current,
            }).serialize() ++ driver_desc;
        };

        const string = blk: {
            const Dev = config.Device;

            // String 0 indicates language. First byte is length.
            const lang: types.U16Le = .from(@intFromEnum(config.language));
            var desc: []const []const u8 = &.{&.{
                0x04,
                @intFromEnum(descriptor.Type.String),
                lang.lo,
                lang.hi,
            }};

            const device_strings = config.strings orelse Dev.default_strings;
            desc = desc ++ .{descriptor.string(device_strings.manufacturer)};
            desc = desc ++ .{descriptor.string(device_strings.product)};
            desc = desc ++ .{descriptor.string(device_strings.serial)};

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

        drivers: ?[]const DriverInterface,
        driver_by_interface: [16]?DriverInterface,
        driver_by_endpoint_in: [config.Device.max_endpoints_count]?DriverInterface,
        driver_by_endpoint_out: [config.Device.max_endpoints_count]?DriverInterface,
        // Class driver associated with last setup request if any
        driver: ?DriverInterface,
        // When the host gives us a new address, we can't just slap it into
        // registers right away, because we have to do an acknowledgement step using
        // our _old_ address.
        new_address: ?u7,
        // Last setup packet request
        setup_packet: types.SetupPacket,
        // Keeps track of sent data from tmp buffer
        now_sending_ep0: ?[]const u8,
        // 0 - no config set
        cfg_num: u16,
        driver_data: config.Driver,

        pub const init: @This() = .{
            .drivers = null,
            .driver_by_interface = @splat(null),
            .driver_by_endpoint_in = @splat(null),
            .driver_by_endpoint_out = @splat(null),
            .driver = null,
            .new_address = null,
            .setup_packet = undefined,
            .now_sending_ep0 = null,
            .cfg_num = 0,
            .driver_data = undefined,
        };

        /// Command response utility function that can split long data in multiple packets
        fn send_cmd_response(this: *@This(), data: []const u8) void {
            if (this.now_sending_ep0) |residual|
                std.log.err("residual data: {any}", .{residual});

            const len = config.Device.usb_start_tx(.ep0, data);
            if (len != 0)
                this.now_sending_ep0 = data[len..];
        }

        /// Initialize the usb device using the given configuration
        pub fn init_device(this: *@This(), drivers: []const DriverInterface) void {
            config.Device.usb_init_device();
            this.drivers = drivers;
        }

        fn control_transfer(ptr: *anyopaque, data: []const u8) void {
            const this: *@This() = @alignCast(@ptrCast(ptr));
            this.send_cmd_response(data);
        }

        fn submit_tx_buffer(ptr: *anyopaque, ep_in: Endpoint.Num, buffer_end: [*]const u8) void {
            _ = ptr;
            return config.Device.submit_tx_buffer(ep_in, buffer_end);
        }

        fn endpoint_rx(ptr: *anyopaque, ep_out: Endpoint.Num, len: usize) void {
            _ = ptr;
            config.Device.usb_start_rx(ep_out, len);
        }

        fn endpoint_open(ptr: *anyopaque, ep_desc: []const u8) anyerror!?[]u8 {
            _ = ptr;
            const ep_addr = BosConfig.get_data_u8(ep_desc, 2);
            const ep: Endpoint = .from_address(ep_addr);
            const ep_transfer_type = BosConfig.get_data_u8(ep_desc, 3);
            const ep_max_packet_size = @as(u11, @intCast(BosConfig.get_data_u16(ep_desc, 4) & 0x7FF));

            return config.Device.endpoint_open(ep, enumFromInt(types.TransferType, ep_transfer_type) catch .Bulk, ep_max_packet_size);
        }

        pub fn interface(this: *@This()) ControllerInterface {
            return .{
                .ptr = this,
                .vtable = &interface_vtable,
            };
        }

        fn process_device_setup_request(this: *@This(), setup: *const types.SetupPacket) void {
            if (setup.request_type.type != .Standard) return;
            switch (enumFromInt(SetupRequest, setup.request) catch return) {
                .SetAddress => {
                    this.new_address = @intCast(setup.value);
                    this.send_cmd_response("");
                },
                .SetConfiguration => {
                    defer this.send_cmd_response("");
                    if (this.cfg_num == setup.value) return;
                    defer this.cfg_num = setup.value;

                    if (this.cfg_num > 0) {
                        this.driver_by_interface = @splat(null);
                        this.driver_by_endpoint_in = @splat(null);
                        this.driver_by_endpoint_out = @splat(null);
                        // TODO: call umount callback if any
                    }

                    if (setup.value == 0) return;

                    this.driver_data.mount(this.interface());

                    // TODO: we support just one config for now so ignore config index
                    const bos_cfg = config_descriptor;

                    var curr_bos_cfg = bos_cfg;
                    var curr_drv_idx: u8 = 0;

                    if (BosConfig.try_get_desc_as(descriptor.Configuration, curr_bos_cfg)) |_| {
                        curr_bos_cfg = BosConfig.get_desc_next(curr_bos_cfg);
                    } else {
                        // TODO: error
                        return;
                    }

                    while (curr_bos_cfg.len > 0) : (curr_drv_idx += 1) {
                        var assoc_itf_count: u8 = 1;
                        // New class starts optionally from InterfaceAssociation followed by mandatory Interface
                        if (BosConfig.try_get_desc_as(descriptor.InterfaceAssociation, curr_bos_cfg)) |desc_assoc_itf| {
                            assoc_itf_count = desc_assoc_itf.interface_count;
                            curr_bos_cfg = BosConfig.get_desc_next(curr_bos_cfg);
                        }

                        if (BosConfig.get_desc_type(curr_bos_cfg) != @intFromEnum(descriptor.Type.Interface)) {
                            // TODO: error
                            return;
                        }
                        const desc_itf = BosConfig.get_desc_as(descriptor.Interface, curr_bos_cfg);

                        var drv = this.drivers.?[curr_drv_idx];
                        const drv_cfg_len = drv.open(this.interface(), curr_bos_cfg) catch unreachable;

                        for (0..assoc_itf_count) |itf_offset| {
                            const itf_num = desc_itf.interface_number + itf_offset;
                            this.driver_by_interface[itf_num] = drv;
                        }

                        var curr_bos_cfg2 = curr_bos_cfg[0..drv_cfg_len];
                        while (curr_bos_cfg2.len > 0) : ({
                            curr_bos_cfg2 = BosConfig.get_desc_next(curr_bos_cfg2);
                        }) {
                            if (BosConfig.try_get_desc_as(descriptor.Endpoint, curr_bos_cfg2)) |desc_ep| {
                                switch (desc_ep.endpoint.dir) {
                                    .Out => this.driver_by_endpoint_out[desc_ep.endpoint.num.to_int()] = drv,
                                    .In => this.driver_by_endpoint_in[desc_ep.endpoint.num.to_int()] = drv,
                                }
                            }
                        }

                        curr_bos_cfg = curr_bos_cfg[drv_cfg_len..];

                        // TODO: TMP solution - just 1 driver so quit while loop
                        break;
                    }
                },
                .GetDescriptor => if (enumFromInt(descriptor.Type, setup.value >> 8)) |descriptor_type| blk: {
                    const data: []const u8 = switch (descriptor_type) {
                        .Device => comptime &device_descriptor.serialize(),
                        .Configuration => config_descriptor,
                        .String => if (setup.value & 0xff < string.descriptors.len)
                            string.descriptors[setup.value & 0xff]
                        else
                            comptime descriptor.string(""),
                        .DeviceQualifier => comptime &device_descriptor.qualifier().serialize(),
                        else => break :blk,
                    };
                    const len = @min(data.len, setup.length);
                    this.send_cmd_response(data[0..len]);
                } else |_| {},
                .SetFeature => if (enumFromInt(FeatureSelector, setup.value >> 8)) |feature|
                    switch (feature) {
                        .DeviceRemoteWakeup, .EndpointHalt => this.send_cmd_response(""),
                        // TODO: https://github.com/ZigEmbeddedGroup/microzig/issues/453
                        .TestMode => {},
                    }
                else |_| {},
            }
        }

        /// Usb task function meant to be executed in regular intervals after
        /// initializing the device.
        ///
        /// You have to ensure the device has been initialized.
        pub fn task(ptr: *anyopaque) void {
            const this: *@This() = @alignCast(@ptrCast(ptr));
            // Check which interrupt flags are set.
            const ints = config.Device.get_interrupts();

            // Setup request received?
            if (ints.SetupReq) {
                const setup = config.Device.get_setup_packet();
                this.setup_packet = setup;
                this.driver = null;

                switch (setup.request_type.recipient) {
                    .Device => this.process_device_setup_request(&setup),
                    .Interface => if (this.driver_by_interface[setup.index & 0xFF]) |drv| {
                        this.driver = drv;
                        if (drv.class_control(this.interface(), .Setup, &setup) == false) {
                            // TODO
                        }
                    },
                    else => {},
                }
            }

            // Events on one or more buffers?
            if (ints.BuffStatus) {
                var iter = config.Device.get_unhandled_endpoints();

                // Perform any required action on the data. For OUT, the `data`
                // will be whatever was sent by the host. For IN, it's a new
                // transmit buffer that has become available.
                while (iter.next()) |result| switch (result) {
                    .In => |in| {
                        if (in.ep_num == .ep0) {
                            // We use this opportunity to finish the delayed
                            // SetAddress request, if there is one:
                            if (this.new_address) |addr| {
                                // Change our address:
                                config.Device.set_address(addr);
                                this.new_address = null;
                            }

                            if (this.now_sending_ep0) |data| {
                                if (data.len > 0) {
                                    const len = config.Device.usb_start_tx(.ep0, data);
                                    this.now_sending_ep0 = data[len..];
                                } else {
                                    // Otherwise, we've just finished sending
                                    // something to the host. We expect an ensuing
                                    // status phase where the host sends us (via EP0
                                    // OUT) a zero-byte DATA packet, so, set that
                                    // up:
                                    config.Device.usb_start_rx(.ep0, 0);
                                    if (this.driver) |drv|
                                        _ = drv.class_control(this.interface(), .Ack, &this.setup_packet);

                                    this.now_sending_ep0 = null;
                                }
                            }
                            // TODO: Route different endpoints to different functions.
                        } else if (this.driver_by_endpoint_in[in.ep_num.to_int()]) |drv|
                            drv.on_tx_ready(this.interface(), in.buffer);
                    },
                    .Out => |out| {
                        // TODO: Route different endpoints to different functions.
                        if (this.driver_by_endpoint_out[out.ep_num.to_int()]) |drv|
                            drv.on_data_rx(this.interface(), out.buffer);

                        config.Device.endpoint_reset_rx(out.ep_num);
                    },
                };
            }

            // Has the host signaled a bus reset?
            if (ints.BusReset) {
                this.driver_by_interface = @splat(null);
                this.driver_by_endpoint_in = @splat(null);
                this.driver_by_endpoint_out = @splat(null);
                // Reset the device
                config.Device.bus_reset();

                // Reset our state.
                this.new_address = null;
                this.cfg_num = 0;
                this.now_sending_ep0 = null;
            }
        }
    };
}

// +++++++++++++++++++++++++++++++++++++++++++++++++
// Driver support stuctures
// +++++++++++++++++++++++++++++++++++++++++++++++++

/// USB interrupt status
///
/// __Note__: Available interrupts may change from device to device.
pub const InterruptStatus = struct {
    ///  Host: raised every time the host sends a SOF (Start of Frame)
    BuffStatus: bool = false,
    BusReset: bool = false,
    ///  Set when the device connection state changes
    DevConnDis: bool = false,
    ///  Set when the device suspend state changes
    DevSuspend: bool = false,
    ///  Set when the device receives a resume from the host
    DevResumeFromHost: bool = false,
    /// Setup Request
    SetupReq: bool = false,
};

/// And endpoint and its corresponding buffer.
pub const EndpointAndBuffer = union(Dir) {
    Out: struct { ep_num: Endpoint.Num, buffer: []const u8 },
    In: struct { ep_num: Endpoint.Num, buffer: []u8 },
};

test "tests" {
    _ = hid;
    _ = utils;
}
