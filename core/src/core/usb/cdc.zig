const std = @import("std");

const types = @import("types.zig");
const utils = @import("utils.zig");

const DescType = types.DescType;
const bos = utils.BosConfig;

pub const DescSubType = enum(u8) {
    Header         = 0x00,
    CallManagement = 0x01,
    ACM            = 0x02,
    Union          = 0x06,

    pub fn from_u16(v: u16) ?@This() {
        return std.meta.intToEnum(@This(), v) catch null;
    }
};

pub const CdcManagementRequestType = enum(u8) {
    SetLineCoding       = 0x20,
    GetLineCoding       = 0x21,
    SetControlLineState = 0x22,
    SendBreak           = 0x23,

    pub fn from_u8(v: u8) ?@This() {
        return std.meta.intToEnum(@This(), v) catch null;
    }
};

pub const CdcCommSubClassType = enum(u8) {
    AbstractControlModel = 2
};

pub const CdcHeaderDescriptor = extern struct {
    length: u8 = 5,
    // Type of this descriptor, must be `ClassSpecific`.
    descriptor_type: DescType = DescType.CsInterface,
    // Subtype of this descriptor, must be `Header`.
    descriptor_subtype: DescSubType = DescSubType.Header,
    // USB Class Definitions for Communication Devices Specification release
    // number in binary-coded decimal. Typically 0x01_10.
    bcd_cdc: u16 align(1),

    pub fn serialize(self: *const @This()) [5]u8 {
        var out: [5]u8 = undefined;
        out[0] = out.len;
        out[1] = @intFromEnum(self.descriptor_type);
        out[2] = @intFromEnum(self.descriptor_subtype);
        out[3] = @intCast(self.bcd_cdc & 0xff);
        out[4] = @intCast((self.bcd_cdc >> 8) & 0xff);
        return out;
    }
};

pub const CdcCallManagementDescriptor = extern struct {
    length: u8 = 5,
    // Type of this descriptor, must be `ClassSpecific`.
    descriptor_type: DescType = DescType.CsInterface,
    // Subtype of this descriptor, must be `CallManagement`.
    descriptor_subtype: DescSubType = DescSubType.CallManagement,
    // Capabilities. Should be 0x00 for use as a serial device.
    capabilities: u8,
    // Data interface number.
    data_interface: u8,

    pub fn serialize(self: *const @This()) [5]u8 {
        var out: [5]u8 = undefined;
        out[0] = out.len;
        out[1] = @intFromEnum(self.descriptor_type);
        out[2] = @intFromEnum(self.descriptor_subtype);
        out[3] = self.capabilities;
        out[4] = self.data_interface;
        return out;
    }
};

pub const CdcAcmDescriptor = extern struct {
    length: u8 = 4,
    // Type of this descriptor, must be `ClassSpecific`.
    descriptor_type: DescType = DescType.CsInterface,
    // Subtype of this descriptor, must be `ACM`.
    descriptor_subtype: DescSubType = DescSubType.ACM,
    // Capabilities. Should be 0x02 for use as a serial device.
    capabilities: u8,

    pub fn serialize(self: *const @This()) [4]u8 {
        var out: [4]u8 = undefined;
        out[0] = out.len;
        out[1] = @intFromEnum(self.descriptor_type);
        out[2] = @intFromEnum(self.descriptor_subtype);
        out[3] = self.capabilities;
        return out;
    }
};

pub const CdcUnionDescriptor = extern struct {
    length: u8 = 5,
    // Type of this descriptor, must be `ClassSpecific`.
    descriptor_type: DescType = DescType.CsInterface,
    // Subtype of this descriptor, must be `Union`.
    descriptor_subtype: DescSubType = DescSubType.Union,
    // The interface number of the communication or data class interface
    // designated as the master or controlling interface for the union.
    master_interface: u8,
    // The interface number of the first slave or associated interface in the
    // union.
    slave_interface_0: u8,

    pub fn serialize(self: *const @This()) [5]u8 {
        var out: [5]u8 = undefined;
        out[0] = out.len;
        out[1] = @intFromEnum(self.descriptor_type);
        out[2] = @intFromEnum(self.descriptor_subtype);
        out[3] = self.master_interface;
        out[4] = self.slave_interface_0;
        return out;
    }
};

pub const CdcLineCoding = extern struct {
    bit_rate: u32 align(1),
    stop_bits: u8,
    parity: u8,
    data_bits: u8,
};

