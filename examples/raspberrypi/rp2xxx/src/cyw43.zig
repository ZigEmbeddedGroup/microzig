//! This example is work in progress on CYW43xx WiFi/BT driver
//! Tested on Pico 2 W
const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const pio = rp2xxx.pio;
const drivers = microzig.hal.drivers;

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

const log = std.log.scoped(.main);

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
};

pub fn main() !void {
    // init uart logging
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    var wifi: drivers.WiFi = .{};
    try wifi.init(.{});

    // The driver isn't finished yet, so we're using this infinite test loop to process all internal driver events.
    // Eventually, this will be replaced by a dedicated driver task/thread.
    //cyw43.test_loop();

    // enable led by wifi regs
    // wifi.runner.bus.bp_write32(0x18000000 + 0x68, 1);

    var on: u32 = 1;
    //wifi.runner.read_clmver();
    try wifi.runner.read_mac();

    try wifi.runner.join("", "");
    log.debug("join end\n\n", .{});

    while (true) {
        time.sleep_ms(500);
        // toggle led by sending command
        try wifi.runner.led_on(on == 1);
        on = if (on == 1) 0 else 1;

        // toggle led by using wifi regs
        //wifi.runner.bus.bp_write32(0x18000000 + 0x64, on);
    }
}

// wifi.led.put()
