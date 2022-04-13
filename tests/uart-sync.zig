const micro = @import("microzig");

// Configures the led_pin to a hardware pin
const led_pin = if (micro.config.has_board)
    switch (micro.config.board_name) {
        .@"Arduino Nano" => micro.Pin("D13"),
        .@"mbed LPC1768" => micro.Pin("LED-1"),
        .@"STM32F3DISCOVERY" => micro.Pin("LD3"),
        .@"STM32F4DISCOVERY" => micro.Pin("LD5"),
        .@"STM32F429IDISCOVERY" => micro.Pin("LD4"),
        else => @compileError("unknown board"),
    }
else switch (micro.config.chip_name) {
    .@"ATmega328p" => micro.Pin("PB5"),
    .@"NXP LPC1768" => micro.Pin("P1.18"),
    .@"STM32F103x8" => micro.Pin("PC13"),
    else => @compileError("unknown chip"),
};

// Configures the uart index
const uart_idx = if (micro.config.has_board)
    switch (micro.config.board_name) {
        .@"mbed LPC1768" => 1,
        .@"STM32F3DISCOVERY" => 1,
        .@"STM32F4DISCOVERY" => 2,
        else => @compileError("unknown board"),
    }
else switch (micro.config.chip_name) {
    .@"NXP LPC1768" => 1,
    else => @compileError("unknown chip"),
};

pub fn main() !void {
    const led = micro.Gpio(led_pin, .{
        .mode = .output,
        .initial_state = .low,
    });
    led.init();

    var uart = micro.Uart(uart_idx).init(.{
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
