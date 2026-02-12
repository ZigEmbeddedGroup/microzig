const microzig = @import("microzig");

const LCD = microzig.chip.peripherals.LCD;

const LCD_COM_L = microzig.mmio.Mmio(packed struct(u32) {
    SEG0T31: u32,
});

const LCD_COM_H = microzig.mmio.Mmio(packed struct(u32) {
    SEG32T44: u12,
    reserved: u20,
});

const LCD_RAM = extern struct {
    COM0L: LCD_COM_L,
    COM0H: LCD_COM_H,
    COM1L: LCD_COM_L,
    COM1H: LCD_COM_H,
    COM2L: LCD_COM_L,
    COM2H: LCD_COM_H,
    COM3L: LCD_COM_L,
    COM3H: LCD_COM_H,
};

// LCD RAM is not correctly defined in the stm32-data from embassy
// The high segments are inside a reserved space.
const ram: *volatile LCD_RAM = @ptrCast(&LCD.@"RAM_COM[0]");

pub fn init_lcd() void {
    LCD.CR.modify(.{
        .BIAS = 0b10,
        .DUTY = 0b011,
    });
    LCD.FCR.modify(.{
        .CC = 0b110,
        .PS = 2,
        .DIV = 4,
    });
}

pub fn enable_lcd() void {
    LCD.CR.modify(.{
        .LCDEN = 1,
    });
}

pub const LcdRam = struct {
    com0: u44 = 0,
    com1: u44 = 0,
    com2: u44 = 0,
    com3: u44 = 0,
};

pub fn load_data(data: LcdRam) void {
    while (LCD.SR.read().UDR == 1) {}
    ram.COM0L.modify(.{ .SEG0T31 = @as(u32, @truncate(data.com0)) });
    ram.COM0H.modify(.{ .SEG32T44 = @as(u12, @truncate(data.com0 >> 32)) });
    ram.COM1L.modify(.{ .SEG0T31 = @as(u32, @truncate(data.com1)) });
    ram.COM1H.modify(.{ .SEG32T44 = @as(u12, @truncate(data.com1 >> 32)) });
    ram.COM2L.modify(.{ .SEG0T31 = @as(u32, @truncate(data.com2)) });
    ram.COM2H.modify(.{ .SEG32T44 = @as(u12, @truncate(data.com2 >> 32)) });
    ram.COM3L.modify(.{ .SEG0T31 = @as(u32, @truncate(data.com3)) });
    ram.COM3H.modify(.{ .SEG32T44 = @as(u12, @truncate(data.com3 >> 32)) });

    LCD.SR.modify(.{
        .UDR = 1,
    });
}
