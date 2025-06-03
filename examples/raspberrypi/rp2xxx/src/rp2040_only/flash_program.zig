const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;
const flash = rp2xxx.flash;
const time = rp2xxx.time;
const gpio = rp2xxx.gpio;
const clocks = rp2xxx.clocks;

const led = gpio.num(25);
const uart = rp2xxx.uart.instance.num(0);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(0);

const flash_target_offset: u32 = 256 * 1024;
const flash_target_contents = @as([*]const u8, @ptrFromInt(rp2xxx.flash.XIP_BASE + flash_target_offset));

pub fn panic(message: []const u8, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {
    std.log.err("panic: {s}", .{message});
    @breakpoint();
    while (true) {}
}

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.log,
};

pub fn main() !void {
    // init uart logging
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    led.set_function(.sio);
    led.set_direction(.out);
    led.put(1);

    var data: [flash.PAGE_SIZE]u8 = undefined;
    var i: usize = 0;
    var j: u8 = 0;
    while (i < flash.PAGE_SIZE) : (i += 1) {
        data[i] = j;

        if (j == 255) j = 0;
        j += 1;
    }

    std.log.info("Generate data", .{});
    std.log.info("data: {s}", .{&data});

    // Note that a whole number of sectors (4096 bytes) must be erased at a time
    std.log.info("Erasing target region...", .{});
    flash.range_erase(flash_target_offset, flash.SECTOR_SIZE);
    std.log.info("Done. Read back target region:", .{});
    std.log.info("data: {s}", .{flash_target_contents[0..flash.PAGE_SIZE]});

    // Note that a whole number of pages (256 bytes) must be written at a time
    std.log.info("Programming target region...", .{});
    flash.range_program(flash_target_offset, data[0..]);
    std.log.info("Done. Read back target region:", .{});
    std.log.info("data: {s}", .{flash_target_contents[0..flash.PAGE_SIZE]});

    var mismatch: bool = false;
    i = 0;
    while (i < flash.PAGE_SIZE) : (i += 1) {
        if (data[i] != flash_target_contents[i])
            mismatch = true;
    }

    if (mismatch) {
        std.log.info("Programming failed!", .{});
    } else {
        std.log.info("Programming successful!", .{});
    }
}
