const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const interrupt = microzig.cpu.interrupt;
const hal = microzig.hal;
const rtos = hal.rtos;
const radio = hal.radio;
const usb_serial_jtag = hal.usb_serial_jtag;

const exports = @import("lwip/exports.zig");
const lwip = @import("lwip/include.zig");

comptime {
    _ = exports;
}

pub const microzig_options: microzig.Options = .{
    .log_level = .debug,
    .log_scope_levels = &.{
        .{ .scope = .esp_radio, .level = .err },
        .{ .scope = .esp_radio_timer, .level = .err },
        .{ .scope = .esp_radio_wifi, .level = .err },
        .{ .scope = .esp_radio_osi, .level = .err },
    },
    .logFn = usb_serial_jtag.logger.log,
    .interrupts = .{
        .interrupt29 = radio.interrupt_handler,
        .interrupt30 = rtos.general_purpose_interrupt_handler,
        .interrupt31 = rtos.yield_interrupt_handler,
    },
    .cpu = .{
        .interrupt_stack = .{
            .enable = true,
            .size = 8192,
        },
    },
    .hal = .{
        .rtos = .{
            .enable = true,
        },
        .radio = .{
            .wifi = .{
                .on_packet_received = on_packet_received,
            },
        },
    },
};

// NOTE: Change these to match your setup.
const SSID = "SSID";
const PASSWORD: []const u8 = "";
const AUTH_METHOD: radio.wifi.AuthMethod = .none;
const SERVER_PORT = 3333;

var maybe_netif: ?*lwip.c.netif = null;

var ip_ready_semaphore: rtos.Semaphore = .init(0, 1);
var ip: lwip.c.ip_addr_t = undefined;

extern fn netconn_new_with_proto_and_callback(t: lwip.c.enum_netconn_type, proto: lwip.c.u8_t, callback: ?*const anyopaque) [*c]lwip.c.struct_netconn;
pub fn main() !void {
    var heap_allocator: microzig.Allocator = .init_with_heap(16384);
    const gpa = heap_allocator.allocator();

    try radio.wifi.init(gpa, .{});
    defer radio.wifi.deinit();

    exports.gpa = gpa;
    lwip.c.tcpip_init(null, null);

    var netif: lwip.c.netif = undefined;
    _ = lwip.c.netifapi_netif_add(
        &netif,
        @ptrCast(lwip.c.IP4_ADDR_ANY),
        @ptrCast(lwip.c.IP4_ADDR_ANY),
        @ptrCast(lwip.c.IP4_ADDR_ANY),
        null,
        netif_init,
        lwip.c.tcpip_input,
    );
    maybe_netif = &netif;
    try lwip.c_err(lwip.c.netifapi_netif_common(&netif, null, lwip.c.dhcp_start));

    try radio.wifi.apply(.{
        .sta = .{
            .ssid = SSID,
            .password = PASSWORD,
            .auth_method = AUTH_METHOD,
        },
    });
    try radio.wifi.start_blocking();

    {
        std.log.info("Scanning for access points...", .{});
        var scan_iter = try radio.wifi.scan(.{.ssid = "Internet"});
        defer scan_iter.deinit();
        while (try scan_iter.next()) |record| {
            std.log.info("Found ap `{s}` RSSI: {} Channel: {}, Auth: {?t}", .{
                record.ssid,
                record.rssi,
                record.primary_channel,
                record.auth_mode,
            });
        }
    }

    try radio.wifi.connect_blocking();
    try lwip.c_err(lwip.c.netifapi_netif_common(&netif, lwip.c.netif_set_link_up, null));

    ip_ready_semaphore.take();
    std.log.info("Listening on {f}:{}", .{ IP_Formatter.init(netif.ip_addr), SERVER_PORT });

    const server_conn = netconn_new_with_proto_and_callback(lwip.c.NETCONN_TCP, 0, null) orelse {
        std.log.err("Failed to create netconn", .{});
        return error.FailedToCreateNetconn;
    };
    defer {
        _ = lwip.c.netconn_close(server_conn);
        _ = lwip.c.netconn_delete(server_conn);
    }

    try lwip.c_err(lwip.c.netconn_bind(server_conn, null, SERVER_PORT));

    try lwip.c_err(lwip.c.netconn_listen(server_conn));
    std.log.info("TCP Server listening...", .{});

    while (true) : (rtos.sleep(.from_ms(200))) {
        var client_conn: ?*lwip.c.netconn = null;

        lwip.c_err(lwip.c.netconn_accept(server_conn, &client_conn)) catch |err| {
            std.log.err("failed to accept connection: {t}", .{err});
            continue;
        };
        defer {
            _ = lwip.c.netconn_close(client_conn);
            _ = lwip.c.netconn_delete(client_conn);
        }

        std.log.info("New client connected!", .{});
        defer std.log.info("Client disconnected.", .{});
        handle_client(client_conn) catch |err| {
            std.log.err("error while connected to client: {t}", .{err});
            continue;
        };
    }
}

