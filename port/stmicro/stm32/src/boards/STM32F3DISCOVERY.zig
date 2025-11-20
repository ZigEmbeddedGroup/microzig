pub const microzig = @import("microzig");

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

const uart_pin: microzig.hal.uart.Pins = .{ .tx = null, .rx = null };

pub fn debug_write(string: []const u8) void {
    const uart1 = microzig.hal.uart.Uart(.UART1, uart_pin).get_or_init(.{
        .baud_rate = 9600,
        .word_bits = .eight,
        .parity = .none,
        .stop_bits = .Stop1,
    }) catch unreachable;

    for (string) |c| {
        uart1.tx(c);
    }
}
