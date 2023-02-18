const micro = @import("microzig");
const mmio = micro.mmio;

pub const devices = struct {
    ///  GD32VF103 RISC-V Microcontroller based device
    pub const GD32VF103 = struct {
        pub const properties = struct {
            pub const @"cpu.nvic_prio_bits" = "4";
            pub const @"cpu.mpu" = "0";
            pub const @"cpu.fpu" = "0";
            pub const @"cpu.revision" = "r2p1";
            pub const @"cpu.vendor_systick_config" = "0";
            pub const license =
                \\
                \\    Copyright 2019 Sipeed Co.,Ltd.
                \\  
                \\    Licensed under the Apache License, Version 2.0 (the "License");
                \\    you may not use this file except in compliance with the License.
                \\    You may obtain a copy of the License at
                \\
                \\        http://www.apache.org/licenses/LICENSE-2.0
                \\
                \\    Unless required by applicable law or agreed to in writing, software
                \\    distributed under the License is distributed on an "AS IS" BASIS,
                \\    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
                \\    See the License for the specific language governing permissions and
                \\    limitations under the License.
                \\
            ;
            pub const @"cpu.name" = "CM3";
            pub const @"cpu.endian" = "little";
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
            WWDGT: Handler = unhandled,
            reserved15: [20]u32 = undefined,
            Tamper: Handler = unhandled,
            RTC: Handler = unhandled,
            FMC: Handler = unhandled,
            RCU: Handler = unhandled,
            EXTI_Line0: Handler = unhandled,
            EXTI_Line1: Handler = unhandled,
            EXTI_Line2: Handler = unhandled,
            EXTI_Line3: Handler = unhandled,
            EXTI_Line4: Handler = unhandled,
            DMA0_Channel0: Handler = unhandled,
            DMA0_Channel1: Handler = unhandled,
            DMA0_Channel2: Handler = unhandled,
            DMA0_Channel3: Handler = unhandled,
            DMA0_Channel4: Handler = unhandled,
            DMA0_Channel5: Handler = unhandled,
            DMA0_Channel6: Handler = unhandled,
            ADC0_1: Handler = unhandled,
            CAN0_TX: Handler = unhandled,
            CAN0_RX0: Handler = unhandled,
            CAN0_RX1: Handler = unhandled,
            CAN0_EWMC: Handler = unhandled,
            EXTI_line9_5: Handler = unhandled,
            TIMER0_BRK: Handler = unhandled,
            TIMER0_UP: Handler = unhandled,
            TIMER0_TRG_CMT: Handler = unhandled,
            TIMER0_Channel: Handler = unhandled,
            TIMER1: Handler = unhandled,
            TIMER2: Handler = unhandled,
            TIMER3: Handler = unhandled,
            I2C0_EV: Handler = unhandled,
            I2C0_ER: Handler = unhandled,
            I2C1_EV: Handler = unhandled,
            I2C1_ER: Handler = unhandled,
            SPI0: Handler = unhandled,
            SPI1: Handler = unhandled,
            USART0: Handler = unhandled,
            USART1: Handler = unhandled,
            USART2: Handler = unhandled,
            EXTI_line15_10: Handler = unhandled,
            RTC_Alarm: Handler = unhandled,
            USBFS_WKUP: Handler = unhandled,
            reserved76: [7]u32 = undefined,
            TIMER4: Handler = unhandled,
            SPI2: Handler = unhandled,
            UART3: Handler = unhandled,
            UART4: Handler = unhandled,
            TIMER5: Handler = unhandled,
            TIMER6: Handler = unhandled,
            DMA1_Channel0: Handler = unhandled,
            DMA1_Channel1: Handler = unhandled,
            DMA1_Channel2: Handler = unhandled,
            DMA1_Channel3: Handler = unhandled,
            DMA1_Channel4: Handler = unhandled,
            reserved94: [2]u32 = undefined,
            CAN1_TX: Handler = unhandled,
            CAN1_RX0: Handler = unhandled,
            CAN1_RX1: Handler = unhandled,
            CAN1_EWMC: Handler = unhandled,
            USBFS: Handler = unhandled,
        };

        pub const peripherals = struct {
            ///  General-purpose-timers
            pub const TIMER1 = @intToPtr(*volatile types.peripherals.TIMER1, 0x40000000);
            ///  General-purpose-timers
            pub const TIMER2 = @intToPtr(*volatile types.peripherals.TIMER1, 0x40000400);
            ///  General-purpose-timers
            pub const TIMER3 = @intToPtr(*volatile types.peripherals.TIMER1, 0x40000800);
            ///  General-purpose-timers
            pub const TIMER4 = @intToPtr(*volatile types.peripherals.TIMER1, 0x40000c00);
            ///  Basic-timers
            pub const TIMER5 = @intToPtr(*volatile types.peripherals.TIMER5, 0x40001000);
            ///  Basic-timers
            pub const TIMER6 = @intToPtr(*volatile types.peripherals.TIMER5, 0x40001400);
            ///  Real-time clock
            pub const RTC = @intToPtr(*volatile types.peripherals.RTC, 0x40002800);
            ///  Window watchdog timer
            pub const WWDGT = @intToPtr(*volatile types.peripherals.WWDGT, 0x40002c00);
            ///  free watchdog timer
            pub const FWDGT = @intToPtr(*volatile types.peripherals.FWDGT, 0x40003000);
            ///  Serial peripheral interface
            pub const SPI1 = @intToPtr(*volatile types.peripherals.SPI0, 0x40003800);
            ///  Serial peripheral interface
            pub const SPI2 = @intToPtr(*volatile types.peripherals.SPI0, 0x40003c00);
            ///  Universal synchronous asynchronous receiver transmitter
            pub const USART1 = @intToPtr(*volatile types.peripherals.USART0, 0x40004400);
            ///  Universal synchronous asynchronous receiver transmitter
            pub const USART2 = @intToPtr(*volatile types.peripherals.USART0, 0x40004800);
            ///  Universal asynchronous receiver transmitter
            pub const UART3 = @intToPtr(*volatile types.peripherals.UART3, 0x40004c00);
            ///  Universal asynchronous receiver transmitter
            pub const UART4 = @intToPtr(*volatile types.peripherals.UART3, 0x40005000);
            ///  Inter integrated circuit
            pub const I2C0 = @intToPtr(*volatile types.peripherals.I2C0, 0x40005400);
            ///  Inter integrated circuit
            pub const I2C1 = @intToPtr(*volatile types.peripherals.I2C0, 0x40005800);
            ///  Controller area network
            pub const CAN0 = @intToPtr(*volatile types.peripherals.CAN0, 0x40006400);
            ///  Controller area network
            pub const CAN1 = @intToPtr(*volatile types.peripherals.CAN0, 0x40006800);
            ///  Backup registers
            pub const BKP = @intToPtr(*volatile types.peripherals.BKP, 0x40006c00);
            ///  Power management unit
            pub const PMU = @intToPtr(*volatile types.peripherals.PMU, 0x40007000);
            ///  Digital-to-analog converter
            pub const DAC = @intToPtr(*volatile types.peripherals.DAC, 0x40007400);
            ///  Alternate-function I/Os
            pub const AFIO = @intToPtr(*volatile types.peripherals.AFIO, 0x40010000);
            ///  External interrupt/event controller
            pub const EXTI = @intToPtr(*volatile types.peripherals.EXTI, 0x40010400);
            ///  General-purpose I/Os
            pub const GPIOA = @intToPtr(*volatile types.peripherals.GPIOA, 0x40010800);
            ///  General-purpose I/Os
            pub const GPIOB = @intToPtr(*volatile types.peripherals.GPIOA, 0x40010c00);
            ///  General-purpose I/Os
            pub const GPIOC = @intToPtr(*volatile types.peripherals.GPIOA, 0x40011000);
            ///  General-purpose I/Os
            pub const GPIOD = @intToPtr(*volatile types.peripherals.GPIOA, 0x40011400);
            ///  General-purpose I/Os
            pub const GPIOE = @intToPtr(*volatile types.peripherals.GPIOA, 0x40011800);
            ///  Analog to digital converter
            pub const ADC0 = @intToPtr(*volatile types.peripherals.ADC0, 0x40012400);
            ///  Analog to digital converter
            pub const ADC1 = @intToPtr(*volatile types.peripherals.ADC1, 0x40012800);
            ///  Advanced-timers
            pub const TIMER0 = @intToPtr(*volatile types.peripherals.TIMER0, 0x40012c00);
            ///  Serial peripheral interface
            pub const SPI0 = @intToPtr(*volatile types.peripherals.SPI0, 0x40013000);
            ///  Universal synchronous asynchronous receiver transmitter
            pub const USART0 = @intToPtr(*volatile types.peripherals.USART0, 0x40013800);
            ///  DMA controller
            pub const DMA0 = @intToPtr(*volatile types.peripherals.DMA0, 0x40020000);
            ///  Direct memory access controller
            pub const DMA1 = @intToPtr(*volatile types.peripherals.DMA1, 0x40020000);
            ///  Reset and clock unit
            pub const RCU = @intToPtr(*volatile types.peripherals.RCU, 0x40021000);
            ///  FMC
            pub const FMC = @intToPtr(*volatile types.peripherals.FMC, 0x40022000);
            ///  cyclic redundancy check calculation unit
            pub const CRC = @intToPtr(*volatile types.peripherals.CRC, 0x40023000);
            ///  USB full speed global registers
            pub const USBFS_GLOBAL = @intToPtr(*volatile types.peripherals.USBFS_GLOBAL, 0x50000000);
            ///  USB on the go full speed host
            pub const USBFS_HOST = @intToPtr(*volatile types.peripherals.USBFS_HOST, 0x50000400);
            ///  USB on the go full speed device
            pub const USBFS_DEVICE = @intToPtr(*volatile types.peripherals.USBFS_DEVICE, 0x50000800);
            ///  USB on the go full speed
            pub const USBFS_PWRCLK = @intToPtr(*volatile types.peripherals.USBFS_PWRCLK, 0x50000e00);
            ///  External memory controller
            pub const EXMC = @intToPtr(*volatile types.peripherals.EXMC, 0xa0000000);
            ///  Enhanced Core Local Interrupt Controller
            pub const ECLIC = @intToPtr(*volatile types.peripherals.ECLIC, 0xd2000000);
            ///  System Tick Timer
            pub const SysTick = @intToPtr(*volatile types.peripherals.SCS.SysTick, 0xe000e010);
            ///  Debug support
            pub const DBG = @intToPtr(*volatile types.peripherals.DBG, 0xe0042000);
        };
    };
};

