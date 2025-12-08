// /--------
// | THE CODE BELOW IS OLD HAL CODE FOR UART, I2C, AND SPI
// | THAT HAS WORKED IN A PREVIOUS MICROZIG INCARNATION.
// |
// | IT SHOULD BE MOVED INTO SEPARATE FILES IN STM32F303/.
// \--------
//
// For now we keep all clock settings on the chip defaults.
// This code currently assumes the STM32F303xB / STM32F303xC clock configuration.
// TODO: Do something useful for other STM32f30x chips.

const std = @import("std");
const microzig = @import("microzig");

pub const uart = @import("STM32F303/uart.zig");
pub const rcc = @import("STM32F303/rcc.zig");
pub const i2c = @import("STM32F303/i2c.zig");
pub const pins = @import("STM32F303/pins.zig");
pub const enums = @import("STM32F303/enums.zig");

pub fn parse_pin(comptime spec: []const u8) type {
    const invalid_format_msg = "The given pin '" ++ spec ++ "' has an invalid format. Pins must follow the format \"P{Port}{Pin}\" scheme.";

    if (spec[0] != 'P')
        @compileError(invalid_format_msg);
    if (spec[1] < 'A' or spec[1] > 'H')
        @compileError(invalid_format_msg);

    const pin_number: comptime_int = std.fmt.parseInt(u4, spec[2..], 10) catch @compileError(invalid_format_msg);

    return struct {
        /// 'A'...'H'
        const gpio_port_name = spec[1..2];
        const gpio_port = @field(microzig.peripherals, "GPIO" ++ gpio_port_name);
        const suffix = std.fmt.comptimePrint("{d}", .{pin_number});
    };
}
