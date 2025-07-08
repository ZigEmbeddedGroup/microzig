const std = @import("std");
const microzig = @import("microzig");

const stepper = microzig.drivers.stepper;
const base = microzig.drivers.base;
const rpxxxx = microzig.hal;
const gpio = rpxxxx.gpio;
const time = rpxxxx.time;
const UART_Device = rpxxxx.drivers.UART_Device;
const ClockDevice = rpxxxx.drivers.ClockDevice;
const TMC2209 = stepper.TMC2209;

const uart0 = rpxxxx.uart.instance.num(0);
const uart1 = rpxxxx.uart.instance.num(1);
const baud_rate = 115200;
const uart_tx_pin = gpio.num(0);

const pin_config = rpxxxx.pins.GlobalConfiguration{
    .GPIO0 = .{ .name = "gpio0", .function = .UART0_TX },
    .GPIO8 = .{ .name = "gpio8", .function = .UART1_TX },
    .GPIO9 = .{ .name = "gpio9", .function = .UART1_RX },
};

pub const microzig_options = microzig.Options{
    .log_level = .debug,
    .logFn = rpxxxx.uart.log,
};

pub fn main() !void {
    try init();

    var cd = ClockDevice{};
    var ud = UART_Device.init(uart1, null);

    var driver = try TMC2209.init(.{
        .uart = ud.stream_device(),
        .clock = cd.clock_device(),
        .address = 0,
    });

    // var c1 = TMC2209.ifcnt{};
    // try driver.read(&c1);
    // std.log.debug("c1 {d}", .{c1.val.ifcnt});

    try driver.set_microsteps(4);
    try driver.spreadcycle();

    var i: f32 = 5;
    while (true) {
        std.log.debug("move {d}", .{5 * i});
        try driver.move(i);
        i *= -1;
        time.sleep_ms(5000);
    }
}

fn init() !void {
    uart_tx_pin.set_function(.uart);
    uart0.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rpxxxx.clock_config,
    });

    uart1.apply(.{
        .baud_rate = baud_rate,
        .clock_config = rpxxxx.clock_config,
    });

    rpxxxx.uart.init_logger(uart0);
    pin_config.apply();
}
