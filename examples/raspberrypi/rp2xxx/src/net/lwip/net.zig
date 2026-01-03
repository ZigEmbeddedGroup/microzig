/// Platform independent network library. Connects lwip with underlying network
/// link interface.
const std = @import("std");
const assert = std.debug.assert;

pub const lwip = @cImport({
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

const log = std.log.scoped(.lwip);

pub const Interface = struct {
    const Self = @This();

    netif: lwip.netif = .{},
    dhcp: lwip.dhcp = .{},

    mac: [6]u8,
    link: struct {
        ptr: *anyopaque,
        recv: *const fn (*anyopaque, []u8) anyerror!?struct { usize, usize },
        send: *const fn (*anyopaque, []u8) anyerror!void,
        ready: *const fn (*anyopaque) bool,
    },

    pub const Options = struct {
        fixed: ?Fixed = null,

        pub const Fixed = struct {
            ip: lwip.ip4_addr,
            netmask: lwip.ip4_addr,
            gw: lwip.ip4_addr,

            pub fn init(ip: []const u8, netmask: []const u8, gw: []const u8) !Fixed {
                var f: Fixed = undefined;
                if (lwip.ip4addr_aton(ip.ptr, &f.ip) != 1 or
                    lwip.ip4addr_aton(netmask.ptr, &f.netmask) != 1 or
                    lwip.ip4addr_aton(gw.ptr, &f.gw) != 1)
                    return error.IpAddrParse;
                return f;
            }
        };
    };

    pub fn init(self: *Self, opt: Options) !void {
        lwip.lwip_init();
        const netif: *lwip.netif = &self.netif;

        if (opt.fixed) |fixed| {
            _ = lwip.netif_add(
                netif,
                &fixed.ip,
                &fixed.netmask,
                &fixed.gw,
                null,
                netif_init,
                lwip.netif_input,
            ) orelse return error.OutOfMemory;
        } else {
            _ = lwip.netif_add_noaddr(
                netif,
                null,
                netif_init,
                lwip.netif_input,
            ) orelse return error.OutOfMemory;
        }

        lwip.netif_create_ip6_linklocal_address(netif, 1);
        netif.ip6_autoconfig_enabled = 1;
        lwip.netif_set_status_callback(netif, netif_status_callback);
        lwip.netif_set_default(netif);
        lwip.netif_set_up(netif);
        if (opt.fixed == null) {
            lwip.dhcp_set_struct(netif, &self.dhcp);
            try c_err(lwip.dhcp_start(netif));
        }
        lwip.netif_set_link_up(netif);
    }

    fn netif_init(netif_c: [*c]lwip.netif) callconv(.c) lwip.err_t {
        const netif: *lwip.netif = netif_c;
        const self: *Self = @fieldParentPtr("netif", netif);

        netif.linkoutput = netif_linkoutput;
        netif.output = lwip.etharp_output;
        netif.output_ip6 = lwip.ethip6_output;
        netif.mtu = sz.mtu;
        netif.flags = lwip.NETIF_FLAG_BROADCAST | lwip.NETIF_FLAG_ETHARP | lwip.NETIF_FLAG_ETHERNET | lwip.NETIF_FLAG_IGMP | lwip.NETIF_FLAG_MLD6;
        std.mem.copyForwards(u8, &netif.hwaddr, &self.mac);
        netif.hwaddr_len = lwip.ETH_HWADDR_LEN;
        return lwip.ERR_OK;
    }

    fn netif_status_callback(netif_c: [*c]lwip.netif) callconv(.c) void {
        const netif: *lwip.netif = netif_c;
        const self: *Self = @fieldParentPtr("netif", netif);
        log.debug("netif status callback is_link_up: {}, is_up: {}, ready: {}, ip: {f}", .{
            netif.flags & lwip.NETIF_FLAG_LINK_UP > 0,
            netif.flags & lwip.NETIF_FLAG_UP > 0,
            self.ready(),
            IPFormatter.new(netif.ip_addr),
        });
    }

    /// Called by lwip when there is packet to send.
    /// pbuf chain total_len is <= netif.mtu + ethernet header
    fn netif_linkoutput(netif_c: [*c]lwip.netif, pbuf_c: [*c]lwip.pbuf) callconv(.c) lwip.err_t {
        const netif: *lwip.netif = netif_c;
        var pbuf: *lwip.pbuf = pbuf_c;
        const self: *Self = @fieldParentPtr("netif", netif);

        if (!self.link.ready(self.link.ptr)) {
            log.err("linkouput link not ready", .{});
            return lwip.ERR_MEM; // lwip will try later
        }

        if (lwip.pbuf_header(pbuf, sz.link_head) != 0) {
            log.err("can't get pbuf headroom len: {}, tot_len: {} ", .{ pbuf.len, pbuf.tot_len });
            return lwip.ERR_ARG;
        }

        if (pbuf.next != null) {
            // clone chain into single packet buffer
            pbuf = lwip.pbuf_clone(lwip.PBUF_RAW, lwip.PBUF_POOL, pbuf) orelse return lwip.ERR_MEM;
        }
        defer {
            // free local pbuf clone (if clone was made)
            if (pbuf_c.*.next != null) _ = lwip.pbuf_free(pbuf);
        }

        self.link.send(self.link.ptr, payload_bytes(pbuf)) catch |err| {
            log.err("link send {}", .{err});
            return lwip.ERR_ARG;
        };
        return lwip.ERR_OK;
    }

    pub fn ready(self: *Self) bool {
        const netif = &self.netif;
        return (netif.flags & lwip.NETIF_FLAG_UP > 0) and
            (netif.flags & lwip.NETIF_FLAG_LINK_UP > 0) and
            (netif.ip_addr.u_addr.ip4.addr != 0 or netif.ip_addr.u_addr.ip6.addr[0] != 0);
    }

    pub fn poll(self: *Self) !void {
        lwip.sys_check_timeouts();
        var packets: usize = 0;
        while (true) : (packets += 1) {
            // get packet buffer of the max size
            const pbuf: *lwip.pbuf = lwip.pbuf_alloc(lwip.PBUF_RAW, sz.pbuf_pool, lwip.PBUF_POOL) orelse return error.OutOfMemory;
            assert(pbuf.next == null);
            assert(pbuf.len == pbuf.tot_len and pbuf.len == sz.pbuf_pool);

            // receive into that buffer
            const head, const len = try self.link.recv(self.link.ptr, payload_bytes(pbuf)) orelse {
                // no data release packet buffer and exit loop
                _ = lwip.pbuf_free(pbuf);
                break;
            };
            errdefer _ = lwip.pbuf_free(pbuf); // netif.input: transfers ownership of pbuf on success
            // set payload header and len
            if (lwip.pbuf_header(pbuf, -@as(lwip.s16_t, @intCast(head))) != 0) return error.InvalidPbufHead;
            pbuf.len = @intCast(len);
            pbuf.tot_len = @intCast(len);
            // pass data to the lwip input function
            try c_err(self.netif.input.?(pbuf, &self.netif));
        }
        if (packets > 0) {
            lwip.sys_check_timeouts();
        }
    }

    pub fn log_stats(self: *Self) void {
        _ = self;
        const stats = lwip.lwip_stats;
        log.debug("stats ip_frag: {}", .{stats.ip_frag});
        log.debug("stats icpmp: {}", .{stats.icmp});
        log.debug("stats mem: {} ", .{stats.mem});
        for (stats.memp, 0..) |s, i| {
            log.debug("stats memp {}: {}", .{ i, s.* });
        }
    }
};

fn payload_bytes(pbuf: *lwip.pbuf) []u8 {
    return @as([*]u8, @ptrCast(pbuf.payload.?))[0..pbuf.len];
}

pub const Udp = struct {
    const Self = @This();

    pub const RecvOptions = struct {
        src: Endpoint,
        /// If udp packet is fragmented into multiple lwip packet buffers (pbuf)
        /// this will be false for all expect the last fragment.
        last_fragment: bool,
    };
    const OnRecv = *const fn (*Self, []u8, RecvOptions) void;

    pcb: *lwip.udp_pcb,
    on_recv: ?OnRecv = null,

    pub fn init(nic: *Interface) !Self {
        const pcb: *lwip.udp_pcb = lwip.udp_new() orelse return error.OutOfMemory;
        lwip.udp_bind_netif(pcb, &nic.netif);
        pcb.ttl = 64;
        return .{
            .pcb = pcb,
        };
    }

    pub fn send(self: *Self, data: []const u8, target: Endpoint) !void {
        const pbuf: *lwip.pbuf = lwip.pbuf_alloc(lwip.PBUF_TRANSPORT, @intCast(data.len), lwip.PBUF_POOL) orelse return error.OutOfMemory;
        defer _ = lwip.pbuf_free(pbuf);
        try c_err(lwip.pbuf_take(pbuf, data.ptr, @intCast(data.len)));
        try c_err(lwip.udp_sendto(self.pcb, pbuf, &target.addr, target.port));
    }

    pub fn bind(self: *Self, port: u16, on_recv: OnRecv) !void {
        assert(self.on_recv == null);
        self.on_recv = on_recv;
        try c_err(lwip.udp_bind(self.pcb, lwip.IP_ADDR_ANY, port));
        lwip.udp_recv(self.pcb, Self.c_on_recv, self);
    }

    fn c_on_recv(
        ptr: ?*anyopaque,
        _: [*c]lwip.udp_pcb,
        pbuf_c: [*c]lwip.pbuf,
        addr_c: [*c]const lwip.ip_addr,
        port: u16,
    ) callconv(.c) void {
        var pbuf: *lwip.pbuf = pbuf_c;
        const addr: lwip.ip_addr = addr_c[0];
        const self: *Self = @ptrCast(@alignCast(ptr.?));
        defer _ = lwip.pbuf_free(pbuf_c);

        while (true) {
            const last_fragment = pbuf.next == null;
            self.on_recv.?(self, payload_bytes(pbuf), .{
                .last_fragment = last_fragment,
                .src = .{ .addr = addr, .port = port },
            });
            if (last_fragment) break;
            pbuf = pbuf.next;
        }
    }
};

pub const tcp = struct {
    pub fn connect(nic: *Interface, conn: *Connection, target: *Endpoint) !void {
        if (conn.pcb != null or conn.state == .open) return Error.AlreadyConnected;
        if (conn.state != .closed) return Error.AlreadyConnecting;
        conn.nic = nic;

        const pcb: *lwip.tcp_pcb = lwip.tcp_new() orelse return Error.OutOfMemory;
        lwip.tcp_arg(pcb, conn);
        lwip.tcp_err(pcb, Connection.c_on_err);

        errdefer _ = lwip.tcp_close(pcb);
        try c_err(lwip.tcp_connect(pcb, &target.addr, target.port, Connection.c_on_connect));
    }

    pub const Connection = struct {
        const Self = @This();

        const State = enum {
            closed,
            connecting,
            open,
        };

        const OnClose = *const fn (*Self, Error) void;
        const OnRecv = *const fn (*Self, []u8) void;
        const OnSent = *const fn (*Self, u16) void;
        const OnConnect = *const fn (*Self) void;

        nic: ?*Interface = null,
        pcb: ?*lwip.tcp_pcb = null,
        state: State = .closed,
        on_close: ?OnClose = null,
        on_recv: ?OnRecv = null,
        on_sent: ?OnSent = null,
        on_connect: ?OnConnect = null,

        fn open(self: *Self, pcb: *lwip.tcp_pcb) void {
            assert(self.nic != null);
            lwip.tcp_bind_netif(pcb, &self.nic.?.netif);
            lwip.tcp_arg(pcb, self);
            lwip.tcp_recv(pcb, c_on_recv);
            lwip.tcp_sent(pcb, c_on_sent);
            lwip.tcp_err(pcb, c_on_err);
            self.pcb = pcb;
            self.state = .open;
            if (self.on_connect) |cb| cb(self);
        }

        fn c_on_err(ptr: ?*anyopaque, ce: lwip.err_t) callconv(.c) void {
            const self: *Self = @ptrCast(@alignCast(ptr.?));
            // The corresponding pcb is already freed when this callback is called!
            // https://www.nongnu.org/lwip/2_1_x/group__tcp__raw.html#gae1346c4e34d3bc7c01e1b47142ab3121
            self.pcb = null;
            if (self.state != .closed) {
                self.state = .closed;
                if (self.on_close) |cb| cb(self, to_error(ce) orelse return);
            }
        }

        fn c_on_connect(ptr: ?*anyopaque, c_pcb: [*c]lwip.tcp_pcb, ce: lwip.err_t) callconv(.c) lwip.err_t {
            if (ce != lwip.ERR_OK) return ce; // it is always 0
            const self: *Self = @ptrCast(@alignCast(ptr.?));
            assert(self.pcb == null);
            assert(self.state == .closed);
            self.open(c_pcb);
            return lwip.ERR_OK;
        }

        fn c_on_recv(ptr: ?*anyopaque, _: [*c]lwip.tcp_pcb, c_pbuf: [*c]lwip.pbuf, ce: lwip.err_t) callconv(.c) lwip.err_t {
            const self: *Self = @ptrCast(@alignCast(ptr.?));
            if (c_pbuf == null) {
                // peer clean close received
                var ret: lwip.err_t = lwip.ERR_OK;
                if (self.pcb != null) {
                    self.close() catch |err| {
                        log.err("c_on_recv close unexpected {}", .{err});
                        ret = lwip.ERR_ABRT;
                    };
                    if (self.on_close) |cb| cb(self, Error.EndOfStream);
                }
                return ret;
            }
            defer _ = lwip.pbuf_free(c_pbuf);

            if (to_error(ce)) |err| {
                if (self.on_close) |cb| cb(self, err);
                return lwip.ERR_OK;
            }

            var pbuf: *lwip.pbuf = c_pbuf;
            while (true) {
                if (self.on_recv) |cb| cb(self, payload_bytes(pbuf));
                if (pbuf.next == null) break;
                pbuf = pbuf.next;
            }
            if (self.pcb) |pcb| {
                lwip.tcp_recved(pcb, c_pbuf.*.tot_len);
            }
            return lwip.ERR_OK;
        }

        fn c_on_sent(ptr: ?*anyopaque, _: [*c]lwip.tcp_pcb, n: u16) callconv(.c) lwip.err_t {
            const self: *Self = @ptrCast(@alignCast(ptr.?));
            if (self.on_sent) |cb| cb(self, n);
            return lwip.ERR_OK;
        }

        pub fn send(self: *Self, bytes: []const u8) !void {
            const pcb = self.pcb orelse return Error.NotConnected;
            try c_err(lwip.tcp_write(pcb, bytes.ptr, @intCast(bytes.len), lwip.TCP_WRITE_FLAG_COPY));
            try c_err(lwip.tcp_output(pcb));
        }

        pub fn close(self: *Self) !void {
            const pcb = self.pcb orelse return Error.NotConnected;
            self.pcb = null;
            self.state = .closed;
            c_err(lwip.tcp_close(pcb)) catch |err| {
                lwip.tcp_abort(pcb);
                return err;
            };
        }

        /// Number of bytes currently available in the TCP send buffer for a
        /// given TCP connection.
        pub fn send_buffer(self: *Self) u16 {
            const pcb = self.pcb orelse return lwip.TCP_SND_BUF;
            return lwip.tcp_sndbuf(pcb);
        }

        pub fn limits(self: *Self) void {
            log.debug(
                "tcp limits current snd_buf: {}, max snd_buf: {}, mss: {}, wnd: {}, snd_queuelen: {}",
                .{ self.send_buffer(), lwip.TCP_SND_BUF, lwip.TCP_MSS, lwip.TCP_WND, lwip.TCP_SND_QUEUELEN },
            );
        }
    };

    pub const Server = struct {
        const Self = @This();

        const OnAccept = *const fn () ?*Connection;

        nic: *Interface,
        on_accept: OnAccept,
        pcb: ?*lwip.tcp_pcb = null,

        pub fn bind(self: *Self, port: u16) !void {
            const pcb: *lwip.tcp_pcb = lwip.tcp_new() orelse return Error.OutOfMemory;

            errdefer _ = lwip.tcp_close(pcb);
            try c_err(lwip.tcp_bind(pcb, lwip.IP_ADDR_ANY, port));
            self.pcb = lwip.tcp_listen(pcb);
            lwip.tcp_arg(self.pcb, self);
            lwip.tcp_accept(self.pcb, c_on_accept);
        }

        fn c_on_accept(ptr: ?*anyopaque, pcb: [*c]lwip.tcp_pcb, ce: lwip.err_t) callconv(.c) lwip.err_t {
            const self: *Self = @ptrCast(@alignCast(ptr.?));
            if (to_error(ce)) |err| {
                log.err("c_on_accept {}", .{err});
                return lwip.ERR_OK;
            }
            var conn = self.on_accept() orelse {
                lwip.tcp_abort(pcb);
                return lwip.ERR_ABRT;
            };
            conn.nic = self.nic;
            conn.open(pcb);
            return lwip.ERR_OK;
        }
    };
};

pub const Endpoint = struct {
    addr: lwip.ip_addr = .{},
    port: u16 = 0,

    pub fn format(self: Endpoint, writer: anytype) !void {
        try writer.writeAll(std.mem.sliceTo(lwip.ip4addr_ntoa(@as(*const lwip.ip4_addr_t, @ptrCast(&self.addr))), 0));
        var buf: [16]u8 = undefined;
        try writer.writeAll(std.fmt.bufPrint(&buf, ":{}", .{self.port}) catch "");
    }

    pub fn parse(ip: []const u8, port: u16) !Endpoint {
        var target: Endpoint = .{ .port = port };
        if (lwip.ipaddr_aton(ip.ptr, &target.addr) != 1) return error.IpAddrParse;
        return target;
    }
};

pub const Error = error{
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
    /// All other errors.
    Unknown,
    /// Clean tcp close.
    EndOfStream,
};

fn to_error(e: lwip.err_t) ?Error {
    return switch (e) {
        lwip.ERR_OK => null,
        lwip.ERR_MEM => Error.OutOfMemory,
        lwip.ERR_BUF => Error.BufferError,
        lwip.ERR_TIMEOUT => Error.Timeout,
        lwip.ERR_RTE => Error.Routing,
        lwip.ERR_INPROGRESS => Error.InProgress,
        lwip.ERR_VAL => Error.IllegalValue,
        lwip.ERR_WOULDBLOCK => Error.WouldBlock,
        lwip.ERR_USE => Error.AddressInUse,
        lwip.ERR_ALREADY => Error.AlreadyConnecting,
        lwip.ERR_ISCONN => Error.AlreadyConnected,
        lwip.ERR_CONN => Error.NotConnected,
        lwip.ERR_IF => Error.LowlevelInterfaceError,
        lwip.ERR_ABRT => Error.ConnectionAborted,
        lwip.ERR_RST => Error.ConnectionReset,
        lwip.ERR_CLSD => Error.ConnectionClosed,
        lwip.ERR_ARG => Error.IllegalArgument,
        else => Error.Unknown,
    };
}

fn c_err(res: anytype) Error!void {
    switch (@TypeOf(res)) {
        lwip.err_t => return to_error(res) orelse return,
        lwip.u8_t => if (res != 0) {
            return Error.Unknown;
        },
        else => @compileError("unknown type"),
    }
}

const IPFormatter = struct {
    addr: lwip.ip_addr_t,

    pub fn new(addr: lwip.ip_addr_t) IPFormatter {
        return IPFormatter{ .addr = addr };
    }

    pub fn format(
        addr: IPFormatter,
        writer: anytype,
    ) !void {
        try writer.writeAll(std.mem.sliceTo(lwip.ip4addr_ntoa(@as(*const lwip.ip4_addr_t, @ptrCast(&addr.addr))), 0));
    }
};

// required buffer sizes
const sz = struct {
    const pbuf_pool = lwip.PBUF_POOL_BUFSIZE; // 1540 = 1500 mtu + ethernet + link head/tail
    const link_head = lwip.PBUF_LINK_ENCAPSULATION_HLEN; // 22
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
