const std = @import("std");

const descriptor = @import("descriptor.zig");
const types = @import("types.zig");
const utils = @import("utils.zig");

const DescType = types.DescType;
const bos = utils.BosConfig;

pub const Descriptor = extern struct {
    interface: descriptor.Interface,
    hid: descriptor.hid.Hid,
    ep_out: descriptor.Endpoint,
    ep_in: descriptor.Endpoint,

    pub fn create(
        interface_number: u8,
        string_ids: anytype,
        boot_protocol: bool,
        report_desc_len: u16,
        endpoint_out_address: types.Endpoint.Num,
        endpoint_in_address: types.Endpoint.Num,
        endpoint_size: u16,
        endpoint_interval: u8,
    ) @This() {
        return .{
            .interface = .{
                .interface_number = interface_number,
                .alternate_setting = 0,
                .num_endpoints = 2,
                .interface_class = 3,
                .interface_subclass = @intFromBool(boot_protocol),
                .interface_protocol = @intFromBool(boot_protocol),
                .interface_s = string_ids.name,
            },
            .hid = .{
                .bcd_hid = .from(0x0111),
                .country_code = .NotSupported,
                .num_descriptors = 1,
                .report_length = .from(report_desc_len),
            },
            .ep_out = .{
                .endpoint = .out(endpoint_out_address),
                .attributes = .{ .transfer_type = .Interrupt, .usage = .data },
                .max_packet_size = .from(endpoint_size),
                .interval = endpoint_interval,
            },
            .ep_in = .{
                .endpoint = .in(endpoint_in_address),
                .attributes = .{ .transfer_type = .Interrupt, .usage = .data },
                .max_packet_size = .from(endpoint_size),
                .interval = endpoint_interval,
            },
        };
    }
};

pub fn HidClassDriver(Report: type) type {
    return struct {
        pub const ReportDescriptor = blk: {
            const Type = std.meta.Type;

            var fields: []Type.StructField = &.{
                .{
                    .name = "",
                    .type = void,
                    .default_value_ptr = null,
                    .is_comptime = false,
                    .alignment = 1,
                },
            };

            for (@typeInfo(Report).@"struct".fields) |fld| {
                fields = fields ++ switch (fld.type) {
                    else => @compileError("Type " ++ @typeName(fld.type) ++ " not supported in HID report."),
                };
            }

            break :blk @Type(.{ .@"struct" = .{
                .decls = &.{},
                .fields = fields,
                .is_tuple = false,
                .layout = .@"extern",
            } });
        };

        device: ?types.UsbDevice = null,
        ep_in: u8 = 0,
        ep_out: u8 = 0,
        hid_descriptor: []const u8 = &.{},
        report_descriptor: []const u8,

        fn init(ptr: *anyopaque, device: types.UsbDevice) void {
            var self: *@This() = @ptrCast(@alignCast(ptr));
            self.device = device;
        }

        fn open(ptr: *anyopaque, cfg: []const u8) !usize {
            var self: *@This() = @ptrCast(@alignCast(ptr));
            var curr_cfg = cfg;

            if (bos.try_get_desc_as(descriptor.Interface, curr_cfg)) |desc_itf| {
                if (desc_itf.interface_class != @intFromEnum(types.ClassCode.Hid)) return types.DriverErrors.UnsupportedInterfaceClassType;
            } else {
                return types.DriverErrors.ExpectedInterfaceDescriptor;
            }

            curr_cfg = bos.get_desc_next(curr_cfg);
            if (bos.try_get_desc_as(descriptor.hid.Hid, curr_cfg)) |_| {
                self.hid_descriptor = curr_cfg[0..bos.get_desc_len(curr_cfg)];
                curr_cfg = bos.get_desc_next(curr_cfg);
            } else {
                return types.DriverErrors.UnexpectedDescriptor;
            }

            for (0..2) |_| {
                if (bos.try_get_desc_as(descriptor.Endpoint, curr_cfg)) |desc_ep| {
                    switch (desc_ep.endpoint.dir) {
                        .In => self.ep_in = @bitCast(desc_ep.endpoint),
                        .Out => self.ep_out = @bitCast(desc_ep.endpoint),
                    }
                    self.device.?.endpoint_open(curr_cfg[0..desc_ep.length]);
                    curr_cfg = bos.get_desc_next(curr_cfg);
                }
            }

            return cfg.len - curr_cfg.len;
        }

        fn class_control(ptr: *anyopaque, stage: types.ControlStage, setup: *const types.SetupPacket) bool {
            var self: *@This() = @ptrCast(@alignCast(ptr));

            switch (setup.request_type.type) {
                .Standard => {
                    if (stage == .Setup) {
                        const hid_desc_type = std.meta.intToEnum(descriptor.hid.Hid.Type, (setup.value >> 8) & 0xff) catch return false;
                        const request_code = std.meta.intToEnum(types.SetupRequest, setup.request) catch return false;

                        if (request_code == .GetDescriptor and hid_desc_type == .Hid) {
                            self.device.?.control_transfer(setup, self.hid_descriptor);
                        } else if (request_code == .GetDescriptor and hid_desc_type == .Report) {
                            self.device.?.control_transfer(setup, self.report_descriptor);
                        } else {
                            return false;
                        }
                    }
                },
                .Class => {
                    const hid_request_type = std.meta.intToEnum(descriptor.hid.RequestType, setup.request) catch return false;
                    switch (hid_request_type) {
                        .SetIdle => {
                            if (stage == .Setup) {
                                // TODO: The host is attempting to limit bandwidth by requesting that
                                // the device only return report data when its values actually change,
                                // or when the specified duration elapses. In practice, the device can
                                // still send reports as often as it wants, but for completeness this
                                // should be implemented eventually.
                                //
                                // https://github.com/ZigEmbeddedGroup/microzig/issues/454
                                self.device.?.control_ack(setup);
                            }
                        },
                        .SetProtocol => {
                            if (stage == .Setup) {
                                // TODO: The device should switch the format of its reports from the
                                // boot keyboard/mouse protocol to the format described in its report descriptor,
                                // or vice versa.
                                //
                                // For now, this request is ACKed without doing anything; in practice,
                                // the OS will reuqest the report protocol anyway, so usually only one format is needed.
                                // Unless the report format matches the boot protocol exactly (see ReportDescriptorKeyboard),
                                // our device might not work in a limited BIOS environment.
                                //
                                // https://github.com/ZigEmbeddedGroup/microzig/issues/454
                                self.device.?.control_ack(setup);
                            }
                        },
                        .SetReport => {
                            if (stage == .Setup) {
                                // TODO: This request sends a feature or output report to the device,
                                // e.g. turning on the caps lock LED. This must be handled in an
                                // application-specific way, so notify the application code of the event.
                                //
                                // https://github.com/ZigEmbeddedGroup/microzig/issues/454
                                self.device.?.control_ack(setup);
                            }
                        },
                        else => {
                            return false;
                        },
                    }
                },
                else => {
                    return false;
                },
            }

            return true;
        }

        fn transfer(_: *anyopaque, _: types.Endpoint, _: []u8) void {}

        pub fn driver(self: *@This()) types.UsbClassDriver {
            return .{
                .ptr = self,
                .fn_init = init,
                .fn_open = open,
                .fn_class_control = class_control,
                .fn_transfer = transfer,
            };
        }
    };
}
