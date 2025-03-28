const std = @import("std");
const microzig = @import("microzig");

const rp2xxx = microzig.hal;

const gpio = rp2xxx.gpio;
const i2c_slave = rp2xxx.i2c_slave;
const time = rp2xxx.time;
const uart = rp2xxx.uart.instance.num(0);

const Pin = gpio.Pin;

// -----------------------------------------------------------------------------
//  Local Constants
// -----------------------------------------------------------------------------

// --- GPIO pins --------------------------------

const pin_config = rp2xxx.pins.GlobalConfiguration{
    .GPIO0 = .{ .name = "gpio0", .function = .UART0_TX },
    .GPIO1 = .{
        .name = "gpio1",
        .function = .UART0_RX,
    },
    .GPIO26 = .{
        .name = "sda",
        .function = .I2C1_SDA,
        .slew_rate = .slow,
    },
    .GPIO27 = .{
        .name = "scl",
        .function = .I2C1_SCL,
        .slew_rate = .slow,
    },
};

// ---- MicroZig Options --------------------------------

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rp2xxx.uart.logFn,
    .interrupts = .{ .I2C1_IRQ = .{ .c = i2c_slave.isr1 } },
};

// -----------------------------------------------------------------------------
//  Global Variables
// -----------------------------------------------------------------------------

var i2c_buffer: [10]u8 = undefined;

// -----------------------------------------------------------------------------
//  Function: main
// -----------------------------------------------------------------------------

pub fn main() !void {
    // --- Set up GPIO -------------------------------

    pin_config.apply();

    // --- Set up UART -------------------------------

    uart.apply(.{
        .baud_rate = 115200,
        .clock_config = rp2xxx.clock_config,
    });

    rp2xxx.uart.init_logger(uart);

    std.log.info("Hello from i2c_slave.\n", .{});

    // --- Set up I2C communication ------------------

    i2c_slave.i2c1.open(0x42, &i2c_buffer, i2cRXCallback, i2cTXCallback, null);

    // --- Main loop -------------------------------

    std.log.debug("Setup Complete\n", .{});

    while (true) {
        time.sleep_ms(1_000);
    }
}

// -----------------------------------------------------------------------------
//  Function: i2cRXCallback
// -----------------------------------------------------------------------------
// This function processes data we receive from the master.

fn i2cRXCallback(in_data: []const u8, in_first: bool, in_last: bool, in_gen_call: bool, in_param: ?*anyopaque) void {
    _ = in_param;

    std.log.debug("i2cRXCallback: {any} [{d}]\n", .{ in_data, in_data.len });
    std.log.debug("first: {}\n", .{in_first});
    std.log.debug("last: {}\n", .{in_last});
    std.log.debug("gen_call: {}\n", .{in_gen_call});
}

// -----------------------------------------------------------------------------
//  Function: i2cTXCallback
// -----------------------------------------------------------------------------
// This function is called when the master wants us to send some data

fn i2cTXCallback(out_data: []u8, in_first: bool, in_param: ?*anyopaque) usize {
    _ = in_param;

    std.log.debug("i2cTXCallback\n", .{});
    std.log.debug("first: {}\n", .{in_first});

    for (out_data, 0..) |*out, i| out.* = @intCast(i);

    return out_data.len;
}
