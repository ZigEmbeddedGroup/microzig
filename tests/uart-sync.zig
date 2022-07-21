const micro = @import("microzig");

// Configures the led_pin and uart index
const cfg = if (micro.config.has_board)
    switch (micro.config.board_name) {
        .@"mbed LPC1768" => .{
            .led_pin = micro.Pin("LED-1"),
            .uart_idx = 1,
            .pins = .{},
        },
        .@"STM32F3DISCOVERY" => .{
            .led_pin = micro.Pin("LD3"),
            .uart_idx = 1,
            .pins = .{},
        },
        .@"STM32F4DISCOVERY" => .{
            .led_pin = micro.Pin("LD5"),
            .uart_idx = 2,
            .pins = .{ .tx = micro.Pin("PA2"), .rx = micro.Pin("PA3") },
        },
        .@"Longan Nano" => .{
            .led_pin = micro.Pin("PA2"),
            .uart_idx = 1,
            .pins = .{ .tx = null, .rx = null },
        },
        else => @compileError("unknown board"),
    }
else switch (micro.config.chip_name) {
    .@"NXP LPC1768" => .{ .led_pin = micro.Pin("P1.18"), .uart_idx = 1, .pins = .{} },
    else => @compileError("unknown chip"),
};

pub fn main() !void {
    const led = micro.Gpio(cfg.led_pin, .{
        .mode = .output,
        .initial_state = .low,
    });
    led.init();

    var uart = micro.Uart(cfg.uart_idx, cfg.pins).init(.{
        .baud_rate = 9600,
        .stop_bits = .one,
        .parity = null,
        .data_bits = .eight,
    }) catch |err| {
        blinkError(led, err);

        micro.hang();
    };

    var out = uart.writer();

    while (true) {
        led.setToHigh();
        try out.writeAll("Hello microzig!\r\n");
        led.setToLow();
        micro.debug.busySleep(100_000);
    }
}

fn blinkError(led: anytype, err: micro.uart.InitError) void {
    var blinks: u3 =
        switch (err) {
        error.UnsupportedBaudRate => 1,
        error.UnsupportedParity => 2,
        error.UnsupportedStopBitCount => 3,
        error.UnsupportedWordSize => 4,
    };

    while (blinks > 0) : (blinks -= 1) {
        led.setToHigh();
        micro.debug.busySleep(1_000_000);
        led.setToLow();
        micro.debug.busySleep(1_000_000);
    }
}
