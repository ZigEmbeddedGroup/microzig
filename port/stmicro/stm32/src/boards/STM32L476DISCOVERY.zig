// This is only for Rev C board
// It is labeled as MB1184 C-04
// Based on the user manual: UM1879:
// https://www.st.com/resource/en/user_manual/um1879-discovery-kit-with-stm32l476vg-mcu-stmicroelectronics.pdf
const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;
const LcdRam = hal.lcd.LcdRam;
const hal_pins = hal.pins;

pub const leds_config = (hal_pins.GlobalConfiguration{
    .GPIOB = .{
        .PIN2 = .{ .name = "LD4", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
    },
    .GPIOE = .{
        .PIN8 = .{ .name = "LD5", .mode = .{ .output = .{ .resistor = .Floating, .o_type = .PushPull } } },
    },
});

pub const Lcd = struct {
    const hal_lcd = hal.lcd;

    current_ram: LcdRam,

    // Rev C have the following segment map to each digit:
    //             5544_4433_-655_11--_--6-_3322_--66_-221 1---
    //  .comX =  0b1111_1111_X111_11XX_XX1X_1111_XX11_X111_1XXX
    const SEGMENT_SHIFT = [_][4]u6{
        [_]u6{ 3, 4, 22, 23 }, // Digit 1
        [_]u6{ 5, 6, 12, 13 }, // Digit 2
        [_]u6{ 14, 15, 28, 29 }, // Digit 3
        [_]u6{ 30, 31, 32, 33 }, // Digit 4
        [_]u6{ 34, 35, 24, 25 }, // Digit 5
        [_]u6{ 26, 17, 9, 8 }, // Digit 6
    };

    pub const ALPHABET = [_]u16{
        // A       B       C       D       E
        0xC8CC, 0x06DC, 0x4C40, 0x06D4, 0xCC40,
        // F       G       H       I       J
        0xC840, 0x4C4C, 0xC88C, 0x0650, 0x0C84,
        // K       L       M       N       O
        0xC920, 0x4C00, 0x58A4, 0x5984, 0x4CC4,
        // P       Q       R       S       T
        0xC8C8, 0x4DC4, 0xC9C8, 0xC44C, 0x0250,
        // U       V       W       X       Y
        0x4C84, 0x6820, 0x6984, 0x3120, 0x1220,
        // Z
        0x2460,
    };

    pub const NUMBER = [_]u16{
        //  0      1       2       3       4
        0x4CC4, 0x00A4, 0x2460, 0x04CC, 0xC084,
        // 5       6       7       8       9
        0xC44C, 0xCC4C, 0x2060, 0xCCCC, 0xC4CC,
    };

    // All special char will print the same symbole.
    // There will be no distinction between lower or upper cases.
    // Some symbol will be far from the corresponding glype.
    pub const ASCII_MAP = [_]u16{
        // NUL    SOH     STX     ETX     EOT    ENQ      ACK     BEL     BS      HT      LF      VT
        0x1060, 0x1060, 0x1060, 0x1060, 0x1060, 0x1060, 0x1060, 0x1060, 0x1060, 0x1060, 0x1060, 0x1060,
        // FF     CR      SO      SI      DLE     DC1     DC2     DC3     DC4     NAK     SYN     ETB
        0x1060, 0x1060, 0x1060, 0x1060, 0x1060, 0x1060, 0x1060, 0x1060, 0x1060, 0x1060, 0x1060, 0x1060,
        // CAN    EM      SUB     ESC     FS      GS      RS      US      SP      !       "       #
        0x1060, 0x1060, 0x1060, 0x1060, 0x1060, 0x1060, 0x1060, 0x1060, 0x0000, 0x0210, 0x1020, 0x82DC,
        // $      %       &       '       (       )       *       +       ,       -       .       /
        0xC65C, 0xF12C, 0x2620, 0x0010, 0x0120, 0x3000, 0xB338, 0x8218, 0x2000, 0x8008, 0x0001, 0x2020,
        // 0      1       2       3       4       5       6       7       8       9       :       ;
        0x4CC4, 0x00A4, 0x2460, 0x04CC, 0xC084, 0xC44C, 0xCC4C, 0x2060, 0xCCCC, 0xC4CC, 0x0002, 0x0240,
        // <      =       >       ?       @       A       B       C       D       E       F       G
        0x0028, 0x8408, 0x9000, 0x02C8, 0x8EC4, 0xC8CC, 0x06DC, 0x4C40, 0x06D4, 0xCC40, 0xC840, 0x4C4C,
        // H      I       J       K       L       M       N       O       P       Q       R       S
        0xC88C, 0x0650, 0x0C84, 0xC920, 0x4C00, 0x58A4, 0x5984, 0x4CC4, 0xC8C8, 0x4DC4, 0xC9C8, 0xC44C,
        // T      U       V       W       X       Y       Z       [       \       ]       ^       _
        0x0250, 0x4C84, 0x6820, 0x6984, 0x3120, 0x1220, 0x2460, 0x4C40, 0x1100, 0x04C4, 0x2100, 0x0400,
        // `      a       b       c       d       e       f       g       h       i       j       k
        0x1000, 0xC8CC, 0x06DC, 0x4C40, 0x06D4, 0xCC40, 0xC840, 0x4C4C, 0xC88C, 0x0650, 0x0C84, 0xC920,
        // l      m       n       o       p       q       r       s       t       u       v       w
        0x4C00, 0x58A4, 0x5984, 0x4CC4, 0xC8C8, 0x4DC4, 0xC9C8, 0xC44C, 0x0250, 0x4C84, 0x6820, 0x6984,
        // x      y       z       {       |       }       ~       DEL
        0x3120, 0x1220, 0x2460, 0x8650, 0x0210, 0x0658, 0x5008, 0x1060,
    };

    // LCD segment mapping:
    // --------------------
    // -----A-----        _
    // |\   |   /|   COL |_|
    // F H  J  K B
    // |  \ | /  |        _
    // --G-- --M--   COL |_|
    // |  / | \  |
    // E Q  P  N C
    // |/   |   \|        _
    // -----D-----   DP  |_|
    //
    // Bytes   3   2   1   0
    //
    // LSB   { H , N , J , DP   }
    //       { Q , P , K , COL }
    //       { F , D , A , C   }
    // MSB   { G , E , B , M   }
    //       -------------------
    //
    fn get_digit(digit: usize, val: u16) LcdRam {
        const shift = SEGMENT_SHIFT[digit];
        const base = @as(u44, val);
        const com3 = (base & 0x1) << shift[3] |
            ((base & 0x10) >> 4) << shift[2] |
            ((base & 0x100) >> 8) << shift[1] |
            ((base & 0x1000) >> 12) << shift[0];
        const com2 = ((base & 0x2) >> 1) << shift[3] |
            ((base & 0x20) >> 5) << shift[2] |
            ((base & 0x200) >> 9) << shift[1] |
            ((base & 0x2000) >> 13) << shift[0];
        const com1 = ((base & 0x4) >> 2) << shift[3] |
            ((base & 0x40) >> 6) << shift[2] |
            ((base & 0x400) >> 10) << shift[1] |
            ((base & 0x4000) >> 14) << shift[0];
        const com0 = ((base & 0x8) >> 3) << shift[3] |
            ((base & 0x80) >> 7) << shift[2] |
            ((base & 0x800) >> 11) << shift[1] |
            ((base & 0x8000) >> 15) << shift[0];

        return .{
            .com0 = com0,
            .com1 = com1,
            .com2 = com2,
            .com3 = com3,
        };
    }

    pub fn add_digit(self: *@This(), digit: usize, val: u16) void {
        const toAdd = get_digit(digit, val);

        self.current_ram.com0 |= toAdd.com0;
        self.current_ram.com1 |= toAdd.com1;
        self.current_ram.com2 |= toAdd.com2;
        self.current_ram.com3 |= toAdd.com3;
    }

    pub fn clear(self: *@This()) void {
        self.current_ram = .{};
    }

    pub fn flush(self: *@This()) void {
        hal_lcd.load_data(self.current_ram);
        self.clear();
    }

    fn init_pins() void {
        _ = (hal_pins.GlobalConfiguration{
            .GPIOA = .{
                .PIN6 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN7 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN8 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN9 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN10 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN15 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
            },
            .GPIOB = .{
                .PIN0 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN1 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN4 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN5 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN9 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN12 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN13 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN14 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN15 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
            },
            .GPIOC = .{
                .PIN3 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN4 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN5 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN6 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN7 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN8 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
            },
            .GPIOD = .{
                .PIN8 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN9 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN10 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN11 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN12 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN13 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN14 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
                .PIN15 = .{ .mode = .{ .alternate_function = .{ .afr = .AF11 } } },
            },
        }).apply();
    }

    pub fn init() Lcd {
        Lcd.init_pins();
        hal_lcd.init_lcd();
        hal_lcd.load_data(.{});
        hal_lcd.enable_lcd();
        return .{ .current_ram = .{} };
    }
};

pub fn i2c1() !hal.i2c.I2C_Device {
    _ = (hal.pins.GlobalConfiguration{
        .GPIOB = .{
            // I2C
            .PIN6 = .{ .mode = .{ .alternate_function = .{
                .afr = .AF4,
            } } },
            .PIN7 = .{ .mode = .{ .alternate_function = .{
                .afr = .AF4,
            } } },
        },
    }).apply();

    return try hal.i2c.I2C_Device.init(.I2C1);
}

pub const uart_logger = hal.uart.UARTLogger(.USART2);

pub fn init_log() void {
    _ = (hal.pins.GlobalConfiguration{
        .GPIOD = .{
            .PIN5 = .{ .mode = .{ .alternate_function = .{ .afr = .AF7 } } },
            .PIN6 = .{ .mode = .{ .alternate_function = .{ .afr = .AF7 } } },
        },
    }).apply();
    uart_logger.init(.{
        .baud_rate = 9600,
        .dma = hal.dma.DMA1_Channel4.get_channel(),
    });
}

pub fn init() void {}
