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

/// USB primitive types
pub const types = @import("usb/types.zig");
/// USB Human Interface Device (HID)
pub const hid = @import("usb/hid.zig");
pub const cdc = @import("usb/cdc.zig");
pub const vendor = @import("usb/vendor.zig");
pub const utils = @import("usb/utils.zig");
pub const templates = @import("usb/templates.zig");

const DescType = types.DescType;
const FeatureSelector = types.FeatureSelector;
const Dir = types.Dir;
const Endpoint = types.Endpoint;
const SetupRequest = types.SetupRequest;
const BosConfig = utils.BosConfig;

pub const Descriptors = struct {
    const Lang = struct {
        lo: u8,
        hi: u8,

        pub const English: @This() = .{ .lo = 0x09, .hi = 0x04 };
    };

    device: []const u8,
    config: []const u8,
    string: []const []const u8,
    device_qualifier: []const u8,

    pub fn create(comptime device: types.DeviceDescriptor, config: []const u8, comptime lang: Lang, comptime strings: []const []const u8) @This() {
        @setEvalBranchQuota(10000);

        // String 0 indicates language.
        var strings_utf16: []const []const u8 = &.{&.{ 0x04, 0x03, lang.lo, lang.hi }};
        inline for (strings) |str| {
            const str_utf16: []const u8 = @ptrCast(std.unicode.utf8ToUtf16LeStringLiteral(str));
            strings_utf16 = strings_utf16 ++ .{.{ str_utf16.len + 2, strings_utf16[0][1] } ++ str_utf16};
        }
        return .{
            .device = &device.serialize(),
            .config = config,
            .string = strings_utf16,
            .device_qualifier = &(types.DeviceQualifierDescriptor{
                .bcd_usb = device.bcd_usb,
                .device_triple = device.device_triple,
                .max_packet_size0 = device.max_packet_size0,
                .num_configurations = device.num_configurations,
            }).serialize(),
        };
    }
};

