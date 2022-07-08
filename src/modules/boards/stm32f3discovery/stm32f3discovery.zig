pub const chip = @import("chip");
pub const micro = @import("microzig");

pub const cpu_frequency = 8_000_000;

pub const pin_map = .{
    // circle of LEDs, connected to GPIOE bits 8..15

    // NW blue
    .@"LD4" = "PE8",
    // N red
    .@"LD3" = "PE9",
    // NE orange
    .@"LD5" = "PE10",
    // E green
    .@"LD7" = "PE11",
    // SE blue
    .@"LD9" = "PE12",
    // S red
    .@"LD10" = "PE13",
    // SW orange
    .@"LD8" = "PE14",
    // W green
    .@"LD6" = "PE15",
};

pub fn debugWrite(string: []const u8) void {
    const uart1 = micro.Uart(1, .{}).getOrInit(.{
        .baud_rate = 9600,
        .data_bits = .eight,
        .parity = null,
        .stop_bits = .one,
    }) catch unreachable;

    const writer = uart1.writer();
    _ = writer.write(string) catch unreachable;
    uart1.internal.txflush();
}
