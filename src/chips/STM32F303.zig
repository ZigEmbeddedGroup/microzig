const micro = @import("microzig");
const mmio = micro.mmio;

pub const devices = struct {
    ///  STM32F303
    pub const STM32F303 = struct {
        pub const properties = struct {
            pub const @"cpu.nvic_prio_bits" = "3";
            pub const @"cpu.mpu" = "false";
            pub const @"cpu.fpu" = "false";
            pub const @"cpu.revision" = "r1p0";
            pub const @"cpu.vendor_systick_config" = "false";
            pub const @"cpu.endian" = "little";
            pub const @"cpu.name" = "CM4";
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
            ///  Window Watchdog interrupt
            WWDG: Handler = unhandled,
            ///  PVD through EXTI line detection interrupt
            PVD: Handler = unhandled,
            ///  Tamper and TimeStamp interrupts
            TAMP_STAMP: Handler = unhandled,
            ///  RTC Wakeup interrupt through the EXTI line
            RTC_WKUP: Handler = unhandled,
            ///  Flash global interrupt
            FLASH: Handler = unhandled,
            ///  RCC global interrupt
            RCC: Handler = unhandled,
            reserved20: [2]u32 = undefined,
            ///  EXTI Line2 and Touch sensing interrupts
            EXTI2_TSC: Handler = unhandled,
            reserved23: [2]u32 = undefined,
            ///  DMA1 channel 1 interrupt
            DMA1_CH1: Handler = unhandled,
            reserved26: [6]u32 = undefined,
            ///  ADC1 and ADC2 global interrupt
            ADC1_2: Handler = unhandled,
            ///  USB High Priority/CAN_TX interrupts
            USB_HP_CAN_TX: Handler = unhandled,
            reserved34: [4]u32 = undefined,
            ///  TIM1 Break/TIM15 global interruts
            TIM1_BRK_TIM15: Handler = unhandled,
            ///  TIM1 Update/TIM16 global interrupts
            TIM1_UP_TIM16: Handler = unhandled,
            ///  TIM1 trigger and commutation/TIM17 interrupts
            TIM1_TRG_COM_TIM17: Handler = unhandled,
            ///  TIM1 capture compare interrupt
            TIM1_CC: Handler = unhandled,
            ///  TIM2 global interrupt
            TIM2: Handler = unhandled,
            ///  TIM3 global interrupt
            TIM3: Handler = unhandled,
            ///  TIM4 global interrupt
            TIM4: Handler = unhandled,
            ///  I2C1 event interrupt and EXTI Line23 interrupt
            I2C1_EV_EXTI23: Handler = unhandled,
            reserved46: [1]u32 = undefined,
            ///  I2C2 event interrupt & EXTI Line24 interrupt
            I2C2_EV_EXTI24: Handler = unhandled,
            reserved48: [1]u32 = undefined,
            ///  SPI1 global interrupt
            SPI1: Handler = unhandled,
            ///  SPI2 global interrupt
            SPI2: Handler = unhandled,
            ///  USART1 global interrupt and EXTI Line 25 interrupt
            USART1_EXTI25: Handler = unhandled,
            ///  USART2 global interrupt and EXTI Line 26 interrupt
            USART2_EXTI26: Handler = unhandled,
            ///  USART3 global interrupt and EXTI Line 28 interrupt
            USART3_EXTI28: Handler = unhandled,
            reserved54: [2]u32 = undefined,
            ///  USB wakeup from Suspend
            USB_WKUP: Handler = unhandled,
            ///  TIM8 break interrupt
            TIM8_BRK: Handler = unhandled,
            reserved58: [3]u32 = undefined,
            ///  ADC3 global interrupt
            ADC3: Handler = unhandled,
            ///  FSMC global interrupt
            FMC: Handler = unhandled,
            reserved63: [2]u32 = undefined,
            ///  SPI3 global interrupt
            SPI3: Handler = unhandled,
            ///  UART4 global and EXTI Line 34 interrupts
            UART4_EXTI34: Handler = unhandled,
            ///  UART5 global and EXTI Line 35 interrupts
            UART5_EXTI35: Handler = unhandled,
            ///  TIM6 global and DAC12 underrun interrupts
            TIM6_DACUNDER: Handler = unhandled,
            ///  TIM7 global interrupt
            TIM7: Handler = unhandled,
            ///  DMA2 channel1 global interrupt
            DMA2_CH1: Handler = unhandled,
            reserved71: [4]u32 = undefined,
            ///  ADC4 global interrupt
            ADC4: Handler = unhandled,
            reserved76: [2]u32 = undefined,
            ///  COMP1 & COMP2 & COMP3 interrupts combined with EXTI Lines 21, 22 and 29 interrupts
            COMP123: Handler = unhandled,
            reserved79: [16]u32 = undefined,
            ///  Floating point unit interrupt
            FPU: Handler = unhandled,
        };

        pub const peripherals = struct {
            ///  General purpose timer
            pub const TIM2 = @as(*volatile types.TIM2, @ptrFromInt(0x40000000));
            ///  General purpose timer
            pub const TIM3 = @as(*volatile types.TIM2, @ptrFromInt(0x40000400));
            ///  General purpose timer
            pub const TIM4 = @as(*volatile types.TIM2, @ptrFromInt(0x40000800));
            ///  Basic timers
            pub const TIM6 = @as(*volatile types.TIM6, @ptrFromInt(0x40001000));
            ///  Basic timers
            pub const TIM7 = @as(*volatile types.TIM6, @ptrFromInt(0x40001400));
            ///  Real-time clock
            pub const RTC = @as(*volatile types.RTC, @ptrFromInt(0x40002800));
            ///  Window watchdog
            pub const WWDG = @as(*volatile types.WWDG, @ptrFromInt(0x40002c00));
            ///  Independent watchdog
            pub const IWDG = @as(*volatile types.IWDG, @ptrFromInt(0x40003000));
            ///  Serial peripheral interface/Inter-IC sound
            pub const I2S2ext = @as(*volatile types.SPI1, @ptrFromInt(0x40003400));
            ///  Serial peripheral interface/Inter-IC sound
            pub const SPI2 = @as(*volatile types.SPI1, @ptrFromInt(0x40003800));
            ///  Serial peripheral interface/Inter-IC sound
            pub const SPI3 = @as(*volatile types.SPI1, @ptrFromInt(0x40003c00));
            ///  Serial peripheral interface/Inter-IC sound
            pub const I2S3ext = @as(*volatile types.SPI1, @ptrFromInt(0x40004000));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const USART2 = @as(*volatile types.USART1, @ptrFromInt(0x40004400));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const USART3 = @as(*volatile types.USART1, @ptrFromInt(0x40004800));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const UART4 = @as(*volatile types.USART1, @ptrFromInt(0x40004c00));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const UART5 = @as(*volatile types.USART1, @ptrFromInt(0x40005000));
            ///  Inter-integrated circuit
            pub const I2C1 = @as(*volatile types.I2C1, @ptrFromInt(0x40005400));
            ///  Inter-integrated circuit
            pub const I2C2 = @as(*volatile types.I2C1, @ptrFromInt(0x40005800));
            ///  Universal serial bus full-speed device interface
            pub const USB_FS = @as(*volatile types.USB_FS, @ptrFromInt(0x40005c00));
            ///  Controller area network
            pub const CAN = @as(*volatile types.CAN, @ptrFromInt(0x40006400));
            ///  Power control
            pub const PWR = @as(*volatile types.PWR, @ptrFromInt(0x40007000));
            ///  Digital-to-analog converter
            pub const DAC = @as(*volatile types.DAC, @ptrFromInt(0x40007400));
            ///  Inter-integrated circuit
            pub const I2C3 = @as(*volatile types.I2C1, @ptrFromInt(0x40007800));
            ///  System configuration controller _Comparator and Operational amplifier
            pub const SYSCFG_COMP_OPAMP = @as(*volatile types.SYSCFG_COMP_OPAMP, @ptrFromInt(0x40010000));
            ///  External interrupt/event controller
            pub const EXTI = @as(*volatile types.EXTI, @ptrFromInt(0x40010400));
            ///  Advanced timer
            pub const TIM1 = @as(*volatile types.TIM1, @ptrFromInt(0x40012c00));
            ///  Serial peripheral interface/Inter-IC sound
            pub const SPI1 = @as(*volatile types.SPI1, @ptrFromInt(0x40013000));
            ///  Advanced-timers
            pub const TIM8 = @as(*volatile types.TIM8, @ptrFromInt(0x40013400));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const USART1 = @as(*volatile types.USART1, @ptrFromInt(0x40013800));
            ///  Serial peripheral interface/Inter-IC sound
            pub const SPI4 = @as(*volatile types.SPI1, @ptrFromInt(0x40013c00));
            ///  General purpose timers
            pub const TIM15 = @as(*volatile types.TIM15, @ptrFromInt(0x40014000));
            ///  General-purpose-timers
            pub const TIM16 = @as(*volatile types.TIM16, @ptrFromInt(0x40014400));
            ///  General purpose timer
            pub const TIM17 = @as(*volatile types.TIM17, @ptrFromInt(0x40014800));
            ///  Advanced timer
            pub const TIM20 = @as(*volatile types.TIM1, @ptrFromInt(0x40015000));
            ///  DMA controller 1
            pub const DMA1 = @as(*volatile types.DMA1, @ptrFromInt(0x40020000));
            ///  DMA controller 1
            pub const DMA2 = @as(*volatile types.DMA1, @ptrFromInt(0x40020400));
            ///  Reset and clock control
            pub const RCC = @as(*volatile types.RCC, @ptrFromInt(0x40021000));
            ///  Flash
            pub const Flash = @as(*volatile types.Flash, @ptrFromInt(0x40022000));
            ///  cyclic redundancy check calculation unit
            pub const CRC = @as(*volatile types.CRC, @ptrFromInt(0x40023000));
            ///  Touch sensing controller
            pub const TSC = @as(*volatile types.TSC, @ptrFromInt(0x40024000));
            ///  General-purpose I/Os
            pub const GPIOA = @as(*volatile types.GPIOA, @ptrFromInt(0x48000000));
            ///  General-purpose I/Os
            pub const GPIOB = @as(*volatile types.GPIOB, @ptrFromInt(0x48000400));
            ///  General-purpose I/Os
            pub const GPIOC = @as(*volatile types.GPIOB, @ptrFromInt(0x48000800));
            ///  General-purpose I/Os
            pub const GPIOD = @as(*volatile types.GPIOB, @ptrFromInt(0x48000c00));
            ///  General-purpose I/Os
            pub const GPIOE = @as(*volatile types.GPIOB, @ptrFromInt(0x48001000));
            ///  General-purpose I/Os
            pub const GPIOF = @as(*volatile types.GPIOB, @ptrFromInt(0x48001400));
            ///  General-purpose I/Os
            pub const GPIOG = @as(*volatile types.GPIOB, @ptrFromInt(0x48001800));
            ///  General-purpose I/Os
            pub const GPIOH = @as(*volatile types.GPIOB, @ptrFromInt(0x48001c00));
            ///  Analog-to-Digital Converter
            pub const ADC1 = @as(*volatile types.ADC1, @ptrFromInt(0x50000000));
            ///  Analog-to-Digital Converter
            pub const ADC2 = @as(*volatile types.ADC1, @ptrFromInt(0x50000100));
            ///  Analog-to-Digital Converter
            pub const ADC1_2 = @as(*volatile types.ADC1_2, @ptrFromInt(0x50000300));
            ///  Analog-to-Digital Converter
            pub const ADC3 = @as(*volatile types.ADC1, @ptrFromInt(0x50000400));
            ///  Analog-to-Digital Converter
            pub const ADC4 = @as(*volatile types.ADC1, @ptrFromInt(0x50000500));
            ///  Analog-to-Digital Converter
            pub const ADC3_4 = @as(*volatile types.ADC1_2, @ptrFromInt(0x50000700));
            ///  Flexible memory controller
            pub const FMC = @as(*volatile types.FMC, @ptrFromInt(0xa0000400));
            ///  System control block ACTLR
            pub const SCB_ACTRL = @as(*volatile types.SCB_ACTRL, @ptrFromInt(0xe000e008));
            ///  SysTick timer
            pub const STK = @as(*volatile types.STK, @ptrFromInt(0xe000e010));
            ///  Nested Vectored Interrupt Controller
            pub const NVIC = @as(*volatile types.NVIC, @ptrFromInt(0xe000e100));
            ///  System control block
            pub const SCB = @as(*volatile types.SCB, @ptrFromInt(0xe000ed00));
            ///  Floating point unit CPACR
            pub const FPU_CPACR = @as(*volatile types.FPU_CPACR, @ptrFromInt(0xe000ed88));
            ///  Memory protection unit
            pub const MPU = @as(*volatile types.MPU, @ptrFromInt(0xe000ed90));
            ///  Nested vectored interrupt controller
            pub const NVIC_STIR = @as(*volatile types.NVIC_STIR, @ptrFromInt(0xe000ef00));
            ///  Floting point unit
            pub const FPU = @as(*volatile types.FPU, @ptrFromInt(0xe000ef34));
            ///  Debug support
            pub const DBGMCU = @as(*volatile types.DBGMCU, @ptrFromInt(0xe0042000));
        };
    };
};

