const std = @import("std");
const microzig = @import("microzig");
const rp2xxx = microzig.hal;
const gpio = rp2xxx.gpio;
const i2c = rp2xxx.i2c;
const time = rp2xxx.time;

const uart = rp2xxx.uart.instance.num(0);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(0);

const pin_config = rp2xxx.pins.GlobalConfiguration{
    .GPIO0 = .{ .name = "gpio0", .function = .UART0_TX },
    .GPIO4 = .{
        .name = "sda",
        .function = .I2C0_SDA,
        .slew_rate = .slow,
    },
    .GPIO5 = .{
        .name = "scl",
        .function = .I2C0_SCL,
        .slew_rate = .slow,
    },
};

pub const microzig_options = microzig.Options{
    .logFn = rp2xxx.uart.logFn,
    .interrupts = .{ .I2C0_IRQ = .{ .c = i2c.slave.isr1 } },
};

var i2c_buffer: [10]u8 = undefined;
var slave_addr: i2c.Address = @enumFromInt(0x42);

pub fn main() !void {
    // init uart logging
    uart_tx_pin.set_function(.uart);
    uart.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rp2xxx.clock_config,
    });
    rp2xxx.uart.init_logger(uart);

    pin_config.apply();

    std.log.info("Hello from i2c_slave.", .{});

    i2c.slave.i2c0.open(slave_addr, &i2c_buffer, i2cRXCallback, i2cTXCallback, null);

    std.log.debug("Setup Complete", .{});

    while (true) {
        time.sleep_ms(1_000);
    }
}

fn i2cRXCallback(in_data: []const u8, in_first: bool, in_last: bool, in_gen_call: bool, in_param: ?*anyopaque) void {
    _ = in_param;

    std.log.debug("i2cRXCallback: {any} [{d}]", .{ in_data, in_data.len });
    std.log.debug("first: {}", .{in_first});
    std.log.debug("last: {}", .{in_last});
    std.log.debug("gen_call: {}", .{in_gen_call});
}

fn i2cTXCallback(out_data: []u8, in_first: bool, in_param: ?*anyopaque) usize {
    _ = in_param;

    std.log.debug("i2cTXCallback", .{});
    std.log.debug("first: {}", .{in_first});

    for (out_data, 0..) |*out, i| out.* = @intCast(i);

    return out_data.len;
}
