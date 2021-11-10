const std = @import("std");
const micro = @import("microzig");

// this will instantiate microzig and pull in all dependencies
pub const panic = micro.panic;

// Configures the led_pin to a hardware pin
const led_pin = if (micro.config.has_board)
    switch (micro.config.board_name) {
        .@"Arduino Nano" => micro.Pin("D13"),
        .@"mbed LPC1768" => micro.Pin("LED-1"),
        .@"Raspberry Pi Pico" => micro.Pin("LED"),
        else => @compileError("unknown board"),
    }
else switch (micro.config.chip_name) {
    .@"ATmega328p" => micro.Pin("PB5"),
    .@"NXP LPC1768" => micro.Pin("P1.18"),
    .@"Raspberry Pi RP2040" => micro.Pin("GPIO25"),
    else => @compileError("unknown chip"),
};

const led = micro.Gpio(led_pin, .{
    .mode = .output,
    .initial_state = .low,
});

pub const vector_table = struct {
    pub fn systick() void {
        micro.chip.registers.PPB.ICSR.set(.{ .PENDSVSET = 1 });
    }

    pub fn pendsv() callconv(.C) void {
        led.toggle();
    }

    pub fn svc() callconv(.Naked) void {
        asm volatile ("mov pc, lr");
    }
};

pub fn main() void {
    const PPB = micro.chip.registers.PPB;

    PPB.SHPR3.modify(.{ .PRI_14 = 3 });

    PPB.SYST_RVR.modify(.{ .RELOAD = 150_000_00 });
    PPB.SYST_CVR.modify(.{ .CURRENT = 0 });

    PPB.SYST_CSR.modify(.{
        .ENABLE = 1,
        .TICKINT = 1,
        .CLKSOURCE = 1,
    });

    micro.reset(.{.gpio});
    led_pin.route(.gpio);

    led.init();

    while (true) {
        micro.cpu.wfi();
        //busyloop();
        //led.toggle();
    }
}

fn busyloop() void {
    const limit = 100_000_00;

    var i: u24 = 0;
    while (i < limit) : (i += 1) {
        @import("std").mem.doNotOptimizeAway(i);
    }
}