pub const CdcClassDriver = struct {
    
    device: ?types.UsbDevice = null,
    ep_notif: u8 = 0,
    ep_in: u8 = 0,
    ep_out: u8 = 0,

    line_coding: CdcLineCoding = undefined,

    pub fn write(self: *@This(), data: []const u8) void {
        // TODO - ugly hack, current limitation 63 chars (in future endpoints should implement ring buffers)
        const max_size = 63;
        var buf: [64]u8 = undefined;
        const size = @min(data.len, max_size);
        @memcpy(buf[0..size], data[0..size]);
        buf[max_size-2] = '\r';
        buf[max_size-1] = '\n';
        const data_packet = buf[0..size];

        if (self.device.?.ready() == false) {
            return;
        }
        self.device.?.endpoint_transfer(self.ep_in, data_packet);
    }

    fn init(ptr: *anyopaque, device: types.UsbDevice) void {
        var self: *CdcClassDriver = @ptrCast(@alignCast(ptr));
        self.device = device;
        self.line_coding = .{ 
            .bit_rate = 115200,
            .stop_bits = 0,
            .parity = 0,
            .data_bits = 8
        };
    }

    fn open(ptr: *anyopaque, cfg: []const u8) !usize {
        var self: *CdcClassDriver = @ptrCast(@alignCast(ptr));
        var curr_cfg = cfg;

        if (bos.try_get_desc_as(types.InterfaceDescriptor, curr_cfg)) |desc_itf| {
            if (desc_itf.interface_class != @intFromEnum(types.ClassCode.Cdc)) return types.DriverErrors.UnsupportedInterfaceClassType;
            if (desc_itf.interface_subclass != @intFromEnum(CdcCommSubClassType.AbstractControlModel)) return types.DriverErrors.UnsupportedInterfaceSubClassType;
        } else {
            return types.DriverErrors.ExpectedInterfaceDescriptor;
        }

        curr_cfg = bos.get_desc_next(curr_cfg);

        while (curr_cfg.len > 0 and bos.get_desc_type(curr_cfg) == DescType.CsInterface) {
            curr_cfg = bos.get_desc_next(curr_cfg);
        }

        if (bos.try_get_desc_as(types.EndpointDescriptor, curr_cfg)) |desc_ep| {
            self.ep_notif = desc_ep.endpoint_address;
            curr_cfg = bos.get_desc_next(curr_cfg);
        }

        if (bos.try_get_desc_as(types.InterfaceDescriptor, curr_cfg)) |desc_itf| {
            if (desc_itf.interface_class == @intFromEnum(types.ClassCode.CdcData)) {
                curr_cfg = bos.get_desc_next(curr_cfg);
                for (0..2) |_| {
                    if (bos.try_get_desc_as(types.EndpointDescriptor, curr_cfg)) |desc_ep| {
                        switch (types.Endpoint.dir_from_address(desc_ep.endpoint_address)) {
                            .In => { self.ep_in = desc_ep.endpoint_address; },
                            .Out => { self.ep_out = desc_ep.endpoint_address; },
                        }
                        self.device.?.endpoint_open(curr_cfg[0..desc_ep.length]);
                        curr_cfg = bos.get_desc_next(curr_cfg);
                    }
                }
            }
        }

        return cfg.len - curr_cfg.len;
    }

    fn class_control(ptr: *anyopaque, stage: types.ControlStage, setup: *const types.SetupPacket) bool {
        var self: *CdcClassDriver = @ptrCast(@alignCast(ptr));

        if (CdcManagementRequestType.from_u8(setup.request)) |request| {
            switch (request) {
                .SetLineCoding => {
                    switch (stage) {
                        .Setup => {
                            // HACK, we should handle data phase somehow to read sent line_coding
                            self.device.?.control_ack(setup);
                        },
                        else => {}
                    }
                },
                .GetLineCoding => {
                    if (stage == .Setup) {
                        self.device.?.control_transfer(setup, std.mem.asBytes(&self.line_coding));
                    }
                },
                .SetControlLineState => {
                    switch (stage) {
                        .Setup => {
                            self.device.?.control_ack(setup);
                        },
                        else => {}
                    }
                },
                .SendBreak => {
                    switch (stage) {
                        .Setup => {
                            self.device.?.control_ack(setup);
                        },
                        else => {}
                    }
                }
            }
        }

        return true;
    }

    pub fn driver(self: *@This()) types.UsbClassDriver {
        return .{
            .ptr = self,
            .fn_init = init,
            .fn_open = open,
            .fn_class_control = class_control
        };
    }
};