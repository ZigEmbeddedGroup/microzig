const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const flash = rp2xxx.flash;
const gpio = rp2xxx.gpio;

const uart = rp2xxx.uart.instance.num(0);
const uart_tx_pin = gpio.num(0);

pub const std_options = microzig.std_options(.{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
});

comptime {
    _ = microzig.export_startup();
}

pub const panic = microzig.panic;

pub fn main() !void {
    // init uart logging
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    const flash_storage_start: u32 = 256 * 1024;
    const flash_storage_end: u32 = flash_storage_start + 4 * flash.SECTOR_SIZE;

    // Erase the flash storage region
    flash.range_erase(flash_storage_start, flash_storage_end);

    const flash_instance: rp2xxx.drivers.Flash = .{};
    var storage: microzig.drivers.kv_store.Generic(
        rp2xxx.drivers.Flash,
        u32,
        .{},
    ) = try .init(
        flash_instance,
        flash_storage_start,
        flash_storage_end,
    );

    try storage.store(0, @as(u32, 10));
    try storage.store(1, @as(u32, 30));
    try storage.store(2, @as(u32, 40));

    // overwrite the value with key 0
    try storage.store(0, @as(u32, 20));

    for (0..3) |i| {
        const value = try storage.fetch(@truncate(i), u32);
        std.log.info("Loaded value for key {}: {?}", .{ i, value });
    }
}
