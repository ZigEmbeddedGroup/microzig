const microzig = @import("microzig");

// Configures the led_pin and uart index
const cfg = if (microzig.config.has_board)
    switch (microzig.config.board_name) {
        .@"mbed LPC1768" => .{
            .led_pin = microzig.Pin("LED-1"),
            .uart_idx = 1,
            .pins = .{},
        },
        .STM32F3DISCOVERY => .{
            .led_pin = microzig.Pin("LD3"),
            .uart_idx = 1,
            .pins = .{},
        },
        .STM32F4DISCOVERY => .{
            .led_pin = microzig.Pin("LD5"),
            .uart_idx = 2,
            .pins = .{ .tx = microzig.Pin("PA2"), .rx = microzig.Pin("PA3") },
        },
        .@"Longan Nano" => .{
            .led_pin = microzig.Pin("PA2"),
            .uart_idx = 1,
            .pins = .{ .tx = null, .rx = null },
        },
        .@"Arduino Uno" => .{
            .led_pin = microzig.Pin("D13"),
            .uart_idx = 0,
            .pins = .{},
        },
        else => @compileError("unknown board"),
    }
else switch (microzig.config.chip_name) {
    .@"NXP LPC1768" => .{ .led_pin = microzig.Pin("P1.18"), .uart_idx = 1, .pins = .{} },
    .GD32VF103x8 => .{ .led_pin = microzig.Pin("PA2"), .uart_idx = 1, .pins = .{} },
    else => @compileError("unknown chip"),
};

pub fn main() !void {
    const led = microzig.Gpio(cfg.led_pin, .{
        .mode = .output,
        .initial_state = .low,
    });
    led.init();

    var uart = microzig.Uart(cfg.uart_idx, cfg.pins).init(.{
        .baud_rate = 9600,
        .stop_bits = .one,
        .parity = null,
        .data_bits = .eight,
    }) catch |err| {
        blinkError(led, err);

        microzig.hang();
    };

    var out = uart.writer();

    while (true) {
        led.setToHigh();
        try out.writeAll("Hello microzig!\r\n");
        led.setToLow();
        microzig.debug.busySleep(100_000);
    }
}

fn blinkError(led: anytype, err: microzig.uart.InitError) void {
    var blinks: u3 =
        switch (err) {
        error.UnsupportedBaudRate => 1,
        error.UnsupportedParity => 2,
        error.UnsupportedStopBitCount => 3,
        error.UnsupportedWordSize => 4,
    };

    while (blinks > 0) : (blinks -= 1) {
        led.setToHigh();
        microzig.debug.busySleep(1_000_000);
        led.setToLow();
        microzig.debug.busySleep(1_000_000);
    }
}
