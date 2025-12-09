//! This example is work in progress on CYW43xx WiFi/BT driver
//! Tested on Pico 2 W
const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const pio = rp2xxx.pio;
const drivers = microzig.hal.drivers;
// const Net = @import("net.zig").Net;
// const Udp = @import("net.zig").Udp;

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

const log = std.log.scoped(.main);

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
};

var wifi_driver: drivers.WiFi = .{};
//var rx_buffer: [1536]u8 align(4) = undefined; // 1500 (payload 1472 + ip 20 + udp 8) + 14 ethernet + 22 bus (12 sdp + 2 padding + 4 bdc + 4 padding)
//var tx_buffer: [1472]u8 align(4) = undefined; // 1472 payload + ip 20 + udp 8  = 1500

var wifi_buffer: drivers.WiFi.Chip.Buffer = undefined;

const Lwip = @import("lwip.zig");
const Udp = Lwip.Udp;

var lwip: Lwip = undefined;
var udp: Udp = .{};

pub fn main() !void {
    // init uart logging
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    var wifi = try wifi_driver.init(.{}, &wifi_buffer);
    log.debug("mac address: {x}", .{wifi.mac});

    // var net = Net{
    //     .mac = wifi.mac,
    //     .ip = [4]u8{ 192, 168, 190, 90 },
    //     .driver = .{
    //         .ptr = wifi,
    //         .recv = drivers.WiFi.recv,
    //         .send = drivers.WiFi.send,
    //     },
    //     .sleep_ms = time.sleep_ms,
    //     .tx_buffer = wifi.tx_buffer(),
    // };
    try wifi.join("ninazara", "PeroZdero1");

    //const hydra_ip: [4]u8 = .{ 192, 168, 190, 235 };
    // const hydra_mac = try net.get_mac(hydra_ip);
    // log.debug("hydra mac: {x}", .{hydra_mac[0..6]});

    // var udp: Udp = .{
    //     .net = &net,
    //     .port = 0x1234,
    //     .destination = .{
    //         .ip = hydra_ip,
    //         .mac = hydra_mac,
    //         .port = 9999,
    //     },
    // };

    lwip = .{
        .mac = wifi.mac,
        .driver = .{
            .ptr = wifi,
            .recv = drivers.WiFi.recv,
            .send = drivers.WiFi.send,
        },
        .tx_buffer = wifi.tx_buffer(),
    };
    try lwip.init();

    var i: usize = 1000;
    while (true) : (i +%= 1) {
        time.sleep_ms(500);
        wifi.led_toggle();
        try lwip.poll();
        if (lwip.ready()) {
            break;
        }

        // net.poll(500) catch |err| {
        //     log.err("net pool {}", .{err});
        //     continue;
        // };
        // const buf = try std.fmt.bufPrint(udp.tx_buffer(), "hello from pico {}\n", .{i});
        // udp.send(buf) catch |err| {
        //     log.err("udp send: {}", .{err});
        //     continue;
        // };
    }
    log.debug("net ready", .{});
    try lwip.udp_connect(&udp, "192.168.190.235", 9999);

    while (true) : (i +%= 1) {
        time.sleep_ms(500);
        wifi.led_toggle();
        try lwip.poll();
        //try udp.send("pero\n");

        const buf = try std.fmt.bufPrint(wifi.tx_buffer()[42..], "hello from pico {}\n", .{i});
        try udp.send(buf);
    }

    rp2xxx.rom.reset_to_usb_boot();
}

export fn ashet_lockInterrupts(were_enabled: *bool) void {
    _ = were_enabled;
    // were_enabled.* = platform.areInterruptsEnabled();
    // if (were_enabled.*) {
    //     platform.disableInterrupts();
    // }
}

export fn ashet_unlockInterrupts(enable: bool) void {
    _ = enable;
    // if (enable) {
    //     platform.enableInterrupts();
    // }
}

export fn ashet_rand() u32 {
    // TODO: Improve this
    return 4; // chose by a fair dice roll
}

export fn sys_now() u32 {
    const ts = time.get_time_since_boot();
    return @truncate(ts.to_us() / 1000);
}

export fn __aeabi_read_tp() u32 {
    return 0;
}
