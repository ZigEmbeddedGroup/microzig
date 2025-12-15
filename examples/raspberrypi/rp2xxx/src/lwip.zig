const std = @import("std");
const log = std.log.scoped(.lwip);

const c = @cImport({
    @cInclude("lwip/init.h");
    @cInclude("lwip/tcpip.h");
    @cInclude("lwip/netif.h");
    @cInclude("lwip/dhcp.h");
    @cInclude("lwip/tcp.h");
    @cInclude("lwip/udp.h");
    @cInclude("lwip/etharp.h");
    @cInclude("lwip/ethip6.h");
    @cInclude("lwip/timeouts.h");
});

const Self = @This();

netif: c.struct_netif = .{},
dhcp: c.struct_dhcp = .{},

mac: [6]u8,
link: struct {
    ptr: *anyopaque,
    recv: *const fn (*anyopaque) anyerror!?[]const u8,
    send: *const fn (*anyopaque, []const u8) anyerror!void,
},
tx_buffer: []u8,

pub fn init(self: *Self) !void {
    c.lwip_init();
    const netif: *c.netif = &self.netif;

    _ = c.netif_add(
        netif,
        @as(*c.ip4_addr_t, @ptrCast(@constCast(c.IP4_ADDR_ANY))), // ipaddr
        @as(*c.ip4_addr_t, @ptrCast(@constCast(c.IP4_ADDR_ANY))), // netmask
        @as(*c.ip4_addr_t, @ptrCast(@constCast(c.IP4_ADDR_ANY))), // gw
        null,
        netif_init,
        c.netif_input,
    ) orelse return error.OutOfMemory;

    c.netif_create_ip6_linklocal_address(netif, 1);
    netif.ip6_autoconfig_enabled = 1;
    c.netif_set_status_callback(netif, netif_status_callback);
    c.netif_set_default(netif);

    c.dhcp_set_struct(netif, &self.dhcp);
    c.netif_set_up(netif);
    try c_err(c.dhcp_start(netif));
    c.netif_set_link_up(netif);
}

fn netif_init(netif_c: [*c]c.netif) callconv(.c) c.err_t {
    const netif: *c.netif = netif_c;
    const self: *Self = @fieldParentPtr("netif", netif);

    netif.linkoutput = netif_linkoutput;
    netif.output = c.etharp_output;
    netif.output_ip6 = c.ethip6_output;
    netif.mtu = 1500;
    netif.flags = c.NETIF_FLAG_BROADCAST | c.NETIF_FLAG_ETHARP | c.NETIF_FLAG_ETHERNET | c.NETIF_FLAG_IGMP | c.NETIF_FLAG_MLD6;
    std.mem.copyForwards(u8, &netif.hwaddr, &self.mac);
    netif.hwaddr_len = c.ETH_HWADDR_LEN;
    return c.ERR_OK;
}

fn netif_status_callback(netif_c: [*c]c.netif) callconv(.c) void {
    const netif: *c.netif = netif_c;
    log.info("netif changed ip to {f}", .{IPFormatter.new(netif.ip_addr)});
}

fn netif_linkoutput(netif_c: [*c]c.netif, pbuf_c: [*c]c.pbuf) callconv(.c) c.err_t {
    const netif: *c.netif = netif_c;
    var pbuf: *c.pbuf = pbuf_c;
    const self: *Self = @fieldParentPtr("netif", netif);

    // TODO what to retrun if send is not ready
    var tx_buffer = self.tx_buffer;
    var tx_pos: usize = 0;

    const tot_len = pbuf.tot_len;
    while (true) {
        if (pbuf.payload) |ptr| {
            var buf: []const u8 = @as([*]u8, @ptrCast(ptr))[0..pbuf.len];
            //log.debug("sending tot_len: {} , len: {} bytes {any}", .{ pbuf.tot_len, pbuf.len, payload });
            if (&buf[0] != &tx_buffer[tx_pos]) {
                @memcpy(tx_buffer[tx_pos..][0..buf.len], buf);
                //log.debug("memcpy {} {x} {b}", .{ buf.len, @intFromPtr(buf.ptr), @intFromPtr(buf.ptr) });
            } else {
                //log.debug("skip memcpy {}", .{buf.len});
            }
            tx_pos += buf.len;
            if (tx_pos >= tot_len) break;
        } else {
            break;
        }
        pbuf = pbuf.next;
    }
    if (tx_pos > 0) {
        //log.debug("send buf: {} {x}", .{ tx_pos, tx_buffer[0..@min(64, tx_pos)] });
        self.link.send(self.link.ptr, tx_buffer[0..tx_pos]) catch return c.ERR_ARG;
    }
    return c.ERR_OK;
}

