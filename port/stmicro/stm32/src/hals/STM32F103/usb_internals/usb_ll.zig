const std = @import("std");
const PMA = @import("usb_pma.zig");
const timeout = @import("../drivers.zig").Timeout;

const microzig = @import("microzig");
const interrupt = microzig.interrupt;

const USB = microzig.chip.peripherals.USB;
const USBTypes = microzig.chip.types.peripherals.usb_v1;

const ep_test = packed struct(u16) {
    ep0: u1,
    ep1: u1,
    ep2: u1,
    ep3: u1,
    ep4: u1,
    ep5: u1,
    ep6: u1,
    ep7: u1,
    ep8: u1,
    ep9: u1,
    ep10: u1,
    ep11: u1,
    ep12: u1,
    ep13: u1,
    ep14: u1,
    ep15: u1,
};

const InitError = error{
    UsbAlreadyEnabled,
    InvalidEPC,
    EPControlTaken,
    EndpointTaken,
} || PMA.Config.Error || PMA.BTABLEError;

const EndpointError = error{
    UninitEndpoint,
    RecvBufferOVF,
    TransBufferOVF,
};

const StatusDir = enum {
    RX,
    TX,
};
pub const PID = enum {
    force_data0,
    force_data1,
    no_change,
    endpoint_ctr,
};

const EP_CALLBACK = *const fn (EpControl, ?*anyopaque) void;

pub const Endpoint = struct {
    //configs
    ep_control: EpControl,
    endpoint: u4,
    ep_type: USBTypes.EP_TYPE,
    tx_reset_state: USBTypes.STAT = .Disabled,
    tx_buffer_size: usize,
    rx_reset_state: USBTypes.STAT = .Disabled,
    rx_buffer_size: PMA.RX_size,
    ep_kind: bool = false,
    tx_callback: ?EP_CALLBACK = null,
    rx_callback: ?EP_CALLBACK = null,
    setup_callback: ?EP_CALLBACK = null,
    user_param: ?*anyopaque = null,

    //context data
    rx_pid: u1 = 0,
    tx_pid: u1 = 0,

    pub fn toggle_pid(self: *Endpoint, dir: StatusDir) void {
        switch (dir) {
            .RX => {
                self.rx_pid ^= 1;
            },
            .TX => {
                self.tx_pid ^= 1;
            },
        }
    }

    pub fn get_pid(self: *const Endpoint, dir: StatusDir) PID {
        switch (dir) {
            .RX => {
                return @enumFromInt(self.rx_pid);
            },
            .TX => {
                return @enumFromInt(self.tx_pid);
            },
        }
    }

    pub fn force_change(self: *Endpoint, dir: StatusDir, val: u1) void {
        switch (dir) {
            .RX => self.rx_pid = val,
            .TX => self.tx_pid = val,
        }
    }
};

pub const EpControl = enum {
    EPC0,
    EPC1,
    EPC2,
    EPC3,
    EPC4,
    EPC5,
    EPC6,
    EPC7,

    fn check_ep(ep: EpControl) EndpointError!usize {
        const ep_num: usize = @intFromEnum(ep);
        if (endpoints[ep_num] == null) {
            return error.UninitEndpoint;
        }
        return ep_num;
    }
    pub fn set_status(ep: EpControl, dir: StatusDir, status: USBTypes.STAT, pid: PID) EndpointError!void {
        const ep_num: usize = try ep.check_ep();
        change_status(dir, status, pid, ep_num);
    }

    pub fn read_buffer(ep: EpControl, buffer: []u8) EndpointError![]const u8 {
        const ep_num: usize = try ep.check_ep();
        if (buffer.len < PMA.RX_recv_size(ep_num)) {
            return error.RecvBufferOVF;
        }
        return PMA.RX_to_buffer(buffer, ep_num);
    }

    pub fn write_buffer(ep: EpControl, buffer: []const u8) EndpointError!void {
        const ep_num: usize = try ep.check_ep();
        if (buffer.len > endpoints[ep_num].?.tx_buffer_size) {
            return error.TransBufferOVF;
        }
        PMA.buffer_to_TX(buffer, ep_num);
    }

    pub fn ZLP(ep: EpControl) EndpointError!void {
        try ep.write_buffer(&[0]u8{});
    }
};

var init: bool = false;
var endpoints: [8]?Endpoint = .{null} ** 8;

pub fn usb_init(configs: []const Endpoint, startup: timeout) InitError!void {
    interrupt.disable(.USB_LP_CAN1_RX0);
    if (init) return error.UsbAlreadyEnabled;

    //force USB reset before init
    USB.CNTR.modify(.{
        .PDWN = 0,
        .FRES = 1,
    });
    while (!startup.check_timeout()) {
        asm volatile ("nop");
    }
    USB.CNTR.modify(.{ .FRES = 0 });

    //wait for reset
    while (USB.ISTR.read().RESET == 0) {
        asm volatile ("nop");
    }
    USB.CNTR.raw = 0;
    USB.ISTR.raw = 0;

    //config btable
    var BTABLE_conf: PMA.Config = .{};
    var test_ep: u16 = 0;
    for (configs) |ep_conf| {
        const epc_num: usize = @intFromEnum(ep_conf.ep_control);
        const ep_bit: u16 = @as(u16, 1) << ep_conf.endpoint;
        if (endpoints[epc_num]) |_| {
            return error.EPControlTaken;
        } else if ((test_ep & ep_bit) == 1) {
            return error.EndpointTaken;
        }
        test_ep |= ep_bit;
        endpoints[epc_num] = ep_conf;
        try BTABLE_conf.set_config(epc_num, .{
            .tx_max_size = ep_conf.tx_buffer_size,
            .rx_max_size = ep_conf.rx_buffer_size,
        });
    }
    try PMA.btable_init(BTABLE_conf);

    //re-enable interrupts
    USB.CNTR.modify(.{
        .RESETM = 1,
        .CTRM = 1,
    });

    init = true;

    interrupt.enable(.USB_LP_CAN1_RX0);
}

