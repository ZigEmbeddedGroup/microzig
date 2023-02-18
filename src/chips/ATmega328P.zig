const micro = @import("microzig");
const mmio = micro.mmio;

pub const devices = struct {
    pub const ATmega328P = struct {
        pub const properties = struct {
            pub const family = "megaAVR";
            pub const arch = "AVR8";
        };

        pub const VectorTable = extern struct {
            const Handler = micro.interrupt.Handler;
            const unhandled = micro.interrupt.unhandled;

            RESET: Handler = unhandled,
            ///  External Interrupt Request 0
            INT0: Handler = unhandled,
            ///  External Interrupt Request 1
            INT1: Handler = unhandled,
            ///  Pin Change Interrupt Request 0
            PCINT0: Handler = unhandled,
            ///  Pin Change Interrupt Request 1
            PCINT1: Handler = unhandled,
            ///  Pin Change Interrupt Request 2
            PCINT2: Handler = unhandled,
            ///  Watchdog Time-out Interrupt
            WDT: Handler = unhandled,
            ///  Timer/Counter2 Compare Match A
            TIMER2_COMPA: Handler = unhandled,
            ///  Timer/Counter2 Compare Match B
            TIMER2_COMPB: Handler = unhandled,
            ///  Timer/Counter2 Overflow
            TIMER2_OVF: Handler = unhandled,
            ///  Timer/Counter1 Capture Event
            TIMER1_CAPT: Handler = unhandled,
            ///  Timer/Counter1 Compare Match A
            TIMER1_COMPA: Handler = unhandled,
            ///  Timer/Counter1 Compare Match B
            TIMER1_COMPB: Handler = unhandled,
            ///  Timer/Counter1 Overflow
            TIMER1_OVF: Handler = unhandled,
            ///  TimerCounter0 Compare Match A
            TIMER0_COMPA: Handler = unhandled,
            ///  TimerCounter0 Compare Match B
            TIMER0_COMPB: Handler = unhandled,
            ///  Timer/Couner0 Overflow
            TIMER0_OVF: Handler = unhandled,
            ///  SPI Serial Transfer Complete
            SPI_STC: Handler = unhandled,
            ///  USART Rx Complete
            USART_RX: Handler = unhandled,
            ///  USART, Data Register Empty
            USART_UDRE: Handler = unhandled,
            ///  USART Tx Complete
            USART_TX: Handler = unhandled,
            ///  ADC Conversion Complete
            ADC: Handler = unhandled,
            ///  EEPROM Ready
            EE_READY: Handler = unhandled,
            ///  Analog Comparator
            ANALOG_COMP: Handler = unhandled,
            ///  Two-wire Serial Interface
            TWI: Handler = unhandled,
            ///  Store Program Memory Read
            SPM_Ready: Handler = unhandled,
        };

        pub const peripherals = struct {
            ///  Fuses
            pub const FUSE = @intToPtr(*volatile types.peripherals.FUSE, 0x0);
            ///  Lockbits
            pub const LOCKBIT = @intToPtr(*volatile types.peripherals.LOCKBIT, 0x0);
            ///  I/O Port
            pub const PORTB = @intToPtr(*volatile types.peripherals.PORT.PORTB, 0x23);
            ///  I/O Port
            pub const PORTC = @intToPtr(*volatile types.peripherals.PORT.PORTC, 0x26);
            ///  I/O Port
            pub const PORTD = @intToPtr(*volatile types.peripherals.PORT.PORTD, 0x29);
            ///  Timer/Counter, 8-bit
            pub const TC0 = @intToPtr(*volatile types.peripherals.TC8.TC0, 0x35);
            ///  Timer/Counter, 16-bit
            pub const TC1 = @intToPtr(*volatile types.peripherals.TC16.TC1, 0x36);
            ///  Timer/Counter, 8-bit Async
            pub const TC2 = @intToPtr(*volatile types.peripherals.TC8_ASYNC.TC2, 0x37);
            ///  External Interrupts
            pub const EXINT = @intToPtr(*volatile types.peripherals.EXINT, 0x3b);
            ///  CPU Registers
            pub const CPU = @intToPtr(*volatile types.peripherals.CPU, 0x3e);
            ///  EEPROM
            pub const EEPROM = @intToPtr(*volatile types.peripherals.EEPROM, 0x3f);
            ///  Serial Peripheral Interface
            pub const SPI = @intToPtr(*volatile types.peripherals.SPI, 0x4c);
            ///  Analog Comparator
            pub const AC = @intToPtr(*volatile types.peripherals.AC, 0x50);
            ///  Watchdog Timer
            pub const WDT = @intToPtr(*volatile types.peripherals.WDT, 0x60);
            ///  Analog-to-Digital Converter
            pub const ADC = @intToPtr(*volatile types.peripherals.ADC, 0x78);
            ///  Two Wire Serial Interface
            pub const TWI = @intToPtr(*volatile types.peripherals.TWI, 0xb8);
            ///  USART
            pub const USART0 = @intToPtr(*volatile types.peripherals.USART.USART0, 0xc0);
        };
    };
};

