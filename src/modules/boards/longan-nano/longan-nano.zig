pub const chip = @import("chip");
pub const micro = @import("microzig");

pub const cpu_frequency = 8_000_000;

pub const pin_map = .{
    // Port A
    .PA0 = "PA0",
    .PA1 = "PA1",
    .PA2 = "PA2",
    .PA3 = "PA3",
    .PA4 = "PA4",
    .PA5 = "PA5",
    .PA6 = "PA6",
    .PA7 = "PA7",
    .PA8 = "PA8",
    .PA9 = "PA9",
    .PA10 = "PA10",
    .PA11 = "PA11",
    .PA12 = "PA12",
    .PA13 = "PA13",

    // Port B
    .PB0 = "PB0",
    .PB1 = "PB1",
    .PB2 = "PB2",
    .PB3 = "PB3",
    .PB4 = "PB4",
    .PB5 = "PB5",
    .PB6 = "PB6",
    .PB7 = "PB7",
    .PB8 = "PB8",
    .PB9 = "PB9",
    .PB10 = "PB10",
    .PB11 = "PB11",
    .PB12 = "PB12",
    .PB13 = "PB13",
    .PB14 = "PB14",
    .PB15 = "PB15",

    // Port C
    .PC13 = "PC13",
    .PC14 = "PC14",
    .PC15 = "PC15",

    // Colors LED
    // LCD_COLOR_WHITE     0xFFFF
    // LCD_COLOR_BLACK     0x0000
    // LCD_COLOR_GREY      0xF7DE
    // LCD_COLOR_BLUE      0x001F
    // LCD_COLOR_BLUE2     0x051F
    // LCD_COLOR_RED       0xF800
    // LCD_COLOR_MAGENTA   0xF81F
    // LCD_COLOR_GREEN     0x07E0
    // LCD_COLOR_CYAN      0x7FFF
    // LCD_COLOR_YELLOW    0xFFE0
};

pub fn debugWrite(string: []const u8) void {
    const uart0 = micro.Uart(0).getOrInit(.{
        .baud_rate = 115200,
        .data_bits = .eight,
        .parity = null,
        .stop_bits = .one,
    }) catch unreachable;

    const writer = uart0.writer();
    _ = writer.write(string) catch unreachable;
    uart0.internal.txflush();
}