fn change_rx_status(status: USBTypes.STAT, pid: PID, EPC: usize) void {
    const corrent = USB.EPR[EPC].read();
    const DTOG_val = switch (pid) {
        .no_change, .endpoint_ctr => @as(u1, 0),
        .force_data0 => corrent.DTOG_RX,
        .force_data1 => corrent.DTOG_RX ^ @as(u1, 1),
    };

    const valid: u2 = @as(u2, @intFromEnum(corrent.STAT_RX)) ^ @as(u2, @intFromEnum(status));

    USB.EPR[EPC].modify(.{
        .STAT_RX = @as(USBTypes.STAT, @enumFromInt(valid)),
        .DTOG_RX = DTOG_val,
    });
}

fn change_tx_status(status: USBTypes.STAT, pid: PID, EPC: usize) void {
    const corrent = USB.EPR[EPC].read();
    const DTOG_val = switch (pid) {
        .no_change, .endpoint_ctr => @as(u1, 0),
        .force_data0 => corrent.DTOG_TX,
        .force_data1 => corrent.DTOG_TX ^ @as(u1, 1),
    };

    const valid: u2 = @as(u2, @intFromEnum(corrent.STAT_TX)) ^ @as(u2, @intFromEnum(status));

    USB.EPR[EPC].modify(.{
        .STAT_TX = @as(USBTypes.STAT, @enumFromInt(valid)),
        .DTOG_TX = DTOG_val,
    });
}

fn change_status(dir: StatusDir, status: USBTypes.STAT, pid: PID, EPC: usize) void {
    const call: *const fn (USBTypes.STAT, PID, usize) void = switch (dir) {
        .RX => change_rx_status,
        .TX => change_tx_status,
    };

    switch (pid) {
        .endpoint_ctr => {
            const new_pid: PID = if (endpoints[EPC]) |*ep| ep.get_pid(dir) else PID.no_change;
            call(status, new_pid, EPC);
        },
        .force_data0, .force_data1 => |new_pid| {
            if (endpoints[EPC]) |*ep| {
                ep.force_change(dir, @intCast(@intFromEnum(new_pid)));
            }
            call(status, new_pid, EPC);
        },
        else => call(status, pid, EPC),
    }
}

pub fn set_addr(addr: u7) void {
    USB.DADDR.modify(.{
        .ADD = addr,
        .EF = 1,
    });
}

pub fn default_reset_handler() void {
    USB.DADDR.modify(.{
        .ADD = 0,
        .EF = 1,
    });
    //clear all endpoints
    for (0..8) |EP| {
        const corrent = USB.EPR[EP].read();
        USB.EPR[EP].modify(.{
            .EA = @as(u4, @intCast(EP)),
            .STAT_RX = corrent.STAT_RX,
            .STAT_TX = corrent.STAT_TX,
            .DTOG_TX = corrent.DTOG_TX,
            .DTOG_RX = corrent.DTOG_RX,
            .CTR_RX = 0,
            .CTR_TX = 0,
            .EP_KIND = 0,
        });
    }

    USB.ISTR.raw = 0;

    //re-configure endpoints
    for (0..8) |i| {
        if (endpoints[i]) |valid_ep| {
            USB.EPR[i].modify(.{
                .EA = valid_ep.endpoint,
                .EP_TYPE = valid_ep.ep_type,
                .STAT_RX = valid_ep.rx_reset_state,
                .STAT_TX = valid_ep.tx_reset_state,
                .EP_KIND = if (valid_ep.ep_kind) @as(u1, 1) else @as(u1, 0),
            });
        }
    }

    USB.CNTR.modify(.{
        .RESETM = 1,
        .CTRM = 1,
    });
}

pub fn usb_handler() callconv(.C) void {
    const event = USB.ISTR.read();
    if (event.RESET == 1) {
        USB.ISTR.modify(.{ .RESET = 0 });
        default_reset_handler();
    }

    if (event.CTR == 1) {
        USB.ISTR.modify(.{ .CTR = 0 });
        const ep = event.EP_ID;
        const EPR = USB.EPR[ep].read();
        if (endpoints[ep]) |*epc| {
            if (EPR.CTR_RX == 1) {
                USB.EPR[ep].modify(.{ .CTR_RX = 0 });
                epc.toggle_pid(.RX);
                if (EPR.SETUP == 1) {
                    if (epc.setup_callback) |callback| {
                        callback(epc.ep_control, epc.user_param);
                    }
                } else {
                    if (epc.rx_callback) |callback| {
                        callback(epc.ep_control, epc.user_param);
                    }
                }
            }

            if (EPR.CTR_TX == 1) {
                USB.EPR[ep].modify(.{ .CTR_TX = 0 });
                epc.toggle_pid(.TX);
                if (epc.tx_callback) |callback| {
                    callback(epc.ep_control, epc.user_param);
                }
            }
        }
    }
}
