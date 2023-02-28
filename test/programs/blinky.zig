const micro = @import("microzig");

// Configures the led_pin to a hardware pin
const led_pin = if (micro.config.has_board)
    switch (micro.config.board_name) {
        .@"Arduino Nano" => micro.Pin("D13"),
        .@"Arduino Uno" => micro.Pin("D13"),
        .@"mbed LPC1768" => micro.Pin("LED-1"),
        .STM32F3DISCOVERY => micro.Pin("LD3"),
        .STM32F4DISCOVERY => micro.Pin("LD5"),
        .STM32F429IDISCOVERY => micro.Pin("LD4"),
        .@"Longan Nano" => micro.Pin("PA2"),
        else => @compileError("unknown board"),
    }
else switch (micro.config.chip_name) {
    .ATmega328p => micro.Pin("PB5"),
    .@"NXP LPC1768" => micro.Pin("P1.18"),
    .STM32F103x8 => micro.Pin("PC13"),
    .GD32VF103x8 => micro.Pin("PA2"),
    else => @compileError("unknown chip"),
};

pub fn main() void {
    const led = micro.Gpio(led_pin, .{
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
