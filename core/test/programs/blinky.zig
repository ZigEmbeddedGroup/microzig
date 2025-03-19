const microzig = @import("microzig");

// Configures the led_pin to a hardware pin
const led_pin = if (microzig.config.has_board)
    switch (microzig.config.board_name) {
        .@"Arduino Nano" => microzig.Pin("D13"),
        .@"Arduino Uno" => microzig.Pin("D13"),
        .@"mbed LPC1768" => microzig.Pin("LED-1"),
        .STM32F3DISCOVERY => microzig.Pin("LD3"),
        .STM32F4DISCOVERY => microzig.Pin("LD5"),
        .STM32F429IDISCOVERY => microzig.Pin("LD4"),
        .@"Longan Nano" => microzig.Pin("PA2"),
        else => @compileError("unknown board"),
    }
else switch (microzig.config.chip_name) {
    .ATmega328p => microzig.Pin("PB5"),
    .@"NXP LPC1768" => microzig.Pin("P1.18"),
    .STM32F103x8 => microzig.Pin("PC13"),
    .GD32VF103x8 => microzig.Pin("PA2"),
    else => @compileError("unknown chip"),
};

pub fn main() void {
    const led = microzig.Gpio(led_pin, .{
        .mode = .output,
        .initial_state = .low,
    });
    led.init();

    while (true) {
        busyloop();
        led.toggle();
    }
}

fn busyloop() void {
    const limit = 100_000;

    var i: u24 = 0;
    while (i < limit) : (i += 1) {
        @import("std").mem.doNotOptimizeAway(i);
    }
}
