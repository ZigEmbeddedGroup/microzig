pub const microzig = @import("microzig");
<<<<<<< HEAD
=======
pub const hal = microzig.hal;
pub const rcc = hal.rcc;
pub const pins = hal.pins;
const UART_LOG = microzig.hal.uart.Uart(.UART1);
>>>>>>> 6acb63ca (fixup! Add logging function for STM32F303)

pub const pin_map = .{
    // circle of LEDs, connected to GPIOE bits 8..15

    // NW blue
    .LD4 = "PE8",
    // N red
    .LD3 = "PE9",
    // NE orange
    .LD5 = "PE10",
    // E green
    .LD7 = "PE11",
    // SE blue
    .LD9 = "PE12",
    // S red
    .LD10 = "PE13",
    // SW orange
    .LD8 = "PE14",
    // W green
    .LD6 = "PE15",
};


var uart_log: ?UART_LOG = null;

// Init should come first or the baud_rate would be too fast for the default HSI.
pub fn init_log() void {
    _ = (pins.GlobalConfiguration{
        .GPIOC = .{
            .PIN4 = .{ .mode = .{ .alternate_function = .{ .afr = .AF7 } } },
            .PIN5 = .{ .mode = .{ .alternate_function = .{ .afr = .AF7 } } },
        },
    }).apply();
    uart_log = try microzig.hal.uart.Uart(.UART1).init(.{ .baud_rate = 115200 });
    if (uart_log) |*logger| {
        microzig.hal.uart.init_logger(logger);
    }
}