fn handle_client(conn: ?*lwip.c.netconn) !void {
    var buf: ?*lwip.c.netbuf = null;
    while (true) {
        lwip.c_err(lwip.c.netconn_recv(conn, &buf)) catch |err| switch (err) {
            error.ConnectionClosed => break,
            else => return err,
        };
        defer lwip.c.netbuf_delete(buf);

        var data_ptr: ?*anyopaque = null;
        var len: u16 = 0;
        try lwip.c_err(lwip.c.netbuf_data(buf, &data_ptr, &len));

        const slice = @as([*]u8, @ptrCast(data_ptr))[0..len];
        std.log.info("Received {} bytes: {s}", .{ len, slice });

        // Echo back to client
        try lwip.c_err(lwip.c.netconn_write_partly(conn, data_ptr, len, lwip.c.NETCONN_COPY, null));
    }
}

fn on_packet_received(comptime _: radio.wifi.Interface, data: []const u8) void {
    const pbuf: *lwip.c.struct_pbuf = lwip.c.pbuf_alloc(lwip.c.PBUF_RAW, @intCast(data.len), lwip.c.PBUF_POOL) orelse {
        std.log.err("failed to allocate receive pbuf", .{});
        return;
    };
    lwip.c_err(lwip.c.pbuf_take(pbuf, data.ptr, @intCast(data.len))) catch unreachable;
    if (maybe_netif) |netif| {
        lwip.c_err(netif.input.?(pbuf, netif)) catch |err| {
            _ = lwip.c.pbuf_free(pbuf);
            std.log.warn("tcpip_input failed: {t}", .{err});
        };
    } else {
        _ = lwip.c.pbuf_free(pbuf);
    }
}

fn netif_init(netif_ptr: [*c]lwip.c.struct_netif) callconv(.c) lwip.c.err_t {
    const netif = &netif_ptr[0];
    @memcpy(&netif.name, "w0");
    netif.linkoutput = netif_output;
    netif.output = lwip.c.etharp_output;
    netif.output_ip6 = lwip.c.ethip6_output;
    netif.mtu = 1500;
    netif.flags = lwip.c.NETIF_FLAG_BROADCAST | lwip.c.NETIF_FLAG_ETHARP | lwip.c.NETIF_FLAG_ETHERNET | lwip.c.NETIF_FLAG_IGMP | lwip.c.NETIF_FLAG_MLD6;
    @memcpy(&netif.hwaddr, &radio.read_mac(.sta));
    netif.hwaddr_len = 6;
    lwip.c.netif_create_ip6_linklocal_address(netif, 1);
    lwip.c.netif_set_status_callback(netif, netif_status_callback);
    lwip.c.netif_set_default(netif);
    lwip.c.netif_set_up(netif);
    return lwip.c.ERR_OK;
}

fn netif_status_callback(netif_ptr: [*c]lwip.c.netif) callconv(.c) void {
    const netif = &netif_ptr[0];
    if (netif.ip_addr.u_addr.ip4.addr != 0) {
        ip = netif.ip_addr;
        ip_ready_semaphore.give();
    }
}

var packet_buf: [1600]u8 = undefined;

fn netif_output(_: [*c]lwip.c.struct_netif, pbuf_c: [*c]lwip.c.struct_pbuf) callconv(.c) lwip.c.err_t {
    const pbuf: *lwip.c.struct_pbuf = pbuf_c;
    std.debug.assert(pbuf.tot_len < packet_buf.len);

    var off: usize = 0;
    while (off < pbuf.tot_len) {
        const cnt = lwip.c.pbuf_copy_partial(pbuf, packet_buf[off..].ptr, @as(u15, @intCast(pbuf.tot_len - off)), @as(u15, @intCast(off)));
        if (cnt == 0) {
            std.log.err("failed to copy network packet", .{});
            return lwip.c.ERR_BUF;
        }
        off += cnt;
    }

    radio.wifi.send_packet(.sta, packet_buf[0..pbuf.tot_len]) catch |err| {
        std.log.err("failed to send packet: {}", .{err});
        return lwip.c.ERR_IF;
    };

    return lwip.c.ERR_OK;
}

const IP_Formatter = struct {
    addr: lwip.c.ip_addr_t,

    pub fn init(addr: lwip.c.ip_addr_t) IP_Formatter {
        return .{ .addr = addr };
    }

    pub fn format(addr: IP_Formatter, writer: *std.Io.Writer) !void {
        try writer.writeAll(std.mem.sliceTo(lwip.c.ip4addr_ntoa(@as(*const lwip.c.ip4_addr_t, @ptrCast(&addr.addr))), 0));
    }
};
