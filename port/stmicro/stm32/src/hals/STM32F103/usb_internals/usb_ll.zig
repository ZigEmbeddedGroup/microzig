const std = @import("std");
const PMA = @import("usb_pma.zig");

const microzig = @import("microzig");
const time = microzig.hal.time;
const interrupt = microzig.interrupt;
const Duration = microzig.drivers.time.Duration;
const Deadline = microzig.drivers.time.Deadline;

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
    ConfigError,
    BadEP0,
} || PMA.Config.Error || PMA.BTABLEError;

const EndpointError = error{
    UninitEndpoint,
    RecvBufferOVF,
    TransBufferOVF,
};

const UsbError = error{UsbNotInit} || EndpointError;
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

    pub fn force_change(self: *Endpoint, dir: StatusDir, val: PID) PID {
        switch (dir) {
            .RX => self.rx_pid = @intCast(@intFromEnum(val)),
            .TX => self.tx_pid = @intCast(@intFromEnum(val)),
        }
        return val;
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

    //write to buffer and enable TX
    pub fn USB_send(ep: EpControl, buffer: []const u8, pid: PID) UsbError!void {
        if (!init) return error.UsbNotInit;
        const ep_num: usize = try ep.check_ep();
        if (buffer.len > endpoints[ep_num].?.tx_buffer_size) {
            return error.TransBufferOVF;
        }
        PMA.buffer_to_TX(buffer, ep_num);
        change_status(.TX, .Valid, pid, ep_num);
    }

    pub inline fn ZLP(ep: EpControl, pid: PID) UsbError!void {
        return USB_send(ep, &[_]u8{}, pid);
    }

    //read and enable RX for the next pkg
    pub fn USB_read(ep: EpControl, next: PID) UsbError![]const u8 {
        if (!init) return error.UsbNotInit;
        const ep_num: usize = try ep.check_ep();
        const recv = PMA.RX_to_buffer(iner_RX_buffer, ep_num);
        change_status(.RX, .Valid, next, ep_num);
        return recv;
    }
};

const UsbErrorStatus = struct {}; //TODO

const ResetCallback = *const fn (?*anyopaque) void;
const ErrorCallback = *const fn (UsbErrorStatus, ?*anyopaque) void;

pub const Config = struct {
    endpoints: []const Endpoint,
    RX_buffer: []u8,
    reset_callback: ?ResetCallback = null,
    reset_args: ?*anyopaque = null,
    error_callback: ?ErrorCallback = null,
    error_args: ?*anyopaque = null,
};

var init: bool = false;
var endpoints: [8]?Endpoint = .{null} ** 8;
var iner_RX_buffer: []u8 = undefined;
var reset_callback: ?ResetCallback = null;
var reset_ctx: ?*anyopaque = null;
var error_callback: ?ErrorCallback = null;
var error_ctx: ?*anyopaque = null;

fn comptime_or_runtime_err(erro: InitError, comptime msg: []const u8, args: anytype) InitError!void {
    if (@inComptime()) {
        @compileError(std.fmt.comptimePrint(msg, args));
    } else {
        return erro;
    }
}

fn usb_check(config: Config) InitError!PMA.Config {
    if (config.endpoints.len > 8) {
        comptime_or_runtime_err(
            InitError.ConfigError,
            "USB can only support up to 8 endpoints configurations\n",
            .{},
        );
    } else if (config.endpoints.len == 0) {
        comptime_or_runtime_err(
            InitError.ConfigError,
            "USB must have at least one endpoint configuration\n\n",
            .{},
        );
    }

    var ep_check: u16 = 0;
    var epc_check: u16 = 0;
    var max_rx_size: usize = 0;
    var btable_conf: PMA.Config = .{};
    for (config.endpoints) |epconf| {
        const ep_size = epconf.rx_buffer_size.calc_rx_size();
        const ep_bit: u16 = @as(u16, 1) << epconf.endpoint;
        const epc_bit: u16 = @as(u16, 1) << @as(u4, @intFromEnum(epconf.ep_control));

        if (epconf.endpoint == 0) {
            if (epconf.ep_type != .Control) comptime_or_runtime_err(
                InitError.BadEP0,
                "EP0 must have type: Control",
                .{},
            );
        }
        if (ep_size > max_rx_size) {
            max_rx_size = ep_size;
        }

        if ((ep_bit & ep_check) == 0) {
            ep_check |= ep_bit;
        } else {
            comptime_or_runtime_err(
                InitError.InvalidEndpoint,
                "EP: {x} has already been taken\n",
                .{epconf.endpoint},
            );
        }

        if ((epc_bit & epc_check) == 0) {
            epc_check |= epc_bit;
        } else {
            comptime_or_runtime_err(
                InitError.InvalidEndpoint,
                "EPC{d} has already been taken\n",
                .{@as(u4, @intFromEnum(epconf.ep_control))},
            );
        }

        btable_conf.set_config(epconf.endpoint, .{
            .rx_max_size = epconf.rx_buffer_size,
            .tx_max_size = epconf.tx_buffer_size,
        }) catch unreachable;
    }
    if ((epc_check & 0x1) == 0) comptime_or_runtime_err(
        InitError.BadEP0,
        "EP0 not configured\n",
        .{},
    );
    if (config.RX_buffer.len < max_rx_size) comptime_or_runtime_err(
        InitError.ConfigError,
        "Internal RX is too small for current configuration",
        .{},
    );
    return btable_conf;
}

