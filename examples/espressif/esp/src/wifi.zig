const std = @import("std");
const microzig = @import("microzig");
const SPSC_Queue = microzig.concurrency.SPSC_Queue;
const interrupt = microzig.cpu.interrupt;
const hal = microzig.hal;
const Scheduler = hal.Scheduler;
const radio = hal.radio;
const usb_serial_jtag = hal.usb_serial_jtag;

const c = @import("lwip");

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
        .interrupt29 = .{ .c = radio.interrupt_handlers.wifi_xxx },
        .interrupt30 = .{ .c = Scheduler.generic_interrupt_handler },
        .interrupt31 = .{ .naked = Scheduler.isr_yield_handler },
    },
    .cpu = .{
        .interrupt_stack_size = 8192,
    },
    .hal = .{
        .radio = .{
            .wifi_interrupt = .interrupt29,
        },
    },
};

var buffer: [50 * 1024]u8 = undefined;
var scheduler: Scheduler = undefined;

pub fn main() !void {
    // var fba: std.heap.FixedBufferAllocator = .init(&buffer);
    // const allocator = fba.threadSafeAllocator();
    var alloc = microzig.Allocator.init_with_buffer(&buffer);
    const allocator = alloc.allocator();
    scheduler.init(allocator);

    try radio.init(allocator, &scheduler);
    try radio.wifi.init();

    // c.lwip_init();
    //
    // var netif: c.netif = undefined;
    // _ = c.netif_add(&netif, @ptrCast(c.IP4_ADDR_ANY), @ptrCast(c.IP4_ADDR_ANY), @ptrCast(c.IP4_ADDR_ANY), null, netif_init, c.netif_input);
    // @memcpy(&netif.name, "e0");
    // c.netif_create_ip6_linklocal_address(&netif, 1);
    // netif.ip6_autoconfig_enabled = 1;
    // c.netif_set_status_callback(&netif, netif_status_callback);
    // c.netif_set_default(&netif);
    // c.netif_set_up(&netif);
    // _ = c.dhcp_start(&netif);

    try radio.wifi.apply(.{
        .sta = .{
            .ssid = "Internet",
        },
    });

    try radio.wifi.start();
    try radio.wifi.connect();

    var connected: bool = false;
    // var last_mem_show = hal.time.get_time_since_boot();

    while (true) {
        radio.tick();

        const sta_state = radio.wifi.get_sta_state();
        if (!connected and sta_state == .sta_connected) {
            std.log.info("link up", .{});
            // c.netif_set_link_up(&netif);
            connected = true;
        } else if (connected and sta_state == .sta_disconnected) {
            std.log.info("link down", .{});
            // c.netif_set_link_down(&netif);
            connected = false;
        }

        while (radio.wifi.recv_packet(.sta)) |packet| {
            defer packet.deinit();

            std.log.info("packet received", .{});

            // const maybe_pbuf: ?*c.struct_pbuf = c.pbuf_alloc(c.PBUF_RAW, @intCast(packet.data.len), c.PBUF_POOL);
            // if (maybe_pbuf) |pbuf| {
            //     _ = c.pbuf_take(pbuf, packet.data.ptr, @intCast(packet.data.len));
            //     defer _ = c.pbuf_free(pbuf);
            //
            //     if (c.netif_input(pbuf, &netif) != c.ERR_OK) {
            //         std.log.warn("lwip netif input failed", .{});
            //     }
            // }
        }

        // c.sys_check_timeouts();

        // const now = hal.time.get_time_since_boot();
        // if (!now.diff(last_mem_show).less_than(.from_ms(1000))) {
        //     const used_mem = 50 * 1024 - alloc.free_heap();
        //     std.log.info("used memory: {}K ({})", .{ used_mem / 1024, used_mem });
        //     last_mem_show = now;
        // }
        scheduler.sleep(10_000 * hal.systimer.ticks_per_us());
    }

    // var ssid: [1:0]u8 = @splat(0);
    // var bssid: [1:0]u8 = @splat(0);
    //
    // var scan_config: c.wifi_scan_config_t = .{
    //     .ssid = &ssid,
    //     .bssid = &bssid,
    //     .channel = 0,
    //     .show_hidden = true,
    //     .scan_type = c.WIFI_SCAN_TYPE_PASSIVE,
    //     .scan_time = .{
    //         .active = .{ .min = 0, .max = 0 },
    //         .passive = 2000,
    //     },
    //     .home_chan_dwell_time = 0,
    //     .channel_bitmap = .{
    //         .ghz_2_channels = 0,
    //         .ghz_5_channels = 0,
    //     },
    // };
    // try radio.wifi.c_result(c.esp_wifi_scan_start(&scan_config, true));
    //
    // var no: u16 = undefined;
    // try radio.wifi.c_result(c.esp_wifi_scan_get_ap_num(&no));

    // std.log.info("found {} aps", .{no});
}

fn netif_init(netif_c: [*c]c.struct_netif) callconv(.c) c.err_t {
    const netif: *c.struct_netif = netif_c;

    netif.linkoutput = netif_output;
    netif.output = c.etharp_output;
    netif.output_ip6 = c.ethip6_output;
    netif.mtu = 1500;
    netif.flags = c.NETIF_FLAG_BROADCAST | c.NETIF_FLAG_ETHARP | c.NETIF_FLAG_ETHERNET | c.NETIF_FLAG_IGMP | c.NETIF_FLAG_MLD6;
    @memcpy(&netif.hwaddr, &radio.read_mac(.sta));
    netif.hwaddr_len = 6;

    return c.ERR_OK;
}

var packet_buf: [1500]u8 = undefined;

fn netif_output(netif: [*c]c.struct_netif, pbuf_c: [*c]c.struct_pbuf) callconv(.c) c.err_t {
    _ = netif;
    const pbuf: *c.struct_pbuf = pbuf_c;

    // std.log.info("sending packet", .{});

    var off: usize = 0;
    while (off < pbuf.tot_len) {
        const cnt = c.pbuf_copy_partial(pbuf, packet_buf[off..].ptr, @as(u15, @intCast(pbuf.tot_len - off)), @as(u15, @intCast(off)));
        if (cnt == 0) {
            std.log.err("failed to copy network packet", .{});
            return c.ERR_BUF;
        }
        off += cnt;
    }

    radio.wifi.send_packet(.sta, packet_buf[0..pbuf.tot_len]) catch |err| {
        std.log.err("failed to send packet: {}", .{err});
    };

    return c.ERR_OK;
}

const IPFormatter = struct {
    addr: c.ip_addr_t,

    pub fn init(addr: c.ip_addr_t) IPFormatter {
        return .{ .addr = addr };
    }

    pub fn format(addr: IPFormatter, writer: *std.Io.Writer) !void {
        try writer.writeAll(std.mem.sliceTo(c.ip4addr_ntoa(@as(*const c.ip4_addr_t, @ptrCast(&addr.addr))), 0));
    }
};

fn netif_status_callback(netif_c: [*c]c.netif) callconv(.c) void {
    const netif: *c.netif = netif_c;

    std.log.info("netif status changed ip to {f}", .{IPFormatter.init(netif.ip_addr)});
}

export fn sys_now() callconv(.c) u32 {
    return @truncate(hal.time.get_time_since_boot().to_us() * 1_000);
}

export fn rand() callconv(.c) i32 {
    return @bitCast(hal.rng.random_u32());
}
