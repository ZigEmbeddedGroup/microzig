const std = @import("std");
const PMA = @import("usb_pma.zig");
const timeout = @import("../drivers.zig").Timeout;

const microzig = @import("microzig");
const interrupt = microzig.interrupt;

const USB = microzig.chip.peripherals.USB;
const USBTypes = microzig.chip.types.peripherals.usb_v1;

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

pub const Endpoint = struct {
    //configs
    endpoint: u4,
    ep_type: USBTypes.EP_TYPE,
    ep_kind: bool,
    tx_reset_state: USBTypes.STAT,
    tx_buffer_size: usize,
    rx_reset_state: USBTypes.STAT,
    rx_buffer_size: PMA.RX_size,

    //context data
    rx_pid: u1 = 0,
    tx_pid: u1 = 0,

    pub fn toggle_pid(self: *Endpoint, dir: StatusDir) PID {
        switch (dir) {
            .RX => {
                const pid: PID = @enumFromInt(self.rx_pid);
                self.rx_pid ^= 1;
                return pid;
            },
            .TX => {
                const pid: PID = @enumFromInt(self.tx_pid);
                self.tx_pid ^= 1;
                return pid;
            },
        }
    }

    pub fn toggle_change(self: *Endpoint, dir: StatusDir, val: u1) void {
        switch (dir) {
            .RX => self.rx_pid = val,
            .TX => self.tx_pid = val,
        }
    }
};

var init: bool = false;
var endpoints: [8]?Endpoint = .{null} ** 8;

pub fn usb_init(configs: []const Endpoint, startup: timeout) !void {
    interrupt.disable(.USB_LP_CAN1_RX0);
    if (init) return error.usbAlreadyEnabled;

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
    var i: usize = 0;
    for (configs) |ep_conf| {
        endpoints[i] = ep_conf;
        try BTABLE_conf.set_config(i, .{
            .tx_max_size = ep_conf.tx_buffer_size,
            .rx_max_size = ep_conf.rx_buffer_size,
        });
        i += 1;
    }
    try PMA.btable_init(BTABLE_conf);

    //re-enable interrupts
    USB.CNTR.modify(.{
        .RESETM = 1,
        .CTRM = 1,
    });

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

pub fn change_status(dir: StatusDir, status: USBTypes.STAT, pid: PID, EPC: usize) void {
    const call: *const fn (USBTypes.STAT, PID, usize) void = switch (dir) {
        .RX => change_rx_status,
        .TX => change_tx_status,
    };

    switch (pid) {
        .endpoint_ctr => {
            const new_pid: PID = if (endpoints[EPC]) |*ep| ep.toggle_pid(dir) else PID.no_change;
            call(status, new_pid, EPC);
        },
        .force_data0, .force_data1 => {
            if (endpoints[EPC]) |*ep| {
                ep.toggle_change(dir, @intCast(@intFromEnum(pid)));
            }
            call(status, pid, EPC);
        },
        else => call(status, pid, EPC),
    }
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

//TODO
pub fn usb_handler() void {
    const event = USB.ISTR.read();
    if (event.RESET == 1) {
        USB.ISTR.modify(.{ .RESET = 0 });
        default_reset_handler();
    }

    if (event.CTR == 1) {
        USB.ISTR.modify(.{ .CTR = 0 });
        //const ep = event.EP_ID;
    }
}
