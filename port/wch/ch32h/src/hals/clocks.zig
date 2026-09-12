const microzig = @import("microzig");
const gpio = microzig.hal.gpio;

const RCC = microzig.chip.peripherals.RCC;

pub fn enable_gpio(port: gpio.Port) void {
    switch (port) {
        .A => RCC.HB2PCENR.modify(.{ .IOPAEN = 1 }),
        .B => RCC.HB2PCENR.modify(.{ .IOPBEN = 1 }),
        .C => RCC.HB2PCENR.modify(.{ .IOPCEN = 1 }),
        .D => RCC.HB2PCENR.modify(.{ .IOPDEN = 1 }),
        .E => RCC.HB2PCENR.modify(.{ .IOPEEN = 1 }),
        .F => RCC.HB2PCENR.modify(.{ .IOPFEN = 1 }),
    }
}
