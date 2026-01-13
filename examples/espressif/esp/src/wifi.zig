const std = @import("std");
const microzig = @import("microzig");
const interrupt = microzig.cpu.interrupt;
const hal = microzig.hal;
const rtos = hal.rtos;
const radio = hal.radio;
const usb_serial_jtag = hal.usb_serial_jtag;

const lwip = @import("lwip/include.zig");
const exports = @import("lwip/exports.zig");
comptime {
    _ = exports;
}

pub const microzig_options: microzig.Options = .{
    .log_level = .debug,
    .log_scope_levels = &.{
        .{
            .scope = .esp_radio,
            .level = .info,
        },
        .{
            .scope = .esp_radio_wifi,
            .level = .info,
        },
        .{
            .scope = .esp_radio_osi,
            .level = .info,
        },
        .{
            .scope = .esp_wifi_driver_internal,
            .level = .err,
        },
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
        },
    },
    .hal = .{
        .rtos = .{
            .enable = true,
        },
        .radio = .{
            .wifi = .{
                .on_event = on_event,
                .on_packet_received = on_packet_received,
            },
        },
    },
};

var netif: lwip.c.netif = undefined;

pub fn main() !void {
    var heap_allocator: microzig.Allocator = .init_with_heap(8192);
    const gpa = heap_allocator.allocator();

    try radio.wifi.init(gpa);
    defer radio.wifi.deinit();

    exports.gpa = gpa;
    _ = lwip.c.tcpip_init(init_done, null);

    try radio.wifi.apply(.{
        .sta = .{
            .ssid = "Internet",
        },
    });

    try radio.wifi.start();
    try radio.wifi.connect();

    var count: usize = 0;
    while (true) {
        const free_heap = heap_allocator.free_heap();
        std.log.info("{} free memory: {}K ({})", .{ count, free_heap / 1024, free_heap });
        count += 1;
        rtos.sleep(.from_ms(1000));
    }
}

fn on_event(e: radio.wifi.EventType) void {
    switch (e) {
        .StaConnected => _ = lwip.c.netifapi_netif_common(&netif, lwip.c.netif_set_link_up, null),
        .StaDisconnected => _ = lwip.c.netifapi_netif_common(&netif, lwip.c.netif_set_link_down, null),
        else => {}
    }
}

fn on_packet_received(comptime _: radio.wifi.Interface, data: []const u8) void {
    const maybe_pbuf: ?*lwip.c.struct_pbuf = lwip.c.pbuf_alloc(lwip.c.PBUF_RAW, @intCast(data.len), lwip.c.PBUF_POOL);
    if (maybe_pbuf) |pbuf| {
        _ = lwip.c.pbuf_take(pbuf, data.ptr, @intCast(data.len));
        if (lwip.c.tcpip_input(pbuf, &netif) != lwip.c.ERR_OK) {
            std.log.warn("lwip netif input failed", .{});
        }
    }
}

fn init_done(_: ?*anyopaque) callconv(.c) void {
    _ = lwip.c.netif_add(
        &netif,
        @ptrCast(lwip.c.IP4_ADDR_ANY),
        @ptrCast(lwip.c.IP4_ADDR_ANY),
        @ptrCast(lwip.c.IP4_ADDR_ANY),
        null,
        netif_init,
        lwip.c.tcpip_input,
    );
    _ = lwip.c.dhcp_start(&netif);
}

fn netif_init(_: [*c]lwip.c.struct_netif) callconv(.c) lwip.c.err_t {
    @memcpy(&netif.name, "e0");
    netif.linkoutput = netif_output;
    netif.output = lwip.c.etharp_output;
    netif.output_ip6 = lwip.c.ethip6_output;
    netif.mtu = 1500;
    netif.flags = lwip.c.NETIF_FLAG_BROADCAST | lwip.c.NETIF_FLAG_ETHARP | lwip.c.NETIF_FLAG_ETHERNET | lwip.c.NETIF_FLAG_IGMP | lwip.c.NETIF_FLAG_MLD6;
    @memcpy(&netif.hwaddr, &radio.read_mac(.sta));
    netif.hwaddr_len = 6;
    lwip.c.netif_create_ip6_linklocal_address(&netif, 1);
    lwip.c.netif_set_status_callback(&netif, netif_status_callback);
    lwip.c.netif_set_default(&netif);
    lwip.c.netif_set_up(&netif);

    return lwip.c.ERR_OK;
}

var packet_buf: [1600]u8 = undefined;

fn netif_output(_: [*c]lwip.c.struct_netif, pbuf_c: [*c]lwip.c.struct_pbuf) callconv(.c) lwip.c.err_t {
    const pbuf: *lwip.c.struct_pbuf = pbuf_c;
    std.debug.assert(pbuf.tot_len <= packet_buf.len);

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
    };

    return lwip.c.ERR_OK;
}

const IPFormatter = struct {
    addr: lwip.c.ip_addr_t,

    pub fn init(addr: lwip.c.ip_addr_t) IPFormatter {
        return .{ .addr = addr };
    }

    pub fn format(addr: IPFormatter, writer: *std.Io.Writer) !void {
        try writer.writeAll(std.mem.sliceTo(lwip.c.ip4addr_ntoa(@as(*const lwip.c.ip4_addr_t, @ptrCast(&addr.addr))), 0));
    }
};

fn netif_status_callback(_: [*c]lwip.c.netif) callconv(.c) void {
    std.log.info("netif status changed ip to {f}", .{IPFormatter.init(netif.ip_addr)});
}
