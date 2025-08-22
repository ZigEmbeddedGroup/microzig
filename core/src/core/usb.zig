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

pub const ControllerInterface = struct {
    const Vtable = struct {
        task: *const fn (ptr: *anyopaque) void,
        control_transfer: *const fn (ptr: *anyopaque, data: []const u8) void,
        submit_tx_buffer: *const fn (ptr: *anyopaque, ep_in: EpNum, buffer_end: [*]const u8) void,
        signal_rx_ready: *const fn (ptr: *anyopaque, ep_out: EpNum, max_len: usize) void,
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
};

pub const Config = struct {
    pub fn NameValue(T: type) type {
        return struct { name: [:0]const u8, value: T };
    }
    /// Vendor ID and product ID combo.
    pub const VidPid = struct { product: u16, vendor: u16 };

    /// Manufacturer, product and serial number strings.
    pub const Strings = struct {
        manufacturer: []const u8,
        product: []const u8,
        serial: []const u8,
    };
    /// String descriptor language.
    pub const Language = enum(u16) {
        English = 0x0409,
    };

    /// Underlying USB device.
    Device: type,
    /// Class, subclass and protocol of device.
    device_triple: descriptor.Device.DeviceTriple = .unspecified,
    /// Vendor ID and product ID combo.
    id: ?VidPid = null,
    /// Device version number as Binary Coded Decimal.
    bcd_device: u16 = 0x01_00,
    /// Manufacturer, product and serial number strings.
    strings: ?Strings = null,
    /// Bit set of device attributes.
    attributes: descriptor.Configuration.Attributes,
    /// Maximum device current consumption..
    max_current: descriptor.Configuration.MaxCurrent = .from_ma(100),
    /// String descriptor language.
    language: Language = .English,
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
        pub const max_packet_size = config.Device.max_packet_size;

        pub const interface_vtable: ControllerInterface.Vtable = .{
            .task = &task,
            .control_transfer = &control_transfer,
            .signal_rx_ready = &signal_rx_ready,
            .submit_tx_buffer = &submit_tx_buffer,
        };

        const device_descriptor: descriptor.Device = .{
            .bcd_usb = .from(config.Device.bcd_usb),
            .device_triple = config.device_triple,
            .max_packet_size0 = config.Device.max_transfer_size,
            .vendor = .from(if (config.id) |id| id.vendor else config.Device.default_vid_pid.vendor),
            .product = .from(if (config.id) |id| id.product else config.Device.default_vid_pid.product),
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

                fn serialize(this: @This()) [@sizeOf(@This())]u8 {
                    return @bitCast(this);
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

        const ACK = "";

        pub const ControlEndpointDriver = union(enum) {
            sending: []const u8, // Slice of data left to be sent.
            no_buffer,
            ready: []u8, // Buffer for next transaction. Always empty if available.

            fn submit(this: *@This(), tx_buf: []u8, data: []const u8) void {
                const len = @min(tx_buf.len, data.len);
                if (len == 0)
                    this.* = .no_buffer
                else {
                    std.mem.copyForwards(u8, tx_buf, data[0..len]);
                    this.* = .{ .sending = data[len..] };
                }
                config.Device.submit_tx_buffer(.ep0, tx_buf.ptr + len);
            }

            pub fn send(this: *@This(), data: []const u8) void {
                switch (this.*) {
                    .sending => |residual| {
                        std.log.err("residual data: {any}", .{residual});
                        this.* = .{ .sending = data };
                    },
                    .no_buffer => this.* = .{ .sending = data },
                    .ready => |tx_buf| this.submit(tx_buf, data),
                }
            }

            pub fn on_tx_ready(this: *@This(), tx_buf: []u8) bool {
                switch (this.*) {
                    .sending => |data| {
                        const ret = data.len == 0;
                        this.submit(tx_buf, data);
                        return ret;
                    },
                    .no_buffer => this.* = .{ .ready = tx_buf },
                    .ready => |_| std.log.err("Got buffer twice!", .{}),
                }
                return false;
            }
        };

        driver_by_interface: [16]?*config.Driver,
        driver_by_endpoint_in: [config.Device.max_endpoints_count]?*config.Driver,
        driver_by_endpoint_out: [config.Device.max_endpoints_count]?*config.Driver,
        // Class driver associated with last setup request if any
        driver: ?*config.Driver,
        // When the host gives us a new address, we can't just slap it into
        // registers right away, because we have to do an acknowledgement step using
        // our _old_ address.
        new_address: ?u7,
        // Last setup packet request
        setup_packet: types.SetupPacket,
        //
        ep0_driver: ControlEndpointDriver,
        // 0 - no config set
        cfg_num: u16,
        driver_data: config.Driver,

        pub const init: @This() = .{
            .driver_by_interface = @splat(null),
            .driver_by_endpoint_in = @splat(null),
            .driver_by_endpoint_out = @splat(null),
            .driver = null,
            .new_address = null,
            .setup_packet = undefined,
            .ep0_driver = .no_buffer,
            .cfg_num = 0,
            .driver_data = undefined,
        };

        pub fn init_device(this: *@This()) void {
            if (config.Device.usb_init_device()) |tx_buf|
                this.ep0_driver = .{ .ready = tx_buf };
        }

        pub fn interface(this: *@This()) ControllerInterface {
            return .{
                .ptr = this,
                .vtable = &interface_vtable,
            };
        }

        fn control_transfer(ptr: *anyopaque, data: []const u8) void {
            const this: *@This() = @alignCast(@ptrCast(ptr));
            this.ep0_driver.send(data);
        }

        fn submit_tx_buffer(ptr: *anyopaque, ep_in: EpNum, buffer_end: [*]const u8) void {
            _ = ptr;
            config.Device.submit_tx_buffer(ep_in, buffer_end);
        }

        fn signal_rx_ready(ptr: *anyopaque, ep_out: EpNum, max_len: usize) void {
            _ = ptr;
            config.Device.signal_rx_ready(ep_out, max_len);
        }

        fn process_device_setup_request(this: *@This(), setup: *const types.SetupPacket) anyerror!void {
            if (setup.request_type.type != .Standard) return;
            switch (enumFromInt(types.SetupRequest, setup.request) catch return) {
                .SetAddress => {
                    this.new_address = @intCast(setup.value);
                    this.ep0_driver.send(ACK);
                },
                .SetConfiguration => {
                    defer this.ep0_driver.send(ACK);
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
                            _ = try config.Device.endpoint_open(
                                desc_ep.endpoint,
                                desc_ep.attributes.transfer_type,
                                desc_ep.max_packet_size.into(),
                            );
                        }

                        try this.driver_data.mount(this.interface(), &driver);

                        inline for (fields) |fld| {
                            if (fld.type != descriptor.Endpoint) continue;
                            const desc_ep = @field(driver, fld.name);
                            if (desc_ep.endpoint.dir != .In) continue;

                            this.driver_by_endpoint_in[desc_ep.endpoint.num.to_int()] = &this.driver_data;
                            if (try config.Device.endpoint_open(
                                desc_ep.endpoint,
                                desc_ep.attributes.transfer_type,
                                desc_ep.max_packet_size.into(),
                            )) |buf|
                                this.driver_data.on_tx_ready(this.interface(), buf);
                        }
                    }
                },
                .GetDescriptor => if (enumFromInt(descriptor.Type, setup.value >> 8)) |descriptor_type| blk: {
                    const data: []const u8 = switch (descriptor_type) {
                        .Device => comptime &device_descriptor.serialize(),
                        .Configuration => comptime &config_descriptor.serialize(),
                        .String => if (setup.value & 0xff < string.descriptors.len)
                            string.descriptors[setup.value & 0xff]
                        else
                            comptime descriptor.string(""),
                        .DeviceQualifier => comptime &device_descriptor.qualifier().serialize(),
                        else => break :blk,
                    };
                    const len = @min(data.len, setup.length);
                    this.ep0_driver.send(data[0..len]);
                } else |_| {},
                .SetFeature => if (enumFromInt(types.FeatureSelector, setup.value >> 8)) |feature|
                    switch (feature) {
                        .DeviceRemoteWakeup, .EndpointHalt => this.ep0_driver.send(ACK),
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
        fn task(ptr: *anyopaque) void {
            const this: *@This() = @alignCast(@ptrCast(ptr));
            const events = config.Device.get_events();

            if (events.setup_packet) |setup| {
                this.setup_packet = setup;
                this.driver = null;

                switch (setup.request_type.recipient) {
                    .Device => this.process_device_setup_request(&setup) catch unreachable,
                    .Interface => if (this.driver_by_interface[setup.index & 0xFF]) |drv| {
                        this.driver = drv;
                        if (drv.class_control(this.interface(), .Setup, &setup) == false) {
                            // TODO
                        }
                    },
                    else => {},
                }
            }

            if (events.unhandled_buffers) |iter_const| {
                var iter = iter_const;
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

                            if (this.ep0_driver.on_tx_ready(in.buffer)) {
                                // Otherwise, we've just finished sending
                                // something to the host. We expect an ensuing
                                // status phase where the host sends us (via EP0
                                // OUT) a zero-byte DATA packet, so, set that
                                // up:
                                config.Device.signal_rx_ready(.ep0, 0);
                                if (this.driver) |drv|
                                    _ = drv.class_control(this.interface(), .Ack, &this.setup_packet);

                                // I believe this is incorrect but reality disagrees.
                                this.ep0_driver = .{ .ready = in.buffer };
                            }
                            // TODO: Route different endpoints to different functions.
                        } else if (this.driver_by_endpoint_in[in.ep_num.to_int()]) |drv|
                            drv.on_tx_ready(this.interface(), in.buffer);
                    },
                    .Out => |out| {
                        // TODO: Route different endpoints to different functions.
                        if (this.driver_by_endpoint_out[out.ep_num.to_int()]) |drv|
                            drv.on_data_rx(this.interface(), out.buffer);
                    },
                };
            }

            if (events.bus_reset) {
                // TODO: call umount callback if any
                const tmp = this.ep0_driver;
                this.* = .init;
                this.ep0_driver = tmp;
                config.Device.bus_reset_clear();
            }
        }
    };
}
