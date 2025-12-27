/// Platform independent network library. Connects lwip with underlying network
/// link interface.
const std = @import("std");

const log = std.log.scoped(.lwip);
const assert = std.debug.assert;

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

netif: c.netif = .{},
dhcp: c.dhcp = .{},

mac: [6]u8,
link: struct {
    ptr: *anyopaque,
    recv: *const fn (*anyopaque, []u8) anyerror!?struct { usize, usize },
    send: *const fn (*anyopaque, []u8) anyerror!void,
    ready: *const fn (*anyopaque) bool,
},

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
    netif.mtu = sz.mtu;
    netif.flags = c.NETIF_FLAG_BROADCAST | c.NETIF_FLAG_ETHARP | c.NETIF_FLAG_ETHERNET | c.NETIF_FLAG_IGMP | c.NETIF_FLAG_MLD6;
    std.mem.copyForwards(u8, &netif.hwaddr, &self.mac);
    netif.hwaddr_len = c.ETH_HWADDR_LEN;
    return c.ERR_OK;
}

fn netif_status_callback(netif_c: [*c]c.netif) callconv(.c) void {
    const netif: *c.netif = netif_c;
    const self: *Self = @fieldParentPtr("netif", netif);
    log.debug("netif status callback is_link_up: {}, is_up: {}, ready: {}, ip: {f}", .{
        netif.flags & c.NETIF_FLAG_LINK_UP > 0,
        netif.flags & c.NETIF_FLAG_UP > 0,
        self.ready(),
        IPFormatter.new(netif.ip_addr),
    });
}

/// Called by lwip when there is packet to send.
/// pbuf chain total_len is <= netif.mtu + ethernet header
fn netif_linkoutput(netif_c: [*c]c.netif, pbuf_c: [*c]c.pbuf) callconv(.c) c.err_t {
    const netif: *c.netif = netif_c;
    var pbuf: *c.pbuf = pbuf_c;
    const self: *Self = @fieldParentPtr("netif", netif);

    if (!self.link.ready(self.link.ptr)) {
        log.err("linkouput link not ready", .{});
        return c.ERR_MEM; // lwip will try later
    }

    if (c.pbuf_header(pbuf, sz.link_head) != 0) {
        log.err("can't get pbuf headroom len: {}, tot_len: {} ", .{ pbuf.len, pbuf.tot_len });
        return c.ERR_ARG;
    }

    if (pbuf.next != null) {
        // clone chain into single packet buffer
        pbuf = c.pbuf_clone(c.PBUF_RAW, c.PBUF_POOL, pbuf) orelse return c.ERR_MEM;
    }
    defer {
        // free local clone is clone was made
        if (pbuf_c.*.next != null) _ = c.pbuf_free(pbuf);
    }

    self.link.send(self.link.ptr, payload_bytes(pbuf)) catch |err| {
        log.err("link send {}", .{err});
        return c.ERR_ARG;
    };
    return c.ERR_OK;
}

fn payload_bytes(pbuf: *c.pbuf) []u8 {
    return @as([*]u8, @ptrCast(pbuf.payload.?))[0..pbuf.len];
}

pub fn ready(self: *Self) bool {
    const netif = &self.netif;
    return (netif.flags & c.NETIF_FLAG_UP > 0) and
        (netif.flags & c.NETIF_FLAG_LINK_UP > 0) and
        (netif.ip_addr.u_addr.ip4.addr != 0 or netif.ip_addr.u_addr.ip6.addr[0] != 0);
}

