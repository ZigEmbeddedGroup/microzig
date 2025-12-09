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
driver: struct {
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

    try lwip.dhcp.start(netif);

    c.netif_set_link_up(netif);
}

fn netif_status_callback(netif_c: [*c]c.netif) callconv(.c) void {
    const netif: *c.netif = netif_c;

    log.info("netif status changed ip to {f}", .{IPFormatter.new(netif.ip_addr)});
}

pub fn ready(self: *Self) bool {
    const netif = &self.netif;

    return (netif.flags & c.NETIF_FLAG_UP > 0) and
        (netif.flags & c.NETIF_FLAG_LINK_UP > 0) and
        (netif.ip_addr.u_addr.ip4.addr != 0);
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

fn netif_init(netif_c: [*c]c.netif) callconv(.c) c.err_t {
    const netif: *c.netif = netif_c;
    const self: *Self = @fieldParentPtr("netif", netif);

    netif.linkoutput = netif_output;
    netif.output = c.etharp_output;
    netif.output_ip6 = c.ethip6_output;
    netif.mtu = 1500; // nic.mtu; // c.ETHERNET_MTU;
    netif.flags = c.NETIF_FLAG_BROADCAST | c.NETIF_FLAG_ETHARP | c.NETIF_FLAG_ETHERNET | c.NETIF_FLAG_IGMP | c.NETIF_FLAG_MLD6;
    // c.MIB2_INIT_NETIF(netif, c.snmp_ifType_ethernet_csmacd, 100000000);
    std.mem.copyForwards(u8, &netif.hwaddr, &self.mac);
    netif.hwaddr_len = c.ETH_HWADDR_LEN;
    return c.ERR_OK;
}

fn send(self: *Self, data: []const u8) !void {
    try self.driver.send(self.driver.ptr, data);
}

fn recv(self: *Self) !?[]const u8 {
    return try self.driver.recv(self.driver.ptr);
}

fn netif_output(netif_c: [*c]c.netif, pbuf_c: [*c]c.pbuf) callconv(.c) c.err_t {
    const netif: *c.netif = netif_c;
    var pbuf: *c.pbuf = pbuf_c;
    const self: *Self = @fieldParentPtr("netif", netif);

    var tx_buffer = self.tx_buffer;
    var tx_pos: usize = 0;

    const tot_len = pbuf.tot_len;
    while (true) {
        if (pbuf.payload) |payload| {
            //log.debug("sending tot_len: {} , len: {} bytes {any}", .{ pbuf.tot_len, pbuf.len, payload });
            var buf: []const u8 = undefined;
            buf.ptr = @ptrCast(payload);
            buf.len = pbuf.len;

            if (&buf[0] != &tx_buffer[tx_pos]) {
                @memcpy(tx_buffer[tx_pos..][0..buf.len], buf);
                log.debug("memcpy {}", .{buf.len});
            } else {
                log.debug("skip memcpy {}", .{buf.len});
            }
            tx_pos += buf.len;
            if (tx_pos >= tot_len) break;
        } else {
            break;
        }
        pbuf = pbuf.next;
    }
    if (tx_pos > 0) {
        log.debug("send buf: {} {x}", .{ tx_pos, tx_buffer[0..@min(64, tx_pos)] });
        self.send(tx_buffer[0..tx_pos]) catch return c.ERR_ARG;
    }

    // if (nic.allocOutgoingPacket(pbuf.tot_len)) |packet| {
    //     // TODO: Handle length here
    //     var off: usize = 0;
    //     while (off < pbuf.tot_len) {
    //         const cnt = c.pbuf_copy_partial(pbuf, packet.ptr + off, @as(u15, @intCast(pbuf.tot_len - off)), @as(u15, @intCast(off)));
    //         if (cnt == 0) {
    //             logger.err("failed to copy network packet", .{});
    //             return c.ERR_BUF;
    //         }
    //         off += cnt;
    //     }
    //     if (!nic.send(packet)) {
    //         logger.err("failed to send network packet!", .{});
    //     }
    // } else {
    //     logger.err("failed to allocate network packet!", .{});
    // }

    return c.ERR_OK;
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

fn lwipErr(err: c.err_t) LwipError {
    if (lwipTry(err)) |_|
        unreachable
    else |e|
        return e;
}

fn lwipTry(err: c.err_t) LwipError!void {
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

const LWIP_Error_Code = enum(c.err_t) {
    mem = c.ERR_MEM,
    buf = c.ERR_BUF,
    timeout = c.ERR_TIMEOUT,
    rte = c.ERR_RTE,
    inprogress = c.ERR_INPROGRESS,
    val = c.ERR_VAL,
    wouldblock = c.ERR_WOULDBLOCK,
    use = c.ERR_USE,
    already = c.ERR_ALREADY,
    isconn = c.ERR_ISCONN,
    conn = c.ERR_CONN,
    interface = c.ERR_IF,
    abrt = c.ERR_ABRT,
    rst = c.ERR_RST,
    clsd = c.ERR_CLSD,
    arg = c.ERR_ARG,

    fn to_zig_error(code: LWIP_Error_Code) LwipError {
        std.debug.assert(@intFromEnum(code) != c.ERR_OK);
        return switch (code) {
            .mem => LwipError.OutOfMemory,
            .buf => LwipError.BufferError,
            .timeout => LwipError.Timeout,
            .rte => LwipError.Routing,
            .inprogress => LwipError.InProgress,
            .val => LwipError.IllegalValue,
            .wouldblock => LwipError.WouldBlock,
            .use => LwipError.AddressInUse,
            .already => LwipError.AlreadyConnecting,
            .isconn => LwipError.AlreadyConnected,
            .conn => LwipError.NotConnected,
            .interface => LwipError.LowlevelInterfaceError,
            .abrt => LwipError.ConnectionAborted,
            .rst => LwipError.ConnectionReset,
            .clsd => LwipError.ConnectionClosed,
            .arg => LwipError.IllegalArgument,
        };
    }
};

fn wrap_lwip_call(comptime func: anytype, comptime error_set: []const LWIP_Error_Code) type {
    const F = @TypeOf(func);
    const fnInfo = @typeInfo(F).@"fn";

    std.debug.assert(fnInfo.return_type == c.err_t);

    var arg_fields: [fnInfo.params.len]std.builtin.Type.StructField = undefined;
    for (&arg_fields, fnInfo.params, 0..) |*out, in, i| {
        out.* = .{
            .name = std.fmt.comptimePrint("{d}", .{i}),
            .type = in.type.?,
            .alignment = @alignOf(in.type.?),
            .default_value_ptr = null,
            .is_comptime = false,
        };
    }

    var errors: [error_set.len]std.builtin.Type.Error = undefined;
    for (&errors, error_set) |*out, in| {
        out.* = .{ .name = @errorName(in.to_zig_error()) };
    }

    const E = @Type(.{ .error_set = &errors });

    const Tuple = @Type(.{ .@"struct" = .{
        .layout = .auto,
        .is_tuple = true,
        .decls = &.{},
        .fields = &arg_fields,
    } });

    return struct {
        fn invoke_tuple(args: Tuple) E!void {
            const return_code: c.err_t = @call(.auto, func, args);
            if (return_code == c.ERR_OK)
                return;
            inline for (error_set) |err| {
                if (return_code == @intFromEnum(err))
                    return @field(anyerror, @errorName(err.to_zig_error()));
            }
            std.log.err("{} returned unexpected error code {}", .{ &func, return_code });
            @panic("unexpected return value from LWIP!");
        }

        const invoke = reify_function(invoke_tuple);
    };
}

// TODO(fqu): Search lwIP sources to see what errors each function can return:
const lwip = struct {
    const pbuf = struct {
        const take = wrap_lwip_call(c.pbuf_take, &.{.mem}).invoke;
    };

    const dhcp = struct {
        const start = wrap_lwip_call(c.dhcp_start, &.{}).invoke;
    };

    const tcp = struct {
        const bind = wrap_lwip_call(c.tcp_bind, &.{
            // ERR_OK if bound
            .use, // ERR_USE if the port is already in use
            .val, // ERR_VAL if bind failed because the PCB is not in a valid state
        }).invoke;
        const connect = wrap_lwip_call(c.tcp_connect, &.{
            .val, //ERR_VAL if invalid arguments are given
            // ERR_OK if connect request has been sent
            // other err_t values if connect request couldn't be sent
        }).invoke;
        const write = wrap_lwip_call(c.tcp_write, &.{.mem}).invoke;
    };
    const udp = struct {
        const bind = wrap_lwip_call(c.udp_bind, &.{}).invoke;
        const connect = wrap_lwip_call(c.udp_connect, &.{}).invoke;
        const disconnect = c.udp_disconnect;
        const send = wrap_lwip_call(c.udp_send, &.{}).invoke;
        const sendto = wrap_lwip_call(c.udp_sendto, &.{}).invoke;
    };
};

pub fn reify_function(comptime func: anytype) @TypeOf(_reify_function(func).invoke) {
    return _reify_function(func).invoke;
}

fn _reify_function(comptime func: anytype) type {
    //
    const F = @TypeOf(func);
    const fnInfo = @typeInfo(F).@"fn";

    std.debug.assert(fnInfo.params.len == 1);

    const ArgTuple = fnInfo.params[0].type.?;
    const CC = fnInfo.calling_convention;

    const arg_info = @typeInfo(ArgTuple).@"struct";
    std.debug.assert(arg_info.is_tuple);

    var a_backing: [arg_info.fields.len]type = undefined;
    for (&a_backing, arg_info.fields) |*out, in| {
        out.* = in.type;
    }

    const A = a_backing;
    const R = fnInfo.return_type.?;

    return struct {
        pub const invoke = @field(@This(), std.fmt.comptimePrint("n{}", .{A.len}));

        fn n0() callconv(CC) R {
            return func(.{});
        }

        fn n1(a0: A[0]) callconv(CC) R {
            return func(.{a0});
        }

        fn n2(a0: A[0], a1: A[1]) callconv(CC) R {
            return func(.{ a0, a1 });
        }

        fn n3(a0: A[0], a1: A[1], a2: A[2]) callconv(CC) R {
            return func(.{ a0, a1, a2 });
        }

        fn n4(a0: A[0], a1: A[1], a2: A[2], a3: A[3]) callconv(CC) R {
            return func(.{ a0, a1, a2, a3 });
        }
    };
}

pub fn poll(self: *Self) !void {
    while (try self.recv()) |buf| {
        var pbuf: c.pbuf = .{
            .payload = @constCast(buf.ptr),
            .len = @intCast(buf.len),
            .tot_len = @intCast(buf.len),
        };
        log.debug("recv {} {x}", .{ buf.len, buf[0..@min(16, buf.len)] });
        try lwipTry(self.netif.input.?(&pbuf, &self.netif));
        c.sys_check_timeouts();
    }
}

pub const Udp = struct {
    pcb: c.udp_pcb = .{},
    addr: c.ip_addr_t = .{},
    port: u16 = 0,

    fn connect(udp: *Udp, net: *Self, target: []const u8, port: u16) !void {
        c.udp_bind_netif(&udp.pcb, &net.netif);
        const res = c.ipaddr_aton(target.ptr, &udp.addr);
        log.debug("udp connect res: {}", .{res});
        udp.port = port;
        try lwipTry(c.udp_connect(&udp.pcb, &udp.addr, udp.port));
        udp.pcb.ttl = 64;
    }

    pub fn send(udp: *Udp, buf: []const u8) !void {
        const pbuf: *c.struct_pbuf = c.pbuf_alloc(c.PBUF_TRANSPORT, @intCast(buf.len), c.PBUF_REF);
        defer _ = c.pbuf_free(pbuf);
        //const ptr: [*c]u8 = @ptrCast(pbuf.payload.?);
        //@memcpy(ptr, buf);

        pbuf.payload = @constCast(&buf[0]);
        //log.debug("send pbuf {} {} {any}", .{ pbuf.len, pbuf.tot_len, pbuf });

        // var pbuf: c.pbuf = .{
        //     .payload = @constCast(buf.ptr),
        //     .len = @intCast(buf.len),
        //     .tot_len = @intCast(buf.len),
        // };
        //const res = c.udp_send(&udp.pcb, &pbuf);

        const res = c.udp_sendto(&udp.pcb, pbuf, &udp.addr, udp.port);
        log.debug("udp send res: {}", .{res});
    }
};

pub fn udp_connect(self: *Self, udp: *Udp, target: []const u8, port: u16) !void {
    try udp.connect(self, target, port);
}