pub const types = struct {
    pub const peripherals = struct {
        ///  System Control Space
        pub const SCS = struct {
            ///  System Tick Timer
            pub const SysTick = extern struct {
                ///  SysTick Control and Status Register
                CTRL: mmio.Mmio(packed struct(u32) {
                    ENABLE: u1,
                    TICKINT: u1,
                    CLKSOURCE: u1,
                    reserved16: u13,
                    COUNTFLAG: u1,
                    padding: u15,
                }),
                ///  SysTick Reload Value Register
                LOAD: mmio.Mmio(packed struct(u32) {
                    RELOAD: u24,
                    padding: u8,
                }),
                ///  SysTick Current Value Register
                VAL: mmio.Mmio(packed struct(u32) {
                    CURRENT: u24,
                    padding: u8,
                }),
                ///  SysTick Calibration Register
                CALIB: mmio.Mmio(packed struct(u32) {
                    TENMS: u24,
                    reserved30: u6,
                    SKEW: u1,
                    NOREF: u1,
                }),
            };
        };

        ///  Analog to digital converter
        pub const ADC0 = extern struct {
            ///  status register
            STAT: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog event flag
                WDE: u1,
                ///  End of group conversion flag
                EOC: u1,
                ///  End of inserted group conversion flag
                EOIC: u1,
                ///  Start flag of inserted channel group
                STIC: u1,
                ///  Start flag of regular channel group
                STRC: u1,
                padding: u27,
            }),
            ///  control register 0
            CTL0: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog channel select
                WDCHSEL: u5,
                ///  Interrupt enable for EOC
                EOCIE: u1,
                ///  Interrupt enable for WDE
                WDEIE: u1,
                ///  Interrupt enable for EOIC
                EOICIE: u1,
                ///  Scan mode
                SM: u1,
                ///  When in scan mode, analog watchdog is effective on a single channel
                WDSC: u1,
                ///  Inserted channel group convert automatically
                ICA: u1,
                ///  Discontinuous mode on regular channels
                DISRC: u1,
                ///  Discontinuous mode on inserted channels
                DISIC: u1,
                ///  Number of conversions in discontinuous mode
                DISNUM: u3,
                ///  sync mode selection
                SYNCM: u4,
                reserved22: u2,
                ///  Inserted channel analog watchdog enable
                IWDEN: u1,
                ///  Regular channel analog watchdog enable
                RWDEN: u1,
                padding: u8,
            }),
            ///  control register 1
            CTL1: mmio.Mmio(packed struct(u32) {
                ///  ADC on
                ADCON: u1,
                ///  Continuous mode
                CTN: u1,
                ///  ADC calibration
                CLB: u1,
                ///  Reset calibration
                RSTCLB: u1,
                reserved8: u4,
                ///  DMA request enable
                DMA: u1,
                reserved11: u2,
                ///  Data alignment
                DAL: u1,
                ///  External trigger select for inserted channel
                ETSIC: u3,
                ///  External trigger select for inserted channel
                ETEIC: u1,
                reserved17: u1,
                ///  External trigger select for regular channel
                ETSRC: u3,
                ///  External trigger enable for regular channel
                ETERC: u1,
                ///  Start on inserted channel
                SWICST: u1,
                ///  Start on regular channel
                SWRCST: u1,
                ///  Channel 16 and 17 enable of ADC0
                TSVREN: u1,
                padding: u8,
            }),
            ///  Sample time register 0
            SAMPT0: mmio.Mmio(packed struct(u32) {
                ///  Channel 10 sample time selection
                SPT10: u3,
                ///  Channel 11 sample time selection
                SPT11: u3,
                ///  Channel 12 sample time selection
                SPT12: u3,
                ///  Channel 13 sample time selection
                SPT13: u3,
                ///  Channel 14 sample time selection
                SPT14: u3,
                ///  Channel 15 sample time selection
                SPT15: u3,
                ///  Channel 16 sample time selection
                SPT16: u3,
                ///  Channel 17 sample time selection
                SPT17: u3,
                padding: u8,
            }),
            ///  Sample time register 1
            SAMPT1: mmio.Mmio(packed struct(u32) {
                ///  Channel 0 sample time selection
                SPT0: u3,
                ///  Channel 1 sample time selection
                SPT1: u3,
                ///  Channel 2 sample time selection
                SPT2: u3,
                ///  Channel 3 sample time selection
                SPT3: u3,
                ///  Channel 4 sample time selection
                SPT4: u3,
                ///  Channel 5 sample time selection
                SPT5: u3,
                ///  Channel 6 sample time selection
                SPT6: u3,
                ///  Channel 7 sample time selection
                SPT7: u3,
                ///  Channel 8 sample time selection
                SPT8: u3,
                ///  Channel 9 sample time selection
                SPT9: u3,
                padding: u2,
            }),
            ///  Inserted channel data offset register 0
            IOFF0: mmio.Mmio(packed struct(u32) {
                ///  Data offset for inserted channel 0
                IOFF: u12,
                padding: u20,
            }),
            ///  Inserted channel data offset register 1
            IOFF1: mmio.Mmio(packed struct(u32) {
                ///  Data offset for inserted channel 1
                IOFF: u12,
                padding: u20,
            }),
            ///  Inserted channel data offset register 2
            IOFF2: mmio.Mmio(packed struct(u32) {
                ///  Data offset for inserted channel 2
                IOFF: u12,
                padding: u20,
            }),
            ///  Inserted channel data offset register 3
            IOFF3: mmio.Mmio(packed struct(u32) {
                ///  Data offset for inserted channel 3
                IOFF: u12,
                padding: u20,
            }),
            ///  watchdog higher threshold register
            WDHT: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog higher threshold
                WDHT: u12,
                padding: u20,
            }),
            ///  watchdog lower threshold register
            WDLT: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog lower threshold
                WDLT: u12,
                padding: u20,
            }),
            ///  regular sequence register 0
            RSQ0: mmio.Mmio(packed struct(u32) {
                ///  13th conversion in regular sequence
                RSQ12: u5,
                ///  14th conversion in regular sequence
                RSQ13: u5,
                ///  15th conversion in regular sequence
                RSQ14: u5,
                ///  16th conversion in regular sequence
                RSQ15: u5,
                ///  Regular channel group length
                RL: u4,
                padding: u8,
            }),
            ///  regular sequence register 1
            RSQ1: mmio.Mmio(packed struct(u32) {
                ///  7th conversion in regular sequence
                RSQ6: u5,
                ///  8th conversion in regular sequence
                RSQ7: u5,
                ///  9th conversion in regular sequence
                RSQ8: u5,
                ///  10th conversion in regular sequence
                RSQ9: u5,
                ///  11th conversion in regular sequence
                RSQ10: u5,
                ///  12th conversion in regular sequence
                RSQ11: u5,
                padding: u2,
            }),
            ///  regular sequence register 2
            RSQ2: mmio.Mmio(packed struct(u32) {
                ///  1st conversion in regular sequence
                RSQ0: u5,
                ///  2nd conversion in regular sequence
                RSQ1: u5,
                ///  3rd conversion in regular sequence
                RSQ2: u5,
                ///  4th conversion in regular sequence
                RSQ3: u5,
                ///  5th conversion in regular sequence
                RSQ4: u5,
                ///  6th conversion in regular sequence
                RSQ5: u5,
                padding: u2,
            }),
            ///  Inserted sequence register
            ISQ: mmio.Mmio(packed struct(u32) {
                ///  1st conversion in inserted sequence
                ISQ0: u5,
                ///  2nd conversion in inserted sequence
                ISQ1: u5,
                ///  3rd conversion in inserted sequence
                ISQ2: u5,
                ///  4th conversion in inserted sequence
                ISQ3: u5,
                ///  Inserted channel group length
                IL: u2,
                padding: u10,
            }),
            ///  Inserted data register 0
            IDATA0: mmio.Mmio(packed struct(u32) {
                ///  Inserted number n conversion data
                IDATAn: u16,
                padding: u16,
            }),
            ///  Inserted data register 1
            IDATA1: mmio.Mmio(packed struct(u32) {
                ///  Inserted number n conversion data
                IDATAn: u16,
                padding: u16,
            }),
            ///  Inserted data register 2
            IDATA2: mmio.Mmio(packed struct(u32) {
                ///  Inserted number n conversion data
                IDATAn: u16,
                padding: u16,
            }),
            ///  Inserted data register 3
            IDATA3: mmio.Mmio(packed struct(u32) {
                ///  Inserted number n conversion data
                IDATAn: u16,
                padding: u16,
            }),
            ///  regular data register
            RDATA: mmio.Mmio(packed struct(u32) {
                ///  Regular channel data
                RDATA: u16,
                ///  ADC regular channel data
                ADC1RDTR: u16,
            }),
            reserved128: [48]u8,
            ///  Oversample control register
            OVSAMPCTL: mmio.Mmio(packed struct(u32) {
                ///  Oversampler Enable
                OVSEN: u1,
                reserved2: u1,
                ///  Oversampling ratio
                OVSR: u3,
                ///  Oversampling shift
                OVSS: u4,
                ///  Triggered Oversampling
                TOVS: u1,
                reserved12: u2,
                ///  ADC resolution
                DRES: u2,
                padding: u18,
            }),
        };

        ///  Analog to digital converter
        pub const ADC1 = extern struct {
            ///  status register
            STAT: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog event flag
                WDE: u1,
                ///  End of group conversion flag
                EOC: u1,
                ///  End of inserted group conversion flag
                EOIC: u1,
                ///  Start flag of inserted channel group
                STIC: u1,
                ///  Start flag of regular channel group
                STRC: u1,
                padding: u27,
            }),
            ///  control register 0
            CTL0: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog channel select
                WDCHSEL: u5,
                ///  Interrupt enable for EOC
                EOCIE: u1,
                ///  Interrupt enable for WDE
                WDEIE: u1,
                ///  Interrupt enable for EOIC
                EOICIE: u1,
                ///  Scan mode
                SM: u1,
                ///  When in scan mode, analog watchdog is effective on a single channel
                WDSC: u1,
                ///  Inserted channel group convert automatically
                ICA: u1,
                ///  Discontinuous mode on regular channels
                DISRC: u1,
                ///  Discontinuous mode on inserted channels
                DISIC: u1,
                ///  Number of conversions in discontinuous mode
                DISNUM: u3,
                reserved22: u6,
                ///  Inserted channel analog watchdog enable
                IWDEN: u1,
                ///  Regular channel analog watchdog enable
                RWDEN: u1,
                padding: u8,
            }),
            ///  control register 1
            CTL1: mmio.Mmio(packed struct(u32) {
                ///  ADC on
                ADCON: u1,
                ///  Continuous mode
                CTN: u1,
                ///  ADC calibration
                CLB: u1,
                ///  Reset calibration
                RSTCLB: u1,
                reserved8: u4,
                ///  DMA request enable
                DMA: u1,
                reserved11: u2,
                ///  Data alignment
                DAL: u1,
                ///  External trigger select for inserted channel
                ETSIC: u3,
                ///  External trigger enable for inserted channel
                ETEIC: u1,
                reserved17: u1,
                ///  External trigger select for regular channel
                ETSRC: u3,
                ///  External trigger enable for regular channel
                ETERC: u1,
                ///  Start on inserted channel
                SWICST: u1,
                ///  Start on regular channel
                SWRCST: u1,
                padding: u9,
            }),
            ///  Sample time register 0
            SAMPT0: mmio.Mmio(packed struct(u32) {
                ///  Channel 10 sample time selection
                SPT10: u3,
                ///  Channel 11 sample time selection
                SPT11: u3,
                ///  Channel 12 sample time selection
                SPT12: u3,
                ///  Channel 13 sample time selection
                SPT13: u3,
                ///  Channel 14 sample time selection
                SPT14: u3,
                ///  Channel 15 sample time selection
                SPT15: u3,
                ///  Channel 16 sample time selection
                SPT16: u3,
                ///  Channel 17 sample time selection
                SPT17: u3,
                padding: u8,
            }),
            ///  Sample time register 1
            SAMPT1: mmio.Mmio(packed struct(u32) {
                ///  Channel 0 sample time selection
                SPT0: u3,
                ///  Channel 1 sample time selection
                SPT1: u3,
                ///  Channel 2 sample time selection
                SPT2: u3,
                ///  Channel 3 sample time selection
                SPT3: u3,
                ///  Channel 4 sample time selection
                SPT4: u3,
                ///  Channel 5 sample time selection
                SPT5: u3,
                ///  Channel 6 sample time selection
                SPT6: u3,
                ///  Channel 7 sample time selection
                SPT7: u3,
                ///  Channel 8 sample time selection
                SPT8: u3,
                ///  Channel 9 sample time selection
                SPT9: u3,
                padding: u2,
            }),
            ///  Inserted channel data offset register 0
            IOFF0: mmio.Mmio(packed struct(u32) {
                ///  Data offset for inserted channel 0
                IOFF: u12,
                padding: u20,
            }),
            ///  Inserted channel data offset register 1
            IOFF1: mmio.Mmio(packed struct(u32) {
                ///  Data offset for inserted channel 1
                IOFF: u12,
                padding: u20,
            }),
            ///  Inserted channel data offset register 2
            IOFF2: mmio.Mmio(packed struct(u32) {
                ///  Data offset for inserted channel 2
                IOFF: u12,
                padding: u20,
            }),
            ///  Inserted channel data offset register 3
            IOFF3: mmio.Mmio(packed struct(u32) {
                ///  Data offset for inserted channel 3
                IOFF: u12,
                padding: u20,
            }),
            ///  watchdog higher threshold register
            WDHT: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog higher threshold
                WDHT: u12,
                padding: u20,
            }),
            ///  watchdog lower threshold register
            WDLT: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog lower threshold
                WDLT: u12,
                padding: u20,
            }),
            ///  regular sequence register 0
            RSQ0: mmio.Mmio(packed struct(u32) {
                ///  13th conversion in regular sequence
                RSQ12: u5,
                ///  14th conversion in regular sequence
                RSQ13: u5,
                ///  15th conversion in regular sequence
                RSQ14: u5,
                ///  16th conversion in regular sequence
                RSQ15: u5,
                ///  Regular channel group length
                RL: u4,
                padding: u8,
            }),
            ///  regular sequence register 1
            RSQ1: mmio.Mmio(packed struct(u32) {
                ///  7th conversion in regular sequence
                RSQ6: u5,
                ///  8th conversion in regular sequence
                RSQ7: u5,
                ///  9th conversion in regular sequence
                RSQ8: u5,
                ///  10th conversion in regular sequence
                RSQ9: u5,
                ///  11th conversion in regular sequence
                RSQ10: u5,
                ///  12th conversion in regular sequence
                RSQ11: u5,
                padding: u2,
            }),
            ///  regular sequence register 2
            RSQ2: mmio.Mmio(packed struct(u32) {
                ///  1st conversion in regular sequence
                RSQ0: u5,
                ///  2nd conversion in regular sequence
                RSQ1: u5,
                ///  3rd conversion in regular sequence
                RSQ2: u5,
                ///  4th conversion in regular sequence
                RSQ3: u5,
                ///  5th conversion in regular sequence
                RSQ4: u5,
                ///  6th conversion in regular sequence
                RSQ5: u5,
                padding: u2,
            }),
            ///  Inserted sequence register
            ISQ: mmio.Mmio(packed struct(u32) {
                ///  1st conversion in inserted sequence
                ISQ0: u5,
                ///  2nd conversion in inserted sequence
                ISQ1: u5,
                ///  3rd conversion in inserted sequence
                ISQ2: u5,
                ///  4th conversion in inserted sequence
                ISQ3: u5,
                ///  Inserted channel group length
                IL: u2,
                padding: u10,
            }),
            ///  Inserted data register 0
            IDATA0: mmio.Mmio(packed struct(u32) {
                ///  Inserted number n conversion data
                IDATAn: u16,
                padding: u16,
            }),
            ///  Inserted data register 1
            IDATA1: mmio.Mmio(packed struct(u32) {
                ///  Inserted number n conversion data
                IDATAn: u16,
                padding: u16,
            }),
            ///  Inserted data register 2
            IDATA2: mmio.Mmio(packed struct(u32) {
                ///  Inserted number n conversion data
                IDATAn: u16,
                padding: u16,
            }),
            ///  Inserted data register 3
            IDATA3: mmio.Mmio(packed struct(u32) {
                ///  Inserted number n conversion data
                IDATAn: u16,
                padding: u16,
            }),
            ///  regular data register
            RDATA: mmio.Mmio(packed struct(u32) {
                ///  Regular channel data
                RDATA: u16,
                padding: u16,
            }),
        };

        ///  Alternate-function I/Os
        pub const AFIO = extern struct {
            ///  Event control register
            EC: mmio.Mmio(packed struct(u32) {
                ///  Event output pin selection
                PIN: u4,
                ///  Event output port selection
                PORT: u3,
                ///  Event output enable
                EOE: u1,
                padding: u24,
            }),
            ///  AFIO port configuration register 0
            PCF0: mmio.Mmio(packed struct(u32) {
                ///  SPI0 remapping
                SPI0_REMAP: u1,
                ///  I2C0 remapping
                I2C0_REMAP: u1,
                ///  USART0 remapping
                USART0_REMAP: u1,
                ///  USART1 remapping
                USART1_REMAP: u1,
                ///  USART2 remapping
                USART2_REMAP: u2,
                ///  TIMER0 remapping
                TIMER0_REMAP: u2,
                ///  TIMER1 remapping
                TIMER1_REMAP: u2,
                ///  TIMER2 remapping
                TIMER2_REMAP: u2,
                ///  TIMER3 remapping
                TIMER3_REMAP: u1,
                ///  CAN0 alternate interface remapping
                CAN0_REMAP: u2,
                ///  Port D0/Port D1 mapping on OSC_IN/OSC_OUT
                PD01_REMAP: u1,
                ///  TIMER4 channel3 internal remapping
                TIMER4CH3_IREMAP: u1,
                reserved22: u5,
                ///  CAN1 I/O remapping
                CAN1_REMAP: u1,
                reserved24: u1,
                ///  Serial wire JTAG configuration
                SWJ_CFG: u3,
                reserved28: u1,
                ///  SPI2/I2S2 remapping
                SPI2_REMAP: u1,
                ///  TIMER1 internal trigger 1 remapping
                TIMER1ITI1_REMAP: u1,
                padding: u2,
            }),
            ///  EXTI sources selection register 0
            EXTISS0: mmio.Mmio(packed struct(u32) {
                ///  EXTI 0 sources selection
                EXTI0_SS: u4,
                ///  EXTI 1 sources selection
                EXTI1_SS: u4,
                ///  EXTI 2 sources selection
                EXTI2_SS: u4,
                ///  EXTI 3 sources selection
                EXTI3_SS: u4,
                padding: u16,
            }),
            ///  EXTI sources selection register 1
            EXTISS1: mmio.Mmio(packed struct(u32) {
                ///  EXTI 4 sources selection
                EXTI4_SS: u4,
                ///  EXTI 5 sources selection
                EXTI5_SS: u4,
                ///  EXTI 6 sources selection
                EXTI6_SS: u4,
                ///  EXTI 7 sources selection
                EXTI7_SS: u4,
                padding: u16,
            }),
            ///  EXTI sources selection register 2
            EXTISS2: mmio.Mmio(packed struct(u32) {
                ///  EXTI 8 sources selection
                EXTI8_SS: u4,
                ///  EXTI 9 sources selection
                EXTI9_SS: u4,
                ///  EXTI 10 sources selection
                EXTI10_SS: u4,
                ///  EXTI 11 sources selection
                EXTI11_SS: u4,
                padding: u16,
            }),
            ///  EXTI sources selection register 3
            EXTISS3: mmio.Mmio(packed struct(u32) {
                ///  EXTI 12 sources selection
                EXTI12_SS: u4,
                ///  EXTI 13 sources selection
                EXTI13_SS: u4,
                ///  EXTI 14 sources selection
                EXTI14_SS: u4,
                ///  EXTI 15 sources selection
                EXTI15_SS: u4,
                padding: u16,
            }),
            reserved28: [4]u8,
            ///  AFIO port configuration register 1
            PCF1: mmio.Mmio(packed struct(u32) {
                reserved10: u10,
                ///  EXMC_NADV connect/disconnect
                EXMC_NADV: u1,
                padding: u21,
            }),
        };

        ///  Backup registers
        pub const BKP = extern struct {
            reserved4: [4]u8,
            ///  Backup data register 0
            DATA0: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved8: [2]u8,
            ///  Backup data register 1
            DATA1: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved12: [2]u8,
            ///  Backup data register 2
            DATA2: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved16: [2]u8,
            ///  Backup data register 3
            DATA3: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved20: [2]u8,
            ///  Backup data register 4
            DATA4: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved24: [2]u8,
            ///  Backup data register 5
            DATA5: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved28: [2]u8,
            ///  Backup data register 6
            DATA6: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved32: [2]u8,
            ///  Backup data register 7
            DATA7: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved36: [2]u8,
            ///  Backup data register 8
            DATA8: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved40: [2]u8,
            ///  Backup data register 9
            DATA9: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved44: [2]u8,
            ///  RTC signal output control register
            OCTL: mmio.Mmio(packed struct(u16) {
                ///  RTC clock calibration value
                RCCV: u7,
                ///  RTC clock calibration output enable
                COEN: u1,
                ///  RTC alarm or second signal output enable
                ASOEN: u1,
                ///  RTC output selection
                ROSEL: u1,
                padding: u6,
            }),
            reserved48: [2]u8,
            ///  Tamper pin control register
            TPCTL: mmio.Mmio(packed struct(u16) {
                ///  TAMPER detection enable
                TPEN: u1,
                ///  TAMPER pin active level
                TPAL: u1,
                padding: u14,
            }),
            reserved52: [2]u8,
            ///  Tamper control and status register
            TPCS: mmio.Mmio(packed struct(u16) {
                ///  Tamper event reset
                TER: u1,
                ///  Tamper interrupt reset
                TIR: u1,
                ///  Tamper interrupt enable
                TPIE: u1,
                reserved8: u5,
                ///  Tamper event flag
                TEF: u1,
                ///  Tamper interrupt flag
                TIF: u1,
                padding: u6,
            }),
            reserved64: [10]u8,
            ///  Backup data register 10
            DATA10: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved68: [2]u8,
            ///  Backup data register 11
            DATA11: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved72: [2]u8,
            ///  Backup data register 12
            DATA12: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved76: [2]u8,
            ///  Backup data register 13
            DATA13: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved80: [2]u8,
            ///  Backup data register 14
            DATA14: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved84: [2]u8,
            ///  Backup data register 15
            DATA15: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved88: [2]u8,
            ///  Backup data register 16
            DATA16: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved92: [2]u8,
            ///  Backup data register 17
            DATA17: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved96: [2]u8,
            ///  Backup data register 18
            DATA18: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved100: [2]u8,
            ///  Backup data register 19
            DATA19: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved104: [2]u8,
            ///  Backup data register 20
            DATA20: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved108: [2]u8,
            ///  Backup data register 21
            DATA21: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved112: [2]u8,
            ///  Backup data register 22
            DATA22: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved116: [2]u8,
            ///  Backup data register 23
            DATA23: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved120: [2]u8,
            ///  Backup data register 24
            DATA24: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved124: [2]u8,
            ///  Backup data register 25
            DATA25: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved128: [2]u8,
            ///  Backup data register 26
            DATA26: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved132: [2]u8,
            ///  Backup data register 27
            DATA27: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved136: [2]u8,
            ///  Backup data register 28
            DATA28: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved140: [2]u8,
            ///  Backup data register 29
            DATA29: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved144: [2]u8,
            ///  Backup data register 30
            DATA30: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved148: [2]u8,
            ///  Backup data register 31
            DATA31: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved152: [2]u8,
            ///  Backup data register 32
            DATA32: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved156: [2]u8,
            ///  Backup data register 33
            DATA33: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved160: [2]u8,
            ///  Backup data register 34
            DATA34: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved164: [2]u8,
            ///  Backup data register 35
            DATA35: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved168: [2]u8,
            ///  Backup data register 36
            DATA36: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved172: [2]u8,
            ///  Backup data register 37
            DATA37: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved176: [2]u8,
            ///  Backup data register 38
            DATA38: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved180: [2]u8,
            ///  Backup data register 39
            DATA39: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved184: [2]u8,
            ///  Backup data register 40
            DATA40: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
            reserved188: [2]u8,
            ///  Backup data register 41
            DATA41: mmio.Mmio(packed struct(u16) {
                ///  Backup data
                DATA: u16,
            }),
        };

        ///  Controller area network
        pub const CAN0 = extern struct {
            ///  Control register
            CTL: mmio.Mmio(packed struct(u32) {
                ///  Initial working mode
                IWMOD: u1,
                ///  Sleep working mode
                SLPWMOD: u1,
                ///  Transmit FIFO order
                TFO: u1,
                ///  Receive FIFO overwrite disable
                RFOD: u1,
                ///  Automatic retransmission disable
                ARD: u1,
                ///  Automatic wakeup
                AWU: u1,
                ///  Automatic bus-off recovery
                ABOR: u1,
                ///  Time-triggered communication
                TTC: u1,
                reserved15: u7,
                ///  Software reset
                SWRST: u1,
                ///  Debug freeze
                DFZ: u1,
                padding: u15,
            }),
            ///  Status register
            STAT: mmio.Mmio(packed struct(u32) {
                ///  Initial working state
                IWS: u1,
                ///  Sleep working state
                SLPWS: u1,
                ///  Error interrupt flag
                ERRIF: u1,
                ///  Status change interrupt flag of wakeup from sleep working mode
                WUIF: u1,
                ///  Status change interrupt flag of sleep working mode entering
                SLPIF: u1,
                reserved8: u3,
                ///  Transmitting state
                TS: u1,
                ///  Receiving state
                RS: u1,
                ///  Last sample value of RX pin
                LASTRX: u1,
                ///  RX level
                RXL: u1,
                padding: u20,
            }),
            ///  Transmit status register
            TSTAT: mmio.Mmio(packed struct(u32) {
                ///  Mailbox 0 transmit finished
                MTF0: u1,
                ///  Mailbox 0 transmit finished and no error
                MTFNERR0: u1,
                ///  Mailbox 0 arbitration lost
                MAL0: u1,
                ///  Mailbox 0 transmit error
                MTE0: u1,
                reserved7: u3,
                ///  Mailbox 0 stop transmitting
                MST0: u1,
                ///  Mailbox 1 transmit finished
                MTF1: u1,
                ///  Mailbox 1 transmit finished and no error
                MTFNERR1: u1,
                ///  Mailbox 1 arbitration lost
                MAL1: u1,
                ///  Mailbox 1 transmit error
                MTE1: u1,
                reserved15: u3,
                ///  Mailbox 1 stop transmitting
                MST1: u1,
                ///  Mailbox 2 transmit finished
                MTF2: u1,
                ///  Mailbox 2 transmit finished and no error
                MTFNERR2: u1,
                ///  Mailbox 2 arbitration lost
                MAL2: u1,
                ///  Mailbox 2 transmit error
                MTE2: u1,
                reserved23: u3,
                ///  Mailbox 2 stop transmitting
                MST2: u1,
                ///  number of the transmit FIFO mailbox in which the frame will be transmitted if at least one mailbox is empty
                NUM: u2,
                ///  Transmit mailbox 0 empty
                TME0: u1,
                ///  Transmit mailbox 1 empty
                TME1: u1,
                ///  Transmit mailbox 2 empty
                TME2: u1,
                ///  Transmit mailbox 0 last sending in transmit FIFO
                TMLS0: u1,
                ///  Transmit mailbox 1 last sending in transmit FIFO
                TMLS1: u1,
                ///  Transmit mailbox 2 last sending in transmit FIFO
                TMLS2: u1,
            }),
            ///  Receive message FIFO0 register
            RFIFO0: mmio.Mmio(packed struct(u32) {
                ///  Receive FIFO0 length
                RFL0: u2,
                reserved3: u1,
                ///  Receive FIFO0 full
                RFF0: u1,
                ///  Receive FIFO0 overfull
                RFO0: u1,
                ///  Receive FIFO0 dequeue
                RFD0: u1,
                padding: u26,
            }),
            ///  Receive message FIFO1 register
            RFIFO1: mmio.Mmio(packed struct(u32) {
                ///  Receive FIFO1 length
                RFL1: u2,
                reserved3: u1,
                ///  Receive FIFO1 full
                RFF1: u1,
                ///  Receive FIFO1 overfull
                RFO1: u1,
                ///  Receive FIFO1 dequeue
                RFD1: u1,
                padding: u26,
            }),
            ///  Interrupt enable register
            INTEN: mmio.Mmio(packed struct(u32) {
                ///  Transmit mailbox empty interrupt enable
                TMEIE: u1,
                ///  Receive FIFO0 not empty interrupt enable
                RFNEIE0: u1,
                ///  Receive FIFO0 full interrupt enable
                RFFIE0: u1,
                ///  Receive FIFO0 overfull interrupt enable
                RFOIE0: u1,
                ///  Receive FIFO1 not empty interrupt enable
                RFNEIE1: u1,
                ///  Receive FIFO1 full interrupt enable
                RFFIE1: u1,
                ///  Receive FIFO1 overfull interrupt enable
                RFOIE1: u1,
                reserved8: u1,
                ///  Warning error interrupt enable
                WERRIE: u1,
                ///  Passive error interrupt enable
                PERRIE: u1,
                ///  Bus-off interrupt enable
                BOIE: u1,
                ///  Error number interrupt enable
                ERRNIE: u1,
                reserved15: u3,
                ///  Error interrupt enable
                ERRIE: u1,
                ///  Wakeup interrupt enable
                WIE: u1,
                ///  Sleep working interrupt enable
                SLPWIE: u1,
                padding: u14,
            }),
            ///  Error register
            ERR: mmio.Mmio(packed struct(u32) {
                ///  Warning error
                WERR: u1,
                ///  Passive error
                PERR: u1,
                ///  Bus-off error
                BOERR: u1,
                reserved4: u1,
                ///  Error number
                ERRN: u3,
                reserved16: u9,
                ///  Transmit Error Count defined by the CAN standard
                TECNT: u8,
                ///  Receive Error Count defined by the CAN standard
                RECNT: u8,
            }),
            ///  Bit timing register
            BT: mmio.Mmio(packed struct(u32) {
                ///  Baud rate prescaler
                BAUDPSC: u10,
                reserved16: u6,
                ///  Bit segment 1
                BS1: u4,
                ///  Bit segment 2
                BS2: u3,
                reserved24: u1,
                ///  Resynchronization jump width
                SJW: u2,
                reserved30: u4,
                ///  Loopback communication mode
                LCMOD: u1,
                ///  Silent communication mode
                SCMOD: u1,
            }),
            reserved384: [352]u8,
            ///  Transmit mailbox identifier register 0
            TMI0: mmio.Mmio(packed struct(u32) {
                ///  Transmit enable
                TEN: u1,
                ///  Frame type
                FT: u1,
                ///  Frame format
                FF: u1,
                ///  The frame identifier
                EFID: u18,
                ///  The frame identifier
                SFID_EFID: u11,
            }),
            ///  Transmit mailbox property register 0
            TMP0: mmio.Mmio(packed struct(u32) {
                ///  Data length code
                DLENC: u4,
                reserved8: u4,
                ///  Time stamp enable
                TSEN: u1,
                reserved16: u7,
                ///  Time stamp
                TS: u16,
            }),
            ///  Transmit mailbox data0 register
            TMDATA00: mmio.Mmio(packed struct(u32) {
                ///  Data byte 0
                DB0: u8,
                ///  Data byte 1
                DB1: u8,
                ///  Data byte 2
                DB2: u8,
                ///  Data byte 3
                DB3: u8,
            }),
            ///  Transmit mailbox data1 register
            TMDATA10: mmio.Mmio(packed struct(u32) {
                ///  Data byte 4
                DB4: u8,
                ///  Data byte 5
                DB5: u8,
                ///  Data byte 6
                DB6: u8,
                ///  Data byte 7
                DB7: u8,
            }),
            ///  Transmit mailbox identifier register 1
            TMI1: mmio.Mmio(packed struct(u32) {
                ///  Transmit enable
                TEN: u1,
                ///  Frame type
                FT: u1,
                ///  Frame format
                FF: u1,
                ///  The frame identifier
                EFID: u18,
                ///  The frame identifier
                SFID_EFID: u11,
            }),
            ///  Transmit mailbox property register 1
            TMP1: mmio.Mmio(packed struct(u32) {
                ///  Data length code
                DLENC: u4,
                reserved8: u4,
                ///  Time stamp enable
                TSEN: u1,
                reserved16: u7,
                ///  Time stamp
                TS: u16,
            }),
            ///  Transmit mailbox data0 register
            TMDATA01: mmio.Mmio(packed struct(u32) {
                ///  Data byte 0
                DB0: u8,
                ///  Data byte 1
                DB1: u8,
                ///  Data byte 2
                DB2: u8,
                ///  Data byte 3
                DB3: u8,
            }),
            ///  Transmit mailbox data1 register
            TMDATA11: mmio.Mmio(packed struct(u32) {
                ///  Data byte 4
                DB4: u8,
                ///  Data byte 5
                DB5: u8,
                ///  Data byte 6
                DB6: u8,
                ///  Data byte 7
                DB7: u8,
            }),
            ///  Transmit mailbox identifier register 2
            TMI2: mmio.Mmio(packed struct(u32) {
                ///  Transmit enable
                TEN: u1,
                ///  Frame type
                FT: u1,
                ///  Frame format
                FF: u1,
                ///  The frame identifier
                EFID: u18,
                ///  The frame identifier
                SFID_EFID: u11,
            }),
            ///  Transmit mailbox property register 2
            TMP2: mmio.Mmio(packed struct(u32) {
                ///  Data length code
                DLENC: u4,
                reserved8: u4,
                ///  Time stamp enable
                TSEN: u1,
                reserved16: u7,
                ///  Time stamp
                TS: u16,
            }),
            ///  Transmit mailbox data0 register
            TMDATA02: mmio.Mmio(packed struct(u32) {
                ///  Data byte 0
                DB0: u8,
                ///  Data byte 1
                DB1: u8,
                ///  Data byte 2
                DB2: u8,
                ///  Data byte 3
                DB3: u8,
            }),
            ///  Transmit mailbox data1 register
            TMDATA12: mmio.Mmio(packed struct(u32) {
                ///  Data byte 4
                DB4: u8,
                ///  Data byte 5
                DB5: u8,
                ///  Data byte 6
                DB6: u8,
                ///  Data byte 7
                DB7: u8,
            }),
            ///  Receive FIFO mailbox identifier register
            RFIFOMI0: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Frame type
                FT: u1,
                ///  Frame format
                FF: u1,
                ///  The frame identifier
                EFID: u18,
                ///  The frame identifier
                SFID_EFID: u11,
            }),
            ///  Receive FIFO0 mailbox property register
            RFIFOMP0: mmio.Mmio(packed struct(u32) {
                ///  Data length code
                DLENC: u4,
                reserved8: u4,
                ///  Filtering index
                FI: u8,
                ///  Time stamp
                TS: u16,
            }),
            ///  Receive FIFO0 mailbox data0 register
            RFIFOMDATA00: mmio.Mmio(packed struct(u32) {
                ///  Data byte 0
                DB0: u8,
                ///  Data byte 1
                DB1: u8,
                ///  Data byte 2
                DB2: u8,
                ///  Data byte 3
                DB3: u8,
            }),
            ///  Receive FIFO0 mailbox data1 register
            RFIFOMDATA10: mmio.Mmio(packed struct(u32) {
                ///  Data byte 4
                DB4: u8,
                ///  Data byte 5
                DB5: u8,
                ///  Data byte 6
                DB6: u8,
                ///  Data byte 7
                DB7: u8,
            }),
            ///  Receive FIFO1 mailbox identifier register
            RFIFOMI1: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Frame type
                FT: u1,
                ///  Frame format
                FF: u1,
                ///  The frame identifier
                EFID: u18,
                ///  The frame identifier
                SFID_EFID: u11,
            }),
            ///  Receive FIFO1 mailbox property register
            RFIFOMP1: mmio.Mmio(packed struct(u32) {
                ///  Data length code
                DLENC: u4,
                reserved8: u4,
                ///  Filtering index
                FI: u8,
                ///  Time stamp
                TS: u16,
            }),
            ///  Receive FIFO1 mailbox data0 register
            RFIFOMDATA01: mmio.Mmio(packed struct(u32) {
                ///  Data byte 0
                DB0: u8,
                ///  Data byte 1
                DB1: u8,
                ///  Data byte 2
                DB2: u8,
                ///  Data byte 3
                DB3: u8,
            }),
            ///  Receive FIFO1 mailbox data1 register
            RFIFOMDATA11: mmio.Mmio(packed struct(u32) {
                ///  Data byte 4
                DB4: u8,
                ///  Data byte 5
                DB5: u8,
                ///  Data byte 6
                DB6: u8,
                ///  Data byte 7
                DB7: u8,
            }),
            reserved512: [48]u8,
            ///  Filter control register
            FCTL: mmio.Mmio(packed struct(u32) {
                ///  Filter lock disable
                FLD: u1,
                reserved8: u7,
                ///  Header bank of CAN1 filter
                HBC1F: u6,
                padding: u18,
            }),
            ///  Filter mode configuration register
            FMCFG: mmio.Mmio(packed struct(u32) {
                ///  Filter mode
                FMOD0: u1,
                ///  Filter mode
                FMOD1: u1,
                ///  Filter mode
                FMOD2: u1,
                ///  Filter mode
                FMOD3: u1,
                ///  Filter mode
                FMOD4: u1,
                ///  Filter mode
                FMOD5: u1,
                ///  Filter mode
                FMOD6: u1,
                ///  Filter mode
                FMOD7: u1,
                ///  Filter mode
                FMOD8: u1,
                ///  Filter mode
                FMOD9: u1,
                ///  Filter mode
                FMOD10: u1,
                ///  Filter mode
                FMOD11: u1,
                ///  Filter mode
                FMOD12: u1,
                ///  Filter mode
                FMOD13: u1,
                ///  Filter mode
                FMOD14: u1,
                ///  Filter mode
                FMOD15: u1,
                ///  Filter mode
                FMOD16: u1,
                ///  Filter mode
                FMOD17: u1,
                ///  Filter mode
                FMOD18: u1,
                ///  Filter mode
                FMOD19: u1,
                ///  Filter mode
                FMOD20: u1,
                ///  Filter mode
                FMOD21: u1,
                ///  Filter mode
                FMOD22: u1,
                ///  Filter mode
                FMOD23: u1,
                ///  Filter mode
                FMOD24: u1,
                ///  Filter mode
                FMOD25: u1,
                ///  Filter mode
                FMOD26: u1,
                ///  Filter mode
                FMOD27: u1,
                padding: u4,
            }),
            reserved524: [4]u8,
            ///  Filter scale configuration register
            FSCFG: mmio.Mmio(packed struct(u32) {
                ///  Filter scale configuration
                FS0: u1,
                ///  Filter scale configuration
                FS1: u1,
                ///  Filter scale configuration
                FS2: u1,
                ///  Filter scale configuration
                FS3: u1,
                ///  Filter scale configuration
                FS4: u1,
                ///  Filter scale configuration
                FS5: u1,
                ///  Filter scale configuration
                FS6: u1,
                ///  Filter scale configuration
                FS7: u1,
                ///  Filter scale configuration
                FS8: u1,
                ///  Filter scale configuration
                FS9: u1,
                ///  Filter scale configuration
                FS10: u1,
                ///  Filter scale configuration
                FS11: u1,
                ///  Filter scale configuration
                FS12: u1,
                ///  Filter scale configuration
                FS13: u1,
                ///  Filter scale configuration
                FS14: u1,
                ///  Filter scale configuration
                FS15: u1,
                ///  Filter scale configuration
                FS16: u1,
                ///  Filter scale configuration
                FS17: u1,
                ///  Filter scale configuration
                FS18: u1,
                ///  Filter scale configuration
                FS19: u1,
                ///  Filter scale configuration
                FS20: u1,
                ///  Filter scale configuration
                FS21: u1,
                ///  Filter scale configuration
                FS22: u1,
                ///  Filter scale configuration
                FS23: u1,
                ///  Filter scale configuration
                FS24: u1,
                ///  Filter scale configuration
                FS25: u1,
                ///  Filter scale configuration
                FS26: u1,
                ///  Filter scale configuration
                FS27: u1,
                padding: u4,
            }),
            reserved532: [4]u8,
            ///  Filter associated FIFO register
            FAFIFO: mmio.Mmio(packed struct(u32) {
                ///  Filter 0 associated with FIFO
                FAF0: u1,
                ///  Filter 1 associated with FIFO
                FAF1: u1,
                ///  Filter 2 associated with FIFO
                FAF2: u1,
                ///  Filter 3 associated with FIFO
                FAF3: u1,
                ///  Filter 4 associated with FIFO
                FAF4: u1,
                ///  Filter 5 associated with FIFO
                FAF5: u1,
                ///  Filter 6 associated with FIFO
                FAF6: u1,
                ///  Filter 7 associated with FIFO
                FAF7: u1,
                ///  Filter 8 associated with FIFO
                FAF8: u1,
                ///  Filter 9 associated with FIFO
                FAF9: u1,
                ///  Filter 10 associated with FIFO
                FAF10: u1,
                ///  Filter 11 associated with FIFO
                FAF11: u1,
                ///  Filter 12 associated with FIFO
                FAF12: u1,
                ///  Filter 13 associated with FIFO
                FAF13: u1,
                ///  Filter 14 associated with FIFO
                FAF14: u1,
                ///  Filter 15 associated with FIFO
                FAF15: u1,
                ///  Filter 16 associated with FIFO
                FAF16: u1,
                ///  Filter 17 associated with FIFO
                FAF17: u1,
                ///  Filter 18 associated with FIFO
                FAF18: u1,
                ///  Filter 19 associated with FIFO
                FAF19: u1,
                ///  Filter 20 associated with FIFO
                FAF20: u1,
                ///  Filter 21 associated with FIFO
                FAF21: u1,
                ///  Filter 22 associated with FIFO
                FAF22: u1,
                ///  Filter 23 associated with FIFO
                FAF23: u1,
                ///  Filter 24 associated with FIFO
                FAF24: u1,
                ///  Filter 25 associated with FIFO
                FAF25: u1,
                ///  Filter 26 associated with FIFO
                FAF26: u1,
                ///  Filter 27 associated with FIFO
                FAF27: u1,
                padding: u4,
            }),
            reserved540: [4]u8,
            ///  Filter working register
            FW: mmio.Mmio(packed struct(u32) {
                ///  Filter working
                FW0: u1,
                ///  Filter working
                FW1: u1,
                ///  Filter working
                FW2: u1,
                ///  Filter working
                FW3: u1,
                ///  Filter working
                FW4: u1,
                ///  Filter working
                FW5: u1,
                ///  Filter working
                FW6: u1,
                ///  Filter working
                FW7: u1,
                ///  Filter working
                FW8: u1,
                ///  Filter working
                FW9: u1,
                ///  Filter working
                FW10: u1,
                ///  Filter working
                FW11: u1,
                ///  Filter working
                FW12: u1,
                ///  Filter working
                FW13: u1,
                ///  Filter working
                FW14: u1,
                ///  Filter working
                FW15: u1,
                ///  Filter working
                FW16: u1,
                ///  Filter working
                FW17: u1,
                ///  Filter working
                FW18: u1,
                ///  Filter working
                FW19: u1,
                ///  Filter working
                FW20: u1,
                ///  Filter working
                FW21: u1,
                ///  Filter working
                FW22: u1,
                ///  Filter working
                FW23: u1,
                ///  Filter working
                FW24: u1,
                ///  Filter working
                FW25: u1,
                ///  Filter working
                FW26: u1,
                ///  Filter working
                FW27: u1,
                padding: u4,
            }),
            reserved576: [32]u8,
            ///  Filter 0 data 0 register
            F0DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 0 data 1 register
            F0DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 1 data 0 register
            F1DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 1 data 1 register
            F1DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 2 data 0 register
            F2DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 2 data 1 register
            F2DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 3 data 0 register
            F3DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 3 data 1 register
            F3DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 4 data 0 register
            F4DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 4 data 1 register
            F4DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 5 data 0 register
            F5DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 5 data 1 register
            F5DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 6 data 0 register
            F6DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 6 data 1 register
            F6DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 7 data 0 register
            F7DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 7 data 1 register
            F7DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 8 data 0 register
            F8DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 8 data 1 register
            F8DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 9 data 0 register
            F9DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 9 data 1 register
            F9DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 10 data 0 register
            F10DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 10 data 1 register
            F10DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 11 data 0 register
            F11DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 11 data 1 register
            F11DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 12 data 0 register
            F12DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 12 data 1 register
            F12DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 13 data 0 register
            F13DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 13 data 1 register
            F13DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 14 data 0 register
            F14DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 14 data 1 register
            F14DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 15 data 0 register
            F15DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 15 data 1 register
            F15DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 16 data 0 register
            F16DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 16 data 1 register
            F16DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 17 data 0 register
            F17DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 17 data 1 register
            F17DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 18 data 0 register
            F18DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 18 data 1 register
            F18DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 19 data 0 register
            F19DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 19 data 1 register
            F19DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 20 data 0 register
            F20DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 20 data 1 register
            F20DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 21 data 0 register
            F21DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 21 data 1 register
            F21DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 22 data 0 register
            F22DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 22 data 1 register
            F22DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 23 data 0 register
            F23DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 23 data 1 register
            F23DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 24 data 0 register
            F24DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 24 data 1 register
            F24DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 25 data 0 register
            F25DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 25 data 1 register
            F25DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 26 data 0 register
            F26DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 26 data 1 register
            F26DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 27 data 0 register
            F27DATA0: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
            ///  Filter 27 data 1 register
            F27DATA1: mmio.Mmio(packed struct(u32) {
                ///  Filter bits
                FD0: u1,
                ///  Filter bits
                FD1: u1,
                ///  Filter bits
                FD2: u1,
                ///  Filter bits
                FD3: u1,
                ///  Filter bits
                FD4: u1,
                ///  Filter bits
                FD5: u1,
                ///  Filter bits
                FD6: u1,
                ///  Filter bits
                FD7: u1,
                ///  Filter bits
                FD8: u1,
                ///  Filter bits
                FD9: u1,
                ///  Filter bits
                FD10: u1,
                ///  Filter bits
                FD11: u1,
                ///  Filter bits
                FD12: u1,
                ///  Filter bits
                FD13: u1,
                ///  Filter bits
                FD14: u1,
                ///  Filter bits
                FD15: u1,
                ///  Filter bits
                FD16: u1,
                ///  Filter bits
                FD17: u1,
                ///  Filter bits
                FD18: u1,
                ///  Filter bits
                FD19: u1,
                ///  Filter bits
                FD20: u1,
                ///  Filter bits
                FD21: u1,
                ///  Filter bits
                FD22: u1,
                ///  Filter bits
                FD23: u1,
                ///  Filter bits
                FD24: u1,
                ///  Filter bits
                FD25: u1,
                ///  Filter bits
                FD26: u1,
                ///  Filter bits
                FD27: u1,
                ///  Filter bits
                FD28: u1,
                ///  Filter bits
                FD29: u1,
                ///  Filter bits
                FD30: u1,
                ///  Filter bits
                FD31: u1,
            }),
        };

        ///  Window watchdog timer
        pub const WWDGT = extern struct {
            ///  Control register
            CTL: mmio.Mmio(packed struct(u32) {
                ///  7-bit counter
                CNT: u7,
                ///  Activation bit
                WDGTEN: u1,
                padding: u24,
            }),
            ///  Configuration register
            CFG: mmio.Mmio(packed struct(u32) {
                ///  7-bit window value
                WIN: u7,
                ///  Prescaler
                PSC: u2,
                ///  Early wakeup interrupt
                EWIE: u1,
                padding: u22,
            }),
            ///  Status register
            STAT: mmio.Mmio(packed struct(u32) {
                ///  Early wakeup interrupt flag
                EWIF: u1,
                padding: u31,
            }),
        };

        ///  cyclic redundancy check calculation unit
        pub const CRC = extern struct {
            ///  Data register
            DATA: mmio.Mmio(packed struct(u32) {
                ///  CRC calculation result bits
                DATA: u32,
            }),
            ///  Free data register
            FDATA: mmio.Mmio(packed struct(u32) {
                ///  Free Data Register bits
                FDATA: u8,
                padding: u24,
            }),
            ///  Control register
            CTL: mmio.Mmio(packed struct(u32) {
                ///  reset bit
                RST: u1,
                padding: u31,
            }),
        };

        ///  Digital-to-analog converter
        pub const DAC = extern struct {
            ///  control register
            CTL: mmio.Mmio(packed struct(u32) {
                ///  DAC0 enable
                DEN0: u1,
                ///  DAC0 output buffer turn off
                DBOFF0: u1,
                ///  DAC0 trigger enable
                DTEN0: u1,
                ///  DAC0 trigger selection
                DTSEL0: u3,
                ///  DAC0 noise wave mode
                DWM0: u2,
                ///  DAC0 noise wave bit width
                DWBW0: u4,
                ///  DAC0 DMA enable
                DDMAEN0: u1,
                reserved16: u3,
                ///  DAC1 enable
                DEN1: u1,
                ///  DAC1 output buffer turn off
                DBOFF1: u1,
                ///  DAC1 trigger enable
                DTEN1: u1,
                ///  DAC1 trigger selection
                DTSEL1: u3,
                ///  DAC1 noise wave mode
                DWM1: u2,
                ///  DAC1 noise wave bit width
                DWBW1: u4,
                ///  DAC1 DMA enable
                DDMAEN1: u1,
                padding: u3,
            }),
            ///  software trigger register
            SWT: mmio.Mmio(packed struct(u32) {
                ///  DAC0 software trigger
                SWTR0: u1,
                ///  DAC1 software trigger
                SWTR1: u1,
                padding: u30,
            }),
            ///  DAC0 12-bit right-aligned data holding register
            DAC0_R12DH: mmio.Mmio(packed struct(u32) {
                ///  DAC0 12-bit right-aligned data
                DAC0_DH: u12,
                padding: u20,
            }),
            ///  DAC0 12-bit left-aligned data holding register
            DAC0_L12DH: mmio.Mmio(packed struct(u32) {
                reserved4: u4,
                ///  DAC0 12-bit left-aligned data
                DAC0_DH: u12,
                padding: u16,
            }),
            ///  DAC0 8-bit right aligned data holding register
            DAC0_R8DH: mmio.Mmio(packed struct(u32) {
                ///  DAC0 8-bit right-aligned data
                DAC0_DH: u8,
                padding: u24,
            }),
            ///  DAC1 12-bit right-aligned data holding register
            DAC1_R12DH: mmio.Mmio(packed struct(u32) {
                ///  DAC1 12-bit right-aligned data
                DAC1_DH: u12,
                padding: u20,
            }),
            ///  DAC1 12-bit left aligned data holding register
            DAC1_L12DH: mmio.Mmio(packed struct(u32) {
                reserved4: u4,
                ///  DAC1 12-bit left-aligned data
                DAC1_DH: u12,
                padding: u16,
            }),
            ///  DAC1 8-bit right aligned data holding register
            DAC1_R8DH: mmio.Mmio(packed struct(u32) {
                ///  DAC1 8-bit right-aligned data
                DAC1_DH: u8,
                padding: u24,
            }),
            ///  DAC concurrent mode 12-bit right-aligned data holding register
            DACC_R12DH: mmio.Mmio(packed struct(u32) {
                ///  DAC0 12-bit right-aligned data
                DAC0_DH: u12,
                reserved16: u4,
                ///  DAC1 12-bit right-aligned data
                DAC1_DH: u12,
                padding: u4,
            }),
            ///  DAC concurrent mode 12-bit left aligned data holding register
            DACC_L12DH: mmio.Mmio(packed struct(u32) {
                reserved4: u4,
                ///  DAC0 12-bit left-aligned data
                DAC0_DH: u12,
                reserved20: u4,
                ///  DAC1 12-bit left-aligned data
                DAC1_DH: u12,
            }),
            ///  DAC concurrent mode 8-bit right aligned data holding register
            DACC_R8DH: mmio.Mmio(packed struct(u32) {
                ///  DAC0 8-bit right-aligned data
                DAC0_DH: u8,
                ///  DAC1 8-bit right-aligned data
                DAC1_DH: u8,
                padding: u16,
            }),
            ///  DAC0 data output register
            DAC0_DO: mmio.Mmio(packed struct(u32) {
                ///  DAC0 data output
                DAC0_DO: u12,
                padding: u20,
            }),
            ///  DAC1 data output register
            DAC1_DO: mmio.Mmio(packed struct(u32) {
                ///  DAC1 data output
                DAC1_DO: u12,
                padding: u20,
            }),
        };

        ///  Debug support
        pub const DBG = extern struct {
            ///  ID code register
            ID: mmio.Mmio(packed struct(u32) {
                ///  DBG ID code register
                ID_CODE: u32,
            }),
            ///  Control register 0
            CTL: mmio.Mmio(packed struct(u32) {
                ///  Sleep mode hold register
                SLP_HOLD: u1,
                ///  Deep-sleep mode hold register
                DSLP_HOLD: u1,
                ///  Standby mode hold register
                STB_HOLD: u1,
                reserved8: u5,
                ///  FWDGT hold bit
                FWDGT_HOLD: u1,
                ///  WWDGT hold bit
                WWDGT_HOLD: u1,
                ///  TIMER 0 hold bit
                TIMER0_HOLD: u1,
                ///  TIMER 1 hold bit
                TIMER1_HOLD: u1,
                ///  TIMER 2 hold bit
                TIMER2_HOLD: u1,
                ///  TIMER 23 hold bit
                TIMER3_HOLD: u1,
                ///  CAN0 hold bit
                CAN0_HOLD: u1,
                ///  I2C0 hold bit
                I2C0_HOLD: u1,
                ///  I2C1 hold bit
                I2C1_HOLD: u1,
                reserved18: u1,
                ///  TIMER4_HOLD
                TIMER4_HOLD: u1,
                ///  TIMER 5 hold bit
                TIMER5_HOLD: u1,
                ///  TIMER 6 hold bit
                TIMER6_HOLD: u1,
                ///  CAN1 hold bit
                CAN1_HOLD: u1,
                padding: u10,
            }),
        };

        ///  DMA controller
        pub const DMA0 = extern struct {
            ///  Interrupt flag register
            INTF: mmio.Mmio(packed struct(u32) {
                ///  Global interrupt flag of channel 0
                GIF0: u1,
                ///  Full Transfer finish flag of channe 0
                FTFIF0: u1,
                ///  Half transfer finish flag of channel 0
                HTFIF0: u1,
                ///  Error flag of channel 0
                ERRIF0: u1,
                ///  Global interrupt flag of channel 1
                GIF1: u1,
                ///  Full Transfer finish flag of channe 1
                FTFIF1: u1,
                ///  Half transfer finish flag of channel 1
                HTFIF1: u1,
                ///  Error flag of channel 1
                ERRIF1: u1,
                ///  Global interrupt flag of channel 2
                GIF2: u1,
                ///  Full Transfer finish flag of channe 2
                FTFIF2: u1,
                ///  Half transfer finish flag of channel 2
                HTFIF2: u1,
                ///  Error flag of channel 2
                ERRIF2: u1,
                ///  Global interrupt flag of channel 3
                GIF3: u1,
                ///  Full Transfer finish flag of channe 3
                FTFIF3: u1,
                ///  Half transfer finish flag of channel 3
                HTFIF3: u1,
                ///  Error flag of channel 3
                ERRIF3: u1,
                ///  Global interrupt flag of channel 4
                GIF4: u1,
                ///  Full Transfer finish flag of channe 4
                FTFIF4: u1,
                ///  Half transfer finish flag of channel 4
                HTFIF4: u1,
                ///  Error flag of channel 4
                ERRIF4: u1,
                ///  Global interrupt flag of channel 5
                GIF5: u1,
                ///  Full Transfer finish flag of channe 5
                FTFIF5: u1,
                ///  Half transfer finish flag of channel 5
                HTFIF5: u1,
                ///  Error flag of channel 5
                ERRIF5: u1,
                ///  Global interrupt flag of channel 6
                GIF6: u1,
                ///  Full Transfer finish flag of channe 6
                FTFIF6: u1,
                ///  Half transfer finish flag of channel 6
                HTFIF6: u1,
                ///  Error flag of channel 6
                ERRIF6: u1,
                padding: u4,
            }),
            ///  Interrupt flag clear register
            INTC: mmio.Mmio(packed struct(u32) {
                ///  Clear global interrupt flag of channel 0
                GIFC0: u1,
                ///  Clear bit for full transfer finish flag of channel 0
                FTFIFC0: u1,
                ///  Clear bit for half transfer finish flag of channel 0
                HTFIFC0: u1,
                ///  Clear bit for error flag of channel 0
                ERRIFC0: u1,
                ///  Clear global interrupt flag of channel 1
                GIFC1: u1,
                ///  Clear bit for full transfer finish flag of channel 1
                FTFIFC1: u1,
                ///  Clear bit for half transfer finish flag of channel 1
                HTFIFC1: u1,
                ///  Clear bit for error flag of channel 1
                ERRIFC1: u1,
                ///  Clear global interrupt flag of channel 2
                GIFC2: u1,
                ///  Clear bit for full transfer finish flag of channel 2
                FTFIFC2: u1,
                ///  Clear bit for half transfer finish flag of channel 2
                HTFIFC2: u1,
                ///  Clear bit for error flag of channel 2
                ERRIFC2: u1,
                ///  Clear global interrupt flag of channel 3
                GIFC3: u1,
                ///  Clear bit for full transfer finish flag of channel 3
                FTFIFC3: u1,
                ///  Clear bit for half transfer finish flag of channel 3
                HTFIFC3: u1,
                ///  Clear bit for error flag of channel 3
                ERRIFC3: u1,
                ///  Clear global interrupt flag of channel 4
                GIFC4: u1,
                ///  Clear bit for full transfer finish flag of channel 4
                FTFIFC4: u1,
                ///  Clear bit for half transfer finish flag of channel 4
                HTFIFC4: u1,
                ///  Clear bit for error flag of channel 4
                ERRIFC4: u1,
                ///  Clear global interrupt flag of channel 5
                GIFC5: u1,
                ///  Clear bit for full transfer finish flag of channel 5
                FTFIFC5: u1,
                ///  Clear bit for half transfer finish flag of channel 5
                HTFIFC5: u1,
                ///  Clear bit for error flag of channel 5
                ERRIFC5: u1,
                ///  Clear global interrupt flag of channel 6
                GIFC6: u1,
                ///  Clear bit for full transfer finish flag of channel 6
                FTFIFC6: u1,
                ///  Clear bit for half transfer finish flag of channel 6
                HTFIFC6: u1,
                ///  Clear bit for error flag of channel 6
                ERRIFC6: u1,
                padding: u4,
            }),
            ///  Channel 0 control register
            CH0CTL: mmio.Mmio(packed struct(u32) {
                ///  Channel enable
                CHEN: u1,
                ///  Enable bit for channel full transfer finish interrupt
                FTFIE: u1,
                ///  Enable bit for channel half transfer finish interrupt
                HTFIE: u1,
                ///  Enable bit for channel error interrupt
                ERRIE: u1,
                ///  Transfer direction
                DIR: u1,
                ///  Circular mode enable
                CMEN: u1,
                ///  Next address generation algorithm of peripheral
                PNAGA: u1,
                ///  Next address generation algorithm of memory
                MNAGA: u1,
                ///  Transfer data size of peripheral
                PWIDTH: u2,
                ///  Transfer data size of memory
                MWIDTH: u2,
                ///  Priority level
                PRIO: u2,
                ///  Memory to Memory Mode
                M2M: u1,
                padding: u17,
            }),
            ///  Channel 0 counter register
            CH0CNT: mmio.Mmio(packed struct(u32) {
                ///  Transfer counter
                CNT: u16,
                padding: u16,
            }),
            ///  Channel 0 peripheral base address register
            CH0PADDR: mmio.Mmio(packed struct(u32) {
                ///  Peripheral base address
                PADDR: u32,
            }),
            ///  Channel 0 memory base address register
            CH0MADDR: mmio.Mmio(packed struct(u32) {
                ///  Memory base address
                MADDR: u32,
            }),
            reserved28: [4]u8,
            ///  Channel 1 control register
            CH1CTL: mmio.Mmio(packed struct(u32) {
                ///  Channel enable
                CHEN: u1,
                ///  Enable bit for channel full transfer finish interrupt
                FTFIE: u1,
                ///  Enable bit for channel half transfer finish interrupt
                HTFIE: u1,
                ///  Enable bit for channel error interrupt
                ERRIE: u1,
                ///  Transfer direction
                DIR: u1,
                ///  Circular mode enable
                CMEN: u1,
                ///  Next address generation algorithm of peripheral
                PNAGA: u1,
                ///  Next address generation algorithm of memory
                MNAGA: u1,
                ///  Transfer data size of peripheral
                PWIDTH: u2,
                ///  Transfer data size of memory
                MWIDTH: u2,
                ///  Priority level
                PRIO: u2,
                ///  Memory to Memory Mode
                M2M: u1,
                padding: u17,
            }),
            ///  Channel 1 counter register
            CH1CNT: mmio.Mmio(packed struct(u32) {
                ///  Transfer counter
                CNT: u16,
                padding: u16,
            }),
            ///  Channel 1 peripheral base address register
            CH1PADDR: mmio.Mmio(packed struct(u32) {
                ///  Peripheral base address
                PADDR: u32,
            }),
            ///  Channel 1 memory base address register
            CH1MADDR: mmio.Mmio(packed struct(u32) {
                ///  Memory base address
                MADDR: u32,
            }),
            reserved48: [4]u8,
            ///  Channel 2 control register
            CH2CTL: mmio.Mmio(packed struct(u32) {
                ///  Channel enable
                CHEN: u1,
                ///  Enable bit for channel full transfer finish interrupt
                FTFIE: u1,
                ///  Enable bit for channel half transfer finish interrupt
                HTFIE: u1,
                ///  Enable bit for channel error interrupt
                ERRIE: u1,
                ///  Transfer direction
                DIR: u1,
                ///  Circular mode enable
                CMEN: u1,
                ///  Next address generation algorithm of peripheral
                PNAGA: u1,
                ///  Next address generation algorithm of memory
                MNAGA: u1,
                ///  Transfer data size of peripheral
                PWIDTH: u2,
                ///  Transfer data size of memory
                MWIDTH: u2,
                ///  Priority level
                PRIO: u2,
                ///  Memory to Memory Mode
                M2M: u1,
                padding: u17,
            }),
            ///  Channel 2 counter register
            CH2CNT: mmio.Mmio(packed struct(u32) {
                ///  Transfer counter
                CNT: u16,
                padding: u16,
            }),
            ///  Channel 2 peripheral base address register
            CH2PADDR: mmio.Mmio(packed struct(u32) {
                ///  Peripheral base address
                PADDR: u32,
            }),
            ///  Channel 2 memory base address register
            CH2MADDR: mmio.Mmio(packed struct(u32) {
                ///  Memory base address
                MADDR: u32,
            }),
            reserved68: [4]u8,
            ///  Channel 3 control register
            CH3CTL: mmio.Mmio(packed struct(u32) {
                ///  Channel enable
                CHEN: u1,
                ///  Enable bit for channel full transfer finish interrupt
                FTFIE: u1,
                ///  Enable bit for channel half transfer finish interrupt
                HTFIE: u1,
                ///  Enable bit for channel error interrupt
                ERRIE: u1,
                ///  Transfer direction
                DIR: u1,
                ///  Circular mode enable
                CMEN: u1,
                ///  Next address generation algorithm of peripheral
                PNAGA: u1,
                ///  Next address generation algorithm of memory
                MNAGA: u1,
                ///  Transfer data size of peripheral
                PWIDTH: u2,
                ///  Transfer data size of memory
                MWIDTH: u2,
                ///  Priority level
                PRIO: u2,
                ///  Memory to Memory Mode
                M2M: u1,
                padding: u17,
            }),
            ///  Channel 3 counter register
            CH3CNT: mmio.Mmio(packed struct(u32) {
                ///  Transfer counter
                CNT: u16,
                padding: u16,
            }),
            ///  Channel 3 peripheral base address register
            CH3PADDR: mmio.Mmio(packed struct(u32) {
                ///  Peripheral base address
                PADDR: u32,
            }),
            ///  Channel 3 memory base address register
            CH3MADDR: mmio.Mmio(packed struct(u32) {
                ///  Memory base address
                MADDR: u32,
            }),
            reserved88: [4]u8,
            ///  Channel 4 control register
            CH4CTL: mmio.Mmio(packed struct(u32) {
                ///  Channel enable
                CHEN: u1,
                ///  Enable bit for channel full transfer finish interrupt
                FTFIE: u1,
                ///  Enable bit for channel half transfer finish interrupt
                HTFIE: u1,
                ///  Enable bit for channel error interrupt
                ERRIE: u1,
                ///  Transfer direction
                DIR: u1,
                ///  Circular mode enable
                CMEN: u1,
                ///  Next address generation algorithm of peripheral
                PNAGA: u1,
                ///  Next address generation algorithm of memory
                MNAGA: u1,
                ///  Transfer data size of peripheral
                PWIDTH: u2,
                ///  Transfer data size of memory
                MWIDTH: u2,
                ///  Priority level
                PRIO: u2,
                ///  Memory to Memory Mode
                M2M: u1,
                padding: u17,
            }),
            ///  Channel 4 counter register
            CH4CNT: mmio.Mmio(packed struct(u32) {
                ///  Transfer counter
                CNT: u16,
                padding: u16,
            }),
            ///  Channel 4 peripheral base address register
            CH4PADDR: mmio.Mmio(packed struct(u32) {
                ///  Peripheral base address
                PADDR: u32,
            }),
            ///  Channel 4 memory base address register
            CH4MADDR: mmio.Mmio(packed struct(u32) {
                ///  Memory base address
                MADDR: u32,
            }),
            reserved108: [4]u8,
            ///  Channel 5 control register
            CH5CTL: mmio.Mmio(packed struct(u32) {
                ///  Channel enable
                CHEN: u1,
                ///  Enable bit for channel full transfer finish interrupt
                FTFIE: u1,
                ///  Enable bit for channel half transfer finish interrupt
                HTFIE: u1,
                ///  Enable bit for channel error interrupt
                ERRIE: u1,
                ///  Transfer direction
                DIR: u1,
                ///  Circular mode enable
                CMEN: u1,
                ///  Next address generation algorithm of peripheral
                PNAGA: u1,
                ///  Next address generation algorithm of memory
                MNAGA: u1,
                ///  Transfer data size of peripheral
                PWIDTH: u2,
                ///  Transfer data size of memory
                MWIDTH: u2,
                ///  Priority level
                PRIO: u2,
                ///  Memory to Memory Mode
                M2M: u1,
                padding: u17,
            }),
            ///  Channel 5 counter register
            CH5CNT: mmio.Mmio(packed struct(u32) {
                ///  Transfer counter
                CNT: u16,
                padding: u16,
            }),
            ///  Channel 5 peripheral base address register
            CH5PADDR: mmio.Mmio(packed struct(u32) {
                ///  Peripheral base address
                PADDR: u32,
            }),
            ///  Channel 5 memory base address register
            CH5MADDR: mmio.Mmio(packed struct(u32) {
                ///  Memory base address
                MADDR: u32,
            }),
            reserved128: [4]u8,
            ///  Channel 6 control register
            CH6CTL: mmio.Mmio(packed struct(u32) {
                ///  Channel enable
                CHEN: u1,
                ///  Enable bit for channel full transfer finish interrupt
                FTFIE: u1,
                ///  Enable bit for channel half transfer finish interrupt
                HTFIE: u1,
                ///  Enable bit for channel error interrupt
                ERRIE: u1,
                ///  Transfer direction
                DIR: u1,
                ///  Circular mode enable
                CMEN: u1,
                ///  Next address generation algorithm of peripheral
                PNAGA: u1,
                ///  Next address generation algorithm of memory
                MNAGA: u1,
                ///  Transfer data size of peripheral
                PWIDTH: u2,
                ///  Transfer data size of memory
                MWIDTH: u2,
                ///  Priority level
                PRIO: u2,
                ///  Memory to Memory Mode
                M2M: u1,
                padding: u17,
            }),
            ///  Channel 6 counter register
            CH6CNT: mmio.Mmio(packed struct(u32) {
                ///  Transfer counter
                CNT: u16,
                padding: u16,
            }),
            ///  Channel 6 peripheral base address register
            CH6PADDR: mmio.Mmio(packed struct(u32) {
                ///  Peripheral base address
                PADDR: u32,
            }),
            ///  Channel 6 memory base address register
            CH6MADDR: mmio.Mmio(packed struct(u32) {
                ///  Memory base address
                MADDR: u32,
            }),
        };

        ///  Direct memory access controller
        pub const DMA1 = extern struct {
            ///  Interrupt flag register
            INTF: mmio.Mmio(packed struct(u32) {
                ///  Global interrupt flag of channel 0
                GIF0: u1,
                ///  Full Transfer finish flag of channe 0
                FTFIF0: u1,
                ///  Half transfer finish flag of channel 0
                HTFIF0: u1,
                ///  Error flag of channel 0
                ERRIF0: u1,
                ///  Global interrupt flag of channel 1
                GIF1: u1,
                ///  Full Transfer finish flag of channe 1
                FTFIF1: u1,
                ///  Half transfer finish flag of channel 1
                HTFIF1: u1,
                ///  Error flag of channel 1
                ERRIF1: u1,
                ///  Global interrupt flag of channel 2
                GIF2: u1,
                ///  Full Transfer finish flag of channe 2
                FTFIF2: u1,
                ///  Half transfer finish flag of channel 2
                HTFIF2: u1,
                ///  Error flag of channel 2
                ERRIF2: u1,
                ///  Global interrupt flag of channel 3
                GIF3: u1,
                ///  Full Transfer finish flag of channe 3
                FTFIF3: u1,
                ///  Half transfer finish flag of channel 3
                HTFIF3: u1,
                ///  Error flag of channel 3
                ERRIF3: u1,
                ///  Global interrupt flag of channel 4
                GIF4: u1,
                ///  Full Transfer finish flag of channe 4
                FTFIF4: u1,
                ///  Half transfer finish flag of channel 4
                HTFIF4: u1,
                ///  Error flag of channel 4
                ERRIF4: u1,
                padding: u12,
            }),
            ///  Interrupt flag clear register
            INTC: mmio.Mmio(packed struct(u32) {
                ///  Clear global interrupt flag of channel 0
                GIFC0: u1,
                ///  Clear bit for full transfer finish flag of channel 0
                FTFIFC0: u1,
                ///  Clear bit for half transfer finish flag of channel 0
                HTFIFC0: u1,
                ///  Clear bit for error flag of channel 0
                ERRIFC0: u1,
                ///  Clear global interrupt flag of channel 1
                GIFC1: u1,
                ///  Clear bit for full transfer finish flag of channel 1
                FTFIFC1: u1,
                ///  Clear bit for half transfer finish flag of channel 1
                HTFIFC1: u1,
                ///  Clear bit for error flag of channel 1
                ERRIFC1: u1,
                ///  Clear global interrupt flag of channel 2
                GIFC2: u1,
                ///  Clear bit for full transfer finish flag of channel 2
                FTFIFC2: u1,
                ///  Clear bit for half transfer finish flag of channel 2
                HTFIFC2: u1,
                ///  Clear bit for error flag of channel 2
                ERRIFC2: u1,
                ///  Clear global interrupt flag of channel 3
                GIFC3: u1,
                ///  Clear bit for full transfer finish flag of channel 3
                FTFIFC3: u1,
                ///  Clear bit for half transfer finish flag of channel 3
                HTFIFC3: u1,
                ///  Clear bit for error flag of channel 3
                ERRIFC3: u1,
                ///  Clear global interrupt flag of channel 4
                GIFC4: u1,
                ///  Clear bit for full transfer finish flag of channel 4
                FTFIFC4: u1,
                ///  Clear bit for half transfer finish flag of channel 4
                HTFIFC4: u1,
                ///  Clear bit for error flag of channel 4
                ERRIFC4: u1,
                padding: u12,
            }),
            ///  Channel 0 control register
            CH0CTL: mmio.Mmio(packed struct(u32) {
                ///  Channel enable
                CHEN: u1,
                ///  Enable bit for channel full transfer finish interrupt
                FTFIE: u1,
                ///  Enable bit for channel half transfer finish interrupt
                HTFIE: u1,
                ///  Enable bit for channel error interrupt
                ERRIE: u1,
                ///  Transfer direction
                DIR: u1,
                ///  Circular mode enable
                CMEN: u1,
                ///  Next address generation algorithm of peripheral
                PNAGA: u1,
                ///  Next address generation algorithm of memory
                MNAGA: u1,
                ///  Transfer data size of peripheral
                PWIDTH: u2,
                ///  Transfer data size of memory
                MWIDTH: u2,
                ///  Priority level
                PRIO: u2,
                ///  Memory to Memory Mode
                M2M: u1,
                padding: u17,
            }),
            ///  Channel 0 counter register
            CH0CNT: mmio.Mmio(packed struct(u32) {
                ///  Transfer counter
                CNT: u16,
                padding: u16,
            }),
            ///  Channel 0 peripheral base address register
            CH0PADDR: mmio.Mmio(packed struct(u32) {
                ///  Peripheral base address
                PADDR: u32,
            }),
            ///  Channel 0 memory base address register
            CH0MADDR: mmio.Mmio(packed struct(u32) {
                ///  Memory base address
                MADDR: u32,
            }),
            reserved28: [4]u8,
            ///  Channel 1 control register
            CH1CTL: mmio.Mmio(packed struct(u32) {
                ///  Channel enable
                CHEN: u1,
                ///  Enable bit for channel full transfer finish interrupt
                FTFIE: u1,
                ///  Enable bit for channel half transfer finish interrupt
                HTFIE: u1,
                ///  Enable bit for channel error interrupt
                ERRIE: u1,
                ///  Transfer direction
                DIR: u1,
                ///  Circular mode enable
                CMEN: u1,
                ///  Next address generation algorithm of peripheral
                PNAGA: u1,
                ///  Next address generation algorithm of memory
                MNAGA: u1,
                ///  Transfer data size of peripheral
                PWIDTH: u2,
                ///  Transfer data size of memory
                MWIDTH: u2,
                ///  Priority level
                PRIO: u2,
                ///  Memory to Memory Mode
                M2M: u1,
                padding: u17,
            }),
            ///  Channel 1 counter register
            CH1CNT: mmio.Mmio(packed struct(u32) {
                ///  Transfer counter
                CNT: u16,
                padding: u16,
            }),
            ///  Channel 1 peripheral base address register
            CH1PADDR: mmio.Mmio(packed struct(u32) {
                ///  Peripheral base address
                PADDR: u32,
            }),
            ///  Channel 1 memory base address register
            CH1MADDR: mmio.Mmio(packed struct(u32) {
                ///  Memory base address
                MADDR: u32,
            }),
            reserved48: [4]u8,
            ///  Channel 2 control register
            CH2CTL: mmio.Mmio(packed struct(u32) {
                ///  Channel enable
                CHEN: u1,
                ///  Enable bit for channel full transfer finish interrupt
                FTFIE: u1,
                ///  Enable bit for channel half transfer finish interrupt
                HTFIE: u1,
                ///  Enable bit for channel error interrupt
                ERRIE: u1,
                ///  Transfer direction
                DIR: u1,
                ///  Circular mode enable
                CMEN: u1,
                ///  Next address generation algorithm of peripheral
                PNAGA: u1,
                ///  Next address generation algorithm of memory
                MNAGA: u1,
                ///  Transfer data size of peripheral
                PWIDTH: u2,
                ///  Transfer data size of memory
                MWIDTH: u2,
                ///  Priority level
                PRIO: u2,
                ///  Memory to Memory Mode
                M2M: u1,
                padding: u17,
            }),
            ///  Channel 2 counter register
            CH2CNT: mmio.Mmio(packed struct(u32) {
                ///  Transfer counter
                CNT: u16,
                padding: u16,
            }),
            ///  Channel 2 peripheral base address register
            CH2PADDR: mmio.Mmio(packed struct(u32) {
                ///  Peripheral base address
                PADDR: u32,
            }),
            ///  Channel 2 memory base address register
            CH2MADDR: mmio.Mmio(packed struct(u32) {
                ///  Memory base address
                MADDR: u32,
            }),
            reserved68: [4]u8,
            ///  Channel 3 control register
            CH3CTL: mmio.Mmio(packed struct(u32) {
                ///  Channel enable
                CHEN: u1,
                ///  Enable bit for channel full transfer finish interrupt
                FTFIE: u1,
                ///  Enable bit for channel half transfer finish interrupt
                HTFIE: u1,
                ///  Enable bit for channel error interrupt
                ERRIE: u1,
                ///  Transfer direction
                DIR: u1,
                ///  Circular mode enable
                CMEN: u1,
                ///  Next address generation algorithm of peripheral
                PNAGA: u1,
                ///  Next address generation algorithm of memory
                MNAGA: u1,
                ///  Transfer data size of peripheral
                PWIDTH: u2,
                ///  Transfer data size of memory
                MWIDTH: u2,
                ///  Priority level
                PRIO: u2,
                ///  Memory to Memory Mode
                M2M: u1,
                padding: u17,
            }),
            ///  Channel 3 counter register
            CH3CNT: mmio.Mmio(packed struct(u32) {
                ///  Transfer counter
                CNT: u16,
                padding: u16,
            }),
            ///  Channel 3 peripheral base address register
            CH3PADDR: mmio.Mmio(packed struct(u32) {
                ///  Peripheral base address
                PADDR: u32,
            }),
            ///  Channel 3 memory base address register
            CH3MADDR: mmio.Mmio(packed struct(u32) {
                ///  Memory base address
                MADDR: u32,
            }),
            reserved88: [4]u8,
            ///  Channel 4 control register
            CH4CTL: mmio.Mmio(packed struct(u32) {
                ///  Channel enable
                CHEN: u1,
                ///  Enable bit for channel full transfer finish interrupt
                FTFIE: u1,
                ///  Enable bit for channel half transfer finish interrupt
                HTFIE: u1,
                ///  Enable bit for channel error interrupt
                ERRIE: u1,
                ///  Transfer direction
                DIR: u1,
                ///  Circular mode enable
                CMEN: u1,
                ///  Next address generation algorithm of peripheral
                PNAGA: u1,
                ///  Next address generation algorithm of memory
                MNAGA: u1,
                ///  Transfer data size of peripheral
                PWIDTH: u2,
                ///  Transfer data size of memory
                MWIDTH: u2,
                ///  Priority level
                PRIO: u2,
                ///  Memory to Memory Mode
                M2M: u1,
                padding: u17,
            }),
            ///  Channel 4 counter register
            CH4CNT: mmio.Mmio(packed struct(u32) {
                ///  Transfer counter
                CNT: u16,
                padding: u16,
            }),
            ///  Channel 4 peripheral base address register
            CH4PADDR: mmio.Mmio(packed struct(u32) {
                ///  Peripheral base address
                PADDR: u32,
            }),
            ///  Channel 4 memory base address register
            CH4MADDR: mmio.Mmio(packed struct(u32) {
                ///  Memory base address
                MADDR: u32,
            }),
        };

        ///  External memory controller
        pub const EXMC = extern struct {
            ///  SRAM/NOR flash control register 0
            SNCTL0: mmio.Mmio(packed struct(u32) {
                ///  NOR bank enable
                NRBKEN: u1,
                ///  NOR bank memory address/data multiplexing
                NRMUX: u1,
                ///  NOR bank memory type
                NRTP: u2,
                ///  NOR bank memory data bus width
                NRW: u2,
                ///  NOR Flash access enable
                NREN: u1,
                reserved9: u2,
                ///  NWAIT signal polarity
                NRWTPOL: u1,
                reserved12: u2,
                ///  Write enable
                WREN: u1,
                ///  NWAIT signal enable
                NRWTEN: u1,
                reserved15: u1,
                ///  Asynchronous wait
                ASYNCWAIT: u1,
                padding: u16,
            }),
            ///  SRAM/NOR flash timing configuration register 0
            SNTCFG0: mmio.Mmio(packed struct(u32) {
                ///  Address setup time
                ASET: u4,
                ///  Address hold time
                AHLD: u4,
                ///  Data setup time
                DSET: u8,
                ///  Bus latency
                BUSLAT: u4,
                padding: u12,
            }),
            ///  SRAM/NOR flash control register 1
            SNCTL1: mmio.Mmio(packed struct(u32) {
                ///  NOR bank enable
                NRBKEN: u1,
                ///  NOR bank memory address/data multiplexing
                NRMUX: u1,
                ///  NOR bank memory type
                NRTP: u2,
                ///  NOR bank memory data bus width
                NRW: u2,
                ///  NOR Flash access enable
                NREN: u1,
                reserved9: u2,
                ///  NWAIT signal polarity
                NRWTPOL: u1,
                reserved12: u2,
                ///  Write enable
                WREN: u1,
                ///  NWAIT signal enable
                NRWTEN: u1,
                reserved15: u1,
                ///  Asynchronous wait
                ASYNCWAIT: u1,
                padding: u16,
            }),
        };

        ///  External interrupt/event controller
        pub const EXTI = extern struct {
            ///  Interrupt enable register (EXTI_INTEN)
            INTEN: mmio.Mmio(packed struct(u32) {
                ///  Enable Interrupt on line 0
                INTEN0: u1,
                ///  Enable Interrupt on line 1
                INTEN1: u1,
                ///  Enable Interrupt on line 2
                INTEN2: u1,
                ///  Enable Interrupt on line 3
                INTEN3: u1,
                ///  Enable Interrupt on line 4
                INTEN4: u1,
                ///  Enable Interrupt on line 5
                INTEN5: u1,
                ///  Enable Interrupt on line 6
                INTEN6: u1,
                ///  Enable Interrupt on line 7
                INTEN7: u1,
                ///  Enable Interrupt on line 8
                INTEN8: u1,
                ///  Enable Interrupt on line 9
                INTEN9: u1,
                ///  Enable Interrupt on line 10
                INTEN10: u1,
                ///  Enable Interrupt on line 11
                INTEN11: u1,
                ///  Enable Interrupt on line 12
                INTEN12: u1,
                ///  Enable Interrupt on line 13
                INTEN13: u1,
                ///  Enable Interrupt on line 14
                INTEN14: u1,
                ///  Enable Interrupt on line 15
                INTEN15: u1,
                ///  Enable Interrupt on line 16
                INTEN16: u1,
                ///  Enable Interrupt on line 17
                INTEN17: u1,
                ///  Enable Interrupt on line 18
                INTEN18: u1,
                padding: u13,
            }),
            ///  Event enable register (EXTI_EVEN)
            EVEN: mmio.Mmio(packed struct(u32) {
                ///  Enable Event on line 0
                EVEN0: u1,
                ///  Enable Event on line 1
                EVEN1: u1,
                ///  Enable Event on line 2
                EVEN2: u1,
                ///  Enable Event on line 3
                EVEN3: u1,
                ///  Enable Event on line 4
                EVEN4: u1,
                ///  Enable Event on line 5
                EVEN5: u1,
                ///  Enable Event on line 6
                EVEN6: u1,
                ///  Enable Event on line 7
                EVEN7: u1,
                ///  Enable Event on line 8
                EVEN8: u1,
                ///  Enable Event on line 9
                EVEN9: u1,
                ///  Enable Event on line 10
                EVEN10: u1,
                ///  Enable Event on line 11
                EVEN11: u1,
                ///  Enable Event on line 12
                EVEN12: u1,
                ///  Enable Event on line 13
                EVEN13: u1,
                ///  Enable Event on line 14
                EVEN14: u1,
                ///  Enable Event on line 15
                EVEN15: u1,
                ///  Enable Event on line 16
                EVEN16: u1,
                ///  Enable Event on line 17
                EVEN17: u1,
                ///  Enable Event on line 18
                EVEN18: u1,
                padding: u13,
            }),
            ///  Rising Edge Trigger Enable register (EXTI_RTEN)
            RTEN: mmio.Mmio(packed struct(u32) {
                ///  Rising edge trigger enable of line 0
                RTEN0: u1,
                ///  Rising edge trigger enable of line 1
                RTEN1: u1,
                ///  Rising edge trigger enable of line 2
                RTEN2: u1,
                ///  Rising edge trigger enable of line 3
                RTEN3: u1,
                ///  Rising edge trigger enable of line 4
                RTEN4: u1,
                ///  Rising edge trigger enable of line 5
                RTEN5: u1,
                ///  Rising edge trigger enable of line 6
                RTEN6: u1,
                ///  Rising edge trigger enable of line 7
                RTEN7: u1,
                ///  Rising edge trigger enable of line 8
                RTEN8: u1,
                ///  Rising edge trigger enable of line 9
                RTEN9: u1,
                ///  Rising edge trigger enable of line 10
                RTEN10: u1,
                ///  Rising edge trigger enable of line 11
                RTEN11: u1,
                ///  Rising edge trigger enable of line 12
                RTEN12: u1,
                ///  Rising edge trigger enable of line 13
                RTEN13: u1,
                ///  Rising edge trigger enable of line 14
                RTEN14: u1,
                ///  Rising edge trigger enable of line 15
                RTEN15: u1,
                ///  Rising edge trigger enable of line 16
                RTEN16: u1,
                ///  Rising edge trigger enable of line 17
                RTEN17: u1,
                ///  Rising edge trigger enable of line 18
                RTEN18: u1,
                padding: u13,
            }),
            ///  Falling Egde Trigger Enable register (EXTI_FTEN)
            FTEN: mmio.Mmio(packed struct(u32) {
                ///  Falling edge trigger enable of line 0
                FTEN0: u1,
                ///  Falling edge trigger enable of line 1
                FTEN1: u1,
                ///  Falling edge trigger enable of line 2
                FTEN2: u1,
                ///  Falling edge trigger enable of line 3
                FTEN3: u1,
                ///  Falling edge trigger enable of line 4
                FTEN4: u1,
                ///  Falling edge trigger enable of line 5
                FTEN5: u1,
                ///  Falling edge trigger enable of line 6
                FTEN6: u1,
                ///  Falling edge trigger enable of line 7
                FTEN7: u1,
                ///  Falling edge trigger enable of line 8
                FTEN8: u1,
                ///  Falling edge trigger enable of line 9
                FTEN9: u1,
                ///  Falling edge trigger enable of line 10
                FTEN10: u1,
                ///  Falling edge trigger enable of line 11
                FTEN11: u1,
                ///  Falling edge trigger enable of line 12
                FTEN12: u1,
                ///  Falling edge trigger enable of line 13
                FTEN13: u1,
                ///  Falling edge trigger enable of line 14
                FTEN14: u1,
                ///  Falling edge trigger enable of line 15
                FTEN15: u1,
                ///  Falling edge trigger enable of line 16
                FTEN16: u1,
                ///  Falling edge trigger enable of line 17
                FTEN17: u1,
                ///  Falling edge trigger enable of line 18
                FTEN18: u1,
                padding: u13,
            }),
            ///  Software interrupt event register (EXTI_SWIEV)
            SWIEV: mmio.Mmio(packed struct(u32) {
                ///  Interrupt/Event software trigger on line 0
                SWIEV0: u1,
                ///  Interrupt/Event software trigger on line 1
                SWIEV1: u1,
                ///  Interrupt/Event software trigger on line 2
                SWIEV2: u1,
                ///  Interrupt/Event software trigger on line 3
                SWIEV3: u1,
                ///  Interrupt/Event software trigger on line 4
                SWIEV4: u1,
                ///  Interrupt/Event software trigger on line 5
                SWIEV5: u1,
                ///  Interrupt/Event software trigger on line 6
                SWIEV6: u1,
                ///  Interrupt/Event software trigger on line 7
                SWIEV7: u1,
                ///  Interrupt/Event software trigger on line 8
                SWIEV8: u1,
                ///  Interrupt/Event software trigger on line 9
                SWIEV9: u1,
                ///  Interrupt/Event software trigger on line 10
                SWIEV10: u1,
                ///  Interrupt/Event software trigger on line 11
                SWIEV11: u1,
                ///  Interrupt/Event software trigger on line 12
                SWIEV12: u1,
                ///  Interrupt/Event software trigger on line 13
                SWIEV13: u1,
                ///  Interrupt/Event software trigger on line 14
                SWIEV14: u1,
                ///  Interrupt/Event software trigger on line 15
                SWIEV15: u1,
                ///  Interrupt/Event software trigger on line 16
                SWIEV16: u1,
                ///  Interrupt/Event software trigger on line 17
                SWIEV17: u1,
                ///  Interrupt/Event software trigger on line 18
                SWIEV18: u1,
                padding: u13,
            }),
            ///  Pending register (EXTI_PD)
            PD: mmio.Mmio(packed struct(u32) {
                ///  Interrupt pending status of line 0
                PD0: u1,
                ///  Interrupt pending status of line 1
                PD1: u1,
                ///  Interrupt pending status of line 2
                PD2: u1,
                ///  Interrupt pending status of line 3
                PD3: u1,
                ///  Interrupt pending status of line 4
                PD4: u1,
                ///  Interrupt pending status of line 5
                PD5: u1,
                ///  Interrupt pending status of line 6
                PD6: u1,
                ///  Interrupt pending status of line 7
                PD7: u1,
                ///  Interrupt pending status of line 8
                PD8: u1,
                ///  Interrupt pending status of line 9
                PD9: u1,
                ///  Interrupt pending status of line 10
                PD10: u1,
                ///  Interrupt pending status of line 11
                PD11: u1,
                ///  Interrupt pending status of line 12
                PD12: u1,
                ///  Interrupt pending status of line 13
                PD13: u1,
                ///  Interrupt pending status of line 14
                PD14: u1,
                ///  Interrupt pending status of line 15
                PD15: u1,
                ///  Interrupt pending status of line 16
                PD16: u1,
                ///  Interrupt pending status of line 17
                PD17: u1,
                ///  Interrupt pending status of line 18
                PD18: u1,
                padding: u13,
            }),
        };

        ///  FMC
        pub const FMC = extern struct {
            ///  wait state counter register
            WS: mmio.Mmio(packed struct(u32) {
                ///  wait state counter register
                WSCNT: u3,
                padding: u29,
            }),
            ///  Unlock key register 0
            KEY0: mmio.Mmio(packed struct(u32) {
                ///  FMC_CTL0 unlock key
                KEY: u32,
            }),
            ///  Option byte unlock key register
            OBKEY: mmio.Mmio(packed struct(u32) {
                ///  FMC_ CTL0 option byte operation unlock register
                OBKEY: u32,
            }),
            ///  Status register 0
            STAT0: mmio.Mmio(packed struct(u32) {
                ///  The flash is busy bit
                BUSY: u1,
                reserved2: u1,
                ///  Program error flag bit
                PGERR: u1,
                reserved4: u1,
                ///  Erase/Program protection error flag bit
                WPERR: u1,
                ///  End of operation flag bit
                ENDF: u1,
                padding: u26,
            }),
            ///  Control register 0
            CTL0: mmio.Mmio(packed struct(u32) {
                ///  Main flash program for bank0 command bit
                PG: u1,
                ///  Main flash page erase for bank0 command bit
                PER: u1,
                ///  Main flash mass erase for bank0 command bit
                MER: u1,
                reserved4: u1,
                ///  Option bytes program command bit
                OBPG: u1,
                ///  Option bytes erase command bit
                OBER: u1,
                ///  Send erase command to FMC bit
                START: u1,
                ///  FMC_CTL0 lock bit
                LK: u1,
                reserved9: u1,
                ///  Option byte erase/program enable bit
                OBWEN: u1,
                ///  Error interrupt enable bit
                ERRIE: u1,
                reserved12: u1,
                ///  End of operation interrupt enable bit
                ENDIE: u1,
                padding: u19,
            }),
            ///  Address register 0
            ADDR0: mmio.Mmio(packed struct(u32) {
                ///  Flash erase/program command address bits
                ADDR: u32,
            }),
            reserved28: [4]u8,
            ///  Option byte status register
            OBSTAT: mmio.Mmio(packed struct(u32) {
                ///  Option bytes read error bit
                OBERR: u1,
                ///  Option bytes security protection code
                SPC: u1,
                ///  Store USER of option bytes block after system reset
                USER: u8,
                ///  Store DATA[15:0] of option bytes block after system reset
                DATA: u16,
                padding: u6,
            }),
            ///  Erase/Program Protection register
            WP: mmio.Mmio(packed struct(u32) {
                ///  Store WP[31:0] of option bytes block after system reset
                WP: u32,
            }),
            reserved256: [220]u8,
            ///  Product ID register
            PID: mmio.Mmio(packed struct(u32) {
                ///  Product reserved ID code register
                PID: u32,
            }),
        };

        ///  free watchdog timer
        pub const FWDGT = extern struct {
            ///  Control register
            CTL: mmio.Mmio(packed struct(u32) {
                ///  Key value
                CMD: u16,
                padding: u16,
            }),
            ///  Prescaler register
            PSC: mmio.Mmio(packed struct(u32) {
                ///  Free watchdog timer prescaler selection
                PSC: u3,
                padding: u29,
            }),
            ///  Reload register
            RLD: mmio.Mmio(packed struct(u32) {
                ///  Free watchdog timer counter reload value
                RLD: u12,
                padding: u20,
            }),
            ///  Status register
            STAT: mmio.Mmio(packed struct(u32) {
                ///  Free watchdog timer prescaler value update
                PUD: u1,
                ///  Free watchdog timer counter reload value update
                RUD: u1,
                padding: u30,
            }),
        };

        ///  General-purpose I/Os
        pub const GPIOA = extern struct {
            ///  port control register 0
            CTL0: mmio.Mmio(packed struct(u32) {
                ///  Port x mode bits (x = 0)
                MD0: u2,
                ///  Port x configuration bits (x = 0)
                CTL0: u2,
                ///  Port x mode bits (x = 1)
                MD1: u2,
                ///  Port x configuration bits (x = 1)
                CTL1: u2,
                ///  Port x mode bits (x = 2 )
                MD2: u2,
                ///  Port x configuration bits (x = 2)
                CTL2: u2,
                ///  Port x mode bits (x = 3 )
                MD3: u2,
                ///  Port x configuration bits (x = 3)
                CTL3: u2,
                ///  Port x mode bits (x = 4)
                MD4: u2,
                ///  Port x configuration bits (x = 4)
                CTL4: u2,
                ///  Port x mode bits (x = 5)
                MD5: u2,
                ///  Port x configuration bits (x = 5)
                CTL5: u2,
                ///  Port x mode bits (x = 6)
                MD6: u2,
                ///  Port x configuration bits (x = 6)
                CTL6: u2,
                ///  Port x mode bits (x = 7)
                MD7: u2,
                ///  Port x configuration bits (x = 7)
                CTL7: u2,
            }),
            ///  port control register 1
            CTL1: mmio.Mmio(packed struct(u32) {
                ///  Port x mode bits (x = 8)
                MD8: u2,
                ///  Port x configuration bits (x = 8)
                CTL8: u2,
                ///  Port x mode bits (x = 9)
                MD9: u2,
                ///  Port x configuration bits (x = 9)
                CTL9: u2,
                ///  Port x mode bits (x = 10 )
                MD10: u2,
                ///  Port x configuration bits (x = 10)
                CTL10: u2,
                ///  Port x mode bits (x = 11 )
                MD11: u2,
                ///  Port x configuration bits (x = 11)
                CTL11: u2,
                ///  Port x mode bits (x = 12)
                MD12: u2,
                ///  Port x configuration bits (x = 12)
                CTL12: u2,
                ///  Port x mode bits (x = 13)
                MD13: u2,
                ///  Port x configuration bits (x = 13)
                CTL13: u2,
                ///  Port x mode bits (x = 14)
                MD14: u2,
                ///  Port x configuration bits (x = 14)
                CTL14: u2,
                ///  Port x mode bits (x = 15)
                MD15: u2,
                ///  Port x configuration bits (x = 15)
                CTL15: u2,
            }),
            ///  Port input status register
            ISTAT: mmio.Mmio(packed struct(u32) {
                ///  Port input status
                ISTAT0: u1,
                ///  Port input status
                ISTAT1: u1,
                ///  Port input status
                ISTAT2: u1,
                ///  Port input status
                ISTAT3: u1,
                ///  Port input status
                ISTAT4: u1,
                ///  Port input status
                ISTAT5: u1,
                ///  Port input status
                ISTAT6: u1,
                ///  Port input status
                ISTAT7: u1,
                ///  Port input status
                ISTAT8: u1,
                ///  Port input status
                ISTAT9: u1,
                ///  Port input status
                ISTAT10: u1,
                ///  Port input status
                ISTAT11: u1,
                ///  Port input status
                ISTAT12: u1,
                ///  Port input status
                ISTAT13: u1,
                ///  Port input status
                ISTAT14: u1,
                ///  Port input status
                ISTAT15: u1,
                padding: u16,
            }),
            ///  Port output control register
            OCTL: mmio.Mmio(packed struct(u32) {
                ///  Port output control
                OCTL0: u1,
                ///  Port output control
                OCTL1: u1,
                ///  Port output control
                OCTL2: u1,
                ///  Port output control
                OCTL3: u1,
                ///  Port output control
                OCTL4: u1,
                ///  Port output control
                OCTL5: u1,
                ///  Port output control
                OCTL6: u1,
                ///  Port output control
                OCTL7: u1,
                ///  Port output control
                OCTL8: u1,
                ///  Port output control
                OCTL9: u1,
                ///  Port output control
                OCTL10: u1,
                ///  Port output control
                OCTL11: u1,
                ///  Port output control
                OCTL12: u1,
                ///  Port output control
                OCTL13: u1,
                ///  Port output control
                OCTL14: u1,
                ///  Port output control
                OCTL15: u1,
                padding: u16,
            }),
            ///  Port bit operate register
            BOP: mmio.Mmio(packed struct(u32) {
                ///  Port 0 Set bit
                BOP0: u1,
                ///  Port 1 Set bit
                BOP1: u1,
                ///  Port 2 Set bit
                BOP2: u1,
                ///  Port 3 Set bit
                BOP3: u1,
                ///  Port 4 Set bit
                BOP4: u1,
                ///  Port 5 Set bit
                BOP5: u1,
                ///  Port 6 Set bit
                BOP6: u1,
                ///  Port 7 Set bit
                BOP7: u1,
                ///  Port 8 Set bit
                BOP8: u1,
                ///  Port 9 Set bit
                BOP9: u1,
                ///  Port 10 Set bit
                BOP10: u1,
                ///  Port 11 Set bit
                BOP11: u1,
                ///  Port 12 Set bit
                BOP12: u1,
                ///  Port 13 Set bit
                BOP13: u1,
                ///  Port 14 Set bit
                BOP14: u1,
                ///  Port 15 Set bit
                BOP15: u1,
                ///  Port 0 Clear bit
                CR0: u1,
                ///  Port 1 Clear bit
                CR1: u1,
                ///  Port 2 Clear bit
                CR2: u1,
                ///  Port 3 Clear bit
                CR3: u1,
                ///  Port 4 Clear bit
                CR4: u1,
                ///  Port 5 Clear bit
                CR5: u1,
                ///  Port 6 Clear bit
                CR6: u1,
                ///  Port 7 Clear bit
                CR7: u1,
                ///  Port 8 Clear bit
                CR8: u1,
                ///  Port 9 Clear bit
                CR9: u1,
                ///  Port 10 Clear bit
                CR10: u1,
                ///  Port 11 Clear bit
                CR11: u1,
                ///  Port 12 Clear bit
                CR12: u1,
                ///  Port 13 Clear bit
                CR13: u1,
                ///  Port 14 Clear bit
                CR14: u1,
                ///  Port 15 Clear bit
                CR15: u1,
            }),
            ///  Port bit clear register
            BC: mmio.Mmio(packed struct(u32) {
                ///  Port 0 Clear bit
                CR0: u1,
                ///  Port 1 Clear bit
                CR1: u1,
                ///  Port 2 Clear bit
                CR2: u1,
                ///  Port 3 Clear bit
                CR3: u1,
                ///  Port 4 Clear bit
                CR4: u1,
                ///  Port 5 Clear bit
                CR5: u1,
                ///  Port 6 Clear bit
                CR6: u1,
                ///  Port 7 Clear bit
                CR7: u1,
                ///  Port 8 Clear bit
                CR8: u1,
                ///  Port 9 Clear bit
                CR9: u1,
                ///  Port 10 Clear bit
                CR10: u1,
                ///  Port 11 Clear bit
                CR11: u1,
                ///  Port 12 Clear bit
                CR12: u1,
                ///  Port 13 Clear bit
                CR13: u1,
                ///  Port 14 Clear bit
                CR14: u1,
                ///  Port 15 Clear bit
                CR15: u1,
                padding: u16,
            }),
            ///  GPIO port configuration lock register
            LOCK: mmio.Mmio(packed struct(u32) {
                ///  Port Lock bit 0
                LK0: u1,
                ///  Port Lock bit 1
                LK1: u1,
                ///  Port Lock bit 2
                LK2: u1,
                ///  Port Lock bit 3
                LK3: u1,
                ///  Port Lock bit 4
                LK4: u1,
                ///  Port Lock bit 5
                LK5: u1,
                ///  Port Lock bit 6
                LK6: u1,
                ///  Port Lock bit 7
                LK7: u1,
                ///  Port Lock bit 8
                LK8: u1,
                ///  Port Lock bit 9
                LK9: u1,
                ///  Port Lock bit 10
                LK10: u1,
                ///  Port Lock bit 11
                LK11: u1,
                ///  Port Lock bit 12
                LK12: u1,
                ///  Port Lock bit 13
                LK13: u1,
                ///  Port Lock bit 14
                LK14: u1,
                ///  Port Lock bit 15
                LK15: u1,
                ///  Lock sequence key
                LKK: u1,
                padding: u15,
            }),
        };

        ///  USB on the go full speed
        pub const USBFS_PWRCLK = extern struct {
            ///  power and clock gating control register (PWRCLKCTL)
            PWRCLKCTL: mmio.Mmio(packed struct(u32) {
                ///  Stop the USB clock
                SUCLK: u1,
                ///  Stop HCLK
                SHCLK: u1,
                padding: u30,
            }),
        };

        ///  USB on the go full speed device
        pub const USBFS_DEVICE = extern struct {
            ///  device configuration register (DCFG)
            DCFG: mmio.Mmio(packed struct(u32) {
                ///  Device speed
                DS: u2,
                ///  Non-zero-length status OUT handshake
                NZLSOH: u1,
                reserved4: u1,
                ///  Device address
                DAR: u7,
                ///  end of periodic frame time
                EOPFT: u2,
                padding: u19,
            }),
            ///  device control register (DCTL)
            DCTL: mmio.Mmio(packed struct(u32) {
                ///  Remote wakeup
                RWKUP: u1,
                ///  Soft disconnect
                SD: u1,
                ///  Global IN NAK status
                GINS: u1,
                ///  Global OUT NAK status
                GONS: u1,
                reserved7: u3,
                ///  Set global IN NAK
                SGINAK: u1,
                ///  Clear global IN NAK
                CGINAK: u1,
                ///  Set global OUT NAK
                SGONAK: u1,
                ///  Clear global OUT NAK
                CGONAK: u1,
                ///  Power-on initialization flag
                POIF: u1,
                padding: u20,
            }),
            ///  device status register (DSTAT)
            DSTAT: mmio.Mmio(packed struct(u32) {
                ///  Suspend status
                SPST: u1,
                ///  Enumerated speed
                ES: u2,
                reserved8: u5,
                ///  Frame number of the received SOF
                FNRSOF: u14,
                padding: u10,
            }),
            reserved16: [4]u8,
            ///  device IN endpoint common interrupt mask register (DIEPINTEN)
            DIEPINTEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer finished interrupt enable
                TFEN: u1,
                ///  Endpoint disabled interrupt enable
                EPDISEN: u1,
                reserved3: u1,
                ///  Control IN timeout condition interrupt enable (Non-isochronous endpoints)
                CITOEN: u1,
                ///  Endpoint Tx FIFO underrun interrupt enable bit
                EPTXFUDEN: u1,
                reserved6: u1,
                ///  IN endpoint NAK effective interrupt enable
                IEPNEEN: u1,
                padding: u25,
            }),
            ///  device OUT endpoint common interrupt enable register (DOEPINTEN)
            DOEPINTEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer finished interrupt enable
                TFEN: u1,
                ///  Endpoint disabled interrupt enable
                EPDISEN: u1,
                reserved3: u1,
                ///  SETUP phase finished interrupt enable
                STPFEN: u1,
                ///  Endpoint Rx FIFO overrun interrupt enable
                EPRXFOVREN: u1,
                reserved6: u1,
                ///  Back-to-back SETUP packets interrupt enable
                BTBSTPEN: u1,
                padding: u25,
            }),
            ///  device all endpoints interrupt register (DAEPINT)
            DAEPINT: mmio.Mmio(packed struct(u32) {
                ///  Device all IN endpoint interrupt bits
                IEPITB: u4,
                reserved16: u12,
                ///  Device all OUT endpoint interrupt bits
                OEPITB: u4,
                padding: u12,
            }),
            ///  Device all endpoints interrupt enable register (DAEPINTEN)
            DAEPINTEN: mmio.Mmio(packed struct(u32) {
                ///  IN EP interrupt interrupt enable bits
                IEPIE: u4,
                reserved16: u12,
                ///  OUT endpoint interrupt enable bits
                OEPIE: u4,
                padding: u12,
            }),
            reserved40: [8]u8,
            ///  device VBUS discharge time register
            DVBUSDT: mmio.Mmio(packed struct(u32) {
                ///  Device VBUS discharge time
                DVBUSDT: u16,
                padding: u16,
            }),
            ///  device VBUS pulsing time register
            DVBUSPT: mmio.Mmio(packed struct(u32) {
                ///  Device VBUS pulsing time
                DVBUSPT: u12,
                padding: u20,
            }),
            reserved52: [4]u8,
            ///  device IN endpoint FIFO empty interrupt enable register
            DIEPFEINTEN: mmio.Mmio(packed struct(u32) {
                ///  IN EP Tx FIFO empty interrupt enable bits
                IEPTXFEIE: u4,
                padding: u28,
            }),
            reserved256: [200]u8,
            ///  device IN endpoint 0 control register (DIEP0CTL)
            DIEP0CTL: mmio.Mmio(packed struct(u32) {
                ///  Maximum packet length
                MPL: u2,
                reserved15: u13,
                ///  endpoint active
                EPACT: u1,
                reserved17: u1,
                ///  NAK status
                NAKS: u1,
                ///  Endpoint type
                EPTYPE: u2,
                reserved21: u1,
                ///  STALL handshake
                STALL: u1,
                ///  TxFIFO number
                TXFNUM: u4,
                ///  Clear NAK
                CNAK: u1,
                ///  Set NAK
                SNAK: u1,
                reserved30: u2,
                ///  Endpoint disable
                EPD: u1,
                ///  Endpoint enable
                EPEN: u1,
            }),
            reserved264: [4]u8,
            ///  device endpoint-0 interrupt register
            DIEP0INTF: mmio.Mmio(packed struct(u32) {
                ///  Transfer finished
                TF: u1,
                ///  Endpoint finished
                EPDIS: u1,
                reserved3: u1,
                ///  Control in timeout interrupt
                CITO: u1,
                ///  Endpoint Tx FIFO underrun
                EPTXFUD: u1,
                reserved6: u1,
                ///  IN endpoint NAK effective
                IEPNE: u1,
                ///  Transmit FIFO empty
                TXFE: u1,
                padding: u24,
            }),
            reserved272: [4]u8,
            ///  device IN endpoint-0 transfer length register
            DIEP0LEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer length
                TLEN: u7,
                reserved19: u12,
                ///  Packet count
                PCNT: u2,
                padding: u11,
            }),
            reserved280: [4]u8,
            ///  device IN endpoint 0 transmit FIFO status register
            DIEP0TFSTAT: mmio.Mmio(packed struct(u32) {
                ///  IN endpoint TxFIFO space remaining
                IEPTFS: u16,
                padding: u16,
            }),
            reserved288: [4]u8,
            ///  device in endpoint-1 control register
            DIEP1CTL: mmio.Mmio(packed struct(u32) {
                ///  maximum packet length
                MPL: u11,
                reserved15: u4,
                ///  Endpoint active
                EPACT: u1,
                ///  EOFRM/DPID
                EOFRM_DPID: u1,
                ///  NAK status
                NAKS: u1,
                ///  Endpoint type
                EPTYPE: u2,
                reserved21: u1,
                ///  STALL handshake
                STALL: u1,
                ///  Tx FIFO number
                TXFNUM: u4,
                ///  Clear NAK
                CNAK: u1,
                ///  Set NAK
                SNAK: u1,
                ///  SD0PID/SEVNFRM
                SD0PID_SEVENFRM: u1,
                ///  Set DATA1 PID/Set odd frame
                SD1PID_SODDFRM: u1,
                ///  Endpoint disable
                EPD: u1,
                ///  Endpoint enable
                EPEN: u1,
            }),
            reserved296: [4]u8,
            ///  device endpoint-1 interrupt register
            DIEP1INTF: mmio.Mmio(packed struct(u32) {
                ///  Transfer finished
                TF: u1,
                ///  Endpoint finished
                EPDIS: u1,
                reserved3: u1,
                ///  Control in timeout interrupt
                CITO: u1,
                ///  Endpoint Tx FIFO underrun
                EPTXFUD: u1,
                reserved6: u1,
                ///  IN endpoint NAK effective
                IEPNE: u1,
                ///  Transmit FIFO empty
                TXFE: u1,
                padding: u24,
            }),
            reserved304: [4]u8,
            ///  device IN endpoint-1 transfer length register
            DIEP1LEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer length
                TLEN: u19,
                ///  Packet count
                PCNT: u10,
                ///  Multi packet count per frame
                MCPF: u2,
                padding: u1,
            }),
            reserved312: [4]u8,
            ///  device IN endpoint 1 transmit FIFO status register
            DIEP1TFSTAT: mmio.Mmio(packed struct(u32) {
                ///  IN endpoint TxFIFO space remaining
                IEPTFS: u16,
                padding: u16,
            }),
            reserved320: [4]u8,
            ///  device endpoint-2 control register
            DIEP2CTL: mmio.Mmio(packed struct(u32) {
                ///  maximum packet length
                MPL: u11,
                reserved15: u4,
                ///  Endpoint active
                EPACT: u1,
                ///  EOFRM/DPID
                EOFRM_DPID: u1,
                ///  NAK status
                NAKS: u1,
                ///  Endpoint type
                EPTYPE: u2,
                reserved21: u1,
                ///  STALL handshake
                STALL: u1,
                ///  Tx FIFO number
                TXFNUM: u4,
                ///  Clear NAK
                CNAK: u1,
                ///  Set NAK
                SNAK: u1,
                ///  SD0PID/SEVNFRM
                SD0PID_SEVENFRM: u1,
                ///  Set DATA1 PID/Set odd frame
                SD1PID_SODDFRM: u1,
                ///  Endpoint disable
                EPD: u1,
                ///  Endpoint enable
                EPEN: u1,
            }),
            reserved328: [4]u8,
            ///  device endpoint-2 interrupt register
            DIEP2INTF: mmio.Mmio(packed struct(u32) {
                ///  Transfer finished
                TF: u1,
                ///  Endpoint finished
                EPDIS: u1,
                reserved3: u1,
                ///  Control in timeout interrupt
                CITO: u1,
                ///  Endpoint Tx FIFO underrun
                EPTXFUD: u1,
                reserved6: u1,
                ///  IN endpoint NAK effective
                IEPNE: u1,
                ///  Transmit FIFO empty
                TXFE: u1,
                padding: u24,
            }),
            reserved336: [4]u8,
            ///  device IN endpoint-2 transfer length register
            DIEP2LEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer length
                TLEN: u19,
                ///  Packet count
                PCNT: u10,
                ///  Multi packet count per frame
                MCPF: u2,
                padding: u1,
            }),
            reserved344: [4]u8,
            ///  device IN endpoint 2 transmit FIFO status register
            DIEP2TFSTAT: mmio.Mmio(packed struct(u32) {
                ///  IN endpoint TxFIFO space remaining
                IEPTFS: u16,
                padding: u16,
            }),
            reserved352: [4]u8,
            ///  device endpoint-3 control register
            DIEP3CTL: mmio.Mmio(packed struct(u32) {
                ///  maximum packet length
                MPL: u11,
                reserved15: u4,
                ///  Endpoint active
                EPACT: u1,
                ///  EOFRM/DPID
                EOFRM_DPID: u1,
                ///  NAK status
                NAKS: u1,
                ///  Endpoint type
                EPTYPE: u2,
                reserved21: u1,
                ///  STALL handshake
                STALL: u1,
                ///  Tx FIFO number
                TXFNUM: u4,
                ///  Clear NAK
                CNAK: u1,
                ///  Set NAK
                SNAK: u1,
                ///  SD0PID/SEVNFRM
                SD0PID_SEVENFRM: u1,
                ///  Set DATA1 PID/Set odd frame
                SD1PID_SODDFRM: u1,
                ///  Endpoint disable
                EPD: u1,
                ///  Endpoint enable
                EPEN: u1,
            }),
            reserved360: [4]u8,
            ///  device endpoint-3 interrupt register
            DIEP3INTF: mmio.Mmio(packed struct(u32) {
                ///  Transfer finished
                TF: u1,
                ///  Endpoint finished
                EPDIS: u1,
                reserved3: u1,
                ///  Control in timeout interrupt
                CITO: u1,
                ///  Endpoint Tx FIFO underrun
                EPTXFUD: u1,
                reserved6: u1,
                ///  IN endpoint NAK effective
                IEPNE: u1,
                ///  Transmit FIFO empty
                TXFE: u1,
                padding: u24,
            }),
            reserved368: [4]u8,
            ///  device IN endpoint-3 transfer length register
            DIEP3LEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer length
                TLEN: u19,
                ///  Packet count
                PCNT: u10,
                ///  Multi packet count per frame
                MCPF: u2,
                padding: u1,
            }),
            reserved376: [4]u8,
            ///  device IN endpoint 3 transmit FIFO status register
            DIEP3TFSTAT: mmio.Mmio(packed struct(u32) {
                ///  IN endpoint TxFIFO space remaining
                IEPTFS: u16,
                padding: u16,
            }),
            reserved768: [388]u8,
            ///  device endpoint-0 control register
            DOEP0CTL: mmio.Mmio(packed struct(u32) {
                ///  Maximum packet length
                MPL: u2,
                reserved15: u13,
                ///  Endpoint active
                EPACT: u1,
                reserved17: u1,
                ///  NAK status
                NAKS: u1,
                ///  Endpoint type
                EPTYPE: u2,
                ///  Snoop mode
                SNOOP: u1,
                ///  STALL handshake
                STALL: u1,
                reserved26: u4,
                ///  Clear NAK
                CNAK: u1,
                ///  Set NAK
                SNAK: u1,
                reserved30: u2,
                ///  Endpoint disable
                EPD: u1,
                ///  Endpoint enable
                EPEN: u1,
            }),
            reserved776: [4]u8,
            ///  device out endpoint-0 interrupt flag register
            DOEP0INTF: mmio.Mmio(packed struct(u32) {
                ///  Transfer finished
                TF: u1,
                ///  Endpoint disabled
                EPDIS: u1,
                reserved3: u1,
                ///  Setup phase finished
                STPF: u1,
                ///  Endpoint Rx FIFO overrun
                EPRXFOVR: u1,
                reserved6: u1,
                ///  Back-to-back SETUP packets
                BTBSTP: u1,
                padding: u25,
            }),
            reserved784: [4]u8,
            ///  device OUT endpoint-0 transfer length register
            DOEP0LEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer length
                TLEN: u7,
                reserved19: u12,
                ///  Packet count
                PCNT: u1,
                reserved29: u9,
                ///  SETUP packet count
                STPCNT: u2,
                padding: u1,
            }),
            reserved800: [12]u8,
            ///  device endpoint-1 control register
            DOEP1CTL: mmio.Mmio(packed struct(u32) {
                ///  maximum packet length
                MPL: u11,
                reserved15: u4,
                ///  Endpoint active
                EPACT: u1,
                ///  EOFRM/DPID
                EOFRM_DPID: u1,
                ///  NAK status
                NAKS: u1,
                ///  Endpoint type
                EPTYPE: u2,
                ///  Snoop mode
                SNOOP: u1,
                ///  STALL handshake
                STALL: u1,
                reserved26: u4,
                ///  Clear NAK
                CNAK: u1,
                ///  Set NAK
                SNAK: u1,
                ///  SD0PID/SEVENFRM
                SD0PID_SEVENFRM: u1,
                ///  SD1PID/SODDFRM
                SD1PID_SODDFRM: u1,
                ///  Endpoint disable
                EPD: u1,
                ///  Endpoint enable
                EPEN: u1,
            }),
            reserved808: [4]u8,
            ///  device out endpoint-1 interrupt flag register
            DOEP1INTF: mmio.Mmio(packed struct(u32) {
                ///  Transfer finished
                TF: u1,
                ///  Endpoint disabled
                EPDIS: u1,
                reserved3: u1,
                ///  Setup phase finished
                STPF: u1,
                ///  Endpoint Rx FIFO overrun
                EPRXFOVR: u1,
                reserved6: u1,
                ///  Back-to-back SETUP packets
                BTBSTP: u1,
                padding: u25,
            }),
            reserved816: [4]u8,
            ///  device OUT endpoint-1 transfer length register
            DOEP1LEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer length
                TLEN: u19,
                ///  Packet count
                PCNT: u10,
                ///  SETUP packet count/Received data PID
                STPCNT_RXDPID: u2,
                padding: u1,
            }),
            reserved832: [12]u8,
            ///  device endpoint-2 control register
            DOEP2CTL: mmio.Mmio(packed struct(u32) {
                ///  maximum packet length
                MPL: u11,
                reserved15: u4,
                ///  Endpoint active
                EPACT: u1,
                ///  EOFRM/DPID
                EOFRM_DPID: u1,
                ///  NAK status
                NAKS: u1,
                ///  Endpoint type
                EPTYPE: u2,
                ///  Snoop mode
                SNOOP: u1,
                ///  STALL handshake
                STALL: u1,
                reserved26: u4,
                ///  Clear NAK
                CNAK: u1,
                ///  Set NAK
                SNAK: u1,
                ///  SD0PID/SEVENFRM
                SD0PID_SEVENFRM: u1,
                ///  SD1PID/SODDFRM
                SD1PID_SODDFRM: u1,
                ///  Endpoint disable
                EPD: u1,
                ///  Endpoint enable
                EPEN: u1,
            }),
            reserved840: [4]u8,
            ///  device out endpoint-2 interrupt flag register
            DOEP2INTF: mmio.Mmio(packed struct(u32) {
                ///  Transfer finished
                TF: u1,
                ///  Endpoint disabled
                EPDIS: u1,
                reserved3: u1,
                ///  Setup phase finished
                STPF: u1,
                ///  Endpoint Rx FIFO overrun
                EPRXFOVR: u1,
                reserved6: u1,
                ///  Back-to-back SETUP packets
                BTBSTP: u1,
                padding: u25,
            }),
            reserved848: [4]u8,
            ///  device OUT endpoint-2 transfer length register
            DOEP2LEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer length
                TLEN: u19,
                ///  Packet count
                PCNT: u10,
                ///  SETUP packet count/Received data PID
                STPCNT_RXDPID: u2,
                padding: u1,
            }),
            reserved864: [12]u8,
            ///  device endpoint-3 control register
            DOEP3CTL: mmio.Mmio(packed struct(u32) {
                ///  maximum packet length
                MPL: u11,
                reserved15: u4,
                ///  Endpoint active
                EPACT: u1,
                ///  EOFRM/DPID
                EOFRM_DPID: u1,
                ///  NAK status
                NAKS: u1,
                ///  Endpoint type
                EPTYPE: u2,
                ///  Snoop mode
                SNOOP: u1,
                ///  STALL handshake
                STALL: u1,
                reserved26: u4,
                ///  Clear NAK
                CNAK: u1,
                ///  Set NAK
                SNAK: u1,
                ///  SD0PID/SEVENFRM
                SD0PID_SEVENFRM: u1,
                ///  SD1PID/SODDFRM
                SD1PID_SODDFRM: u1,
                ///  Endpoint disable
                EPD: u1,
                ///  Endpoint enable
                EPEN: u1,
            }),
            reserved872: [4]u8,
            ///  device out endpoint-3 interrupt flag register
            DOEP3INTF: mmio.Mmio(packed struct(u32) {
                ///  Transfer finished
                TF: u1,
                ///  Endpoint disabled
                EPDIS: u1,
                reserved3: u1,
                ///  Setup phase finished
                STPF: u1,
                ///  Endpoint Rx FIFO overrun
                EPRXFOVR: u1,
                reserved6: u1,
                ///  Back-to-back SETUP packets
                BTBSTP: u1,
                padding: u25,
            }),
            reserved880: [4]u8,
            ///  device OUT endpoint-3 transfer length register
            DOEP3LEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer length
                TLEN: u19,
                ///  Packet count
                PCNT: u10,
                ///  SETUP packet count/Received data PID
                STPCNT_RXDPID: u2,
                padding: u1,
            }),
        };

        ///  USB on the go full speed host
        pub const USBFS_HOST = extern struct {
            ///  host configuration register (HCTL)
            HCTL: mmio.Mmio(packed struct(u32) {
                ///  clock select for USB clock
                CLKSEL: u2,
                padding: u30,
            }),
            ///  Host frame interval register
            HFT: mmio.Mmio(packed struct(u32) {
                ///  Frame interval
                FRI: u16,
                padding: u16,
            }),
            ///  FS host frame number/frame time remaining register (HFINFR)
            HFINFR: mmio.Mmio(packed struct(u32) {
                ///  Frame number
                FRNUM: u16,
                ///  Frame remaining time
                FRT: u16,
            }),
            reserved16: [4]u8,
            ///  Host periodic transmit FIFO/queue status register (HPTFQSTAT)
            HPTFQSTAT: mmio.Mmio(packed struct(u32) {
                ///  Periodic transmit data FIFO space available
                PTXFS: u16,
                ///  Periodic transmit request queue space available
                PTXREQS: u8,
                ///  Top of the periodic transmit request queue
                PTXREQT: u8,
            }),
            ///  Host all channels interrupt register
            HACHINT: mmio.Mmio(packed struct(u32) {
                ///  Host all channel interrupts
                HACHINT: u8,
                padding: u24,
            }),
            ///  host all channels interrupt mask register
            HACHINTEN: mmio.Mmio(packed struct(u32) {
                ///  Channel interrupt enable
                CINTEN: u8,
                padding: u24,
            }),
            reserved64: [36]u8,
            ///  Host port control and status register (USBFS_HPCS)
            HPCS: mmio.Mmio(packed struct(u32) {
                ///  Port connect status
                PCST: u1,
                ///  Port connect detected
                PCD: u1,
                ///  Port enable
                PE: u1,
                ///  Port enable/disable change
                PEDC: u1,
                reserved6: u2,
                ///  Port resume
                PREM: u1,
                ///  Port suspend
                PSP: u1,
                ///  Port reset
                PRST: u1,
                reserved10: u1,
                ///  Port line status
                PLST: u2,
                ///  Port power
                PP: u1,
                reserved17: u4,
                ///  Port speed
                PS: u2,
                padding: u13,
            }),
            reserved256: [188]u8,
            ///  host channel-0 characteristics register (HCH0CTL)
            HCH0CTL: mmio.Mmio(packed struct(u32) {
                ///  Maximum packet size
                MPL: u11,
                ///  Endpoint number
                EPNUM: u4,
                ///  Endpoint direction
                EPDIR: u1,
                reserved17: u1,
                ///  Low-speed device
                LSD: u1,
                ///  Endpoint type
                EPTYPE: u2,
                reserved22: u2,
                ///  Device address
                DAR: u7,
                ///  Odd frame
                ODDFRM: u1,
                ///  Channel disable
                CDIS: u1,
                ///  Channel enable
                CEN: u1,
            }),
            reserved264: [4]u8,
            ///  host channel-0 interrupt register (USBFS_HCHxINTF)
            HCH0INTF: mmio.Mmio(packed struct(u32) {
                ///  Transfer finished
                TF: u1,
                ///  Channel halted
                CH: u1,
                reserved3: u1,
                ///  STALL response received interrupt
                STALL: u1,
                ///  NAK response received interrupt
                NAK: u1,
                ///  ACK response received/transmitted interrupt
                ACK: u1,
                reserved7: u1,
                ///  USB bus error
                USBER: u1,
                ///  Babble error
                BBER: u1,
                ///  Request queue overrun
                REQOVR: u1,
                ///  Data toggle error
                DTER: u1,
                padding: u21,
            }),
            ///  host channel-0 interrupt enable register (HCH0INTEN)
            HCH0INTEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer completed interrupt enable
                TFIE: u1,
                ///  Channel halted interrupt enable
                CHIE: u1,
                reserved3: u1,
                ///  STALL interrupt enable
                STALLIE: u1,
                ///  NAK interrupt enable
                NAKIE: u1,
                ///  ACK interrupt enable
                ACKIE: u1,
                reserved7: u1,
                ///  USB bus error interrupt enable
                USBERIE: u1,
                ///  Babble error interrupt enable
                BBERIE: u1,
                ///  request queue overrun interrupt enable
                REQOVRIE: u1,
                ///  Data toggle error interrupt enable
                DTERIE: u1,
                padding: u21,
            }),
            ///  host channel-0 transfer length register
            HCH0LEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer length
                TLEN: u19,
                ///  Packet count
                PCNT: u10,
                ///  Data PID
                DPID: u2,
                padding: u1,
            }),
            reserved288: [12]u8,
            ///  host channel-1 characteristics register (HCH1CTL)
            HCH1CTL: mmio.Mmio(packed struct(u32) {
                ///  Maximum packet size
                MPL: u11,
                ///  Endpoint number
                EPNUM: u4,
                ///  Endpoint direction
                EPDIR: u1,
                reserved17: u1,
                ///  Low-speed device
                LSD: u1,
                ///  Endpoint type
                EPTYPE: u2,
                reserved22: u2,
                ///  Device address
                DAR: u7,
                ///  Odd frame
                ODDFRM: u1,
                ///  Channel disable
                CDIS: u1,
                ///  Channel enable
                CEN: u1,
            }),
            reserved296: [4]u8,
            ///  host channel-1 interrupt register (HCH1INTF)
            HCH1INTF: mmio.Mmio(packed struct(u32) {
                ///  Transfer finished
                TF: u1,
                ///  Channel halted
                CH: u1,
                reserved3: u1,
                ///  STALL response received interrupt
                STALL: u1,
                ///  NAK response received interrupt
                NAK: u1,
                ///  ACK response received/transmitted interrupt
                ACK: u1,
                reserved7: u1,
                ///  USB bus error
                USBER: u1,
                ///  Babble error
                BBER: u1,
                ///  Request queue overrun
                REQOVR: u1,
                ///  Data toggle error
                DTER: u1,
                padding: u21,
            }),
            ///  host channel-1 interrupt enable register (HCH1INTEN)
            HCH1INTEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer completed interrupt enable
                TFIE: u1,
                ///  Channel halted interrupt enable
                CHIE: u1,
                reserved3: u1,
                ///  STALL interrupt enable
                STALLIE: u1,
                ///  NAK interrupt enable
                NAKIE: u1,
                ///  ACK interrupt enable
                ACKIE: u1,
                reserved7: u1,
                ///  USB bus error interrupt enable
                USBERIE: u1,
                ///  Babble error interrupt enable
                BBERIE: u1,
                ///  request queue overrun interrupt enable
                REQOVRIE: u1,
                ///  Data toggle error interrupt enable
                DTERIE: u1,
                padding: u21,
            }),
            ///  host channel-1 transfer length register
            HCH1LEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer length
                TLEN: u19,
                ///  Packet count
                PCNT: u10,
                ///  Data PID
                DPID: u2,
                padding: u1,
            }),
            reserved320: [12]u8,
            ///  host channel-2 characteristics register (HCH2CTL)
            HCH2CTL: mmio.Mmio(packed struct(u32) {
                ///  Maximum packet size
                MPL: u11,
                ///  Endpoint number
                EPNUM: u4,
                ///  Endpoint direction
                EPDIR: u1,
                reserved17: u1,
                ///  Low-speed device
                LSD: u1,
                ///  Endpoint type
                EPTYPE: u2,
                reserved22: u2,
                ///  Device address
                DAR: u7,
                ///  Odd frame
                ODDFRM: u1,
                ///  Channel disable
                CDIS: u1,
                ///  Channel enable
                CEN: u1,
            }),
            reserved328: [4]u8,
            ///  host channel-2 interrupt register (HCH2INTF)
            HCH2INTF: mmio.Mmio(packed struct(u32) {
                ///  Transfer finished
                TF: u1,
                ///  Channel halted
                CH: u1,
                reserved3: u1,
                ///  STALL response received interrupt
                STALL: u1,
                ///  NAK response received interrupt
                NAK: u1,
                ///  ACK response received/transmitted interrupt
                ACK: u1,
                reserved7: u1,
                ///  USB bus error
                USBER: u1,
                ///  Babble error
                BBER: u1,
                ///  Request queue overrun
                REQOVR: u1,
                ///  Data toggle error
                DTER: u1,
                padding: u21,
            }),
            ///  host channel-2 interrupt enable register (HCH2INTEN)
            HCH2INTEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer completed interrupt enable
                TFIE: u1,
                ///  Channel halted interrupt enable
                CHIE: u1,
                reserved3: u1,
                ///  STALL interrupt enable
                STALLIE: u1,
                ///  NAK interrupt enable
                NAKIE: u1,
                ///  ACK interrupt enable
                ACKIE: u1,
                reserved7: u1,
                ///  USB bus error interrupt enable
                USBERIE: u1,
                ///  Babble error interrupt enable
                BBERIE: u1,
                ///  request queue overrun interrupt enable
                REQOVRIE: u1,
                ///  Data toggle error interrupt enable
                DTERIE: u1,
                padding: u21,
            }),
            ///  host channel-2 transfer length register
            HCH2LEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer length
                TLEN: u19,
                ///  Packet count
                PCNT: u10,
                ///  Data PID
                DPID: u2,
                padding: u1,
            }),
            reserved352: [12]u8,
            ///  host channel-3 characteristics register (HCH3CTL)
            HCH3CTL: mmio.Mmio(packed struct(u32) {
                ///  Maximum packet size
                MPL: u11,
                ///  Endpoint number
                EPNUM: u4,
                ///  Endpoint direction
                EPDIR: u1,
                reserved17: u1,
                ///  Low-speed device
                LSD: u1,
                ///  Endpoint type
                EPTYPE: u2,
                reserved22: u2,
                ///  Device address
                DAR: u7,
                ///  Odd frame
                ODDFRM: u1,
                ///  Channel disable
                CDIS: u1,
                ///  Channel enable
                CEN: u1,
            }),
            reserved360: [4]u8,
            ///  host channel-3 interrupt register (HCH3INTF)
            HCH3INTF: mmio.Mmio(packed struct(u32) {
                ///  Transfer finished
                TF: u1,
                ///  Channel halted
                CH: u1,
                reserved3: u1,
                ///  STALL response received interrupt
                STALL: u1,
                ///  NAK response received interrupt
                NAK: u1,
                ///  ACK response received/transmitted interrupt
                ACK: u1,
                reserved7: u1,
                ///  USB bus error
                USBER: u1,
                ///  Babble error
                BBER: u1,
                ///  Request queue overrun
                REQOVR: u1,
                ///  Data toggle error
                DTER: u1,
                padding: u21,
            }),
            ///  host channel-3 interrupt enable register (HCH3INTEN)
            HCH3INTEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer completed interrupt enable
                TFIE: u1,
                ///  Channel halted interrupt enable
                CHIE: u1,
                reserved3: u1,
                ///  STALL interrupt enable
                STALLIE: u1,
                ///  NAK interrupt enable
                NAKIE: u1,
                ///  ACK interrupt enable
                ACKIE: u1,
                reserved7: u1,
                ///  USB bus error interrupt enable
                USBERIE: u1,
                ///  Babble error interrupt enable
                BBERIE: u1,
                ///  request queue overrun interrupt enable
                REQOVRIE: u1,
                ///  Data toggle error interrupt enable
                DTERIE: u1,
                padding: u21,
            }),
            ///  host channel-3 transfer length register
            HCH3LEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer length
                TLEN: u19,
                ///  Packet count
                PCNT: u10,
                ///  Data PID
                DPID: u2,
                padding: u1,
            }),
            reserved384: [12]u8,
            ///  host channel-4 characteristics register (HCH4CTL)
            HCH4CTL: mmio.Mmio(packed struct(u32) {
                ///  Maximum packet size
                MPL: u11,
                ///  Endpoint number
                EPNUM: u4,
                ///  Endpoint direction
                EPDIR: u1,
                reserved17: u1,
                ///  Low-speed device
                LSD: u1,
                ///  Endpoint type
                EPTYPE: u2,
                reserved22: u2,
                ///  Device address
                DAR: u7,
                ///  Odd frame
                ODDFRM: u1,
                ///  Channel disable
                CDIS: u1,
                ///  Channel enable
                CEN: u1,
            }),
            reserved392: [4]u8,
            ///  host channel-4 interrupt register (HCH4INTF)
            HCH4INTF: mmio.Mmio(packed struct(u32) {
                ///  Transfer finished
                TF: u1,
                ///  Channel halted
                CH: u1,
                reserved3: u1,
                ///  STALL response received interrupt
                STALL: u1,
                ///  NAK response received interrupt
                NAK: u1,
                ///  ACK response received/transmitted interrupt
                ACK: u1,
                reserved7: u1,
                ///  USB bus error
                USBER: u1,
                ///  Babble error
                BBER: u1,
                ///  Request queue overrun
                REQOVR: u1,
                ///  Data toggle error
                DTER: u1,
                padding: u21,
            }),
            ///  host channel-4 interrupt enable register (HCH4INTEN)
            HCH4INTEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer completed interrupt enable
                TFIE: u1,
                ///  Channel halted interrupt enable
                CHIE: u1,
                reserved3: u1,
                ///  STALL interrupt enable
                STALLIE: u1,
                ///  NAK interrupt enable
                NAKIE: u1,
                ///  ACK interrupt enable
                ACKIE: u1,
                reserved7: u1,
                ///  USB bus error interrupt enable
                USBERIE: u1,
                ///  Babble error interrupt enable
                BBERIE: u1,
                ///  request queue overrun interrupt enable
                REQOVRIE: u1,
                ///  Data toggle error interrupt enable
                DTERIE: u1,
                padding: u21,
            }),
            ///  host channel-4 transfer length register
            HCH4LEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer length
                TLEN: u19,
                ///  Packet count
                PCNT: u10,
                ///  Data PID
                DPID: u2,
                padding: u1,
            }),
            reserved416: [12]u8,
            ///  host channel-5 characteristics register (HCH5CTL)
            HCH5CTL: mmio.Mmio(packed struct(u32) {
                ///  Maximum packet size
                MPL: u11,
                ///  Endpoint number
                EPNUM: u4,
                ///  Endpoint direction
                EPDIR: u1,
                reserved17: u1,
                ///  Low-speed device
                LSD: u1,
                ///  Endpoint type
                EPTYPE: u2,
                reserved22: u2,
                ///  Device address
                DAR: u7,
                ///  Odd frame
                ODDFRM: u1,
                ///  Channel disable
                CDIS: u1,
                ///  Channel enable
                CEN: u1,
            }),
            reserved424: [4]u8,
            ///  host channel-5 interrupt register (HCH5INTF)
            HCH5INTF: mmio.Mmio(packed struct(u32) {
                ///  Transfer finished
                TF: u1,
                ///  Channel halted
                CH: u1,
                reserved3: u1,
                ///  STALL response received interrupt
                STALL: u1,
                ///  NAK response received interrupt
                NAK: u1,
                ///  ACK response received/transmitted interrupt
                ACK: u1,
                reserved7: u1,
                ///  USB bus error
                USBER: u1,
                ///  Babble error
                BBER: u1,
                ///  Request queue overrun
                REQOVR: u1,
                ///  Data toggle error
                DTER: u1,
                padding: u21,
            }),
            ///  host channel-5 interrupt enable register (HCH5INTEN)
            HCH5INTEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer completed interrupt enable
                TFIE: u1,
                ///  Channel halted interrupt enable
                CHIE: u1,
                reserved3: u1,
                ///  STALL interrupt enable
                STALLIE: u1,
                ///  NAK interrupt enable
                NAKIE: u1,
                ///  ACK interrupt enable
                ACKIE: u1,
                reserved7: u1,
                ///  USB bus error interrupt enable
                USBERIE: u1,
                ///  Babble error interrupt enable
                BBERIE: u1,
                ///  request queue overrun interrupt enable
                REQOVRIE: u1,
                ///  Data toggle error interrupt enable
                DTERIE: u1,
                padding: u21,
            }),
            ///  host channel-5 transfer length register
            HCH5LEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer length
                TLEN: u19,
                ///  Packet count
                PCNT: u10,
                ///  Data PID
                DPID: u2,
                padding: u1,
            }),
            reserved448: [12]u8,
            ///  host channel-6 characteristics register (HCH6CTL)
            HCH6CTL: mmio.Mmio(packed struct(u32) {
                ///  Maximum packet size
                MPL: u11,
                ///  Endpoint number
                EPNUM: u4,
                ///  Endpoint direction
                EPDIR: u1,
                reserved17: u1,
                ///  Low-speed device
                LSD: u1,
                ///  Endpoint type
                EPTYPE: u2,
                reserved22: u2,
                ///  Device address
                DAR: u7,
                ///  Odd frame
                ODDFRM: u1,
                ///  Channel disable
                CDIS: u1,
                ///  Channel enable
                CEN: u1,
            }),
            reserved456: [4]u8,
            ///  host channel-6 interrupt register (HCH6INTF)
            HCH6INTF: mmio.Mmio(packed struct(u32) {
                ///  Transfer finished
                TF: u1,
                ///  Channel halted
                CH: u1,
                reserved3: u1,
                ///  STALL response received interrupt
                STALL: u1,
                ///  NAK response received interrupt
                NAK: u1,
                ///  ACK response received/transmitted interrupt
                ACK: u1,
                reserved7: u1,
                ///  USB bus error
                USBER: u1,
                ///  Babble error
                BBER: u1,
                ///  Request queue overrun
                REQOVR: u1,
                ///  Data toggle error
                DTER: u1,
                padding: u21,
            }),
            ///  host channel-6 interrupt enable register (HCH6INTEN)
            HCH6INTEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer completed interrupt enable
                TFIE: u1,
                ///  Channel halted interrupt enable
                CHIE: u1,
                reserved3: u1,
                ///  STALL interrupt enable
                STALLIE: u1,
                ///  NAK interrupt enable
                NAKIE: u1,
                ///  ACK interrupt enable
                ACKIE: u1,
                reserved7: u1,
                ///  USB bus error interrupt enable
                USBERIE: u1,
                ///  Babble error interrupt enable
                BBERIE: u1,
                ///  request queue overrun interrupt enable
                REQOVRIE: u1,
                ///  Data toggle error interrupt enable
                DTERIE: u1,
                padding: u21,
            }),
            ///  host channel-6 transfer length register
            HCH6LEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer length
                TLEN: u19,
                ///  Packet count
                PCNT: u10,
                ///  Data PID
                DPID: u2,
                padding: u1,
            }),
            reserved480: [12]u8,
            ///  host channel-7 characteristics register (HCH7CTL)
            HCH7CTL: mmio.Mmio(packed struct(u32) {
                ///  Maximum packet size
                MPL: u11,
                ///  Endpoint number
                EPNUM: u4,
                ///  Endpoint direction
                EPDIR: u1,
                reserved17: u1,
                ///  Low-speed device
                LSD: u1,
                ///  Endpoint type
                EPTYPE: u2,
                reserved22: u2,
                ///  Device address
                DAR: u7,
                ///  Odd frame
                ODDFRM: u1,
                ///  Channel disable
                CDIS: u1,
                ///  Channel enable
                CEN: u1,
            }),
            reserved488: [4]u8,
            ///  host channel-7 interrupt register (HCH7INTF)
            HCH7INTF: mmio.Mmio(packed struct(u32) {
                ///  Transfer finished
                TF: u1,
                ///  Channel halted
                CH: u1,
                reserved3: u1,
                ///  STALL response received interrupt
                STALL: u1,
                ///  NAK response received interrupt
                NAK: u1,
                ///  ACK response received/transmitted interrupt
                ACK: u1,
                reserved7: u1,
                ///  USB bus error
                USBER: u1,
                ///  Babble error
                BBER: u1,
                ///  Request queue overrun
                REQOVR: u1,
                ///  Data toggle error
                DTER: u1,
                padding: u21,
            }),
            ///  host channel-7 interrupt enable register (HCH7INTEN)
            HCH7INTEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer completed interrupt enable
                TFIE: u1,
                ///  Channel halted interrupt enable
                CHIE: u1,
                reserved3: u1,
                ///  STALL interrupt enable
                STALLIE: u1,
                ///  NAK interrupt enable
                NAKIE: u1,
                ///  ACK interrupt enable
                ACKIE: u1,
                reserved7: u1,
                ///  USB bus error interrupt enable
                USBERIE: u1,
                ///  Babble error interrupt enable
                BBERIE: u1,
                ///  request queue overrun interrupt enable
                REQOVRIE: u1,
                ///  Data toggle error interrupt enable
                DTERIE: u1,
                padding: u21,
            }),
            ///  host channel-7 transfer length register
            HCH7LEN: mmio.Mmio(packed struct(u32) {
                ///  Transfer length
                TLEN: u19,
                ///  Packet count
                PCNT: u10,
                ///  Data PID
                DPID: u2,
                padding: u1,
            }),
        };

        ///  USB full speed global registers
        pub const USBFS_GLOBAL = extern struct {
            ///  Global OTG control and status register (USBFS_GOTGCS)
            GOTGCS: mmio.Mmio(packed struct(u32) {
                ///  SRP success
                SRPS: u1,
                ///  SRP request
                SRPREQ: u1,
                reserved8: u6,
                ///  Host success
                HNPS: u1,
                ///  HNP request
                HNPREQ: u1,
                ///  Host HNP enable
                HHNPEN: u1,
                ///  Device HNP enabled
                DHNPEN: u1,
                reserved16: u4,
                ///  ID pin status
                IDPS: u1,
                ///  Debounce interval
                DI: u1,
                ///  A-session valid
                ASV: u1,
                ///  B-session valid
                BSV: u1,
                padding: u12,
            }),
            ///  Global OTG interrupt flag register (USBFS_GOTGINTF)
            GOTGINTF: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  Session end
                SESEND: u1,
                reserved8: u5,
                ///  Session request success status change
                SRPEND: u1,
                ///  HNP end
                HNPEND: u1,
                reserved17: u7,
                ///  Host negotiation request detected
                HNPDET: u1,
                ///  A-device timeout
                ADTO: u1,
                ///  Debounce finish
                DF: u1,
                padding: u12,
            }),
            ///  Global AHB control and status register (USBFS_GAHBCS)
            GAHBCS: mmio.Mmio(packed struct(u32) {
                ///  Global interrupt enable
                GINTEN: u1,
                reserved7: u6,
                ///  Tx FIFO threshold
                TXFTH: u1,
                ///  Periodic Tx FIFO threshold
                PTXFTH: u1,
                padding: u23,
            }),
            ///  Global USB control and status register (USBFS_GUSBCSR)
            GUSBCS: mmio.Mmio(packed struct(u32) {
                ///  Timeout calibration
                TOC: u3,
                reserved8: u5,
                ///  SRP capability enable
                SRPCEN: u1,
                ///  HNP capability enable
                HNPCEN: u1,
                ///  USB turnaround time
                UTT: u4,
                reserved29: u15,
                ///  Force host mode
                FHM: u1,
                ///  Force device mode
                FDM: u1,
                padding: u1,
            }),
            ///  Global reset control register (USBFS_GRSTCTL)
            GRSTCTL: mmio.Mmio(packed struct(u32) {
                ///  Core soft reset
                CSRST: u1,
                ///  HCLK soft reset
                HCSRST: u1,
                ///  Host frame counter reset
                HFCRST: u1,
                reserved4: u1,
                ///  RxFIFO flush
                RXFF: u1,
                ///  TxFIFO flush
                TXFF: u1,
                ///  TxFIFO number
                TXFNUM: u5,
                padding: u21,
            }),
            ///  Global interrupt flag register (USBFS_GINTF)
            GINTF: mmio.Mmio(packed struct(u32) {
                ///  Current operation mode
                COPM: u1,
                ///  Mode fault interrupt flag
                MFIF: u1,
                ///  OTG interrupt flag
                OTGIF: u1,
                ///  Start of frame
                SOF: u1,
                ///  RxFIFO non-empty interrupt flag
                RXFNEIF: u1,
                ///  Non-periodic TxFIFO empty interrupt flag
                NPTXFEIF: u1,
                ///  Global Non-Periodic IN NAK effective
                GNPINAK: u1,
                ///  Global OUT NAK effective
                GONAK: u1,
                reserved10: u2,
                ///  Early suspend
                ESP: u1,
                ///  USB suspend
                SP: u1,
                ///  USB reset
                RST: u1,
                ///  Enumeration finished
                ENUMF: u1,
                ///  Isochronous OUT packet dropped interrupt
                ISOOPDIF: u1,
                ///  End of periodic frame interrupt flag
                EOPFIF: u1,
                reserved18: u2,
                ///  IN endpoint interrupt flag
                IEPIF: u1,
                ///  OUT endpoint interrupt flag
                OEPIF: u1,
                ///  Isochronous IN transfer Not Complete Interrupt Flag
                ISOINCIF: u1,
                ///  periodic transfer not complete interrupt flag(Host mode)/isochronous OUT transfer not complete interrupt flag(Device mode)
                PXNCIF_ISOONCIF: u1,
                reserved24: u2,
                ///  Host port interrupt flag
                HPIF: u1,
                ///  Host channels interrupt flag
                HCIF: u1,
                ///  Periodic TxFIFO empty interrupt flag
                PTXFEIF: u1,
                reserved28: u1,
                ///  ID pin status change
                IDPSC: u1,
                ///  Disconnect interrupt flag
                DISCIF: u1,
                ///  Session interrupt flag
                SESIF: u1,
                ///  Wakeup interrupt flag
                WKUPIF: u1,
            }),
            ///  Global interrupt enable register (USBFS_GINTEN)
            GINTEN: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Mode fault interrupt enable
                MFIE: u1,
                ///  OTG interrupt enable
                OTGIE: u1,
                ///  Start of frame interrupt enable
                SOFIE: u1,
                ///  Receive FIFO non-empty interrupt enable
                RXFNEIE: u1,
                ///  Non-periodic TxFIFO empty interrupt enable
                NPTXFEIE: u1,
                ///  Global non-periodic IN NAK effective interrupt enable
                GNPINAKIE: u1,
                ///  Global OUT NAK effective interrupt enable
                GONAKIE: u1,
                reserved10: u2,
                ///  Early suspend interrupt enable
                ESPIE: u1,
                ///  USB suspend interrupt enable
                SPIE: u1,
                ///  USB reset interrupt enable
                RSTIE: u1,
                ///  Enumeration finish interrupt enable
                ENUMFIE: u1,
                ///  Isochronous OUT packet dropped interrupt enable
                ISOOPDIE: u1,
                ///  End of periodic frame interrupt enable
                EOPFIE: u1,
                reserved18: u2,
                ///  IN endpoints interrupt enable
                IEPIE: u1,
                ///  OUT endpoints interrupt enable
                OEPIE: u1,
                ///  isochronous IN transfer not complete interrupt enable
                ISOINCIE: u1,
                ///  periodic transfer not compelete Interrupt enable(Host mode)/isochronous OUT transfer not complete interrupt enable(Device mode)
                PXNCIE_ISOONCIE: u1,
                reserved24: u2,
                ///  Host port interrupt enable
                HPIE: u1,
                ///  Host channels interrupt enable
                HCIE: u1,
                ///  Periodic TxFIFO empty interrupt enable
                PTXFEIE: u1,
                reserved28: u1,
                ///  ID pin status change interrupt enable
                IDPSCIE: u1,
                ///  Disconnect interrupt enable
                DISCIE: u1,
                ///  Session interrupt enable
                SESIE: u1,
                ///  Wakeup interrupt enable
                WKUPIE: u1,
            }),
            ///  Global Receive status read(Device mode)
            GRSTATR_Device: mmio.Mmio(packed struct(u32) {
                ///  Endpoint number
                EPNUM: u4,
                ///  Byte count
                BCOUNT: u11,
                ///  Data PID
                DPID: u2,
                ///  Recieve packet status
                RPCKST: u4,
                padding: u11,
            }),
            ///  Global Receive status pop(Device mode)
            GRSTATP_Device: mmio.Mmio(packed struct(u32) {
                ///  Endpoint number
                EPNUM: u4,
                ///  Byte count
                BCOUNT: u11,
                ///  Data PID
                DPID: u2,
                ///  Recieve packet status
                RPCKST: u4,
                padding: u11,
            }),
            ///  Global Receive FIFO size register (USBFS_GRFLEN)
            GRFLEN: mmio.Mmio(packed struct(u32) {
                ///  Rx FIFO depth
                RXFD: u16,
                padding: u16,
            }),
            ///  Host non-periodic transmit FIFO length register (Host mode)
            HNPTFLEN: mmio.Mmio(packed struct(u32) {
                ///  host non-periodic transmit Tx RAM start address
                HNPTXRSAR: u16,
                ///  host non-periodic TxFIFO depth
                HNPTXFD: u16,
            }),
            ///  Host non-periodic transmit FIFO/queue status register (HNPTFQSTAT)
            HNPTFQSTAT: mmio.Mmio(packed struct(u32) {
                ///  Non-periodic TxFIFO space
                NPTXFS: u16,
                ///  Non-periodic transmit request queue space
                NPTXRQS: u8,
                ///  Top of the non-periodic transmit request queue
                NPTXRQTOP: u7,
                padding: u1,
            }),
            reserved56: [8]u8,
            ///  Global core configuration register (USBFS_GCCFG)
            GCCFG: mmio.Mmio(packed struct(u32) {
                reserved16: u16,
                ///  Power on
                PWRON: u1,
                reserved18: u1,
                ///  The VBUS A-device Comparer enable
                VBUSACEN: u1,
                ///  The VBUS B-device Comparer enable
                VBUSBCEN: u1,
                ///  SOF output enable
                SOFOEN: u1,
                ///  VBUS ignored
                VBUSIG: u1,
                padding: u10,
            }),
            ///  core ID register
            CID: mmio.Mmio(packed struct(u32) {
                ///  Core ID
                CID: u32,
            }),
            reserved256: [192]u8,
            ///  Host periodic transmit FIFO length register (HPTFLEN)
            HPTFLEN: mmio.Mmio(packed struct(u32) {
                ///  Host periodic TxFIFO start address
                HPTXFSAR: u16,
                ///  Host periodic TxFIFO depth
                HPTXFD: u16,
            }),
            ///  device IN endpoint transmit FIFO size register (DIEP1TFLEN)
            DIEP1TFLEN: mmio.Mmio(packed struct(u32) {
                ///  IN endpoint FIFO transmit RAM start address
                IEPTXRSAR: u16,
                ///  IN endpoint TxFIFO depth
                IEPTXFD: u16,
            }),
            ///  device IN endpoint transmit FIFO size register (DIEP2TFLEN)
            DIEP2TFLEN: mmio.Mmio(packed struct(u32) {
                ///  IN endpoint FIFO transmit RAM start address
                IEPTXRSAR: u16,
                ///  IN endpoint TxFIFO depth
                IEPTXFD: u16,
            }),
            ///  device IN endpoint transmit FIFO size register (FS_DIEP3TXFLEN)
            DIEP3TFLEN: mmio.Mmio(packed struct(u32) {
                ///  IN endpoint FIFO4 transmit RAM start address
                IEPTXRSAR: u16,
                ///  IN endpoint TxFIFO depth
                IEPTXFD: u16,
            }),
        };

        ///  Inter integrated circuit
        pub const I2C0 = extern struct {
            ///  Control register 0
            CTL0: mmio.Mmio(packed struct(u16) {
                ///  I2C peripheral enable
                I2CEN: u1,
                ///  SMBus/I2C mode switch
                SMBEN: u1,
                reserved3: u1,
                ///  SMBusType Selection
                SMBSEL: u1,
                ///  ARP protocol in SMBus switch
                ARPEN: u1,
                ///  PEC Calculation Switch
                PECEN: u1,
                ///  Whether or not to response to a General Call (0x00)
                GCEN: u1,
                ///  Whether to stretch SCL low when data is not ready in slave mode
                SS: u1,
                ///  Generate a START condition on I2C bus
                START: u1,
                ///  Generate a STOP condition on I2C bus
                STOP: u1,
                ///  Whether or not to send an ACK
                ACKEN: u1,
                ///  Position of ACK and PEC when receiving
                POAP: u1,
                ///  PEC Transfer
                PECTRANS: u1,
                ///  SMBus alert
                SALT: u1,
                reserved15: u1,
                ///  Software reset
                SRESET: u1,
            }),
            reserved4: [2]u8,
            ///  Control register 1
            CTL1: mmio.Mmio(packed struct(u16) {
                ///  I2C Peripheral clock frequency
                I2CCLK: u6,
                reserved8: u2,
                ///  Error interrupt enable
                ERRIE: u1,
                ///  Event interrupt enable
                EVIE: u1,
                ///  Buffer interrupt enable
                BUFIE: u1,
                ///  DMA mode switch
                DMAON: u1,
                ///  Flag indicating DMA last transfer
                DMALST: u1,
                padding: u3,
            }),
            reserved8: [2]u8,
            ///  Slave address register 0
            SADDR0: mmio.Mmio(packed struct(u16) {
                ///  Bit 0 of a 10-bit address
                ADDRESS0: u1,
                ///  7-bit address or bits 7:1 of a 10-bit address
                ADDRESS7_1: u7,
                ///  Highest two bits of a 10-bit address
                ADDRESS9_8: u2,
                reserved15: u5,
                ///  Address mode for the I2C slave
                ADDFORMAT: u1,
            }),
            reserved12: [2]u8,
            ///  Slave address register 1
            SADDR1: mmio.Mmio(packed struct(u16) {
                ///  Dual-Address mode switch
                DUADEN: u1,
                ///  Second I2C address for the slave in Dual-Address mode
                ADDRESS2: u7,
                padding: u8,
            }),
            reserved16: [2]u8,
            ///  Transfer buffer register
            DATA: mmio.Mmio(packed struct(u16) {
                ///  Transmission or reception data buffer register
                TRB: u8,
                padding: u8,
            }),
            reserved20: [2]u8,
            ///  Transfer status register 0
            STAT0: mmio.Mmio(packed struct(u16) {
                ///  START condition sent out in master mode
                SBSEND: u1,
                ///  Address is sent in master mode or received and matches in slave mode
                ADDSEND: u1,
                ///  Byte transmission completed
                BTC: u1,
                ///  Header of 10-bit address is sent in master mode
                ADD10SEND: u1,
                ///  STOP condition detected in slave mode
                STPDET: u1,
                reserved6: u1,
                ///  I2C_DATA is not Empty during receiving
                RBNE: u1,
                ///  I2C_DATA is Empty during transmitting
                TBE: u1,
                ///  A bus error occurs indication a unexpected START or STOP condition on I2C bus
                BERR: u1,
                ///  Arbitration Lost in master mode
                LOSTARB: u1,
                ///  Acknowledge error
                AERR: u1,
                ///  Over-run or under-run situation occurs in slave mode
                OUERR: u1,
                ///  PEC error when receiving data
                PECERR: u1,
                reserved14: u1,
                ///  Timeout signal in SMBus mode
                SMBTO: u1,
                ///  SMBus Alert status
                SMBALT: u1,
            }),
            reserved24: [2]u8,
            ///  Transfer status register 1
            STAT1: mmio.Mmio(packed struct(u16) {
                ///  A flag indicating whether I2C block is in master or slave mode
                MASTER: u1,
                ///  Busy flag
                I2CBSY: u1,
                ///  Whether the I2C is a transmitter or a receiver
                TR: u1,
                reserved4: u1,
                ///  General call address (00h) received
                RXGC: u1,
                ///  Default address of SMBusDevice
                DEFSMB: u1,
                ///  SMBus Host Header detected in slave mode
                HSTSMB: u1,
                ///  Dual Flag in slave mode
                DUMODF: u1,
                ///  Packet Error Checking Value that calculated by hardware when PEC is enabled
                PECV: u8,
            }),
            reserved28: [2]u8,
            ///  Clock configure register
            CKCFG: mmio.Mmio(packed struct(u16) {
                ///  I2C Clock control in master mode
                CLKC: u12,
                reserved14: u2,
                ///  Duty cycle in fast mode
                DTCY: u1,
                ///  I2C speed selection in master mode
                FAST: u1,
            }),
            reserved32: [2]u8,
            ///  Rise time register
            RT: mmio.Mmio(packed struct(u16) {
                ///  Maximum rise time in master mode
                RISETIME: u6,
                padding: u10,
            }),
        };

        ///  Basic-timers
        pub const TIMER5 = extern struct {
            ///  control register 0
            CTL0: mmio.Mmio(packed struct(u16) {
                ///  Counter enable
                CEN: u1,
                ///  Update disable
                UPDIS: u1,
                ///  Update source
                UPS: u1,
                ///  Single pulse mode
                SPM: u1,
                reserved7: u3,
                ///  Auto-reload shadow enable
                ARSE: u1,
                padding: u8,
            }),
            reserved4: [2]u8,
            ///  control register 1
            CTL1: mmio.Mmio(packed struct(u16) {
                reserved4: u4,
                ///  Master mode control
                MMC: u3,
                padding: u9,
            }),
            reserved12: [6]u8,
            ///  DMA/Interrupt enable register
            DMAINTEN: mmio.Mmio(packed struct(u16) {
                ///  Update interrupt enable
                UPIE: u1,
                reserved8: u7,
                ///  Update DMA request enable
                UPDEN: u1,
                padding: u7,
            }),
            reserved16: [2]u8,
            ///  Interrupt flag register
            INTF: mmio.Mmio(packed struct(u16) {
                ///  Update interrupt flag
                UPIF: u1,
                padding: u15,
            }),
            reserved20: [2]u8,
            ///  event generation register
            SWEVG: mmio.Mmio(packed struct(u16) {
                ///  Update generation
                UPG: u1,
                padding: u15,
            }),
            reserved36: [14]u8,
            ///  Counter register
            CNT: mmio.Mmio(packed struct(u16) {
                ///  Low counter value
                CNT: u16,
            }),
            reserved40: [2]u8,
            ///  Prescaler register
            PSC: mmio.Mmio(packed struct(u16) {
                ///  Prescaler value of the counter clock
                PSC: u16,
            }),
            reserved44: [2]u8,
            ///  Counter auto reload register
            CAR: mmio.Mmio(packed struct(u16) {
                ///  Counter auto reload value
                CARL: u16,
            }),
        };

        ///  Enhanced Core Local Interrupt Controller
        pub const ECLIC = extern struct {
            ///  cliccfg Register
            CLICCFG: mmio.Mmio(packed struct(u8) {
                reserved1: u1,
                ///  NLBITS
                NLBITS: u4,
                padding: u3,
            }),
            reserved4: [3]u8,
            ///  clicinfo Register
            CLICINFO: mmio.Mmio(packed struct(u32) {
                ///  NUM_INTERRUPT
                NUM_INTERRUPT: u13,
                ///  VERSION
                VERSION: u8,
                ///  CLICINTCTLBITS
                CLICINTCTLBITS: u4,
                padding: u7,
            }),
            reserved11: [3]u8,
            ///  MTH Register
            MTH: mmio.Mmio(packed struct(u8) {
                ///  MTH
                MTH: u8,
            }),
            reserved4096: [4084]u8,
            ///  clicintip Register
            CLICINTIP_0: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_0: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_0: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_0: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_1: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_1: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_1: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_1: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_2: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_2: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_2: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_2: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_3: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_3: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_3: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_3: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_4: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_4: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_4: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_4: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_5: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_5: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_5: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_5: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_6: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_6: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_6: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_6: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_7: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_7: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_7: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_7: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_8: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_8: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_8: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_8: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_9: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_9: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_9: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_9: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_10: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_10: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_10: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_10: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_11: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_11: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_11: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_11: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_12: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_12: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_12: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_12: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_13: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_13: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_13: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_13: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_14: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_14: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_14: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_14: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_15: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_15: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_15: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_15: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_16: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_16: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_16: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_16: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_17: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_17: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_17: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_17: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_18: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_18: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_18: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_18: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_19: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_19: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_19: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_19: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_20: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_20: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_20: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_20: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_21: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_21: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_21: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_21: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_22: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_22: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_22: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_22: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_23: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_23: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_23: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_23: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_24: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_24: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_24: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_24: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_25: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_25: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_25: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_25: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_26: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_26: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_26: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_26: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_27: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_27: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_27: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_27: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_28: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_28: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_28: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_28: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_29: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_29: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_29: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_29: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_30: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_30: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_30: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_30: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_31: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_31: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_31: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_31: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_32: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_32: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_32: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_32: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_33: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_33: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_33: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_33: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_34: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_34: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_34: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_34: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_35: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_35: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_35: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_35: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_36: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_36: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_36: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_36: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_37: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_37: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_37: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_37: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_38: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_38: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_38: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_38: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_39: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_39: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_39: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_39: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_40: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_40: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_40: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_40: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_41: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_41: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_41: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_41: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_42: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_42: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_42: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_42: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_43: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_43: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_43: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_43: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_44: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_44: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_44: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_44: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_45: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_45: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_45: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_45: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_46: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_46: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_46: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_46: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_47: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_47: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_47: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_47: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_48: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_48: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_48: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_48: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_49: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_49: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_49: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_49: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_50: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_50: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_50: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_50: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_51: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_51: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_51: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_51: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_52: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_52: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_52: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_52: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_53: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_53: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_53: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_53: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_54: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_54: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_54: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_54: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_55: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_55: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_55: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_55: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_56: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_56: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_56: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_56: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_57: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_57: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_57: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_57: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_58: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_58: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_58: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_58: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_59: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_59: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_59: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_59: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_60: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_60: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_60: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_60: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_61: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_61: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_61: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_61: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_62: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_62: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_62: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_62: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_63: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_63: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_63: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_63: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_64: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_64: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_64: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_64: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_65: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_65: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_65: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_65: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_66: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_66: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_66: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_66: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_67: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_67: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_67: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_67: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_68: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_68: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_68: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_68: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_69: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_69: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_69: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_69: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_70: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_70: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_70: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_70: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_71: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_71: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_71: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_71: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_72: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_72: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_72: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_72: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_73: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_73: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_73: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_73: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_74: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_74: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_74: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_74: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_75: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_75: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_75: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_75: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_76: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_76: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_76: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_76: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_77: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_77: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_77: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_77: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_78: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_78: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_78: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_78: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_79: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_79: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_79: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_79: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_80: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_80: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_80: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_80: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_81: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_81: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_81: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_81: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_82: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_82: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_82: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_82: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_83: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_83: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_83: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_83: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_84: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_84: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_84: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_84: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            reserved4437: [1]u8,
            ///  clicintie Register
            CLICINTIE_85: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_85: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_85: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_85: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
            ///  clicintie Register
            CLICINTIE_86: mmio.Mmio(packed struct(u8) {
                ///  IE
                IE: u1,
                padding: u7,
            }),
            ///  clicintattr Register
            CLICINTATTR_86: mmio.Mmio(packed struct(u8) {
                ///  SHV
                SHV: u1,
                ///  TRIG
                TRIG: u2,
                padding: u5,
            }),
            ///  clicintctl Register
            CLICINTCTL_86: mmio.Mmio(packed struct(u8) {
                ///  LEVEL_PRIORITY
                LEVEL_PRIORITY: u8,
            }),
            ///  clicintip Register
            CLICINTIP_86: mmio.Mmio(packed struct(u8) {
                ///  IP
                IP: u1,
                padding: u7,
            }),
        };

        ///  Power management unit
        pub const PMU = extern struct {
            ///  power control register
            CTL: mmio.Mmio(packed struct(u32) {
                ///  LDO Low Power Mode
                LDOLP: u1,
                ///  Standby Mode
                STBMOD: u1,
                ///  Wakeup Flag Reset
                WURST: u1,
                ///  Standby Flag Reset
                STBRST: u1,
                ///  Low Voltage Detector Enable
                LVDEN: u1,
                ///  Low Voltage Detector Threshold
                LVDT: u3,
                ///  Backup Domain Write Enable
                BKPWEN: u1,
                padding: u23,
            }),
            ///  power control/status register
            CS: mmio.Mmio(packed struct(u32) {
                ///  Wakeup flag
                WUF: u1,
                ///  Standby flag
                STBF: u1,
                ///  Low Voltage Detector Status Flag
                LVDF: u1,
                reserved8: u5,
                ///  Enable WKUP pin
                WUPEN: u1,
                padding: u23,
            }),
        };

        ///  Reset and clock unit
        pub const RCU = extern struct {
            ///  Control register
            CTL: mmio.Mmio(packed struct(u32) {
                ///  Internal 8MHz RC oscillator Enable
                IRC8MEN: u1,
                ///  IRC8M Internal 8MHz RC Oscillator stabilization Flag
                IRC8MSTB: u1,
                reserved3: u1,
                ///  Internal 8MHz RC Oscillator clock trim adjust value
                IRC8MADJ: u5,
                ///  Internal 8MHz RC Oscillator calibration value register
                IRC8MCALIB: u8,
                ///  External High Speed oscillator Enable
                HXTALEN: u1,
                ///  External crystal oscillator (HXTAL) clock stabilization flag
                HXTALSTB: u1,
                ///  External crystal oscillator (HXTAL) clock bypass mode enable
                HXTALBPS: u1,
                ///  HXTAL Clock Monitor Enable
                CKMEN: u1,
                reserved24: u4,
                ///  PLL enable
                PLLEN: u1,
                ///  PLL Clock Stabilization Flag
                PLLSTB: u1,
                ///  PLL1 enable
                PLL1EN: u1,
                ///  PLL1 Clock Stabilization Flag
                PLL1STB: u1,
                ///  PLL2 enable
                PLL2EN: u1,
                ///  PLL2 Clock Stabilization Flag
                PLL2STB: u1,
                padding: u2,
            }),
            ///  Clock configuration register 0 (RCU_CFG0)
            CFG0: mmio.Mmio(packed struct(u32) {
                ///  System clock switch
                SCS: u2,
                ///  System clock switch status
                SCSS: u2,
                ///  AHB prescaler selection
                AHBPSC: u4,
                ///  APB1 prescaler selection
                APB1PSC: u3,
                ///  APB2 prescaler selection
                APB2PSC: u3,
                ///  ADC clock prescaler selection
                ADCPSC_1_0: u2,
                ///  PLL Clock Source Selection
                PLLSEL: u1,
                ///  The LSB of PREDV0 division factor
                PREDV0_LSB: u1,
                ///  The PLL clock multiplication factor
                PLLMF_3_0: u4,
                ///  USBFS clock prescaler selection
                USBFSPSC: u2,
                ///  CKOUT0 Clock Source Selection
                CKOUT0SEL: u4,
                ///  Bit 2 of ADCPSC
                ADCPSC_2: u1,
                ///  Bit 4 of PLLMF
                PLLMF_4: u1,
                padding: u2,
            }),
            ///  Clock interrupt register (RCU_INT)
            INT: mmio.Mmio(packed struct(u32) {
                ///  IRC40K stabilization interrupt flag
                IRC40KSTBIF: u1,
                ///  LXTAL stabilization interrupt flag
                LXTALSTBIF: u1,
                ///  IRC8M stabilization interrupt flag
                IRC8MSTBIF: u1,
                ///  HXTAL stabilization interrupt flag
                HXTALSTBIF: u1,
                ///  PLL stabilization interrupt flag
                PLLSTBIF: u1,
                ///  PLL1 stabilization interrupt flag
                PLL1STBIF: u1,
                ///  PLL2 stabilization interrupt flag
                PLL2STBIF: u1,
                ///  HXTAL Clock Stuck Interrupt Flag
                CKMIF: u1,
                ///  IRC40K Stabilization interrupt enable
                IRC40KSTBIE: u1,
                ///  LXTAL Stabilization Interrupt Enable
                LXTALSTBIE: u1,
                ///  IRC8M Stabilization Interrupt Enable
                IRC8MSTBIE: u1,
                ///  HXTAL Stabilization Interrupt Enable
                HXTALSTBIE: u1,
                ///  PLL Stabilization Interrupt Enable
                PLLSTBIE: u1,
                ///  PLL1 Stabilization Interrupt Enable
                PLL1STBIE: u1,
                ///  PLL2 Stabilization Interrupt Enable
                PLL2STBIE: u1,
                reserved16: u1,
                ///  IRC40K Stabilization Interrupt Clear
                IRC40KSTBIC: u1,
                ///  LXTAL Stabilization Interrupt Clear
                LXTALSTBIC: u1,
                ///  IRC8M Stabilization Interrupt Clear
                IRC8MSTBIC: u1,
                ///  HXTAL Stabilization Interrupt Clear
                HXTALSTBIC: u1,
                ///  PLL stabilization Interrupt Clear
                PLLSTBIC: u1,
                ///  PLL1 stabilization Interrupt Clear
                PLL1STBIC: u1,
                ///  PLL2 stabilization Interrupt Clear
                PLL2STBIC: u1,
                ///  HXTAL Clock Stuck Interrupt Clear
                CKMIC: u1,
                padding: u8,
            }),
            ///  APB2 reset register (RCU_APB2RST)
            APB2RST: mmio.Mmio(packed struct(u32) {
                ///  Alternate function I/O reset
                AFRST: u1,
                reserved2: u1,
                ///  GPIO port A reset
                PARST: u1,
                ///  GPIO port B reset
                PBRST: u1,
                ///  GPIO port C reset
                PCRST: u1,
                ///  GPIO port D reset
                PDRST: u1,
                ///  GPIO port E reset
                PERST: u1,
                reserved9: u2,
                ///  ADC0 reset
                ADC0RST: u1,
                ///  ADC1 reset
                ADC1RST: u1,
                ///  Timer 0 reset
                TIMER0RST: u1,
                ///  SPI0 reset
                SPI0RST: u1,
                reserved14: u1,
                ///  USART0 Reset
                USART0RST: u1,
                padding: u17,
            }),
            ///  APB1 reset register (RCU_APB1RST)
            APB1RST: mmio.Mmio(packed struct(u32) {
                ///  TIMER1 timer reset
                TIMER1RST: u1,
                ///  TIMER2 timer reset
                TIMER2RST: u1,
                ///  TIMER3 timer reset
                TIMER3RST: u1,
                ///  TIMER4 timer reset
                TIMER4RST: u1,
                ///  TIMER5 timer reset
                TIMER5RST: u1,
                ///  TIMER6 timer reset
                TIMER6RST: u1,
                reserved11: u5,
                ///  Window watchdog timer reset
                WWDGTRST: u1,
                reserved14: u2,
                ///  SPI1 reset
                SPI1RST: u1,
                ///  SPI2 reset
                SPI2RST: u1,
                reserved17: u1,
                ///  USART1 reset
                USART1RST: u1,
                ///  USART2 reset
                USART2RST: u1,
                ///  UART3 reset
                UART3RST: u1,
                ///  UART4 reset
                UART4RST: u1,
                ///  I2C0 reset
                I2C0RST: u1,
                ///  I2C1 reset
                I2C1RST: u1,
                reserved25: u2,
                ///  CAN0 reset
                CAN0RST: u1,
                ///  CAN1 reset
                CAN1RST: u1,
                ///  Backup interface reset
                BKPIRST: u1,
                ///  Power control reset
                PMURST: u1,
                ///  DAC reset
                DACRST: u1,
                padding: u2,
            }),
            ///  AHB enable register
            AHBEN: mmio.Mmio(packed struct(u32) {
                ///  DMA0 clock enable
                DMA0EN: u1,
                ///  DMA1 clock enable
                DMA1EN: u1,
                ///  SRAM interface clock enable when sleep mode
                SRAMSPEN: u1,
                reserved4: u1,
                ///  FMC clock enable when sleep mode
                FMCSPEN: u1,
                reserved6: u1,
                ///  CRC clock enable
                CRCEN: u1,
                reserved8: u1,
                ///  EXMC clock enable
                EXMCEN: u1,
                reserved12: u3,
                ///  USBFS clock enable
                USBFSEN: u1,
                padding: u19,
            }),
            ///  APB2 clock enable register (RCU_APB2EN)
            APB2EN: mmio.Mmio(packed struct(u32) {
                ///  Alternate function IO clock enable
                AFEN: u1,
                reserved2: u1,
                ///  GPIO port A clock enable
                PAEN: u1,
                ///  GPIO port B clock enable
                PBEN: u1,
                ///  GPIO port C clock enable
                PCEN: u1,
                ///  GPIO port D clock enable
                PDEN: u1,
                ///  GPIO port E clock enable
                PEEN: u1,
                reserved9: u2,
                ///  ADC0 clock enable
                ADC0EN: u1,
                ///  ADC1 clock enable
                ADC1EN: u1,
                ///  TIMER0 clock enable
                TIMER0EN: u1,
                ///  SPI0 clock enable
                SPI0EN: u1,
                reserved14: u1,
                ///  USART0 clock enable
                USART0EN: u1,
                padding: u17,
            }),
            ///  APB1 clock enable register (RCU_APB1EN)
            APB1EN: mmio.Mmio(packed struct(u32) {
                ///  TIMER1 timer clock enable
                TIMER1EN: u1,
                ///  TIMER2 timer clock enable
                TIMER2EN: u1,
                ///  TIMER3 timer clock enable
                TIMER3EN: u1,
                ///  TIMER4 timer clock enable
                TIMER4EN: u1,
                ///  TIMER5 timer clock enable
                TIMER5EN: u1,
                ///  TIMER6 timer clock enable
                TIMER6EN: u1,
                reserved11: u5,
                ///  Window watchdog timer clock enable
                WWDGTEN: u1,
                reserved14: u2,
                ///  SPI1 clock enable
                SPI1EN: u1,
                ///  SPI2 clock enable
                SPI2EN: u1,
                reserved17: u1,
                ///  USART1 clock enable
                USART1EN: u1,
                ///  USART2 clock enable
                USART2EN: u1,
                ///  UART3 clock enable
                UART3EN: u1,
                ///  UART4 clock enable
                UART4EN: u1,
                ///  I2C0 clock enable
                I2C0EN: u1,
                ///  I2C1 clock enable
                I2C1EN: u1,
                reserved25: u2,
                ///  CAN0 clock enable
                CAN0EN: u1,
                ///  CAN1 clock enable
                CAN1EN: u1,
                ///  Backup interface clock enable
                BKPIEN: u1,
                ///  Power control clock enable
                PMUEN: u1,
                ///  DAC clock enable
                DACEN: u1,
                padding: u2,
            }),
            ///  Backup domain control register (RCU_BDCTL)
            BDCTL: mmio.Mmio(packed struct(u32) {
                ///  LXTAL enable
                LXTALEN: u1,
                ///  External low-speed oscillator stabilization
                LXTALSTB: u1,
                ///  LXTAL bypass mode enable
                LXTALBPS: u1,
                reserved8: u5,
                ///  RTC clock entry selection
                RTCSRC: u2,
                reserved15: u5,
                ///  RTC clock enable
                RTCEN: u1,
                ///  Backup domain reset
                BKPRST: u1,
                padding: u15,
            }),
            ///  Reset source /clock register (RCU_RSTSCK)
            RSTSCK: mmio.Mmio(packed struct(u32) {
                ///  IRC40K enable
                IRC40KEN: u1,
                ///  IRC40K stabilization
                IRC40KSTB: u1,
                reserved24: u22,
                ///  Reset flag clear
                RSTFC: u1,
                reserved26: u1,
                ///  External PIN reset flag
                EPRSTF: u1,
                ///  Power reset flag
                PORRSTF: u1,
                ///  Software reset flag
                SWRSTF: u1,
                ///  Free Watchdog timer reset flag
                FWDGTRSTF: u1,
                ///  Window watchdog timer reset flag
                WWDGTRSTF: u1,
                ///  Low-power reset flag
                LPRSTF: u1,
            }),
            ///  AHB reset register
            AHBRST: mmio.Mmio(packed struct(u32) {
                reserved12: u12,
                ///  USBFS reset
                USBFSRST: u1,
                padding: u19,
            }),
            ///  Clock Configuration register 1
            CFG1: mmio.Mmio(packed struct(u32) {
                ///  PREDV0 division factor
                PREDV0: u4,
                ///  PREDV1 division factor
                PREDV1: u4,
                ///  The PLL1 clock multiplication factor
                PLL1MF: u4,
                ///  The PLL2 clock multiplication factor
                PLL2MF: u4,
                ///  PREDV0 input Clock Source Selection
                PREDV0SEL: u1,
                ///  I2S1 Clock Source Selection
                I2S1SEL: u1,
                ///  I2S2 Clock Source Selection
                I2S2SEL: u1,
                padding: u13,
            }),
            reserved52: [4]u8,
            ///  Deep sleep mode Voltage register
            DSV: mmio.Mmio(packed struct(u32) {
                ///  Deep-sleep mode voltage select
                DSLPVS: u2,
                padding: u30,
            }),
        };

        ///  Real-time clock
        pub const RTC = extern struct {
            ///  RTC interrupt enable register
            INTEN: mmio.Mmio(packed struct(u32) {
                ///  Second interrupt
                SCIE: u1,
                ///  Alarm interrupt enable
                ALRMIE: u1,
                ///  Overflow interrupt enable
                OVIE: u1,
                padding: u29,
            }),
            ///  control register
            CTL: mmio.Mmio(packed struct(u32) {
                ///  Sencond interrupt flag
                SCIF: u1,
                ///  Alarm interrupt flag
                ALRMIF: u1,
                ///  Overflow interrupt flag
                OVIF: u1,
                ///  Registers synchronized flag
                RSYNF: u1,
                ///  Configuration mode flag
                CMF: u1,
                ///  Last write operation finished flag
                LWOFF: u1,
                padding: u26,
            }),
            ///  RTC prescaler high register
            PSCH: mmio.Mmio(packed struct(u32) {
                padding: u32,
            }),
            ///  RTC prescaler low register
            PSCL: mmio.Mmio(packed struct(u32) {
                padding: u32,
            }),
            ///  RTC divider high register
            DIVH: mmio.Mmio(packed struct(u32) {
                ///  RTC divider value high
                DIV: u4,
                padding: u28,
            }),
            ///  RTC divider low register
            DIVL: mmio.Mmio(packed struct(u32) {
                ///  RTC divider value low
                DIV: u16,
                padding: u16,
            }),
            ///  RTC counter high register
            CNTH: mmio.Mmio(packed struct(u32) {
                ///  RTC counter value high
                CNT: u16,
                padding: u16,
            }),
            ///  RTC counter low register
            CNTL: mmio.Mmio(packed struct(u32) {
                ///  RTC counter value low
                CNT: u16,
                padding: u16,
            }),
        };

        ///  Serial peripheral interface
        pub const SPI0 = extern struct {
            ///  control register 0
            CTL0: mmio.Mmio(packed struct(u16) {
                ///  Clock Phase Selection
                CKPH: u1,
                ///  Clock polarity Selection
                CKPL: u1,
                ///  Master Mode Enable
                MSTMOD: u1,
                ///  Master Clock Prescaler Selection
                PSC: u3,
                ///  SPI enable
                SPIEN: u1,
                ///  LSB First Mode
                LF: u1,
                ///  NSS Pin Selection In NSS Software Mode
                SWNSS: u1,
                ///  NSS Software Mode Selection
                SWNSSEN: u1,
                ///  Receive only
                RO: u1,
                ///  Data frame format
                FF16: u1,
                ///  CRC Next Transfer
                CRCNT: u1,
                ///  CRC Calculation Enable
                CRCEN: u1,
                ///  Bidirectional Transmit output enable
                BDOEN: u1,
                ///  Bidirectional enable
                BDEN: u1,
            }),
            reserved4: [2]u8,
            ///  control register 1
            CTL1: mmio.Mmio(packed struct(u16) {
                ///  Rx buffer DMA enable
                DMAREN: u1,
                ///  Transmit Buffer DMA Enable
                DMATEN: u1,
                ///  Drive NSS Output
                NSSDRV: u1,
                ///  SPI NSS pulse mode enable
                NSSP: u1,
                ///  SPI TI mode enable
                TMOD: u1,
                ///  Error interrupt enable
                ERRIE: u1,
                ///  RX buffer not empty interrupt enable
                RBNEIE: u1,
                ///  Tx buffer empty interrupt enable
                TBEIE: u1,
                padding: u8,
            }),
            reserved8: [2]u8,
            ///  status register
            STAT: mmio.Mmio(packed struct(u16) {
                ///  Receive Buffer Not Empty
                RBNE: u1,
                ///  Transmit Buffer Empty
                TBE: u1,
                ///  I2S channel side
                I2SCH: u1,
                ///  Transmission underrun error bit
                TXURERR: u1,
                ///  SPI CRC Error Bit
                CRCERR: u1,
                ///  SPI Configuration error
                CONFERR: u1,
                ///  Reception Overrun Error Bit
                RXORERR: u1,
                ///  Transmitting On-going Bit
                TRANS: u1,
                ///  Format error
                FERR: u1,
                padding: u7,
            }),
            reserved12: [2]u8,
            ///  data register
            DATA: mmio.Mmio(packed struct(u16) {
                ///  Data transfer register
                SPI_DATA: u16,
            }),
            reserved16: [2]u8,
            ///  CRC polynomial register
            CRCPOLY: mmio.Mmio(packed struct(u16) {
                ///  CRC polynomial value
                CRCPOLY: u16,
            }),
            reserved20: [2]u8,
            ///  RX CRC register
            RCRC: mmio.Mmio(packed struct(u16) {
                ///  RX CRC value
                RCRC: u16,
            }),
            reserved24: [2]u8,
            ///  TX CRC register
            TCRC: mmio.Mmio(packed struct(u16) {
                ///  Tx CRC value
                TCRC: u16,
            }),
            reserved28: [2]u8,
            ///  I2S control register
            I2SCTL: mmio.Mmio(packed struct(u16) {
                ///  Channel length (number of bits per audio channel)
                CHLEN: u1,
                ///  Data length
                DTLEN: u2,
                ///  Idle state clock polarity
                CKPL: u1,
                ///  I2S standard selection
                I2SSTD: u2,
                reserved7: u1,
                ///  PCM frame synchronization mode
                PCMSMOD: u1,
                ///  I2S operation mode
                I2SOPMOD: u2,
                ///  I2S Enable
                I2SEN: u1,
                ///  I2S mode selection
                I2SSEL: u1,
                padding: u4,
            }),
            reserved32: [2]u8,
            ///  I2S prescaler register
            I2SPSC: mmio.Mmio(packed struct(u16) {
                ///  Dividing factor for the prescaler
                DIV: u8,
                ///  Odd factor for the prescaler
                OF: u1,
                ///  I2S_MCK output enable
                MCKOEN: u1,
                padding: u6,
            }),
        };

        ///  Universal asynchronous receiver transmitter
        pub const UART3 = extern struct {
            ///  Status register
            STAT: mmio.Mmio(packed struct(u32) {
                ///  Parity error flag
                PERR: u1,
                ///  Frame error flag
                FERR: u1,
                ///  Noise error flag
                NERR: u1,
                ///  Overrun error
                ORERR: u1,
                ///  IDLE frame detected flag
                IDLEF: u1,
                ///  Read data buffer not empty
                RBNE: u1,
                ///  Transmission complete
                TC: u1,
                ///  Transmit data buffer empty
                TBE: u1,
                ///  LIN break detection flag
                LBDF: u1,
                padding: u23,
            }),
            ///  Data register
            DATA: mmio.Mmio(packed struct(u32) {
                ///  Transmit or read data value
                DATA: u9,
                padding: u23,
            }),
            ///  Baud rate register
            BAUD: mmio.Mmio(packed struct(u32) {
                ///  Fraction part of baud-rate divider
                FRADIV: u4,
                ///  Integer part of baud-rate divider
                INTDIV: u12,
                padding: u16,
            }),
            ///  Control register 0
            CTL0: mmio.Mmio(packed struct(u32) {
                ///  Send break command
                SBKCMD: u1,
                ///  Receiver wakeup from mute mode
                RWU: u1,
                ///  Receiver enable
                REN: u1,
                ///  Transmitter enable
                TEN: u1,
                ///  IDLE line detected interrupt enable
                IDLEIE: u1,
                ///  Read data buffer not empty interrupt and overrun error interrupt enable
                RBNEIE: u1,
                ///  Transmission complete interrupt enable
                TCIE: u1,
                ///  Transmitter buffer empty interrupt enable
                TBEIE: u1,
                ///  Parity error interrupt enable
                PERRIE: u1,
                ///  Parity mode
                PM: u1,
                ///  Parity check function enable
                PCEN: u1,
                ///  Wakeup method in mute mode
                WM: u1,
                ///  Word length
                WL: u1,
                ///  USART enable
                UEN: u1,
                padding: u18,
            }),
            ///  Control register 1
            CTL1: mmio.Mmio(packed struct(u32) {
                ///  Address of the USART
                ADDR: u4,
                reserved5: u1,
                ///  LIN break frame length
                LBLEN: u1,
                ///  LIN break detection interrupt enable
                LBDIE: u1,
                reserved12: u5,
                ///  STOP bits length
                STB: u2,
                ///  LIN mode enable
                LMEN: u1,
                padding: u17,
            }),
            ///  Control register 2
            CTL2: mmio.Mmio(packed struct(u32) {
                ///  Error interrupt enable
                ERRIE: u1,
                ///  IrDA mode enable
                IREN: u1,
                ///  IrDA low-power
                IRLP: u1,
                ///  Half-duplex selection
                HDEN: u1,
                reserved6: u2,
                ///  DMA request enable for reception
                DENR: u1,
                ///  DMA request enable for transmission
                DENT: u1,
                padding: u24,
            }),
            ///  Guard time and prescaler register
            GP: mmio.Mmio(packed struct(u32) {
                ///  Prescaler value
                PSC: u8,
                padding: u24,
            }),
        };

        ///  Universal synchronous asynchronous receiver transmitter
        pub const USART0 = extern struct {
            ///  Status register
            STAT: mmio.Mmio(packed struct(u32) {
                ///  Parity error flag
                PERR: u1,
                ///  Frame error flag
                FERR: u1,
                ///  Noise error flag
                NERR: u1,
                ///  Overrun error
                ORERR: u1,
                ///  IDLE frame detected flag
                IDLEF: u1,
                ///  Read data buffer not empty
                RBNE: u1,
                ///  Transmission complete
                TC: u1,
                ///  Transmit data buffer empty
                TBE: u1,
                ///  LIN break detection flag
                LBDF: u1,
                ///  CTS change flag
                CTSF: u1,
                padding: u22,
            }),
            ///  Data register
            DATA: mmio.Mmio(packed struct(u32) {
                ///  Transmit or read data value
                DATA: u9,
                padding: u23,
            }),
            ///  Baud rate register
            BAUD: mmio.Mmio(packed struct(u32) {
                ///  Fraction part of baud-rate divider
                FRADIV: u4,
                ///  Integer part of baud-rate divider
                INTDIV: u12,
                padding: u16,
            }),
            ///  Control register 0
            CTL0: mmio.Mmio(packed struct(u32) {
                ///  Send break command
                SBKCMD: u1,
                ///  Receiver wakeup from mute mode
                RWU: u1,
                ///  Receiver enable
                REN: u1,
                ///  Transmitter enable
                TEN: u1,
                ///  IDLE line detected interrupt enable
                IDLEIE: u1,
                ///  Read data buffer not empty interrupt and overrun error interrupt enable
                RBNEIE: u1,
                ///  Transmission complete interrupt enable
                TCIE: u1,
                ///  Transmitter buffer empty interrupt enable
                TBEIE: u1,
                ///  Parity error interrupt enable
                PERRIE: u1,
                ///  Parity mode
                PM: u1,
                ///  Parity check function enable
                PCEN: u1,
                ///  Wakeup method in mute mode
                WM: u1,
                ///  Word length
                WL: u1,
                ///  USART enable
                UEN: u1,
                padding: u18,
            }),
            ///  Control register 1
            CTL1: mmio.Mmio(packed struct(u32) {
                ///  Address of the USART
                ADDR: u4,
                reserved5: u1,
                ///  LIN break frame length
                LBLEN: u1,
                ///  LIN break detection interrupt enable
                LBDIE: u1,
                reserved8: u1,
                ///  CK Length
                CLEN: u1,
                ///  Clock phase
                CPH: u1,
                ///  Clock polarity
                CPL: u1,
                ///  CK pin enable
                CKEN: u1,
                ///  STOP bits length
                STB: u2,
                ///  LIN mode enable
                LMEN: u1,
                padding: u17,
            }),
            ///  Control register 2
            CTL2: mmio.Mmio(packed struct(u32) {
                ///  Error interrupt enable
                ERRIE: u1,
                ///  IrDA mode enable
                IREN: u1,
                ///  IrDA low-power
                IRLP: u1,
                ///  Half-duplex selection
                HDEN: u1,
                ///  Smartcard NACK enable
                NKEN: u1,
                ///  Smartcard mode enable
                SCEN: u1,
                ///  DMA request enable for reception
                DENR: u1,
                ///  DMA request enable for transmission
                DENT: u1,
                ///  RTS enable
                RTSEN: u1,
                ///  CTS enable
                CTSEN: u1,
                ///  CTS interrupt enable
                CTSIE: u1,
                padding: u21,
            }),
            ///  Guard time and prescaler register
            GP: mmio.Mmio(packed struct(u32) {
                ///  Prescaler value
                PSC: u8,
                ///  Guard time value in Smartcard mode
                GUAT: u8,
                padding: u16,
            }),
        };

        ///  Advanced-timers
        pub const TIMER0 = extern struct {
            ///  control register 0
            CTL0: mmio.Mmio(packed struct(u16) {
                ///  Counter enable
                CEN: u1,
                ///  Update disable
                UPDIS: u1,
                ///  Update source
                UPS: u1,
                ///  Single pulse mode
                SPM: u1,
                ///  Direction
                DIR: u1,
                ///  Counter aligns mode selection
                CAM: u2,
                ///  Auto-reload shadow enable
                ARSE: u1,
                ///  Clock division
                CKDIV: u2,
                padding: u6,
            }),
            reserved4: [2]u8,
            ///  control register 1
            CTL1: mmio.Mmio(packed struct(u16) {
                ///  Commutation control shadow enable
                CCSE: u1,
                reserved2: u1,
                ///  Commutation control shadow register update control
                CCUC: u1,
                ///  DMA request source selection
                DMAS: u1,
                ///  Master mode control
                MMC: u3,
                ///  Channel 0 trigger input selection
                TI0S: u1,
                ///  Idle state of channel 0 output
                ISO0: u1,
                ///  Idle state of channel 0 complementary output
                ISO0N: u1,
                ///  Idle state of channel 1 output
                ISO1: u1,
                ///  Idle state of channel 1 complementary output
                ISO1N: u1,
                ///  Idle state of channel 2 output
                ISO2: u1,
                ///  Idle state of channel 2 complementary output
                ISO2N: u1,
                ///  Idle state of channel 3 output
                ISO3: u1,
                padding: u1,
            }),
            reserved8: [2]u8,
            ///  slave mode configuration register
            SMCFG: mmio.Mmio(packed struct(u16) {
                ///  Slave mode selection
                SMC: u3,
                reserved4: u1,
                ///  Trigger selection
                TRGS: u3,
                ///  Master/Slave mode
                MSM: u1,
                ///  External trigger filter control
                ETFC: u4,
                ///  External trigger prescaler
                ETPSC: u2,
                ///  Part of SMC for enable External clock mode1
                SMC1: u1,
                ///  External trigger polarity
                ETP: u1,
            }),
            reserved12: [2]u8,
            ///  DMA/Interrupt enable register
            DMAINTEN: mmio.Mmio(packed struct(u16) {
                ///  Update interrupt enable
                UPIE: u1,
                ///  Channel 0 capture/compare interrupt enable
                CH0IE: u1,
                ///  Channel 1 capture/compare interrupt enable
                CH1IE: u1,
                ///  Channel 2 capture/compare interrupt enable
                CH2IE: u1,
                ///  Channel 3 capture/compare interrupt enable
                CH3IE: u1,
                ///  commutation interrupt enable
                CMTIE: u1,
                ///  Trigger interrupt enable
                TRGIE: u1,
                ///  Break interrupt enable
                BRKIE: u1,
                ///  Update DMA request enable
                UPDEN: u1,
                ///  Channel 0 capture/compare DMA request enable
                CH0DEN: u1,
                ///  Channel 1 capture/compare DMA request enable
                CH1DEN: u1,
                ///  Channel 2 capture/compare DMA request enable
                CH2DEN: u1,
                ///  Channel 3 capture/compare DMA request enable
                CH3DEN: u1,
                ///  Commutation DMA request enable
                CMTDEN: u1,
                ///  Trigger DMA request enable
                TRGDEN: u1,
                padding: u1,
            }),
            reserved16: [2]u8,
            ///  Interrupt flag register
            INTF: mmio.Mmio(packed struct(u16) {
                ///  Update interrupt flag
                UPIF: u1,
                ///  Channel 0 capture/compare interrupt flag
                CH0IF: u1,
                ///  Channel 1 capture/compare interrupt flag
                CH1IF: u1,
                ///  Channel 2 capture/compare interrupt flag
                CH2IF: u1,
                ///  Channel 3 capture/compare interrupt flag
                CH3IF: u1,
                ///  Channel commutation interrupt flag
                CMTIF: u1,
                ///  Trigger interrupt flag
                TRGIF: u1,
                ///  Break interrupt flag
                BRKIF: u1,
                reserved9: u1,
                ///  Channel 0 over capture flag
                CH0OF: u1,
                ///  Channel 1 over capture flag
                CH1OF: u1,
                ///  Channel 2 over capture flag
                CH2OF: u1,
                ///  Channel 3 over capture flag
                CH3OF: u1,
                padding: u3,
            }),
            reserved20: [2]u8,
            ///  Software event generation register
            SWEVG: mmio.Mmio(packed struct(u16) {
                ///  Update event generation
                UPG: u1,
                ///  Channel 0 capture or compare event generation
                CH0G: u1,
                ///  Channel 1 capture or compare event generation
                CH1G: u1,
                ///  Channel 2 capture or compare event generation
                CH2G: u1,
                ///  Channel 3 capture or compare event generation
                CH3G: u1,
                ///  Channel commutation event generation
                CMTG: u1,
                ///  Trigger event generation
                TRGG: u1,
                ///  Break event generation
                BRKG: u1,
                padding: u8,
            }),
            reserved24: [2]u8,
            ///  Channel control register 0 (output mode)
            CHCTL0_Output: mmio.Mmio(packed struct(u16) {
                ///  Channel 0 I/O mode selection
                CH0MS: u2,
                ///  Channel 0 output compare fast enable
                CH0COMFEN: u1,
                ///  Channel 0 compare output shadow enable
                CH0COMSEN: u1,
                ///  Channel 0 compare output control
                CH0COMCTL: u3,
                ///  Channel 0 output compare clear enable
                CH0COMCEN: u1,
                ///  Channel 1 mode selection
                CH1MS: u2,
                ///  Channel 1 output compare fast enable
                CH1COMFEN: u1,
                ///  Channel 1 output compare shadow enable
                CH1COMSEN: u1,
                ///  Channel 1 compare output control
                CH1COMCTL: u3,
                ///  Channel 1 output compare clear enable
                CH1COMCEN: u1,
            }),
            reserved28: [2]u8,
            ///  Channel control register 1 (output mode)
            CHCTL1_Output: mmio.Mmio(packed struct(u16) {
                ///  Channel 2 I/O mode selection
                CH2MS: u2,
                ///  Channel 2 output compare fast enable
                CH2COMFEN: u1,
                ///  Channel 2 compare output shadow enable
                CH2COMSEN: u1,
                ///  Channel 2 compare output control
                CH2COMCTL: u3,
                ///  Channel 2 output compare clear enable
                CH2COMCEN: u1,
                ///  Channel 3 mode selection
                CH3MS: u2,
                ///  Channel 3 output compare fast enable
                CH3COMFEN: u1,
                ///  Channel 3 output compare shadow enable
                CH3COMSEN: u1,
                ///  Channel 3 compare output control
                CH3COMCTL: u3,
                ///  Channel 3 output compare clear enable
                CH3COMCEN: u1,
            }),
            reserved32: [2]u8,
            ///  Channel control register 2
            CHCTL2: mmio.Mmio(packed struct(u16) {
                ///  Channel 0 capture/compare function enable
                CH0EN: u1,
                ///  Channel 0 capture/compare function polarity
                CH0P: u1,
                ///  Channel 0 complementary output enable
                CH0NEN: u1,
                ///  Channel 0 complementary output polarity
                CH0NP: u1,
                ///  Channel 1 capture/compare function enable
                CH1EN: u1,
                ///  Channel 1 capture/compare function polarity
                CH1P: u1,
                ///  Channel 1 complementary output enable
                CH1NEN: u1,
                ///  Channel 1 complementary output polarity
                CH1NP: u1,
                ///  Channel 2 capture/compare function enable
                CH2EN: u1,
                ///  Channel 2 capture/compare function polarity
                CH2P: u1,
                ///  Channel 2 complementary output enable
                CH2NEN: u1,
                ///  Channel 2 complementary output polarity
                CH2NP: u1,
                ///  Channel 3 capture/compare function enable
                CH3EN: u1,
                ///  Channel 3 capture/compare function polarity
                CH3P: u1,
                padding: u2,
            }),
            reserved36: [2]u8,
            ///  counter
            CNT: mmio.Mmio(packed struct(u16) {
                ///  current counter value
                CNT: u16,
            }),
            reserved40: [2]u8,
            ///  prescaler
            PSC: mmio.Mmio(packed struct(u16) {
                ///  Prescaler value of the counter clock
                PSC: u16,
            }),
            reserved44: [2]u8,
            ///  Counter auto reload register
            CAR: mmio.Mmio(packed struct(u16) {
                ///  Counter auto reload value
                CARL: u16,
            }),
            reserved48: [2]u8,
            ///  Counter repetition register
            CREP: mmio.Mmio(packed struct(u16) {
                ///  Counter repetition value
                CREP: u8,
                padding: u8,
            }),
            reserved52: [2]u8,
            ///  Channel 0 capture/compare value register
            CH0CV: mmio.Mmio(packed struct(u16) {
                ///  Capture or compare value of channel0
                CH0VAL: u16,
            }),
            reserved56: [2]u8,
            ///  Channel 1 capture/compare value register
            CH1CV: mmio.Mmio(packed struct(u16) {
                ///  Capture or compare value of channel1
                CH1VAL: u16,
            }),
            reserved60: [2]u8,
            ///  Channel 2 capture/compare value register
            CH2CV: mmio.Mmio(packed struct(u16) {
                ///  Capture or compare value of channel 2
                CH2VAL: u16,
            }),
            reserved64: [2]u8,
            ///  Channel 3 capture/compare value register
            CH3CV: mmio.Mmio(packed struct(u16) {
                ///  Capture or compare value of channel 3
                CH3VAL: u16,
            }),
            reserved68: [2]u8,
            ///  channel complementary protection register
            CCHP: mmio.Mmio(packed struct(u16) {
                ///  Dead time configure
                DTCFG: u8,
                ///  Complementary register protect control
                PROT: u2,
                ///  Idle mode off-state configure
                IOS: u1,
                ///  Run mode off-state configure
                ROS: u1,
                ///  Break enable
                BRKEN: u1,
                ///  Break polarity
                BRKP: u1,
                ///  Output automatic enable
                OAEN: u1,
                ///  Primary output enable
                POEN: u1,
            }),
            reserved72: [2]u8,
            ///  DMA configuration register
            DMACFG: mmio.Mmio(packed struct(u16) {
                ///  DMA transfer access start address
                DMATA: u5,
                reserved8: u3,
                ///  DMA transfer count
                DMATC: u5,
                padding: u3,
            }),
            reserved76: [2]u8,
            ///  DMA transfer buffer register
            DMATB: mmio.Mmio(packed struct(u16) {
                ///  DMA transfer buffer
                DMATB: u16,
            }),
        };

        ///  General-purpose-timers
        pub const TIMER1 = extern struct {
            ///  control register 0
            CTL0: mmio.Mmio(packed struct(u16) {
                ///  Counter enable
                CEN: u1,
                ///  Update disable
                UPDIS: u1,
                ///  Update source
                UPS: u1,
                ///  Single pulse mode
                SPM: u1,
                ///  Direction
                DIR: u1,
                ///  Counter aligns mode selection
                CAM: u2,
                ///  Auto-reload shadow enable
                ARSE: u1,
                ///  Clock division
                CKDIV: u2,
                padding: u6,
            }),
            reserved4: [2]u8,
            ///  control register 1
            CTL1: mmio.Mmio(packed struct(u16) {
                reserved3: u3,
                ///  DMA request source selection
                DMAS: u1,
                ///  Master mode control
                MMC: u3,
                ///  Channel 0 trigger input selection
                TI0S: u1,
                padding: u8,
            }),
            reserved8: [2]u8,
            ///  slave mode control register
            SMCFG: mmio.Mmio(packed struct(u16) {
                ///  Slave mode control
                SMC: u3,
                reserved4: u1,
                ///  Trigger selection
                TRGS: u3,
                ///  Master-slave mode
                MSM: u1,
                ///  External trigger filter control
                ETFC: u4,
                ///  External trigger prescaler
                ETPSC: u2,
                ///  Part of SMC for enable External clock mode1
                SMC1: u1,
                ///  External trigger polarity
                ETP: u1,
            }),
            reserved12: [2]u8,
            ///  DMA/Interrupt enable register
            DMAINTEN: mmio.Mmio(packed struct(u16) {
                ///  Update interrupt enable
                UPIE: u1,
                ///  Channel 0 capture/compare interrupt enable
                CH0IE: u1,
                ///  Channel 1 capture/compare interrupt enable
                CH1IE: u1,
                ///  Channel 2 capture/compare interrupt enable
                CH2IE: u1,
                ///  Channel 3 capture/compare interrupt enable
                CH3IE: u1,
                reserved6: u1,
                ///  Trigger interrupt enable
                TRGIE: u1,
                reserved8: u1,
                ///  Update DMA request enable
                UPDEN: u1,
                ///  Channel 0 capture/compare DMA request enable
                CH0DEN: u1,
                ///  Channel 1 capture/compare DMA request enable
                CH1DEN: u1,
                ///  Channel 2 capture/compare DMA request enable
                CH2DEN: u1,
                ///  Channel 3 capture/compare DMA request enable
                CH3DEN: u1,
                reserved14: u1,
                ///  Trigger DMA request enable
                TRGDEN: u1,
                padding: u1,
            }),
            reserved16: [2]u8,
            ///  interrupt flag register
            INTF: mmio.Mmio(packed struct(u16) {
                ///  Update interrupt flag
                UPIF: u1,
                ///  Channel 0 capture/compare interrupt flag
                CH0IF: u1,
                ///  Channel 1 capture/compare interrupt flag
                CH1IF: u1,
                ///  Channel 2 capture/compare interrupt enable
                CH2IF: u1,
                ///  Channel 3 capture/compare interrupt enable
                CH3IF: u1,
                reserved6: u1,
                ///  Trigger interrupt flag
                TRGIF: u1,
                reserved9: u2,
                ///  Channel 0 over capture flag
                CH0OF: u1,
                ///  Channel 1 over capture flag
                CH1OF: u1,
                ///  Channel 2 over capture flag
                CH2OF: u1,
                ///  Channel 3 over capture flag
                CH3OF: u1,
                padding: u3,
            }),
            reserved20: [2]u8,
            ///  event generation register
            SWEVG: mmio.Mmio(packed struct(u16) {
                ///  Update generation
                UPG: u1,
                ///  Channel 0 capture or compare event generation
                CH0G: u1,
                ///  Channel 1 capture or compare event generation
                CH1G: u1,
                ///  Channel 2 capture or compare event generation
                CH2G: u1,
                ///  Channel 3 capture or compare event generation
                CH3G: u1,
                reserved6: u1,
                ///  Trigger event generation
                TRGG: u1,
                padding: u9,
            }),
            reserved24: [2]u8,
            ///  Channel control register 0 (output mode)
            CHCTL0_Output: mmio.Mmio(packed struct(u16) {
                ///  Channel 0 I/O mode selection
                CH0MS: u2,
                ///  Channel 0 output compare fast enable
                CH0COMFEN: u1,
                ///  Channel 0 compare output shadow enable
                CH0COMSEN: u1,
                ///  Channel 0 compare output control
                CH0COMCTL: u3,
                ///  Channel 0 output compare clear enable
                CH0COMCEN: u1,
                ///  Channel 1 mode selection
                CH1MS: u2,
                ///  Channel 1 output compare fast enable
                CH1COMFEN: u1,
                ///  Channel 1 output compare shadow enable
                CH1COMSEN: u1,
                ///  Channel 1 compare output control
                CH1COMCTL: u3,
                ///  Channel 1 output compare clear enable
                CH1COMCEN: u1,
            }),
            reserved28: [2]u8,
            ///  Channel control register 1 (output mode)
            CHCTL1_Output: mmio.Mmio(packed struct(u16) {
                ///  Channel 2 I/O mode selection
                CH2MS: u2,
                ///  Channel 2 output compare fast enable
                CH2COMFEN: u1,
                ///  Channel 2 compare output shadow enable
                CH2COMSEN: u1,
                ///  Channel 2 compare output control
                CH2COMCTL: u3,
                ///  Channel 2 output compare clear enable
                CH2COMCEN: u1,
                ///  Channel 3 mode selection
                CH3MS: u2,
                ///  Channel 3 output compare fast enable
                CH3COMFEN: u1,
                ///  Channel 3 output compare shadow enable
                CH3COMSEN: u1,
                ///  Channel 3 compare output control
                CH3COMCTL: u3,
                ///  Channel 3 output compare clear enable
                CH3COMCEN: u1,
            }),
            reserved32: [2]u8,
            ///  Channel control register 2
            CHCTL2: mmio.Mmio(packed struct(u16) {
                ///  Channel 0 capture/compare function enable
                CH0EN: u1,
                ///  Channel 0 capture/compare function polarity
                CH0P: u1,
                reserved4: u2,
                ///  Channel 1 capture/compare function enable
                CH1EN: u1,
                ///  Channel 1 capture/compare function polarity
                CH1P: u1,
                reserved8: u2,
                ///  Channel 2 capture/compare function enable
                CH2EN: u1,
                ///  Channel 2 capture/compare function polarity
                CH2P: u1,
                reserved12: u2,
                ///  Channel 3 capture/compare function enable
                CH3EN: u1,
                ///  Channel 3 capture/compare function polarity
                CH3P: u1,
                padding: u2,
            }),
            reserved36: [2]u8,
            ///  Counter register
            CNT: mmio.Mmio(packed struct(u16) {
                ///  counter value
                CNT: u16,
            }),
            reserved40: [2]u8,
            ///  Prescaler register
            PSC: mmio.Mmio(packed struct(u16) {
                ///  Prescaler value of the counter clock
                PSC: u16,
            }),
            reserved44: [2]u8,
            ///  Counter auto reload register
            CAR: mmio.Mmio(packed struct(u16) {
                ///  Counter auto reload value
                CARL: u16,
            }),
            reserved52: [6]u8,
            ///  Channel 0 capture/compare value register
            CH0CV: mmio.Mmio(packed struct(u32) {
                ///  Capture or compare value of channel 0
                CH0VAL: u16,
                padding: u16,
            }),
            ///  Channel 1 capture/compare value register
            CH1CV: mmio.Mmio(packed struct(u32) {
                ///  Capture or compare value of channel1
                CH1VAL: u16,
                padding: u16,
            }),
            ///  Channel 2 capture/compare value register
            CH2CV: mmio.Mmio(packed struct(u32) {
                ///  Capture or compare value of channel 2
                CH2VAL: u16,
                padding: u16,
            }),
            ///  Channel 3 capture/compare value register
            CH3CV: mmio.Mmio(packed struct(u32) {
                ///  Capture or compare value of channel 3
                CH3VAL: u16,
                padding: u16,
            }),
            reserved72: [4]u8,
            ///  DMA configuration register
            DMACFG: mmio.Mmio(packed struct(u16) {
                ///  DMA transfer access start address
                DMATA: u5,
                reserved8: u3,
                ///  DMA transfer count
                DMATC: u5,
                padding: u3,
            }),
            reserved76: [2]u8,
            ///  DMA transfer buffer register
            DMATB: mmio.Mmio(packed struct(u32) {
                ///  DMA transfer buffer
                DMATB: u16,
                padding: u16,
            }),
        };
    };
};
