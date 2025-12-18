//! This example is work in progress on CYW43xx WiFi/BT driver
//! Tested on Pico 2 W
const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const pio = rp2xxx.pio;
const drivers = microzig.hal.drivers;
const interrupt = microzig.cpu.interrupt;

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

const log = std.log.scoped(.main);

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
    .interrupts = .{
        .IO_IRQ_BANK0 = .{ .c = timer_interrupt },
    },
};

var wifi_driver: drivers.WiFi = .{};
var wifi_buffer: drivers.WiFi.Chip.Buffer = undefined;

const Net = @import("lwip.zig");
const Udp = Net.Udp;

var net: Net = undefined;
var udp: Udp = .{};

fn timer_interrupt() callconv(.c) void {
    //log.debug("!!!!! my interrupt hanlder", .{});
    var iter = gpio.IrqEventIter{};
    while (iter.next()) |e| {
        //e.pin.acknowledge_irq(e.events);
        //log.debug("event {}", .{e});
        _ = e;
        break;
    }
    // const irq_pin = gpio.num(24);
    // irq_pin.acknowledge_irq(gpio.IrqEvents{ .raise = 1 });
}

pub fn main() !void {

    // init uart logging
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    var wifi = try wifi_driver.init(.{}, &wifi_buffer);
    log.debug("mac address: {x}", .{wifi.mac});

    try wifi.join("ninazara", "PeroZdero1");

    // const irq_pin = gpio.num(24);
    // irq_pin.set_irq_enabled(gpio.IrqEvents{ .high = 1 }, true);
    // microzig.interrupt.enable(.IO_IRQ_BANK0);

    net = .{
        .mac = wifi.mac,
        .link = .{
            .ptr = wifi,
            .recv = drivers.WiFi.recv,
            .send = drivers.WiFi.send,
            .ready = drivers.WiFi.ready,
        },
        .link_buffer = wifi.tx_buffer(),
    };
    try net.init();

    var i: usize = 1000;
    while (true) : (i +%= 1) {
        //time.sleep_ms(500);
        wifi.led_toggle();
        net.poll() catch |err| {
            log.err("pool {}", .{err});
            continue;
        };
        if (net.ready()) {
            break;
        }
    }
    log.debug("net ready", .{});
    try net.udp_init(&udp, "192.168.190.235", 9999);

    var buf: [128]u8 = @splat(0);
    while (true) : (i +%= 1) {
        time.sleep_ms(100);
        wifi.led_toggle();
        net.poll() catch |err| {
            log.err("pool {}", .{err});
            continue;
        };
        const msg = try std.fmt.bufPrint(&buf, "hello from pico {}\n", .{i});
        try udp.send(msg);
    }

    rp2xxx.rom.reset_to_usb_boot();
}

export fn sys_now() u32 {
    const ts = time.get_time_since_boot();
    return @truncate(ts.to_us() / 1000);
}
