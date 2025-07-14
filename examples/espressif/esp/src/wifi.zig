const std = @import("std");
const microzig = @import("microzig");
const interrupt = microzig.cpu.interrupt;
const hal = microzig.hal;
const radio = hal.radio;
const usb_serial_jtag = hal.usb_serial_jtag;

pub const microzig_options: microzig.Options = .{
    .log_level = .debug,
    .log_scope_levels = &.{
        .{
            .scope = .esp_radio,
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
        .interrupt1 = radio.interrupt_handlers.wifi_xxx,
        .interrupt2 = radio.interrupt_handlers.timer,
        .interrupt3 = radio.interrupt_handlers.software,
    },
};

var buffer: [50 * 1024]u8 = undefined;

pub fn main() !void {
    var fba: std.heap.FixedBufferAllocator = .init(&buffer);
    const allocator = fba.threadSafeAllocator();

    microzig.cpu.interrupt.enable_interrupts();

    try radio.init(allocator);
    try radio.wifi.init();

    try radio.wifi.set_mode(.sta);
    try radio.wifi.set_client_config(.{
        .ssid = "Internet",
    });

    try radio.wifi.start();
    try radio.wifi.connect();

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

    while (true) {
        std.log.info("tick!", .{});
        hal.time.sleep_ms(1000);
    }
}