pub const types = struct {
    ///  General-purpose I/Os
    pub const GPIOA = extern struct {
        ///  GPIO port mode register
        MODER: mmio.Mmio(packed struct(u32) {
            ///  Port x configuration bits (y = 0..15)
            MODER0: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER1: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER2: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER3: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER4: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER5: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER6: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER7: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER8: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER9: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER10: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER11: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER12: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER13: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER14: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER15: u2,
        }),
        ///  GPIO port output type register
        OTYPER: mmio.Mmio(packed struct(u32) {
            ///  Port x configuration bits (y = 0..15)
            OT0: u1,
            ///  Port x configuration bits (y = 0..15)
            OT1: u1,
            ///  Port x configuration bits (y = 0..15)
            OT2: u1,
            ///  Port x configuration bits (y = 0..15)
            OT3: u1,
            ///  Port x configuration bits (y = 0..15)
            OT4: u1,
            ///  Port x configuration bits (y = 0..15)
            OT5: u1,
            ///  Port x configuration bits (y = 0..15)
            OT6: u1,
            ///  Port x configuration bits (y = 0..15)
            OT7: u1,
            ///  Port x configuration bits (y = 0..15)
            OT8: u1,
            ///  Port x configuration bits (y = 0..15)
            OT9: u1,
            ///  Port x configuration bits (y = 0..15)
            OT10: u1,
            ///  Port x configuration bits (y = 0..15)
            OT11: u1,
            ///  Port x configuration bits (y = 0..15)
            OT12: u1,
            ///  Port x configuration bits (y = 0..15)
            OT13: u1,
            ///  Port x configuration bits (y = 0..15)
            OT14: u1,
            ///  Port x configuration bits (y = 0..15)
            OT15: u1,
            padding: u16,
        }),
        ///  GPIO port output speed register
        OSPEEDR: mmio.Mmio(packed struct(u32) {
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR0: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR1: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR2: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR3: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR4: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR5: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR6: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR7: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR8: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR9: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR10: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR11: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR12: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR13: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR14: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR15: u2,
        }),
        ///  GPIO port pull-up/pull-down register
        PUPDR: mmio.Mmio(packed struct(u32) {
            ///  Port x configuration bits (y = 0..15)
            PUPDR0: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR1: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR2: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR3: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR4: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR5: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR6: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR7: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR8: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR9: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR10: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR11: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR12: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR13: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR14: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR15: u2,
        }),
        ///  GPIO port input data register
        IDR: mmio.Mmio(packed struct(u32) {
            ///  Port input data (y = 0..15)
            IDR0: u1,
            ///  Port input data (y = 0..15)
            IDR1: u1,
            ///  Port input data (y = 0..15)
            IDR2: u1,
            ///  Port input data (y = 0..15)
            IDR3: u1,
            ///  Port input data (y = 0..15)
            IDR4: u1,
            ///  Port input data (y = 0..15)
            IDR5: u1,
            ///  Port input data (y = 0..15)
            IDR6: u1,
            ///  Port input data (y = 0..15)
            IDR7: u1,
            ///  Port input data (y = 0..15)
            IDR8: u1,
            ///  Port input data (y = 0..15)
            IDR9: u1,
            ///  Port input data (y = 0..15)
            IDR10: u1,
            ///  Port input data (y = 0..15)
            IDR11: u1,
            ///  Port input data (y = 0..15)
            IDR12: u1,
            ///  Port input data (y = 0..15)
            IDR13: u1,
            ///  Port input data (y = 0..15)
            IDR14: u1,
            ///  Port input data (y = 0..15)
            IDR15: u1,
            padding: u16,
        }),
        ///  GPIO port output data register
        ODR: mmio.Mmio(packed struct(u32) {
            ///  Port output data (y = 0..15)
            ODR0: u1,
            ///  Port output data (y = 0..15)
            ODR1: u1,
            ///  Port output data (y = 0..15)
            ODR2: u1,
            ///  Port output data (y = 0..15)
            ODR3: u1,
            ///  Port output data (y = 0..15)
            ODR4: u1,
            ///  Port output data (y = 0..15)
            ODR5: u1,
            ///  Port output data (y = 0..15)
            ODR6: u1,
            ///  Port output data (y = 0..15)
            ODR7: u1,
            ///  Port output data (y = 0..15)
            ODR8: u1,
            ///  Port output data (y = 0..15)
            ODR9: u1,
            ///  Port output data (y = 0..15)
            ODR10: u1,
            ///  Port output data (y = 0..15)
            ODR11: u1,
            ///  Port output data (y = 0..15)
            ODR12: u1,
            ///  Port output data (y = 0..15)
            ODR13: u1,
            ///  Port output data (y = 0..15)
            ODR14: u1,
            ///  Port output data (y = 0..15)
            ODR15: u1,
            padding: u16,
        }),
        ///  GPIO port bit set/reset register
        BSRR: mmio.Mmio(packed struct(u32) {
            ///  Port x set bit y (y= 0..15)
            BS0: u1,
            ///  Port x set bit y (y= 0..15)
            BS1: u1,
            ///  Port x set bit y (y= 0..15)
            BS2: u1,
            ///  Port x set bit y (y= 0..15)
            BS3: u1,
            ///  Port x set bit y (y= 0..15)
            BS4: u1,
            ///  Port x set bit y (y= 0..15)
            BS5: u1,
            ///  Port x set bit y (y= 0..15)
            BS6: u1,
            ///  Port x set bit y (y= 0..15)
            BS7: u1,
            ///  Port x set bit y (y= 0..15)
            BS8: u1,
            ///  Port x set bit y (y= 0..15)
            BS9: u1,
            ///  Port x set bit y (y= 0..15)
            BS10: u1,
            ///  Port x set bit y (y= 0..15)
            BS11: u1,
            ///  Port x set bit y (y= 0..15)
            BS12: u1,
            ///  Port x set bit y (y= 0..15)
            BS13: u1,
            ///  Port x set bit y (y= 0..15)
            BS14: u1,
            ///  Port x set bit y (y= 0..15)
            BS15: u1,
            ///  Port x set bit y (y= 0..15)
            BR0: u1,
            ///  Port x reset bit y (y = 0..15)
            BR1: u1,
            ///  Port x reset bit y (y = 0..15)
            BR2: u1,
            ///  Port x reset bit y (y = 0..15)
            BR3: u1,
            ///  Port x reset bit y (y = 0..15)
            BR4: u1,
            ///  Port x reset bit y (y = 0..15)
            BR5: u1,
            ///  Port x reset bit y (y = 0..15)
            BR6: u1,
            ///  Port x reset bit y (y = 0..15)
            BR7: u1,
            ///  Port x reset bit y (y = 0..15)
            BR8: u1,
            ///  Port x reset bit y (y = 0..15)
            BR9: u1,
            ///  Port x reset bit y (y = 0..15)
            BR10: u1,
            ///  Port x reset bit y (y = 0..15)
            BR11: u1,
            ///  Port x reset bit y (y = 0..15)
            BR12: u1,
            ///  Port x reset bit y (y = 0..15)
            BR13: u1,
            ///  Port x reset bit y (y = 0..15)
            BR14: u1,
            ///  Port x reset bit y (y = 0..15)
            BR15: u1,
        }),
        ///  GPIO port configuration lock register
        LCKR: mmio.Mmio(packed struct(u32) {
            ///  Port x lock bit y (y= 0..15)
            LCK0: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK1: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK2: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK3: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK4: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK5: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK6: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK7: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK8: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK9: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK10: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK11: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK12: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK13: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK14: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK15: u1,
            ///  Lok Key
            LCKK: u1,
            padding: u15,
        }),
        ///  GPIO alternate function low register
        AFRL: mmio.Mmio(packed struct(u32) {
            ///  Alternate function selection for port x bit y (y = 0..7)
            AFRL0: u4,
            ///  Alternate function selection for port x bit y (y = 0..7)
            AFRL1: u4,
            ///  Alternate function selection for port x bit y (y = 0..7)
            AFRL2: u4,
            ///  Alternate function selection for port x bit y (y = 0..7)
            AFRL3: u4,
            ///  Alternate function selection for port x bit y (y = 0..7)
            AFRL4: u4,
            ///  Alternate function selection for port x bit y (y = 0..7)
            AFRL5: u4,
            ///  Alternate function selection for port x bit y (y = 0..7)
            AFRL6: u4,
            ///  Alternate function selection for port x bit y (y = 0..7)
            AFRL7: u4,
        }),
        ///  GPIO alternate function high register
        AFRH: mmio.Mmio(packed struct(u32) {
            ///  Alternate function selection for port x bit y (y = 8..15)
            AFRH8: u4,
            ///  Alternate function selection for port x bit y (y = 8..15)
            AFRH9: u4,
            ///  Alternate function selection for port x bit y (y = 8..15)
            AFRH10: u4,
            ///  Alternate function selection for port x bit y (y = 8..15)
            AFRH11: u4,
            ///  Alternate function selection for port x bit y (y = 8..15)
            AFRH12: u4,
            ///  Alternate function selection for port x bit y (y = 8..15)
            AFRH13: u4,
            ///  Alternate function selection for port x bit y (y = 8..15)
            AFRH14: u4,
            ///  Alternate function selection for port x bit y (y = 8..15)
            AFRH15: u4,
        }),
        ///  Port bit reset register
        BRR: mmio.Mmio(packed struct(u32) {
            ///  Port x Reset bit y
            BR0: u1,
            ///  Port x Reset bit y
            BR1: u1,
            ///  Port x Reset bit y
            BR2: u1,
            ///  Port x Reset bit y
            BR3: u1,
            ///  Port x Reset bit y
            BR4: u1,
            ///  Port x Reset bit y
            BR5: u1,
            ///  Port x Reset bit y
            BR6: u1,
            ///  Port x Reset bit y
            BR7: u1,
            ///  Port x Reset bit y
            BR8: u1,
            ///  Port x Reset bit y
            BR9: u1,
            ///  Port x Reset bit y
            BR10: u1,
            ///  Port x Reset bit y
            BR11: u1,
            ///  Port x Reset bit y
            BR12: u1,
            ///  Port x Reset bit y
            BR13: u1,
            ///  Port x Reset bit y
            BR14: u1,
            ///  Port x Reset bit y
            BR15: u1,
            padding: u16,
        }),
    };

    ///  General-purpose I/Os
    pub const GPIOB = extern struct {
        ///  GPIO port mode register
        MODER: mmio.Mmio(packed struct(u32) {
            ///  Port x configuration bits (y = 0..15)
            MODER0: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER1: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER2: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER3: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER4: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER5: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER6: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER7: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER8: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER9: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER10: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER11: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER12: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER13: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER14: u2,
            ///  Port x configuration bits (y = 0..15)
            MODER15: u2,
        }),
        ///  GPIO port output type register
        OTYPER: mmio.Mmio(packed struct(u32) {
            ///  Port x configuration bit 0
            OT0: u1,
            ///  Port x configuration bit 1
            OT1: u1,
            ///  Port x configuration bit 2
            OT2: u1,
            ///  Port x configuration bit 3
            OT3: u1,
            ///  Port x configuration bit 4
            OT4: u1,
            ///  Port x configuration bit 5
            OT5: u1,
            ///  Port x configuration bit 6
            OT6: u1,
            ///  Port x configuration bit 7
            OT7: u1,
            ///  Port x configuration bit 8
            OT8: u1,
            ///  Port x configuration bit 9
            OT9: u1,
            ///  Port x configuration bit 10
            OT10: u1,
            ///  Port x configuration bit 11
            OT11: u1,
            ///  Port x configuration bit 12
            OT12: u1,
            ///  Port x configuration bit 13
            OT13: u1,
            ///  Port x configuration bit 14
            OT14: u1,
            ///  Port x configuration bit 15
            OT15: u1,
            padding: u16,
        }),
        ///  GPIO port output speed register
        OSPEEDR: mmio.Mmio(packed struct(u32) {
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR0: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR1: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR2: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR3: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR4: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR5: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR6: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR7: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR8: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR9: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR10: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR11: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR12: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR13: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR14: u2,
            ///  Port x configuration bits (y = 0..15)
            OSPEEDR15: u2,
        }),
        ///  GPIO port pull-up/pull-down register
        PUPDR: mmio.Mmio(packed struct(u32) {
            ///  Port x configuration bits (y = 0..15)
            PUPDR0: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR1: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR2: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR3: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR4: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR5: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR6: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR7: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR8: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR9: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR10: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR11: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR12: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR13: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR14: u2,
            ///  Port x configuration bits (y = 0..15)
            PUPDR15: u2,
        }),
        ///  GPIO port input data register
        IDR: mmio.Mmio(packed struct(u32) {
            ///  Port input data (y = 0..15)
            IDR0: u1,
            ///  Port input data (y = 0..15)
            IDR1: u1,
            ///  Port input data (y = 0..15)
            IDR2: u1,
            ///  Port input data (y = 0..15)
            IDR3: u1,
            ///  Port input data (y = 0..15)
            IDR4: u1,
            ///  Port input data (y = 0..15)
            IDR5: u1,
            ///  Port input data (y = 0..15)
            IDR6: u1,
            ///  Port input data (y = 0..15)
            IDR7: u1,
            ///  Port input data (y = 0..15)
            IDR8: u1,
            ///  Port input data (y = 0..15)
            IDR9: u1,
            ///  Port input data (y = 0..15)
            IDR10: u1,
            ///  Port input data (y = 0..15)
            IDR11: u1,
            ///  Port input data (y = 0..15)
            IDR12: u1,
            ///  Port input data (y = 0..15)
            IDR13: u1,
            ///  Port input data (y = 0..15)
            IDR14: u1,
            ///  Port input data (y = 0..15)
            IDR15: u1,
            padding: u16,
        }),
        ///  GPIO port output data register
        ODR: mmio.Mmio(packed struct(u32) {
            ///  Port output data (y = 0..15)
            ODR0: u1,
            ///  Port output data (y = 0..15)
            ODR1: u1,
            ///  Port output data (y = 0..15)
            ODR2: u1,
            ///  Port output data (y = 0..15)
            ODR3: u1,
            ///  Port output data (y = 0..15)
            ODR4: u1,
            ///  Port output data (y = 0..15)
            ODR5: u1,
            ///  Port output data (y = 0..15)
            ODR6: u1,
            ///  Port output data (y = 0..15)
            ODR7: u1,
            ///  Port output data (y = 0..15)
            ODR8: u1,
            ///  Port output data (y = 0..15)
            ODR9: u1,
            ///  Port output data (y = 0..15)
            ODR10: u1,
            ///  Port output data (y = 0..15)
            ODR11: u1,
            ///  Port output data (y = 0..15)
            ODR12: u1,
            ///  Port output data (y = 0..15)
            ODR13: u1,
            ///  Port output data (y = 0..15)
            ODR14: u1,
            ///  Port output data (y = 0..15)
            ODR15: u1,
            padding: u16,
        }),
        ///  GPIO port bit set/reset register
        BSRR: mmio.Mmio(packed struct(u32) {
            ///  Port x set bit y (y= 0..15)
            BS0: u1,
            ///  Port x set bit y (y= 0..15)
            BS1: u1,
            ///  Port x set bit y (y= 0..15)
            BS2: u1,
            ///  Port x set bit y (y= 0..15)
            BS3: u1,
            ///  Port x set bit y (y= 0..15)
            BS4: u1,
            ///  Port x set bit y (y= 0..15)
            BS5: u1,
            ///  Port x set bit y (y= 0..15)
            BS6: u1,
            ///  Port x set bit y (y= 0..15)
            BS7: u1,
            ///  Port x set bit y (y= 0..15)
            BS8: u1,
            ///  Port x set bit y (y= 0..15)
            BS9: u1,
            ///  Port x set bit y (y= 0..15)
            BS10: u1,
            ///  Port x set bit y (y= 0..15)
            BS11: u1,
            ///  Port x set bit y (y= 0..15)
            BS12: u1,
            ///  Port x set bit y (y= 0..15)
            BS13: u1,
            ///  Port x set bit y (y= 0..15)
            BS14: u1,
            ///  Port x set bit y (y= 0..15)
            BS15: u1,
            ///  Port x set bit y (y= 0..15)
            BR0: u1,
            ///  Port x reset bit y (y = 0..15)
            BR1: u1,
            ///  Port x reset bit y (y = 0..15)
            BR2: u1,
            ///  Port x reset bit y (y = 0..15)
            BR3: u1,
            ///  Port x reset bit y (y = 0..15)
            BR4: u1,
            ///  Port x reset bit y (y = 0..15)
            BR5: u1,
            ///  Port x reset bit y (y = 0..15)
            BR6: u1,
            ///  Port x reset bit y (y = 0..15)
            BR7: u1,
            ///  Port x reset bit y (y = 0..15)
            BR8: u1,
            ///  Port x reset bit y (y = 0..15)
            BR9: u1,
            ///  Port x reset bit y (y = 0..15)
            BR10: u1,
            ///  Port x reset bit y (y = 0..15)
            BR11: u1,
            ///  Port x reset bit y (y = 0..15)
            BR12: u1,
            ///  Port x reset bit y (y = 0..15)
            BR13: u1,
            ///  Port x reset bit y (y = 0..15)
            BR14: u1,
            ///  Port x reset bit y (y = 0..15)
            BR15: u1,
        }),
        ///  GPIO port configuration lock register
        LCKR: mmio.Mmio(packed struct(u32) {
            ///  Port x lock bit y (y= 0..15)
            LCK0: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK1: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK2: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK3: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK4: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK5: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK6: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK7: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK8: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK9: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK10: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK11: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK12: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK13: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK14: u1,
            ///  Port x lock bit y (y= 0..15)
            LCK15: u1,
            ///  Lok Key
            LCKK: u1,
            padding: u15,
        }),
        ///  GPIO alternate function low register
        AFRL: mmio.Mmio(packed struct(u32) {
            ///  Alternate function selection for port x bit y (y = 0..7)
            AFRL0: u4,
            ///  Alternate function selection for port x bit y (y = 0..7)
            AFRL1: u4,
            ///  Alternate function selection for port x bit y (y = 0..7)
            AFRL2: u4,
            ///  Alternate function selection for port x bit y (y = 0..7)
            AFRL3: u4,
            ///  Alternate function selection for port x bit y (y = 0..7)
            AFRL4: u4,
            ///  Alternate function selection for port x bit y (y = 0..7)
            AFRL5: u4,
            ///  Alternate function selection for port x bit y (y = 0..7)
            AFRL6: u4,
            ///  Alternate function selection for port x bit y (y = 0..7)
            AFRL7: u4,
        }),
        ///  GPIO alternate function high register
        AFRH: mmio.Mmio(packed struct(u32) {
            ///  Alternate function selection for port x bit y (y = 8..15)
            AFRH8: u4,
            ///  Alternate function selection for port x bit y (y = 8..15)
            AFRH9: u4,
            ///  Alternate function selection for port x bit y (y = 8..15)
            AFRH10: u4,
            ///  Alternate function selection for port x bit y (y = 8..15)
            AFRH11: u4,
            ///  Alternate function selection for port x bit y (y = 8..15)
            AFRH12: u4,
            ///  Alternate function selection for port x bit y (y = 8..15)
            AFRH13: u4,
            ///  Alternate function selection for port x bit y (y = 8..15)
            AFRH14: u4,
            ///  Alternate function selection for port x bit y (y = 8..15)
            AFRH15: u4,
        }),
        ///  Port bit reset register
        BRR: mmio.Mmio(packed struct(u32) {
            ///  Port x Reset bit y
            BR0: u1,
            ///  Port x Reset bit y
            BR1: u1,
            ///  Port x Reset bit y
            BR2: u1,
            ///  Port x Reset bit y
            BR3: u1,
            ///  Port x Reset bit y
            BR4: u1,
            ///  Port x Reset bit y
            BR5: u1,
            ///  Port x Reset bit y
            BR6: u1,
            ///  Port x Reset bit y
            BR7: u1,
            ///  Port x Reset bit y
            BR8: u1,
            ///  Port x Reset bit y
            BR9: u1,
            ///  Port x Reset bit y
            BR10: u1,
            ///  Port x Reset bit y
            BR11: u1,
            ///  Port x Reset bit y
            BR12: u1,
            ///  Port x Reset bit y
            BR13: u1,
            ///  Port x Reset bit y
            BR14: u1,
            ///  Port x Reset bit y
            BR15: u1,
            padding: u16,
        }),
    };

    ///  System control block ACTLR
    pub const SCB_ACTRL = extern struct {
        ///  Auxiliary control register
        ACTRL: mmio.Mmio(packed struct(u32) {
            ///  DISMCYCINT
            DISMCYCINT: u1,
            ///  DISDEFWBUF
            DISDEFWBUF: u1,
            ///  DISFOLD
            DISFOLD: u1,
            reserved8: u5,
            ///  DISFPCA
            DISFPCA: u1,
            ///  DISOOFP
            DISOOFP: u1,
            padding: u22,
        }),
    };

    ///  Floating point unit CPACR
    pub const FPU_CPACR = extern struct {
        ///  Coprocessor access control register
        CPACR: mmio.Mmio(packed struct(u32) {
            reserved20: u20,
            ///  CP
            CP: u4,
            padding: u8,
        }),
    };

    ///  Nested vectored interrupt controller
    pub const NVIC_STIR = extern struct {
        ///  Software trigger interrupt register
        STIR: mmio.Mmio(packed struct(u32) {
            ///  Software generated interrupt ID
            INTID: u9,
            padding: u23,
        }),
    };

    ///  System control block
    pub const SCB = extern struct {
        ///  CPUID base register
        CPUID: mmio.Mmio(packed struct(u32) {
            ///  Revision number
            Revision: u4,
            ///  Part number of the processor
            PartNo: u12,
            ///  Reads as 0xF
            Constant: u4,
            ///  Variant number
            Variant: u4,
            ///  Implementer code
            Implementer: u8,
        }),
        ///  Interrupt control and state register
        ICSR: mmio.Mmio(packed struct(u32) {
            ///  Active vector
            VECTACTIVE: u9,
            reserved11: u2,
            ///  Return to base level
            RETTOBASE: u1,
            ///  Pending vector
            VECTPENDING: u7,
            reserved22: u3,
            ///  Interrupt pending flag
            ISRPENDING: u1,
            reserved25: u2,
            ///  SysTick exception clear-pending bit
            PENDSTCLR: u1,
            ///  SysTick exception set-pending bit
            PENDSTSET: u1,
            ///  PendSV clear-pending bit
            PENDSVCLR: u1,
            ///  PendSV set-pending bit
            PENDSVSET: u1,
            reserved31: u2,
            ///  NMI set-pending bit.
            NMIPENDSET: u1,
        }),
        ///  Vector table offset register
        VTOR: mmio.Mmio(packed struct(u32) {
            reserved9: u9,
            ///  Vector table base offset field
            TBLOFF: u21,
            padding: u2,
        }),
        ///  Application interrupt and reset control register
        AIRCR: mmio.Mmio(packed struct(u32) {
            ///  VECTRESET
            VECTRESET: u1,
            ///  VECTCLRACTIVE
            VECTCLRACTIVE: u1,
            ///  SYSRESETREQ
            SYSRESETREQ: u1,
            reserved8: u5,
            ///  PRIGROUP
            PRIGROUP: u3,
            reserved15: u4,
            ///  ENDIANESS
            ENDIANESS: u1,
            ///  Register key
            VECTKEYSTAT: u16,
        }),
        ///  System control register
        SCR: mmio.Mmio(packed struct(u32) {
            reserved1: u1,
            ///  SLEEPONEXIT
            SLEEPONEXIT: u1,
            ///  SLEEPDEEP
            SLEEPDEEP: u1,
            reserved4: u1,
            ///  Send Event on Pending bit
            SEVEONPEND: u1,
            padding: u27,
        }),
        ///  Configuration and control register
        CCR: mmio.Mmio(packed struct(u32) {
            ///  Configures how the processor enters Thread mode
            NONBASETHRDENA: u1,
            ///  USERSETMPEND
            USERSETMPEND: u1,
            reserved3: u1,
            ///  UNALIGN_ TRP
            UNALIGN__TRP: u1,
            ///  DIV_0_TRP
            DIV_0_TRP: u1,
            reserved8: u3,
            ///  BFHFNMIGN
            BFHFNMIGN: u1,
            ///  STKALIGN
            STKALIGN: u1,
            padding: u22,
        }),
        ///  System handler priority registers
        SHPR1: mmio.Mmio(packed struct(u32) {
            ///  Priority of system handler 4
            PRI_4: u8,
            ///  Priority of system handler 5
            PRI_5: u8,
            ///  Priority of system handler 6
            PRI_6: u8,
            padding: u8,
        }),
        ///  System handler priority registers
        SHPR2: mmio.Mmio(packed struct(u32) {
            reserved24: u24,
            ///  Priority of system handler 11
            PRI_11: u8,
        }),
        ///  System handler priority registers
        SHPR3: mmio.Mmio(packed struct(u32) {
            reserved16: u16,
            ///  Priority of system handler 14
            PRI_14: u8,
            ///  Priority of system handler 15
            PRI_15: u8,
        }),
        ///  System handler control and state register
        SHCRS: mmio.Mmio(packed struct(u32) {
            ///  Memory management fault exception active bit
            MEMFAULTACT: u1,
            ///  Bus fault exception active bit
            BUSFAULTACT: u1,
            reserved3: u1,
            ///  Usage fault exception active bit
            USGFAULTACT: u1,
            reserved7: u3,
            ///  SVC call active bit
            SVCALLACT: u1,
            ///  Debug monitor active bit
            MONITORACT: u1,
            reserved10: u1,
            ///  PendSV exception active bit
            PENDSVACT: u1,
            ///  SysTick exception active bit
            SYSTICKACT: u1,
            ///  Usage fault exception pending bit
            USGFAULTPENDED: u1,
            ///  Memory management fault exception pending bit
            MEMFAULTPENDED: u1,
            ///  Bus fault exception pending bit
            BUSFAULTPENDED: u1,
            ///  SVC call pending bit
            SVCALLPENDED: u1,
            ///  Memory management fault enable bit
            MEMFAULTENA: u1,
            ///  Bus fault enable bit
            BUSFAULTENA: u1,
            ///  Usage fault enable bit
            USGFAULTENA: u1,
            padding: u13,
        }),
        ///  Configurable fault status register
        CFSR_UFSR_BFSR_MMFSR: mmio.Mmio(packed struct(u32) {
            reserved1: u1,
            ///  Instruction access violation flag
            IACCVIOL: u1,
            reserved3: u1,
            ///  Memory manager fault on unstacking for a return from exception
            MUNSTKERR: u1,
            ///  Memory manager fault on stacking for exception entry.
            MSTKERR: u1,
            ///  MLSPERR
            MLSPERR: u1,
            reserved7: u1,
            ///  Memory Management Fault Address Register (MMAR) valid flag
            MMARVALID: u1,
            ///  Instruction bus error
            IBUSERR: u1,
            ///  Precise data bus error
            PRECISERR: u1,
            ///  Imprecise data bus error
            IMPRECISERR: u1,
            ///  Bus fault on unstacking for a return from exception
            UNSTKERR: u1,
            ///  Bus fault on stacking for exception entry
            STKERR: u1,
            ///  Bus fault on floating-point lazy state preservation
            LSPERR: u1,
            reserved15: u1,
            ///  Bus Fault Address Register (BFAR) valid flag
            BFARVALID: u1,
            ///  Undefined instruction usage fault
            UNDEFINSTR: u1,
            ///  Invalid state usage fault
            INVSTATE: u1,
            ///  Invalid PC load usage fault
            INVPC: u1,
            ///  No coprocessor usage fault.
            NOCP: u1,
            reserved24: u4,
            ///  Unaligned access usage fault
            UNALIGNED: u1,
            ///  Divide by zero usage fault
            DIVBYZERO: u1,
            padding: u6,
        }),
        ///  Hard fault status register
        HFSR: mmio.Mmio(packed struct(u32) {
            reserved1: u1,
            ///  Vector table hard fault
            VECTTBL: u1,
            reserved30: u28,
            ///  Forced hard fault
            FORCED: u1,
            ///  Reserved for Debug use
            DEBUG_VT: u1,
        }),
        reserved52: [4]u8,
        ///  Memory management fault address register
        MMFAR: mmio.Mmio(packed struct(u32) {
            ///  Memory management fault address
            MMFAR: u32,
        }),
        ///  Bus fault address register
        BFAR: mmio.Mmio(packed struct(u32) {
            ///  Bus fault address
            BFAR: u32,
        }),
        ///  Auxiliary fault status register
        AFSR: mmio.Mmio(packed struct(u32) {
            ///  Implementation defined
            IMPDEF: u32,
        }),
    };

    ///  SysTick timer
    pub const STK = extern struct {
        ///  SysTick control and status register
        CTRL: mmio.Mmio(packed struct(u32) {
            ///  Counter enable
            ENABLE: u1,
            ///  SysTick exception request enable
            TICKINT: u1,
            ///  Clock source selection
            CLKSOURCE: u1,
            reserved16: u13,
            ///  COUNTFLAG
            COUNTFLAG: u1,
            padding: u15,
        }),
        ///  SysTick reload value register
        LOAD: mmio.Mmio(packed struct(u32) {
            ///  RELOAD value
            RELOAD: u24,
            padding: u8,
        }),
        ///  SysTick current value register
        VAL: mmio.Mmio(packed struct(u32) {
            ///  Current counter value
            CURRENT: u24,
            padding: u8,
        }),
        ///  SysTick calibration value register
        CALIB: mmio.Mmio(packed struct(u32) {
            ///  Calibration value
            TENMS: u24,
            reserved30: u6,
            ///  SKEW flag: Indicates whether the TENMS value is exact
            SKEW: u1,
            ///  NOREF flag. Reads as zero
            NOREF: u1,
        }),
    };

    ///  Memory protection unit
    pub const MPU = extern struct {
        ///  MPU type register
        MPU_TYPER: mmio.Mmio(packed struct(u32) {
            ///  Separate flag
            SEPARATE: u1,
            reserved8: u7,
            ///  Number of MPU data regions
            DREGION: u8,
            ///  Number of MPU instruction regions
            IREGION: u8,
            padding: u8,
        }),
        ///  MPU control register
        MPU_CTRL: mmio.Mmio(packed struct(u32) {
            ///  Enables the MPU
            ENABLE: u1,
            ///  Enables the operation of MPU during hard fault
            HFNMIENA: u1,
            ///  Enable priviliged software access to default memory map
            PRIVDEFENA: u1,
            padding: u29,
        }),
        ///  MPU region number register
        MPU_RNR: mmio.Mmio(packed struct(u32) {
            ///  MPU region
            REGION: u8,
            padding: u24,
        }),
        ///  MPU region base address register
        MPU_RBAR: mmio.Mmio(packed struct(u32) {
            ///  MPU region field
            REGION: u4,
            ///  MPU region number valid
            VALID: u1,
            ///  Region base address field
            ADDR: u27,
        }),
        ///  MPU region attribute and size register
        MPU_RASR: mmio.Mmio(packed struct(u32) {
            ///  Region enable bit.
            ENABLE: u1,
            ///  Size of the MPU protection region
            SIZE: u5,
            reserved8: u2,
            ///  Subregion disable bits
            SRD: u8,
            ///  memory attribute
            B: u1,
            ///  memory attribute
            C: u1,
            ///  Shareable memory attribute
            S: u1,
            ///  memory attribute
            TEX: u3,
            reserved24: u2,
            ///  Access permission
            AP: u3,
            reserved28: u1,
            ///  Instruction access disable bit
            XN: u1,
            padding: u3,
        }),
    };

    ///  Touch sensing controller
    pub const TSC = extern struct {
        ///  control register
        CR: mmio.Mmio(packed struct(u32) {
            ///  Touch sensing controller enable
            TSCE: u1,
            ///  Start a new acquisition
            START: u1,
            ///  Acquisition mode
            AM: u1,
            ///  Synchronization pin polarity
            SYNCPOL: u1,
            ///  I/O Default mode
            IODEF: u1,
            ///  Max count value
            MCV: u3,
            reserved12: u4,
            ///  pulse generator prescaler
            PGPSC: u3,
            ///  Spread spectrum prescaler
            SSPSC: u1,
            ///  Spread spectrum enable
            SSE: u1,
            ///  Spread spectrum deviation
            SSD: u7,
            ///  Charge transfer pulse low
            CTPL: u4,
            ///  Charge transfer pulse high
            CTPH: u4,
        }),
        ///  interrupt enable register
        IER: mmio.Mmio(packed struct(u32) {
            ///  End of acquisition interrupt enable
            EOAIE: u1,
            ///  Max count error interrupt enable
            MCEIE: u1,
            padding: u30,
        }),
        ///  interrupt clear register
        ICR: mmio.Mmio(packed struct(u32) {
            ///  End of acquisition interrupt clear
            EOAIC: u1,
            ///  Max count error interrupt clear
            MCEIC: u1,
            padding: u30,
        }),
        ///  interrupt status register
        ISR: mmio.Mmio(packed struct(u32) {
            ///  End of acquisition flag
            EOAF: u1,
            ///  Max count error flag
            MCEF: u1,
            padding: u30,
        }),
        ///  I/O hysteresis control register
        IOHCR: mmio.Mmio(packed struct(u32) {
            ///  G1_IO1 Schmitt trigger hysteresis mode
            G1_IO1: u1,
            ///  G1_IO2 Schmitt trigger hysteresis mode
            G1_IO2: u1,
            ///  G1_IO3 Schmitt trigger hysteresis mode
            G1_IO3: u1,
            ///  G1_IO4 Schmitt trigger hysteresis mode
            G1_IO4: u1,
            ///  G2_IO1 Schmitt trigger hysteresis mode
            G2_IO1: u1,
            ///  G2_IO2 Schmitt trigger hysteresis mode
            G2_IO2: u1,
            ///  G2_IO3 Schmitt trigger hysteresis mode
            G2_IO3: u1,
            ///  G2_IO4 Schmitt trigger hysteresis mode
            G2_IO4: u1,
            ///  G3_IO1 Schmitt trigger hysteresis mode
            G3_IO1: u1,
            ///  G3_IO2 Schmitt trigger hysteresis mode
            G3_IO2: u1,
            ///  G3_IO3 Schmitt trigger hysteresis mode
            G3_IO3: u1,
            ///  G3_IO4 Schmitt trigger hysteresis mode
            G3_IO4: u1,
            ///  G4_IO1 Schmitt trigger hysteresis mode
            G4_IO1: u1,
            ///  G4_IO2 Schmitt trigger hysteresis mode
            G4_IO2: u1,
            ///  G4_IO3 Schmitt trigger hysteresis mode
            G4_IO3: u1,
            ///  G4_IO4 Schmitt trigger hysteresis mode
            G4_IO4: u1,
            ///  G5_IO1 Schmitt trigger hysteresis mode
            G5_IO1: u1,
            ///  G5_IO2 Schmitt trigger hysteresis mode
            G5_IO2: u1,
            ///  G5_IO3 Schmitt trigger hysteresis mode
            G5_IO3: u1,
            ///  G5_IO4 Schmitt trigger hysteresis mode
            G5_IO4: u1,
            ///  G6_IO1 Schmitt trigger hysteresis mode
            G6_IO1: u1,
            ///  G6_IO2 Schmitt trigger hysteresis mode
            G6_IO2: u1,
            ///  G6_IO3 Schmitt trigger hysteresis mode
            G6_IO3: u1,
            ///  G6_IO4 Schmitt trigger hysteresis mode
            G6_IO4: u1,
            ///  G7_IO1 Schmitt trigger hysteresis mode
            G7_IO1: u1,
            ///  G7_IO2 Schmitt trigger hysteresis mode
            G7_IO2: u1,
            ///  G7_IO3 Schmitt trigger hysteresis mode
            G7_IO3: u1,
            ///  G7_IO4 Schmitt trigger hysteresis mode
            G7_IO4: u1,
            ///  G8_IO1 Schmitt trigger hysteresis mode
            G8_IO1: u1,
            ///  G8_IO2 Schmitt trigger hysteresis mode
            G8_IO2: u1,
            ///  G8_IO3 Schmitt trigger hysteresis mode
            G8_IO3: u1,
            ///  G8_IO4 Schmitt trigger hysteresis mode
            G8_IO4: u1,
        }),
        reserved24: [4]u8,
        ///  I/O analog switch control register
        IOASCR: mmio.Mmio(packed struct(u32) {
            ///  G1_IO1 analog switch enable
            G1_IO1: u1,
            ///  G1_IO2 analog switch enable
            G1_IO2: u1,
            ///  G1_IO3 analog switch enable
            G1_IO3: u1,
            ///  G1_IO4 analog switch enable
            G1_IO4: u1,
            ///  G2_IO1 analog switch enable
            G2_IO1: u1,
            ///  G2_IO2 analog switch enable
            G2_IO2: u1,
            ///  G2_IO3 analog switch enable
            G2_IO3: u1,
            ///  G2_IO4 analog switch enable
            G2_IO4: u1,
            ///  G3_IO1 analog switch enable
            G3_IO1: u1,
            ///  G3_IO2 analog switch enable
            G3_IO2: u1,
            ///  G3_IO3 analog switch enable
            G3_IO3: u1,
            ///  G3_IO4 analog switch enable
            G3_IO4: u1,
            ///  G4_IO1 analog switch enable
            G4_IO1: u1,
            ///  G4_IO2 analog switch enable
            G4_IO2: u1,
            ///  G4_IO3 analog switch enable
            G4_IO3: u1,
            ///  G4_IO4 analog switch enable
            G4_IO4: u1,
            ///  G5_IO1 analog switch enable
            G5_IO1: u1,
            ///  G5_IO2 analog switch enable
            G5_IO2: u1,
            ///  G5_IO3 analog switch enable
            G5_IO3: u1,
            ///  G5_IO4 analog switch enable
            G5_IO4: u1,
            ///  G6_IO1 analog switch enable
            G6_IO1: u1,
            ///  G6_IO2 analog switch enable
            G6_IO2: u1,
            ///  G6_IO3 analog switch enable
            G6_IO3: u1,
            ///  G6_IO4 analog switch enable
            G6_IO4: u1,
            ///  G7_IO1 analog switch enable
            G7_IO1: u1,
            ///  G7_IO2 analog switch enable
            G7_IO2: u1,
            ///  G7_IO3 analog switch enable
            G7_IO3: u1,
            ///  G7_IO4 analog switch enable
            G7_IO4: u1,
            ///  G8_IO1 analog switch enable
            G8_IO1: u1,
            ///  G8_IO2 analog switch enable
            G8_IO2: u1,
            ///  G8_IO3 analog switch enable
            G8_IO3: u1,
            ///  G8_IO4 analog switch enable
            G8_IO4: u1,
        }),
        reserved32: [4]u8,
        ///  I/O sampling control register
        IOSCR: mmio.Mmio(packed struct(u32) {
            ///  G1_IO1 sampling mode
            G1_IO1: u1,
            ///  G1_IO2 sampling mode
            G1_IO2: u1,
            ///  G1_IO3 sampling mode
            G1_IO3: u1,
            ///  G1_IO4 sampling mode
            G1_IO4: u1,
            ///  G2_IO1 sampling mode
            G2_IO1: u1,
            ///  G2_IO2 sampling mode
            G2_IO2: u1,
            ///  G2_IO3 sampling mode
            G2_IO3: u1,
            ///  G2_IO4 sampling mode
            G2_IO4: u1,
            ///  G3_IO1 sampling mode
            G3_IO1: u1,
            ///  G3_IO2 sampling mode
            G3_IO2: u1,
            ///  G3_IO3 sampling mode
            G3_IO3: u1,
            ///  G3_IO4 sampling mode
            G3_IO4: u1,
            ///  G4_IO1 sampling mode
            G4_IO1: u1,
            ///  G4_IO2 sampling mode
            G4_IO2: u1,
            ///  G4_IO3 sampling mode
            G4_IO3: u1,
            ///  G4_IO4 sampling mode
            G4_IO4: u1,
            ///  G5_IO1 sampling mode
            G5_IO1: u1,
            ///  G5_IO2 sampling mode
            G5_IO2: u1,
            ///  G5_IO3 sampling mode
            G5_IO3: u1,
            ///  G5_IO4 sampling mode
            G5_IO4: u1,
            ///  G6_IO1 sampling mode
            G6_IO1: u1,
            ///  G6_IO2 sampling mode
            G6_IO2: u1,
            ///  G6_IO3 sampling mode
            G6_IO3: u1,
            ///  G6_IO4 sampling mode
            G6_IO4: u1,
            ///  G7_IO1 sampling mode
            G7_IO1: u1,
            ///  G7_IO2 sampling mode
            G7_IO2: u1,
            ///  G7_IO3 sampling mode
            G7_IO3: u1,
            ///  G7_IO4 sampling mode
            G7_IO4: u1,
            ///  G8_IO1 sampling mode
            G8_IO1: u1,
            ///  G8_IO2 sampling mode
            G8_IO2: u1,
            ///  G8_IO3 sampling mode
            G8_IO3: u1,
            ///  G8_IO4 sampling mode
            G8_IO4: u1,
        }),
        reserved40: [4]u8,
        ///  I/O channel control register
        IOCCR: mmio.Mmio(packed struct(u32) {
            ///  G1_IO1 channel mode
            G1_IO1: u1,
            ///  G1_IO2 channel mode
            G1_IO2: u1,
            ///  G1_IO3 channel mode
            G1_IO3: u1,
            ///  G1_IO4 channel mode
            G1_IO4: u1,
            ///  G2_IO1 channel mode
            G2_IO1: u1,
            ///  G2_IO2 channel mode
            G2_IO2: u1,
            ///  G2_IO3 channel mode
            G2_IO3: u1,
            ///  G2_IO4 channel mode
            G2_IO4: u1,
            ///  G3_IO1 channel mode
            G3_IO1: u1,
            ///  G3_IO2 channel mode
            G3_IO2: u1,
            ///  G3_IO3 channel mode
            G3_IO3: u1,
            ///  G3_IO4 channel mode
            G3_IO4: u1,
            ///  G4_IO1 channel mode
            G4_IO1: u1,
            ///  G4_IO2 channel mode
            G4_IO2: u1,
            ///  G4_IO3 channel mode
            G4_IO3: u1,
            ///  G4_IO4 channel mode
            G4_IO4: u1,
            ///  G5_IO1 channel mode
            G5_IO1: u1,
            ///  G5_IO2 channel mode
            G5_IO2: u1,
            ///  G5_IO3 channel mode
            G5_IO3: u1,
            ///  G5_IO4 channel mode
            G5_IO4: u1,
            ///  G6_IO1 channel mode
            G6_IO1: u1,
            ///  G6_IO2 channel mode
            G6_IO2: u1,
            ///  G6_IO3 channel mode
            G6_IO3: u1,
            ///  G6_IO4 channel mode
            G6_IO4: u1,
            ///  G7_IO1 channel mode
            G7_IO1: u1,
            ///  G7_IO2 channel mode
            G7_IO2: u1,
            ///  G7_IO3 channel mode
            G7_IO3: u1,
            ///  G7_IO4 channel mode
            G7_IO4: u1,
            ///  G8_IO1 channel mode
            G8_IO1: u1,
            ///  G8_IO2 channel mode
            G8_IO2: u1,
            ///  G8_IO3 channel mode
            G8_IO3: u1,
            ///  G8_IO4 channel mode
            G8_IO4: u1,
        }),
        reserved48: [4]u8,
        ///  I/O group control status register
        IOGCSR: mmio.Mmio(packed struct(u32) {
            ///  Analog I/O group x enable
            G1E: u1,
            ///  Analog I/O group x enable
            G2E: u1,
            ///  Analog I/O group x enable
            G3E: u1,
            ///  Analog I/O group x enable
            G4E: u1,
            ///  Analog I/O group x enable
            G5E: u1,
            ///  Analog I/O group x enable
            G6E: u1,
            ///  Analog I/O group x enable
            G7E: u1,
            ///  Analog I/O group x enable
            G8E: u1,
            reserved16: u8,
            ///  Analog I/O group x status
            G1S: u1,
            ///  Analog I/O group x status
            G2S: u1,
            ///  Analog I/O group x status
            G3S: u1,
            ///  Analog I/O group x status
            G4S: u1,
            ///  Analog I/O group x status
            G5S: u1,
            ///  Analog I/O group x status
            G6S: u1,
            ///  Analog I/O group x status
            G7S: u1,
            ///  Analog I/O group x status
            G8S: u1,
            padding: u8,
        }),
        ///  I/O group x counter register
        IOG1CR: mmio.Mmio(packed struct(u32) {
            ///  Counter value
            CNT: u14,
            padding: u18,
        }),
        ///  I/O group x counter register
        IOG2CR: mmio.Mmio(packed struct(u32) {
            ///  Counter value
            CNT: u14,
            padding: u18,
        }),
        ///  I/O group x counter register
        IOG3CR: mmio.Mmio(packed struct(u32) {
            ///  Counter value
            CNT: u14,
            padding: u18,
        }),
        ///  I/O group x counter register
        IOG4CR: mmio.Mmio(packed struct(u32) {
            ///  Counter value
            CNT: u14,
            padding: u18,
        }),
        ///  I/O group x counter register
        IOG5CR: mmio.Mmio(packed struct(u32) {
            ///  Counter value
            CNT: u14,
            padding: u18,
        }),
        ///  I/O group x counter register
        IOG6CR: mmio.Mmio(packed struct(u32) {
            ///  Counter value
            CNT: u14,
            padding: u18,
        }),
        ///  I/O group x counter register
        IOG7CR: mmio.Mmio(packed struct(u32) {
            ///  Counter value
            CNT: u14,
            padding: u18,
        }),
        ///  I/O group x counter register
        IOG8CR: mmio.Mmio(packed struct(u32) {
            ///  Counter value
            CNT: u14,
            padding: u18,
        }),
    };

    ///  cyclic redundancy check calculation unit
    pub const CRC = extern struct {
        ///  Data register
        DR: mmio.Mmio(packed struct(u32) {
            ///  Data register bits
            DR: u32,
        }),
        ///  Independent data register
        IDR: mmio.Mmio(packed struct(u32) {
            ///  General-purpose 8-bit data register bits
            IDR: u8,
            padding: u24,
        }),
        ///  Control register
        CR: mmio.Mmio(packed struct(u32) {
            ///  reset bit
            RESET: u1,
            reserved3: u2,
            ///  Polynomial size
            POLYSIZE: u2,
            ///  Reverse input data
            REV_IN: u2,
            ///  Reverse output data
            REV_OUT: u1,
            padding: u24,
        }),
        reserved16: [4]u8,
        ///  Initial CRC value
        INIT: mmio.Mmio(packed struct(u32) {
            ///  Programmable initial CRC value
            INIT: u32,
        }),
        ///  CRC polynomial
        POL: mmio.Mmio(packed struct(u32) {
            ///  Programmable polynomial
            POL: u32,
        }),
    };

    ///  Flash
    pub const Flash = extern struct {
        ///  Flash access control register
        ACR: mmio.Mmio(packed struct(u32) {
            ///  LATENCY
            LATENCY: u3,
            reserved4: u1,
            ///  PRFTBE
            PRFTBE: u1,
            ///  PRFTBS
            PRFTBS: u1,
            padding: u26,
        }),
        ///  Flash key register
        KEYR: mmio.Mmio(packed struct(u32) {
            ///  Flash Key
            FKEYR: u32,
        }),
        ///  Flash option key register
        OPTKEYR: mmio.Mmio(packed struct(u32) {
            ///  Option byte key
            OPTKEYR: u32,
        }),
        ///  Flash status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Busy
            BSY: u1,
            reserved2: u1,
            ///  Programming error
            PGERR: u1,
            reserved4: u1,
            ///  Write protection error
            WRPRT: u1,
            ///  End of operation
            EOP: u1,
            padding: u26,
        }),
        ///  Flash control register
        CR: mmio.Mmio(packed struct(u32) {
            ///  Programming
            PG: u1,
            ///  Page erase
            PER: u1,
            ///  Mass erase
            MER: u1,
            reserved4: u1,
            ///  Option byte programming
            OPTPG: u1,
            ///  Option byte erase
            OPTER: u1,
            ///  Start
            STRT: u1,
            ///  Lock
            LOCK: u1,
            reserved9: u1,
            ///  Option bytes write enable
            OPTWRE: u1,
            ///  Error interrupt enable
            ERRIE: u1,
            reserved12: u1,
            ///  End of operation interrupt enable
            EOPIE: u1,
            ///  Force option byte loading
            FORCE_OPTLOAD: u1,
            padding: u18,
        }),
        ///  Flash address register
        AR: mmio.Mmio(packed struct(u32) {
            ///  Flash address
            FAR: u32,
        }),
        reserved28: [4]u8,
        ///  Option byte register
        OBR: mmio.Mmio(packed struct(u32) {
            ///  Option byte error
            OPTERR: u1,
            ///  Level 1 protection status
            LEVEL1_PROT: u1,
            ///  Level 2 protection status
            LEVEL2_PROT: u1,
            reserved8: u5,
            ///  WDG_SW
            WDG_SW: u1,
            ///  nRST_STOP
            nRST_STOP: u1,
            ///  nRST_STDBY
            nRST_STDBY: u1,
            reserved12: u1,
            ///  BOOT1
            BOOT1: u1,
            ///  VDDA_MONITOR
            VDDA_MONITOR: u1,
            ///  SRAM_PARITY_CHECK
            SRAM_PARITY_CHECK: u1,
            reserved16: u1,
            ///  Data0
            Data0: u8,
            ///  Data1
            Data1: u8,
        }),
        ///  Write protection register
        WRPR: mmio.Mmio(packed struct(u32) {
            ///  Write protect
            WRP: u32,
        }),
    };

    ///  Reset and clock control
    pub const RCC = extern struct {
        ///  Clock control register
        CR: mmio.Mmio(packed struct(u32) {
            ///  Internal High Speed clock enable
            HSION: u1,
            ///  Internal High Speed clock ready flag
            HSIRDY: u1,
            reserved3: u1,
            ///  Internal High Speed clock trimming
            HSITRIM: u5,
            ///  Internal High Speed clock Calibration
            HSICAL: u8,
            ///  External High Speed clock enable
            HSEON: u1,
            ///  External High Speed clock ready flag
            HSERDY: u1,
            ///  External High Speed clock Bypass
            HSEBYP: u1,
            ///  Clock Security System enable
            CSSON: u1,
            reserved24: u4,
            ///  PLL enable
            PLLON: u1,
            ///  PLL clock ready flag
            PLLRDY: u1,
            padding: u6,
        }),
        ///  Clock configuration register (RCC_CFGR)
        CFGR: mmio.Mmio(packed struct(u32) {
            ///  System clock Switch
            SW: u2,
            ///  System Clock Switch Status
            SWS: u2,
            ///  AHB prescaler
            HPRE: u4,
            ///  APB Low speed prescaler (APB1)
            PPRE1: u3,
            ///  APB high speed prescaler (APB2)
            PPRE2: u3,
            reserved15: u1,
            ///  PLL entry clock source
            PLLSRC: u2,
            ///  HSE divider for PLL entry
            PLLXTPRE: u1,
            ///  PLL Multiplication Factor
            PLLMUL: u4,
            ///  USB prescaler
            USBPRES: u1,
            ///  I2S external clock source selection
            I2SSRC: u1,
            ///  Microcontroller clock output
            MCO: u3,
            reserved28: u1,
            ///  Microcontroller Clock Output Flag
            MCOF: u1,
            padding: u3,
        }),
        ///  Clock interrupt register (RCC_CIR)
        CIR: mmio.Mmio(packed struct(u32) {
            ///  LSI Ready Interrupt flag
            LSIRDYF: u1,
            ///  LSE Ready Interrupt flag
            LSERDYF: u1,
            ///  HSI Ready Interrupt flag
            HSIRDYF: u1,
            ///  HSE Ready Interrupt flag
            HSERDYF: u1,
            ///  PLL Ready Interrupt flag
            PLLRDYF: u1,
            reserved7: u2,
            ///  Clock Security System Interrupt flag
            CSSF: u1,
            ///  LSI Ready Interrupt Enable
            LSIRDYIE: u1,
            ///  LSE Ready Interrupt Enable
            LSERDYIE: u1,
            ///  HSI Ready Interrupt Enable
            HSIRDYIE: u1,
            ///  HSE Ready Interrupt Enable
            HSERDYIE: u1,
            ///  PLL Ready Interrupt Enable
            PLLRDYIE: u1,
            reserved16: u3,
            ///  LSI Ready Interrupt Clear
            LSIRDYC: u1,
            ///  LSE Ready Interrupt Clear
            LSERDYC: u1,
            ///  HSI Ready Interrupt Clear
            HSIRDYC: u1,
            ///  HSE Ready Interrupt Clear
            HSERDYC: u1,
            ///  PLL Ready Interrupt Clear
            PLLRDYC: u1,
            reserved23: u2,
            ///  Clock security system interrupt clear
            CSSC: u1,
            padding: u8,
        }),
        ///  APB2 peripheral reset register (RCC_APB2RSTR)
        APB2RSTR: mmio.Mmio(packed struct(u32) {
            ///  SYSCFG and COMP reset
            SYSCFGRST: u1,
            reserved11: u10,
            ///  TIM1 timer reset
            TIM1RST: u1,
            ///  SPI 1 reset
            SPI1RST: u1,
            ///  TIM8 timer reset
            TIM8RST: u1,
            ///  USART1 reset
            USART1RST: u1,
            reserved16: u1,
            ///  TIM15 timer reset
            TIM15RST: u1,
            ///  TIM16 timer reset
            TIM16RST: u1,
            ///  TIM17 timer reset
            TIM17RST: u1,
            padding: u13,
        }),
        ///  APB1 peripheral reset register (RCC_APB1RSTR)
        APB1RSTR: mmio.Mmio(packed struct(u32) {
            ///  Timer 2 reset
            TIM2RST: u1,
            ///  Timer 3 reset
            TIM3RST: u1,
            ///  Timer 14 reset
            TIM4RST: u1,
            reserved4: u1,
            ///  Timer 6 reset
            TIM6RST: u1,
            ///  Timer 7 reset
            TIM7RST: u1,
            reserved11: u5,
            ///  Window watchdog reset
            WWDGRST: u1,
            reserved14: u2,
            ///  SPI2 reset
            SPI2RST: u1,
            ///  SPI3 reset
            SPI3RST: u1,
            reserved17: u1,
            ///  USART 2 reset
            USART2RST: u1,
            ///  USART3 reset
            USART3RST: u1,
            ///  UART 4 reset
            UART4RST: u1,
            ///  UART 5 reset
            UART5RST: u1,
            ///  I2C1 reset
            I2C1RST: u1,
            ///  I2C2 reset
            I2C2RST: u1,
            ///  USB reset
            USBRST: u1,
            reserved25: u1,
            ///  CAN reset
            CANRST: u1,
            reserved28: u2,
            ///  Power interface reset
            PWRRST: u1,
            ///  DAC interface reset
            DACRST: u1,
            ///  I2C3 reset
            I2C3RST: u1,
            padding: u1,
        }),
        ///  AHB Peripheral Clock enable register (RCC_AHBENR)
        AHBENR: mmio.Mmio(packed struct(u32) {
            ///  DMA1 clock enable
            DMAEN: u1,
            ///  DMA2 clock enable
            DMA2EN: u1,
            ///  SRAM interface clock enable
            SRAMEN: u1,
            reserved4: u1,
            ///  FLITF clock enable
            FLITFEN: u1,
            ///  FMC clock enable
            FMCEN: u1,
            ///  CRC clock enable
            CRCEN: u1,
            reserved16: u9,
            ///  IO port H clock enable
            IOPHEN: u1,
            ///  I/O port A clock enable
            IOPAEN: u1,
            ///  I/O port B clock enable
            IOPBEN: u1,
            ///  I/O port C clock enable
            IOPCEN: u1,
            ///  I/O port D clock enable
            IOPDEN: u1,
            ///  I/O port E clock enable
            IOPEEN: u1,
            ///  I/O port F clock enable
            IOPFEN: u1,
            ///  I/O port G clock enable
            IOPGEN: u1,
            ///  Touch sensing controller clock enable
            TSCEN: u1,
            reserved28: u3,
            ///  ADC1 and ADC2 clock enable
            ADC12EN: u1,
            ///  ADC3 and ADC4 clock enable
            ADC34EN: u1,
            padding: u2,
        }),
        ///  APB2 peripheral clock enable register (RCC_APB2ENR)
        APB2ENR: mmio.Mmio(packed struct(u32) {
            ///  SYSCFG clock enable
            SYSCFGEN: u1,
            reserved11: u10,
            ///  TIM1 Timer clock enable
            TIM1EN: u1,
            ///  SPI 1 clock enable
            SPI1EN: u1,
            ///  TIM8 Timer clock enable
            TIM8EN: u1,
            ///  USART1 clock enable
            USART1EN: u1,
            reserved16: u1,
            ///  TIM15 timer clock enable
            TIM15EN: u1,
            ///  TIM16 timer clock enable
            TIM16EN: u1,
            ///  TIM17 timer clock enable
            TIM17EN: u1,
            padding: u13,
        }),
        ///  APB1 peripheral clock enable register (RCC_APB1ENR)
        APB1ENR: mmio.Mmio(packed struct(u32) {
            ///  Timer 2 clock enable
            TIM2EN: u1,
            ///  Timer 3 clock enable
            TIM3EN: u1,
            ///  Timer 4 clock enable
            TIM4EN: u1,
            reserved4: u1,
            ///  Timer 6 clock enable
            TIM6EN: u1,
            ///  Timer 7 clock enable
            TIM7EN: u1,
            reserved11: u5,
            ///  Window watchdog clock enable
            WWDGEN: u1,
            reserved14: u2,
            ///  SPI 2 clock enable
            SPI2EN: u1,
            ///  SPI 3 clock enable
            SPI3EN: u1,
            reserved17: u1,
            ///  USART 2 clock enable
            USART2EN: u1,
            ///  USART 3 clock enable
            USART3EN: u1,
            ///  USART 4 clock enable
            USART4EN: u1,
            ///  USART 5 clock enable
            USART5EN: u1,
            ///  I2C 1 clock enable
            I2C1EN: u1,
            ///  I2C 2 clock enable
            I2C2EN: u1,
            ///  USB clock enable
            USBEN: u1,
            reserved25: u1,
            ///  CAN clock enable
            CANEN: u1,
            ///  DAC2 interface clock enable
            DAC2EN: u1,
            reserved28: u1,
            ///  Power interface clock enable
            PWREN: u1,
            ///  DAC interface clock enable
            DACEN: u1,
            ///  I2C3 clock enable
            I2C3EN: u1,
            padding: u1,
        }),
        ///  Backup domain control register (RCC_BDCR)
        BDCR: mmio.Mmio(packed struct(u32) {
            ///  External Low Speed oscillator enable
            LSEON: u1,
            ///  External Low Speed oscillator ready
            LSERDY: u1,
            ///  External Low Speed oscillator bypass
            LSEBYP: u1,
            ///  LSE oscillator drive capability
            LSEDRV: u2,
            reserved8: u3,
            ///  RTC clock source selection
            RTCSEL: u2,
            reserved15: u5,
            ///  RTC clock enable
            RTCEN: u1,
            ///  Backup domain software reset
            BDRST: u1,
            padding: u15,
        }),
        ///  Control/status register (RCC_CSR)
        CSR: mmio.Mmio(packed struct(u32) {
            ///  Internal low speed oscillator enable
            LSION: u1,
            ///  Internal low speed oscillator ready
            LSIRDY: u1,
            reserved24: u22,
            ///  Remove reset flag
            RMVF: u1,
            ///  Option byte loader reset flag
            OBLRSTF: u1,
            ///  PIN reset flag
            PINRSTF: u1,
            ///  POR/PDR reset flag
            PORRSTF: u1,
            ///  Software reset flag
            SFTRSTF: u1,
            ///  Independent watchdog reset flag
            IWDGRSTF: u1,
            ///  Window watchdog reset flag
            WWDGRSTF: u1,
            ///  Low-power reset flag
            LPWRRSTF: u1,
        }),
        ///  AHB peripheral reset register
        AHBRSTR: mmio.Mmio(packed struct(u32) {
            reserved5: u5,
            ///  FMC reset
            FMCRST: u1,
            reserved16: u10,
            ///  I/O port H reset
            IOPHRST: u1,
            ///  I/O port A reset
            IOPARST: u1,
            ///  I/O port B reset
            IOPBRST: u1,
            ///  I/O port C reset
            IOPCRST: u1,
            ///  I/O port D reset
            IOPDRST: u1,
            ///  I/O port E reset
            IOPERST: u1,
            ///  I/O port F reset
            IOPFRST: u1,
            ///  Touch sensing controller reset
            IOPGRST: u1,
            ///  Touch sensing controller reset
            TSCRST: u1,
            reserved28: u3,
            ///  ADC1 and ADC2 reset
            ADC12RST: u1,
            ///  ADC3 and ADC4 reset
            ADC34RST: u1,
            padding: u2,
        }),
        ///  Clock configuration register 2
        CFGR2: mmio.Mmio(packed struct(u32) {
            ///  PREDIV division factor
            PREDIV: u4,
            ///  ADC1 and ADC2 prescaler
            ADC12PRES: u5,
            ///  ADC3 and ADC4 prescaler
            ADC34PRES: u5,
            padding: u18,
        }),
        ///  Clock configuration register 3
        CFGR3: mmio.Mmio(packed struct(u32) {
            ///  USART1 clock source selection
            USART1SW: u2,
            reserved4: u2,
            ///  I2C1 clock source selection
            I2C1SW: u1,
            ///  I2C2 clock source selection
            I2C2SW: u1,
            ///  I2C3 clock source selection
            I2C3SW: u1,
            reserved8: u1,
            ///  Timer1 clock source selection
            TIM1SW: u1,
            ///  Timer8 clock source selection
            TIM8SW: u1,
            reserved16: u6,
            ///  USART2 clock source selection
            USART2SW: u2,
            ///  USART3 clock source selection
            USART3SW: u2,
            ///  UART4 clock source selection
            UART4SW: u2,
            ///  UART5 clock source selection
            UART5SW: u2,
            padding: u8,
        }),
    };

    ///  DMA controller 1
    pub const DMA1 = extern struct {
        ///  DMA interrupt status register (DMA_ISR)
        ISR: mmio.Mmio(packed struct(u32) {
            ///  Channel 1 Global interrupt flag
            GIF1: u1,
            ///  Channel 1 Transfer Complete flag
            TCIF1: u1,
            ///  Channel 1 Half Transfer Complete flag
            HTIF1: u1,
            ///  Channel 1 Transfer Error flag
            TEIF1: u1,
            ///  Channel 2 Global interrupt flag
            GIF2: u1,
            ///  Channel 2 Transfer Complete flag
            TCIF2: u1,
            ///  Channel 2 Half Transfer Complete flag
            HTIF2: u1,
            ///  Channel 2 Transfer Error flag
            TEIF2: u1,
            ///  Channel 3 Global interrupt flag
            GIF3: u1,
            ///  Channel 3 Transfer Complete flag
            TCIF3: u1,
            ///  Channel 3 Half Transfer Complete flag
            HTIF3: u1,
            ///  Channel 3 Transfer Error flag
            TEIF3: u1,
            ///  Channel 4 Global interrupt flag
            GIF4: u1,
            ///  Channel 4 Transfer Complete flag
            TCIF4: u1,
            ///  Channel 4 Half Transfer Complete flag
            HTIF4: u1,
            ///  Channel 4 Transfer Error flag
            TEIF4: u1,
            ///  Channel 5 Global interrupt flag
            GIF5: u1,
            ///  Channel 5 Transfer Complete flag
            TCIF5: u1,
            ///  Channel 5 Half Transfer Complete flag
            HTIF5: u1,
            ///  Channel 5 Transfer Error flag
            TEIF5: u1,
            ///  Channel 6 Global interrupt flag
            GIF6: u1,
            ///  Channel 6 Transfer Complete flag
            TCIF6: u1,
            ///  Channel 6 Half Transfer Complete flag
            HTIF6: u1,
            ///  Channel 6 Transfer Error flag
            TEIF6: u1,
            ///  Channel 7 Global interrupt flag
            GIF7: u1,
            ///  Channel 7 Transfer Complete flag
            TCIF7: u1,
            ///  Channel 7 Half Transfer Complete flag
            HTIF7: u1,
            ///  Channel 7 Transfer Error flag
            TEIF7: u1,
            padding: u4,
        }),
        ///  DMA interrupt flag clear register (DMA_IFCR)
        IFCR: mmio.Mmio(packed struct(u32) {
            ///  Channel 1 Global interrupt clear
            CGIF1: u1,
            ///  Channel 1 Transfer Complete clear
            CTCIF1: u1,
            ///  Channel 1 Half Transfer clear
            CHTIF1: u1,
            ///  Channel 1 Transfer Error clear
            CTEIF1: u1,
            ///  Channel 2 Global interrupt clear
            CGIF2: u1,
            ///  Channel 2 Transfer Complete clear
            CTCIF2: u1,
            ///  Channel 2 Half Transfer clear
            CHTIF2: u1,
            ///  Channel 2 Transfer Error clear
            CTEIF2: u1,
            ///  Channel 3 Global interrupt clear
            CGIF3: u1,
            ///  Channel 3 Transfer Complete clear
            CTCIF3: u1,
            ///  Channel 3 Half Transfer clear
            CHTIF3: u1,
            ///  Channel 3 Transfer Error clear
            CTEIF3: u1,
            ///  Channel 4 Global interrupt clear
            CGIF4: u1,
            ///  Channel 4 Transfer Complete clear
            CTCIF4: u1,
            ///  Channel 4 Half Transfer clear
            CHTIF4: u1,
            ///  Channel 4 Transfer Error clear
            CTEIF4: u1,
            ///  Channel 5 Global interrupt clear
            CGIF5: u1,
            ///  Channel 5 Transfer Complete clear
            CTCIF5: u1,
            ///  Channel 5 Half Transfer clear
            CHTIF5: u1,
            ///  Channel 5 Transfer Error clear
            CTEIF5: u1,
            ///  Channel 6 Global interrupt clear
            CGIF6: u1,
            ///  Channel 6 Transfer Complete clear
            CTCIF6: u1,
            ///  Channel 6 Half Transfer clear
            CHTIF6: u1,
            ///  Channel 6 Transfer Error clear
            CTEIF6: u1,
            ///  Channel 7 Global interrupt clear
            CGIF7: u1,
            ///  Channel 7 Transfer Complete clear
            CTCIF7: u1,
            ///  Channel 7 Half Transfer clear
            CHTIF7: u1,
            ///  Channel 7 Transfer Error clear
            CTEIF7: u1,
            padding: u4,
        }),
        ///  DMA channel configuration register (DMA_CCR)
        CCR1: mmio.Mmio(packed struct(u32) {
            ///  Channel enable
            EN: u1,
            ///  Transfer complete interrupt enable
            TCIE: u1,
            ///  Half Transfer interrupt enable
            HTIE: u1,
            ///  Transfer error interrupt enable
            TEIE: u1,
            ///  Data transfer direction
            DIR: u1,
            ///  Circular mode
            CIRC: u1,
            ///  Peripheral increment mode
            PINC: u1,
            ///  Memory increment mode
            MINC: u1,
            ///  Peripheral size
            PSIZE: u2,
            ///  Memory size
            MSIZE: u2,
            ///  Channel Priority level
            PL: u2,
            ///  Memory to memory mode
            MEM2MEM: u1,
            padding: u17,
        }),
        ///  DMA channel 1 number of data register
        CNDTR1: mmio.Mmio(packed struct(u32) {
            ///  Number of data to transfer
            NDT: u16,
            padding: u16,
        }),
        ///  DMA channel 1 peripheral address register
        CPAR1: mmio.Mmio(packed struct(u32) {
            ///  Peripheral address
            PA: u32,
        }),
        ///  DMA channel 1 memory address register
        CMAR1: mmio.Mmio(packed struct(u32) {
            ///  Memory address
            MA: u32,
        }),
        reserved28: [4]u8,
        ///  DMA channel configuration register (DMA_CCR)
        CCR2: mmio.Mmio(packed struct(u32) {
            ///  Channel enable
            EN: u1,
            ///  Transfer complete interrupt enable
            TCIE: u1,
            ///  Half Transfer interrupt enable
            HTIE: u1,
            ///  Transfer error interrupt enable
            TEIE: u1,
            ///  Data transfer direction
            DIR: u1,
            ///  Circular mode
            CIRC: u1,
            ///  Peripheral increment mode
            PINC: u1,
            ///  Memory increment mode
            MINC: u1,
            ///  Peripheral size
            PSIZE: u2,
            ///  Memory size
            MSIZE: u2,
            ///  Channel Priority level
            PL: u2,
            ///  Memory to memory mode
            MEM2MEM: u1,
            padding: u17,
        }),
        ///  DMA channel 2 number of data register
        CNDTR2: mmio.Mmio(packed struct(u32) {
            ///  Number of data to transfer
            NDT: u16,
            padding: u16,
        }),
        ///  DMA channel 2 peripheral address register
        CPAR2: mmio.Mmio(packed struct(u32) {
            ///  Peripheral address
            PA: u32,
        }),
        ///  DMA channel 2 memory address register
        CMAR2: mmio.Mmio(packed struct(u32) {
            ///  Memory address
            MA: u32,
        }),
        reserved48: [4]u8,
        ///  DMA channel configuration register (DMA_CCR)
        CCR3: mmio.Mmio(packed struct(u32) {
            ///  Channel enable
            EN: u1,
            ///  Transfer complete interrupt enable
            TCIE: u1,
            ///  Half Transfer interrupt enable
            HTIE: u1,
            ///  Transfer error interrupt enable
            TEIE: u1,
            ///  Data transfer direction
            DIR: u1,
            ///  Circular mode
            CIRC: u1,
            ///  Peripheral increment mode
            PINC: u1,
            ///  Memory increment mode
            MINC: u1,
            ///  Peripheral size
            PSIZE: u2,
            ///  Memory size
            MSIZE: u2,
            ///  Channel Priority level
            PL: u2,
            ///  Memory to memory mode
            MEM2MEM: u1,
            padding: u17,
        }),
        ///  DMA channel 3 number of data register
        CNDTR3: mmio.Mmio(packed struct(u32) {
            ///  Number of data to transfer
            NDT: u16,
            padding: u16,
        }),
        ///  DMA channel 3 peripheral address register
        CPAR3: mmio.Mmio(packed struct(u32) {
            ///  Peripheral address
            PA: u32,
        }),
        ///  DMA channel 3 memory address register
        CMAR3: mmio.Mmio(packed struct(u32) {
            ///  Memory address
            MA: u32,
        }),
        reserved68: [4]u8,
        ///  DMA channel configuration register (DMA_CCR)
        CCR4: mmio.Mmio(packed struct(u32) {
            ///  Channel enable
            EN: u1,
            ///  Transfer complete interrupt enable
            TCIE: u1,
            ///  Half Transfer interrupt enable
            HTIE: u1,
            ///  Transfer error interrupt enable
            TEIE: u1,
            ///  Data transfer direction
            DIR: u1,
            ///  Circular mode
            CIRC: u1,
            ///  Peripheral increment mode
            PINC: u1,
            ///  Memory increment mode
            MINC: u1,
            ///  Peripheral size
            PSIZE: u2,
            ///  Memory size
            MSIZE: u2,
            ///  Channel Priority level
            PL: u2,
            ///  Memory to memory mode
            MEM2MEM: u1,
            padding: u17,
        }),
        ///  DMA channel 4 number of data register
        CNDTR4: mmio.Mmio(packed struct(u32) {
            ///  Number of data to transfer
            NDT: u16,
            padding: u16,
        }),
        ///  DMA channel 4 peripheral address register
        CPAR4: mmio.Mmio(packed struct(u32) {
            ///  Peripheral address
            PA: u32,
        }),
        ///  DMA channel 4 memory address register
        CMAR4: mmio.Mmio(packed struct(u32) {
            ///  Memory address
            MA: u32,
        }),
        reserved88: [4]u8,
        ///  DMA channel configuration register (DMA_CCR)
        CCR5: mmio.Mmio(packed struct(u32) {
            ///  Channel enable
            EN: u1,
            ///  Transfer complete interrupt enable
            TCIE: u1,
            ///  Half Transfer interrupt enable
            HTIE: u1,
            ///  Transfer error interrupt enable
            TEIE: u1,
            ///  Data transfer direction
            DIR: u1,
            ///  Circular mode
            CIRC: u1,
            ///  Peripheral increment mode
            PINC: u1,
            ///  Memory increment mode
            MINC: u1,
            ///  Peripheral size
            PSIZE: u2,
            ///  Memory size
            MSIZE: u2,
            ///  Channel Priority level
            PL: u2,
            ///  Memory to memory mode
            MEM2MEM: u1,
            padding: u17,
        }),
        ///  DMA channel 5 number of data register
        CNDTR5: mmio.Mmio(packed struct(u32) {
            ///  Number of data to transfer
            NDT: u16,
            padding: u16,
        }),
        ///  DMA channel 5 peripheral address register
        CPAR5: mmio.Mmio(packed struct(u32) {
            ///  Peripheral address
            PA: u32,
        }),
        ///  DMA channel 5 memory address register
        CMAR5: mmio.Mmio(packed struct(u32) {
            ///  Memory address
            MA: u32,
        }),
        reserved108: [4]u8,
        ///  DMA channel configuration register (DMA_CCR)
        CCR6: mmio.Mmio(packed struct(u32) {
            ///  Channel enable
            EN: u1,
            ///  Transfer complete interrupt enable
            TCIE: u1,
            ///  Half Transfer interrupt enable
            HTIE: u1,
            ///  Transfer error interrupt enable
            TEIE: u1,
            ///  Data transfer direction
            DIR: u1,
            ///  Circular mode
            CIRC: u1,
            ///  Peripheral increment mode
            PINC: u1,
            ///  Memory increment mode
            MINC: u1,
            ///  Peripheral size
            PSIZE: u2,
            ///  Memory size
            MSIZE: u2,
            ///  Channel Priority level
            PL: u2,
            ///  Memory to memory mode
            MEM2MEM: u1,
            padding: u17,
        }),
        ///  DMA channel 6 number of data register
        CNDTR6: mmio.Mmio(packed struct(u32) {
            ///  Number of data to transfer
            NDT: u16,
            padding: u16,
        }),
        ///  DMA channel 6 peripheral address register
        CPAR6: mmio.Mmio(packed struct(u32) {
            ///  Peripheral address
            PA: u32,
        }),
        ///  DMA channel 6 memory address register
        CMAR6: mmio.Mmio(packed struct(u32) {
            ///  Memory address
            MA: u32,
        }),
        reserved128: [4]u8,
        ///  DMA channel configuration register (DMA_CCR)
        CCR7: mmio.Mmio(packed struct(u32) {
            ///  Channel enable
            EN: u1,
            ///  Transfer complete interrupt enable
            TCIE: u1,
            ///  Half Transfer interrupt enable
            HTIE: u1,
            ///  Transfer error interrupt enable
            TEIE: u1,
            ///  Data transfer direction
            DIR: u1,
            ///  Circular mode
            CIRC: u1,
            ///  Peripheral increment mode
            PINC: u1,
            ///  Memory increment mode
            MINC: u1,
            ///  Peripheral size
            PSIZE: u2,
            ///  Memory size
            MSIZE: u2,
            ///  Channel Priority level
            PL: u2,
            ///  Memory to memory mode
            MEM2MEM: u1,
            padding: u17,
        }),
        ///  DMA channel 7 number of data register
        CNDTR7: mmio.Mmio(packed struct(u32) {
            ///  Number of data to transfer
            NDT: u16,
            padding: u16,
        }),
        ///  DMA channel 7 peripheral address register
        CPAR7: mmio.Mmio(packed struct(u32) {
            ///  Peripheral address
            PA: u32,
        }),
        ///  DMA channel 7 memory address register
        CMAR7: mmio.Mmio(packed struct(u32) {
            ///  Memory address
            MA: u32,
        }),
    };

    ///  Floting point unit
    pub const FPU = extern struct {
        ///  Floating-point context control register
        FPCCR: mmio.Mmio(packed struct(u32) {
            ///  LSPACT
            LSPACT: u1,
            ///  USER
            USER: u1,
            reserved3: u1,
            ///  THREAD
            THREAD: u1,
            ///  HFRDY
            HFRDY: u1,
            ///  MMRDY
            MMRDY: u1,
            ///  BFRDY
            BFRDY: u1,
            reserved8: u1,
            ///  MONRDY
            MONRDY: u1,
            reserved30: u21,
            ///  LSPEN
            LSPEN: u1,
            ///  ASPEN
            ASPEN: u1,
        }),
        ///  Floating-point context address register
        FPCAR: mmio.Mmio(packed struct(u32) {
            reserved3: u3,
            ///  Location of unpopulated floating-point
            ADDRESS: u29,
        }),
        ///  Floating-point status control register
        FPSCR: mmio.Mmio(packed struct(u32) {
            ///  Invalid operation cumulative exception bit
            IOC: u1,
            ///  Division by zero cumulative exception bit.
            DZC: u1,
            ///  Overflow cumulative exception bit
            OFC: u1,
            ///  Underflow cumulative exception bit
            UFC: u1,
            ///  Inexact cumulative exception bit
            IXC: u1,
            reserved7: u2,
            ///  Input denormal cumulative exception bit.
            IDC: u1,
            reserved22: u14,
            ///  Rounding Mode control field
            RMode: u2,
            ///  Flush-to-zero mode control bit:
            FZ: u1,
            ///  Default NaN mode control bit
            DN: u1,
            ///  Alternative half-precision control bit
            AHP: u1,
            reserved28: u1,
            ///  Overflow condition code flag
            V: u1,
            ///  Carry condition code flag
            C: u1,
            ///  Zero condition code flag
            Z: u1,
            ///  Negative condition code flag
            N: u1,
        }),
    };

    ///  General purpose timer
    pub const TIM2 = extern struct {
        ///  control register 1
        CR1: mmio.Mmio(packed struct(u32) {
            ///  Counter enable
            CEN: u1,
            ///  Update disable
            UDIS: u1,
            ///  Update request source
            URS: u1,
            ///  One-pulse mode
            OPM: u1,
            ///  Direction
            DIR: u1,
            ///  Center-aligned mode selection
            CMS: u2,
            ///  Auto-reload preload enable
            ARPE: u1,
            ///  Clock division
            CKD: u2,
            reserved11: u1,
            ///  UIF status bit remapping
            UIFREMAP: u1,
            padding: u20,
        }),
        ///  control register 2
        CR2: mmio.Mmio(packed struct(u32) {
            reserved3: u3,
            ///  Capture/compare DMA selection
            CCDS: u1,
            ///  Master mode selection
            MMS: u3,
            ///  TI1 selection
            TI1S: u1,
            padding: u24,
        }),
        ///  slave mode control register
        SMCR: mmio.Mmio(packed struct(u32) {
            ///  Slave mode selection
            SMS: u3,
            ///  OCREF clear selection
            OCCS: u1,
            ///  Trigger selection
            TS: u3,
            ///  Master/Slave mode
            MSM: u1,
            ///  External trigger filter
            ETF: u4,
            ///  External trigger prescaler
            ETPS: u2,
            ///  External clock enable
            ECE: u1,
            ///  External trigger polarity
            ETP: u1,
            ///  Slave mode selection bit3
            SMS_3: u1,
            padding: u15,
        }),
        ///  DMA/Interrupt enable register
        DIER: mmio.Mmio(packed struct(u32) {
            ///  Update interrupt enable
            UIE: u1,
            ///  Capture/Compare 1 interrupt enable
            CC1IE: u1,
            ///  Capture/Compare 2 interrupt enable
            CC2IE: u1,
            ///  Capture/Compare 3 interrupt enable
            CC3IE: u1,
            ///  Capture/Compare 4 interrupt enable
            CC4IE: u1,
            reserved6: u1,
            ///  Trigger interrupt enable
            TIE: u1,
            reserved8: u1,
            ///  Update DMA request enable
            UDE: u1,
            ///  Capture/Compare 1 DMA request enable
            CC1DE: u1,
            ///  Capture/Compare 2 DMA request enable
            CC2DE: u1,
            ///  Capture/Compare 3 DMA request enable
            CC3DE: u1,
            ///  Capture/Compare 4 DMA request enable
            CC4DE: u1,
            reserved14: u1,
            ///  Trigger DMA request enable
            TDE: u1,
            padding: u17,
        }),
        ///  status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Update interrupt flag
            UIF: u1,
            ///  Capture/compare 1 interrupt flag
            CC1IF: u1,
            ///  Capture/Compare 2 interrupt flag
            CC2IF: u1,
            ///  Capture/Compare 3 interrupt flag
            CC3IF: u1,
            ///  Capture/Compare 4 interrupt flag
            CC4IF: u1,
            reserved6: u1,
            ///  Trigger interrupt flag
            TIF: u1,
            reserved9: u2,
            ///  Capture/Compare 1 overcapture flag
            CC1OF: u1,
            ///  Capture/compare 2 overcapture flag
            CC2OF: u1,
            ///  Capture/Compare 3 overcapture flag
            CC3OF: u1,
            ///  Capture/Compare 4 overcapture flag
            CC4OF: u1,
            padding: u19,
        }),
        ///  event generation register
        EGR: mmio.Mmio(packed struct(u32) {
            ///  Update generation
            UG: u1,
            ///  Capture/compare 1 generation
            CC1G: u1,
            ///  Capture/compare 2 generation
            CC2G: u1,
            ///  Capture/compare 3 generation
            CC3G: u1,
            ///  Capture/compare 4 generation
            CC4G: u1,
            reserved6: u1,
            ///  Trigger generation
            TG: u1,
            padding: u25,
        }),
        ///  capture/compare mode register 1 (output mode)
        CCMR1_Output: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 selection
            CC1S: u2,
            ///  Output compare 1 fast enable
            OC1FE: u1,
            ///  Output compare 1 preload enable
            OC1PE: u1,
            ///  Output compare 1 mode
            OC1M: u3,
            ///  Output compare 1 clear enable
            OC1CE: u1,
            ///  Capture/Compare 2 selection
            CC2S: u2,
            ///  Output compare 2 fast enable
            OC2FE: u1,
            ///  Output compare 2 preload enable
            OC2PE: u1,
            ///  Output compare 2 mode
            OC2M: u3,
            ///  Output compare 2 clear enable
            OC2CE: u1,
            ///  Output compare 1 mode bit 3
            OC1M_3: u1,
            reserved24: u7,
            ///  Output compare 2 mode bit 3
            OC2M_3: u1,
            padding: u7,
        }),
        ///  capture/compare mode register 2 (output mode)
        CCMR2_Output: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 3 selection
            CC3S: u2,
            ///  Output compare 3 fast enable
            OC3FE: u1,
            ///  Output compare 3 preload enable
            OC3PE: u1,
            ///  Output compare 3 mode
            OC3M: u3,
            ///  Output compare 3 clear enable
            OC3CE: u1,
            ///  Capture/Compare 4 selection
            CC4S: u2,
            ///  Output compare 4 fast enable
            OC4FE: u1,
            ///  Output compare 4 preload enable
            OC4PE: u1,
            ///  Output compare 4 mode
            OC4M: u3,
            ///  Output compare 4 clear enable
            O24CE: u1,
            ///  Output compare 3 mode bit3
            OC3M_3: u1,
            reserved24: u7,
            ///  Output compare 4 mode bit3
            OC4M_3: u1,
            padding: u7,
        }),
        ///  capture/compare enable register
        CCER: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 output enable
            CC1E: u1,
            ///  Capture/Compare 1 output Polarity
            CC1P: u1,
            reserved3: u1,
            ///  Capture/Compare 1 output Polarity
            CC1NP: u1,
            ///  Capture/Compare 2 output enable
            CC2E: u1,
            ///  Capture/Compare 2 output Polarity
            CC2P: u1,
            reserved7: u1,
            ///  Capture/Compare 2 output Polarity
            CC2NP: u1,
            ///  Capture/Compare 3 output enable
            CC3E: u1,
            ///  Capture/Compare 3 output Polarity
            CC3P: u1,
            reserved11: u1,
            ///  Capture/Compare 3 output Polarity
            CC3NP: u1,
            ///  Capture/Compare 4 output enable
            CC4E: u1,
            ///  Capture/Compare 3 output Polarity
            CC4P: u1,
            reserved15: u1,
            ///  Capture/Compare 3 output Polarity
            CC4NP: u1,
            padding: u16,
        }),
        ///  counter
        CNT: mmio.Mmio(packed struct(u32) {
            ///  Low counter value
            CNTL: u16,
            ///  High counter value
            CNTH: u15,
            ///  if IUFREMAP=0 than CNT with read write access else UIFCPY with read only access
            CNT_or_UIFCPY: u1,
        }),
        ///  prescaler
        PSC: mmio.Mmio(packed struct(u32) {
            ///  Prescaler value
            PSC: u16,
            padding: u16,
        }),
        ///  auto-reload register
        ARR: mmio.Mmio(packed struct(u32) {
            ///  Low Auto-reload value
            ARRL: u16,
            ///  High Auto-reload value
            ARRH: u16,
        }),
        reserved52: [4]u8,
        ///  capture/compare register 1
        CCR1: mmio.Mmio(packed struct(u32) {
            ///  Low Capture/Compare 1 value
            CCR1L: u16,
            ///  High Capture/Compare 1 value (on TIM2)
            CCR1H: u16,
        }),
        ///  capture/compare register 2
        CCR2: mmio.Mmio(packed struct(u32) {
            ///  Low Capture/Compare 2 value
            CCR2L: u16,
            ///  High Capture/Compare 2 value (on TIM2)
            CCR2H: u16,
        }),
        ///  capture/compare register 3
        CCR3: mmio.Mmio(packed struct(u32) {
            ///  Low Capture/Compare value
            CCR3L: u16,
            ///  High Capture/Compare value (on TIM2)
            CCR3H: u16,
        }),
        ///  capture/compare register 4
        CCR4: mmio.Mmio(packed struct(u32) {
            ///  Low Capture/Compare value
            CCR4L: u16,
            ///  High Capture/Compare value (on TIM2)
            CCR4H: u16,
        }),
        reserved72: [4]u8,
        ///  DMA control register
        DCR: mmio.Mmio(packed struct(u32) {
            ///  DMA base address
            DBA: u5,
            reserved8: u3,
            ///  DMA burst length
            DBL: u5,
            padding: u19,
        }),
        ///  DMA address for full transfer
        DMAR: mmio.Mmio(packed struct(u32) {
            ///  DMA register for burst accesses
            DMAB: u16,
            padding: u16,
        }),
    };

    ///  Nested Vectored Interrupt Controller
    pub const NVIC = extern struct {
        ///  Interrupt Set-Enable Register
        ISER0: mmio.Mmio(packed struct(u32) {
            ///  SETENA
            SETENA: u32,
        }),
        ///  Interrupt Set-Enable Register
        ISER1: mmio.Mmio(packed struct(u32) {
            ///  SETENA
            SETENA: u32,
        }),
        ///  Interrupt Set-Enable Register
        ISER2: mmio.Mmio(packed struct(u32) {
            ///  SETENA
            SETENA: u32,
        }),
        reserved128: [116]u8,
        ///  Interrupt Clear-Enable Register
        ICER0: mmio.Mmio(packed struct(u32) {
            ///  CLRENA
            CLRENA: u32,
        }),
        ///  Interrupt Clear-Enable Register
        ICER1: mmio.Mmio(packed struct(u32) {
            ///  CLRENA
            CLRENA: u32,
        }),
        ///  Interrupt Clear-Enable Register
        ICER2: mmio.Mmio(packed struct(u32) {
            ///  CLRENA
            CLRENA: u32,
        }),
        reserved256: [116]u8,
        ///  Interrupt Set-Pending Register
        ISPR0: mmio.Mmio(packed struct(u32) {
            ///  SETPEND
            SETPEND: u32,
        }),
        ///  Interrupt Set-Pending Register
        ISPR1: mmio.Mmio(packed struct(u32) {
            ///  SETPEND
            SETPEND: u32,
        }),
        ///  Interrupt Set-Pending Register
        ISPR2: mmio.Mmio(packed struct(u32) {
            ///  SETPEND
            SETPEND: u32,
        }),
        reserved384: [116]u8,
        ///  Interrupt Clear-Pending Register
        ICPR0: mmio.Mmio(packed struct(u32) {
            ///  CLRPEND
            CLRPEND: u32,
        }),
        ///  Interrupt Clear-Pending Register
        ICPR1: mmio.Mmio(packed struct(u32) {
            ///  CLRPEND
            CLRPEND: u32,
        }),
        ///  Interrupt Clear-Pending Register
        ICPR2: mmio.Mmio(packed struct(u32) {
            ///  CLRPEND
            CLRPEND: u32,
        }),
        reserved512: [116]u8,
        ///  Interrupt Active Bit Register
        IABR0: mmio.Mmio(packed struct(u32) {
            ///  ACTIVE
            ACTIVE: u32,
        }),
        ///  Interrupt Active Bit Register
        IABR1: mmio.Mmio(packed struct(u32) {
            ///  ACTIVE
            ACTIVE: u32,
        }),
        ///  Interrupt Active Bit Register
        IABR2: mmio.Mmio(packed struct(u32) {
            ///  ACTIVE
            ACTIVE: u32,
        }),
        reserved768: [244]u8,
        ///  Interrupt Priority Register
        IPR0: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
        ///  Interrupt Priority Register
        IPR1: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
        ///  Interrupt Priority Register
        IPR2: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
        ///  Interrupt Priority Register
        IPR3: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
        ///  Interrupt Priority Register
        IPR4: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
        ///  Interrupt Priority Register
        IPR5: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
        ///  Interrupt Priority Register
        IPR6: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
        ///  Interrupt Priority Register
        IPR7: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
        ///  Interrupt Priority Register
        IPR8: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
        ///  Interrupt Priority Register
        IPR9: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
        ///  Interrupt Priority Register
        IPR10: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
        ///  Interrupt Priority Register
        IPR11: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
        ///  Interrupt Priority Register
        IPR12: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
        ///  Interrupt Priority Register
        IPR13: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
        ///  Interrupt Priority Register
        IPR14: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
        ///  Interrupt Priority Register
        IPR15: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
        ///  Interrupt Priority Register
        IPR16: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
        ///  Interrupt Priority Register
        IPR17: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
        ///  Interrupt Priority Register
        IPR18: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
        ///  Interrupt Priority Register
        IPR19: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
        ///  Interrupt Priority Register
        IPR20: mmio.Mmio(packed struct(u32) {
            ///  IPR_N0
            IPR_N0: u8,
            ///  IPR_N1
            IPR_N1: u8,
            ///  IPR_N2
            IPR_N2: u8,
            ///  IPR_N3
            IPR_N3: u8,
        }),
    };

    ///  Flexible memory controller
    pub const FMC = extern struct {
        ///  SRAM/NOR-Flash chip-select control register 1
        BCR1: mmio.Mmio(packed struct(u32) {
            ///  MBKEN
            MBKEN: u1,
            ///  MUXEN
            MUXEN: u1,
            ///  MTYP
            MTYP: u2,
            ///  MWID
            MWID: u2,
            ///  FACCEN
            FACCEN: u1,
            reserved8: u1,
            ///  BURSTEN
            BURSTEN: u1,
            ///  WAITPOL
            WAITPOL: u1,
            reserved11: u1,
            ///  WAITCFG
            WAITCFG: u1,
            ///  WREN
            WREN: u1,
            ///  WAITEN
            WAITEN: u1,
            ///  EXTMOD
            EXTMOD: u1,
            ///  ASYNCWAIT
            ASYNCWAIT: u1,
            reserved19: u3,
            ///  CBURSTRW
            CBURSTRW: u1,
            ///  CCLKEN
            CCLKEN: u1,
            padding: u11,
        }),
        ///  SRAM/NOR-Flash chip-select timing register 1
        BTR1: mmio.Mmio(packed struct(u32) {
            ///  ADDSET
            ADDSET: u4,
            ///  ADDHLD
            ADDHLD: u4,
            ///  DATAST
            DATAST: u8,
            ///  BUSTURN
            BUSTURN: u4,
            ///  CLKDIV
            CLKDIV: u4,
            ///  DATLAT
            DATLAT: u4,
            ///  ACCMOD
            ACCMOD: u2,
            padding: u2,
        }),
        ///  SRAM/NOR-Flash chip-select control register 2
        BCR2: mmio.Mmio(packed struct(u32) {
            ///  MBKEN
            MBKEN: u1,
            ///  MUXEN
            MUXEN: u1,
            ///  MTYP
            MTYP: u2,
            ///  MWID
            MWID: u2,
            ///  FACCEN
            FACCEN: u1,
            reserved8: u1,
            ///  BURSTEN
            BURSTEN: u1,
            ///  WAITPOL
            WAITPOL: u1,
            ///  WRAPMOD
            WRAPMOD: u1,
            ///  WAITCFG
            WAITCFG: u1,
            ///  WREN
            WREN: u1,
            ///  WAITEN
            WAITEN: u1,
            ///  EXTMOD
            EXTMOD: u1,
            ///  ASYNCWAIT
            ASYNCWAIT: u1,
            reserved19: u3,
            ///  CBURSTRW
            CBURSTRW: u1,
            padding: u12,
        }),
        ///  SRAM/NOR-Flash chip-select timing register 2
        BTR2: mmio.Mmio(packed struct(u32) {
            ///  ADDSET
            ADDSET: u4,
            ///  ADDHLD
            ADDHLD: u4,
            ///  DATAST
            DATAST: u8,
            ///  BUSTURN
            BUSTURN: u4,
            ///  CLKDIV
            CLKDIV: u4,
            ///  DATLAT
            DATLAT: u4,
            ///  ACCMOD
            ACCMOD: u2,
            padding: u2,
        }),
        ///  SRAM/NOR-Flash chip-select control register 3
        BCR3: mmio.Mmio(packed struct(u32) {
            ///  MBKEN
            MBKEN: u1,
            ///  MUXEN
            MUXEN: u1,
            ///  MTYP
            MTYP: u2,
            ///  MWID
            MWID: u2,
            ///  FACCEN
            FACCEN: u1,
            reserved8: u1,
            ///  BURSTEN
            BURSTEN: u1,
            ///  WAITPOL
            WAITPOL: u1,
            ///  WRAPMOD
            WRAPMOD: u1,
            ///  WAITCFG
            WAITCFG: u1,
            ///  WREN
            WREN: u1,
            ///  WAITEN
            WAITEN: u1,
            ///  EXTMOD
            EXTMOD: u1,
            ///  ASYNCWAIT
            ASYNCWAIT: u1,
            reserved19: u3,
            ///  CBURSTRW
            CBURSTRW: u1,
            padding: u12,
        }),
        ///  SRAM/NOR-Flash chip-select timing register 3
        BTR3: mmio.Mmio(packed struct(u32) {
            ///  ADDSET
            ADDSET: u4,
            ///  ADDHLD
            ADDHLD: u4,
            ///  DATAST
            DATAST: u8,
            ///  BUSTURN
            BUSTURN: u4,
            ///  CLKDIV
            CLKDIV: u4,
            ///  DATLAT
            DATLAT: u4,
            ///  ACCMOD
            ACCMOD: u2,
            padding: u2,
        }),
        ///  SRAM/NOR-Flash chip-select control register 4
        BCR4: mmio.Mmio(packed struct(u32) {
            ///  MBKEN
            MBKEN: u1,
            ///  MUXEN
            MUXEN: u1,
            ///  MTYP
            MTYP: u2,
            ///  MWID
            MWID: u2,
            ///  FACCEN
            FACCEN: u1,
            reserved8: u1,
            ///  BURSTEN
            BURSTEN: u1,
            ///  WAITPOL
            WAITPOL: u1,
            ///  WRAPMOD
            WRAPMOD: u1,
            ///  WAITCFG
            WAITCFG: u1,
            ///  WREN
            WREN: u1,
            ///  WAITEN
            WAITEN: u1,
            ///  EXTMOD
            EXTMOD: u1,
            ///  ASYNCWAIT
            ASYNCWAIT: u1,
            reserved19: u3,
            ///  CBURSTRW
            CBURSTRW: u1,
            padding: u12,
        }),
        ///  SRAM/NOR-Flash chip-select timing register 4
        BTR4: mmio.Mmio(packed struct(u32) {
            ///  ADDSET
            ADDSET: u4,
            ///  ADDHLD
            ADDHLD: u4,
            ///  DATAST
            DATAST: u8,
            ///  BUSTURN
            BUSTURN: u4,
            ///  CLKDIV
            CLKDIV: u4,
            ///  DATLAT
            DATLAT: u4,
            ///  ACCMOD
            ACCMOD: u2,
            padding: u2,
        }),
        reserved96: [64]u8,
        ///  PC Card/NAND Flash control register 2
        PCR2: mmio.Mmio(packed struct(u32) {
            reserved1: u1,
            ///  PWAITEN
            PWAITEN: u1,
            ///  PBKEN
            PBKEN: u1,
            ///  PTYP
            PTYP: u1,
            ///  PWID
            PWID: u2,
            ///  ECCEN
            ECCEN: u1,
            reserved9: u2,
            ///  TCLR
            TCLR: u4,
            ///  TAR
            TAR: u4,
            ///  ECCPS
            ECCPS: u3,
            padding: u12,
        }),
        ///  FIFO status and interrupt register 2
        SR2: mmio.Mmio(packed struct(u32) {
            ///  IRS
            IRS: u1,
            ///  ILS
            ILS: u1,
            ///  IFS
            IFS: u1,
            ///  IREN
            IREN: u1,
            ///  ILEN
            ILEN: u1,
            ///  IFEN
            IFEN: u1,
            ///  FEMPT
            FEMPT: u1,
            padding: u25,
        }),
        ///  Common memory space timing register 2
        PMEM2: mmio.Mmio(packed struct(u32) {
            ///  MEMSETx
            MEMSETx: u8,
            ///  MEMWAITx
            MEMWAITx: u8,
            ///  MEMHOLDx
            MEMHOLDx: u8,
            ///  MEMHIZx
            MEMHIZx: u8,
        }),
        ///  Attribute memory space timing register 2
        PATT2: mmio.Mmio(packed struct(u32) {
            ///  ATTSETx
            ATTSETx: u8,
            ///  ATTWAITx
            ATTWAITx: u8,
            ///  ATTHOLDx
            ATTHOLDx: u8,
            ///  ATTHIZx
            ATTHIZx: u8,
        }),
        reserved116: [4]u8,
        ///  ECC result register 2
        ECCR2: mmio.Mmio(packed struct(u32) {
            ///  ECCx
            ECCx: u32,
        }),
        reserved128: [8]u8,
        ///  PC Card/NAND Flash control register 3
        PCR3: mmio.Mmio(packed struct(u32) {
            reserved1: u1,
            ///  PWAITEN
            PWAITEN: u1,
            ///  PBKEN
            PBKEN: u1,
            ///  PTYP
            PTYP: u1,
            ///  PWID
            PWID: u2,
            ///  ECCEN
            ECCEN: u1,
            reserved9: u2,
            ///  TCLR
            TCLR: u4,
            ///  TAR
            TAR: u4,
            ///  ECCPS
            ECCPS: u3,
            padding: u12,
        }),
        ///  FIFO status and interrupt register 3
        SR3: mmio.Mmio(packed struct(u32) {
            ///  IRS
            IRS: u1,
            ///  ILS
            ILS: u1,
            ///  IFS
            IFS: u1,
            ///  IREN
            IREN: u1,
            ///  ILEN
            ILEN: u1,
            ///  IFEN
            IFEN: u1,
            ///  FEMPT
            FEMPT: u1,
            padding: u25,
        }),
        ///  Common memory space timing register 3
        PMEM3: mmio.Mmio(packed struct(u32) {
            ///  MEMSETx
            MEMSETx: u8,
            ///  MEMWAITx
            MEMWAITx: u8,
            ///  MEMHOLDx
            MEMHOLDx: u8,
            ///  MEMHIZx
            MEMHIZx: u8,
        }),
        ///  Attribute memory space timing register 3
        PATT3: mmio.Mmio(packed struct(u32) {
            ///  ATTSETx
            ATTSETx: u8,
            ///  ATTWAITx
            ATTWAITx: u8,
            ///  ATTHOLDx
            ATTHOLDx: u8,
            ///  ATTHIZx
            ATTHIZx: u8,
        }),
        reserved148: [4]u8,
        ///  ECC result register 3
        ECCR3: mmio.Mmio(packed struct(u32) {
            ///  ECCx
            ECCx: u32,
        }),
        reserved160: [8]u8,
        ///  PC Card/NAND Flash control register 4
        PCR4: mmio.Mmio(packed struct(u32) {
            reserved1: u1,
            ///  PWAITEN
            PWAITEN: u1,
            ///  PBKEN
            PBKEN: u1,
            ///  PTYP
            PTYP: u1,
            ///  PWID
            PWID: u2,
            ///  ECCEN
            ECCEN: u1,
            reserved9: u2,
            ///  TCLR
            TCLR: u4,
            ///  TAR
            TAR: u4,
            ///  ECCPS
            ECCPS: u3,
            padding: u12,
        }),
        ///  FIFO status and interrupt register 4
        SR4: mmio.Mmio(packed struct(u32) {
            ///  IRS
            IRS: u1,
            ///  ILS
            ILS: u1,
            ///  IFS
            IFS: u1,
            ///  IREN
            IREN: u1,
            ///  ILEN
            ILEN: u1,
            ///  IFEN
            IFEN: u1,
            ///  FEMPT
            FEMPT: u1,
            padding: u25,
        }),
        ///  Common memory space timing register 4
        PMEM4: mmio.Mmio(packed struct(u32) {
            ///  MEMSETx
            MEMSETx: u8,
            ///  MEMWAITx
            MEMWAITx: u8,
            ///  MEMHOLDx
            MEMHOLDx: u8,
            ///  MEMHIZx
            MEMHIZx: u8,
        }),
        ///  Attribute memory space timing register 4
        PATT4: mmio.Mmio(packed struct(u32) {
            ///  ATTSETx
            ATTSETx: u8,
            ///  ATTWAITx
            ATTWAITx: u8,
            ///  ATTHOLDx
            ATTHOLDx: u8,
            ///  ATTHIZx
            ATTHIZx: u8,
        }),
        ///  I/O space timing register 4
        PIO4: mmio.Mmio(packed struct(u32) {
            ///  IOSETx
            IOSETx: u8,
            ///  IOWAITx
            IOWAITx: u8,
            ///  IOHOLDx
            IOHOLDx: u8,
            ///  IOHIZx
            IOHIZx: u8,
        }),
        reserved260: [80]u8,
        ///  SRAM/NOR-Flash write timing registers 1
        BWTR1: mmio.Mmio(packed struct(u32) {
            ///  ADDSET
            ADDSET: u4,
            ///  ADDHLD
            ADDHLD: u4,
            ///  DATAST
            DATAST: u8,
            ///  Bus turnaround phase duration
            BUSTURN: u4,
            ///  CLKDIV
            CLKDIV: u4,
            ///  DATLAT
            DATLAT: u4,
            ///  ACCMOD
            ACCMOD: u2,
            padding: u2,
        }),
        reserved268: [4]u8,
        ///  SRAM/NOR-Flash write timing registers 2
        BWTR2: mmio.Mmio(packed struct(u32) {
            ///  ADDSET
            ADDSET: u4,
            ///  ADDHLD
            ADDHLD: u4,
            ///  DATAST
            DATAST: u8,
            ///  Bus turnaround phase duration
            BUSTURN: u4,
            ///  CLKDIV
            CLKDIV: u4,
            ///  DATLAT
            DATLAT: u4,
            ///  ACCMOD
            ACCMOD: u2,
            padding: u2,
        }),
        reserved276: [4]u8,
        ///  SRAM/NOR-Flash write timing registers 3
        BWTR3: mmio.Mmio(packed struct(u32) {
            ///  ADDSET
            ADDSET: u4,
            ///  ADDHLD
            ADDHLD: u4,
            ///  DATAST
            DATAST: u8,
            ///  Bus turnaround phase duration
            BUSTURN: u4,
            ///  CLKDIV
            CLKDIV: u4,
            ///  DATLAT
            DATLAT: u4,
            ///  ACCMOD
            ACCMOD: u2,
            padding: u2,
        }),
        reserved284: [4]u8,
        ///  SRAM/NOR-Flash write timing registers 4
        BWTR4: mmio.Mmio(packed struct(u32) {
            ///  ADDSET
            ADDSET: u4,
            ///  ADDHLD
            ADDHLD: u4,
            ///  DATAST
            DATAST: u8,
            ///  Bus turnaround phase duration
            BUSTURN: u4,
            ///  CLKDIV
            CLKDIV: u4,
            ///  DATLAT
            DATLAT: u4,
            ///  ACCMOD
            ACCMOD: u2,
            padding: u2,
        }),
    };

    ///  General purpose timers
    pub const TIM15 = extern struct {
        ///  control register 1
        CR1: mmio.Mmio(packed struct(u32) {
            ///  Counter enable
            CEN: u1,
            ///  Update disable
            UDIS: u1,
            ///  Update request source
            URS: u1,
            ///  One-pulse mode
            OPM: u1,
            reserved7: u3,
            ///  Auto-reload preload enable
            ARPE: u1,
            ///  Clock division
            CKD: u2,
            reserved11: u1,
            ///  UIF status bit remapping
            UIFREMAP: u1,
            padding: u20,
        }),
        ///  control register 2
        CR2: mmio.Mmio(packed struct(u32) {
            ///  Capture/compare preloaded control
            CCPC: u1,
            reserved2: u1,
            ///  Capture/compare control update selection
            CCUS: u1,
            ///  Capture/compare DMA selection
            CCDS: u1,
            ///  Master mode selection
            MMS: u3,
            ///  TI1 selection
            TI1S: u1,
            ///  Output Idle state 1
            OIS1: u1,
            ///  Output Idle state 1
            OIS1N: u1,
            ///  Output Idle state 2
            OIS2: u1,
            padding: u21,
        }),
        ///  slave mode control register
        SMCR: mmio.Mmio(packed struct(u32) {
            ///  Slave mode selection
            SMS: u3,
            reserved4: u1,
            ///  Trigger selection
            TS: u3,
            ///  Master/Slave mode
            MSM: u1,
            reserved16: u8,
            ///  Slave mode selection bit 3
            SMS_3: u1,
            padding: u15,
        }),
        ///  DMA/Interrupt enable register
        DIER: mmio.Mmio(packed struct(u32) {
            ///  Update interrupt enable
            UIE: u1,
            ///  Capture/Compare 1 interrupt enable
            CC1IE: u1,
            ///  Capture/Compare 2 interrupt enable
            CC2IE: u1,
            reserved5: u2,
            ///  COM interrupt enable
            COMIE: u1,
            ///  Trigger interrupt enable
            TIE: u1,
            ///  Break interrupt enable
            BIE: u1,
            ///  Update DMA request enable
            UDE: u1,
            ///  Capture/Compare 1 DMA request enable
            CC1DE: u1,
            ///  Capture/Compare 2 DMA request enable
            CC2DE: u1,
            reserved13: u2,
            ///  COM DMA request enable
            COMDE: u1,
            ///  Trigger DMA request enable
            TDE: u1,
            padding: u17,
        }),
        ///  status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Update interrupt flag
            UIF: u1,
            ///  Capture/compare 1 interrupt flag
            CC1IF: u1,
            ///  Capture/Compare 2 interrupt flag
            CC2IF: u1,
            reserved5: u2,
            ///  COM interrupt flag
            COMIF: u1,
            ///  Trigger interrupt flag
            TIF: u1,
            ///  Break interrupt flag
            BIF: u1,
            reserved9: u1,
            ///  Capture/Compare 1 overcapture flag
            CC1OF: u1,
            ///  Capture/compare 2 overcapture flag
            CC2OF: u1,
            padding: u21,
        }),
        ///  event generation register
        EGR: mmio.Mmio(packed struct(u32) {
            ///  Update generation
            UG: u1,
            ///  Capture/compare 1 generation
            CC1G: u1,
            ///  Capture/compare 2 generation
            CC2G: u1,
            reserved5: u2,
            ///  Capture/Compare control update generation
            COMG: u1,
            ///  Trigger generation
            TG: u1,
            ///  Break generation
            BG: u1,
            padding: u24,
        }),
        ///  capture/compare mode register (output mode)
        CCMR1_Output: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 selection
            CC1S: u2,
            ///  Output Compare 1 fast enable
            OC1FE: u1,
            ///  Output Compare 1 preload enable
            OC1PE: u1,
            ///  Output Compare 1 mode
            OC1M: u3,
            reserved8: u1,
            ///  Capture/Compare 2 selection
            CC2S: u2,
            ///  Output Compare 2 fast enable
            OC2FE: u1,
            ///  Output Compare 2 preload enable
            OC2PE: u1,
            ///  Output Compare 2 mode
            OC2M: u3,
            reserved16: u1,
            ///  Output Compare 1 mode bit 3
            OC1M_3: u1,
            reserved24: u7,
            ///  Output Compare 2 mode bit 3
            OC2M_3: u1,
            padding: u7,
        }),
        reserved32: [4]u8,
        ///  capture/compare enable register
        CCER: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 output enable
            CC1E: u1,
            ///  Capture/Compare 1 output Polarity
            CC1P: u1,
            ///  Capture/Compare 1 complementary output enable
            CC1NE: u1,
            ///  Capture/Compare 1 output Polarity
            CC1NP: u1,
            ///  Capture/Compare 2 output enable
            CC2E: u1,
            ///  Capture/Compare 2 output Polarity
            CC2P: u1,
            reserved7: u1,
            ///  Capture/Compare 2 output Polarity
            CC2NP: u1,
            padding: u24,
        }),
        ///  counter
        CNT: mmio.Mmio(packed struct(u32) {
            ///  counter value
            CNT: u16,
            reserved31: u15,
            ///  UIF copy
            UIFCPY: u1,
        }),
        ///  prescaler
        PSC: mmio.Mmio(packed struct(u32) {
            ///  Prescaler value
            PSC: u16,
            padding: u16,
        }),
        ///  auto-reload register
        ARR: mmio.Mmio(packed struct(u32) {
            ///  Auto-reload value
            ARR: u16,
            padding: u16,
        }),
        ///  repetition counter register
        RCR: mmio.Mmio(packed struct(u32) {
            ///  Repetition counter value
            REP: u8,
            padding: u24,
        }),
        ///  capture/compare register 1
        CCR1: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 value
            CCR1: u16,
            padding: u16,
        }),
        ///  capture/compare register 2
        CCR2: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 2 value
            CCR2: u16,
            padding: u16,
        }),
        reserved68: [8]u8,
        ///  break and dead-time register
        BDTR: mmio.Mmio(packed struct(u32) {
            ///  Dead-time generator setup
            DTG: u8,
            ///  Lock configuration
            LOCK: u2,
            ///  Off-state selection for Idle mode
            OSSI: u1,
            ///  Off-state selection for Run mode
            OSSR: u1,
            ///  Break enable
            BKE: u1,
            ///  Break polarity
            BKP: u1,
            ///  Automatic output enable
            AOE: u1,
            ///  Main output enable
            MOE: u1,
            ///  Break filter
            BKF: u4,
            padding: u12,
        }),
        ///  DMA control register
        DCR: mmio.Mmio(packed struct(u32) {
            ///  DMA base address
            DBA: u5,
            reserved8: u3,
            ///  DMA burst length
            DBL: u5,
            padding: u19,
        }),
        ///  DMA address for full transfer
        DMAR: mmio.Mmio(packed struct(u32) {
            ///  DMA register for burst accesses
            DMAB: u16,
            padding: u16,
        }),
    };

    ///  General-purpose-timers
    pub const TIM16 = extern struct {
        ///  control register 1
        CR1: mmio.Mmio(packed struct(u32) {
            ///  Counter enable
            CEN: u1,
            ///  Update disable
            UDIS: u1,
            ///  Update request source
            URS: u1,
            ///  One-pulse mode
            OPM: u1,
            reserved7: u3,
            ///  Auto-reload preload enable
            ARPE: u1,
            ///  Clock division
            CKD: u2,
            reserved11: u1,
            ///  UIF status bit remapping
            UIFREMAP: u1,
            padding: u20,
        }),
        ///  control register 2
        CR2: mmio.Mmio(packed struct(u32) {
            ///  Capture/compare preloaded control
            CCPC: u1,
            reserved2: u1,
            ///  Capture/compare control update selection
            CCUS: u1,
            ///  Capture/compare DMA selection
            CCDS: u1,
            reserved8: u4,
            ///  Output Idle state 1
            OIS1: u1,
            ///  Output Idle state 1
            OIS1N: u1,
            padding: u22,
        }),
        reserved12: [4]u8,
        ///  DMA/Interrupt enable register
        DIER: mmio.Mmio(packed struct(u32) {
            ///  Update interrupt enable
            UIE: u1,
            ///  Capture/Compare 1 interrupt enable
            CC1IE: u1,
            reserved5: u3,
            ///  COM interrupt enable
            COMIE: u1,
            ///  Trigger interrupt enable
            TIE: u1,
            ///  Break interrupt enable
            BIE: u1,
            ///  Update DMA request enable
            UDE: u1,
            ///  Capture/Compare 1 DMA request enable
            CC1DE: u1,
            reserved13: u3,
            ///  COM DMA request enable
            COMDE: u1,
            ///  Trigger DMA request enable
            TDE: u1,
            padding: u17,
        }),
        ///  status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Update interrupt flag
            UIF: u1,
            ///  Capture/compare 1 interrupt flag
            CC1IF: u1,
            reserved5: u3,
            ///  COM interrupt flag
            COMIF: u1,
            ///  Trigger interrupt flag
            TIF: u1,
            ///  Break interrupt flag
            BIF: u1,
            reserved9: u1,
            ///  Capture/Compare 1 overcapture flag
            CC1OF: u1,
            padding: u22,
        }),
        ///  event generation register
        EGR: mmio.Mmio(packed struct(u32) {
            ///  Update generation
            UG: u1,
            ///  Capture/compare 1 generation
            CC1G: u1,
            reserved5: u3,
            ///  Capture/Compare control update generation
            COMG: u1,
            ///  Trigger generation
            TG: u1,
            ///  Break generation
            BG: u1,
            padding: u24,
        }),
        ///  capture/compare mode register (output mode)
        CCMR1_Output: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 selection
            CC1S: u2,
            ///  Output Compare 1 fast enable
            OC1FE: u1,
            ///  Output Compare 1 preload enable
            OC1PE: u1,
            ///  Output Compare 1 mode
            OC1M: u3,
            reserved16: u9,
            ///  Output Compare 1 mode
            OC1M_3: u1,
            padding: u15,
        }),
        reserved32: [4]u8,
        ///  capture/compare enable register
        CCER: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 output enable
            CC1E: u1,
            ///  Capture/Compare 1 output Polarity
            CC1P: u1,
            ///  Capture/Compare 1 complementary output enable
            CC1NE: u1,
            ///  Capture/Compare 1 output Polarity
            CC1NP: u1,
            padding: u28,
        }),
        ///  counter
        CNT: mmio.Mmio(packed struct(u32) {
            ///  counter value
            CNT: u16,
            reserved31: u15,
            ///  UIF Copy
            UIFCPY: u1,
        }),
        ///  prescaler
        PSC: mmio.Mmio(packed struct(u32) {
            ///  Prescaler value
            PSC: u16,
            padding: u16,
        }),
        ///  auto-reload register
        ARR: mmio.Mmio(packed struct(u32) {
            ///  Auto-reload value
            ARR: u16,
            padding: u16,
        }),
        ///  repetition counter register
        RCR: mmio.Mmio(packed struct(u32) {
            ///  Repetition counter value
            REP: u8,
            padding: u24,
        }),
        ///  capture/compare register 1
        CCR1: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 value
            CCR1: u16,
            padding: u16,
        }),
        reserved68: [12]u8,
        ///  break and dead-time register
        BDTR: mmio.Mmio(packed struct(u32) {
            ///  Dead-time generator setup
            DTG: u8,
            ///  Lock configuration
            LOCK: u2,
            ///  Off-state selection for Idle mode
            OSSI: u1,
            ///  Off-state selection for Run mode
            OSSR: u1,
            ///  Break enable
            BKE: u1,
            ///  Break polarity
            BKP: u1,
            ///  Automatic output enable
            AOE: u1,
            ///  Main output enable
            MOE: u1,
            ///  Break filter
            BKF: u4,
            padding: u12,
        }),
        ///  DMA control register
        DCR: mmio.Mmio(packed struct(u32) {
            ///  DMA base address
            DBA: u5,
            reserved8: u3,
            ///  DMA burst length
            DBL: u5,
            padding: u19,
        }),
        ///  DMA address for full transfer
        DMAR: mmio.Mmio(packed struct(u32) {
            ///  DMA register for burst accesses
            DMAB: u16,
            padding: u16,
        }),
        ///  option register
        OR: u32,
    };

    ///  General purpose timer
    pub const TIM17 = extern struct {
        ///  control register 1
        CR1: mmio.Mmio(packed struct(u32) {
            ///  Counter enable
            CEN: u1,
            ///  Update disable
            UDIS: u1,
            ///  Update request source
            URS: u1,
            ///  One-pulse mode
            OPM: u1,
            reserved7: u3,
            ///  Auto-reload preload enable
            ARPE: u1,
            ///  Clock division
            CKD: u2,
            reserved11: u1,
            ///  UIF status bit remapping
            UIFREMAP: u1,
            padding: u20,
        }),
        ///  control register 2
        CR2: mmio.Mmio(packed struct(u32) {
            ///  Capture/compare preloaded control
            CCPC: u1,
            reserved2: u1,
            ///  Capture/compare control update selection
            CCUS: u1,
            ///  Capture/compare DMA selection
            CCDS: u1,
            reserved8: u4,
            ///  Output Idle state 1
            OIS1: u1,
            ///  Output Idle state 1
            OIS1N: u1,
            padding: u22,
        }),
        reserved12: [4]u8,
        ///  DMA/Interrupt enable register
        DIER: mmio.Mmio(packed struct(u32) {
            ///  Update interrupt enable
            UIE: u1,
            ///  Capture/Compare 1 interrupt enable
            CC1IE: u1,
            reserved5: u3,
            ///  COM interrupt enable
            COMIE: u1,
            ///  Trigger interrupt enable
            TIE: u1,
            ///  Break interrupt enable
            BIE: u1,
            ///  Update DMA request enable
            UDE: u1,
            ///  Capture/Compare 1 DMA request enable
            CC1DE: u1,
            reserved13: u3,
            ///  COM DMA request enable
            COMDE: u1,
            ///  Trigger DMA request enable
            TDE: u1,
            padding: u17,
        }),
        ///  status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Update interrupt flag
            UIF: u1,
            ///  Capture/compare 1 interrupt flag
            CC1IF: u1,
            reserved5: u3,
            ///  COM interrupt flag
            COMIF: u1,
            ///  Trigger interrupt flag
            TIF: u1,
            ///  Break interrupt flag
            BIF: u1,
            reserved9: u1,
            ///  Capture/Compare 1 overcapture flag
            CC1OF: u1,
            padding: u22,
        }),
        ///  event generation register
        EGR: mmio.Mmio(packed struct(u32) {
            ///  Update generation
            UG: u1,
            ///  Capture/compare 1 generation
            CC1G: u1,
            reserved5: u3,
            ///  Capture/Compare control update generation
            COMG: u1,
            ///  Trigger generation
            TG: u1,
            ///  Break generation
            BG: u1,
            padding: u24,
        }),
        ///  capture/compare mode register (output mode)
        CCMR1_Output: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 selection
            CC1S: u2,
            ///  Output Compare 1 fast enable
            OC1FE: u1,
            ///  Output Compare 1 preload enable
            OC1PE: u1,
            ///  Output Compare 1 mode
            OC1M: u3,
            reserved16: u9,
            ///  Output Compare 1 mode
            OC1M_3: u1,
            padding: u15,
        }),
        reserved32: [4]u8,
        ///  capture/compare enable register
        CCER: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 output enable
            CC1E: u1,
            ///  Capture/Compare 1 output Polarity
            CC1P: u1,
            ///  Capture/Compare 1 complementary output enable
            CC1NE: u1,
            ///  Capture/Compare 1 output Polarity
            CC1NP: u1,
            padding: u28,
        }),
        ///  counter
        CNT: mmio.Mmio(packed struct(u32) {
            ///  counter value
            CNT: u16,
            reserved31: u15,
            ///  UIF Copy
            UIFCPY: u1,
        }),
        ///  prescaler
        PSC: mmio.Mmio(packed struct(u32) {
            ///  Prescaler value
            PSC: u16,
            padding: u16,
        }),
        ///  auto-reload register
        ARR: mmio.Mmio(packed struct(u32) {
            ///  Auto-reload value
            ARR: u16,
            padding: u16,
        }),
        ///  repetition counter register
        RCR: mmio.Mmio(packed struct(u32) {
            ///  Repetition counter value
            REP: u8,
            padding: u24,
        }),
        ///  capture/compare register 1
        CCR1: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 value
            CCR1: u16,
            padding: u16,
        }),
        reserved68: [12]u8,
        ///  break and dead-time register
        BDTR: mmio.Mmio(packed struct(u32) {
            ///  Dead-time generator setup
            DTG: u8,
            ///  Lock configuration
            LOCK: u2,
            ///  Off-state selection for Idle mode
            OSSI: u1,
            ///  Off-state selection for Run mode
            OSSR: u1,
            ///  Break enable
            BKE: u1,
            ///  Break polarity
            BKP: u1,
            ///  Automatic output enable
            AOE: u1,
            ///  Main output enable
            MOE: u1,
            ///  Break filter
            BKF: u4,
            padding: u12,
        }),
        ///  DMA control register
        DCR: mmio.Mmio(packed struct(u32) {
            ///  DMA base address
            DBA: u5,
            reserved8: u3,
            ///  DMA burst length
            DBL: u5,
            padding: u19,
        }),
        ///  DMA address for full transfer
        DMAR: mmio.Mmio(packed struct(u32) {
            ///  DMA register for burst accesses
            DMAB: u16,
            padding: u16,
        }),
    };

    ///  Universal synchronous asynchronous receiver transmitter
    pub const USART1 = extern struct {
        ///  Control register 1
        CR1: mmio.Mmio(packed struct(u32) {
            ///  USART enable
            UE: u1,
            ///  USART enable in Stop mode
            UESM: u1,
            ///  Receiver enable
            RE: u1,
            ///  Transmitter enable
            TE: u1,
            ///  IDLE interrupt enable
            IDLEIE: u1,
            ///  RXNE interrupt enable
            RXNEIE: u1,
            ///  Transmission complete interrupt enable
            TCIE: u1,
            ///  interrupt enable
            TXEIE: u1,
            ///  PE interrupt enable
            PEIE: u1,
            ///  Parity selection
            PS: u1,
            ///  Parity control enable
            PCE: u1,
            ///  Receiver wakeup method
            WAKE: u1,
            ///  Word length
            M: u1,
            ///  Mute mode enable
            MME: u1,
            ///  Character match interrupt enable
            CMIE: u1,
            ///  Oversampling mode
            OVER8: u1,
            ///  Driver Enable deassertion time
            DEDT: u5,
            ///  Driver Enable assertion time
            DEAT: u5,
            ///  Receiver timeout interrupt enable
            RTOIE: u1,
            ///  End of Block interrupt enable
            EOBIE: u1,
            padding: u4,
        }),
        ///  Control register 2
        CR2: mmio.Mmio(packed struct(u32) {
            reserved4: u4,
            ///  7-bit Address Detection/4-bit Address Detection
            ADDM7: u1,
            ///  LIN break detection length
            LBDL: u1,
            ///  LIN break detection interrupt enable
            LBDIE: u1,
            reserved8: u1,
            ///  Last bit clock pulse
            LBCL: u1,
            ///  Clock phase
            CPHA: u1,
            ///  Clock polarity
            CPOL: u1,
            ///  Clock enable
            CLKEN: u1,
            ///  STOP bits
            STOP: u2,
            ///  LIN mode enable
            LINEN: u1,
            ///  Swap TX/RX pins
            SWAP: u1,
            ///  RX pin active level inversion
            RXINV: u1,
            ///  TX pin active level inversion
            TXINV: u1,
            ///  Binary data inversion
            DATAINV: u1,
            ///  Most significant bit first
            MSBFIRST: u1,
            ///  Auto baud rate enable
            ABREN: u1,
            ///  Auto baud rate mode
            ABRMOD: u2,
            ///  Receiver timeout enable
            RTOEN: u1,
            ///  Address of the USART node
            ADD0: u4,
            ///  Address of the USART node
            ADD4: u4,
        }),
        ///  Control register 3
        CR3: mmio.Mmio(packed struct(u32) {
            ///  Error interrupt enable
            EIE: u1,
            ///  IrDA mode enable
            IREN: u1,
            ///  IrDA low-power
            IRLP: u1,
            ///  Half-duplex selection
            HDSEL: u1,
            ///  Smartcard NACK enable
            NACK: u1,
            ///  Smartcard mode enable
            SCEN: u1,
            ///  DMA enable receiver
            DMAR: u1,
            ///  DMA enable transmitter
            DMAT: u1,
            ///  RTS enable
            RTSE: u1,
            ///  CTS enable
            CTSE: u1,
            ///  CTS interrupt enable
            CTSIE: u1,
            ///  One sample bit method enable
            ONEBIT: u1,
            ///  Overrun Disable
            OVRDIS: u1,
            ///  DMA Disable on Reception Error
            DDRE: u1,
            ///  Driver enable mode
            DEM: u1,
            ///  Driver enable polarity selection
            DEP: u1,
            reserved17: u1,
            ///  Smartcard auto-retry count
            SCARCNT: u3,
            ///  Wakeup from Stop mode interrupt flag selection
            WUS: u2,
            ///  Wakeup from Stop mode interrupt enable
            WUFIE: u1,
            padding: u9,
        }),
        ///  Baud rate register
        BRR: mmio.Mmio(packed struct(u32) {
            ///  fraction of USARTDIV
            DIV_Fraction: u4,
            ///  mantissa of USARTDIV
            DIV_Mantissa: u12,
            padding: u16,
        }),
        ///  Guard time and prescaler register
        GTPR: mmio.Mmio(packed struct(u32) {
            ///  Prescaler value
            PSC: u8,
            ///  Guard time value
            GT: u8,
            padding: u16,
        }),
        ///  Receiver timeout register
        RTOR: mmio.Mmio(packed struct(u32) {
            ///  Receiver timeout value
            RTO: u24,
            ///  Block Length
            BLEN: u8,
        }),
        ///  Request register
        RQR: mmio.Mmio(packed struct(u32) {
            ///  Auto baud rate request
            ABRRQ: u1,
            ///  Send break request
            SBKRQ: u1,
            ///  Mute mode request
            MMRQ: u1,
            ///  Receive data flush request
            RXFRQ: u1,
            ///  Transmit data flush request
            TXFRQ: u1,
            padding: u27,
        }),
        ///  Interrupt & status register
        ISR: mmio.Mmio(packed struct(u32) {
            ///  Parity error
            PE: u1,
            ///  Framing error
            FE: u1,
            ///  Noise detected flag
            NF: u1,
            ///  Overrun error
            ORE: u1,
            ///  Idle line detected
            IDLE: u1,
            ///  Read data register not empty
            RXNE: u1,
            ///  Transmission complete
            TC: u1,
            ///  Transmit data register empty
            TXE: u1,
            ///  LIN break detection flag
            LBDF: u1,
            ///  CTS interrupt flag
            CTSIF: u1,
            ///  CTS flag
            CTS: u1,
            ///  Receiver timeout
            RTOF: u1,
            ///  End of block flag
            EOBF: u1,
            reserved14: u1,
            ///  Auto baud rate error
            ABRE: u1,
            ///  Auto baud rate flag
            ABRF: u1,
            ///  Busy flag
            BUSY: u1,
            ///  character match flag
            CMF: u1,
            ///  Send break flag
            SBKF: u1,
            ///  Receiver wakeup from Mute mode
            RWU: u1,
            ///  Wakeup from Stop mode flag
            WUF: u1,
            ///  Transmit enable acknowledge flag
            TEACK: u1,
            ///  Receive enable acknowledge flag
            REACK: u1,
            padding: u9,
        }),
        ///  Interrupt flag clear register
        ICR: mmio.Mmio(packed struct(u32) {
            ///  Parity error clear flag
            PECF: u1,
            ///  Framing error clear flag
            FECF: u1,
            ///  Noise detected clear flag
            NCF: u1,
            ///  Overrun error clear flag
            ORECF: u1,
            ///  Idle line detected clear flag
            IDLECF: u1,
            reserved6: u1,
            ///  Transmission complete clear flag
            TCCF: u1,
            reserved8: u1,
            ///  LIN break detection clear flag
            LBDCF: u1,
            ///  CTS clear flag
            CTSCF: u1,
            reserved11: u1,
            ///  Receiver timeout clear flag
            RTOCF: u1,
            ///  End of timeout clear flag
            EOBCF: u1,
            reserved17: u4,
            ///  Character match clear flag
            CMCF: u1,
            reserved20: u2,
            ///  Wakeup from Stop mode clear flag
            WUCF: u1,
            padding: u11,
        }),
        ///  Receive data register
        RDR: mmio.Mmio(packed struct(u32) {
            ///  Receive data value
            RDR: u9,
            padding: u23,
        }),
        ///  Transmit data register
        TDR: mmio.Mmio(packed struct(u32) {
            ///  Transmit data value
            TDR: u9,
            padding: u23,
        }),
    };

    ///  System configuration controller _Comparator and Operational amplifier
    pub const SYSCFG_COMP_OPAMP = extern struct {
        ///  configuration register 1
        SYSCFG_CFGR1: mmio.Mmio(packed struct(u32) {
            ///  Memory mapping selection bits
            MEM_MODE: u2,
            reserved5: u3,
            ///  USB interrupt remap
            USB_IT_RMP: u1,
            ///  Timer 1 ITR3 selection
            TIM1_ITR_RMP: u1,
            ///  DAC trigger remap (when TSEL = 001)
            DAC_TRIG_RMP: u1,
            ///  ADC24 DMA remapping bit
            ADC24_DMA_RMP: u1,
            reserved11: u2,
            ///  TIM16 DMA request remapping bit
            TIM16_DMA_RMP: u1,
            ///  TIM17 DMA request remapping bit
            TIM17_DMA_RMP: u1,
            ///  TIM6 and DAC1 DMA request remapping bit
            TIM6_DAC1_DMA_RMP: u1,
            ///  TIM7 and DAC2 DMA request remapping bit
            TIM7_DAC2_DMA_RMP: u1,
            reserved16: u1,
            ///  Fast Mode Plus (FM+) driving capability activation bits.
            I2C_PB6_FM: u1,
            ///  Fast Mode Plus (FM+) driving capability activation bits.
            I2C_PB7_FM: u1,
            ///  Fast Mode Plus (FM+) driving capability activation bits.
            I2C_PB8_FM: u1,
            ///  Fast Mode Plus (FM+) driving capability activation bits.
            I2C_PB9_FM: u1,
            ///  I2C1 Fast Mode Plus
            I2C1_FM: u1,
            ///  I2C2 Fast Mode Plus
            I2C2_FM: u1,
            ///  Encoder mode
            ENCODER_MODE: u2,
            reserved26: u2,
            ///  Interrupt enable bits from FPU
            FPU_IT: u6,
        }),
        ///  CCM SRAM protection register
        SYSCFG_RCR: mmio.Mmio(packed struct(u32) {
            ///  CCM SRAM page write protection bit
            PAGE0_WP: u1,
            ///  CCM SRAM page write protection bit
            PAGE1_WP: u1,
            ///  CCM SRAM page write protection bit
            PAGE2_WP: u1,
            ///  CCM SRAM page write protection bit
            PAGE3_WP: u1,
            ///  CCM SRAM page write protection bit
            PAGE4_WP: u1,
            ///  CCM SRAM page write protection bit
            PAGE5_WP: u1,
            ///  CCM SRAM page write protection bit
            PAGE6_WP: u1,
            ///  CCM SRAM page write protection bit
            PAGE7_WP: u1,
            padding: u24,
        }),
        ///  external interrupt configuration register 1
        SYSCFG_EXTICR1: mmio.Mmio(packed struct(u32) {
            ///  EXTI 0 configuration bits
            EXTI0: u4,
            ///  EXTI 1 configuration bits
            EXTI1: u4,
            ///  EXTI 2 configuration bits
            EXTI2: u4,
            ///  EXTI 3 configuration bits
            EXTI3: u4,
            padding: u16,
        }),
        ///  external interrupt configuration register 2
        SYSCFG_EXTICR2: mmio.Mmio(packed struct(u32) {
            ///  EXTI 4 configuration bits
            EXTI4: u4,
            ///  EXTI 5 configuration bits
            EXTI5: u4,
            ///  EXTI 6 configuration bits
            EXTI6: u4,
            ///  EXTI 7 configuration bits
            EXTI7: u4,
            padding: u16,
        }),
        ///  external interrupt configuration register 3
        SYSCFG_EXTICR3: mmio.Mmio(packed struct(u32) {
            ///  EXTI 8 configuration bits
            EXTI8: u4,
            ///  EXTI 9 configuration bits
            EXTI9: u4,
            ///  EXTI 10 configuration bits
            EXTI10: u4,
            ///  EXTI 11 configuration bits
            EXTI11: u4,
            padding: u16,
        }),
        ///  external interrupt configuration register 4
        SYSCFG_EXTICR4: mmio.Mmio(packed struct(u32) {
            ///  EXTI 12 configuration bits
            EXTI12: u4,
            ///  EXTI 13 configuration bits
            EXTI13: u4,
            ///  EXTI 14 configuration bits
            EXTI14: u4,
            ///  EXTI 15 configuration bits
            EXTI15: u4,
            padding: u16,
        }),
        ///  configuration register 2
        SYSCFG_CFGR2: mmio.Mmio(packed struct(u32) {
            ///  Cortex-M0 LOCKUP bit enable bit
            LOCUP_LOCK: u1,
            ///  SRAM parity lock bit
            SRAM_PARITY_LOCK: u1,
            ///  PVD lock enable bit
            PVD_LOCK: u1,
            reserved4: u1,
            ///  Bypass address bit 29 in parity calculation
            BYP_ADD_PAR: u1,
            reserved8: u3,
            ///  SRAM parity flag
            SRAM_PEF: u1,
            padding: u23,
        }),
        ///  control and status register
        COMP1_CSR: mmio.Mmio(packed struct(u32) {
            ///  Comparator 1 enable
            COMP1EN: u1,
            ///  COMP1_INP_DAC
            COMP1_INP_DAC: u1,
            ///  Comparator 1 mode
            COMP1MODE: u2,
            ///  Comparator 1 inverting input selection
            COMP1INSEL: u3,
            reserved10: u3,
            ///  Comparator 1 output selection
            COMP1_OUT_SEL: u4,
            reserved15: u1,
            ///  Comparator 1 output polarity
            COMP1POL: u1,
            ///  Comparator 1 hysteresis
            COMP1HYST: u2,
            ///  Comparator 1 blanking source
            COMP1_BLANKING: u3,
            reserved30: u9,
            ///  Comparator 1 output
            COMP1OUT: u1,
            ///  Comparator 1 lock
            COMP1LOCK: u1,
        }),
        ///  control and status register
        COMP2_CSR: mmio.Mmio(packed struct(u32) {
            ///  Comparator 2 enable
            COMP2EN: u1,
            reserved2: u1,
            ///  Comparator 2 mode
            COMP2MODE: u2,
            ///  Comparator 2 inverting input selection
            COMP2INSEL: u3,
            ///  Comparator 2 non inverted input selection
            COMP2INPSEL: u1,
            reserved9: u1,
            ///  Comparator 1inverting input selection
            COMP2INMSEL: u1,
            ///  Comparator 2 output selection
            COMP2_OUT_SEL: u4,
            reserved15: u1,
            ///  Comparator 2 output polarity
            COMP2POL: u1,
            ///  Comparator 2 hysteresis
            COMP2HYST: u2,
            ///  Comparator 2 blanking source
            COMP2_BLANKING: u3,
            reserved31: u10,
            ///  Comparator 2 lock
            COMP2LOCK: u1,
        }),
        ///  control and status register
        COMP3_CSR: mmio.Mmio(packed struct(u32) {
            ///  Comparator 3 enable
            COMP3EN: u1,
            reserved2: u1,
            ///  Comparator 3 mode
            COMP3MODE: u2,
            ///  Comparator 3 inverting input selection
            COMP3INSEL: u3,
            ///  Comparator 3 non inverted input selection
            COMP3INPSEL: u1,
            reserved10: u2,
            ///  Comparator 3 output selection
            COMP3_OUT_SEL: u4,
            reserved15: u1,
            ///  Comparator 3 output polarity
            COMP3POL: u1,
            ///  Comparator 3 hysteresis
            COMP3HYST: u2,
            ///  Comparator 3 blanking source
            COMP3_BLANKING: u3,
            reserved30: u9,
            ///  Comparator 3 output
            COMP3OUT: u1,
            ///  Comparator 3 lock
            COMP3LOCK: u1,
        }),
        ///  control and status register
        COMP4_CSR: mmio.Mmio(packed struct(u32) {
            ///  Comparator 4 enable
            COMP4EN: u1,
            reserved2: u1,
            ///  Comparator 4 mode
            COMP4MODE: u2,
            ///  Comparator 4 inverting input selection
            COMP4INSEL: u3,
            ///  Comparator 4 non inverted input selection
            COMP4INPSEL: u1,
            reserved9: u1,
            ///  Comparator 4 window mode
            COM4WINMODE: u1,
            ///  Comparator 4 output selection
            COMP4_OUT_SEL: u4,
            reserved15: u1,
            ///  Comparator 4 output polarity
            COMP4POL: u1,
            ///  Comparator 4 hysteresis
            COMP4HYST: u2,
            ///  Comparator 4 blanking source
            COMP4_BLANKING: u3,
            reserved30: u9,
            ///  Comparator 4 output
            COMP4OUT: u1,
            ///  Comparator 4 lock
            COMP4LOCK: u1,
        }),
        ///  control and status register
        COMP5_CSR: mmio.Mmio(packed struct(u32) {
            ///  Comparator 5 enable
            COMP5EN: u1,
            reserved2: u1,
            ///  Comparator 5 mode
            COMP5MODE: u2,
            ///  Comparator 5 inverting input selection
            COMP5INSEL: u3,
            ///  Comparator 5 non inverted input selection
            COMP5INPSEL: u1,
            reserved10: u2,
            ///  Comparator 5 output selection
            COMP5_OUT_SEL: u4,
            reserved15: u1,
            ///  Comparator 5 output polarity
            COMP5POL: u1,
            ///  Comparator 5 hysteresis
            COMP5HYST: u2,
            ///  Comparator 5 blanking source
            COMP5_BLANKING: u3,
            reserved30: u9,
            ///  Comparator51 output
            COMP5OUT: u1,
            ///  Comparator 5 lock
            COMP5LOCK: u1,
        }),
        ///  control and status register
        COMP6_CSR: mmio.Mmio(packed struct(u32) {
            ///  Comparator 6 enable
            COMP6EN: u1,
            reserved2: u1,
            ///  Comparator 6 mode
            COMP6MODE: u2,
            ///  Comparator 6 inverting input selection
            COMP6INSEL: u3,
            ///  Comparator 6 non inverted input selection
            COMP6INPSEL: u1,
            reserved9: u1,
            ///  Comparator 6 window mode
            COM6WINMODE: u1,
            ///  Comparator 6 output selection
            COMP6_OUT_SEL: u4,
            reserved15: u1,
            ///  Comparator 6 output polarity
            COMP6POL: u1,
            ///  Comparator 6 hysteresis
            COMP6HYST: u2,
            ///  Comparator 6 blanking source
            COMP6_BLANKING: u3,
            reserved30: u9,
            ///  Comparator 6 output
            COMP6OUT: u1,
            ///  Comparator 6 lock
            COMP6LOCK: u1,
        }),
        ///  control and status register
        COMP7_CSR: mmio.Mmio(packed struct(u32) {
            ///  Comparator 7 enable
            COMP7EN: u1,
            reserved2: u1,
            ///  Comparator 7 mode
            COMP7MODE: u2,
            ///  Comparator 7 inverting input selection
            COMP7INSEL: u3,
            ///  Comparator 7 non inverted input selection
            COMP7INPSEL: u1,
            reserved10: u2,
            ///  Comparator 7 output selection
            COMP7_OUT_SEL: u4,
            reserved15: u1,
            ///  Comparator 7 output polarity
            COMP7POL: u1,
            ///  Comparator 7 hysteresis
            COMP7HYST: u2,
            ///  Comparator 7 blanking source
            COMP7_BLANKING: u3,
            reserved30: u9,
            ///  Comparator 7 output
            COMP7OUT: u1,
            ///  Comparator 7 lock
            COMP7LOCK: u1,
        }),
        ///  control register
        OPAMP1_CSR: mmio.Mmio(packed struct(u32) {
            ///  OPAMP1 enable
            OPAMP1_EN: u1,
            ///  FORCE_VP
            FORCE_VP: u1,
            ///  OPAMP1 Non inverting input selection
            VP_SEL: u2,
            reserved5: u1,
            ///  OPAMP1 inverting input selection
            VM_SEL: u2,
            ///  Timer controlled Mux mode enable
            TCM_EN: u1,
            ///  OPAMP1 inverting input secondary selection
            VMS_SEL: u1,
            ///  OPAMP1 Non inverting input secondary selection
            VPS_SEL: u2,
            ///  Calibration mode enable
            CALON: u1,
            ///  Calibration selection
            CALSEL: u2,
            ///  Gain in PGA mode
            PGA_GAIN: u4,
            ///  User trimming enable
            USER_TRIM: u1,
            ///  Offset trimming value (PMOS)
            TRIMOFFSETP: u5,
            ///  Offset trimming value (NMOS)
            TRIMOFFSETN: u5,
            ///  TSTREF
            TSTREF: u1,
            ///  OPAMP 1 ouput status flag
            OUTCAL: u1,
            ///  OPAMP 1 lock
            LOCK: u1,
        }),
        ///  control register
        OPAMP2_CSR: mmio.Mmio(packed struct(u32) {
            ///  OPAMP2 enable
            OPAMP2EN: u1,
            ///  FORCE_VP
            FORCE_VP: u1,
            ///  OPAMP2 Non inverting input selection
            VP_SEL: u2,
            reserved5: u1,
            ///  OPAMP2 inverting input selection
            VM_SEL: u2,
            ///  Timer controlled Mux mode enable
            TCM_EN: u1,
            ///  OPAMP2 inverting input secondary selection
            VMS_SEL: u1,
            ///  OPAMP2 Non inverting input secondary selection
            VPS_SEL: u2,
            ///  Calibration mode enable
            CALON: u1,
            ///  Calibration selection
            CAL_SEL: u2,
            ///  Gain in PGA mode
            PGA_GAIN: u4,
            ///  User trimming enable
            USER_TRIM: u1,
            ///  Offset trimming value (PMOS)
            TRIMOFFSETP: u5,
            ///  Offset trimming value (NMOS)
            TRIMOFFSETN: u5,
            ///  TSTREF
            TSTREF: u1,
            ///  OPAMP 2 ouput status flag
            OUTCAL: u1,
            ///  OPAMP 2 lock
            LOCK: u1,
        }),
        ///  control register
        OPAMP3_CSR: mmio.Mmio(packed struct(u32) {
            ///  OPAMP3 enable
            OPAMP3EN: u1,
            ///  FORCE_VP
            FORCE_VP: u1,
            ///  OPAMP3 Non inverting input selection
            VP_SEL: u2,
            reserved5: u1,
            ///  OPAMP3 inverting input selection
            VM_SEL: u2,
            ///  Timer controlled Mux mode enable
            TCM_EN: u1,
            ///  OPAMP3 inverting input secondary selection
            VMS_SEL: u1,
            ///  OPAMP3 Non inverting input secondary selection
            VPS_SEL: u2,
            ///  Calibration mode enable
            CALON: u1,
            ///  Calibration selection
            CALSEL: u2,
            ///  Gain in PGA mode
            PGA_GAIN: u4,
            ///  User trimming enable
            USER_TRIM: u1,
            ///  Offset trimming value (PMOS)
            TRIMOFFSETP: u5,
            ///  Offset trimming value (NMOS)
            TRIMOFFSETN: u5,
            ///  TSTREF
            TSTREF: u1,
            ///  OPAMP 3 ouput status flag
            OUTCAL: u1,
            ///  OPAMP 3 lock
            LOCK: u1,
        }),
        ///  control register
        OPAMP4_CSR: mmio.Mmio(packed struct(u32) {
            ///  OPAMP4 enable
            OPAMP4EN: u1,
            ///  FORCE_VP
            FORCE_VP: u1,
            ///  OPAMP4 Non inverting input selection
            VP_SEL: u2,
            reserved5: u1,
            ///  OPAMP4 inverting input selection
            VM_SEL: u2,
            ///  Timer controlled Mux mode enable
            TCM_EN: u1,
            ///  OPAMP4 inverting input secondary selection
            VMS_SEL: u1,
            ///  OPAMP4 Non inverting input secondary selection
            VPS_SEL: u2,
            ///  Calibration mode enable
            CALON: u1,
            ///  Calibration selection
            CALSEL: u2,
            ///  Gain in PGA mode
            PGA_GAIN: u4,
            ///  User trimming enable
            USER_TRIM: u1,
            ///  Offset trimming value (PMOS)
            TRIMOFFSETP: u5,
            ///  Offset trimming value (NMOS)
            TRIMOFFSETN: u5,
            ///  TSTREF
            TSTREF: u1,
            ///  OPAMP 4 ouput status flag
            OUTCAL: u1,
            ///  OPAMP 4 lock
            LOCK: u1,
        }),
    };

    ///  Independent watchdog
    pub const IWDG = extern struct {
        ///  Key register
        KR: mmio.Mmio(packed struct(u32) {
            ///  Key value
            KEY: u16,
            padding: u16,
        }),
        ///  Prescaler register
        PR: mmio.Mmio(packed struct(u32) {
            ///  Prescaler divider
            PR: u3,
            padding: u29,
        }),
        ///  Reload register
        RLR: mmio.Mmio(packed struct(u32) {
            ///  Watchdog counter reload value
            RL: u12,
            padding: u20,
        }),
        ///  Status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Watchdog prescaler value update
            PVU: u1,
            ///  Watchdog counter reload value update
            RVU: u1,
            ///  Watchdog counter window value update
            WVU: u1,
            padding: u29,
        }),
        ///  Window register
        WINR: mmio.Mmio(packed struct(u32) {
            ///  Watchdog counter window value
            WIN: u12,
            padding: u20,
        }),
    };

    ///  Analog-to-Digital Converter
    pub const ADC1_2 = extern struct {
        ///  ADC Common status register
        CSR: mmio.Mmio(packed struct(u32) {
            ///  ADDRDY_MST
            ADDRDY_MST: u1,
            ///  EOSMP_MST
            EOSMP_MST: u1,
            ///  EOC_MST
            EOC_MST: u1,
            ///  EOS_MST
            EOS_MST: u1,
            ///  OVR_MST
            OVR_MST: u1,
            ///  JEOC_MST
            JEOC_MST: u1,
            ///  JEOS_MST
            JEOS_MST: u1,
            ///  AWD1_MST
            AWD1_MST: u1,
            ///  AWD2_MST
            AWD2_MST: u1,
            ///  AWD3_MST
            AWD3_MST: u1,
            ///  JQOVF_MST
            JQOVF_MST: u1,
            reserved16: u5,
            ///  ADRDY_SLV
            ADRDY_SLV: u1,
            ///  EOSMP_SLV
            EOSMP_SLV: u1,
            ///  End of regular conversion of the slave ADC
            EOC_SLV: u1,
            ///  End of regular sequence flag of the slave ADC
            EOS_SLV: u1,
            ///  Overrun flag of the slave ADC
            OVR_SLV: u1,
            ///  End of injected conversion flag of the slave ADC
            JEOC_SLV: u1,
            ///  End of injected sequence flag of the slave ADC
            JEOS_SLV: u1,
            ///  Analog watchdog 1 flag of the slave ADC
            AWD1_SLV: u1,
            ///  Analog watchdog 2 flag of the slave ADC
            AWD2_SLV: u1,
            ///  Analog watchdog 3 flag of the slave ADC
            AWD3_SLV: u1,
            ///  Injected Context Queue Overflow flag of the slave ADC
            JQOVF_SLV: u1,
            padding: u5,
        }),
        reserved8: [4]u8,
        ///  ADC common control register
        CCR: mmio.Mmio(packed struct(u32) {
            ///  Multi ADC mode selection
            MULT: u5,
            reserved8: u3,
            ///  Delay between 2 sampling phases
            DELAY: u4,
            reserved13: u1,
            ///  DMA configuration (for multi-ADC mode)
            DMACFG: u1,
            ///  Direct memory access mode for multi ADC mode
            MDMA: u2,
            ///  ADC clock mode
            CKMODE: u2,
            reserved22: u4,
            ///  VREFINT enable
            VREFEN: u1,
            ///  Temperature sensor enable
            TSEN: u1,
            ///  VBAT enable
            VBATEN: u1,
            padding: u7,
        }),
        ///  ADC common regular data register for dual and triple modes
        CDR: mmio.Mmio(packed struct(u32) {
            ///  Regular data of the master ADC
            RDATA_MST: u16,
            ///  Regular data of the slave ADC
            RDATA_SLV: u16,
        }),
    };

    ///  Window watchdog
    pub const WWDG = extern struct {
        ///  Control register
        CR: mmio.Mmio(packed struct(u32) {
            ///  7-bit counter
            T: u7,
            ///  Activation bit
            WDGA: u1,
            padding: u24,
        }),
        ///  Configuration register
        CFR: mmio.Mmio(packed struct(u32) {
            ///  7-bit window value
            W: u7,
            ///  Timer base
            WDGTB: u2,
            ///  Early wakeup interrupt
            EWI: u1,
            padding: u22,
        }),
        ///  Status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Early wakeup interrupt flag
            EWIF: u1,
            padding: u31,
        }),
    };

    ///  Serial peripheral interface/Inter-IC sound
    pub const SPI1 = extern struct {
        ///  control register 1
        CR1: mmio.Mmio(packed struct(u32) {
            ///  Clock phase
            CPHA: u1,
            ///  Clock polarity
            CPOL: u1,
            ///  Master selection
            MSTR: u1,
            ///  Baud rate control
            BR: u3,
            ///  SPI enable
            SPE: u1,
            ///  Frame format
            LSBFIRST: u1,
            ///  Internal slave select
            SSI: u1,
            ///  Software slave management
            SSM: u1,
            ///  Receive only
            RXONLY: u1,
            ///  CRC length
            CRCL: u1,
            ///  CRC transfer next
            CRCNEXT: u1,
            ///  Hardware CRC calculation enable
            CRCEN: u1,
            ///  Output enable in bidirectional mode
            BIDIOE: u1,
            ///  Bidirectional data mode enable
            BIDIMODE: u1,
            padding: u16,
        }),
        ///  control register 2
        CR2: mmio.Mmio(packed struct(u32) {
            ///  Rx buffer DMA enable
            RXDMAEN: u1,
            ///  Tx buffer DMA enable
            TXDMAEN: u1,
            ///  SS output enable
            SSOE: u1,
            ///  NSS pulse management
            NSSP: u1,
            ///  Frame format
            FRF: u1,
            ///  Error interrupt enable
            ERRIE: u1,
            ///  RX buffer not empty interrupt enable
            RXNEIE: u1,
            ///  Tx buffer empty interrupt enable
            TXEIE: u1,
            ///  Data size
            DS: u4,
            ///  FIFO reception threshold
            FRXTH: u1,
            ///  Last DMA transfer for reception
            LDMA_RX: u1,
            ///  Last DMA transfer for transmission
            LDMA_TX: u1,
            padding: u17,
        }),
        ///  status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Receive buffer not empty
            RXNE: u1,
            ///  Transmit buffer empty
            TXE: u1,
            ///  Channel side
            CHSIDE: u1,
            ///  Underrun flag
            UDR: u1,
            ///  CRC error flag
            CRCERR: u1,
            ///  Mode fault
            MODF: u1,
            ///  Overrun flag
            OVR: u1,
            ///  Busy flag
            BSY: u1,
            ///  TI frame format error
            TIFRFE: u1,
            ///  FIFO reception level
            FRLVL: u2,
            ///  FIFO transmission level
            FTLVL: u2,
            padding: u19,
        }),
        ///  data register
        DR: mmio.Mmio(packed struct(u32) {
            ///  Data register
            DR: u16,
            padding: u16,
        }),
        ///  CRC polynomial register
        CRCPR: mmio.Mmio(packed struct(u32) {
            ///  CRC polynomial register
            CRCPOLY: u16,
            padding: u16,
        }),
        ///  RX CRC register
        RXCRCR: mmio.Mmio(packed struct(u32) {
            ///  Rx CRC register
            RxCRC: u16,
            padding: u16,
        }),
        ///  TX CRC register
        TXCRCR: mmio.Mmio(packed struct(u32) {
            ///  Tx CRC register
            TxCRC: u16,
            padding: u16,
        }),
        ///  I2S configuration register
        I2SCFGR: mmio.Mmio(packed struct(u32) {
            ///  Channel length (number of bits per audio channel)
            CHLEN: u1,
            ///  Data length to be transferred
            DATLEN: u2,
            ///  Steady state clock polarity
            CKPOL: u1,
            ///  I2S standard selection
            I2SSTD: u2,
            reserved7: u1,
            ///  PCM frame synchronization
            PCMSYNC: u1,
            ///  I2S configuration mode
            I2SCFG: u2,
            ///  I2S Enable
            I2SE: u1,
            ///  I2S mode selection
            I2SMOD: u1,
            padding: u20,
        }),
        ///  I2S prescaler register
        I2SPR: mmio.Mmio(packed struct(u32) {
            ///  I2S Linear prescaler
            I2SDIV: u8,
            ///  Odd factor for the prescaler
            ODD: u1,
            ///  Master clock output enable
            MCKOE: u1,
            padding: u22,
        }),
    };

    ///  Real-time clock
    pub const RTC = extern struct {
        ///  time register
        TR: mmio.Mmio(packed struct(u32) {
            ///  Second units in BCD format
            SU: u4,
            ///  Second tens in BCD format
            ST: u3,
            reserved8: u1,
            ///  Minute units in BCD format
            MNU: u4,
            ///  Minute tens in BCD format
            MNT: u3,
            reserved16: u1,
            ///  Hour units in BCD format
            HU: u4,
            ///  Hour tens in BCD format
            HT: u2,
            ///  AM/PM notation
            PM: u1,
            padding: u9,
        }),
        ///  date register
        DR: mmio.Mmio(packed struct(u32) {
            ///  Date units in BCD format
            DU: u4,
            ///  Date tens in BCD format
            DT: u2,
            reserved8: u2,
            ///  Month units in BCD format
            MU: u4,
            ///  Month tens in BCD format
            MT: u1,
            ///  Week day units
            WDU: u3,
            ///  Year units in BCD format
            YU: u4,
            ///  Year tens in BCD format
            YT: u4,
            padding: u8,
        }),
        ///  control register
        CR: mmio.Mmio(packed struct(u32) {
            ///  Wakeup clock selection
            WCKSEL: u3,
            ///  Time-stamp event active edge
            TSEDGE: u1,
            ///  Reference clock detection enable (50 or 60 Hz)
            REFCKON: u1,
            ///  Bypass the shadow registers
            BYPSHAD: u1,
            ///  Hour format
            FMT: u1,
            reserved8: u1,
            ///  Alarm A enable
            ALRAE: u1,
            ///  Alarm B enable
            ALRBE: u1,
            ///  Wakeup timer enable
            WUTE: u1,
            ///  Time stamp enable
            TSE: u1,
            ///  Alarm A interrupt enable
            ALRAIE: u1,
            ///  Alarm B interrupt enable
            ALRBIE: u1,
            ///  Wakeup timer interrupt enable
            WUTIE: u1,
            ///  Time-stamp interrupt enable
            TSIE: u1,
            ///  Add 1 hour (summer time change)
            ADD1H: u1,
            ///  Subtract 1 hour (winter time change)
            SUB1H: u1,
            ///  Backup
            BKP: u1,
            ///  Calibration output selection
            COSEL: u1,
            ///  Output polarity
            POL: u1,
            ///  Output selection
            OSEL: u2,
            ///  Calibration output enable
            COE: u1,
            padding: u8,
        }),
        ///  initialization and status register
        ISR: mmio.Mmio(packed struct(u32) {
            ///  Alarm A write flag
            ALRAWF: u1,
            ///  Alarm B write flag
            ALRBWF: u1,
            ///  Wakeup timer write flag
            WUTWF: u1,
            ///  Shift operation pending
            SHPF: u1,
            ///  Initialization status flag
            INITS: u1,
            ///  Registers synchronization flag
            RSF: u1,
            ///  Initialization flag
            INITF: u1,
            ///  Initialization mode
            INIT: u1,
            ///  Alarm A flag
            ALRAF: u1,
            ///  Alarm B flag
            ALRBF: u1,
            ///  Wakeup timer flag
            WUTF: u1,
            ///  Time-stamp flag
            TSF: u1,
            ///  Time-stamp overflow flag
            TSOVF: u1,
            ///  Tamper detection flag
            TAMP1F: u1,
            ///  RTC_TAMP2 detection flag
            TAMP2F: u1,
            ///  RTC_TAMP3 detection flag
            TAMP3F: u1,
            ///  Recalibration pending Flag
            RECALPF: u1,
            padding: u15,
        }),
        ///  prescaler register
        PRER: mmio.Mmio(packed struct(u32) {
            ///  Synchronous prescaler factor
            PREDIV_S: u15,
            reserved16: u1,
            ///  Asynchronous prescaler factor
            PREDIV_A: u7,
            padding: u9,
        }),
        ///  wakeup timer register
        WUTR: mmio.Mmio(packed struct(u32) {
            ///  Wakeup auto-reload value bits
            WUT: u16,
            padding: u16,
        }),
        reserved28: [4]u8,
        ///  alarm A register
        ALRMAR: mmio.Mmio(packed struct(u32) {
            ///  Second units in BCD format
            SU: u4,
            ///  Second tens in BCD format
            ST: u3,
            ///  Alarm A seconds mask
            MSK1: u1,
            ///  Minute units in BCD format
            MNU: u4,
            ///  Minute tens in BCD format
            MNT: u3,
            ///  Alarm A minutes mask
            MSK2: u1,
            ///  Hour units in BCD format
            HU: u4,
            ///  Hour tens in BCD format
            HT: u2,
            ///  AM/PM notation
            PM: u1,
            ///  Alarm A hours mask
            MSK3: u1,
            ///  Date units or day in BCD format
            DU: u4,
            ///  Date tens in BCD format
            DT: u2,
            ///  Week day selection
            WDSEL: u1,
            ///  Alarm A date mask
            MSK4: u1,
        }),
        ///  alarm B register
        ALRMBR: mmio.Mmio(packed struct(u32) {
            ///  Second units in BCD format
            SU: u4,
            ///  Second tens in BCD format
            ST: u3,
            ///  Alarm B seconds mask
            MSK1: u1,
            ///  Minute units in BCD format
            MNU: u4,
            ///  Minute tens in BCD format
            MNT: u3,
            ///  Alarm B minutes mask
            MSK2: u1,
            ///  Hour units in BCD format
            HU: u4,
            ///  Hour tens in BCD format
            HT: u2,
            ///  AM/PM notation
            PM: u1,
            ///  Alarm B hours mask
            MSK3: u1,
            ///  Date units or day in BCD format
            DU: u4,
            ///  Date tens in BCD format
            DT: u2,
            ///  Week day selection
            WDSEL: u1,
            ///  Alarm B date mask
            MSK4: u1,
        }),
        ///  write protection register
        WPR: mmio.Mmio(packed struct(u32) {
            ///  Write protection key
            KEY: u8,
            padding: u24,
        }),
        ///  sub second register
        SSR: mmio.Mmio(packed struct(u32) {
            ///  Sub second value
            SS: u16,
            padding: u16,
        }),
        ///  shift control register
        SHIFTR: mmio.Mmio(packed struct(u32) {
            ///  Subtract a fraction of a second
            SUBFS: u15,
            reserved31: u16,
            ///  Add one second
            ADD1S: u1,
        }),
        ///  time stamp time register
        TSTR: mmio.Mmio(packed struct(u32) {
            ///  Second units in BCD format
            SU: u4,
            ///  Second tens in BCD format
            ST: u3,
            reserved8: u1,
            ///  Minute units in BCD format
            MNU: u4,
            ///  Minute tens in BCD format
            MNT: u3,
            reserved16: u1,
            ///  Hour units in BCD format
            HU: u4,
            ///  Hour tens in BCD format
            HT: u2,
            ///  AM/PM notation
            PM: u1,
            padding: u9,
        }),
        ///  time stamp date register
        TSDR: mmio.Mmio(packed struct(u32) {
            ///  Date units in BCD format
            DU: u4,
            ///  Date tens in BCD format
            DT: u2,
            reserved8: u2,
            ///  Month units in BCD format
            MU: u4,
            ///  Month tens in BCD format
            MT: u1,
            ///  Week day units
            WDU: u3,
            padding: u16,
        }),
        ///  timestamp sub second register
        TSSSR: mmio.Mmio(packed struct(u32) {
            ///  Sub second value
            SS: u16,
            padding: u16,
        }),
        ///  calibration register
        CALR: mmio.Mmio(packed struct(u32) {
            ///  Calibration minus
            CALM: u9,
            reserved13: u4,
            ///  Use a 16-second calibration cycle period
            CALW16: u1,
            ///  Use an 8-second calibration cycle period
            CALW8: u1,
            ///  Increase frequency of RTC by 488.5 ppm
            CALP: u1,
            padding: u16,
        }),
        ///  tamper and alternate function configuration register
        TAFCR: mmio.Mmio(packed struct(u32) {
            ///  Tamper 1 detection enable
            TAMP1E: u1,
            ///  Active level for tamper 1
            TAMP1TRG: u1,
            ///  Tamper interrupt enable
            TAMPIE: u1,
            ///  Tamper 2 detection enable
            TAMP2E: u1,
            ///  Active level for tamper 2
            TAMP2TRG: u1,
            ///  Tamper 3 detection enable
            TAMP3E: u1,
            ///  Active level for tamper 3
            TAMP3TRG: u1,
            ///  Activate timestamp on tamper detection event
            TAMPTS: u1,
            ///  Tamper sampling frequency
            TAMPFREQ: u3,
            ///  Tamper filter count
            TAMPFLT: u2,
            ///  Tamper precharge duration
            TAMPPRCH: u2,
            ///  TAMPER pull-up disable
            TAMPPUDIS: u1,
            reserved18: u2,
            ///  PC13 value
            PC13VALUE: u1,
            ///  PC13 mode
            PC13MODE: u1,
            ///  PC14 value
            PC14VALUE: u1,
            ///  PC 14 mode
            PC14MODE: u1,
            ///  PC15 value
            PC15VALUE: u1,
            ///  PC15 mode
            PC15MODE: u1,
            padding: u8,
        }),
        ///  alarm A sub second register
        ALRMASSR: mmio.Mmio(packed struct(u32) {
            ///  Sub seconds value
            SS: u15,
            reserved24: u9,
            ///  Mask the most-significant bits starting at this bit
            MASKSS: u4,
            padding: u4,
        }),
        ///  alarm B sub second register
        ALRMBSSR: mmio.Mmio(packed struct(u32) {
            ///  Sub seconds value
            SS: u15,
            reserved24: u9,
            ///  Mask the most-significant bits starting at this bit
            MASKSS: u4,
            padding: u4,
        }),
        reserved80: [4]u8,
        ///  backup register
        BKP0R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP1R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP2R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP3R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP4R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP5R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP6R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP7R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP8R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP9R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP10R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP11R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP12R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP13R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP14R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP15R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP16R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP17R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP18R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP19R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP20R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP21R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP22R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP23R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP24R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP25R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP26R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP27R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP28R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP29R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP30R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
        ///  backup register
        BKP31R: mmio.Mmio(packed struct(u32) {
            ///  BKP
            BKP: u32,
        }),
    };

    ///  Basic timers
    pub const TIM6 = extern struct {
        ///  control register 1
        CR1: mmio.Mmio(packed struct(u32) {
            ///  Counter enable
            CEN: u1,
            ///  Update disable
            UDIS: u1,
            ///  Update request source
            URS: u1,
            ///  One-pulse mode
            OPM: u1,
            reserved7: u3,
            ///  Auto-reload preload enable
            ARPE: u1,
            reserved11: u3,
            ///  UIF status bit remapping
            UIFREMAP: u1,
            padding: u20,
        }),
        ///  control register 2
        CR2: mmio.Mmio(packed struct(u32) {
            reserved4: u4,
            ///  Master mode selection
            MMS: u3,
            padding: u25,
        }),
        reserved12: [4]u8,
        ///  DMA/Interrupt enable register
        DIER: mmio.Mmio(packed struct(u32) {
            ///  Update interrupt enable
            UIE: u1,
            reserved8: u7,
            ///  Update DMA request enable
            UDE: u1,
            padding: u23,
        }),
        ///  status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Update interrupt flag
            UIF: u1,
            padding: u31,
        }),
        ///  event generation register
        EGR: mmio.Mmio(packed struct(u32) {
            ///  Update generation
            UG: u1,
            padding: u31,
        }),
        reserved36: [12]u8,
        ///  counter
        CNT: mmio.Mmio(packed struct(u32) {
            ///  Low counter value
            CNT: u16,
            reserved31: u15,
            ///  UIF Copy
            UIFCPY: u1,
        }),
        ///  prescaler
        PSC: mmio.Mmio(packed struct(u32) {
            ///  Prescaler value
            PSC: u16,
            padding: u16,
        }),
        ///  auto-reload register
        ARR: mmio.Mmio(packed struct(u32) {
            ///  Low Auto-reload value
            ARR: u16,
            padding: u16,
        }),
    };

    ///  Analog-to-Digital Converter
    pub const ADC1 = extern struct {
        ///  interrupt and status register
        ISR: mmio.Mmio(packed struct(u32) {
            ///  ADRDY
            ADRDY: u1,
            ///  EOSMP
            EOSMP: u1,
            ///  EOC
            EOC: u1,
            ///  EOS
            EOS: u1,
            ///  OVR
            OVR: u1,
            ///  JEOC
            JEOC: u1,
            ///  JEOS
            JEOS: u1,
            ///  AWD1
            AWD1: u1,
            ///  AWD2
            AWD2: u1,
            ///  AWD3
            AWD3: u1,
            ///  JQOVF
            JQOVF: u1,
            padding: u21,
        }),
        ///  interrupt enable register
        IER: mmio.Mmio(packed struct(u32) {
            ///  ADRDYIE
            ADRDYIE: u1,
            ///  EOSMPIE
            EOSMPIE: u1,
            ///  EOCIE
            EOCIE: u1,
            ///  EOSIE
            EOSIE: u1,
            ///  OVRIE
            OVRIE: u1,
            ///  JEOCIE
            JEOCIE: u1,
            ///  JEOSIE
            JEOSIE: u1,
            ///  AWD1IE
            AWD1IE: u1,
            ///  AWD2IE
            AWD2IE: u1,
            ///  AWD3IE
            AWD3IE: u1,
            ///  JQOVFIE
            JQOVFIE: u1,
            padding: u21,
        }),
        ///  control register
        CR: mmio.Mmio(packed struct(u32) {
            ///  ADEN
            ADEN: u1,
            ///  ADDIS
            ADDIS: u1,
            ///  ADSTART
            ADSTART: u1,
            ///  JADSTART
            JADSTART: u1,
            ///  ADSTP
            ADSTP: u1,
            ///  JADSTP
            JADSTP: u1,
            reserved28: u22,
            ///  ADVREGEN
            ADVREGEN: u1,
            ///  DEEPPWD
            DEEPPWD: u1,
            ///  ADCALDIF
            ADCALDIF: u1,
            ///  ADCAL
            ADCAL: u1,
        }),
        ///  configuration register
        CFGR: mmio.Mmio(packed struct(u32) {
            ///  DMAEN
            DMAEN: u1,
            ///  DMACFG
            DMACFG: u1,
            reserved3: u1,
            ///  RES
            RES: u2,
            ///  ALIGN
            ALIGN: u1,
            ///  EXTSEL
            EXTSEL: u4,
            ///  EXTEN
            EXTEN: u2,
            ///  OVRMOD
            OVRMOD: u1,
            ///  CONT
            CONT: u1,
            ///  AUTDLY
            AUTDLY: u1,
            ///  AUTOFF
            AUTOFF: u1,
            ///  DISCEN
            DISCEN: u1,
            ///  DISCNUM
            DISCNUM: u3,
            ///  JDISCEN
            JDISCEN: u1,
            ///  JQM
            JQM: u1,
            ///  AWD1SGL
            AWD1SGL: u1,
            ///  AWD1EN
            AWD1EN: u1,
            ///  JAWD1EN
            JAWD1EN: u1,
            ///  JAUTO
            JAUTO: u1,
            ///  AWDCH1CH
            AWDCH1CH: u5,
            padding: u1,
        }),
        reserved20: [4]u8,
        ///  sample time register 1
        SMPR1: mmio.Mmio(packed struct(u32) {
            reserved3: u3,
            ///  SMP1
            SMP1: u3,
            ///  SMP2
            SMP2: u3,
            ///  SMP3
            SMP3: u3,
            ///  SMP4
            SMP4: u3,
            ///  SMP5
            SMP5: u3,
            ///  SMP6
            SMP6: u3,
            ///  SMP7
            SMP7: u3,
            ///  SMP8
            SMP8: u3,
            ///  SMP9
            SMP9: u3,
            padding: u2,
        }),
        ///  sample time register 2
        SMPR2: mmio.Mmio(packed struct(u32) {
            ///  SMP10
            SMP10: u3,
            ///  SMP11
            SMP11: u3,
            ///  SMP12
            SMP12: u3,
            ///  SMP13
            SMP13: u3,
            ///  SMP14
            SMP14: u3,
            ///  SMP15
            SMP15: u3,
            ///  SMP16
            SMP16: u3,
            ///  SMP17
            SMP17: u3,
            ///  SMP18
            SMP18: u3,
            padding: u5,
        }),
        reserved32: [4]u8,
        ///  watchdog threshold register 1
        TR1: mmio.Mmio(packed struct(u32) {
            ///  LT1
            LT1: u12,
            reserved16: u4,
            ///  HT1
            HT1: u12,
            padding: u4,
        }),
        ///  watchdog threshold register
        TR2: mmio.Mmio(packed struct(u32) {
            ///  LT2
            LT2: u8,
            reserved16: u8,
            ///  HT2
            HT2: u8,
            padding: u8,
        }),
        ///  watchdog threshold register 3
        TR3: mmio.Mmio(packed struct(u32) {
            ///  LT3
            LT3: u8,
            reserved16: u8,
            ///  HT3
            HT3: u8,
            padding: u8,
        }),
        reserved48: [4]u8,
        ///  regular sequence register 1
        SQR1: mmio.Mmio(packed struct(u32) {
            ///  L3
            L3: u4,
            reserved6: u2,
            ///  SQ1
            SQ1: u5,
            reserved12: u1,
            ///  SQ2
            SQ2: u5,
            reserved18: u1,
            ///  SQ3
            SQ3: u5,
            reserved24: u1,
            ///  SQ4
            SQ4: u5,
            padding: u3,
        }),
        ///  regular sequence register 2
        SQR2: mmio.Mmio(packed struct(u32) {
            ///  SQ5
            SQ5: u5,
            reserved6: u1,
            ///  SQ6
            SQ6: u5,
            reserved12: u1,
            ///  SQ7
            SQ7: u5,
            reserved18: u1,
            ///  SQ8
            SQ8: u5,
            reserved24: u1,
            ///  SQ9
            SQ9: u5,
            padding: u3,
        }),
        ///  regular sequence register 3
        SQR3: mmio.Mmio(packed struct(u32) {
            ///  SQ10
            SQ10: u5,
            reserved6: u1,
            ///  SQ11
            SQ11: u5,
            reserved12: u1,
            ///  SQ12
            SQ12: u5,
            reserved18: u1,
            ///  SQ13
            SQ13: u5,
            reserved24: u1,
            ///  SQ14
            SQ14: u5,
            padding: u3,
        }),
        ///  regular sequence register 4
        SQR4: mmio.Mmio(packed struct(u32) {
            ///  SQ15
            SQ15: u5,
            reserved6: u1,
            ///  SQ16
            SQ16: u5,
            padding: u21,
        }),
        ///  regular Data Register
        DR: mmio.Mmio(packed struct(u32) {
            ///  regularDATA
            regularDATA: u16,
            padding: u16,
        }),
        reserved76: [8]u8,
        ///  injected sequence register
        JSQR: mmio.Mmio(packed struct(u32) {
            ///  JL
            JL: u2,
            ///  JEXTSEL
            JEXTSEL: u4,
            ///  JEXTEN
            JEXTEN: u2,
            ///  JSQ1
            JSQ1: u5,
            reserved14: u1,
            ///  JSQ2
            JSQ2: u5,
            reserved20: u1,
            ///  JSQ3
            JSQ3: u5,
            reserved26: u1,
            ///  JSQ4
            JSQ4: u5,
            padding: u1,
        }),
        reserved96: [16]u8,
        ///  offset register 1
        OFR1: mmio.Mmio(packed struct(u32) {
            ///  OFFSET1
            OFFSET1: u12,
            reserved26: u14,
            ///  OFFSET1_CH
            OFFSET1_CH: u5,
            ///  OFFSET1_EN
            OFFSET1_EN: u1,
        }),
        ///  offset register 2
        OFR2: mmio.Mmio(packed struct(u32) {
            ///  OFFSET2
            OFFSET2: u12,
            reserved26: u14,
            ///  OFFSET2_CH
            OFFSET2_CH: u5,
            ///  OFFSET2_EN
            OFFSET2_EN: u1,
        }),
        ///  offset register 3
        OFR3: mmio.Mmio(packed struct(u32) {
            ///  OFFSET3
            OFFSET3: u12,
            reserved26: u14,
            ///  OFFSET3_CH
            OFFSET3_CH: u5,
            ///  OFFSET3_EN
            OFFSET3_EN: u1,
        }),
        ///  offset register 4
        OFR4: mmio.Mmio(packed struct(u32) {
            ///  OFFSET4
            OFFSET4: u12,
            reserved26: u14,
            ///  OFFSET4_CH
            OFFSET4_CH: u5,
            ///  OFFSET4_EN
            OFFSET4_EN: u1,
        }),
        reserved128: [16]u8,
        ///  injected data register 1
        JDR1: mmio.Mmio(packed struct(u32) {
            ///  JDATA1
            JDATA1: u16,
            padding: u16,
        }),
        ///  injected data register 2
        JDR2: mmio.Mmio(packed struct(u32) {
            ///  JDATA2
            JDATA2: u16,
            padding: u16,
        }),
        ///  injected data register 3
        JDR3: mmio.Mmio(packed struct(u32) {
            ///  JDATA3
            JDATA3: u16,
            padding: u16,
        }),
        ///  injected data register 4
        JDR4: mmio.Mmio(packed struct(u32) {
            ///  JDATA4
            JDATA4: u16,
            padding: u16,
        }),
        reserved160: [16]u8,
        ///  Analog Watchdog 2 Configuration Register
        AWD2CR: mmio.Mmio(packed struct(u32) {
            reserved1: u1,
            ///  AWD2CH
            AWD2CH: u18,
            padding: u13,
        }),
        ///  Analog Watchdog 3 Configuration Register
        AWD3CR: mmio.Mmio(packed struct(u32) {
            reserved1: u1,
            ///  AWD3CH
            AWD3CH: u18,
            padding: u13,
        }),
        reserved176: [8]u8,
        ///  Differential Mode Selection Register 2
        DIFSEL: mmio.Mmio(packed struct(u32) {
            reserved1: u1,
            ///  Differential mode for channels 15 to 1
            DIFSEL_1_15: u15,
            ///  Differential mode for channels 18 to 16
            DIFSEL_16_18: u3,
            padding: u13,
        }),
        ///  Calibration Factors
        CALFACT: mmio.Mmio(packed struct(u32) {
            ///  CALFACT_S
            CALFACT_S: u7,
            reserved16: u9,
            ///  CALFACT_D
            CALFACT_D: u7,
            padding: u9,
        }),
    };

    ///  Advanced-timers
    pub const TIM8 = extern struct {
        ///  control register 1
        CR1: mmio.Mmio(packed struct(u32) {
            ///  Counter enable
            CEN: u1,
            ///  Update disable
            UDIS: u1,
            ///  Update request source
            URS: u1,
            ///  One-pulse mode
            OPM: u1,
            ///  Direction
            DIR: u1,
            ///  Center-aligned mode selection
            CMS: u2,
            ///  Auto-reload preload enable
            ARPE: u1,
            ///  Clock division
            CKD: u2,
            reserved11: u1,
            ///  UIF status bit remapping
            UIFREMAP: u1,
            padding: u20,
        }),
        ///  control register 2
        CR2: mmio.Mmio(packed struct(u32) {
            ///  Capture/compare preloaded control
            CCPC: u1,
            reserved2: u1,
            ///  Capture/compare control update selection
            CCUS: u1,
            ///  Capture/compare DMA selection
            CCDS: u1,
            ///  Master mode selection
            MMS: u3,
            ///  TI1 selection
            TI1S: u1,
            ///  Output Idle state 1
            OIS1: u1,
            ///  Output Idle state 1
            OIS1N: u1,
            ///  Output Idle state 2
            OIS2: u1,
            ///  Output Idle state 2
            OIS2N: u1,
            ///  Output Idle state 3
            OIS3: u1,
            ///  Output Idle state 3
            OIS3N: u1,
            ///  Output Idle state 4
            OIS4: u1,
            reserved16: u1,
            ///  Output Idle state 5
            OIS5: u1,
            reserved18: u1,
            ///  Output Idle state 6
            OIS6: u1,
            reserved20: u1,
            ///  Master mode selection 2
            MMS2: u4,
            padding: u8,
        }),
        ///  slave mode control register
        SMCR: mmio.Mmio(packed struct(u32) {
            ///  Slave mode selection
            SMS: u3,
            ///  OCREF clear selection
            OCCS: u1,
            ///  Trigger selection
            TS: u3,
            ///  Master/Slave mode
            MSM: u1,
            ///  External trigger filter
            ETF: u4,
            ///  External trigger prescaler
            ETPS: u2,
            ///  External clock enable
            ECE: u1,
            ///  External trigger polarity
            ETP: u1,
            ///  Slave mode selection bit 3
            SMS3: u1,
            padding: u15,
        }),
        ///  DMA/Interrupt enable register
        DIER: mmio.Mmio(packed struct(u32) {
            ///  Update interrupt enable
            UIE: u1,
            ///  Capture/Compare 1 interrupt enable
            CC1IE: u1,
            ///  Capture/Compare 2 interrupt enable
            CC2IE: u1,
            ///  Capture/Compare 3 interrupt enable
            CC3IE: u1,
            ///  Capture/Compare 4 interrupt enable
            CC4IE: u1,
            ///  COM interrupt enable
            COMIE: u1,
            ///  Trigger interrupt enable
            TIE: u1,
            ///  Break interrupt enable
            BIE: u1,
            ///  Update DMA request enable
            UDE: u1,
            ///  Capture/Compare 1 DMA request enable
            CC1DE: u1,
            ///  Capture/Compare 2 DMA request enable
            CC2DE: u1,
            ///  Capture/Compare 3 DMA request enable
            CC3DE: u1,
            ///  Capture/Compare 4 DMA request enable
            CC4DE: u1,
            ///  COM DMA request enable
            COMDE: u1,
            ///  Trigger DMA request enable
            TDE: u1,
            padding: u17,
        }),
        ///  status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Update interrupt flag
            UIF: u1,
            ///  Capture/compare 1 interrupt flag
            CC1IF: u1,
            ///  Capture/Compare 2 interrupt flag
            CC2IF: u1,
            ///  Capture/Compare 3 interrupt flag
            CC3IF: u1,
            ///  Capture/Compare 4 interrupt flag
            CC4IF: u1,
            ///  COM interrupt flag
            COMIF: u1,
            ///  Trigger interrupt flag
            TIF: u1,
            ///  Break interrupt flag
            BIF: u1,
            ///  Break 2 interrupt flag
            B2IF: u1,
            ///  Capture/Compare 1 overcapture flag
            CC1OF: u1,
            ///  Capture/compare 2 overcapture flag
            CC2OF: u1,
            ///  Capture/Compare 3 overcapture flag
            CC3OF: u1,
            ///  Capture/Compare 4 overcapture flag
            CC4OF: u1,
            reserved16: u3,
            ///  Capture/Compare 5 interrupt flag
            C5IF: u1,
            ///  Capture/Compare 6 interrupt flag
            C6IF: u1,
            padding: u14,
        }),
        ///  event generation register
        EGR: mmio.Mmio(packed struct(u32) {
            ///  Update generation
            UG: u1,
            ///  Capture/compare 1 generation
            CC1G: u1,
            ///  Capture/compare 2 generation
            CC2G: u1,
            ///  Capture/compare 3 generation
            CC3G: u1,
            ///  Capture/compare 4 generation
            CC4G: u1,
            ///  Capture/Compare control update generation
            COMG: u1,
            ///  Trigger generation
            TG: u1,
            ///  Break generation
            BG: u1,
            ///  Break 2 generation
            B2G: u1,
            padding: u23,
        }),
        ///  capture/compare mode register (output mode)
        CCMR1_Output: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 selection
            CC1S: u2,
            ///  Output Compare 1 fast enable
            OC1FE: u1,
            ///  Output Compare 1 preload enable
            OC1PE: u1,
            ///  Output Compare 1 mode
            OC1M: u3,
            ///  Output Compare 1 clear enable
            OC1CE: u1,
            ///  Capture/Compare 2 selection
            CC2S: u2,
            ///  Output Compare 2 fast enable
            OC2FE: u1,
            ///  Output Compare 2 preload enable
            OC2PE: u1,
            ///  Output Compare 2 mode
            OC2M: u3,
            ///  Output Compare 2 clear enable
            OC2CE: u1,
            ///  Output Compare 1 mode bit 3
            OC1M_3: u1,
            reserved24: u7,
            ///  Output Compare 2 mode bit 3
            OC2M_3: u1,
            padding: u7,
        }),
        ///  capture/compare mode register (output mode)
        CCMR2_Output: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 3 selection
            CC3S: u2,
            ///  Output compare 3 fast enable
            OC3FE: u1,
            ///  Output compare 3 preload enable
            OC3PE: u1,
            ///  Output compare 3 mode
            OC3M: u3,
            ///  Output compare 3 clear enable
            OC3CE: u1,
            ///  Capture/Compare 4 selection
            CC4S: u2,
            ///  Output compare 4 fast enable
            OC4FE: u1,
            ///  Output compare 4 preload enable
            OC4PE: u1,
            ///  Output compare 4 mode
            OC4M: u3,
            ///  Output compare 4 clear enable
            OC4CE: u1,
            ///  Output Compare 3 mode bit 3
            OC3M_3: u1,
            reserved24: u7,
            ///  Output Compare 4 mode bit 3
            OC4M_3: u1,
            padding: u7,
        }),
        ///  capture/compare enable register
        CCER: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 output enable
            CC1E: u1,
            ///  Capture/Compare 1 output Polarity
            CC1P: u1,
            ///  Capture/Compare 1 complementary output enable
            CC1NE: u1,
            ///  Capture/Compare 1 output Polarity
            CC1NP: u1,
            ///  Capture/Compare 2 output enable
            CC2E: u1,
            ///  Capture/Compare 2 output Polarity
            CC2P: u1,
            ///  Capture/Compare 2 complementary output enable
            CC2NE: u1,
            ///  Capture/Compare 2 output Polarity
            CC2NP: u1,
            ///  Capture/Compare 3 output enable
            CC3E: u1,
            ///  Capture/Compare 3 output Polarity
            CC3P: u1,
            ///  Capture/Compare 3 complementary output enable
            CC3NE: u1,
            ///  Capture/Compare 3 output Polarity
            CC3NP: u1,
            ///  Capture/Compare 4 output enable
            CC4E: u1,
            ///  Capture/Compare 3 output Polarity
            CC4P: u1,
            reserved15: u1,
            ///  Capture/Compare 4 output Polarity
            CC4NP: u1,
            ///  Capture/Compare 5 output enable
            CC5E: u1,
            ///  Capture/Compare 5 output Polarity
            CC5P: u1,
            reserved20: u2,
            ///  Capture/Compare 6 output enable
            CC6E: u1,
            ///  Capture/Compare 6 output Polarity
            CC6P: u1,
            padding: u10,
        }),
        ///  counter
        CNT: mmio.Mmio(packed struct(u32) {
            ///  counter value
            CNT: u16,
            reserved31: u15,
            ///  UIF copy
            UIFCPY: u1,
        }),
        ///  prescaler
        PSC: mmio.Mmio(packed struct(u32) {
            ///  Prescaler value
            PSC: u16,
            padding: u16,
        }),
        ///  auto-reload register
        ARR: mmio.Mmio(packed struct(u32) {
            ///  Auto-reload value
            ARR: u16,
            padding: u16,
        }),
        ///  repetition counter register
        RCR: mmio.Mmio(packed struct(u32) {
            ///  Repetition counter value
            REP: u16,
            padding: u16,
        }),
        ///  capture/compare register 1
        CCR1: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 value
            CCR1: u16,
            padding: u16,
        }),
        ///  capture/compare register 2
        CCR2: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 2 value
            CCR2: u16,
            padding: u16,
        }),
        ///  capture/compare register 3
        CCR3: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 3 value
            CCR3: u16,
            padding: u16,
        }),
        ///  capture/compare register 4
        CCR4: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 3 value
            CCR4: u16,
            padding: u16,
        }),
        ///  break and dead-time register
        BDTR: mmio.Mmio(packed struct(u32) {
            ///  Dead-time generator setup
            DTG: u8,
            ///  Lock configuration
            LOCK: u2,
            ///  Off-state selection for Idle mode
            OSSI: u1,
            ///  Off-state selection for Run mode
            OSSR: u1,
            ///  Break enable
            BKE: u1,
            ///  Break polarity
            BKP: u1,
            ///  Automatic output enable
            AOE: u1,
            ///  Main output enable
            MOE: u1,
            ///  Break filter
            BKF: u4,
            ///  Break 2 filter
            BK2F: u4,
            ///  Break 2 enable
            BK2E: u1,
            ///  Break 2 polarity
            BK2P: u1,
            padding: u6,
        }),
        ///  DMA control register
        DCR: mmio.Mmio(packed struct(u32) {
            ///  DMA base address
            DBA: u5,
            reserved8: u3,
            ///  DMA burst length
            DBL: u5,
            padding: u19,
        }),
        ///  DMA address for full transfer
        DMAR: mmio.Mmio(packed struct(u32) {
            ///  DMA register for burst accesses
            DMAB: u16,
            padding: u16,
        }),
        reserved84: [4]u8,
        ///  capture/compare mode register 3 (output mode)
        CCMR3_Output: mmio.Mmio(packed struct(u32) {
            reserved2: u2,
            ///  Output compare 5 fast enable
            OC5FE: u1,
            ///  Output compare 5 preload enable
            OC5PE: u1,
            ///  Output compare 5 mode
            OC5M: u3,
            ///  Output compare 5 clear enable
            OC5CE: u1,
            reserved10: u2,
            ///  Output compare 6 fast enable
            OC6FE: u1,
            ///  Output compare 6 preload enable
            OC6PE: u1,
            ///  Output compare 6 mode
            OC6M: u3,
            ///  Output compare 6 clear enable
            OC6CE: u1,
            ///  Outout Compare 5 mode bit 3
            OC5M_3: u1,
            reserved24: u7,
            ///  Outout Compare 6 mode bit 3
            OC6M_3: u1,
            padding: u7,
        }),
        ///  capture/compare register 5
        CCR5: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 5 value
            CCR5: u16,
            reserved29: u13,
            ///  Group Channel 5 and Channel 1
            GC5C1: u1,
            ///  Group Channel 5 and Channel 2
            GC5C2: u1,
            ///  Group Channel 5 and Channel 3
            GC5C3: u1,
        }),
        ///  capture/compare register 6
        CCR6: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 6 value
            CCR6: u16,
            padding: u16,
        }),
        ///  option registers
        OR: mmio.Mmio(packed struct(u32) {
            ///  TIM8_ETR_ADC2 remapping capability
            TIM8_ETR_ADC2_RMP: u2,
            ///  TIM8_ETR_ADC3 remapping capability
            TIM8_ETR_ADC3_RMP: u2,
            padding: u28,
        }),
    };

    ///  Digital-to-analog converter
    pub const DAC = extern struct {
        ///  control register
        CR: mmio.Mmio(packed struct(u32) {
            ///  DAC channel1 enable
            EN1: u1,
            ///  DAC channel1 output buffer disable
            BOFF1: u1,
            ///  DAC channel1 trigger enable
            TEN1: u1,
            ///  DAC channel1 trigger selection
            TSEL1: u3,
            ///  DAC channel1 noise/triangle wave generation enable
            WAVE1: u2,
            ///  DAC channel1 mask/amplitude selector
            MAMP1: u4,
            ///  DAC channel1 DMA enable
            DMAEN1: u1,
            ///  DAC channel1 DMA Underrun Interrupt enable
            DMAUDRIE1: u1,
            reserved16: u2,
            ///  DAC channel2 enable
            EN2: u1,
            ///  DAC channel2 output buffer disable
            BOFF2: u1,
            ///  DAC channel2 trigger enable
            TEN2: u1,
            ///  DAC channel2 trigger selection
            TSEL2: u3,
            ///  DAC channel2 noise/triangle wave generation enable
            WAVE2: u2,
            ///  DAC channel2 mask/amplitude selector
            MAMP2: u4,
            ///  DAC channel2 DMA enable
            DMAEN2: u1,
            ///  DAC channel2 DMA underrun interrupt enable
            DMAUDRIE2: u1,
            padding: u2,
        }),
        ///  software trigger register
        SWTRIGR: mmio.Mmio(packed struct(u32) {
            ///  DAC channel1 software trigger
            SWTRIG1: u1,
            ///  DAC channel2 software trigger
            SWTRIG2: u1,
            padding: u30,
        }),
        ///  channel1 12-bit right-aligned data holding register
        DHR12R1: mmio.Mmio(packed struct(u32) {
            ///  DAC channel1 12-bit right-aligned data
            DACC1DHR: u12,
            padding: u20,
        }),
        ///  channel1 12-bit left aligned data holding register
        DHR12L1: mmio.Mmio(packed struct(u32) {
            reserved4: u4,
            ///  DAC channel1 12-bit left-aligned data
            DACC1DHR: u12,
            padding: u16,
        }),
        ///  channel1 8-bit right aligned data holding register
        DHR8R1: mmio.Mmio(packed struct(u32) {
            ///  DAC channel1 8-bit right-aligned data
            DACC1DHR: u8,
            padding: u24,
        }),
        ///  channel2 12-bit right aligned data holding register
        DHR12R2: mmio.Mmio(packed struct(u32) {
            ///  DAC channel2 12-bit right-aligned data
            DACC2DHR: u12,
            padding: u20,
        }),
        ///  channel2 12-bit left aligned data holding register
        DHR12L2: mmio.Mmio(packed struct(u32) {
            reserved4: u4,
            ///  DAC channel2 12-bit left-aligned data
            DACC2DHR: u12,
            padding: u16,
        }),
        ///  channel2 8-bit right-aligned data holding register
        DHR8R2: mmio.Mmio(packed struct(u32) {
            ///  DAC channel2 8-bit right-aligned data
            DACC2DHR: u8,
            padding: u24,
        }),
        ///  Dual DAC 12-bit right-aligned data holding register
        DHR12RD: mmio.Mmio(packed struct(u32) {
            ///  DAC channel1 12-bit right-aligned data
            DACC1DHR: u12,
            reserved16: u4,
            ///  DAC channel2 12-bit right-aligned data
            DACC2DHR: u12,
            padding: u4,
        }),
        ///  DUAL DAC 12-bit left aligned data holding register
        DHR12LD: mmio.Mmio(packed struct(u32) {
            reserved4: u4,
            ///  DAC channel1 12-bit left-aligned data
            DACC1DHR: u12,
            reserved20: u4,
            ///  DAC channel2 12-bit left-aligned data
            DACC2DHR: u12,
        }),
        ///  DUAL DAC 8-bit right aligned data holding register
        DHR8RD: mmio.Mmio(packed struct(u32) {
            ///  DAC channel1 8-bit right-aligned data
            DACC1DHR: u8,
            ///  DAC channel2 8-bit right-aligned data
            DACC2DHR: u8,
            padding: u16,
        }),
        ///  channel1 data output register
        DOR1: mmio.Mmio(packed struct(u32) {
            ///  DAC channel1 data output
            DACC1DOR: u12,
            padding: u20,
        }),
        ///  channel2 data output register
        DOR2: mmio.Mmio(packed struct(u32) {
            ///  DAC channel2 data output
            DACC2DOR: u12,
            padding: u20,
        }),
        ///  status register
        SR: mmio.Mmio(packed struct(u32) {
            reserved13: u13,
            ///  DAC channel1 DMA underrun flag
            DMAUDR1: u1,
            reserved29: u15,
            ///  DAC channel2 DMA underrun flag
            DMAUDR2: u1,
            padding: u2,
        }),
    };

    ///  External interrupt/event controller
    pub const EXTI = extern struct {
        ///  Interrupt mask register
        IMR1: mmio.Mmio(packed struct(u32) {
            ///  Interrupt Mask on line 0
            MR0: u1,
            ///  Interrupt Mask on line 1
            MR1: u1,
            ///  Interrupt Mask on line 2
            MR2: u1,
            ///  Interrupt Mask on line 3
            MR3: u1,
            ///  Interrupt Mask on line 4
            MR4: u1,
            ///  Interrupt Mask on line 5
            MR5: u1,
            ///  Interrupt Mask on line 6
            MR6: u1,
            ///  Interrupt Mask on line 7
            MR7: u1,
            ///  Interrupt Mask on line 8
            MR8: u1,
            ///  Interrupt Mask on line 9
            MR9: u1,
            ///  Interrupt Mask on line 10
            MR10: u1,
            ///  Interrupt Mask on line 11
            MR11: u1,
            ///  Interrupt Mask on line 12
            MR12: u1,
            ///  Interrupt Mask on line 13
            MR13: u1,
            ///  Interrupt Mask on line 14
            MR14: u1,
            ///  Interrupt Mask on line 15
            MR15: u1,
            ///  Interrupt Mask on line 16
            MR16: u1,
            ///  Interrupt Mask on line 17
            MR17: u1,
            ///  Interrupt Mask on line 18
            MR18: u1,
            ///  Interrupt Mask on line 19
            MR19: u1,
            ///  Interrupt Mask on line 20
            MR20: u1,
            ///  Interrupt Mask on line 21
            MR21: u1,
            ///  Interrupt Mask on line 22
            MR22: u1,
            ///  Interrupt Mask on line 23
            MR23: u1,
            ///  Interrupt Mask on line 24
            MR24: u1,
            ///  Interrupt Mask on line 25
            MR25: u1,
            ///  Interrupt Mask on line 26
            MR26: u1,
            ///  Interrupt Mask on line 27
            MR27: u1,
            ///  Interrupt Mask on line 28
            MR28: u1,
            ///  Interrupt Mask on line 29
            MR29: u1,
            ///  Interrupt Mask on line 30
            MR30: u1,
            ///  Interrupt Mask on line 31
            MR31: u1,
        }),
        ///  Event mask register
        EMR1: mmio.Mmio(packed struct(u32) {
            ///  Event Mask on line 0
            MR0: u1,
            ///  Event Mask on line 1
            MR1: u1,
            ///  Event Mask on line 2
            MR2: u1,
            ///  Event Mask on line 3
            MR3: u1,
            ///  Event Mask on line 4
            MR4: u1,
            ///  Event Mask on line 5
            MR5: u1,
            ///  Event Mask on line 6
            MR6: u1,
            ///  Event Mask on line 7
            MR7: u1,
            ///  Event Mask on line 8
            MR8: u1,
            ///  Event Mask on line 9
            MR9: u1,
            ///  Event Mask on line 10
            MR10: u1,
            ///  Event Mask on line 11
            MR11: u1,
            ///  Event Mask on line 12
            MR12: u1,
            ///  Event Mask on line 13
            MR13: u1,
            ///  Event Mask on line 14
            MR14: u1,
            ///  Event Mask on line 15
            MR15: u1,
            ///  Event Mask on line 16
            MR16: u1,
            ///  Event Mask on line 17
            MR17: u1,
            ///  Event Mask on line 18
            MR18: u1,
            ///  Event Mask on line 19
            MR19: u1,
            ///  Event Mask on line 20
            MR20: u1,
            ///  Event Mask on line 21
            MR21: u1,
            ///  Event Mask on line 22
            MR22: u1,
            ///  Event Mask on line 23
            MR23: u1,
            ///  Event Mask on line 24
            MR24: u1,
            ///  Event Mask on line 25
            MR25: u1,
            ///  Event Mask on line 26
            MR26: u1,
            ///  Event Mask on line 27
            MR27: u1,
            ///  Event Mask on line 28
            MR28: u1,
            ///  Event Mask on line 29
            MR29: u1,
            ///  Event Mask on line 30
            MR30: u1,
            ///  Event Mask on line 31
            MR31: u1,
        }),
        ///  Rising Trigger selection register
        RTSR1: mmio.Mmio(packed struct(u32) {
            ///  Rising trigger event configuration of line 0
            TR0: u1,
            ///  Rising trigger event configuration of line 1
            TR1: u1,
            ///  Rising trigger event configuration of line 2
            TR2: u1,
            ///  Rising trigger event configuration of line 3
            TR3: u1,
            ///  Rising trigger event configuration of line 4
            TR4: u1,
            ///  Rising trigger event configuration of line 5
            TR5: u1,
            ///  Rising trigger event configuration of line 6
            TR6: u1,
            ///  Rising trigger event configuration of line 7
            TR7: u1,
            ///  Rising trigger event configuration of line 8
            TR8: u1,
            ///  Rising trigger event configuration of line 9
            TR9: u1,
            ///  Rising trigger event configuration of line 10
            TR10: u1,
            ///  Rising trigger event configuration of line 11
            TR11: u1,
            ///  Rising trigger event configuration of line 12
            TR12: u1,
            ///  Rising trigger event configuration of line 13
            TR13: u1,
            ///  Rising trigger event configuration of line 14
            TR14: u1,
            ///  Rising trigger event configuration of line 15
            TR15: u1,
            ///  Rising trigger event configuration of line 16
            TR16: u1,
            ///  Rising trigger event configuration of line 17
            TR17: u1,
            ///  Rising trigger event configuration of line 18
            TR18: u1,
            ///  Rising trigger event configuration of line 19
            TR19: u1,
            ///  Rising trigger event configuration of line 20
            TR20: u1,
            ///  Rising trigger event configuration of line 21
            TR21: u1,
            ///  Rising trigger event configuration of line 22
            TR22: u1,
            reserved29: u6,
            ///  Rising trigger event configuration of line 29
            TR29: u1,
            ///  Rising trigger event configuration of line 30
            TR30: u1,
            ///  Rising trigger event configuration of line 31
            TR31: u1,
        }),
        ///  Falling Trigger selection register
        FTSR1: mmio.Mmio(packed struct(u32) {
            ///  Falling trigger event configuration of line 0
            TR0: u1,
            ///  Falling trigger event configuration of line 1
            TR1: u1,
            ///  Falling trigger event configuration of line 2
            TR2: u1,
            ///  Falling trigger event configuration of line 3
            TR3: u1,
            ///  Falling trigger event configuration of line 4
            TR4: u1,
            ///  Falling trigger event configuration of line 5
            TR5: u1,
            ///  Falling trigger event configuration of line 6
            TR6: u1,
            ///  Falling trigger event configuration of line 7
            TR7: u1,
            ///  Falling trigger event configuration of line 8
            TR8: u1,
            ///  Falling trigger event configuration of line 9
            TR9: u1,
            ///  Falling trigger event configuration of line 10
            TR10: u1,
            ///  Falling trigger event configuration of line 11
            TR11: u1,
            ///  Falling trigger event configuration of line 12
            TR12: u1,
            ///  Falling trigger event configuration of line 13
            TR13: u1,
            ///  Falling trigger event configuration of line 14
            TR14: u1,
            ///  Falling trigger event configuration of line 15
            TR15: u1,
            ///  Falling trigger event configuration of line 16
            TR16: u1,
            ///  Falling trigger event configuration of line 17
            TR17: u1,
            ///  Falling trigger event configuration of line 18
            TR18: u1,
            ///  Falling trigger event configuration of line 19
            TR19: u1,
            ///  Falling trigger event configuration of line 20
            TR20: u1,
            ///  Falling trigger event configuration of line 21
            TR21: u1,
            ///  Falling trigger event configuration of line 22
            TR22: u1,
            reserved29: u6,
            ///  Falling trigger event configuration of line 29
            TR29: u1,
            ///  Falling trigger event configuration of line 30.
            TR30: u1,
            ///  Falling trigger event configuration of line 31
            TR31: u1,
        }),
        ///  Software interrupt event register
        SWIER1: mmio.Mmio(packed struct(u32) {
            ///  Software Interrupt on line 0
            SWIER0: u1,
            ///  Software Interrupt on line 1
            SWIER1: u1,
            ///  Software Interrupt on line 2
            SWIER2: u1,
            ///  Software Interrupt on line 3
            SWIER3: u1,
            ///  Software Interrupt on line 4
            SWIER4: u1,
            ///  Software Interrupt on line 5
            SWIER5: u1,
            ///  Software Interrupt on line 6
            SWIER6: u1,
            ///  Software Interrupt on line 7
            SWIER7: u1,
            ///  Software Interrupt on line 8
            SWIER8: u1,
            ///  Software Interrupt on line 9
            SWIER9: u1,
            ///  Software Interrupt on line 10
            SWIER10: u1,
            ///  Software Interrupt on line 11
            SWIER11: u1,
            ///  Software Interrupt on line 12
            SWIER12: u1,
            ///  Software Interrupt on line 13
            SWIER13: u1,
            ///  Software Interrupt on line 14
            SWIER14: u1,
            ///  Software Interrupt on line 15
            SWIER15: u1,
            ///  Software Interrupt on line 16
            SWIER16: u1,
            ///  Software Interrupt on line 17
            SWIER17: u1,
            ///  Software Interrupt on line 18
            SWIER18: u1,
            ///  Software Interrupt on line 19
            SWIER19: u1,
            ///  Software Interrupt on line 20
            SWIER20: u1,
            ///  Software Interrupt on line 21
            SWIER21: u1,
            ///  Software Interrupt on line 22
            SWIER22: u1,
            reserved29: u6,
            ///  Software Interrupt on line 29
            SWIER29: u1,
            ///  Software Interrupt on line 309
            SWIER30: u1,
            ///  Software Interrupt on line 319
            SWIER31: u1,
        }),
        ///  Pending register
        PR1: mmio.Mmio(packed struct(u32) {
            ///  Pending bit 0
            PR0: u1,
            ///  Pending bit 1
            PR1: u1,
            ///  Pending bit 2
            PR2: u1,
            ///  Pending bit 3
            PR3: u1,
            ///  Pending bit 4
            PR4: u1,
            ///  Pending bit 5
            PR5: u1,
            ///  Pending bit 6
            PR6: u1,
            ///  Pending bit 7
            PR7: u1,
            ///  Pending bit 8
            PR8: u1,
            ///  Pending bit 9
            PR9: u1,
            ///  Pending bit 10
            PR10: u1,
            ///  Pending bit 11
            PR11: u1,
            ///  Pending bit 12
            PR12: u1,
            ///  Pending bit 13
            PR13: u1,
            ///  Pending bit 14
            PR14: u1,
            ///  Pending bit 15
            PR15: u1,
            ///  Pending bit 16
            PR16: u1,
            ///  Pending bit 17
            PR17: u1,
            ///  Pending bit 18
            PR18: u1,
            ///  Pending bit 19
            PR19: u1,
            ///  Pending bit 20
            PR20: u1,
            ///  Pending bit 21
            PR21: u1,
            ///  Pending bit 22
            PR22: u1,
            reserved29: u6,
            ///  Pending bit 29
            PR29: u1,
            ///  Pending bit 30
            PR30: u1,
            ///  Pending bit 31
            PR31: u1,
        }),
        ///  Interrupt mask register
        IMR2: mmio.Mmio(packed struct(u32) {
            ///  Interrupt Mask on external/internal line 32
            MR32: u1,
            ///  Interrupt Mask on external/internal line 33
            MR33: u1,
            ///  Interrupt Mask on external/internal line 34
            MR34: u1,
            ///  Interrupt Mask on external/internal line 35
            MR35: u1,
            padding: u28,
        }),
        ///  Event mask register
        EMR2: mmio.Mmio(packed struct(u32) {
            ///  Event mask on external/internal line 32
            MR32: u1,
            ///  Event mask on external/internal line 33
            MR33: u1,
            ///  Event mask on external/internal line 34
            MR34: u1,
            ///  Event mask on external/internal line 35
            MR35: u1,
            padding: u28,
        }),
        ///  Rising Trigger selection register
        RTSR2: mmio.Mmio(packed struct(u32) {
            ///  Rising trigger event configuration bit of line 32
            TR32: u1,
            ///  Rising trigger event configuration bit of line 33
            TR33: u1,
            padding: u30,
        }),
        ///  Falling Trigger selection register
        FTSR2: mmio.Mmio(packed struct(u32) {
            ///  Falling trigger event configuration bit of line 32
            TR32: u1,
            ///  Falling trigger event configuration bit of line 33
            TR33: u1,
            padding: u30,
        }),
        ///  Software interrupt event register
        SWIER2: mmio.Mmio(packed struct(u32) {
            ///  Software interrupt on line 32
            SWIER32: u1,
            ///  Software interrupt on line 33
            SWIER33: u1,
            padding: u30,
        }),
        ///  Pending register
        PR2: mmio.Mmio(packed struct(u32) {
            ///  Pending bit on line 32
            PR32: u1,
            ///  Pending bit on line 33
            PR33: u1,
            padding: u30,
        }),
    };

    ///  Power control
    pub const PWR = extern struct {
        ///  power control register
        CR: mmio.Mmio(packed struct(u32) {
            ///  Low-power deep sleep
            LPDS: u1,
            ///  Power down deepsleep
            PDDS: u1,
            ///  Clear wakeup flag
            CWUF: u1,
            ///  Clear standby flag
            CSBF: u1,
            ///  Power voltage detector enable
            PVDE: u1,
            ///  PVD level selection
            PLS: u3,
            ///  Disable backup domain write protection
            DBP: u1,
            padding: u23,
        }),
        ///  power control/status register
        CSR: mmio.Mmio(packed struct(u32) {
            ///  Wakeup flag
            WUF: u1,
            ///  Standby flag
            SBF: u1,
            ///  PVD output
            PVDO: u1,
            reserved8: u5,
            ///  Enable WKUP1 pin
            EWUP1: u1,
            ///  Enable WKUP2 pin
            EWUP2: u1,
            padding: u22,
        }),
    };

    ///  Controller area network
    pub const CAN = extern struct {
        ///  master control register
        MCR: mmio.Mmio(packed struct(u32) {
            ///  INRQ
            INRQ: u1,
            ///  SLEEP
            SLEEP: u1,
            ///  TXFP
            TXFP: u1,
            ///  RFLM
            RFLM: u1,
            ///  NART
            NART: u1,
            ///  AWUM
            AWUM: u1,
            ///  ABOM
            ABOM: u1,
            ///  TTCM
            TTCM: u1,
            reserved15: u7,
            ///  RESET
            RESET: u1,
            ///  DBF
            DBF: u1,
            padding: u15,
        }),
        ///  master status register
        MSR: mmio.Mmio(packed struct(u32) {
            ///  INAK
            INAK: u1,
            ///  SLAK
            SLAK: u1,
            ///  ERRI
            ERRI: u1,
            ///  WKUI
            WKUI: u1,
            ///  SLAKI
            SLAKI: u1,
            reserved8: u3,
            ///  TXM
            TXM: u1,
            ///  RXM
            RXM: u1,
            ///  SAMP
            SAMP: u1,
            ///  RX
            RX: u1,
            padding: u20,
        }),
        ///  transmit status register
        TSR: mmio.Mmio(packed struct(u32) {
            ///  RQCP0
            RQCP0: u1,
            ///  TXOK0
            TXOK0: u1,
            ///  ALST0
            ALST0: u1,
            ///  TERR0
            TERR0: u1,
            reserved7: u3,
            ///  ABRQ0
            ABRQ0: u1,
            ///  RQCP1
            RQCP1: u1,
            ///  TXOK1
            TXOK1: u1,
            ///  ALST1
            ALST1: u1,
            ///  TERR1
            TERR1: u1,
            reserved15: u3,
            ///  ABRQ1
            ABRQ1: u1,
            ///  RQCP2
            RQCP2: u1,
            ///  TXOK2
            TXOK2: u1,
            ///  ALST2
            ALST2: u1,
            ///  TERR2
            TERR2: u1,
            reserved23: u3,
            ///  ABRQ2
            ABRQ2: u1,
            ///  CODE
            CODE: u2,
            ///  Lowest priority flag for mailbox 0
            TME0: u1,
            ///  Lowest priority flag for mailbox 1
            TME1: u1,
            ///  Lowest priority flag for mailbox 2
            TME2: u1,
            ///  Lowest priority flag for mailbox 0
            LOW0: u1,
            ///  Lowest priority flag for mailbox 1
            LOW1: u1,
            ///  Lowest priority flag for mailbox 2
            LOW2: u1,
        }),
        ///  receive FIFO 0 register
        RF0R: mmio.Mmio(packed struct(u32) {
            ///  FMP0
            FMP0: u2,
            reserved3: u1,
            ///  FULL0
            FULL0: u1,
            ///  FOVR0
            FOVR0: u1,
            ///  RFOM0
            RFOM0: u1,
            padding: u26,
        }),
        ///  receive FIFO 1 register
        RF1R: mmio.Mmio(packed struct(u32) {
            ///  FMP1
            FMP1: u2,
            reserved3: u1,
            ///  FULL1
            FULL1: u1,
            ///  FOVR1
            FOVR1: u1,
            ///  RFOM1
            RFOM1: u1,
            padding: u26,
        }),
        ///  interrupt enable register
        IER: mmio.Mmio(packed struct(u32) {
            ///  TMEIE
            TMEIE: u1,
            ///  FMPIE0
            FMPIE0: u1,
            ///  FFIE0
            FFIE0: u1,
            ///  FOVIE0
            FOVIE0: u1,
            ///  FMPIE1
            FMPIE1: u1,
            ///  FFIE1
            FFIE1: u1,
            ///  FOVIE1
            FOVIE1: u1,
            reserved8: u1,
            ///  EWGIE
            EWGIE: u1,
            ///  EPVIE
            EPVIE: u1,
            ///  BOFIE
            BOFIE: u1,
            ///  LECIE
            LECIE: u1,
            reserved15: u3,
            ///  ERRIE
            ERRIE: u1,
            ///  WKUIE
            WKUIE: u1,
            ///  SLKIE
            SLKIE: u1,
            padding: u14,
        }),
        ///  error status register
        ESR: mmio.Mmio(packed struct(u32) {
            ///  EWGF
            EWGF: u1,
            ///  EPVF
            EPVF: u1,
            ///  BOFF
            BOFF: u1,
            reserved4: u1,
            ///  LEC
            LEC: u3,
            reserved16: u9,
            ///  TEC
            TEC: u8,
            ///  REC
            REC: u8,
        }),
        ///  bit timing register
        BTR: mmio.Mmio(packed struct(u32) {
            ///  BRP
            BRP: u10,
            reserved16: u6,
            ///  TS1
            TS1: u4,
            ///  TS2
            TS2: u3,
            reserved24: u1,
            ///  SJW
            SJW: u2,
            reserved30: u4,
            ///  LBKM
            LBKM: u1,
            ///  SILM
            SILM: u1,
        }),
        reserved384: [352]u8,
        ///  TX mailbox identifier register
        TI0R: mmio.Mmio(packed struct(u32) {
            ///  TXRQ
            TXRQ: u1,
            ///  RTR
            RTR: u1,
            ///  IDE
            IDE: u1,
            ///  EXID
            EXID: u18,
            ///  STID
            STID: u11,
        }),
        ///  mailbox data length control and time stamp register
        TDT0R: mmio.Mmio(packed struct(u32) {
            ///  DLC
            DLC: u4,
            reserved8: u4,
            ///  TGT
            TGT: u1,
            reserved16: u7,
            ///  TIME
            TIME: u16,
        }),
        ///  mailbox data low register
        TDL0R: mmio.Mmio(packed struct(u32) {
            ///  DATA0
            DATA0: u8,
            ///  DATA1
            DATA1: u8,
            ///  DATA2
            DATA2: u8,
            ///  DATA3
            DATA3: u8,
        }),
        ///  mailbox data high register
        TDH0R: mmio.Mmio(packed struct(u32) {
            ///  DATA4
            DATA4: u8,
            ///  DATA5
            DATA5: u8,
            ///  DATA6
            DATA6: u8,
            ///  DATA7
            DATA7: u8,
        }),
        ///  TX mailbox identifier register
        TI1R: mmio.Mmio(packed struct(u32) {
            ///  TXRQ
            TXRQ: u1,
            ///  RTR
            RTR: u1,
            ///  IDE
            IDE: u1,
            ///  EXID
            EXID: u18,
            ///  STID
            STID: u11,
        }),
        ///  mailbox data length control and time stamp register
        TDT1R: mmio.Mmio(packed struct(u32) {
            ///  DLC
            DLC: u4,
            reserved8: u4,
            ///  TGT
            TGT: u1,
            reserved16: u7,
            ///  TIME
            TIME: u16,
        }),
        ///  mailbox data low register
        TDL1R: mmio.Mmio(packed struct(u32) {
            ///  DATA0
            DATA0: u8,
            ///  DATA1
            DATA1: u8,
            ///  DATA2
            DATA2: u8,
            ///  DATA3
            DATA3: u8,
        }),
        ///  mailbox data high register
        TDH1R: mmio.Mmio(packed struct(u32) {
            ///  DATA4
            DATA4: u8,
            ///  DATA5
            DATA5: u8,
            ///  DATA6
            DATA6: u8,
            ///  DATA7
            DATA7: u8,
        }),
        ///  TX mailbox identifier register
        TI2R: mmio.Mmio(packed struct(u32) {
            ///  TXRQ
            TXRQ: u1,
            ///  RTR
            RTR: u1,
            ///  IDE
            IDE: u1,
            ///  EXID
            EXID: u18,
            ///  STID
            STID: u11,
        }),
        ///  mailbox data length control and time stamp register
        TDT2R: mmio.Mmio(packed struct(u32) {
            ///  DLC
            DLC: u4,
            reserved8: u4,
            ///  TGT
            TGT: u1,
            reserved16: u7,
            ///  TIME
            TIME: u16,
        }),
        ///  mailbox data low register
        TDL2R: mmio.Mmio(packed struct(u32) {
            ///  DATA0
            DATA0: u8,
            ///  DATA1
            DATA1: u8,
            ///  DATA2
            DATA2: u8,
            ///  DATA3
            DATA3: u8,
        }),
        ///  mailbox data high register
        TDH2R: mmio.Mmio(packed struct(u32) {
            ///  DATA4
            DATA4: u8,
            ///  DATA5
            DATA5: u8,
            ///  DATA6
            DATA6: u8,
            ///  DATA7
            DATA7: u8,
        }),
        ///  receive FIFO mailbox identifier register
        RI0R: mmio.Mmio(packed struct(u32) {
            reserved1: u1,
            ///  RTR
            RTR: u1,
            ///  IDE
            IDE: u1,
            ///  EXID
            EXID: u18,
            ///  STID
            STID: u11,
        }),
        ///  receive FIFO mailbox data length control and time stamp register
        RDT0R: mmio.Mmio(packed struct(u32) {
            ///  DLC
            DLC: u4,
            reserved8: u4,
            ///  FMI
            FMI: u8,
            ///  TIME
            TIME: u16,
        }),
        ///  receive FIFO mailbox data low register
        RDL0R: mmio.Mmio(packed struct(u32) {
            ///  DATA0
            DATA0: u8,
            ///  DATA1
            DATA1: u8,
            ///  DATA2
            DATA2: u8,
            ///  DATA3
            DATA3: u8,
        }),
        ///  receive FIFO mailbox data high register
        RDH0R: mmio.Mmio(packed struct(u32) {
            ///  DATA4
            DATA4: u8,
            ///  DATA5
            DATA5: u8,
            ///  DATA6
            DATA6: u8,
            ///  DATA7
            DATA7: u8,
        }),
        ///  receive FIFO mailbox identifier register
        RI1R: mmio.Mmio(packed struct(u32) {
            reserved1: u1,
            ///  RTR
            RTR: u1,
            ///  IDE
            IDE: u1,
            ///  EXID
            EXID: u18,
            ///  STID
            STID: u11,
        }),
        ///  receive FIFO mailbox data length control and time stamp register
        RDT1R: mmio.Mmio(packed struct(u32) {
            ///  DLC
            DLC: u4,
            reserved8: u4,
            ///  FMI
            FMI: u8,
            ///  TIME
            TIME: u16,
        }),
        ///  receive FIFO mailbox data low register
        RDL1R: mmio.Mmio(packed struct(u32) {
            ///  DATA0
            DATA0: u8,
            ///  DATA1
            DATA1: u8,
            ///  DATA2
            DATA2: u8,
            ///  DATA3
            DATA3: u8,
        }),
        ///  receive FIFO mailbox data high register
        RDH1R: mmio.Mmio(packed struct(u32) {
            ///  DATA4
            DATA4: u8,
            ///  DATA5
            DATA5: u8,
            ///  DATA6
            DATA6: u8,
            ///  DATA7
            DATA7: u8,
        }),
        reserved512: [48]u8,
        ///  filter master register
        FMR: mmio.Mmio(packed struct(u32) {
            ///  Filter init mode
            FINIT: u1,
            reserved8: u7,
            ///  CAN2 start bank
            CAN2SB: u6,
            padding: u18,
        }),
        ///  filter mode register
        FM1R: mmio.Mmio(packed struct(u32) {
            ///  Filter mode
            FBM0: u1,
            ///  Filter mode
            FBM1: u1,
            ///  Filter mode
            FBM2: u1,
            ///  Filter mode
            FBM3: u1,
            ///  Filter mode
            FBM4: u1,
            ///  Filter mode
            FBM5: u1,
            ///  Filter mode
            FBM6: u1,
            ///  Filter mode
            FBM7: u1,
            ///  Filter mode
            FBM8: u1,
            ///  Filter mode
            FBM9: u1,
            ///  Filter mode
            FBM10: u1,
            ///  Filter mode
            FBM11: u1,
            ///  Filter mode
            FBM12: u1,
            ///  Filter mode
            FBM13: u1,
            ///  Filter mode
            FBM14: u1,
            ///  Filter mode
            FBM15: u1,
            ///  Filter mode
            FBM16: u1,
            ///  Filter mode
            FBM17: u1,
            ///  Filter mode
            FBM18: u1,
            ///  Filter mode
            FBM19: u1,
            ///  Filter mode
            FBM20: u1,
            ///  Filter mode
            FBM21: u1,
            ///  Filter mode
            FBM22: u1,
            ///  Filter mode
            FBM23: u1,
            ///  Filter mode
            FBM24: u1,
            ///  Filter mode
            FBM25: u1,
            ///  Filter mode
            FBM26: u1,
            ///  Filter mode
            FBM27: u1,
            padding: u4,
        }),
        reserved524: [4]u8,
        ///  filter scale register
        FS1R: mmio.Mmio(packed struct(u32) {
            ///  Filter scale configuration
            FSC0: u1,
            ///  Filter scale configuration
            FSC1: u1,
            ///  Filter scale configuration
            FSC2: u1,
            ///  Filter scale configuration
            FSC3: u1,
            ///  Filter scale configuration
            FSC4: u1,
            ///  Filter scale configuration
            FSC5: u1,
            ///  Filter scale configuration
            FSC6: u1,
            ///  Filter scale configuration
            FSC7: u1,
            ///  Filter scale configuration
            FSC8: u1,
            ///  Filter scale configuration
            FSC9: u1,
            ///  Filter scale configuration
            FSC10: u1,
            ///  Filter scale configuration
            FSC11: u1,
            ///  Filter scale configuration
            FSC12: u1,
            ///  Filter scale configuration
            FSC13: u1,
            ///  Filter scale configuration
            FSC14: u1,
            ///  Filter scale configuration
            FSC15: u1,
            ///  Filter scale configuration
            FSC16: u1,
            ///  Filter scale configuration
            FSC17: u1,
            ///  Filter scale configuration
            FSC18: u1,
            ///  Filter scale configuration
            FSC19: u1,
            ///  Filter scale configuration
            FSC20: u1,
            ///  Filter scale configuration
            FSC21: u1,
            ///  Filter scale configuration
            FSC22: u1,
            ///  Filter scale configuration
            FSC23: u1,
            ///  Filter scale configuration
            FSC24: u1,
            ///  Filter scale configuration
            FSC25: u1,
            ///  Filter scale configuration
            FSC26: u1,
            ///  Filter scale configuration
            FSC27: u1,
            padding: u4,
        }),
        reserved532: [4]u8,
        ///  filter FIFO assignment register
        FFA1R: mmio.Mmio(packed struct(u32) {
            ///  Filter FIFO assignment for filter 0
            FFA0: u1,
            ///  Filter FIFO assignment for filter 1
            FFA1: u1,
            ///  Filter FIFO assignment for filter 2
            FFA2: u1,
            ///  Filter FIFO assignment for filter 3
            FFA3: u1,
            ///  Filter FIFO assignment for filter 4
            FFA4: u1,
            ///  Filter FIFO assignment for filter 5
            FFA5: u1,
            ///  Filter FIFO assignment for filter 6
            FFA6: u1,
            ///  Filter FIFO assignment for filter 7
            FFA7: u1,
            ///  Filter FIFO assignment for filter 8
            FFA8: u1,
            ///  Filter FIFO assignment for filter 9
            FFA9: u1,
            ///  Filter FIFO assignment for filter 10
            FFA10: u1,
            ///  Filter FIFO assignment for filter 11
            FFA11: u1,
            ///  Filter FIFO assignment for filter 12
            FFA12: u1,
            ///  Filter FIFO assignment for filter 13
            FFA13: u1,
            ///  Filter FIFO assignment for filter 14
            FFA14: u1,
            ///  Filter FIFO assignment for filter 15
            FFA15: u1,
            ///  Filter FIFO assignment for filter 16
            FFA16: u1,
            ///  Filter FIFO assignment for filter 17
            FFA17: u1,
            ///  Filter FIFO assignment for filter 18
            FFA18: u1,
            ///  Filter FIFO assignment for filter 19
            FFA19: u1,
            ///  Filter FIFO assignment for filter 20
            FFA20: u1,
            ///  Filter FIFO assignment for filter 21
            FFA21: u1,
            ///  Filter FIFO assignment for filter 22
            FFA22: u1,
            ///  Filter FIFO assignment for filter 23
            FFA23: u1,
            ///  Filter FIFO assignment for filter 24
            FFA24: u1,
            ///  Filter FIFO assignment for filter 25
            FFA25: u1,
            ///  Filter FIFO assignment for filter 26
            FFA26: u1,
            ///  Filter FIFO assignment for filter 27
            FFA27: u1,
            padding: u4,
        }),
        reserved540: [4]u8,
        ///  CAN filter activation register
        FA1R: mmio.Mmio(packed struct(u32) {
            ///  Filter active
            FACT0: u1,
            ///  Filter active
            FACT1: u1,
            ///  Filter active
            FACT2: u1,
            ///  Filter active
            FACT3: u1,
            ///  Filter active
            FACT4: u1,
            ///  Filter active
            FACT5: u1,
            ///  Filter active
            FACT6: u1,
            ///  Filter active
            FACT7: u1,
            ///  Filter active
            FACT8: u1,
            ///  Filter active
            FACT9: u1,
            ///  Filter active
            FACT10: u1,
            ///  Filter active
            FACT11: u1,
            ///  Filter active
            FACT12: u1,
            ///  Filter active
            FACT13: u1,
            ///  Filter active
            FACT14: u1,
            ///  Filter active
            FACT15: u1,
            ///  Filter active
            FACT16: u1,
            ///  Filter active
            FACT17: u1,
            ///  Filter active
            FACT18: u1,
            ///  Filter active
            FACT19: u1,
            ///  Filter active
            FACT20: u1,
            ///  Filter active
            FACT21: u1,
            ///  Filter active
            FACT22: u1,
            ///  Filter active
            FACT23: u1,
            ///  Filter active
            FACT24: u1,
            ///  Filter active
            FACT25: u1,
            ///  Filter active
            FACT26: u1,
            ///  Filter active
            FACT27: u1,
            padding: u4,
        }),
        reserved576: [32]u8,
        ///  Filter bank 0 register 1
        F0R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 0 register 2
        F0R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 1 register 1
        F1R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 1 register 2
        F1R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 2 register 1
        F2R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 2 register 2
        F2R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 3 register 1
        F3R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 3 register 2
        F3R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 4 register 1
        F4R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 4 register 2
        F4R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 5 register 1
        F5R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 5 register 2
        F5R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 6 register 1
        F6R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 6 register 2
        F6R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 7 register 1
        F7R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 7 register 2
        F7R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 8 register 1
        F8R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 8 register 2
        F8R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 9 register 1
        F9R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 9 register 2
        F9R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 10 register 1
        F10R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 10 register 2
        F10R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 11 register 1
        F11R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 11 register 2
        F11R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 4 register 1
        F12R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 12 register 2
        F12R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 13 register 1
        F13R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 13 register 2
        F13R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 14 register 1
        F14R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 14 register 2
        F14R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 15 register 1
        F15R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 15 register 2
        F15R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 16 register 1
        F16R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 16 register 2
        F16R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 17 register 1
        F17R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 17 register 2
        F17R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 18 register 1
        F18R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 18 register 2
        F18R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 19 register 1
        F19R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 19 register 2
        F19R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 20 register 1
        F20R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 20 register 2
        F20R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 21 register 1
        F21R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 21 register 2
        F21R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 22 register 1
        F22R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 22 register 2
        F22R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 23 register 1
        F23R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 23 register 2
        F23R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 24 register 1
        F24R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 24 register 2
        F24R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 25 register 1
        F25R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 25 register 2
        F25R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 26 register 1
        F26R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 26 register 2
        F26R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 27 register 1
        F27R1: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
        ///  Filter bank 27 register 2
        F27R2: mmio.Mmio(packed struct(u32) {
            ///  Filter bits
            FB0: u1,
            ///  Filter bits
            FB1: u1,
            ///  Filter bits
            FB2: u1,
            ///  Filter bits
            FB3: u1,
            ///  Filter bits
            FB4: u1,
            ///  Filter bits
            FB5: u1,
            ///  Filter bits
            FB6: u1,
            ///  Filter bits
            FB7: u1,
            ///  Filter bits
            FB8: u1,
            ///  Filter bits
            FB9: u1,
            ///  Filter bits
            FB10: u1,
            ///  Filter bits
            FB11: u1,
            ///  Filter bits
            FB12: u1,
            ///  Filter bits
            FB13: u1,
            ///  Filter bits
            FB14: u1,
            ///  Filter bits
            FB15: u1,
            ///  Filter bits
            FB16: u1,
            ///  Filter bits
            FB17: u1,
            ///  Filter bits
            FB18: u1,
            ///  Filter bits
            FB19: u1,
            ///  Filter bits
            FB20: u1,
            ///  Filter bits
            FB21: u1,
            ///  Filter bits
            FB22: u1,
            ///  Filter bits
            FB23: u1,
            ///  Filter bits
            FB24: u1,
            ///  Filter bits
            FB25: u1,
            ///  Filter bits
            FB26: u1,
            ///  Filter bits
            FB27: u1,
            ///  Filter bits
            FB28: u1,
            ///  Filter bits
            FB29: u1,
            ///  Filter bits
            FB30: u1,
            ///  Filter bits
            FB31: u1,
        }),
    };

    ///  Universal serial bus full-speed device interface
    pub const USB_FS = extern struct {
        ///  endpoint 0 register
        USB_EP0R: mmio.Mmio(packed struct(u32) {
            ///  Endpoint address
            EA: u4,
            ///  Status bits, for transmission transfers
            STAT_TX: u2,
            ///  Data Toggle, for transmission transfers
            DTOG_TX: u1,
            ///  Correct Transfer for transmission
            CTR_TX: u1,
            ///  Endpoint kind
            EP_KIND: u1,
            ///  Endpoint type
            EP_TYPE: u2,
            ///  Setup transaction completed
            SETUP: u1,
            ///  Status bits, for reception transfers
            STAT_RX: u2,
            ///  Data Toggle, for reception transfers
            DTOG_RX: u1,
            ///  Correct transfer for reception
            CTR_RX: u1,
            padding: u16,
        }),
        ///  endpoint 1 register
        USB_EP1R: mmio.Mmio(packed struct(u32) {
            ///  Endpoint address
            EA: u4,
            ///  Status bits, for transmission transfers
            STAT_TX: u2,
            ///  Data Toggle, for transmission transfers
            DTOG_TX: u1,
            ///  Correct Transfer for transmission
            CTR_TX: u1,
            ///  Endpoint kind
            EP_KIND: u1,
            ///  Endpoint type
            EP_TYPE: u2,
            ///  Setup transaction completed
            SETUP: u1,
            ///  Status bits, for reception transfers
            STAT_RX: u2,
            ///  Data Toggle, for reception transfers
            DTOG_RX: u1,
            ///  Correct transfer for reception
            CTR_RX: u1,
            padding: u16,
        }),
        ///  endpoint 2 register
        USB_EP2R: mmio.Mmio(packed struct(u32) {
            ///  Endpoint address
            EA: u4,
            ///  Status bits, for transmission transfers
            STAT_TX: u2,
            ///  Data Toggle, for transmission transfers
            DTOG_TX: u1,
            ///  Correct Transfer for transmission
            CTR_TX: u1,
            ///  Endpoint kind
            EP_KIND: u1,
            ///  Endpoint type
            EP_TYPE: u2,
            ///  Setup transaction completed
            SETUP: u1,
            ///  Status bits, for reception transfers
            STAT_RX: u2,
            ///  Data Toggle, for reception transfers
            DTOG_RX: u1,
            ///  Correct transfer for reception
            CTR_RX: u1,
            padding: u16,
        }),
        ///  endpoint 3 register
        USB_EP3R: mmio.Mmio(packed struct(u32) {
            ///  Endpoint address
            EA: u4,
            ///  Status bits, for transmission transfers
            STAT_TX: u2,
            ///  Data Toggle, for transmission transfers
            DTOG_TX: u1,
            ///  Correct Transfer for transmission
            CTR_TX: u1,
            ///  Endpoint kind
            EP_KIND: u1,
            ///  Endpoint type
            EP_TYPE: u2,
            ///  Setup transaction completed
            SETUP: u1,
            ///  Status bits, for reception transfers
            STAT_RX: u2,
            ///  Data Toggle, for reception transfers
            DTOG_RX: u1,
            ///  Correct transfer for reception
            CTR_RX: u1,
            padding: u16,
        }),
        ///  endpoint 4 register
        USB_EP4R: mmio.Mmio(packed struct(u32) {
            ///  Endpoint address
            EA: u4,
            ///  Status bits, for transmission transfers
            STAT_TX: u2,
            ///  Data Toggle, for transmission transfers
            DTOG_TX: u1,
            ///  Correct Transfer for transmission
            CTR_TX: u1,
            ///  Endpoint kind
            EP_KIND: u1,
            ///  Endpoint type
            EP_TYPE: u2,
            ///  Setup transaction completed
            SETUP: u1,
            ///  Status bits, for reception transfers
            STAT_RX: u2,
            ///  Data Toggle, for reception transfers
            DTOG_RX: u1,
            ///  Correct transfer for reception
            CTR_RX: u1,
            padding: u16,
        }),
        ///  endpoint 5 register
        USB_EP5R: mmio.Mmio(packed struct(u32) {
            ///  Endpoint address
            EA: u4,
            ///  Status bits, for transmission transfers
            STAT_TX: u2,
            ///  Data Toggle, for transmission transfers
            DTOG_TX: u1,
            ///  Correct Transfer for transmission
            CTR_TX: u1,
            ///  Endpoint kind
            EP_KIND: u1,
            ///  Endpoint type
            EP_TYPE: u2,
            ///  Setup transaction completed
            SETUP: u1,
            ///  Status bits, for reception transfers
            STAT_RX: u2,
            ///  Data Toggle, for reception transfers
            DTOG_RX: u1,
            ///  Correct transfer for reception
            CTR_RX: u1,
            padding: u16,
        }),
        ///  endpoint 6 register
        USB_EP6R: mmio.Mmio(packed struct(u32) {
            ///  Endpoint address
            EA: u4,
            ///  Status bits, for transmission transfers
            STAT_TX: u2,
            ///  Data Toggle, for transmission transfers
            DTOG_TX: u1,
            ///  Correct Transfer for transmission
            CTR_TX: u1,
            ///  Endpoint kind
            EP_KIND: u1,
            ///  Endpoint type
            EP_TYPE: u2,
            ///  Setup transaction completed
            SETUP: u1,
            ///  Status bits, for reception transfers
            STAT_RX: u2,
            ///  Data Toggle, for reception transfers
            DTOG_RX: u1,
            ///  Correct transfer for reception
            CTR_RX: u1,
            padding: u16,
        }),
        ///  endpoint 7 register
        USB_EP7R: mmio.Mmio(packed struct(u32) {
            ///  Endpoint address
            EA: u4,
            ///  Status bits, for transmission transfers
            STAT_TX: u2,
            ///  Data Toggle, for transmission transfers
            DTOG_TX: u1,
            ///  Correct Transfer for transmission
            CTR_TX: u1,
            ///  Endpoint kind
            EP_KIND: u1,
            ///  Endpoint type
            EP_TYPE: u2,
            ///  Setup transaction completed
            SETUP: u1,
            ///  Status bits, for reception transfers
            STAT_RX: u2,
            ///  Data Toggle, for reception transfers
            DTOG_RX: u1,
            ///  Correct transfer for reception
            CTR_RX: u1,
            padding: u16,
        }),
        reserved64: [32]u8,
        ///  control register
        USB_CNTR: mmio.Mmio(packed struct(u32) {
            ///  Force USB Reset
            FRES: u1,
            ///  Power down
            PDWN: u1,
            ///  Low-power mode
            LPMODE: u1,
            ///  Force suspend
            FSUSP: u1,
            ///  Resume request
            RESUME: u1,
            reserved8: u3,
            ///  Expected start of frame interrupt mask
            ESOFM: u1,
            ///  Start of frame interrupt mask
            SOFM: u1,
            ///  USB reset interrupt mask
            RESETM: u1,
            ///  Suspend mode interrupt mask
            SUSPM: u1,
            ///  Wakeup interrupt mask
            WKUPM: u1,
            ///  Error interrupt mask
            ERRM: u1,
            ///  Packet memory area over / underrun interrupt mask
            PMAOVRM: u1,
            ///  Correct transfer interrupt mask
            CTRM: u1,
            padding: u16,
        }),
        ///  interrupt status register
        ISTR: mmio.Mmio(packed struct(u32) {
            ///  Endpoint Identifier
            EP_ID: u4,
            ///  Direction of transaction
            DIR: u1,
            reserved8: u3,
            ///  Expected start frame
            ESOF: u1,
            ///  start of frame
            SOF: u1,
            ///  reset request
            RESET: u1,
            ///  Suspend mode request
            SUSP: u1,
            ///  Wakeup
            WKUP: u1,
            ///  Error
            ERR: u1,
            ///  Packet memory area over / underrun
            PMAOVR: u1,
            ///  Correct transfer
            CTR: u1,
            padding: u16,
        }),
        ///  frame number register
        FNR: mmio.Mmio(packed struct(u32) {
            ///  Frame number
            FN: u11,
            ///  Lost SOF
            LSOF: u2,
            ///  Locked
            LCK: u1,
            ///  Receive data - line status
            RXDM: u1,
            ///  Receive data + line status
            RXDP: u1,
            padding: u16,
        }),
        ///  device address
        DADDR: mmio.Mmio(packed struct(u32) {
            ///  Device address
            ADD: u1,
            ///  Device address
            ADD1: u1,
            ///  Device address
            ADD2: u1,
            ///  Device address
            ADD3: u1,
            ///  Device address
            ADD4: u1,
            ///  Device address
            ADD5: u1,
            ///  Device address
            ADD6: u1,
            ///  Enable function
            EF: u1,
            padding: u24,
        }),
        ///  Buffer table address
        BTABLE: mmio.Mmio(packed struct(u32) {
            reserved3: u3,
            ///  Buffer table
            BTABLE: u13,
            padding: u16,
        }),
    };

    ///  Inter-integrated circuit
    pub const I2C1 = extern struct {
        ///  Control register 1
        CR1: mmio.Mmio(packed struct(u32) {
            ///  Peripheral enable
            PE: u1,
            ///  TX Interrupt enable
            TXIE: u1,
            ///  RX Interrupt enable
            RXIE: u1,
            ///  Address match interrupt enable (slave only)
            ADDRIE: u1,
            ///  Not acknowledge received interrupt enable
            NACKIE: u1,
            ///  STOP detection Interrupt enable
            STOPIE: u1,
            ///  Transfer Complete interrupt enable
            TCIE: u1,
            ///  Error interrupts enable
            ERRIE: u1,
            ///  Digital noise filter
            DNF: u4,
            ///  Analog noise filter OFF
            ANFOFF: u1,
            ///  Software reset
            SWRST: u1,
            ///  DMA transmission requests enable
            TXDMAEN: u1,
            ///  DMA reception requests enable
            RXDMAEN: u1,
            ///  Slave byte control
            SBC: u1,
            ///  Clock stretching disable
            NOSTRETCH: u1,
            ///  Wakeup from STOP enable
            WUPEN: u1,
            ///  General call enable
            GCEN: u1,
            ///  SMBus Host address enable
            SMBHEN: u1,
            ///  SMBus Device Default address enable
            SMBDEN: u1,
            ///  SMBUS alert enable
            ALERTEN: u1,
            ///  PEC enable
            PECEN: u1,
            padding: u8,
        }),
        ///  Control register 2
        CR2: mmio.Mmio(packed struct(u32) {
            ///  Slave address bit 0 (master mode)
            SADD0: u1,
            ///  Slave address bit 7:1 (master mode)
            SADD1: u7,
            ///  Slave address bit 9:8 (master mode)
            SADD8: u2,
            ///  Transfer direction (master mode)
            RD_WRN: u1,
            ///  10-bit addressing mode (master mode)
            ADD10: u1,
            ///  10-bit address header only read direction (master receiver mode)
            HEAD10R: u1,
            ///  Start generation
            START: u1,
            ///  Stop generation (master mode)
            STOP: u1,
            ///  NACK generation (slave mode)
            NACK: u1,
            ///  Number of bytes
            NBYTES: u8,
            ///  NBYTES reload mode
            RELOAD: u1,
            ///  Automatic end mode (master mode)
            AUTOEND: u1,
            ///  Packet error checking byte
            PECBYTE: u1,
            padding: u5,
        }),
        ///  Own address register 1
        OAR1: mmio.Mmio(packed struct(u32) {
            ///  Interface address
            OA1_0: u1,
            ///  Interface address
            OA1_1: u7,
            ///  Interface address
            OA1_8: u2,
            ///  Own Address 1 10-bit mode
            OA1MODE: u1,
            reserved15: u4,
            ///  Own Address 1 enable
            OA1EN: u1,
            padding: u16,
        }),
        ///  Own address register 2
        OAR2: mmio.Mmio(packed struct(u32) {
            reserved1: u1,
            ///  Interface address
            OA2: u7,
            ///  Own Address 2 masks
            OA2MSK: u3,
            reserved15: u4,
            ///  Own Address 2 enable
            OA2EN: u1,
            padding: u16,
        }),
        ///  Timing register
        TIMINGR: mmio.Mmio(packed struct(u32) {
            ///  SCL low period (master mode)
            SCLL: u8,
            ///  SCL high period (master mode)
            SCLH: u8,
            ///  Data hold time
            SDADEL: u4,
            ///  Data setup time
            SCLDEL: u4,
            reserved28: u4,
            ///  Timing prescaler
            PRESC: u4,
        }),
        ///  Status register 1
        TIMEOUTR: mmio.Mmio(packed struct(u32) {
            ///  Bus timeout A
            TIMEOUTA: u12,
            ///  Idle clock timeout detection
            TIDLE: u1,
            reserved15: u2,
            ///  Clock timeout enable
            TIMOUTEN: u1,
            ///  Bus timeout B
            TIMEOUTB: u12,
            reserved31: u3,
            ///  Extended clock timeout enable
            TEXTEN: u1,
        }),
        ///  Interrupt and Status register
        ISR: mmio.Mmio(packed struct(u32) {
            ///  Transmit data register empty (transmitters)
            TXE: u1,
            ///  Transmit interrupt status (transmitters)
            TXIS: u1,
            ///  Receive data register not empty (receivers)
            RXNE: u1,
            ///  Address matched (slave mode)
            ADDR: u1,
            ///  Not acknowledge received flag
            NACKF: u1,
            ///  Stop detection flag
            STOPF: u1,
            ///  Transfer Complete (master mode)
            TC: u1,
            ///  Transfer Complete Reload
            TCR: u1,
            ///  Bus error
            BERR: u1,
            ///  Arbitration lost
            ARLO: u1,
            ///  Overrun/Underrun (slave mode)
            OVR: u1,
            ///  PEC Error in reception
            PECERR: u1,
            ///  Timeout or t_low detection flag
            TIMEOUT: u1,
            ///  SMBus alert
            ALERT: u1,
            reserved15: u1,
            ///  Bus busy
            BUSY: u1,
            ///  Transfer direction (Slave mode)
            DIR: u1,
            ///  Address match code (Slave mode)
            ADDCODE: u7,
            padding: u8,
        }),
        ///  Interrupt clear register
        ICR: mmio.Mmio(packed struct(u32) {
            reserved3: u3,
            ///  Address Matched flag clear
            ADDRCF: u1,
            ///  Not Acknowledge flag clear
            NACKCF: u1,
            ///  Stop detection flag clear
            STOPCF: u1,
            reserved8: u2,
            ///  Bus error flag clear
            BERRCF: u1,
            ///  Arbitration lost flag clear
            ARLOCF: u1,
            ///  Overrun/Underrun flag clear
            OVRCF: u1,
            ///  PEC Error flag clear
            PECCF: u1,
            ///  Timeout detection flag clear
            TIMOUTCF: u1,
            ///  Alert flag clear
            ALERTCF: u1,
            padding: u18,
        }),
        ///  PEC register
        PECR: mmio.Mmio(packed struct(u32) {
            ///  Packet error checking register
            PEC: u8,
            padding: u24,
        }),
        ///  Receive data register
        RXDR: mmio.Mmio(packed struct(u32) {
            ///  8-bit receive data
            RXDATA: u8,
            padding: u24,
        }),
        ///  Transmit data register
        TXDR: mmio.Mmio(packed struct(u32) {
            ///  8-bit transmit data
            TXDATA: u8,
            padding: u24,
        }),
    };

    ///  Advanced timer
    pub const TIM1 = extern struct {
        ///  control register 1
        CR1: mmio.Mmio(packed struct(u32) {
            ///  Counter enable
            CEN: u1,
            ///  Update disable
            UDIS: u1,
            ///  Update request source
            URS: u1,
            ///  One-pulse mode
            OPM: u1,
            ///  Direction
            DIR: u1,
            ///  Center-aligned mode selection
            CMS: u2,
            ///  Auto-reload preload enable
            ARPE: u1,
            ///  Clock division
            CKD: u2,
            reserved11: u1,
            ///  UIF status bit remapping
            UIFREMAP: u1,
            padding: u20,
        }),
        ///  control register 2
        CR2: mmio.Mmio(packed struct(u32) {
            ///  Capture/compare preloaded control
            CCPC: u1,
            reserved2: u1,
            ///  Capture/compare control update selection
            CCUS: u1,
            ///  Capture/compare DMA selection
            CCDS: u1,
            ///  Master mode selection
            MMS: u3,
            ///  TI1 selection
            TI1S: u1,
            ///  Output Idle state 1
            OIS1: u1,
            ///  Output Idle state 1
            OIS1N: u1,
            ///  Output Idle state 2
            OIS2: u1,
            ///  Output Idle state 2
            OIS2N: u1,
            ///  Output Idle state 3
            OIS3: u1,
            ///  Output Idle state 3
            OIS3N: u1,
            ///  Output Idle state 4
            OIS4: u1,
            reserved16: u1,
            ///  Output Idle state 5
            OIS5: u1,
            reserved18: u1,
            ///  Output Idle state 6
            OIS6: u1,
            reserved20: u1,
            ///  Master mode selection 2
            MMS2: u4,
            padding: u8,
        }),
        ///  slave mode control register
        SMCR: mmio.Mmio(packed struct(u32) {
            ///  Slave mode selection
            SMS: u3,
            ///  OCREF clear selection
            OCCS: u1,
            ///  Trigger selection
            TS: u3,
            ///  Master/Slave mode
            MSM: u1,
            ///  External trigger filter
            ETF: u4,
            ///  External trigger prescaler
            ETPS: u2,
            ///  External clock enable
            ECE: u1,
            ///  External trigger polarity
            ETP: u1,
            ///  Slave mode selection bit 3
            SMS3: u1,
            padding: u15,
        }),
        ///  DMA/Interrupt enable register
        DIER: mmio.Mmio(packed struct(u32) {
            ///  Update interrupt enable
            UIE: u1,
            ///  Capture/Compare 1 interrupt enable
            CC1IE: u1,
            ///  Capture/Compare 2 interrupt enable
            CC2IE: u1,
            ///  Capture/Compare 3 interrupt enable
            CC3IE: u1,
            ///  Capture/Compare 4 interrupt enable
            CC4IE: u1,
            ///  COM interrupt enable
            COMIE: u1,
            ///  Trigger interrupt enable
            TIE: u1,
            ///  Break interrupt enable
            BIE: u1,
            ///  Update DMA request enable
            UDE: u1,
            ///  Capture/Compare 1 DMA request enable
            CC1DE: u1,
            ///  Capture/Compare 2 DMA request enable
            CC2DE: u1,
            ///  Capture/Compare 3 DMA request enable
            CC3DE: u1,
            ///  Capture/Compare 4 DMA request enable
            CC4DE: u1,
            ///  COM DMA request enable
            COMDE: u1,
            ///  Trigger DMA request enable
            TDE: u1,
            padding: u17,
        }),
        ///  status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Update interrupt flag
            UIF: u1,
            ///  Capture/compare 1 interrupt flag
            CC1IF: u1,
            ///  Capture/Compare 2 interrupt flag
            CC2IF: u1,
            ///  Capture/Compare 3 interrupt flag
            CC3IF: u1,
            ///  Capture/Compare 4 interrupt flag
            CC4IF: u1,
            ///  COM interrupt flag
            COMIF: u1,
            ///  Trigger interrupt flag
            TIF: u1,
            ///  Break interrupt flag
            BIF: u1,
            ///  Break 2 interrupt flag
            B2IF: u1,
            ///  Capture/Compare 1 overcapture flag
            CC1OF: u1,
            ///  Capture/compare 2 overcapture flag
            CC2OF: u1,
            ///  Capture/Compare 3 overcapture flag
            CC3OF: u1,
            ///  Capture/Compare 4 overcapture flag
            CC4OF: u1,
            reserved16: u3,
            ///  Capture/Compare 5 interrupt flag
            C5IF: u1,
            ///  Capture/Compare 6 interrupt flag
            C6IF: u1,
            padding: u14,
        }),
        ///  event generation register
        EGR: mmio.Mmio(packed struct(u32) {
            ///  Update generation
            UG: u1,
            ///  Capture/compare 1 generation
            CC1G: u1,
            ///  Capture/compare 2 generation
            CC2G: u1,
            ///  Capture/compare 3 generation
            CC3G: u1,
            ///  Capture/compare 4 generation
            CC4G: u1,
            ///  Capture/Compare control update generation
            COMG: u1,
            ///  Trigger generation
            TG: u1,
            ///  Break generation
            BG: u1,
            ///  Break 2 generation
            B2G: u1,
            padding: u23,
        }),
        ///  capture/compare mode register (output mode)
        CCMR1_Output: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 selection
            CC1S: u2,
            ///  Output Compare 1 fast enable
            OC1FE: u1,
            ///  Output Compare 1 preload enable
            OC1PE: u1,
            ///  Output Compare 1 mode
            OC1M: u3,
            ///  Output Compare 1 clear enable
            OC1CE: u1,
            ///  Capture/Compare 2 selection
            CC2S: u2,
            ///  Output Compare 2 fast enable
            OC2FE: u1,
            ///  Output Compare 2 preload enable
            OC2PE: u1,
            ///  Output Compare 2 mode
            OC2M: u3,
            ///  Output Compare 2 clear enable
            OC2CE: u1,
            ///  Output Compare 1 mode bit 3
            OC1M_3: u1,
            reserved24: u7,
            ///  Output Compare 2 mode bit 3
            OC2M_3: u1,
            padding: u7,
        }),
        ///  capture/compare mode register (output mode)
        CCMR2_Output: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 3 selection
            CC3S: u2,
            ///  Output compare 3 fast enable
            OC3FE: u1,
            ///  Output compare 3 preload enable
            OC3PE: u1,
            ///  Output compare 3 mode
            OC3M: u3,
            ///  Output compare 3 clear enable
            OC3CE: u1,
            ///  Capture/Compare 4 selection
            CC4S: u2,
            ///  Output compare 4 fast enable
            OC4FE: u1,
            ///  Output compare 4 preload enable
            OC4PE: u1,
            ///  Output compare 4 mode
            OC4M: u3,
            ///  Output compare 4 clear enable
            OC4CE: u1,
            ///  Output Compare 3 mode bit 3
            OC3M_3: u1,
            reserved24: u7,
            ///  Output Compare 4 mode bit 3
            OC4M_3: u1,
            padding: u7,
        }),
        ///  capture/compare enable register
        CCER: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 output enable
            CC1E: u1,
            ///  Capture/Compare 1 output Polarity
            CC1P: u1,
            ///  Capture/Compare 1 complementary output enable
            CC1NE: u1,
            ///  Capture/Compare 1 output Polarity
            CC1NP: u1,
            ///  Capture/Compare 2 output enable
            CC2E: u1,
            ///  Capture/Compare 2 output Polarity
            CC2P: u1,
            ///  Capture/Compare 2 complementary output enable
            CC2NE: u1,
            ///  Capture/Compare 2 output Polarity
            CC2NP: u1,
            ///  Capture/Compare 3 output enable
            CC3E: u1,
            ///  Capture/Compare 3 output Polarity
            CC3P: u1,
            ///  Capture/Compare 3 complementary output enable
            CC3NE: u1,
            ///  Capture/Compare 3 output Polarity
            CC3NP: u1,
            ///  Capture/Compare 4 output enable
            CC4E: u1,
            ///  Capture/Compare 3 output Polarity
            CC4P: u1,
            reserved15: u1,
            ///  Capture/Compare 4 output Polarity
            CC4NP: u1,
            ///  Capture/Compare 5 output enable
            CC5E: u1,
            ///  Capture/Compare 5 output Polarity
            CC5P: u1,
            reserved20: u2,
            ///  Capture/Compare 6 output enable
            CC6E: u1,
            ///  Capture/Compare 6 output Polarity
            CC6P: u1,
            padding: u10,
        }),
        ///  counter
        CNT: mmio.Mmio(packed struct(u32) {
            ///  counter value
            CNT: u16,
            reserved31: u15,
            ///  UIF copy
            UIFCPY: u1,
        }),
        ///  prescaler
        PSC: mmio.Mmio(packed struct(u32) {
            ///  Prescaler value
            PSC: u16,
            padding: u16,
        }),
        ///  auto-reload register
        ARR: mmio.Mmio(packed struct(u32) {
            ///  Auto-reload value
            ARR: u16,
            padding: u16,
        }),
        ///  repetition counter register
        RCR: mmio.Mmio(packed struct(u32) {
            ///  Repetition counter value
            REP: u16,
            padding: u16,
        }),
        ///  capture/compare register 1
        CCR1: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 value
            CCR1: u16,
            padding: u16,
        }),
        ///  capture/compare register 2
        CCR2: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 2 value
            CCR2: u16,
            padding: u16,
        }),
        ///  capture/compare register 3
        CCR3: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 3 value
            CCR3: u16,
            padding: u16,
        }),
        ///  capture/compare register 4
        CCR4: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 3 value
            CCR4: u16,
            padding: u16,
        }),
        ///  break and dead-time register
        BDTR: mmio.Mmio(packed struct(u32) {
            ///  Dead-time generator setup
            DTG: u8,
            ///  Lock configuration
            LOCK: u2,
            ///  Off-state selection for Idle mode
            OSSI: u1,
            ///  Off-state selection for Run mode
            OSSR: u1,
            ///  Break enable
            BKE: u1,
            ///  Break polarity
            BKP: u1,
            ///  Automatic output enable
            AOE: u1,
            ///  Main output enable
            MOE: u1,
            ///  Break filter
            BKF: u4,
            ///  Break 2 filter
            BK2F: u4,
            ///  Break 2 enable
            BK2E: u1,
            ///  Break 2 polarity
            BK2P: u1,
            padding: u6,
        }),
        ///  DMA control register
        DCR: mmio.Mmio(packed struct(u32) {
            ///  DMA base address
            DBA: u5,
            reserved8: u3,
            ///  DMA burst length
            DBL: u5,
            padding: u19,
        }),
        ///  DMA address for full transfer
        DMAR: mmio.Mmio(packed struct(u32) {
            ///  DMA register for burst accesses
            DMAB: u16,
            padding: u16,
        }),
        reserved84: [4]u8,
        ///  capture/compare mode register 3 (output mode)
        CCMR3_Output: mmio.Mmio(packed struct(u32) {
            reserved2: u2,
            ///  Output compare 5 fast enable
            OC5FE: u1,
            ///  Output compare 5 preload enable
            OC5PE: u1,
            ///  Output compare 5 mode
            OC5M: u3,
            ///  Output compare 5 clear enable
            OC5CE: u1,
            reserved10: u2,
            ///  Output compare 6 fast enable
            OC6FE: u1,
            ///  Output compare 6 preload enable
            OC6PE: u1,
            ///  Output compare 6 mode
            OC6M: u3,
            ///  Output compare 6 clear enable
            OC6CE: u1,
            ///  Outout Compare 5 mode bit 3
            OC5M_3: u1,
            reserved24: u7,
            ///  Outout Compare 6 mode bit 3
            OC6M_3: u1,
            padding: u7,
        }),
        ///  capture/compare register 5
        CCR5: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 5 value
            CCR5: u16,
            reserved29: u13,
            ///  Group Channel 5 and Channel 1
            GC5C1: u1,
            ///  Group Channel 5 and Channel 2
            GC5C2: u1,
            ///  Group Channel 5 and Channel 3
            GC5C3: u1,
        }),
        ///  capture/compare register 6
        CCR6: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 6 value
            CCR6: u16,
            padding: u16,
        }),
        ///  option registers
        OR: mmio.Mmio(packed struct(u32) {
            ///  TIM1_ETR_ADC1 remapping capability
            TIM1_ETR_ADC1_RMP: u2,
            ///  TIM1_ETR_ADC4 remapping capability
            TIM1_ETR_ADC4_RMP: u2,
            padding: u28,
        }),
    };

    ///  Debug support
    pub const DBGMCU = extern struct {
        ///  MCU Device ID Code Register
        IDCODE: mmio.Mmio(packed struct(u32) {
            ///  Device Identifier
            DEV_ID: u12,
            reserved16: u4,
            ///  Revision Identifier
            REV_ID: u16,
        }),
        ///  Debug MCU Configuration Register
        CR: mmio.Mmio(packed struct(u32) {
            ///  Debug Sleep mode
            DBG_SLEEP: u1,
            ///  Debug Stop Mode
            DBG_STOP: u1,
            ///  Debug Standby Mode
            DBG_STANDBY: u1,
            reserved5: u2,
            ///  Trace pin assignment control
            TRACE_IOEN: u1,
            ///  Trace pin assignment control
            TRACE_MODE: u2,
            padding: u24,
        }),
        ///  APB Low Freeze Register
        APB1FZ: mmio.Mmio(packed struct(u32) {
            ///  Debug Timer 2 stopped when Core is halted
            DBG_TIM2_STOP: u1,
            ///  Debug Timer 3 stopped when Core is halted
            DBG_TIM3_STOP: u1,
            ///  Debug Timer 4 stopped when Core is halted
            DBG_TIM4_STOP: u1,
            ///  Debug Timer 5 stopped when Core is halted
            DBG_TIM5_STOP: u1,
            ///  Debug Timer 6 stopped when Core is halted
            DBG_TIM6_STOP: u1,
            ///  Debug Timer 7 stopped when Core is halted
            DBG_TIM7_STOP: u1,
            ///  Debug Timer 12 stopped when Core is halted
            DBG_TIM12_STOP: u1,
            ///  Debug Timer 13 stopped when Core is halted
            DBG_TIM13_STOP: u1,
            ///  Debug Timer 14 stopped when Core is halted
            DBG_TIMER14_STOP: u1,
            ///  Debug Timer 18 stopped when Core is halted
            DBG_TIM18_STOP: u1,
            ///  Debug RTC stopped when Core is halted
            DBG_RTC_STOP: u1,
            ///  Debug Window Wachdog stopped when Core is halted
            DBG_WWDG_STOP: u1,
            ///  Debug Independent Wachdog stopped when Core is halted
            DBG_IWDG_STOP: u1,
            reserved21: u8,
            ///  SMBUS timeout mode stopped when Core is halted
            I2C1_SMBUS_TIMEOUT: u1,
            ///  SMBUS timeout mode stopped when Core is halted
            I2C2_SMBUS_TIMEOUT: u1,
            reserved25: u2,
            ///  Debug CAN stopped when core is halted
            DBG_CAN_STOP: u1,
            padding: u6,
        }),
        ///  APB High Freeze Register
        APB2FZ: mmio.Mmio(packed struct(u32) {
            reserved2: u2,
            ///  Debug Timer 15 stopped when Core is halted
            DBG_TIM15_STOP: u1,
            ///  Debug Timer 16 stopped when Core is halted
            DBG_TIM16_STOP: u1,
            ///  Debug Timer 17 stopped when Core is halted
            DBG_TIM17_STO: u1,
            ///  Debug Timer 19 stopped when Core is halted
            DBG_TIM19_STOP: u1,
            padding: u26,
        }),
    };
};
