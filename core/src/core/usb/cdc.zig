const std = @import("std");

const types = @import("types.zig");
const utils = @import("utils.zig");

const DescType = types.DescType;
const bos = utils.BosConfig;

pub const DescSubType = enum(u8) {
    Header = 0x00,
    CallManagement = 0x01,
    ACM = 0x02,
    Union = 0x06,

    pub fn from_u16(v: u16) ?@This() {
        return std.meta.intToEnum(@This(), v) catch null;
    }
};

pub const CdcManagementRequestType = enum(u8) {
    SetLineCoding = 0x20,
    GetLineCoding = 0x21,
    SetControlLineState = 0x22,
    SendBreak = 0x23,

    pub fn from_u8(v: u8) ?@This() {
        return std.meta.intToEnum(@This(), v) catch null;
    }
};

pub const CdcCommSubClassType = enum(u8) {
    AbstractControlModel = 2,
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

pub fn CdcClassDriver(comptime usb: anytype) type {
    const fifo = std.fifo.LinearFifo(u8, std.fifo.LinearFifoBufferType{ .Static = usb.max_packet_size });

    return struct {
        device: ?types.UsbDevice = null,
        ep_in_notif: types.Endpoint.Num = .ep0,
        ep_in: types.Endpoint.Num = .ep0,
        ep_out: types.Endpoint.Num = .ep0,

        line_coding: CdcLineCoding = undefined,

        rx: fifo = fifo.init(),
        tx: fifo = fifo.init(),

        epin_buf: [usb.max_packet_size]u8 = undefined,

        pub fn available(self: *@This()) usize {
            return self.rx.readableLength();
        }

        pub fn read(self: *@This(), dst: []u8) usize {
            const read_count = self.rx.read(dst);
            self.prep_out_transaction();
            return read_count;
        }

        pub fn write(self: *@This(), data: []const u8) []const u8 {
            const write_count = @min(self.tx.writableLength(), data.len);

            if (write_count > 0) {
                self.tx.writeAssumeCapacity(data[0..write_count]);
            } else {
                return data[0..];
            }

            if (self.tx.writableLength() == 0) {
                _ = self.write_flush();
            }

            return data[write_count..];
        }

        pub fn write_flush(self: *@This()) usize {
            if (self.device.?.ready() == false) {
                return 0;
            }
            if (self.tx.readableLength() == 0) {
                return 0;
            }
            const len = self.tx.read(&self.epin_buf);
            const tx_len = self.device.?.endpoint_tx(self.ep_in, &.{self.epin_buf[0..len]});
            if (tx_len != len) @panic("bruh");
            return len;
        }

        fn prep_out_transaction(self: *@This()) void {
            if (self.rx.writableLength() >= usb.max_packet_size) {
                // Let endpoint know that we are ready for next packet
                self.device.?.endpoint_rx(self.ep_out, usb.max_packet_size);
            }
        }

        fn init(ptr: *anyopaque, device: types.UsbDevice) void {
            var self: *@This() = @ptrCast(@alignCast(ptr));
            self.device = device;
            self.line_coding = .{
                .bit_rate = 115200,
                .stop_bits = 0,
                .parity = 0,
                .data_bits = 8,
            };
        }

        fn open(ptr: *anyopaque, cfg: []const u8) !usize {
            var self: *@This() = @ptrCast(@alignCast(ptr));
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
                std.debug.assert(desc_ep.endpoint.dir == .In);
                self.ep_in_notif = desc_ep.endpoint.num;
                curr_cfg = bos.get_desc_next(curr_cfg);
            }

            if (bos.try_get_desc_as(types.InterfaceDescriptor, curr_cfg)) |desc_itf| {
                if (desc_itf.interface_class == @intFromEnum(types.ClassCode.CdcData)) {
                    curr_cfg = bos.get_desc_next(curr_cfg);
                    for (0..2) |_| {
                        if (bos.try_get_desc_as(types.EndpointDescriptor, curr_cfg)) |desc_ep| {
                            switch (desc_ep.endpoint.dir) {
                                .In => self.ep_in = desc_ep.endpoint.num,
                                .Out => self.ep_out = desc_ep.endpoint.num,
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
            var self: *@This() = @ptrCast(@alignCast(ptr));

            if (CdcManagementRequestType.from_u8(setup.request)) |request| {
                switch (request) {
                    .SetLineCoding => {
                        switch (stage) {
                            .Setup => {
                                // HACK, we should handle data phase somehow to read sent line_coding
                                self.device.?.control_ack(setup);
                            },
                            else => {},
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
                            else => {},
                        }
                    },
                    .SendBreak => {
                        switch (stage) {
                            .Setup => {
                                self.device.?.control_ack(setup);
                            },
                            else => {},
                        }
                    },
                }
            }

            return true;
        }

        fn send(ptr: *anyopaque, ep_in: types.Endpoint.Num, data: []const u8) void {
            var self: *@This() = @ptrCast(@alignCast(ptr));

            if (ep_in == self.ep_in and self.write_flush() == 0) {
                // If there is no data left, a empty packet should be sent if
                // data len is multiple of EP Packet size and not zero
                if (self.tx.readableLength() == 0 and data.len > 0 and data.len == usb.max_packet_size) {
                    _ = self.device.?.endpoint_tx(self.ep_in, &.{&.{}});
                }
            }
        }

        fn receive(ptr: *anyopaque, ep_out: types.Endpoint.Num, data: []const u8) void {
            var self: *@This() = @ptrCast(@alignCast(ptr));

            if (ep_out == self.ep_out) {
                self.rx.write(data) catch {};
                self.prep_out_transaction();
            }
        }

        pub fn driver(self: *@This()) types.UsbClassDriver {
            return .{
                .ptr = self,
                .fn_init = init,
                .fn_open = open,
                .fn_class_control = class_control,
                .fn_send = send,
                .fn_receive = receive,
            };
        }
    };
}