pub fn ready(self: *Self) bool {
    const netif = &self.netif;
    return (netif.flags & c.NETIF_FLAG_UP > 0) and
        (netif.flags & c.NETIF_FLAG_LINK_UP > 0) and
        (netif.ip_addr.u_addr.ip4.addr != 0 or netif.ip_addr.u_addr.ip6.addr[0] != 0);
}

pub fn poll(self: *Self) !void {
    while (try self.link.recv(self.link.ptr)) |buf| {
        const pbuf: *c.struct_pbuf = c.pbuf_alloc(c.PBUF_RAW, @intCast(buf.len), c.PBUF_REF);
        defer _ = c.pbuf_free(pbuf);
        pbuf.payload = @constCast(buf.ptr);
        try c_err(self.netif.input.?(pbuf, &self.netif));
    }
    c.sys_check_timeouts();
}

pub const Udp = struct {
    pcb: c.udp_pcb = .{},
    addr: c.ip_addr_t = .{},
    port: u16 = 0,

    fn init(udp: *Udp, net: *Self, target: []const u8, port: u16) !void {
        if (c.ipaddr_aton(target.ptr, &udp.addr) != 1) return error.IpAddrParse;
        c.udp_bind_netif(&udp.pcb, &net.netif);
        udp.port = port;
        udp.pcb.ttl = 64;
    }

    pub fn send(udp: *Udp, buf: []const u8) !void {
        const pbuf: *c.struct_pbuf = c.pbuf_alloc(c.PBUF_TRANSPORT, @intCast(buf.len), c.PBUF_POOL);
        defer _ = c.pbuf_free(pbuf);
        try c_err(c.pbuf_take(pbuf, buf.ptr, @intCast(buf.len)));
        try c_err(c.udp_sendto(&udp.pcb, pbuf, &udp.addr, udp.port));
    }
};

pub fn udp_init(self: *Self, udp: *Udp, target: []const u8, port: u16) !void {
    try udp.init(self, target, port);
}

const LwipError = error{
    /// Out of memory error.
    OutOfMemory,
    /// Buffer error.
    BufferError,
    /// Timeout.
    Timeout,
    /// Routing problem.
    Routing,
    /// Operation in progress
    InProgress,
    /// Illegal value.
    IllegalValue,
    /// Operation would block.
    WouldBlock,
    /// Address in use.
    AddressInUse,
    /// Already connecting.
    AlreadyConnecting,
    /// Conn already established.
    AlreadyConnected,
    /// Not connected.
    NotConnected,
    /// Low-level netif error
    LowlevelInterfaceError,
    /// Connection aborted.
    ConnectionAborted,
    /// Connection reset.
    ConnectionReset,
    /// Connection closed.
    ConnectionClosed,
    /// Illegal argument.
    IllegalArgument,
};

fn c_err(err: c.err_t) LwipError!void {
    return switch (err) {
        c.ERR_OK => {},
        c.ERR_MEM => LwipError.OutOfMemory,
        c.ERR_BUF => LwipError.BufferError,
        c.ERR_TIMEOUT => LwipError.Timeout,
        c.ERR_RTE => LwipError.Routing,
        c.ERR_INPROGRESS => LwipError.InProgress,
        c.ERR_VAL => LwipError.IllegalValue,
        c.ERR_WOULDBLOCK => LwipError.WouldBlock,
        c.ERR_USE => LwipError.AddressInUse,
        c.ERR_ALREADY => LwipError.AlreadyConnecting,
        c.ERR_ISCONN => LwipError.AlreadyConnected,
        c.ERR_CONN => LwipError.NotConnected,
        c.ERR_IF => LwipError.LowlevelInterfaceError,
        c.ERR_ABRT => LwipError.ConnectionAborted,
        c.ERR_RST => LwipError.ConnectionReset,
        c.ERR_CLSD => LwipError.ConnectionClosed,
        c.ERR_ARG => LwipError.IllegalArgument,
        else => {
            log.err("error code: {}", .{err});
            @panic("unexpected lwip error code!");
        },
    };
}

const IPFormatter = struct {
    addr: c.ip_addr_t,

    pub fn new(addr: c.ip_addr_t) IPFormatter {
        return IPFormatter{ .addr = addr };
    }

    pub fn format(
        addr: IPFormatter,
        writer: anytype,
    ) !void {
        try writer.writeAll(std.mem.sliceTo(c.ip4addr_ntoa(@as(*const c.ip4_addr_t, @ptrCast(&addr.addr))), 0));
    }
};

// exports required by lwip

export fn net_lock_interrupts(were_enabled: *bool) void {
    _ = were_enabled;
}

export fn net_unlock_interrupts(enable: bool) void {
    _ = enable;
}

export fn net_rand() u32 {
    // TODO: Improve this
    return 4; // chose by a fair dice roll
}

export fn __aeabi_read_tp() u32 {
    return 0;
}