pub fn poll(self: *Self) !void {
    var mem_err_count: usize = 0;
    while (true) {
        // get packet buffer of the max size
        const pbuf: *c.pbuf = c.pbuf_alloc(c.PBUF_RAW, sz.pbuf_pool, c.PBUF_POOL) orelse {
            if (mem_err_count > 2) {
                self.log_stats();
                return error.OutOfMemory;
            }
            mem_err_count += 1;
            c.sys_check_timeouts();
            continue;
        };
        mem_err_count = 0;
        assert(pbuf.next == null);
        assert(pbuf.len == pbuf.tot_len and pbuf.len == sz.pbuf_pool);

        // receive into that buffer
        const head, const len = try self.link.recv(self.link.ptr, payload_bytes(pbuf)) orelse {
            // no data release packet buffer and exit loop
            _ = c.pbuf_free(pbuf);
            break;
        };
        errdefer _ = c.pbuf_free(pbuf); // netif.input: transfers ownership of pbuf on success
        // set payload header and len
        if (c.pbuf_header(pbuf, -@as(c.s16_t, @intCast(head))) != 0) return error.InvalidPbufHead;
        pbuf.len = @intCast(len);
        pbuf.tot_len = @intCast(len);
        // pass data to the lwip input function
        try c_err(self.netif.input.?(pbuf, &self.netif));
    }
    c.sys_check_timeouts();
}

pub fn log_stats(self: *Self) void {
    _ = self;
    const stats = c.lwip_stats;
    log.debug("stats ip_frag: {}", .{stats.ip_frag});
    log.debug("stats icpmp: {}", .{stats.icmp});
    log.debug("stats mem: {} ", .{stats.mem});
    for (stats.memp, 0..) |s, i| {
        log.debug("stats memp {}: {}", .{ i, s.* });
    }
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

    pub fn send(udp: *Udp, data: []const u8) !void {
        const pbuf: *c.pbuf = c.pbuf_alloc(c.PBUF_TRANSPORT, @intCast(data.len), c.PBUF_POOL) orelse return error.OutOfMemory;
        defer _ = c.pbuf_free(pbuf);
        try c_err(c.pbuf_take(pbuf, data.ptr, @intCast(data.len)));
        try c_err(c.udp_sendto(&udp.pcb, pbuf, &udp.addr, udp.port));
    }
};

pub fn udp_init(self: *Self, udp: *Udp, target: []const u8, port: u16) !void {
    try udp.init(self, target, port);
}

const Error = error{
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
    ///
    Unknown,
};

fn c_err(res: anytype) Error!void {
    switch (@TypeOf(res)) {
        c.err_t => return switch (res) {
            c.ERR_OK => {},
            c.ERR_MEM => Error.OutOfMemory,
            c.ERR_BUF => Error.BufferError,
            c.ERR_TIMEOUT => Error.Timeout,
            c.ERR_RTE => Error.Routing,
            c.ERR_INPROGRESS => Error.InProgress,
            c.ERR_VAL => Error.IllegalValue,
            c.ERR_WOULDBLOCK => Error.WouldBlock,
            c.ERR_USE => Error.AddressInUse,
            c.ERR_ALREADY => Error.AlreadyConnecting,
            c.ERR_ISCONN => Error.AlreadyConnected,
            c.ERR_CONN => Error.NotConnected,
            c.ERR_IF => Error.LowlevelInterfaceError,
            c.ERR_ABRT => Error.ConnectionAborted,
            c.ERR_RST => Error.ConnectionReset,
            c.ERR_CLSD => Error.ConnectionClosed,
            c.ERR_ARG => Error.IllegalArgument,
            else => {
                log.err("error code: {}", .{res});
                @panic("unexpected lwip error code!");
            },
        },
        c.u8_t => {
            if (res != 0) {
                return Error.Unknown;
            }
        },
        else => @compileError("unknown type"),
    }
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

// required buffer sizes
const sz = struct {
    const pbuf_pool = c.PBUF_POOL_BUFSIZE; // 1540 = 1500 mtu + ethernet + link head/tail
    const link_head = c.PBUF_LINK_ENCAPSULATION_HLEN; // 22
    const link_tail = 4; // reserved for the status in recv buffer
    const ethernet = 14; // layer 2 ethernet header size

    // layer 3 (ip) mtu,
    const mtu = pbuf_pool - link_head - link_tail - ethernet; // 1500

    // ip v4 sizes
    const v4 = struct {
        // headers
        const ip = 20;
        const udp = 8;
        const tcp = 20;

        const payload = struct {
            const udp = mtu - ip - v4.udp; // 1472
        };
    };
};

// test lwipopts.h config
comptime {
    assert(sz.pbuf_pool == 1540);
    assert(sz.link_head == 22);
    assert(sz.mtu == 1500);
}
