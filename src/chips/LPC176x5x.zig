const micro = @import("microzig");
const mmio = micro.mmio;

pub const devices = struct {
    ///  LPC176x/LPC175x M3
    pub const LPC176x5x = struct {
        pub const properties = struct {
            pub const @"cpu.nvic_prio_bits" = "5";
            pub const @"cpu.mpu" = "1";
            pub const @"cpu.fpu" = "0";
            pub const @"cpu.revision" = "r0p0";
            pub const @"cpu.vendor_systick_config" = "0";
            pub const @"cpu.endian" = "little";
            pub const @"cpu.name" = "CM3";
        };

        pub const VectorTable = extern struct {
            const Handler = micro.interrupt.Handler;
            const unhandled = micro.interrupt.unhandled;

            initial_stack_pointer: u32,
            Reset: Handler = unhandled,
            NMI: Handler = unhandled,
            HardFault: Handler = unhandled,
            MemManageFault: Handler = unhandled,
            BusFault: Handler = unhandled,
            UsageFault: Handler = unhandled,
            reserved5: [4]u32 = undefined,
            SVCall: Handler = unhandled,
            DebugMonitor: Handler = unhandled,
            reserved11: [1]u32 = undefined,
            PendSV: Handler = unhandled,
            SysTick: Handler = unhandled,
            WDT: Handler = unhandled,
            TIMER0: Handler = unhandled,
            TIMER1: Handler = unhandled,
            TIMER2: Handler = unhandled,
            TIMER3: Handler = unhandled,
            UART0: Handler = unhandled,
            UART1: Handler = unhandled,
            UART2: Handler = unhandled,
            UART3: Handler = unhandled,
            PWM1: Handler = unhandled,
            I2C0: Handler = unhandled,
            I2C1: Handler = unhandled,
            I2C2: Handler = unhandled,
            SPI: Handler = unhandled,
            SSP0: Handler = unhandled,
            SSP1: Handler = unhandled,
            reserved30: [1]u32 = undefined,
            RTC: Handler = unhandled,
            EINT0: Handler = unhandled,
            reserved33: [3]u32 = undefined,
            ADC: Handler = unhandled,
            reserved37: [1]u32 = undefined,
            USB: Handler = unhandled,
            CAN: Handler = unhandled,
            DMA: Handler = unhandled,
            I2S: Handler = unhandled,
            ENET: Handler = unhandled,
            RIT: Handler = unhandled,
            MCPWM: Handler = unhandled,
            QEI: Handler = unhandled,
            reserved46: [2]u32 = undefined,
            CANActivity: Handler = unhandled,
        };

        pub const peripherals = struct {
            ///  General Purpose I/O
            pub const GPIO = @ptrCast(*volatile types.GPIO, 0x2009c000);
            ///  Watchdog Timer (WDT)
            pub const WDT = @ptrCast(*volatile types.WDT, 0x40000000);
            ///  Timer0/1/2/3
            pub const TIMER0 = @ptrCast(*volatile types.TIMER0, 0x40004000);
            ///  Timer0/1/2/3
            pub const TIMER1 = @ptrCast(*volatile types.TIMER0, 0x40008000);
            ///  UART0/2/3
            pub const UART0 = @ptrCast(*volatile types.UART0, 0x4000c000);
            ///  UART1
            pub const UART1 = @ptrCast(*volatile types.UART1, 0x40010000);
            ///  Pulse Width Modulators (PWM1)
            pub const PWM1 = @ptrCast(*volatile types.PWM1, 0x40018000);
            ///  I2C bus interface
            pub const I2C0 = @ptrCast(*volatile types.I2C0, 0x4001c000);
            ///  SPI
            pub const SPI = @ptrCast(*volatile types.SPI, 0x40020000);
            ///  Real Time Clock (RTC)
            pub const RTC = @ptrCast(*volatile types.RTC, 0x40024000);
            ///  GPIO
            pub const GPIOINT = @ptrCast(*volatile types.GPIOINT, 0x40028080);
            ///  Pin connect block
            pub const PINCONNECT = @ptrCast(*volatile types.PINCONNECT, 0x4002c000);
            ///  SSP1 controller
            pub const SSP1 = @ptrCast(*volatile types.SSP1, 0x40030000);
            ///  Analog-to-Digital Converter (ADC)
            pub const ADC = @ptrCast(*volatile types.ADC, 0x40034000);
            ///  CAN acceptance filter RAM
            pub const CANAFRAM = @ptrCast(*volatile types.CANAFRAM, 0x40038000);
            ///  CAN controller acceptance filter
            pub const CANAF = @ptrCast(*volatile types.CANAF, 0x4003c000);
            ///  Central CAN controller
            pub const CCAN = @ptrCast(*volatile types.CCAN, 0x40040000);
            ///  CAN1 controller
            pub const CAN1 = @ptrCast(*volatile types.CAN1, 0x40044000);
            ///  CAN1 controller
            pub const CAN2 = @ptrCast(*volatile types.CAN1, 0x40048000);
            ///  I2C bus interface
            pub const I2C1 = @ptrCast(*volatile types.I2C0, 0x4005c000);
            ///  SSP controller
            pub const SSP0 = @ptrCast(*volatile types.SSP1, 0x40088000);
            ///  Digital-to-Analog Converter (DAC)
            pub const DAC = @ptrCast(*volatile types.DAC, 0x4008c000);
            ///  Timer0/1/2/3
            pub const TIMER2 = @ptrCast(*volatile types.TIMER0, 0x40090000);
            ///  Timer0/1/2/3
            pub const TIMER3 = @ptrCast(*volatile types.TIMER0, 0x40094000);
            ///  UART0/2/3
            pub const UART2 = @ptrCast(*volatile types.UART0, 0x40098000);
            ///  UART0/2/3
            pub const UART3 = @ptrCast(*volatile types.UART0, 0x4009c000);
            ///  I2C bus interface
            pub const I2C2 = @ptrCast(*volatile types.I2C0, 0x400a0000);
            ///  I2S interface
            pub const I2S = @ptrCast(*volatile types.I2S, 0x400a8000);
            ///  Repetitive Interrupt Timer (RIT)
            pub const RITIMER = @ptrCast(*volatile types.RITIMER, 0x400b0000);
            ///  Motor Control PWM
            pub const MCPWM = @ptrCast(*volatile types.MCPWM, 0x400b8000);
            ///  Quadrature Encoder Interface (QEI)
            pub const QEI = @ptrCast(*volatile types.QEI, 0x400bc000);
            ///  System and clock control
            pub const SYSCON = @ptrCast(*volatile types.SYSCON, 0x400fc000);
            ///  Ethernet
            pub const EMAC = @ptrCast(*volatile types.EMAC, 0x50000000);
            ///  General purpose DMA controller
            pub const GPDMA = @ptrCast(*volatile types.GPDMA, 0x50004000);
            ///  USB device/host/OTG controller
            pub const USB = @ptrCast(*volatile types.USB, 0x50008000);
        };
    };
};

pub const types = struct {
    ///  Watchdog Timer (WDT)
    pub const WDT = extern struct {
        ///  Watchdog mode register. This register determines the basic mode and status of the Watchdog Timer.
        MOD: mmio.Mmio(packed struct(u32) {
            ///  Watchdog enable bit. This bit is Set Only.
            WDEN: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The watchdog timer is stopped.
                    STOP = 0x0,
                    ///  The watchdog timer is running.
                    RUN = 0x1,
                },
            },
            ///  Watchdog reset enable bit. This bit is Set Only. See Table 652.
            WDRESET: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A watchdog timeout will not cause a chip reset.
                    NORESET = 0x0,
                    ///  A watchdog timeout will cause a chip reset.
                    RESET = 0x1,
                },
            },
            ///  Watchdog time-out flag. Set when the watchdog timer times out, cleared by software.
            WDTOF: u1,
            ///  Watchdog interrupt flag. Cleared by software.
            WDINT: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u28,
        }),
        ///  Watchdog timer constant register. The value in this register determines the time-out value.
        TC: mmio.Mmio(packed struct(u32) {
            ///  Watchdog time-out interval.
            Count: u32,
        }),
        ///  Watchdog feed sequence register. Writing 0xAA followed by 0x55 to this register reloads the Watchdog timer with the value contained in WDTC.
        FEED: mmio.Mmio(packed struct(u32) {
            ///  Feed value should be 0xAA followed by 0x55.
            Feed: u8,
            padding: u24,
        }),
        ///  Watchdog timer value register. This register reads out the current value of the Watchdog timer.
        TV: mmio.Mmio(packed struct(u32) {
            ///  Counter timer value.
            Count: u32,
        }),
        ///  Watchdog clock select register.
        CLKSEL: mmio.Mmio(packed struct(u32) {
            reserved1: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u30,
            ///  If this bit is set to one writing to this register does not affect bit 0. The clock source can only be changed by first clearing this bit, then writing the new value of bit 0.
            LOCK: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  This bit is set to 0 on any reset. It cannot be cleared by software.
                    UNLOCKED = 0x0,
                    ///  Software can set this bit to 1 at any time. Once WDLOCK is set, the bits of this register cannot be modified.
                    LOCKED = 0x1,
                },
            },
        }),
    };

    ///  Timer0/1/2/3
    pub const TIMER0 = extern struct {
        ///  Interrupt Register. The IR can be written to clear interrupts. The IR can be read to identify which of eight possible interrupt sources are pending.
        IR: mmio.Mmio(packed struct(u32) {
            ///  Interrupt flag for match channel 0.
            MR0INT: u1,
            ///  Interrupt flag for match channel 1.
            MR1INT: u1,
            ///  Interrupt flag for match channel 2.
            MR2INT: u1,
            ///  Interrupt flag for match channel 3.
            MR3INT: u1,
            ///  Interrupt flag for capture channel 0 event.
            CR0INT: u1,
            ///  Interrupt flag for capture channel 1 event.
            CR1INT: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u26,
        }),
        ///  Timer Control Register. The TCR is used to control the Timer Counter functions. The Timer Counter can be disabled or reset through the TCR.
        TCR: mmio.Mmio(packed struct(u32) {
            ///  When one, the Timer Counter and Prescale Counter are enabled for counting. When zero, the counters are disabled.
            CEN: u1,
            ///  When one, the Timer Counter and the Prescale Counter are synchronously reset on the next positive edge of PCLK. The counters remain reset until TCR[1] is returned to zero.
            CRST: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u30,
        }),
        ///  Timer Counter. The 32 bit TC is incremented every PR+1 cycles of PCLK. The TC is controlled through the TCR.
        TC: mmio.Mmio(packed struct(u32) {
            ///  Timer counter value.
            TC: u32,
        }),
        ///  Prescale Register. When the Prescale Counter (PC) is equal to this value, the next clock increments the TC and clears the PC.
        PR: mmio.Mmio(packed struct(u32) {
            ///  Prescale counter maximum value.
            PM: u32,
        }),
        ///  Prescale Counter. The 32 bit PC is a counter which is incremented to the value stored in PR. When the value in PR is reached, the TC is incremented and the PC is cleared. The PC is observable and controllable through the bus interface.
        PC: mmio.Mmio(packed struct(u32) {
            ///  Prescale counter value.
            PC: u32,
        }),
        ///  Match Control Register. The MCR is used to control if an interrupt is generated and if the TC is reset when a Match occurs.
        MCR: mmio.Mmio(packed struct(u32) {
            ///  Interrupt on MR0
            MR0I: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Interrupt is generated when MR0 matches the value in the TC.
                    INTERRUPT_IS_GENERAT = 0x1,
                    ///  Interrupt is disabled
                    INTERRUPT_IS_DISABLE = 0x0,
                },
            },
            ///  Reset on MR0
            MR0R: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  TC will be reset if MR0 matches it.
                    TC_WILL_BE_RESET_IF_ = 0x1,
                    ///  Feature disabled.
                    FEATURE_DISABLED_ = 0x0,
                },
            },
            ///  Stop on MR0
            MR0S: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  TC and PC will be stopped and TCR[0] will be set to 0 if MR0 matches the TC.
                    TC_AND_PC_WILL_BE_ST = 0x1,
                    ///  Feature disabled.
                    FEATURE_DISABLED_ = 0x0,
                },
            },
            ///  Interrupt on MR1
            MR1I: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Interrupt is generated when MR1 matches the value in the TC.
                    INTERRUPT_IS_GENERAT = 0x1,
                    ///  Interrupt is disabled.
                    INTERRUPT_IS_DISABLE = 0x0,
                },
            },
            ///  Reset on MR1
            MR1R: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  TC will be reset if MR1 matches it.
                    TC_WILL_BE_RESET_IF_ = 0x1,
                    ///  Feature disabled.
                    FEATURE_DISABLED_ = 0x0,
                },
            },
            ///  Stop on MR1
            MR1S: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  TC and PC will be stopped and TCR[0] will be set to 0 if MR1 matches the TC.
                    TC_AND_PC_WILL_BE_ST = 0x1,
                    ///  Feature disabled.
                    FEATURE_DISABLED_ = 0x0,
                },
            },
            ///  Interrupt on MR2
            MR2I: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Interrupt is generated when MR2 matches the value in the TC.
                    INTERRUPT_IS_GENERAT = 0x1,
                    ///  Interrupt is disabled
                    INTERRUPT_IS_DISABLE = 0x0,
                },
            },
            ///  Reset on MR2
            MR2R: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  TC will be reset if MR2 matches it.
                    TC_WILL_BE_RESET_IF_ = 0x1,
                    ///  Feature disabled.
                    FEATURE_DISABLED_ = 0x0,
                },
            },
            ///  Stop on MR2.
            MR2S: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  TC and PC will be stopped and TCR[0] will be set to 0 if MR2 matches the TC
                    TC_AND_PC_WILL_BE_ST = 0x1,
                    ///  Feature disabled.
                    FEATURE_DISABLED_ = 0x0,
                },
            },
            ///  Interrupt on MR3
            MR3I: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Interrupt is generated when MR3 matches the value in the TC.
                    INTERRUPT_IS_GENERAT = 0x1,
                    ///  This interrupt is disabled
                    THIS_INTERRUPT_IS_DI = 0x0,
                },
            },
            ///  Reset on MR3
            MR3R: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  TC will be reset if MR3 matches it.
                    TC_WILL_BE_RESET_IF_ = 0x1,
                    ///  Feature disabled.
                    FEATURE_DISABLED_ = 0x0,
                },
            },
            ///  Stop on MR3
            MR3S: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  TC and PC will be stopped and TCR[0] will be set to 0 if MR3 matches the TC.
                    TC_AND_PC_WILL_BE_ST = 0x1,
                    ///  Feature disabled.
                    FEATURE_DISABLED_ = 0x0,
                },
            },
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u20,
        }),
        reserved40: [16]u8,
        ///  Capture Control Register. The CCR controls which edges of the capture inputs are used to load the Capture Registers and whether or not an interrupt is generated when a capture takes place.
        CCR: mmio.Mmio(packed struct(u32) {
            ///  Capture on CAPn.0 rising edge
            CAP0RE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A sequence of 0 then 1 on CAPn.0 will cause CR0 to be loaded with the contents of TC.
                    ENABLE = 0x1,
                    ///  This feature is disabled.
                    DISABLE = 0x0,
                },
            },
            ///  Capture on CAPn.0 falling edge
            CAP0FE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A sequence of 1 then 0 on CAPn.0 will cause CR0 to be loaded with the contents of TC.
                    ENABLE = 0x1,
                    ///  This feature is disabled.
                    DISABLE = 0x0,
                },
            },
            ///  Interrupt on CAPn.0 event
            CAP0I: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A CR0 load due to a CAPn.0 event will generate an interrupt.
                    ENABLE = 0x1,
                    ///  This feature is disabled.
                    DISABLE = 0x0,
                },
            },
            ///  Capture on CAPn.1 rising edge
            CAP1RE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A sequence of 0 then 1 on CAPn.1 will cause CR1 to be loaded with the contents of TC.
                    ENABLE = 0x1,
                    ///  This feature is disabled.
                    DISABLE = 0x0,
                },
            },
            ///  Capture on CAPn.1 falling edge
            CAP1FE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A sequence of 1 then 0 on CAPn.1 will cause CR1 to be loaded with the contents of TC.
                    ENABLE = 0x1,
                    ///  This feature is disabled.
                    DISABLE = 0x0,
                },
            },
            ///  Interrupt on CAPn.1 event
            CAP1I: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A CR1 load due to a CAPn.1 event will generate an interrupt.
                    ENABLE = 0x1,
                    ///  This feature is disabled.
                    DISABLE = 0x0,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u26,
        }),
        reserved60: [16]u8,
        ///  External Match Register. The EMR controls the external match pins.
        EMR: mmio.Mmio(packed struct(u32) {
            ///  External Match 0. When a match occurs between the TC and MR0, this bit can either toggle, go low, go high, or do nothing, depending on bits 5:4 of this register. This bit can be driven onto a MATn.0 pin, in a positive-logic manner (0 = low, 1 = high).
            EM0: u1,
            ///  External Match 1. When a match occurs between the TC and MR1, this bit can either toggle, go low, go high, or do nothing, depending on bits 7:6 of this register. This bit can be driven onto a MATn.1 pin, in a positive-logic manner (0 = low, 1 = high).
            EM1: u1,
            ///  External Match 2. When a match occurs between the TC and MR2, this bit can either toggle, go low, go high, or do nothing, depending on bits 9:8 of this register. This bit can be driven onto a MATn.0 pin, in a positive-logic manner (0 = low, 1 = high).
            EM2: u1,
            ///  External Match 3. When a match occurs between the TC and MR3, this bit can either toggle, go low, go high, or do nothing, depending on bits 11:10 of this register. This bit can be driven onto a MATn.0 pin, in a positive-logic manner (0 = low, 1 = high).
            EM3: u1,
            ///  External Match Control 0. Determines the functionality of External Match 0.
            EMC0: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Do Nothing.
                    DO_NOTHING_ = 0x0,
                    ///  Clear the corresponding External Match bit/output to 0 (MATn.m pin is LOW if pinned out).
                    CLEAR_THE_CORRESPOND = 0x1,
                    ///  Set the corresponding External Match bit/output to 1 (MATn.m pin is HIGH if pinned out).
                    SET_THE_CORRESPONDIN = 0x2,
                    ///  Toggle the corresponding External Match bit/output.
                    TOGGLE_THE_CORRESPON = 0x3,
                },
            },
            ///  External Match Control 1. Determines the functionality of External Match 1.
            EMC1: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Do Nothing.
                    DO_NOTHING_ = 0x0,
                    ///  Clear the corresponding External Match bit/output to 0 (MATn.m pin is LOW if pinned out).
                    CLEAR_THE_CORRESPOND = 0x1,
                    ///  Set the corresponding External Match bit/output to 1 (MATn.m pin is HIGH if pinned out).
                    SET_THE_CORRESPONDIN = 0x2,
                    ///  Toggle the corresponding External Match bit/output.
                    TOGGLE_THE_CORRESPON = 0x3,
                },
            },
            ///  External Match Control 2. Determines the functionality of External Match 2.
            EMC2: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Do Nothing.
                    DO_NOTHING_ = 0x0,
                    ///  Clear the corresponding External Match bit/output to 0 (MATn.m pin is LOW if pinned out).
                    CLEAR_THE_CORRESPOND = 0x1,
                    ///  Set the corresponding External Match bit/output to 1 (MATn.m pin is HIGH if pinned out).
                    SET_THE_CORRESPONDIN = 0x2,
                    ///  Toggle the corresponding External Match bit/output.
                    TOGGLE_THE_CORRESPON = 0x3,
                },
            },
            ///  External Match Control 3. Determines the functionality of External Match 3.
            EMC3: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Do Nothing.
                    DO_NOTHING_ = 0x0,
                    ///  Clear the corresponding External Match bit/output to 0 (MATn.m pin is LOW if pinned out).
                    CLEAR_THE_CORRESPOND = 0x1,
                    ///  Set the corresponding External Match bit/output to 1 (MATn.m pin is HIGH if pinned out).
                    SET_THE_CORRESPONDIN = 0x2,
                    ///  Toggle the corresponding External Match bit/output.
                    TOGGLE_THE_CORRESPON = 0x3,
                },
            },
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u20,
        }),
        reserved112: [48]u8,
        ///  Count Control Register. The CTCR selects between Timer and Counter mode, and in Counter mode selects the signal and edge(s) for counting.
        CTCR: mmio.Mmio(packed struct(u32) {
            ///  Counter/Timer Mode This field selects which rising PCLK edges can increment Timer's Prescale Counter (PC), or clear PC and increment Timer Counter (TC). Timer Mode: the TC is incremented when the Prescale Counter matches the Prescale Register.
            CTMODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Timer Mode: every rising PCLK edge
                    TIMER_MODE_EVERY_RI = 0x0,
                    ///  Counter Mode: TC is incremented on rising edges on the CAP input selected by bits 3:2.
                    RISING = 0x1,
                    ///  Counter Mode: TC is incremented on falling edges on the CAP input selected by bits 3:2.
                    FALLING = 0x2,
                    ///  Counter Mode: TC is incremented on both edges on the CAP input selected by bits 3:2.
                    DUALEDGE = 0x3,
                },
            },
            ///  Count Input Select When bits 1:0 in this register are not 00, these bits select which CAP pin is sampled for clocking. Note: If Counter mode is selected for a particular CAPn input in the TnCTCR, the 3 bits for that input in the Capture Control Register (TnCCR) must be programmed as 000. However, capture and/or interrupt can be selected for the other 3 CAPn inputs in the same timer.
            CINSEL: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CAPn.0 for TIMERn
                    CAPN_0_FOR_TIMERN = 0x0,
                    ///  CAPn.1 for TIMERn
                    CAPN_1_FOR_TIMERN = 0x1,
                    _,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u28,
        }),
    };

    ///  General Purpose I/O
    pub const GPIO = struct {};

    ///  UART0/2/3
    pub const UART0 = extern struct {
        ///  Receiver Buffer Register. Contains the next received character to be read (DLAB =0).
        RBR: mmio.Mmio(packed struct(u32) {
            ///  The UARTn Receiver Buffer Register contains the oldest received byte in the UARTn Rx FIFO.
            RBR: u8,
            ///  Reserved, the value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        ///  Divisor Latch MSB. Most significant byte of the baud rate divisor value. The full divisor is used to generate a baud rate from the fractional rate divider (DLAB =1).
        DLM: mmio.Mmio(packed struct(u32) {
            ///  The UARTn Divisor Latch MSB Register, along with the U0DLL register, determines the baud rate of the UARTn.
            DLMSB: u8,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        ///  Interrupt ID Register. Identifies which interrupt(s) are pending.
        IIR: mmio.Mmio(packed struct(u32) {
            ///  Interrupt status. Note that UnIIR[0] is active low. The pending interrupt can be determined by evaluating UnIIR[3:1].
            INTSTATUS: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  At least one interrupt is pending.
                    AT_LEAST_ONE_INTERRU = 0x0,
                    ///  No interrupt is pending.
                    NO_INTERRUPT_IS_PEND = 0x1,
                },
            },
            ///  Interrupt identification. UnIER[3:1] identifies an interrupt corresponding to the UARTn Rx or TX FIFO. All other combinations of UnIER[3:1] not listed below are reserved (000,100,101,111).
            INTID: packed union {
                raw: u3,
                value: enum(u3) {
                    ///  1 - Receive Line Status (RLS).
                    @"1_RECEIVE_LINE_S" = 0x3,
                    ///  2a - Receive Data Available (RDA).
                    @"2A__RECEIVE_DATA_AV" = 0x2,
                    ///  2b - Character Time-out Indicator (CTI).
                    @"2B__CHARACTER_TIME_" = 0x6,
                    ///  3 - THRE Interrupt
                    @"3_THRE_INTERRUPT" = 0x1,
                    _,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u2,
            ///  Copies of UnFCR[0].
            FIFOENABLE: u2,
            ///  End of auto-baud interrupt. True if auto-baud has finished successfully and interrupt is enabled.
            ABEOINT: u1,
            ///  Auto-baud time-out interrupt. True if auto-baud has timed out and interrupt is enabled.
            ABTOINT: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u22,
        }),
        ///  Line Control Register. Contains controls for frame formatting and break generation.
        LCR: mmio.Mmio(packed struct(u32) {
            ///  Word Length Select.
            WLS: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  5-bit character length
                    @"5_BIT_CHARACTER_LENG" = 0x0,
                    ///  6-bit character length
                    @"6_BIT_CHARACTER_LENG" = 0x1,
                    ///  7-bit character length
                    @"7_BIT_CHARACTER_LENG" = 0x2,
                    ///  8-bit character length
                    @"8_BIT_CHARACTER_LENG" = 0x3,
                },
            },
            ///  Stop Bit Select
            SBS: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  1 stop bit.
                    @"1_STOP_BIT_" = 0x0,
                    ///  2 stop bits (1.5 if UnLCR[1:0]=00).
                    @"2_STOP_BITS_1_5_IF_" = 0x1,
                },
            },
            ///  Parity Enable.
            PE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable parity generation and checking.
                    DISABLE_PARITY_GENER = 0x0,
                    ///  Enable parity generation and checking.
                    ENABLE_PARITY_GENERA = 0x1,
                },
            },
            ///  Parity Select
            PS: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Odd parity. Number of 1s in the transmitted character and the attached parity bit will be odd.
                    ODD_PARITY_NUMBER_O = 0x0,
                    ///  Even Parity. Number of 1s in the transmitted character and the attached parity bit will be even.
                    EVEN_PARITY_NUMBER_ = 0x1,
                    ///  Forced 1 stick parity.
                    FORCED_1_STICK_PARIT = 0x2,
                    ///  Forced 0 stick parity.
                    FORCED_0_STICK_PARIT = 0x3,
                },
            },
            ///  Break Control
            BC: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable break transmission.
                    DISABLE_BREAK_TRANSM = 0x0,
                    ///  Enable break transmission. Output pin UARTn TXD is forced to logic 0 when UnLCR[6] is active high.
                    ENABLE_BREAK_TRANSMI = 0x1,
                },
            },
            ///  Divisor Latch Access Bit
            DLAB: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable access to Divisor Latches.
                    DISABLE_ACCESS_TO_DI = 0x0,
                    ///  Enable access to Divisor Latches.
                    ENABLE_ACCESS_TO_DIV = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        reserved20: [4]u8,
        ///  Line Status Register. Contains flags for transmit and receive status, including line errors.
        LSR: mmio.Mmio(packed struct(u32) {
            ///  Receiver Data Ready. UnLSR[0] is set when the UnRBR holds an unread character and is cleared when the UARTn RBR FIFO is empty.
            RDR: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The UARTn receiver FIFO is empty.
                    EMPTY = 0x0,
                    ///  The UARTn receiver FIFO is not empty.
                    NOTEMPTY = 0x1,
                },
            },
            ///  Overrun Error. The overrun error condition is set as soon as it occurs. An UnLSR read clears UnLSR[1]. UnLSR[1] is set when UARTn RSR has a new character assembled and the UARTn RBR FIFO is full. In this case, the UARTn RBR FIFO will not be overwritten and the character in the UARTn RSR will be lost.
            OE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Overrun error status is inactive.
                    INACTIVE = 0x0,
                    ///  Overrun error status is active.
                    ACTIVE = 0x1,
                },
            },
            ///  Parity Error. When the parity bit of a received character is in the wrong state, a parity error occurs. An UnLSR read clears UnLSR[2]. Time of parity error detection is dependent on UnFCR[0]. Note: A parity error is associated with the character at the top of the UARTn RBR FIFO.
            PE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Parity error status is inactive.
                    INACTIVE = 0x0,
                    ///  Parity error status is active.
                    ACTIVE = 0x1,
                },
            },
            ///  Framing Error. When the stop bit of a received character is a logic 0, a framing error occurs. An UnLSR read clears UnLSR[3]. The time of the framing error detection is dependent on UnFCR[0]. Upon detection of a framing error, the Rx will attempt to resynchronize to the data and assume that the bad stop bit is actually an early start bit. However, it cannot be assumed that the next received byte will be correct even if there is no Framing Error. Note: A framing error is associated with the character at the top of the UARTn RBR FIFO.
            FE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Framing error status is inactive.
                    INACTIVE = 0x0,
                    ///  Framing error status is active.
                    ACTIVE = 0x1,
                },
            },
            ///  Break Interrupt. When RXDn is held in the spacing state (all zeroes) for one full character transmission (start, data, parity, stop), a break interrupt occurs. Once the break condition has been detected, the receiver goes idle until RXDn goes to marking state (all ones). An UnLSR read clears this status bit. The time of break detection is dependent on UnFCR[0]. Note: The break interrupt is associated with the character at the top of the UARTn RBR FIFO.
            BI: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Break interrupt status is inactive.
                    INACTIVE = 0x0,
                    ///  Break interrupt status is active.
                    ACTIVE = 0x1,
                },
            },
            ///  Transmitter Holding Register Empty. THRE is set immediately upon detection of an empty UARTn THR and is cleared on a UnTHR write.
            THRE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  UnTHR contains valid data.
                    VALIDDATA = 0x0,
                    ///  UnTHR is empty.
                    EMPTY = 0x1,
                },
            },
            ///  Transmitter Empty. TEMT is set when both UnTHR and UnTSR are empty; TEMT is cleared when either the UnTSR or the UnTHR contain valid data.
            TEMT: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  UnTHR and/or the UnTSR contains valid data.
                    VALIDDATA = 0x0,
                    ///  UnTHR and the UnTSR are empty.
                    EMPTY = 0x1,
                },
            },
            ///  Error in RX FIFO . UnLSR[7] is set when a character with a Rx error such as framing error, parity error or break interrupt, is loaded into the UnRBR. This bit is cleared when the UnLSR register is read and there are no subsequent errors in the UARTn FIFO.
            RXFE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  UnRBR contains no UARTn RX errors or UnFCR[0]=0.
                    NOERROR = 0x0,
                    ///  UARTn RBR contains at least one UARTn RX error.
                    ERRORS = 0x1,
                },
            },
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        reserved28: [4]u8,
        ///  Scratch Pad Register. 8-bit temporary storage for software.
        SCR: mmio.Mmio(packed struct(u32) {
            ///  A readable, writable byte.
            PAD: u8,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        ///  Auto-baud Control Register. Contains controls for the auto-baud feature.
        ACR: mmio.Mmio(packed struct(u32) {
            ///  Start bit. This bit is automatically cleared after auto-baud completion.
            START: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Auto-baud stop (auto-baud is not running).
                    AUTO_BAUD_STOP_AUTO = 0x0,
                    ///  Auto-baud start (auto-baud is running). Auto-baud run bit. This bit is automatically cleared after auto-baud completion.
                    AUTO_BAUD_START_AUT = 0x1,
                },
            },
            ///  Auto-baud mode select bit.
            MODE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Mode 0.
                    MODE_0_ = 0x0,
                    ///  Mode 1.
                    MODE_1_ = 0x1,
                },
            },
            ///  Restart bit.
            AUTORESTART: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  No restart.
                    NO_RESTART_ = 0x0,
                    ///  Restart in case of time-out (counter restarts at next UARTn Rx falling edge)
                    RESTART_IN_CASE_OF_T = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u5,
            ///  End of auto-baud interrupt clear bit (write-only accessible). Writing a 1 will clear the corresponding interrupt in the UnIIR. Writing a 0 has no impact.
            ABEOINTCLR: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  No impact.
                    NO_IMPACT_ = 0x0,
                    ///  Clear the corresponding interrupt in the IIR.
                    CLEAR_THE_CORRESPOND = 0x1,
                },
            },
            ///  Auto-baud time-out interrupt clear bit (write-only accessible). Writing a 1 will clear the corresponding interrupt in the UnIIR. Writing a 0 has no impact.
            ABTOINTCLR: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  No impact.
                    NO_IMPACT_ = 0x0,
                    ///  Clear the corresponding interrupt in the IIR.
                    CLEAR_THE_CORRESPOND = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u22,
        }),
        reserved40: [4]u8,
        ///  Fractional Divider Register. Generates a clock input for the baud rate divider.
        FDR: mmio.Mmio(packed struct(u32) {
            ///  Baud-rate generation pre-scaler divisor value. If this field is 0, fractional baud-rate generator will not impact the UARTn baudrate.
            DIVADDVAL: u4,
            ///  Baud-rate pre-scaler multiplier value. This field must be greater or equal 1 for UARTn to operate properly, regardless of whether the fractional baud-rate generator is used or not.
            MULVAL: u4,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        reserved48: [4]u8,
        ///  Transmit Enable Register. Turns off UART transmitter for use with software flow control.
        TER: mmio.Mmio(packed struct(u32) {
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u7,
            ///  When this bit is 1, as it is after a Reset, data written to the THR is output on the TXD pin as soon as any preceding data has been sent. If this bit is cleared to 0 while a character is being sent, the transmission of that character is completed, but no further characters are sent until this bit is set again. In other words, a 0 in this bit blocks the transfer of characters from the THR or TX FIFO into the transmit shift register. Software implementing software-handshaking can clear this bit when it receives an XOFF character (DC3). Software can set this bit again when it receives an XON (DC1) character.
            TXEN: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        reserved76: [24]u8,
        ///  RS-485/EIA-485 Control. Contains controls to configure various aspects of RS-485/EIA-485 modes.
        RS485CTRL: mmio.Mmio(packed struct(u32) {
            ///  NMM enable.
            NMMEN: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  RS-485/EIA-485 Normal Multidrop Mode (NMM) is disabled.
                    DISABLED = 0x0,
                    ///  RS-485/EIA-485 Normal Multidrop Mode (NMM) is enabled. In this mode, an address is detected when a received byte has the parity bit = 1, generating a received data interrupt. See Section 18.6.16 RS-485/EIA-485 modes of operation.
                    ENABLED = 0x1,
                },
            },
            ///  Receiver enable.
            RXDIS: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The receiver is enabled.
                    ENABLED = 0x0,
                    ///  The receiver is disabled.
                    DISABLED = 0x1,
                },
            },
            ///  AAD enable.
            AADEN: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Auto Address Detect (AAD) is disabled.
                    DISABLED = 0x0,
                    ///  Auto Address Detect (AAD) is enabled.
                    ENABLED = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u1,
            ///  Direction control enable.
            DCTRL: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable Auto Direction Control.
                    DISABLE_AUTO_DIRECTI = 0x0,
                    ///  Enable Auto Direction Control.
                    ENABLE_AUTO_DIRECTIO = 0x1,
                },
            },
            ///  Direction control pin polarity. This bit reverses the polarity of the direction control signal on the Un_OE pin.
            OINV: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The direction control pin will be driven to logic 0 when the transmitter has data to be sent. It will be driven to logic 1 after the last bit of data has been transmitted.
                    DIRLOW = 0x0,
                    ///  The direction control pin will be driven to logic 1 when the transmitter has data to be sent. It will be driven to logic 0 after the last bit of data has been transmitted.
                    DIRHIGH = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u26,
        }),
        ///  RS-485/EIA-485 address match. Contains the address match value for RS-485/EIA-485 mode.
        RS485ADRMATCH: mmio.Mmio(packed struct(u32) {
            ///  Contains the address match value.
            ADRMATCH: u8,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        ///  RS-485/EIA-485 direction control delay.
        RS485DLY: mmio.Mmio(packed struct(u32) {
            ///  Contains the direction control (UnOE) delay value. This register works in conjunction with an 8-bit counter.
            DLY: u8,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
    };

    ///  UART1
    pub const UART1 = extern struct {
        ///  DLAB =0 Receiver Buffer Register. Contains the next received character to be read.
        RBR: mmio.Mmio(packed struct(u32) {
            ///  The UART1 Receiver Buffer Register contains the oldest received byte in the UART1 RX FIFO.
            RBR: u8,
            ///  Reserved, the value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        ///  DLAB =1. Divisor Latch MSB. Most significant byte of the baud rate divisor value. The full divisor is used to generate a baud rate from the fractional rate divider.
        DLM: mmio.Mmio(packed struct(u32) {
            ///  The UART1 Divisor Latch MSB Register, along with the U1DLL register, determines the baud rate of the UART1.
            DLMSB: u8,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        ///  Interrupt ID Register. Identifies which interrupt(s) are pending.
        IIR: mmio.Mmio(packed struct(u32) {
            ///  Interrupt status. Note that IIR[0] is active low. The pending interrupt can be determined by evaluating IIR[3:1].
            INTSTATUS: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  At least one interrupt is pending.
                    AT_LEAST_ONE_INTERRU = 0x0,
                    ///  No interrupt is pending.
                    NO_INTERRUPT_IS_PEND = 0x1,
                },
            },
            ///  Interrupt identification. IER[3:1] identifies an interrupt corresponding to the UART1 Rx or TX FIFO. All other combinations of IER[3:1] not listed below are reserved (100,101,111).
            INTID: packed union {
                raw: u3,
                value: enum(u3) {
                    ///  1 - Receive Line Status (RLS).
                    RLS = 0x3,
                    ///  2a - Receive Data Available (RDA).
                    RDA = 0x2,
                    ///  2b - Character Time-out Indicator (CTI).
                    CTI = 0x6,
                    ///  3 - THRE Interrupt.
                    THRE = 0x1,
                    ///  4 - Modem Interrupt.
                    MODEM = 0x0,
                    _,
                },
            },
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u2,
            ///  Copies of FCR[0].
            FIFOENABLE: u2,
            ///  End of auto-baud interrupt. True if auto-baud has finished successfully and interrupt is enabled.
            ABEOINT: u1,
            ///  Auto-baud time-out interrupt. True if auto-baud has timed out and interrupt is enabled.
            ABTOINT: u1,
            ///  Reserved, the value read from a reserved bit is not defined.
            RESERVED: u22,
        }),
        ///  Line Control Register. Contains controls for frame formatting and break generation.
        LCR: mmio.Mmio(packed struct(u32) {
            ///  Word Length Select.
            WLS: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  5-bit character length.
                    @"5_BIT_CHARACTER_LENG" = 0x0,
                    ///  6-bit character length.
                    @"6_BIT_CHARACTER_LENG" = 0x1,
                    ///  7-bit character length.
                    @"7_BIT_CHARACTER_LENG" = 0x2,
                    ///  8-bit character length.
                    @"8_BIT_CHARACTER_LENG" = 0x3,
                },
            },
            ///  Stop Bit Select.
            SBS: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  1 stop bit.
                    @"1_STOP_BIT_" = 0x0,
                    ///  2 stop bits (1.5 if LCR[1:0]=00).
                    @"2_STOP_BITS_1_5_IF_" = 0x1,
                },
            },
            ///  Parity Enable.
            PE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable parity generation and checking.
                    DISABLE_PARITY_GENER = 0x0,
                    ///  Enable parity generation and checking.
                    ENABLE_PARITY_GENERA = 0x1,
                },
            },
            ///  Parity Select.
            PS: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Odd parity. Number of 1s in the transmitted character and the attached parity bit will be odd.
                    ODD_PARITY_NUMBER_O = 0x0,
                    ///  Even Parity. Number of 1s in the transmitted character and the attached parity bit will be even.
                    EVEN_PARITY_NUMBER_ = 0x1,
                    ///  Forced 1 stick parity.
                    FORCED1STICK_PAR = 0x2,
                    ///  Forced 0 stick parity.
                    FORCED0STICK_PAR = 0x3,
                },
            },
            ///  Break Control.
            BC: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable break transmission.
                    DISABLE_BREAK_TRANSM = 0x0,
                    ///  Enable break transmission. Output pin UART1 TXD is forced to logic 0 when LCR[6] is active high.
                    ENABLE_BREAK_TRANSMI = 0x1,
                },
            },
            ///  Divisor Latch Access Bit (DLAB)
            DLAB: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable access to Divisor Latches.
                    DISABLE_ACCESS_TO_DI = 0x0,
                    ///  Enable access to Divisor Latches.
                    ENABLE_ACCESS_TO_DIV = 0x1,
                },
            },
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        ///  Modem Control Register. Contains controls for flow control handshaking and loopback mode.
        MCR: mmio.Mmio(packed struct(u32) {
            ///  DTR Control. Source for modem output pin, DTR. This bit reads as 0 when modem loopback mode is active.
            DTRCTRL: u1,
            ///  RTS Control. Source for modem output pin RTS. This bit reads as 0 when modem loopback mode is active.
            RTSCTRL: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u2,
            ///  Loopback Mode Select. The modem loopback mode provides a mechanism to perform diagnostic loopback testing. Serial data from the transmitter is connected internally to serial input of the receiver. Input pin, RXD1, has no effect on loopback and output pin, TXD1 is held in marking state. The 4 modem inputs (CTS, DSR, RI and DCD) are disconnected externally. Externally, the modem outputs (RTS, DTR) are set inactive. Internally, the 4 modem outputs are connected to the 4 modem inputs. As a result of these connections, the upper 4 bits of the MSR will be driven by the lower 4 bits of the MCR rather than the 4 modem inputs in normal mode. This permits modem status interrupts to be generated in loopback mode by writing the lower 4 bits of MCR.
            LMS: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable modem loopback mode.
                    DISABLE_MODEM_LOOPBA = 0x0,
                    ///  Enable modem loopback mode.
                    ENABLE_MODEM_LOOPBAC = 0x1,
                },
            },
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u1,
            ///  RTS enable.
            RTSEN: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable auto-rts flow control.
                    DISABLE_AUTO_RTS_FLO = 0x0,
                    ///  Enable auto-rts flow control.
                    ENABLE_AUTO_RTS_FLOW = 0x1,
                },
            },
            ///  CTS enable.
            CTSEN: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable auto-cts flow control.
                    DISABLE_AUTO_CTS_FLO = 0x0,
                    ///  Enable auto-cts flow control.
                    ENABLE_AUTO_CTS_FLOW = 0x1,
                },
            },
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        ///  Line Status Register. Contains flags for transmit and receive status, including line errors.
        LSR: mmio.Mmio(packed struct(u32) {
            ///  Receiver Data Ready. LSR[0] is set when the RBR holds an unread character and is cleared when the UART1 RBR FIFO is empty.
            RDR: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The UART1 receiver FIFO is empty.
                    EMPTY = 0x0,
                    ///  The UART1 receiver FIFO is not empty.
                    NOTEMPTY = 0x1,
                },
            },
            ///  Overrun Error. The overrun error condition is set as soon as it occurs. An LSR read clears LSR[1]. LSR[1] is set when UART1 RSR has a new character assembled and the UART1 RBR FIFO is full. In this case, the UART1 RBR FIFO will not be overwritten and the character in the UART1 RSR will be lost.
            OE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Overrun error status is inactive.
                    INACTIVE = 0x0,
                    ///  Overrun error status is active.
                    ACTIVE = 0x1,
                },
            },
            ///  Parity Error. When the parity bit of a received character is in the wrong state, a parity error occurs. An LSR read clears LSR[2]. Time of parity error detection is dependent on FCR[0]. Note: A parity error is associated with the character at the top of the UART1 RBR FIFO.
            PE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Parity error status is inactive.
                    INACTIVE = 0x0,
                    ///  Parity error status is active.
                    ACTIVE = 0x1,
                },
            },
            ///  Framing Error. When the stop bit of a received character is a logic 0, a framing error occurs. An LSR read clears LSR[3]. The time of the framing error detection is dependent on FCR0. Upon detection of a framing error, the RX will attempt to resynchronize to the data and assume that the bad stop bit is actually an early start bit. However, it cannot be assumed that the next received byte will be correct even if there is no Framing Error. Note: A framing error is associated with the character at the top of the UART1 RBR FIFO.
            FE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Framing error status is inactive.
                    INACTIVE = 0x0,
                    ///  Framing error status is active.
                    ACTIVE = 0x1,
                },
            },
            ///  Break Interrupt. When RXD1 is held in the spacing state (all zeroes) for one full character transmission (start, data, parity, stop), a break interrupt occurs. Once the break condition has been detected, the receiver goes idle until RXD1 goes to marking state (all ones). An LSR read clears this status bit. The time of break detection is dependent on FCR[0]. Note: The break interrupt is associated with the character at the top of the UART1 RBR FIFO.
            BI: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Break interrupt status is inactive.
                    INACTIVE = 0x0,
                    ///  Break interrupt status is active.
                    ACTIVE = 0x1,
                },
            },
            ///  Transmitter Holding Register Empty. THRE is set immediately upon detection of an empty UART1 THR and is cleared on a THR write.
            THRE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  THR contains valid data.
                    VALID = 0x0,
                    ///  THR is empty.
                    THR_IS_EMPTY_ = 0x1,
                },
            },
            ///  Transmitter Empty. TEMT is set when both THR and TSR are empty; TEMT is cleared when either the TSR or the THR contain valid data.
            TEMT: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  THR and/or the TSR contains valid data.
                    VALID = 0x0,
                    ///  THR and the TSR are empty.
                    EMPTY = 0x1,
                },
            },
            ///  Error in RX FIFO. LSR[7] is set when a character with a RX error such as framing error, parity error or break interrupt, is loaded into the RBR. This bit is cleared when the LSR register is read and there are no subsequent errors in the UART1 FIFO.
            RXFE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  RBR contains no UART1 RX errors or FCR[0]=0.
                    NOERROR = 0x0,
                    ///  UART1 RBR contains at least one UART1 RX error.
                    ERRORS = 0x1,
                },
            },
            ///  Reserved, the value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        ///  Modem Status Register. Contains handshake signal status flags.
        MSR: mmio.Mmio(packed struct(u32) {
            ///  Delta CTS. Set upon state change of input CTS. Cleared on an MSR read.
            DCTS: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  No change detected on modem input, CTS.
                    NO_CHANGE_DETECTED_O = 0x0,
                    ///  State change detected on modem input, CTS.
                    STATE_CHANGE_DETECTE = 0x1,
                },
            },
            ///  Delta DSR. Set upon state change of input DSR. Cleared on an MSR read.
            DDSR: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  No change detected on modem input, DSR.
                    NO_CHANGE_DETECTED_O = 0x0,
                    ///  State change detected on modem input, DSR.
                    STATE_CHANGE_DETECTE = 0x1,
                },
            },
            ///  Trailing Edge RI. Set upon low to high transition of input RI. Cleared on an MSR read.
            TERI: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  No change detected on modem input, RI.
                    NO_CHANGE_DETECTED_O = 0x0,
                    ///  Low-to-high transition detected on RI.
                    LOW_TO_HIGH_TRANSITI = 0x1,
                },
            },
            ///  Delta DCD. Set upon state change of input DCD. Cleared on an MSR read.
            DDCD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  No change detected on modem input, DCD.
                    NO_CHANGE_DETECTED_O = 0x0,
                    ///  State change detected on modem input, DCD.
                    STATE_CHANGE_DETECTE = 0x1,
                },
            },
            ///  Clear To Send State. Complement of input signal CTS. This bit is connected to MCR[1] in modem loopback mode.
            CTS: u1,
            ///  Data Set Ready State. Complement of input signal DSR. This bit is connected to MCR[0] in modem loopback mode.
            DSR: u1,
            ///  Ring Indicator State. Complement of input RI. This bit is connected to MCR[2] in modem loopback mode.
            RI: u1,
            ///  Data Carrier Detect State. Complement of input DCD. This bit is connected to MCR[3] in modem loopback mode.
            DCD: u1,
            ///  Reserved, the value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        ///  Scratch Pad Register. 8-bit temporary storage for software.
        SCR: mmio.Mmio(packed struct(u32) {
            ///  A readable, writable byte.
            Pad: u8,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        ///  Auto-baud Control Register. Contains controls for the auto-baud feature.
        ACR: mmio.Mmio(packed struct(u32) {
            ///  Auto-baud start bit. This bit is automatically cleared after auto-baud completion.
            START: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Auto-baud stop (auto-baud is not running).
                    STOP = 0x0,
                    ///  Auto-baud start (auto-baud is running). Auto-baud run bit. This bit is automatically cleared after auto-baud completion.
                    START = 0x1,
                },
            },
            ///  Auto-baud mode select bit.
            MODE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Mode 0.
                    MODE_0_ = 0x0,
                    ///  Mode 1.
                    MODE_1_ = 0x1,
                },
            },
            ///  Auto-baud restart bit.
            AUTORESTART: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  No restart
                    NO_RESTART = 0x0,
                    ///  Restart in case of time-out (counter restarts at next UART1 Rx falling edge)
                    RESTART_IN_CASE_OF_T = 0x1,
                },
            },
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u5,
            ///  End of auto-baud interrupt clear bit (write-only).
            ABEOINTCLR: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Writing a 0 has no impact.
                    WRITING_A_0_HAS_NO_I = 0x0,
                    ///  Writing a 1 will clear the corresponding interrupt in the IIR.
                    WRITING_A_1_WILL_CLE = 0x1,
                },
            },
            ///  Auto-baud time-out interrupt clear bit (write-only).
            ABTOINTCLR: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Writing a 0 has no impact.
                    WRITING_A_0_HAS_NO_I = 0x0,
                    ///  Writing a 1 will clear the corresponding interrupt in the IIR.
                    WRITING_A_1_WILL_CLE = 0x1,
                },
            },
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u22,
        }),
        reserved40: [4]u8,
        ///  Fractional Divider Register. Generates a clock input for the baud rate divider.
        FDR: mmio.Mmio(packed struct(u32) {
            ///  Baud rate generation pre-scaler divisor value. If this field is 0, fractional baud rate generator will not impact the UART1 baud rate.
            DIVADDVAL: u4,
            ///  Baud rate pre-scaler multiplier value. This field must be greater or equal 1 for UART1 to operate properly, regardless of whether the fractional baud rate generator is used or not.
            MULVAL: u4,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        reserved48: [4]u8,
        ///  Transmit Enable Register. Turns off UART transmitter for use with software flow control.
        TER: mmio.Mmio(packed struct(u32) {
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u7,
            ///  When this bit is 1, as it is after a Reset, data written to the THR is output on the TXD pin as soon as any preceding data has been sent. If this bit cleared to 0 while a character is being sent, the transmission of that character is completed, but no further characters are sent until this bit is set again. In other words, a 0 in this bit blocks the transfer of characters from the THR or TX FIFO into the transmit shift register. Software can clear this bit when it detects that the a hardware-handshaking TX-permit signal (CTS) has gone false, or with software handshaking, when it receives an XOFF character (DC3). Software can set this bit again when it detects that the TX-permit signal has gone true, or when it receives an XON (DC1) character.
            TXEN: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        reserved76: [24]u8,
        ///  RS-485/EIA-485 Control. Contains controls to configure various aspects of RS-485/EIA-485 modes.
        RS485CTRL: mmio.Mmio(packed struct(u32) {
            ///  RS-485/EIA-485 Normal Multidrop Mode (NMM) mode select.
            NMMEN: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Enabled. In this mode, an address is detected when a received byte causes the UART to set the parity error and generate an interrupt.
                    ENABLED_IN_THIS_MOD = 0x1,
                },
            },
            ///  Receive enable.
            RXDIS: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Enabled.
                    ENABLED_ = 0x0,
                    ///  Disabled.
                    DISABLED_ = 0x1,
                },
            },
            ///  Auto Address Detect (AAD) enable.
            AADEN: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Enabled.
                    ENABLED_ = 0x1,
                },
            },
            ///  Direction control.
            SEL: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  RTS. If direction control is enabled (bit DCTRL = 1), pin RTS is used for direction control.
                    RTS_IF_DIRECTION_CO = 0x0,
                    ///  DTR. If direction control is enabled (bit DCTRL = 1), pin DTR is used for direction control.
                    DTR_IF_DIRECTION_CO = 0x1,
                },
            },
            ///  Direction control enable.
            DCTRL: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable Auto Direction Control.
                    DISABLE_AUTO_DIRECTI = 0x0,
                    ///  Enable Auto Direction Control.
                    ENABLE_AUTO_DIRECTIO = 0x1,
                },
            },
            ///  Polarity. This bit reverses the polarity of the direction control signal on the RTS (or DTR) pin.
            OINV: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  LOW. The direction control pin will be driven to logic 0 when the transmitter has data to be sent. It will be driven to logic 1 after the last bit of data has been transmitted.
                    LOW_THE_DIRECTION_C = 0x0,
                    ///  HIGH. The direction control pin will be driven to logic 1 when the transmitter has data to be sent. It will be driven to logic 0 after the last bit of data has been transmitted.
                    HIGH_THE_DIRECTION_ = 0x1,
                },
            },
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u26,
        }),
        ///  RS-485/EIA-485 address match. Contains the address match value for RS-485/EIA-485 mode.
        RS485ADRMATCH: mmio.Mmio(packed struct(u32) {
            ///  Contains the address match value.
            ADRMATCH: u8,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        ///  RS-485/EIA-485 direction control delay.
        RS485DLY: mmio.Mmio(packed struct(u32) {
            ///  Contains the direction control (RTS or DTR) delay value. This register works in conjunction with an 8-bit counter.
            DLY: u8,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
    };

    ///  Pulse Width Modulators (PWM1)
    pub const PWM1 = extern struct {
        ///  Interrupt Register. The IR can be written to clear interrupts, or read to identify which PWM interrupt sources are pending.
        IR: mmio.Mmio(packed struct(u32) {
            ///  Interrupt flag for PWM match channel 0.
            PWMMR0INT: u1,
            ///  Interrupt flag for PWM match channel 1.
            PWMMR1INT: u1,
            ///  Interrupt flag for PWM match channel 2.
            PWMMR2INT: u1,
            ///  Interrupt flag for PWM match channel 3.
            PWMMR3INT: u1,
            ///  Interrupt flag for capture input 0
            PWMCAP0INT: u1,
            ///  Interrupt flag for capture input 1 (available in PWM1IR only; this bit is reserved in PWM0IR).
            PWMCAP1INT: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u2,
            ///  Interrupt flag for PWM match channel 4.
            PWMMR4INT: u1,
            ///  Interrupt flag for PWM match channel 5.
            PWMMR5INT: u1,
            ///  Interrupt flag for PWM match channel 6.
            PWMMR6INT: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u21,
        }),
        ///  Timer Control Register. The TCR is used to control the Timer Counter functions.
        TCR: mmio.Mmio(packed struct(u32) {
            ///  Counter Enable
            CE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The PWM Timer Counter and PWM Prescale Counter are enabled for counting.
                    THE_PWM_TIMER_COUNTE = 0x1,
                    ///  The counters are disabled.
                    THE_COUNTERS_ARE_DIS = 0x0,
                },
            },
            ///  Counter Reset
            CR: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The PWM Timer Counter and the PWM Prescale Counter are synchronously reset on the next positive edge of PCLK. The counters remain reset until this bit is returned to zero.
                    THE_PWM_TIMER_COUNTE = 0x1,
                    ///  Clear reset.
                    CLEAR_RESET_ = 0x0,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u1,
            ///  PWM Enable
            PWMEN: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  PWM mode is enabled (counter resets to 1). PWM mode causes the shadow registers to operate in connection with the Match registers. A program write to a Match register will not have an effect on the Match result until the corresponding bit in PWMLER has been set, followed by the occurrence of a PWM Match 0 event. Note that the PWM Match register that determines the PWM rate (PWM Match Register 0 - MR0) must be set up prior to the PWM being enabled. Otherwise a Match event will not occur to cause shadow register contents to become effective.
                    PWM_MODE_IS_ENABLED_ = 0x1,
                    ///  Timer mode is enabled (counter resets to 0).
                    TIMER_MODE_IS_ENABLE = 0x0,
                },
            },
            ///  Master Disable (PWM0 only). The two PWMs may be synchronized using the Master Disable control bit. The Master disable bit of the Master PWM (PWM0 module) controls a secondary enable input to both PWMs, as shown in Figure 141. This bit has no function in the Slave PWM (PWM1).
            MDIS: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Master use. PWM0 is the master, and both PWMs are enabled for counting.
                    MASTER_USE_PWM0_IS_ = 0x1,
                    ///  Individual use. The PWMs are used independently, and the individual Counter Enable bits are used to control the PWMs.
                    INDIVIDUAL_USE_THE_ = 0x0,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u27,
        }),
        ///  Timer Counter. The 32 bit TC is incremented every PR+1 cycles of PCLK. The TC is controlled through the TCR.
        TC: mmio.Mmio(packed struct(u32) {
            ///  Timer counter value.
            TC: u32,
        }),
        ///  Prescale Register. Determines how often the PWM counter is incremented.
        PR: mmio.Mmio(packed struct(u32) {
            ///  Prescale counter maximum value.
            PM: u32,
        }),
        ///  Prescale Counter. Prescaler for the main PWM counter.
        PC: mmio.Mmio(packed struct(u32) {
            ///  Prescale counter value.
            PC: u32,
        }),
        ///  Match Control Register. The MCR is used to control whether an interrupt is generated and if the PWM counter is reset when a Match occurs.
        MCR: mmio.Mmio(packed struct(u32) {
            ///  Interrupt PWM0
            PWMMR0I: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Interrupt on PWMMR0: an interrupt is generated when PWMMR0 matches the value in the PWMTC.
                    INTERRUPT_ON_PWMMR0 = 0x1,
                },
            },
            ///  Reset PWM0
            PWMMR0R: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Reset on PWMMR0: the PWMTC will be reset if PWMMR0 matches it.
                    RESET_ON_PWMMR0_THE = 0x1,
                },
            },
            ///  Stop PWM0
            PWMMR0S: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled
                    DISABLED = 0x0,
                    ///  Stop on PWMMR0: the PWMTC and PWMPC will be stopped and PWMTCR bit 0 will be set to 0 if PWMMR0 matches the PWMTC.
                    STOP_ON_PWMMR0_THE_ = 0x1,
                },
            },
            ///  Interrupt PWM1
            PWMMR1I: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Interrupt on PWMMR1: an interrupt is generated when PWMMR1 matches the value in the PWMTC.
                    INTERRUPT_ON_PWMMR1 = 0x1,
                },
            },
            ///  Reset PWM1
            PWMMR1R: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Reset on PWMMR1: the PWMTC will be reset if PWMMR1 matches it.
                    RESET_ON_PWMMR1_THE = 0x1,
                },
            },
            ///  Stop PWM1
            PWMMR1S: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled
                    DISABLED = 0x0,
                    ///  Stop on PWMMR1: the PWMTC and PWMPC will be stopped and PWMTCR bit 0 will be set to 0 if PWMMR1 matches the PWMTC.
                    STOP_ON_PWMMR1_THE_ = 0x1,
                },
            },
            ///  Interrupt PWM0
            PWMMR2I: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Interrupt on PWMMR2: an interrupt is generated when PWMMR2 matches the value in the PWMTC.
                    INTERRUPT_ON_PWMMR2 = 0x1,
                },
            },
            ///  Reset PWM0
            PWMMR2R: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Reset on PWMMR2: the PWMTC will be reset if PWMMR2 matches it.
                    RESET_ON_PWMMR2_THE = 0x1,
                },
            },
            ///  Stop PWM0
            PWMMR2S: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled
                    DISABLED = 0x0,
                    ///  Stop on PWMMR2: the PWMTC and PWMPC will be stopped and PWMTCR bit 0 will be set to 0 if PWMMR0 matches the PWMTC.
                    STOP_ON_PWMMR2_THE_ = 0x1,
                },
            },
            ///  Interrupt PWM3
            PWMMR3I: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Interrupt on PWMMR3: an interrupt is generated when PWMMR3 matches the value in the PWMTC.
                    INTERRUPT_ON_PWMMR3 = 0x1,
                },
            },
            ///  Reset PWM3
            PWMMR3R: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Reset on PWMMR3: the PWMTC will be reset if PWMMR3 matches it.
                    RESET_ON_PWMMR3_THE = 0x1,
                },
            },
            ///  Stop PWM0
            PWMMR3S: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled
                    DISABLED = 0x0,
                    ///  Stop on PWMMR3: the PWMTC and PWMPC will be stopped and PWMTCR bit 0 will be set to 0 if PWMMR0 matches the PWMTC.
                    STOP_ON_PWMMR3_THE_ = 0x1,
                },
            },
            ///  Interrupt PWM4
            PWMMR4I: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Interrupt on PWMMR4: an interrupt is generated when PWMMR4 matches the value in the PWMTC.
                    INTERRUPT_ON_PWMMR4 = 0x1,
                },
            },
            ///  Reset PWM4
            PWMMR4R: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Reset on PWMMR4: the PWMTC will be reset if PWMMR4 matches it.
                    RESET_ON_PWMMR4_THE = 0x1,
                },
            },
            ///  Stop PWM4
            PWMMR4S: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled
                    DISABLED = 0x0,
                    ///  Stop on PWMMR4: the PWMTC and PWMPC will be stopped and PWMTCR bit 0 will be set to 0 if PWMMR4 matches the PWMTC.
                    STOP_ON_PWMMR4_THE_ = 0x1,
                },
            },
            ///  Interrupt PWM5
            PWMMR5I: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Interrupt on PWMMR5: an interrupt is generated when PWMMR5 matches the value in the PWMTC.
                    INTERRUPT_ON_PWMMR5 = 0x1,
                },
            },
            ///  Reset PWM5
            PWMMR5R: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Reset on PWMMR5: the PWMTC will be reset if PWMMR5 matches it.
                    RESET_ON_PWMMR5_THE = 0x1,
                },
            },
            ///  Stop PWM5
            PWMMR5S: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled
                    DISABLED = 0x0,
                    ///  Stop on PWMMR5: the PWMTC and PWMPC will be stopped and PWMTCR bit 0 will be set to 0 if PWMMR5 matches the PWMTC.
                    STOP_ON_PWMMR5_THE_ = 0x1,
                },
            },
            ///  Interrupt PWM6
            PWMMR6I: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Interrupt on PWMMR6: an interrupt is generated when PWMMR6 matches the value in the PWMTC.
                    INTERRUPT_ON_PWMMR6 = 0x1,
                },
            },
            ///  Reset PWM6
            PWMMR6R: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Reset on PWMMR6: the PWMTC will be reset if PWMMR6 matches it.
                    RESET_ON_PWMMR6_THE = 0x1,
                },
            },
            ///  Stop PWM6
            PWMMR6S: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled
                    DISABLED = 0x0,
                    ///  Stop on PWMMR6: the PWMTC and PWMPC will be stopped and PWMTCR bit 0 will be set to 0 if PWMMR6 matches the PWMTC.
                    STOP_ON_PWMMR6_THE_ = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u11,
        }),
        reserved40: [16]u8,
        ///  Capture Control Register. The CCR controls which edges of the capture inputs are used to load the Capture Registers and whether or not an interrupt is generated for a capture event.
        CCR: mmio.Mmio(packed struct(u32) {
            ///  Capture on PWMn_CAP0 rising edge
            CAP0_R: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled. This feature is disabled.
                    DISABLED_THIS_FEATU = 0x0,
                    ///  Rising edge. A synchronously sampled rising edge on PWMn_CAP0 will cause CR0 to be loaded with the contents of the TC.
                    RISING_EDGE_A_SYNCH = 0x1,
                },
            },
            ///  Capture on PWMn_CAP0 falling edge
            CAP0_F: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled. This feature is disabled.
                    DISABLED_THIS_FEATU = 0x0,
                    ///  Falling edge. A synchronously sampled falling edge on PWMn_CAP0 will cause CR0 to be loaded with the contents of TC.
                    FALLING_EDGE_A_SYNC = 0x1,
                },
            },
            ///  Interrupt on PWMn_CAP0 event
            CAP0_I: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled. This feature is disabled.
                    DISABLED_THIS_FEATU = 0x0,
                    ///  Interrupt. A CR0 load due to a PWMn_CAP0 event will generate an interrupt.
                    INTERRUPT_A_CR0_LOA = 0x1,
                },
            },
            ///  Capture on PWMn_CAP1 rising edge. Reserved for PWM0.
            CAP1_R: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled. This feature is disabled.
                    DISABLED_THIS_FEATU = 0x0,
                    ///  Rising edge. A synchronously sampled rising edge on PWMn_CAP1 will cause CR1 to be loaded with the contents of the TC.
                    RISING_EDGE_A_SYNCH = 0x1,
                },
            },
            ///  Capture on PWMn_CAP1 falling edge. Reserved for PWM0.
            CAP1_F: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled. This feature is disabled.
                    DISABLED_THIS_FEATU = 0x0,
                    ///  Falling edge. A synchronously sampled falling edge on PWMn_CAP1 will cause CR1 to be loaded with the contents of TC.
                    FALLING_EDGE_A_SYNC = 0x1,
                },
            },
            ///  Interrupt on PWMn_CAP1 event. Reserved for PWM0.
            CAP1_I: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled. This feature is disabled.
                    DISABLED_THIS_FEATU = 0x0,
                    ///  Interrupt. A CR1 load due to a PWMn_CAP1 event will generate an interrupt.
                    INTERRUPT_A_CR1_LOA = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u26,
        }),
        reserved76: [32]u8,
        ///  PWM Control Register. Enables PWM outputs and selects either single edge or double edge controlled PWM outputs.
        PCR: mmio.Mmio(packed struct(u32) {
            ///  Reserved.
            RESERVED: u2,
            ///  PWM[2] output single/double edge mode control.
            PWMSEL2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Single edge controlled mode is selected.
                    SINGLE_EDGE_CONTROLL = 0x0,
                    ///  Double edge controlled mode is selected.
                    DOUBLE_EDGE_CONTROLL = 0x1,
                },
            },
            ///  PWM[3] output edge control.
            PWMSEL3: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Single edge controlled mode is selected.
                    SINGLE_EDGE_CONTROLL = 0x0,
                    ///  Double edge controlled mode is selected.
                    DOUBLE_EDGE_CONTROLL = 0x1,
                },
            },
            ///  PWM[4] output edge control.
            PWMSEL4: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Single edge controlled mode is selected.
                    SINGLE_EDGE_CONTROLL = 0x0,
                    ///  Double edge controlled mode is selected.
                    DOUBLE_EDGE_CONTROLL = 0x1,
                },
            },
            ///  PWM[5] output edge control.
            PWMSEL5: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Single edge controlled mode is selected.
                    SINGLE_EDGE_CONTROLL = 0x0,
                    ///  Double edge controlled mode is selected.
                    DOUBLE_EDGE_CONTROLL = 0x1,
                },
            },
            ///  PWM[6] output edge control.
            PWMSEL6: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Single edge controlled mode is selected.
                    SINGLE_EDGE_CONTROLL = 0x0,
                    ///  Double edge controlled mode is selected.
                    DOUBLE_EDGE_CONTROLL = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u2,
            ///  PWM[1] output enable control.
            PWMENA1: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The PWM output is disabled.
                    THE_PWM_OUTPUT_IS_DI = 0x0,
                    ///  The PWM output is enabled.
                    THE_PWM_OUTPUT_IS_EN = 0x1,
                },
            },
            ///  PWM[2] output enable control.
            PWMENA2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The PWM output is disabled.
                    THE_PWM_OUTPUT_IS_DI = 0x0,
                    ///  The PWM output is enabled.
                    THE_PWM_OUTPUT_IS_EN = 0x1,
                },
            },
            ///  PWM[3] output enable control.
            PWMENA3: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The PWM output is disabled.
                    THE_PWM_OUTPUT_IS_DI = 0x0,
                    ///  The PWM output is enabled.
                    THE_PWM_OUTPUT_IS_EN = 0x1,
                },
            },
            ///  PWM[4] output enable control.
            PWMENA4: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The PWM output is disabled.
                    THE_PWM_OUTPUT_IS_DI = 0x0,
                    ///  The PWM output is enabled.
                    THE_PWM_OUTPUT_IS_EN = 0x1,
                },
            },
            ///  PWM[5] output enable control.
            PWMENA5: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The PWM output is disabled.
                    THE_PWM_OUTPUT_IS_DI = 0x0,
                    ///  The PWM output is enabled.
                    THE_PWM_OUTPUT_IS_EN = 0x1,
                },
            },
            ///  PWM[6] output enable control. See PWMENA1 for details.
            PWMENA6: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The PWM output is disabled.
                    THE_PWM_OUTPUT_IS_DI = 0x0,
                    ///  The PWM output is enabled.
                    THE_PWM_OUTPUT_IS_EN = 0x1,
                },
            },
            ///  Unused, always zero.
            RESERVED: u17,
        }),
        ///  Load Enable Register. Enables use of updated PWM match values.
        LER: mmio.Mmio(packed struct(u32) {
            ///  Enable PWM Match 0 Latch. PWM MR0 register update control. Writing a one to this bit allows the last value written to the PWM Match Register 0 to be become effective when the timer is next reset by a PWM Match event. See Section 27.6.7.
            MAT0LATCHEN: u1,
            ///  Enable PWM Match 1 Latch. PWM MR1 register update control. See bit 0 for details.
            MAT1LATCHEN: u1,
            ///  Enable PWM Match 2 Latch. PWM MR2 register update control. See bit 0 for details.
            MAT2LATCHEN: u1,
            ///  Enable PWM Match 3 Latch. PWM MR3 register update control. See bit 0 for details.
            MAT3LATCHEN: u1,
            ///  Enable PWM Match 4 Latch. PWM MR4 register update control. See bit 0 for details.
            MAT4LATCHEN: u1,
            ///  Enable PWM Match 5 Latch. PWM MR5 register update control. See bit 0 for details.
            MAT5LATCHEN: u1,
            ///  Enable PWM Match 6 Latch. PWM MR6 register update control. See bit 0 for details.
            MAT6LATCHEN: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u25,
        }),
        reserved112: [28]u8,
        ///  Count Control Register. The CTCR selects between Timer and Counter mode, and in Counter mode selects the signal and edge(s) for counting.
        CTCR: mmio.Mmio(packed struct(u32) {
            ///  Counter/ Timer Mode
            MOD: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Timer Mode: the TC is incremented when the Prescale Counter matches the Prescale register.
                    TIMER_MODE_THE_TC_I = 0x0,
                    ///  Rising edge counter Mode: the TC is incremented on rising edges of the PWM_CAP input selected by bits 3:2.
                    RISING_EDGE_COUNTER_ = 0x1,
                    ///  Falling edge counter Mode: the TC is incremented on falling edges of the PWM_CAP input selected by bits 3:2.
                    FALLING_EDGE_COUNTER = 0x2,
                    ///  Dual edge counter Mode: the TC is incremented on both edges of the PWM_CAP input selected by bits 3:2.
                    DUAL_EDGE_COUNTER_MO = 0x3,
                },
            },
            ///  Count Input Select. When bits 1:0 are not 00, these bits select which PWM_CAP pin carries the signal used to increment the TC. Other combinations are reserved.
            CIS: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  For PWM0: 00 = PWM0_CAP0 (Other combinations are reserved) For PWM1: 00 = PWM1_CAP0, 01 = PWM1_CAP1 (Other combinations are reserved)
                    FOR_PWM0_00_EQ_PWM0_ = 0x0,
                    _,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u28,
        }),
    };

    ///  I2C bus interface
    pub const I2C0 = extern struct {
        ///  I2C Control Set Register. When a one is written to a bit of this register, the corresponding bit in the I2C control register is set. Writing a zero has no effect on the corresponding bit in the I2C control register.
        CONSET: mmio.Mmio(packed struct(u32) {
            ///  Reserved. User software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u2,
            ///  Assert acknowledge flag.
            AA: u1,
            ///  I2C interrupt flag.
            SI: u1,
            ///  STOP flag.
            STO: u1,
            ///  START flag.
            STA: u1,
            ///  I2C interface enable.
            I2EN: u1,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u25,
        }),
        ///  I2C Status Register. During I2C operation, this register provides detailed status codes that allow software to determine the next action needed.
        STAT: mmio.Mmio(packed struct(u32) {
            ///  These bits are unused and are always 0.
            RESERVED: u3,
            ///  These bits give the actual status information about the I 2C interface.
            Status: u5,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        ///  I2C Data Register. During master or slave transmit mode, data to be transmitted is written to this register. During master or slave receive mode, data that has been received may be read from this register.
        DAT: mmio.Mmio(packed struct(u32) {
            ///  This register holds data values that have been received or are to be transmitted.
            Data: u8,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        ///  I2C Slave Address Register 0. Contains the 7-bit slave address for operation of the I2C interface in slave mode, and is not used in master mode. The least significant bit determines whether a slave responds to the General Call address.
        ADR0: mmio.Mmio(packed struct(u32) {
            ///  General Call enable bit.
            GC: u1,
            ///  The I2C device address for slave mode.
            Address: u7,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        ///  SCH Duty Cycle Register High Half Word. Determines the high time of the I2C clock.
        SCLH: mmio.Mmio(packed struct(u32) {
            ///  Count for SCL HIGH time period selection.
            SCLH: u16,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u16,
        }),
        ///  SCL Duty Cycle Register Low Half Word. Determines the low time of the I2C clock. SCLL and SCLH together determine the clock frequency generated by an I2C master and certain times used in slave mode.
        SCLL: mmio.Mmio(packed struct(u32) {
            ///  Count for SCL low time period selection.
            SCLL: u16,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u16,
        }),
        ///  I2C Control Clear Register. When a one is written to a bit of this register, the corresponding bit in the I2C control register is cleared. Writing a zero has no effect on the corresponding bit in the I2C control register.
        CONCLR: mmio.Mmio(packed struct(u32) {
            ///  Reserved. User software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u2,
            ///  Assert acknowledge Clear bit.
            AAC: u1,
            ///  I2C interrupt Clear bit.
            SIC: u1,
            ///  Reserved. User software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u1,
            ///  START flag Clear bit.
            STAC: u1,
            ///  I2C interface Disable bit.
            I2ENC: u1,
            ///  Reserved. User software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u1,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        ///  Monitor mode control register.
        MMCTRL: mmio.Mmio(packed struct(u32) {
            ///  Monitor mode enable.
            MM_ENA: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Monitor mode disabled.
                    MONITOR_MODE_DISABLE = 0x0,
                    ///  The I 2C module will enter monitor mode. In this mode the SDA output will be forced high. This will prevent the I2C module from outputting data of any kind (including ACK) onto the I2C data bus. Depending on the state of the ENA_SCL bit, the output may be also forced high, preventing the module from having control over the I2C clock line.
                    THE_I_2C_MODULE_WILL = 0x1,
                },
            },
            ///  SCL output enable.
            ENA_SCL: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  When this bit is cleared to 0, the SCL output will be forced high when the module is in monitor mode. As described above, this will prevent the module from having any control over the I2C clock line.
                    WHEN_THIS_BIT_IS_CLE = 0x0,
                    ///  When this bit is set, the I2C module may exercise the same control over the clock line that it would in normal operation. This means that, acting as a slave peripheral, the I2C module can stretch the clock line (hold it low) until it has had time to respond to an I2C interrupt.[1]
                    WHEN_THIS_BIT_IS_SET = 0x1,
                },
            },
            ///  Select interrupt register match.
            MATCH_ALL: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  When this bit is cleared, an interrupt will only be generated when a match occurs to one of the (up-to) four address registers described above. That is, the module will respond as a normal slave as far as address-recognition is concerned.
                    WHEN_THIS_BIT_IS_CLE = 0x0,
                    ///  When this bit is set to 1 and the I2C is in monitor mode, an interrupt will be generated on ANY address received. This will enable the part to monitor all traffic on the bus.
                    WHEN_THIS_BIT_IS_SET = 0x1,
                },
            },
            ///  Reserved. The value read from reserved bits is not defined.
            RESERVED: u29,
        }),
        reserved44: [12]u8,
        ///  Data buffer register. The contents of the 8 MSBs of the DAT shift register will be transferred to the DATA_BUFFER automatically after every nine bits (8 bits of data plus ACK or NACK) has been received on the bus.
        DATA_BUFFER: mmio.Mmio(packed struct(u32) {
            ///  This register holds contents of the 8 MSBs of the DAT shift register.
            Data: u8,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
    };

    ///  SPI
    pub const SPI = extern struct {
        ///  SPI Control Register. This register controls the operation of the SPI.
        CR: mmio.Mmio(packed struct(u32) {
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u2,
            ///  The SPI controller sends and receives 8 bits of data per transfer.
            BITENABLE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The SPI controller sends and receives the number of bits selected by bits 11:8.
                    THE_SPI_CONTROLLER_S = 0x1,
                    _,
                },
            },
            ///  Clock phase control determines the relationship between the data and the clock on SPI transfers, and controls when a slave transfer is defined as starting and ending.
            CPHA: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Data is sampled on the first clock edge of SCK. A transfer starts and ends with activation and deactivation of the SSEL signal.
                    FIRST_EDGE = 0x0,
                    ///  Data is sampled on the second clock edge of the SCK. A transfer starts with the first clock edge, and ends with the last sampling edge when the SSEL signal is active.
                    SECOND_EDGE = 0x1,
                },
            },
            ///  Clock polarity control.
            CPOL: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  SCK is active high.
                    SCK_IS_ACTIVE_HIGH_ = 0x0,
                    ///  SCK is active low.
                    SCK_IS_ACTIVE_LOW_ = 0x1,
                },
            },
            ///  Master mode select.
            MSTR: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The SPI operates in Slave mode.
                    SLAVE = 0x0,
                    ///  The SPI operates in Master mode.
                    MASTER = 0x1,
                },
            },
            ///  LSB First controls which direction each byte is shifted when transferred.
            LSBF: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  SPI data is transferred MSB (bit 7) first.
                    MSB = 0x0,
                    ///  SPI data is transferred LSB (bit 0) first.
                    LSB = 0x1,
                },
            },
            ///  Serial peripheral interrupt enable.
            SPIE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  SPI interrupts are inhibited.
                    INTBLOCK = 0x0,
                    ///  A hardware interrupt is generated each time the SPIF or MODF bits are activated.
                    HWINT = 0x1,
                },
            },
            ///  When bit 2 of this register is 1, this field controls the number of bits per transfer:
            BITS: packed union {
                raw: u4,
                value: enum(u4) {
                    ///  8 bits per transfer
                    @"8_BITS_PER_TRANSFER" = 0x8,
                    ///  9 bits per transfer
                    @"9_BITS_PER_TRANSFER" = 0x9,
                    ///  10 bits per transfer
                    @"10_BITS_PER_TRANSFER" = 0xa,
                    ///  11 bits per transfer
                    @"11_BITS_PER_TRANSFER" = 0xb,
                    ///  12 bits per transfer
                    @"12_BITS_PER_TRANSFER" = 0xc,
                    ///  13 bits per transfer
                    @"13_BITS_PER_TRANSFER" = 0xd,
                    ///  14 bits per transfer
                    @"14_BITS_PER_TRANSFER" = 0xe,
                    ///  15 bits per transfer
                    @"15_BITS_PER_TRANSFER" = 0xf,
                    ///  16 bits per transfer
                    @"16_BITS_PER_TRANSFER" = 0x0,
                    _,
                },
            },
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u20,
        }),
        ///  SPI Status Register. This register shows the status of the SPI.
        SR: mmio.Mmio(packed struct(u32) {
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u3,
            ///  Slave abort. When 1, this bit indicates that a slave abort has occurred. This bit is cleared by reading this register.
            ABRT: u1,
            ///  Mode fault. when 1, this bit indicates that a Mode fault error has occurred. This bit is cleared by reading this register, then writing the SPI0 control register.
            MODF: u1,
            ///  Read overrun. When 1, this bit indicates that a read overrun has occurred. This bit is cleared by reading this register.
            ROVR: u1,
            ///  Write collision. When 1, this bit indicates that a write collision has occurred. This bit is cleared by reading this register, then accessing the SPI Data Register.
            WCOL: u1,
            ///  SPI transfer complete flag. When 1, this bit indicates when a SPI data transfer is complete. When a master, this bit is set at the end of the last cycle of the transfer. When a slave, this bit is set on the last data sampling edge of the SCK. This bit is cleared by first reading this register, then accessing the SPI Data Register. Note: this is not the SPI interrupt flag. This flag is found in the SPINT register.
            SPIF: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        ///  SPI Data Register. This bi-directional register provides the transmit and receive data for the SPI. Transmit data is provided to the SPI0 by writing to this register. Data received by the SPI0 can be read from this register.
        DR: mmio.Mmio(packed struct(u32) {
            ///  SPI Bi-directional data port.
            DATALOW: u8,
            ///  If bit 2 of the SPCR is 1 and bits 11:8 are other than 1000, some or all of these bits contain the additional transmit and receive bits. When less than 16 bits are selected, the more significant among these bits read as zeroes.
            DATAHIGH: u8,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u16,
        }),
        ///  SPI Clock Counter Register. This register controls the frequency of a master's SCK0.
        CCR: mmio.Mmio(packed struct(u32) {
            ///  SPI0 Clock counter setting.
            COUNTER: u8,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        reserved28: [12]u8,
        ///  SPI Interrupt Flag. This register contains the interrupt flag for the SPI interface.
        INT: mmio.Mmio(packed struct(u32) {
            ///  SPI interrupt flag. Set by the SPI interface to generate an interrupt. Cleared by writing a 1 to this bit. Note: this bit will be set once when SPIE = 1 and at least one of SPIF and WCOL bits is 1. However, only when the SPI Interrupt bit is set and SPI0 Interrupt is enabled in the NVIC, SPI based interrupt can be processed by interrupt handling software.
            SPIF: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u7,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
    };

    ///  Real Time Clock (RTC)
    pub const RTC = extern struct {
        ///  Interrupt Location Register
        ILR: mmio.Mmio(packed struct(u32) {
            ///  When one, the Counter Increment Interrupt block generated an interrupt. Writing a one to this bit location clears the counter increment interrupt.
            RTCCIF: u1,
            ///  When one, the alarm registers generated an interrupt. Writing a one to this bit location clears the alarm interrupt.
            RTCALF: u1,
            reserved21: u19,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u11,
        }),
        reserved8: [4]u8,
        ///  Clock Control Register
        CCR: mmio.Mmio(packed struct(u32) {
            ///  Clock Enable.
            CLKEN: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The time counters are enabled.
                    THE_TIME_COUNTERS_AR = 0x1,
                    ///  The time counters are disabled so that they may be initialized.
                    THE_TIME_COUNTERS_AR = 0x0,
                },
            },
            ///  CTC Reset.
            CTCRST: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  When one, the elements in the internal oscillator divider are reset, and remain reset until CCR[1] is changed to zero. This is the divider that generates the 1 Hz clock from the 32.768 kHz crystal. The state of the divider is not visible to software.
                    RESET = 0x1,
                    ///  No effect.
                    NO_EFFECT_ = 0x0,
                },
            },
            ///  Internal test mode controls. These bits must be 0 for normal RTC operation.
            RESERVED: u2,
            ///  Calibration counter enable.
            CCALEN: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The calibration counter is disabled and reset to zero.
                    THE_CALIBRATION_COUN = 0x1,
                    ///  The calibration counter is enabled and counting, using the 1 Hz clock. When the calibration counter is equal to the value of the CALIBRATION register, the counter resets and repeats counting up to the value of the CALIBRATION register. See Section 30.6.4.2 and Section 30.6.5.
                    THE_CALIBRATION_COUN = 0x0,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u27,
        }),
        ///  Counter Increment Interrupt Register
        CIIR: mmio.Mmio(packed struct(u32) {
            ///  When 1, an increment of the Second value generates an interrupt.
            IMSEC: u1,
            ///  When 1, an increment of the Minute value generates an interrupt.
            IMMIN: u1,
            ///  When 1, an increment of the Hour value generates an interrupt.
            IMHOUR: u1,
            ///  When 1, an increment of the Day of Month value generates an interrupt.
            IMDOM: u1,
            ///  When 1, an increment of the Day of Week value generates an interrupt.
            IMDOW: u1,
            ///  When 1, an increment of the Day of Year value generates an interrupt.
            IMDOY: u1,
            ///  When 1, an increment of the Month value generates an interrupt.
            IMMON: u1,
            ///  When 1, an increment of the Year value generates an interrupt.
            IMYEAR: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        ///  Alarm Mask Register
        AMR: mmio.Mmio(packed struct(u32) {
            ///  When 1, the Second value is not compared for the alarm.
            AMRSEC: u1,
            ///  When 1, the Minutes value is not compared for the alarm.
            AMRMIN: u1,
            ///  When 1, the Hour value is not compared for the alarm.
            AMRHOUR: u1,
            ///  When 1, the Day of Month value is not compared for the alarm.
            AMRDOM: u1,
            ///  When 1, the Day of Week value is not compared for the alarm.
            AMRDOW: u1,
            ///  When 1, the Day of Year value is not compared for the alarm.
            AMRDOY: u1,
            ///  When 1, the Month value is not compared for the alarm.
            AMRMON: u1,
            ///  When 1, the Year value is not compared for the alarm.
            AMRYEAR: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        ///  Consolidated Time Register 0
        CTIME0: mmio.Mmio(packed struct(u32) {
            ///  Seconds value in the range of 0 to 59
            SECONDS: u6,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u2,
            ///  Minutes value in the range of 0 to 59
            MINUTES: u6,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u2,
            ///  Hours value in the range of 0 to 23
            HOURS: u5,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u3,
            ///  Day of week value in the range of 0 to 6
            DOW: u3,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u5,
        }),
        ///  Consolidated Time Register 1
        CTIME1: mmio.Mmio(packed struct(u32) {
            ///  Day of month value in the range of 1 to 28, 29, 30, or 31 (depending on the month and whether it is a leap year).
            DOM: u5,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u3,
            ///  Month value in the range of 1 to 12.
            MONTH: u4,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u4,
            ///  Year value in the range of 0 to 4095.
            YEAR: u12,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u4,
        }),
        ///  Consolidated Time Register 2
        CTIME2: mmio.Mmio(packed struct(u32) {
            ///  Day of year value in the range of 1 to 365 (366 for leap years).
            DOY: u12,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u20,
        }),
        ///  Seconds Counter
        SEC: mmio.Mmio(packed struct(u32) {
            ///  Seconds value in the range of 0 to 59
            SECONDS: u6,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u26,
        }),
        ///  Minutes Register
        MIN: mmio.Mmio(packed struct(u32) {
            ///  Minutes value in the range of 0 to 59
            MINUTES: u6,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u26,
        }),
        ///  Hours Register
        HRS: mmio.Mmio(packed struct(u32) {
            ///  Hours value in the range of 0 to 23
            HOURS: u5,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u27,
        }),
        ///  Day of Month Register
        DOM: mmio.Mmio(packed struct(u32) {
            ///  Day of month value in the range of 1 to 28, 29, 30, or 31 (depending on the month and whether it is a leap year).
            DOM: u5,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u27,
        }),
        ///  Day of Week Register
        DOW: mmio.Mmio(packed struct(u32) {
            ///  Day of week value in the range of 0 to 6.
            DOW: u3,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u29,
        }),
        ///  Day of Year Register
        DOY: mmio.Mmio(packed struct(u32) {
            ///  Day of year value in the range of 1 to 365 (366 for leap years).
            DOY: u9,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u23,
        }),
        ///  Months Register
        MONTH: mmio.Mmio(packed struct(u32) {
            ///  Month value in the range of 1 to 12.
            MONTH: u4,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u28,
        }),
        ///  Years Register
        YEAR: mmio.Mmio(packed struct(u32) {
            ///  Year value in the range of 0 to 4095.
            YEAR: u12,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u20,
        }),
        ///  Calibration Value Register
        CALIBRATION: mmio.Mmio(packed struct(u32) {
            ///  If enabled, the calibration counter counts up to this value. The maximum value is 131, 072 corresponding to about 36.4 hours. Calibration is disabled if CALVAL = 0.
            CALVAL: u17,
            ///  Calibration direction
            CALDIR: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Backward calibration. When CALVAL is equal to the calibration counter, the RTC timers will stop incrementing for 1 second.
                    BACKWARD_CALIBRATION = 0x1,
                    ///  Forward calibration. When CALVAL is equal to the calibration counter, the RTC timers will jump by 2 seconds.
                    FORWARD_CALIBRATION_ = 0x0,
                },
            },
            padding: u14,
        }),
        reserved88: [20]u8,
        ///  RTC Auxiliary Enable register
        RTC_AUXEN: mmio.Mmio(packed struct(u32) {
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u4,
            ///  Oscillator Fail Detect interrupt enable. When 0: the RTC Oscillator Fail detect interrupt is disabled. When 1: the RTC Oscillator Fail detect interrupt is enabled. See Section 30.6.2.5.
            RTC_OSCFEN: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u27,
        }),
        ///  RTC Auxiliary control register
        RTC_AUX: mmio.Mmio(packed struct(u32) {
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u4,
            ///  RTC Oscillator Fail detect flag. Read: this bit is set if the RTC oscillator stops, and when RTC power is first turned on. An interrupt will occur when this bit is set, the RTC_OSCFEN bit in RTC_AUXEN is a 1, and the RTC interrupt is enabled in the NVIC. Write: writing a 1 to this bit clears the flag.
            RTC_OSCF: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u1,
            ///  When 0: the RTC_ALARM pin reflects the RTC alarm status. When 1: the RTC_ALARM pin indicates Deep Power-down mode.
            RTC_PDOUT: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u25,
        }),
        ///  Alarm value for Seconds
        ASEC: mmio.Mmio(packed struct(u32) {
            ///  Seconds value in the range of 0 to 59
            SECONDS: u6,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u26,
        }),
        ///  Alarm value for Minutes
        AMIN: mmio.Mmio(packed struct(u32) {
            ///  Minutes value in the range of 0 to 59
            MINUTES: u6,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u26,
        }),
        ///  Alarm value for Hours
        AHRS: mmio.Mmio(packed struct(u32) {
            ///  Hours value in the range of 0 to 23
            HOURS: u5,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u27,
        }),
        ///  Alarm value for Day of Month
        ADOM: mmio.Mmio(packed struct(u32) {
            ///  Day of month value in the range of 1 to 28, 29, 30, or 31 (depending on the month and whether it is a leap year).
            DOM: u5,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u27,
        }),
        ///  Alarm value for Day of Week
        ADOW: mmio.Mmio(packed struct(u32) {
            ///  Day of week value in the range of 0 to 6.
            DOW: u3,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u29,
        }),
        ///  Alarm value for Day of Year
        ADOY: mmio.Mmio(packed struct(u32) {
            ///  Day of year value in the range of 1 to 365 (366 for leap years).
            DOY: u9,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u23,
        }),
        ///  Alarm value for Months
        AMON: mmio.Mmio(packed struct(u32) {
            ///  Month value in the range of 1 to 12.
            MONTH: u4,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u28,
        }),
        ///  Alarm value for Year
        AYRS: mmio.Mmio(packed struct(u32) {
            ///  Year value in the range of 0 to 4095.
            YEAR: u12,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u20,
        }),
    };

    ///  GPIO
    pub const GPIOINT = extern struct {
        ///  GPIO overall Interrupt Status.
        STATUS: mmio.Mmio(packed struct(u32) {
            ///  Port 0 GPIO interrupt pending.
            P0INT: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  No pending interrupts on Port 0.
                    NO_PENDING_INTERRUPT = 0x0,
                    ///  At least one pending interrupt on Port 0.
                    AT_LEAST_ONE_PENDING = 0x1,
                },
            },
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u1,
            ///  Port 2 GPIO interrupt pending.
            P2INT: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  No pending interrupts on Port 2.
                    NO_PENDING_INTERRUPT = 0x0,
                    ///  At least one pending interrupt on Port 2.
                    AT_LEAST_ONE_PENDING = 0x1,
                },
            },
            padding: u29,
        }),
        ///  GPIO Interrupt Status for Rising edge for Port 0.
        STATR0: mmio.Mmio(packed struct(u32) {
            ///  Status of Rising Edge Interrupt for P0[0]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_0REI: u1,
            ///  Status of Rising Edge Interrupt for P0[1]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_1REI: u1,
            ///  Status of Rising Edge Interrupt for P0[2]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_2REI: u1,
            ///  Status of Rising Edge Interrupt for P0[3]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_3REI: u1,
            ///  Status of Rising Edge Interrupt for P0[4]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_4REI: u1,
            ///  Status of Rising Edge Interrupt for P0[5]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_5REI: u1,
            ///  Status of Rising Edge Interrupt for P0[6]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_6REI: u1,
            ///  Status of Rising Edge Interrupt for P0[7]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_7REI: u1,
            ///  Status of Rising Edge Interrupt for P0[8]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_8REI: u1,
            ///  Status of Rising Edge Interrupt for P0[9]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_9REI: u1,
            ///  Status of Rising Edge Interrupt for P0[10]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_10REI: u1,
            ///  Status of Rising Edge Interrupt for P0[11]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_11REI: u1,
            ///  Status of Rising Edge Interrupt for P0[12]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_12REI: u1,
            ///  Status of Rising Edge Interrupt for P0[13]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_13REI: u1,
            ///  Status of Rising Edge Interrupt for P0[14]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_14REI: u1,
            ///  Status of Rising Edge Interrupt for P0[15]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_15REI: u1,
            ///  Status of Rising Edge Interrupt for P0[16]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_16REI: u1,
            ///  Status of Rising Edge Interrupt for P0[17]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_17REI: u1,
            ///  Status of Rising Edge Interrupt for P0[18]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_18REI: u1,
            ///  Status of Rising Edge Interrupt for P0[19]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_19REI: u1,
            ///  Status of Rising Edge Interrupt for P0[20]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_20REI: u1,
            ///  Status of Rising Edge Interrupt for P0[21]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_21REI: u1,
            ///  Status of Rising Edge Interrupt for P0[22]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_22REI: u1,
            ///  Status of Rising Edge Interrupt for P0[23]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_23REI: u1,
            ///  Status of Rising Edge Interrupt for P0[24]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_24REI: u1,
            ///  Status of Rising Edge Interrupt for P0[25]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_25REI: u1,
            ///  Status of Rising Edge Interrupt for P0[26]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_26REI: u1,
            ///  Status of Rising Edge Interrupt for P0[27]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_27REI: u1,
            ///  Status of Rising Edge Interrupt for P0[28]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_28REI: u1,
            ///  Status of Rising Edge Interrupt for P0[29]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_29REI: u1,
            ///  Status of Rising Edge Interrupt for P0[30]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P0_30REI: u1,
            ///  Reserved.
            RESERVED: u1,
        }),
        ///  GPIO Interrupt Status for Falling edge for Port 0.
        STATF0: mmio.Mmio(packed struct(u32) {
            ///  Status of Falling Edge Interrupt for P0[0]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_0FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[1]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_1FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[2]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_2FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[3]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_3FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[4]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_4FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[5]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_5FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[6]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_6FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[7]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_7FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[8]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_8FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[9]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_9FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[10]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_10FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[11]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_11FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[12]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_12FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[13]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_13FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[14]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_14FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[15]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_15FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[16]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_16FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[17]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_17FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[18]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_18FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[19]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_19FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[20]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_20FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[21]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_21FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[22]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_22FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[23]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_23FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[24]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_24FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[25]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_25FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[26]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_26FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[27]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_27FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[28]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_28FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[29]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_29FEI: u1,
            ///  Status of Falling Edge Interrupt for P0[30]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P0_30FEI: u1,
            ///  Reserved.
            RESERVED: u1,
        }),
        ///  GPIO Interrupt Clear.
        CLR0: mmio.Mmio(packed struct(u32) {
            ///  Clear GPIO port Interrupts for P0[0]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_0CI: u1,
            ///  Clear GPIO port Interrupts for P0[1]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_1CI: u1,
            ///  Clear GPIO port Interrupts for P0[2]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_2CI: u1,
            ///  Clear GPIO port Interrupts for P0[3]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_3CI: u1,
            ///  Clear GPIO port Interrupts for P0[4]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_4CI: u1,
            ///  Clear GPIO port Interrupts for P0[5]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_5CI: u1,
            ///  Clear GPIO port Interrupts for P0[6]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_6CI: u1,
            ///  Clear GPIO port Interrupts for P0[7]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_7CI: u1,
            ///  Clear GPIO port Interrupts for P0[8]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_8CI: u1,
            ///  Clear GPIO port Interrupts for P0[9]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_9CI: u1,
            ///  Clear GPIO port Interrupts for P0[10]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_10CI: u1,
            ///  Clear GPIO port Interrupts for P0[11]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_11CI: u1,
            ///  Clear GPIO port Interrupts for P0[12]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_12CI: u1,
            ///  Clear GPIO port Interrupts for P0[13]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_13CI: u1,
            ///  Clear GPIO port Interrupts for P0[14]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_14CI: u1,
            ///  Clear GPIO port Interrupts for P0[15]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_15CI: u1,
            ///  Clear GPIO port Interrupts for P0[16]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_16CI: u1,
            ///  Clear GPIO port Interrupts for P0[17]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_17CI: u1,
            ///  Clear GPIO port Interrupts for P0[18]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_18CI: u1,
            ///  Clear GPIO port Interrupts for P0[19]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_19CI: u1,
            ///  Clear GPIO port Interrupts for P0[20]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_20CI: u1,
            ///  Clear GPIO port Interrupts for P0[21]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_21CI: u1,
            ///  Clear GPIO port Interrupts for P0[22]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_22CI: u1,
            ///  Clear GPIO port Interrupts for P0[23]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_23CI: u1,
            ///  Clear GPIO port Interrupts for P0[24]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_24CI: u1,
            ///  Clear GPIO port Interrupts for P0[25]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_25CI: u1,
            ///  Clear GPIO port Interrupts for P0[26]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_26CI: u1,
            ///  Clear GPIO port Interrupts for P0[27]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_27CI: u1,
            ///  Clear GPIO port Interrupts for P0[28]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_28CI: u1,
            ///  Clear GPIO port Interrupts for P0[29]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_29CI: u1,
            ///  Clear GPIO port Interrupts for P0[30]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P0_30CI: u1,
            ///  Reserved.
            RESERVED: u1,
        }),
        ///  GPIO Interrupt Enable for Rising edge for Port 0.
        ENR0: mmio.Mmio(packed struct(u32) {
            ///  Enable rising edge interrupt for P0[0]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_0ER: u1,
            ///  Enable rising edge interrupt for P0[1]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_1ER: u1,
            ///  Enable rising edge interrupt for P0[2]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_2ER: u1,
            ///  Enable rising edge interrupt for P0[3]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_3ER: u1,
            ///  Enable rising edge interrupt for P0[4]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_4ER: u1,
            ///  Enable rising edge interrupt for P0[5]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_5ER: u1,
            ///  Enable rising edge interrupt for P0[6]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_6ER: u1,
            ///  Enable rising edge interrupt for P0[7]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_7ER: u1,
            ///  Enable rising edge interrupt for P0[8]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_8ER: u1,
            ///  Enable rising edge interrupt for P0[9]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_9ER: u1,
            ///  Enable rising edge interrupt for P0[10]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_10ER: u1,
            ///  Enable rising edge interrupt for P0[11]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_11ER: u1,
            ///  Enable rising edge interrupt for P0[12]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_12ER: u1,
            ///  Enable rising edge interrupt for P0[13]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_13ER: u1,
            ///  Enable rising edge interrupt for P0[14]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_14ER: u1,
            ///  Enable rising edge interrupt for P0[15]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_15ER: u1,
            ///  Enable rising edge interrupt for P0[16]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_16ER: u1,
            ///  Enable rising edge interrupt for P0[17]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_17ER: u1,
            ///  Enable rising edge interrupt for P0[18]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_18ER: u1,
            ///  Enable rising edge interrupt for P0[19]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_19ER: u1,
            ///  Enable rising edge interrupt for P0[20]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_20ER: u1,
            ///  Enable rising edge interrupt for P0[21]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_21ER: u1,
            ///  Enable rising edge interrupt for P0[22]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_22ER: u1,
            ///  Enable rising edge interrupt for P0[23]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_23ER: u1,
            ///  Enable rising edge interrupt for P0[24]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_24ER: u1,
            ///  Enable rising edge interrupt for P0[25]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_25ER: u1,
            ///  Enable rising edge interrupt for P0[26]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_26ER: u1,
            ///  Enable rising edge interrupt for P0[27]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_27ER: u1,
            ///  Enable rising edge interrupt for P0[28]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_28ER: u1,
            ///  Enable rising edge interrupt for P0[29]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_29ER: u1,
            ///  Enable rising edge interrupt for P0[30]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P0_30ER: u1,
            ///  Reserved.
            RESERVED: u1,
        }),
        ///  GPIO Interrupt Enable for Falling edge for Port 0.
        ENF0: mmio.Mmio(packed struct(u32) {
            ///  Enable falling edge interrupt for P0[0]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_0EF: u1,
            ///  Enable falling edge interrupt for P0[1]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_1EF: u1,
            ///  Enable falling edge interrupt for P0[2]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_2EF: u1,
            ///  Enable falling edge interrupt for P0[3]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_3EF: u1,
            ///  Enable falling edge interrupt for P0[4]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_4EF: u1,
            ///  Enable falling edge interrupt for P0[5]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_5EF: u1,
            ///  Enable falling edge interrupt for P0[6]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_6EF: u1,
            ///  Enable falling edge interrupt for P0[7]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_7EF: u1,
            ///  Enable falling edge interrupt for P0[8]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_8EF: u1,
            ///  Enable falling edge interrupt for P0[9]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_9EF: u1,
            ///  Enable falling edge interrupt for P0[10]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_10EF: u1,
            ///  Enable falling edge interrupt for P0[11]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_11EF: u1,
            ///  Enable falling edge interrupt for P0[12]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_12EF: u1,
            ///  Enable falling edge interrupt for P0[13]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_13EF: u1,
            ///  Enable falling edge interrupt for P0[14]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_14EF: u1,
            ///  Enable falling edge interrupt for P0[15]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_15EF: u1,
            ///  Enable falling edge interrupt for P0[16]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_16EF: u1,
            ///  Enable falling edge interrupt for P0[17]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_17EF: u1,
            ///  Enable falling edge interrupt for P0[18]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_18EF: u1,
            ///  Enable falling edge interrupt for P0[19]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_19EF: u1,
            ///  Enable falling edge interrupt for P0[20]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_20EF: u1,
            ///  Enable falling edge interrupt for P0[21]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_21EF: u1,
            ///  Enable falling edge interrupt for P0[22]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_22EF: u1,
            ///  Enable falling edge interrupt for P0[23]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_23EF: u1,
            ///  Enable falling edge interrupt for P0[24]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_24EF: u1,
            ///  Enable falling edge interrupt for P0[25]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_25EF: u1,
            ///  Enable falling edge interrupt for P0[26]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_26EF: u1,
            ///  Enable falling edge interrupt for P0[27]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_27EF: u1,
            ///  Enable falling edge interrupt for P0[28]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_28EF: u1,
            ///  Enable falling edge interrupt for P0[29]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_29EF: u1,
            ///  Enable falling edge interrupt for P0[30]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P0_30EF: u1,
            ///  Reserved.
            RESERVED: u1,
        }),
        reserved36: [12]u8,
        ///  GPIO Interrupt Status for Rising edge for Port 0.
        STATR2: mmio.Mmio(packed struct(u32) {
            ///  Status of Rising Edge Interrupt for P2[0]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P2_0REI: u1,
            ///  Status of Rising Edge Interrupt for P2[1]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P2_1REI: u1,
            ///  Status of Rising Edge Interrupt for P2[2]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P2_2REI: u1,
            ///  Status of Rising Edge Interrupt for P2[3]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P2_3REI: u1,
            ///  Status of Rising Edge Interrupt for P2[4]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P2_4REI: u1,
            ///  Status of Rising Edge Interrupt for P2[5]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P2_5REI: u1,
            ///  Status of Rising Edge Interrupt for P2[6]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P2_6REI: u1,
            ///  Status of Rising Edge Interrupt for P2[7]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P2_7REI: u1,
            ///  Status of Rising Edge Interrupt for P2[8]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P2_8REI: u1,
            ///  Status of Rising Edge Interrupt for P2[9]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P2_9REI: u1,
            ///  Status of Rising Edge Interrupt for P2[10]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P2_10REI: u1,
            ///  Status of Rising Edge Interrupt for P2[11]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P2_11REI: u1,
            ///  Status of Rising Edge Interrupt for P2[12]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P2_12REI: u1,
            ///  Status of Rising Edge Interrupt for P2[13]. 0 = No rising edge detected. 1 = Rising edge interrupt generated.
            P2_13REI: u1,
            ///  Reserved.
            RESERVED: u18,
        }),
        ///  GPIO Interrupt Status for Falling edge for Port 0.
        STATF2: mmio.Mmio(packed struct(u32) {
            ///  Status of Falling Edge Interrupt for P2[0]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P2_0FEI: u1,
            ///  Status of Falling Edge Interrupt for P2[1]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P2_1FEI: u1,
            ///  Status of Falling Edge Interrupt for P2[2]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P2_2FEI: u1,
            ///  Status of Falling Edge Interrupt for P2[3]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P2_3FEI: u1,
            ///  Status of Falling Edge Interrupt for P2[4]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P2_4FEI: u1,
            ///  Status of Falling Edge Interrupt for P2[5]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P2_5FEI: u1,
            ///  Status of Falling Edge Interrupt for P2[6]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P2_6FEI: u1,
            ///  Status of Falling Edge Interrupt for P2[7]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P2_7FEI: u1,
            ///  Status of Falling Edge Interrupt for P2[8]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P2_8FEI: u1,
            ///  Status of Falling Edge Interrupt for P2[9]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P2_9FEI: u1,
            ///  Status of Falling Edge Interrupt for P2[10]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P2_10FEI: u1,
            ///  Status of Falling Edge Interrupt for P2[11]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P2_11FEI: u1,
            ///  Status of Falling Edge Interrupt for P2[12]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P2_12FEI: u1,
            ///  Status of Falling Edge Interrupt for P2[13]. 0 = No falling edge detected. 1 = Falling edge interrupt generated.
            P2_13FEI: u1,
            ///  Reserved.
            RESERVED: u18,
        }),
        ///  GPIO Interrupt Clear.
        CLR2: mmio.Mmio(packed struct(u32) {
            ///  Clear GPIO port Interrupts for P2[0]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P2_0CI: u1,
            ///  Clear GPIO port Interrupts for P2[1]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P2_1CI: u1,
            ///  Clear GPIO port Interrupts for P2[2]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P2_2CI: u1,
            ///  Clear GPIO port Interrupts for P2[3]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P2_3CI: u1,
            ///  Clear GPIO port Interrupts for P2[4]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P2_4CI: u1,
            ///  Clear GPIO port Interrupts for P2[5]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P2_5CI: u1,
            ///  Clear GPIO port Interrupts for P2[6]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P2_6CI: u1,
            ///  Clear GPIO port Interrupts for P2[7]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P2_7CI: u1,
            ///  Clear GPIO port Interrupts for P2[8]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P2_8CI: u1,
            ///  Clear GPIO port Interrupts for P2[9]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P2_9CI: u1,
            ///  Clear GPIO port Interrupts for P2[10]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P2_10CI: u1,
            ///  Clear GPIO port Interrupts for P2[11]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P2_11CI: u1,
            ///  Clear GPIO port Interrupts for P2[12]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P2_12CI: u1,
            ///  Clear GPIO port Interrupts for P2[13]. 0 = No effect. 1 = Clear corresponding bits in IOnINTSTATR and IOnSTATF.
            P2_13CI: u1,
            ///  Reserved.
            RESERVED: u18,
        }),
        ///  GPIO Interrupt Enable for Rising edge for Port 0.
        ENR2: mmio.Mmio(packed struct(u32) {
            ///  Enable rising edge interrupt for P2[0]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P2_0ER: u1,
            ///  Enable rising edge interrupt for P2[1]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P2_1ER: u1,
            ///  Enable rising edge interrupt for P2[2]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P2_2ER: u1,
            ///  Enable rising edge interrupt for P2[3]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P2_3ER: u1,
            ///  Enable rising edge interrupt for P2[4]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P2_4ER: u1,
            ///  Enable rising edge interrupt for P2[5]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P2_5ER: u1,
            ///  Enable rising edge interrupt for P2[6]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P2_6ER: u1,
            ///  Enable rising edge interrupt for P2[7]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P2_7ER: u1,
            ///  Enable rising edge interrupt for P2[8]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P2_8ER: u1,
            ///  Enable rising edge interrupt for P2[9]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P2_9ER: u1,
            ///  Enable rising edge interrupt for P2[10]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P2_10ER: u1,
            ///  Enable rising edge interrupt for P2[11]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P2_11ER: u1,
            ///  Enable rising edge interrupt for P2[12]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P2_12ER: u1,
            ///  Enable rising edge interrupt for P2[13]. 0 = Disable rising edge interrupt. 1 = Enable rising edge interrupt.
            P2_13ER: u1,
            ///  Reserved.
            RESERVED: u18,
        }),
        ///  GPIO Interrupt Enable for Falling edge for Port 0.
        ENF2: mmio.Mmio(packed struct(u32) {
            ///  Enable falling edge interrupt for P2[0]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P2_0EF: u1,
            ///  Enable falling edge interrupt for P2[1]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P2_1EF: u1,
            ///  Enable falling edge interrupt for P2[2]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P2_2EF: u1,
            ///  Enable falling edge interrupt for P2[3]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P2_3EF: u1,
            ///  Enable falling edge interrupt for P2[4]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P2_4EF: u1,
            ///  Enable falling edge interrupt for P2[5]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P2_5EF: u1,
            ///  Enable falling edge interrupt for P2[6]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P2_6EF: u1,
            ///  Enable falling edge interrupt for P2[7]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P2_7EF: u1,
            ///  Enable falling edge interrupt for P2[8]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P2_8EF: u1,
            ///  Enable falling edge interrupt for P2[9]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P2_9EF: u1,
            ///  Enable falling edge interrupt for P2[10]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P2_10EF: u1,
            ///  Enable falling edge interrupt for P2[11]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P2_11EF: u1,
            ///  Enable falling edge interrupt for P2[12]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P2_12EF: u1,
            ///  Enable falling edge interrupt for P2[13]. 0 = Disable falling edge interrupt. 1 = Enable falling edge interrupt.
            P2_13EF: u1,
            ///  Reserved.
            RESERVED: u18,
        }),
    };

    ///  Pin connect block
    pub const PINCONNECT = extern struct {
        ///  Pin function select register 0.
        PINSEL0: mmio.Mmio(packed struct(u32) {
            ///  Pin function select P0.0.
            P0_0: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.0
                    GPIO_P0 = 0x0,
                    ///  RD1
                    RD1 = 0x1,
                    ///  TXD3
                    TXD3 = 0x2,
                    ///  SDA1
                    SDA1 = 0x3,
                },
            },
            ///  Pin function select P0.1.
            P0_1: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.1
                    GPIO_P0 = 0x0,
                    ///  TD1
                    TD1 = 0x1,
                    ///  RXD3
                    RXD3 = 0x2,
                    ///  SCL1
                    SCL1 = 0x3,
                },
            },
            ///  Pin function select P0.2.
            P0_2: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.2
                    GPIO_P0 = 0x0,
                    ///  TXD0
                    TXD0 = 0x1,
                    ///  AD0.7
                    AD0 = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Pin function select P0.3.
            P0_3: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.3.
                    GPIO_P0 = 0x0,
                    ///  RXD0
                    RXD0 = 0x1,
                    ///  AD0.6
                    AD0 = 0x2,
                    ///  Reserved.
                    RESERVED = 0x3,
                },
            },
            ///  Pin function select P0.4.
            P0_4: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.4.
                    GPIO_P0 = 0x0,
                    ///  I2SRX_CLK
                    I2SRX_CLK = 0x1,
                    ///  RD2
                    RD2 = 0x2,
                    ///  CAP2.0
                    CAP2 = 0x3,
                },
            },
            ///  Pin function select P0.5.
            P0_5: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.5.
                    GPIO_P0 = 0x0,
                    ///  I2SRX_WS
                    I2SRX_WS = 0x1,
                    ///  TD2
                    TD2 = 0x2,
                    ///  CAP2.1
                    CAP2 = 0x3,
                },
            },
            ///  Pin function select P0.6.
            P0_6: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.6.
                    GPIO_P0 = 0x0,
                    ///  I2SRX_SDA
                    I2SRX_SDA = 0x1,
                    ///  SSEL1
                    SSEL1 = 0x2,
                    ///  MAT2.0
                    MAT2 = 0x3,
                },
            },
            ///  Pin function select P0.7.
            P0_7: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.7.
                    GPIO_P0 = 0x0,
                    ///  I2STX_CLK
                    I2STX_CLK = 0x1,
                    ///  SCK1
                    SCK1 = 0x2,
                    ///  MAT2.1
                    MAT2 = 0x3,
                },
            },
            ///  Pin function select P0.8.
            P0_8: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.8.
                    GPIO_P0 = 0x0,
                    ///  I2STX_WS
                    I2STX_WS = 0x1,
                    ///  MISO1
                    MISO1 = 0x2,
                    ///  MAT2.2
                    MAT2 = 0x3,
                },
            },
            ///  Pin function select P0.9.
            P0_9: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.9
                    GPIO_P0 = 0x0,
                    ///  I2STX_SDA
                    I2STX_SDA = 0x1,
                    ///  MOSI1
                    MOSI1 = 0x2,
                    ///  MAT2.3
                    MAT2 = 0x3,
                },
            },
            ///  Pin function select P0.10.
            P0_10: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.10
                    GPIO_P0 = 0x0,
                    ///  TXD2
                    TXD2 = 0x1,
                    ///  SDA2
                    SDA2 = 0x2,
                    ///  MAT3.0
                    MAT3 = 0x3,
                },
            },
            ///  Pin function select P0.11.
            P0_11: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.11
                    GPIO_P0 = 0x0,
                    ///  RXD2
                    RXD2 = 0x1,
                    ///  SCL2
                    SCL2 = 0x2,
                    ///  MAT3.1
                    MAT3 = 0x3,
                },
            },
            ///  Reserved.
            RESERVED: u6,
            ///  Pin function select P0.15.
            P0_15: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.15
                    GPIO_P0 = 0x0,
                    ///  TXD1
                    TXD1 = 0x1,
                    ///  SCK0
                    SCK0 = 0x2,
                    ///  SCK
                    SCK = 0x3,
                },
            },
        }),
        ///  Pin function select register 1.
        PINSEL1: mmio.Mmio(packed struct(u32) {
            ///  Pin function select P0.16.
            P0_16: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.16
                    GPIO_P0 = 0x0,
                    ///  RXD1
                    RXD1 = 0x1,
                    ///  SSEL0
                    SSEL0 = 0x2,
                    ///  SSEL
                    SSEL = 0x3,
                },
            },
            ///  Pin function select P0.17.
            P0_17: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.17
                    GPIO_P0 = 0x0,
                    ///  CTS1
                    CTS1 = 0x1,
                    ///  MISO0
                    MISO0 = 0x2,
                    ///  MISO
                    MISO = 0x3,
                },
            },
            ///  Pin function select P0.18.
            P0_18: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.18
                    GPIO_P0 = 0x0,
                    ///  DCD1
                    DCD1 = 0x1,
                    ///  MOSI0
                    MOSI0 = 0x2,
                    ///  MOSI
                    MOSI = 0x3,
                },
            },
            ///  Pin function select P019.
            P0_19: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.19.
                    GPIO_P0 = 0x0,
                    ///  DSR1
                    DSR1 = 0x1,
                    ///  Reserved
                    RESERVED = 0x2,
                    ///  SDA1
                    SDA1 = 0x3,
                },
            },
            ///  Pin function select P0.20.
            P0_20: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.20.
                    GPIO_P0 = 0x0,
                    ///  DTR1
                    DTR1 = 0x1,
                    ///  Reserved
                    RESERVED = 0x2,
                    ///  SCL1
                    SCL1 = 0x3,
                },
            },
            ///  Pin function select P0.21.
            P0_21: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO Port 0.21.
                    GPIO_PORT_0 = 0x0,
                    ///  RI1
                    RI1 = 0x1,
                    ///  Reserved
                    RESERVED = 0x2,
                    ///  RD1
                    RD1 = 0x3,
                },
            },
            ///  Pin function select P022
            P0_22: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.22.
                    GPIO_P0 = 0x0,
                    ///  RTS1
                    RTS1 = 0x1,
                    ///  Reserved
                    RESERVED = 0x2,
                    ///  TD1
                    TD1 = 0x3,
                },
            },
            ///  Pin function select P023.
            P0_23: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.23.
                    GPIO_P0 = 0x0,
                    ///  AD0.0
                    AD0 = 0x1,
                    ///  I2SRX_CLK
                    I2SRX_CLK = 0x2,
                    ///  CAP3.0
                    CAP3 = 0x3,
                },
            },
            ///  Pin function select P0.24.
            P0_24: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.24.
                    GPIO_P0 = 0x0,
                    ///  AD0.1
                    AD0 = 0x1,
                    ///  I2SRX_WS
                    I2SRX_WS = 0x2,
                    ///  CAP3.1
                    CAP3 = 0x3,
                },
            },
            ///  Pin function select P0.25.
            P0_25: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.25
                    GPIO_P0 = 0x0,
                    ///  AD0.2
                    AD0 = 0x1,
                    ///  I2SRX_SDA
                    I2SRX_SDA = 0x2,
                    ///  TXD3
                    TXD3 = 0x3,
                },
            },
            ///  Pin function select P0.26.
            P0_26: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.26
                    GPIO_P0 = 0x0,
                    ///  AD0.3
                    AD0 = 0x1,
                    ///  AOUT
                    AOUT = 0x2,
                    ///  RXD3
                    RXD3 = 0x3,
                },
            },
            ///  Pin function select P0.27.
            P0_27: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.27
                    GPIO_P0 = 0x0,
                    ///  SDA0
                    SDA0 = 0x1,
                    ///  USB_SDA
                    USB_SDA = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Pin function select P0.28.
            P0_28: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.28
                    GPIO_P0 = 0x0,
                    ///  SCL0
                    SCL0 = 0x1,
                    ///  USB_SCL
                    USB_SCL = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Pin function select P0.29
            P0_29: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.29
                    GPIO_P0 = 0x0,
                    ///  USB_D+
                    USB_DP = 0x1,
                    ///  Reserved
                    RESERVED = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Pin function select P0.30.
            P0_30: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P0.30
                    GPIO_P0 = 0x0,
                    ///  USB_D-
                    USB_DM = 0x1,
                    ///  Reserved
                    RESERVED = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Reserved
            RESERVED: u2,
        }),
        ///  Pin function select register 2.
        PINSEL2: mmio.Mmio(packed struct(u32) {
            ///  Pin function select P1.0.
            P1_0: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.0
                    GPIO_P1 = 0x0,
                    ///  ENET_TXD0
                    ENET_TXD0 = 0x1,
                    ///  Reserved
                    RESERVED = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Pin function select P1.1.
            P1_1: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.1
                    GPIO_P1 = 0x0,
                    ///  ENET_TXD1
                    ENET_TXD1 = 0x1,
                    ///  Reserved
                    RESERVED = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Reserved.
            RESERVED: u4,
            ///  Pin function select P1.4.
            P1_4: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.4.
                    GPIO_P1 = 0x0,
                    ///  ENET_TX_EN
                    ENET_TX_EN = 0x1,
                    ///  Reserved
                    RESERVED = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Reserved.
            RESERVED: u6,
            ///  Pin function select P1.8.
            P1_8: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.8.
                    GPIO_P1 = 0x0,
                    ///  ENET_CRS
                    ENET_CRS = 0x1,
                    ///  Reserved
                    RESERVED = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Pin function select P1.9.
            P1_9: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO Port 1.9
                    GPIO_PORT_1 = 0x0,
                    ///  ENET_RXD0
                    ENET_RXD0 = 0x1,
                    ///  Reserved
                    RESERVED = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Pin function select P1.10.
            P1_10: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.10
                    GPIO_P1 = 0x0,
                    ///  ENET_RXD1
                    ENET_RXD1 = 0x1,
                    ///  Reserved
                    RESERVED = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Pin function select P1.14.
            P1_14: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.14
                    GPIO_P1 = 0x0,
                    ///  ENET_RX_ER
                    ENET_RX_ER = 0x1,
                    ///  Reserved
                    RESERVED = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Reserved.
            RESERVED: u6,
            ///  Pin function select P1.15.
            P1_15: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.15
                    GPIO_P1 = 0x0,
                    ///  ENET_REF_CLK
                    ENET_REF_CLK = 0x1,
                    ///  Reserved
                    RESERVED = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
        }),
        ///  Pin function select register 3.
        PINSEL3: mmio.Mmio(packed struct(u32) {
            ///  Pin function select P1.16.
            P1_16: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.16
                    GPIO_P1 = 0x0,
                    ///  ENET_MDC
                    ENET_MDC = 0x1,
                    ///  Reserved
                    RESERVED = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Pin function select P1.17.
            P1_17: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.17
                    GPIO_P1 = 0x0,
                    ///  ENET_MDIO
                    ENET_MDIO = 0x1,
                    ///  Reserved
                    RESERVED = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Pin function select P1.18.
            P1_18: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.18
                    GPIO_P1 = 0x0,
                    ///  USB_UP_LED
                    USB_UP_LED = 0x1,
                    ///  PWM1.1
                    PWM1 = 0x2,
                    ///  CAP1.0
                    CAP1 = 0x3,
                },
            },
            ///  Pin function select P1.19.
            P1_19: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.19.
                    GPIO_P1 = 0x0,
                    ///  MCOA0
                    MCOA0 = 0x1,
                    ///  USB_PPWR
                    USB_PPWR = 0x2,
                    ///  CAP1.1
                    CAP1 = 0x3,
                },
            },
            ///  Pin function select P1.20.
            P1_20: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.20.
                    GPIO_P1 = 0x0,
                    ///  MCI0
                    MCI0 = 0x1,
                    ///  PWM1.2
                    PWM1 = 0x2,
                    ///  SCK0
                    SCK0 = 0x3,
                },
            },
            ///  Pin function select P1.21.
            P1_21: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.21.
                    GPIO_P1 = 0x0,
                    ///  MCABORT
                    MCABORT = 0x1,
                    ///  PWM1.3
                    PWM1 = 0x2,
                    ///  SSEL0
                    SSEL0 = 0x3,
                },
            },
            ///  Pin function select P1.22
            P1_22: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.22.
                    GPIO_P1 = 0x0,
                    ///  MCOB0
                    MCOB0 = 0x1,
                    ///  USB_PWRD
                    USB_PWRD = 0x2,
                    ///  MAT1.0
                    MAT1 = 0x3,
                },
            },
            ///  Pin function select P1.23.
            P1_23: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.23.
                    GPIO_P1 = 0x0,
                    ///  MCI1
                    MCI1 = 0x1,
                    ///  PWM1.4
                    PWM1 = 0x2,
                    ///  MISO0
                    MISO0 = 0x3,
                },
            },
            ///  Pin function select P1.24.
            P1_24: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.24.
                    GPIO_P1 = 0x0,
                    ///  MCI2
                    MCI2 = 0x1,
                    ///  PWM1.5
                    PWM1 = 0x2,
                    ///  MOSI0
                    MOSI0 = 0x3,
                },
            },
            ///  Pin function select P1.25.
            P1_25: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.25
                    GPIO_P1 = 0x0,
                    ///  MCOA1
                    MCOA1 = 0x1,
                    ///  Reserved
                    RESERVED = 0x2,
                    ///  MAT1.1
                    MAT1 = 0x3,
                },
            },
            ///  Pin function select P1.26.
            P1_26: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.26
                    GPIO_P1 = 0x0,
                    ///  MCOB1
                    MCOB1 = 0x1,
                    ///  PWM1.6
                    PWM1 = 0x2,
                    ///  CAP0.0
                    CAP0 = 0x3,
                },
            },
            ///  Pin function select P1.27.
            P1_27: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.27
                    GPIO_P1 = 0x0,
                    ///  CLKOUT
                    CLKOUT = 0x1,
                    ///  USB_OVRCR
                    USB_OVRCR = 0x2,
                    ///  CAP0.1
                    CAP0 = 0x3,
                },
            },
            ///  Pin function select P1.28.
            P1_28: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.28
                    GPIO_P1 = 0x0,
                    ///  MCOA2
                    MCOA2 = 0x1,
                    ///  PCAP1.0
                    PCAP1 = 0x2,
                    ///  MAT0.0
                    MAT0 = 0x3,
                },
            },
            ///  Pin function select P1.29
            P1_29: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.29
                    GPIO_P1 = 0x0,
                    ///  MCOB2
                    MCOB2 = 0x1,
                    ///  PCAP1.1
                    PCAP1 = 0x2,
                    ///  MAT0.1
                    MAT0 = 0x3,
                },
            },
            ///  Pin function select P1.30.
            P1_30: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P1.30
                    GPIO_P1 = 0x0,
                    ///  Reserved
                    RESERVED = 0x1,
                    ///  VBUS
                    VBUS = 0x2,
                    ///  AD0.4
                    AD0 = 0x3,
                },
            },
            ///  Pin function select P1.31.
            P1_31: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO Port 1.31
                    GPIO_PORT_1 = 0x0,
                    ///  Reserved
                    RESERVED = 0x1,
                    ///  SCK1
                    SCK1 = 0x2,
                    ///  AD0.5
                    AD0 = 0x3,
                },
            },
        }),
        ///  Pin function select register 4
        PINSEL4: mmio.Mmio(packed struct(u32) {
            ///  Pin function select P2.0.
            P2_0: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P2.0
                    GPIO_P2 = 0x0,
                    ///  PWM1.1
                    PWM1 = 0x1,
                    ///  TXD1
                    TXD1 = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Pin function select P2.1.
            P2_1: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P2.1
                    GPIO_P2 = 0x0,
                    ///  PWM1.2
                    PWM1 = 0x1,
                    ///  RXD1
                    RXD1 = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Pin function select P2.2.
            P2_2: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P2.2
                    GPIO_P2 = 0x0,
                    ///  PWM1.3
                    PWM1 = 0x1,
                    ///  CTS1
                    CTS1 = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Pin function select P2.3.
            P2_3: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P2.3.
                    GPIO_P2 = 0x0,
                    ///  PWM1.4
                    PWM1 = 0x1,
                    ///  DCD1
                    DCD1 = 0x2,
                    ///  Reserved.
                    RESERVED = 0x3,
                },
            },
            ///  Pin function select P2.4.
            P2_4: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P2.4.
                    GPIO_P2 = 0x0,
                    ///  PWM1.5
                    PWM1 = 0x1,
                    ///  DSR1
                    DSR1 = 0x2,
                    ///  Reserved.
                    RESERVED = 0x3,
                },
            },
            ///  Pin function select P2.5.
            P2_5: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P2.5.
                    GPIO_P2 = 0x0,
                    ///  PWM1.6
                    PWM1 = 0x1,
                    ///  DTR1
                    DTR1 = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Pin function select P2.6.
            P2_6: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P2.6.
                    GPIO_P2 = 0x0,
                    ///  PCAP1.0
                    PCAP1 = 0x1,
                    ///  RI1
                    RI1 = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Pin function select P2.7.
            P2_7: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P2.7.
                    GPIO_P2 = 0x0,
                    ///  RD2
                    RD2 = 0x1,
                    ///  RTS1
                    RTS1 = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Pin function select P2.8.
            P2_8: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P2.8.
                    GPIO_P2 = 0x0,
                    ///  TD2
                    TD2 = 0x1,
                    ///  TXD2
                    TXD2 = 0x2,
                    ///  ENET_MDC
                    ENET_MDC = 0x3,
                },
            },
            ///  Pin function select P2.9.
            P2_9: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P2.9
                    GPIO_P2 = 0x0,
                    ///  USB_CONNECT
                    USB_CONNECT = 0x1,
                    ///  RXD2
                    RXD2 = 0x2,
                    ///  ENET_MDIO
                    ENET_MDIO = 0x3,
                },
            },
            ///  Pin function select P2.10.
            P2_10: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P2.10
                    GPIO_P2 = 0x0,
                    ///  EINT0
                    EINT0 = 0x1,
                    ///  NMI
                    NMI = 0x2,
                    ///  Reserved
                    RESERVED = 0x3,
                },
            },
            ///  Pin function select P2.11.
            P2_11: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P2.11
                    GPIO_P2 = 0x0,
                    ///  EINT1
                    EINT1 = 0x1,
                    ///  Reserved
                    RESERVED = 0x2,
                    ///  I2STX_CLK
                    I2STX_CLK = 0x3,
                },
            },
            ///  Pin function select P2.12.
            P2_12: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P2.12
                    GPIO_P2 = 0x0,
                    ///  EINT2
                    EINT2 = 0x1,
                    ///  Reserved
                    RESERVED = 0x2,
                    ///  I2STX_WS
                    I2STX_WS = 0x3,
                },
            },
            ///  Pin function select P2.13.
            P2_13: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P2.13
                    GPIO_P2 = 0x0,
                    ///  EINT3
                    EINT3 = 0x1,
                    ///  Reserved
                    RESERVED = 0x2,
                    ///  I2STX_SDA
                    I2STX_SDA = 0x3,
                },
            },
            ///  Reserved.
            RESERVED: u4,
        }),
        reserved28: [8]u8,
        ///  Pin function select register 7
        PINSEL7: mmio.Mmio(packed struct(u32) {
            ///  Reserved.
            RESERVED: u18,
            ///  Pin function select P3.25.
            P3_25: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P3.25
                    GPIO_P3 = 0x0,
                    ///  Reserved
                    RESERVED = 0x1,
                    ///  MAT0.0
                    MAT0 = 0x2,
                    ///  PWM1.2
                    PWM1 = 0x3,
                },
            },
            ///  Pin function select P3.26.
            P3_26: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P3.26
                    GPIO_P3 = 0x0,
                    ///  STCLK
                    STCLK = 0x1,
                    ///  MAT0.1
                    MAT0 = 0x2,
                    ///  PWM1.3
                    PWM1 = 0x3,
                },
            },
            ///  Reserved.
            RESERVED: u10,
        }),
        reserved36: [4]u8,
        ///  Pin function select register 9
        PINSEL9: mmio.Mmio(packed struct(u32) {
            ///  Reserved.
            RESERVED: u24,
            ///  Pin function select P4.28.
            P4_28: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P4.28
                    GPIO_P4 = 0x0,
                    ///  RX_MCLK
                    RX_MCLK = 0x1,
                    ///  MAT2.0
                    MAT2 = 0x2,
                    ///  TXD3
                    TXD3 = 0x3,
                },
            },
            ///  Pin function select P4.29.
            P4_29: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  GPIO P4.29
                    GPIO_P4 = 0x0,
                    ///  TX_MCLK
                    TX_MCLK = 0x1,
                    ///  MAT2.1
                    MAT2 = 0x2,
                    ///  RXD3
                    RXD3 = 0x3,
                },
            },
            ///  Reserved.
            RESERVED: u4,
        }),
        ///  Pin function select register 10
        PINSEL10: mmio.Mmio(packed struct(u32) {
            ///  Reserved. Software should not write 1 to these bits.
            RESERVED: u3,
            ///  TPIU interface pins control.
            TPIUCTRL: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled. TPIU interface is disabled.
                    DISABLED = 0x0,
                    ///  Enabled. TPIU interface is enabled. TPIU signals are available on the pins hosting them regardless of the PINSEL4 content.
                    ENABLED = 0x1,
                },
            },
            ///  Reserved. Software should not write 1 to these bits.
            RESERVED: u28,
        }),
        reserved64: [20]u8,
        ///  Pin mode select register 0
        PINMODE0: mmio.Mmio(packed struct(u32) {
            ///  Port 0 pin 0 on-chip pull-up/down resistor control.
            P0_00MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.0 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.0 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.0 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.0 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 0 pin 1 control.
            P0_01MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.1 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.1 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.1 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.1 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 0 pin 2 control.
            P0_02MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.2 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.2 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.2 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.2 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 0 pin 3 control.
            P0_03MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.3 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.3 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.3 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.3 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 0 pin 4 control.
            P0_04MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.4 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.4 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.4 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.4 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 0 pin 5 control.
            P0_05MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.5 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.5 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.5 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.5 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 0 pin 6 control.
            P0_06MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.6 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Disabled. Repeater. P0.6 pin has repeater mode enabled.
                    DISABLED = 0x1,
                    ///  Disabled. P0.6 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.6 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 0 pin 7 control.
            P0_07MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.7 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.7 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.7 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.7 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 0 pin 8 control.
            P0_08MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.8 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.8 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.8 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.8 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 0 pin 9 control.
            P0_09MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.9 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.9 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.9 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.9 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 0 pin 10 control.
            P0_10MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.10 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.10 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.10 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.10 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 0 pin 11 control.
            P0_11MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.11 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.11 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.11 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.11 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Reserved.
            RESERVED: u6,
            ///  Port 0 pin 15 control.
            P0_15MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.15 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.15 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.15 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.15 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
        }),
        ///  Pin mode select register 1
        PINMODE1: mmio.Mmio(packed struct(u32) {
            ///  Port 1 pin 16 control.
            P0_16MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.16 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.16 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.16 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.16 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 17 control.
            P0_17MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.17 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.17 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.17 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.17 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 18 control.
            P0_18MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.18 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.18 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.18 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.18 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 19 control.
            P0_19MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.19 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.19 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.19 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.19 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 20 control.
            P0_20MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.20 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.20 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.20 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.20 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 21 control.
            P0_21MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.21 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.21 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.21 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.21 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 22 control.
            P0_22MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.22 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.22 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.22 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.22 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 23 control.
            P0_23MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.23 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.23 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.23 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.23 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 24 control.
            P0_24MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.24 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.24 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.24 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.24 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 25 control.
            P0_25MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.25 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.25 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.25 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.25 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 26 control.
            P0_26MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P0.26 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P0.26 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P0.26 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P0.26 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Reserved.
            RESERVED: u8,
            ///  Reserved.
            RESERVED: u2,
        }),
        ///  Pin mode select register 2
        PINMODE2: mmio.Mmio(packed struct(u32) {
            ///  Port 1 pin 0 control.
            P1_00MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.0 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.0 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.0 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.0 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 1 control.
            P1_01MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.1 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.1 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.1 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.1 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Reserved.
            RESERVED: u4,
            ///  Port 1 pin 4 control.
            P1_04MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.4 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.4 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.4 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.4 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Reserved.
            RESERVED: u6,
            ///  Port 1 pin 8 control.
            P1_08MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.8 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.8 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.8 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.8 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 9 control.
            P1_09MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.9 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.9 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.9 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.9 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 10 control.
            P1_10MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.10 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.10 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.10 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.10 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Reserved.
            RESERVED: u6,
            ///  Port 1 pin 14 control.
            P1_14MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.14 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.14 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.14 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.14 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 15 control.
            P1_15MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.15 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.15 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.15 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.15 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
        }),
        ///  Pin mode select register 3.
        PINMODE3: mmio.Mmio(packed struct(u32) {
            ///  Port 1 pin 16 control.
            P1_16MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.16 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.16 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.16 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.16 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 17 control.
            P1_17MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.17 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.17 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.17 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.17 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 18 control.
            P1_18MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.18 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.18 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.18 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.18 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 19 control.
            P1_19MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.19 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.19 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.19 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.19 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 20 control.
            P1_20MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.20 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.20 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.20 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.20 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 21 control.
            P1_21MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.21 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.21 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.21 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.21 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 22 control.
            P1_22MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.22 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.22 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.22 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.22 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 23 control.
            P1_23MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.23 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.23 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.23 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.23 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 24 control.
            P1_24MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.24 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.24 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.24 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.24 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 25 control.
            P1_25MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.25 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.25 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.25 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.25 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 26 control.
            P1_26MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.26 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.26 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.26 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.26 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 27 control.
            P1_27MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.27 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.27 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.27 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.27 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 28 control.
            P1_28MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.28 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.28 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.28 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.28 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 29 control.
            P1_29MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.29 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.29 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.29 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.29 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 30 control.
            P1_30MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.30 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.30 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.30 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.30 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 1 pin 31 control.
            P1_31MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P1.31 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P1.31 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P1.31 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P1.31 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
        }),
        ///  Pin mode select register 4
        PINMODE4: mmio.Mmio(packed struct(u32) {
            ///  Port 2 pin 0 control.
            P2_00MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P2.0 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P2.0 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P2.0 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P2.0 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 2 pin 1 control.
            P2_01MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P2.1 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P2.1 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P2.1 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P2.1 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 2 pin 2 control.
            P2_02MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P2.2 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P2.2 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P2.2 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P2.2 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 2 pin 3 control.
            P2_03MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P2.3 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P2.3 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P2.3 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P2.3 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 2 pin 4 control.
            P2_04MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P2.4 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P2.4 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P2.4 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P2.4 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 2 pin 5 control.
            P2_05MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P2.5 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P2.5 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P2.5 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P2.5 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 2 pin 6 control.
            P2_06MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P2.6 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P2.6 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P2.6 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P2.6 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 2 pin 7 control.
            P2_07MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P2.7 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P2.7 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P2.7 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P2.7 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 2 pin 8 control.
            P2_08MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P2.8 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P2.8 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P2.8 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P2.8 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 2 pin 9 control.
            P2_09MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P2.9 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P2.9 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P2.9 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P2.9 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 2 pin 10 control.
            P2_10MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P2.10 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P2.10 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P2.10 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P2.10 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 2 pin 11 control.
            P2_11MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P2.11 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P2.11 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P2.11 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P2.11 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 2 pin 12 control.
            P2_12MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P2.12 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P2.12 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P2.12 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P2.12 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 2 pin 13 control.
            P2_13MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P2.13 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P2.13 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P2.13 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P2.13 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Reserved.
            RESERVED: u4,
        }),
        reserved92: [8]u8,
        ///  Pin mode select register 7
        PINMODE7: mmio.Mmio(packed struct(u32) {
            ///  Reserved
            RESERVED: u18,
            ///  Port 3 pin 25 control.
            P3_25MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P3.25 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P3.25 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P3.25 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P3.25 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 3 pin 26 control.
            P3_26MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P3.26 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P3.26 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P3.26 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P3.26 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Reserved.
            RESERVED: u10,
        }),
        reserved100: [4]u8,
        ///  Pin mode select register 9
        PINMODE9: mmio.Mmio(packed struct(u32) {
            ///  Reserved.
            RESERVED: u24,
            ///  Port 4 pin 28 control.
            P4_28MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P4.28 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P4.28 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P4.28 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P4.28 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Port 4 pin 29 control.
            P4_29MODE: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Pull-up. P4.29 pin has a pull-up resistor enabled.
                    PULL_UP = 0x0,
                    ///  Repeater. P4.29 pin has repeater mode enabled.
                    REPEATER = 0x1,
                    ///  Disabled. P4.29 pin has neither pull-up nor pull-down.
                    DISABLED = 0x2,
                    ///  Pull-down. P4.29 has a pull-down resistor enabled.
                    PULL_DOWN = 0x3,
                },
            },
            ///  Reserved.
            RESERVED: u4,
        }),
        ///  Open drain mode control register 0
        PINMODE_OD0: mmio.Mmio(packed struct(u32) {
            ///  Port 0 pin 0 open drain mode control. Pins may potentially be used for I2C-buses using standard port pins. If so, they should be configured for open drain mode via the related bits in PINMODE_OD0.
            P0_00OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.0 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.0 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 1 open drain mode control. Pins may potentially be used for I2C-buses using standard port pins. If so, they should be configured for open drain mode via the related bits in PINMODE_OD0.
            P0_01OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.1 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.1 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 2 open drain mode control
            P0_02OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.2 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.2 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 3 open drain mode control
            P0_03OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.3 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.3 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 4 open drain mode control
            P0_04OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.4 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.4 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 5 open drain mode control
            P0_05OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.5 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.5 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 6 open drain mode control
            P0_06OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.6 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.6 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 7 open drain mode control
            P0_07OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.7 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.7 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 8 open drain mode control
            P0_08OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.8 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.8 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 9 open drain mode control
            P0_09OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.9 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.9 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 10 open drain mode control. Pins may potentially be used for I2C-buses using standard port pins. If so, they should be configured for open drain mode via the related bits in PINMODE_OD0.
            P0_10OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.10 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.10 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 11 open drain mode control. Pins may potentially be used for I2C-buses using standard port pins. If so, they should be configured for open drain mode via the related bits in PINMODE_OD0.
            P0_11OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.11 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.11 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u3,
            ///  Port 0 pin 15 open drain mode control
            P0_15OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.15 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.15 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 16 open drain mode control
            P0_16OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.16 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.16 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 17 open drain mode control
            P0_17OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.17 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.17 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 18 open drain mode control
            P0_18OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.18 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.18 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 19 open drain mode control. Pins may potentially be used for I2C-buses using standard port pins. If so, they should be configured for open drain mode via the related bits in PINMODE_OD0.
            P0_19OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.19 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.19 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 20open drain mode control. Pins may potentially be used for I2C-buses using standard port pins. If so, they should be configured for open drain mode via the related bits in PINMODE_OD0.
            P0_20OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.20 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.20 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 21 open drain mode control
            P0_21OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.21 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.21 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 22 open drain mode control
            P0_22OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.22 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.22 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 23 open drain mode control
            P0_23OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.23 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.23 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 24open drain mode control
            P0_24OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.23 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.23 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 25 open drain mode control
            P0_25OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.25 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.25 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 26 open drain mode control
            P0_26OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.26 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.26 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u2,
            ///  Port 0 pin 29 open drain mode control
            P0_29OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.29 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.29 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 0 pin 30 open drain mode control
            P0_30OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P0.30 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P0.30 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u1,
        }),
        ///  Open drain mode control register 1
        PINMODE_OD1: mmio.Mmio(packed struct(u32) {
            ///  Port 1 pin 0 open drain mode control.
            P1_00OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.0 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.0 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 1 pin 1 open drain mode control, see P1.00OD
            P1_01OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.1 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.1 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u2,
            ///  Port 1 pin 4 open drain mode control, see P1.00OD
            P1_04OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.4 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.4 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u3,
            ///  Port 1 pin 8 open drain mode control, see P1.00OD
            P1_08OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.8 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.8 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 1 pin 9 open drain mode control, see P1.00OD
            P1_09OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.9 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.9 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 1 pin 10 open drain mode control, see P1.00OD
            P1_10OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.10 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.10 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u3,
            ///  Port 1 pin 14 open drain mode control, see P1.00OD
            P1_14OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.14 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.14 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 1 pin 15 open drain mode control, see P1.00OD
            P1_15OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.15 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.15 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 1 pin 16 open drain mode control, see P1.00OD
            P1_16OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.16 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.16 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 1 pin 17 open drain mode control, see P1.00OD
            P1_17OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.17 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.17 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 1 pin 18 open drain mode control, see P1.00OD
            P1_18OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.18 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.18 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 1 pin 19 open drain mode control, see P1.00OD
            P1_19OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.19 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.19 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 1 pin 20open drain mode control, see P1.00OD
            P1_20OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.20 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.20 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 1 pin 21 open drain mode control, see P1.00OD
            P1_21OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.21 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.21 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 1 pin 22 open drain mode control, see P1.00OD
            P1_22OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.22 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.22 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 1 pin 23 open drain mode control, see P1.00OD
            P1_23OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.23 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.23 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 1 pin 24open drain mode control, see P1.00OD
            P1_24OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.24 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.24 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 1 pin 25 open drain mode control, see P1.00OD
            P1_25OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.25 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.25 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 1 pin 26 open drain mode control, see P1.00OD
            P1_26OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.26 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.26 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 1 pin 27 open drain mode control, see P1.00OD
            P1_27OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.27 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.27 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 1 pin 28 open drain mode control, see P1.00OD
            P1_28OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.28 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.28 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 1 pin 29 open drain mode control, see P1.00OD
            P1_29OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.29 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.29 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 1 pin 30 open drain mode control, see P1.00OD
            P1_30OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.30 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.30 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 1 pin 31 open drain mode control.
            P1_31OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P1.31 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P1.31 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
        }),
        ///  Open drain mode control register 2
        PINMODE_OD2: mmio.Mmio(packed struct(u32) {
            ///  Port 2 pin 0 open drain mode control.
            P2_00OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P2.0 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P2.0 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 2 pin 1 open drain mode control, see P2.00OD
            P2_01OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P2.1 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P2.1p in is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 2 pin 2 open drain mode control, see P2.00OD
            P2_02OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P2.2 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P2.2 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 2 pin 3 open drain mode control, see P2.00OD
            P2_03OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P2.3 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P2.3 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 2 pin 4 open drain mode control, see P2.00OD
            P2_04OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P2.4 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P2.4 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 2 pin 5 open drain mode control, see P2.00OD
            P2_05OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P2.5 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P2.5 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 2 pin 6 open drain mode control, see P2.00OD
            P2_06OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P2.6 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P2.6 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 2 pin 7 open drain mode control, see P2.00OD
            P2_07OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P2.7 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P2.7 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 2 pin 8 open drain mode control, see P2.00OD
            P2_08OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P2.8 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P2.8 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 2 pin 9 open drain mode control, see P2.00OD
            P2_09OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P2.9 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P2.9 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 2 pin 10 open drain mode control, see P2.00OD
            P2_10OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P2.10 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P2.10 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 2 pin 11 open drain mode control, see P2.00OD
            P2_11OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P2.11 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P2.11 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 2 pin 12 open drain mode control, see P2.00OD
            P2_12OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P2.12 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P2.12 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 2 pin 13 open drain mode control, see P2.00OD
            P2_13OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P2.13 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P2.13 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u18,
        }),
        ///  Open drain mode control register 3
        PINMODE_OD3: mmio.Mmio(packed struct(u32) {
            ///  Reserved.
            RESERVED: u25,
            ///  Port 3 pin 25 open drain mode control.
            P3_25OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P3.25 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P3.25 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 3 pin 26 open drain mode control, see P3.25OD
            P3_26OD: u1,
            ///  Reserved.
            RESERVED: u5,
        }),
        ///  Open drain mode control register 4
        PINMODE_OD4: mmio.Mmio(packed struct(u32) {
            ///  Reserved.
            RESERVED: u28,
            ///  Port 4 pin 28 open drain mode control.
            P4_28OD: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. P4.28 pin is in the normal (not open drain) mode.
                    NORMAL = 0x0,
                    ///  Open-drain. P4.28 pin is in the open drain mode.
                    OPEN_DRAIN = 0x1,
                },
            },
            ///  Port 4 pin 29 open drain mode control, see P4.28OD
            P4_29OD: u1,
            ///  Reserved.
            RESERVED: u2,
        }),
        ///  I2C Pin Configuration register
        I2CPADCFG: mmio.Mmio(packed struct(u32) {
            ///  Drive mode control for the SDA0 pin, P0.27.
            SDADRV0: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Standard. The SDA0 pin is in the standard drive mode.
                    STANDARD = 0x0,
                    ///  Fast-mode plus. The SDA0 pin is in Fast Mode Plus drive mode.
                    FAST_MODE_PLUS = 0x1,
                },
            },
            ///  I 2C filter mode control for the SDA0 pin, P0.27.
            SDAI2C0: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Enabled. The SDA0 pin has I2C glitch filtering and slew rate control enabled.
                    ENABLED = 0x0,
                    ///  Disabled. The SDA0 pin has I2C glitch filtering and slew rate control disabled.
                    DISABLED = 0x1,
                },
            },
            ///  Drive mode control for the SCL0 pin, P0.28.
            SCLDRV0: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Standard. The SCL0 pin is in the standard drive mode.
                    STANDARD = 0x0,
                    ///  Fast-mode plus. The SCL0 pin is in Fast Mode Plus drive mode.
                    FAST_MODE_PLUS = 0x1,
                },
            },
            ///  I 2C filter mode control for the SCL0 pin, P0.28.
            SCLI2C0: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Enabled. The SCL0 pin has I2C glitch filtering and slew rate control enabled.
                    ENABLED = 0x0,
                    ///  Disabled. The SCL0 pin has I2C glitch filtering and slew rate control disabled.
                    DISABLED = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u28,
        }),
    };

    ///  SSP1 controller
    pub const SSP1 = extern struct {
        ///  Control Register 0. Selects the serial clock rate, bus type, and data size.
        CR0: mmio.Mmio(packed struct(u32) {
            ///  Data Size Select. This field controls the number of bits transferred in each frame. Values 0000-0010 are not supported and should not be used.
            DSS: packed union {
                raw: u4,
                value: enum(u4) {
                    ///  4-bit transfer
                    @"4_BIT_TRANSFER" = 0x3,
                    ///  5-bit transfer
                    @"5_BIT_TRANSFER" = 0x4,
                    ///  6-bit transfer
                    @"6_BIT_TRANSFER" = 0x5,
                    ///  7-bit transfer
                    @"7_BIT_TRANSFER" = 0x6,
                    ///  8-bit transfer
                    @"8_BIT_TRANSFER" = 0x7,
                    ///  9-bit transfer
                    @"9_BIT_TRANSFER" = 0x8,
                    ///  10-bit transfer
                    @"10_BIT_TRANSFER" = 0x9,
                    ///  11-bit transfer
                    @"11_BIT_TRANSFER" = 0xa,
                    ///  12-bit transfer
                    @"12_BIT_TRANSFER" = 0xb,
                    ///  13-bit transfer
                    @"13_BIT_TRANSFER" = 0xc,
                    ///  14-bit transfer
                    @"14_BIT_TRANSFER" = 0xd,
                    ///  15-bit transfer
                    @"15_BIT_TRANSFER" = 0xe,
                    ///  16-bit transfer
                    @"16_BIT_TRANSFER" = 0xf,
                    _,
                },
            },
            ///  Frame Format.
            FRF: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  SPI
                    SPI = 0x0,
                    ///  TI
                    TI = 0x1,
                    ///  Microwire
                    MICROWIRE = 0x2,
                    ///  This combination is not supported and should not be used.
                    THIS_COMBINATION_IS_ = 0x3,
                },
            },
            ///  Clock Out Polarity. This bit is only used in SPI mode.
            CPOL: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  SSP controller maintains the bus clock low between frames.
                    BUS_LOW = 0x0,
                    ///  SSP controller maintains the bus clock high between frames.
                    BUS_HIGH = 0x1,
                },
            },
            ///  Clock Out Phase. This bit is only used in SPI mode.
            CPHA: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  SSP controller captures serial data on the first clock transition of the frame, that is, the transition away from the inter-frame state of the clock line.
                    FIRST_CLOCK = 0x0,
                    ///  SSP controller captures serial data on the second clock transition of the frame, that is, the transition back to the inter-frame state of the clock line.
                    SECOND_CLOCK = 0x1,
                },
            },
            ///  Serial Clock Rate. The number of prescaler-output clocks per bit on the bus, minus one. Given that CPSDVSR is the prescale divider, and the APB clock PCLK clocks the prescaler, the bit frequency is PCLK / (CPSDVSR X [SCR+1]).
            SCR: u8,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u16,
        }),
        ///  Control Register 1. Selects master/slave and other modes.
        CR1: mmio.Mmio(packed struct(u32) {
            ///  Loop Back Mode.
            LBM: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  During normal operation.
                    NORMAL = 0x0,
                    ///  Serial input is taken from the serial output (MOSI or MISO) rather than the serial input pin (MISO or MOSI respectively).
                    OUPTU = 0x1,
                },
            },
            ///  SSP Enable.
            SSE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The SSP controller is disabled.
                    DISABLED = 0x0,
                    ///  The SSP controller will interact with other devices on the serial bus. Software should write the appropriate control information to the other SSP registers and interrupt controller registers, before setting this bit.
                    ENABLED = 0x1,
                },
            },
            ///  Master/Slave Mode.This bit can only be written when the SSE bit is 0.
            MS: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The SSP controller acts as a master on the bus, driving the SCLK, MOSI, and SSEL lines and receiving the MISO line.
                    MASTER = 0x0,
                    ///  The SSP controller acts as a slave on the bus, driving MISO line and receiving SCLK, MOSI, and SSEL lines.
                    SLAVE = 0x1,
                },
            },
            ///  Slave Output Disable. This bit is relevant only in slave mode (MS = 1). If it is 1, this blocks this SSP controller from driving the transmit data line (MISO).
            SOD: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u28,
        }),
        ///  Data Register. Writes fill the transmit FIFO, and reads empty the receive FIFO.
        DR: mmio.Mmio(packed struct(u32) {
            ///  Write: software can write data to be sent in a future frame to this register whenever the TNF bit in the Status register is 1, indicating that the Tx FIFO is not full. If the Tx FIFO was previously empty and the SSP controller is not busy on the bus, transmission of the data will begin immediately. Otherwise the data written to this register will be sent as soon as all previous data has been sent (and received). If the data length is less than 16 bits, software must right-justify the data written to this register. Read: software can read data from this register whenever the RNE bit in the Status register is 1, indicating that the Rx FIFO is not empty. When software reads this register, the SSP controller returns data from the least recent frame in the Rx FIFO. If the data length is less than 16 bits, the data is right-justified in this field with higher order bits filled with 0s.
            DATA: u16,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u16,
        }),
        ///  Status Register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Transmit FIFO Empty. This bit is 1 is the Transmit FIFO is empty, 0 if not.
            TFE: u1,
            ///  Transmit FIFO Not Full. This bit is 0 if the Tx FIFO is full, 1 if not.
            TNF: u1,
            ///  Receive FIFO Not Empty. This bit is 0 if the Receive FIFO is empty, 1 if not.
            RNE: u1,
            ///  Receive FIFO Full. This bit is 1 if the Receive FIFO is full, 0 if not.
            RFF: u1,
            ///  Busy. This bit is 0 if the SSPn controller is idle, or 1 if it is currently sending/receiving a frame and/or the Tx FIFO is not empty.
            BSY: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u27,
        }),
        ///  Clock Prescale Register
        CPSR: mmio.Mmio(packed struct(u32) {
            ///  This even value between 2 and 254, by which PCLK is divided to yield the prescaler output clock. Bit 0 always reads as 0.
            CPSDVSR: u8,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        ///  Interrupt Mask Set and Clear Register
        IMSC: mmio.Mmio(packed struct(u32) {
            ///  Software should set this bit to enable interrupt when a Receive Overrun occurs, that is, when the Rx FIFO is full and another frame is completely received. The ARM spec implies that the preceding frame data is overwritten by the new frame data when this occurs.
            RORIM: u1,
            ///  Software should set this bit to enable interrupt when a Receive Time-out condition occurs. A Receive Time-out occurs when the Rx FIFO is not empty, and no has not been read for a time-out period. The time-out period is the same for master and slave modes and is determined by the SSP bit rate: 32 bits at PCLK / (CPSDVSR X [SCR+1]).
            RTIM: u1,
            ///  Software should set this bit to enable interrupt when the Rx FIFO is at least half full.
            RXIM: u1,
            ///  Software should set this bit to enable interrupt when the Tx FIFO is at least half empty.
            TXIM: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u28,
        }),
        ///  Raw Interrupt Status Register
        RIS: mmio.Mmio(packed struct(u32) {
            ///  This bit is 1 if another frame was completely received while the RxFIFO was full. The ARM spec implies that the preceding frame data is overwritten by the new frame data when this occurs.
            RORRIS: u1,
            ///  This bit is 1 if the Rx FIFO is not empty, and has not been read for a time-out period. The time-out period is the same for master and slave modes and is determined by the SSP bit rate: 32 bits at PCLK / (CPSDVSR X [SCR+1]).
            RTRIS: u1,
            ///  This bit is 1 if the Rx FIFO is at least half full.
            RXRIS: u1,
            ///  This bit is 1 if the Tx FIFO is at least half empty.
            TXRIS: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u28,
        }),
        ///  Masked Interrupt Status Register
        MIS: mmio.Mmio(packed struct(u32) {
            ///  This bit is 1 if another frame was completely received while the RxFIFO was full, and this interrupt is enabled.
            RORMIS: u1,
            ///  This bit is 1 if the Rx FIFO is not empty, has not been read for a time-out period, and this interrupt is enabled. The time-out period is the same for master and slave modes and is determined by the SSP bit rate: 32 bits at PCLK / (CPSDVSR X [SCR+1]).
            RTMIS: u1,
            ///  This bit is 1 if the Rx FIFO is at least half full, and this interrupt is enabled.
            RXMIS: u1,
            ///  This bit is 1 if the Tx FIFO is at least half empty, and this interrupt is enabled.
            TXMIS: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u28,
        }),
        ///  SSPICR Interrupt Clear Register
        ICR: mmio.Mmio(packed struct(u32) {
            ///  Writing a 1 to this bit clears the frame was received when RxFIFO was full interrupt.
            RORIC: u1,
            ///  Writing a 1 to this bit clears the Rx FIFO was not empty and has not been read for a time-out period interrupt. The time-out period is the same for master and slave modes and is determined by the SSP bit rate: 32 bits at PCLK / (CPSDVSR / [SCR+1]).
            RTIC: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u30,
        }),
        ///  SSP0 DMA control register
        DMACR: mmio.Mmio(packed struct(u32) {
            ///  Receive DMA Enable. When this bit is set to one 1, DMA for the receive FIFO is enabled, otherwise receive DMA is disabled.
            RXDMAE: u1,
            ///  Transmit DMA Enable. When this bit is set to one 1, DMA for the transmit FIFO is enabled, otherwise transmit DMA is disabled
            TXDMAE: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u30,
        }),
    };

    ///  Analog-to-Digital Converter (ADC)
    pub const ADC = extern struct {
        ///  A/D Control Register. The ADCR register must be written to select the operating mode before A/D conversion can occur.
        CR: mmio.Mmio(packed struct(u32) {
            ///  Selects which of the AD0[7:0] pins is (are) to be sampled and converted. For AD0, bit 0 selects Pin AD0[0], and bit 7 selects pin AD0[7]. In software-controlled mode, only one of these bits should be 1. In hardware scan mode, any value containing 1 to 8 ones is allowed. All zeroes is equivalent to 0x01.
            SEL: u8,
            ///  The APB clock (PCLK) is divided by (this value plus one) to produce the clock for the A/D converter, which should be less than or equal to 12.4 MHz. Typically, software should program the smallest value in this field that yields a clock of 12.4 MHz or slightly less, but in certain cases (such as a high-impedance analog source) a slower clock may be desirable.
            CLKDIV: u8,
            ///  Burst mode
            BURST: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The AD converter does repeated conversions at up to 400 kHz, scanning (if necessary) through the pins selected by bits set to ones in the SEL field. The first conversion after the start corresponds to the least-significant 1 in the SEL field, then higher numbered 1-bits (pins) if applicable. Repeated conversions can be terminated by clearing this bit, but the conversion that's in progress when this bit is cleared will be completed. START bits must be 000 when BURST = 1 or conversions will not start.
                    BURST = 0x1,
                    ///  Conversions are software controlled and require 31 clocks.
                    SW = 0x0,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u4,
            ///  Power down mode
            PDN: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The A/D converter is operational.
                    POWERED = 0x1,
                    ///  The A/D converter is in power-down mode.
                    POWERDOWN = 0x0,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u2,
            ///  When the BURST bit is 0, these bits control whether and when an A/D conversion is started:
            START: packed union {
                raw: u3,
                value: enum(u3) {
                    ///  No start (this value should be used when clearing PDN to 0).
                    NO_START_THIS_VALUE = 0x0,
                    ///  Start conversion now.
                    START_CONVERSION_NOW = 0x1,
                    ///  Start conversion when the edge selected by bit 27 occurs on the P2[10] pin.
                    P2_10 = 0x2,
                    ///  Start conversion when the edge selected by bit 27 occurs on the P1[27] pin.
                    P1_27 = 0x3,
                    ///  Start conversion when the edge selected by bit 27 occurs on MAT0.1. Note that this does not require that the MAT0.1 function appear on a device pin.
                    MAT0_1 = 0x4,
                    ///  Start conversion when the edge selected by bit 27 occurs on MAT0.3. Note that it is not possible to cause the MAT0.3 function to appear on a device pin.
                    MAT0_3 = 0x5,
                    ///  Start conversion when the edge selected by bit 27 occurs on MAT1.0. Note that this does not require that the MAT1.0 function appear on a device pin.
                    MAT1_0 = 0x6,
                    ///  Start conversion when the edge selected by bit 27 occurs on MAT1.1. Note that this does not require that the MAT1.1 function appear on a device pin.
                    MAT1_1 = 0x7,
                },
            },
            ///  This bit is significant only when the START field contains 010-111. In these cases:
            EDGE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Start conversion on a falling edge on the selected CAP/MAT signal.
                    FALLLING = 0x1,
                    ///  Start conversion on a rising edge on the selected CAP/MAT signal.
                    RISING = 0x0,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u4,
        }),
        ///  A/D Global Data Register. This register contains the ADC's DONE bit and the result of the most recent A/D conversion.
        GDR: mmio.Mmio(packed struct(u32) {
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u4,
            ///  When DONE is 1, this field contains a binary fraction representing the voltage on the AD0[n] pin selected by the SEL field, as it falls within the range of VREFP to VSS. Zero in the field indicates that the voltage on the input pin was less than, equal to, or close to that on VSS, while 0xFFF indicates that the voltage on the input was close to, equal to, or greater than that on VREFP.
            RESULT: u12,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u8,
            ///  These bits contain the channel from which the RESULT bits were converted (e.g. 000 identifies channel 0, 001 channel 1...).
            CHN: u3,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u3,
            ///  This bit is 1 in burst mode if the results of one or more conversions was (were) lost and overwritten before the conversion that produced the result in the RESULT bits. This bit is cleared by reading this register.
            OVERRUN: u1,
            ///  This bit is set to 1 when an A/D conversion completes. It is cleared when this register is read and when the ADCR is written. If the ADCR is written while a conversion is still in progress, this bit is set and a new conversion is started.
            DONE: u1,
        }),
        reserved12: [4]u8,
        ///  A/D Interrupt Enable Register. This register contains enable bits that allow the DONE flag of each A/D channel to be included or excluded from contributing to the generation of an A/D interrupt.
        INTEN: mmio.Mmio(packed struct(u32) {
            ///  Interrupt enable
            ADINTEN0: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Completion of a conversion on ADC channel 0 will not generate an interrupt.
                    DISABLE = 0x0,
                    ///  Completion of a conversion on ADC channel 0 will generate an interrupt.
                    ENABLE = 0x1,
                },
            },
            ///  Interrupt enable
            ADINTEN1: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Completion of a conversion on ADC channel 1 will not generate an interrupt.
                    DISABLE = 0x0,
                    ///  Completion of a conversion on ADC channel 1 will generate an interrupt.
                    ENABLE = 0x1,
                },
            },
            ///  Interrupt enable
            ADINTEN2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Completion of a conversion on ADC channel 2 will not generate an interrupt.
                    DISABLE = 0x0,
                    ///  Completion of a conversion on ADC channel 2 will generate an interrupt.
                    ENABLE = 0x1,
                },
            },
            ///  Interrupt enable
            ADINTEN3: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Completion of a conversion on ADC channel 3 will not generate an interrupt.
                    DISABLE = 0x0,
                    ///  Completion of a conversion on ADC channel 3 will generate an interrupt.
                    ENABLE = 0x1,
                },
            },
            ///  Interrupt enable
            ADINTEN4: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Completion of a conversion on ADC channel 4 will not generate an interrupt.
                    DISABLE = 0x0,
                    ///  Completion of a conversion on ADC channel 4 will generate an interrupt.
                    ENABLE = 0x1,
                },
            },
            ///  Interrupt enable
            ADINTEN5: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Completion of a conversion on ADC channel 5 will not generate an interrupt.
                    DISABLE = 0x0,
                    ///  Completion of a conversion on ADC channel 5 will generate an interrupt.
                    ENABLE = 0x1,
                },
            },
            ///  Interrupt enable
            ADINTEN6: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Completion of a conversion on ADC channel 6 will not generate an interrupt.
                    DISABLE = 0x0,
                    ///  Completion of a conversion on ADC channel 6 will generate an interrupt.
                    ENABLE = 0x1,
                },
            },
            ///  Interrupt enable
            ADINTEN7: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Completion of a conversion on ADC channel 7 will not generate an interrupt.
                    DISABLE = 0x0,
                    ///  Completion of a conversion on ADC channel 7 will generate an interrupt.
                    ENABLE = 0x1,
                },
            },
            ///  Interrupt enable
            ADGINTEN: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Only the individual ADC channels enabled by ADINTEN7:0 will generate interrupts.
                    CHANNELS = 0x0,
                    ///  The global DONE flag in ADDR is enabled to generate an interrupt in addition to any individual ADC channels that are enabled to generate interrupts.
                    GLOBAL = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u23,
        }),
        reserved48: [32]u8,
        ///  A/D Status Register. This register contains DONE and OVERRUN flags for all of the A/D channels, as well as the A/D interrupt/DMA flag.
        STAT: mmio.Mmio(packed struct(u32) {
            ///  This bit mirrors the DONE status flag from the result register for A/D channel 0.
            DONE0: u1,
            ///  This bit mirrors the DONE status flag from the result register for A/D channel 1.
            DONE1: u1,
            ///  This bit mirrors the DONE status flag from the result register for A/D channel 2.
            DONE2: u1,
            ///  This bit mirrors the DONE status flag from the result register for A/D channel 3.
            DONE3: u1,
            ///  This bit mirrors the DONE status flag from the result register for A/D channel 4.
            DONE4: u1,
            ///  This bit mirrors the DONE status flag from the result register for A/D channel 5.
            DONE5: u1,
            ///  This bit mirrors the DONE status flag from the result register for A/D channel 6.
            DONE6: u1,
            ///  This bit mirrors the DONE status flag from the result register for A/D channel 7.
            DONE7: u1,
            ///  This bit mirrors the OVERRRUN status flag from the result register for A/D channel 0.
            OVERRUN0: u1,
            ///  This bit mirrors the OVERRRUN status flag from the result register for A/D channel 1.
            OVERRUN1: u1,
            ///  This bit mirrors the OVERRRUN status flag from the result register for A/D channel 2.
            OVERRUN2: u1,
            ///  This bit mirrors the OVERRRUN status flag from the result register for A/D channel 3.
            OVERRUN3: u1,
            ///  This bit mirrors the OVERRRUN status flag from the result register for A/D channel 4.
            OVERRUN4: u1,
            ///  This bit mirrors the OVERRRUN status flag from the result register for A/D channel 5.
            OVERRUN5: u1,
            ///  This bit mirrors the OVERRRUN status flag from the result register for A/D channel 6.
            OVERRUN6: u1,
            ///  This bit mirrors the OVERRRUN status flag from the result register for A/D channel 7.
            OVERRUN7: u1,
            ///  This bit is the A/D interrupt flag. It is one when any of the individual A/D channel Done flags is asserted and enabled to contribute to the A/D interrupt via the ADINTEN register.
            ADINT: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u15,
        }),
        ///  ADC trim register.
        TRM: mmio.Mmio(packed struct(u32) {
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u4,
            ///  Offset trim bits for ADC operation. Initialized by the boot code. Can be overwritten by the user.
            ADCOFFS: u4,
            ///  written-to by boot code. Can not be overwritten by the user. These bits are locked after boot code write.
            TRIM: u4,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u20,
        }),
    };

    ///  CAN acceptance filter RAM
    pub const CANAFRAM = struct {};

    ///  CAN controller acceptance filter
    pub const CANAF = extern struct {
        ///  Acceptance Filter Register
        AFMR: mmio.Mmio(packed struct(u32) {
            ///  if AccBP is 0, the Acceptance Filter is not operational. All Rx messages on all CAN buses are ignored.
            ACCOFF: u1,
            ///  All Rx messages are accepted on enabled CAN controllers. Software must set this bit before modifying the contents of any of the registers described below, and before modifying the contents of Lookup Table RAM in any way other than setting or clearing Disable bits in Standard Identifier entries. When both this bit and AccOff are 0, the Acceptance filter operates to screen received CAN Identifiers.
            ACCBP: u1,
            ///  FullCAN mode
            EFCAN: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Software must read all messages for all enabled IDs on all enabled CAN buses, from the receiving CAN controllers.
                    SOFTWARE_MUST_READ_A = 0x0,
                    ///  The Acceptance Filter itself will take care of receiving and storing messages for selected Standard ID values on selected CAN buses. See Section 21.16 FullCAN mode on page 576.
                    THE_ACCEPTANCE_FILTE = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u29,
        }),
        ///  Standard Frame Individual Start Address Register
        SFF_SA: mmio.Mmio(packed struct(u32) {
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u2,
            ///  The start address of the table of individual Standard Identifiers in AF Lookup RAM. If the table is empty, write the same value in this register and the SFF_GRP_sa register described below. For compatibility with possible future devices, write zeroes in bits 31:11 and 1:0 of this register. If the eFCAN bit in the AFMR is 1, this value also indicates the size of the table of Standard IDs which the Acceptance Filter will search and (if found) automatically store received messages in Acceptance Filter RAM.
            SFF_SA: u9,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u21,
        }),
        ///  Standard Frame Group Start Address Register
        SFF_GRP_SA: mmio.Mmio(packed struct(u32) {
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u2,
            ///  The start address of the table of grouped Standard Identifiers in AF Lookup RAM. If the table is empty, write the same value in this register and the EFF_sa register described below. The largest value that should be written to this register is 0x800, when only the Standard Individual table is used, and the last word (address 0x7FC) in AF Lookup Table RAM is used. For compatibility with possible future devices, please write zeroes in bits 31:12 and 1:0 of this register.
            SFF_GRP_SA: u10,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u20,
        }),
        ///  Extended Frame Start Address Register
        EFF_SA: mmio.Mmio(packed struct(u32) {
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u2,
            ///  The start address of the table of individual Extended Identifiers in AF Lookup RAM. If the table is empty, write the same value in this register and the EFF_GRP_sa register described below. The largest value that should be written to this register is 0x800, when both Extended Tables are empty and the last word (address 0x7FC) in AF Lookup Table RAM is used. For compatibility with possible future devices, please write zeroes in bits 31:11 and 1:0 of this register.
            EFF_SA: u9,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u21,
        }),
        ///  Extended Frame Group Start Address Register
        EFF_GRP_SA: mmio.Mmio(packed struct(u32) {
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u2,
            ///  The start address of the table of grouped Extended Identifiers in AF Lookup RAM. If the table is empty, write the same value in this register and the ENDofTable register described below. The largest value that should be written to this register is 0x800, when this table is empty and the last word (address 0x7FC) in AF Lookup Table RAM is used. For compatibility with possible future devices, please write zeroes in bits 31:12 and 1:0 of this register.
            EFF_GRP_SA: u10,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u20,
        }),
        ///  End of AF Tables register
        ENDOFTABLE: mmio.Mmio(packed struct(u32) {
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u2,
            ///  The address above the last active address in the last active AF table. For compatibility with possible future devices, please write zeroes in bits 31:12 and 1:0 of this register. If the eFCAN bit in the AFMR is 0, the largest value that should be written to this register is 0x800, which allows the last word (address 0x7FC) in AF Lookup Table RAM to be used. If the eFCAN bit in the AFMR is 1, this value marks the start of the area of Acceptance Filter RAM, into which the Acceptance Filter will automatically receive messages for selected IDs on selected CAN buses. In this case, the maximum value that should be written to this register is 0x800 minus 6 times the value in SFF_sa. This allows 12 bytes of message storage between this address and the end of Acceptance Filter RAM, for each Standard ID that is specified between the start of Acceptance Filter RAM, and the next active AF table.
            ENDOFTABLE: u10,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u20,
        }),
        ///  LUT Error Address register
        LUTERRAD: mmio.Mmio(packed struct(u32) {
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u2,
            ///  It the LUT Error bit (below) is 1, this read-only field contains the address in AF Lookup Table RAM, at which the Acceptance Filter encountered an error in the content of the tables.
            LUTERRAD: u9,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u21,
        }),
        ///  LUT Error Register
        LUTERR: mmio.Mmio(packed struct(u32) {
            ///  This read-only bit is set to 1 if the Acceptance Filter encounters an error in the content of the tables in AF RAM. It is cleared when software reads the LUTerrAd register. This condition is ORed with the other CAN interrupts from the CAN controllers, to produce the request that is connected to the NVIC.
            LUTERR: u1,
            ///  Reserved, the value read from a reserved bit is not defined.
            RESERVED: u31,
        }),
        ///  FullCAN interrupt enable register
        FCANIE: mmio.Mmio(packed struct(u32) {
            ///  Global FullCAN Interrupt Enable. When 1, this interrupt is enabled.
            FCANIE: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u31,
        }),
        ///  FullCAN interrupt and capture register0
        FCANIC0: mmio.Mmio(packed struct(u32) {
            ///  FullCan Interrupt Pending 0 = FullCan Interrupt Pending bit 0. 1 = FullCan Interrupt Pending bit 1. ... 31 = FullCan Interrupt Pending bit 31.
            INTPND: u32,
        }),
        ///  FullCAN interrupt and capture register1
        FCANIC1: mmio.Mmio(packed struct(u32) {
            ///  FullCan Interrupt Pending bit 32. 0 = FullCan Interrupt Pending bit 32. 1 = FullCan Interrupt Pending bit 33. ... 31 = FullCan Interrupt Pending bit 63.
            IntPnd32: u32,
        }),
    };

    ///  Central CAN controller
    pub const CCAN = extern struct {
        ///  CAN Central Transmit Status Register
        TXSR: mmio.Mmio(packed struct(u32) {
            ///  When 1, the CAN controller 1 is sending a message (same as TS in the CAN1GSR).
            TS1: u1,
            ///  When 1, the CAN controller 2 is sending a message (same as TS in the CAN2GSR)
            TS2: u1,
            ///  Reserved, the value read from a reserved bit is not defined.
            RESERVED: u6,
            ///  When 1, all 3 Tx Buffers of the CAN1 controller are available to the CPU (same as TBS in CAN1GSR).
            TBS1: u1,
            ///  When 1, all 3 Tx Buffers of the CAN2 controller are available to the CPU (same as TBS in CAN2GSR).
            TBS2: u1,
            ///  Reserved, the value read from a reserved bit is not defined.
            RESERVED: u6,
            ///  When 1, all requested transmissions have been completed successfully by the CAN1 controller (same as TCS in CAN1GSR).
            TCS1: u1,
            ///  When 1, all requested transmissions have been completed successfully by the CAN2 controller (same as TCS in CAN2GSR).
            TCS2: u1,
            ///  Reserved, the value read from a reserved bit is not defined.
            RESERVED: u14,
        }),
        ///  CAN Central Receive Status Register
        RXSR: mmio.Mmio(packed struct(u32) {
            ///  When 1, CAN1 is receiving a message (same as RS in CAN1GSR).
            RS1: u1,
            ///  When 1, CAN2 is receiving a message (same as RS in CAN2GSR).
            RS2: u1,
            ///  Reserved, the value read from a reserved bit is not defined.
            RESERVED: u6,
            ///  When 1, a received message is available in the CAN1 controller (same as RBS in CAN1GSR).
            RB1: u1,
            ///  When 1, a received message is available in the CAN2 controller (same as RBS in CAN2GSR).
            RB2: u1,
            ///  Reserved, the value read from a reserved bit is not defined.
            RESERVED: u6,
            ///  When 1, a message was lost because the preceding message to CAN1 controller was not read out quickly enough (same as DOS in CAN1GSR).
            DOS1: u1,
            ///  When 1, a message was lost because the preceding message to CAN2 controller was not read out quickly enough (same as DOS in CAN2GSR).
            DOS2: u1,
            ///  Reserved, the value read from a reserved bit is not defined.
            RESERVED: u14,
        }),
        ///  CAN Central Miscellaneous Register
        MSR: mmio.Mmio(packed struct(u32) {
            ///  When 1, one or both of the CAN1 Tx and Rx Error Counters has reached the limit set in the CAN1EWL register (same as ES in CAN1GSR)
            E1: u1,
            ///  When 1, one or both of the CAN2 Tx and Rx Error Counters has reached the limit set in the CAN2EWL register (same as ES in CAN2GSR)
            E2: u1,
            ///  Reserved, the value read from a reserved bit is not defined.
            RESERVED: u6,
            ///  When 1, the CAN1 controller is currently involved in bus activities (same as BS in CAN1GSR).
            BS1: u1,
            ///  When 1, the CAN2 controller is currently involved in bus activities (same as BS in CAN2GSR).
            BS2: u1,
            ///  Reserved, the value read from a reserved bit is not defined.
            RESERVED: u22,
        }),
    };

    ///  CAN1 controller
    pub const CAN1 = extern struct {
        ///  Controls the operating mode of the CAN Controller.
        MOD: mmio.Mmio(packed struct(u32) {
            ///  Reset Mode.
            RM: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal.The CAN Controller is in the Operating Mode, and certain registers can not be written.
                    NORMAL_THE_CAN_CONTR = 0x0,
                    ///  Reset. CAN operation is disabled, writable registers can be written and the current transmission/reception of a message is aborted.
                    RESET_CAN_OPERATION = 0x1,
                },
            },
            ///  Listen Only Mode.
            LOM: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. The CAN controller acknowledges a successfully received message on the CAN bus. The error counters are stopped at the current value.
                    NORMAL_THE_CAN_CONT = 0x0,
                    ///  Listen only. The controller gives no acknowledgment, even if a message is successfully received. Messages cannot be sent, and the controller operates in error passive mode. This mode is intended for software bit rate detection and hot plugging.
                    LISTEN_ONLY_THE_CON = 0x1,
                },
            },
            ///  Self Test Mode.
            STM: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Normal. A transmitted message must be acknowledged to be considered successful.
                    NORMAL_A_TRANSMITTE = 0x0,
                    ///  Self test. The controller will consider a Tx message successful even if there is no acknowledgment received. In this mode a full node test is possible without any other active node on the bus using the SRR bit in CANxCMR.
                    SELF_TEST_THE_CONTR = 0x1,
                },
            },
            ///  Transmit Priority Mode.
            TPM: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  CAN ID. The transmit priority for 3 Transmit Buffers depends on the CAN Identifier.
                    CAN_ID_THE_TRANSMIT = 0x0,
                    ///  Local priority. The transmit priority for 3 Transmit Buffers depends on the contents of the Tx Priority register within the Transmit Buffer.
                    LOCAL_PRIORITY_THE_ = 0x1,
                },
            },
            ///  Sleep Mode.
            SM: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Wake-up. Normal operation.
                    WAKE_UP_NORMAL_OPER = 0x0,
                    ///  Sleep. The CAN controller enters Sleep Mode if no CAN interrupt is pending and there is no bus activity. See the Sleep Mode description Section 21.8.2 on page 565.
                    SLEEP_THE_CAN_CONTR = 0x1,
                },
            },
            ///  Receive Polarity Mode.
            RPM: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Low active. RD input is active Low (dominant bit = 0).
                    LOW_ACTIVE_RD_INPUT = 0x0,
                    ///  High active. RD input is active High (dominant bit = 1) -- reverse polarity.
                    HIGH_ACTIVE_RD_INPU = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u1,
            ///  Test Mode.
            TM: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled. Normal operation.
                    DISABLED_NORMAL_OPE = 0x0,
                    ///  Enabled. The TD pin will reflect the bit, detected on RD pin, with the next positive edge of the system clock.
                    ENABLED_THE_TD_PIN_ = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        ///  Command bits that affect the state of the CAN Controller
        CMR: mmio.Mmio(packed struct(u32) {
            ///  Transmission Request.
            TR: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Absent.No transmission request.
                    ABSENT_NO_TRANSMISSI = 0x0,
                    ///  Present. The message, previously written to the CANxTFI, CANxTID, and optionally the CANxTDA and CANxTDB registers, is queued for transmission from the selected Transmit Buffer. If at two or all three of STB1, STB2 and STB3 bits are selected when TR=1 is written, Transmit Buffer will be selected based on the chosen priority scheme (for details see Section 21.5.3 Transmit Buffers (TXB))
                    PRESENT_THE_MESSAGE = 0x1,
                },
            },
            ///  Abort Transmission.
            AT: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  No action. Do not abort the transmission.
                    NO_ACTION_DO_NOT_AB = 0x0,
                    ///  Present. if not already in progress, a pending Transmission Request for the selected Transmit Buffer is cancelled.
                    PRESENT_IF_NOT_ALRE = 0x1,
                },
            },
            ///  Release Receive Buffer.
            RRB: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  No action. Do not release the receive buffer.
                    NO_ACTION_DO_NOT_RE = 0x0,
                    ///  Released. The information in the Receive Buffer (consisting of CANxRFS, CANxRID, and if applicable the CANxRDA and CANxRDB registers) is released, and becomes eligible for replacement by the next received frame. If the next received frame is not available, writing this command clears the RBS bit in the Status Register(s).
                    RELEASED_THE_INFORM = 0x1,
                },
            },
            ///  Clear Data Overrun.
            CDO: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  No action. Do not clear the data overrun bit.
                    NO_ACTION_DO_NOT_CL = 0x0,
                    ///  Clear. The Data Overrun bit in Status Register(s) is cleared.
                    CLEAR_THE_DATA_OVER = 0x1,
                },
            },
            ///  Self Reception Request.
            SRR: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Absent. No self reception request.
                    ABSENT_NO_SELF_RECE = 0x0,
                    ///  Present. The message, previously written to the CANxTFS, CANxTID, and optionally the CANxTDA and CANxTDB registers, is queued for transmission from the selected Transmit Buffer and received simultaneously. This differs from the TR bit above in that the receiver is not disabled during the transmission, so that it receives the message if its Identifier is recognized by the Acceptance Filter.
                    PRESENT_THE_MESSAGE = 0x1,
                },
            },
            ///  Select Tx Buffer 1.
            STB1: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Not selected. Tx Buffer 1 is not selected for transmission.
                    NOT_SELECTED_TX_BUF = 0x0,
                    ///  Selected. Tx Buffer 1 is selected for transmission.
                    SELECTED_TX_BUFFER_ = 0x1,
                },
            },
            ///  Select Tx Buffer 2.
            STB2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Not selected. Tx Buffer 2 is not selected for transmission.
                    NOT_SELECTED_TX_BUF = 0x0,
                    ///  Selected. Tx Buffer 2 is selected for transmission.
                    SELECTED_TX_BUFFER_ = 0x1,
                },
            },
            ///  Select Tx Buffer 3.
            STB3: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Not selected. Tx Buffer 3 is not selected for transmission.
                    NOT_SELECTED_TX_BUF = 0x0,
                    ///  Selected. Tx Buffer 3 is selected for transmission.
                    SELECTED_TX_BUFFER_ = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        ///  Global Controller Status and Error Counters. The error counters can only be written when RM in CANMOD is 1.
        GSR: mmio.Mmio(packed struct(u32) {
            ///  Receive Buffer Status. After reading all messages and releasing their memory space with the command 'Release Receive Buffer,' this bit is cleared.
            RBS: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Empty. No message is available.
                    EMPTY_NO_MESSAGE_IS = 0x0,
                    ///  Full. At least one complete message is received by the Double Receive Buffer and available in the CANxRFS, CANxRID, and if applicable the CANxRDA and CANxRDB registers. This bit is cleared by the Release Receive Buffer command in CANxCMR, if no subsequent received message is available.
                    FULL_AT_LEAST_ONE_C = 0x1,
                },
            },
            ///  Data Overrun Status. If there is not enough space to store the message within the Receive Buffer, that message is dropped and the Data Overrun condition is signalled to the CPU in the moment this message becomes valid. If this message is not completed successfully (e.g. because of an error), no overrun condition is signalled.
            DOS: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Absent. No data overrun has occurred since the last Clear Data Overrun command was given/written to CANxCMR (or since Reset).
                    ABSENT_NO_DATA_OVER = 0x0,
                    ///  Overrun. A message was lost because the preceding message to this CAN controller was not read and released quickly enough (there was not enough space for a new message in the Double Receive Buffer).
                    OVERRUN_A_MESSAGE_W = 0x1,
                },
            },
            ///  Transmit Buffer Status.
            TBS: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Locked. At least one of the Transmit Buffers is not available for the CPU, i.e. at least one previously queued message for this CAN controller has not yet been sent, and therefore software should not write to the CANxTFI, CANxTID, CANxTDA, nor CANxTDB registers of that (those) Tx buffer(s).
                    LOCKED_AT_LEAST_ONE = 0x0,
                    ///  Released. All three Transmit Buffers are available for the CPU. No transmit message is pending for this CAN controller (in any of the 3 Tx buffers), and software may write to any of the CANxTFI, CANxTID, CANxTDA, and CANxTDB registers.
                    RELEASED_ALL_THREE_ = 0x1,
                },
            },
            ///  Transmit Complete Status. The Transmission Complete Status bit is set '0' (incomplete) whenever the Transmission Request bit or the Self Reception Request bit is set '1' at least for one of the three Transmit Buffers. The Transmission Complete Status bit will remain '0' until all messages are transmitted successfully.
            TCS: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Incomplete. At least one requested transmission has not been successfully completed yet.
                    INCOMPLETE_AT_LEAST = 0x0,
                    ///  Complete. All requested transmission(s) has (have) been successfully completed.
                    COMPLETE_ALL_REQUES = 0x1,
                },
            },
            ///  Receive Status. If both the Receive Status and the Transmit Status bits are '0' (idle), the CAN-Bus is idle. If both bits are set, the controller is waiting to become idle again. After hardware reset 11 consecutive recessive bits have to be detected until idle status is reached. After Bus-off this will take 128 times of 11 consecutive recessive bits.
            RS: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Idle. The CAN controller is idle.
                    IDLE_THE_CAN_CONTRO = 0x0,
                    ///  Receive. The CAN controller is receiving a message.
                    RECEIVE_THE_CAN_CON = 0x1,
                },
            },
            ///  Transmit Status. If both the Receive Status and the Transmit Status bits are '0' (idle), the CAN-Bus is idle. If both bits are set, the controller is waiting to become idle again. After hardware reset 11 consecutive recessive bits have to be detected until idle status is reached. After Bus-off this will take 128 times of 11 consecutive recessive bits.
            TS: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Idle. The CAN controller is idle.
                    IDLE_THE_CAN_CONTRO = 0x0,
                    ///  Transmit. The CAN controller is sending a message.
                    TRANSMIT_THE_CAN_CO = 0x1,
                },
            },
            ///  Error Status. Errors detected during reception or transmission will effect the error counters according to the CAN specification. The Error Status bit is set when at least one of the error counters has reached or exceeded the Error Warning Limit. An Error Warning Interrupt is generated, if enabled. The default value of the Error Warning Limit after hardware reset is 96 decimal, see also Section 21.7.7 CAN Error Warning Limit register (CAN1EWL - 0x4004 4018, CAN2EWL - 0x4004 8018).
            ES: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  OK. Both error counters are below the Error Warning Limit.
                    OK_BOTH_ERROR_COUNT = 0x0,
                    ///  Error. One or both of the Transmit and Receive Error Counters has reached the limit set in the Error Warning Limit register.
                    ERROR_ONE_OR_BOTH_O = 0x1,
                },
            },
            ///  Bus Status. Mode bit '1' (present) and an Error Warning Interrupt is generated, if enabled. Afterwards the Transmit Error Counter is set to '127', and the Receive Error Counter is cleared. It will stay in this mode until the CPU clears the Reset Mode bit. Once this is completed the CAN Controller will wait the minimum protocol-defined time (128 occurrences of the Bus-Free signal) counting down the Transmit Error Counter. After that, the Bus Status bit is cleared (Bus-On), the Error Status bit is set '0' (ok), the Error Counters are reset, and an Error Warning Interrupt is generated, if enabled. Reading the TX Error Counter during this time gives information about the status of the Bus-Off recovery.
            BS: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Bus-on. The CAN Controller is involved in bus activities
                    BUS_ON_THE_CAN_CONT = 0x0,
                    ///  Bus-off. The CAN controller is currently not involved/prohibited from bus activity because the Transmit Error Counter reached its limiting value of 255.
                    BUS_OFF_THE_CAN_CON = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u8,
            ///  The current value of the Rx Error Counter (an 8-bit value).
            RXERR: u8,
            ///  The current value of the Tx Error Counter (an 8-bit value).
            TXERR: u8,
        }),
        ///  Interrupt status, Arbitration Lost Capture, Error Code Capture
        ICR: mmio.Mmio(packed struct(u32) {
            ///  Receive Interrupt. This bit is set whenever the RBS bit in CANxSR and the RIE bit in CANxIER are both 1, indicating that a new message was received and stored in the Receive Buffer. The Receive Interrupt Bit is not cleared upon a read access to the Interrupt Register. Giving the Command Release Receive Buffer will clear RI temporarily. If there is another message available within the Receive Buffer after the release command, RI is set again. Otherwise RI remains cleared.
            RI: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Reset
                    RESET = 0x0,
                    ///  Set
                    SET = 0x1,
                },
            },
            ///  Transmit Interrupt 1. This bit is set when the TBS1 bit in CANxSR goes from 0 to 1 (whenever a message out of TXB1 was successfully transmitted or aborted), indicating that Transmit buffer 1 is available, and the TIE1 bit in CANxIER is 1.
            TI1: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Reset
                    RESET = 0x0,
                    ///  Set
                    SET = 0x1,
                },
            },
            ///  Error Warning Interrupt. This bit is set on every change (set or clear) of either the Error Status or Bus Status bit in CANxSR and the EIE bit bit is set within the Interrupt Enable Register at the time of the change.
            EI: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Reset
                    RESET = 0x0,
                    ///  Set
                    SET = 0x1,
                },
            },
            ///  Data Overrun Interrupt. This bit is set when the DOS bit in CANxSR goes from 0 to 1 and the DOIE bit in CANxIER is 1.
            DOI: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Reset
                    RESET = 0x0,
                    ///  Set
                    SET = 0x1,
                },
            },
            ///  Wake-Up Interrupt. This bit is set if the CAN controller is sleeping and bus activity is detected and the WUIE bit in CANxIER is 1. A Wake-Up Interrupt is also generated if the CPU tries to set the Sleep bit while the CAN controller is involved in bus activities or a CAN Interrupt is pending. The WUI flag can also get asserted when the according enable bit WUIE is not set. In this case a Wake-Up Interrupt does not get asserted.
            WUI: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Reset
                    RESET = 0x0,
                    ///  Set
                    SET = 0x1,
                },
            },
            ///  Error Passive Interrupt. This bit is set if the EPIE bit in CANxIER is 1, and the CAN controller switches between Error Passive and Error Active mode in either direction. This is the case when the CAN Controller has reached the Error Passive Status (at least one error counter exceeds the CAN protocol defined level of 127) or if the CAN Controller is in Error Passive Status and enters the Error Active Status again.
            EPI: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Reset
                    RESET = 0x0,
                    ///  Set
                    SET = 0x1,
                },
            },
            ///  Arbitration Lost Interrupt. This bit is set if the ALIE bit in CANxIER is 1, and the CAN controller loses arbitration while attempting to transmit. In this case the CAN node becomes a receiver.
            ALI: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Reset
                    RESET = 0x0,
                    ///  Set
                    SET = 0x1,
                },
            },
            ///  Bus Error Interrupt -- this bit is set if the BEIE bit in CANxIER is 1, and the CAN controller detects an error on the bus.
            BEI: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Reset
                    RESET = 0x0,
                    ///  Set
                    SET = 0x1,
                },
            },
            ///  ID Ready Interrupt -- this bit is set if the IDIE bit in CANxIER is 1, and a CAN Identifier has been received (a message was successfully transmitted or aborted). This bit is set whenever a message was successfully transmitted or aborted and the IDIE bit is set in the IER register.
            IDI: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Reset
                    RESET = 0x0,
                    ///  Set
                    SET = 0x1,
                },
            },
            ///  Transmit Interrupt 2. This bit is set when the TBS2 bit in CANxSR goes from 0 to 1 (whenever a message out of TXB2 was successfully transmitted or aborted), indicating that Transmit buffer 2 is available, and the TIE2 bit in CANxIER is 1.
            TI2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Reset
                    RESET = 0x0,
                    ///  Set
                    SET = 0x1,
                },
            },
            ///  Transmit Interrupt 3. This bit is set when the TBS3 bit in CANxSR goes from 0 to 1 (whenever a message out of TXB3 was successfully transmitted or aborted), indicating that Transmit buffer 3 is available, and the TIE3 bit in CANxIER is 1.
            TI3: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Reset
                    RESET = 0x0,
                    ///  Set
                    SET = 0x1,
                },
            },
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u5,
            ///  Error Code Capture: when the CAN controller detects a bus error, the location of the error within the frame is captured in this field. The value reflects an internal state variable, and as a result is not very linear: 00011 = Start of Frame 00010 = ID28 ... ID21 00110 = ID20 ... ID18 00100 = SRTR Bit 00101 = IDE bit 00111 = ID17 ... 13 01111 = ID12 ... ID5 01110 = ID4 ... ID0 01100 = RTR Bit 01101 = Reserved Bit 1 01001 = Reserved Bit 0 01011 = Data Length Code 01010 = Data Field 01000 = CRC Sequence 11000 = CRC Delimiter 11001 = Acknowledge Slot 11011 = Acknowledge Delimiter 11010 = End of Frame 10010 = Intermission Whenever a bus error occurs, the corresponding bus error interrupt is forced, if enabled. At the same time, the current position of the Bit Stream Processor is captured into the Error Code Capture Register. The content within this register is fixed until the user software has read out its content once. From now on, the capture mechanism is activated again, i.e. reading the CANxICR enables another Bus Error Interrupt.
            ERRBIT4_0: u5,
            ///  When the CAN controller detects a bus error, the direction of the current bit is captured in this bit.
            ERRDIR: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Error occurred during transmitting.
                    ERROR_OCCURRED_DURIN = 0x0,
                    ///  Error occurred during receiving.
                    ERROR_OCCURRED_DURIN = 0x1,
                },
            },
            ///  When the CAN controller detects a bus error, the type of error is captured in this field:
            ERRC1_0: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Bit error
                    BIT_ERROR = 0x0,
                    ///  Form error
                    FORM_ERROR = 0x1,
                    ///  Stuff error
                    STUFF_ERROR = 0x2,
                    ///  Other error
                    OTHER_ERROR = 0x3,
                },
            },
            ///  Each time arbitration is lost while trying to send on the CAN, the bit number within the frame is captured into this field. After the content of ALCBIT is read, the ALI bit is cleared and a new Arbitration Lost interrupt can occur. 00 = arbitration lost in the first bit (MS) of identifier ... 11 = arbitration lost in SRTS bit (RTR bit for standard frame messages) 12 = arbitration lost in IDE bit 13 = arbitration lost in 12th bit of identifier (extended frame only) ... 30 = arbitration lost in last bit of identifier (extended frame only) 31 = arbitration lost in RTR bit (extended frame only) On arbitration lost, the corresponding arbitration lost interrupt is forced, if enabled. At that time, the current bit position of the Bit Stream Processor is captured into the Arbitration Lost Capture Register. The content within this register is fixed until the user application has read out its contents once. From now on, the capture mechanism is activated again.
            ALCBIT: u8,
        }),
        ///  Interrupt Enable
        IER: mmio.Mmio(packed struct(u32) {
            ///  Receiver Interrupt Enable. When the Receive Buffer Status is 'full', the CAN Controller requests the respective interrupt.
            RIE: u1,
            ///  Transmit Interrupt Enable for Buffer1. When a message has been successfully transmitted out of TXB1 or Transmit Buffer 1 is accessible again (e.g. after an Abort Transmission command), the CAN Controller requests the respective interrupt.
            TIE1: u1,
            ///  Error Warning Interrupt Enable. If the Error or Bus Status change (see Status Register), the CAN Controller requests the respective interrupt.
            EIE: u1,
            ///  Data Overrun Interrupt Enable. If the Data Overrun Status bit is set (see Status Register), the CAN Controller requests the respective interrupt.
            DOIE: u1,
            ///  Wake-Up Interrupt Enable. If the sleeping CAN controller wakes up, the respective interrupt is requested.
            WUIE: u1,
            ///  Error Passive Interrupt Enable. If the error status of the CAN Controller changes from error active to error passive or vice versa, the respective interrupt is requested.
            EPIE: u1,
            ///  Arbitration Lost Interrupt Enable. If the CAN Controller has lost arbitration, the respective interrupt is requested.
            ALIE: u1,
            ///  Bus Error Interrupt Enable. If a bus error has been detected, the CAN Controller requests the respective interrupt.
            BEIE: u1,
            ///  ID Ready Interrupt Enable. When a CAN identifier has been received, the CAN Controller requests the respective interrupt.
            IDIE: u1,
            ///  Transmit Interrupt Enable for Buffer2. When a message has been successfully transmitted out of TXB2 or Transmit Buffer 2 is accessible again (e.g. after an Abort Transmission command), the CAN Controller requests the respective interrupt.
            TIE2: u1,
            ///  Transmit Interrupt Enable for Buffer3. When a message has been successfully transmitted out of TXB3 or Transmit Buffer 3 is accessible again (e.g. after an Abort Transmission command), the CAN Controller requests the respective interrupt.
            TIE3: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u21,
        }),
        ///  Bus Timing. Can only be written when RM in CANMOD is 1.
        BTR: mmio.Mmio(packed struct(u32) {
            ///  Baud Rate Prescaler. The APB clock is divided by (this value plus one) to produce the CAN clock.
            BRP: u10,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u4,
            ///  The Synchronization Jump Width is (this value plus one) CAN clocks.
            SJW: u2,
            ///  The delay from the nominal Sync point to the sample point is (this value plus one) CAN clocks.
            TESG1: u4,
            ///  The delay from the sample point to the next nominal sync point is (this value plus one) CAN clocks. The nominal CAN bit time is (this value plus the value in TSEG1 plus 3) CAN clocks.
            TESG2: u3,
            ///  Sampling
            SAM: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The bus is sampled once (recommended for high speed buses)
                    THE_BUS_IS_SAMPLED_O = 0x0,
                    ///  The bus is sampled 3 times (recommended for low to medium speed buses to filter spikes on the bus-line)
                    THE_BUS_IS_SAMPLED_3 = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u8,
        }),
        ///  Error Warning Limit. Can only be written when RM in CANMOD is 1.
        EWL: mmio.Mmio(packed struct(u32) {
            ///  During CAN operation, this value is compared to both the Tx and Rx Error Counters. If either of these counter matches this value, the Error Status (ES) bit in CANSR is set.
            EWL: u8,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        ///  Status Register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Receive Buffer Status. This bit is identical to the RBS bit in the CANxGSR.
            RBS_1: u1,
            ///  Data Overrun Status. This bit is identical to the DOS bit in the CANxGSR.
            DOS_1: u1,
            ///  Transmit Buffer Status 1.
            TBS1_1: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Locked. Software cannot access the Tx Buffer 1 nor write to the corresponding CANxTFI, CANxTID, CANxTDA, and CANxTDB registers because a message is either waiting for transmission or is in transmitting process.
                    LOCKED_SOFTWARE_CAN = 0x0,
                    ///  Released. Software may write a message into the Transmit Buffer 1 and its CANxTFI, CANxTID, CANxTDA, and CANxTDB registers.
                    RELEASED_SOFTWARE_M = 0x1,
                },
            },
            ///  Transmission Complete Status.
            TCS1_1: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Incomplete. The previously requested transmission for Tx Buffer 1 is not complete.
                    INCOMPLETE_THE_PREV = 0x0,
                    ///  Complete. The previously requested transmission for Tx Buffer 1 has been successfully completed.
                    COMPLETE_THE_PREVIO = 0x1,
                },
            },
            ///  Receive Status. This bit is identical to the RS bit in the GSR.
            RS_1: u1,
            ///  Transmit Status 1.
            TS1_1: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Idle. There is no transmission from Tx Buffer 1.
                    IDLE_THERE_IS_NO_TR = 0x0,
                    ///  Transmit. The CAN Controller is transmitting a message from Tx Buffer 1.
                    TRANSMIT_THE_CAN_CO = 0x1,
                },
            },
            ///  Error Status. This bit is identical to the ES bit in the CANxGSR.
            ES_1: u1,
            ///  Bus Status. This bit is identical to the BS bit in the CANxGSR.
            BS_1: u1,
            ///  Receive Buffer Status. This bit is identical to the RBS bit in the CANxGSR.
            RBS_2: u1,
            ///  Data Overrun Status. This bit is identical to the DOS bit in the CANxGSR.
            DOS_2: u1,
            ///  Transmit Buffer Status 2.
            TBS2_2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Locked. Software cannot access the Tx Buffer 2 nor write to the corresponding CANxTFI, CANxTID, CANxTDA, and CANxTDB registers because a message is either waiting for transmission or is in transmitting process.
                    LOCKED_SOFTWARE_CAN = 0x0,
                    ///  Released. Software may write a message into the Transmit Buffer 2 and its CANxTFI, CANxTID, CANxTDA, and CANxTDB registers.
                    RELEASED_SOFTWARE_M = 0x1,
                },
            },
            ///  Transmission Complete Status.
            TCS2_2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Incomplete. The previously requested transmission for Tx Buffer 2 is not complete.
                    INCOMPLETE_THE_PREV = 0x0,
                    ///  Complete. The previously requested transmission for Tx Buffer 2 has been successfully completed.
                    COMPLETE_THE_PREVIO = 0x1,
                },
            },
            ///  Receive Status. This bit is identical to the RS bit in the GSR.
            RS_2: u1,
            ///  Transmit Status 2.
            TS2_2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Idle. There is no transmission from Tx Buffer 2.
                    IDLE_THERE_IS_NO_TR = 0x0,
                    ///  Transmit. The CAN Controller is transmitting a message from Tx Buffer 2.
                    TRANSMIT_THE_CAN_CO = 0x1,
                },
            },
            ///  Error Status. This bit is identical to the ES bit in the CANxGSR.
            ES_2: u1,
            ///  Bus Status. This bit is identical to the BS bit in the CANxGSR.
            BS_2: u1,
            ///  Receive Buffer Status. This bit is identical to the RBS bit in the CANxGSR.
            RBS_3: u1,
            ///  Data Overrun Status. This bit is identical to the DOS bit in the CANxGSR.
            DOS_3: u1,
            ///  Transmit Buffer Status 3.
            TBS3_3: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Locked. Software cannot access the Tx Buffer 3 nor write to the corresponding CANxTFI, CANxTID, CANxTDA, and CANxTDB registers because a message is either waiting for transmission or is in transmitting process.
                    LOCKED_SOFTWARE_CAN = 0x0,
                    ///  Released. Software may write a message into the Transmit Buffer 3 and its CANxTFI, CANxTID, CANxTDA, and CANxTDB registers.
                    RELEASED_SOFTWARE_M = 0x1,
                },
            },
            ///  Transmission Complete Status.
            TCS3_3: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Incomplete. The previously requested transmission for Tx Buffer 3 is not complete.
                    INCOMPLETE_THE_PREV = 0x0,
                    ///  Complete. The previously requested transmission for Tx Buffer 3 has been successfully completed.
                    COMPLETE_THE_PREVIO = 0x1,
                },
            },
            ///  Receive Status. This bit is identical to the RS bit in the GSR.
            RS_3: u1,
            ///  Transmit Status 3.
            TS3_3: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Idle. There is no transmission from Tx Buffer 3.
                    IDLE_THERE_IS_NO_TR = 0x0,
                    ///  Transmit. The CAN Controller is transmitting a message from Tx Buffer 3.
                    TRANSMIT_THE_CAN_CO = 0x1,
                },
            },
            ///  Error Status. This bit is identical to the ES bit in the CANxGSR.
            ES_3: u1,
            ///  Bus Status. This bit is identical to the BS bit in the CANxGSR.
            BS_3: u1,
            ///  Reserved, the value read from a reserved bit is not defined.
            RESERVED: u8,
        }),
        ///  Receive frame status. Can only be written when RM in CANMOD is 1.
        RFS: mmio.Mmio(packed struct(u32) {
            ///  ID Index. If the BP bit (below) is 0, this value is the zero-based number of the Lookup Table RAM entry at which the Acceptance Filter matched the received Identifier. Disabled entries in the Standard tables are included in this numbering, but will not be matched. See Section 21.17 Examples of acceptance filter tables and ID index values on page 587 for examples of ID Index values.
            IDINDEX: u10,
            ///  If this bit is 1, the current message was received in AF Bypass mode, and the ID Index field (above) is meaningless.
            BP: u1,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u5,
            ///  The field contains the Data Length Code (DLC) field of the current received message. When RTR = 0, this is related to the number of data bytes available in the CANRDA and CANRDB registers as follows: 0000-0111 = 0 to 7 bytes1000-1111 = 8 bytes With RTR = 1, this value indicates the number of data bytes requested to be sent back, with the same encoding.
            DLC: u4,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u10,
            ///  This bit contains the Remote Transmission Request bit of the current received message. 0 indicates a Data Frame, in which (if DLC is non-zero) data can be read from the CANRDA and possibly the CANRDB registers. 1 indicates a Remote frame, in which case the DLC value identifies the number of data bytes requested to be sent using the same Identifier.
            RTR: u1,
            ///  A 0 in this bit indicates that the current received message included an 11-bit Identifier, while a 1 indicates a 29-bit Identifier. This affects the contents of the CANid register described below.
            FF: u1,
        }),
        ///  Received Identifier. Can only be written when RM in CANMOD is 1.
        RID: mmio.Mmio(packed struct(u32) {
            ///  The 11-bit Identifier field of the current received message. In CAN 2.0A, these bits are called ID10-0, while in CAN 2.0B they're called ID29-18.
            ID: u11,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u21,
        }),
        ///  Received data bytes 1-4. Can only be written when RM in CANMOD is 1.
        RDA: mmio.Mmio(packed struct(u32) {
            ///  Data 1. If the DLC field in CANRFS >= 0001, this contains the first Data byte of the current received message.
            DATA1: u8,
            ///  Data 2. If the DLC field in CANRFS >= 0010, this contains the first Data byte of the current received message.
            DATA2: u8,
            ///  Data 3. If the DLC field in CANRFS >= 0011, this contains the first Data byte of the current received message.
            DATA3: u8,
            ///  Data 4. If the DLC field in CANRFS >= 0100, this contains the first Data byte of the current received message.
            DATA4: u8,
        }),
        ///  Received data bytes 5-8. Can only be written when RM in CANMOD is 1.
        RDB: mmio.Mmio(packed struct(u32) {
            ///  Data 5. If the DLC field in CANRFS >= 0101, this contains the first Data byte of the current received message.
            DATA5: u8,
            ///  Data 6. If the DLC field in CANRFS >= 0110, this contains the first Data byte of the current received message.
            DATA6: u8,
            ///  Data 7. If the DLC field in CANRFS >= 0111, this contains the first Data byte of the current received message.
            DATA7: u8,
            ///  Data 8. If the DLC field in CANRFS >= 1000, this contains the first Data byte of the current received message.
            DATA8: u8,
        }),
    };

    ///  USB device/host/OTG controller
    pub const USB = extern struct {
        reserved220: [220]u8,
        ///  USB Receive Packet Length
        RXPLEN: mmio.Mmio(packed struct(u32) {
            ///  The remaining number of bytes to be read from the currently selected endpoint's buffer. When this field decrements to 0, the RxENDPKT bit will be set in USBDevIntSt.
            PKT_LNGTH: u10,
            ///  Data valid. This bit is useful for isochronous endpoints. Non-isochronous endpoints do not raise an interrupt when an erroneous data packet is received. But invalid data packet can be produced with a bus reset. For isochronous endpoints, data transfer will happen even if an erroneous packet is received. In this case DV bit will not be set for the packet.
            DV: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Data is invalid.
                    DATA_IS_INVALID_ = 0x0,
                    ///  Data is valid.
                    DATA_IS_VALID_ = 0x1,
                },
            },
            ///  The PKT_LNGTH field is valid and the packet is ready for reading.
            PKT_RDY: u1,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u20,
        }),
        reserved256: [32]u8,
        ///  OTG Interrupt Status
        INTST: mmio.Mmio(packed struct(u32) {
            ///  Timer time-out.
            TMR: u1,
            ///  Remove pull-up. This bit is set by hardware to indicate that software needs to disable the D+ pull-up resistor.
            REMOVE_PU: u1,
            ///  HNP failed. This bit is set by hardware to indicate that the HNP switching has failed.
            HNP_FAILURE: u1,
            ///  HNP succeeded. This bit is set by hardware to indicate that the HNP switching has succeeded.
            HNP_SUCCESS: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u28,
        }),
        ///  OTG Interrupt Enable
        INTEN: mmio.Mmio(packed struct(u32) {
            ///  1 = enable the corresponding bit in the IntSt register.
            TMR_EN: u1,
            ///  1 = enable the corresponding bit in the IntSt register.
            REMOVE_PU_EN: u1,
            ///  1 = enable the corresponding bit in the IntSt register.
            HNP_FAILURE_EN: u1,
            ///  1 = enable the corresponding bit in the IntSt register.
            HNP_SUCCES_EN: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u28,
        }),
        ///  OTG Interrupt Set
        INTSET: mmio.Mmio(packed struct(u32) {
            ///  0 = no effect. 1 = set the corresponding bit in the IntSt register.
            TMR_SET: u1,
            ///  0 = no effect. 1 = set the corresponding bit in the IntSt register.
            REMOVE_PU_SET: u1,
            ///  0 = no effect. 1 = set the corresponding bit in the IntSt register.
            HNP_FAILURE_SET: u1,
            ///  0 = no effect. 1 = set the corresponding bit in the IntSt register.
            HNP_SUCCES_SET: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u28,
        }),
        ///  OTG Interrupt Clear
        INTCLR: mmio.Mmio(packed struct(u32) {
            ///  0 = no effect. 1 = clear the corresponding bit in the IntSt register.
            TMR_CLR: u1,
            ///  0 = no effect. 1 = clear the corresponding bit in the IntSt register.
            REMOVE_PU_CLR: u1,
            ///  0 = no effect. 1 = clear the corresponding bit in the IntSt register.
            HNP_FAILURE_CLR: u1,
            ///  0 = no effect. 1 = clear the corresponding bit in the IntSt register.
            HNP_SUCCES_CLR: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u28,
        }),
        ///  OTG Status and Control and USB port select
        STCTRL: mmio.Mmio(packed struct(u32) {
            ///  Controls connection of USB functions (see Figure 51). Bit 0 is set or cleared by hardware when B_HNP_TRACK or A_HNP_TRACK is set and HNP succeeds. See Section 14.9. 00: U1 = device (OTG), U2 = host 01: U1 = host (OTG), U2 = host 10: Reserved 11: U1 = host, U2 = device In a device-only configuration, the following values are allowed: 00: U1 = device. The USB device controller signals are mapped to the U1 port: USB_CONNECT1, USB_UP_LED1, USB_D+1, USB_D-1. 11: U2 = device. The USB device controller signals are mapped to the U2 port: USB_CONNECT2, USB_UP_LED2, USB_D+2, USB_D-2.
            PORT_FUNC: u2,
            ///  Timer scale selection. This field determines the duration of each timer count. 00: 10 ms (100 KHz) 01: 100 ms (10 KHz) 10: 1000 ms (1 KHz) 11: Reserved
            TMR_SCALE: u2,
            ///  Timer mode selection. 0: monoshot 1: free running
            TMR_MODE: u1,
            ///  Timer enable. When set, TMR_CNT increments. When cleared, TMR_CNT is reset to 0.
            TMR_EN: u1,
            ///  Timer reset. Writing one to this bit resets TMR_CNT to 0. This provides a single bit control for the software to restart the timer when the timer is enabled.
            TMR_RST: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u1,
            ///  Enable HNP tracking for B-device (peripheral), see Section 14.9. Hardware clears this bit when HNP_SUCCESS or HNP_FAILURE is set.
            B_HNP_TRACK: u1,
            ///  Enable HNP tracking for A-device (host), see Section 14.9. Hardware clears this bit when HNP_SUCCESS or HNP_FAILURE is set.
            A_HNP_TRACK: u1,
            ///  When the B-device changes its role from peripheral to host, software sets this bit when it removes the D+ pull-up, see Section 14.9. Hardware clears this bit when HNP_SUCCESS or HNP_FAILURE is set.
            PU_REMOVED: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u5,
            ///  Current timer count value.
            TMR_CNT: u16,
        }),
        ///  OTG Timer
        TMR: mmio.Mmio(packed struct(u32) {
            ///  The TMR interrupt is set when TMR_CNT reaches this value.
            TIMEOUT_CNT: u16,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u16,
        }),
        reserved512: [232]u8,
        ///  USB Device Interrupt Status
        DEVINTST: mmio.Mmio(packed struct(u32) {
            ///  The frame interrupt occurs every 1 ms. This is used in isochronous packet transfers.
            FRAME: u1,
            ///  Fast endpoint interrupt. If an Endpoint Interrupt Priority register (USBEpIntPri) bit is set, the corresponding endpoint interrupt will be routed to this bit.
            EP_FAST: u1,
            ///  Slow endpoints interrupt. If an Endpoint Interrupt Priority Register (USBEpIntPri) bit is not set, the corresponding endpoint interrupt will be routed to this bit.
            EP_SLOW: u1,
            ///  Set when USB Bus reset, USB suspend change or Connect change event occurs. Refer to Section 13.12.6 Set Device Status (Command: 0xFE, Data: write 1 byte) on page 366.
            DEV_STAT: u1,
            ///  The command code register (USBCmdCode) is empty (New command can be written).
            CCEMPTY: u1,
            ///  Command data register (USBCmdData) is full (Data can be read now).
            CDFULL: u1,
            ///  The current packet in the endpoint buffer is transferred to the CPU.
            RxENDPKT: u1,
            ///  The number of data bytes transferred to the endpoint buffer equals the number of bytes programmed in the TxPacket length register (USBTxPLen).
            TxENDPKT: u1,
            ///  Endpoints realized. Set when Realize Endpoint register (USBReEp) or MaxPacketSize register (USBMaxPSize) is updated and the corresponding operation is completed.
            EP_RLZED: u1,
            ///  Error Interrupt. Any bus error interrupt from the USB device. Refer to Section 13.12.9 Read Error Status (Command: 0xFB, Data: read 1 byte) on page 368
            ERR_INT: u1,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u22,
        }),
        ///  USB Device Interrupt Enable
        DEVINTEN: mmio.Mmio(packed struct(u32) {
            ///  0 = No interrupt is generated. 1 = An interrupt will be generated when the corresponding bit in the Device Interrupt Status (USBDevIntSt) register (Table 261) is set. By default, the interrupt is routed to the USB_INT_REQ_LP interrupt line. Optionally, either the EP_FAST or FRAME interrupt may be routed to the USB_INT_REQ_HP interrupt line by changing the value of USBDevIntPri.
            FRAMEEN: u1,
            ///  0 = No interrupt is generated. 1 = An interrupt will be generated when the corresponding bit in the Device Interrupt Status (USBDevIntSt) register (Table 261) is set. By default, the interrupt is routed to the USB_INT_REQ_LP interrupt line. Optionally, either the EP_FAST or FRAME interrupt may be routed to the USB_INT_REQ_HP interrupt line by changing the value of USBDevIntPri.
            EP_FASTEN: u1,
            ///  0 = No interrupt is generated. 1 = An interrupt will be generated when the corresponding bit in the Device Interrupt Status (USBDevIntSt) register (Table 261) is set. By default, the interrupt is routed to the USB_INT_REQ_LP interrupt line. Optionally, either the EP_FAST or FRAME interrupt may be routed to the USB_INT_REQ_HP interrupt line by changing the value of USBDevIntPri.
            EP_SLOWEN: u1,
            ///  0 = No interrupt is generated. 1 = An interrupt will be generated when the corresponding bit in the Device Interrupt Status (USBDevIntSt) register (Table 261) is set. By default, the interrupt is routed to the USB_INT_REQ_LP interrupt line. Optionally, either the EP_FAST or FRAME interrupt may be routed to the USB_INT_REQ_HP interrupt line by changing the value of USBDevIntPri.
            DEV_STATEN: u1,
            ///  0 = No interrupt is generated. 1 = An interrupt will be generated when the corresponding bit in the Device Interrupt Status (USBDevIntSt) register (Table 261) is set. By default, the interrupt is routed to the USB_INT_REQ_LP interrupt line. Optionally, either the EP_FAST or FRAME interrupt may be routed to the USB_INT_REQ_HP interrupt line by changing the value of USBDevIntPri.
            CCEMPTYEN: u1,
            ///  0 = No interrupt is generated. 1 = An interrupt will be generated when the corresponding bit in the Device Interrupt Status (USBDevIntSt) register (Table 261) is set. By default, the interrupt is routed to the USB_INT_REQ_LP interrupt line. Optionally, either the EP_FAST or FRAME interrupt may be routed to the USB_INT_REQ_HP interrupt line by changing the value of USBDevIntPri.
            CDFULLEN: u1,
            ///  0 = No interrupt is generated. 1 = An interrupt will be generated when the corresponding bit in the Device Interrupt Status (USBDevIntSt) register (Table 261) is set. By default, the interrupt is routed to the USB_INT_REQ_LP interrupt line. Optionally, either the EP_FAST or FRAME interrupt may be routed to the USB_INT_REQ_HP interrupt line by changing the value of USBDevIntPri.
            RxENDPKTEN: u1,
            ///  0 = No interrupt is generated. 1 = An interrupt will be generated when the corresponding bit in the Device Interrupt Status (USBDevIntSt) register (Table 261) is set. By default, the interrupt is routed to the USB_INT_REQ_LP interrupt line. Optionally, either the EP_FAST or FRAME interrupt may be routed to the USB_INT_REQ_HP interrupt line by changing the value of USBDevIntPri.
            TxENDPKTEN: u1,
            ///  0 = No interrupt is generated. 1 = An interrupt will be generated when the corresponding bit in the Device Interrupt Status (USBDevIntSt) register (Table 261) is set. By default, the interrupt is routed to the USB_INT_REQ_LP interrupt line. Optionally, either the EP_FAST or FRAME interrupt may be routed to the USB_INT_REQ_HP interrupt line by changing the value of USBDevIntPri.
            EP_RLZEDEN: u1,
            ///  0 = No interrupt is generated. 1 = An interrupt will be generated when the corresponding bit in the Device Interrupt Status (USBDevIntSt) register (Table 261) is set. By default, the interrupt is routed to the USB_INT_REQ_LP interrupt line. Optionally, either the EP_FAST or FRAME interrupt may be routed to the USB_INT_REQ_HP interrupt line by changing the value of USBDevIntPri.
            ERR_INTEN: u1,
            ///  Reserved
            RESERVED: u22,
        }),
        ///  USB Device Interrupt Clear
        DEVINTCLR: mmio.Mmio(packed struct(u32) {
            ///  0 = No effect. 1 = The corresponding bit in USBDevIntSt (Section 13.10.3.2) is cleared.
            FRAMECLR: u1,
            ///  0 = No effect. 1 = The corresponding bit in USBDevIntSt (Section 13.10.3.2) is cleared.
            EP_FASTCLR: u1,
            ///  0 = No effect. 1 = The corresponding bit in USBDevIntSt (Section 13.10.3.2) is cleared.
            EP_SLOWCLR: u1,
            ///  0 = No effect. 1 = The corresponding bit in USBDevIntSt (Section 13.10.3.2) is cleared.
            DEV_STATCLR: u1,
            ///  0 = No effect. 1 = The corresponding bit in USBDevIntSt (Section 13.10.3.2) is cleared.
            CCEMPTYCLR: u1,
            ///  0 = No effect. 1 = The corresponding bit in USBDevIntSt (Section 13.10.3.2) is cleared.
            CDFULLCLR: u1,
            ///  0 = No effect. 1 = The corresponding bit in USBDevIntSt (Section 13.10.3.2) is cleared.
            RxENDPKTCLR: u1,
            ///  0 = No effect. 1 = The corresponding bit in USBDevIntSt (Section 13.10.3.2) is cleared.
            TxENDPKTCLR: u1,
            ///  0 = No effect. 1 = The corresponding bit in USBDevIntSt (Section 13.10.3.2) is cleared.
            EP_RLZEDCLR: u1,
            ///  0 = No effect. 1 = The corresponding bit in USBDevIntSt (Section 13.10.3.2) is cleared.
            ERR_INTCLR: u1,
            ///  Reserved
            RESERVED: u22,
        }),
        ///  USB Device Interrupt Set
        DEVINTSET: mmio.Mmio(packed struct(u32) {
            ///  0 = No effect. 1 = The corresponding bit in USBDevIntSt (Section 13.10.3.2) is set.
            FRAMESET: u1,
            ///  0 = No effect. 1 = The corresponding bit in USBDevIntSt (Section 13.10.3.2) is set.
            EP_FASTSET: u1,
            ///  0 = No effect. 1 = The corresponding bit in USBDevIntSt (Section 13.10.3.2) is set.
            EP_SLOWSET: u1,
            ///  0 = No effect. 1 = The corresponding bit in USBDevIntSt (Section 13.10.3.2) is set.
            DEV_STATSET: u1,
            ///  0 = No effect. 1 = The corresponding bit in USBDevIntSt (Section 13.10.3.2) is set.
            CCEMPTYSET: u1,
            ///  0 = No effect. 1 = The corresponding bit in USBDevIntSt (Section 13.10.3.2) is set.
            CDFULLSET: u1,
            ///  0 = No effect. 1 = The corresponding bit in USBDevIntSt (Section 13.10.3.2) is set.
            RxENDPKTSET: u1,
            ///  0 = No effect. 1 = The corresponding bit in USBDevIntSt (Section 13.10.3.2) is set.
            TxENDPKTSET: u1,
            ///  0 = No effect. 1 = The corresponding bit in USBDevIntSt (Section 13.10.3.2) is set.
            EP_RLZEDSET: u1,
            ///  0 = No effect. 1 = The corresponding bit in USBDevIntSt (Section 13.10.3.2) is set.
            ERR_INTSET: u1,
            ///  Reserved
            RESERVED: u22,
        }),
        ///  USB Command Code
        CMDCODE: mmio.Mmio(packed struct(u32) {
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u8,
            ///  The command phase:
            CMD_PHASE: packed union {
                raw: u8,
                value: enum(u8) {
                    ///  Read
                    READ = 0x2,
                    ///  Write
                    WRITE = 0x1,
                    ///  Command
                    COMMAND = 0x5,
                    _,
                },
            },
            ///  This is a multi-purpose field. When CMD_PHASE is Command or Read, this field contains the code for the command (CMD_CODE). When CMD_PHASE is Write, this field contains the command write data (CMD_WDATA).
            CMD_CODE_WDATA: u8,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u8,
        }),
        ///  USB Command Data
        CMDDATA: mmio.Mmio(packed struct(u32) {
            ///  Command Read Data.
            CMD_RDATA: u8,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        ///  USB Receive Data
        RXDATA: mmio.Mmio(packed struct(u32) {
            ///  Data received.
            RX_DATA: u32,
        }),
        ///  USB Transmit Data
        TXDATA: mmio.Mmio(packed struct(u32) {
            ///  Transmit Data.
            TX_DATA: u32,
        }),
        reserved548: [4]u8,
        ///  USB Transmit Packet Length
        TXPLEN: mmio.Mmio(packed struct(u32) {
            ///  The remaining number of bytes to be written to the selected endpoint buffer. This field is decremented by 4 by hardware after each write to USBTxData. When this field decrements to 0, the TxENDPKT bit will be set in USBDevIntSt.
            PKT_LNGTH: u10,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u22,
        }),
        ///  USB Control
        CTRL: mmio.Mmio(packed struct(u32) {
            ///  Read mode control. Enables reading data from the OUT endpoint buffer for the endpoint specified in the LOG_ENDPOINT field using the USBRxData register. This bit is cleared by hardware when the last word of the current packet is read from USBRxData.
            RD_EN: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Enabled.
                    ENABLED_ = 0x1,
                },
            },
            ///  Write mode control. Enables writing data to the IN endpoint buffer for the endpoint specified in the LOG_ENDPOINT field using the USBTxData register. This bit is cleared by hardware when the number of bytes in USBTxLen have been sent.
            WR_EN: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Enabled.
                    ENABLED_ = 0x1,
                },
            },
            ///  Logical Endpoint number.
            LOG_ENDPOINT: u4,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u26,
        }),
        ///  USB Device Interrupt Priority
        DEVINTPRI: mmio.Mmio(packed struct(u32) {
            ///  Frame interrupt routing
            FRAME: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  FRAME interrupt is routed to USB_INT_REQ_LP.
                    LP = 0x0,
                    ///  FRAME interrupt is routed to USB_INT_REQ_HP.
                    HP = 0x1,
                },
            },
            ///  Fast endpoint interrupt routing
            EP_FAST: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  EP_FAST interrupt is routed to USB_INT_REQ_LP.
                    LP = 0x0,
                    ///  EP_FAST interrupt is routed to USB_INT_REQ_HP.
                    HP = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u30,
        }),
        ///  USB Endpoint Interrupt Status
        EPINTST: mmio.Mmio(packed struct(u32) {
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST0: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST1: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST2: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST3: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST4: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST5: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST6: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST7: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST8: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST9: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST10: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST11: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST12: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST13: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST14: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST15: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST16: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST17: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST18: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST19: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST20: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST21: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST22: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST23: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST24: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST25: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST26: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST27: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST28: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST29: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST30: u1,
            ///  1 = Endpoint Data Received (bits 0, 2, 4, ..., 30) or Transmitted (bits 1, 3, 5, ..., 31) Interrupt received.
            EPST31: u1,
        }),
        ///  USB Endpoint Interrupt Enable
        EPINTEN: mmio.Mmio(packed struct(u32) {
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN0: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN1: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN2: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN3: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN4: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN5: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN6: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN7: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN8: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN9: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN10: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN11: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN12: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN13: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN14: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN15: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN16: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN17: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN18: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN19: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN20: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN21: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN22: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN23: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN24: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN25: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN26: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN27: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN28: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN29: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN30: u1,
            ///  0= The corresponding bit in USBDMARSt is set when an interrupt occurs for this endpoint. 1 = The corresponding bit in USBEpIntSt is set when an interrupt occurs for this endpoint. Implies Slave mode for this endpoint.
            EPEN31: u1,
        }),
        ///  USB Endpoint Interrupt Clear
        EPINTCLR: mmio.Mmio(packed struct(u32) {
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR0: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR1: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR2: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR3: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR4: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR5: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR6: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR7: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR8: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR9: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR10: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR11: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR12: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR13: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR14: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR15: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR16: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR17: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR18: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR19: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR20: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR21: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR22: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR23: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR24: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR25: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR26: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR27: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR28: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR29: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR30: u1,
            ///  0 = No effect. 1 = Clears the corresponding bit in USBEpIntSt, by executing the SIE Select Endpoint/Clear Interrupt command for this endpoint.
            EPCLR31: u1,
        }),
        ///  USB Endpoint Interrupt Set
        EPINTSET: mmio.Mmio(packed struct(u32) {
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET0: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET1: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET2: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET3: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET4: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET5: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET6: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET7: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET8: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET9: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET10: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET11: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET12: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET13: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET14: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET15: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET16: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET17: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET18: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET19: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET20: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET21: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET22: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET23: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET24: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET25: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET26: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET27: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET28: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET29: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET30: u1,
            ///  0 = No effect. 1 = Sets the corresponding bit in USBEpIntSt.
            EPSET31: u1,
        }),
        ///  USB Endpoint Priority
        EPINTPRI: mmio.Mmio(packed struct(u32) {
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI0: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI1: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI2: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI3: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI4: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI5: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI6: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI7: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI8: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI9: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI10: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI11: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI12: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI13: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI14: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI15: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI16: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI17: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI18: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI19: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI20: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI21: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI22: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI23: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI24: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI25: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI26: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI27: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI28: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI29: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI30: u1,
            ///  0 = The corresponding interrupt is routed to the EP_SLOW bit of USBDevIntSt 1 = The corresponding interrupt is routed to the EP_FAST bit of USBDevIntSt
            EPPRI31: u1,
        }),
        ///  USB Realize Endpoint
        REEP: mmio.Mmio(packed struct(u32) {
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR0: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR1: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR2: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR3: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR4: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR5: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR6: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR7: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR8: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR9: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR10: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR11: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR12: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR13: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR14: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR15: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR16: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR17: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR18: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR19: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR20: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR21: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR22: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR23: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR24: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR25: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR26: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR27: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR28: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR29: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR30: u1,
            ///  0 = Endpoint EPxx is not realized. 1 = Endpoint EPxx is realized.
            EPR31: u1,
        }),
        ///  USB Endpoint Index
        EPIND: mmio.Mmio(packed struct(u32) {
            ///  Physical endpoint number (0-31)
            PHY_EP: u5,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u27,
        }),
        ///  USB MaxPacketSize
        MAXPSIZE: mmio.Mmio(packed struct(u32) {
            ///  The maximum packet size value.
            MPS: u10,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u22,
        }),
        ///  USB DMA Request Status
        DMARST: mmio.Mmio(packed struct(u32) {
            ///  Control endpoint OUT (DMA cannot be enabled for this endpoint and EP0 bit must be 0).
            EPRST0: u1,
            ///  Control endpoint IN (DMA cannot be enabled for this endpoint and EP1 bit must be 0).
            EPRST1: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST2: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST3: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST4: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST5: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST6: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST7: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST8: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST9: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST10: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST11: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST12: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST13: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST14: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST15: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST16: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST17: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST18: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST19: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST20: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST21: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST22: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST23: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST24: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST25: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST26: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST27: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST28: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST29: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST30: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA request. 0 = DMA not requested by endpoint xx. 1 = DMA requested by endpoint xx.
            EPRST31: u1,
        }),
        ///  USB DMA Request Clear
        DMARCLR: mmio.Mmio(packed struct(u32) {
            ///  Control endpoint OUT (DMA cannot be enabled for this endpoint and the EP0 bit must be 0).
            EPRCLR0: u1,
            ///  Control endpoint IN (DMA cannot be enabled for this endpoint and the EP1 bit must be 0).
            EPRCLR1: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR2: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR3: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR4: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR5: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR6: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR7: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR8: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR9: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR10: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR11: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR12: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR13: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR14: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR15: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR16: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR17: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR18: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR19: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR20: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR21: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR22: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR23: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR24: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR25: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR26: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR27: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR28: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR29: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR30: u1,
            ///  Clear the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Clear the corresponding bit in USBDMARSt.
            EPRCLR31: u1,
        }),
        ///  USB DMA Request Set
        DMARSET: mmio.Mmio(packed struct(u32) {
            ///  Control endpoint OUT (DMA cannot be enabled for this endpoint and the EP0 bit must be 0).
            EPRSET0: u1,
            ///  Control endpoint IN (DMA cannot be enabled for this endpoint and the EP1 bit must be 0).
            EPRSET1: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET2: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET3: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET4: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET5: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET6: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET7: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET8: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET9: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET10: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET11: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET12: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET13: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET14: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET15: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET16: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET17: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET18: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET19: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET20: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET21: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET22: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET23: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET24: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET25: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET26: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET27: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET28: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET29: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET30: u1,
            ///  Set the endpoint xx (2 <= xx <= 31) DMA request. 0 = No effect 1 = Set the corresponding bit in USBDMARSt.
            EPRSET31: u1,
        }),
        reserved640: [36]u8,
        ///  USB UDCA Head
        UDCAH: mmio.Mmio(packed struct(u32) {
            ///  Reserved. Read value is undefined, only zero should be written. The UDCA is aligned to 128-byte boundaries.
            RESERVED: u7,
            ///  Start address of the UDCA.
            UDCA_ADDR: u25,
        }),
        ///  USB Endpoint DMA Status
        EPDMAST: mmio.Mmio(packed struct(u32) {
            ///  Control endpoint OUT (DMA cannot be enabled for this endpoint and the EP0_DMA_ENABLE bit must be 0).
            EP_DMA_ST0: u1,
            ///  Control endpoint IN (DMA cannot be enabled for this endpoint and the EP1_DMA_ENABLE bit must be 0).
            EP_DMA_ST1: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST2: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST3: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST4: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST5: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST6: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST7: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST8: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST9: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST10: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST11: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST12: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST13: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST14: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST15: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST16: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST17: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST18: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST19: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST20: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST21: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST22: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST23: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST24: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST25: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST26: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST27: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST28: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST29: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST30: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA enabled bit. 0 = The DMA for endpoint EPxx is disabled. 1 = The DMA for endpoint EPxx is enabled.
            EP_DMA_ST31: u1,
        }),
        ///  USB Endpoint DMA Enable
        EPDMAEN: mmio.Mmio(packed struct(u32) {
            ///  Control endpoint OUT (DMA cannot be enabled for this endpoint and the EP0_DMA_ENABLE bit value must be 0).
            EP_DMA_EN0: u1,
            ///  Control endpoint IN (DMA cannot be enabled for this endpoint and the EP1_DMA_ENABLE bit must be 0).
            EP_DMA_EN1: u1,
            ///  Endpoint xx(2 <= xx <= 31) DMA enable control bit. 0 = No effect. 1 = Enable the DMA operation for endpoint EPxx.
            EP_DMA_EN: u30,
        }),
        ///  USB Endpoint DMA Disable
        EPDMADIS: mmio.Mmio(packed struct(u32) {
            ///  Control endpoint OUT (DMA cannot be enabled for this endpoint and the EP0_DMA_DISABLE bit value must be 0).
            EP_DMA_DIS0: u1,
            ///  Control endpoint IN (DMA cannot be enabled for this endpoint and the EP1_DMA_DISABLE bit value must be 0).
            EP_DMA_DIS1: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS2: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS3: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS4: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS5: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS6: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS7: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS8: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS9: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS10: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS11: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS12: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS13: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS14: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS15: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS16: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS17: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS18: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS19: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS20: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS21: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS22: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS23: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS24: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS25: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS26: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS27: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS28: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS29: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS30: u1,
            ///  Endpoint xx (2 <= xx <= 31) DMA disable control bit. 0 = No effect. 1 = Disable the DMA operation for endpoint EPxx.
            EP_DMA_DIS31: u1,
        }),
        ///  USB DMA Interrupt Status
        DMAINTST: mmio.Mmio(packed struct(u32) {
            ///  End of Transfer Interrupt bit.
            EOT: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  All bits in the USBEoTIntSt register are 0.
                    ALL_BITS_IN_THE_USBE = 0x0,
                    ///  At least one bit in the USBEoTIntSt is set.
                    AT_LEAST_ONE_BIT_IN_ = 0x1,
                },
            },
            ///  New DD Request Interrupt bit.
            NDDR: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  All bits in the USBNDDRIntSt register are 0.
                    ALL_BITS_IN_THE_USBN = 0x0,
                    ///  At least one bit in the USBNDDRIntSt is set.
                    AT_LEAST_ONE_BIT_IN_ = 0x1,
                },
            },
            ///  System Error Interrupt bit.
            ERR: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  All bits in the USBSysErrIntSt register are 0.
                    ALL_BITS_IN_THE_USBS = 0x0,
                    ///  At least one bit in the USBSysErrIntSt is set.
                    AT_LEAST_ONE_BIT_IN_ = 0x1,
                },
            },
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u29,
        }),
        ///  USB DMA Interrupt Enable
        DMAINTEN: mmio.Mmio(packed struct(u32) {
            ///  End of Transfer Interrupt enable bit.
            EOT: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Enabled.
                    ENABLED_ = 0x1,
                },
            },
            ///  New DD Request Interrupt enable bit.
            NDDR: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Enabled.
                    ENABLED_ = 0x1,
                },
            },
            ///  System Error Interrupt enable bit.
            ERR: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled.
                    DISABLED_ = 0x0,
                    ///  Enabled.
                    ENABLED_ = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u29,
        }),
        reserved672: [8]u8,
        ///  USB End of Transfer Interrupt Status
        EOTINTST: mmio.Mmio(packed struct(u32) {
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST0: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST1: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST2: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST3: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST4: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST5: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST6: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST7: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST8: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST9: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST10: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST11: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST12: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST13: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST14: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST15: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST16: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST17: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST18: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST19: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST20: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST21: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST22: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST23: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST24: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST25: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST26: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST27: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST28: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST29: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST30: u1,
            ///  Endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = There is no End of Transfer interrupt request for endpoint xx. 1 = There is an End of Transfer Interrupt request for endpoint xx.
            EPTXINTST31: u1,
        }),
        ///  USB End of Transfer Interrupt Clear
        EOTINTCLR: mmio.Mmio(packed struct(u32) {
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR0: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR1: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR2: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR3: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR4: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR5: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR6: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR7: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR8: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR9: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR10: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR11: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR12: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR13: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR14: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR15: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR16: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR17: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR18: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR19: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR20: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR21: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR22: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR23: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR24: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR25: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR26: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR27: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR28: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR29: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR30: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Clear the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTCLR31: u1,
        }),
        ///  USB End of Transfer Interrupt Set
        EOTINTSET: mmio.Mmio(packed struct(u32) {
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET0: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET1: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET2: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET3: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET4: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET5: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET6: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET7: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET8: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET9: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET10: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET11: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET12: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET13: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET14: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET15: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET16: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET17: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET18: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET19: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET20: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET21: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET22: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET23: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET24: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET25: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET26: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET27: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET28: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET29: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET30: u1,
            ///  Set endpoint xx (2 <= xx <= 31) End of Transfer Interrupt request. 0 = No effect. 1 = Set the EPxx End of Transfer Interrupt request in the USBEoTIntSt register.
            EPTXINTSET31: u1,
        }),
        ///  USB New DD Request Interrupt Status
        NDDRINTST: mmio.Mmio(packed struct(u32) {
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST0: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST1: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST2: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST3: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST4: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST5: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST6: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST7: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST8: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST9: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST10: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST11: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST12: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST13: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST14: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST15: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST16: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST17: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST18: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST19: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST20: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST21: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST22: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST23: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST24: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST25: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST26: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST27: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST28: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST29: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST30: u1,
            ///  Endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = There is no new DD interrupt request for endpoint xx. 1 = There is a new DD interrupt request for endpoint xx.
            EPNDDINTST31: u1,
        }),
        ///  USB New DD Request Interrupt Clear
        NDDRINTCLR: mmio.Mmio(packed struct(u32) {
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR0: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR1: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR2: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR3: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR4: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR5: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR6: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR7: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR8: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR9: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR10: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR11: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR12: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR13: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR14: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR15: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR16: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR17: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR18: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR19: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR20: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR21: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR22: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR23: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR24: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR25: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR26: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR27: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR28: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR29: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR30: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Clear the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTCLR31: u1,
        }),
        ///  USB New DD Request Interrupt Set
        NDDRINTSET: mmio.Mmio(packed struct(u32) {
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET0: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET1: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET2: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET3: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET4: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET5: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET6: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET7: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET8: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET9: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET10: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET11: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET12: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET13: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET14: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET15: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET16: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET17: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET18: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET19: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET20: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET21: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET22: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET23: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET24: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET25: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET26: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET27: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET28: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET29: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET30: u1,
            ///  Set endpoint xx (2 <= xx <= 31) new DD interrupt request. 0 = No effect. 1 = Set the EPxx new DD interrupt request in the USBNDDRIntSt register.
            EPNDDINTSET31: u1,
        }),
        ///  USB System Error Interrupt Status
        SYSERRINTST: mmio.Mmio(packed struct(u32) {
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST0: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST1: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST2: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST3: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST4: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST5: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST6: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST7: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST8: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST9: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST10: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST11: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST12: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST13: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST14: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST15: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST16: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST17: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST18: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST19: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST20: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST21: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST22: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST23: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST24: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST25: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST26: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST27: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST28: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST29: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST30: u1,
            ///  Endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = There is no System Error Interrupt request for endpoint xx. 1 = There is a System Error Interrupt request for endpoint xx.
            EPERRINTST31: u1,
        }),
        ///  USB System Error Interrupt Clear
        SYSERRINTCLR: mmio.Mmio(packed struct(u32) {
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR0: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR1: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR2: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR3: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR4: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR5: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR6: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR7: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR8: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR9: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR10: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR11: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR12: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR13: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR14: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR15: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR16: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR17: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR18: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR19: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR20: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR21: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR22: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR23: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR24: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR25: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR26: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR27: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR28: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR29: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR30: u1,
            ///  Clear endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Clear the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTCLR31: u1,
        }),
        ///  USB System Error Interrupt Set
        SYSERRINTSET: mmio.Mmio(packed struct(u32) {
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET0: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET1: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET2: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET3: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET4: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET5: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET6: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET7: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET8: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET9: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET10: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET11: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET12: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET13: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET14: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET15: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET16: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET17: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET18: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET19: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET20: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET21: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET22: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET23: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET24: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET25: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET26: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET27: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET28: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET29: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET30: u1,
            ///  Set endpoint xx (2 <= xx <= 31) System Error Interrupt request. 0 = No effect. 1 = Set the EPxx System Error Interrupt request in the USBSysErrIntSt register.
            EPERRINTSET31: u1,
        }),
        reserved768: [60]u8,
        ///  I2C Receive
        I2C_RX: mmio.Mmio(packed struct(u32) {
            ///  Receive data.
            RXDATA: u8,
            padding: u24,
        }),
        ///  I2C Status
        I2C_STS: mmio.Mmio(packed struct(u32) {
            ///  Transaction Done Interrupt. This flag is set if a transaction completes successfully. It is cleared by writing a one to bit 0 of the status register. It is unaffected by slave transactions.
            TDI: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Transaction has not completed.
                    NOT_COMPLETE = 0x0,
                    ///  Transaction completed.
                    COMPLETE = 0x1,
                },
            },
            ///  Arbitration Failure Interrupt. When transmitting, if the SDA is low when SDAOUT is high, then this I2C has lost the arbitration to another device on the bus. The Arbitration Failure bit is set when this happens. It is cleared by writing a one to bit 1 of the status register.
            AFI: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  No arbitration failure on last transmission.
                    NO_ARBITRATION_FAILU = 0x0,
                    ///  Arbitration failure occurred on last transmission.
                    ARBITRATION_FAILURE_ = 0x1,
                },
            },
            ///  No Acknowledge Interrupt. After every byte of data is sent, the transmitter expects an acknowledge from the receiver. This bit is set if the acknowledge is not received. It is cleared when a byte is written to the master TX FIFO.
            NAI: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Last transmission received an acknowledge.
                    ACKNOWLEDGE_RCVD = 0x0,
                    ///  Last transmission did not receive an acknowledge.
                    NO_ACKNOWLEDGE_RCVD = 0x1,
                },
            },
            ///  Master Data Request Interrupt. Once a transmission is started, the transmitter must have data to transmit as long as it isn't followed by a stop condition or it will hold SCL low until more data is available. The Master Data Request bit is set when the master transmitter is data-starved. If the master TX FIFO is empty and the last byte did not have a STOP condition flag, then SCL is held low until the CPU writes another byte to transmit. This bit is cleared when a byte is written to the master TX FIFO.
            DRMI: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Master transmitter does not need data.
                    BUSY = 0x0,
                    ///  Master transmitter needs data.
                    NEED_DATA = 0x1,
                },
            },
            ///  Slave Data Request Interrupt. Once a transmission is started, the transmitter must have data to transmit as long as it isn't followed by a STOP condition or it will hold SCL low until more data is available. The Slave Data Request bit is set when the slave transmitter is data-starved. If the slave TX FIFO is empty and the last byte transmitted was acknowledged, then SCL is held low until the CPU writes another byte to transmit. This bit is cleared when a byte is written to the slave Tx FIFO.
            DRSI: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Slave transmitter does not need data.
                    BUSY = 0x0,
                    ///  Slave transmitter needs data.
                    NEED_DATA = 0x1,
                },
            },
            ///  Indicates whether the bus is busy. This bit is set when a START condition has been seen. It is cleared when a STOP condition is seen..
            Active: u1,
            ///  The current value of the SCL signal.
            SCL: u1,
            ///  The current value of the SDA signal.
            SDA: u1,
            ///  Receive FIFO Full (RFF). This bit is set when the RX FIFO is full and cannot accept any more data. It is cleared when the RX FIFO is not full. If a byte arrives when the Receive FIFO is full, the SCL is held low until the CPU reads the RX FIFO and makes room for it.
            RFF: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  RX FIFO is not full
                    RX_FIFO_IS_NOT_FULL = 0x0,
                    ///  RX FIFO is full
                    RX_FIFO_IS_FULL = 0x1,
                },
            },
            ///  Receive FIFO Empty. RFE is set when the RX FIFO is empty and is cleared when the RX FIFO contains valid data.
            RFE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  RX FIFO contains data.
                    DATA = 0x0,
                    ///  RX FIFO is empty
                    EMPTY = 0x1,
                },
            },
            ///  Transmit FIFO Full. TFF is set when the TX FIFO is full and is cleared when the TX FIFO is not full.
            TFF: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  TX FIFO is not full.
                    TX_FIFO_IS_NOT_FULL_ = 0x0,
                    ///  TX FIFO is full
                    TX_FIFO_IS_FULL = 0x1,
                },
            },
            ///  Transmit FIFO Empty. TFE is set when the TX FIFO is empty and is cleared when the TX FIFO contains valid data.
            TFE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  TX FIFO contains valid data.
                    VALID_DATA = 0x0,
                    ///  TX FIFO is empty
                    EMPTY = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u20,
        }),
        ///  I2C Control
        I2C_CTL: mmio.Mmio(packed struct(u32) {
            ///  Transmit Done Interrupt Enable. This enables the TDI interrupt signalling that this I2C issued a STOP condition.
            TDIE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable the TDI interrupt.
                    DISABLE_THE_TDI_INTE = 0x0,
                    ///  Enable the TDI interrupt.
                    ENABLE_THE_TDI_INTER = 0x1,
                },
            },
            ///  Transmitter Arbitration Failure Interrupt Enable. This enables the AFI interrupt which is asserted during transmission when trying to set SDA high, but the bus is driven low by another device.
            AFIE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable the AFI.
                    DISABLE_THE_AFI_ = 0x0,
                    ///  Enable the AFI.
                    ENABLE_THE_AFI_ = 0x1,
                },
            },
            ///  Transmitter No Acknowledge Interrupt Enable. This enables the NAI interrupt signalling that transmitted byte was not acknowledged.
            NAIE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable the NAI.
                    DISABLE_THE_NAI_ = 0x0,
                    ///  Enable the NAI.
                    ENABLE_THE_NAI_ = 0x1,
                },
            },
            ///  Master Transmitter Data Request Interrupt Enable. This enables the DRMI interrupt which signals that the master transmitter has run out of data, has not issued a STOP, and is holding the SCL line low.
            DRMIE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable the DRMI interrupt.
                    DISABLE_THE_DRMI_INT = 0x0,
                    ///  Enable the DRMI interrupt.
                    ENABLE_THE_DRMI_INTE = 0x1,
                },
            },
            ///  Slave Transmitter Data Request Interrupt Enable. This enables the DRSI interrupt which signals that the slave transmitter has run out of data and the last byte was acknowledged, so the SCL line is being held low.
            DRSIE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable the DRSI interrupt.
                    DISABLE_THE_DRSI_INT = 0x0,
                    ///  Enable the DRSI interrupt.
                    ENABLE_THE_DRSI_INTE = 0x1,
                },
            },
            ///  Receive FIFO Full Interrupt Enable. This enables the Receive FIFO Full interrupt to indicate that the receive FIFO cannot accept any more data.
            REFIE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable the RFFI.
                    DISABLE_THE_RFFI_ = 0x0,
                    ///  Enable the RFFI.
                    ENABLE_THE_RFFI_ = 0x1,
                },
            },
            ///  Receive Data Available Interrupt Enable. This enables the DAI interrupt to indicate that data is available in the receive FIFO (i.e. not empty).
            RFDAIE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable the DAI.
                    DISABLE_THE_DAI_ = 0x0,
                    ///  Enable the DAI.
                    ENABLE_THE_DAI_ = 0x1,
                },
            },
            ///  Transmit FIFO Not Full Interrupt Enable. This enables the Transmit FIFO Not Full interrupt to indicate that the more data can be written to the transmit FIFO. Note that this is not full. It is intended help the CPU to write to the I2C block only when there is room in the FIFO and do this without polling the status register.
            TFFIE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable the TFFI.
                    DISABLE_THE_TFFI_ = 0x0,
                    ///  Enable the TFFI.
                    ENABLE_THE_TFFI_ = 0x1,
                },
            },
            ///  Soft reset. This is only needed in unusual circumstances. If a device issues a start condition without issuing a stop condition. A system timer may be used to reset the I2C if the bus remains busy longer than the time-out period. On a soft reset, the Tx and Rx FIFOs are flushed, I2C_STS register is cleared, and all internal state machines are reset to appear idle. The I2C_CLKHI, I2C_CLKLO and I2C_CTL (except Soft Reset Bit) are NOT modified by a soft reset.
            SRST: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  No reset.
                    NO_RESET = 0x0,
                    ///  Reset the I2C to idle state. Self clearing.
                    RESET = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u23,
        }),
        ///  I2C Clock High
        I2C_CLKHI: mmio.Mmio(packed struct(u32) {
            ///  Clock divisor high. This value is the number of 48 MHz clocks the serial clock (SCL) will be high.
            CDHI: u8,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        ///  I2C Clock Low
        I2C_CLKLO: mmio.Mmio(packed struct(u32) {
            ///  Clock divisor low. This value is the number of 48 MHz clocks the serial clock (SCL) will be low.
            CDLO: u8,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        reserved4084: [3296]u8,
        ///  USB Clock Control
        USBCLKCTRL: mmio.Mmio(packed struct(u32) {
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u1,
            ///  Device clock enable. Enables the usbclk input to the device controller
            DEV_CLK_EN: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u1,
            ///  Port select register clock enable.
            PORTSEL_CLK_EN: u1,
            ///  AHB clock enable
            AHB_CLK_EN: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u27,
        }),
        ///  USB Clock Status
        USBCLKST: mmio.Mmio(packed struct(u32) {
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u1,
            ///  Device clock on. The usbclk input to the device controller is active .
            DEV_CLK_ON: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u1,
            ///  Port select register clock on.
            PORTSEL_CLK_ON: u1,
            ///  AHB clock on.
            AHB_CLK_ON: u1,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u27,
        }),
    };

    ///  General purpose DMA controller
    pub const GPDMA = extern struct {
        ///  DMA Interrupt Status Register
        INTSTAT: mmio.Mmio(packed struct(u32) {
            ///  Status of DMA channel interrupts after masking. Each bit represents one channel: 0 - the corresponding channel has no active interrupt request. 1 - the corresponding channel does have an active interrupt request.
            INTSTAT0: u1,
            ///  Status of DMA channel interrupts after masking. Each bit represents one channel: 0 - the corresponding channel has no active interrupt request. 1 - the corresponding channel does have an active interrupt request.
            INTSTAT1: u1,
            ///  Status of DMA channel interrupts after masking. Each bit represents one channel: 0 - the corresponding channel has no active interrupt request. 1 - the corresponding channel does have an active interrupt request.
            INTSTAT2: u1,
            ///  Status of DMA channel interrupts after masking. Each bit represents one channel: 0 - the corresponding channel has no active interrupt request. 1 - the corresponding channel does have an active interrupt request.
            INTSTAT3: u1,
            ///  Status of DMA channel interrupts after masking. Each bit represents one channel: 0 - the corresponding channel has no active interrupt request. 1 - the corresponding channel does have an active interrupt request.
            INTSTAT4: u1,
            ///  Status of DMA channel interrupts after masking. Each bit represents one channel: 0 - the corresponding channel has no active interrupt request. 1 - the corresponding channel does have an active interrupt request.
            INTSTAT5: u1,
            ///  Status of DMA channel interrupts after masking. Each bit represents one channel: 0 - the corresponding channel has no active interrupt request. 1 - the corresponding channel does have an active interrupt request.
            INTSTAT6: u1,
            ///  Status of DMA channel interrupts after masking. Each bit represents one channel: 0 - the corresponding channel has no active interrupt request. 1 - the corresponding channel does have an active interrupt request.
            INTSTAT7: u1,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        ///  DMA Interrupt Terminal Count Request Status Register
        INTTCSTAT: mmio.Mmio(packed struct(u32) {
            ///  Terminal count interrupt request status for DMA channels. Each bit represents one channel: 0 - the corresponding channel has no active terminal count interrupt request. 1 - the corresponding channel does have an active terminal count interrupt request.
            INTTCSTAT0: u1,
            ///  Terminal count interrupt request status for DMA channels. Each bit represents one channel: 0 - the corresponding channel has no active terminal count interrupt request. 1 - the corresponding channel does have an active terminal count interrupt request.
            INTTCSTAT1: u1,
            ///  Terminal count interrupt request status for DMA channels. Each bit represents one channel: 0 - the corresponding channel has no active terminal count interrupt request. 1 - the corresponding channel does have an active terminal count interrupt request.
            INTTCSTAT2: u1,
            ///  Terminal count interrupt request status for DMA channels. Each bit represents one channel: 0 - the corresponding channel has no active terminal count interrupt request. 1 - the corresponding channel does have an active terminal count interrupt request.
            INTTCSTAT3: u1,
            ///  Terminal count interrupt request status for DMA channels. Each bit represents one channel: 0 - the corresponding channel has no active terminal count interrupt request. 1 - the corresponding channel does have an active terminal count interrupt request.
            INTTCSTAT4: u1,
            ///  Terminal count interrupt request status for DMA channels. Each bit represents one channel: 0 - the corresponding channel has no active terminal count interrupt request. 1 - the corresponding channel does have an active terminal count interrupt request.
            INTTCSTAT5: u1,
            ///  Terminal count interrupt request status for DMA channels. Each bit represents one channel: 0 - the corresponding channel has no active terminal count interrupt request. 1 - the corresponding channel does have an active terminal count interrupt request.
            INTTCSTAT6: u1,
            ///  Terminal count interrupt request status for DMA channels. Each bit represents one channel: 0 - the corresponding channel has no active terminal count interrupt request. 1 - the corresponding channel does have an active terminal count interrupt request.
            INTTCSTAT7: u1,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        ///  DMA Interrupt Terminal Count Request Clear Register
        INTTCCLEAR: mmio.Mmio(packed struct(u32) {
            ///  Allows clearing the Terminal count interrupt request (IntTCStat) for DMA channels. Each bit represents one channel: 0 - writing 0 has no effect. 1 - clears the corresponding channel terminal count interrupt.
            INTTCCLEAR0: u1,
            ///  Allows clearing the Terminal count interrupt request (IntTCStat) for DMA channels. Each bit represents one channel: 0 - writing 0 has no effect. 1 - clears the corresponding channel terminal count interrupt.
            INTTCCLEAR1: u1,
            ///  Allows clearing the Terminal count interrupt request (IntTCStat) for DMA channels. Each bit represents one channel: 0 - writing 0 has no effect. 1 - clears the corresponding channel terminal count interrupt.
            INTTCCLEAR2: u1,
            ///  Allows clearing the Terminal count interrupt request (IntTCStat) for DMA channels. Each bit represents one channel: 0 - writing 0 has no effect. 1 - clears the corresponding channel terminal count interrupt.
            INTTCCLEAR3: u1,
            ///  Allows clearing the Terminal count interrupt request (IntTCStat) for DMA channels. Each bit represents one channel: 0 - writing 0 has no effect. 1 - clears the corresponding channel terminal count interrupt.
            INTTCCLEAR4: u1,
            ///  Allows clearing the Terminal count interrupt request (IntTCStat) for DMA channels. Each bit represents one channel: 0 - writing 0 has no effect. 1 - clears the corresponding channel terminal count interrupt.
            INTTCCLEAR5: u1,
            ///  Allows clearing the Terminal count interrupt request (IntTCStat) for DMA channels. Each bit represents one channel: 0 - writing 0 has no effect. 1 - clears the corresponding channel terminal count interrupt.
            INTTCCLEAR6: u1,
            ///  Allows clearing the Terminal count interrupt request (IntTCStat) for DMA channels. Each bit represents one channel: 0 - writing 0 has no effect. 1 - clears the corresponding channel terminal count interrupt.
            INTTCCLEAR7: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        ///  DMA Interrupt Error Status Register
        INTERRSTAT: mmio.Mmio(packed struct(u32) {
            ///  Interrupt error status for DMA channels. Each bit represents one channel: 0 - the corresponding channel has no active error interrupt request. 1 - the corresponding channel does have an active error interrupt request.
            INTERRSTAT0: u1,
            ///  Interrupt error status for DMA channels. Each bit represents one channel: 0 - the corresponding channel has no active error interrupt request. 1 - the corresponding channel does have an active error interrupt request.
            INTERRSTAT1: u1,
            ///  Interrupt error status for DMA channels. Each bit represents one channel: 0 - the corresponding channel has no active error interrupt request. 1 - the corresponding channel does have an active error interrupt request.
            INTERRSTAT2: u1,
            ///  Interrupt error status for DMA channels. Each bit represents one channel: 0 - the corresponding channel has no active error interrupt request. 1 - the corresponding channel does have an active error interrupt request.
            INTERRSTAT3: u1,
            ///  Interrupt error status for DMA channels. Each bit represents one channel: 0 - the corresponding channel has no active error interrupt request. 1 - the corresponding channel does have an active error interrupt request.
            INTERRSTAT4: u1,
            ///  Interrupt error status for DMA channels. Each bit represents one channel: 0 - the corresponding channel has no active error interrupt request. 1 - the corresponding channel does have an active error interrupt request.
            INTERRSTAT5: u1,
            ///  Interrupt error status for DMA channels. Each bit represents one channel: 0 - the corresponding channel has no active error interrupt request. 1 - the corresponding channel does have an active error interrupt request.
            INTERRSTAT6: u1,
            ///  Interrupt error status for DMA channels. Each bit represents one channel: 0 - the corresponding channel has no active error interrupt request. 1 - the corresponding channel does have an active error interrupt request.
            INTERRSTAT7: u1,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        ///  DMA Interrupt Error Clear Register
        INTERRCLR: mmio.Mmio(packed struct(u32) {
            ///  Writing a 1 clears the error interrupt request (IntErrStat) for DMA channels. Each bit represents one channel: 0 - writing 0 has no effect. 1 - clears the corresponding channel error interrupt.
            INTERRCLR0: u1,
            ///  Writing a 1 clears the error interrupt request (IntErrStat) for DMA channels. Each bit represents one channel: 0 - writing 0 has no effect. 1 - clears the corresponding channel error interrupt.
            INTERRCLR1: u1,
            ///  Writing a 1 clears the error interrupt request (IntErrStat) for DMA channels. Each bit represents one channel: 0 - writing 0 has no effect. 1 - clears the corresponding channel error interrupt.
            INTERRCLR2: u1,
            ///  Writing a 1 clears the error interrupt request (IntErrStat) for DMA channels. Each bit represents one channel: 0 - writing 0 has no effect. 1 - clears the corresponding channel error interrupt.
            INTERRCLR3: u1,
            ///  Writing a 1 clears the error interrupt request (IntErrStat) for DMA channels. Each bit represents one channel: 0 - writing 0 has no effect. 1 - clears the corresponding channel error interrupt.
            INTERRCLR4: u1,
            ///  Writing a 1 clears the error interrupt request (IntErrStat) for DMA channels. Each bit represents one channel: 0 - writing 0 has no effect. 1 - clears the corresponding channel error interrupt.
            INTERRCLR5: u1,
            ///  Writing a 1 clears the error interrupt request (IntErrStat) for DMA channels. Each bit represents one channel: 0 - writing 0 has no effect. 1 - clears the corresponding channel error interrupt.
            INTERRCLR6: u1,
            ///  Writing a 1 clears the error interrupt request (IntErrStat) for DMA channels. Each bit represents one channel: 0 - writing 0 has no effect. 1 - clears the corresponding channel error interrupt.
            INTERRCLR7: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        ///  DMA Raw Interrupt Terminal Count Status Register
        RAWINTTCSTAT: mmio.Mmio(packed struct(u32) {
            ///  Status of the terminal count interrupt for DMA channels prior to masking. Each bit represents one channel: 0 - the corresponding channel has no active terminal count interrupt request. 1 - the corresponding channel does have an active terminal count interrupt request.
            RAWINTTCSTAT0: u1,
            ///  Status of the terminal count interrupt for DMA channels prior to masking. Each bit represents one channel: 0 - the corresponding channel has no active terminal count interrupt request. 1 - the corresponding channel does have an active terminal count interrupt request.
            RAWINTTCSTAT1: u1,
            ///  Status of the terminal count interrupt for DMA channels prior to masking. Each bit represents one channel: 0 - the corresponding channel has no active terminal count interrupt request. 1 - the corresponding channel does have an active terminal count interrupt request.
            RAWINTTCSTAT2: u1,
            ///  Status of the terminal count interrupt for DMA channels prior to masking. Each bit represents one channel: 0 - the corresponding channel has no active terminal count interrupt request. 1 - the corresponding channel does have an active terminal count interrupt request.
            RAWINTTCSTAT3: u1,
            ///  Status of the terminal count interrupt for DMA channels prior to masking. Each bit represents one channel: 0 - the corresponding channel has no active terminal count interrupt request. 1 - the corresponding channel does have an active terminal count interrupt request.
            RAWINTTCSTAT4: u1,
            ///  Status of the terminal count interrupt for DMA channels prior to masking. Each bit represents one channel: 0 - the corresponding channel has no active terminal count interrupt request. 1 - the corresponding channel does have an active terminal count interrupt request.
            RAWINTTCSTAT5: u1,
            ///  Status of the terminal count interrupt for DMA channels prior to masking. Each bit represents one channel: 0 - the corresponding channel has no active terminal count interrupt request. 1 - the corresponding channel does have an active terminal count interrupt request.
            RAWINTTCSTAT6: u1,
            ///  Status of the terminal count interrupt for DMA channels prior to masking. Each bit represents one channel: 0 - the corresponding channel has no active terminal count interrupt request. 1 - the corresponding channel does have an active terminal count interrupt request.
            RAWINTTCSTAT7: u1,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        ///  DMA Raw Error Interrupt Status Register
        RAWINTERRSTAT: mmio.Mmio(packed struct(u32) {
            ///  Status of the error interrupt for DMA channels prior to masking. Each bit represents one channel: 0 - the corresponding channel has no active error interrupt request. 1 - the corresponding channel does have an active error interrupt request.
            RAWINTERRSTAT0: u1,
            ///  Status of the error interrupt for DMA channels prior to masking. Each bit represents one channel: 0 - the corresponding channel has no active error interrupt request. 1 - the corresponding channel does have an active error interrupt request.
            RAWINTERRSTAT1: u1,
            ///  Status of the error interrupt for DMA channels prior to masking. Each bit represents one channel: 0 - the corresponding channel has no active error interrupt request. 1 - the corresponding channel does have an active error interrupt request.
            RAWINTERRSTAT2: u1,
            ///  Status of the error interrupt for DMA channels prior to masking. Each bit represents one channel: 0 - the corresponding channel has no active error interrupt request. 1 - the corresponding channel does have an active error interrupt request.
            RAWINTERRSTAT3: u1,
            ///  Status of the error interrupt for DMA channels prior to masking. Each bit represents one channel: 0 - the corresponding channel has no active error interrupt request. 1 - the corresponding channel does have an active error interrupt request.
            RAWINTERRSTAT4: u1,
            ///  Status of the error interrupt for DMA channels prior to masking. Each bit represents one channel: 0 - the corresponding channel has no active error interrupt request. 1 - the corresponding channel does have an active error interrupt request.
            RAWINTERRSTAT5: u1,
            ///  Status of the error interrupt for DMA channels prior to masking. Each bit represents one channel: 0 - the corresponding channel has no active error interrupt request. 1 - the corresponding channel does have an active error interrupt request.
            RAWINTERRSTAT6: u1,
            ///  Status of the error interrupt for DMA channels prior to masking. Each bit represents one channel: 0 - the corresponding channel has no active error interrupt request. 1 - the corresponding channel does have an active error interrupt request.
            RAWINTERRSTAT7: u1,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        ///  DMA Enabled Channel Register
        ENBLDCHNS: mmio.Mmio(packed struct(u32) {
            ///  Enable status for DMA channels. Each bit represents one channel: 0 - DMA channel is disabled. 1 - DMA channel is enabled.
            ENABLEDCHANNELS0: u1,
            ///  Enable status for DMA channels. Each bit represents one channel: 0 - DMA channel is disabled. 1 - DMA channel is enabled.
            ENABLEDCHANNELS1: u1,
            ///  Enable status for DMA channels. Each bit represents one channel: 0 - DMA channel is disabled. 1 - DMA channel is enabled.
            ENABLEDCHANNELS2: u1,
            ///  Enable status for DMA channels. Each bit represents one channel: 0 - DMA channel is disabled. 1 - DMA channel is enabled.
            ENABLEDCHANNELS3: u1,
            ///  Enable status for DMA channels. Each bit represents one channel: 0 - DMA channel is disabled. 1 - DMA channel is enabled.
            ENABLEDCHANNELS4: u1,
            ///  Enable status for DMA channels. Each bit represents one channel: 0 - DMA channel is disabled. 1 - DMA channel is enabled.
            ENABLEDCHANNELS5: u1,
            ///  Enable status for DMA channels. Each bit represents one channel: 0 - DMA channel is disabled. 1 - DMA channel is enabled.
            ENABLEDCHANNELS6: u1,
            ///  Enable status for DMA channels. Each bit represents one channel: 0 - DMA channel is disabled. 1 - DMA channel is enabled.
            ENABLEDCHANNELS7: u1,
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        ///  DMA Software Burst Request Register
        SOFTBREQ: mmio.Mmio(packed struct(u32) {
            ///  Software burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral Description (refer to Table 672 for peripheral hardware connections to the DMA controller): 0 - writing 0 has no effect. 1 - writing 1 generates a DMA burst request for the corresponding request line.
            SOFTBREQ0: u1,
            ///  Software burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral Description (refer to Table 672 for peripheral hardware connections to the DMA controller): 0 - writing 0 has no effect. 1 - writing 1 generates a DMA burst request for the corresponding request line.
            SOFTBREQ1: u1,
            ///  Software burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral Description (refer to Table 672 for peripheral hardware connections to the DMA controller): 0 - writing 0 has no effect. 1 - writing 1 generates a DMA burst request for the corresponding request line.
            SOFTBREQ2: u1,
            ///  Software burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral Description (refer to Table 672 for peripheral hardware connections to the DMA controller): 0 - writing 0 has no effect. 1 - writing 1 generates a DMA burst request for the corresponding request line.
            SOFTBREQ3: u1,
            ///  Software burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral Description (refer to Table 672 for peripheral hardware connections to the DMA controller): 0 - writing 0 has no effect. 1 - writing 1 generates a DMA burst request for the corresponding request line.
            SOFTBREQ4: u1,
            ///  Software burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral Description (refer to Table 672 for peripheral hardware connections to the DMA controller): 0 - writing 0 has no effect. 1 - writing 1 generates a DMA burst request for the corresponding request line.
            SOFTBREQ5: u1,
            ///  Software burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral Description (refer to Table 672 for peripheral hardware connections to the DMA controller): 0 - writing 0 has no effect. 1 - writing 1 generates a DMA burst request for the corresponding request line.
            SOFTBREQ6: u1,
            ///  Software burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral Description (refer to Table 672 for peripheral hardware connections to the DMA controller): 0 - writing 0 has no effect. 1 - writing 1 generates a DMA burst request for the corresponding request line.
            SOFTBREQ7: u1,
            ///  Software burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral Description (refer to Table 672 for peripheral hardware connections to the DMA controller): 0 - writing 0 has no effect. 1 - writing 1 generates a DMA burst request for the corresponding request line.
            SOFTBREQ8: u1,
            ///  Software burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral Description (refer to Table 672 for peripheral hardware connections to the DMA controller): 0 - writing 0 has no effect. 1 - writing 1 generates a DMA burst request for the corresponding request line.
            SOFTBREQ9: u1,
            ///  Software burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral Description (refer to Table 672 for peripheral hardware connections to the DMA controller): 0 - writing 0 has no effect. 1 - writing 1 generates a DMA burst request for the corresponding request line.
            SOFTBREQ10: u1,
            ///  Software burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral Description (refer to Table 672 for peripheral hardware connections to the DMA controller): 0 - writing 0 has no effect. 1 - writing 1 generates a DMA burst request for the corresponding request line.
            SOFTBREQ11: u1,
            ///  Software burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral Description (refer to Table 672 for peripheral hardware connections to the DMA controller): 0 - writing 0 has no effect. 1 - writing 1 generates a DMA burst request for the corresponding request line.
            SOFTBREQ12: u1,
            ///  Software burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral Description (refer to Table 672 for peripheral hardware connections to the DMA controller): 0 - writing 0 has no effect. 1 - writing 1 generates a DMA burst request for the corresponding request line.
            SOFTBREQ13: u1,
            ///  Software burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral Description (refer to Table 672 for peripheral hardware connections to the DMA controller): 0 - writing 0 has no effect. 1 - writing 1 generates a DMA burst request for the corresponding request line.
            SOFTBREQ14: u1,
            ///  Software burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral Description (refer to Table 672 for peripheral hardware connections to the DMA controller): 0 - writing 0 has no effect. 1 - writing 1 generates a DMA burst request for the corresponding request line.
            SOFTBREQ15: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u16,
        }),
        ///  DMA Software Single Request Register
        SOFTSREQ: mmio.Mmio(packed struct(u32) {
            ///  Software single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA single transfer request for the corresponding request line.
            SOFTSREQ0: u1,
            ///  Software single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA single transfer request for the corresponding request line.
            SOFTSREQ1: u1,
            ///  Software single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA single transfer request for the corresponding request line.
            SOFTSREQ2: u1,
            ///  Software single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA single transfer request for the corresponding request line.
            SOFTSREQ3: u1,
            ///  Software single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA single transfer request for the corresponding request line.
            SOFTSREQ4: u1,
            ///  Software single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA single transfer request for the corresponding request line.
            SOFTSREQ5: u1,
            ///  Software single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA single transfer request for the corresponding request line.
            SOFTSREQ6: u1,
            ///  Software single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA single transfer request for the corresponding request line.
            SOFTSREQ7: u1,
            ///  Software single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA single transfer request for the corresponding request line.
            SOFTSREQ8: u1,
            ///  Software single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA single transfer request for the corresponding request line.
            SOFTSREQ9: u1,
            ///  Software single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA single transfer request for the corresponding request line.
            SOFTSREQ10: u1,
            ///  Software single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA single transfer request for the corresponding request line.
            SOFTSREQ11: u1,
            ///  Software single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA single transfer request for the corresponding request line.
            SOFTSREQ12: u1,
            ///  Software single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA single transfer request for the corresponding request line.
            SOFTSREQ13: u1,
            ///  Software single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA single transfer request for the corresponding request line.
            SOFTSREQ14: u1,
            ///  Software single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA single transfer request for the corresponding request line.
            SOFTSREQ15: u1,
            ///  Reserved. Read undefined. Write reserved bits as zero.
            RESERVED: u16,
        }),
        ///  DMA Software Last Burst Request Register
        SOFTLBREQ: mmio.Mmio(packed struct(u32) {
            ///  Software last burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last burst request for the corresponding request line.
            SOFTLBREQ0: u1,
            ///  Software last burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last burst request for the corresponding request line.
            SOFTLBREQ1: u1,
            ///  Software last burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last burst request for the corresponding request line.
            SOFTLBREQ2: u1,
            ///  Software last burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last burst request for the corresponding request line.
            SOFTLBREQ3: u1,
            ///  Software last burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last burst request for the corresponding request line.
            SOFTLBREQ4: u1,
            ///  Software last burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last burst request for the corresponding request line.
            SOFTLBREQ5: u1,
            ///  Software last burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last burst request for the corresponding request line.
            SOFTLBREQ6: u1,
            ///  Software last burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last burst request for the corresponding request line.
            SOFTLBREQ7: u1,
            ///  Software last burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last burst request for the corresponding request line.
            SOFTLBREQ8: u1,
            ///  Software last burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last burst request for the corresponding request line.
            SOFTLBREQ9: u1,
            ///  Software last burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last burst request for the corresponding request line.
            SOFTLBREQ10: u1,
            ///  Software last burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last burst request for the corresponding request line.
            SOFTLBREQ11: u1,
            ///  Software last burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last burst request for the corresponding request line.
            SOFTLBREQ12: u1,
            ///  Software last burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last burst request for the corresponding request line.
            SOFTLBREQ13: u1,
            ///  Software last burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last burst request for the corresponding request line.
            SOFTLBREQ14: u1,
            ///  Software last burst request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last burst request for the corresponding request line.
            SOFTLBREQ15: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u16,
        }),
        ///  DMA Software Last Single Request Register
        SOFTLSREQ: mmio.Mmio(packed struct(u32) {
            ///  Software last single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last single transfer request for the corresponding request line.
            SOFTLSREQ0: u1,
            ///  Software last single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last single transfer request for the corresponding request line.
            SOFTLSREQ1: u1,
            ///  Software last single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last single transfer request for the corresponding request line.
            SOFTLSREQ2: u1,
            ///  Software last single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last single transfer request for the corresponding request line.
            SOFTLSREQ3: u1,
            ///  Software last single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last single transfer request for the corresponding request line.
            SOFTLSREQ4: u1,
            ///  Software last single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last single transfer request for the corresponding request line.
            SOFTLSREQ5: u1,
            ///  Software last single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last single transfer request for the corresponding request line.
            SOFTLSREQ6: u1,
            ///  Software last single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last single transfer request for the corresponding request line.
            SOFTLSREQ7: u1,
            ///  Software last single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last single transfer request for the corresponding request line.
            SOFTLSREQ8: u1,
            ///  Software last single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last single transfer request for the corresponding request line.
            SOFTLSREQ9: u1,
            ///  Software last single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last single transfer request for the corresponding request line.
            SOFTLSREQ10: u1,
            ///  Software last single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last single transfer request for the corresponding request line.
            SOFTLSREQ11: u1,
            ///  Software last single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last single transfer request for the corresponding request line.
            SOFTLSREQ12: u1,
            ///  Software last single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last single transfer request for the corresponding request line.
            SOFTLSREQ13: u1,
            ///  Software last single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last single transfer request for the corresponding request line.
            SOFTLSREQ14: u1,
            ///  Software last single transfer request flags for each of 16 possible sources. Each bit represents one DMA request line or peripheral function: 0 - writing 0 has no effect. 1 - writing 1 generates a DMA last single transfer request for the corresponding request line.
            SOFTLSREQ15: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u16,
        }),
        ///  DMA Configuration Register
        CONFIG: mmio.Mmio(packed struct(u32) {
            ///  DMA Controller enable: 0 = disabled (default). Disabling the DMA Controller reduces power consumption. 1 = enabled.
            E: u1,
            ///  AHB Master endianness configuration: 0 = little-endian mode (default). 1 = big-endian mode.
            M: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u30,
        }),
        ///  DMA Synchronization Register
        SYNC: mmio.Mmio(packed struct(u32) {
            ///  Controls the synchronization logic for DMA request signals. Each bit represents one set of DMA request lines as described in the preceding text: 0 - synchronization logic for the corresponding DMA request signals are enabled. 1 - synchronization logic for the corresponding DMA request signals are disabled.
            DMACSYNC0: u1,
            ///  Controls the synchronization logic for DMA request signals. Each bit represents one set of DMA request lines as described in the preceding text: 0 - synchronization logic for the corresponding DMA request signals are enabled. 1 - synchronization logic for the corresponding DMA request signals are disabled.
            DMACSYNC1: u1,
            ///  Controls the synchronization logic for DMA request signals. Each bit represents one set of DMA request lines as described in the preceding text: 0 - synchronization logic for the corresponding DMA request signals are enabled. 1 - synchronization logic for the corresponding DMA request signals are disabled.
            DMACSYNC2: u1,
            ///  Controls the synchronization logic for DMA request signals. Each bit represents one set of DMA request lines as described in the preceding text: 0 - synchronization logic for the corresponding DMA request signals are enabled. 1 - synchronization logic for the corresponding DMA request signals are disabled.
            DMACSYNC3: u1,
            ///  Controls the synchronization logic for DMA request signals. Each bit represents one set of DMA request lines as described in the preceding text: 0 - synchronization logic for the corresponding DMA request signals are enabled. 1 - synchronization logic for the corresponding DMA request signals are disabled.
            DMACSYNC4: u1,
            ///  Controls the synchronization logic for DMA request signals. Each bit represents one set of DMA request lines as described in the preceding text: 0 - synchronization logic for the corresponding DMA request signals are enabled. 1 - synchronization logic for the corresponding DMA request signals are disabled.
            DMACSYNC5: u1,
            ///  Controls the synchronization logic for DMA request signals. Each bit represents one set of DMA request lines as described in the preceding text: 0 - synchronization logic for the corresponding DMA request signals are enabled. 1 - synchronization logic for the corresponding DMA request signals are disabled.
            DMACSYNC6: u1,
            ///  Controls the synchronization logic for DMA request signals. Each bit represents one set of DMA request lines as described in the preceding text: 0 - synchronization logic for the corresponding DMA request signals are enabled. 1 - synchronization logic for the corresponding DMA request signals are disabled.
            DMACSYNC7: u1,
            ///  Controls the synchronization logic for DMA request signals. Each bit represents one set of DMA request lines as described in the preceding text: 0 - synchronization logic for the corresponding DMA request signals are enabled. 1 - synchronization logic for the corresponding DMA request signals are disabled.
            DMACSYNC8: u1,
            ///  Controls the synchronization logic for DMA request signals. Each bit represents one set of DMA request lines as described in the preceding text: 0 - synchronization logic for the corresponding DMA request signals are enabled. 1 - synchronization logic for the corresponding DMA request signals are disabled.
            DMACSYNC9: u1,
            ///  Controls the synchronization logic for DMA request signals. Each bit represents one set of DMA request lines as described in the preceding text: 0 - synchronization logic for the corresponding DMA request signals are enabled. 1 - synchronization logic for the corresponding DMA request signals are disabled.
            DMACSYNC10: u1,
            ///  Controls the synchronization logic for DMA request signals. Each bit represents one set of DMA request lines as described in the preceding text: 0 - synchronization logic for the corresponding DMA request signals are enabled. 1 - synchronization logic for the corresponding DMA request signals are disabled.
            DMACSYNC11: u1,
            ///  Controls the synchronization logic for DMA request signals. Each bit represents one set of DMA request lines as described in the preceding text: 0 - synchronization logic for the corresponding DMA request signals are enabled. 1 - synchronization logic for the corresponding DMA request signals are disabled.
            DMACSYNC12: u1,
            ///  Controls the synchronization logic for DMA request signals. Each bit represents one set of DMA request lines as described in the preceding text: 0 - synchronization logic for the corresponding DMA request signals are enabled. 1 - synchronization logic for the corresponding DMA request signals are disabled.
            DMACSYNC13: u1,
            ///  Controls the synchronization logic for DMA request signals. Each bit represents one set of DMA request lines as described in the preceding text: 0 - synchronization logic for the corresponding DMA request signals are enabled. 1 - synchronization logic for the corresponding DMA request signals are disabled.
            DMACSYNC14: u1,
            ///  Controls the synchronization logic for DMA request signals. Each bit represents one set of DMA request lines as described in the preceding text: 0 - synchronization logic for the corresponding DMA request signals are enabled. 1 - synchronization logic for the corresponding DMA request signals are disabled.
            DMACSYNC15: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u16,
        }),
    };

    ///  Ethernet
    pub const EMAC = extern struct {
        ///  MAC configuration register 1.
        MAC1: mmio.Mmio(packed struct(u32) {
            ///  RECEIVE ENABLE. Set this to allow receive frames to be received. Internally the MAC synchronizes this control bit to the incoming receive stream.
            RXENABLE: u1,
            ///  PASS ALL RECEIVE FRAMES. When enabled (set to 1), the MAC will pass all frames regardless of type (normal vs. Control). When disabled, the MAC does not pass valid Control frames.
            PARF: u1,
            ///  RX FLOW CONTROL. When enabled (set to 1), the MAC acts upon received PAUSE Flow Control frames. When disabled, received PAUSE Flow Control frames are ignored.
            RXFLOWCTRL: u1,
            ///  TX FLOW CONTROL. When enabled (set to 1), PAUSE Flow Control frames are allowed to be transmitted. When disabled, Flow Control frames are blocked.
            TXFLOWCTRL: u1,
            ///  Setting this bit will cause the MAC Transmit interface to be looped back to the MAC Receive interface. Clearing this bit results in normal operation.
            LOOPBACK: u1,
            ///  Unused
            RESERVED: u3,
            ///  Setting this bit will put the Transmit Function logic in reset.
            RESETTX: u1,
            ///  Setting this bit resets the MAC Control Sublayer / Transmit logic. The MCS logic implements flow control.
            RESETMCSTX: u1,
            ///  Setting this bit will put the Ethernet receive logic in reset.
            RESETRX: u1,
            ///  Setting this bit resets the MAC Control Sublayer / Receive logic. The MCS logic implements flow control.
            RESETMCSRX: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u2,
            ///  SIMULATION RESET. Setting this bit will cause a reset to the random number generator within the Transmit Function.
            SIMRESET: u1,
            ///  SOFT RESET. Setting this bit will put all modules within the MAC in reset except the Host Interface.
            SOFTRESET: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u16,
        }),
        ///  MAC configuration register 2.
        MAC2: mmio.Mmio(packed struct(u32) {
            ///  When enabled (set to 1), the MAC operates in Full-Duplex mode. When disabled, the MAC operates in Half-Duplex mode.
            FULLDUPLEX: u1,
            ///  FRAMELENGTH CHECKING. When enabled (set to 1), both transmit and receive frame lengths are compared to the Length/Type field. If the Length/Type field represents a length then the check is performed. Mismatches are reported in the StatusInfo word for each received frame.
            FLC: u1,
            ///  HUGE FRAME ENABLEWhen enabled (set to 1), frames of any length are transmitted and received.
            HFEN: u1,
            ///  DELAYED CRC. This bit determines the number of bytes, if any, of proprietary header information that exist on the front of IEEE 802.3 frames. When 1, four bytes of header (ignored by the CRC function) are added. When 0, there is no proprietary header.
            DELAYEDCRC: u1,
            ///  CRC ENABLESet this bit to append a CRC to every frame whether padding was required or not. Must be set if PAD/CRC ENABLE is set. Clear this bit if frames presented to the MAC contain a CRC.
            CRCEN: u1,
            ///  PAD CRC ENABLE. Set this bit to have the MAC pad all short frames. Clear this bit if frames presented to the MAC have a valid length. This bit is used in conjunction with AUTO PAD ENABLE and VLAN PAD ENABLE. See Table 153 - Pad Operation for details on the pad function.
            PADCRCEN: u1,
            ///  VLAN PAD ENABLE. Set this bit to cause the MAC to pad all short frames to 64 bytes and append a valid CRC. Consult Table 153 - Pad Operation for more information on the various padding features. Note: This bit is ignored if PAD / CRC ENABLE is cleared.
            VLANPADEN: u1,
            ///  AUTODETECTPAD ENABLE. Set this bit to cause the MAC to automatically detect the type of frame, either tagged or un-tagged, by comparing the two octets following the source address with 0x8100 (VLAN Protocol ID) and pad accordingly. Table 153 - Pad Operation provides a description of the pad function based on the configuration of this register. Note: This bit is ignored if PAD / CRC ENABLE is cleared.
            AUTODETPADEN: u1,
            ///  PURE PREAMBLE ENFORCEMEN. When enabled (set to 1), the MAC will verify the content of the preamble to ensure it contains 0x55 and is error-free. A packet with an incorrect preamble is discarded. When disabled, no preamble checking is performed.
            PPENF: u1,
            ///  LONG PREAMBLE ENFORCEMENT. When enabled (set to 1), the MAC only allows receive packets which contain preamble fields less than 12 bytes in length. When disabled, the MAC allows any length preamble as per the Standard.
            LPENF: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u2,
            ///  When enabled (set to 1), the MAC will immediately retransmit following a collision rather than using the Binary Exponential Backoff algorithm as specified in the Standard.
            NOBACKOFF: u1,
            ///  BACK PRESSURE / NO BACKOFF. When enabled (set to 1), after the MAC incidentally causes a collision during back pressure, it will immediately retransmit without backoff, reducing the chance of further collisions and ensuring transmit packets get sent.
            BP_NOBACKOFF: u1,
            ///  When enabled (set to 1) the MAC will defer to carrier indefinitely as per the Standard. When disabled, the MAC will abort when the excessive deferral limit is reached.
            EXCESSDEFER: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u17,
        }),
        ///  Back-to-Back Inter-Packet-Gap register.
        IPGT: mmio.Mmio(packed struct(u32) {
            ///  BACK-TO-BACK INTER-PACKET-GAP.This is a programmable field representing the nibble time offset of the minimum possible period between the end of any transmitted packet to the beginning of the next. In Full-Duplex mode, the register value should be the desired period in nibble times minus 3. In Half-Duplex mode, the register value should be the desired period in nibble times minus 6. In Full-Duplex the recommended setting is 0x15 (21d), which represents the minimum IPG of 960 ns (in 100 Mbps mode) or 9.6 us (in 10 Mbps mode). In Half-Duplex the recommended setting is 0x12 (18d), which also represents the minimum IPG of 960 ns (in 100 Mbps mode) or 9.6 us (in 10 Mbps mode).
            BTOBINTEGAP: u7,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u25,
        }),
        ///  Non Back-to-Back Inter-Packet-Gap register.
        IPGR: mmio.Mmio(packed struct(u32) {
            ///  NON-BACK-TO-BACK INTER-PACKET-GAP PART2. This is a programmable field representing the Non-Back-to-Back Inter-Packet-Gap. The recommended value is 0x12 (18d), which represents the minimum IPG of 960 ns (in 100 Mbps mode) or 9.6 us (in 10 Mbps mode).
            NBTOBINTEGAP2: u7,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u1,
            ///  NON-BACK-TO-BACK INTER-PACKET-GAP PART1. This is a programmable field representing the optional carrierSense window referenced in IEEE 802.3/4.2.3.2.1 'Carrier Deference'. If carrier is detected during the timing of IPGR1, the MAC defers to carrier. If, however, carrier becomes active after IPGR1, the MAC continues timing IPGR2 and transmits, knowingly causing a collision, thus ensuring fair access to medium. Its range of values is 0x0 to IPGR2. The recommended value is 0xC (12d)
            NBTOBINTEGAP1: u7,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u17,
        }),
        ///  Collision window / Retry register.
        CLRT: mmio.Mmio(packed struct(u32) {
            ///  RETRANSMISSION MAXIMUM.This is a programmable field specifying the number of retransmission attempts following a collision before aborting the packet due to excessive collisions. The Standard specifies the attemptLimit to be 0xF (15d). See IEEE 802.3/4.2.3.2.5.
            RETRANSMAX: u4,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u4,
            ///  COLLISION WINDOW. This is a programmable field representing the slot time or collision window during which collisions occur in properly configured networks. The default value of 0x37 (55d) represents a 56 byte window following the preamble and SFD.
            COLLWIN: u6,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u18,
        }),
        ///  Maximum Frame register.
        MAXF: mmio.Mmio(packed struct(u32) {
            ///  MAXIMUM FRAME LENGTH. This field resets to the value 0x0600, which represents a maximum receive frame of 1536 octets. An untagged maximum size Ethernet frame is 1518 octets. A tagged frame adds four octets for a total of 1522 octets. If a shorter maximum length restriction is desired, program this 16-bit field.
            MAXFLEN: u16,
            ///  Unused
            RESERVED: u16,
        }),
        ///  PHY Support register.
        SUPP: mmio.Mmio(packed struct(u32) {
            ///  Unused
            RESERVED: u8,
            ///  This bit configures the Reduced MII logic for the current operating speed. When set, 100 Mbps mode is selected. When cleared, 10 Mbps mode is selected.
            SPEED: u1,
            ///  Unused
            RESERVED: u23,
        }),
        ///  Test register.
        TEST: mmio.Mmio(packed struct(u32) {
            ///  SHORTCUT PAUSE QUANTA. This bit reduces the effective PAUSE quanta from 64 byte-times to 1 byte-time.
            SCPQ: u1,
            ///  This bit causes the MAC Control sublayer to inhibit transmissions, just as if a PAUSE Receive Control frame with a nonzero pause time parameter was received.
            TESTPAUSE: u1,
            ///  TEST BACKPRESSURE. Setting this bit will cause the MAC to assert backpressure on the link. Backpressure causes preamble to be transmitted, raising carrier sense. A transmit packet from the system will be sent during backpressure.
            TESTBP: u1,
            ///  Unused
            RESERVED: u29,
        }),
        ///  MII Mgmt Configuration register.
        MCFG: mmio.Mmio(packed struct(u32) {
            ///  SCAN INCREMENT. Set this bit to cause the MII Management hardware to perform read cycles across a range of PHYs. When set, the MII Management hardware will perform read cycles from address 1 through the value set in PHY ADDRESS[4:0]. Clear this bit to allow continuous reads of the same PHY.
            SCANINC: u1,
            ///  SUPPRESS PREAMBLE. Set this bit to cause the MII Management hardware to perform read/write cycles without the 32-bit preamble field. Clear this bit to cause normal cycles to be performed. Some PHYs support suppressed preamble.
            SUPPPREAMBLE: u1,
            ///  CLOCK SELECT. This field is used by the clock divide logic in creating the MII Management Clock (MDC) which IEEE 802.3u defines to be no faster than 2.5 MHz. Some PHYs support clock rates up to 12.5 MHz, however. The AHB bus clock (HCLK) is divided by the specified amount. Refer to Table 160 below for the definition of values for this field.
            CLOCKSEL: u4,
            ///  Unused
            RESERVED: u9,
            ///  RESET MII MGMT. This bit resets the MII Management hardware.
            RESETMIIMGMT: u1,
            ///  Unused
            RESERVED: u16,
        }),
        ///  MII Mgmt Command register.
        MCMD: mmio.Mmio(packed struct(u32) {
            ///  This bit causes the MII Management hardware to perform a single Read cycle. The Read data is returned in Register MRDD (MII Mgmt Read Data).
            READ: u1,
            ///  This bit causes the MII Management hardware to perform Read cycles continuously. This is useful for monitoring Link Fail for example.
            SCAN: u1,
            ///  Unused
            RESERVED: u30,
        }),
        ///  MII Mgmt Address register.
        MADR: mmio.Mmio(packed struct(u32) {
            ///  REGISTER ADDRESS. This field represents the 5-bit Register Address field of Mgmt cycles. Up to 32 registers can be accessed.
            REGADDR: u5,
            ///  Unused
            RESERVED: u3,
            ///  PHY ADDRESS. This field represents the 5-bit PHY Address field of Mgmt cycles. Up to 31 PHYs can be addressed (0 is reserved).
            PHYADDR: u5,
            ///  Unused
            RESERVED: u19,
        }),
        ///  MII Mgmt Write Data register.
        MWTD: mmio.Mmio(packed struct(u32) {
            ///  WRITE DATA. When written, an MII Mgmt write cycle is performed using the 16-bit data and the pre-configured PHY and Register addresses from the MII Mgmt Address register (MADR).
            WRITEDATA: u16,
            ///  Unused
            RESERVED: u16,
        }),
        ///  MII Mgmt Read Data register.
        MRDD: mmio.Mmio(packed struct(u32) {
            ///  READ DATA. Following an MII Mgmt Read Cycle, the 16-bit data can be read from this location.
            READDATA: u16,
            ///  Unused
            RESERVED: u16,
        }),
        ///  MII Mgmt Indicators register.
        MIND: mmio.Mmio(packed struct(u32) {
            ///  When 1 is returned - indicates MII Mgmt is currently performing an MII Mgmt Read or Write cycle.
            BUSY: u1,
            ///  When 1 is returned - indicates a scan operation (continuous MII Mgmt Read cycles) is in progress.
            SCANNING: u1,
            ///  When 1 is returned - indicates MII Mgmt Read cycle has not completed and the Read Data is not yet valid.
            NOTVALID: u1,
            ///  When 1 is returned - indicates that an MII Mgmt link fail has occurred.
            MIILINKFAIL: u1,
            ///  Unused
            RESERVED: u28,
        }),
        reserved64: [8]u8,
        ///  Station Address 0 register.
        SA0: mmio.Mmio(packed struct(u32) {
            ///  STATION ADDRESS, 2nd octet. This field holds the second octet of the station address.
            SADDR2: u8,
            ///  STATION ADDRESS, 1st octet. This field holds the first octet of the station address.
            SADDR1: u8,
            ///  Unused
            RESERVED: u16,
        }),
        ///  Station Address 1 register.
        SA1: mmio.Mmio(packed struct(u32) {
            ///  STATION ADDRESS, 4th octet. This field holds the fourth octet of the station address.
            SADDR4: u8,
            ///  STATION ADDRESS, 3rd octet. This field holds the third octet of the station address.
            SADDR3: u8,
            ///  Unused
            RESERVED: u16,
        }),
        ///  Station Address 2 register.
        SA2: mmio.Mmio(packed struct(u32) {
            ///  STATION ADDRESS, 6th octet. This field holds the sixth octet of the station address.
            SADDR6: u8,
            ///  STATION ADDRESS, 5th octet. This field holds the fifth octet of the station address.
            SADDR5: u8,
            ///  Unused
            RESERVED: u16,
        }),
        reserved256: [180]u8,
        ///  Command register.
        COMMAND: mmio.Mmio(packed struct(u32) {
            ///  Enable receive.
            RXENABLE: u1,
            ///  Enable transmit.
            TXENABLE: u1,
            ///  Unused
            RESERVED: u1,
            ///  When a 1 is written, all datapaths and the host registers are reset. The MAC needs to be reset separately.
            REGRESET: u1,
            ///  When a 1 is written, the transmit datapath is reset.
            TXRESET: u1,
            ///  When a 1 is written, the receive datapath is reset.
            RXRESET: u1,
            ///  When set to 1 , passes runt frames s1maller than 64 bytes to memory unless they have a CRC error. If 0 runt frames are filtered out.
            PASSRUNTFRAME: u1,
            ///  When set to 1 , disables receive filtering i.e. all frames received are written to memory.
            PASSRXFILTER: u1,
            ///  Enable IEEE 802.3 / clause 31 flow control sending pause frames in full duplex and continuous preamble in half duplex.
            TXFLOWCONTROL: u1,
            ///  When set to 1 , RMII mode is selected; if 0, MII mode is selected.
            RMII: u1,
            ///  When set to 1 , indicates full duplex operation.
            FULLDUPLEX: u1,
            ///  Unused
            RESERVED: u21,
        }),
        ///  Status register.
        STATUS: mmio.Mmio(packed struct(u32) {
            ///  If 1, the receive channel is active. If 0, the receive channel is inactive.
            RXSTATUS: u1,
            ///  If 1, the transmit channel is active. If 0, the transmit channel is inactive.
            TXSTATUS: u1,
            ///  Unused
            RESERVED: u30,
        }),
        ///  Receive descriptor base address register.
        RXDESCRIPTOR: mmio.Mmio(packed struct(u32) {
            ///  Fixed to 00
            RESERVED: u2,
            ///  MSBs of receive descriptor base address.
            RXDESCRIPTOR: u30,
        }),
        ///  Receive status base address register.
        RXSTATUS: mmio.Mmio(packed struct(u32) {
            ///  Fixed to 000
            RESERVED: u3,
            ///  MSBs of receive status base address.
            RXSTATUS: u29,
        }),
        ///  Receive number of descriptors register.
        RXDESCRIPTORNUMBER: mmio.Mmio(packed struct(u32) {
            ///  RxDescriptorNumber. Number of descriptors in the descriptor array for which RxDescriptor is the base address. The number of descriptors is minus one encoded.
            RXDESCRIPTORN: u16,
            ///  Unused
            RESERVED: u16,
        }),
        ///  Receive produce index register.
        RXPRODUCEINDEX: mmio.Mmio(packed struct(u32) {
            ///  Index of the descriptor that is going to be filled next by the receive datapath.
            RXPRODUCEIX: u16,
            ///  Unused
            RESERVED: u16,
        }),
        ///  Receive consume index register.
        RXCONSUMEINDEX: mmio.Mmio(packed struct(u32) {
            ///  Index of the descriptor that is going to be processed next by the receive
            RXCONSUMEIX: u16,
            ///  Unused
            RESERVED: u16,
        }),
        ///  Transmit descriptor base address register.
        TXDESCRIPTOR: mmio.Mmio(packed struct(u32) {
            ///  Fixed to 00
            RESERVED: u2,
            ///  TxDescriptor. MSBs of transmit descriptor base address.
            TXD: u30,
        }),
        ///  Transmit status base address register.
        TXSTATUS: mmio.Mmio(packed struct(u32) {
            ///  Fixed to 00
            RESERVED: u2,
            ///  TxStatus. MSBs of transmit status base address.
            TXSTAT: u30,
        }),
        ///  Transmit number of descriptors register.
        TXDESCRIPTORNUMBER: mmio.Mmio(packed struct(u32) {
            ///  TxDescriptorNumber. Number of descriptors in the descriptor array for which TxDescriptor is the base address. The register is minus one encoded.
            TXDN: u16,
            ///  Unused
            RESERVED: u16,
        }),
        ///  Transmit produce index register.
        TXPRODUCEINDEX: mmio.Mmio(packed struct(u32) {
            ///  TxProduceIndex. Index of the descriptor that is going to be filled next by the transmit software driver.
            TXPI: u16,
            ///  Unused
            RESERVED: u16,
        }),
        ///  Transmit consume index register.
        TXCONSUMEINDEX: mmio.Mmio(packed struct(u32) {
            ///  TxConsumeIndex. Index of the descriptor that is going to be transmitted next by the transmit datapath.
            TXCI: u16,
            ///  Unused
            RESERVED: u16,
        }),
        reserved344: [40]u8,
        ///  Transmit status vector 0 register.
        TSV0: mmio.Mmio(packed struct(u32) {
            ///  CRC error. The attached CRC in the packet did not match the internally generated CRC.
            CRCERR: u1,
            ///  Length check error. Indicates the frame length field does not match the actual number of data items and is not a type field.
            LCE: u1,
            ///  Length out of range. Indicates that frame type/length field was larger than 1500 bytes. The EMAC doesn't distinguish the frame type and frame length, so, e.g. when the IP(0x8000) or ARP(0x0806) packets are received, it compares the frame type with the max length and gives the "Length out of range" error. In fact, this bit is not an error indication, but simply a statement by the chip regarding the status of the received frame.
            LOR: u1,
            ///  Transmission of packet was completed.
            DONE: u1,
            ///  Packet's destination was a multicast address.
            MULTICAST: u1,
            ///  Packet's destination was a broadcast address.
            BROADCAST: u1,
            ///  Packet was deferred for at least one attempt, but less than an excessive defer.
            PACKETDEFER: u1,
            ///  Excessive Defer. Packet was deferred in excess of 6071 nibble times in 100 Mbps or 24287 bit times in 10 Mbps mode.
            EXDF: u1,
            ///  Excessive Collision. Packet was aborted due to exceeding of maximum allowed number of collisions.
            EXCOL: u1,
            ///  Late Collision. Collision occurred beyond collision window, 512 bit times.
            LCOL: u1,
            ///  Byte count in frame was greater than can be represented in the transmit byte count field in TSV1.
            GIANT: u1,
            ///  Host side caused buffer underrun.
            UNDERRUN: u1,
            ///  The total number of bytes transferred including collided attempts.
            TOTALBYTES: u16,
            ///  The frame was a control frame.
            CONTROLFRAME: u1,
            ///  The frame was a control frame with a valid PAUSE opcode.
            PAUSE: u1,
            ///  Carrier-sense method backpressure was previously applied.
            BACKPRESSURE: u1,
            ///  Frame's length/type field contained 0x8100 which is the VLAN protocol identifier.
            VLAN: u1,
        }),
        ///  Transmit status vector 1 register.
        TSV1: mmio.Mmio(packed struct(u32) {
            ///  Transmit byte count. The total number of bytes in the frame, not counting the collided bytes.
            TBC: u16,
            ///  Transmit collision count. Number of collisions the current packet incurred during transmission attempts. The maximum number of collisions (16) cannot be represented.
            TCC: u4,
            ///  Unused
            RESERVED: u12,
        }),
        ///  Receive status vector register.
        RSV: mmio.Mmio(packed struct(u32) {
            ///  Received byte count. Indicates length of received frame.
            RBC: u16,
            ///  Packet previously ignored. Indicates that a packet was dropped.
            PPI: u1,
            ///  RXDV event previously seen. Indicates that the last receive event seen was not long enough to be a valid packet.
            RXDVSEEN: u1,
            ///  Carrier event previously seen. Indicates that at some time since the last receive statistics, a carrier event was detected.
            CESEEN: u1,
            ///  Receive code violation. Indicates that received PHY data does not represent a valid receive code.
            RCV: u1,
            ///  CRC error. The attached CRC in the packet did not match the internally generated CRC.
            CRCERR: u1,
            ///  Length check error. Indicates the frame length field does not match the actual number of data items and is not a type field.
            LCERR: u1,
            ///  Length out of range. Indicates that frame type/length field was larger than 1518 bytes. The EMAC doesn't distinguish the frame type and frame length, so, e.g. when the IP(0x8000) or ARP(0x0806) packets are received, it compares the frame type with the max length and gives the "Length out of range" error. In fact, this bit is not an error indication, but simply a statement by the chip regarding the status of the received frame.
            LOR: u1,
            ///  Receive OK. The packet had valid CRC and no symbol errors.
            ROK: u1,
            ///  The packet destination was a multicast address.
            MULTICAST: u1,
            ///  The packet destination was a broadcast address.
            BROADCAST: u1,
            ///  Indicates that after the end of packet another 1-7 bits were received. A single nibble, called dribble nibble, is formed but not sent out.
            DRIBBLENIBBLE: u1,
            ///  The frame was a control frame.
            CONTROLFRAME: u1,
            ///  The frame was a control frame with a valid PAUSE opcode.
            PAUSE: u1,
            ///  Unsupported Opcode. The current frame was recognized as a Control Frame but contains an unknown opcode.
            UO: u1,
            ///  Frame's length/type field contained 0x8100 which is the VLAN protocol identifier.
            VLAN: u1,
            ///  Unused
            RESERVED: u1,
        }),
        reserved368: [12]u8,
        ///  Flow control counter register.
        FLOWCONTROLCOUNTER: mmio.Mmio(packed struct(u32) {
            ///  MirrorCounter. In full duplex mode the MirrorCounter specifies the number of cycles before re-issuing the Pause control frame.
            MC: u16,
            ///  PauseTimer. In full-duplex mode the PauseTimer specifies the value that is inserted into the pause timer field of a pause flow control frame. In half duplex mode the PauseTimer specifies the number of backpressure cycles.
            PT: u16,
        }),
        ///  Flow control status register.
        FLOWCONTROLSTATUS: mmio.Mmio(packed struct(u32) {
            ///  MirrorCounterCurrent. In full duplex mode this register represents the current value of the datapath's mirror counter which counts up to the value specified by the MirrorCounter field in the FlowControlCounter register. In half duplex mode the register counts until it reaches the value of the PauseTimer bits in the FlowControlCounter register.
            MCC: u16,
            ///  Unused
            RESERVED: u16,
        }),
        reserved512: [136]u8,
        ///  Receive filter control register.
        RXFILTERCTRL: mmio.Mmio(packed struct(u32) {
            ///  AcceptUnicastEn. When set to 1, all unicast frames are accepted.
            AUE: u1,
            ///  AcceptBroadcastEn. When set to 1, all broadcast frames are accepted.
            ABE: u1,
            ///  AcceptMulticastEn. When set to 1, all multicast frames are accepted.
            AME: u1,
            ///  AcceptUnicastHashEn. When set to 1, unicast frames that pass the imperfect hash filter are accepted.
            AUHE: u1,
            ///  AcceptMulticastHashEn. When set to 1, multicast frames that pass the imperfect hash filter are accepted.
            AMHE: u1,
            ///  AcceptPerfectEn. When set to 1, the frames with a destination address identical to the station address are accepted.
            APE: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u6,
            ///  MagicPacketEnWoL. When set to 1, the result of the magic packet filter will generate a WoL interrupt when there is a match.
            MPEW: u1,
            ///  RxFilterEnWoL. When set to 1, the result of the perfect address matching filter and the imperfect hash filter will generate a WoL interrupt when there is a match.
            RFEW: u1,
            ///  Unused
            RESERVED: u18,
        }),
        ///  Receive filter WoL status register.
        RXFILTERWOLSTATUS: mmio.Mmio(packed struct(u32) {
            ///  AcceptUnicastWoL. When the value is 1, a unicast frames caused WoL.
            AUW: u1,
            ///  AcceptBroadcastWoL. When the value is 1, a broadcast frame caused WoL.
            ABW: u1,
            ///  AcceptMulticastWoL. When the value is 1, a multicast frame caused WoL.
            AMW: u1,
            ///  AcceptUnicastHashWoL. When the value is 1, a unicast frame that passes the imperfect hash filter caused WoL.
            AUHW: u1,
            ///  AcceptMulticastHashWoL. When the value is 1, a multicast frame that passes the imperfect hash filter caused WoL.
            AMHW: u1,
            ///  AcceptPerfectWoL. When the value is 1, the perfect address matching filter caused WoL.
            APW: u1,
            ///  Unused
            RESERVED: u1,
            ///  RxFilterWoL. When the value is 1, the receive filter caused WoL.
            RFW: u1,
            ///  MagicPacketWoL. When the value is 1, the magic packet filter caused WoL.
            MPW: u1,
            ///  Unused
            RESERVED: u23,
        }),
        ///  Receive filter WoL clear register.
        RXFILTERWOLCLEAR: mmio.Mmio(packed struct(u32) {
            ///  AcceptUnicastWoLClr. When a 1 is written, the corresponding status bit in the RxFilterWoLStatus register is cleared.
            AUWCLR: u1,
            ///  AcceptBroadcastWoLClr. When a 1 is written, the corresponding status bit in the RxFilterWoLStatus register is cleared.
            ABWCLR: u1,
            ///  AcceptMulticastWoLClr. When a 1 is written, the corresponding status bit in the RxFilterWoLStatus register is cleared.
            AMWCLR: u1,
            ///  AcceptUnicastHashWoLClr. When a 1 is written, the corresponding status bit in the RxFilterWoLStatus register is cleared.
            AUHWCLR: u1,
            ///  AcceptMulticastHashWoLClr. When a 1 is written, the corresponding status bit in the RxFilterWoLStatus register is cleared.
            AMHWCLR: u1,
            ///  AcceptPerfectWoLClr. When a 1 is written, the corresponding status bit in the RxFilterWoLStatus register is cleared.
            APWCLR: u1,
            ///  Unused
            RESERVED: u1,
            ///  RxFilterWoLClr. When a 1 is written, the corresponding status bit in the RxFilterWoLStatus register is cleared.
            RFWCLR: u1,
            ///  MagicPacketWoLClr. When a 1 is written, the corresponding status bit in the RxFilterWoLStatus register is cleared.
            MPWCLR: u1,
            ///  Unused
            RESERVED: u23,
        }),
        reserved528: [4]u8,
        ///  Hash filter table LSBs register.
        HASHFILTERL: mmio.Mmio(packed struct(u32) {
            ///  HashFilterL. Bits 31:0 of the imperfect filter hash table for receive filtering.
            HFL: u32,
        }),
        ///  Hash filter table MSBs register.
        HASHFILTERH: mmio.Mmio(packed struct(u32) {
            ///  Bits 63:32 of the imperfect filter hash table for receive filtering.
            HFH: u32,
        }),
        reserved4064: [3528]u8,
        ///  Interrupt status register.
        INTSTATUS: mmio.Mmio(packed struct(u32) {
            ///  Interrupt set on a fatal overrun error in the receive queue. The fatal interrupt should be resolved by a Rx soft-reset. The bit is not set when there is a nonfatal overrun error.
            RXOVERRUNINT: u1,
            ///  Interrupt trigger on receive errors: AlignmentError, RangeError, LengthError, SymbolError, CRCError or NoDescriptor or Overrun.
            RXERRORINT: u1,
            ///  Interrupt triggered when all receive descriptors have been processed i.e. on the transition to the situation where ProduceIndex == ConsumeIndex.
            RXFINISHEDINT: u1,
            ///  Interrupt triggered when a receive descriptor has been processed while the Interrupt bit in the Control field of the descriptor was set.
            RXDONEINT: u1,
            ///  Interrupt set on a fatal underrun error in the transmit queue. The fatal interrupt should be resolved by a Tx soft-reset. The bit is not set when there is a nonfatal underrun error.
            TXUNDERRUNINT: u1,
            ///  Interrupt trigger on transmit errors: LateCollision, ExcessiveCollision and ExcessiveDefer, NoDescriptor or Underrun.
            TXERRORINT: u1,
            ///  Interrupt triggered when all transmit descriptors have been processed i.e. on the transition to the situation where ProduceIndex == ConsumeIndex.
            TXFINISHEDINT: u1,
            ///  Interrupt triggered when a descriptor has been transmitted while the Interrupt bit in the Control field of the descriptor was set.
            TXDONEINT: u1,
            ///  Unused
            RESERVED: u4,
            ///  Interrupt triggered by software writing a 1 to the SoftIntSet bit in the IntSet register.
            SOFTINT: u1,
            ///  Interrupt triggered by a Wake-up event detected by the receive filter.
            WAKEUPINT: u1,
            ///  Unused
            RESERVED: u18,
        }),
        ///  Interrupt enable register.
        INTENABLE: mmio.Mmio(packed struct(u32) {
            ///  Enable for interrupt trigger on receive buffer overrun or descriptor underrun situations.
            RXOVERRUNINTEN: u1,
            ///  Enable for interrupt trigger on receive errors.
            RXERRORINTEN: u1,
            ///  Enable for interrupt triggered when all receive descriptors have been processed i.e. on the transition to the situation where ProduceIndex == ConsumeIndex.
            RXFINISHEDINTEN: u1,
            ///  Enable for interrupt triggered when a receive descriptor has been processed while the Interrupt bit in the Control field of the descriptor was set.
            RXDONEINTEN: u1,
            ///  Enable for interrupt trigger on transmit buffer or descriptor underrun situations.
            TXUNDERRUNINTEN: u1,
            ///  Enable for interrupt trigger on transmit errors.
            TXERRORINTEN: u1,
            ///  Enable for interrupt triggered when all transmit descriptors have been processed i.e. on the transition to the situation where ProduceIndex == ConsumeIndex.
            TXFINISHEDINTEN: u1,
            ///  Enable for interrupt triggered when a descriptor has been transmitted while the Interrupt bit in the Control field of the descriptor was set.
            TXDONEINTEN: u1,
            ///  Unused
            RESERVED: u4,
            ///  Enable for interrupt triggered by the SoftInt bit in the IntStatus register, caused by software writing a 1 to the SoftIntSet bit in the IntSet register.
            SOFTINTEN: u1,
            ///  Enable for interrupt triggered by a Wake-up event detected by the receive filter.
            WAKEUPINTEN: u1,
            ///  Unused
            RESERVED: u18,
        }),
        ///  Interrupt clear register.
        INTCLEAR: mmio.Mmio(packed struct(u32) {
            ///  Writing a 1 clears the corresponding status bit in interrupt status register IntStatus.
            RXOVERRUNINTCLR: u1,
            ///  Writing a 1 clears the corresponding status bit in interrupt status register IntStatus.
            RXERRORINTCLR: u1,
            ///  Writing a 1 clears the corresponding status bit in interrupt status register IntStatus.
            RXFINISHEDINTCLR: u1,
            ///  Writing a 1 clears the corresponding status bit in interrupt status register IntStatus.
            RXDONEINTCLR: u1,
            ///  Writing a 1 clears the corresponding status bit in interrupt status register IntStatus.
            TXUNDERRUNINTCLR: u1,
            ///  Writing a 1 clears the corresponding status bit in interrupt status register IntStatus.
            TXERRORINTCLR: u1,
            ///  Writing a 1 clears the corresponding status bit in interrupt status register IntStatus.
            TXFINISHEDINTCLR: u1,
            ///  Writing a 1 clears the corresponding status bit in interrupt status register IntStatus.
            TXDONEINTCLR: u1,
            ///  Unused
            RESERVED: u4,
            ///  Writing a 1 clears the corresponding status bit in interrupt status register IntStatus.
            SOFTINTCLR: u1,
            ///  Writing a 1 clears the corresponding status bit in interrupt status register IntStatus.
            WAKEUPINTCLR: u1,
            ///  Unused
            RESERVED: u18,
        }),
        ///  Interrupt set register.
        INTSET: mmio.Mmio(packed struct(u32) {
            ///  Writing a 1 to one sets the corresponding status bit in interrupt status register IntStatus.
            RXOVERRUNINTSET: u1,
            ///  Writing a 1 to one sets the corresponding status bit in interrupt status register IntStatus.
            RXERRORINTSET: u1,
            ///  Writing a 1 to one sets the corresponding status bit in interrupt status register IntStatus.
            RXFINISHEDINTSET: u1,
            ///  Writing a 1 to one sets the corresponding status bit in interrupt status register IntStatus.
            RXDONEINTSET: u1,
            ///  Writing a 1 to one sets the corresponding status bit in interrupt status register IntStatus.
            TXUNDERRUNINTSET: u1,
            ///  Writing a 1 to one sets the corresponding status bit in interrupt status register IntStatus.
            TXERRORINTSET: u1,
            ///  Writing a 1 to one sets the corresponding status bit in interrupt status register IntStatus.
            TXFINISHEDINTSET: u1,
            ///  Writing a 1 to one sets the corresponding status bit in interrupt status register IntStatus.
            TXDONEINTSET: u1,
            ///  Unused
            RESERVED: u4,
            ///  Writing a 1 to one sets the corresponding status bit in interrupt status register IntStatus.
            SOFTINTSET: u1,
            ///  Writing a 1 to one sets the corresponding status bit in interrupt status register IntStatus.
            WAKEUPINTSET: u1,
            ///  Unused
            RESERVED: u18,
        }),
        reserved4084: [4]u8,
        ///  Power-down register.
        POWERDOWN: mmio.Mmio(packed struct(u32) {
            ///  Unused
            RESERVED: u31,
            ///  PowerDownMACAHB. If true, all AHB accesses will return a read/write error, except accesses to the Power-Down register.
            PD: u1,
        }),
    };

    ///  Digital-to-Analog Converter (DAC)
    pub const DAC = extern struct {
        ///  D/A Converter Register. This register contains the digital value to be converted to analog and a power control bit.
        CR: mmio.Mmio(packed struct(u32) {
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u6,
            ///  After the selected settling time after this field is written with a new VALUE, the voltage on the DAC_OUT pin (with respect to VSSA) is VALUE x ((VREFP - V REFN)/1024) + VREFN.
            VALUE: u10,
            ///  Settling time The settling times noted in the description of the BIAS bit are valid for a capacitance load on the DAC_OUT pin not exceeding 100 pF. A load impedance value greater than that value will cause settling time longer than the specified time. One or more graphs of load impedance vs. settling time will be included in the final data sheet.
            BIAS: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The settling time of the DAC is 1 us max, and the maximum current is 700 uA. This allows a maximum update rate of 1 MHz.
                    FAST = 0x0,
                    ///  The settling time of the DAC is 2.5 us and the maximum current is 350 uA. This allows a maximum update rate of 400 kHz.
                    SLOW = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u15,
        }),
        ///  DAC Control register. This register controls DMA and timer operation.
        CTRL: mmio.Mmio(packed struct(u32) {
            ///  DMA interrupt request
            INT_DMA_REQ: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Clear on any write to the DACR register.
                    CLEAR_ON_ANY_WRITE_T = 0x0,
                    ///  Set by hardware when the timer times out.
                    SET_BY_HARDWARE_WHEN = 0x1,
                },
            },
            ///  Double buffering
            DBLBUF_ENA: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable
                    DISABLE = 0x0,
                    ///  Enable. When this bit and the CNT_ENA bit are both set, the double-buffering feature in the DACR register will be enabled. Writes to the DACR register are written to a pre-buffer and then transferred to the DACR on the next time-out of the counter.
                    ENABLE_WHEN_THIS_BI = 0x1,
                },
            },
            ///  Time-out counter operation
            CNT_ENA: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable
                    DISABLE = 0x0,
                    ///  Enable
                    ENABLE = 0x1,
                },
            },
            ///  DMA access
            DMA_ENA: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disable
                    DISABLE = 0x0,
                    ///  Enable. DMA Burst Request Input 7 is enabled for the DAC (see Table 672).
                    ENABLE_DMA_BURST_RE = 0x1,
                },
            },
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u28,
        }),
        ///  DAC Counter Value register. This register contains the reload value for the DAC DMA/Interrupt timer.
        CNTVAL: mmio.Mmio(packed struct(u32) {
            ///  16-bit reload value for the DAC interrupt/DMA timer.
            VALUE: u16,
            ///  Reserved
            RESERVED: u16,
        }),
    };

    ///  System and clock control
    pub const SYSCON = extern struct {
        ///  Flash Accelerator Configuration Register. Controls flash access timing.
        FLASHCFG: mmio.Mmio(packed struct(u32) {
            ///  Reserved, user software should not change these bits from the reset value.
            RESERVED: u12,
            ///  Flash access time. The value of this field plus 1 gives the number of CPU clocks used for a flash access. Warning: improper setting of this value may result in incorrect operation of the device. Other values are reserved.
            FLASHTIM: packed union {
                raw: u4,
                value: enum(u4) {
                    ///  Flash accesses use 1 CPU clock. Use for up to 20 MHz CPU clock.
                    @"1CLK" = 0x0,
                    ///  Flash accesses use 2 CPU clocks. Use for up to 40 MHz CPU clock.
                    @"2CLK" = 0x1,
                    ///  Flash accesses use 3 CPU clocks. Use for up to 60 MHz CPU clock.
                    @"3CLK" = 0x2,
                    ///  Flash accesses use 4 CPU clocks. Use for up to 80 MHz CPU clock.
                    @"4CLK" = 0x3,
                    ///  Flash accesses use 5 CPU clocks. Use for up to 100 MHz CPU clock. Use for up to 120 Mhz for LPC1759 and LPC1769 only.
                    @"5CLK" = 0x4,
                    ///  Flash accesses use 6 CPU clocks. This safe setting will work under any conditions.
                    @"6CLK" = 0x5,
                    _,
                },
            },
            ///  Reserved. The value read from a reserved bit is not defined.
            RESERVED: u16,
        }),
        reserved128: [124]u8,
        ///  PLL0 Control Register
        PLL0CON: mmio.Mmio(packed struct(u32) {
            ///  PLL0 Enable. When one, and after a valid PLL0 feed, this bit will activate PLL0 and allow it to lock to the requested frequency. See PLL0STAT register.
            PLLE0: u1,
            ///  PLL0 Connect. Setting PLLC0 to one after PLL0 has been enabled and locked, then followed by a valid PLL0 feed sequence causes PLL0 to become the clock source for the CPU, AHB peripherals, and used to derive the clocks for APB peripherals. The PLL0 output may potentially be used to clock the USB subsystem if the frequency is 48 MHz. See PLL0STAT register.
            PLLC0: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u30,
        }),
        ///  PLL0 Configuration Register
        PLL0CFG: mmio.Mmio(packed struct(u32) {
            ///  PLL0 Multiplier value. Supplies the value M in PLL0 frequency calculations. The value stored here is M - 1. Note: Not all values of M are needed, and therefore some are not supported by hardware.
            MSEL0: u15,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u1,
            ///  PLL0 Pre-Divider value. Supplies the value N in PLL0 frequency calculations. The value stored here is N - 1. Supported values for N are 1 through 32.
            NSEL0: u8,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u8,
        }),
        ///  PLL0 Status Register
        PLL0STAT: mmio.Mmio(packed struct(u32) {
            ///  Read-back for the PLL0 Multiplier value. This is the value currently used by PLL0, and is one less than the actual multiplier.
            MSEL0: u15,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u1,
            ///  Read-back for the PLL0 Pre-Divider value. This is the value currently used by PLL0, and is one less than the actual divider.
            NSEL0: u8,
            ///  Read-back for the PLL0 Enable bit. This bit reflects the state of the PLEC0 bit in PLL0CON after a valid PLL0 feed. When one, PLL0 is currently enabled. When zero, PLL0 is turned off. This bit is automatically cleared when Power-down mode is entered.
            PLLE0_STAT: u1,
            ///  Read-back for the PLL0 Connect bit. This bit reflects the state of the PLLC0 bit in PLL0CON after a valid PLL0 feed. When PLLC0 and PLLE0 are both one, PLL0 is connected as the clock source for the CPU. When either PLLC0 or PLLE0 is zero, PLL0 is bypassed. This bit is automatically cleared when Power-down mode is entered.
            PLLC0_STAT: u1,
            ///  Reflects the PLL0 Lock status. When zero, PLL0 is not locked. When one, PLL0 is locked onto the requested frequency. See text for details.
            PLOCK0: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u5,
        }),
        ///  PLL0 Feed Register
        PLL0FEED: mmio.Mmio(packed struct(u32) {
            ///  The PLL0 feed sequence must be written to this register in order for PLL0 configuration and control register changes to take effect.
            PLL0FEED: u8,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        reserved160: [16]u8,
        ///  PLL1 Control Register
        PLL1CON: mmio.Mmio(packed struct(u32) {
            ///  PLL1 Enable. When one, and after a valid PLL1 feed, this bit will activate PLL1 and allow it to lock to the requested frequency.
            PLLE1: u1,
            ///  PLL1 Connect. Setting PLLC to one after PLL1 has been enabled and locked, then followed by a valid PLL1 feed sequence causes PLL1 to become the clock source for the USB subsystem via the USB clock divider. See PLL1STAT register.
            PLLC1: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u30,
        }),
        ///  PLL1 Configuration Register
        PLL1CFG: mmio.Mmio(packed struct(u32) {
            ///  PLL1 Multiplier value. Supplies the value M in the PLL1 frequency calculations.
            MSEL1: u5,
            ///  PLL1 Divider value. Supplies the value P in the PLL1 frequency calculations.
            PSEL1: u2,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u25,
        }),
        ///  PLL1 Status Register
        PLL1STAT: mmio.Mmio(packed struct(u32) {
            ///  Read-back for the PLL1 Multiplier value. This is the value currently used by PLL1.
            MSEL1: u5,
            ///  Read-back for the PLL1 Divider value. This is the value currently used by PLL1.
            PSEL1: u2,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u1,
            ///  Read-back for the PLL1 Enable bit. When one, PLL1 is currently activated. When zero, PLL1 is turned off. This bit is automatically cleared when Power-down mode is activated.
            PLLE1_STAT: u1,
            ///  Read-back for the PLL1 Connect bit. When PLLC and PLLE are both one, PLL1 is connected as the clock source for the microcontroller. When either PLLC or PLLE is zero, PLL1 is bypassed and the oscillator clock is used directly by the microcontroller. This bit is automatically cleared when Power-down mode is activated.
            PLLC1_STAT: u1,
            ///  Reflects the PLL1 Lock status. When zero, PLL1 is not locked. When one, PLL1 is locked onto the requested frequency.
            PLOCK1: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u21,
        }),
        ///  PLL1 Feed Register
        PLL1FEED: mmio.Mmio(packed struct(u32) {
            ///  The PLL1 feed sequence must be written to this register in order for PLL1 configuration and control register changes to take effect.
            PLL1FEED: u8,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        reserved192: [16]u8,
        ///  Power Control Register
        PCON: mmio.Mmio(packed struct(u32) {
            ///  Power mode control bit 0. This bit controls entry to the Power-down mode.
            PM0: u1,
            ///  Power mode control bit 1. This bit controls entry to the Deep Power-down mode.
            PM1: u1,
            ///  Brown-Out Reduced Power Mode. When BODRPM is 1, the Brown-Out Detect circuitry will be turned off when chip Power-down mode or Deep Sleep mode is entered, resulting in a further reduction in power usage. However, the possibility of using Brown-Out Detect as a wake-up source from the reduced power mode will be lost. When 0, the Brown-Out Detect function remains active during Power-down and Deep Sleep modes. See the System Control Block chapter for details of Brown-Out detection.
            BODRPM: u1,
            ///  Brown-Out Global Disable. When BOGD is 1, the Brown-Out Detect circuitry is fully disabled at all times, and does not consume power. When 0, the Brown-Out Detect circuitry is enabled. See the System Control Block chapter for details of Brown-Out detection. Note: the Brown-Out Reset Disable (BORD, in this register) and the Brown-Out Interrupt (xx) must be disabled when software changes the value of this bit.
            BOGD: u1,
            ///  Brown-Out Reset Disable. When BORD is 1, the BOD will not reset the device when the VDD(REG)(3V3) voltage dips goes below the BOD reset trip level. The Brown-Out interrupt is not affected. When BORD is 0, the BOD reset is enabled.
            BORD: u1,
            reserved8: u3,
            ///  Sleep Mode entry flag. Set when the Sleep mode is successfully entered. Cleared by software writing a one to this bit.
            SMFLAG: u1,
            ///  Deep Sleep entry flag. Set when the Deep Sleep mode is successfully entered. Cleared by software writing a one to this bit.
            DSFLAG: u1,
            ///  Power-down entry flag. Set when the Power-down mode is successfully entered. Cleared by software writing a one to this bit.
            PDFLAG: u1,
            ///  Deep Power-down entry flag. Set when the Deep Power-down mode is successfully entered. Cleared by software writing a one to this bit.
            DPDFLAG: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u20,
        }),
        ///  Power Control for Peripherals Register
        PCONP: mmio.Mmio(packed struct(u32) {
            ///  Reserved.
            RESERVED: u1,
            ///  Timer/Counter 0 power/clock control bit.
            PCTIM0: u1,
            ///  Timer/Counter 1 power/clock control bit.
            PCTIM1: u1,
            ///  UART0 power/clock control bit.
            PCUART0: u1,
            ///  UART1 power/clock control bit.
            PCUART1: u1,
            ///  Reserved.
            RESERVED: u1,
            ///  PWM1 power/clock control bit.
            PCPWM1: u1,
            ///  The I2C0 interface power/clock control bit.
            PCI2C0: u1,
            ///  The SPI interface power/clock control bit.
            PCSPI: u1,
            ///  The RTC power/clock control bit.
            PCRTC: u1,
            ///  The SSP 1 interface power/clock control bit.
            PCSSP1: u1,
            ///  Reserved.
            RESERVED: u1,
            ///  A/D converter (ADC) power/clock control bit. Note: Clear the PDN bit in the AD0CR before clearing this bit, and set this bit before setting PDN.
            PCADC: u1,
            ///  CAN Controller 1 power/clock control bit.
            PCCAN1: u1,
            ///  CAN Controller 2 power/clock control bit.
            PCCAN2: u1,
            ///  Power/clock control bit for IOCON, GPIO, and GPIO interrupts.
            PCGPIO: u1,
            ///  Repetitive Interrupt Timer power/clock control bit.
            PCRIT: u1,
            ///  Motor Control PWM
            PCMCPWM: u1,
            ///  Quadrature Encoder Interface power/clock control bit.
            PCQEI: u1,
            ///  The I2C1 interface power/clock control bit.
            PCI2C1: u1,
            ///  Reserved.
            RESERVED: u1,
            ///  The SSP0 interface power/clock control bit.
            PCSSP0: u1,
            ///  Timer 2 power/clock control bit.
            PCTIM2: u1,
            ///  Timer 3 power/clock control bit.
            PCTIM3: u1,
            ///  UART 2 power/clock control bit.
            PCUART2: u1,
            ///  UART 3 power/clock control bit.
            PCUART3: u1,
            ///  I2C interface 2 power/clock control bit.
            PCI2C2: u1,
            ///  I2S interface power/clock control bit.
            PCI2S: u1,
            ///  Reserved.
            RESERVED: u1,
            ///  GPDMA function power/clock control bit.
            PCGPDMA: u1,
            ///  Ethernet block power/clock control bit.
            PCENET: u1,
            ///  USB interface power/clock control bit.
            PCUSB: u1,
        }),
        reserved260: [60]u8,
        ///  CPU Clock Configuration Register
        CCLKCFG: mmio.Mmio(packed struct(u32) {
            ///  Selects the divide value for creating the CPU clock (CCLK) from the PLL0 output. 0 = pllclk is divided by 1 to produce the CPU clock. This setting is not allowed when the PLL0 is connected, because the rate would always be greater than the maximum allowed CPU clock. 1 = pllclk is divided by 2 to produce the CPU clock. This setting is not allowed when the PLL0 is connected, because the rate would always be greater than the maximum allowed CPU clock. 2 = pllclk is divided by 3 to produce the CPU clock. 3 = pllclk is divided by 4 to produce the CPU clock. ... 255 = pllclk is divided by 256 to produce the CPU clock.
            CCLKSEL: u8,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u24,
        }),
        ///  USB Clock Configuration Register
        USBCLKCFG: mmio.Mmio(packed struct(u32) {
            ///  Selects the divide value for creating the USB clock from the PLL0 output. Only the values shown below can produce even number multiples of 48 MHz from the PLL0 output. Warning: Improper setting of this value will result in incorrect operation of the USB interface. 5 = PLL0 output is divided by 6. PLL0 output must be 288 MHz. 7 = PLL0 output is divided by 8. PLL0 output must be 384 MHz. 9 = PLL0 output is divided by 10. PLL0 output must be 480 MHz.
            USBSEL: u4,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u28,
        }),
        ///  Clock Source Select Register
        CLKSRCSEL: mmio.Mmio(packed struct(u32) {
            ///  Selects the clock source for PLL0 as follows. Warning: Improper setting of this value, or an incorrect sequence of changing this value may result in incorrect operation of the device.
            CLKSRC: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Selects the Internal RC oscillator as the PLL0 clock source (default).
                    SELECTS_THE_INTERNAL = 0x0,
                    ///  Selects the main oscillator as the PLL0 clock source. Select the main oscillator as PLL0 clock source if the PLL0 clock output is used for USB or for CAN with baudrates > 100 kBit/s.
                    SELECTS_THE_MAIN_OSC = 0x1,
                    ///  Selects the RTC oscillator as the PLL0 clock source.
                    SELECTS_THE_RTC_OSCI = 0x2,
                    ///  Reserved, do not use this setting.
                    RESERVED = 0x3,
                },
            },
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u30,
        }),
        ///  Allows clearing the current CAN channel sleep state as well as reading that state.
        CANSLEEPCLR: mmio.Mmio(packed struct(u32) {
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u1,
            ///  Sleep status and control for CAN channel 1. Read: when 1, indicates that CAN channel 1 is in the sleep mode. Write: writing a 1 causes clocks to be restored to CAN channel 1.
            CAN1SLEEP: u1,
            ///  Sleep status and control for CAN channel 2. Read: when 1, indicates that CAN channel 2 is in the sleep mode. Write: writing a 1 causes clocks to be restored to CAN channel 2.
            CAN2SLEEP: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u29,
        }),
        ///  Allows reading the wake-up state of the CAN channels.
        CANWAKEFLAGS: mmio.Mmio(packed struct(u32) {
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u1,
            ///  Wake-up status for CAN channel 1. Read: when 1, indicates that a falling edge has occurred on the receive data line of CAN channel 1. Write: writing a 1 clears this bit.
            CAN1WAKE: u1,
            ///  Wake-up status for CAN channel 2. Read: when 1, indicates that a falling edge has occurred on the receive data line of CAN channel 2. Write: writing a 1 clears this bit.
            CAN2WAKE: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u29,
        }),
        reserved320: [40]u8,
        ///  External Interrupt Flag Register
        EXTINT: mmio.Mmio(packed struct(u32) {
            ///  In level-sensitive mode, this bit is set if the EINT0 function is selected for its pin, and the pin is in its active state. In edge-sensitive mode, this bit is set if the EINT0 function is selected for its pin, and the selected edge occurs on the pin. This bit is cleared by writing a one to it, except in level sensitive mode when the pin is in its active state.
            EINT0: u1,
            ///  In level-sensitive mode, this bit is set if the EINT1 function is selected for its pin, and the pin is in its active state. In edge-sensitive mode, this bit is set if the EINT1 function is selected for its pin, and the selected edge occurs on the pin. This bit is cleared by writing a one to it, except in level sensitive mode when the pin is in its active state.
            EINT1: u1,
            ///  In level-sensitive mode, this bit is set if the EINT2 function is selected for its pin, and the pin is in its active state. In edge-sensitive mode, this bit is set if the EINT2 function is selected for its pin, and the selected edge occurs on the pin. This bit is cleared by writing a one to it, except in level sensitive mode when the pin is in its active state.
            EINT2: u1,
            ///  In level-sensitive mode, this bit is set if the EINT3 function is selected for its pin, and the pin is in its active state. In edge-sensitive mode, this bit is set if the EINT3 function is selected for its pin, and the selected edge occurs on the pin. This bit is cleared by writing a one to it, except in level sensitive mode when the pin is in its active state.
            EINT3: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u28,
        }),
        reserved328: [4]u8,
        ///  External Interrupt Mode register
        EXTMODE: mmio.Mmio(packed struct(u32) {
            ///  External interrupt 0 EINT0 mode.
            EXTMODE0: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Level-sensitive. Level-sensitivity is selected for EINT0.
                    LEVEL_SENSITIVE = 0x0,
                    ///  Edge-sensitive. EINT0 is edge sensitive.
                    EDGE_SENSITIVE = 0x1,
                },
            },
            ///  External interrupt 1 EINT1 mode.
            EXTMODE1: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Level-sensitive. Level-sensitivity is selected for EINT1.
                    LEVEL_SENSITIVE = 0x0,
                    ///  Edge-sensitive. EINT1 is edge sensitive.
                    EDGE_SENSITIVE = 0x1,
                },
            },
            ///  External interrupt 2 EINT2 mode.
            EXTMODE2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Level-sensitive. Level-sensitivity is selected for EINT2.
                    LEVEL_SENSITIVE = 0x0,
                    ///  Edge-sensitive. EINT2 is edge sensitive.
                    EDGE_SENSITIVE = 0x1,
                },
            },
            ///  External interrupt 3 EINT3 mode.
            EXTMODE3: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Level-sensitive. Level-sensitivity is selected for EINT3.
                    LEVEL_SENSITIVE = 0x0,
                    ///  Edge-sensitive. EINT3 is edge sensitive.
                    EDGE_SENSITIVE = 0x1,
                },
            },
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u28,
        }),
        ///  External Interrupt Polarity Register
        EXTPOLAR: mmio.Mmio(packed struct(u32) {
            ///  External interrupt 0 EINT0 polarity.
            EXTPOLAR0: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Falling edge. EINT0 is low-active or falling-edge sensitive (depending on EXTMODE0).
                    FALLING_EDGE = 0x0,
                    ///  Rising edge. EINT0 is high-active or rising-edge sensitive (depending on EXTMODE0).
                    RISING_EDGE = 0x1,
                },
            },
            ///  External interrupt 1 EINT1 polarity.
            EXTPOLAR1: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Falling edge. EINT1 is low-active or falling-edge sensitive (depending on EXTMODE1).
                    FALLING_EDGE = 0x0,
                    ///  Rising edge. EINT1 is high-active or rising-edge sensitive (depending on EXTMODE1).
                    RISING_EDGE = 0x1,
                },
            },
            ///  External interrupt 2 EINT2 polarity.
            EXTPOLAR2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Falling edge. EINT2 is low-active or falling-edge sensitive (depending on EXTMODE2).
                    FALLING_EDGE = 0x0,
                    ///  Rising edge. EINT2 is high-active or rising-edge sensitive (depending on EXTMODE2).
                    RISING_EDGE = 0x1,
                },
            },
            ///  External interrupt 3 EINT3 polarity.
            EXTPOLAR3: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Falling edge. EINT3 is low-active or falling-edge sensitive (depending on EXTMODE3).
                    FALLING_EDGE = 0x0,
                    ///  Rising edge. EINT3 is high-active or rising-edge sensitive (depending on EXTMODE3).
                    RISING_EDGE = 0x1,
                },
            },
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u28,
        }),
        reserved384: [48]u8,
        ///  Reset Source Identification Register
        RSID: mmio.Mmio(packed struct(u32) {
            ///  Assertion of the POR signal sets this bit, and clears all of the other bits in this register. But if another Reset signal (e.g., External Reset) remains asserted after the POR signal is negated, then its bit is set. This bit is not affected by any of the other sources of Reset.
            POR: u1,
            ///  Assertion of the RESET signal sets this bit. This bit is cleared only by software or POR.
            EXTR: u1,
            ///  This bit is set when the Watchdog Timer times out and the WDTRESET bit in the Watchdog Mode Register is 1. This bit is cleared only by software or POR.
            WDTR: u1,
            ///  This bit is set when the VDD(REG)(3V3) voltage reaches a level below the BOD reset trip level (typically 1.85 V under nominal room temperature conditions). If the VDD(REG)(3V3) voltage dips from the normal operating range to below the BOD reset trip level and recovers, the BODR bit will be set to 1. If the VDD(REG)(3V3) voltage dips from the normal operating range to below the BOD reset trip level and continues to decline to the level at which POR is asserted (nominally 1 V), the BODR bit is cleared. If the VDD(REG)(3V3) voltage rises continuously from below 1 V to a level above the BOD reset trip level, the BODR will be set to 1. This bit is cleared only by software or POR. Note: Only in the case where a reset occurs and the POR = 0, the BODR bit indicates if the VDD(REG)(3V3) voltage was below the BOD reset trip level or not.
            BODR: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u28,
        }),
        reserved416: [28]u8,
        ///  System control and status
        SCS: mmio.Mmio(packed struct(u32) {
            ///  Reserved. User software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u4,
            ///  Main oscillator range select.
            OSCRANGE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Low. The frequency range of the main oscillator is 1 MHz to 20 MHz.
                    LOW = 0x0,
                    ///  High. The frequency range of the main oscillator is 15 MHz to 25 MHz.
                    HIGH = 0x1,
                },
            },
            ///  Main oscillator enable.
            OSCEN: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Disabled. The main oscillator is disabled.
                    DISABLED = 0x0,
                    ///  Enabled.The main oscillator is enabled, and will start up if the correct external circuitry is connected to the XTAL1 and XTAL2 pins.
                    ENABLED = 0x1,
                },
            },
            ///  Main oscillator status.
            OSCSTAT: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Not ready. The main oscillator is not ready to be used as a clock source.
                    NOT_READY = 0x0,
                    ///  Ready. The main oscillator is ready to be used as a clock source. The main oscillator must be enabled via the OSCEN bit.
                    READY = 0x1,
                },
            },
            ///  Reserved. User software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u25,
        }),
        reserved424: [4]u8,
        ///  Peripheral Clock Selection register 0.
        PCLKSEL0: mmio.Mmio(packed struct(u32) {
            ///  Peripheral clock selection for WDT.
            PCLK_WDT: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Peripheral clock selection for TIMER0.
            PCLK_TIMER0: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Peripheral clock selection for TIMER1.
            PCLK_TIMER1: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Peripheral clock selection for UART0.
            PCLK_UART0: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Peripheral clock selection for UART1.
            PCLK_UART1: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Reserved.
            RESERVED: u2,
            ///  Peripheral clock selection for PWM1.
            PCLK_PWM1: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Peripheral clock selection for I2C0.
            PCLK_I2C0: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Peripheral clock selection for SPI.
            PCLK_SPI: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Reserved.
            RESERVED: u2,
            ///  Peripheral clock selection for SSP1.
            PCLK_SSP1: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Peripheral clock selection for DAC.
            PCLK_DAC: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Peripheral clock selection for ADC.
            PCLK_ADC: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Peripheral clock selection for CAN1.PCLK_CAN1 and PCLK_CAN2 must have the same PCLK divide value when the CAN function is used.
            PCLK_CAN1: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 6. PCLK_peripheral = CCLK/6.
                    CCLK_DIV_6 = 0x3,
                },
            },
            ///  Peripheral clock selection for CAN2.PCLK_CAN1 and PCLK_CAN2 must have the same PCLK divide value when the CAN function is used.
            PCLK_CAN2: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 6. PCLK_peripheral = CCLK/6,
                    CCLK_DIV_6 = 0x3,
                },
            },
            ///  Peripheral clock selection for CAN acceptance filtering.PCLK_CAN1 and PCLK_CAN2 must have the same PCLK divide value when the CAN function is used.
            PCLK_ACF: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 6. PCLK_peripheral = CCLK/6
                    CCLK_DIV_6 = 0x3,
                },
            },
        }),
        ///  Peripheral Clock Selection register 1.
        PCLKSEL1: mmio.Mmio(packed struct(u32) {
            ///  Peripheral clock selection for the Quadrature Encoder Interface.
            PCLK_QEI: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Peripheral clock selection for GPIO interrupts.
            PCLK_GPIOINT: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Peripheral clock selection for the Pin Connect block.
            PCLK_PCB: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Peripheral clock selection for I2C1.
            PCLK_I2C1: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Reserved.
            RESERVED: u2,
            ///  Peripheral clock selection for SSP0.
            PCLK_SSP0: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Peripheral clock selection for TIMER2.
            PCLK_TIMER2: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Peripheral clock selection for TIMER3.
            PCLK_TIMER3: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Peripheral clock selection for UART2.
            PCLK_UART2: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Peripheral clock selection for UART3.
            PCLK_UART3: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Peripheral clock selection for I2C2.
            PCLK_I2C2: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Peripheral clock selection for I2S.
            PCLK_I2S: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Reserved.
            RESERVED: u2,
            ///  Peripheral clock selection for Repetitive Interrupt Timer.
            PCLK_RIT: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Peripheral clock selection for the System Control block.
            PCLK_SYSCON: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
            ///  Peripheral clock selection for the Motor Control PWM.
            PCLK_MC: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  CCLK div 4. PCLK_peripheral = CCLK/4
                    CCLK_DIV_4 = 0x0,
                    ///  CCLK. PCLK_peripheral = CCLK
                    CCLK = 0x1,
                    ///  CCLK div 2. PCLK_peripheral = CCLK/2
                    CCLK_DIV_2 = 0x2,
                    ///  CCLK div 8. PCLK_peripheral = CCLK/8
                    CCLK_DIV_8 = 0x3,
                },
            },
        }),
        reserved448: [16]u8,
        ///  USB Interrupt Status
        USBINTST: mmio.Mmio(packed struct(u32) {
            ///  Low priority interrupt line status. This bit is read-only.
            USB_INT_REQ_LP: u1,
            ///  High priority interrupt line status. This bit is read-only.
            USB_INT_REQ_HP: u1,
            ///  DMA interrupt line status. This bit is read-only.
            USB_INT_REQ_DMA: u1,
            ///  USB host interrupt line status. This bit is read-only.
            USB_HOST_INT: u1,
            ///  External ATX interrupt line status. This bit is read-only.
            USB_ATX_INT: u1,
            ///  OTG interrupt line status. This bit is read-only.
            USB_OTG_INT: u1,
            ///  I2C module interrupt line status. This bit is read-only.
            USB_I2C_INT: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u1,
            ///  USB need clock indicator. This bit is read-only. This bit is set to 1 when USB activity or a change of state on the USB data pins is detected, and it indicates that a PLL supplied clock of 48 MHz is needed. Once USB_NEED_CLK becomes one, it resets to zero 5 ms after the last packet has been received/sent, or 2 ms after the Suspend Change (SUS_CH) interrupt has occurred. A change of this bit from 0 to 1 can wake up the microcontroller if activity on the USB bus is selected to wake up the part from the Power-down mode (see Section 4.7.9 Wake-up from Reduced Power Modes for details). Also see Section 4.5.8 PLLs and Power-down mode and Section 4.7.10 Power Control for Peripherals register (PCONP - 0x400F C0C4) for considerations about the PLL and invoking the Power-down mode. This bit is read-only.
            USB_NEED_CLK: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u22,
            ///  Enable all USB interrupts. When this bit is cleared, the NVIC does not see the ORed output of the USB interrupt lines.
            EN_USB_INTS: u1,
        }),
        ///  Selects between alternative requests on DMA channels 0 through 7 and 10 through 15
        DMACREQSEL: mmio.Mmio(packed struct(u32) {
            ///  Selects the DMA request for GPDMA input 8: 0 - uart0 tx 1 - Timer 0 match 0 is selected.
            DMASEL08: u1,
            ///  Selects the DMA request for GPDMA input 9: 0 - uart0 rx 1 - Timer 0 match 1 is selected.
            DMASEL09: u1,
            ///  Selects the DMA request for GPDMA input 10: 0 - uart1 tx is selected. 1 - Timer 1 match 0 is selected.
            DMASEL10: u1,
            ///  Selects the DMA request for GPDMA input 11: 0 - uart1 rx is selected. 1 - Timer 1 match 1 is selected.
            DMASEL11: u1,
            ///  Selects the DMA request for GPDMA input 12: 0 - uart2 tx is selected. 1 - Timer 2 match 0 is selected.
            DMASEL12: u1,
            ///  Selects the DMA request for GPDMA input 13: 0 - uart2 rx is selected. 1 - Timer 2 match 1 is selected.
            DMASEL13: u1,
            ///  Selects the DMA request for GPDMA input 14: 0 - uart3 tx is selected. 1 - I2S channel 0 is selected.
            DMASEL14: u1,
            ///  Selects the DMA request for GPDMA input 15: 0 - uart3 rx is selected. 1 - I2S channel 1 is selected.
            DMASEL15: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u24,
        }),
        ///  Clock Output Configuration Register
        CLKOUTCFG: mmio.Mmio(packed struct(u32) {
            ///  Selects the clock source for the CLKOUT function. Other values are reserved. Do not use.
            CLKOUTSEL: packed union {
                raw: u4,
                value: enum(u4) {
                    ///  Selects the CPU clock as the CLKOUT source.
                    SELECTS_THE_CPU_CLOC = 0x0,
                    ///  Selects the main oscillator as the CLKOUT source.
                    SELECTS_THE_MAIN_OSC = 0x1,
                    ///  Selects the Internal RC oscillator as the CLKOUT source.
                    SELECTS_THE_INTERNAL = 0x2,
                    ///  Selects the USB clock as the CLKOUT source.
                    SELECTS_THE_USB_CLOC = 0x3,
                    ///  Selects the RTC oscillator as the CLKOUT source.
                    SELECTS_THE_RTC_OSCI = 0x4,
                    _,
                },
            },
            ///  Integer value to divide the output clock by, minus one. 0 = Clock is divided by 1 1 = Clock is divided by 2. 2 = Clock is divided by 3. ... 15 = Clock is divided by 16.
            CLKOUTDIV: u4,
            ///  CLKOUT enable control, allows switching the CLKOUT source without glitches. Clear to stop CLKOUT on the next falling edge. Set to enable CLKOUT.
            CLKOUT_EN: u1,
            ///  CLKOUT activity indication. Reads as 1 when CLKOUT is enabled. Read as 0 when CLKOUT has been disabled via the CLKOUT_EN bit and the clock has completed being stopped.
            CLKOUT_ACT: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u22,
        }),
    };

    ///  Quadrature Encoder Interface (QEI)
    pub const QEI = extern struct {
        ///  Control register
        CON: mmio.Mmio(packed struct(u32) {
            ///  Reset position counter. When set = 1, resets the position counter to all zeros. Autoclears when the position counter is cleared.
            RESP: u1,
            ///  Reset position counter on index. When set = 1, resets the position counter to all zeros once only the first time an index pulse occurs. Autoclears when the position counter is cleared.
            RESPI: u1,
            ///  Reset velocity. When set = 1, resets the velocity counter to all zeros, reloads the velocity timer, and presets the velocity compare register. Autoclears when the velocity counter is cleared.
            RESV: u1,
            ///  Reset index counter. When set = 1, resets the index counter to all zeros. Autoclears when the index counter is cleared.
            RESI: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u28,
        }),
        ///  Status register
        STAT: mmio.Mmio(packed struct(u32) {
            ///  Direction bit. In combination with DIRINV bit indicates forward or reverse direction. See Table 597.
            DIR: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u31,
        }),
        ///  Configuration register
        CONF: mmio.Mmio(packed struct(u32) {
            ///  Direction invert. When 1, complements the DIR bit.
            DIRINV: u1,
            ///  Signal Mode. When 0, PhA and PhB function as quadrature encoder inputs. When 1, PhA functions as the direction signal and PhB functions as the clock signal.
            SIGMODE: u1,
            ///  Capture Mode. When 0, only PhA edges are counted (2X). When 1, BOTH PhA and PhB edges are counted (4X), increasing resolution but decreasing range.
            CAPMODE: u1,
            ///  Invert Index. When 1, inverts the sense of the index input.
            INVINX: u1,
            ///  Continuously reset the position counter on index. When 1, resets the position counter to all zeros whenever an index pulse occurs after the next position increase (recalibration).
            CRESPI: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u11,
            ///  Index gating configuration: When INXGATE[16] = 1, pass the index when PHA = 1 and PHB = 0, otherwise block index. When INXGATE[17] = 1, pass the index when PHA = 1 and PHB = 1, otherwise block index. When INXGATE[18] = 1, pass the index when PHA = 0 and PHB = 1, otherwise block index. When INXGATE[19] = 1, pass the index when PHA = 0 and PHB = 0, otherwise block index.
            INXGATE: u4,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u12,
        }),
        ///  Position register
        POS: mmio.Mmio(packed struct(u32) {
            ///  Current position value.
            POS: u32,
        }),
        ///  Maximum position register
        MAXPOS: mmio.Mmio(packed struct(u32) {
            ///  Current maximum position value.
            MAXPOS: u32,
        }),
        ///  Position compare register 0
        CMPOS0: mmio.Mmio(packed struct(u32) {
            ///  Position compare value 0.
            PCMP0: u32,
        }),
        ///  Position compare register 1
        CMPOS1: mmio.Mmio(packed struct(u32) {
            ///  Position compare value 1.
            PCMP1: u32,
        }),
        ///  Position compare register 2
        CMPOS2: mmio.Mmio(packed struct(u32) {
            ///  Position compare value 2.
            PCMP2: u32,
        }),
        ///  Index count register 0
        INXCNT: mmio.Mmio(packed struct(u32) {
            ///  Current index counter value.
            ENCPOS: u32,
        }),
        ///  Index compare register 0
        INXCMP0: mmio.Mmio(packed struct(u32) {
            ///  Index compare value 0.
            ICMP0: u32,
        }),
        ///  Velocity timer reload register
        LOAD: mmio.Mmio(packed struct(u32) {
            ///  Current velocity timer load value.
            VELLOAD: u32,
        }),
        ///  Velocity timer register
        TIME: mmio.Mmio(packed struct(u32) {
            ///  Current velocity timer value.
            VELVAL: u32,
        }),
        ///  Velocity counter register
        VEL: mmio.Mmio(packed struct(u32) {
            ///  Current velocity pulse count.
            VELPC: u32,
        }),
        ///  Velocity capture register
        CAP: mmio.Mmio(packed struct(u32) {
            ///  Last velocity capture.
            VELCAP: u32,
        }),
        ///  Velocity compare register
        VELCOMP: mmio.Mmio(packed struct(u32) {
            ///  Compare velocity pulse count.
            VELPC: u32,
        }),
        ///  Digital filter register
        FILTER: mmio.Mmio(packed struct(u32) {
            ///  Digital filter sampling delay.
            FILTA: u32,
        }),
        reserved4056: [3992]u8,
        ///  Interrupt enable clear register
        IEC: mmio.Mmio(packed struct(u32) {
            ///  Writing a 1 disables the INX_Int interrupt in the QEIIE register.
            INX_INT: u1,
            ///  Writing a 1 disables the TIN_Int interrupt in the QEIIE register.
            TIM_INT: u1,
            ///  Writing a 1 disables the VELC_Int interrupt in the QEIIE register.
            VELC_INT: u1,
            ///  Writing a 1 disables the DIR_Int interrupt in the QEIIE register.
            DIR_INT: u1,
            ///  Writing a 1 disables the ERR_Int interrupt in the QEIIE register.
            ERR_INT: u1,
            ///  Writing a 1 disables the ENCLK_Int interrupt in the QEIIE register.
            ENCLK_INT: u1,
            ///  Writing a 1 disables the POS0_Int interrupt in the QEIIE register.
            POS0_INT: u1,
            ///  Writing a 1 disables the POS1_Int interrupt in the QEIIE register.
            POS1_INT: u1,
            ///  Writing a 1 disables the POS2_Int interrupt in the QEIIE register.
            POS2_INT: u1,
            ///  Writing a 1 disables the REV0_Int interrupt in the QEIIE register.
            REV0_INT: u1,
            ///  Writing a 1 disables the POS0REV_Int interrupt in the QEIIE register.
            POS0REV_INT: u1,
            ///  Writing a 1 disables the POS1REV_Int interrupt in the QEIIE register.
            POS1REV_INT: u1,
            ///  Writing a 1 disables the POS2REV_Int interrupt in the QEIIE register.
            POS2REV_INT: u1,
            ///  Writing a 1 disables the REV1_Int interrupt in the QEIIE register.
            REV1_INT: u1,
            ///  Writing a 1 disables the REV2_Int interrupt in the QEIIE register.
            REV2_INT: u1,
            ///  Writing a 1 disables the MAXPOS_Int interrupt in the QEIIE register.
            MAXPOS_INT: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u16,
        }),
        ///  Interrupt enable set register
        IES: mmio.Mmio(packed struct(u32) {
            ///  Writing a 1 enables the INX_Int interrupt in the QEIIE register.
            INX_INT: u1,
            ///  Writing a 1 enables the TIN_Int interrupt in the QEIIE register.
            TIM_INT: u1,
            ///  Writing a 1 enables the VELC_Int interrupt in the QEIIE register.
            VELC_INT: u1,
            ///  Writing a 1 enables the DIR_Int interrupt in the QEIIE register.
            DIR_INT: u1,
            ///  Writing a 1 enables the ERR_Int interrupt in the QEIIE register.
            ERR_INT: u1,
            ///  Writing a 1 enables the ENCLK_Int interrupt in the QEIIE register.
            ENCLK_INT: u1,
            ///  Writing a 1 enables the POS0_Int interrupt in the QEIIE register.
            POS0_INT: u1,
            ///  Writing a 1 enables the POS1_Int interrupt in the QEIIE register.
            POS1_INT: u1,
            ///  Writing a 1 enables the POS2_Int interrupt in the QEIIE register.
            POS2_INT: u1,
            ///  Writing a 1 enables the REV0_Int interrupt in the QEIIE register.
            REV0_INT: u1,
            ///  Writing a 1 enables the POS0REV_Int interrupt in the QEIIE register.
            POS0REV_INT: u1,
            ///  Writing a 1 enables the POS1REV_Int interrupt in the QEIIE register.
            POS1REV_INT: u1,
            ///  Writing a 1 enables the POS2REV_Int interrupt in the QEIIE register.
            POS2REV_INT: u1,
            ///  Writing a 1 enables the REV1_Int interrupt in the QEIIE register.
            REV1_INT: u1,
            ///  Writing a 1 enables the REV2_Int interrupt in the QEIIE register.
            REV2_INT: u1,
            ///  Writing a 1 enables the MAXPOS_Int interrupt in the QEIIE register.
            MAXPOS_INT: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u16,
        }),
        ///  Interrupt status register
        INTSTAT: mmio.Mmio(packed struct(u32) {
            ///  Indicates that an index pulse was detected.
            INX_INT: u1,
            ///  Indicates that a velocity timer overflow occurred
            TIM_INT: u1,
            ///  Indicates that captured velocity is less than compare velocity.
            VELC_INT: u1,
            ///  Indicates that a change of direction was detected.
            DIR_INT: u1,
            ///  Indicates that an encoder phase error was detected.
            ERR_INT: u1,
            ///  Indicates that and encoder clock pulse was detected.
            ENCLK_INT: u1,
            ///  Indicates that the position 0 compare value is equal to the current position.
            POS0_INT: u1,
            ///  Indicates that the position 1compare value is equal to the current position.
            POS1_INT: u1,
            ///  Indicates that the position 2 compare value is equal to the current position.
            POS2_INT: u1,
            ///  Indicates that the index compare 0 value is equal to the current index count.
            REV0_INT: u1,
            ///  Combined position 0 and revolution count interrupt. Set when both the POS0_Int bit is set and the REV0_Int is set.
            POS0REV_INT: u1,
            ///  Combined position 1 and revolution count interrupt. Set when both the POS1_Int bit is set and the REV1_Int is set.
            POS1REV_INT: u1,
            ///  Combined position 2 and revolution count interrupt. Set when both the POS2_Int bit is set and the REV2_Int is set.
            POS2REV_INT: u1,
            ///  Indicates that the index compare 1value is equal to the current index count.
            REV1_INT: u1,
            ///  Indicates that the index compare 2 value is equal to the current index count.
            REV2_INT: u1,
            ///  Indicates that the current position count goes through the MAXPOS value to zero in the forward direction, or through zero to MAXPOS in the reverse direction.
            MAXPOS_INT: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u16,
        }),
        ///  Interrupt enable register
        IE: mmio.Mmio(packed struct(u32) {
            ///  When 1, the INX_Int interrupt is enabled.
            INX_INT: u1,
            ///  When 1, the TIN_Int interrupt is enabled.
            TIM_INT: u1,
            ///  When 1, the VELC_Int interrupt is enabled.
            VELC_INT: u1,
            ///  When 1, the DIR_Int interrupt is enabled.
            DIR_INT: u1,
            ///  When 1, the ERR_Int interrupt is enabled.
            ERR_INT: u1,
            ///  When 1, the ENCLK_Int interrupt is enabled.
            ENCLK_INT: u1,
            ///  When 1, the POS0_Int interrupt is enabled.
            POS0_INT: u1,
            ///  When 1, the POS1_Int interrupt is enabled.
            POS1_INT: u1,
            ///  When 1, the POS2_Int interrupt is enabled.
            POS2_INT: u1,
            ///  When 1, the REV0_Int interrupt is enabled.
            REV0_INT: u1,
            ///  When 1, the POS0REV_Int interrupt is enabled.
            POS0REV_INT: u1,
            ///  When 1, the POS1REV_Int interrupt is enabled.
            POS1REV_INT: u1,
            ///  When 1, the POS2REV_Int interrupt is enabled.
            POS2REV_INT: u1,
            ///  When 1, the REV1_Int interrupt is enabled.
            REV1_INT: u1,
            ///  When 1, the REV2_Int interrupt is enabled.
            REV2_INT: u1,
            ///  When 1, the MAXPOS_Int interrupt is enabled.
            MAXPOS_INT: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u16,
        }),
        ///  Interrupt status clear register
        CLR: mmio.Mmio(packed struct(u32) {
            ///  Writing a 1 clears the INX_Int bit in QEIINTSTAT.
            INX_INT: u1,
            ///  Writing a 1 clears the TIN_Int bit in QEIINTSTAT.
            TIM_INT: u1,
            ///  Writing a 1 clears the VELC_Int bit in QEIINTSTAT.
            VELC_INT: u1,
            ///  Writing a 1 clears the DIR_Int bit in QEIINTSTAT.
            DIR_INT: u1,
            ///  Writing a 1 clears the ERR_Int bit in QEIINTSTAT.
            ERR_INT: u1,
            ///  Writing a 1 clears the ENCLK_Int bit in QEIINTSTAT.
            ENCLK_INT: u1,
            ///  Writing a 1 clears the POS0_Int bit in QEIINTSTAT.
            POS0_INT: u1,
            ///  Writing a 1 clears the POS1_Int bit in QEIINTSTAT.
            POS1_INT: u1,
            ///  Writing a 1 clears the POS2_Int bit in QEIINTSTAT.
            POS2_INT: u1,
            ///  Writing a 1 clears the REV0_Int bit in QEIINTSTAT.
            REV0_INT: u1,
            ///  Writing a 1 clears the POS0REV_Int bit in QEIINTSTAT.
            POS0REV_INT: u1,
            ///  Writing a 1 clears the POS1REV_Int bit in QEIINTSTAT.
            POS1REV_INT: u1,
            ///  Writing a 1 clears the POS2REV_Int bit in QEIINTSTAT.
            POS2REV_INT: u1,
            ///  Writing a 1 clears the REV1_Int bit in QEIINTSTAT.
            REV1_INT: u1,
            ///  Writing a 1 clears the REV2_Int bit in QEIINTSTAT.
            REV2_INT: u1,
            ///  Writing a 1 clears the MAXPOS_Int bit in QEIINTSTAT.
            MAXPOS_INT: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u16,
        }),
        ///  Interrupt status set register
        SET: mmio.Mmio(packed struct(u32) {
            ///  Writing a 1 sets the INX_Int bit in QEIINTSTAT.
            INX_INT: u1,
            ///  Writing a 1 sets the TIN_Int bit in QEIINTSTAT.
            TIM_INT: u1,
            ///  Writing a 1 sets the VELC_Int bit in QEIINTSTAT.
            VELC_INT: u1,
            ///  Writing a 1 sets the DIR_Int bit in QEIINTSTAT.
            DIR_INT: u1,
            ///  Writing a 1 sets the ERR_Int bit in QEIINTSTAT.
            ERR_INT: u1,
            ///  Writing a 1 sets the ENCLK_Int bit in QEIINTSTAT.
            ENCLK_INT: u1,
            ///  Writing a 1 sets the POS0_Int bit in QEIINTSTAT.
            POS0_INT: u1,
            ///  Writing a 1 sets the POS1_Int bit in QEIINTSTAT.
            POS1_INT: u1,
            ///  Writing a 1 sets the POS2_Int bit in QEIINTSTAT.
            POS2_INT: u1,
            ///  Writing a 1 sets the REV0_Int bit in QEIINTSTAT.
            REV0_INT: u1,
            ///  Writing a 1 sets the POS0REV_Int bit in QEIINTSTAT.
            POS0REV_INT: u1,
            ///  Writing a 1 sets the POS1REV_Int bit in QEIINTSTAT.
            POS1REV_INT: u1,
            ///  Writing a 1 sets the POS2REV_Int bit in QEIINTSTAT.
            POS2REV_INT: u1,
            ///  Writing a 1 sets the REV1_Int bit in QEIINTSTAT.
            REV1_INT: u1,
            ///  Writing a 1 sets the REV2_Int bit in QEIINTSTAT.
            REV2_INT: u1,
            ///  Writing a 1 sets the MAXPOS_Int bit in QEIINTSTAT.
            MAXPOS_INT: u1,
            ///  Reserved. Read value is undefined, only zero should be written.
            RESERVED: u16,
        }),
    };

    ///  Motor Control PWM
    pub const MCPWM = extern struct {
        ///  PWM Control read address
        CON: mmio.Mmio(packed struct(u32) {
            ///  Stops/starts timer channel 0.
            RUN0: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Stop.
                    STOP_ = 0x0,
                    ///  Run.
                    RUN_ = 0x1,
                },
            },
            ///  Edge/center aligned operation for channel 0.
            CENTER0: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Edge-aligned.
                    EDGE_ALIGNED_ = 0x0,
                    ///  Center-aligned.
                    CENTER_ALIGNED_ = 0x1,
                },
            },
            ///  Selects polarity of the MCOA0 and MCOB0 pins.
            POLA0: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Passive state is LOW, active state is HIGH.
                    PASSIVE_STATE_IS_LOW = 0x0,
                    ///  Passive state is HIGH, active state is LOW.
                    PASSIVE_STATE_IS_HIG = 0x1,
                },
            },
            ///  Controls the dead-time feature for channel 0.
            DTE0: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Dead-time disabled.
                    DEAD_TIME_DISABLED_ = 0x0,
                    ///  Dead-time enabled.
                    DEAD_TIME_ENABLED_ = 0x1,
                },
            },
            ///  Enable/disable updates of functional registers for channel 0 (see Section 24.8.2).
            DISUP0: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Functional registers are updated from the write registers at the end of each PWM cycle.
                    UPDATE = 0x0,
                    ///  Functional registers remain the same as long as the timer is running.
                    NOUPDATE = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u3,
            ///  Stops/starts timer channel 1.
            RUN1: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Stop.
                    STOP_ = 0x0,
                    ///  Run.
                    RUN_ = 0x1,
                },
            },
            ///  Edge/center aligned operation for channel 1.
            CENTER1: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Edge-aligned.
                    EDGE_ALIGNED_ = 0x0,
                    ///  Center-aligned.
                    CENTER_ALIGNED_ = 0x1,
                },
            },
            ///  Selects polarity of the MCOA1 and MCOB1 pins.
            POLA1: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Passive state is LOW, active state is HIGH.
                    PASSIVE_STATE_IS_LOW = 0x0,
                    ///  Passive state is HIGH, active state is LOW.
                    PASSIVE_STATE_IS_HIG = 0x1,
                },
            },
            ///  Controls the dead-time feature for channel 1.
            DTE1: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Dead-time disabled.
                    DEAD_TIME_DISABLED_ = 0x0,
                    ///  Dead-time enabled.
                    DEAD_TIME_ENABLED_ = 0x1,
                },
            },
            ///  Enable/disable updates of functional registers for channel 1 (see Section 24.8.2).
            DISUP1: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Functional registers are updated from the write registers at the end of each PWM cycle.
                    UPDATE = 0x0,
                    ///  Functional registers remain the same as long as the timer is running.
                    NOUPDATE = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u3,
            ///  Stops/starts timer channel 2.
            RUN2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Stop.
                    STOP_ = 0x0,
                    ///  Run.
                    RUN_ = 0x1,
                },
            },
            ///  Edge/center aligned operation for channel 2.
            CENTER2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Edge-aligned.
                    EDGE_ALIGNED_ = 0x0,
                    ///  Center-aligned.
                    CENTER_ALIGNED_ = 0x1,
                },
            },
            ///  Selects polarity of the MCOA2 and MCOB2 pins.
            POLA2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Passive state is LOW, active state is HIGH.
                    PASSIVE_STATE_IS_LOW = 0x0,
                    ///  Passive state is HIGH, active state is LOW.
                    PASSIVE_STATE_IS_HIG = 0x1,
                },
            },
            ///  Controls the dead-time feature for channel 1.
            DTE2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Dead-time disabled.
                    DEAD_TIME_DISABLED_ = 0x0,
                    ///  Dead-time enabled.
                    DEAD_TIME_ENABLED_ = 0x1,
                },
            },
            ///  Enable/disable updates of functional registers for channel 2 (see Section 24.8.2).
            DISUP2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Functional registers are updated from the write registers at the end of each PWM cycle.
                    UPDATE = 0x0,
                    ///  Functional registers remain the same as long as the timer is running.
                    NOUPDATE = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u8,
            ///  Controls the polarity of the MCOB outputs for all 3 channels. This bit is typically set to 1 only in 3-phase DC mode.
            INVBDC: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The MCOB outputs have opposite polarity from the MCOA outputs (aside from dead time).
                    OPPOSITE = 0x0,
                    ///  The MCOB outputs have the same basic polarity as the MCOA outputs. (see Section 24.8.6)
                    SAME = 0x1,
                },
            },
            ///  3-phase AC mode select (see Section 24.8.7).
            ACMODE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  3-phase AC-mode off: Each PWM channel uses its own timer-counter and period register.
                    @"3_PHASE_AC_MODE_OFF" = 0x0,
                    ///  3-phase AC-mode on: All PWM channels use the timer-counter and period register of channel 0.
                    @"3_PHASE_AC_MODE_ON_" = 0x1,
                },
            },
            ///  3-phase DC mode select (see Section 24.8.6).
            DCMODE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  3-phase DC mode off: PWM channels are independent (unless bit ACMODE = 1)
                    @"3_PHASE_DC_MODE_OFF" = 0x0,
                    ///  3-phase DC mode on: The internal MCOA0 output is routed through the CP register (i.e. a mask) register to all six PWM outputs.
                    @"3_PHASE_DC_MODE_ON_" = 0x1,
                },
            },
        }),
        ///  PWM Control set address
        CON_SET: mmio.Mmio(packed struct(u32) {
            ///  Writing a one sets the corresponding bit in the CON register.
            RUN0_SET: u1,
            ///  Writing a one sets the corresponding bit in the CON register.
            CENTER0_SET: u1,
            ///  Writing a one sets the corresponding bit in the CON register.
            POLA0_SET: u1,
            ///  Writing a one sets the corresponding bit in the CON register.
            DTE0_SET: u1,
            ///  Writing a one sets the corresponding bit in the CON register.
            DISUP0_SET: u1,
            ///  Writing a one sets the corresponding bit in the CON register.
            RESERVED: u3,
            ///  Writing a one sets the corresponding bit in the CON register.
            RUN1_SET: u1,
            ///  Writing a one sets the corresponding bit in the CON register.
            CENTER1_SET: u1,
            ///  Writing a one sets the corresponding bit in the CON register.
            POLA1_SET: u1,
            ///  Writing a one sets the corresponding bit in the CON register.
            DTE1_SET: u1,
            ///  Writing a one sets the corresponding bit in the CON register.
            DISUP1_SET: u1,
            ///  Writing a one sets the corresponding bit in the CON register.
            RESERVED: u3,
            ///  Writing a one sets the corresponding bit in the CON register.
            RUN2_SET: u1,
            ///  Writing a one sets the corresponding bit in the CON register.
            CENTER2_SET: u1,
            ///  Writing a one sets the corresponding bit in the CON register.
            POLA2_SET: u1,
            ///  Writing a one sets the corresponding bit in the CON register.
            DTE2_SET: u1,
            ///  Writing a one sets the corresponding bit in the CON register.
            DISUP2_SET: u1,
            ///  Writing a one sets the corresponding bit in the CON register.
            RESERVED: u8,
            ///  Writing a one sets the corresponding bit in the CON register.
            INVBDC_SET: u1,
            ///  Writing a one sets the corresponding bit in the CON register.
            ACMODE_SET: u1,
            ///  Writing a one sets the corresponding bit in the CON register.
            DCMODE_SET: u1,
        }),
        ///  PWM Control clear address
        CON_CLR: mmio.Mmio(packed struct(u32) {
            ///  Writing a one clears the corresponding bit in the CON register.
            RUN0_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CON register.
            CENTER0_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CON register.
            POLA0_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CON register.
            DTE0_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CON register.
            DISUP0_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CON register.
            RESERVED: u3,
            ///  Writing a one clears the corresponding bit in the CON register.
            RUN1_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CON register.
            CENTER1_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CON register.
            POLA1_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CON register.
            DTE1_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CON register.
            DISUP1_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CON register.
            RESERVED: u3,
            ///  Writing a one clears the corresponding bit in the CON register.
            RUN2_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CON register.
            CENTER2_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CON register.
            POLA2_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CON register.
            DTE2_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CON register.
            DISUP2_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CON register.
            RESERVED: u8,
            ///  Writing a one clears the corresponding bit in the CON register.
            INVBDC_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CON register.
            ACMOD_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CON register.
            DCMODE_CLR: u1,
        }),
        ///  Capture Control read address
        CAPCON: mmio.Mmio(packed struct(u32) {
            ///  A 1 in this bit enables a channel 0 capture event on a rising edge on MCI0.
            CAP0MCI0_RE: u1,
            ///  A 1 in this bit enables a channel 0 capture event on a falling edge on MCI0.
            CAP0MCI0_FE: u1,
            ///  A 1 in this bit enables a channel 0 capture event on a rising edge on MCI1.
            CAP0MCI1_RE: u1,
            ///  A 1 in this bit enables a channel 0 capture event on a falling edge on MCI1.
            CAP0MCI1_FE: u1,
            ///  A 1 in this bit enables a channel 0 capture event on a rising edge on MCI2.
            CAP0MCI2_RE: u1,
            ///  A 1 in this bit enables a channel 0 capture event on a falling edge on MCI2.
            CAP0MCI2_FE: u1,
            ///  A 1 in this bit enables a channel 1 capture event on a rising edge on MCI0.
            CAP1MCI0_RE: u1,
            ///  A 1 in this bit enables a channel 1 capture event on a falling edge on MCI0.
            CAP1MCI0_FE: u1,
            ///  A 1 in this bit enables a channel 1 capture event on a rising edge on MCI1.
            CAP1MCI1_RE: u1,
            ///  A 1 in this bit enables a channel 1 capture event on a falling edge on MCI1.
            CAP1MCI1_FE: u1,
            ///  A 1 in this bit enables a channel 1 capture event on a rising edge on MCI2.
            CAP1MCI2_RE: u1,
            ///  A 1 in this bit enables a channel 1 capture event on a falling edge on MCI2.
            CAP1MCI2_FE: u1,
            ///  A 1 in this bit enables a channel 2 capture event on a rising edge on MCI0.
            CAP2MCI0_RE: u1,
            ///  A 1 in this bit enables a channel 2 capture event on a falling edge on MCI0.
            CAP2MCI0_FE: u1,
            ///  A 1 in this bit enables a channel 2 capture event on a rising edge on MCI1.
            CAP2MCI1_RE: u1,
            ///  A 1 in this bit enables a channel 2 capture event on a falling edge on MCI1.
            CAP2MCI1_FE: u1,
            ///  A 1 in this bit enables a channel 2 capture event on a rising edge on MCI2.
            CAP2MCI2_RE: u1,
            ///  A 1 in this bit enables a channel 2 capture event on a falling edge on MCI2.
            CAP2MCI2_FE: u1,
            ///  If this bit is 1, TC0 is reset by a channel 0 capture event.
            RT0: u1,
            ///  If this bit is 1, TC1 is reset by a channel 1 capture event.
            RT1: u1,
            ///  If this bit is 1, TC2 is reset by a channel 2 capture event.
            RT2: u1,
            ///  Reserved.
            RESERVED: u11,
        }),
        ///  Capture Control set address
        CAPCON_SET: mmio.Mmio(packed struct(u32) {
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            CAP0MCI0_RE_SET: u1,
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            CAP0MCI0_FE_SET: u1,
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            CAP0MCI1_RE_SET: u1,
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            CAP0MCI1_FE_SET: u1,
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            CAP0MCI2_RE_SET: u1,
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            CAP0MCI2_FE_SET: u1,
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            CAP1MCI0_RE_SET: u1,
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            CAP1MCI0_FE_SET: u1,
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            CAP1MCI1_RE_SET: u1,
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            CAP1MCI1_FE_SET: u1,
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            CAP1MCI2_RE_SET: u1,
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            CAP1MCI2_FE_SET: u1,
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            CAP2MCI0_RE_SET: u1,
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            CAP2MCI0_FE_SET: u1,
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            CAP2MCI1_RE_SET: u1,
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            CAP2MCI1_FE_SET: u1,
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            CAP2MCI2_RE_SET: u1,
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            CAP2MCI2_FE_SET: u1,
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            RT0_SET: u1,
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            RT1_SET: u1,
            ///  Writing a one sets the corresponding bits in the CAPCON register.
            RT2_SET: u1,
            ///  Reserved.
            RESERVED: u11,
        }),
        ///  Event Control clear address
        CAPCON_CLR: mmio.Mmio(packed struct(u32) {
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            CAP0MCI0_RE_CLR: u1,
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            CAP0MCI0_FE_CLR: u1,
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            CAP0MCI1_RE_CLR: u1,
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            CAP0MCI1_FE_CLR: u1,
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            CAP0MCI2_RE_CLR: u1,
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            CAP0MCI2_FE_CLR: u1,
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            CAP1MCI0_RE_CLR: u1,
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            CAP1MCI0_FE_CLR: u1,
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            CAP1MCI1_RE_CLR: u1,
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            CAP1MCI1_FE_CLR: u1,
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            CAP1MCI2_RE_CLR: u1,
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            CAP1MCI2_FE_CLR: u1,
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            CAP2MCI0_RE_CLR: u1,
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            CAP2MCI0_FE_CLR: u1,
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            CAP2MCI1_RE_CLR: u1,
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            CAP2MCI1_FE_CLR: u1,
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            CAP2MCI2_RE_CLR: u1,
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            CAP2MCI2_FE_CLR: u1,
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            RT0_CLR: u1,
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            RT1_CLR: u1,
            ///  Writing a one clears the corresponding bits in the CAPCON register.
            RT2_CLR: u1,
            ///  Reserved.
            RESERVED: u11,
        }),
        reserved60: [36]u8,
        ///  Dead time register
        DT: mmio.Mmio(packed struct(u32) {
            ///  Dead time for channel 0.[1]
            DT0: u10,
            ///  Dead time for channel 1.[2]
            DT1: u10,
            ///  Dead time for channel 2.[2]
            DT2: u10,
            ///  reserved
            RESERVED: u2,
        }),
        ///  Communication Pattern register
        CP: mmio.Mmio(packed struct(u32) {
            ///  Communication pattern output A, channel 0.
            CCPA0: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  MCOA0 passive.
                    MCOA0_PASSIVE_ = 0x0,
                    ///  internal MCOA0.
                    INTERNAL_MCOA0_ = 0x1,
                },
            },
            ///  Communication pattern output B, channel 0.
            CCPB0: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  MCOB0 passive.
                    MCOB0_PASSIVE_ = 0x0,
                    ///  MCOB0 tracks internal MCOA0.
                    MCOB0_TRACKS_INTERNA = 0x1,
                },
            },
            ///  Communication pattern output A, channel 1.
            CCPA1: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  MCOA1 passive.
                    MCOA1_PASSIVE_ = 0x0,
                    ///  MCOA1 tracks internal MCOA0.
                    MCOA1_TRACKS_INTERNA = 0x1,
                },
            },
            ///  Communication pattern output B, channel 1.
            CCPB1: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  MCOB1 passive.
                    MCOB1_PASSIVE_ = 0x0,
                    ///  MCOB1 tracks internal MCOA0.
                    MCOB1_TRACKS_INTERNA = 0x1,
                },
            },
            ///  Communication pattern output A, channel 2.
            CCPA2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  MCOA2 passive.
                    MCOA2_PASSIVE_ = 0x0,
                    ///  MCOA2 tracks internal MCOA0.
                    MCOA2_TRACKS_INTERNA = 0x1,
                },
            },
            ///  Communication pattern output B, channel 2.
            CCPB2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  MCOB2 passive.
                    MCOB2_PASSIVE_ = 0x0,
                    ///  MCOB2 tracks internal MCOA0.
                    MCOB2_TRACKS_INTERNA = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u26,
        }),
        reserved80: [12]u8,
        ///  Interrupt Enable read address
        INTEN: mmio.Mmio(packed struct(u32) {
            ///  Limit interrupt for channel 0.
            ILIM0: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Interrupt disabled.
                    INTERRUPT_DISABLED_ = 0x0,
                    ///  Interrupt enabled.
                    INTERRUPT_ENABLED_ = 0x1,
                },
            },
            ///  Match interrupt for channel 0.
            IMAT0: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Interrupt disabled.
                    INTERRUPT_DISABLED_ = 0x0,
                    ///  Interrupt enabled.
                    INTERRUPT_ENABLED_ = 0x1,
                },
            },
            ///  Capture interrupt for channel 0.
            ICAP0: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Interrupt disabled.
                    INTERRUPT_DISABLED_ = 0x0,
                    ///  Interrupt enabled.
                    INTERRUPT_ENABLED_ = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u1,
            ///  Limit interrupt for channel 1.
            ILIM1: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Interrupt disabled.
                    INTERRUPT_DISABLED_ = 0x0,
                    ///  Interrupt enabled.
                    INTERRUPT_ENABLED_ = 0x1,
                },
            },
            ///  Match interrupt for channel 1.
            IMAT1: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Interrupt disabled.
                    INTERRUPT_DISABLED_ = 0x0,
                    ///  Interrupt enabled.
                    INTERRUPT_ENABLED_ = 0x1,
                },
            },
            ///  Capture interrupt for channel 1.
            ICAP1: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Interrupt disabled.
                    INTERRUPT_DISABLED_ = 0x0,
                    ///  Interrupt enabled.
                    INTERRUPT_ENABLED_ = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u1,
            ///  Limit interrupt for channel 2.
            ILIM2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Interrupt disabled.
                    INTERRUPT_DISABLED_ = 0x0,
                    ///  Interrupt enabled.
                    INTERRUPT_ENABLED_ = 0x1,
                },
            },
            ///  Match interrupt for channel 2.
            IMAT2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Interrupt disabled.
                    INTERRUPT_DISABLED_ = 0x0,
                    ///  Interrupt enabled.
                    INTERRUPT_ENABLED_ = 0x1,
                },
            },
            ///  Capture interrupt for channel 2.
            ICAP2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Interrupt disabled.
                    INTERRUPT_DISABLED_ = 0x0,
                    ///  Interrupt enabled.
                    INTERRUPT_ENABLED_ = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u4,
            ///  Fast abort interrupt.
            ABORT: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Interrupt disabled.
                    INTERRUPT_DISABLED_ = 0x0,
                    ///  Interrupt enabled.
                    INTERRUPT_ENABLED_ = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u16,
        }),
        ///  Interrupt Enable set address
        INTEN_SET: mmio.Mmio(packed struct(u32) {
            ///  Writing a one sets the corresponding bit in INTEN, thus enabling the interrupt.
            ILIM0_SET: u1,
            ///  Writing a one sets the corresponding bit in INTEN, thus enabling the interrupt.
            IMAT0_SET: u1,
            ///  Writing a one sets the corresponding bit in INTEN, thus enabling the interrupt.
            ICAP0_SET: u1,
            ///  Reserved.
            RESERVED: u1,
            ///  Writing a one sets the corresponding bit in INTEN, thus enabling the interrupt.
            ILIM1_SET: u1,
            ///  Writing a one sets the corresponding bit in INTEN, thus enabling the interrupt.
            IMAT1_SET: u1,
            ///  Writing a one sets the corresponding bit in INTEN, thus enabling the interrupt.
            ICAP1_SET: u1,
            ///  Reserved.
            RESERVED: u1,
            reserved9: u1,
            ///  Writing a one sets the corresponding bit in INTEN, thus enabling the interrupt.
            ILIM2_SET: u1,
            ///  Writing a one sets the corresponding bit in INTEN, thus enabling the interrupt.
            IMAT2_SET: u1,
            ///  Writing a one sets the corresponding bit in INTEN, thus enabling the interrupt.
            ICAP2_SET: u1,
            ///  Reserved.
            RESERVED: u3,
            ///  Writing a one sets the corresponding bit in INTEN, thus enabling the interrupt.
            ABORT_SET: u1,
            ///  Reserved.
            RESERVED: u16,
        }),
        ///  Interrupt Enable clear address
        INTEN_CLR: mmio.Mmio(packed struct(u32) {
            ///  Writing a one clears the corresponding bit in INTEN, thus disabling the interrupt.
            ILIM0_CLR: u1,
            ///  Writing a one clears the corresponding bit in INTEN, thus disabling the interrupt.
            IMAT0_CLR: u1,
            ///  Writing a one clears the corresponding bit in INTEN, thus disabling the interrupt.
            ICAP0_CLR: u1,
            ///  Reserved.
            RESERVED: u1,
            ///  Writing a one clears the corresponding bit in INTEN, thus disabling the interrupt.
            ILIM1_CLR: u1,
            ///  Writing a one clears the corresponding bit in INTEN, thus disabling the interrupt.
            IMAT1_CLR: u1,
            ///  Writing a one clears the corresponding bit in INTEN, thus disabling the interrupt.
            ICAP1_CLR: u1,
            ///  Reserved.
            RESERVED: u1,
            ///  Writing a one clears the corresponding bit in INTEN, thus disabling the interrupt.
            ILIM2_CLR: u1,
            ///  Writing a one clears the corresponding bit in INTEN, thus disabling the interrupt.
            IMAT2_CLR: u1,
            ///  Writing a one clears the corresponding bit in INTEN, thus disabling the interrupt.
            ICAP2_CLR: u1,
            ///  Reserved.
            RESERVED: u4,
            ///  Writing a one clears the corresponding bit in INTEN, thus disabling the interrupt.
            ABORT_CLR: u1,
            ///  Reserved.
            RESERVED: u16,
        }),
        ///  Count Control read address
        CNTCON: mmio.Mmio(packed struct(u32) {
            ///  Counter 0 rising edge mode, channel 0.
            TC0MCI0_RE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A rising edge on MCI0 does not affect counter 0.
                    A_RISING_EDGE_ON_MCI = 0x0,
                    ///  If MODE0 is 1, counter 0 advances on a rising edge on MCI0.
                    RISING = 0x1,
                },
            },
            ///  Counter 0 falling edge mode, channel 0.
            TC0MCI0_FE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A falling edge on MCI0 does not affect counter 0.
                    A_FALLING_EDGE_ON_MC = 0x0,
                    ///  If MODE0 is 1, counter 0 advances on a falling edge on MCI0.
                    FALLING = 0x1,
                },
            },
            ///  Counter 0 rising edge mode, channel 1.
            TC0MCI1_RE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A rising edge on MCI1 does not affect counter 0.
                    A_RISING_EDGE_ON_MCI = 0x0,
                    ///  If MODE0 is 1, counter 0 advances on a rising edge on MCI1.
                    RISING = 0x1,
                },
            },
            ///  Counter 0 falling edge mode, channel 1.
            TC0MCI1_FE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A falling edge on MCI1 does not affect counter 0.
                    A_FALLING_EDGE_ON_MC = 0x0,
                    ///  If MODE0 is 1, counter 0 advances on a falling edge on MCI1.
                    FALLING = 0x1,
                },
            },
            ///  Counter 0 rising edge mode, channel 2.
            TC0MCI2_RE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A rising edge on MCI0 does not affect counter 0.
                    A_RISING_EDGE_ON_MCI = 0x0,
                    ///  If MODE0 is 1, counter 0 advances on a rising edge on MCI2.
                    RISING = 0x1,
                },
            },
            ///  Counter 0 falling edge mode, channel 2.
            TC0MCI2_FE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A falling edge on MCI0 does not affect counter 0.
                    A_FALLING_EDGE_ON_MC = 0x0,
                    ///  If MODE0 is 1, counter 0 advances on a falling edge on MCI2.
                    FALLLING = 0x1,
                },
            },
            ///  Counter 1 rising edge mode, channel 0.
            TC1MCI0_RE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A rising edge on MCI0 does not affect counter 1.
                    A_RISING_EDGE_ON_MCI = 0x0,
                    ///  If MODE1 is 1, counter 1 advances on a rising edge on MCI0.
                    RISING = 0x1,
                },
            },
            ///  Counter 1 falling edge mode, channel 0.
            TC1MCI0_FE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A falling edge on MCI0 does not affect counter 1.
                    A_FALLING_EDGE_ON_MC = 0x0,
                    ///  If MODE1 is 1, counter 1 advances on a falling edge on MCI0.
                    FALLING = 0x1,
                },
            },
            ///  Counter 1 rising edge mode, channel 1.
            TC1MCI1_RE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A rising edge on MCI1 does not affect counter 1.
                    A_RISING_EDGE_ON_MCI = 0x0,
                    ///  If MODE1 is 1, counter 1 advances on a rising edge on MCI1.
                    RISING = 0x1,
                },
            },
            ///  Counter 1 falling edge mode, channel 1.
            TC1MCI1_FE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A falling edge on MCI0 does not affect counter 1.
                    A_FALLING_EDGE_ON_MC = 0x0,
                    ///  If MODE1 is 1, counter 1 advances on a falling edge on MCI1.
                    FALLING = 0x1,
                },
            },
            ///  Counter 1 rising edge mode, channel 2.
            TC1MCI2_RE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A rising edge on MCI2 does not affect counter 1.
                    A_RISING_EDGE_ON_MCI = 0x0,
                    ///  If MODE1 is 1, counter 1 advances on a rising edge on MCI2.
                    RISING = 0x1,
                },
            },
            ///  Counter 1 falling edge mode, channel 2.
            TC1MCI2_FE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A falling edge on MCI2 does not affect counter 1.
                    A_FALLING_EDGE_ON_MC = 0x0,
                    ///  If MODE1 is 1, counter 1 advances on a falling edge on MCI2.
                    FALLING = 0x1,
                },
            },
            ///  Counter 2 rising edge mode, channel 0.
            TC2MCI0_RE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A rising edge on MCI0 does not affect counter 2.
                    A_RISING_EDGE_ON_MCI = 0x0,
                    ///  If MODE2 is 1, counter 2 advances on a rising edge on MCI0.
                    RISING = 0x1,
                },
            },
            ///  Counter 2 falling edge mode, channel 0.
            TC2MCI0_FE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A falling edge on MCI0 does not affect counter 2.
                    A_FALLING_EDGE_ON_MC = 0x0,
                    ///  If MODE2 is 1, counter 2 advances on a falling edge on MCI0.
                    FALLING = 0x1,
                },
            },
            ///  Counter 2 rising edge mode, channel 1.
            TC2MCI1_RE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A rising edge on MCI1 does not affect counter 2.
                    A_RISING_EDGE_ON_MCI = 0x0,
                    ///  If MODE2 is 1, counter 2 advances on a rising edge on MCI1.
                    RISING = 0x1,
                },
            },
            ///  Counter 2 falling edge mode, channel 1.
            TC2MCI1_FE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A falling edge on MCI1 does not affect counter 2.
                    A_FALLING_EDGE_ON_MC = 0x0,
                    ///  If MODE2 is 1, counter 2 advances on a falling edge on MCI1.
                    FALLING = 0x1,
                },
            },
            ///  Counter 2 rising edge mode, channel 2.
            TC2MCI2_RE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A rising edge on MCI2 does not affect counter 2.
                    A_RISING_EDGE_ON_MCI = 0x0,
                    ///  If MODE2 is 1, counter 2 advances on a rising edge on MCI2.
                    RISIING = 0x1,
                },
            },
            ///  Counter 2 falling edge mode, channel 2.
            TC2MCI2_FE: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  A falling edge on MCI2 does not affect counter 2.
                    A_FALLING_EDGE_ON_MC = 0x0,
                    ///  If MODE2 is 1, counter 2 advances on a falling edge on MCI2.
                    FALLING = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u11,
            ///  Channel 0 counter/timer mode.
            CNTR0: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Channel 0 is in timer mode.
                    CHANNEL_0_IS_IN_TIME = 0x0,
                    ///  Channel 0 is in counter mode.
                    CHANNEL_0_IS_IN_COUN = 0x1,
                },
            },
            ///  Channel 1 counter/timer mode.
            CNTR1: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Channel 1 is in timer mode.
                    CHANNEL_1_IS_IN_TIME = 0x0,
                    ///  Channel 1 is in counter mode.
                    CHANNEL_1_IS_IN_COUN = 0x1,
                },
            },
            ///  Channel 2 counter/timer mode.
            CNTR2: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Channel 2 is in timer mode.
                    CHANNEL_2_IS_IN_TIME = 0x0,
                    ///  Channel 2 is in counter mode.
                    CHANNEL_2_IS_IN_COUN = 0x1,
                },
            },
        }),
        ///  Count Control set address
        CNTCON_SET: mmio.Mmio(packed struct(u32) {
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            TC0MCI0_RE_SET: u1,
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            TC0MCI0_FE_SET: u1,
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            TC0MCI1_RE_SET: u1,
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            TC0MCI1_FE_SET: u1,
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            TC0MCI2_RE_SET: u1,
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            TC0MCI2_FE_SET: u1,
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            TC1MCI0_RE_SET: u1,
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            TC1MCI0_FE_SET: u1,
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            TC1MCI1_RE_SET: u1,
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            TC1MCI1_FE_SET: u1,
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            TC1MCI2_RE_SET: u1,
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            TC1MCI2_FE_SET: u1,
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            TC2MCI0_RE_SET: u1,
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            TC2MCI0_FE_SET: u1,
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            TC2MCI1_RE_SET: u1,
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            TC2MCI1_FE_SET: u1,
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            TC2MCI2_RE_SET: u1,
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            TC2MCI2_FE_SET: u1,
            ///  Reserved.
            RESERVED: u11,
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            CNTR0_SET: u1,
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            CNTR1_SET: u1,
            ///  Writing a one sets the corresponding bit in the CNTCON register.
            CNTR2_SET: u1,
        }),
        ///  Count Control clear address
        CNTCON_CLR: mmio.Mmio(packed struct(u32) {
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            TC0MCI0_RE_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            TC0MCI0_FE_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            TC0MCI1_RE_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            TC0MCI1_FE_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            TC0MCI2_RE: u1,
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            TC0MCI2_FE_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            TC1MCI0_RE_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            TC1MCI0_FE_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            TC1MCI1_RE_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            TC1MCI1_FE_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            TC1MCI2_RE_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            TC1MCI2_FE_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            TC2MCI0_RE_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            TC2MCI0_FE_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            TC2MCI1_RE_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            TC2MCI1_FE_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            TC2MCI2_RE_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            TC2MCI2_FE_CLR: u1,
            ///  Reserved.
            RESERVED: u11,
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            CNTR0_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            CNTR1_CLR: u1,
            ///  Writing a one clears the corresponding bit in the CNTCON register.
            CNTR2_CLR: u1,
        }),
        ///  Interrupt flags read address
        INTF: mmio.Mmio(packed struct(u32) {
            ///  Limit interrupt flag for channel 0.
            ILIM0_F: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  This interrupt source is not contributing to the MCPWM interrupt request.
                    THIS_INTERRUPT_SOURC = 0x0,
                    ///  If the corresponding bit in INTEN is 1, the MCPWM module is asserting its interrupt request to the Interrupt Controller.
                    IF_THE_CORRESPONDING = 0x1,
                },
            },
            ///  Match interrupt flag for channel 0.
            IMAT0_F: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  This interrupt source is not contributing to the MCPWM interrupt request.
                    THIS_INTERRUPT_SOURC = 0x0,
                    ///  If the corresponding bit in INTEN is 1, the MCPWM module is asserting its interrupt request to the Interrupt Controller.
                    IF_THE_CORRESPONDING = 0x1,
                },
            },
            ///  Capture interrupt flag for channel 0.
            ICAP0_F: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  This interrupt source is not contributing to the MCPWM interrupt request.
                    THIS_INTERRUPT_SOURC = 0x0,
                    ///  If the corresponding bit in INTEN is 1, the MCPWM module is asserting its interrupt request to the Interrupt Controller.
                    IF_THE_CORRESPONDING = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u1,
            ///  Limit interrupt flag for channel 1.
            ILIM1_F: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  This interrupt source is not contributing to the MCPWM interrupt request.
                    THIS_INTERRUPT_SOURC = 0x0,
                    ///  If the corresponding bit in INTEN is 1, the MCPWM module is asserting its interrupt request to the Interrupt Controller.
                    IF_THE_CORRESPONDING = 0x1,
                },
            },
            ///  Match interrupt flag for channel 1.
            IMAT1_F: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  This interrupt source is not contributing to the MCPWM interrupt request.
                    THIS_INTERRUPT_SOURC = 0x0,
                    ///  If the corresponding bit in INTEN is 1, the MCPWM module is asserting its interrupt request to the Interrupt Controller.
                    IF_THE_CORRESPONDING = 0x1,
                },
            },
            ///  Capture interrupt flag for channel 1.
            ICAP1_F: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  This interrupt source is not contributing to the MCPWM interrupt request.
                    THIS_INTERRUPT_SOURC = 0x0,
                    ///  If the corresponding bit in INTEN is 1, the MCPWM module is asserting its interrupt request to the Interrupt Controller.
                    IF_THE_CORRESPONDING = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u1,
            ///  Limit interrupt flag for channel 2.
            ILIM2_F: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  This interrupt source is not contributing to the MCPWM interrupt request.
                    THIS_INTERRUPT_SOURC = 0x0,
                    ///  If the corresponding bit in INTEN is 1, the MCPWM module is asserting its interrupt request to the Interrupt Controller.
                    IF_THE_CORRESPONDING = 0x1,
                },
            },
            ///  Match interrupt flag for channel 2.
            IMAT2_F: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  This interrupt source is not contributing to the MCPWM interrupt request.
                    THIS_INTERRUPT_SOURC = 0x0,
                    ///  If the corresponding bit in INTEN is 1, the MCPWM module is asserting its interrupt request to the Interrupt Controller.
                    IF_THE_CORRESPONDING = 0x1,
                },
            },
            ///  Capture interrupt flag for channel 2.
            ICAP2_F: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  This interrupt source is not contributing to the MCPWM interrupt request.
                    THIS_INTERRUPT_SOURC = 0x0,
                    ///  If the corresponding bit in INTEN is 1, the MCPWM module is asserting its interrupt request to the Interrupt Controller.
                    IF_THE_CORRESPONDING = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u4,
            ///  Fast abort interrupt flag.
            ABORT_F: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  This interrupt source is not contributing to the MCPWM interrupt request.
                    THIS_INTERRUPT_SOURC = 0x0,
                    ///  If the corresponding bit in INTEN is 1, the MCPWM module is asserting its interrupt request to the Interrupt Controller.
                    IF_THE_CORRESPONDING = 0x1,
                },
            },
            ///  Reserved.
            RESERVED: u16,
        }),
        ///  Interrupt flags set address
        INTF_SET: mmio.Mmio(packed struct(u32) {
            ///  Writing a one sets the corresponding bit in the INTF register, thus possibly simulating hardware interrupt.
            ILIM0_F_SET: u1,
            ///  Writing a one sets the corresponding bit in the INTF register, thus possibly simulating hardware interrupt.
            IMAT0_F_SET: u1,
            ///  Writing a one sets the corresponding bit in the INTF register, thus possibly simulating hardware interrupt.
            ICAP0_F_SET: u1,
            ///  Reserved.
            RESERVED: u1,
            ///  Writing a one sets the corresponding bit in the INTF register, thus possibly simulating hardware interrupt.
            ILIM1_F_SET: u1,
            ///  Writing a one sets the corresponding bit in the INTF register, thus possibly simulating hardware interrupt.
            IMAT1_F_SET: u1,
            ///  Writing a one sets the corresponding bit in the INTF register, thus possibly simulating hardware interrupt.
            ICAP1_F_SET: u1,
            ///  Reserved.
            RESERVED: u1,
            ///  Writing a one sets the corresponding bit in the INTF register, thus possibly simulating hardware interrupt.
            ILIM2_F_SET: u1,
            ///  Writing a one sets the corresponding bit in the INTF register, thus possibly simulating hardware interrupt.
            IMAT2_F_SET: u1,
            ///  Writing a one sets the corresponding bit in the INTF register, thus possibly simulating hardware interrupt.
            ICAP2_F_SET: u1,
            ///  Reserved.
            RESERVED: u4,
            ///  Writing a one sets the corresponding bit in the INTF register, thus possibly simulating hardware interrupt.
            ABORT_F_SET: u1,
            ///  Reserved.
            RESERVED: u16,
        }),
        ///  Interrupt flags clear address
        INTF_CLR: mmio.Mmio(packed struct(u32) {
            ///  Writing a one clears the corresponding bit in the INTF register, thus clearing the corresponding interrupt request.
            ILIM0_F_CLR: u1,
            ///  Writing a one clears the corresponding bit in INTEN, thus disabling the interrupt.
            IMAT0_F_CLR: u1,
            ///  Writing a one clears the corresponding bit in INTEN, thus disabling the interrupt.
            ICAP0_F_CLR: u1,
            ///  Reserved.
            RESERVED: u1,
            ///  Writing a one clears the corresponding bit in INTEN, thus disabling the interrupt.
            ILIM1_F_CLR: u1,
            ///  Writing a one clears the corresponding bit in INTEN, thus disabling the interrupt.
            IMAT1_F_CLR: u1,
            ///  Writing a one clears the corresponding bit in INTEN, thus disabling the interrupt.
            ICAP1_F_CLR: u1,
            ///  Reserved.
            RESERVED: u1,
            ///  Writing a one clears the corresponding bit in INTEN, thus disabling the interrupt.
            ILIM2_F_CLR: u1,
            ///  Writing a one clears the corresponding bit in INTEN, thus disabling the interrupt.
            IMAT2_F_CLR: u1,
            ///  Writing a one clears the corresponding bit in INTEN, thus disabling the interrupt.
            ICAP2_F_CLR: u1,
            ///  Writing a one clears the corresponding bit in INTEN, thus disabling the interrupt.
            RESERVED: u4,
            ///  Writing a one clears the corresponding bit in INTEN, thus disabling the interrupt.
            ABORT_F_CLR: u1,
            ///  Reserved.
            RESERVED: u16,
        }),
        ///  Capture clear address
        CAP_CLR: mmio.Mmio(packed struct(u32) {
            ///  Writing a 1 to this bit clears the CAP0 register.
            CAP_CLR0: u1,
            ///  Writing a 1 to this bit clears the CAP1 register.
            CAP_CLR1: u1,
            ///  Writing a 1 to this bit clears the CAP2 register.
            CAP_CLR2: u1,
            ///  Reserved
            RESERVED: u29,
        }),
    };

    ///  Repetitive Interrupt Timer (RIT)
    pub const RITIMER = extern struct {
        ///  Compare register
        COMPVAL: mmio.Mmio(packed struct(u32) {
            ///  Compare register. Holds the compare value which is compared to the counter.
            RICOMP: u32,
        }),
        ///  Mask register. This register holds the 32-bit mask value. A 1 written to any bit will force a compare on the corresponding bit of the counter and compare register.
        MASK: mmio.Mmio(packed struct(u32) {
            ///  Mask register. This register holds the 32-bit mask value. A one written to any bit overrides the result of the comparison for the corresponding bit of the counter and compare register (causes the comparison of the register bits to be always true).
            RIMASK: u32,
        }),
        ///  Control register.
        CTRL: mmio.Mmio(packed struct(u32) {
            ///  Interrupt flag
            RITINT: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  This bit is set to 1 by hardware whenever the counter value equals the masked compare value specified by the contents of RICOMPVAL and RIMASK registers. Writing a 1 to this bit will clear it to 0. Writing a 0 has no effect.
                    THIS_BIT_IS_SET_TO_1 = 0x1,
                    ///  The counter value does not equal the masked compare value.
                    THE_COUNTER_VALUE_DO = 0x0,
                },
            },
            ///  Timer enable clear
            RITENCLR: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The timer will be cleared to 0 whenever the counter value equals the masked compare value specified by the contents of RICOMPVAL and RIMASK registers. This will occur on the same clock that sets the interrupt flag.
                    THE_TIMER_WILL_BE_CL = 0x1,
                    ///  The timer will not be cleared to 0.
                    THE_TIMER_WILL_NOT_B = 0x0,
                },
            },
            ///  Timer enable for debug
            RITENBR: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  The timer is halted when the processor is halted for debugging.
                    THE_TIMER_IS_HALTED_ = 0x1,
                    ///  Debug has no effect on the timer operation.
                    DEBUG_HAS_NO_EFFECT_ = 0x0,
                },
            },
            ///  Timer enable.
            RITEN: packed union {
                raw: u1,
                value: enum(u1) {
                    ///  Timer enabled. This can be overruled by a debug halt if enabled in bit 2.
                    TIMER_ENABLED_THIS_ = 0x1,
                    ///  Timer disabled.
                    TIMER_DISABLED_ = 0x0,
                },
            },
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u28,
        }),
        ///  32-bit counter
        COUNTER: mmio.Mmio(packed struct(u32) {
            ///  32-bit up counter. Counts continuously unless RITEN bit in RICTRL register is cleared or debug mode is entered (if enabled by the RITNEBR bit in RICTRL). Can be loaded to any value in software.
            RICOUNTER: u32,
        }),
    };

    ///  I2S interface
    pub const I2S = extern struct {
        ///  I2S Digital Audio Output Register. Contains control bits for the I2S transmit channel.
        DAO: mmio.Mmio(packed struct(u32) {
            ///  Selects the number of bytes in data as follows:
            WORDWIDTH: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  8-bit data
                    @"8_BIT_DATA" = 0x0,
                    ///  16-bit data
                    @"16_BIT_DATA" = 0x1,
                    ///  32-bit data
                    @"32_BIT_DATA" = 0x3,
                    _,
                },
            },
            ///  When 1, data is of monaural format. When 0, the data is in stereo format.
            MONO: u1,
            ///  When 1, disables accesses on FIFOs, places the transmit channel in mute mode.
            STOP: u1,
            ///  When 1, asynchronously resets the transmit channel and FIFO.
            RESET: u1,
            ///  When 0, the interface is in master mode. When 1, the interface is in slave mode. See Section 34.7.2 for a summary of useful combinations for this bit with TXMODE.
            WS_SEL: u1,
            ///  Word select half period minus 1, i.e. WS 64clk period -> ws_halfperiod = 31.
            WS_HALFPERIOD: u9,
            ///  When 1, the transmit channel sends only zeroes.
            MUTE: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u16,
        }),
        ///  I2S Digital Audio Input Register. Contains control bits for the I2S receive channel.
        DAI: mmio.Mmio(packed struct(u32) {
            ///  Selects the number of bytes in data as follows:
            WORDWIDTH: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  8-bit data
                    @"8_BIT_DATA" = 0x0,
                    ///  16-bit data
                    @"16_BIT_DATA" = 0x1,
                    ///  32-bit data
                    @"32_BIT_DATA" = 0x3,
                    _,
                },
            },
            ///  When 1, data is of monaural format. When 0, the data is in stereo format.
            MONO: u1,
            ///  When 1, disables accesses on FIFOs, places the transmit channel in mute mode.
            STOP: u1,
            ///  When 1, asynchronously reset the transmit channel and FIFO.
            RESET: u1,
            ///  When 0, the interface is in master mode. When 1, the interface is in slave mode. See Section 34.7.2 for a summary of useful combinations for this bit with RXMODE.
            WS_SEL: u1,
            ///  Word select half period minus 1, i.e. WS 64clk period -> ws_halfperiod = 31.
            WS_HALFPERIOD: u9,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u17,
        }),
        ///  I2S Transmit FIFO. Access register for the 8 x 32-bit transmitter FIFO.
        TXFIFO: mmio.Mmio(packed struct(u32) {
            ///  8 x 32-bit transmit FIFO.
            I2STXFIFO: u32,
        }),
        ///  I2S Receive FIFO. Access register for the 8 x 32-bit receiver FIFO.
        RXFIFO: mmio.Mmio(packed struct(u32) {
            ///  8 x 32-bit transmit FIFO.
            I2SRXFIFO: u32,
        }),
        ///  I2S Status Feedback Register. Contains status information about the I2S interface.
        STATE: mmio.Mmio(packed struct(u32) {
            ///  This bit reflects the presence of Receive Interrupt or Transmit Interrupt. This is determined by comparing the current FIFO levels to the rx_depth_irq and tx_depth_irq fields in the IRQ register.
            IRQ: u1,
            ///  This bit reflects the presence of Receive or Transmit DMA Request 1. This is determined by comparing the current FIFO levels to the rx_depth_dma1 and tx_depth_dma1 fields in the DMA1 register.
            DMAREQ1: u1,
            ///  This bit reflects the presence of Receive or Transmit DMA Request 2. This is determined by comparing the current FIFO levels to the rx_depth_dma2 and tx_depth_dma2 fields in the DMA2 register.
            DMAREQ2: u1,
            ///  Reserved.
            RESERVED: u5,
            ///  Reflects the current level of the Receive FIFO.
            RX_LEVEL: u4,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u4,
            ///  Reflects the current level of the Transmit FIFO.
            TX_LEVEL: u4,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u12,
        }),
        ///  I2S DMA Configuration Register 1. Contains control information for DMA request 1.
        DMA1: mmio.Mmio(packed struct(u32) {
            ///  When 1, enables DMA1 for I2S receive.
            RX_DMA1_ENABLE: u1,
            ///  When 1, enables DMA1 for I2S transmit.
            TX_DMA1_ENABLE: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u6,
            ///  Set the FIFO level that triggers a receive DMA request on DMA1.
            RX_DEPTH_DMA1: u4,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u4,
            ///  Set the FIFO level that triggers a transmit DMA request on DMA1.
            TX_DEPTH_DMA1: u4,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u12,
        }),
        ///  I2S DMA Configuration Register 2. Contains control information for DMA request 2.
        DMA2: mmio.Mmio(packed struct(u32) {
            ///  When 1, enables DMA1 for I2S receive.
            RX_DMA2_ENABLE: u1,
            ///  When 1, enables DMA1 for I2S transmit.
            TX_DMA2_ENABLE: u1,
            ///  Reserved.
            RESERVED: u6,
            ///  Set the FIFO level that triggers a receive DMA request on DMA2.
            RX_DEPTH_DMA2: u4,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u4,
            ///  Set the FIFO level that triggers a transmit DMA request on DMA2.
            TX_DEPTH_DMA2: u4,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u12,
        }),
        ///  I2S Interrupt Request Control Register. Contains bits that control how the I2S interrupt request is generated.
        IRQ: mmio.Mmio(packed struct(u32) {
            ///  When 1, enables I2S receive interrupt.
            RX_IRQ_ENABLE: u1,
            ///  When 1, enables I2S transmit interrupt.
            TX_IRQ_ENABLE: u1,
            ///  Reserved.
            RESERVED: u6,
            ///  Set the FIFO level on which to create an irq request.
            RX_DEPTH_IRQ: u4,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u4,
            ///  Set the FIFO level on which to create an irq request.
            TX_DEPTH_IRQ: u4,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u12,
        }),
        ///  I2S Transmit MCLK divider. This register determines the I2S TX MCLK rate by specifying the value to divide PCLK by in order to produce MCLK.
        TXRATE: mmio.Mmio(packed struct(u32) {
            ///  I2S transmit MCLK rate denominator. This value is used to divide PCLK to produce the transmit MCLK. Eight bits of fractional divide supports a wide range of possibilities. A value of 0 stops the clock.
            Y_DIVIDER: u8,
            ///  I2S transmit MCLK rate numerator. This value is used to multiply PCLK by to produce the transmit MCLK. A value of 0 stops the clock. Eight bits of fractional divide supports a wide range of possibilities. Note: the resulting ratio X/Y is divided by 2.
            X_DIVIDER: u8,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u16,
        }),
        ///  I2S Receive MCLK divider. This register determines the I2S RX MCLK rate by specifying the value to divide PCLK by in order to produce MCLK.
        RXRATE: mmio.Mmio(packed struct(u32) {
            ///  I2S receive MCLK rate denominator. This value is used to divide PCLK to produce the receive MCLK. Eight bits of fractional divide supports a wide range of possibilities. A value of 0 stops the clock.
            Y_DIVIDER: u8,
            ///  I2S receive MCLK rate numerator. This value is used to multiply PCLK by to produce the receive MCLK. A value of 0 stops the clock. Eight bits of fractional divide supports a wide range of possibilities. Note: the resulting ratio X/Y is divided by 2.
            X_DIVIDER: u8,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u16,
        }),
        ///  I2S Transmit bit rate divider. This register determines the I2S transmit bit rate by specifying the value to divide TX_MCLK by in order to produce the transmit bit clock.
        TXBITRATE: mmio.Mmio(packed struct(u32) {
            ///  I2S transmit bit rate. This value plus one is used to divide TX_MCLK to produce the transmit bit clock.
            TX_BITRATE: u6,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u26,
        }),
        ///  I2S Receive bit rate divider. This register determines the I2S receive bit rate by specifying the value to divide RX_MCLK by in order to produce the receive bit clock.
        RXBITRATE: mmio.Mmio(packed struct(u32) {
            ///  I2S receive bit rate. This value plus one is used to divide RX_MCLK to produce the receive bit clock.
            RX_BITRATE: u6,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u26,
        }),
        ///  I2S Transmit mode control.
        TXMODE: mmio.Mmio(packed struct(u32) {
            ///  Clock source selection for the transmit bit clock divider.
            TXCLKSEL: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Select the TX fractional rate divider clock output as the source
                    SELECT_THE_TX_FRACTI = 0x0,
                    ///  Select the RX_MCLK signal as the TX_MCLK clock source
                    SELECT_THE_RX_MCLK_S = 0x2,
                    _,
                },
            },
            ///  Transmit 4-pin mode selection. When 1, enables 4-pin mode.
            TX4PIN: u1,
            ///  Enable for the TX_MCLK output. When 0, output of TX_MCLK is not enabled. When 1, output of TX_MCLK is enabled.
            TXMCENA: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u28,
        }),
        ///  I2S Receive mode control.
        RXMODE: mmio.Mmio(packed struct(u32) {
            ///  Clock source selection for the receive bit clock divider.
            RXCLKSEL: packed union {
                raw: u2,
                value: enum(u2) {
                    ///  Select the RX fractional rate divider clock output as the source
                    SELECT_THE_RX_FRACTI = 0x0,
                    ///  Select the TX_MCLK signal as the RX_MCLK clock source
                    SELECT_THE_TX_MCLK_S = 0x2,
                    _,
                },
            },
            ///  Receive 4-pin mode selection. When 1, enables 4-pin mode.
            RX4PIN: u1,
            ///  Enable for the RX_MCLK output. When 0, output of RX_MCLK is not enabled. When 1, output of RX_MCLK is enabled.
            RXMCENA: u1,
            ///  Reserved, user software should not write ones to reserved bits. The value read from a reserved bit is not defined.
            RESERVED: u28,
        }),
    };
};