pub const types = struct {
    pub const peripherals = struct {
        ///  Fuses
        pub const FUSE = extern struct {
            pub const ENUM_SUT_CKSEL = enum(u6) {
                ///  Ext. Clock; Start-up time PWRDWN/RESET: 6 CK/14 CK + 0 ms
                EXTCLK_6CK_14CK_0MS = 0x0,
                ///  Ext. Clock; Start-up time PWRDWN/RESET: 6 CK/14 CK + 4.1 ms
                EXTCLK_6CK_14CK_4MS1 = 0x10,
                ///  Ext. Clock; Start-up time PWRDWN/RESET: 6 CK/14 CK + 65 ms
                EXTCLK_6CK_14CK_65MS = 0x20,
                ///  Int. RC Osc. 8 MHz; Start-up time PWRDWN/RESET: 6 CK/14 CK + 0 ms
                INTRCOSC_8MHZ_6CK_14CK_0MS = 0x2,
                ///  Int. RC Osc. 8 MHz; Start-up time PWRDWN/RESET: 6 CK/14 CK + 4.1 ms
                INTRCOSC_8MHZ_6CK_14CK_4MS1 = 0x12,
                ///  Int. RC Osc. 8 MHz; Start-up time PWRDWN/RESET: 6 CK/14 CK + 65 ms
                INTRCOSC_8MHZ_6CK_14CK_65MS = 0x22,
                ///  Int. RC Osc. 128kHz; Start-up time PWRDWN/RESET: 6 CK/14 CK + 0 ms
                INTRCOSC_128KHZ_6CK_14CK_0MS = 0x3,
                ///  Int. RC Osc. 128kHz; Start-up time PWRDWN/RESET: 6 CK/14 CK + 4.1 ms
                INTRCOSC_128KHZ_6CK_14CK_4MS1 = 0x13,
                ///  Int. RC Osc. 128kHz; Start-up time PWRDWN/RESET: 6 CK/14 CK + 65 ms
                INTRCOSC_128KHZ_6CK_14CK_65MS = 0x23,
                ///  Ext. Low-Freq. Crystal; Start-up time PWRDWN/RESET: 1K CK/14 CK + 0 ms
                EXTLOFXTAL_1KCK_14CK_0MS = 0x4,
                ///  Ext. Low-Freq. Crystal; Start-up time PWRDWN/RESET: 1K CK/14 CK + 4.1 ms
                EXTLOFXTAL_1KCK_14CK_4MS1 = 0x14,
                ///  Ext. Low-Freq. Crystal; Start-up time PWRDWN/RESET: 1K CK/14 CK + 65 ms
                EXTLOFXTAL_1KCK_14CK_65MS = 0x24,
                ///  Ext. Low-Freq. Crystal; Start-up time PWRDWN/RESET: 32K CK/14 CK + 0 ms
                EXTLOFXTAL_32KCK_14CK_0MS = 0x5,
                ///  Ext. Low-Freq. Crystal; Start-up time PWRDWN/RESET: 32K CK/14 CK + 4.1 ms
                EXTLOFXTAL_32KCK_14CK_4MS1 = 0x15,
                ///  Ext. Low-Freq. Crystal; Start-up time PWRDWN/RESET: 32K CK/14 CK + 65 ms
                EXTLOFXTAL_32KCK_14CK_65MS = 0x25,
                ///  Ext. Full-swing Crystal; Start-up time PWRDWN/RESET: 258 CK/14 CK + 4.1 ms
                EXTFSXTAL_258CK_14CK_4MS1 = 0x6,
                ///  Ext. Full-swing Crystal; Start-up time PWRDWN/RESET: 258 CK/14 CK + 65 ms
                EXTFSXTAL_258CK_14CK_65MS = 0x16,
                ///  Ext. Full-swing Crystal; Start-up time PWRDWN/RESET: 1K CK /14 CK + 0 ms
                EXTFSXTAL_1KCK_14CK_0MS = 0x26,
                ///  Ext. Full-swing Crystal; Start-up time PWRDWN/RESET: 1K CK /14 CK + 4.1 ms
                EXTFSXTAL_1KCK_14CK_4MS1 = 0x36,
                ///  Ext. Full-swing Crystal; Start-up time PWRDWN/RESET: 1K CK /14 CK + 65 ms
                EXTFSXTAL_1KCK_14CK_65MS = 0x7,
                ///  Ext. Full-swing Crystal; Start-up time PWRDWN/RESET: 16K CK/14 CK + 0 ms
                EXTFSXTAL_16KCK_14CK_0MS = 0x17,
                ///  Ext. Full-swing Crystal; Start-up time PWRDWN/RESET: 16K CK/14 CK + 4.1 ms
                EXTFSXTAL_16KCK_14CK_4MS1 = 0x27,
                ///  Ext. Full-swing Crystal; Start-up time PWRDWN/RESET: 16K CK/14 CK + 65 ms
                EXTFSXTAL_16KCK_14CK_65MS = 0x37,
                ///  Ext. Crystal Osc. 0.4-0.9 MHz; Start-up time PWRDWN/RESET: 258 CK/14 CK + 4.1 ms
                EXTXOSC_0MHZ4_0MHZ9_258CK_14CK_4MS1 = 0x8,
                ///  Ext. Crystal Osc. 0.4-0.9 MHz; Start-up time PWRDWN/RESET: 258 CK/14 CK + 65 ms
                EXTXOSC_0MHZ4_0MHZ9_258CK_14CK_65MS = 0x18,
                ///  Ext. Crystal Osc. 0.4-0.9 MHz; Start-up time PWRDWN/RESET: 1K CK /14 CK + 0 ms
                EXTXOSC_0MHZ4_0MHZ9_1KCK_14CK_0MS = 0x28,
                ///  Ext. Crystal Osc. 0.4-0.9 MHz; Start-up time PWRDWN/RESET: 1K CK /14 CK + 4.1 ms
                EXTXOSC_0MHZ4_0MHZ9_1KCK_14CK_4MS1 = 0x38,
                ///  Ext. Crystal Osc. 0.4-0.9 MHz; Start-up time PWRDWN/RESET: 1K CK /14 CK + 65 ms
                EXTXOSC_0MHZ4_0MHZ9_1KCK_14CK_65MS = 0x9,
                ///  Ext. Crystal Osc. 0.4-0.9 MHz; Start-up time PWRDWN/RESET: 16K CK/14 CK + 0 ms
                EXTXOSC_0MHZ4_0MHZ9_16KCK_14CK_0MS = 0x19,
                ///  Ext. Crystal Osc. 0.4-0.9 MHz; Start-up time PWRDWN/RESET: 16K CK/14 CK + 4.1 ms
                EXTXOSC_0MHZ4_0MHZ9_16KCK_14CK_4MS1 = 0x29,
                ///  Ext. Crystal Osc. 0.4-0.9 MHz; Start-up time PWRDWN/RESET: 16K CK/14 CK + 65 ms
                EXTXOSC_0MHZ4_0MHZ9_16KCK_14CK_65MS = 0x39,
                ///  Ext. Crystal Osc. 0.9-3.0 MHz; Start-up time PWRDWN/RESET: 258 CK/14 CK + 4.1 ms
                EXTXOSC_0MHZ9_3MHZ_258CK_14CK_4MS1 = 0xa,
                ///  Ext. Crystal Osc. 0.9-3.0 MHz; Start-up time PWRDWN/RESET: 258 CK/14 CK + 65 ms
                EXTXOSC_0MHZ9_3MHZ_258CK_14CK_65MS = 0x1a,
                ///  Ext. Crystal Osc. 0.9-3.0 MHz; Start-up time PWRDWN/RESET: 1K CK /14 CK + 0 ms
                EXTXOSC_0MHZ9_3MHZ_1KCK_14CK_0MS = 0x2a,
                ///  Ext. Crystal Osc. 0.9-3.0 MHz; Start-up time PWRDWN/RESET: 1K CK /14 CK + 4.1 ms
                EXTXOSC_0MHZ9_3MHZ_1KCK_14CK_4MS1 = 0x3a,
                ///  Ext. Crystal Osc. 0.9-3.0 MHz; Start-up time PWRDWN/RESET: 1K CK /14 CK + 65 ms
                EXTXOSC_0MHZ9_3MHZ_1KCK_14CK_65MS = 0xb,
                ///  Ext. Crystal Osc. 0.9-3.0 MHz; Start-up time PWRDWN/RESET: 16K CK/14 CK + 0 ms
                EXTXOSC_0MHZ9_3MHZ_16KCK_14CK_0MS = 0x1b,
                ///  Ext. Crystal Osc. 0.9-3.0 MHz; Start-up time PWRDWN/RESET: 16K CK/14 CK + 4.1 ms
                EXTXOSC_0MHZ9_3MHZ_16KCK_14CK_4MS1 = 0x2b,
                ///  Ext. Crystal Osc. 0.9-3.0 MHz; Start-up time PWRDWN/RESET: 16K CK/14 CK + 65 ms
                EXTXOSC_0MHZ9_3MHZ_16KCK_14CK_65MS = 0x3b,
                ///  Ext. Crystal Osc. 3.0-8.0 MHz; Start-up time PWRDWN/RESET: 258 CK/14 CK + 4.1 ms
                EXTXOSC_3MHZ_8MHZ_258CK_14CK_4MS1 = 0xc,
                ///  Ext. Crystal Osc. 3.0-8.0 MHz; Start-up time PWRDWN/RESET: 258 CK/14 CK + 65 ms
                EXTXOSC_3MHZ_8MHZ_258CK_14CK_65MS = 0x1c,
                ///  Ext. Crystal Osc. 3.0-8.0 MHz; Start-up time PWRDWN/RESET: 1K CK /14 CK + 0 ms
                EXTXOSC_3MHZ_8MHZ_1KCK_14CK_0MS = 0x2c,
                ///  Ext. Crystal Osc. 3.0-8.0 MHz; Start-up time PWRDWN/RESET: 1K CK /14 CK + 4.1 ms
                EXTXOSC_3MHZ_8MHZ_1KCK_14CK_4MS1 = 0x3c,
                ///  Ext. Crystal Osc. 3.0-8.0 MHz; Start-up time PWRDWN/RESET: 1K CK /14 CK + 65 ms
                EXTXOSC_3MHZ_8MHZ_1KCK_14CK_65MS = 0xd,
                ///  Ext. Crystal Osc. 3.0-8.0 MHz; Start-up time PWRDWN/RESET: 16K CK/14 CK + 0 ms
                EXTXOSC_3MHZ_8MHZ_16KCK_14CK_0MS = 0x1d,
                ///  Ext. Crystal Osc. 3.0-8.0 MHz; Start-up time PWRDWN/RESET: 16K CK/14 CK + 4.1 ms
                EXTXOSC_3MHZ_8MHZ_16KCK_14CK_4MS1 = 0x2d,
                ///  Ext. Crystal Osc. 3.0-8.0 MHz; Start-up time PWRDWN/RESET: 16K CK/14 CK + 65 ms
                EXTXOSC_3MHZ_8MHZ_16KCK_14CK_65MS = 0x3d,
                ///  Ext. Crystal Osc. 8.0- MHz; Start-up time PWRDWN/RESET: 258 CK/14 CK + 4.1 ms
                EXTXOSC_8MHZ_XX_258CK_14CK_4MS1 = 0xe,
                ///  Ext. Crystal Osc. 8.0- MHz; Start-up time PWRDWN/RESET: 258 CK/14 CK + 65 ms
                EXTXOSC_8MHZ_XX_258CK_14CK_65MS = 0x1e,
                ///  Ext. Crystal Osc. 8.0- MHz; Start-up time PWRDWN/RESET: 1K CK /14 CK + 0 ms
                EXTXOSC_8MHZ_XX_1KCK_14CK_0MS = 0x2e,
                ///  Ext. Crystal Osc. 8.0- MHz; Start-up time PWRDWN/RESET: 1K CK /14 CK + 4.1 ms
                EXTXOSC_8MHZ_XX_1KCK_14CK_4MS1 = 0x3e,
                ///  Ext. Crystal Osc. 8.0- MHz; Start-up time PWRDWN/RESET: 1K CK /14 CK + 65 ms
                EXTXOSC_8MHZ_XX_1KCK_14CK_65MS = 0xf,
                ///  Ext. Crystal Osc. 8.0- MHz; Start-up time PWRDWN/RESET: 16K CK/14 CK + 0 ms
                EXTXOSC_8MHZ_XX_16KCK_14CK_0MS = 0x1f,
                ///  Ext. Crystal Osc. 8.0- MHz; Start-up time PWRDWN/RESET: 16K CK/14 CK + 4.1 ms
                EXTXOSC_8MHZ_XX_16KCK_14CK_4MS1 = 0x2f,
                ///  Ext. Crystal Osc. 8.0- MHz; Start-up time PWRDWN/RESET: 16K CK/14 CK + 65 ms
                EXTXOSC_8MHZ_XX_16KCK_14CK_65MS = 0x3f,
                _,
            };

            pub const ENUM_BODLEVEL = enum(u3) {
                ///  Brown-out detection at VCC=4.3 V
                @"4V3" = 0x4,
                ///  Brown-out detection at VCC=2.7 V
                @"2V7" = 0x5,
                ///  Brown-out detection at VCC=1.8 V
                @"1V8" = 0x6,
                ///  Brown-out detection disabled
                DISABLED = 0x7,
                _,
            };

            pub const ENUM_BOOTSZ = enum(u2) {
                ///  Boot Flash size=256 words start address=$3F00
                @"256W_3F00" = 0x3,
                ///  Boot Flash size=512 words start address=$3E00
                @"512W_3E00" = 0x2,
                ///  Boot Flash size=1024 words start address=$3C00
                @"1024W_3C00" = 0x1,
                ///  Boot Flash size=2048 words start address=$3800
                @"2048W_3800" = 0x0,
            };

            LOW: mmio.Mmio(packed struct(u8) {
                ///  Select Clock Source
                SUT_CKSEL: packed union {
                    raw: u6,
                    value: ENUM_SUT_CKSEL,
                },
                ///  Clock output on PORTB0
                CKOUT: u1,
                ///  Divide clock by 8 internally
                CKDIV8: u1,
            }),
            HIGH: mmio.Mmio(packed struct(u8) {
                ///  Boot Reset vector Enabled
                BOOTRST: u1,
                ///  Select boot size
                BOOTSZ: packed union {
                    raw: u2,
                    value: ENUM_BOOTSZ,
                },
                ///  Preserve EEPROM through the Chip Erase cycle
                EESAVE: u1,
                ///  Watch-dog Timer always on
                WDTON: u1,
                ///  Serial program downloading (SPI) enabled
                SPIEN: u1,
                ///  Debug Wire enable
                DWEN: u1,
                ///  Reset Disabled (Enable PC6 as i/o pin)
                RSTDISBL: u1,
            }),
            EXTENDED: mmio.Mmio(packed struct(u8) {
                ///  Brown-out Detector trigger level
                BODLEVEL: packed union {
                    raw: u3,
                    value: ENUM_BODLEVEL,
                },
                padding: u5,
            }),
        };

        ///  Lockbits
        pub const LOCKBIT = extern struct {
            pub const ENUM_LB = enum(u2) {
                ///  Further programming and verification disabled
                PROG_VER_DISABLED = 0x0,
                ///  Further programming disabled
                PROG_DISABLED = 0x2,
                ///  No memory lock features enabled
                NO_LOCK = 0x3,
                _,
            };

            pub const ENUM_BLB = enum(u2) {
                ///  LPM and SPM prohibited in Application Section
                LPM_SPM_DISABLE = 0x0,
                ///  LPM prohibited in Application Section
                LPM_DISABLE = 0x1,
                ///  SPM prohibited in Application Section
                SPM_DISABLE = 0x2,
                ///  No lock on SPM and LPM in Application Section
                NO_LOCK = 0x3,
            };

            pub const ENUM_BLB2 = enum(u2) {
                ///  LPM and SPM prohibited in Boot Section
                LPM_SPM_DISABLE = 0x0,
                ///  LPM prohibited in Boot Section
                LPM_DISABLE = 0x1,
                ///  SPM prohibited in Boot Section
                SPM_DISABLE = 0x2,
                ///  No lock on SPM and LPM in Boot Section
                NO_LOCK = 0x3,
            };

            LOCKBIT: mmio.Mmio(packed struct(u8) {
                ///  Memory Lock
                LB: packed union {
                    raw: u2,
                    value: ENUM_LB,
                },
                ///  Boot Loader Protection Mode
                BLB0: packed union {
                    raw: u2,
                    value: ENUM_BLB,
                },
                ///  Boot Loader Protection Mode
                BLB1: packed union {
                    raw: u2,
                    value: ENUM_BLB2,
                },
                padding: u2,
            }),
        };

        ///  USART
        pub const USART = struct {
            pub const COMM_USART_MODE_2BIT = enum(u2) {
                ///  Asynchronous USART
                ASYNCHRONOUS_USART = 0x0,
                ///  Synchronous USART
                SYNCHRONOUS_USART = 0x1,
                ///  Master SPI
                MASTER_SPI = 0x3,
                _,
            };

            pub const COMM_UPM_PARITY_MODE = enum(u2) {
                ///  Disabled
                DISABLED = 0x0,
                ///  Reserved
                RESERVED = 0x1,
                ///  Enabled, Even Parity
                ENABLED_EVEN_PARITY = 0x2,
                ///  Enabled, Odd Parity
                ENABLED_ODD_PARITY = 0x3,
            };

            pub const COMM_STOP_BIT_SEL = enum(u1) {
                ///  1-bit
                @"1_BIT" = 0x0,
                ///  2-bit
                @"2_BIT" = 0x1,
            };

            ///  USART
            pub const USART0 = extern struct {
                ///  USART Control and Status Register A
                UCSR0A: mmio.Mmio(packed struct(u8) {
                    ///  Multi-processor Communication Mode
                    MPCM0: u1,
                    ///  Double the USART transmission speed
                    U2X0: u1,
                    ///  Parity Error
                    UPE0: u1,
                    ///  Data overRun
                    DOR0: u1,
                    ///  Framing Error
                    FE0: u1,
                    ///  USART Data Register Empty
                    UDRE0: u1,
                    ///  USART Transmitt Complete
                    TXC0: u1,
                    ///  USART Receive Complete
                    RXC0: u1,
                }),
                ///  USART Control and Status Register B
                UCSR0B: mmio.Mmio(packed struct(u8) {
                    ///  Transmit Data Bit 8
                    TXB80: u1,
                    ///  Receive Data Bit 8
                    RXB80: u1,
                    ///  Character Size - together with UCSZ0 in UCSR0C
                    UCSZ02: u1,
                    ///  Transmitter Enable
                    TXEN0: u1,
                    ///  Receiver Enable
                    RXEN0: u1,
                    ///  USART Data register Empty Interrupt Enable
                    UDRIE0: u1,
                    ///  TX Complete Interrupt Enable
                    TXCIE0: u1,
                    ///  RX Complete Interrupt Enable
                    RXCIE0: u1,
                }),
                ///  USART Control and Status Register C
                UCSR0C: mmio.Mmio(packed struct(u8) {
                    ///  Clock Polarity
                    UCPOL0: u1,
                    ///  Character Size - together with UCSZ2 in UCSR0B
                    UCSZ0: u2,
                    ///  Stop Bit Select
                    USBS0: packed union {
                        raw: u1,
                        value: COMM_STOP_BIT_SEL,
                    },
                    ///  Parity Mode Bits
                    UPM0: packed union {
                        raw: u2,
                        value: COMM_UPM_PARITY_MODE,
                    },
                    ///  USART Mode Select
                    UMSEL0: packed union {
                        raw: u2,
                        value: COMM_USART_MODE_2BIT,
                    },
                }),
                reserved4: [1]u8,
                ///  USART Baud Rate Register Bytes
                UBRR0: u16,
                ///  USART I/O Data Register
                UDR0: u8,
            };
        };

        ///  Two Wire Serial Interface
        pub const TWI = extern struct {
            pub const COMM_TWI_PRESACLE = enum(u2) {
                ///  1
                @"1" = 0x0,
                ///  4
                @"4" = 0x1,
                ///  16
                @"16" = 0x2,
                ///  64
                @"64" = 0x3,
            };

            ///  TWI Bit Rate register
            TWBR: u8,
            ///  TWI Status Register
            TWSR: mmio.Mmio(packed struct(u8) {
                ///  TWI Prescaler
                TWPS: packed union {
                    raw: u2,
                    value: COMM_TWI_PRESACLE,
                },
                reserved3: u1,
                ///  TWI Status
                TWS: u5,
            }),
            ///  TWI (Slave) Address register
            TWAR: mmio.Mmio(packed struct(u8) {
                ///  TWI General Call Recognition Enable Bit
                TWGCE: u1,
                ///  TWI (Slave) Address register Bits
                TWA: u7,
            }),
            ///  TWI Data register
            TWDR: u8,
            ///  TWI Control Register
            TWCR: mmio.Mmio(packed struct(u8) {
                ///  TWI Interrupt Enable
                TWIE: u1,
                reserved2: u1,
                ///  TWI Enable Bit
                TWEN: u1,
                ///  TWI Write Collition Flag
                TWWC: u1,
                ///  TWI Stop Condition Bit
                TWSTO: u1,
                ///  TWI Start Condition Bit
                TWSTA: u1,
                ///  TWI Enable Acknowledge Bit
                TWEA: u1,
                ///  TWI Interrupt Flag
                TWINT: u1,
            }),
            ///  TWI (Slave) Address Mask Register
            TWAMR: mmio.Mmio(packed struct(u8) {
                reserved1: u1,
                TWAM: u7,
            }),
        };

        ///  Timer/Counter, 16-bit
        pub const TC16 = struct {
            pub const CLK_SEL_3BIT_EXT = enum(u3) {
                ///  No Clock Source (Stopped)
                NO_CLOCK_SOURCE_STOPPED = 0x0,
                ///  Running, No Prescaling
                RUNNING_NO_PRESCALING = 0x1,
                ///  Running, CLK/8
                RUNNING_CLK_8 = 0x2,
                ///  Running, CLK/64
                RUNNING_CLK_64 = 0x3,
                ///  Running, CLK/256
                RUNNING_CLK_256 = 0x4,
                ///  Running, CLK/1024
                RUNNING_CLK_1024 = 0x5,
                ///  Running, ExtClk Tn Falling Edge
                RUNNING_EXTCLK_TN_FALLING_EDGE = 0x6,
                ///  Running, ExtClk Tn Rising Edge
                RUNNING_EXTCLK_TN_RISING_EDGE = 0x7,
            };

            ///  Timer/Counter, 16-bit
            pub const TC1 = extern struct {
                ///  Timer/Counter Interrupt Flag register
                TIFR1: mmio.Mmio(packed struct(u8) {
                    ///  Timer/Counter1 Overflow Flag
                    TOV1: u1,
                    ///  Output Compare Flag 1A
                    OCF1A: u1,
                    ///  Output Compare Flag 1B
                    OCF1B: u1,
                    reserved5: u2,
                    ///  Input Capture Flag 1
                    ICF1: u1,
                    padding: u2,
                }),
                reserved13: [12]u8,
                ///  General Timer/Counter Control Register
                GTCCR: mmio.Mmio(packed struct(u8) {
                    ///  Prescaler Reset Timer/Counter1 and Timer/Counter0
                    PSRSYNC: u1,
                    reserved7: u6,
                    ///  Timer/Counter Synchronization Mode
                    TSM: u1,
                }),
                reserved57: [43]u8,
                ///  Timer/Counter Interrupt Mask Register
                TIMSK1: mmio.Mmio(packed struct(u8) {
                    ///  Timer/Counter1 Overflow Interrupt Enable
                    TOIE1: u1,
                    ///  Timer/Counter1 Output CompareA Match Interrupt Enable
                    OCIE1A: u1,
                    ///  Timer/Counter1 Output CompareB Match Interrupt Enable
                    OCIE1B: u1,
                    reserved5: u2,
                    ///  Timer/Counter1 Input Capture Interrupt Enable
                    ICIE1: u1,
                    padding: u2,
                }),
                reserved74: [16]u8,
                ///  Timer/Counter1 Control Register A
                TCCR1A: mmio.Mmio(packed struct(u8) {
                    ///  Waveform Generation Mode
                    WGM1: u2,
                    reserved4: u2,
                    ///  Compare Output Mode 1B, bits
                    COM1B: u2,
                    ///  Compare Output Mode 1A, bits
                    COM1A: u2,
                }),
                ///  Timer/Counter1 Control Register B
                TCCR1B: mmio.Mmio(packed struct(u8) {
                    ///  Prescaler source of Timer/Counter 1
                    CS1: packed union {
                        raw: u3,
                        value: CLK_SEL_3BIT_EXT,
                    },
                    ///  Waveform Generation Mode
                    WGM1: u2,
                    reserved6: u1,
                    ///  Input Capture 1 Edge Select
                    ICES1: u1,
                    ///  Input Capture 1 Noise Canceler
                    ICNC1: u1,
                }),
                ///  Timer/Counter1 Control Register C
                TCCR1C: mmio.Mmio(packed struct(u8) {
                    reserved6: u6,
                    FOC1B: u1,
                    FOC1A: u1,
                }),
                reserved78: [1]u8,
                ///  Timer/Counter1 Bytes
                TCNT1: u16,
                ///  Timer/Counter1 Input Capture Register Bytes
                ICR1: u16,
                ///  Timer/Counter1 Output Compare Register Bytes
                OCR1A: u16,
                ///  Timer/Counter1 Output Compare Register Bytes
                OCR1B: u16,
            };
        };

        ///  Timer/Counter, 8-bit Async
        pub const TC8_ASYNC = struct {
            pub const CLK_SEL_3BIT = enum(u3) {
                ///  No Clock Source (Stopped)
                NO_CLOCK_SOURCE_STOPPED = 0x0,
                ///  Running, No Prescaling
                RUNNING_NO_PRESCALING = 0x1,
                ///  Running, CLK/8
                RUNNING_CLK_8 = 0x2,
                ///  Running, CLK/32
                RUNNING_CLK_32 = 0x3,
                ///  Running, CLK/64
                RUNNING_CLK_64 = 0x4,
                ///  Running, CLK/128
                RUNNING_CLK_128 = 0x5,
                ///  Running, CLK/256
                RUNNING_CLK_256 = 0x6,
                ///  Running, CLK/1024
                RUNNING_CLK_1024 = 0x7,
            };

            ///  Timer/Counter, 8-bit Async
            pub const TC2 = extern struct {
                ///  Timer/Counter Interrupt Flag Register
                TIFR2: mmio.Mmio(packed struct(u8) {
                    ///  Timer/Counter2 Overflow Flag
                    TOV2: u1,
                    ///  Output Compare Flag 2A
                    OCF2A: u1,
                    ///  Output Compare Flag 2B
                    OCF2B: u1,
                    padding: u5,
                }),
                reserved12: [11]u8,
                ///  General Timer Counter Control register
                GTCCR: mmio.Mmio(packed struct(u8) {
                    reserved1: u1,
                    ///  Prescaler Reset Timer/Counter2
                    PSRASY: u1,
                    reserved7: u5,
                    ///  Timer/Counter Synchronization Mode
                    TSM: u1,
                }),
                reserved57: [44]u8,
                ///  Timer/Counter Interrupt Mask register
                TIMSK2: mmio.Mmio(packed struct(u8) {
                    ///  Timer/Counter2 Overflow Interrupt Enable
                    TOIE2: u1,
                    ///  Timer/Counter2 Output Compare Match A Interrupt Enable
                    OCIE2A: u1,
                    ///  Timer/Counter2 Output Compare Match B Interrupt Enable
                    OCIE2B: u1,
                    padding: u5,
                }),
                reserved121: [63]u8,
                ///  Timer/Counter2 Control Register A
                TCCR2A: mmio.Mmio(packed struct(u8) {
                    ///  Waveform Genration Mode
                    WGM2: u2,
                    reserved4: u2,
                    ///  Compare Output Mode bits
                    COM2B: u2,
                    ///  Compare Output Mode bits
                    COM2A: u2,
                }),
                ///  Timer/Counter2 Control Register B
                TCCR2B: mmio.Mmio(packed struct(u8) {
                    ///  Clock Select bits
                    CS2: packed union {
                        raw: u3,
                        value: CLK_SEL_3BIT,
                    },
                    ///  Waveform Generation Mode
                    WGM22: u1,
                    reserved6: u2,
                    ///  Force Output Compare B
                    FOC2B: u1,
                    ///  Force Output Compare A
                    FOC2A: u1,
                }),
                ///  Timer/Counter2
                TCNT2: u8,
                ///  Timer/Counter2 Output Compare Register A
                OCR2A: u8,
                ///  Timer/Counter2 Output Compare Register B
                OCR2B: u8,
                reserved127: [1]u8,
                ///  Asynchronous Status Register
                ASSR: mmio.Mmio(packed struct(u8) {
                    ///  Timer/Counter Control Register2 Update Busy
                    TCR2BUB: u1,
                    ///  Timer/Counter Control Register2 Update Busy
                    TCR2AUB: u1,
                    ///  Output Compare Register 2 Update Busy
                    OCR2BUB: u1,
                    ///  Output Compare Register2 Update Busy
                    OCR2AUB: u1,
                    ///  Timer/Counter2 Update Busy
                    TCN2UB: u1,
                    ///  Asynchronous Timer/Counter2
                    AS2: u1,
                    ///  Enable External Clock Input
                    EXCLK: u1,
                    padding: u1,
                }),
            };
        };

        ///  Analog-to-Digital Converter
        pub const ADC = extern struct {
            pub const ANALOG_ADC_V_REF3 = enum(u2) {
                ///  AREF, Internal Vref turned off
                AREF_INTERNAL_VREF_TURNED_OFF = 0x0,
                ///  AVCC with external capacitor at AREF pin
                AVCC_WITH_EXTERNAL_CAPACITOR_AT_AREF_PIN = 0x1,
                ///  Reserved
                RESERVED = 0x2,
                ///  Internal 1.1V Voltage Reference with external capacitor at AREF pin
                INTERNAL_1_1V_VOLTAGE_REFERENCE_WITH_EXTERNAL_CAPACITOR_AT_AREF_PIN = 0x3,
            };

            pub const ADC_MUX_SINGLE = enum(u4) {
                ///  ADC Single Ended Input pin 0
                ADC0 = 0x0,
                ///  ADC Single Ended Input pin 1
                ADC1 = 0x1,
                ///  ADC Single Ended Input pin 2
                ADC2 = 0x2,
                ///  ADC Single Ended Input pin 3
                ADC3 = 0x3,
                ///  ADC Single Ended Input pin 4
                ADC4 = 0x4,
                ///  ADC Single Ended Input pin 5
                ADC5 = 0x5,
                ///  ADC Single Ended Input pin 6
                ADC6 = 0x6,
                ///  ADC Single Ended Input pin 7
                ADC7 = 0x7,
                ///  Temperature sensor
                TEMPSENS = 0x8,
                ///  Internal Reference (VBG)
                ADC_VBG = 0xe,
                ///  0V (GND)
                ADC_GND = 0xf,
                _,
            };

            pub const ANALOG_ADC_PRESCALER = enum(u3) {
                ///  2
                @"2" = 0x0,
                ///  2
                @"2" = 0x1,
                ///  4
                @"4" = 0x2,
                ///  8
                @"8" = 0x3,
                ///  16
                @"16" = 0x4,
                ///  32
                @"32" = 0x5,
                ///  64
                @"64" = 0x6,
                ///  128
                @"128" = 0x7,
            };

            pub const ANALOG_ADC_AUTO_TRIGGER = enum(u3) {
                ///  Free Running mode
                FREE_RUNNING_MODE = 0x0,
                ///  Analog Comparator
                ANALOG_COMPARATOR = 0x1,
                ///  External Interrupt Request 0
                EXTERNAL_INTERRUPT_REQUEST_0 = 0x2,
                ///  Timer/Counter0 Compare Match A
                TIMER_COUNTER0_COMPARE_MATCH_A = 0x3,
                ///  Timer/Counter0 Overflow
                TIMER_COUNTER0_OVERFLOW = 0x4,
                ///  Timer/Counter1 Compare Match B
                TIMER_COUNTER1_COMPARE_MATCH_B = 0x5,
                ///  Timer/Counter1 Overflow
                TIMER_COUNTER1_OVERFLOW = 0x6,
                ///  Timer/Counter1 Capture Event
                TIMER_COUNTER1_CAPTURE_EVENT = 0x7,
            };

            ///  ADC Data Register Bytes
            ADC: u16,
            ///  The ADC Control and Status register A
            ADCSRA: mmio.Mmio(packed struct(u8) {
                ///  ADC Prescaler Select Bits
                ADPS: packed union {
                    raw: u3,
                    value: ANALOG_ADC_PRESCALER,
                },
                ///  ADC Interrupt Enable
                ADIE: u1,
                ///  ADC Interrupt Flag
                ADIF: u1,
                ///  ADC Auto Trigger Enable
                ADATE: u1,
                ///  ADC Start Conversion
                ADSC: u1,
                ///  ADC Enable
                ADEN: u1,
            }),
            ///  The ADC Control and Status register B
            ADCSRB: mmio.Mmio(packed struct(u8) {
                ///  ADC Auto Trigger Source bits
                ADTS: packed union {
                    raw: u3,
                    value: ANALOG_ADC_AUTO_TRIGGER,
                },
                reserved6: u3,
                ACME: u1,
                padding: u1,
            }),
            ///  The ADC multiplexer Selection Register
            ADMUX: mmio.Mmio(packed struct(u8) {
                ///  Analog Channel Selection Bits
                MUX: packed union {
                    raw: u4,
                    value: ADC_MUX_SINGLE,
                },
                reserved5: u1,
                ///  Left Adjust Result
                ADLAR: u1,
                ///  Reference Selection Bits
                REFS: packed union {
                    raw: u2,
                    value: ANALOG_ADC_V_REF3,
                },
            }),
            reserved6: [1]u8,
            ///  Digital Input Disable Register
            DIDR0: mmio.Mmio(packed struct(u8) {
                ADC0D: u1,
                ADC1D: u1,
                ADC2D: u1,
                ADC3D: u1,
                ADC4D: u1,
                ADC5D: u1,
                padding: u2,
            }),
        };

        ///  Analog Comparator
        pub const AC = extern struct {
            pub const ANALOG_COMP_INTERRUPT = enum(u2) {
                ///  Interrupt on Toggle
                INTERRUPT_ON_TOGGLE = 0x0,
                ///  Reserved
                RESERVED = 0x1,
                ///  Interrupt on Falling Edge
                INTERRUPT_ON_FALLING_EDGE = 0x2,
                ///  Interrupt on Rising Edge
                INTERRUPT_ON_RISING_EDGE = 0x3,
            };

            ///  Analog Comparator Control And Status Register
            ACSR: mmio.Mmio(packed struct(u8) {
                ///  Analog Comparator Interrupt Mode Select bits
                ACIS: packed union {
                    raw: u2,
                    value: ANALOG_COMP_INTERRUPT,
                },
                ///  Analog Comparator Input Capture Enable
                ACIC: u1,
                ///  Analog Comparator Interrupt Enable
                ACIE: u1,
                ///  Analog Comparator Interrupt Flag
                ACI: u1,
                ///  Analog Compare Output
                ACO: u1,
                ///  Analog Comparator Bandgap Select
                ACBG: u1,
                ///  Analog Comparator Disable
                ACD: u1,
            }),
            reserved47: [46]u8,
            ///  Digital Input Disable Register 1
            DIDR1: mmio.Mmio(packed struct(u8) {
                ///  AIN0 Digital Input Disable
                AIN0D: u1,
                ///  AIN1 Digital Input Disable
                AIN1D: u1,
                padding: u6,
            }),
        };

        ///  I/O Port
        pub const PORT = struct {
            ///  I/O Port
            pub const PORTB = extern struct {
                ///  Port B Input Pins
                PINB: u8,
                ///  Port B Data Direction Register
                DDRB: u8,
                ///  Port B Data Register
                PORTB: u8,
            };

            ///  I/O Port
            pub const PORTC = extern struct {
                ///  Port C Input Pins
                PINC: u8,
                ///  Port C Data Direction Register
                DDRC: u8,
                ///  Port C Data Register
                PORTC: u8,
            };

            ///  I/O Port
            pub const PORTD = extern struct {
                ///  Port D Input Pins
                PIND: u8,
                ///  Port D Data Direction Register
                DDRD: u8,
                ///  Port D Data Register
                PORTD: u8,
            };
        };

        ///  Timer/Counter, 8-bit
        pub const TC8 = struct {
            pub const CLK_SEL_3BIT_EXT = enum(u3) {
                ///  No Clock Source (Stopped)
                NO_CLOCK_SOURCE_STOPPED = 0x0,
                ///  Running, No Prescaling
                RUNNING_NO_PRESCALING = 0x1,
                ///  Running, CLK/8
                RUNNING_CLK_8 = 0x2,
                ///  Running, CLK/64
                RUNNING_CLK_64 = 0x3,
                ///  Running, CLK/256
                RUNNING_CLK_256 = 0x4,
                ///  Running, CLK/1024
                RUNNING_CLK_1024 = 0x5,
                ///  Running, ExtClk Tn Falling Edge
                RUNNING_EXTCLK_TN_FALLING_EDGE = 0x6,
                ///  Running, ExtClk Tn Rising Edge
                RUNNING_EXTCLK_TN_RISING_EDGE = 0x7,
            };

            ///  Timer/Counter, 8-bit
            pub const TC0 = extern struct {
                ///  Timer/Counter0 Interrupt Flag register
                TIFR0: mmio.Mmio(packed struct(u8) {
                    ///  Timer/Counter0 Overflow Flag
                    TOV0: u1,
                    ///  Timer/Counter0 Output Compare Flag 0A
                    OCF0A: u1,
                    ///  Timer/Counter0 Output Compare Flag 0B
                    OCF0B: u1,
                    padding: u5,
                }),
                reserved14: [13]u8,
                ///  General Timer/Counter Control Register
                GTCCR: mmio.Mmio(packed struct(u8) {
                    ///  Prescaler Reset Timer/Counter1 and Timer/Counter0
                    PSRSYNC: u1,
                    reserved7: u6,
                    ///  Timer/Counter Synchronization Mode
                    TSM: u1,
                }),
                ///  Timer/Counter Control Register A
                TCCR0A: mmio.Mmio(packed struct(u8) {
                    ///  Waveform Generation Mode
                    WGM0: u2,
                    reserved4: u2,
                    ///  Compare Output Mode, Fast PWm
                    COM0B: u2,
                    ///  Compare Output Mode, Phase Correct PWM Mode
                    COM0A: u2,
                }),
                ///  Timer/Counter Control Register B
                TCCR0B: mmio.Mmio(packed struct(u8) {
                    ///  Clock Select
                    CS0: packed union {
                        raw: u3,
                        value: CLK_SEL_3BIT_EXT,
                    },
                    WGM02: u1,
                    reserved6: u2,
                    ///  Force Output Compare B
                    FOC0B: u1,
                    ///  Force Output Compare A
                    FOC0A: u1,
                }),
                ///  Timer/Counter0
                TCNT0: u8,
                ///  Timer/Counter0 Output Compare Register
                OCR0A: u8,
                ///  Timer/Counter0 Output Compare Register
                OCR0B: u8,
                reserved57: [37]u8,
                ///  Timer/Counter0 Interrupt Mask Register
                TIMSK0: mmio.Mmio(packed struct(u8) {
                    ///  Timer/Counter0 Overflow Interrupt Enable
                    TOIE0: u1,
                    ///  Timer/Counter0 Output Compare Match A Interrupt Enable
                    OCIE0A: u1,
                    ///  Timer/Counter0 Output Compare Match B Interrupt Enable
                    OCIE0B: u1,
                    padding: u5,
                }),
            };
        };

        ///  External Interrupts
        pub const EXINT = extern struct {
            ///  Interrupt Sense Control
            pub const INTERRUPT_SENSE_CONTROL = enum(u2) {
                ///  Low Level of INTX
                LOW_LEVEL_OF_INTX = 0x0,
                ///  Any Logical Change of INTX
                ANY_LOGICAL_CHANGE_OF_INTX = 0x1,
                ///  Falling Edge of INTX
                FALLING_EDGE_OF_INTX = 0x2,
                ///  Rising Edge of INTX
                RISING_EDGE_OF_INTX = 0x3,
            };

            ///  Pin Change Interrupt Flag Register
            PCIFR: mmio.Mmio(packed struct(u8) {
                ///  Pin Change Interrupt Flags
                PCIF: u3,
                padding: u5,
            }),
            ///  External Interrupt Flag Register
            EIFR: mmio.Mmio(packed struct(u8) {
                ///  External Interrupt Flags
                INTF: u2,
                padding: u6,
            }),
            ///  External Interrupt Mask Register
            EIMSK: mmio.Mmio(packed struct(u8) {
                ///  External Interrupt Request 1 Enable
                INT: u2,
                padding: u6,
            }),
            reserved45: [42]u8,
            ///  Pin Change Interrupt Control Register
            PCICR: mmio.Mmio(packed struct(u8) {
                ///  Pin Change Interrupt Enables
                PCIE: u3,
                padding: u5,
            }),
            ///  External Interrupt Control Register
            EICRA: mmio.Mmio(packed struct(u8) {
                ///  External Interrupt Sense Control 0 Bits
                ISC0: packed union {
                    raw: u2,
                    value: INTERRUPT_SENSE_CONTROL,
                },
                ///  External Interrupt Sense Control 1 Bits
                ISC1: packed union {
                    raw: u2,
                    value: INTERRUPT_SENSE_CONTROL,
                },
                padding: u4,
            }),
            reserved48: [1]u8,
            ///  Pin Change Mask Register 0
            PCMSK0: mmio.Mmio(packed struct(u8) {
                ///  Pin Change Enable Masks
                PCINT: u8,
            }),
            ///  Pin Change Mask Register 1
            PCMSK1: mmio.Mmio(packed struct(u8) {
                ///  Pin Change Enable Masks
                PCINT: u7,
                padding: u1,
            }),
            ///  Pin Change Mask Register 2
            PCMSK2: mmio.Mmio(packed struct(u8) {
                ///  Pin Change Enable Masks
                PCINT: u8,
            }),
        };

        ///  Serial Peripheral Interface
        pub const SPI = extern struct {
            pub const COMM_SCK_RATE_3BIT = enum(u2) {
                ///  fosc/2 or fosc/4
                FOSC_2_OR_FOSC_4 = 0x0,
                ///  fosc/8 or fosc/16
                FOSC_8_OR_FOSC_16 = 0x1,
                ///  fosc/32 or fosc/64
                FOSC_32_OR_FOSC_64 = 0x2,
                ///  fosc/64 or fosc/128
                FOSC_64_OR_FOSC_128 = 0x3,
            };

            ///  SPI Control Register
            SPCR: mmio.Mmio(packed struct(u8) {
                ///  SPI Clock Rate Selects
                SPR: packed union {
                    raw: u2,
                    value: COMM_SCK_RATE_3BIT,
                },
                ///  Clock Phase
                CPHA: u1,
                ///  Clock polarity
                CPOL: u1,
                ///  Master/Slave Select
                MSTR: u1,
                ///  Data Order
                DORD: u1,
                ///  SPI Enable
                SPE: u1,
                ///  SPI Interrupt Enable
                SPIE: u1,
            }),
            ///  SPI Status Register
            SPSR: mmio.Mmio(packed struct(u8) {
                ///  Double SPI Speed Bit
                SPI2X: u1,
                reserved6: u5,
                ///  Write Collision Flag
                WCOL: u1,
                ///  SPI Interrupt Flag
                SPIF: u1,
            }),
            ///  SPI Data Register
            SPDR: u8,
        };

        ///  Watchdog Timer
        pub const WDT = extern struct {
            pub const WDOG_TIMER_PRESCALE_4BITS = enum(u4) {
                ///  Oscillator Cycles 2K
                OSCILLATOR_CYCLES_2K = 0x0,
                ///  Oscillator Cycles 4K
                OSCILLATOR_CYCLES_4K = 0x1,
                ///  Oscillator Cycles 8K
                OSCILLATOR_CYCLES_8K = 0x2,
                ///  Oscillator Cycles 16K
                OSCILLATOR_CYCLES_16K = 0x3,
                ///  Oscillator Cycles 32K
                OSCILLATOR_CYCLES_32K = 0x4,
                ///  Oscillator Cycles 64K
                OSCILLATOR_CYCLES_64K = 0x5,
                ///  Oscillator Cycles 128K
                OSCILLATOR_CYCLES_128K = 0x6,
                ///  Oscillator Cycles 256K
                OSCILLATOR_CYCLES_256K = 0x7,
                ///  Oscillator Cycles 512K
                OSCILLATOR_CYCLES_512K = 0x8,
                ///  Oscillator Cycles 1024K
                OSCILLATOR_CYCLES_1024K = 0x9,
                _,
            };

            ///  Watchdog Timer Control Register
            WDTCSR: mmio.Mmio(packed struct(u8) {
                ///  Watchdog Timer Prescaler Bits
                WDP_bit0: u1,
                ///  Watchdog Timer Prescaler Bits
                WDP_bit1: u1,
                ///  Watchdog Timer Prescaler Bits
                WDP_bit2: u1,
                ///  Watch Dog Enable
                WDE: u1,
                ///  Watchdog Change Enable
                WDCE: u1,
                ///  Watchdog Timer Prescaler Bits
                WDP_bit3: u1,
                ///  Watchdog Timeout Interrupt Enable
                WDIE: u1,
                ///  Watchdog Timeout Interrupt Flag
                WDIF: u1,
            }),
        };

        ///  CPU Registers
        pub const CPU = extern struct {
            pub const CPU_CLK_PRESCALE_4_BITS_SMALL = enum(u4) {
                ///  1
                @"1" = 0x0,
                ///  2
                @"2" = 0x1,
                ///  4
                @"4" = 0x2,
                ///  8
                @"8" = 0x3,
                ///  16
                @"16" = 0x4,
                ///  32
                @"32" = 0x5,
                ///  64
                @"64" = 0x6,
                ///  128
                @"128" = 0x7,
                ///  256
                @"256" = 0x8,
                _,
            };

            pub const CPU_SLEEP_MODE_3BITS2 = enum(u3) {
                ///  Idle
                IDLE = 0x0,
                ///  ADC Noise Reduction (If Available)
                ADC = 0x1,
                ///  Power Down
                PDOWN = 0x2,
                ///  Power Save
                PSAVE = 0x3,
                ///  Reserved
                VAL_0x04 = 0x4,
                ///  Reserved
                VAL_0x05 = 0x5,
                ///  Standby
                STDBY = 0x6,
                ///  Extended Standby
                ESTDBY = 0x7,
            };

            ///  Oscillator Calibration Values
            pub const OSCCAL_VALUE_ADDRESSES = enum(u1) {
                ///  8.0 MHz
                @"8_0_MHz" = 0x0,
                _,
            };

            ///  General Purpose I/O Register 0
            GPIOR0: u8,
            reserved12: [11]u8,
            ///  General Purpose I/O Register 1
            GPIOR1: u8,
            ///  General Purpose I/O Register 2
            GPIOR2: u8,
            reserved21: [7]u8,
            ///  Sleep Mode Control Register
            SMCR: mmio.Mmio(packed struct(u8) {
                ///  Sleep Enable
                SE: u1,
                ///  Sleep Mode Select Bits
                SM: packed union {
                    raw: u3,
                    value: CPU_SLEEP_MODE_3BITS2,
                },
                padding: u4,
            }),
            ///  MCU Status Register
            MCUSR: mmio.Mmio(packed struct(u8) {
                ///  Power-on reset flag
                PORF: u1,
                ///  External Reset Flag
                EXTRF: u1,
                ///  Brown-out Reset Flag
                BORF: u1,
                ///  Watchdog Reset Flag
                WDRF: u1,
                padding: u4,
            }),
            ///  MCU Control Register
            MCUCR: mmio.Mmio(packed struct(u8) {
                IVCE: u1,
                IVSEL: u1,
                reserved4: u2,
                PUD: u1,
                ///  BOD Sleep Enable
                BODSE: u1,
                ///  BOD Sleep
                BODS: u1,
                padding: u1,
            }),
            reserved25: [1]u8,
            ///  Store Program Memory Control and Status Register
            SPMCSR: mmio.Mmio(packed struct(u8) {
                ///  Store Program Memory
                SPMEN: u1,
                ///  Page Erase
                PGERS: u1,
                ///  Page Write
                PGWRT: u1,
                ///  Boot Lock Bit Set
                BLBSET: u1,
                ///  Read-While-Write section read enable
                RWWSRE: u1,
                ///  Signature Row Read
                SIGRD: u1,
                ///  Read-While-Write Section Busy
                RWWSB: u1,
                ///  SPM Interrupt Enable
                SPMIE: u1,
            }),
            reserved31: [5]u8,
            ///  Stack Pointer
            SP: u16,
            ///  Status Register
            SREG: mmio.Mmio(packed struct(u8) {
                ///  Carry Flag
                C: u1,
                ///  Zero Flag
                Z: u1,
                ///  Negative Flag
                N: u1,
                ///  Two's Complement Overflow Flag
                V: u1,
                ///  Sign Bit
                S: u1,
                ///  Half Carry Flag
                H: u1,
                ///  Bit Copy Storage
                T: u1,
                ///  Global Interrupt Enable
                I: u1,
            }),
            reserved35: [1]u8,
            ///  Clock Prescale Register
            CLKPR: mmio.Mmio(packed struct(u8) {
                ///  Clock Prescaler Select Bits
                CLKPS: packed union {
                    raw: u4,
                    value: CPU_CLK_PRESCALE_4_BITS_SMALL,
                },
                reserved7: u3,
                ///  Clock Prescaler Change Enable
                CLKPCE: u1,
            }),
            reserved38: [2]u8,
            ///  Power Reduction Register
            PRR: mmio.Mmio(packed struct(u8) {
                ///  Power Reduction ADC
                PRADC: u1,
                ///  Power Reduction USART
                PRUSART0: u1,
                ///  Power Reduction Serial Peripheral Interface
                PRSPI: u1,
                ///  Power Reduction Timer/Counter1
                PRTIM1: u1,
                reserved5: u1,
                ///  Power Reduction Timer/Counter0
                PRTIM0: u1,
                ///  Power Reduction Timer/Counter2
                PRTIM2: u1,
                ///  Power Reduction TWI
                PRTWI: u1,
            }),
            reserved40: [1]u8,
            ///  Oscillator Calibration Value
            OSCCAL: mmio.Mmio(packed struct(u8) {
                ///  Oscillator Calibration
                OSCCAL: u8,
            }),
        };

        ///  EEPROM
        pub const EEPROM = extern struct {
            pub const EEP_MODE = enum(u2) {
                ///  Erase and Write in one operation
                ERASE_AND_WRITE_IN_ONE_OPERATION = 0x0,
                ///  Erase Only
                ERASE_ONLY = 0x1,
                ///  Write Only
                WRITE_ONLY = 0x2,
                _,
            };

            ///  EEPROM Control Register
            EECR: mmio.Mmio(packed struct(u8) {
                ///  EEPROM Read Enable
                EERE: u1,
                ///  EEPROM Write Enable
                EEPE: u1,
                ///  EEPROM Master Write Enable
                EEMPE: u1,
                ///  EEPROM Ready Interrupt Enable
                EERIE: u1,
                ///  EEPROM Programming Mode Bits
                EEPM: packed union {
                    raw: u2,
                    value: EEP_MODE,
                },
                padding: u2,
            }),
            ///  EEPROM Data Register
            EEDR: u8,
            ///  EEPROM Address Register Bytes
            EEAR: u16,
        };
    };
};