pub fn usb_init(comptime config: Config, startup: Duration) void {
    const btable_conf = comptime usb_check(config) catch unreachable;
    PMA.comptime_check(btable_conf);
    inner_init(config, btable_conf, startup) catch unreachable;
}

pub fn usb_runtime_init(config: Config, startup: Duration) InitError!void {
    const btable_conf = try usb_check(config);
    try inner_init(config, btable_conf, startup);
}

fn inner_init(config: Config, PMA_conf: PMA.Config, startup: Duration) InitError!void {
    //interrupt.disable(.USB_LP_CAN1_RX0); //NOTE: some error with this function is disabling all interrupts
    const deadline = Deadline.init_relative(time.get_time_since_boot(), startup);

    //force USB reset before init
    USB.CNTR.modify(.{
        .PDWN = 0,
        .FRES = 1,
    });
    while (!deadline.is_reached_by(time.get_time_since_boot())) {
        asm volatile ("nop");
    }
    USB.CNTR.modify(.{ .FRES = 0 });

    //wait for reset
    while (USB.ISTR.read().RESET == 0) {
        asm volatile ("nop");
    }
    USB.CNTR.raw = 0;
    USB.ISTR.raw = 0;

    for (config.endpoints) |ep_conf| {
        const epc_num: usize = @intFromEnum(ep_conf.ep_control);
        endpoints[epc_num] = ep_conf;
    }
    try PMA.btable_init(PMA_conf);

    reset_callback = config.reset_callback;
    reset_ctx = config.reset_args;
    error_callback = config.error_callback;
    error_ctx = config.error_args;
    iner_RX_buffer = config.RX_buffer;

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
    const valid: u2 = @as(u2, @intFromEnum(corrent.STAT_RX)) ^ @as(u2, @intFromEnum(status));
    const DTOG_val = switch (pid) {
        .no_change, .endpoint_ctr => @as(u1, 0),
        .force_data0 => corrent.DTOG_RX,
        .force_data1 => corrent.DTOG_RX ^ @as(u1, 1),
    };
    USB.EPR[EPC].modify(.{
        .STAT_RX = @as(USBTypes.STAT, @enumFromInt(valid)),
        .DTOG_RX = DTOG_val,
        .STAT_TX = @as(USBTypes.STAT, @enumFromInt(0)),
        .DTOG_TX = 0,
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
        .STAT_RX = @as(USBTypes.STAT, @enumFromInt(0)),
        .DTOG_RX = 0,
    });
}

fn change_status(dir: StatusDir, status: USBTypes.STAT, pid: PID, EPC: usize) void {
    const endpoint = &endpoints[EPC].?;

    const call: *const fn (USBTypes.STAT, PID, usize) void = switch (dir) {
        .RX => change_rx_status,
        .TX => change_tx_status,
    };

    const new_pid = switch (pid) {
        .endpoint_ctr => endpoint.get_pid(dir),
        .force_data0, .force_data1 => |p| endpoint.force_change(dir, p),
        else => |some| some,
    };

    call(status, new_pid, EPC);
}

pub fn get_epc_from_ep(ep: usize) ?EpControl {
    for (endpoints) |eps| {
        if (eps) |valid| {
            if (valid.endpoint == ep) return valid.EpControl;
        }
    }
    return null;
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

pub fn usb_handler() callconv(.c) void {
    const event = USB.ISTR.read();
    if (event.RESET == 1) {
        USB.ISTR.modify(.{ .RESET = 0 });
        if (reset_callback) |callback| {
            callback(reset_ctx);
        } else {
            default_reset_handler();
        }
    }

    if (event.CTR == 1) {
        USB.ISTR.modify(.{ .CTR = 0 });
        const ep = event.EP_ID;
        const EPR = USB.EPR[ep].read();
        if (endpoints[ep]) |*epc| {
            if (EPR.CTR_RX == 1) {
                USB.EPR[ep].modify(.{
                    .CTR_RX = 0,
                    .STAT_RX = @as(USBTypes.STAT, @enumFromInt(0)),
                    .DTOG_RX = 0,
                    .STAT_TX = @as(USBTypes.STAT, @enumFromInt(0)),
                    .DTOG_TX = 0,
                });
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
                USB.EPR[ep].modify(.{
                    .CTR_TX = 0,
                    .STAT_RX = @as(USBTypes.STAT, @enumFromInt(0)),
                    .DTOG_RX = 0,
                    .STAT_TX = @as(USBTypes.STAT, @enumFromInt(0)),
                    .DTOG_TX = 0,
                });
                epc.toggle_pid(.TX);
                if (epc.tx_callback) |callback| {
                    callback(epc.ep_control, epc.user_param);
                }
            }
        }
    }
}
