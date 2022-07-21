pub const chip = @import("chip");
pub const micro = @import("microzig");

pub const cpu_frequency = 8_000_000; // 8 MHz

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
    .PC0 = "PC0",
    .PC1 = "PC1",
    .PC2 = "PC2",
    .PC3 = "PC3",
    .PC4 = "PC4",
    .PC5 = "PC5",
    .PC6 = "PC6",
    .PC7 = "PC7",
    .PC8 = "PC8",
    .PC9 = "PC9",
    .PC10 = "PC10",
    .PC11 = "PC11",
    .PC12 = "PC12",
    .PC13 = "PC13",
    .PC14 = "PC14",
    .PC15 = "PC15",

    // Port D
    .PD0 = "PD0",
    .PD1 = "PD1",
    .PD2 = "PD2",
    .PD3 = "PD3",
    .PD4 = "PD4",
    .PD5 = "PD5",
    .PD6 = "PD6",
    .PD7 = "PD7",
    .PD8 = "PD8",
    .PD9 = "PD9",
    .PD10 = "PD10",
    .PD11 = "PD11",
    .PD12 = "PD12",
    .PD13 = "PD13",
    .PD14 = "PD14",
    .PD15 = "PD15",

    // Port E
    .PE0 = "PE0",
    .PE1 = "PE1",
    .PE2 = "PE2",
    .PE3 = "PE3",
    .PE4 = "PE4",
    .PE5 = "PE5",
    .PE6 = "PE6",
    .PE7 = "PE7",
    .PE8 = "PE8",
    .PE9 = "PE9",
    .PE10 = "PE10",
    .PE11 = "PE11",
    .PE12 = "PE12",
    .PE13 = "PE13",
    .PE14 = "PE14",
    .PE15 = "PE15",

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
    _ = string;
    // TODO: implement
}