pub const Config = struct {
    device: type,
    descriptors: Descriptors,
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
        const Controller = @This();

        /// USB Class driver interface
        pub const DriverInterface = struct {
            ptr: *anyopaque,
            fn_init: *const fn (ptr: *anyopaque, ctrl: *Controller) void,
            fn_open: *const fn (ptr: *anyopaque, ctrl: *Controller, cfg: []const u8) anyerror!usize,
            fn_class_control: *const fn (ptr: *anyopaque, ctrl: *Controller, stage: types.ControlStage, setup: *const types.SetupPacket) bool,
            fn_send: *const fn (ptr: *anyopaque, ctrl: *Controller, ep_in: types.Endpoint.Num, data: []const u8) void,
            fn_receive: *const fn (ptr: *anyopaque, ctrl: *Controller, ep_out: types.Endpoint.Num, data: []const u8) void,

            pub fn init(interface: *const @This(), ctrl: *Controller) void {
                return interface.fn_init(interface.ptr, ctrl);
            }

            /// Driver open (set config) operation. Must return length of consumed driver config data.
            pub fn open(interface: *const @This(), ctrl: *Controller, cfg: []const u8) !usize {
                return interface.fn_open(interface.ptr, ctrl, cfg);
            }

            pub fn class_control(interface: *const @This(), ctrl: *Controller, stage: types.ControlStage, setup: *const types.SetupPacket) bool {
                return interface.fn_class_control(interface.ptr, ctrl, stage, setup);
            }

            pub fn send(interface: *const @This(), ctrl: *Controller, ep_in: types.Endpoint.Num, data: []const u8) void {
                return interface.fn_send(interface.ptr, ctrl, ep_in, data);
            }

            pub fn receive(interface: *const @This(), ctrl: *Controller, ep_out: types.Endpoint.Num, len: []const u8) void {
                return interface.fn_receive(interface.ptr, ctrl, ep_out, len);
            }
        };

        pub const max_packet_size = config.device.max_packet_size;
        const drvid_invalid = 0xff;

        /// The usb configuration set
        drivers: ?[]const DriverInterface,
        itf_to_drv: [config.device.cfg_max_interfaces_count]u8,
        ep_to_drv: [config.device.cfg_max_endpoints_count][2]u8,
        // Class driver associated with last setup request if any
        driver: ?*const DriverInterface,
        // When the host gives us a new address, we can't just slap it into
        // registers right away, because we have to do an acknowledgement step using
        // our _old_ address.
        new_address: ?u8,
        // Flag recording whether the host has configured us with a
        // `SetConfiguration` message.
        configured: bool,
        // Flag recording whether we've set up buffer transfers after being
        // configured.
        started: bool,
        // Last setup packet request
        setup_packet: types.SetupPacket,
        // Keeps track of sent data from tmp buffer
        now_sending: []const u8,
        // 0 - no config set
        cfg_num: u16,

        pub const init: @This() = .{
            .drivers = null,
            .itf_to_drv = @splat(0),
            .ep_to_drv = @splat(@splat(0)),
            .driver = null,
            .new_address = null,
            .configured = false,
            .started = false,
            .setup_packet = undefined,
            .now_sending = &.{},
            .cfg_num = 0,
        };

        // Command endpoint utilities
        const CmdEndpoint = struct {
            /// Command response utility function that can split long data in multiple packets
            fn send_cmd_response(this2: *Controller, data: []const u8, expected_max_length: u16) void {
                this2.now_sending = data[0..@min(data.len, expected_max_length)];
                const data_chunk = this2.now_sending[0..@min(this2.now_sending.len, 64)];

                if (data_chunk.len > 0) {
                    _ = config.device.usb_start_tx(.ep0, &.{data_chunk});
                }
            }

            fn send_cmd_ack(this2: *Controller) void {
                _ = this2;
                _ = config.device.usb_start_tx(.ep0, &.{});
            }
        };

        /// Initialize the usb device using the given configuration
        ///
        /// You have to ensure that the device is getting an appropiate clock signal.
        pub fn init_device(this: *@This(), d: []const DriverInterface) void {
            config.device.usb_init_device();
            this.drivers = d;

            for (d) |*drv| {
                drv.init(this);
            }
        }

        pub fn ready(this: *@This()) bool {
            return this.started;
        }

        pub fn control_transfer(this: *@This(), setup: *const types.SetupPacket, data: []const u8) void {
            CmdEndpoint.send_cmd_response(this, data, setup.length);
        }

        pub fn control_ack(this: *@This(), _: *const types.SetupPacket) void {
            CmdEndpoint.send_cmd_ack(this);
        }

        pub fn endpoint_tx(this: *@This(), ep_in: Endpoint.Num, data: []const []const u8) usize {
            _ = this;
            return config.device.usb_start_tx(ep_in, data);
        }

        pub fn endpoint_rx(this: *@This(), ep_out: Endpoint.Num, len: usize) void {
            _ = this;
            return config.device.usb_start_rx(ep_out, len);
        }

        pub fn endpoint_open(this: *@This(), ep_desc: []const u8) void {
            _ = this;
            const ep_addr = BosConfig.get_data_u8(ep_desc, 2);
            const ep: Endpoint = .from_address(ep_addr);
            const ep_transfer_type = BosConfig.get_data_u8(ep_desc, 3);
            const ep_max_packet_size = @as(u11, @intCast(BosConfig.get_data_u16(ep_desc, 4) & 0x7FF));

            config.device.endpoint_open(ep, types.TransferType.from_u8(ep_transfer_type) orelse types.TransferType.Bulk, ep_max_packet_size) catch unreachable;
        }

        fn get_driver(this: *@This(), drv_idx: u8) ?*const DriverInterface {
            if (drv_idx == drvid_invalid)
                return null
            else
                return &this.drivers.?[drv_idx];
        }

        fn get_setup_packet(this: *@This()) types.SetupPacket {
            const setup = config.device.get_setup_packet();
            this.setup_packet = setup;
            this.driver = null;
            return setup;
        }

        fn configuration_reset(this: *@This()) void {
            @memset(&this.itf_to_drv, drvid_invalid);
            @memset(&this.ep_to_drv, .{ drvid_invalid, drvid_invalid });
        }

        /// Usb task function meant to be executed in regular intervals after
        /// initializing the device.
        ///
        /// This function will return an error if the device hasn't been initialized.
        pub fn task(this: *@This(), debug: bool) !void {
            if (this.drivers == null) return error.UninitializedDevice;

            // Device Specific Request
            const DeviceRequestProcessor = struct {
                fn process_setup_request(this2: *Controller, setup: *const types.SetupPacket, debug_mode: bool) !void {
                    switch (setup.request_type.type) {
                        .Class => {
                            //const itfIndex = setup.index & 0x00ff;
                            std.log.info("Device.Class", .{});
                        },
                        .Standard => {
                            const req = SetupRequest.from_u8(setup.request);
                            if (req == null) return;
                            switch (req.?) {
                                .SetAddress => {
                                    this2.new_address = @as(u8, @intCast(setup.value & 0xff));
                                    CmdEndpoint.send_cmd_ack(this2);
                                    if (debug_mode) std.log.info("    SetAddress: {}", .{this2.new_address.?});
                                },
                                .SetConfiguration => {
                                    if (debug_mode) std.log.info("    SetConfiguration", .{});
                                    if (this2.cfg_num != setup.value) {
                                        if (this2.cfg_num > 0) {
                                            this2.configuration_reset();
                                        }

                                        if (setup.value > 0) {
                                            try process_set_config(this2, setup.value - 1);
                                            // TODO: call mount callback if any
                                        } else {
                                            // TODO: call umount callback if any
                                        }
                                    }
                                    this2.cfg_num = setup.value;
                                    this2.configured = true;
                                    CmdEndpoint.send_cmd_ack(this2);
                                },
                                .GetDescriptor => {
                                    const descriptor_type = DescType.from_u8(@intCast(setup.value >> 8));
                                    if (descriptor_type) |dt| {
                                        try process_get_descriptor(this2, setup, dt, debug_mode);
                                    }
                                },
                                .SetFeature => {
                                    const feature = FeatureSelector.from_u8(@intCast(setup.value >> 8));
                                    if (feature) |feat| {
                                        switch (feat) {
                                            .DeviceRemoteWakeup, .EndpointHalt => CmdEndpoint.send_cmd_ack(this2),
                                            // TODO: https://github.com/ZigEmbeddedGroup/microzig/issues/453
                                            .TestMode => {},
                                        }
                                    }
                                },
                            }
                        },
                        else => {},
                    }
                }

                fn process_get_descriptor(this2: *Controller, setup: *const types.SetupPacket, descriptor_type: DescType, debug_mode: bool) !void {
                    _ = debug_mode;
                    const data = switch (descriptor_type) {
                        .Device => config.descriptors.device,
                        .Config => config.descriptors.config,
                        .String => config.descriptors.string[setup.value & 0xff],
                        .DeviceQualifier => config.descriptors.device_qualifier,
                        else => return,
                    };
                    CmdEndpoint.send_cmd_response(this2, data, setup.length);
                }

                fn process_set_config(this2: *Controller, _: u16) !void {
                    // TODO: we support just one config for now so ignore config index
                    const bos_cfg = config.descriptors.config;

                    var curr_bos_cfg = bos_cfg;
                    var curr_drv_idx: u8 = 0;

                    if (BosConfig.try_get_desc_as(types.ConfigurationDescriptor, curr_bos_cfg)) |_| {
                        curr_bos_cfg = BosConfig.get_desc_next(curr_bos_cfg);
                    } else {
                        // TODO - error
                        return;
                    }

                    while (curr_bos_cfg.len > 0) : (curr_drv_idx += 1) {
                        var assoc_itf_count: u8 = 1;
                        // New class starts optionally from InterfaceAssociation followed by mandatory Interface
                        if (BosConfig.try_get_desc_as(types.InterfaceAssociationDescriptor, curr_bos_cfg)) |desc_assoc_itf| {
                            assoc_itf_count = desc_assoc_itf.interface_count;
                            curr_bos_cfg = BosConfig.get_desc_next(curr_bos_cfg);
                        }

                        if (BosConfig.get_desc_type(curr_bos_cfg) != DescType.Interface) {
                            // TODO - error
                            return;
                        }
                        const desc_itf = BosConfig.get_desc_as(types.InterfaceDescriptor, curr_bos_cfg);

                        var drv = this2.drivers.?[curr_drv_idx];
                        const drv_cfg_len = try drv.open(this2, curr_bos_cfg);

                        for (0..assoc_itf_count) |itf_offset| {
                            const itf_num = desc_itf.interface_number + itf_offset;
                            this2.itf_to_drv[itf_num] = curr_drv_idx;
                        }

                        bind_endpoints_to_driver(this2, curr_bos_cfg[0..drv_cfg_len], curr_drv_idx);
                        curr_bos_cfg = curr_bos_cfg[drv_cfg_len..];

                        // TODO: TMP solution - just 1 driver so quit while loop
                        return;
                    }
                }

                fn bind_endpoints_to_driver(this2: *Controller, drv_bos_cfg: []const u8, drv_idx: u8) void {
                    var curr_bos_cfg = drv_bos_cfg;
                    while (curr_bos_cfg.len > 0) : ({
                        curr_bos_cfg = BosConfig.get_desc_next(curr_bos_cfg);
                    }) {
                        if (BosConfig.try_get_desc_as(types.EndpointDescriptor, curr_bos_cfg)) |desc_ep| {
                            const dir_as_number: u1 = switch (desc_ep.endpoint.dir) {
                                .Out => 0,
                                .In => 1,
                            };
                            this2.ep_to_drv[desc_ep.endpoint.num.to_int()][dir_as_number] = drv_idx;
                        }
                    }
                }
            };

            // Class/Interface Specific Request
            const InterfaceRequestProcessor = struct {
                fn process_setup_request(this2: *Controller, setup: *const types.SetupPacket) !void {
                    const itf: u8 = @intCast(setup.index & 0xFF);
                    const drv = this2.get_driver(this2.itf_to_drv[itf]);
                    if (drv == null) return;

                    this2.driver = drv;
                    if (this2.driver.?.class_control(this2, .Setup, setup) == false) {
                        // TODO
                    }
                }
            };

            // Endpoint Specific Request
            const EndpointRequestProcessor = struct {
                fn process_setup_request(_: *const types.SetupPacket) !void {}
            };

            // Check which interrupt flags are set.
            const ints = config.device.get_interrupts();

            // Setup request received?
            if (ints.SetupReq) {
                if (debug) std.log.info("setup req", .{});

                const setup = this.get_setup_packet();

                // Reset PID to 1 for EP0 IN. Every DATA packet we send in response
                // to an IN on EP0 needs to use PID DATA1, and this line will ensure
                // that.
                // TODO - maybe it can be moved to config.device.get_setup_packet?
                config.device.reset_ep0();

                switch (setup.request_type.recipient) {
                    .Device => try DeviceRequestProcessor.process_setup_request(this, &setup, debug),
                    .Interface => try InterfaceRequestProcessor.process_setup_request(this, &setup),
                    .Endpoint => try EndpointRequestProcessor.process_setup_request(&setup),
                    else => {},
                }
            }

            // Events on one or more buffers? (In practice, always one.)
            if (ints.BuffStatus) {
                if (debug) std.log.info("buff status", .{});
                var iter: config.device.UnhandledEndpointIterator = .init();

                while (iter.next()) |result| switch (result) {
                    .In => |in| {
                        if (debug) std.log.info("    data: {any}", .{in.buffer});

                        // Perform any required action on the data. For OUT, the `data`
                        // will be whatever was sent by the host. For IN, it's a copy of
                        // whatever we sent.
                        if (in.ep_num == .ep0) {
                            if (debug) std.log.info("    EP0_IN_ADDR", .{});

                            // We use this opportunity to finish the delayed
                            // SetAddress request, if there is one:
                            if (this.new_address) |addr| {
                                // Change our address:
                                config.device.set_address(@intCast(addr));
                            }

                            if (in.buffer.len > 0 and this.now_sending.len > 0) {
                                this.now_sending = this.now_sending[in.buffer.len..];
                                const next_data_chunk = this.now_sending[0..@min(this.now_sending.len, 64)];
                                if (next_data_chunk.len > 0) {
                                    _ = config.device.usb_start_tx(.ep0, &.{next_data_chunk});
                                } else {
                                    config.device.usb_start_rx(.ep0, 0);

                                    if (this.driver) |drv| {
                                        _ = drv.class_control(this, .Ack, &this.setup_packet);
                                    }
                                }
                            } else {
                                // Otherwise, we've just finished sending
                                // something to the host. We expect an ensuing
                                // status phase where the host sends us (via EP0
                                // OUT) a zero-byte DATA packet, so, set that
                                // up:
                                config.device.usb_start_rx(.ep0, 0);

                                if (this.driver) |drv|
                                    _ = drv.class_control(this, .Ack, &this.setup_packet);
                            }
                        } else if (this.get_driver(this.ep_to_drv[in.ep_num.to_int()][1])) |drv|
                            drv.send(this, in.ep_num, in.buffer);
                    },
                    .Out => |out| {
                        if (debug) std.log.info("    data: {any}", .{out.buffer});
                        if (this.get_driver(this.ep_to_drv[out.ep_num.to_int()][0])) |drv|
                            drv.receive(this, out.ep_num, out.buffer);

                        config.device.endpoint_reset_rx(out.ep_num);
                    },
                };
            } // <-- END of buf status handling

            // Has the host signaled a bus reset?
            if (ints.BusReset) {
                if (debug) std.log.info("bus reset", .{});

                this.configuration_reset();
                // Reset the device
                config.device.bus_reset();

                // Reset our state.
                this.new_address = null;
                this.configured = false;
                this.started = false;
                this.now_sending = &.{};
            }

            // If we have been configured but haven't reached this point yet, set up
            // our custom EP OUT's to receive whatever data the host wants to send.
            if (this.configured and !this.started)
                this.started = true;
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
