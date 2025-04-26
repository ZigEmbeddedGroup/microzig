const std = @import("std");
const microzig = @import("microzig");
const cpu = microzig.cpu;
const chip = microzig.chip;

pub const time = @import("hal/time.zig");
pub const gpio = @import("hal/gpio.zig");
pub const clock = @import("hal/clocks.zig");
pub const crc16 = @import("hal/crc16.zig");
pub const spi = @import("hal/spi.zig");
pub const uart = @import("hal/uart.zig");
pub const i2c = @import("hal/i2c.zig");
pub const drivers = @import("hal/drivers.zig");

pub inline fn init() void {
    const CLOCK = chip.peripherals.CLOCK;
    clock.set_rch_frequency(.@"4MHz");
    clock.enable(.InternalHighSpeed, true);
    // TODO: hide pins on 20-pin mcu

    // TODO: move this to seprate function
    CLOCK.PERI_CLKEN.modify(.{
        .TICK = 1,
    });
    CLOCK.SYSTICK_CR.modify(.{
        .CLK_SEL = 0x2, // RCH
        .NOREF = 1,
    });
    cpu.peripherals.systick.LOAD.modify(.{
        .RELOAD = 4_000_000 / 1000, // 1ms tick rate
    });
    cpu.peripherals.systick.VAL.modify(.{
        .CURRENT = 0, // 1ms tick rate
    });
    cpu.peripherals.systick.CTRL.modify(.{
        .ENABLE = 1,
    });
}
