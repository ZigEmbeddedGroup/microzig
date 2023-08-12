const micro = @import("microzig");
const mmio = micro.mmio;

pub const devices = struct {
    ///  STM32F429
    pub const STM32F429 = struct {
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
            ///  Tamper and TimeStamp interrupts through the EXTI line
            TAMP_STAMP: Handler = unhandled,
            ///  RTC Wakeup interrupt through the EXTI line
            RTC_WKUP: Handler = unhandled,
            ///  Flash global interrupt
            FLASH: Handler = unhandled,
            ///  RCC global interrupt
            RCC: Handler = unhandled,
            reserved20: [5]u32 = undefined,
            ///  DMA1 Stream0 global interrupt
            DMA1_Stream0: Handler = unhandled,
            reserved26: [6]u32 = undefined,
            ///  ADC2 global interrupts
            ADC: Handler = unhandled,
            ///  CAN1 TX interrupts
            CAN1_TX: Handler = unhandled,
            reserved34: [4]u32 = undefined,
            ///  TIM1 Break interrupt and TIM9 global interrupt
            TIM1_BRK_TIM9: Handler = unhandled,
            reserved39: [3]u32 = undefined,
            ///  TIM2 global interrupt
            TIM2: Handler = unhandled,
            ///  TIM3 global interrupt
            TIM3: Handler = unhandled,
            ///  TIM4 global interrupt
            TIM4: Handler = unhandled,
            ///  I2C1 event interrupt
            I2C1_EV: Handler = unhandled,
            reserved46: [1]u32 = undefined,
            ///  I2C2 event interrupt
            I2C2_EV: Handler = unhandled,
            reserved48: [1]u32 = undefined,
            ///  SPI1 global interrupt
            SPI1: Handler = unhandled,
            ///  SPI2 global interrupt
            SPI2: Handler = unhandled,
            ///  USART1 global interrupt
            USART1: Handler = unhandled,
            ///  USART2 global interrupt
            USART2: Handler = unhandled,
            ///  USART3 global interrupt
            USART3: Handler = unhandled,
            reserved54: [2]u32 = undefined,
            ///  USB On-The-Go FS Wakeup through EXTI line interrupt
            OTG_FS_WKUP: Handler = unhandled,
            ///  TIM8 Break interrupt and TIM12 global interrupt
            TIM8_BRK_TIM12: Handler = unhandled,
            ///  TIM8 Update interrupt and TIM13 global interrupt
            TIM8_UP_TIM13: Handler = unhandled,
            ///  TIM8 Trigger and Commutation interrupts and TIM14 global interrupt
            TIM8_TRG_COM_TIM14: Handler = unhandled,
            reserved60: [2]u32 = undefined,
            ///  FMC global interrupt
            FMC: Handler = unhandled,
            ///  SDIO global interrupt
            SDIO: Handler = unhandled,
            ///  TIM5 global interrupt
            TIM5: Handler = unhandled,
            ///  SPI3 global interrupt
            SPI3: Handler = unhandled,
            ///  UART4 global interrupt
            UART4: Handler = unhandled,
            ///  UART5 global interrupt
            UART5: Handler = unhandled,
            ///  TIM6 global interrupt, DAC1 and DAC2 underrun error interrupt
            TIM6_DAC: Handler = unhandled,
            ///  TIM7 global interrupt
            TIM7: Handler = unhandled,
            ///  DMA2 Stream0 global interrupt
            DMA2_Stream0: Handler = unhandled,
            reserved71: [4]u32 = undefined,
            ///  Ethernet global interrupt
            ETH: Handler = unhandled,
            reserved76: [1]u32 = undefined,
            ///  CAN2 TX interrupts
            CAN2_TX: Handler = unhandled,
            reserved78: [7]u32 = undefined,
            ///  USART6 global interrupt
            USART6: Handler = unhandled,
            ///  I2C3 event interrupt
            I2C3_EV: Handler = unhandled,
            reserved87: [1]u32 = undefined,
            ///  USB On The Go HS End Point 1 Out global interrupt
            OTG_HS_EP1_OUT: Handler = unhandled,
            reserved89: [3]u32 = undefined,
            ///  DCMI global interrupt
            DCMI: Handler = unhandled,
            ///  CRYP crypto global interrupt
            CRYP: Handler = unhandled,
            ///  Hash and Rng global interrupt
            HASH_RNG: Handler = unhandled,
            ///  FPU interrupt
            FPU: Handler = unhandled,
            ///  UART 7 global interrupt
            UART7: Handler = unhandled,
            ///  UART 8 global interrupt
            UART8: Handler = unhandled,
            ///  SPI 4 global interrupt
            SPI4: Handler = unhandled,
            ///  SPI 5 global interrupt
            SPI5: Handler = unhandled,
            ///  SPI 6 global interrupt
            SPI6: Handler = unhandled,
            ///  SAI1 global interrupt
            SAI1: Handler = unhandled,
            ///  LTDC global interrupt
            LCD_TFT: Handler = unhandled,
            reserved103: [1]u32 = undefined,
            ///  DMA2D global interrupt
            DMA2D: Handler = unhandled,
        };

        pub const peripherals = struct {
            ///  General purpose timers
            pub const TIM2 = @as(*volatile types.TIM2, @ptrFromInt(0x40000000));
            ///  General purpose timers
            pub const TIM3 = @as(*volatile types.TIM3, @ptrFromInt(0x40000400));
            ///  General purpose timers
            pub const TIM4 = @as(*volatile types.TIM3, @ptrFromInt(0x40000800));
            ///  General-purpose-timers
            pub const TIM5 = @as(*volatile types.TIM5, @ptrFromInt(0x40000c00));
            ///  Basic timers
            pub const TIM6 = @as(*volatile types.TIM6, @ptrFromInt(0x40001000));
            ///  Basic timers
            pub const TIM7 = @as(*volatile types.TIM6, @ptrFromInt(0x40001400));
            ///  General purpose timers
            pub const TIM12 = @as(*volatile types.TIM9, @ptrFromInt(0x40001800));
            ///  General-purpose-timers
            pub const TIM13 = @as(*volatile types.TIM10, @ptrFromInt(0x40001c00));
            ///  General-purpose-timers
            pub const TIM14 = @as(*volatile types.TIM10, @ptrFromInt(0x40002000));
            ///  Real-time clock
            pub const RTC = @as(*volatile types.RTC, @ptrFromInt(0x40002800));
            ///  Window watchdog
            pub const WWDG = @as(*volatile types.WWDG, @ptrFromInt(0x40002c00));
            ///  Independent watchdog
            pub const IWDG = @as(*volatile types.IWDG, @ptrFromInt(0x40003000));
            ///  Serial peripheral interface
            pub const I2S2ext = @as(*volatile types.SPI1, @ptrFromInt(0x40003400));
            ///  Serial peripheral interface
            pub const SPI2 = @as(*volatile types.SPI1, @ptrFromInt(0x40003800));
            ///  Serial peripheral interface
            pub const SPI3 = @as(*volatile types.SPI1, @ptrFromInt(0x40003c00));
            ///  Serial peripheral interface
            pub const I2S3ext = @as(*volatile types.SPI1, @ptrFromInt(0x40004000));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const USART2 = @as(*volatile types.USART6, @ptrFromInt(0x40004400));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const USART3 = @as(*volatile types.USART6, @ptrFromInt(0x40004800));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const UART4 = @as(*volatile types.UART4, @ptrFromInt(0x40004c00));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const UART5 = @as(*volatile types.UART4, @ptrFromInt(0x40005000));
            ///  Inter-integrated circuit
            pub const I2C1 = @as(*volatile types.I2C3, @ptrFromInt(0x40005400));
            ///  Inter-integrated circuit
            pub const I2C2 = @as(*volatile types.I2C3, @ptrFromInt(0x40005800));
            ///  Inter-integrated circuit
            pub const I2C3 = @as(*volatile types.I2C3, @ptrFromInt(0x40005c00));
            ///  Controller area network
            pub const CAN1 = @as(*volatile types.CAN1, @ptrFromInt(0x40006400));
            ///  Controller area network
            pub const CAN2 = @as(*volatile types.CAN1, @ptrFromInt(0x40006800));
            ///  Power control
            pub const PWR = @as(*volatile types.PWR, @ptrFromInt(0x40007000));
            ///  Digital-to-analog converter
            pub const DAC = @as(*volatile types.DAC, @ptrFromInt(0x40007400));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const UART7 = @as(*volatile types.USART6, @ptrFromInt(0x40007800));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const UART8 = @as(*volatile types.USART6, @ptrFromInt(0x40007c00));
            ///  Advanced-timers
            pub const TIM1 = @as(*volatile types.TIM1, @ptrFromInt(0x40010000));
            ///  Advanced-timers
            pub const TIM8 = @as(*volatile types.TIM1, @ptrFromInt(0x40010400));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const USART1 = @as(*volatile types.USART6, @ptrFromInt(0x40011000));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const USART6 = @as(*volatile types.USART6, @ptrFromInt(0x40011400));
            ///  Analog-to-digital converter
            pub const ADC1 = @as(*volatile types.ADC1, @ptrFromInt(0x40012000));
            ///  Analog-to-digital converter
            pub const ADC2 = @as(*volatile types.ADC1, @ptrFromInt(0x40012100));
            ///  Analog-to-digital converter
            pub const ADC3 = @as(*volatile types.ADC1, @ptrFromInt(0x40012200));
            ///  Common ADC registers
            pub const C_ADC = @as(*volatile types.C_ADC, @ptrFromInt(0x40012300));
            ///  Secure digital input/output interface
            pub const SDIO = @as(*volatile types.SDIO, @ptrFromInt(0x40012c00));
            ///  Serial peripheral interface
            pub const SPI1 = @as(*volatile types.SPI1, @ptrFromInt(0x40013000));
            ///  Serial peripheral interface
            pub const SPI4 = @as(*volatile types.SPI1, @ptrFromInt(0x40013400));
            ///  System configuration controller
            pub const SYSCFG = @as(*volatile types.SYSCFG, @ptrFromInt(0x40013800));
            ///  External interrupt/event controller
            pub const EXTI = @as(*volatile types.EXTI, @ptrFromInt(0x40013c00));
            ///  General purpose timers
            pub const TIM9 = @as(*volatile types.TIM9, @ptrFromInt(0x40014000));
            ///  General-purpose-timers
            pub const TIM10 = @as(*volatile types.TIM10, @ptrFromInt(0x40014400));
            ///  General-purpose-timers
            pub const TIM11 = @as(*volatile types.TIM11, @ptrFromInt(0x40014800));
            ///  Serial peripheral interface
            pub const SPI5 = @as(*volatile types.SPI1, @ptrFromInt(0x40015000));
            ///  Serial peripheral interface
            pub const SPI6 = @as(*volatile types.SPI1, @ptrFromInt(0x40015400));
            ///  Serial audio interface
            pub const SAI = @as(*volatile types.SAI, @ptrFromInt(0x40015800));
            ///  LCD-TFT Controller
            pub const LTDC = @as(*volatile types.LTDC, @ptrFromInt(0x40016800));
            ///  General-purpose I/Os
            pub const GPIOA = @as(*volatile types.GPIOA, @ptrFromInt(0x40020000));
            ///  General-purpose I/Os
            pub const GPIOB = @as(*volatile types.GPIOB, @ptrFromInt(0x40020400));
            ///  General-purpose I/Os
            pub const GPIOC = @as(*volatile types.GPIOK, @ptrFromInt(0x40020800));
            ///  General-purpose I/Os
            pub const GPIOD = @as(*volatile types.GPIOK, @ptrFromInt(0x40020c00));
            ///  General-purpose I/Os
            pub const GPIOE = @as(*volatile types.GPIOK, @ptrFromInt(0x40021000));
            ///  General-purpose I/Os
            pub const GPIOF = @as(*volatile types.GPIOK, @ptrFromInt(0x40021400));
            ///  General-purpose I/Os
            pub const GPIOG = @as(*volatile types.GPIOK, @ptrFromInt(0x40021800));
            ///  General-purpose I/Os
            pub const GPIOH = @as(*volatile types.GPIOK, @ptrFromInt(0x40021c00));
            ///  General-purpose I/Os
            pub const GPIOI = @as(*volatile types.GPIOK, @ptrFromInt(0x40022000));
            ///  General-purpose I/Os
            pub const GPIOJ = @as(*volatile types.GPIOK, @ptrFromInt(0x40022400));
            ///  General-purpose I/Os
            pub const GPIOK = @as(*volatile types.GPIOK, @ptrFromInt(0x40022800));
            ///  Cryptographic processor
            pub const CRC = @as(*volatile types.CRC, @ptrFromInt(0x40023000));
            ///  Reset and clock control
            pub const RCC = @as(*volatile types.RCC, @ptrFromInt(0x40023800));
            ///  FLASH
            pub const FLASH = @as(*volatile types.FLASH, @ptrFromInt(0x40023c00));
            ///  DMA controller
            pub const DMA1 = @as(*volatile types.DMA2, @ptrFromInt(0x40026000));
            ///  DMA controller
            pub const DMA2 = @as(*volatile types.DMA2, @ptrFromInt(0x40026400));
            ///  Ethernet: media access control (MAC)
            pub const Ethernet_MAC = @as(*volatile types.Ethernet_MAC, @ptrFromInt(0x40028000));
            ///  Ethernet: MAC management counters
            pub const Ethernet_MMC = @as(*volatile types.Ethernet_MMC, @ptrFromInt(0x40028100));
            ///  Ethernet: Precision time protocol
            pub const Ethernet_PTP = @as(*volatile types.Ethernet_PTP, @ptrFromInt(0x40028700));
            ///  Ethernet: DMA controller operation
            pub const Ethernet_DMA = @as(*volatile types.Ethernet_DMA, @ptrFromInt(0x40029000));
            ///  DMA2D controller
            pub const DMA2D = @as(*volatile types.DMA2D, @ptrFromInt(0x4002b000));
            ///  USB on the go high speed
            pub const OTG_HS_GLOBAL = @as(*volatile types.OTG_HS_GLOBAL, @ptrFromInt(0x40040000));
            ///  USB on the go high speed
            pub const OTG_HS_HOST = @as(*volatile types.OTG_HS_HOST, @ptrFromInt(0x40040400));
            ///  USB on the go high speed
            pub const OTG_HS_DEVICE = @as(*volatile types.OTG_HS_DEVICE, @ptrFromInt(0x40040800));
            ///  USB on the go high speed
            pub const OTG_HS_PWRCLK = @as(*volatile types.OTG_HS_PWRCLK, @ptrFromInt(0x40040e00));
            ///  USB on the go full speed
            pub const OTG_FS_GLOBAL = @as(*volatile types.OTG_FS_GLOBAL, @ptrFromInt(0x50000000));
            ///  USB on the go full speed
            pub const OTG_FS_HOST = @as(*volatile types.OTG_FS_HOST, @ptrFromInt(0x50000400));
            ///  USB on the go full speed
            pub const OTG_FS_DEVICE = @as(*volatile types.OTG_FS_DEVICE, @ptrFromInt(0x50000800));
            ///  USB on the go full speed
            pub const OTG_FS_PWRCLK = @as(*volatile types.OTG_FS_PWRCLK, @ptrFromInt(0x50000e00));
            ///  Digital camera interface
            pub const DCMI = @as(*volatile types.DCMI, @ptrFromInt(0x50050000));
            ///  Cryptographic processor
            pub const CRYP = @as(*volatile types.CRYP, @ptrFromInt(0x50060000));
            ///  Hash processor
            pub const HASH = @as(*volatile types.HASH, @ptrFromInt(0x50060400));
            ///  Random number generator
            pub const RNG = @as(*volatile types.RNG, @ptrFromInt(0x50060800));
            ///  Flexible memory controller
            pub const FMC = @as(*volatile types.FMC, @ptrFromInt(0xa0000000));
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
            pub const DBG = @as(*volatile types.DBG, @ptrFromInt(0xe0042000));
        };
    };
};

pub const types = struct {
    ///  Random number generator
    pub const RNG = extern struct {
        ///  control register
        CR: mmio.Mmio(packed struct(u32) {
            reserved2: u2,
            ///  Random number generator enable
            RNGEN: u1,
            ///  Interrupt enable
            IE: u1,
            padding: u28,
        }),
        ///  status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Data ready
            DRDY: u1,
            ///  Clock error current status
            CECS: u1,
            ///  Seed error current status
            SECS: u1,
            reserved5: u2,
            ///  Clock error interrupt status
            CEIS: u1,
            ///  Seed error interrupt status
            SEIS: u1,
            padding: u25,
        }),
        ///  data register
        DR: mmio.Mmio(packed struct(u32) {
            ///  Random data
            RNDATA: u32,
        }),
    };

    ///  Hash processor
    pub const HASH = extern struct {
        ///  control register
        CR: mmio.Mmio(packed struct(u32) {
            reserved2: u2,
            ///  Initialize message digest calculation
            INIT: u1,
            ///  DMA enable
            DMAE: u1,
            ///  Data type selection
            DATATYPE: u2,
            ///  Mode selection
            MODE: u1,
            ///  Algorithm selection
            ALGO0: u1,
            ///  Number of words already pushed
            NBW: u4,
            ///  DIN not empty
            DINNE: u1,
            ///  Multiple DMA Transfers
            MDMAT: u1,
            reserved16: u2,
            ///  Long key selection
            LKEY: u1,
            reserved18: u1,
            ///  ALGO
            ALGO1: u1,
            padding: u13,
        }),
        ///  data input register
        DIN: mmio.Mmio(packed struct(u32) {
            ///  Data input
            DATAIN: u32,
        }),
        ///  start register
        STR: mmio.Mmio(packed struct(u32) {
            ///  Number of valid bits in the last word of the message
            NBLW: u5,
            reserved8: u3,
            ///  Digest calculation
            DCAL: u1,
            padding: u23,
        }),
        ///  digest registers
        HR0: mmio.Mmio(packed struct(u32) {
            ///  H0
            H0: u32,
        }),
        ///  digest registers
        HR1: mmio.Mmio(packed struct(u32) {
            ///  H1
            H1: u32,
        }),
        ///  digest registers
        HR2: mmio.Mmio(packed struct(u32) {
            ///  H2
            H2: u32,
        }),
        ///  digest registers
        HR3: mmio.Mmio(packed struct(u32) {
            ///  H3
            H3: u32,
        }),
        ///  digest registers
        HR4: mmio.Mmio(packed struct(u32) {
            ///  H4
            H4: u32,
        }),
        ///  interrupt enable register
        IMR: mmio.Mmio(packed struct(u32) {
            ///  Data input interrupt enable
            DINIE: u1,
            ///  Digest calculation completion interrupt enable
            DCIE: u1,
            padding: u30,
        }),
        ///  status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Data input interrupt status
            DINIS: u1,
            ///  Digest calculation completion interrupt status
            DCIS: u1,
            ///  DMA Status
            DMAS: u1,
            ///  Busy bit
            BUSY: u1,
            padding: u28,
        }),
        reserved248: [208]u8,
        ///  context swap registers
        CSR0: mmio.Mmio(packed struct(u32) {
            ///  CSR0
            CSR0: u32,
        }),
        ///  context swap registers
        CSR1: mmio.Mmio(packed struct(u32) {
            ///  CSR1
            CSR1: u32,
        }),
        ///  context swap registers
        CSR2: mmio.Mmio(packed struct(u32) {
            ///  CSR2
            CSR2: u32,
        }),
        ///  context swap registers
        CSR3: mmio.Mmio(packed struct(u32) {
            ///  CSR3
            CSR3: u32,
        }),
        ///  context swap registers
        CSR4: mmio.Mmio(packed struct(u32) {
            ///  CSR4
            CSR4: u32,
        }),
        ///  context swap registers
        CSR5: mmio.Mmio(packed struct(u32) {
            ///  CSR5
            CSR5: u32,
        }),
        ///  context swap registers
        CSR6: mmio.Mmio(packed struct(u32) {
            ///  CSR6
            CSR6: u32,
        }),
        ///  context swap registers
        CSR7: mmio.Mmio(packed struct(u32) {
            ///  CSR7
            CSR7: u32,
        }),
        ///  context swap registers
        CSR8: mmio.Mmio(packed struct(u32) {
            ///  CSR8
            CSR8: u32,
        }),
        ///  context swap registers
        CSR9: mmio.Mmio(packed struct(u32) {
            ///  CSR9
            CSR9: u32,
        }),
        ///  context swap registers
        CSR10: mmio.Mmio(packed struct(u32) {
            ///  CSR10
            CSR10: u32,
        }),
        ///  context swap registers
        CSR11: mmio.Mmio(packed struct(u32) {
            ///  CSR11
            CSR11: u32,
        }),
        ///  context swap registers
        CSR12: mmio.Mmio(packed struct(u32) {
            ///  CSR12
            CSR12: u32,
        }),
        ///  context swap registers
        CSR13: mmio.Mmio(packed struct(u32) {
            ///  CSR13
            CSR13: u32,
        }),
        ///  context swap registers
        CSR14: mmio.Mmio(packed struct(u32) {
            ///  CSR14
            CSR14: u32,
        }),
        ///  context swap registers
        CSR15: mmio.Mmio(packed struct(u32) {
            ///  CSR15
            CSR15: u32,
        }),
        ///  context swap registers
        CSR16: mmio.Mmio(packed struct(u32) {
            ///  CSR16
            CSR16: u32,
        }),
        ///  context swap registers
        CSR17: mmio.Mmio(packed struct(u32) {
            ///  CSR17
            CSR17: u32,
        }),
        ///  context swap registers
        CSR18: mmio.Mmio(packed struct(u32) {
            ///  CSR18
            CSR18: u32,
        }),
        ///  context swap registers
        CSR19: mmio.Mmio(packed struct(u32) {
            ///  CSR19
            CSR19: u32,
        }),
        ///  context swap registers
        CSR20: mmio.Mmio(packed struct(u32) {
            ///  CSR20
            CSR20: u32,
        }),
        ///  context swap registers
        CSR21: mmio.Mmio(packed struct(u32) {
            ///  CSR21
            CSR21: u32,
        }),
        ///  context swap registers
        CSR22: mmio.Mmio(packed struct(u32) {
            ///  CSR22
            CSR22: u32,
        }),
        ///  context swap registers
        CSR23: mmio.Mmio(packed struct(u32) {
            ///  CSR23
            CSR23: u32,
        }),
        ///  context swap registers
        CSR24: mmio.Mmio(packed struct(u32) {
            ///  CSR24
            CSR24: u32,
        }),
        ///  context swap registers
        CSR25: mmio.Mmio(packed struct(u32) {
            ///  CSR25
            CSR25: u32,
        }),
        ///  context swap registers
        CSR26: mmio.Mmio(packed struct(u32) {
            ///  CSR26
            CSR26: u32,
        }),
        ///  context swap registers
        CSR27: mmio.Mmio(packed struct(u32) {
            ///  CSR27
            CSR27: u32,
        }),
        ///  context swap registers
        CSR28: mmio.Mmio(packed struct(u32) {
            ///  CSR28
            CSR28: u32,
        }),
        ///  context swap registers
        CSR29: mmio.Mmio(packed struct(u32) {
            ///  CSR29
            CSR29: u32,
        }),
        ///  context swap registers
        CSR30: mmio.Mmio(packed struct(u32) {
            ///  CSR30
            CSR30: u32,
        }),
        ///  context swap registers
        CSR31: mmio.Mmio(packed struct(u32) {
            ///  CSR31
            CSR31: u32,
        }),
        ///  context swap registers
        CSR32: mmio.Mmio(packed struct(u32) {
            ///  CSR32
            CSR32: u32,
        }),
        ///  context swap registers
        CSR33: mmio.Mmio(packed struct(u32) {
            ///  CSR33
            CSR33: u32,
        }),
        ///  context swap registers
        CSR34: mmio.Mmio(packed struct(u32) {
            ///  CSR34
            CSR34: u32,
        }),
        ///  context swap registers
        CSR35: mmio.Mmio(packed struct(u32) {
            ///  CSR35
            CSR35: u32,
        }),
        ///  context swap registers
        CSR36: mmio.Mmio(packed struct(u32) {
            ///  CSR36
            CSR36: u32,
        }),
        ///  context swap registers
        CSR37: mmio.Mmio(packed struct(u32) {
            ///  CSR37
            CSR37: u32,
        }),
        ///  context swap registers
        CSR38: mmio.Mmio(packed struct(u32) {
            ///  CSR38
            CSR38: u32,
        }),
        ///  context swap registers
        CSR39: mmio.Mmio(packed struct(u32) {
            ///  CSR39
            CSR39: u32,
        }),
        ///  context swap registers
        CSR40: mmio.Mmio(packed struct(u32) {
            ///  CSR40
            CSR40: u32,
        }),
        ///  context swap registers
        CSR41: mmio.Mmio(packed struct(u32) {
            ///  CSR41
            CSR41: u32,
        }),
        ///  context swap registers
        CSR42: mmio.Mmio(packed struct(u32) {
            ///  CSR42
            CSR42: u32,
        }),
        ///  context swap registers
        CSR43: mmio.Mmio(packed struct(u32) {
            ///  CSR43
            CSR43: u32,
        }),
        ///  context swap registers
        CSR44: mmio.Mmio(packed struct(u32) {
            ///  CSR44
            CSR44: u32,
        }),
        ///  context swap registers
        CSR45: mmio.Mmio(packed struct(u32) {
            ///  CSR45
            CSR45: u32,
        }),
        ///  context swap registers
        CSR46: mmio.Mmio(packed struct(u32) {
            ///  CSR46
            CSR46: u32,
        }),
        ///  context swap registers
        CSR47: mmio.Mmio(packed struct(u32) {
            ///  CSR47
            CSR47: u32,
        }),
        ///  context swap registers
        CSR48: mmio.Mmio(packed struct(u32) {
            ///  CSR48
            CSR48: u32,
        }),
        ///  context swap registers
        CSR49: mmio.Mmio(packed struct(u32) {
            ///  CSR49
            CSR49: u32,
        }),
        ///  context swap registers
        CSR50: mmio.Mmio(packed struct(u32) {
            ///  CSR50
            CSR50: u32,
        }),
        ///  context swap registers
        CSR51: mmio.Mmio(packed struct(u32) {
            ///  CSR51
            CSR51: u32,
        }),
        ///  context swap registers
        CSR52: mmio.Mmio(packed struct(u32) {
            ///  CSR52
            CSR52: u32,
        }),
        ///  context swap registers
        CSR53: mmio.Mmio(packed struct(u32) {
            ///  CSR53
            CSR53: u32,
        }),
        reserved784: [320]u8,
        ///  HASH digest register
        HASH_HR0: mmio.Mmio(packed struct(u32) {
            ///  H0
            H0: u32,
        }),
        ///  read-only
        HASH_HR1: mmio.Mmio(packed struct(u32) {
            ///  H1
            H1: u32,
        }),
        ///  read-only
        HASH_HR2: mmio.Mmio(packed struct(u32) {
            ///  H2
            H2: u32,
        }),
        ///  read-only
        HASH_HR3: mmio.Mmio(packed struct(u32) {
            ///  H3
            H3: u32,
        }),
        ///  read-only
        HASH_HR4: mmio.Mmio(packed struct(u32) {
            ///  H4
            H4: u32,
        }),
        ///  read-only
        HASH_HR5: mmio.Mmio(packed struct(u32) {
            ///  H5
            H5: u32,
        }),
        ///  read-only
        HASH_HR6: mmio.Mmio(packed struct(u32) {
            ///  H6
            H6: u32,
        }),
        ///  read-only
        HASH_HR7: mmio.Mmio(packed struct(u32) {
            ///  H7
            H7: u32,
        }),
    };

    ///  Cryptographic processor
    pub const CRYP = extern struct {
        ///  control register
        CR: mmio.Mmio(packed struct(u32) {
            reserved2: u2,
            ///  Algorithm direction
            ALGODIR: u1,
            ///  Algorithm mode
            ALGOMODE0: u3,
            ///  Data type selection
            DATATYPE: u2,
            ///  Key size selection (AES mode only)
            KEYSIZE: u2,
            reserved14: u4,
            ///  FIFO flush
            FFLUSH: u1,
            ///  Cryptographic processor enable
            CRYPEN: u1,
            ///  GCM_CCMPH
            GCM_CCMPH: u2,
            reserved19: u1,
            ///  ALGOMODE
            ALGOMODE3: u1,
            padding: u12,
        }),
        ///  status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Input FIFO empty
            IFEM: u1,
            ///  Input FIFO not full
            IFNF: u1,
            ///  Output FIFO not empty
            OFNE: u1,
            ///  Output FIFO full
            OFFU: u1,
            ///  Busy bit
            BUSY: u1,
            padding: u27,
        }),
        ///  data input register
        DIN: mmio.Mmio(packed struct(u32) {
            ///  Data input
            DATAIN: u32,
        }),
        ///  data output register
        DOUT: mmio.Mmio(packed struct(u32) {
            ///  Data output
            DATAOUT: u32,
        }),
        ///  DMA control register
        DMACR: mmio.Mmio(packed struct(u32) {
            ///  DMA input enable
            DIEN: u1,
            ///  DMA output enable
            DOEN: u1,
            padding: u30,
        }),
        ///  interrupt mask set/clear register
        IMSCR: mmio.Mmio(packed struct(u32) {
            ///  Input FIFO service interrupt mask
            INIM: u1,
            ///  Output FIFO service interrupt mask
            OUTIM: u1,
            padding: u30,
        }),
        ///  raw interrupt status register
        RISR: mmio.Mmio(packed struct(u32) {
            ///  Input FIFO service raw interrupt status
            INRIS: u1,
            ///  Output FIFO service raw interrupt status
            OUTRIS: u1,
            padding: u30,
        }),
        ///  masked interrupt status register
        MISR: mmio.Mmio(packed struct(u32) {
            ///  Input FIFO service masked interrupt status
            INMIS: u1,
            ///  Output FIFO service masked interrupt status
            OUTMIS: u1,
            padding: u30,
        }),
        ///  key registers
        K0LR: mmio.Mmio(packed struct(u32) {
            ///  b224
            b224: u1,
            ///  b225
            b225: u1,
            ///  b226
            b226: u1,
            ///  b227
            b227: u1,
            ///  b228
            b228: u1,
            ///  b229
            b229: u1,
            ///  b230
            b230: u1,
            ///  b231
            b231: u1,
            ///  b232
            b232: u1,
            ///  b233
            b233: u1,
            ///  b234
            b234: u1,
            ///  b235
            b235: u1,
            ///  b236
            b236: u1,
            ///  b237
            b237: u1,
            ///  b238
            b238: u1,
            ///  b239
            b239: u1,
            ///  b240
            b240: u1,
            ///  b241
            b241: u1,
            ///  b242
            b242: u1,
            ///  b243
            b243: u1,
            ///  b244
            b244: u1,
            ///  b245
            b245: u1,
            ///  b246
            b246: u1,
            ///  b247
            b247: u1,
            ///  b248
            b248: u1,
            ///  b249
            b249: u1,
            ///  b250
            b250: u1,
            ///  b251
            b251: u1,
            ///  b252
            b252: u1,
            ///  b253
            b253: u1,
            ///  b254
            b254: u1,
            ///  b255
            b255: u1,
        }),
        ///  key registers
        K0RR: mmio.Mmio(packed struct(u32) {
            ///  b192
            b192: u1,
            ///  b193
            b193: u1,
            ///  b194
            b194: u1,
            ///  b195
            b195: u1,
            ///  b196
            b196: u1,
            ///  b197
            b197: u1,
            ///  b198
            b198: u1,
            ///  b199
            b199: u1,
            ///  b200
            b200: u1,
            ///  b201
            b201: u1,
            ///  b202
            b202: u1,
            ///  b203
            b203: u1,
            ///  b204
            b204: u1,
            ///  b205
            b205: u1,
            ///  b206
            b206: u1,
            ///  b207
            b207: u1,
            ///  b208
            b208: u1,
            ///  b209
            b209: u1,
            ///  b210
            b210: u1,
            ///  b211
            b211: u1,
            ///  b212
            b212: u1,
            ///  b213
            b213: u1,
            ///  b214
            b214: u1,
            ///  b215
            b215: u1,
            ///  b216
            b216: u1,
            ///  b217
            b217: u1,
            ///  b218
            b218: u1,
            ///  b219
            b219: u1,
            ///  b220
            b220: u1,
            ///  b221
            b221: u1,
            ///  b222
            b222: u1,
            ///  b223
            b223: u1,
        }),
        ///  key registers
        K1LR: mmio.Mmio(packed struct(u32) {
            ///  b160
            b160: u1,
            ///  b161
            b161: u1,
            ///  b162
            b162: u1,
            ///  b163
            b163: u1,
            ///  b164
            b164: u1,
            ///  b165
            b165: u1,
            ///  b166
            b166: u1,
            ///  b167
            b167: u1,
            ///  b168
            b168: u1,
            ///  b169
            b169: u1,
            ///  b170
            b170: u1,
            ///  b171
            b171: u1,
            ///  b172
            b172: u1,
            ///  b173
            b173: u1,
            ///  b174
            b174: u1,
            ///  b175
            b175: u1,
            ///  b176
            b176: u1,
            ///  b177
            b177: u1,
            ///  b178
            b178: u1,
            ///  b179
            b179: u1,
            ///  b180
            b180: u1,
            ///  b181
            b181: u1,
            ///  b182
            b182: u1,
            ///  b183
            b183: u1,
            ///  b184
            b184: u1,
            ///  b185
            b185: u1,
            ///  b186
            b186: u1,
            ///  b187
            b187: u1,
            ///  b188
            b188: u1,
            ///  b189
            b189: u1,
            ///  b190
            b190: u1,
            ///  b191
            b191: u1,
        }),
        ///  key registers
        K1RR: mmio.Mmio(packed struct(u32) {
            ///  b128
            b128: u1,
            ///  b129
            b129: u1,
            ///  b130
            b130: u1,
            ///  b131
            b131: u1,
            ///  b132
            b132: u1,
            ///  b133
            b133: u1,
            ///  b134
            b134: u1,
            ///  b135
            b135: u1,
            ///  b136
            b136: u1,
            ///  b137
            b137: u1,
            ///  b138
            b138: u1,
            ///  b139
            b139: u1,
            ///  b140
            b140: u1,
            ///  b141
            b141: u1,
            ///  b142
            b142: u1,
            ///  b143
            b143: u1,
            ///  b144
            b144: u1,
            ///  b145
            b145: u1,
            ///  b146
            b146: u1,
            ///  b147
            b147: u1,
            ///  b148
            b148: u1,
            ///  b149
            b149: u1,
            ///  b150
            b150: u1,
            ///  b151
            b151: u1,
            ///  b152
            b152: u1,
            ///  b153
            b153: u1,
            ///  b154
            b154: u1,
            ///  b155
            b155: u1,
            ///  b156
            b156: u1,
            ///  b157
            b157: u1,
            ///  b158
            b158: u1,
            ///  b159
            b159: u1,
        }),
        ///  key registers
        K2LR: mmio.Mmio(packed struct(u32) {
            ///  b96
            b96: u1,
            ///  b97
            b97: u1,
            ///  b98
            b98: u1,
            ///  b99
            b99: u1,
            ///  b100
            b100: u1,
            ///  b101
            b101: u1,
            ///  b102
            b102: u1,
            ///  b103
            b103: u1,
            ///  b104
            b104: u1,
            ///  b105
            b105: u1,
            ///  b106
            b106: u1,
            ///  b107
            b107: u1,
            ///  b108
            b108: u1,
            ///  b109
            b109: u1,
            ///  b110
            b110: u1,
            ///  b111
            b111: u1,
            ///  b112
            b112: u1,
            ///  b113
            b113: u1,
            ///  b114
            b114: u1,
            ///  b115
            b115: u1,
            ///  b116
            b116: u1,
            ///  b117
            b117: u1,
            ///  b118
            b118: u1,
            ///  b119
            b119: u1,
            ///  b120
            b120: u1,
            ///  b121
            b121: u1,
            ///  b122
            b122: u1,
            ///  b123
            b123: u1,
            ///  b124
            b124: u1,
            ///  b125
            b125: u1,
            ///  b126
            b126: u1,
            ///  b127
            b127: u1,
        }),
        ///  key registers
        K2RR: mmio.Mmio(packed struct(u32) {
            ///  b64
            b64: u1,
            ///  b65
            b65: u1,
            ///  b66
            b66: u1,
            ///  b67
            b67: u1,
            ///  b68
            b68: u1,
            ///  b69
            b69: u1,
            ///  b70
            b70: u1,
            ///  b71
            b71: u1,
            ///  b72
            b72: u1,
            ///  b73
            b73: u1,
            ///  b74
            b74: u1,
            ///  b75
            b75: u1,
            ///  b76
            b76: u1,
            ///  b77
            b77: u1,
            ///  b78
            b78: u1,
            ///  b79
            b79: u1,
            ///  b80
            b80: u1,
            ///  b81
            b81: u1,
            ///  b82
            b82: u1,
            ///  b83
            b83: u1,
            ///  b84
            b84: u1,
            ///  b85
            b85: u1,
            ///  b86
            b86: u1,
            ///  b87
            b87: u1,
            ///  b88
            b88: u1,
            ///  b89
            b89: u1,
            ///  b90
            b90: u1,
            ///  b91
            b91: u1,
            ///  b92
            b92: u1,
            ///  b93
            b93: u1,
            ///  b94
            b94: u1,
            ///  b95
            b95: u1,
        }),
        ///  key registers
        K3LR: mmio.Mmio(packed struct(u32) {
            ///  b32
            b32: u1,
            ///  b33
            b33: u1,
            ///  b34
            b34: u1,
            ///  b35
            b35: u1,
            ///  b36
            b36: u1,
            ///  b37
            b37: u1,
            ///  b38
            b38: u1,
            ///  b39
            b39: u1,
            ///  b40
            b40: u1,
            ///  b41
            b41: u1,
            ///  b42
            b42: u1,
            ///  b43
            b43: u1,
            ///  b44
            b44: u1,
            ///  b45
            b45: u1,
            ///  b46
            b46: u1,
            ///  b47
            b47: u1,
            ///  b48
            b48: u1,
            ///  b49
            b49: u1,
            ///  b50
            b50: u1,
            ///  b51
            b51: u1,
            ///  b52
            b52: u1,
            ///  b53
            b53: u1,
            ///  b54
            b54: u1,
            ///  b55
            b55: u1,
            ///  b56
            b56: u1,
            ///  b57
            b57: u1,
            ///  b58
            b58: u1,
            ///  b59
            b59: u1,
            ///  b60
            b60: u1,
            ///  b61
            b61: u1,
            ///  b62
            b62: u1,
            ///  b63
            b63: u1,
        }),
        ///  key registers
        K3RR: mmio.Mmio(packed struct(u32) {
            ///  b0
            b0: u1,
            ///  b1
            b1: u1,
            ///  b2
            b2: u1,
            ///  b3
            b3: u1,
            ///  b4
            b4: u1,
            ///  b5
            b5: u1,
            ///  b6
            b6: u1,
            ///  b7
            b7: u1,
            ///  b8
            b8: u1,
            ///  b9
            b9: u1,
            ///  b10
            b10: u1,
            ///  b11
            b11: u1,
            ///  b12
            b12: u1,
            ///  b13
            b13: u1,
            ///  b14
            b14: u1,
            ///  b15
            b15: u1,
            ///  b16
            b16: u1,
            ///  b17
            b17: u1,
            ///  b18
            b18: u1,
            ///  b19
            b19: u1,
            ///  b20
            b20: u1,
            ///  b21
            b21: u1,
            ///  b22
            b22: u1,
            ///  b23
            b23: u1,
            ///  b24
            b24: u1,
            ///  b25
            b25: u1,
            ///  b26
            b26: u1,
            ///  b27
            b27: u1,
            ///  b28
            b28: u1,
            ///  b29
            b29: u1,
            ///  b30
            b30: u1,
            ///  b31
            b31: u1,
        }),
        ///  initialization vector registers
        IV0LR: mmio.Mmio(packed struct(u32) {
            ///  IV31
            IV31: u1,
            ///  IV30
            IV30: u1,
            ///  IV29
            IV29: u1,
            ///  IV28
            IV28: u1,
            ///  IV27
            IV27: u1,
            ///  IV26
            IV26: u1,
            ///  IV25
            IV25: u1,
            ///  IV24
            IV24: u1,
            ///  IV23
            IV23: u1,
            ///  IV22
            IV22: u1,
            ///  IV21
            IV21: u1,
            ///  IV20
            IV20: u1,
            ///  IV19
            IV19: u1,
            ///  IV18
            IV18: u1,
            ///  IV17
            IV17: u1,
            ///  IV16
            IV16: u1,
            ///  IV15
            IV15: u1,
            ///  IV14
            IV14: u1,
            ///  IV13
            IV13: u1,
            ///  IV12
            IV12: u1,
            ///  IV11
            IV11: u1,
            ///  IV10
            IV10: u1,
            ///  IV9
            IV9: u1,
            ///  IV8
            IV8: u1,
            ///  IV7
            IV7: u1,
            ///  IV6
            IV6: u1,
            ///  IV5
            IV5: u1,
            ///  IV4
            IV4: u1,
            ///  IV3
            IV3: u1,
            ///  IV2
            IV2: u1,
            ///  IV1
            IV1: u1,
            ///  IV0
            IV0: u1,
        }),
        ///  initialization vector registers
        IV0RR: mmio.Mmio(packed struct(u32) {
            ///  IV63
            IV63: u1,
            ///  IV62
            IV62: u1,
            ///  IV61
            IV61: u1,
            ///  IV60
            IV60: u1,
            ///  IV59
            IV59: u1,
            ///  IV58
            IV58: u1,
            ///  IV57
            IV57: u1,
            ///  IV56
            IV56: u1,
            ///  IV55
            IV55: u1,
            ///  IV54
            IV54: u1,
            ///  IV53
            IV53: u1,
            ///  IV52
            IV52: u1,
            ///  IV51
            IV51: u1,
            ///  IV50
            IV50: u1,
            ///  IV49
            IV49: u1,
            ///  IV48
            IV48: u1,
            ///  IV47
            IV47: u1,
            ///  IV46
            IV46: u1,
            ///  IV45
            IV45: u1,
            ///  IV44
            IV44: u1,
            ///  IV43
            IV43: u1,
            ///  IV42
            IV42: u1,
            ///  IV41
            IV41: u1,
            ///  IV40
            IV40: u1,
            ///  IV39
            IV39: u1,
            ///  IV38
            IV38: u1,
            ///  IV37
            IV37: u1,
            ///  IV36
            IV36: u1,
            ///  IV35
            IV35: u1,
            ///  IV34
            IV34: u1,
            ///  IV33
            IV33: u1,
            ///  IV32
            IV32: u1,
        }),
        ///  initialization vector registers
        IV1LR: mmio.Mmio(packed struct(u32) {
            ///  IV95
            IV95: u1,
            ///  IV94
            IV94: u1,
            ///  IV93
            IV93: u1,
            ///  IV92
            IV92: u1,
            ///  IV91
            IV91: u1,
            ///  IV90
            IV90: u1,
            ///  IV89
            IV89: u1,
            ///  IV88
            IV88: u1,
            ///  IV87
            IV87: u1,
            ///  IV86
            IV86: u1,
            ///  IV85
            IV85: u1,
            ///  IV84
            IV84: u1,
            ///  IV83
            IV83: u1,
            ///  IV82
            IV82: u1,
            ///  IV81
            IV81: u1,
            ///  IV80
            IV80: u1,
            ///  IV79
            IV79: u1,
            ///  IV78
            IV78: u1,
            ///  IV77
            IV77: u1,
            ///  IV76
            IV76: u1,
            ///  IV75
            IV75: u1,
            ///  IV74
            IV74: u1,
            ///  IV73
            IV73: u1,
            ///  IV72
            IV72: u1,
            ///  IV71
            IV71: u1,
            ///  IV70
            IV70: u1,
            ///  IV69
            IV69: u1,
            ///  IV68
            IV68: u1,
            ///  IV67
            IV67: u1,
            ///  IV66
            IV66: u1,
            ///  IV65
            IV65: u1,
            ///  IV64
            IV64: u1,
        }),
        ///  initialization vector registers
        IV1RR: mmio.Mmio(packed struct(u32) {
            ///  IV127
            IV127: u1,
            ///  IV126
            IV126: u1,
            ///  IV125
            IV125: u1,
            ///  IV124
            IV124: u1,
            ///  IV123
            IV123: u1,
            ///  IV122
            IV122: u1,
            ///  IV121
            IV121: u1,
            ///  IV120
            IV120: u1,
            ///  IV119
            IV119: u1,
            ///  IV118
            IV118: u1,
            ///  IV117
            IV117: u1,
            ///  IV116
            IV116: u1,
            ///  IV115
            IV115: u1,
            ///  IV114
            IV114: u1,
            ///  IV113
            IV113: u1,
            ///  IV112
            IV112: u1,
            ///  IV111
            IV111: u1,
            ///  IV110
            IV110: u1,
            ///  IV109
            IV109: u1,
            ///  IV108
            IV108: u1,
            ///  IV107
            IV107: u1,
            ///  IV106
            IV106: u1,
            ///  IV105
            IV105: u1,
            ///  IV104
            IV104: u1,
            ///  IV103
            IV103: u1,
            ///  IV102
            IV102: u1,
            ///  IV101
            IV101: u1,
            ///  IV100
            IV100: u1,
            ///  IV99
            IV99: u1,
            ///  IV98
            IV98: u1,
            ///  IV97
            IV97: u1,
            ///  IV96
            IV96: u1,
        }),
        ///  context swap register
        CSGCMCCM0R: mmio.Mmio(packed struct(u32) {
            ///  CSGCMCCM0R
            CSGCMCCM0R: u32,
        }),
        ///  context swap register
        CSGCMCCM1R: mmio.Mmio(packed struct(u32) {
            ///  CSGCMCCM1R
            CSGCMCCM1R: u32,
        }),
        ///  context swap register
        CSGCMCCM2R: mmio.Mmio(packed struct(u32) {
            ///  CSGCMCCM2R
            CSGCMCCM2R: u32,
        }),
        ///  context swap register
        CSGCMCCM3R: mmio.Mmio(packed struct(u32) {
            ///  CSGCMCCM3R
            CSGCMCCM3R: u32,
        }),
        ///  context swap register
        CSGCMCCM4R: mmio.Mmio(packed struct(u32) {
            ///  CSGCMCCM4R
            CSGCMCCM4R: u32,
        }),
        ///  context swap register
        CSGCMCCM5R: mmio.Mmio(packed struct(u32) {
            ///  CSGCMCCM5R
            CSGCMCCM5R: u32,
        }),
        ///  context swap register
        CSGCMCCM6R: mmio.Mmio(packed struct(u32) {
            ///  CSGCMCCM6R
            CSGCMCCM6R: u32,
        }),
        ///  context swap register
        CSGCMCCM7R: mmio.Mmio(packed struct(u32) {
            ///  CSGCMCCM7R
            CSGCMCCM7R: u32,
        }),
        ///  context swap register
        CSGCM0R: mmio.Mmio(packed struct(u32) {
            ///  CSGCM0R
            CSGCM0R: u32,
        }),
        ///  context swap register
        CSGCM1R: mmio.Mmio(packed struct(u32) {
            ///  CSGCM1R
            CSGCM1R: u32,
        }),
        ///  context swap register
        CSGCM2R: mmio.Mmio(packed struct(u32) {
            ///  CSGCM2R
            CSGCM2R: u32,
        }),
        ///  context swap register
        CSGCM3R: mmio.Mmio(packed struct(u32) {
            ///  CSGCM3R
            CSGCM3R: u32,
        }),
        ///  context swap register
        CSGCM4R: mmio.Mmio(packed struct(u32) {
            ///  CSGCM4R
            CSGCM4R: u32,
        }),
        ///  context swap register
        CSGCM5R: mmio.Mmio(packed struct(u32) {
            ///  CSGCM5R
            CSGCM5R: u32,
        }),
        ///  context swap register
        CSGCM6R: mmio.Mmio(packed struct(u32) {
            ///  CSGCM6R
            CSGCM6R: u32,
        }),
        ///  context swap register
        CSGCM7R: mmio.Mmio(packed struct(u32) {
            ///  CSGCM7R
            CSGCM7R: u32,
        }),
    };

    ///  Digital camera interface
    pub const DCMI = extern struct {
        ///  control register 1
        CR: mmio.Mmio(packed struct(u32) {
            ///  Capture enable
            CAPTURE: u1,
            ///  Capture mode
            CM: u1,
            ///  Crop feature
            CROP: u1,
            ///  JPEG format
            JPEG: u1,
            ///  Embedded synchronization select
            ESS: u1,
            ///  Pixel clock polarity
            PCKPOL: u1,
            ///  Horizontal synchronization polarity
            HSPOL: u1,
            ///  Vertical synchronization polarity
            VSPOL: u1,
            ///  Frame capture rate control
            FCRC: u2,
            ///  Extended data mode
            EDM: u2,
            reserved14: u2,
            ///  DCMI enable
            ENABLE: u1,
            padding: u17,
        }),
        ///  status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  HSYNC
            HSYNC: u1,
            ///  VSYNC
            VSYNC: u1,
            ///  FIFO not empty
            FNE: u1,
            padding: u29,
        }),
        ///  raw interrupt status register
        RIS: mmio.Mmio(packed struct(u32) {
            ///  Capture complete raw interrupt status
            FRAME_RIS: u1,
            ///  Overrun raw interrupt status
            OVR_RIS: u1,
            ///  Synchronization error raw interrupt status
            ERR_RIS: u1,
            ///  VSYNC raw interrupt status
            VSYNC_RIS: u1,
            ///  Line raw interrupt status
            LINE_RIS: u1,
            padding: u27,
        }),
        ///  interrupt enable register
        IER: mmio.Mmio(packed struct(u32) {
            ///  Capture complete interrupt enable
            FRAME_IE: u1,
            ///  Overrun interrupt enable
            OVR_IE: u1,
            ///  Synchronization error interrupt enable
            ERR_IE: u1,
            ///  VSYNC interrupt enable
            VSYNC_IE: u1,
            ///  Line interrupt enable
            LINE_IE: u1,
            padding: u27,
        }),
        ///  masked interrupt status register
        MIS: mmio.Mmio(packed struct(u32) {
            ///  Capture complete masked interrupt status
            FRAME_MIS: u1,
            ///  Overrun masked interrupt status
            OVR_MIS: u1,
            ///  Synchronization error masked interrupt status
            ERR_MIS: u1,
            ///  VSYNC masked interrupt status
            VSYNC_MIS: u1,
            ///  Line masked interrupt status
            LINE_MIS: u1,
            padding: u27,
        }),
        ///  interrupt clear register
        ICR: mmio.Mmio(packed struct(u32) {
            ///  Capture complete interrupt status clear
            FRAME_ISC: u1,
            ///  Overrun interrupt status clear
            OVR_ISC: u1,
            ///  Synchronization error interrupt status clear
            ERR_ISC: u1,
            ///  Vertical synch interrupt status clear
            VSYNC_ISC: u1,
            ///  line interrupt status clear
            LINE_ISC: u1,
            padding: u27,
        }),
        ///  embedded synchronization code register
        ESCR: mmio.Mmio(packed struct(u32) {
            ///  Frame start delimiter code
            FSC: u8,
            ///  Line start delimiter code
            LSC: u8,
            ///  Line end delimiter code
            LEC: u8,
            ///  Frame end delimiter code
            FEC: u8,
        }),
        ///  embedded synchronization unmask register
        ESUR: mmio.Mmio(packed struct(u32) {
            ///  Frame start delimiter unmask
            FSU: u8,
            ///  Line start delimiter unmask
            LSU: u8,
            ///  Line end delimiter unmask
            LEU: u8,
            ///  Frame end delimiter unmask
            FEU: u8,
        }),
        ///  crop window start
        CWSTRT: mmio.Mmio(packed struct(u32) {
            ///  Horizontal offset count
            HOFFCNT: u14,
            reserved16: u2,
            ///  Vertical start line count
            VST: u13,
            padding: u3,
        }),
        ///  crop window size
        CWSIZE: mmio.Mmio(packed struct(u32) {
            ///  Capture count
            CAPCNT: u14,
            reserved16: u2,
            ///  Vertical line count
            VLINE: u14,
            padding: u2,
        }),
        ///  data register
        DR: mmio.Mmio(packed struct(u32) {
            ///  Data byte 0
            Byte0: u8,
            ///  Data byte 1
            Byte1: u8,
            ///  Data byte 2
            Byte2: u8,
            ///  Data byte 3
            Byte3: u8,
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
            reserved20: u4,
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
            reserved20: u4,
            ///  CLKDIV
            CLKDIV: u4,
            ///  DATLAT
            DATLAT: u4,
            ///  ACCMOD
            ACCMOD: u2,
            padding: u2,
        }),
        reserved320: [48]u8,
        ///  SDRAM Control Register 1
        SDCR1: mmio.Mmio(packed struct(u32) {
            ///  Number of column address bits
            NC: u2,
            ///  Number of row address bits
            NR: u2,
            ///  Memory data bus width
            MWID: u2,
            ///  Number of internal banks
            NB: u1,
            ///  CAS latency
            CAS: u2,
            ///  Write protection
            WP: u1,
            ///  SDRAM clock configuration
            SDCLK: u2,
            ///  Burst read
            RBURST: u1,
            ///  Read pipe
            RPIPE: u2,
            padding: u17,
        }),
        ///  SDRAM Control Register 2
        SDCR2: mmio.Mmio(packed struct(u32) {
            ///  Number of column address bits
            NC: u2,
            ///  Number of row address bits
            NR: u2,
            ///  Memory data bus width
            MWID: u2,
            ///  Number of internal banks
            NB: u1,
            ///  CAS latency
            CAS: u2,
            ///  Write protection
            WP: u1,
            ///  SDRAM clock configuration
            SDCLK: u2,
            ///  Burst read
            RBURST: u1,
            ///  Read pipe
            RPIPE: u2,
            padding: u17,
        }),
        ///  SDRAM Timing register 1
        SDTR1: mmio.Mmio(packed struct(u32) {
            ///  Load Mode Register to Active
            TMRD: u4,
            ///  Exit self-refresh delay
            TXSR: u4,
            ///  Self refresh time
            TRAS: u4,
            ///  Row cycle delay
            TRC: u4,
            ///  Recovery delay
            TWR: u4,
            ///  Row precharge delay
            TRP: u4,
            ///  Row to column delay
            TRCD: u4,
            padding: u4,
        }),
        ///  SDRAM Timing register 2
        SDTR2: mmio.Mmio(packed struct(u32) {
            ///  Load Mode Register to Active
            TMRD: u4,
            ///  Exit self-refresh delay
            TXSR: u4,
            ///  Self refresh time
            TRAS: u4,
            ///  Row cycle delay
            TRC: u4,
            ///  Recovery delay
            TWR: u4,
            ///  Row precharge delay
            TRP: u4,
            ///  Row to column delay
            TRCD: u4,
            padding: u4,
        }),
        ///  SDRAM Command Mode register
        SDCMR: mmio.Mmio(packed struct(u32) {
            ///  Command mode
            MODE: u3,
            ///  Command target bank 2
            CTB2: u1,
            ///  Command target bank 1
            CTB1: u1,
            ///  Number of Auto-refresh
            NRFS: u4,
            ///  Mode Register definition
            MRD: u13,
            padding: u10,
        }),
        ///  SDRAM Refresh Timer register
        SDRTR: mmio.Mmio(packed struct(u32) {
            ///  Clear Refresh error flag
            CRE: u1,
            ///  Refresh Timer Count
            COUNT: u13,
            ///  RES Interrupt Enable
            REIE: u1,
            padding: u17,
        }),
        ///  SDRAM Status register
        SDSR: mmio.Mmio(packed struct(u32) {
            ///  Refresh error flag
            RE: u1,
            ///  Status Mode for Bank 1
            MODES1: u2,
            ///  Status Mode for Bank 2
            MODES2: u2,
            ///  Busy status
            BUSY: u1,
            padding: u26,
        }),
    };

    ///  Debug support
    pub const DBG = extern struct {
        ///  IDCODE
        DBGMCU_IDCODE: mmio.Mmio(packed struct(u32) {
            ///  DEV_ID
            DEV_ID: u12,
            reserved16: u4,
            ///  REV_ID
            REV_ID: u16,
        }),
        ///  Control Register
        DBGMCU_CR: mmio.Mmio(packed struct(u32) {
            ///  DBG_SLEEP
            DBG_SLEEP: u1,
            ///  DBG_STOP
            DBG_STOP: u1,
            ///  DBG_STANDBY
            DBG_STANDBY: u1,
            reserved5: u2,
            ///  TRACE_IOEN
            TRACE_IOEN: u1,
            ///  TRACE_MODE
            TRACE_MODE: u2,
            padding: u24,
        }),
        ///  Debug MCU APB1 Freeze registe
        DBGMCU_APB1_FZ: mmio.Mmio(packed struct(u32) {
            ///  DBG_TIM2_STOP
            DBG_TIM2_STOP: u1,
            ///  DBG_TIM3 _STOP
            DBG_TIM3_STOP: u1,
            ///  DBG_TIM4_STOP
            DBG_TIM4_STOP: u1,
            ///  DBG_TIM5_STOP
            DBG_TIM5_STOP: u1,
            ///  DBG_TIM6_STOP
            DBG_TIM6_STOP: u1,
            ///  DBG_TIM7_STOP
            DBG_TIM7_STOP: u1,
            ///  DBG_TIM12_STOP
            DBG_TIM12_STOP: u1,
            ///  DBG_TIM13_STOP
            DBG_TIM13_STOP: u1,
            ///  DBG_TIM14_STOP
            DBG_TIM14_STOP: u1,
            reserved11: u2,
            ///  DBG_WWDG_STOP
            DBG_WWDG_STOP: u1,
            ///  DBG_IWDEG_STOP
            DBG_IWDEG_STOP: u1,
            reserved21: u8,
            ///  DBG_J2C1_SMBUS_TIMEOUT
            DBG_J2C1_SMBUS_TIMEOUT: u1,
            ///  DBG_J2C2_SMBUS_TIMEOUT
            DBG_J2C2_SMBUS_TIMEOUT: u1,
            ///  DBG_J2C3SMBUS_TIMEOUT
            DBG_J2C3SMBUS_TIMEOUT: u1,
            reserved25: u1,
            ///  DBG_CAN1_STOP
            DBG_CAN1_STOP: u1,
            ///  DBG_CAN2_STOP
            DBG_CAN2_STOP: u1,
            padding: u5,
        }),
        ///  Debug MCU APB2 Freeze registe
        DBGMCU_APB2_FZ: mmio.Mmio(packed struct(u32) {
            ///  TIM1 counter stopped when core is halted
            DBG_TIM1_STOP: u1,
            ///  TIM8 counter stopped when core is halted
            DBG_TIM8_STOP: u1,
            reserved16: u14,
            ///  TIM9 counter stopped when core is halted
            DBG_TIM9_STOP: u1,
            ///  TIM10 counter stopped when core is halted
            DBG_TIM10_STOP: u1,
            ///  TIM11 counter stopped when core is halted
            DBG_TIM11_STOP: u1,
            padding: u13,
        }),
    };

    ///  DMA controller
    pub const DMA2 = extern struct {
        ///  low interrupt status register
        LISR: mmio.Mmio(packed struct(u32) {
            ///  Stream x FIFO error interrupt flag (x=3..0)
            FEIF0: u1,
            reserved2: u1,
            ///  Stream x direct mode error interrupt flag (x=3..0)
            DMEIF0: u1,
            ///  Stream x transfer error interrupt flag (x=3..0)
            TEIF0: u1,
            ///  Stream x half transfer interrupt flag (x=3..0)
            HTIF0: u1,
            ///  Stream x transfer complete interrupt flag (x = 3..0)
            TCIF0: u1,
            ///  Stream x FIFO error interrupt flag (x=3..0)
            FEIF1: u1,
            reserved8: u1,
            ///  Stream x direct mode error interrupt flag (x=3..0)
            DMEIF1: u1,
            ///  Stream x transfer error interrupt flag (x=3..0)
            TEIF1: u1,
            ///  Stream x half transfer interrupt flag (x=3..0)
            HTIF1: u1,
            ///  Stream x transfer complete interrupt flag (x = 3..0)
            TCIF1: u1,
            reserved16: u4,
            ///  Stream x FIFO error interrupt flag (x=3..0)
            FEIF2: u1,
            reserved18: u1,
            ///  Stream x direct mode error interrupt flag (x=3..0)
            DMEIF2: u1,
            ///  Stream x transfer error interrupt flag (x=3..0)
            TEIF2: u1,
            ///  Stream x half transfer interrupt flag (x=3..0)
            HTIF2: u1,
            ///  Stream x transfer complete interrupt flag (x = 3..0)
            TCIF2: u1,
            ///  Stream x FIFO error interrupt flag (x=3..0)
            FEIF3: u1,
            reserved24: u1,
            ///  Stream x direct mode error interrupt flag (x=3..0)
            DMEIF3: u1,
            ///  Stream x transfer error interrupt flag (x=3..0)
            TEIF3: u1,
            ///  Stream x half transfer interrupt flag (x=3..0)
            HTIF3: u1,
            ///  Stream x transfer complete interrupt flag (x = 3..0)
            TCIF3: u1,
            padding: u4,
        }),
        ///  high interrupt status register
        HISR: mmio.Mmio(packed struct(u32) {
            ///  Stream x FIFO error interrupt flag (x=7..4)
            FEIF4: u1,
            reserved2: u1,
            ///  Stream x direct mode error interrupt flag (x=7..4)
            DMEIF4: u1,
            ///  Stream x transfer error interrupt flag (x=7..4)
            TEIF4: u1,
            ///  Stream x half transfer interrupt flag (x=7..4)
            HTIF4: u1,
            ///  Stream x transfer complete interrupt flag (x=7..4)
            TCIF4: u1,
            ///  Stream x FIFO error interrupt flag (x=7..4)
            FEIF5: u1,
            reserved8: u1,
            ///  Stream x direct mode error interrupt flag (x=7..4)
            DMEIF5: u1,
            ///  Stream x transfer error interrupt flag (x=7..4)
            TEIF5: u1,
            ///  Stream x half transfer interrupt flag (x=7..4)
            HTIF5: u1,
            ///  Stream x transfer complete interrupt flag (x=7..4)
            TCIF5: u1,
            reserved16: u4,
            ///  Stream x FIFO error interrupt flag (x=7..4)
            FEIF6: u1,
            reserved18: u1,
            ///  Stream x direct mode error interrupt flag (x=7..4)
            DMEIF6: u1,
            ///  Stream x transfer error interrupt flag (x=7..4)
            TEIF6: u1,
            ///  Stream x half transfer interrupt flag (x=7..4)
            HTIF6: u1,
            ///  Stream x transfer complete interrupt flag (x=7..4)
            TCIF6: u1,
            ///  Stream x FIFO error interrupt flag (x=7..4)
            FEIF7: u1,
            reserved24: u1,
            ///  Stream x direct mode error interrupt flag (x=7..4)
            DMEIF7: u1,
            ///  Stream x transfer error interrupt flag (x=7..4)
            TEIF7: u1,
            ///  Stream x half transfer interrupt flag (x=7..4)
            HTIF7: u1,
            ///  Stream x transfer complete interrupt flag (x=7..4)
            TCIF7: u1,
            padding: u4,
        }),
        ///  low interrupt flag clear register
        LIFCR: mmio.Mmio(packed struct(u32) {
            ///  Stream x clear FIFO error interrupt flag (x = 3..0)
            CFEIF0: u1,
            reserved2: u1,
            ///  Stream x clear direct mode error interrupt flag (x = 3..0)
            CDMEIF0: u1,
            ///  Stream x clear transfer error interrupt flag (x = 3..0)
            CTEIF0: u1,
            ///  Stream x clear half transfer interrupt flag (x = 3..0)
            CHTIF0: u1,
            ///  Stream x clear transfer complete interrupt flag (x = 3..0)
            CTCIF0: u1,
            ///  Stream x clear FIFO error interrupt flag (x = 3..0)
            CFEIF1: u1,
            reserved8: u1,
            ///  Stream x clear direct mode error interrupt flag (x = 3..0)
            CDMEIF1: u1,
            ///  Stream x clear transfer error interrupt flag (x = 3..0)
            CTEIF1: u1,
            ///  Stream x clear half transfer interrupt flag (x = 3..0)
            CHTIF1: u1,
            ///  Stream x clear transfer complete interrupt flag (x = 3..0)
            CTCIF1: u1,
            reserved16: u4,
            ///  Stream x clear FIFO error interrupt flag (x = 3..0)
            CFEIF2: u1,
            reserved18: u1,
            ///  Stream x clear direct mode error interrupt flag (x = 3..0)
            CDMEIF2: u1,
            ///  Stream x clear transfer error interrupt flag (x = 3..0)
            CTEIF2: u1,
            ///  Stream x clear half transfer interrupt flag (x = 3..0)
            CHTIF2: u1,
            ///  Stream x clear transfer complete interrupt flag (x = 3..0)
            CTCIF2: u1,
            ///  Stream x clear FIFO error interrupt flag (x = 3..0)
            CFEIF3: u1,
            reserved24: u1,
            ///  Stream x clear direct mode error interrupt flag (x = 3..0)
            CDMEIF3: u1,
            ///  Stream x clear transfer error interrupt flag (x = 3..0)
            CTEIF3: u1,
            ///  Stream x clear half transfer interrupt flag (x = 3..0)
            CHTIF3: u1,
            ///  Stream x clear transfer complete interrupt flag (x = 3..0)
            CTCIF3: u1,
            padding: u4,
        }),
        ///  high interrupt flag clear register
        HIFCR: mmio.Mmio(packed struct(u32) {
            ///  Stream x clear FIFO error interrupt flag (x = 7..4)
            CFEIF4: u1,
            reserved2: u1,
            ///  Stream x clear direct mode error interrupt flag (x = 7..4)
            CDMEIF4: u1,
            ///  Stream x clear transfer error interrupt flag (x = 7..4)
            CTEIF4: u1,
            ///  Stream x clear half transfer interrupt flag (x = 7..4)
            CHTIF4: u1,
            ///  Stream x clear transfer complete interrupt flag (x = 7..4)
            CTCIF4: u1,
            ///  Stream x clear FIFO error interrupt flag (x = 7..4)
            CFEIF5: u1,
            reserved8: u1,
            ///  Stream x clear direct mode error interrupt flag (x = 7..4)
            CDMEIF5: u1,
            ///  Stream x clear transfer error interrupt flag (x = 7..4)
            CTEIF5: u1,
            ///  Stream x clear half transfer interrupt flag (x = 7..4)
            CHTIF5: u1,
            ///  Stream x clear transfer complete interrupt flag (x = 7..4)
            CTCIF5: u1,
            reserved16: u4,
            ///  Stream x clear FIFO error interrupt flag (x = 7..4)
            CFEIF6: u1,
            reserved18: u1,
            ///  Stream x clear direct mode error interrupt flag (x = 7..4)
            CDMEIF6: u1,
            ///  Stream x clear transfer error interrupt flag (x = 7..4)
            CTEIF6: u1,
            ///  Stream x clear half transfer interrupt flag (x = 7..4)
            CHTIF6: u1,
            ///  Stream x clear transfer complete interrupt flag (x = 7..4)
            CTCIF6: u1,
            ///  Stream x clear FIFO error interrupt flag (x = 7..4)
            CFEIF7: u1,
            reserved24: u1,
            ///  Stream x clear direct mode error interrupt flag (x = 7..4)
            CDMEIF7: u1,
            ///  Stream x clear transfer error interrupt flag (x = 7..4)
            CTEIF7: u1,
            ///  Stream x clear half transfer interrupt flag (x = 7..4)
            CHTIF7: u1,
            ///  Stream x clear transfer complete interrupt flag (x = 7..4)
            CTCIF7: u1,
            padding: u4,
        }),
        ///  stream x configuration register
        S0CR: mmio.Mmio(packed struct(u32) {
            ///  Stream enable / flag stream ready when read low
            EN: u1,
            ///  Direct mode error interrupt enable
            DMEIE: u1,
            ///  Transfer error interrupt enable
            TEIE: u1,
            ///  Half transfer interrupt enable
            HTIE: u1,
            ///  Transfer complete interrupt enable
            TCIE: u1,
            ///  Peripheral flow controller
            PFCTRL: u1,
            ///  Data transfer direction
            DIR: u2,
            ///  Circular mode
            CIRC: u1,
            ///  Peripheral increment mode
            PINC: u1,
            ///  Memory increment mode
            MINC: u1,
            ///  Peripheral data size
            PSIZE: u2,
            ///  Memory data size
            MSIZE: u2,
            ///  Peripheral increment offset size
            PINCOS: u1,
            ///  Priority level
            PL: u2,
            ///  Double buffer mode
            DBM: u1,
            ///  Current target (only in double buffer mode)
            CT: u1,
            reserved21: u1,
            ///  Peripheral burst transfer configuration
            PBURST: u2,
            ///  Memory burst transfer configuration
            MBURST: u2,
            ///  Channel selection
            CHSEL: u3,
            padding: u4,
        }),
        ///  stream x number of data register
        S0NDTR: mmio.Mmio(packed struct(u32) {
            ///  Number of data items to transfer
            NDT: u16,
            padding: u16,
        }),
        ///  stream x peripheral address register
        S0PAR: mmio.Mmio(packed struct(u32) {
            ///  Peripheral address
            PA: u32,
        }),
        ///  stream x memory 0 address register
        S0M0AR: mmio.Mmio(packed struct(u32) {
            ///  Memory 0 address
            M0A: u32,
        }),
        ///  stream x memory 1 address register
        S0M1AR: mmio.Mmio(packed struct(u32) {
            ///  Memory 1 address (used in case of Double buffer mode)
            M1A: u32,
        }),
        ///  stream x FIFO control register
        S0FCR: mmio.Mmio(packed struct(u32) {
            ///  FIFO threshold selection
            FTH: u2,
            ///  Direct mode disable
            DMDIS: u1,
            ///  FIFO status
            FS: u3,
            reserved7: u1,
            ///  FIFO error interrupt enable
            FEIE: u1,
            padding: u24,
        }),
        ///  stream x configuration register
        S1CR: mmio.Mmio(packed struct(u32) {
            ///  Stream enable / flag stream ready when read low
            EN: u1,
            ///  Direct mode error interrupt enable
            DMEIE: u1,
            ///  Transfer error interrupt enable
            TEIE: u1,
            ///  Half transfer interrupt enable
            HTIE: u1,
            ///  Transfer complete interrupt enable
            TCIE: u1,
            ///  Peripheral flow controller
            PFCTRL: u1,
            ///  Data transfer direction
            DIR: u2,
            ///  Circular mode
            CIRC: u1,
            ///  Peripheral increment mode
            PINC: u1,
            ///  Memory increment mode
            MINC: u1,
            ///  Peripheral data size
            PSIZE: u2,
            ///  Memory data size
            MSIZE: u2,
            ///  Peripheral increment offset size
            PINCOS: u1,
            ///  Priority level
            PL: u2,
            ///  Double buffer mode
            DBM: u1,
            ///  Current target (only in double buffer mode)
            CT: u1,
            ///  ACK
            ACK: u1,
            ///  Peripheral burst transfer configuration
            PBURST: u2,
            ///  Memory burst transfer configuration
            MBURST: u2,
            ///  Channel selection
            CHSEL: u3,
            padding: u4,
        }),
        ///  stream x number of data register
        S1NDTR: mmio.Mmio(packed struct(u32) {
            ///  Number of data items to transfer
            NDT: u16,
            padding: u16,
        }),
        ///  stream x peripheral address register
        S1PAR: mmio.Mmio(packed struct(u32) {
            ///  Peripheral address
            PA: u32,
        }),
        ///  stream x memory 0 address register
        S1M0AR: mmio.Mmio(packed struct(u32) {
            ///  Memory 0 address
            M0A: u32,
        }),
        ///  stream x memory 1 address register
        S1M1AR: mmio.Mmio(packed struct(u32) {
            ///  Memory 1 address (used in case of Double buffer mode)
            M1A: u32,
        }),
        ///  stream x FIFO control register
        S1FCR: mmio.Mmio(packed struct(u32) {
            ///  FIFO threshold selection
            FTH: u2,
            ///  Direct mode disable
            DMDIS: u1,
            ///  FIFO status
            FS: u3,
            reserved7: u1,
            ///  FIFO error interrupt enable
            FEIE: u1,
            padding: u24,
        }),
        ///  stream x configuration register
        S2CR: mmio.Mmio(packed struct(u32) {
            ///  Stream enable / flag stream ready when read low
            EN: u1,
            ///  Direct mode error interrupt enable
            DMEIE: u1,
            ///  Transfer error interrupt enable
            TEIE: u1,
            ///  Half transfer interrupt enable
            HTIE: u1,
            ///  Transfer complete interrupt enable
            TCIE: u1,
            ///  Peripheral flow controller
            PFCTRL: u1,
            ///  Data transfer direction
            DIR: u2,
            ///  Circular mode
            CIRC: u1,
            ///  Peripheral increment mode
            PINC: u1,
            ///  Memory increment mode
            MINC: u1,
            ///  Peripheral data size
            PSIZE: u2,
            ///  Memory data size
            MSIZE: u2,
            ///  Peripheral increment offset size
            PINCOS: u1,
            ///  Priority level
            PL: u2,
            ///  Double buffer mode
            DBM: u1,
            ///  Current target (only in double buffer mode)
            CT: u1,
            ///  ACK
            ACK: u1,
            ///  Peripheral burst transfer configuration
            PBURST: u2,
            ///  Memory burst transfer configuration
            MBURST: u2,
            ///  Channel selection
            CHSEL: u3,
            padding: u4,
        }),
        ///  stream x number of data register
        S2NDTR: mmio.Mmio(packed struct(u32) {
            ///  Number of data items to transfer
            NDT: u16,
            padding: u16,
        }),
        ///  stream x peripheral address register
        S2PAR: mmio.Mmio(packed struct(u32) {
            ///  Peripheral address
            PA: u32,
        }),
        ///  stream x memory 0 address register
        S2M0AR: mmio.Mmio(packed struct(u32) {
            ///  Memory 0 address
            M0A: u32,
        }),
        ///  stream x memory 1 address register
        S2M1AR: mmio.Mmio(packed struct(u32) {
            ///  Memory 1 address (used in case of Double buffer mode)
            M1A: u32,
        }),
        ///  stream x FIFO control register
        S2FCR: mmio.Mmio(packed struct(u32) {
            ///  FIFO threshold selection
            FTH: u2,
            ///  Direct mode disable
            DMDIS: u1,
            ///  FIFO status
            FS: u3,
            reserved7: u1,
            ///  FIFO error interrupt enable
            FEIE: u1,
            padding: u24,
        }),
        ///  stream x configuration register
        S3CR: mmio.Mmio(packed struct(u32) {
            ///  Stream enable / flag stream ready when read low
            EN: u1,
            ///  Direct mode error interrupt enable
            DMEIE: u1,
            ///  Transfer error interrupt enable
            TEIE: u1,
            ///  Half transfer interrupt enable
            HTIE: u1,
            ///  Transfer complete interrupt enable
            TCIE: u1,
            ///  Peripheral flow controller
            PFCTRL: u1,
            ///  Data transfer direction
            DIR: u2,
            ///  Circular mode
            CIRC: u1,
            ///  Peripheral increment mode
            PINC: u1,
            ///  Memory increment mode
            MINC: u1,
            ///  Peripheral data size
            PSIZE: u2,
            ///  Memory data size
            MSIZE: u2,
            ///  Peripheral increment offset size
            PINCOS: u1,
            ///  Priority level
            PL: u2,
            ///  Double buffer mode
            DBM: u1,
            ///  Current target (only in double buffer mode)
            CT: u1,
            ///  ACK
            ACK: u1,
            ///  Peripheral burst transfer configuration
            PBURST: u2,
            ///  Memory burst transfer configuration
            MBURST: u2,
            ///  Channel selection
            CHSEL: u3,
            padding: u4,
        }),
        ///  stream x number of data register
        S3NDTR: mmio.Mmio(packed struct(u32) {
            ///  Number of data items to transfer
            NDT: u16,
            padding: u16,
        }),
        ///  stream x peripheral address register
        S3PAR: mmio.Mmio(packed struct(u32) {
            ///  Peripheral address
            PA: u32,
        }),
        ///  stream x memory 0 address register
        S3M0AR: mmio.Mmio(packed struct(u32) {
            ///  Memory 0 address
            M0A: u32,
        }),
        ///  stream x memory 1 address register
        S3M1AR: mmio.Mmio(packed struct(u32) {
            ///  Memory 1 address (used in case of Double buffer mode)
            M1A: u32,
        }),
        ///  stream x FIFO control register
        S3FCR: mmio.Mmio(packed struct(u32) {
            ///  FIFO threshold selection
            FTH: u2,
            ///  Direct mode disable
            DMDIS: u1,
            ///  FIFO status
            FS: u3,
            reserved7: u1,
            ///  FIFO error interrupt enable
            FEIE: u1,
            padding: u24,
        }),
        ///  stream x configuration register
        S4CR: mmio.Mmio(packed struct(u32) {
            ///  Stream enable / flag stream ready when read low
            EN: u1,
            ///  Direct mode error interrupt enable
            DMEIE: u1,
            ///  Transfer error interrupt enable
            TEIE: u1,
            ///  Half transfer interrupt enable
            HTIE: u1,
            ///  Transfer complete interrupt enable
            TCIE: u1,
            ///  Peripheral flow controller
            PFCTRL: u1,
            ///  Data transfer direction
            DIR: u2,
            ///  Circular mode
            CIRC: u1,
            ///  Peripheral increment mode
            PINC: u1,
            ///  Memory increment mode
            MINC: u1,
            ///  Peripheral data size
            PSIZE: u2,
            ///  Memory data size
            MSIZE: u2,
            ///  Peripheral increment offset size
            PINCOS: u1,
            ///  Priority level
            PL: u2,
            ///  Double buffer mode
            DBM: u1,
            ///  Current target (only in double buffer mode)
            CT: u1,
            ///  ACK
            ACK: u1,
            ///  Peripheral burst transfer configuration
            PBURST: u2,
            ///  Memory burst transfer configuration
            MBURST: u2,
            ///  Channel selection
            CHSEL: u3,
            padding: u4,
        }),
        ///  stream x number of data register
        S4NDTR: mmio.Mmio(packed struct(u32) {
            ///  Number of data items to transfer
            NDT: u16,
            padding: u16,
        }),
        ///  stream x peripheral address register
        S4PAR: mmio.Mmio(packed struct(u32) {
            ///  Peripheral address
            PA: u32,
        }),
        ///  stream x memory 0 address register
        S4M0AR: mmio.Mmio(packed struct(u32) {
            ///  Memory 0 address
            M0A: u32,
        }),
        ///  stream x memory 1 address register
        S4M1AR: mmio.Mmio(packed struct(u32) {
            ///  Memory 1 address (used in case of Double buffer mode)
            M1A: u32,
        }),
        ///  stream x FIFO control register
        S4FCR: mmio.Mmio(packed struct(u32) {
            ///  FIFO threshold selection
            FTH: u2,
            ///  Direct mode disable
            DMDIS: u1,
            ///  FIFO status
            FS: u3,
            reserved7: u1,
            ///  FIFO error interrupt enable
            FEIE: u1,
            padding: u24,
        }),
        ///  stream x configuration register
        S5CR: mmio.Mmio(packed struct(u32) {
            ///  Stream enable / flag stream ready when read low
            EN: u1,
            ///  Direct mode error interrupt enable
            DMEIE: u1,
            ///  Transfer error interrupt enable
            TEIE: u1,
            ///  Half transfer interrupt enable
            HTIE: u1,
            ///  Transfer complete interrupt enable
            TCIE: u1,
            ///  Peripheral flow controller
            PFCTRL: u1,
            ///  Data transfer direction
            DIR: u2,
            ///  Circular mode
            CIRC: u1,
            ///  Peripheral increment mode
            PINC: u1,
            ///  Memory increment mode
            MINC: u1,
            ///  Peripheral data size
            PSIZE: u2,
            ///  Memory data size
            MSIZE: u2,
            ///  Peripheral increment offset size
            PINCOS: u1,
            ///  Priority level
            PL: u2,
            ///  Double buffer mode
            DBM: u1,
            ///  Current target (only in double buffer mode)
            CT: u1,
            ///  ACK
            ACK: u1,
            ///  Peripheral burst transfer configuration
            PBURST: u2,
            ///  Memory burst transfer configuration
            MBURST: u2,
            ///  Channel selection
            CHSEL: u3,
            padding: u4,
        }),
        ///  stream x number of data register
        S5NDTR: mmio.Mmio(packed struct(u32) {
            ///  Number of data items to transfer
            NDT: u16,
            padding: u16,
        }),
        ///  stream x peripheral address register
        S5PAR: mmio.Mmio(packed struct(u32) {
            ///  Peripheral address
            PA: u32,
        }),
        ///  stream x memory 0 address register
        S5M0AR: mmio.Mmio(packed struct(u32) {
            ///  Memory 0 address
            M0A: u32,
        }),
        ///  stream x memory 1 address register
        S5M1AR: mmio.Mmio(packed struct(u32) {
            ///  Memory 1 address (used in case of Double buffer mode)
            M1A: u32,
        }),
        ///  stream x FIFO control register
        S5FCR: mmio.Mmio(packed struct(u32) {
            ///  FIFO threshold selection
            FTH: u2,
            ///  Direct mode disable
            DMDIS: u1,
            ///  FIFO status
            FS: u3,
            reserved7: u1,
            ///  FIFO error interrupt enable
            FEIE: u1,
            padding: u24,
        }),
        ///  stream x configuration register
        S6CR: mmio.Mmio(packed struct(u32) {
            ///  Stream enable / flag stream ready when read low
            EN: u1,
            ///  Direct mode error interrupt enable
            DMEIE: u1,
            ///  Transfer error interrupt enable
            TEIE: u1,
            ///  Half transfer interrupt enable
            HTIE: u1,
            ///  Transfer complete interrupt enable
            TCIE: u1,
            ///  Peripheral flow controller
            PFCTRL: u1,
            ///  Data transfer direction
            DIR: u2,
            ///  Circular mode
            CIRC: u1,
            ///  Peripheral increment mode
            PINC: u1,
            ///  Memory increment mode
            MINC: u1,
            ///  Peripheral data size
            PSIZE: u2,
            ///  Memory data size
            MSIZE: u2,
            ///  Peripheral increment offset size
            PINCOS: u1,
            ///  Priority level
            PL: u2,
            ///  Double buffer mode
            DBM: u1,
            ///  Current target (only in double buffer mode)
            CT: u1,
            ///  ACK
            ACK: u1,
            ///  Peripheral burst transfer configuration
            PBURST: u2,
            ///  Memory burst transfer configuration
            MBURST: u2,
            ///  Channel selection
            CHSEL: u3,
            padding: u4,
        }),
        ///  stream x number of data register
        S6NDTR: mmio.Mmio(packed struct(u32) {
            ///  Number of data items to transfer
            NDT: u16,
            padding: u16,
        }),
        ///  stream x peripheral address register
        S6PAR: mmio.Mmio(packed struct(u32) {
            ///  Peripheral address
            PA: u32,
        }),
        ///  stream x memory 0 address register
        S6M0AR: mmio.Mmio(packed struct(u32) {
            ///  Memory 0 address
            M0A: u32,
        }),
        ///  stream x memory 1 address register
        S6M1AR: mmio.Mmio(packed struct(u32) {
            ///  Memory 1 address (used in case of Double buffer mode)
            M1A: u32,
        }),
        ///  stream x FIFO control register
        S6FCR: mmio.Mmio(packed struct(u32) {
            ///  FIFO threshold selection
            FTH: u2,
            ///  Direct mode disable
            DMDIS: u1,
            ///  FIFO status
            FS: u3,
            reserved7: u1,
            ///  FIFO error interrupt enable
            FEIE: u1,
            padding: u24,
        }),
        ///  stream x configuration register
        S7CR: mmio.Mmio(packed struct(u32) {
            ///  Stream enable / flag stream ready when read low
            EN: u1,
            ///  Direct mode error interrupt enable
            DMEIE: u1,
            ///  Transfer error interrupt enable
            TEIE: u1,
            ///  Half transfer interrupt enable
            HTIE: u1,
            ///  Transfer complete interrupt enable
            TCIE: u1,
            ///  Peripheral flow controller
            PFCTRL: u1,
            ///  Data transfer direction
            DIR: u2,
            ///  Circular mode
            CIRC: u1,
            ///  Peripheral increment mode
            PINC: u1,
            ///  Memory increment mode
            MINC: u1,
            ///  Peripheral data size
            PSIZE: u2,
            ///  Memory data size
            MSIZE: u2,
            ///  Peripheral increment offset size
            PINCOS: u1,
            ///  Priority level
            PL: u2,
            ///  Double buffer mode
            DBM: u1,
            ///  Current target (only in double buffer mode)
            CT: u1,
            ///  ACK
            ACK: u1,
            ///  Peripheral burst transfer configuration
            PBURST: u2,
            ///  Memory burst transfer configuration
            MBURST: u2,
            ///  Channel selection
            CHSEL: u3,
            padding: u4,
        }),
        ///  stream x number of data register
        S7NDTR: mmio.Mmio(packed struct(u32) {
            ///  Number of data items to transfer
            NDT: u16,
            padding: u16,
        }),
        ///  stream x peripheral address register
        S7PAR: mmio.Mmio(packed struct(u32) {
            ///  Peripheral address
            PA: u32,
        }),
        ///  stream x memory 0 address register
        S7M0AR: mmio.Mmio(packed struct(u32) {
            ///  Memory 0 address
            M0A: u32,
        }),
        ///  stream x memory 1 address register
        S7M1AR: mmio.Mmio(packed struct(u32) {
            ///  Memory 1 address (used in case of Double buffer mode)
            M1A: u32,
        }),
        ///  stream x FIFO control register
        S7FCR: mmio.Mmio(packed struct(u32) {
            ///  FIFO threshold selection
            FTH: u2,
            ///  Direct mode disable
            DMDIS: u1,
            ///  FIFO status
            FS: u3,
            reserved7: u1,
            ///  FIFO error interrupt enable
            FEIE: u1,
            padding: u24,
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

    ///  Reset and clock control
    pub const RCC = extern struct {
        ///  clock control register
        CR: mmio.Mmio(packed struct(u32) {
            ///  Internal high-speed clock enable
            HSION: u1,
            ///  Internal high-speed clock ready flag
            HSIRDY: u1,
            reserved3: u1,
            ///  Internal high-speed clock trimming
            HSITRIM: u5,
            ///  Internal high-speed clock calibration
            HSICAL: u8,
            ///  HSE clock enable
            HSEON: u1,
            ///  HSE clock ready flag
            HSERDY: u1,
            ///  HSE clock bypass
            HSEBYP: u1,
            ///  Clock security system enable
            CSSON: u1,
            reserved24: u4,
            ///  Main PLL (PLL) enable
            PLLON: u1,
            ///  Main PLL (PLL) clock ready flag
            PLLRDY: u1,
            ///  PLLI2S enable
            PLLI2SON: u1,
            ///  PLLI2S clock ready flag
            PLLI2SRDY: u1,
            padding: u4,
        }),
        ///  PLL configuration register
        PLLCFGR: mmio.Mmio(packed struct(u32) {
            ///  Division factor for the main PLL (PLL) and audio PLL (PLLI2S) input clock
            PLLM0: u1,
            ///  Division factor for the main PLL (PLL) and audio PLL (PLLI2S) input clock
            PLLM1: u1,
            ///  Division factor for the main PLL (PLL) and audio PLL (PLLI2S) input clock
            PLLM2: u1,
            ///  Division factor for the main PLL (PLL) and audio PLL (PLLI2S) input clock
            PLLM3: u1,
            ///  Division factor for the main PLL (PLL) and audio PLL (PLLI2S) input clock
            PLLM4: u1,
            ///  Division factor for the main PLL (PLL) and audio PLL (PLLI2S) input clock
            PLLM5: u1,
            ///  Main PLL (PLL) multiplication factor for VCO
            PLLN0: u1,
            ///  Main PLL (PLL) multiplication factor for VCO
            PLLN1: u1,
            ///  Main PLL (PLL) multiplication factor for VCO
            PLLN2: u1,
            ///  Main PLL (PLL) multiplication factor for VCO
            PLLN3: u1,
            ///  Main PLL (PLL) multiplication factor for VCO
            PLLN4: u1,
            ///  Main PLL (PLL) multiplication factor for VCO
            PLLN5: u1,
            ///  Main PLL (PLL) multiplication factor for VCO
            PLLN6: u1,
            ///  Main PLL (PLL) multiplication factor for VCO
            PLLN7: u1,
            ///  Main PLL (PLL) multiplication factor for VCO
            PLLN8: u1,
            reserved16: u1,
            ///  Main PLL (PLL) division factor for main system clock
            PLLP0: u1,
            ///  Main PLL (PLL) division factor for main system clock
            PLLP1: u1,
            reserved22: u4,
            ///  Main PLL(PLL) and audio PLL (PLLI2S) entry clock source
            PLLSRC: u1,
            reserved24: u1,
            ///  Main PLL (PLL) division factor for USB OTG FS, SDIO and random number generator clocks
            PLLQ0: u1,
            ///  Main PLL (PLL) division factor for USB OTG FS, SDIO and random number generator clocks
            PLLQ1: u1,
            ///  Main PLL (PLL) division factor for USB OTG FS, SDIO and random number generator clocks
            PLLQ2: u1,
            ///  Main PLL (PLL) division factor for USB OTG FS, SDIO and random number generator clocks
            PLLQ3: u1,
            padding: u4,
        }),
        ///  clock configuration register
        CFGR: mmio.Mmio(packed struct(u32) {
            ///  System clock switch
            SW0: u1,
            ///  System clock switch
            SW1: u1,
            ///  System clock switch status
            SWS0: u1,
            ///  System clock switch status
            SWS1: u1,
            ///  AHB prescaler
            HPRE: u4,
            reserved10: u2,
            ///  APB Low speed prescaler (APB1)
            PPRE1: u3,
            ///  APB high-speed prescaler (APB2)
            PPRE2: u3,
            ///  HSE division factor for RTC clock
            RTCPRE: u5,
            ///  Microcontroller clock output 1
            MCO1: u2,
            ///  I2S clock selection
            I2SSRC: u1,
            ///  MCO1 prescaler
            MCO1PRE: u3,
            ///  MCO2 prescaler
            MCO2PRE: u3,
            ///  Microcontroller clock output 2
            MCO2: u2,
        }),
        ///  clock interrupt register
        CIR: mmio.Mmio(packed struct(u32) {
            ///  LSI ready interrupt flag
            LSIRDYF: u1,
            ///  LSE ready interrupt flag
            LSERDYF: u1,
            ///  HSI ready interrupt flag
            HSIRDYF: u1,
            ///  HSE ready interrupt flag
            HSERDYF: u1,
            ///  Main PLL (PLL) ready interrupt flag
            PLLRDYF: u1,
            ///  PLLI2S ready interrupt flag
            PLLI2SRDYF: u1,
            reserved7: u1,
            ///  Clock security system interrupt flag
            CSSF: u1,
            ///  LSI ready interrupt enable
            LSIRDYIE: u1,
            ///  LSE ready interrupt enable
            LSERDYIE: u1,
            ///  HSI ready interrupt enable
            HSIRDYIE: u1,
            ///  HSE ready interrupt enable
            HSERDYIE: u1,
            ///  Main PLL (PLL) ready interrupt enable
            PLLRDYIE: u1,
            ///  PLLI2S ready interrupt enable
            PLLI2SRDYIE: u1,
            reserved16: u2,
            ///  LSI ready interrupt clear
            LSIRDYC: u1,
            ///  LSE ready interrupt clear
            LSERDYC: u1,
            ///  HSI ready interrupt clear
            HSIRDYC: u1,
            ///  HSE ready interrupt clear
            HSERDYC: u1,
            ///  Main PLL(PLL) ready interrupt clear
            PLLRDYC: u1,
            ///  PLLI2S ready interrupt clear
            PLLI2SRDYC: u1,
            reserved23: u1,
            ///  Clock security system interrupt clear
            CSSC: u1,
            padding: u8,
        }),
        ///  AHB1 peripheral reset register
        AHB1RSTR: mmio.Mmio(packed struct(u32) {
            ///  IO port A reset
            GPIOARST: u1,
            ///  IO port B reset
            GPIOBRST: u1,
            ///  IO port C reset
            GPIOCRST: u1,
            ///  IO port D reset
            GPIODRST: u1,
            ///  IO port E reset
            GPIOERST: u1,
            ///  IO port F reset
            GPIOFRST: u1,
            ///  IO port G reset
            GPIOGRST: u1,
            ///  IO port H reset
            GPIOHRST: u1,
            ///  IO port I reset
            GPIOIRST: u1,
            reserved12: u3,
            ///  CRC reset
            CRCRST: u1,
            reserved21: u8,
            ///  DMA2 reset
            DMA1RST: u1,
            ///  DMA2 reset
            DMA2RST: u1,
            reserved25: u2,
            ///  Ethernet MAC reset
            ETHMACRST: u1,
            reserved29: u3,
            ///  USB OTG HS module reset
            OTGHSRST: u1,
            padding: u2,
        }),
        ///  AHB2 peripheral reset register
        AHB2RSTR: mmio.Mmio(packed struct(u32) {
            ///  Camera interface reset
            DCMIRST: u1,
            reserved4: u3,
            ///  Cryptographic module reset
            CRYPRST: u1,
            ///  Hash module reset
            HSAHRST: u1,
            ///  Random number generator module reset
            RNGRST: u1,
            ///  USB OTG FS module reset
            OTGFSRST: u1,
            padding: u24,
        }),
        ///  AHB3 peripheral reset register
        AHB3RSTR: mmio.Mmio(packed struct(u32) {
            ///  Flexible memory controller module reset
            FMCRST: u1,
            padding: u31,
        }),
        reserved32: [4]u8,
        ///  APB1 peripheral reset register
        APB1RSTR: mmio.Mmio(packed struct(u32) {
            ///  TIM2 reset
            TIM2RST: u1,
            ///  TIM3 reset
            TIM3RST: u1,
            ///  TIM4 reset
            TIM4RST: u1,
            ///  TIM5 reset
            TIM5RST: u1,
            ///  TIM6 reset
            TIM6RST: u1,
            ///  TIM7 reset
            TIM7RST: u1,
            ///  TIM12 reset
            TIM12RST: u1,
            ///  TIM13 reset
            TIM13RST: u1,
            ///  TIM14 reset
            TIM14RST: u1,
            reserved11: u2,
            ///  Window watchdog reset
            WWDGRST: u1,
            reserved14: u2,
            ///  SPI 2 reset
            SPI2RST: u1,
            ///  SPI 3 reset
            SPI3RST: u1,
            reserved17: u1,
            ///  USART 2 reset
            UART2RST: u1,
            ///  USART 3 reset
            UART3RST: u1,
            ///  USART 4 reset
            UART4RST: u1,
            ///  USART 5 reset
            UART5RST: u1,
            ///  I2C 1 reset
            I2C1RST: u1,
            ///  I2C 2 reset
            I2C2RST: u1,
            ///  I2C3 reset
            I2C3RST: u1,
            reserved25: u1,
            ///  CAN1 reset
            CAN1RST: u1,
            ///  CAN2 reset
            CAN2RST: u1,
            reserved28: u1,
            ///  Power interface reset
            PWRRST: u1,
            ///  DAC reset
            DACRST: u1,
            padding: u2,
        }),
        ///  APB2 peripheral reset register
        APB2RSTR: mmio.Mmio(packed struct(u32) {
            ///  TIM1 reset
            TIM1RST: u1,
            ///  TIM8 reset
            TIM8RST: u1,
            reserved4: u2,
            ///  USART1 reset
            USART1RST: u1,
            ///  USART6 reset
            USART6RST: u1,
            reserved8: u2,
            ///  ADC interface reset (common to all ADCs)
            ADCRST: u1,
            reserved11: u2,
            ///  SDIO reset
            SDIORST: u1,
            ///  SPI 1 reset
            SPI1RST: u1,
            reserved14: u1,
            ///  System configuration controller reset
            SYSCFGRST: u1,
            reserved16: u1,
            ///  TIM9 reset
            TIM9RST: u1,
            ///  TIM10 reset
            TIM10RST: u1,
            ///  TIM11 reset
            TIM11RST: u1,
            padding: u13,
        }),
        reserved48: [8]u8,
        ///  AHB1 peripheral clock register
        AHB1ENR: mmio.Mmio(packed struct(u32) {
            ///  IO port A clock enable
            GPIOAEN: u1,
            ///  IO port B clock enable
            GPIOBEN: u1,
            ///  IO port C clock enable
            GPIOCEN: u1,
            ///  IO port D clock enable
            GPIODEN: u1,
            ///  IO port E clock enable
            GPIOEEN: u1,
            ///  IO port F clock enable
            GPIOFEN: u1,
            ///  IO port G clock enable
            GPIOGEN: u1,
            ///  IO port H clock enable
            GPIOHEN: u1,
            ///  IO port I clock enable
            GPIOIEN: u1,
            reserved12: u3,
            ///  CRC clock enable
            CRCEN: u1,
            reserved18: u5,
            ///  Backup SRAM interface clock enable
            BKPSRAMEN: u1,
            reserved20: u1,
            ///  CCM data RAM clock enable
            CCMDATARAMEN: u1,
            ///  DMA1 clock enable
            DMA1EN: u1,
            ///  DMA2 clock enable
            DMA2EN: u1,
            reserved25: u2,
            ///  Ethernet MAC clock enable
            ETHMACEN: u1,
            ///  Ethernet Transmission clock enable
            ETHMACTXEN: u1,
            ///  Ethernet Reception clock enable
            ETHMACRXEN: u1,
            ///  Ethernet PTP clock enable
            ETHMACPTPEN: u1,
            ///  USB OTG HS clock enable
            OTGHSEN: u1,
            ///  USB OTG HSULPI clock enable
            OTGHSULPIEN: u1,
            padding: u1,
        }),
        ///  AHB2 peripheral clock enable register
        AHB2ENR: mmio.Mmio(packed struct(u32) {
            ///  Camera interface enable
            DCMIEN: u1,
            reserved4: u3,
            ///  Cryptographic modules clock enable
            CRYPEN: u1,
            ///  Hash modules clock enable
            HASHEN: u1,
            ///  Random number generator clock enable
            RNGEN: u1,
            ///  USB OTG FS clock enable
            OTGFSEN: u1,
            padding: u24,
        }),
        ///  AHB3 peripheral clock enable register
        AHB3ENR: mmio.Mmio(packed struct(u32) {
            ///  Flexible memory controller module clock enable
            FMCEN: u1,
            padding: u31,
        }),
        reserved64: [4]u8,
        ///  APB1 peripheral clock enable register
        APB1ENR: mmio.Mmio(packed struct(u32) {
            ///  TIM2 clock enable
            TIM2EN: u1,
            ///  TIM3 clock enable
            TIM3EN: u1,
            ///  TIM4 clock enable
            TIM4EN: u1,
            ///  TIM5 clock enable
            TIM5EN: u1,
            ///  TIM6 clock enable
            TIM6EN: u1,
            ///  TIM7 clock enable
            TIM7EN: u1,
            ///  TIM12 clock enable
            TIM12EN: u1,
            ///  TIM13 clock enable
            TIM13EN: u1,
            ///  TIM14 clock enable
            TIM14EN: u1,
            reserved11: u2,
            ///  Window watchdog clock enable
            WWDGEN: u1,
            reserved14: u2,
            ///  SPI2 clock enable
            SPI2EN: u1,
            ///  SPI3 clock enable
            SPI3EN: u1,
            reserved17: u1,
            ///  USART 2 clock enable
            USART2EN: u1,
            ///  USART3 clock enable
            USART3EN: u1,
            ///  UART4 clock enable
            UART4EN: u1,
            ///  UART5 clock enable
            UART5EN: u1,
            ///  I2C1 clock enable
            I2C1EN: u1,
            ///  I2C2 clock enable
            I2C2EN: u1,
            ///  I2C3 clock enable
            I2C3EN: u1,
            reserved25: u1,
            ///  CAN 1 clock enable
            CAN1EN: u1,
            ///  CAN 2 clock enable
            CAN2EN: u1,
            reserved28: u1,
            ///  Power interface clock enable
            PWREN: u1,
            ///  DAC interface clock enable
            DACEN: u1,
            padding: u2,
        }),
        ///  APB2 peripheral clock enable register
        APB2ENR: mmio.Mmio(packed struct(u32) {
            ///  TIM1 clock enable
            TIM1EN: u1,
            ///  TIM8 clock enable
            TIM8EN: u1,
            reserved4: u2,
            ///  USART1 clock enable
            USART1EN: u1,
            ///  USART6 clock enable
            USART6EN: u1,
            reserved8: u2,
            ///  ADC1 clock enable
            ADC1EN: u1,
            ///  ADC2 clock enable
            ADC2EN: u1,
            ///  ADC3 clock enable
            ADC3EN: u1,
            ///  SDIO clock enable
            SDIOEN: u1,
            ///  SPI1 clock enable
            SPI1EN: u1,
            reserved14: u1,
            ///  System configuration controller clock enable
            SYSCFGEN: u1,
            reserved16: u1,
            ///  TIM9 clock enable
            TIM9EN: u1,
            ///  TIM10 clock enable
            TIM10EN: u1,
            ///  TIM11 clock enable
            TIM11EN: u1,
            padding: u13,
        }),
        reserved80: [8]u8,
        ///  AHB1 peripheral clock enable in low power mode register
        AHB1LPENR: mmio.Mmio(packed struct(u32) {
            ///  IO port A clock enable during sleep mode
            GPIOALPEN: u1,
            ///  IO port B clock enable during Sleep mode
            GPIOBLPEN: u1,
            ///  IO port C clock enable during Sleep mode
            GPIOCLPEN: u1,
            ///  IO port D clock enable during Sleep mode
            GPIODLPEN: u1,
            ///  IO port E clock enable during Sleep mode
            GPIOELPEN: u1,
            ///  IO port F clock enable during Sleep mode
            GPIOFLPEN: u1,
            ///  IO port G clock enable during Sleep mode
            GPIOGLPEN: u1,
            ///  IO port H clock enable during Sleep mode
            GPIOHLPEN: u1,
            ///  IO port I clock enable during Sleep mode
            GPIOILPEN: u1,
            reserved12: u3,
            ///  CRC clock enable during Sleep mode
            CRCLPEN: u1,
            reserved15: u2,
            ///  Flash interface clock enable during Sleep mode
            FLITFLPEN: u1,
            ///  SRAM 1interface clock enable during Sleep mode
            SRAM1LPEN: u1,
            ///  SRAM 2 interface clock enable during Sleep mode
            SRAM2LPEN: u1,
            ///  Backup SRAM interface clock enable during Sleep mode
            BKPSRAMLPEN: u1,
            reserved21: u2,
            ///  DMA1 clock enable during Sleep mode
            DMA1LPEN: u1,
            ///  DMA2 clock enable during Sleep mode
            DMA2LPEN: u1,
            reserved25: u2,
            ///  Ethernet MAC clock enable during Sleep mode
            ETHMACLPEN: u1,
            ///  Ethernet transmission clock enable during Sleep mode
            ETHMACTXLPEN: u1,
            ///  Ethernet reception clock enable during Sleep mode
            ETHMACRXLPEN: u1,
            ///  Ethernet PTP clock enable during Sleep mode
            ETHMACPTPLPEN: u1,
            ///  USB OTG HS clock enable during Sleep mode
            OTGHSLPEN: u1,
            ///  USB OTG HS ULPI clock enable during Sleep mode
            OTGHSULPILPEN: u1,
            padding: u1,
        }),
        ///  AHB2 peripheral clock enable in low power mode register
        AHB2LPENR: mmio.Mmio(packed struct(u32) {
            ///  Camera interface enable during Sleep mode
            DCMILPEN: u1,
            reserved4: u3,
            ///  Cryptography modules clock enable during Sleep mode
            CRYPLPEN: u1,
            ///  Hash modules clock enable during Sleep mode
            HASHLPEN: u1,
            ///  Random number generator clock enable during Sleep mode
            RNGLPEN: u1,
            ///  USB OTG FS clock enable during Sleep mode
            OTGFSLPEN: u1,
            padding: u24,
        }),
        ///  AHB3 peripheral clock enable in low power mode register
        AHB3LPENR: mmio.Mmio(packed struct(u32) {
            ///  Flexible memory controller module clock enable during Sleep mode
            FMCLPEN: u1,
            padding: u31,
        }),
        reserved96: [4]u8,
        ///  APB1 peripheral clock enable in low power mode register
        APB1LPENR: mmio.Mmio(packed struct(u32) {
            ///  TIM2 clock enable during Sleep mode
            TIM2LPEN: u1,
            ///  TIM3 clock enable during Sleep mode
            TIM3LPEN: u1,
            ///  TIM4 clock enable during Sleep mode
            TIM4LPEN: u1,
            ///  TIM5 clock enable during Sleep mode
            TIM5LPEN: u1,
            ///  TIM6 clock enable during Sleep mode
            TIM6LPEN: u1,
            ///  TIM7 clock enable during Sleep mode
            TIM7LPEN: u1,
            ///  TIM12 clock enable during Sleep mode
            TIM12LPEN: u1,
            ///  TIM13 clock enable during Sleep mode
            TIM13LPEN: u1,
            ///  TIM14 clock enable during Sleep mode
            TIM14LPEN: u1,
            reserved11: u2,
            ///  Window watchdog clock enable during Sleep mode
            WWDGLPEN: u1,
            reserved14: u2,
            ///  SPI2 clock enable during Sleep mode
            SPI2LPEN: u1,
            ///  SPI3 clock enable during Sleep mode
            SPI3LPEN: u1,
            reserved17: u1,
            ///  USART2 clock enable during Sleep mode
            USART2LPEN: u1,
            ///  USART3 clock enable during Sleep mode
            USART3LPEN: u1,
            ///  UART4 clock enable during Sleep mode
            UART4LPEN: u1,
            ///  UART5 clock enable during Sleep mode
            UART5LPEN: u1,
            ///  I2C1 clock enable during Sleep mode
            I2C1LPEN: u1,
            ///  I2C2 clock enable during Sleep mode
            I2C2LPEN: u1,
            ///  I2C3 clock enable during Sleep mode
            I2C3LPEN: u1,
            reserved25: u1,
            ///  CAN 1 clock enable during Sleep mode
            CAN1LPEN: u1,
            ///  CAN 2 clock enable during Sleep mode
            CAN2LPEN: u1,
            reserved28: u1,
            ///  Power interface clock enable during Sleep mode
            PWRLPEN: u1,
            ///  DAC interface clock enable during Sleep mode
            DACLPEN: u1,
            padding: u2,
        }),
        ///  APB2 peripheral clock enabled in low power mode register
        APB2LPENR: mmio.Mmio(packed struct(u32) {
            ///  TIM1 clock enable during Sleep mode
            TIM1LPEN: u1,
            ///  TIM8 clock enable during Sleep mode
            TIM8LPEN: u1,
            reserved4: u2,
            ///  USART1 clock enable during Sleep mode
            USART1LPEN: u1,
            ///  USART6 clock enable during Sleep mode
            USART6LPEN: u1,
            reserved8: u2,
            ///  ADC1 clock enable during Sleep mode
            ADC1LPEN: u1,
            ///  ADC2 clock enable during Sleep mode
            ADC2LPEN: u1,
            ///  ADC 3 clock enable during Sleep mode
            ADC3LPEN: u1,
            ///  SDIO clock enable during Sleep mode
            SDIOLPEN: u1,
            ///  SPI 1 clock enable during Sleep mode
            SPI1LPEN: u1,
            reserved14: u1,
            ///  System configuration controller clock enable during Sleep mode
            SYSCFGLPEN: u1,
            reserved16: u1,
            ///  TIM9 clock enable during sleep mode
            TIM9LPEN: u1,
            ///  TIM10 clock enable during Sleep mode
            TIM10LPEN: u1,
            ///  TIM11 clock enable during Sleep mode
            TIM11LPEN: u1,
            padding: u13,
        }),
        reserved112: [8]u8,
        ///  Backup domain control register
        BDCR: mmio.Mmio(packed struct(u32) {
            ///  External low-speed oscillator enable
            LSEON: u1,
            ///  External low-speed oscillator ready
            LSERDY: u1,
            ///  External low-speed oscillator bypass
            LSEBYP: u1,
            reserved8: u5,
            ///  RTC clock source selection
            RTCSEL0: u1,
            ///  RTC clock source selection
            RTCSEL1: u1,
            reserved15: u5,
            ///  RTC clock enable
            RTCEN: u1,
            ///  Backup domain software reset
            BDRST: u1,
            padding: u15,
        }),
        ///  clock control & status register
        CSR: mmio.Mmio(packed struct(u32) {
            ///  Internal low-speed oscillator enable
            LSION: u1,
            ///  Internal low-speed oscillator ready
            LSIRDY: u1,
            reserved24: u22,
            ///  Remove reset flag
            RMVF: u1,
            ///  BOR reset flag
            BORRSTF: u1,
            ///  PIN reset flag
            PADRSTF: u1,
            ///  POR/PDR reset flag
            PORRSTF: u1,
            ///  Software reset flag
            SFTRSTF: u1,
            ///  Independent watchdog reset flag
            WDGRSTF: u1,
            ///  Window watchdog reset flag
            WWDGRSTF: u1,
            ///  Low-power reset flag
            LPWRRSTF: u1,
        }),
        reserved128: [8]u8,
        ///  spread spectrum clock generation register
        SSCGR: mmio.Mmio(packed struct(u32) {
            ///  Modulation period
            MODPER: u13,
            ///  Incrementation step
            INCSTEP: u15,
            reserved30: u2,
            ///  Spread Select
            SPREADSEL: u1,
            ///  Spread spectrum modulation enable
            SSCGEN: u1,
        }),
        ///  PLLI2S configuration register
        PLLI2SCFGR: mmio.Mmio(packed struct(u32) {
            reserved6: u6,
            ///  PLLI2S multiplication factor for VCO
            PLLI2SN: u9,
            reserved24: u9,
            ///  PLLI2S division factor for SAI1 clock
            PLLI2SQ: u4,
            ///  PLLI2S division factor for I2S clocks
            PLLI2SR: u3,
            padding: u1,
        }),
        ///  RCC PLL configuration register
        PLLSAICFGR: mmio.Mmio(packed struct(u32) {
            reserved6: u6,
            ///  PLLSAI division factor for VCO
            PLLSAIN: u9,
            reserved24: u9,
            ///  PLLSAI division factor for SAI1 clock
            PLLSAIQ: u4,
            ///  PLLSAI division factor for LCD clock
            PLLSAIR: u3,
            padding: u1,
        }),
        ///  RCC Dedicated Clock Configuration Register
        DCKCFGR: mmio.Mmio(packed struct(u32) {
            ///  PLLI2S division factor for SAI1 clock
            PLLI2SDIVQ: u5,
            reserved8: u3,
            ///  PLLSAI division factor for SAI1 clock
            PLLSAIDIVQ: u5,
            reserved16: u3,
            ///  division factor for LCD_CLK
            PLLSAIDIVR: u2,
            reserved20: u2,
            ///  SAI1-A clock source selection
            SAI1ASRC: u2,
            ///  SAI1-B clock source selection
            SAI1BSRC: u2,
            ///  Timers clocks prescalers selection
            TIMPRE: u1,
            padding: u7,
        }),
    };

    ///  General-purpose I/Os
    pub const GPIOK = extern struct {
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
            ///  Port x lock bit y (y= 0..15)
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
            padding: u24,
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
            padding: u16,
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

    ///  Ethernet: MAC management counters
    pub const Ethernet_MMC = extern struct {
        ///  Ethernet MMC control register
        MMCCR: mmio.Mmio(packed struct(u32) {
            ///  CR
            CR: u1,
            ///  CSR
            CSR: u1,
            ///  ROR
            ROR: u1,
            ///  MCF
            MCF: u1,
            ///  MCP
            MCP: u1,
            ///  MCFHP
            MCFHP: u1,
            padding: u26,
        }),
        ///  Ethernet MMC receive interrupt register
        MMCRIR: mmio.Mmio(packed struct(u32) {
            reserved5: u5,
            ///  RFCES
            RFCES: u1,
            ///  RFAES
            RFAES: u1,
            reserved17: u10,
            ///  RGUFS
            RGUFS: u1,
            padding: u14,
        }),
        ///  Ethernet MMC transmit interrupt register
        MMCTIR: mmio.Mmio(packed struct(u32) {
            reserved14: u14,
            ///  TGFSCS
            TGFSCS: u1,
            ///  TGFMSCS
            TGFMSCS: u1,
            reserved21: u5,
            ///  TGFS
            TGFS: u1,
            padding: u10,
        }),
        ///  Ethernet MMC receive interrupt mask register
        MMCRIMR: mmio.Mmio(packed struct(u32) {
            reserved5: u5,
            ///  RFCEM
            RFCEM: u1,
            ///  RFAEM
            RFAEM: u1,
            reserved17: u10,
            ///  RGUFM
            RGUFM: u1,
            padding: u14,
        }),
        ///  Ethernet MMC transmit interrupt mask register
        MMCTIMR: mmio.Mmio(packed struct(u32) {
            reserved14: u14,
            ///  TGFSCM
            TGFSCM: u1,
            ///  TGFMSCM
            TGFMSCM: u1,
            ///  TGFM
            TGFM: u1,
            padding: u15,
        }),
        reserved76: [56]u8,
        ///  Ethernet MMC transmitted good frames after a single collision counter
        MMCTGFSCCR: mmio.Mmio(packed struct(u32) {
            ///  TGFSCC
            TGFSCC: u32,
        }),
        ///  Ethernet MMC transmitted good frames after more than a single collision
        MMCTGFMSCCR: mmio.Mmio(packed struct(u32) {
            ///  TGFMSCC
            TGFMSCC: u32,
        }),
        reserved104: [20]u8,
        ///  Ethernet MMC transmitted good frames counter register
        MMCTGFCR: mmio.Mmio(packed struct(u32) {
            ///  HTL
            TGFC: u32,
        }),
        reserved148: [40]u8,
        ///  Ethernet MMC received frames with CRC error counter register
        MMCRFCECR: mmio.Mmio(packed struct(u32) {
            ///  RFCFC
            RFCFC: u32,
        }),
        ///  Ethernet MMC received frames with alignment error counter register
        MMCRFAECR: mmio.Mmio(packed struct(u32) {
            ///  RFAEC
            RFAEC: u32,
        }),
        reserved196: [40]u8,
        ///  MMC received good unicast frames counter register
        MMCRGUFCR: mmio.Mmio(packed struct(u32) {
            ///  RGUFC
            RGUFC: u32,
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
            ///  Port x lock bit y (y= 0..15)
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
    };

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
            ///  Port x lock bit y (y= 0..15)
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
    };

    ///  System configuration controller
    pub const SYSCFG = extern struct {
        ///  memory remap register
        MEMRM: mmio.Mmio(packed struct(u32) {
            ///  Memory mapping selection
            MEM_MODE: u3,
            reserved8: u5,
            ///  Flash bank mode selection
            FB_MODE: u1,
            reserved10: u1,
            ///  FMC memory mapping swap
            SWP_FMC: u2,
            padding: u20,
        }),
        ///  peripheral mode configuration register
        PMC: mmio.Mmio(packed struct(u32) {
            reserved16: u16,
            ///  ADC1DC2
            ADC1DC2: u1,
            ///  ADC2DC2
            ADC2DC2: u1,
            ///  ADC3DC2
            ADC3DC2: u1,
            reserved23: u4,
            ///  Ethernet PHY interface selection
            MII_RMII_SEL: u1,
            padding: u8,
        }),
        ///  external interrupt configuration register 1
        EXTICR1: mmio.Mmio(packed struct(u32) {
            ///  EXTI x configuration (x = 0 to 3)
            EXTI0: u4,
            ///  EXTI x configuration (x = 0 to 3)
            EXTI1: u4,
            ///  EXTI x configuration (x = 0 to 3)
            EXTI2: u4,
            ///  EXTI x configuration (x = 0 to 3)
            EXTI3: u4,
            padding: u16,
        }),
        ///  external interrupt configuration register 2
        EXTICR2: mmio.Mmio(packed struct(u32) {
            ///  EXTI x configuration (x = 4 to 7)
            EXTI4: u4,
            ///  EXTI x configuration (x = 4 to 7)
            EXTI5: u4,
            ///  EXTI x configuration (x = 4 to 7)
            EXTI6: u4,
            ///  EXTI x configuration (x = 4 to 7)
            EXTI7: u4,
            padding: u16,
        }),
        ///  external interrupt configuration register 3
        EXTICR3: mmio.Mmio(packed struct(u32) {
            ///  EXTI x configuration (x = 8 to 11)
            EXTI8: u4,
            ///  EXTI x configuration (x = 8 to 11)
            EXTI9: u4,
            ///  EXTI10
            EXTI10: u4,
            ///  EXTI x configuration (x = 8 to 11)
            EXTI11: u4,
            padding: u16,
        }),
        ///  external interrupt configuration register 4
        EXTICR4: mmio.Mmio(packed struct(u32) {
            ///  EXTI x configuration (x = 12 to 15)
            EXTI12: u4,
            ///  EXTI x configuration (x = 12 to 15)
            EXTI13: u4,
            ///  EXTI x configuration (x = 12 to 15)
            EXTI14: u4,
            ///  EXTI x configuration (x = 12 to 15)
            EXTI15: u4,
            padding: u16,
        }),
        reserved32: [8]u8,
        ///  Compensation cell control register
        CMPCR: mmio.Mmio(packed struct(u32) {
            ///  Compensation cell power-down
            CMP_PD: u1,
            reserved8: u7,
            ///  READY
            READY: u1,
            padding: u23,
        }),
    };

    ///  Serial peripheral interface
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
            ///  Data frame format
            DFF: u1,
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
            reserved4: u1,
            ///  Frame format
            FRF: u1,
            ///  Error interrupt enable
            ERRIE: u1,
            ///  RX buffer not empty interrupt enable
            RXNEIE: u1,
            ///  Tx buffer empty interrupt enable
            TXEIE: u1,
            padding: u24,
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
            padding: u23,
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

    ///  Inter-integrated circuit
    pub const I2C3 = extern struct {
        ///  Control register 1
        CR1: mmio.Mmio(packed struct(u32) {
            ///  Peripheral enable
            PE: u1,
            ///  SMBus mode
            SMBUS: u1,
            reserved3: u1,
            ///  SMBus type
            SMBTYPE: u1,
            ///  ARP enable
            ENARP: u1,
            ///  PEC enable
            ENPEC: u1,
            ///  General call enable
            ENGC: u1,
            ///  Clock stretching disable (Slave mode)
            NOSTRETCH: u1,
            ///  Start generation
            START: u1,
            ///  Stop generation
            STOP: u1,
            ///  Acknowledge enable
            ACK: u1,
            ///  Acknowledge/PEC Position (for data reception)
            POS: u1,
            ///  Packet error checking
            PEC: u1,
            ///  SMBus alert
            ALERT: u1,
            reserved15: u1,
            ///  Software reset
            SWRST: u1,
            padding: u16,
        }),
        ///  Control register 2
        CR2: mmio.Mmio(packed struct(u32) {
            ///  Peripheral clock frequency
            FREQ: u6,
            reserved8: u2,
            ///  Error interrupt enable
            ITERREN: u1,
            ///  Event interrupt enable
            ITEVTEN: u1,
            ///  Buffer interrupt enable
            ITBUFEN: u1,
            ///  DMA requests enable
            DMAEN: u1,
            ///  DMA last transfer
            LAST: u1,
            padding: u19,
        }),
        ///  Own address register 1
        OAR1: mmio.Mmio(packed struct(u32) {
            ///  Interface address
            ADD0: u1,
            ///  Interface address
            ADD7: u7,
            ///  Interface address
            ADD10: u2,
            reserved15: u5,
            ///  Addressing mode (slave mode)
            ADDMODE: u1,
            padding: u16,
        }),
        ///  Own address register 2
        OAR2: mmio.Mmio(packed struct(u32) {
            ///  Dual addressing mode enable
            ENDUAL: u1,
            ///  Interface address
            ADD2: u7,
            padding: u24,
        }),
        ///  Data register
        DR: mmio.Mmio(packed struct(u32) {
            ///  8-bit data register
            DR: u8,
            padding: u24,
        }),
        ///  Status register 1
        SR1: mmio.Mmio(packed struct(u32) {
            ///  Start bit (Master mode)
            SB: u1,
            ///  Address sent (master mode)/matched (slave mode)
            ADDR: u1,
            ///  Byte transfer finished
            BTF: u1,
            ///  10-bit header sent (Master mode)
            ADD10: u1,
            ///  Stop detection (slave mode)
            STOPF: u1,
            reserved6: u1,
            ///  Data register not empty (receivers)
            RxNE: u1,
            ///  Data register empty (transmitters)
            TxE: u1,
            ///  Bus error
            BERR: u1,
            ///  Arbitration lost (master mode)
            ARLO: u1,
            ///  Acknowledge failure
            AF: u1,
            ///  Overrun/Underrun
            OVR: u1,
            ///  PEC Error in reception
            PECERR: u1,
            reserved14: u1,
            ///  Timeout or Tlow error
            TIMEOUT: u1,
            ///  SMBus alert
            SMBALERT: u1,
            padding: u16,
        }),
        ///  Status register 2
        SR2: mmio.Mmio(packed struct(u32) {
            ///  Master/slave
            MSL: u1,
            ///  Bus busy
            BUSY: u1,
            ///  Transmitter/receiver
            TRA: u1,
            reserved4: u1,
            ///  General call address (Slave mode)
            GENCALL: u1,
            ///  SMBus device default address (Slave mode)
            SMBDEFAULT: u1,
            ///  SMBus host header (Slave mode)
            SMBHOST: u1,
            ///  Dual flag (Slave mode)
            DUALF: u1,
            ///  acket error checking register
            PEC: u8,
            padding: u16,
        }),
        ///  Clock control register
        CCR: mmio.Mmio(packed struct(u32) {
            ///  Clock control register in Fast/Standard mode (Master mode)
            CCR: u12,
            reserved14: u2,
            ///  Fast mode duty cycle
            DUTY: u1,
            ///  I2C master mode selection
            F_S: u1,
            padding: u16,
        }),
        ///  TRISE register
        TRISE: mmio.Mmio(packed struct(u32) {
            ///  Maximum rise time in Fast/Standard mode (Master mode)
            TRISE: u6,
            padding: u26,
        }),
        ///  I2C FLTR register
        FLTR: mmio.Mmio(packed struct(u32) {
            ///  Digital noise filter
            DNF: u4,
            ///  Analog noise filter OFF
            ANOFF: u1,
            padding: u27,
        }),
    };

    ///  DMA2D controller
    pub const DMA2D = extern struct {
        ///  control register
        CR: mmio.Mmio(packed struct(u32) {
            ///  Start
            START: u1,
            ///  Suspend
            SUSP: u1,
            ///  Abort
            ABORT: u1,
            reserved8: u5,
            ///  Transfer error interrupt enable
            TEIE: u1,
            ///  Transfer complete interrupt enable
            TCIE: u1,
            ///  Transfer watermark interrupt enable
            TWIE: u1,
            ///  CLUT access error interrupt enable
            CAEIE: u1,
            ///  CLUT transfer complete interrupt enable
            CTCIE: u1,
            ///  Configuration Error Interrupt Enable
            CEIE: u1,
            reserved16: u2,
            ///  DMA2D mode
            MODE: u2,
            padding: u14,
        }),
        ///  Interrupt Status Register
        ISR: mmio.Mmio(packed struct(u32) {
            ///  Transfer error interrupt flag
            TEIF: u1,
            ///  Transfer complete interrupt flag
            TCIF: u1,
            ///  Transfer watermark interrupt flag
            TWIF: u1,
            ///  CLUT access error interrupt flag
            CAEIF: u1,
            ///  CLUT transfer complete interrupt flag
            CTCIF: u1,
            ///  Configuration error interrupt flag
            CEIF: u1,
            padding: u26,
        }),
        ///  interrupt flag clear register
        IFCR: mmio.Mmio(packed struct(u32) {
            ///  Clear Transfer error interrupt flag
            CTEIF: u1,
            ///  Clear transfer complete interrupt flag
            CTCIF: u1,
            ///  Clear transfer watermark interrupt flag
            CTWIF: u1,
            ///  Clear CLUT access error interrupt flag
            CAECIF: u1,
            ///  Clear CLUT transfer complete interrupt flag
            CCTCIF: u1,
            ///  Clear configuration error interrupt flag
            CCEIF: u1,
            padding: u26,
        }),
        ///  foreground memory address register
        FGMAR: mmio.Mmio(packed struct(u32) {
            ///  Memory address
            MA: u32,
        }),
        ///  foreground offset register
        FGOR: mmio.Mmio(packed struct(u32) {
            ///  Line offset
            LO: u14,
            padding: u18,
        }),
        ///  background memory address register
        BGMAR: mmio.Mmio(packed struct(u32) {
            ///  Memory address
            MA: u32,
        }),
        ///  background offset register
        BGOR: mmio.Mmio(packed struct(u32) {
            ///  Line offset
            LO: u14,
            padding: u18,
        }),
        ///  foreground PFC control register
        FGPFCCR: mmio.Mmio(packed struct(u32) {
            ///  Color mode
            CM: u4,
            ///  CLUT color mode
            CCM: u1,
            ///  Start
            START: u1,
            reserved8: u2,
            ///  CLUT size
            CS: u8,
            ///  Alpha mode
            AM: u2,
            reserved24: u6,
            ///  Alpha value
            ALPHA: u8,
        }),
        ///  foreground color register
        FGCOLR: mmio.Mmio(packed struct(u32) {
            ///  Blue Value
            BLUE: u8,
            ///  Green Value
            GREEN: u8,
            ///  Red Value
            RED: u8,
            padding: u8,
        }),
        ///  background PFC control register
        BGPFCCR: mmio.Mmio(packed struct(u32) {
            ///  Color mode
            CM: u4,
            ///  CLUT Color mode
            CCM: u1,
            ///  Start
            START: u1,
            reserved8: u2,
            ///  CLUT size
            CS: u8,
            ///  Alpha mode
            AM: u2,
            reserved24: u6,
            ///  Alpha value
            ALPHA: u8,
        }),
        ///  background color register
        BGCOLR: mmio.Mmio(packed struct(u32) {
            ///  Blue Value
            BLUE: u8,
            ///  Green Value
            GREEN: u8,
            ///  Red Value
            RED: u8,
            padding: u8,
        }),
        ///  foreground CLUT memory address register
        FGCMAR: mmio.Mmio(packed struct(u32) {
            ///  Memory Address
            MA: u32,
        }),
        ///  background CLUT memory address register
        BGCMAR: mmio.Mmio(packed struct(u32) {
            ///  Memory address
            MA: u32,
        }),
        ///  output PFC control register
        OPFCCR: mmio.Mmio(packed struct(u32) {
            ///  Color mode
            CM: u3,
            padding: u29,
        }),
        ///  output color register
        OCOLR: mmio.Mmio(packed struct(u32) {
            ///  Blue Value
            BLUE: u8,
            ///  Green Value
            GREEN: u8,
            ///  Red Value
            RED: u8,
            ///  Alpha Channel Value
            APLHA: u8,
        }),
        ///  output memory address register
        OMAR: mmio.Mmio(packed struct(u32) {
            ///  Memory Address
            MA: u32,
        }),
        ///  output offset register
        OOR: mmio.Mmio(packed struct(u32) {
            ///  Line Offset
            LO: u14,
            padding: u18,
        }),
        ///  number of line register
        NLR: mmio.Mmio(packed struct(u32) {
            ///  Number of lines
            NL: u16,
            ///  Pixel per lines
            PL: u14,
            padding: u2,
        }),
        ///  line watermark register
        LWR: mmio.Mmio(packed struct(u32) {
            ///  Line watermark
            LW: u16,
            padding: u16,
        }),
        ///  AHB master timer configuration register
        AMTCR: mmio.Mmio(packed struct(u32) {
            ///  Enable
            EN: u1,
            reserved8: u7,
            ///  Dead Time
            DT: u8,
            padding: u16,
        }),
        reserved1024: [944]u8,
        ///  FGCLUT
        FGCLUT: mmio.Mmio(packed struct(u32) {
            ///  BLUE
            BLUE: u8,
            ///  GREEN
            GREEN: u8,
            ///  RED
            RED: u8,
            ///  APLHA
            APLHA: u8,
        }),
        reserved2048: [1020]u8,
        ///  BGCLUT
        BGCLUT: mmio.Mmio(packed struct(u32) {
            ///  BLUE
            BLUE: u8,
            ///  GREEN
            GREEN: u8,
            ///  RED
            RED: u8,
            ///  APLHA
            APLHA: u8,
        }),
    };

    ///  Serial audio interface
    pub const SAI = extern struct {
        reserved4: [4]u8,
        ///  AConfiguration register 1
        ACR1: mmio.Mmio(packed struct(u32) {
            ///  Audio block mode
            MODE: u2,
            ///  Protocol configuration
            PRTCFG: u2,
            reserved5: u1,
            ///  Data size
            DS: u3,
            ///  Least significant bit first
            LSBFIRST: u1,
            ///  Clock strobing edge
            CKSTR: u1,
            ///  Synchronization enable
            SYNCEN: u2,
            ///  Mono mode
            MONO: u1,
            ///  Output drive
            OutDri: u1,
            reserved16: u2,
            ///  Audio block A enable
            SAIAEN: u1,
            ///  DMA enable
            DMAEN: u1,
            reserved19: u1,
            ///  No divider
            NODIV: u1,
            ///  Master clock divider
            MCJDIV: u4,
            padding: u8,
        }),
        ///  AConfiguration register 2
        ACR2: mmio.Mmio(packed struct(u32) {
            ///  FIFO threshold
            FTH: u3,
            ///  FIFO flush
            FFLUS: u1,
            ///  Tristate management on data line
            TRIS: u1,
            ///  Mute
            MUTE: u1,
            ///  Mute value
            MUTEVAL: u1,
            ///  Mute counter
            MUTECN: u6,
            ///  Complement bit
            CPL: u1,
            ///  Companding mode
            COMP: u2,
            padding: u16,
        }),
        ///  AFRCR
        AFRCR: mmio.Mmio(packed struct(u32) {
            ///  Frame length
            FRL: u8,
            ///  Frame synchronization active level length
            FSALL: u7,
            reserved16: u1,
            ///  Frame synchronization definition
            FSDEF: u1,
            ///  Frame synchronization polarity
            FSPOL: u1,
            ///  Frame synchronization offset
            FSOFF: u1,
            padding: u13,
        }),
        ///  ASlot register
        ASLOTR: mmio.Mmio(packed struct(u32) {
            ///  First bit offset
            FBOFF: u5,
            reserved6: u1,
            ///  Slot size
            SLOTSZ: u2,
            ///  Number of slots in an audio frame
            NBSLOT: u4,
            reserved16: u4,
            ///  Slot enable
            SLOTEN: u16,
        }),
        ///  AInterrupt mask register2
        AIM: mmio.Mmio(packed struct(u32) {
            ///  Overrun/underrun interrupt enable
            OVRUDRIE: u1,
            ///  Mute detection interrupt enable
            MUTEDET: u1,
            ///  Wrong clock configuration interrupt enable
            WCKCFG: u1,
            ///  FIFO request interrupt enable
            FREQIE: u1,
            ///  Codec not ready interrupt enable
            CNRDYIE: u1,
            ///  Anticipated frame synchronization detection interrupt enable
            AFSDETIE: u1,
            ///  Late frame synchronization detection interrupt enable
            LFSDET: u1,
            padding: u25,
        }),
        ///  AStatus register
        ASR: mmio.Mmio(packed struct(u32) {
            ///  Overrun / underrun
            OVRUDR: u1,
            ///  Mute detection
            MUTEDET: u1,
            ///  Wrong clock configuration flag. This bit is read only.
            WCKCFG: u1,
            ///  FIFO request
            FREQ: u1,
            ///  Codec not ready
            CNRDY: u1,
            ///  Anticipated frame synchronization detection
            AFSDET: u1,
            ///  Late frame synchronization detection
            LFSDET: u1,
            reserved16: u9,
            ///  FIFO level threshold
            FLVL: u3,
            padding: u13,
        }),
        ///  AClear flag register
        ACLRFR: mmio.Mmio(packed struct(u32) {
            ///  Clear overrun / underrun
            OVRUDR: u1,
            ///  Mute detection flag
            MUTEDET: u1,
            ///  Clear wrong clock configuration flag
            WCKCFG: u1,
            reserved4: u1,
            ///  Clear codec not ready flag
            CNRDY: u1,
            ///  Clear anticipated frame synchronization detection flag.
            CAFSDET: u1,
            ///  Clear late frame synchronization detection flag
            LFSDET: u1,
            padding: u25,
        }),
        ///  AData register
        ADR: mmio.Mmio(packed struct(u32) {
            ///  Data
            DATA: u32,
        }),
        ///  BConfiguration register 1
        BCR1: mmio.Mmio(packed struct(u32) {
            ///  Audio block mode
            MODE: u2,
            ///  Protocol configuration
            PRTCFG: u2,
            reserved5: u1,
            ///  Data size
            DS: u3,
            ///  Least significant bit first
            LSBFIRST: u1,
            ///  Clock strobing edge
            CKSTR: u1,
            ///  Synchronization enable
            SYNCEN: u2,
            ///  Mono mode
            MONO: u1,
            ///  Output drive
            OutDri: u1,
            reserved16: u2,
            ///  Audio block B enable
            SAIBEN: u1,
            ///  DMA enable
            DMAEN: u1,
            reserved19: u1,
            ///  No divider
            NODIV: u1,
            ///  Master clock divider
            MCJDIV: u4,
            padding: u8,
        }),
        ///  BConfiguration register 2
        BCR2: mmio.Mmio(packed struct(u32) {
            ///  FIFO threshold
            FTH: u3,
            ///  FIFO flush
            FFLUS: u1,
            ///  Tristate management on data line
            TRIS: u1,
            ///  Mute
            MUTE: u1,
            ///  Mute value
            MUTEVAL: u1,
            ///  Mute counter
            MUTECN: u6,
            ///  Complement bit
            CPL: u1,
            ///  Companding mode
            COMP: u2,
            padding: u16,
        }),
        ///  BFRCR
        BFRCR: mmio.Mmio(packed struct(u32) {
            ///  Frame length
            FRL: u8,
            ///  Frame synchronization active level length
            FSALL: u7,
            reserved16: u1,
            ///  Frame synchronization definition
            FSDEF: u1,
            ///  Frame synchronization polarity
            FSPOL: u1,
            ///  Frame synchronization offset
            FSOFF: u1,
            padding: u13,
        }),
        ///  BSlot register
        BSLOTR: mmio.Mmio(packed struct(u32) {
            ///  First bit offset
            FBOFF: u5,
            reserved6: u1,
            ///  Slot size
            SLOTSZ: u2,
            ///  Number of slots in an audio frame
            NBSLOT: u4,
            reserved16: u4,
            ///  Slot enable
            SLOTEN: u16,
        }),
        ///  BInterrupt mask register2
        BIM: mmio.Mmio(packed struct(u32) {
            ///  Overrun/underrun interrupt enable
            OVRUDRIE: u1,
            ///  Mute detection interrupt enable
            MUTEDET: u1,
            ///  Wrong clock configuration interrupt enable
            WCKCFG: u1,
            ///  FIFO request interrupt enable
            FREQIE: u1,
            ///  Codec not ready interrupt enable
            CNRDYIE: u1,
            ///  Anticipated frame synchronization detection interrupt enable
            AFSDETIE: u1,
            ///  Late frame synchronization detection interrupt enable
            LFSDETIE: u1,
            padding: u25,
        }),
        ///  BStatus register
        BSR: mmio.Mmio(packed struct(u32) {
            ///  Overrun / underrun
            OVRUDR: u1,
            ///  Mute detection
            MUTEDET: u1,
            ///  Wrong clock configuration flag
            WCKCFG: u1,
            ///  FIFO request
            FREQ: u1,
            ///  Codec not ready
            CNRDY: u1,
            ///  Anticipated frame synchronization detection
            AFSDET: u1,
            ///  Late frame synchronization detection
            LFSDET: u1,
            reserved16: u9,
            ///  FIFO level threshold
            FLVL: u3,
            padding: u13,
        }),
        ///  BClear flag register
        BCLRFR: mmio.Mmio(packed struct(u32) {
            ///  Clear overrun / underrun
            OVRUDR: u1,
            ///  Mute detection flag
            MUTEDET: u1,
            ///  Clear wrong clock configuration flag
            WCKCFG: u1,
            reserved4: u1,
            ///  Clear codec not ready flag
            CNRDY: u1,
            ///  Clear anticipated frame synchronization detection flag
            CAFSDET: u1,
            ///  Clear late frame synchronization detection flag
            LFSDET: u1,
            padding: u25,
        }),
        ///  BData register
        BDR: mmio.Mmio(packed struct(u32) {
            ///  Data
            DATA: u32,
        }),
    };

    ///  LCD-TFT Controller
    pub const LTDC = extern struct {
        reserved8: [8]u8,
        ///  Synchronization Size Configuration Register
        SSCR: mmio.Mmio(packed struct(u32) {
            ///  Vertical Synchronization Height (in units of horizontal scan line)
            VSH: u11,
            reserved16: u5,
            ///  Horizontal Synchronization Width (in units of pixel clock period)
            HSW: u10,
            padding: u6,
        }),
        ///  Back Porch Configuration Register
        BPCR: mmio.Mmio(packed struct(u32) {
            ///  Accumulated Vertical back porch (in units of horizontal scan line)
            AVBP: u11,
            reserved16: u5,
            ///  Accumulated Horizontal back porch (in units of pixel clock period)
            AHBP: u10,
            padding: u6,
        }),
        ///  Active Width Configuration Register
        AWCR: mmio.Mmio(packed struct(u32) {
            ///  Accumulated Active Height (in units of horizontal scan line)
            AAH: u11,
            reserved16: u5,
            ///  AAV
            AAV: u10,
            padding: u6,
        }),
        ///  Total Width Configuration Register
        TWCR: mmio.Mmio(packed struct(u32) {
            ///  Total Height (in units of horizontal scan line)
            TOTALH: u11,
            reserved16: u5,
            ///  Total Width (in units of pixel clock period)
            TOTALW: u10,
            padding: u6,
        }),
        ///  Global Control Register
        GCR: mmio.Mmio(packed struct(u32) {
            ///  LCD-TFT controller enable bit
            LTDCEN: u1,
            reserved4: u3,
            ///  Dither Blue Width
            DBW: u3,
            reserved8: u1,
            ///  Dither Green Width
            DGW: u3,
            reserved12: u1,
            ///  Dither Red Width
            DRW: u3,
            reserved16: u1,
            ///  Dither Enable
            DEN: u1,
            reserved28: u11,
            ///  Pixel Clock Polarity
            PCPOL: u1,
            ///  Data Enable Polarity
            DEPOL: u1,
            ///  Vertical Synchronization Polarity
            VSPOL: u1,
            ///  Horizontal Synchronization Polarity
            HSPOL: u1,
        }),
        reserved36: [8]u8,
        ///  Shadow Reload Configuration Register
        SRCR: mmio.Mmio(packed struct(u32) {
            ///  Immediate Reload
            IMR: u1,
            ///  Vertical Blanking Reload
            VBR: u1,
            padding: u30,
        }),
        reserved44: [4]u8,
        ///  Background Color Configuration Register
        BCCR: mmio.Mmio(packed struct(u32) {
            ///  Background Color Red value
            BC: u24,
            padding: u8,
        }),
        reserved52: [4]u8,
        ///  Interrupt Enable Register
        IER: mmio.Mmio(packed struct(u32) {
            ///  Line Interrupt Enable
            LIE: u1,
            ///  FIFO Underrun Interrupt Enable
            FUIE: u1,
            ///  Transfer Error Interrupt Enable
            TERRIE: u1,
            ///  Register Reload interrupt enable
            RRIE: u1,
            padding: u28,
        }),
        ///  Interrupt Status Register
        ISR: mmio.Mmio(packed struct(u32) {
            ///  Line Interrupt flag
            LIF: u1,
            ///  FIFO Underrun Interrupt flag
            FUIF: u1,
            ///  Transfer Error interrupt flag
            TERRIF: u1,
            ///  Register Reload Interrupt Flag
            RRIF: u1,
            padding: u28,
        }),
        ///  Interrupt Clear Register
        ICR: mmio.Mmio(packed struct(u32) {
            ///  Clears the Line Interrupt Flag
            CLIF: u1,
            ///  Clears the FIFO Underrun Interrupt flag
            CFUIF: u1,
            ///  Clears the Transfer Error Interrupt Flag
            CTERRIF: u1,
            ///  Clears Register Reload Interrupt Flag
            CRRIF: u1,
            padding: u28,
        }),
        ///  Line Interrupt Position Configuration Register
        LIPCR: mmio.Mmio(packed struct(u32) {
            ///  Line Interrupt Position
            LIPOS: u11,
            padding: u21,
        }),
        ///  Current Position Status Register
        CPSR: mmio.Mmio(packed struct(u32) {
            ///  Current Y Position
            CYPOS: u16,
            ///  Current X Position
            CXPOS: u16,
        }),
        ///  Current Display Status Register
        CDSR: mmio.Mmio(packed struct(u32) {
            ///  Vertical Data Enable display Status
            VDES: u1,
            ///  Horizontal Data Enable display Status
            HDES: u1,
            ///  Vertical Synchronization display Status
            VSYNCS: u1,
            ///  Horizontal Synchronization display Status
            HSYNCS: u1,
            padding: u28,
        }),
        reserved132: [56]u8,
        ///  Layerx Control Register
        L1CR: mmio.Mmio(packed struct(u32) {
            ///  Layer Enable
            LEN: u1,
            ///  Color Keying Enable
            COLKEN: u1,
            reserved4: u2,
            ///  Color Look-Up Table Enable
            CLUTEN: u1,
            padding: u27,
        }),
        ///  Layerx Window Horizontal Position Configuration Register
        L1WHPCR: mmio.Mmio(packed struct(u32) {
            ///  Window Horizontal Start Position
            WHSTPOS: u12,
            reserved16: u4,
            ///  Window Horizontal Stop Position
            WHSPPOS: u12,
            padding: u4,
        }),
        ///  Layerx Window Vertical Position Configuration Register
        L1WVPCR: mmio.Mmio(packed struct(u32) {
            ///  Window Vertical Start Position
            WVSTPOS: u11,
            reserved16: u5,
            ///  Window Vertical Stop Position
            WVSPPOS: u11,
            padding: u5,
        }),
        ///  Layerx Color Keying Configuration Register
        L1CKCR: mmio.Mmio(packed struct(u32) {
            ///  Color Key Blue value
            CKBLUE: u8,
            ///  Color Key Green value
            CKGREEN: u8,
            ///  Color Key Red value
            CKRED: u8,
            padding: u8,
        }),
        ///  Layerx Pixel Format Configuration Register
        L1PFCR: mmio.Mmio(packed struct(u32) {
            ///  Pixel Format
            PF: u3,
            padding: u29,
        }),
        ///  Layerx Constant Alpha Configuration Register
        L1CACR: mmio.Mmio(packed struct(u32) {
            ///  Constant Alpha
            CONSTA: u8,
            padding: u24,
        }),
        ///  Layerx Default Color Configuration Register
        L1DCCR: mmio.Mmio(packed struct(u32) {
            ///  Default Color Blue
            DCBLUE: u8,
            ///  Default Color Green
            DCGREEN: u8,
            ///  Default Color Red
            DCRED: u8,
            ///  Default Color Alpha
            DCALPHA: u8,
        }),
        ///  Layerx Blending Factors Configuration Register
        L1BFCR: mmio.Mmio(packed struct(u32) {
            ///  Blending Factor 2
            BF2: u3,
            reserved8: u5,
            ///  Blending Factor 1
            BF1: u3,
            padding: u21,
        }),
        reserved172: [8]u8,
        ///  Layerx Color Frame Buffer Address Register
        L1CFBAR: mmio.Mmio(packed struct(u32) {
            ///  Color Frame Buffer Start Address
            CFBADD: u32,
        }),
        ///  Layerx Color Frame Buffer Length Register
        L1CFBLR: mmio.Mmio(packed struct(u32) {
            ///  Color Frame Buffer Line Length
            CFBLL: u13,
            reserved16: u3,
            ///  Color Frame Buffer Pitch in bytes
            CFBP: u13,
            padding: u3,
        }),
        ///  Layerx ColorFrame Buffer Line Number Register
        L1CFBLNR: mmio.Mmio(packed struct(u32) {
            ///  Frame Buffer Line Number
            CFBLNBR: u11,
            padding: u21,
        }),
        reserved196: [12]u8,
        ///  Layerx CLUT Write Register
        L1CLUTWR: mmio.Mmio(packed struct(u32) {
            ///  Blue value
            BLUE: u8,
            ///  Green value
            GREEN: u8,
            ///  Red value
            RED: u8,
            ///  CLUT Address
            CLUTADD: u8,
        }),
        reserved260: [60]u8,
        ///  Layerx Control Register
        L2CR: mmio.Mmio(packed struct(u32) {
            ///  Layer Enable
            LEN: u1,
            ///  Color Keying Enable
            COLKEN: u1,
            reserved4: u2,
            ///  Color Look-Up Table Enable
            CLUTEN: u1,
            padding: u27,
        }),
        ///  Layerx Window Horizontal Position Configuration Register
        L2WHPCR: mmio.Mmio(packed struct(u32) {
            ///  Window Horizontal Start Position
            WHSTPOS: u12,
            reserved16: u4,
            ///  Window Horizontal Stop Position
            WHSPPOS: u12,
            padding: u4,
        }),
        ///  Layerx Window Vertical Position Configuration Register
        L2WVPCR: mmio.Mmio(packed struct(u32) {
            ///  Window Vertical Start Position
            WVSTPOS: u11,
            reserved16: u5,
            ///  Window Vertical Stop Position
            WVSPPOS: u11,
            padding: u5,
        }),
        ///  Layerx Color Keying Configuration Register
        L2CKCR: mmio.Mmio(packed struct(u32) {
            ///  Color Key Blue value
            CKBLUE: u8,
            ///  Color Key Green value
            CKGREEN: u7,
            ///  Color Key Red value
            CKRED: u9,
            padding: u8,
        }),
        ///  Layerx Pixel Format Configuration Register
        L2PFCR: mmio.Mmio(packed struct(u32) {
            ///  Pixel Format
            PF: u3,
            padding: u29,
        }),
        ///  Layerx Constant Alpha Configuration Register
        L2CACR: mmio.Mmio(packed struct(u32) {
            ///  Constant Alpha
            CONSTA: u8,
            padding: u24,
        }),
        ///  Layerx Default Color Configuration Register
        L2DCCR: mmio.Mmio(packed struct(u32) {
            ///  Default Color Blue
            DCBLUE: u8,
            ///  Default Color Green
            DCGREEN: u8,
            ///  Default Color Red
            DCRED: u8,
            ///  Default Color Alpha
            DCALPHA: u8,
        }),
        ///  Layerx Blending Factors Configuration Register
        L2BFCR: mmio.Mmio(packed struct(u32) {
            ///  Blending Factor 2
            BF2: u3,
            reserved8: u5,
            ///  Blending Factor 1
            BF1: u3,
            padding: u21,
        }),
        reserved300: [8]u8,
        ///  Layerx Color Frame Buffer Address Register
        L2CFBAR: mmio.Mmio(packed struct(u32) {
            ///  Color Frame Buffer Start Address
            CFBADD: u32,
        }),
        ///  Layerx Color Frame Buffer Length Register
        L2CFBLR: mmio.Mmio(packed struct(u32) {
            ///  Color Frame Buffer Line Length
            CFBLL: u13,
            reserved16: u3,
            ///  Color Frame Buffer Pitch in bytes
            CFBP: u13,
            padding: u3,
        }),
        ///  Layerx ColorFrame Buffer Line Number Register
        L2CFBLNR: mmio.Mmio(packed struct(u32) {
            ///  Frame Buffer Line Number
            CFBLNBR: u11,
            padding: u21,
        }),
        reserved324: [12]u8,
        ///  Layerx CLUT Write Register
        L2CLUTWR: mmio.Mmio(packed struct(u32) {
            ///  Blue value
            BLUE: u8,
            ///  Green value
            GREEN: u8,
            ///  Red value
            RED: u8,
            ///  CLUT Address
            CLUTADD: u8,
        }),
    };

    ///  USB on the go high speed
    pub const OTG_HS_PWRCLK = extern struct {
        ///  Power and clock gating control register
        OTG_HS_PCGCR: mmio.Mmio(packed struct(u32) {
            ///  Stop PHY clock
            STPPCLK: u1,
            ///  Gate HCLK
            GATEHCLK: u1,
            reserved4: u2,
            ///  PHY suspended
            PHYSUSP: u1,
            padding: u27,
        }),
    };

    ///  USB on the go high speed
    pub const OTG_HS_DEVICE = extern struct {
        ///  OTG_HS device configuration register
        OTG_HS_DCFG: mmio.Mmio(packed struct(u32) {
            ///  Device speed
            DSPD: u2,
            ///  Nonzero-length status OUT handshake
            NZLSOHSK: u1,
            reserved4: u1,
            ///  Device address
            DAD: u7,
            ///  Periodic (micro)frame interval
            PFIVL: u2,
            reserved24: u11,
            ///  Periodic scheduling interval
            PERSCHIVL: u2,
            padding: u6,
        }),
        ///  OTG_HS device control register
        OTG_HS_DCTL: mmio.Mmio(packed struct(u32) {
            ///  Remote wakeup signaling
            RWUSIG: u1,
            ///  Soft disconnect
            SDIS: u1,
            ///  Global IN NAK status
            GINSTS: u1,
            ///  Global OUT NAK status
            GONSTS: u1,
            ///  Test control
            TCTL: u3,
            ///  Set global IN NAK
            SGINAK: u1,
            ///  Clear global IN NAK
            CGINAK: u1,
            ///  Set global OUT NAK
            SGONAK: u1,
            ///  Clear global OUT NAK
            CGONAK: u1,
            ///  Power-on programming done
            POPRGDNE: u1,
            padding: u20,
        }),
        ///  OTG_HS device status register
        OTG_HS_DSTS: mmio.Mmio(packed struct(u32) {
            ///  Suspend status
            SUSPSTS: u1,
            ///  Enumerated speed
            ENUMSPD: u2,
            ///  Erratic error
            EERR: u1,
            reserved8: u4,
            ///  Frame number of the received SOF
            FNSOF: u14,
            padding: u10,
        }),
        reserved16: [4]u8,
        ///  OTG_HS device IN endpoint common interrupt mask register
        OTG_HS_DIEPMSK: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt mask
            XFRCM: u1,
            ///  Endpoint disabled interrupt mask
            EPDM: u1,
            reserved3: u1,
            ///  Timeout condition mask (nonisochronous endpoints)
            TOM: u1,
            ///  IN token received when TxFIFO empty mask
            ITTXFEMSK: u1,
            ///  IN token received with EP mismatch mask
            INEPNMM: u1,
            ///  IN endpoint NAK effective mask
            INEPNEM: u1,
            reserved8: u1,
            ///  FIFO underrun mask
            TXFURM: u1,
            ///  BNA interrupt mask
            BIM: u1,
            padding: u22,
        }),
        ///  OTG_HS device OUT endpoint common interrupt mask register
        OTG_HS_DOEPMSK: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt mask
            XFRCM: u1,
            ///  Endpoint disabled interrupt mask
            EPDM: u1,
            reserved3: u1,
            ///  SETUP phase done mask
            STUPM: u1,
            ///  OUT token received when endpoint disabled mask
            OTEPDM: u1,
            reserved6: u1,
            ///  Back-to-back SETUP packets received mask
            B2BSTUP: u1,
            reserved8: u1,
            ///  OUT packet error mask
            OPEM: u1,
            ///  BNA interrupt mask
            BOIM: u1,
            padding: u22,
        }),
        ///  OTG_HS device all endpoints interrupt register
        OTG_HS_DAINT: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint interrupt bits
            IEPINT: u16,
            ///  OUT endpoint interrupt bits
            OEPINT: u16,
        }),
        ///  OTG_HS all endpoints interrupt mask register
        OTG_HS_DAINTMSK: mmio.Mmio(packed struct(u32) {
            ///  IN EP interrupt mask bits
            IEPM: u16,
            ///  OUT EP interrupt mask bits
            OEPM: u16,
        }),
        reserved40: [8]u8,
        ///  OTG_HS device VBUS discharge time register
        OTG_HS_DVBUSDIS: mmio.Mmio(packed struct(u32) {
            ///  Device VBUS discharge time
            VBUSDT: u16,
            padding: u16,
        }),
        ///  OTG_HS device VBUS pulsing time register
        OTG_HS_DVBUSPULSE: mmio.Mmio(packed struct(u32) {
            ///  Device VBUS pulsing time
            DVBUSP: u12,
            padding: u20,
        }),
        ///  OTG_HS Device threshold control register
        OTG_HS_DTHRCTL: mmio.Mmio(packed struct(u32) {
            ///  Nonisochronous IN endpoints threshold enable
            NONISOTHREN: u1,
            ///  ISO IN endpoint threshold enable
            ISOTHREN: u1,
            ///  Transmit threshold length
            TXTHRLEN: u9,
            reserved16: u5,
            ///  Receive threshold enable
            RXTHREN: u1,
            ///  Receive threshold length
            RXTHRLEN: u9,
            reserved27: u1,
            ///  Arbiter parking enable
            ARPEN: u1,
            padding: u4,
        }),
        ///  OTG_HS device IN endpoint FIFO empty interrupt mask register
        OTG_HS_DIEPEMPMSK: mmio.Mmio(packed struct(u32) {
            ///  IN EP Tx FIFO empty interrupt mask bits
            INEPTXFEM: u16,
            padding: u16,
        }),
        ///  OTG_HS device each endpoint interrupt register
        OTG_HS_DEACHINT: mmio.Mmio(packed struct(u32) {
            reserved1: u1,
            ///  IN endpoint 1interrupt bit
            IEP1INT: u1,
            reserved17: u15,
            ///  OUT endpoint 1 interrupt bit
            OEP1INT: u1,
            padding: u14,
        }),
        ///  OTG_HS device each endpoint interrupt register mask
        OTG_HS_DEACHINTMSK: mmio.Mmio(packed struct(u32) {
            reserved1: u1,
            ///  IN Endpoint 1 interrupt mask bit
            IEP1INTM: u1,
            reserved17: u15,
            ///  OUT Endpoint 1 interrupt mask bit
            OEP1INTM: u1,
            padding: u14,
        }),
        ///  OTG_HS device each in endpoint-1 interrupt register
        OTG_HS_DIEPEACHMSK1: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt mask
            XFRCM: u1,
            ///  Endpoint disabled interrupt mask
            EPDM: u1,
            reserved3: u1,
            ///  Timeout condition mask (nonisochronous endpoints)
            TOM: u1,
            ///  IN token received when TxFIFO empty mask
            ITTXFEMSK: u1,
            ///  IN token received with EP mismatch mask
            INEPNMM: u1,
            ///  IN endpoint NAK effective mask
            INEPNEM: u1,
            reserved8: u1,
            ///  FIFO underrun mask
            TXFURM: u1,
            ///  BNA interrupt mask
            BIM: u1,
            reserved13: u3,
            ///  NAK interrupt mask
            NAKM: u1,
            padding: u18,
        }),
        reserved128: [60]u8,
        ///  OTG_HS device each OUT endpoint-1 interrupt register
        OTG_HS_DOEPEACHMSK1: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt mask
            XFRCM: u1,
            ///  Endpoint disabled interrupt mask
            EPDM: u1,
            reserved3: u1,
            ///  Timeout condition mask
            TOM: u1,
            ///  IN token received when TxFIFO empty mask
            ITTXFEMSK: u1,
            ///  IN token received with EP mismatch mask
            INEPNMM: u1,
            ///  IN endpoint NAK effective mask
            INEPNEM: u1,
            reserved8: u1,
            ///  OUT packet error mask
            TXFURM: u1,
            ///  BNA interrupt mask
            BIM: u1,
            reserved12: u2,
            ///  Bubble error interrupt mask
            BERRM: u1,
            ///  NAK interrupt mask
            NAKM: u1,
            ///  NYET interrupt mask
            NYETM: u1,
            padding: u17,
        }),
        reserved256: [124]u8,
        ///  OTG device endpoint-0 control register
        OTG_HS_DIEPCTL0: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            reserved15: u4,
            ///  USB active endpoint
            USBAEP: u1,
            ///  Even/odd frame
            EONUM_DPID: u1,
            ///  NAK status
            NAKSTS: u1,
            ///  Endpoint type
            EPTYP: u2,
            reserved21: u1,
            ///  STALL handshake
            Stall: u1,
            ///  TxFIFO number
            TXFNUM: u4,
            ///  Clear NAK
            CNAK: u1,
            ///  Set NAK
            SNAK: u1,
            ///  Set DATA0 PID
            SD0PID_SEVNFRM: u1,
            ///  Set odd frame
            SODDFRM: u1,
            ///  Endpoint disable
            EPDIS: u1,
            ///  Endpoint enable
            EPENA: u1,
        }),
        reserved264: [4]u8,
        ///  OTG device endpoint-0 interrupt register
        OTG_HS_DIEPINT0: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt
            XFRC: u1,
            ///  Endpoint disabled interrupt
            EPDISD: u1,
            reserved3: u1,
            ///  Timeout condition
            TOC: u1,
            ///  IN token received when TxFIFO is empty
            ITTXFE: u1,
            reserved6: u1,
            ///  IN endpoint NAK effective
            INEPNE: u1,
            ///  Transmit FIFO empty
            TXFE: u1,
            ///  Transmit Fifo Underrun
            TXFIFOUDRN: u1,
            ///  Buffer not available interrupt
            BNA: u1,
            reserved11: u1,
            ///  Packet dropped status
            PKTDRPSTS: u1,
            ///  Babble error interrupt
            BERR: u1,
            ///  NAK interrupt
            NAK: u1,
            padding: u18,
        }),
        reserved272: [4]u8,
        ///  OTG_HS device IN endpoint 0 transfer size register
        OTG_HS_DIEPTSIZ0: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u7,
            reserved19: u12,
            ///  Packet count
            PKTCNT: u2,
            padding: u11,
        }),
        ///  OTG_HS device endpoint-1 DMA address register
        OTG_HS_DIEPDMA1: mmio.Mmio(packed struct(u32) {
            ///  DMA address
            DMAADDR: u32,
        }),
        ///  OTG_HS device IN endpoint transmit FIFO status register
        OTG_HS_DTXFSTS0: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint TxFIFO space avail
            INEPTFSAV: u16,
            padding: u16,
        }),
        reserved288: [4]u8,
        ///  OTG device endpoint-1 control register
        OTG_HS_DIEPCTL1: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            reserved15: u4,
            ///  USB active endpoint
            USBAEP: u1,
            ///  Even/odd frame
            EONUM_DPID: u1,
            ///  NAK status
            NAKSTS: u1,
            ///  Endpoint type
            EPTYP: u2,
            reserved21: u1,
            ///  STALL handshake
            Stall: u1,
            ///  TxFIFO number
            TXFNUM: u4,
            ///  Clear NAK
            CNAK: u1,
            ///  Set NAK
            SNAK: u1,
            ///  Set DATA0 PID
            SD0PID_SEVNFRM: u1,
            ///  Set odd frame
            SODDFRM: u1,
            ///  Endpoint disable
            EPDIS: u1,
            ///  Endpoint enable
            EPENA: u1,
        }),
        reserved296: [4]u8,
        ///  OTG device endpoint-1 interrupt register
        OTG_HS_DIEPINT1: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt
            XFRC: u1,
            ///  Endpoint disabled interrupt
            EPDISD: u1,
            reserved3: u1,
            ///  Timeout condition
            TOC: u1,
            ///  IN token received when TxFIFO is empty
            ITTXFE: u1,
            reserved6: u1,
            ///  IN endpoint NAK effective
            INEPNE: u1,
            ///  Transmit FIFO empty
            TXFE: u1,
            ///  Transmit Fifo Underrun
            TXFIFOUDRN: u1,
            ///  Buffer not available interrupt
            BNA: u1,
            reserved11: u1,
            ///  Packet dropped status
            PKTDRPSTS: u1,
            ///  Babble error interrupt
            BERR: u1,
            ///  NAK interrupt
            NAK: u1,
            padding: u18,
        }),
        reserved304: [4]u8,
        ///  OTG_HS device endpoint transfer size register
        OTG_HS_DIEPTSIZ1: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Multi count
            MCNT: u2,
            padding: u1,
        }),
        ///  OTG_HS device endpoint-2 DMA address register
        OTG_HS_DIEPDMA2: mmio.Mmio(packed struct(u32) {
            ///  DMA address
            DMAADDR: u32,
        }),
        ///  OTG_HS device IN endpoint transmit FIFO status register
        OTG_HS_DTXFSTS1: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint TxFIFO space avail
            INEPTFSAV: u16,
            padding: u16,
        }),
        reserved320: [4]u8,
        ///  OTG device endpoint-2 control register
        OTG_HS_DIEPCTL2: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            reserved15: u4,
            ///  USB active endpoint
            USBAEP: u1,
            ///  Even/odd frame
            EONUM_DPID: u1,
            ///  NAK status
            NAKSTS: u1,
            ///  Endpoint type
            EPTYP: u2,
            reserved21: u1,
            ///  STALL handshake
            Stall: u1,
            ///  TxFIFO number
            TXFNUM: u4,
            ///  Clear NAK
            CNAK: u1,
            ///  Set NAK
            SNAK: u1,
            ///  Set DATA0 PID
            SD0PID_SEVNFRM: u1,
            ///  Set odd frame
            SODDFRM: u1,
            ///  Endpoint disable
            EPDIS: u1,
            ///  Endpoint enable
            EPENA: u1,
        }),
        reserved328: [4]u8,
        ///  OTG device endpoint-2 interrupt register
        OTG_HS_DIEPINT2: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt
            XFRC: u1,
            ///  Endpoint disabled interrupt
            EPDISD: u1,
            reserved3: u1,
            ///  Timeout condition
            TOC: u1,
            ///  IN token received when TxFIFO is empty
            ITTXFE: u1,
            reserved6: u1,
            ///  IN endpoint NAK effective
            INEPNE: u1,
            ///  Transmit FIFO empty
            TXFE: u1,
            ///  Transmit Fifo Underrun
            TXFIFOUDRN: u1,
            ///  Buffer not available interrupt
            BNA: u1,
            reserved11: u1,
            ///  Packet dropped status
            PKTDRPSTS: u1,
            ///  Babble error interrupt
            BERR: u1,
            ///  NAK interrupt
            NAK: u1,
            padding: u18,
        }),
        reserved336: [4]u8,
        ///  OTG_HS device endpoint transfer size register
        OTG_HS_DIEPTSIZ2: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Multi count
            MCNT: u2,
            padding: u1,
        }),
        ///  OTG_HS device endpoint-3 DMA address register
        OTG_HS_DIEPDMA3: mmio.Mmio(packed struct(u32) {
            ///  DMA address
            DMAADDR: u32,
        }),
        ///  OTG_HS device IN endpoint transmit FIFO status register
        OTG_HS_DTXFSTS2: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint TxFIFO space avail
            INEPTFSAV: u16,
            padding: u16,
        }),
        reserved352: [4]u8,
        ///  OTG device endpoint-3 control register
        OTG_HS_DIEPCTL3: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            reserved15: u4,
            ///  USB active endpoint
            USBAEP: u1,
            ///  Even/odd frame
            EONUM_DPID: u1,
            ///  NAK status
            NAKSTS: u1,
            ///  Endpoint type
            EPTYP: u2,
            reserved21: u1,
            ///  STALL handshake
            Stall: u1,
            ///  TxFIFO number
            TXFNUM: u4,
            ///  Clear NAK
            CNAK: u1,
            ///  Set NAK
            SNAK: u1,
            ///  Set DATA0 PID
            SD0PID_SEVNFRM: u1,
            ///  Set odd frame
            SODDFRM: u1,
            ///  Endpoint disable
            EPDIS: u1,
            ///  Endpoint enable
            EPENA: u1,
        }),
        reserved360: [4]u8,
        ///  OTG device endpoint-3 interrupt register
        OTG_HS_DIEPINT3: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt
            XFRC: u1,
            ///  Endpoint disabled interrupt
            EPDISD: u1,
            reserved3: u1,
            ///  Timeout condition
            TOC: u1,
            ///  IN token received when TxFIFO is empty
            ITTXFE: u1,
            reserved6: u1,
            ///  IN endpoint NAK effective
            INEPNE: u1,
            ///  Transmit FIFO empty
            TXFE: u1,
            ///  Transmit Fifo Underrun
            TXFIFOUDRN: u1,
            ///  Buffer not available interrupt
            BNA: u1,
            reserved11: u1,
            ///  Packet dropped status
            PKTDRPSTS: u1,
            ///  Babble error interrupt
            BERR: u1,
            ///  NAK interrupt
            NAK: u1,
            padding: u18,
        }),
        reserved368: [4]u8,
        ///  OTG_HS device endpoint transfer size register
        OTG_HS_DIEPTSIZ3: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Multi count
            MCNT: u2,
            padding: u1,
        }),
        ///  OTG_HS device endpoint-4 DMA address register
        OTG_HS_DIEPDMA4: mmio.Mmio(packed struct(u32) {
            ///  DMA address
            DMAADDR: u32,
        }),
        ///  OTG_HS device IN endpoint transmit FIFO status register
        OTG_HS_DTXFSTS3: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint TxFIFO space avail
            INEPTFSAV: u16,
            padding: u16,
        }),
        reserved384: [4]u8,
        ///  OTG device endpoint-4 control register
        OTG_HS_DIEPCTL4: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            reserved15: u4,
            ///  USB active endpoint
            USBAEP: u1,
            ///  Even/odd frame
            EONUM_DPID: u1,
            ///  NAK status
            NAKSTS: u1,
            ///  Endpoint type
            EPTYP: u2,
            reserved21: u1,
            ///  STALL handshake
            Stall: u1,
            ///  TxFIFO number
            TXFNUM: u4,
            ///  Clear NAK
            CNAK: u1,
            ///  Set NAK
            SNAK: u1,
            ///  Set DATA0 PID
            SD0PID_SEVNFRM: u1,
            ///  Set odd frame
            SODDFRM: u1,
            ///  Endpoint disable
            EPDIS: u1,
            ///  Endpoint enable
            EPENA: u1,
        }),
        reserved392: [4]u8,
        ///  OTG device endpoint-4 interrupt register
        OTG_HS_DIEPINT4: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt
            XFRC: u1,
            ///  Endpoint disabled interrupt
            EPDISD: u1,
            reserved3: u1,
            ///  Timeout condition
            TOC: u1,
            ///  IN token received when TxFIFO is empty
            ITTXFE: u1,
            reserved6: u1,
            ///  IN endpoint NAK effective
            INEPNE: u1,
            ///  Transmit FIFO empty
            TXFE: u1,
            ///  Transmit Fifo Underrun
            TXFIFOUDRN: u1,
            ///  Buffer not available interrupt
            BNA: u1,
            reserved11: u1,
            ///  Packet dropped status
            PKTDRPSTS: u1,
            ///  Babble error interrupt
            BERR: u1,
            ///  NAK interrupt
            NAK: u1,
            padding: u18,
        }),
        reserved400: [4]u8,
        ///  OTG_HS device endpoint transfer size register
        OTG_HS_DIEPTSIZ4: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Multi count
            MCNT: u2,
            padding: u1,
        }),
        ///  OTG_HS device endpoint-5 DMA address register
        OTG_HS_DIEPDMA5: mmio.Mmio(packed struct(u32) {
            ///  DMA address
            DMAADDR: u32,
        }),
        ///  OTG_HS device IN endpoint transmit FIFO status register
        OTG_HS_DTXFSTS4: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint TxFIFO space avail
            INEPTFSAV: u16,
            padding: u16,
        }),
        reserved416: [4]u8,
        ///  OTG device endpoint-5 control register
        OTG_HS_DIEPCTL5: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            reserved15: u4,
            ///  USB active endpoint
            USBAEP: u1,
            ///  Even/odd frame
            EONUM_DPID: u1,
            ///  NAK status
            NAKSTS: u1,
            ///  Endpoint type
            EPTYP: u2,
            reserved21: u1,
            ///  STALL handshake
            Stall: u1,
            ///  TxFIFO number
            TXFNUM: u4,
            ///  Clear NAK
            CNAK: u1,
            ///  Set NAK
            SNAK: u1,
            ///  Set DATA0 PID
            SD0PID_SEVNFRM: u1,
            ///  Set odd frame
            SODDFRM: u1,
            ///  Endpoint disable
            EPDIS: u1,
            ///  Endpoint enable
            EPENA: u1,
        }),
        reserved424: [4]u8,
        ///  OTG device endpoint-5 interrupt register
        OTG_HS_DIEPINT5: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt
            XFRC: u1,
            ///  Endpoint disabled interrupt
            EPDISD: u1,
            reserved3: u1,
            ///  Timeout condition
            TOC: u1,
            ///  IN token received when TxFIFO is empty
            ITTXFE: u1,
            reserved6: u1,
            ///  IN endpoint NAK effective
            INEPNE: u1,
            ///  Transmit FIFO empty
            TXFE: u1,
            ///  Transmit Fifo Underrun
            TXFIFOUDRN: u1,
            ///  Buffer not available interrupt
            BNA: u1,
            reserved11: u1,
            ///  Packet dropped status
            PKTDRPSTS: u1,
            ///  Babble error interrupt
            BERR: u1,
            ///  NAK interrupt
            NAK: u1,
            padding: u18,
        }),
        reserved432: [4]u8,
        ///  OTG_HS device endpoint transfer size register
        OTG_HS_DIEPTSIZ5: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Multi count
            MCNT: u2,
            padding: u1,
        }),
        reserved440: [4]u8,
        ///  OTG_HS device IN endpoint transmit FIFO status register
        OTG_HS_DTXFSTS5: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint TxFIFO space avail
            INEPTFSAV: u16,
            padding: u16,
        }),
        reserved448: [4]u8,
        ///  OTG device endpoint-6 control register
        OTG_HS_DIEPCTL6: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            reserved15: u4,
            ///  USB active endpoint
            USBAEP: u1,
            ///  Even/odd frame
            EONUM_DPID: u1,
            ///  NAK status
            NAKSTS: u1,
            ///  Endpoint type
            EPTYP: u2,
            reserved21: u1,
            ///  STALL handshake
            Stall: u1,
            ///  TxFIFO number
            TXFNUM: u4,
            ///  Clear NAK
            CNAK: u1,
            ///  Set NAK
            SNAK: u1,
            ///  Set DATA0 PID
            SD0PID_SEVNFRM: u1,
            ///  Set odd frame
            SODDFRM: u1,
            ///  Endpoint disable
            EPDIS: u1,
            ///  Endpoint enable
            EPENA: u1,
        }),
        reserved456: [4]u8,
        ///  OTG device endpoint-6 interrupt register
        OTG_HS_DIEPINT6: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt
            XFRC: u1,
            ///  Endpoint disabled interrupt
            EPDISD: u1,
            reserved3: u1,
            ///  Timeout condition
            TOC: u1,
            ///  IN token received when TxFIFO is empty
            ITTXFE: u1,
            reserved6: u1,
            ///  IN endpoint NAK effective
            INEPNE: u1,
            ///  Transmit FIFO empty
            TXFE: u1,
            ///  Transmit Fifo Underrun
            TXFIFOUDRN: u1,
            ///  Buffer not available interrupt
            BNA: u1,
            reserved11: u1,
            ///  Packet dropped status
            PKTDRPSTS: u1,
            ///  Babble error interrupt
            BERR: u1,
            ///  NAK interrupt
            NAK: u1,
            padding: u18,
        }),
        reserved480: [20]u8,
        ///  OTG device endpoint-7 control register
        OTG_HS_DIEPCTL7: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            reserved15: u4,
            ///  USB active endpoint
            USBAEP: u1,
            ///  Even/odd frame
            EONUM_DPID: u1,
            ///  NAK status
            NAKSTS: u1,
            ///  Endpoint type
            EPTYP: u2,
            reserved21: u1,
            ///  STALL handshake
            Stall: u1,
            ///  TxFIFO number
            TXFNUM: u4,
            ///  Clear NAK
            CNAK: u1,
            ///  Set NAK
            SNAK: u1,
            ///  Set DATA0 PID
            SD0PID_SEVNFRM: u1,
            ///  Set odd frame
            SODDFRM: u1,
            ///  Endpoint disable
            EPDIS: u1,
            ///  Endpoint enable
            EPENA: u1,
        }),
        reserved488: [4]u8,
        ///  OTG device endpoint-7 interrupt register
        OTG_HS_DIEPINT7: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt
            XFRC: u1,
            ///  Endpoint disabled interrupt
            EPDISD: u1,
            reserved3: u1,
            ///  Timeout condition
            TOC: u1,
            ///  IN token received when TxFIFO is empty
            ITTXFE: u1,
            reserved6: u1,
            ///  IN endpoint NAK effective
            INEPNE: u1,
            ///  Transmit FIFO empty
            TXFE: u1,
            ///  Transmit Fifo Underrun
            TXFIFOUDRN: u1,
            ///  Buffer not available interrupt
            BNA: u1,
            reserved11: u1,
            ///  Packet dropped status
            PKTDRPSTS: u1,
            ///  Babble error interrupt
            BERR: u1,
            ///  NAK interrupt
            NAK: u1,
            padding: u18,
        }),
        reserved768: [276]u8,
        ///  OTG_HS device control OUT endpoint 0 control register
        OTG_HS_DOEPCTL0: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u2,
            reserved15: u13,
            ///  USB active endpoint
            USBAEP: u1,
            reserved17: u1,
            ///  NAK status
            NAKSTS: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Snoop mode
            SNPM: u1,
            ///  STALL handshake
            Stall: u1,
            reserved26: u4,
            ///  Clear NAK
            CNAK: u1,
            ///  Set NAK
            SNAK: u1,
            reserved30: u2,
            ///  Endpoint disable
            EPDIS: u1,
            ///  Endpoint enable
            EPENA: u1,
        }),
        reserved776: [4]u8,
        ///  OTG_HS device endpoint-0 interrupt register
        OTG_HS_DOEPINT0: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt
            XFRC: u1,
            ///  Endpoint disabled interrupt
            EPDISD: u1,
            reserved3: u1,
            ///  SETUP phase done
            STUP: u1,
            ///  OUT token received when endpoint disabled
            OTEPDIS: u1,
            reserved6: u1,
            ///  Back-to-back SETUP packets received
            B2BSTUP: u1,
            reserved14: u7,
            ///  NYET interrupt
            NYET: u1,
            padding: u17,
        }),
        reserved784: [4]u8,
        ///  OTG_HS device endpoint-1 transfer size register
        OTG_HS_DOEPTSIZ0: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u7,
            reserved19: u12,
            ///  Packet count
            PKTCNT: u1,
            reserved29: u9,
            ///  SETUP packet count
            STUPCNT: u2,
            padding: u1,
        }),
        reserved800: [12]u8,
        ///  OTG device endpoint-1 control register
        OTG_HS_DOEPCTL1: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            reserved15: u4,
            ///  USB active endpoint
            USBAEP: u1,
            ///  Even odd frame/Endpoint data PID
            EONUM_DPID: u1,
            ///  NAK status
            NAKSTS: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Snoop mode
            SNPM: u1,
            ///  STALL handshake
            Stall: u1,
            reserved26: u4,
            ///  Clear NAK
            CNAK: u1,
            ///  Set NAK
            SNAK: u1,
            ///  Set DATA0 PID/Set even frame
            SD0PID_SEVNFRM: u1,
            ///  Set odd frame
            SODDFRM: u1,
            ///  Endpoint disable
            EPDIS: u1,
            ///  Endpoint enable
            EPENA: u1,
        }),
        reserved808: [4]u8,
        ///  OTG_HS device endpoint-1 interrupt register
        OTG_HS_DOEPINT1: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt
            XFRC: u1,
            ///  Endpoint disabled interrupt
            EPDISD: u1,
            reserved3: u1,
            ///  SETUP phase done
            STUP: u1,
            ///  OUT token received when endpoint disabled
            OTEPDIS: u1,
            reserved6: u1,
            ///  Back-to-back SETUP packets received
            B2BSTUP: u1,
            reserved14: u7,
            ///  NYET interrupt
            NYET: u1,
            padding: u17,
        }),
        reserved816: [4]u8,
        ///  OTG_HS device endpoint-2 transfer size register
        OTG_HS_DOEPTSIZ1: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Received data PID/SETUP packet count
            RXDPID_STUPCNT: u2,
            padding: u1,
        }),
        reserved832: [12]u8,
        ///  OTG device endpoint-2 control register
        OTG_HS_DOEPCTL2: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            reserved15: u4,
            ///  USB active endpoint
            USBAEP: u1,
            ///  Even odd frame/Endpoint data PID
            EONUM_DPID: u1,
            ///  NAK status
            NAKSTS: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Snoop mode
            SNPM: u1,
            ///  STALL handshake
            Stall: u1,
            reserved26: u4,
            ///  Clear NAK
            CNAK: u1,
            ///  Set NAK
            SNAK: u1,
            ///  Set DATA0 PID/Set even frame
            SD0PID_SEVNFRM: u1,
            ///  Set odd frame
            SODDFRM: u1,
            ///  Endpoint disable
            EPDIS: u1,
            ///  Endpoint enable
            EPENA: u1,
        }),
        reserved840: [4]u8,
        ///  OTG_HS device endpoint-2 interrupt register
        OTG_HS_DOEPINT2: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt
            XFRC: u1,
            ///  Endpoint disabled interrupt
            EPDISD: u1,
            reserved3: u1,
            ///  SETUP phase done
            STUP: u1,
            ///  OUT token received when endpoint disabled
            OTEPDIS: u1,
            reserved6: u1,
            ///  Back-to-back SETUP packets received
            B2BSTUP: u1,
            reserved14: u7,
            ///  NYET interrupt
            NYET: u1,
            padding: u17,
        }),
        reserved848: [4]u8,
        ///  OTG_HS device endpoint-3 transfer size register
        OTG_HS_DOEPTSIZ2: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Received data PID/SETUP packet count
            RXDPID_STUPCNT: u2,
            padding: u1,
        }),
        reserved864: [12]u8,
        ///  OTG device endpoint-3 control register
        OTG_HS_DOEPCTL3: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            reserved15: u4,
            ///  USB active endpoint
            USBAEP: u1,
            ///  Even odd frame/Endpoint data PID
            EONUM_DPID: u1,
            ///  NAK status
            NAKSTS: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Snoop mode
            SNPM: u1,
            ///  STALL handshake
            Stall: u1,
            reserved26: u4,
            ///  Clear NAK
            CNAK: u1,
            ///  Set NAK
            SNAK: u1,
            ///  Set DATA0 PID/Set even frame
            SD0PID_SEVNFRM: u1,
            ///  Set odd frame
            SODDFRM: u1,
            ///  Endpoint disable
            EPDIS: u1,
            ///  Endpoint enable
            EPENA: u1,
        }),
        reserved872: [4]u8,
        ///  OTG_HS device endpoint-3 interrupt register
        OTG_HS_DOEPINT3: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt
            XFRC: u1,
            ///  Endpoint disabled interrupt
            EPDISD: u1,
            reserved3: u1,
            ///  SETUP phase done
            STUP: u1,
            ///  OUT token received when endpoint disabled
            OTEPDIS: u1,
            reserved6: u1,
            ///  Back-to-back SETUP packets received
            B2BSTUP: u1,
            reserved14: u7,
            ///  NYET interrupt
            NYET: u1,
            padding: u17,
        }),
        reserved880: [4]u8,
        ///  OTG_HS device endpoint-4 transfer size register
        OTG_HS_DOEPTSIZ3: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Received data PID/SETUP packet count
            RXDPID_STUPCNT: u2,
            padding: u1,
        }),
        reserved904: [20]u8,
        ///  OTG_HS device endpoint-4 interrupt register
        OTG_HS_DOEPINT4: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt
            XFRC: u1,
            ///  Endpoint disabled interrupt
            EPDISD: u1,
            reserved3: u1,
            ///  SETUP phase done
            STUP: u1,
            ///  OUT token received when endpoint disabled
            OTEPDIS: u1,
            reserved6: u1,
            ///  Back-to-back SETUP packets received
            B2BSTUP: u1,
            reserved14: u7,
            ///  NYET interrupt
            NYET: u1,
            padding: u17,
        }),
        reserved912: [4]u8,
        ///  OTG_HS device endpoint-5 transfer size register
        OTG_HS_DOEPTSIZ4: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Received data PID/SETUP packet count
            RXDPID_STUPCNT: u2,
            padding: u1,
        }),
        reserved936: [20]u8,
        ///  OTG_HS device endpoint-5 interrupt register
        OTG_HS_DOEPINT5: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt
            XFRC: u1,
            ///  Endpoint disabled interrupt
            EPDISD: u1,
            reserved3: u1,
            ///  SETUP phase done
            STUP: u1,
            ///  OUT token received when endpoint disabled
            OTEPDIS: u1,
            reserved6: u1,
            ///  Back-to-back SETUP packets received
            B2BSTUP: u1,
            reserved14: u7,
            ///  NYET interrupt
            NYET: u1,
            padding: u17,
        }),
        reserved968: [28]u8,
        ///  OTG_HS device endpoint-6 interrupt register
        OTG_HS_DOEPINT6: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt
            XFRC: u1,
            ///  Endpoint disabled interrupt
            EPDISD: u1,
            reserved3: u1,
            ///  SETUP phase done
            STUP: u1,
            ///  OUT token received when endpoint disabled
            OTEPDIS: u1,
            reserved6: u1,
            ///  Back-to-back SETUP packets received
            B2BSTUP: u1,
            reserved14: u7,
            ///  NYET interrupt
            NYET: u1,
            padding: u17,
        }),
        reserved1000: [28]u8,
        ///  OTG_HS device endpoint-7 interrupt register
        OTG_HS_DOEPINT7: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt
            XFRC: u1,
            ///  Endpoint disabled interrupt
            EPDISD: u1,
            reserved3: u1,
            ///  SETUP phase done
            STUP: u1,
            ///  OUT token received when endpoint disabled
            OTEPDIS: u1,
            reserved6: u1,
            ///  Back-to-back SETUP packets received
            B2BSTUP: u1,
            reserved14: u7,
            ///  NYET interrupt
            NYET: u1,
            padding: u17,
        }),
    };

    ///  USB on the go high speed
    pub const OTG_HS_HOST = extern struct {
        ///  OTG_HS host configuration register
        OTG_HS_HCFG: mmio.Mmio(packed struct(u32) {
            ///  FS/LS PHY clock select
            FSLSPCS: u2,
            ///  FS- and LS-only support
            FSLSS: u1,
            padding: u29,
        }),
        ///  OTG_HS Host frame interval register
        OTG_HS_HFIR: mmio.Mmio(packed struct(u32) {
            ///  Frame interval
            FRIVL: u16,
            padding: u16,
        }),
        ///  OTG_HS host frame number/frame time remaining register
        OTG_HS_HFNUM: mmio.Mmio(packed struct(u32) {
            ///  Frame number
            FRNUM: u16,
            ///  Frame time remaining
            FTREM: u16,
        }),
        reserved16: [4]u8,
        ///  OTG_HS_Host periodic transmit FIFO/queue status register
        OTG_HS_HPTXSTS: mmio.Mmio(packed struct(u32) {
            ///  Periodic transmit data FIFO space available
            PTXFSAVL: u16,
            ///  Periodic transmit request queue space available
            PTXQSAV: u8,
            ///  Top of the periodic transmit request queue
            PTXQTOP: u8,
        }),
        ///  OTG_HS Host all channels interrupt register
        OTG_HS_HAINT: mmio.Mmio(packed struct(u32) {
            ///  Channel interrupts
            HAINT: u16,
            padding: u16,
        }),
        ///  OTG_HS host all channels interrupt mask register
        OTG_HS_HAINTMSK: mmio.Mmio(packed struct(u32) {
            ///  Channel interrupt mask
            HAINTM: u16,
            padding: u16,
        }),
        reserved64: [36]u8,
        ///  OTG_HS host port control and status register
        OTG_HS_HPRT: mmio.Mmio(packed struct(u32) {
            ///  Port connect status
            PCSTS: u1,
            ///  Port connect detected
            PCDET: u1,
            ///  Port enable
            PENA: u1,
            ///  Port enable/disable change
            PENCHNG: u1,
            ///  Port overcurrent active
            POCA: u1,
            ///  Port overcurrent change
            POCCHNG: u1,
            ///  Port resume
            PRES: u1,
            ///  Port suspend
            PSUSP: u1,
            ///  Port reset
            PRST: u1,
            reserved10: u1,
            ///  Port line status
            PLSTS: u2,
            ///  Port power
            PPWR: u1,
            ///  Port test control
            PTCTL: u4,
            ///  Port speed
            PSPD: u2,
            padding: u13,
        }),
        reserved256: [188]u8,
        ///  OTG_HS host channel-0 characteristics register
        OTG_HS_HCCHAR0: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            ///  Endpoint number
            EPNUM: u4,
            ///  Endpoint direction
            EPDIR: u1,
            reserved17: u1,
            ///  Low-speed device
            LSDEV: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Multi Count (MC) / Error Count (EC)
            MC: u2,
            ///  Device address
            DAD: u7,
            ///  Odd frame
            ODDFRM: u1,
            ///  Channel disable
            CHDIS: u1,
            ///  Channel enable
            CHENA: u1,
        }),
        ///  OTG_HS host channel-0 split control register
        OTG_HS_HCSPLT0: mmio.Mmio(packed struct(u32) {
            ///  Port address
            PRTADDR: u7,
            ///  Hub address
            HUBADDR: u7,
            ///  XACTPOS
            XACTPOS: u2,
            ///  Do complete split
            COMPLSPLT: u1,
            reserved31: u14,
            ///  Split enable
            SPLITEN: u1,
        }),
        ///  OTG_HS host channel-11 interrupt register
        OTG_HS_HCINT0: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed
            XFRC: u1,
            ///  Channel halted
            CHH: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt
            STALL: u1,
            ///  NAK response received interrupt
            NAK: u1,
            ///  ACK response received/transmitted interrupt
            ACK: u1,
            ///  Response received interrupt
            NYET: u1,
            ///  Transaction error
            TXERR: u1,
            ///  Babble error
            BBERR: u1,
            ///  Frame overrun
            FRMOR: u1,
            ///  Data toggle error
            DTERR: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-11 interrupt mask register
        OTG_HS_HCINTMSK0: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed mask
            XFRCM: u1,
            ///  Channel halted mask
            CHHM: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt mask
            STALLM: u1,
            ///  NAK response received interrupt mask
            NAKM: u1,
            ///  ACK response received/transmitted interrupt mask
            ACKM: u1,
            ///  response received interrupt mask
            NYET: u1,
            ///  Transaction error mask
            TXERRM: u1,
            ///  Babble error mask
            BBERRM: u1,
            ///  Frame overrun mask
            FRMORM: u1,
            ///  Data toggle error mask
            DTERRM: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-11 transfer size register
        OTG_HS_HCTSIZ0: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Data PID
            DPID: u2,
            padding: u1,
        }),
        ///  OTG_HS host channel-0 DMA address register
        OTG_HS_HCDMA0: mmio.Mmio(packed struct(u32) {
            ///  DMA address
            DMAADDR: u32,
        }),
        reserved288: [8]u8,
        ///  OTG_HS host channel-1 characteristics register
        OTG_HS_HCCHAR1: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            ///  Endpoint number
            EPNUM: u4,
            ///  Endpoint direction
            EPDIR: u1,
            reserved17: u1,
            ///  Low-speed device
            LSDEV: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Multi Count (MC) / Error Count (EC)
            MC: u2,
            ///  Device address
            DAD: u7,
            ///  Odd frame
            ODDFRM: u1,
            ///  Channel disable
            CHDIS: u1,
            ///  Channel enable
            CHENA: u1,
        }),
        ///  OTG_HS host channel-1 split control register
        OTG_HS_HCSPLT1: mmio.Mmio(packed struct(u32) {
            ///  Port address
            PRTADDR: u7,
            ///  Hub address
            HUBADDR: u7,
            ///  XACTPOS
            XACTPOS: u2,
            ///  Do complete split
            COMPLSPLT: u1,
            reserved31: u14,
            ///  Split enable
            SPLITEN: u1,
        }),
        ///  OTG_HS host channel-1 interrupt register
        OTG_HS_HCINT1: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed
            XFRC: u1,
            ///  Channel halted
            CHH: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt
            STALL: u1,
            ///  NAK response received interrupt
            NAK: u1,
            ///  ACK response received/transmitted interrupt
            ACK: u1,
            ///  Response received interrupt
            NYET: u1,
            ///  Transaction error
            TXERR: u1,
            ///  Babble error
            BBERR: u1,
            ///  Frame overrun
            FRMOR: u1,
            ///  Data toggle error
            DTERR: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-1 interrupt mask register
        OTG_HS_HCINTMSK1: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed mask
            XFRCM: u1,
            ///  Channel halted mask
            CHHM: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt mask
            STALLM: u1,
            ///  NAK response received interrupt mask
            NAKM: u1,
            ///  ACK response received/transmitted interrupt mask
            ACKM: u1,
            ///  response received interrupt mask
            NYET: u1,
            ///  Transaction error mask
            TXERRM: u1,
            ///  Babble error mask
            BBERRM: u1,
            ///  Frame overrun mask
            FRMORM: u1,
            ///  Data toggle error mask
            DTERRM: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-1 transfer size register
        OTG_HS_HCTSIZ1: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Data PID
            DPID: u2,
            padding: u1,
        }),
        ///  OTG_HS host channel-1 DMA address register
        OTG_HS_HCDMA1: mmio.Mmio(packed struct(u32) {
            ///  DMA address
            DMAADDR: u32,
        }),
        reserved320: [8]u8,
        ///  OTG_HS host channel-2 characteristics register
        OTG_HS_HCCHAR2: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            ///  Endpoint number
            EPNUM: u4,
            ///  Endpoint direction
            EPDIR: u1,
            reserved17: u1,
            ///  Low-speed device
            LSDEV: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Multi Count (MC) / Error Count (EC)
            MC: u2,
            ///  Device address
            DAD: u7,
            ///  Odd frame
            ODDFRM: u1,
            ///  Channel disable
            CHDIS: u1,
            ///  Channel enable
            CHENA: u1,
        }),
        ///  OTG_HS host channel-2 split control register
        OTG_HS_HCSPLT2: mmio.Mmio(packed struct(u32) {
            ///  Port address
            PRTADDR: u7,
            ///  Hub address
            HUBADDR: u7,
            ///  XACTPOS
            XACTPOS: u2,
            ///  Do complete split
            COMPLSPLT: u1,
            reserved31: u14,
            ///  Split enable
            SPLITEN: u1,
        }),
        ///  OTG_HS host channel-2 interrupt register
        OTG_HS_HCINT2: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed
            XFRC: u1,
            ///  Channel halted
            CHH: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt
            STALL: u1,
            ///  NAK response received interrupt
            NAK: u1,
            ///  ACK response received/transmitted interrupt
            ACK: u1,
            ///  Response received interrupt
            NYET: u1,
            ///  Transaction error
            TXERR: u1,
            ///  Babble error
            BBERR: u1,
            ///  Frame overrun
            FRMOR: u1,
            ///  Data toggle error
            DTERR: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-2 interrupt mask register
        OTG_HS_HCINTMSK2: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed mask
            XFRCM: u1,
            ///  Channel halted mask
            CHHM: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt mask
            STALLM: u1,
            ///  NAK response received interrupt mask
            NAKM: u1,
            ///  ACK response received/transmitted interrupt mask
            ACKM: u1,
            ///  response received interrupt mask
            NYET: u1,
            ///  Transaction error mask
            TXERRM: u1,
            ///  Babble error mask
            BBERRM: u1,
            ///  Frame overrun mask
            FRMORM: u1,
            ///  Data toggle error mask
            DTERRM: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-2 transfer size register
        OTG_HS_HCTSIZ2: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Data PID
            DPID: u2,
            padding: u1,
        }),
        ///  OTG_HS host channel-2 DMA address register
        OTG_HS_HCDMA2: mmio.Mmio(packed struct(u32) {
            ///  DMA address
            DMAADDR: u32,
        }),
        reserved352: [8]u8,
        ///  OTG_HS host channel-3 characteristics register
        OTG_HS_HCCHAR3: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            ///  Endpoint number
            EPNUM: u4,
            ///  Endpoint direction
            EPDIR: u1,
            reserved17: u1,
            ///  Low-speed device
            LSDEV: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Multi Count (MC) / Error Count (EC)
            MC: u2,
            ///  Device address
            DAD: u7,
            ///  Odd frame
            ODDFRM: u1,
            ///  Channel disable
            CHDIS: u1,
            ///  Channel enable
            CHENA: u1,
        }),
        ///  OTG_HS host channel-3 split control register
        OTG_HS_HCSPLT3: mmio.Mmio(packed struct(u32) {
            ///  Port address
            PRTADDR: u7,
            ///  Hub address
            HUBADDR: u7,
            ///  XACTPOS
            XACTPOS: u2,
            ///  Do complete split
            COMPLSPLT: u1,
            reserved31: u14,
            ///  Split enable
            SPLITEN: u1,
        }),
        ///  OTG_HS host channel-3 interrupt register
        OTG_HS_HCINT3: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed
            XFRC: u1,
            ///  Channel halted
            CHH: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt
            STALL: u1,
            ///  NAK response received interrupt
            NAK: u1,
            ///  ACK response received/transmitted interrupt
            ACK: u1,
            ///  Response received interrupt
            NYET: u1,
            ///  Transaction error
            TXERR: u1,
            ///  Babble error
            BBERR: u1,
            ///  Frame overrun
            FRMOR: u1,
            ///  Data toggle error
            DTERR: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-3 interrupt mask register
        OTG_HS_HCINTMSK3: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed mask
            XFRCM: u1,
            ///  Channel halted mask
            CHHM: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt mask
            STALLM: u1,
            ///  NAK response received interrupt mask
            NAKM: u1,
            ///  ACK response received/transmitted interrupt mask
            ACKM: u1,
            ///  response received interrupt mask
            NYET: u1,
            ///  Transaction error mask
            TXERRM: u1,
            ///  Babble error mask
            BBERRM: u1,
            ///  Frame overrun mask
            FRMORM: u1,
            ///  Data toggle error mask
            DTERRM: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-3 transfer size register
        OTG_HS_HCTSIZ3: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Data PID
            DPID: u2,
            padding: u1,
        }),
        ///  OTG_HS host channel-3 DMA address register
        OTG_HS_HCDMA3: mmio.Mmio(packed struct(u32) {
            ///  DMA address
            DMAADDR: u32,
        }),
        reserved384: [8]u8,
        ///  OTG_HS host channel-4 characteristics register
        OTG_HS_HCCHAR4: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            ///  Endpoint number
            EPNUM: u4,
            ///  Endpoint direction
            EPDIR: u1,
            reserved17: u1,
            ///  Low-speed device
            LSDEV: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Multi Count (MC) / Error Count (EC)
            MC: u2,
            ///  Device address
            DAD: u7,
            ///  Odd frame
            ODDFRM: u1,
            ///  Channel disable
            CHDIS: u1,
            ///  Channel enable
            CHENA: u1,
        }),
        ///  OTG_HS host channel-4 split control register
        OTG_HS_HCSPLT4: mmio.Mmio(packed struct(u32) {
            ///  Port address
            PRTADDR: u7,
            ///  Hub address
            HUBADDR: u7,
            ///  XACTPOS
            XACTPOS: u2,
            ///  Do complete split
            COMPLSPLT: u1,
            reserved31: u14,
            ///  Split enable
            SPLITEN: u1,
        }),
        ///  OTG_HS host channel-4 interrupt register
        OTG_HS_HCINT4: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed
            XFRC: u1,
            ///  Channel halted
            CHH: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt
            STALL: u1,
            ///  NAK response received interrupt
            NAK: u1,
            ///  ACK response received/transmitted interrupt
            ACK: u1,
            ///  Response received interrupt
            NYET: u1,
            ///  Transaction error
            TXERR: u1,
            ///  Babble error
            BBERR: u1,
            ///  Frame overrun
            FRMOR: u1,
            ///  Data toggle error
            DTERR: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-4 interrupt mask register
        OTG_HS_HCINTMSK4: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed mask
            XFRCM: u1,
            ///  Channel halted mask
            CHHM: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt mask
            STALLM: u1,
            ///  NAK response received interrupt mask
            NAKM: u1,
            ///  ACK response received/transmitted interrupt mask
            ACKM: u1,
            ///  response received interrupt mask
            NYET: u1,
            ///  Transaction error mask
            TXERRM: u1,
            ///  Babble error mask
            BBERRM: u1,
            ///  Frame overrun mask
            FRMORM: u1,
            ///  Data toggle error mask
            DTERRM: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-4 transfer size register
        OTG_HS_HCTSIZ4: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Data PID
            DPID: u2,
            padding: u1,
        }),
        ///  OTG_HS host channel-4 DMA address register
        OTG_HS_HCDMA4: mmio.Mmio(packed struct(u32) {
            ///  DMA address
            DMAADDR: u32,
        }),
        reserved416: [8]u8,
        ///  OTG_HS host channel-5 characteristics register
        OTG_HS_HCCHAR5: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            ///  Endpoint number
            EPNUM: u4,
            ///  Endpoint direction
            EPDIR: u1,
            reserved17: u1,
            ///  Low-speed device
            LSDEV: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Multi Count (MC) / Error Count (EC)
            MC: u2,
            ///  Device address
            DAD: u7,
            ///  Odd frame
            ODDFRM: u1,
            ///  Channel disable
            CHDIS: u1,
            ///  Channel enable
            CHENA: u1,
        }),
        ///  OTG_HS host channel-5 split control register
        OTG_HS_HCSPLT5: mmio.Mmio(packed struct(u32) {
            ///  Port address
            PRTADDR: u7,
            ///  Hub address
            HUBADDR: u7,
            ///  XACTPOS
            XACTPOS: u2,
            ///  Do complete split
            COMPLSPLT: u1,
            reserved31: u14,
            ///  Split enable
            SPLITEN: u1,
        }),
        ///  OTG_HS host channel-5 interrupt register
        OTG_HS_HCINT5: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed
            XFRC: u1,
            ///  Channel halted
            CHH: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt
            STALL: u1,
            ///  NAK response received interrupt
            NAK: u1,
            ///  ACK response received/transmitted interrupt
            ACK: u1,
            ///  Response received interrupt
            NYET: u1,
            ///  Transaction error
            TXERR: u1,
            ///  Babble error
            BBERR: u1,
            ///  Frame overrun
            FRMOR: u1,
            ///  Data toggle error
            DTERR: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-5 interrupt mask register
        OTG_HS_HCINTMSK5: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed mask
            XFRCM: u1,
            ///  Channel halted mask
            CHHM: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt mask
            STALLM: u1,
            ///  NAK response received interrupt mask
            NAKM: u1,
            ///  ACK response received/transmitted interrupt mask
            ACKM: u1,
            ///  response received interrupt mask
            NYET: u1,
            ///  Transaction error mask
            TXERRM: u1,
            ///  Babble error mask
            BBERRM: u1,
            ///  Frame overrun mask
            FRMORM: u1,
            ///  Data toggle error mask
            DTERRM: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-5 transfer size register
        OTG_HS_HCTSIZ5: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Data PID
            DPID: u2,
            padding: u1,
        }),
        ///  OTG_HS host channel-5 DMA address register
        OTG_HS_HCDMA5: mmio.Mmio(packed struct(u32) {
            ///  DMA address
            DMAADDR: u32,
        }),
        reserved448: [8]u8,
        ///  OTG_HS host channel-6 characteristics register
        OTG_HS_HCCHAR6: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            ///  Endpoint number
            EPNUM: u4,
            ///  Endpoint direction
            EPDIR: u1,
            reserved17: u1,
            ///  Low-speed device
            LSDEV: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Multi Count (MC) / Error Count (EC)
            MC: u2,
            ///  Device address
            DAD: u7,
            ///  Odd frame
            ODDFRM: u1,
            ///  Channel disable
            CHDIS: u1,
            ///  Channel enable
            CHENA: u1,
        }),
        ///  OTG_HS host channel-6 split control register
        OTG_HS_HCSPLT6: mmio.Mmio(packed struct(u32) {
            ///  Port address
            PRTADDR: u7,
            ///  Hub address
            HUBADDR: u7,
            ///  XACTPOS
            XACTPOS: u2,
            ///  Do complete split
            COMPLSPLT: u1,
            reserved31: u14,
            ///  Split enable
            SPLITEN: u1,
        }),
        ///  OTG_HS host channel-6 interrupt register
        OTG_HS_HCINT6: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed
            XFRC: u1,
            ///  Channel halted
            CHH: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt
            STALL: u1,
            ///  NAK response received interrupt
            NAK: u1,
            ///  ACK response received/transmitted interrupt
            ACK: u1,
            ///  Response received interrupt
            NYET: u1,
            ///  Transaction error
            TXERR: u1,
            ///  Babble error
            BBERR: u1,
            ///  Frame overrun
            FRMOR: u1,
            ///  Data toggle error
            DTERR: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-6 interrupt mask register
        OTG_HS_HCINTMSK6: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed mask
            XFRCM: u1,
            ///  Channel halted mask
            CHHM: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt mask
            STALLM: u1,
            ///  NAK response received interrupt mask
            NAKM: u1,
            ///  ACK response received/transmitted interrupt mask
            ACKM: u1,
            ///  response received interrupt mask
            NYET: u1,
            ///  Transaction error mask
            TXERRM: u1,
            ///  Babble error mask
            BBERRM: u1,
            ///  Frame overrun mask
            FRMORM: u1,
            ///  Data toggle error mask
            DTERRM: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-6 transfer size register
        OTG_HS_HCTSIZ6: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Data PID
            DPID: u2,
            padding: u1,
        }),
        ///  OTG_HS host channel-6 DMA address register
        OTG_HS_HCDMA6: mmio.Mmio(packed struct(u32) {
            ///  DMA address
            DMAADDR: u32,
        }),
        reserved480: [8]u8,
        ///  OTG_HS host channel-7 characteristics register
        OTG_HS_HCCHAR7: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            ///  Endpoint number
            EPNUM: u4,
            ///  Endpoint direction
            EPDIR: u1,
            reserved17: u1,
            ///  Low-speed device
            LSDEV: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Multi Count (MC) / Error Count (EC)
            MC: u2,
            ///  Device address
            DAD: u7,
            ///  Odd frame
            ODDFRM: u1,
            ///  Channel disable
            CHDIS: u1,
            ///  Channel enable
            CHENA: u1,
        }),
        ///  OTG_HS host channel-7 split control register
        OTG_HS_HCSPLT7: mmio.Mmio(packed struct(u32) {
            ///  Port address
            PRTADDR: u7,
            ///  Hub address
            HUBADDR: u7,
            ///  XACTPOS
            XACTPOS: u2,
            ///  Do complete split
            COMPLSPLT: u1,
            reserved31: u14,
            ///  Split enable
            SPLITEN: u1,
        }),
        ///  OTG_HS host channel-7 interrupt register
        OTG_HS_HCINT7: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed
            XFRC: u1,
            ///  Channel halted
            CHH: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt
            STALL: u1,
            ///  NAK response received interrupt
            NAK: u1,
            ///  ACK response received/transmitted interrupt
            ACK: u1,
            ///  Response received interrupt
            NYET: u1,
            ///  Transaction error
            TXERR: u1,
            ///  Babble error
            BBERR: u1,
            ///  Frame overrun
            FRMOR: u1,
            ///  Data toggle error
            DTERR: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-7 interrupt mask register
        OTG_HS_HCINTMSK7: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed mask
            XFRCM: u1,
            ///  Channel halted mask
            CHHM: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt mask
            STALLM: u1,
            ///  NAK response received interrupt mask
            NAKM: u1,
            ///  ACK response received/transmitted interrupt mask
            ACKM: u1,
            ///  response received interrupt mask
            NYET: u1,
            ///  Transaction error mask
            TXERRM: u1,
            ///  Babble error mask
            BBERRM: u1,
            ///  Frame overrun mask
            FRMORM: u1,
            ///  Data toggle error mask
            DTERRM: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-7 transfer size register
        OTG_HS_HCTSIZ7: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Data PID
            DPID: u2,
            padding: u1,
        }),
        ///  OTG_HS host channel-7 DMA address register
        OTG_HS_HCDMA7: mmio.Mmio(packed struct(u32) {
            ///  DMA address
            DMAADDR: u32,
        }),
        reserved512: [8]u8,
        ///  OTG_HS host channel-8 characteristics register
        OTG_HS_HCCHAR8: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            ///  Endpoint number
            EPNUM: u4,
            ///  Endpoint direction
            EPDIR: u1,
            reserved17: u1,
            ///  Low-speed device
            LSDEV: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Multi Count (MC) / Error Count (EC)
            MC: u2,
            ///  Device address
            DAD: u7,
            ///  Odd frame
            ODDFRM: u1,
            ///  Channel disable
            CHDIS: u1,
            ///  Channel enable
            CHENA: u1,
        }),
        ///  OTG_HS host channel-8 split control register
        OTG_HS_HCSPLT8: mmio.Mmio(packed struct(u32) {
            ///  Port address
            PRTADDR: u7,
            ///  Hub address
            HUBADDR: u7,
            ///  XACTPOS
            XACTPOS: u2,
            ///  Do complete split
            COMPLSPLT: u1,
            reserved31: u14,
            ///  Split enable
            SPLITEN: u1,
        }),
        ///  OTG_HS host channel-8 interrupt register
        OTG_HS_HCINT8: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed
            XFRC: u1,
            ///  Channel halted
            CHH: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt
            STALL: u1,
            ///  NAK response received interrupt
            NAK: u1,
            ///  ACK response received/transmitted interrupt
            ACK: u1,
            ///  Response received interrupt
            NYET: u1,
            ///  Transaction error
            TXERR: u1,
            ///  Babble error
            BBERR: u1,
            ///  Frame overrun
            FRMOR: u1,
            ///  Data toggle error
            DTERR: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-8 interrupt mask register
        OTG_HS_HCINTMSK8: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed mask
            XFRCM: u1,
            ///  Channel halted mask
            CHHM: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt mask
            STALLM: u1,
            ///  NAK response received interrupt mask
            NAKM: u1,
            ///  ACK response received/transmitted interrupt mask
            ACKM: u1,
            ///  response received interrupt mask
            NYET: u1,
            ///  Transaction error mask
            TXERRM: u1,
            ///  Babble error mask
            BBERRM: u1,
            ///  Frame overrun mask
            FRMORM: u1,
            ///  Data toggle error mask
            DTERRM: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-8 transfer size register
        OTG_HS_HCTSIZ8: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Data PID
            DPID: u2,
            padding: u1,
        }),
        ///  OTG_HS host channel-8 DMA address register
        OTG_HS_HCDMA8: mmio.Mmio(packed struct(u32) {
            ///  DMA address
            DMAADDR: u32,
        }),
        reserved544: [8]u8,
        ///  OTG_HS host channel-9 characteristics register
        OTG_HS_HCCHAR9: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            ///  Endpoint number
            EPNUM: u4,
            ///  Endpoint direction
            EPDIR: u1,
            reserved17: u1,
            ///  Low-speed device
            LSDEV: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Multi Count (MC) / Error Count (EC)
            MC: u2,
            ///  Device address
            DAD: u7,
            ///  Odd frame
            ODDFRM: u1,
            ///  Channel disable
            CHDIS: u1,
            ///  Channel enable
            CHENA: u1,
        }),
        ///  OTG_HS host channel-9 split control register
        OTG_HS_HCSPLT9: mmio.Mmio(packed struct(u32) {
            ///  Port address
            PRTADDR: u7,
            ///  Hub address
            HUBADDR: u7,
            ///  XACTPOS
            XACTPOS: u2,
            ///  Do complete split
            COMPLSPLT: u1,
            reserved31: u14,
            ///  Split enable
            SPLITEN: u1,
        }),
        ///  OTG_HS host channel-9 interrupt register
        OTG_HS_HCINT9: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed
            XFRC: u1,
            ///  Channel halted
            CHH: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt
            STALL: u1,
            ///  NAK response received interrupt
            NAK: u1,
            ///  ACK response received/transmitted interrupt
            ACK: u1,
            ///  Response received interrupt
            NYET: u1,
            ///  Transaction error
            TXERR: u1,
            ///  Babble error
            BBERR: u1,
            ///  Frame overrun
            FRMOR: u1,
            ///  Data toggle error
            DTERR: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-9 interrupt mask register
        OTG_HS_HCINTMSK9: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed mask
            XFRCM: u1,
            ///  Channel halted mask
            CHHM: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt mask
            STALLM: u1,
            ///  NAK response received interrupt mask
            NAKM: u1,
            ///  ACK response received/transmitted interrupt mask
            ACKM: u1,
            ///  response received interrupt mask
            NYET: u1,
            ///  Transaction error mask
            TXERRM: u1,
            ///  Babble error mask
            BBERRM: u1,
            ///  Frame overrun mask
            FRMORM: u1,
            ///  Data toggle error mask
            DTERRM: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-9 transfer size register
        OTG_HS_HCTSIZ9: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Data PID
            DPID: u2,
            padding: u1,
        }),
        ///  OTG_HS host channel-9 DMA address register
        OTG_HS_HCDMA9: mmio.Mmio(packed struct(u32) {
            ///  DMA address
            DMAADDR: u32,
        }),
        reserved576: [8]u8,
        ///  OTG_HS host channel-10 characteristics register
        OTG_HS_HCCHAR10: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            ///  Endpoint number
            EPNUM: u4,
            ///  Endpoint direction
            EPDIR: u1,
            reserved17: u1,
            ///  Low-speed device
            LSDEV: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Multi Count (MC) / Error Count (EC)
            MC: u2,
            ///  Device address
            DAD: u7,
            ///  Odd frame
            ODDFRM: u1,
            ///  Channel disable
            CHDIS: u1,
            ///  Channel enable
            CHENA: u1,
        }),
        ///  OTG_HS host channel-10 split control register
        OTG_HS_HCSPLT10: mmio.Mmio(packed struct(u32) {
            ///  Port address
            PRTADDR: u7,
            ///  Hub address
            HUBADDR: u7,
            ///  XACTPOS
            XACTPOS: u2,
            ///  Do complete split
            COMPLSPLT: u1,
            reserved31: u14,
            ///  Split enable
            SPLITEN: u1,
        }),
        ///  OTG_HS host channel-10 interrupt register
        OTG_HS_HCINT10: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed
            XFRC: u1,
            ///  Channel halted
            CHH: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt
            STALL: u1,
            ///  NAK response received interrupt
            NAK: u1,
            ///  ACK response received/transmitted interrupt
            ACK: u1,
            ///  Response received interrupt
            NYET: u1,
            ///  Transaction error
            TXERR: u1,
            ///  Babble error
            BBERR: u1,
            ///  Frame overrun
            FRMOR: u1,
            ///  Data toggle error
            DTERR: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-10 interrupt mask register
        OTG_HS_HCINTMSK10: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed mask
            XFRCM: u1,
            ///  Channel halted mask
            CHHM: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt mask
            STALLM: u1,
            ///  NAK response received interrupt mask
            NAKM: u1,
            ///  ACK response received/transmitted interrupt mask
            ACKM: u1,
            ///  response received interrupt mask
            NYET: u1,
            ///  Transaction error mask
            TXERRM: u1,
            ///  Babble error mask
            BBERRM: u1,
            ///  Frame overrun mask
            FRMORM: u1,
            ///  Data toggle error mask
            DTERRM: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-10 transfer size register
        OTG_HS_HCTSIZ10: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Data PID
            DPID: u2,
            padding: u1,
        }),
        ///  OTG_HS host channel-10 DMA address register
        OTG_HS_HCDMA10: mmio.Mmio(packed struct(u32) {
            ///  DMA address
            DMAADDR: u32,
        }),
        reserved608: [8]u8,
        ///  OTG_HS host channel-11 characteristics register
        OTG_HS_HCCHAR11: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            ///  Endpoint number
            EPNUM: u4,
            ///  Endpoint direction
            EPDIR: u1,
            reserved17: u1,
            ///  Low-speed device
            LSDEV: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Multi Count (MC) / Error Count (EC)
            MC: u2,
            ///  Device address
            DAD: u7,
            ///  Odd frame
            ODDFRM: u1,
            ///  Channel disable
            CHDIS: u1,
            ///  Channel enable
            CHENA: u1,
        }),
        ///  OTG_HS host channel-11 split control register
        OTG_HS_HCSPLT11: mmio.Mmio(packed struct(u32) {
            ///  Port address
            PRTADDR: u7,
            ///  Hub address
            HUBADDR: u7,
            ///  XACTPOS
            XACTPOS: u2,
            ///  Do complete split
            COMPLSPLT: u1,
            reserved31: u14,
            ///  Split enable
            SPLITEN: u1,
        }),
        ///  OTG_HS host channel-11 interrupt register
        OTG_HS_HCINT11: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed
            XFRC: u1,
            ///  Channel halted
            CHH: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt
            STALL: u1,
            ///  NAK response received interrupt
            NAK: u1,
            ///  ACK response received/transmitted interrupt
            ACK: u1,
            ///  Response received interrupt
            NYET: u1,
            ///  Transaction error
            TXERR: u1,
            ///  Babble error
            BBERR: u1,
            ///  Frame overrun
            FRMOR: u1,
            ///  Data toggle error
            DTERR: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-11 interrupt mask register
        OTG_HS_HCINTMSK11: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed mask
            XFRCM: u1,
            ///  Channel halted mask
            CHHM: u1,
            ///  AHB error
            AHBERR: u1,
            ///  STALL response received interrupt mask
            STALLM: u1,
            ///  NAK response received interrupt mask
            NAKM: u1,
            ///  ACK response received/transmitted interrupt mask
            ACKM: u1,
            ///  response received interrupt mask
            NYET: u1,
            ///  Transaction error mask
            TXERRM: u1,
            ///  Babble error mask
            BBERRM: u1,
            ///  Frame overrun mask
            FRMORM: u1,
            ///  Data toggle error mask
            DTERRM: u1,
            padding: u21,
        }),
        ///  OTG_HS host channel-11 transfer size register
        OTG_HS_HCTSIZ11: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Data PID
            DPID: u2,
            padding: u1,
        }),
        ///  OTG_HS host channel-11 DMA address register
        OTG_HS_HCDMA11: mmio.Mmio(packed struct(u32) {
            ///  DMA address
            DMAADDR: u32,
        }),
    };

    ///  Secure digital input/output interface
    pub const SDIO = extern struct {
        ///  power control register
        POWER: mmio.Mmio(packed struct(u32) {
            ///  PWRCTRL
            PWRCTRL: u2,
            padding: u30,
        }),
        ///  SDI clock control register
        CLKCR: mmio.Mmio(packed struct(u32) {
            ///  Clock divide factor
            CLKDIV: u8,
            ///  Clock enable bit
            CLKEN: u1,
            ///  Power saving configuration bit
            PWRSAV: u1,
            ///  Clock divider bypass enable bit
            BYPASS: u1,
            ///  Wide bus mode enable bit
            WIDBUS: u2,
            ///  SDIO_CK dephasing selection bit
            NEGEDGE: u1,
            ///  HW Flow Control enable
            HWFC_EN: u1,
            padding: u17,
        }),
        ///  argument register
        ARG: mmio.Mmio(packed struct(u32) {
            ///  Command argument
            CMDARG: u32,
        }),
        ///  command register
        CMD: mmio.Mmio(packed struct(u32) {
            ///  Command index
            CMDINDEX: u6,
            ///  Wait for response bits
            WAITRESP: u2,
            ///  CPSM waits for interrupt request
            WAITINT: u1,
            ///  CPSM Waits for ends of data transfer (CmdPend internal signal).
            WAITPEND: u1,
            ///  Command path state machine (CPSM) Enable bit
            CPSMEN: u1,
            ///  SD I/O suspend command
            SDIOSuspend: u1,
            ///  Enable CMD completion
            ENCMDcompl: u1,
            ///  not Interrupt Enable
            nIEN: u1,
            ///  CE-ATA command
            CE_ATACMD: u1,
            padding: u17,
        }),
        ///  command response register
        RESPCMD: mmio.Mmio(packed struct(u32) {
            ///  Response command index
            RESPCMD: u6,
            padding: u26,
        }),
        ///  response 1..4 register
        RESP1: mmio.Mmio(packed struct(u32) {
            ///  see Table 132.
            CARDSTATUS1: u32,
        }),
        ///  response 1..4 register
        RESP2: mmio.Mmio(packed struct(u32) {
            ///  see Table 132.
            CARDSTATUS2: u32,
        }),
        ///  response 1..4 register
        RESP3: mmio.Mmio(packed struct(u32) {
            ///  see Table 132.
            CARDSTATUS3: u32,
        }),
        ///  response 1..4 register
        RESP4: mmio.Mmio(packed struct(u32) {
            ///  see Table 132.
            CARDSTATUS4: u32,
        }),
        ///  data timer register
        DTIMER: mmio.Mmio(packed struct(u32) {
            ///  Data timeout period
            DATATIME: u32,
        }),
        ///  data length register
        DLEN: mmio.Mmio(packed struct(u32) {
            ///  Data length value
            DATALENGTH: u25,
            padding: u7,
        }),
        ///  data control register
        DCTRL: mmio.Mmio(packed struct(u32) {
            ///  DTEN
            DTEN: u1,
            ///  Data transfer direction selection
            DTDIR: u1,
            ///  Data transfer mode selection 1: Stream or SDIO multibyte data transfer.
            DTMODE: u1,
            ///  DMA enable bit
            DMAEN: u1,
            ///  Data block size
            DBLOCKSIZE: u4,
            ///  Read wait start
            RWSTART: u1,
            ///  Read wait stop
            RWSTOP: u1,
            ///  Read wait mode
            RWMOD: u1,
            ///  SD I/O enable functions
            SDIOEN: u1,
            padding: u20,
        }),
        ///  data counter register
        DCOUNT: mmio.Mmio(packed struct(u32) {
            ///  Data count value
            DATACOUNT: u25,
            padding: u7,
        }),
        ///  status register
        STA: mmio.Mmio(packed struct(u32) {
            ///  Command response received (CRC check failed)
            CCRCFAIL: u1,
            ///  Data block sent/received (CRC check failed)
            DCRCFAIL: u1,
            ///  Command response timeout
            CTIMEOUT: u1,
            ///  Data timeout
            DTIMEOUT: u1,
            ///  Transmit FIFO underrun error
            TXUNDERR: u1,
            ///  Received FIFO overrun error
            RXOVERR: u1,
            ///  Command response received (CRC check passed)
            CMDREND: u1,
            ///  Command sent (no response required)
            CMDSENT: u1,
            ///  Data end (data counter, SDIDCOUNT, is zero)
            DATAEND: u1,
            ///  Start bit not detected on all data signals in wide bus mode
            STBITERR: u1,
            ///  Data block sent/received (CRC check passed)
            DBCKEND: u1,
            ///  Command transfer in progress
            CMDACT: u1,
            ///  Data transmit in progress
            TXACT: u1,
            ///  Data receive in progress
            RXACT: u1,
            ///  Transmit FIFO half empty: at least 8 words can be written into the FIFO
            TXFIFOHE: u1,
            ///  Receive FIFO half full: there are at least 8 words in the FIFO
            RXFIFOHF: u1,
            ///  Transmit FIFO full
            TXFIFOF: u1,
            ///  Receive FIFO full
            RXFIFOF: u1,
            ///  Transmit FIFO empty
            TXFIFOE: u1,
            ///  Receive FIFO empty
            RXFIFOE: u1,
            ///  Data available in transmit FIFO
            TXDAVL: u1,
            ///  Data available in receive FIFO
            RXDAVL: u1,
            ///  SDIO interrupt received
            SDIOIT: u1,
            ///  CE-ATA command completion signal received for CMD61
            CEATAEND: u1,
            padding: u8,
        }),
        ///  interrupt clear register
        ICR: mmio.Mmio(packed struct(u32) {
            ///  CCRCFAIL flag clear bit
            CCRCFAILC: u1,
            ///  DCRCFAIL flag clear bit
            DCRCFAILC: u1,
            ///  CTIMEOUT flag clear bit
            CTIMEOUTC: u1,
            ///  DTIMEOUT flag clear bit
            DTIMEOUTC: u1,
            ///  TXUNDERR flag clear bit
            TXUNDERRC: u1,
            ///  RXOVERR flag clear bit
            RXOVERRC: u1,
            ///  CMDREND flag clear bit
            CMDRENDC: u1,
            ///  CMDSENT flag clear bit
            CMDSENTC: u1,
            ///  DATAEND flag clear bit
            DATAENDC: u1,
            ///  STBITERR flag clear bit
            STBITERRC: u1,
            ///  DBCKEND flag clear bit
            DBCKENDC: u1,
            reserved22: u11,
            ///  SDIOIT flag clear bit
            SDIOITC: u1,
            ///  CEATAEND flag clear bit
            CEATAENDC: u1,
            padding: u8,
        }),
        ///  mask register
        MASK: mmio.Mmio(packed struct(u32) {
            ///  Command CRC fail interrupt enable
            CCRCFAILIE: u1,
            ///  Data CRC fail interrupt enable
            DCRCFAILIE: u1,
            ///  Command timeout interrupt enable
            CTIMEOUTIE: u1,
            ///  Data timeout interrupt enable
            DTIMEOUTIE: u1,
            ///  Tx FIFO underrun error interrupt enable
            TXUNDERRIE: u1,
            ///  Rx FIFO overrun error interrupt enable
            RXOVERRIE: u1,
            ///  Command response received interrupt enable
            CMDRENDIE: u1,
            ///  Command sent interrupt enable
            CMDSENTIE: u1,
            ///  Data end interrupt enable
            DATAENDIE: u1,
            ///  Start bit error interrupt enable
            STBITERRIE: u1,
            ///  Data block end interrupt enable
            DBCKENDIE: u1,
            ///  Command acting interrupt enable
            CMDACTIE: u1,
            ///  Data transmit acting interrupt enable
            TXACTIE: u1,
            ///  Data receive acting interrupt enable
            RXACTIE: u1,
            ///  Tx FIFO half empty interrupt enable
            TXFIFOHEIE: u1,
            ///  Rx FIFO half full interrupt enable
            RXFIFOHFIE: u1,
            ///  Tx FIFO full interrupt enable
            TXFIFOFIE: u1,
            ///  Rx FIFO full interrupt enable
            RXFIFOFIE: u1,
            ///  Tx FIFO empty interrupt enable
            TXFIFOEIE: u1,
            ///  Rx FIFO empty interrupt enable
            RXFIFOEIE: u1,
            ///  Data available in Tx FIFO interrupt enable
            TXDAVLIE: u1,
            ///  Data available in Rx FIFO interrupt enable
            RXDAVLIE: u1,
            ///  SDIO mode interrupt received interrupt enable
            SDIOITIE: u1,
            ///  CE-ATA command completion signal received interrupt enable
            CEATAENDIE: u1,
            padding: u8,
        }),
        reserved72: [8]u8,
        ///  FIFO counter register
        FIFOCNT: mmio.Mmio(packed struct(u32) {
            ///  Remaining number of words to be written to or read from the FIFO.
            FIFOCOUNT: u24,
            padding: u8,
        }),
        reserved128: [52]u8,
        ///  data FIFO register
        FIFO: mmio.Mmio(packed struct(u32) {
            ///  Receive and transmit FIFO data
            FIFOData: u32,
        }),
    };

    ///  Analog-to-digital converter
    pub const ADC1 = extern struct {
        ///  status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Analog watchdog flag
            AWD: u1,
            ///  Regular channel end of conversion
            EOC: u1,
            ///  Injected channel end of conversion
            JEOC: u1,
            ///  Injected channel start flag
            JSTRT: u1,
            ///  Regular channel start flag
            STRT: u1,
            ///  Overrun
            OVR: u1,
            padding: u26,
        }),
        ///  control register 1
        CR1: mmio.Mmio(packed struct(u32) {
            ///  Analog watchdog channel select bits
            AWDCH: u5,
            ///  Interrupt enable for EOC
            EOCIE: u1,
            ///  Analog watchdog interrupt enable
            AWDIE: u1,
            ///  Interrupt enable for injected channels
            JEOCIE: u1,
            ///  Scan mode
            SCAN: u1,
            ///  Enable the watchdog on a single channel in scan mode
            AWDSGL: u1,
            ///  Automatic injected group conversion
            JAUTO: u1,
            ///  Discontinuous mode on regular channels
            DISCEN: u1,
            ///  Discontinuous mode on injected channels
            JDISCEN: u1,
            ///  Discontinuous mode channel count
            DISCNUM: u3,
            reserved22: u6,
            ///  Analog watchdog enable on injected channels
            JAWDEN: u1,
            ///  Analog watchdog enable on regular channels
            AWDEN: u1,
            ///  Resolution
            RES: u2,
            ///  Overrun interrupt enable
            OVRIE: u1,
            padding: u5,
        }),
        ///  control register 2
        CR2: mmio.Mmio(packed struct(u32) {
            ///  A/D Converter ON / OFF
            ADON: u1,
            ///  Continuous conversion
            CONT: u1,
            reserved8: u6,
            ///  Direct memory access mode (for single ADC mode)
            DMA: u1,
            ///  DMA disable selection (for single ADC mode)
            DDS: u1,
            ///  End of conversion selection
            EOCS: u1,
            ///  Data alignment
            ALIGN: u1,
            reserved16: u4,
            ///  External event select for injected group
            JEXTSEL: u4,
            ///  External trigger enable for injected channels
            JEXTEN: u2,
            ///  Start conversion of injected channels
            JSWSTART: u1,
            reserved24: u1,
            ///  External event select for regular group
            EXTSEL: u4,
            ///  External trigger enable for regular channels
            EXTEN: u2,
            ///  Start conversion of regular channels
            SWSTART: u1,
            padding: u1,
        }),
        ///  sample time register 1
        SMPR1: mmio.Mmio(packed struct(u32) {
            ///  Sample time bits
            SMPx_x: u32,
        }),
        ///  sample time register 2
        SMPR2: mmio.Mmio(packed struct(u32) {
            ///  Sample time bits
            SMPx_x: u32,
        }),
        ///  injected channel data offset register x
        JOFR1: mmio.Mmio(packed struct(u32) {
            ///  Data offset for injected channel x
            JOFFSET1: u12,
            padding: u20,
        }),
        ///  injected channel data offset register x
        JOFR2: mmio.Mmio(packed struct(u32) {
            ///  Data offset for injected channel x
            JOFFSET2: u12,
            padding: u20,
        }),
        ///  injected channel data offset register x
        JOFR3: mmio.Mmio(packed struct(u32) {
            ///  Data offset for injected channel x
            JOFFSET3: u12,
            padding: u20,
        }),
        ///  injected channel data offset register x
        JOFR4: mmio.Mmio(packed struct(u32) {
            ///  Data offset for injected channel x
            JOFFSET4: u12,
            padding: u20,
        }),
        ///  watchdog higher threshold register
        HTR: mmio.Mmio(packed struct(u32) {
            ///  Analog watchdog higher threshold
            HT: u12,
            padding: u20,
        }),
        ///  watchdog lower threshold register
        LTR: mmio.Mmio(packed struct(u32) {
            ///  Analog watchdog lower threshold
            LT: u12,
            padding: u20,
        }),
        ///  regular sequence register 1
        SQR1: mmio.Mmio(packed struct(u32) {
            ///  13th conversion in regular sequence
            SQ13: u5,
            ///  14th conversion in regular sequence
            SQ14: u5,
            ///  15th conversion in regular sequence
            SQ15: u5,
            ///  16th conversion in regular sequence
            SQ16: u5,
            ///  Regular channel sequence length
            L: u4,
            padding: u8,
        }),
        ///  regular sequence register 2
        SQR2: mmio.Mmio(packed struct(u32) {
            ///  7th conversion in regular sequence
            SQ7: u5,
            ///  8th conversion in regular sequence
            SQ8: u5,
            ///  9th conversion in regular sequence
            SQ9: u5,
            ///  10th conversion in regular sequence
            SQ10: u5,
            ///  11th conversion in regular sequence
            SQ11: u5,
            ///  12th conversion in regular sequence
            SQ12: u5,
            padding: u2,
        }),
        ///  regular sequence register 3
        SQR3: mmio.Mmio(packed struct(u32) {
            ///  1st conversion in regular sequence
            SQ1: u5,
            ///  2nd conversion in regular sequence
            SQ2: u5,
            ///  3rd conversion in regular sequence
            SQ3: u5,
            ///  4th conversion in regular sequence
            SQ4: u5,
            ///  5th conversion in regular sequence
            SQ5: u5,
            ///  6th conversion in regular sequence
            SQ6: u5,
            padding: u2,
        }),
        ///  injected sequence register
        JSQR: mmio.Mmio(packed struct(u32) {
            ///  1st conversion in injected sequence
            JSQ1: u5,
            ///  2nd conversion in injected sequence
            JSQ2: u5,
            ///  3rd conversion in injected sequence
            JSQ3: u5,
            ///  4th conversion in injected sequence
            JSQ4: u5,
            ///  Injected sequence length
            JL: u2,
            padding: u10,
        }),
        ///  injected data register x
        JDR1: mmio.Mmio(packed struct(u32) {
            ///  Injected data
            JDATA: u16,
            padding: u16,
        }),
        ///  injected data register x
        JDR2: mmio.Mmio(packed struct(u32) {
            ///  Injected data
            JDATA: u16,
            padding: u16,
        }),
        ///  injected data register x
        JDR3: mmio.Mmio(packed struct(u32) {
            ///  Injected data
            JDATA: u16,
            padding: u16,
        }),
        ///  injected data register x
        JDR4: mmio.Mmio(packed struct(u32) {
            ///  Injected data
            JDATA: u16,
            padding: u16,
        }),
        ///  regular data register
        DR: mmio.Mmio(packed struct(u32) {
            ///  Regular data
            DATA: u16,
            padding: u16,
        }),
    };

    ///  USB on the go high speed
    pub const OTG_HS_GLOBAL = extern struct {
        ///  OTG_HS control and status register
        OTG_HS_GOTGCTL: mmio.Mmio(packed struct(u32) {
            ///  Session request success
            SRQSCS: u1,
            ///  Session request
            SRQ: u1,
            reserved8: u6,
            ///  Host negotiation success
            HNGSCS: u1,
            ///  HNP request
            HNPRQ: u1,
            ///  Host set HNP enable
            HSHNPEN: u1,
            ///  Device HNP enabled
            DHNPEN: u1,
            reserved16: u4,
            ///  Connector ID status
            CIDSTS: u1,
            ///  Long/short debounce time
            DBCT: u1,
            ///  A-session valid
            ASVLD: u1,
            ///  B-session valid
            BSVLD: u1,
            padding: u12,
        }),
        ///  OTG_HS interrupt register
        OTG_HS_GOTGINT: mmio.Mmio(packed struct(u32) {
            reserved2: u2,
            ///  Session end detected
            SEDET: u1,
            reserved8: u5,
            ///  Session request success status change
            SRSSCHG: u1,
            ///  Host negotiation success status change
            HNSSCHG: u1,
            reserved17: u7,
            ///  Host negotiation detected
            HNGDET: u1,
            ///  A-device timeout change
            ADTOCHG: u1,
            ///  Debounce done
            DBCDNE: u1,
            padding: u12,
        }),
        ///  OTG_HS AHB configuration register
        OTG_HS_GAHBCFG: mmio.Mmio(packed struct(u32) {
            ///  Global interrupt mask
            GINT: u1,
            ///  Burst length/type
            HBSTLEN: u4,
            ///  DMA enable
            DMAEN: u1,
            reserved7: u1,
            ///  TxFIFO empty level
            TXFELVL: u1,
            ///  Periodic TxFIFO empty level
            PTXFELVL: u1,
            padding: u23,
        }),
        ///  OTG_HS USB configuration register
        OTG_HS_GUSBCFG: mmio.Mmio(packed struct(u32) {
            ///  FS timeout calibration
            TOCAL: u3,
            reserved6: u3,
            ///  USB 2.0 high-speed ULPI PHY or USB 1.1 full-speed serial transceiver select
            PHYSEL: u1,
            reserved8: u1,
            ///  SRP-capable
            SRPCAP: u1,
            ///  HNP-capable
            HNPCAP: u1,
            ///  USB turnaround time
            TRDT: u4,
            reserved15: u1,
            ///  PHY Low-power clock select
            PHYLPCS: u1,
            reserved17: u1,
            ///  ULPI FS/LS select
            ULPIFSLS: u1,
            ///  ULPI Auto-resume
            ULPIAR: u1,
            ///  ULPI Clock SuspendM
            ULPICSM: u1,
            ///  ULPI External VBUS Drive
            ULPIEVBUSD: u1,
            ///  ULPI external VBUS indicator
            ULPIEVBUSI: u1,
            ///  TermSel DLine pulsing selection
            TSDPS: u1,
            ///  Indicator complement
            PCCI: u1,
            ///  Indicator pass through
            PTCI: u1,
            ///  ULPI interface protect disable
            ULPIIPD: u1,
            reserved29: u3,
            ///  Forced host mode
            FHMOD: u1,
            ///  Forced peripheral mode
            FDMOD: u1,
            ///  Corrupt Tx packet
            CTXPKT: u1,
        }),
        ///  OTG_HS reset register
        OTG_HS_GRSTCTL: mmio.Mmio(packed struct(u32) {
            ///  Core soft reset
            CSRST: u1,
            ///  HCLK soft reset
            HSRST: u1,
            ///  Host frame counter reset
            FCRST: u1,
            reserved4: u1,
            ///  RxFIFO flush
            RXFFLSH: u1,
            ///  TxFIFO flush
            TXFFLSH: u1,
            ///  TxFIFO number
            TXFNUM: u5,
            reserved30: u19,
            ///  DMA request signal
            DMAREQ: u1,
            ///  AHB master idle
            AHBIDL: u1,
        }),
        ///  OTG_HS core interrupt register
        OTG_HS_GINTSTS: mmio.Mmio(packed struct(u32) {
            ///  Current mode of operation
            CMOD: u1,
            ///  Mode mismatch interrupt
            MMIS: u1,
            ///  OTG interrupt
            OTGINT: u1,
            ///  Start of frame
            SOF: u1,
            ///  RxFIFO nonempty
            RXFLVL: u1,
            ///  Nonperiodic TxFIFO empty
            NPTXFE: u1,
            ///  Global IN nonperiodic NAK effective
            GINAKEFF: u1,
            ///  Global OUT NAK effective
            BOUTNAKEFF: u1,
            reserved10: u2,
            ///  Early suspend
            ESUSP: u1,
            ///  USB suspend
            USBSUSP: u1,
            ///  USB reset
            USBRST: u1,
            ///  Enumeration done
            ENUMDNE: u1,
            ///  Isochronous OUT packet dropped interrupt
            ISOODRP: u1,
            ///  End of periodic frame interrupt
            EOPF: u1,
            reserved18: u2,
            ///  IN endpoint interrupt
            IEPINT: u1,
            ///  OUT endpoint interrupt
            OEPINT: u1,
            ///  Incomplete isochronous IN transfer
            IISOIXFR: u1,
            ///  Incomplete periodic transfer
            PXFR_INCOMPISOOUT: u1,
            ///  Data fetch suspended
            DATAFSUSP: u1,
            reserved24: u1,
            ///  Host port interrupt
            HPRTINT: u1,
            ///  Host channels interrupt
            HCINT: u1,
            ///  Periodic TxFIFO empty
            PTXFE: u1,
            reserved28: u1,
            ///  Connector ID status change
            CIDSCHG: u1,
            ///  Disconnect detected interrupt
            DISCINT: u1,
            ///  Session request/new session detected interrupt
            SRQINT: u1,
            ///  Resume/remote wakeup detected interrupt
            WKUINT: u1,
        }),
        ///  OTG_HS interrupt mask register
        OTG_HS_GINTMSK: mmio.Mmio(packed struct(u32) {
            reserved1: u1,
            ///  Mode mismatch interrupt mask
            MMISM: u1,
            ///  OTG interrupt mask
            OTGINT: u1,
            ///  Start of frame mask
            SOFM: u1,
            ///  Receive FIFO nonempty mask
            RXFLVLM: u1,
            ///  Nonperiodic TxFIFO empty mask
            NPTXFEM: u1,
            ///  Global nonperiodic IN NAK effective mask
            GINAKEFFM: u1,
            ///  Global OUT NAK effective mask
            GONAKEFFM: u1,
            reserved10: u2,
            ///  Early suspend mask
            ESUSPM: u1,
            ///  USB suspend mask
            USBSUSPM: u1,
            ///  USB reset mask
            USBRST: u1,
            ///  Enumeration done mask
            ENUMDNEM: u1,
            ///  Isochronous OUT packet dropped interrupt mask
            ISOODRPM: u1,
            ///  End of periodic frame interrupt mask
            EOPFM: u1,
            reserved17: u1,
            ///  Endpoint mismatch interrupt mask
            EPMISM: u1,
            ///  IN endpoints interrupt mask
            IEPINT: u1,
            ///  OUT endpoints interrupt mask
            OEPINT: u1,
            ///  Incomplete isochronous IN transfer mask
            IISOIXFRM: u1,
            ///  Incomplete periodic transfer mask
            PXFRM_IISOOXFRM: u1,
            ///  Data fetch suspended mask
            FSUSPM: u1,
            reserved24: u1,
            ///  Host port interrupt mask
            PRTIM: u1,
            ///  Host channels interrupt mask
            HCIM: u1,
            ///  Periodic TxFIFO empty mask
            PTXFEM: u1,
            reserved28: u1,
            ///  Connector ID status change mask
            CIDSCHGM: u1,
            ///  Disconnect detected interrupt mask
            DISCINT: u1,
            ///  Session request/new session detected interrupt mask
            SRQIM: u1,
            ///  Resume/remote wakeup detected interrupt mask
            WUIM: u1,
        }),
        ///  OTG_HS Receive status debug read register (host mode)
        OTG_HS_GRXSTSR_Host: mmio.Mmio(packed struct(u32) {
            ///  Channel number
            CHNUM: u4,
            ///  Byte count
            BCNT: u11,
            ///  Data PID
            DPID: u2,
            ///  Packet status
            PKTSTS: u4,
            padding: u11,
        }),
        ///  OTG_HS status read and pop register (host mode)
        OTG_HS_GRXSTSP_Host: mmio.Mmio(packed struct(u32) {
            ///  Channel number
            CHNUM: u4,
            ///  Byte count
            BCNT: u11,
            ///  Data PID
            DPID: u2,
            ///  Packet status
            PKTSTS: u4,
            padding: u11,
        }),
        ///  OTG_HS Receive FIFO size register
        OTG_HS_GRXFSIZ: mmio.Mmio(packed struct(u32) {
            ///  RxFIFO depth
            RXFD: u16,
            padding: u16,
        }),
        ///  OTG_HS nonperiodic transmit FIFO size register (host mode)
        OTG_HS_GNPTXFSIZ_Host: mmio.Mmio(packed struct(u32) {
            ///  Nonperiodic transmit RAM start address
            NPTXFSA: u16,
            ///  Nonperiodic TxFIFO depth
            NPTXFD: u16,
        }),
        ///  OTG_HS nonperiodic transmit FIFO/queue status register
        OTG_HS_GNPTXSTS: mmio.Mmio(packed struct(u32) {
            ///  Nonperiodic TxFIFO space available
            NPTXFSAV: u16,
            ///  Nonperiodic transmit request queue space available
            NPTQXSAV: u8,
            ///  Top of the nonperiodic transmit request queue
            NPTXQTOP: u7,
            padding: u1,
        }),
        reserved56: [8]u8,
        ///  OTG_HS general core configuration register
        OTG_HS_GCCFG: mmio.Mmio(packed struct(u32) {
            reserved16: u16,
            ///  Power down
            PWRDWN: u1,
            ///  Enable I2C bus connection for the external I2C PHY interface
            I2CPADEN: u1,
            ///  Enable the VBUS sensing device
            VBUSASEN: u1,
            ///  Enable the VBUS sensing device
            VBUSBSEN: u1,
            ///  SOF output enable
            SOFOUTEN: u1,
            ///  VBUS sensing disable option
            NOVBUSSENS: u1,
            padding: u10,
        }),
        ///  OTG_HS core ID register
        OTG_HS_CID: mmio.Mmio(packed struct(u32) {
            ///  Product ID field
            PRODUCT_ID: u32,
        }),
        reserved256: [192]u8,
        ///  OTG_HS Host periodic transmit FIFO size register
        OTG_HS_HPTXFSIZ: mmio.Mmio(packed struct(u32) {
            ///  Host periodic TxFIFO start address
            PTXSA: u16,
            ///  Host periodic TxFIFO depth
            PTXFD: u16,
        }),
        ///  OTG_HS device IN endpoint transmit FIFO size register
        OTG_HS_DIEPTXF1: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint FIFOx transmit RAM start address
            INEPTXSA: u16,
            ///  IN endpoint TxFIFO depth
            INEPTXFD: u16,
        }),
        ///  OTG_HS device IN endpoint transmit FIFO size register
        OTG_HS_DIEPTXF2: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint FIFOx transmit RAM start address
            INEPTXSA: u16,
            ///  IN endpoint TxFIFO depth
            INEPTXFD: u16,
        }),
        reserved284: [16]u8,
        ///  OTG_HS device IN endpoint transmit FIFO size register
        OTG_HS_DIEPTXF3: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint FIFOx transmit RAM start address
            INEPTXSA: u16,
            ///  IN endpoint TxFIFO depth
            INEPTXFD: u16,
        }),
        ///  OTG_HS device IN endpoint transmit FIFO size register
        OTG_HS_DIEPTXF4: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint FIFOx transmit RAM start address
            INEPTXSA: u16,
            ///  IN endpoint TxFIFO depth
            INEPTXFD: u16,
        }),
        ///  OTG_HS device IN endpoint transmit FIFO size register
        OTG_HS_DIEPTXF5: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint FIFOx transmit RAM start address
            INEPTXSA: u16,
            ///  IN endpoint TxFIFO depth
            INEPTXFD: u16,
        }),
        ///  OTG_HS device IN endpoint transmit FIFO size register
        OTG_HS_DIEPTXF6: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint FIFOx transmit RAM start address
            INEPTXSA: u16,
            ///  IN endpoint TxFIFO depth
            INEPTXFD: u16,
        }),
        ///  OTG_HS device IN endpoint transmit FIFO size register
        OTG_HS_DIEPTXF7: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint FIFOx transmit RAM start address
            INEPTXSA: u16,
            ///  IN endpoint TxFIFO depth
            INEPTXFD: u16,
        }),
    };

    ///  External interrupt/event controller
    pub const EXTI = extern struct {
        ///  Interrupt mask register (EXTI_IMR)
        IMR: mmio.Mmio(packed struct(u32) {
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
            padding: u9,
        }),
        ///  Event mask register (EXTI_EMR)
        EMR: mmio.Mmio(packed struct(u32) {
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
            padding: u9,
        }),
        ///  Rising Trigger selection register (EXTI_RTSR)
        RTSR: mmio.Mmio(packed struct(u32) {
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
            padding: u9,
        }),
        ///  Falling Trigger selection register (EXTI_FTSR)
        FTSR: mmio.Mmio(packed struct(u32) {
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
            padding: u9,
        }),
        ///  Software interrupt event register (EXTI_SWIER)
        SWIER: mmio.Mmio(packed struct(u32) {
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
            padding: u9,
        }),
        ///  Pending register (EXTI_PR)
        PR: mmio.Mmio(packed struct(u32) {
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
            padding: u9,
        }),
    };

    ///  Universal synchronous asynchronous receiver transmitter
    pub const USART6 = extern struct {
        ///  Status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Parity error
            PE: u1,
            ///  Framing error
            FE: u1,
            ///  Noise detected flag
            NF: u1,
            ///  Overrun error
            ORE: u1,
            ///  IDLE line detected
            IDLE: u1,
            ///  Read data register not empty
            RXNE: u1,
            ///  Transmission complete
            TC: u1,
            ///  Transmit data register empty
            TXE: u1,
            ///  LIN break detection flag
            LBD: u1,
            ///  CTS flag
            CTS: u1,
            padding: u22,
        }),
        ///  Data register
        DR: mmio.Mmio(packed struct(u32) {
            ///  Data value
            DR: u9,
            padding: u23,
        }),
        ///  Baud rate register
        BRR: mmio.Mmio(packed struct(u32) {
            ///  fraction of USARTDIV
            DIV_Fraction: u4,
            ///  mantissa of USARTDIV
            DIV_Mantissa: u12,
            padding: u16,
        }),
        ///  Control register 1
        CR1: mmio.Mmio(packed struct(u32) {
            ///  Send break
            SBK: u1,
            ///  Receiver wakeup
            RWU: u1,
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
            ///  TXE interrupt enable
            TXEIE: u1,
            ///  PE interrupt enable
            PEIE: u1,
            ///  Parity selection
            PS: u1,
            ///  Parity control enable
            PCE: u1,
            ///  Wakeup method
            WAKE: u1,
            ///  Word length
            M: u1,
            ///  USART enable
            UE: u1,
            reserved15: u1,
            ///  Oversampling mode
            OVER8: u1,
            padding: u16,
        }),
        ///  Control register 2
        CR2: mmio.Mmio(packed struct(u32) {
            ///  Address of the USART node
            ADD: u4,
            reserved5: u1,
            ///  lin break detection length
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
            padding: u17,
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
            padding: u20,
        }),
        ///  Guard time and prescaler register
        GTPR: mmio.Mmio(packed struct(u32) {
            ///  Prescaler value
            PSC: u8,
            ///  Guard time value
            GT: u8,
            padding: u16,
        }),
    };

    ///  FLASH
    pub const FLASH = extern struct {
        ///  Flash access control register
        ACR: mmio.Mmio(packed struct(u32) {
            ///  Latency
            LATENCY: u3,
            reserved8: u5,
            ///  Prefetch enable
            PRFTEN: u1,
            ///  Instruction cache enable
            ICEN: u1,
            ///  Data cache enable
            DCEN: u1,
            ///  Instruction cache reset
            ICRST: u1,
            ///  Data cache reset
            DCRST: u1,
            padding: u19,
        }),
        ///  Flash key register
        KEYR: mmio.Mmio(packed struct(u32) {
            ///  FPEC key
            KEY: u32,
        }),
        ///  Flash option key register
        OPTKEYR: mmio.Mmio(packed struct(u32) {
            ///  Option byte key
            OPTKEY: u32,
        }),
        ///  Status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  End of operation
            EOP: u1,
            ///  Operation error
            OPERR: u1,
            reserved4: u2,
            ///  Write protection error
            WRPERR: u1,
            ///  Programming alignment error
            PGAERR: u1,
            ///  Programming parallelism error
            PGPERR: u1,
            ///  Programming sequence error
            PGSERR: u1,
            reserved16: u8,
            ///  Busy
            BSY: u1,
            padding: u15,
        }),
        ///  Control register
        CR: mmio.Mmio(packed struct(u32) {
            ///  Programming
            PG: u1,
            ///  Sector Erase
            SER: u1,
            ///  Mass Erase of sectors 0 to 11
            MER: u1,
            ///  Sector number
            SNB: u5,
            ///  Program size
            PSIZE: u2,
            reserved15: u5,
            ///  Mass Erase of sectors 12 to 23
            MER1: u1,
            ///  Start
            STRT: u1,
            reserved24: u7,
            ///  End of operation interrupt enable
            EOPIE: u1,
            ///  Error interrupt enable
            ERRIE: u1,
            reserved31: u5,
            ///  Lock
            LOCK: u1,
        }),
        ///  Flash option control register
        OPTCR: mmio.Mmio(packed struct(u32) {
            ///  Option lock
            OPTLOCK: u1,
            ///  Option start
            OPTSTRT: u1,
            ///  BOR reset Level
            BOR_LEV: u2,
            reserved5: u1,
            ///  WDG_SW User option bytes
            WDG_SW: u1,
            ///  nRST_STOP User option bytes
            nRST_STOP: u1,
            ///  nRST_STDBY User option bytes
            nRST_STDBY: u1,
            ///  Read protect
            RDP: u8,
            ///  Not write protect
            nWRP: u12,
            padding: u4,
        }),
        ///  Flash option control register 1
        OPTCR1: mmio.Mmio(packed struct(u32) {
            reserved16: u16,
            ///  Not write protect
            nWRP: u12,
            padding: u4,
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

    ///  Ethernet: media access control (MAC)
    pub const Ethernet_MAC = extern struct {
        ///  Ethernet MAC configuration register
        MACCR: mmio.Mmio(packed struct(u32) {
            reserved2: u2,
            ///  RE
            RE: u1,
            ///  TE
            TE: u1,
            ///  DC
            DC: u1,
            ///  BL
            BL: u2,
            ///  APCS
            APCS: u1,
            reserved9: u1,
            ///  RD
            RD: u1,
            ///  IPCO
            IPCO: u1,
            ///  DM
            DM: u1,
            ///  LM
            LM: u1,
            ///  ROD
            ROD: u1,
            ///  FES
            FES: u1,
            reserved16: u1,
            ///  CSD
            CSD: u1,
            ///  IFG
            IFG: u3,
            reserved22: u2,
            ///  JD
            JD: u1,
            ///  WD
            WD: u1,
            reserved25: u1,
            ///  CSTF
            CSTF: u1,
            padding: u6,
        }),
        ///  Ethernet MAC frame filter register
        MACFFR: mmio.Mmio(packed struct(u32) {
            ///  PM
            PM: u1,
            ///  HU
            HU: u1,
            ///  HM
            HM: u1,
            ///  DAIF
            DAIF: u1,
            ///  RAM
            RAM: u1,
            ///  BFD
            BFD: u1,
            ///  PCF
            PCF: u1,
            ///  SAIF
            SAIF: u1,
            ///  SAF
            SAF: u1,
            ///  HPF
            HPF: u1,
            reserved31: u21,
            ///  RA
            RA: u1,
        }),
        ///  Ethernet MAC hash table high register
        MACHTHR: mmio.Mmio(packed struct(u32) {
            ///  HTH
            HTH: u32,
        }),
        ///  Ethernet MAC hash table low register
        MACHTLR: mmio.Mmio(packed struct(u32) {
            ///  HTL
            HTL: u32,
        }),
        ///  Ethernet MAC MII address register
        MACMIIAR: mmio.Mmio(packed struct(u32) {
            ///  MB
            MB: u1,
            ///  MW
            MW: u1,
            ///  CR
            CR: u3,
            reserved6: u1,
            ///  MR
            MR: u5,
            ///  PA
            PA: u5,
            padding: u16,
        }),
        ///  Ethernet MAC MII data register
        MACMIIDR: mmio.Mmio(packed struct(u32) {
            ///  TD
            TD: u16,
            padding: u16,
        }),
        ///  Ethernet MAC flow control register
        MACFCR: mmio.Mmio(packed struct(u32) {
            ///  FCB
            FCB: u1,
            ///  TFCE
            TFCE: u1,
            ///  RFCE
            RFCE: u1,
            ///  UPFD
            UPFD: u1,
            ///  PLT
            PLT: u2,
            reserved7: u1,
            ///  ZQPD
            ZQPD: u1,
            reserved16: u8,
            ///  PT
            PT: u16,
        }),
        ///  Ethernet MAC VLAN tag register
        MACVLANTR: mmio.Mmio(packed struct(u32) {
            ///  VLANTI
            VLANTI: u16,
            ///  VLANTC
            VLANTC: u1,
            padding: u15,
        }),
        reserved44: [12]u8,
        ///  Ethernet MAC PMT control and status register
        MACPMTCSR: mmio.Mmio(packed struct(u32) {
            ///  PD
            PD: u1,
            ///  MPE
            MPE: u1,
            ///  WFE
            WFE: u1,
            reserved5: u2,
            ///  MPR
            MPR: u1,
            ///  WFR
            WFR: u1,
            reserved9: u2,
            ///  GU
            GU: u1,
            reserved31: u21,
            ///  WFFRPR
            WFFRPR: u1,
        }),
        reserved52: [4]u8,
        ///  Ethernet MAC debug register
        MACDBGR: mmio.Mmio(packed struct(u32) {
            ///  CR
            CR: u1,
            ///  CSR
            CSR: u1,
            ///  ROR
            ROR: u1,
            ///  MCF
            MCF: u1,
            ///  MCP
            MCP: u1,
            ///  MCFHP
            MCFHP: u1,
            padding: u26,
        }),
        ///  Ethernet MAC interrupt status register
        MACSR: mmio.Mmio(packed struct(u32) {
            reserved3: u3,
            ///  PMTS
            PMTS: u1,
            ///  MMCS
            MMCS: u1,
            ///  MMCRS
            MMCRS: u1,
            ///  MMCTS
            MMCTS: u1,
            reserved9: u2,
            ///  TSTS
            TSTS: u1,
            padding: u22,
        }),
        ///  Ethernet MAC interrupt mask register
        MACIMR: mmio.Mmio(packed struct(u32) {
            reserved3: u3,
            ///  PMTIM
            PMTIM: u1,
            reserved9: u5,
            ///  TSTIM
            TSTIM: u1,
            padding: u22,
        }),
        ///  Ethernet MAC address 0 high register
        MACA0HR: mmio.Mmio(packed struct(u32) {
            ///  MAC address0 high
            MACA0H: u16,
            reserved31: u15,
            ///  Always 1
            MO: u1,
        }),
        ///  Ethernet MAC address 0 low register
        MACA0LR: mmio.Mmio(packed struct(u32) {
            ///  0
            MACA0L: u32,
        }),
        ///  Ethernet MAC address 1 high register
        MACA1HR: mmio.Mmio(packed struct(u32) {
            ///  MACA1H
            MACA1H: u16,
            reserved24: u8,
            ///  MBC
            MBC: u6,
            ///  SA
            SA: u1,
            ///  AE
            AE: u1,
        }),
        ///  Ethernet MAC address1 low register
        MACA1LR: mmio.Mmio(packed struct(u32) {
            ///  MACA1LR
            MACA1LR: u32,
        }),
        ///  Ethernet MAC address 2 high register
        MACA2HR: mmio.Mmio(packed struct(u32) {
            ///  MAC2AH
            MAC2AH: u16,
            reserved24: u8,
            ///  MBC
            MBC: u6,
            ///  SA
            SA: u1,
            ///  AE
            AE: u1,
        }),
        ///  Ethernet MAC address 2 low register
        MACA2LR: mmio.Mmio(packed struct(u32) {
            ///  MACA2L
            MACA2L: u31,
            padding: u1,
        }),
        ///  Ethernet MAC address 3 high register
        MACA3HR: mmio.Mmio(packed struct(u32) {
            ///  MACA3H
            MACA3H: u16,
            reserved24: u8,
            ///  MBC
            MBC: u6,
            ///  SA
            SA: u1,
            ///  AE
            AE: u1,
        }),
        ///  Ethernet MAC address 3 low register
        MACA3LR: mmio.Mmio(packed struct(u32) {
            ///  MBCA3L
            MBCA3L: u32,
        }),
    };

    ///  Controller area network
    pub const CAN1 = extern struct {
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
        ///  interrupt enable register
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
        ///  mailbox identifier register
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
        ///  mailbox identifier register
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
        ///  mailbox data high register
        RDT0R: mmio.Mmio(packed struct(u32) {
            ///  DLC
            DLC: u4,
            reserved8: u4,
            ///  FMI
            FMI: u8,
            ///  TIME
            TIME: u16,
        }),
        ///  mailbox data high register
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
        ///  mailbox data high register
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
        ///  mailbox data high register
        RDT1R: mmio.Mmio(packed struct(u32) {
            ///  DLC
            DLC: u4,
            reserved8: u4,
            ///  FMI
            FMI: u8,
            ///  TIME
            TIME: u16,
        }),
        ///  mailbox data high register
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
        ///  mailbox data high register
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
            ///  FINIT
            FINIT: u1,
            reserved8: u7,
            ///  CAN2SB
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
        ///  filter activation register
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

    ///  USB on the go full speed
    pub const OTG_FS_PWRCLK = extern struct {
        ///  OTG_FS power and clock gating control register (OTG_FS_PCGCCTL)
        FS_PCGCCTL: mmio.Mmio(packed struct(u32) {
            ///  Stop PHY clock
            STPPCLK: u1,
            ///  Gate HCLK
            GATEHCLK: u1,
            reserved4: u2,
            ///  PHY Suspended
            PHYSUSP: u1,
            padding: u27,
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
            ///  Flash power down in Stop mode
            FPDS: u1,
            ///  Low-Power Regulator Low Voltage in deepsleep
            LPLVDS: u1,
            ///  Main regulator low voltage in deepsleep mode
            MRLVDS: u1,
            reserved14: u2,
            ///  Regulator voltage scaling output selection
            VOS: u2,
            ///  Over-drive enable
            ODEN: u1,
            ///  Over-drive switching enabled
            ODSWEN: u1,
            ///  Under-drive enable in stop mode
            UDEN: u2,
            padding: u12,
        }),
        ///  power control/status register
        CSR: mmio.Mmio(packed struct(u32) {
            ///  Wakeup flag
            WUF: u1,
            ///  Standby flag
            SBF: u1,
            ///  PVD output
            PVDO: u1,
            ///  Backup regulator ready
            BRR: u1,
            reserved8: u4,
            ///  Enable WKUP pin
            EWUP: u1,
            ///  Backup regulator enable
            BRE: u1,
            reserved14: u4,
            ///  Regulator voltage scaling output selection ready bit
            VOSRDY: u1,
            reserved16: u1,
            ///  Over-drive mode ready
            ODRDY: u1,
            ///  Over-drive mode switching ready
            ODSWRDY: u1,
            ///  Under-drive ready flag
            UDRDY: u2,
            padding: u12,
        }),
    };

    ///  Independent watchdog
    pub const IWDG = extern struct {
        ///  Key register
        KR: mmio.Mmio(packed struct(u32) {
            ///  Key value (write only, read 0000h)
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
            padding: u30,
        }),
    };

    ///  Window watchdog
    pub const WWDG = extern struct {
        ///  Control register
        CR: mmio.Mmio(packed struct(u32) {
            ///  7-bit counter (MSB to LSB)
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
            WDGTB0: u1,
            ///  Timer base
            WDGTB1: u1,
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
            reserved6: u1,
            ///  Hour format
            FMT: u1,
            ///  Coarse digital calibration enable
            DCE: u1,
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
            reserved20: u1,
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
            ///  TAMPER2 detection flag
            TAMP2F: u1,
            reserved16: u1,
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
        ///  calibration register
        CALIBR: mmio.Mmio(packed struct(u32) {
            ///  Digital calibration
            DC: u5,
            reserved7: u2,
            ///  Digital calibration sign
            DCS: u1,
            padding: u24,
        }),
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
            ///  Tamper 1 detection enable
            TAMP1E: u1,
            ///  Active level for tamper 1
            TAMP1TRG: u1,
            ///  Tamper interrupt enable
            TAMPIE: u1,
            reserved16: u13,
            ///  TAMPER1 mapping
            TAMP1INSEL: u1,
            ///  TIMESTAMP mapping
            TSINSEL: u1,
            ///  AFO_ALARM output type
            ALARMOUTTYPE: u1,
            padding: u13,
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
            reserved7: u2,
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
            ///  TAMPER1 mapping
            TAMP1INSEL: u1,
            ///  TIMESTAMP mapping
            TSINSEL: u1,
            ///  AFO_ALARM output type
            ALARMOUTTYPE: u1,
            padding: u13,
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
    };

    ///  Universal synchronous asynchronous receiver transmitter
    pub const UART4 = extern struct {
        ///  Status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Parity error
            PE: u1,
            ///  Framing error
            FE: u1,
            ///  Noise detected flag
            NF: u1,
            ///  Overrun error
            ORE: u1,
            ///  IDLE line detected
            IDLE: u1,
            ///  Read data register not empty
            RXNE: u1,
            ///  Transmission complete
            TC: u1,
            ///  Transmit data register empty
            TXE: u1,
            ///  LIN break detection flag
            LBD: u1,
            padding: u23,
        }),
        ///  Data register
        DR: mmio.Mmio(packed struct(u32) {
            ///  Data value
            DR: u9,
            padding: u23,
        }),
        ///  Baud rate register
        BRR: mmio.Mmio(packed struct(u32) {
            ///  fraction of USARTDIV
            DIV_Fraction: u4,
            ///  mantissa of USARTDIV
            DIV_Mantissa: u12,
            padding: u16,
        }),
        ///  Control register 1
        CR1: mmio.Mmio(packed struct(u32) {
            ///  Send break
            SBK: u1,
            ///  Receiver wakeup
            RWU: u1,
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
            ///  TXE interrupt enable
            TXEIE: u1,
            ///  PE interrupt enable
            PEIE: u1,
            ///  Parity selection
            PS: u1,
            ///  Parity control enable
            PCE: u1,
            ///  Wakeup method
            WAKE: u1,
            ///  Word length
            M: u1,
            ///  USART enable
            UE: u1,
            reserved15: u1,
            ///  Oversampling mode
            OVER8: u1,
            padding: u16,
        }),
        ///  Control register 2
        CR2: mmio.Mmio(packed struct(u32) {
            ///  Address of the USART node
            ADD: u4,
            reserved5: u1,
            ///  lin break detection length
            LBDL: u1,
            ///  LIN break detection interrupt enable
            LBDIE: u1,
            reserved12: u5,
            ///  STOP bits
            STOP: u2,
            ///  LIN mode enable
            LINEN: u1,
            padding: u17,
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
            reserved6: u2,
            ///  DMA enable receiver
            DMAR: u1,
            ///  DMA enable transmitter
            DMAT: u1,
            reserved11: u3,
            ///  One sample bit method enable
            ONEBIT: u1,
            padding: u20,
        }),
    };

    ///  USB on the go full speed
    pub const OTG_FS_DEVICE = extern struct {
        ///  OTG_FS device configuration register (OTG_FS_DCFG)
        FS_DCFG: mmio.Mmio(packed struct(u32) {
            ///  Device speed
            DSPD: u2,
            ///  Non-zero-length status OUT handshake
            NZLSOHSK: u1,
            reserved4: u1,
            ///  Device address
            DAD: u7,
            ///  Periodic frame interval
            PFIVL: u2,
            padding: u19,
        }),
        ///  OTG_FS device control register (OTG_FS_DCTL)
        FS_DCTL: mmio.Mmio(packed struct(u32) {
            ///  Remote wakeup signaling
            RWUSIG: u1,
            ///  Soft disconnect
            SDIS: u1,
            ///  Global IN NAK status
            GINSTS: u1,
            ///  Global OUT NAK status
            GONSTS: u1,
            ///  Test control
            TCTL: u3,
            ///  Set global IN NAK
            SGINAK: u1,
            ///  Clear global IN NAK
            CGINAK: u1,
            ///  Set global OUT NAK
            SGONAK: u1,
            ///  Clear global OUT NAK
            CGONAK: u1,
            ///  Power-on programming done
            POPRGDNE: u1,
            padding: u20,
        }),
        ///  OTG_FS device status register (OTG_FS_DSTS)
        FS_DSTS: mmio.Mmio(packed struct(u32) {
            ///  Suspend status
            SUSPSTS: u1,
            ///  Enumerated speed
            ENUMSPD: u2,
            ///  Erratic error
            EERR: u1,
            reserved8: u4,
            ///  Frame number of the received SOF
            FNSOF: u14,
            padding: u10,
        }),
        reserved16: [4]u8,
        ///  OTG_FS device IN endpoint common interrupt mask register (OTG_FS_DIEPMSK)
        FS_DIEPMSK: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt mask
            XFRCM: u1,
            ///  Endpoint disabled interrupt mask
            EPDM: u1,
            reserved3: u1,
            ///  Timeout condition mask (Non-isochronous endpoints)
            TOM: u1,
            ///  IN token received when TxFIFO empty mask
            ITTXFEMSK: u1,
            ///  IN token received with EP mismatch mask
            INEPNMM: u1,
            ///  IN endpoint NAK effective mask
            INEPNEM: u1,
            padding: u25,
        }),
        ///  OTG_FS device OUT endpoint common interrupt mask register (OTG_FS_DOEPMSK)
        FS_DOEPMSK: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed interrupt mask
            XFRCM: u1,
            ///  Endpoint disabled interrupt mask
            EPDM: u1,
            reserved3: u1,
            ///  SETUP phase done mask
            STUPM: u1,
            ///  OUT token received when endpoint disabled mask
            OTEPDM: u1,
            padding: u27,
        }),
        ///  OTG_FS device all endpoints interrupt register (OTG_FS_DAINT)
        FS_DAINT: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint interrupt bits
            IEPINT: u16,
            ///  OUT endpoint interrupt bits
            OEPINT: u16,
        }),
        ///  OTG_FS all endpoints interrupt mask register (OTG_FS_DAINTMSK)
        FS_DAINTMSK: mmio.Mmio(packed struct(u32) {
            ///  IN EP interrupt mask bits
            IEPM: u16,
            ///  OUT endpoint interrupt bits
            OEPINT: u16,
        }),
        reserved40: [8]u8,
        ///  OTG_FS device VBUS discharge time register
        DVBUSDIS: mmio.Mmio(packed struct(u32) {
            ///  Device VBUS discharge time
            VBUSDT: u16,
            padding: u16,
        }),
        ///  OTG_FS device VBUS pulsing time register
        DVBUSPULSE: mmio.Mmio(packed struct(u32) {
            ///  Device VBUS pulsing time
            DVBUSP: u12,
            padding: u20,
        }),
        reserved52: [4]u8,
        ///  OTG_FS device IN endpoint FIFO empty interrupt mask register
        DIEPEMPMSK: mmio.Mmio(packed struct(u32) {
            ///  IN EP Tx FIFO empty interrupt mask bits
            INEPTXFEM: u16,
            padding: u16,
        }),
        reserved256: [200]u8,
        ///  OTG_FS device control IN endpoint 0 control register (OTG_FS_DIEPCTL0)
        FS_DIEPCTL0: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u2,
            reserved15: u13,
            ///  USB active endpoint
            USBAEP: u1,
            reserved17: u1,
            ///  NAK status
            NAKSTS: u1,
            ///  Endpoint type
            EPTYP: u2,
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
            EPDIS: u1,
            ///  Endpoint enable
            EPENA: u1,
        }),
        reserved264: [4]u8,
        ///  device endpoint-x interrupt register
        DIEPINT0: mmio.Mmio(packed struct(u32) {
            ///  XFRC
            XFRC: u1,
            ///  EPDISD
            EPDISD: u1,
            reserved3: u1,
            ///  TOC
            TOC: u1,
            ///  ITTXFE
            ITTXFE: u1,
            reserved6: u1,
            ///  INEPNE
            INEPNE: u1,
            ///  TXFE
            TXFE: u1,
            padding: u24,
        }),
        reserved272: [4]u8,
        ///  device endpoint-0 transfer size register
        DIEPTSIZ0: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u7,
            reserved19: u12,
            ///  Packet count
            PKTCNT: u2,
            padding: u11,
        }),
        reserved280: [4]u8,
        ///  OTG_FS device IN endpoint transmit FIFO status register
        DTXFSTS0: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint TxFIFO space available
            INEPTFSAV: u16,
            padding: u16,
        }),
        reserved288: [4]u8,
        ///  OTG device endpoint-1 control register
        DIEPCTL1: mmio.Mmio(packed struct(u32) {
            ///  MPSIZ
            MPSIZ: u11,
            reserved15: u4,
            ///  USBAEP
            USBAEP: u1,
            ///  EONUM/DPID
            EONUM_DPID: u1,
            ///  NAKSTS
            NAKSTS: u1,
            ///  EPTYP
            EPTYP: u2,
            reserved21: u1,
            ///  Stall
            Stall: u1,
            ///  TXFNUM
            TXFNUM: u4,
            ///  CNAK
            CNAK: u1,
            ///  SNAK
            SNAK: u1,
            ///  SD0PID/SEVNFRM
            SD0PID_SEVNFRM: u1,
            ///  SODDFRM/SD1PID
            SODDFRM_SD1PID: u1,
            ///  EPDIS
            EPDIS: u1,
            ///  EPENA
            EPENA: u1,
        }),
        reserved296: [4]u8,
        ///  device endpoint-1 interrupt register
        DIEPINT1: mmio.Mmio(packed struct(u32) {
            ///  XFRC
            XFRC: u1,
            ///  EPDISD
            EPDISD: u1,
            reserved3: u1,
            ///  TOC
            TOC: u1,
            ///  ITTXFE
            ITTXFE: u1,
            reserved6: u1,
            ///  INEPNE
            INEPNE: u1,
            ///  TXFE
            TXFE: u1,
            padding: u24,
        }),
        reserved304: [4]u8,
        ///  device endpoint-1 transfer size register
        DIEPTSIZ1: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Multi count
            MCNT: u2,
            padding: u1,
        }),
        reserved312: [4]u8,
        ///  OTG_FS device IN endpoint transmit FIFO status register
        DTXFSTS1: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint TxFIFO space available
            INEPTFSAV: u16,
            padding: u16,
        }),
        reserved320: [4]u8,
        ///  OTG device endpoint-2 control register
        DIEPCTL2: mmio.Mmio(packed struct(u32) {
            ///  MPSIZ
            MPSIZ: u11,
            reserved15: u4,
            ///  USBAEP
            USBAEP: u1,
            ///  EONUM/DPID
            EONUM_DPID: u1,
            ///  NAKSTS
            NAKSTS: u1,
            ///  EPTYP
            EPTYP: u2,
            reserved21: u1,
            ///  Stall
            Stall: u1,
            ///  TXFNUM
            TXFNUM: u4,
            ///  CNAK
            CNAK: u1,
            ///  SNAK
            SNAK: u1,
            ///  SD0PID/SEVNFRM
            SD0PID_SEVNFRM: u1,
            ///  SODDFRM
            SODDFRM: u1,
            ///  EPDIS
            EPDIS: u1,
            ///  EPENA
            EPENA: u1,
        }),
        reserved328: [4]u8,
        ///  device endpoint-2 interrupt register
        DIEPINT2: mmio.Mmio(packed struct(u32) {
            ///  XFRC
            XFRC: u1,
            ///  EPDISD
            EPDISD: u1,
            reserved3: u1,
            ///  TOC
            TOC: u1,
            ///  ITTXFE
            ITTXFE: u1,
            reserved6: u1,
            ///  INEPNE
            INEPNE: u1,
            ///  TXFE
            TXFE: u1,
            padding: u24,
        }),
        reserved336: [4]u8,
        ///  device endpoint-2 transfer size register
        DIEPTSIZ2: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Multi count
            MCNT: u2,
            padding: u1,
        }),
        reserved344: [4]u8,
        ///  OTG_FS device IN endpoint transmit FIFO status register
        DTXFSTS2: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint TxFIFO space available
            INEPTFSAV: u16,
            padding: u16,
        }),
        reserved352: [4]u8,
        ///  OTG device endpoint-3 control register
        DIEPCTL3: mmio.Mmio(packed struct(u32) {
            ///  MPSIZ
            MPSIZ: u11,
            reserved15: u4,
            ///  USBAEP
            USBAEP: u1,
            ///  EONUM/DPID
            EONUM_DPID: u1,
            ///  NAKSTS
            NAKSTS: u1,
            ///  EPTYP
            EPTYP: u2,
            reserved21: u1,
            ///  Stall
            Stall: u1,
            ///  TXFNUM
            TXFNUM: u4,
            ///  CNAK
            CNAK: u1,
            ///  SNAK
            SNAK: u1,
            ///  SD0PID/SEVNFRM
            SD0PID_SEVNFRM: u1,
            ///  SODDFRM
            SODDFRM: u1,
            ///  EPDIS
            EPDIS: u1,
            ///  EPENA
            EPENA: u1,
        }),
        reserved360: [4]u8,
        ///  device endpoint-3 interrupt register
        DIEPINT3: mmio.Mmio(packed struct(u32) {
            ///  XFRC
            XFRC: u1,
            ///  EPDISD
            EPDISD: u1,
            reserved3: u1,
            ///  TOC
            TOC: u1,
            ///  ITTXFE
            ITTXFE: u1,
            reserved6: u1,
            ///  INEPNE
            INEPNE: u1,
            ///  TXFE
            TXFE: u1,
            padding: u24,
        }),
        reserved368: [4]u8,
        ///  device endpoint-3 transfer size register
        DIEPTSIZ3: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Multi count
            MCNT: u2,
            padding: u1,
        }),
        reserved376: [4]u8,
        ///  OTG_FS device IN endpoint transmit FIFO status register
        DTXFSTS3: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint TxFIFO space available
            INEPTFSAV: u16,
            padding: u16,
        }),
        reserved768: [388]u8,
        ///  device endpoint-0 control register
        DOEPCTL0: mmio.Mmio(packed struct(u32) {
            ///  MPSIZ
            MPSIZ: u2,
            reserved15: u13,
            ///  USBAEP
            USBAEP: u1,
            reserved17: u1,
            ///  NAKSTS
            NAKSTS: u1,
            ///  EPTYP
            EPTYP: u2,
            ///  SNPM
            SNPM: u1,
            ///  Stall
            Stall: u1,
            reserved26: u4,
            ///  CNAK
            CNAK: u1,
            ///  SNAK
            SNAK: u1,
            reserved30: u2,
            ///  EPDIS
            EPDIS: u1,
            ///  EPENA
            EPENA: u1,
        }),
        reserved776: [4]u8,
        ///  device endpoint-0 interrupt register
        DOEPINT0: mmio.Mmio(packed struct(u32) {
            ///  XFRC
            XFRC: u1,
            ///  EPDISD
            EPDISD: u1,
            reserved3: u1,
            ///  STUP
            STUP: u1,
            ///  OTEPDIS
            OTEPDIS: u1,
            reserved6: u1,
            ///  B2BSTUP
            B2BSTUP: u1,
            padding: u25,
        }),
        reserved784: [4]u8,
        ///  device OUT endpoint-0 transfer size register
        DOEPTSIZ0: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u7,
            reserved19: u12,
            ///  Packet count
            PKTCNT: u1,
            reserved29: u9,
            ///  SETUP packet count
            STUPCNT: u2,
            padding: u1,
        }),
        reserved800: [12]u8,
        ///  device endpoint-1 control register
        DOEPCTL1: mmio.Mmio(packed struct(u32) {
            ///  MPSIZ
            MPSIZ: u11,
            reserved15: u4,
            ///  USBAEP
            USBAEP: u1,
            ///  EONUM/DPID
            EONUM_DPID: u1,
            ///  NAKSTS
            NAKSTS: u1,
            ///  EPTYP
            EPTYP: u2,
            ///  SNPM
            SNPM: u1,
            ///  Stall
            Stall: u1,
            reserved26: u4,
            ///  CNAK
            CNAK: u1,
            ///  SNAK
            SNAK: u1,
            ///  SD0PID/SEVNFRM
            SD0PID_SEVNFRM: u1,
            ///  SODDFRM
            SODDFRM: u1,
            ///  EPDIS
            EPDIS: u1,
            ///  EPENA
            EPENA: u1,
        }),
        reserved808: [4]u8,
        ///  device endpoint-1 interrupt register
        DOEPINT1: mmio.Mmio(packed struct(u32) {
            ///  XFRC
            XFRC: u1,
            ///  EPDISD
            EPDISD: u1,
            reserved3: u1,
            ///  STUP
            STUP: u1,
            ///  OTEPDIS
            OTEPDIS: u1,
            reserved6: u1,
            ///  B2BSTUP
            B2BSTUP: u1,
            padding: u25,
        }),
        reserved816: [4]u8,
        ///  device OUT endpoint-1 transfer size register
        DOEPTSIZ1: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Received data PID/SETUP packet count
            RXDPID_STUPCNT: u2,
            padding: u1,
        }),
        reserved832: [12]u8,
        ///  device endpoint-2 control register
        DOEPCTL2: mmio.Mmio(packed struct(u32) {
            ///  MPSIZ
            MPSIZ: u11,
            reserved15: u4,
            ///  USBAEP
            USBAEP: u1,
            ///  EONUM/DPID
            EONUM_DPID: u1,
            ///  NAKSTS
            NAKSTS: u1,
            ///  EPTYP
            EPTYP: u2,
            ///  SNPM
            SNPM: u1,
            ///  Stall
            Stall: u1,
            reserved26: u4,
            ///  CNAK
            CNAK: u1,
            ///  SNAK
            SNAK: u1,
            ///  SD0PID/SEVNFRM
            SD0PID_SEVNFRM: u1,
            ///  SODDFRM
            SODDFRM: u1,
            ///  EPDIS
            EPDIS: u1,
            ///  EPENA
            EPENA: u1,
        }),
        reserved840: [4]u8,
        ///  device endpoint-2 interrupt register
        DOEPINT2: mmio.Mmio(packed struct(u32) {
            ///  XFRC
            XFRC: u1,
            ///  EPDISD
            EPDISD: u1,
            reserved3: u1,
            ///  STUP
            STUP: u1,
            ///  OTEPDIS
            OTEPDIS: u1,
            reserved6: u1,
            ///  B2BSTUP
            B2BSTUP: u1,
            padding: u25,
        }),
        reserved848: [4]u8,
        ///  device OUT endpoint-2 transfer size register
        DOEPTSIZ2: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Received data PID/SETUP packet count
            RXDPID_STUPCNT: u2,
            padding: u1,
        }),
        reserved864: [12]u8,
        ///  device endpoint-3 control register
        DOEPCTL3: mmio.Mmio(packed struct(u32) {
            ///  MPSIZ
            MPSIZ: u11,
            reserved15: u4,
            ///  USBAEP
            USBAEP: u1,
            ///  EONUM/DPID
            EONUM_DPID: u1,
            ///  NAKSTS
            NAKSTS: u1,
            ///  EPTYP
            EPTYP: u2,
            ///  SNPM
            SNPM: u1,
            ///  Stall
            Stall: u1,
            reserved26: u4,
            ///  CNAK
            CNAK: u1,
            ///  SNAK
            SNAK: u1,
            ///  SD0PID/SEVNFRM
            SD0PID_SEVNFRM: u1,
            ///  SODDFRM
            SODDFRM: u1,
            ///  EPDIS
            EPDIS: u1,
            ///  EPENA
            EPENA: u1,
        }),
        reserved872: [4]u8,
        ///  device endpoint-3 interrupt register
        DOEPINT3: mmio.Mmio(packed struct(u32) {
            ///  XFRC
            XFRC: u1,
            ///  EPDISD
            EPDISD: u1,
            reserved3: u1,
            ///  STUP
            STUP: u1,
            ///  OTEPDIS
            OTEPDIS: u1,
            reserved6: u1,
            ///  B2BSTUP
            B2BSTUP: u1,
            padding: u25,
        }),
        reserved880: [4]u8,
        ///  device OUT endpoint-3 transfer size register
        DOEPTSIZ3: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Received data PID/SETUP packet count
            RXDPID_STUPCNT: u2,
            padding: u1,
        }),
    };

    ///  Common ADC registers
    pub const C_ADC = extern struct {
        ///  ADC Common status register
        CSR: mmio.Mmio(packed struct(u32) {
            ///  Analog watchdog flag of ADC 1
            AWD1: u1,
            ///  End of conversion of ADC 1
            EOC1: u1,
            ///  Injected channel end of conversion of ADC 1
            JEOC1: u1,
            ///  Injected channel Start flag of ADC 1
            JSTRT1: u1,
            ///  Regular channel Start flag of ADC 1
            STRT1: u1,
            ///  Overrun flag of ADC 1
            OVR1: u1,
            reserved8: u2,
            ///  Analog watchdog flag of ADC 2
            AWD2: u1,
            ///  End of conversion of ADC 2
            EOC2: u1,
            ///  Injected channel end of conversion of ADC 2
            JEOC2: u1,
            ///  Injected channel Start flag of ADC 2
            JSTRT2: u1,
            ///  Regular channel Start flag of ADC 2
            STRT2: u1,
            ///  Overrun flag of ADC 2
            OVR2: u1,
            reserved16: u2,
            ///  Analog watchdog flag of ADC 3
            AWD3: u1,
            ///  End of conversion of ADC 3
            EOC3: u1,
            ///  Injected channel end of conversion of ADC 3
            JEOC3: u1,
            ///  Injected channel Start flag of ADC 3
            JSTRT3: u1,
            ///  Regular channel Start flag of ADC 3
            STRT3: u1,
            ///  Overrun flag of ADC3
            OVR3: u1,
            padding: u10,
        }),
        ///  ADC common control register
        CCR: mmio.Mmio(packed struct(u32) {
            ///  Multi ADC mode selection
            MULT: u5,
            reserved8: u3,
            ///  Delay between 2 sampling phases
            DELAY: u4,
            reserved13: u1,
            ///  DMA disable selection for multi-ADC mode
            DDS: u1,
            ///  Direct memory access mode for multi ADC mode
            DMA: u2,
            ///  ADC prescaler
            ADCPRE: u2,
            reserved22: u4,
            ///  VBAT enable
            VBATE: u1,
            ///  Temperature sensor and VREFINT enable
            TSVREFE: u1,
            padding: u8,
        }),
        ///  ADC common regular data register for dual and triple modes
        CDR: mmio.Mmio(packed struct(u32) {
            ///  1st data item of a pair of regular conversions
            DATA1: u16,
            ///  2nd data item of a pair of regular conversions
            DATA2: u16,
        }),
    };

    ///  Advanced-timers
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
            padding: u22,
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
            padding: u17,
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
            ///  External trigger filter
            ETF: u4,
            ///  External trigger prescaler
            ETPS: u2,
            ///  External clock enable
            ECE: u1,
            ///  External trigger polarity
            ETP: u1,
            padding: u16,
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
            reserved9: u1,
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
            ///  Capture/Compare control update generation
            COMG: u1,
            ///  Trigger generation
            TG: u1,
            ///  Break generation
            BG: u1,
            padding: u24,
        }),
        ///  capture/compare mode register 1 (output mode)
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
            padding: u16,
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
            OC4CE: u1,
            padding: u16,
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
            padding: u18,
        }),
        ///  counter
        CNT: mmio.Mmio(packed struct(u32) {
            ///  counter value
            CNT: u16,
            padding: u16,
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
        ///  capture/compare register 3
        CCR3: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare value
            CCR3: u16,
            padding: u16,
        }),
        ///  capture/compare register 4
        CCR4: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare value
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
            padding: u16,
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

    ///  USB on the go full speed
    pub const OTG_FS_HOST = extern struct {
        ///  OTG_FS host configuration register (OTG_FS_HCFG)
        FS_HCFG: mmio.Mmio(packed struct(u32) {
            ///  FS/LS PHY clock select
            FSLSPCS: u2,
            ///  FS- and LS-only support
            FSLSS: u1,
            padding: u29,
        }),
        ///  OTG_FS Host frame interval register
        HFIR: mmio.Mmio(packed struct(u32) {
            ///  Frame interval
            FRIVL: u16,
            padding: u16,
        }),
        ///  OTG_FS host frame number/frame time remaining register (OTG_FS_HFNUM)
        FS_HFNUM: mmio.Mmio(packed struct(u32) {
            ///  Frame number
            FRNUM: u16,
            ///  Frame time remaining
            FTREM: u16,
        }),
        reserved16: [4]u8,
        ///  OTG_FS_Host periodic transmit FIFO/queue status register (OTG_FS_HPTXSTS)
        FS_HPTXSTS: mmio.Mmio(packed struct(u32) {
            ///  Periodic transmit data FIFO space available
            PTXFSAVL: u16,
            ///  Periodic transmit request queue space available
            PTXQSAV: u8,
            ///  Top of the periodic transmit request queue
            PTXQTOP: u8,
        }),
        ///  OTG_FS Host all channels interrupt register
        HAINT: mmio.Mmio(packed struct(u32) {
            ///  Channel interrupts
            HAINT: u16,
            padding: u16,
        }),
        ///  OTG_FS host all channels interrupt mask register
        HAINTMSK: mmio.Mmio(packed struct(u32) {
            ///  Channel interrupt mask
            HAINTM: u16,
            padding: u16,
        }),
        reserved64: [36]u8,
        ///  OTG_FS host port control and status register (OTG_FS_HPRT)
        FS_HPRT: mmio.Mmio(packed struct(u32) {
            ///  Port connect status
            PCSTS: u1,
            ///  Port connect detected
            PCDET: u1,
            ///  Port enable
            PENA: u1,
            ///  Port enable/disable change
            PENCHNG: u1,
            ///  Port overcurrent active
            POCA: u1,
            ///  Port overcurrent change
            POCCHNG: u1,
            ///  Port resume
            PRES: u1,
            ///  Port suspend
            PSUSP: u1,
            ///  Port reset
            PRST: u1,
            reserved10: u1,
            ///  Port line status
            PLSTS: u2,
            ///  Port power
            PPWR: u1,
            ///  Port test control
            PTCTL: u4,
            ///  Port speed
            PSPD: u2,
            padding: u13,
        }),
        reserved256: [188]u8,
        ///  OTG_FS host channel-0 characteristics register (OTG_FS_HCCHAR0)
        FS_HCCHAR0: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            ///  Endpoint number
            EPNUM: u4,
            ///  Endpoint direction
            EPDIR: u1,
            reserved17: u1,
            ///  Low-speed device
            LSDEV: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Multicount
            MCNT: u2,
            ///  Device address
            DAD: u7,
            ///  Odd frame
            ODDFRM: u1,
            ///  Channel disable
            CHDIS: u1,
            ///  Channel enable
            CHENA: u1,
        }),
        reserved264: [4]u8,
        ///  OTG_FS host channel-0 interrupt register (OTG_FS_HCINT0)
        FS_HCINT0: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed
            XFRC: u1,
            ///  Channel halted
            CHH: u1,
            reserved3: u1,
            ///  STALL response received interrupt
            STALL: u1,
            ///  NAK response received interrupt
            NAK: u1,
            ///  ACK response received/transmitted interrupt
            ACK: u1,
            reserved7: u1,
            ///  Transaction error
            TXERR: u1,
            ///  Babble error
            BBERR: u1,
            ///  Frame overrun
            FRMOR: u1,
            ///  Data toggle error
            DTERR: u1,
            padding: u21,
        }),
        ///  OTG_FS host channel-0 mask register (OTG_FS_HCINTMSK0)
        FS_HCINTMSK0: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed mask
            XFRCM: u1,
            ///  Channel halted mask
            CHHM: u1,
            reserved3: u1,
            ///  STALL response received interrupt mask
            STALLM: u1,
            ///  NAK response received interrupt mask
            NAKM: u1,
            ///  ACK response received/transmitted interrupt mask
            ACKM: u1,
            ///  response received interrupt mask
            NYET: u1,
            ///  Transaction error mask
            TXERRM: u1,
            ///  Babble error mask
            BBERRM: u1,
            ///  Frame overrun mask
            FRMORM: u1,
            ///  Data toggle error mask
            DTERRM: u1,
            padding: u21,
        }),
        ///  OTG_FS host channel-0 transfer size register
        FS_HCTSIZ0: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Data PID
            DPID: u2,
            padding: u1,
        }),
        reserved288: [12]u8,
        ///  OTG_FS host channel-1 characteristics register (OTG_FS_HCCHAR1)
        FS_HCCHAR1: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            ///  Endpoint number
            EPNUM: u4,
            ///  Endpoint direction
            EPDIR: u1,
            reserved17: u1,
            ///  Low-speed device
            LSDEV: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Multicount
            MCNT: u2,
            ///  Device address
            DAD: u7,
            ///  Odd frame
            ODDFRM: u1,
            ///  Channel disable
            CHDIS: u1,
            ///  Channel enable
            CHENA: u1,
        }),
        reserved296: [4]u8,
        ///  OTG_FS host channel-1 interrupt register (OTG_FS_HCINT1)
        FS_HCINT1: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed
            XFRC: u1,
            ///  Channel halted
            CHH: u1,
            reserved3: u1,
            ///  STALL response received interrupt
            STALL: u1,
            ///  NAK response received interrupt
            NAK: u1,
            ///  ACK response received/transmitted interrupt
            ACK: u1,
            reserved7: u1,
            ///  Transaction error
            TXERR: u1,
            ///  Babble error
            BBERR: u1,
            ///  Frame overrun
            FRMOR: u1,
            ///  Data toggle error
            DTERR: u1,
            padding: u21,
        }),
        ///  OTG_FS host channel-1 mask register (OTG_FS_HCINTMSK1)
        FS_HCINTMSK1: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed mask
            XFRCM: u1,
            ///  Channel halted mask
            CHHM: u1,
            reserved3: u1,
            ///  STALL response received interrupt mask
            STALLM: u1,
            ///  NAK response received interrupt mask
            NAKM: u1,
            ///  ACK response received/transmitted interrupt mask
            ACKM: u1,
            ///  response received interrupt mask
            NYET: u1,
            ///  Transaction error mask
            TXERRM: u1,
            ///  Babble error mask
            BBERRM: u1,
            ///  Frame overrun mask
            FRMORM: u1,
            ///  Data toggle error mask
            DTERRM: u1,
            padding: u21,
        }),
        ///  OTG_FS host channel-1 transfer size register
        FS_HCTSIZ1: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Data PID
            DPID: u2,
            padding: u1,
        }),
        reserved320: [12]u8,
        ///  OTG_FS host channel-2 characteristics register (OTG_FS_HCCHAR2)
        FS_HCCHAR2: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            ///  Endpoint number
            EPNUM: u4,
            ///  Endpoint direction
            EPDIR: u1,
            reserved17: u1,
            ///  Low-speed device
            LSDEV: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Multicount
            MCNT: u2,
            ///  Device address
            DAD: u7,
            ///  Odd frame
            ODDFRM: u1,
            ///  Channel disable
            CHDIS: u1,
            ///  Channel enable
            CHENA: u1,
        }),
        reserved328: [4]u8,
        ///  OTG_FS host channel-2 interrupt register (OTG_FS_HCINT2)
        FS_HCINT2: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed
            XFRC: u1,
            ///  Channel halted
            CHH: u1,
            reserved3: u1,
            ///  STALL response received interrupt
            STALL: u1,
            ///  NAK response received interrupt
            NAK: u1,
            ///  ACK response received/transmitted interrupt
            ACK: u1,
            reserved7: u1,
            ///  Transaction error
            TXERR: u1,
            ///  Babble error
            BBERR: u1,
            ///  Frame overrun
            FRMOR: u1,
            ///  Data toggle error
            DTERR: u1,
            padding: u21,
        }),
        ///  OTG_FS host channel-2 mask register (OTG_FS_HCINTMSK2)
        FS_HCINTMSK2: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed mask
            XFRCM: u1,
            ///  Channel halted mask
            CHHM: u1,
            reserved3: u1,
            ///  STALL response received interrupt mask
            STALLM: u1,
            ///  NAK response received interrupt mask
            NAKM: u1,
            ///  ACK response received/transmitted interrupt mask
            ACKM: u1,
            ///  response received interrupt mask
            NYET: u1,
            ///  Transaction error mask
            TXERRM: u1,
            ///  Babble error mask
            BBERRM: u1,
            ///  Frame overrun mask
            FRMORM: u1,
            ///  Data toggle error mask
            DTERRM: u1,
            padding: u21,
        }),
        ///  OTG_FS host channel-2 transfer size register
        FS_HCTSIZ2: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Data PID
            DPID: u2,
            padding: u1,
        }),
        reserved352: [12]u8,
        ///  OTG_FS host channel-3 characteristics register (OTG_FS_HCCHAR3)
        FS_HCCHAR3: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            ///  Endpoint number
            EPNUM: u4,
            ///  Endpoint direction
            EPDIR: u1,
            reserved17: u1,
            ///  Low-speed device
            LSDEV: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Multicount
            MCNT: u2,
            ///  Device address
            DAD: u7,
            ///  Odd frame
            ODDFRM: u1,
            ///  Channel disable
            CHDIS: u1,
            ///  Channel enable
            CHENA: u1,
        }),
        reserved360: [4]u8,
        ///  OTG_FS host channel-3 interrupt register (OTG_FS_HCINT3)
        FS_HCINT3: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed
            XFRC: u1,
            ///  Channel halted
            CHH: u1,
            reserved3: u1,
            ///  STALL response received interrupt
            STALL: u1,
            ///  NAK response received interrupt
            NAK: u1,
            ///  ACK response received/transmitted interrupt
            ACK: u1,
            reserved7: u1,
            ///  Transaction error
            TXERR: u1,
            ///  Babble error
            BBERR: u1,
            ///  Frame overrun
            FRMOR: u1,
            ///  Data toggle error
            DTERR: u1,
            padding: u21,
        }),
        ///  OTG_FS host channel-3 mask register (OTG_FS_HCINTMSK3)
        FS_HCINTMSK3: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed mask
            XFRCM: u1,
            ///  Channel halted mask
            CHHM: u1,
            reserved3: u1,
            ///  STALL response received interrupt mask
            STALLM: u1,
            ///  NAK response received interrupt mask
            NAKM: u1,
            ///  ACK response received/transmitted interrupt mask
            ACKM: u1,
            ///  response received interrupt mask
            NYET: u1,
            ///  Transaction error mask
            TXERRM: u1,
            ///  Babble error mask
            BBERRM: u1,
            ///  Frame overrun mask
            FRMORM: u1,
            ///  Data toggle error mask
            DTERRM: u1,
            padding: u21,
        }),
        ///  OTG_FS host channel-3 transfer size register
        FS_HCTSIZ3: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Data PID
            DPID: u2,
            padding: u1,
        }),
        reserved384: [12]u8,
        ///  OTG_FS host channel-4 characteristics register (OTG_FS_HCCHAR4)
        FS_HCCHAR4: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            ///  Endpoint number
            EPNUM: u4,
            ///  Endpoint direction
            EPDIR: u1,
            reserved17: u1,
            ///  Low-speed device
            LSDEV: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Multicount
            MCNT: u2,
            ///  Device address
            DAD: u7,
            ///  Odd frame
            ODDFRM: u1,
            ///  Channel disable
            CHDIS: u1,
            ///  Channel enable
            CHENA: u1,
        }),
        reserved392: [4]u8,
        ///  OTG_FS host channel-4 interrupt register (OTG_FS_HCINT4)
        FS_HCINT4: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed
            XFRC: u1,
            ///  Channel halted
            CHH: u1,
            reserved3: u1,
            ///  STALL response received interrupt
            STALL: u1,
            ///  NAK response received interrupt
            NAK: u1,
            ///  ACK response received/transmitted interrupt
            ACK: u1,
            reserved7: u1,
            ///  Transaction error
            TXERR: u1,
            ///  Babble error
            BBERR: u1,
            ///  Frame overrun
            FRMOR: u1,
            ///  Data toggle error
            DTERR: u1,
            padding: u21,
        }),
        ///  OTG_FS host channel-4 mask register (OTG_FS_HCINTMSK4)
        FS_HCINTMSK4: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed mask
            XFRCM: u1,
            ///  Channel halted mask
            CHHM: u1,
            reserved3: u1,
            ///  STALL response received interrupt mask
            STALLM: u1,
            ///  NAK response received interrupt mask
            NAKM: u1,
            ///  ACK response received/transmitted interrupt mask
            ACKM: u1,
            ///  response received interrupt mask
            NYET: u1,
            ///  Transaction error mask
            TXERRM: u1,
            ///  Babble error mask
            BBERRM: u1,
            ///  Frame overrun mask
            FRMORM: u1,
            ///  Data toggle error mask
            DTERRM: u1,
            padding: u21,
        }),
        ///  OTG_FS host channel-x transfer size register
        FS_HCTSIZ4: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Data PID
            DPID: u2,
            padding: u1,
        }),
        reserved416: [12]u8,
        ///  OTG_FS host channel-5 characteristics register (OTG_FS_HCCHAR5)
        FS_HCCHAR5: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            ///  Endpoint number
            EPNUM: u4,
            ///  Endpoint direction
            EPDIR: u1,
            reserved17: u1,
            ///  Low-speed device
            LSDEV: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Multicount
            MCNT: u2,
            ///  Device address
            DAD: u7,
            ///  Odd frame
            ODDFRM: u1,
            ///  Channel disable
            CHDIS: u1,
            ///  Channel enable
            CHENA: u1,
        }),
        reserved424: [4]u8,
        ///  OTG_FS host channel-5 interrupt register (OTG_FS_HCINT5)
        FS_HCINT5: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed
            XFRC: u1,
            ///  Channel halted
            CHH: u1,
            reserved3: u1,
            ///  STALL response received interrupt
            STALL: u1,
            ///  NAK response received interrupt
            NAK: u1,
            ///  ACK response received/transmitted interrupt
            ACK: u1,
            reserved7: u1,
            ///  Transaction error
            TXERR: u1,
            ///  Babble error
            BBERR: u1,
            ///  Frame overrun
            FRMOR: u1,
            ///  Data toggle error
            DTERR: u1,
            padding: u21,
        }),
        ///  OTG_FS host channel-5 mask register (OTG_FS_HCINTMSK5)
        FS_HCINTMSK5: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed mask
            XFRCM: u1,
            ///  Channel halted mask
            CHHM: u1,
            reserved3: u1,
            ///  STALL response received interrupt mask
            STALLM: u1,
            ///  NAK response received interrupt mask
            NAKM: u1,
            ///  ACK response received/transmitted interrupt mask
            ACKM: u1,
            ///  response received interrupt mask
            NYET: u1,
            ///  Transaction error mask
            TXERRM: u1,
            ///  Babble error mask
            BBERRM: u1,
            ///  Frame overrun mask
            FRMORM: u1,
            ///  Data toggle error mask
            DTERRM: u1,
            padding: u21,
        }),
        ///  OTG_FS host channel-5 transfer size register
        FS_HCTSIZ5: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Data PID
            DPID: u2,
            padding: u1,
        }),
        reserved448: [12]u8,
        ///  OTG_FS host channel-6 characteristics register (OTG_FS_HCCHAR6)
        FS_HCCHAR6: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            ///  Endpoint number
            EPNUM: u4,
            ///  Endpoint direction
            EPDIR: u1,
            reserved17: u1,
            ///  Low-speed device
            LSDEV: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Multicount
            MCNT: u2,
            ///  Device address
            DAD: u7,
            ///  Odd frame
            ODDFRM: u1,
            ///  Channel disable
            CHDIS: u1,
            ///  Channel enable
            CHENA: u1,
        }),
        reserved456: [4]u8,
        ///  OTG_FS host channel-6 interrupt register (OTG_FS_HCINT6)
        FS_HCINT6: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed
            XFRC: u1,
            ///  Channel halted
            CHH: u1,
            reserved3: u1,
            ///  STALL response received interrupt
            STALL: u1,
            ///  NAK response received interrupt
            NAK: u1,
            ///  ACK response received/transmitted interrupt
            ACK: u1,
            reserved7: u1,
            ///  Transaction error
            TXERR: u1,
            ///  Babble error
            BBERR: u1,
            ///  Frame overrun
            FRMOR: u1,
            ///  Data toggle error
            DTERR: u1,
            padding: u21,
        }),
        ///  OTG_FS host channel-6 mask register (OTG_FS_HCINTMSK6)
        FS_HCINTMSK6: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed mask
            XFRCM: u1,
            ///  Channel halted mask
            CHHM: u1,
            reserved3: u1,
            ///  STALL response received interrupt mask
            STALLM: u1,
            ///  NAK response received interrupt mask
            NAKM: u1,
            ///  ACK response received/transmitted interrupt mask
            ACKM: u1,
            ///  response received interrupt mask
            NYET: u1,
            ///  Transaction error mask
            TXERRM: u1,
            ///  Babble error mask
            BBERRM: u1,
            ///  Frame overrun mask
            FRMORM: u1,
            ///  Data toggle error mask
            DTERRM: u1,
            padding: u21,
        }),
        ///  OTG_FS host channel-6 transfer size register
        FS_HCTSIZ6: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Data PID
            DPID: u2,
            padding: u1,
        }),
        reserved480: [12]u8,
        ///  OTG_FS host channel-7 characteristics register (OTG_FS_HCCHAR7)
        FS_HCCHAR7: mmio.Mmio(packed struct(u32) {
            ///  Maximum packet size
            MPSIZ: u11,
            ///  Endpoint number
            EPNUM: u4,
            ///  Endpoint direction
            EPDIR: u1,
            reserved17: u1,
            ///  Low-speed device
            LSDEV: u1,
            ///  Endpoint type
            EPTYP: u2,
            ///  Multicount
            MCNT: u2,
            ///  Device address
            DAD: u7,
            ///  Odd frame
            ODDFRM: u1,
            ///  Channel disable
            CHDIS: u1,
            ///  Channel enable
            CHENA: u1,
        }),
        reserved488: [4]u8,
        ///  OTG_FS host channel-7 interrupt register (OTG_FS_HCINT7)
        FS_HCINT7: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed
            XFRC: u1,
            ///  Channel halted
            CHH: u1,
            reserved3: u1,
            ///  STALL response received interrupt
            STALL: u1,
            ///  NAK response received interrupt
            NAK: u1,
            ///  ACK response received/transmitted interrupt
            ACK: u1,
            reserved7: u1,
            ///  Transaction error
            TXERR: u1,
            ///  Babble error
            BBERR: u1,
            ///  Frame overrun
            FRMOR: u1,
            ///  Data toggle error
            DTERR: u1,
            padding: u21,
        }),
        ///  OTG_FS host channel-7 mask register (OTG_FS_HCINTMSK7)
        FS_HCINTMSK7: mmio.Mmio(packed struct(u32) {
            ///  Transfer completed mask
            XFRCM: u1,
            ///  Channel halted mask
            CHHM: u1,
            reserved3: u1,
            ///  STALL response received interrupt mask
            STALLM: u1,
            ///  NAK response received interrupt mask
            NAKM: u1,
            ///  ACK response received/transmitted interrupt mask
            ACKM: u1,
            ///  response received interrupt mask
            NYET: u1,
            ///  Transaction error mask
            TXERRM: u1,
            ///  Babble error mask
            BBERRM: u1,
            ///  Frame overrun mask
            FRMORM: u1,
            ///  Data toggle error mask
            DTERRM: u1,
            padding: u21,
        }),
        ///  OTG_FS host channel-7 transfer size register
        FS_HCTSIZ7: mmio.Mmio(packed struct(u32) {
            ///  Transfer size
            XFRSIZ: u19,
            ///  Packet count
            PKTCNT: u10,
            ///  Data PID
            DPID: u2,
            padding: u1,
        }),
    };

    ///  General purpose timers
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
            padding: u22,
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
            reserved4: u1,
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
            padding: u16,
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
            ///  CC1S
            CC1S: u2,
            ///  OC1FE
            OC1FE: u1,
            ///  OC1PE
            OC1PE: u1,
            ///  OC1M
            OC1M: u3,
            ///  OC1CE
            OC1CE: u1,
            ///  CC2S
            CC2S: u2,
            ///  OC2FE
            OC2FE: u1,
            ///  OC2PE
            OC2PE: u1,
            ///  OC2M
            OC2M: u3,
            ///  OC2CE
            OC2CE: u1,
            padding: u16,
        }),
        ///  capture/compare mode register 2 (output mode)
        CCMR2_Output: mmio.Mmio(packed struct(u32) {
            ///  CC3S
            CC3S: u2,
            ///  OC3FE
            OC3FE: u1,
            ///  OC3PE
            OC3PE: u1,
            ///  OC3M
            OC3M: u3,
            ///  OC3CE
            OC3CE: u1,
            ///  CC4S
            CC4S: u2,
            ///  OC4FE
            OC4FE: u1,
            ///  OC4PE
            OC4PE: u1,
            ///  OC4M
            OC4M: u3,
            ///  O24CE
            O24CE: u1,
            padding: u16,
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
            ///  Capture/Compare 4 output Polarity
            CC4NP: u1,
            padding: u16,
        }),
        ///  counter
        CNT: mmio.Mmio(packed struct(u32) {
            ///  Low counter value
            CNT_L: u16,
            ///  High counter value
            CNT_H: u16,
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
            ARR_L: u16,
            ///  High Auto-reload value
            ARR_H: u16,
        }),
        reserved52: [4]u8,
        ///  capture/compare register 1
        CCR1: mmio.Mmio(packed struct(u32) {
            ///  Low Capture/Compare 1 value
            CCR1_L: u16,
            ///  High Capture/Compare 1 value
            CCR1_H: u16,
        }),
        ///  capture/compare register 2
        CCR2: mmio.Mmio(packed struct(u32) {
            ///  Low Capture/Compare 2 value
            CCR2_L: u16,
            ///  High Capture/Compare 2 value
            CCR2_H: u16,
        }),
        ///  capture/compare register 3
        CCR3: mmio.Mmio(packed struct(u32) {
            ///  Low Capture/Compare value
            CCR3_L: u16,
            ///  High Capture/Compare value
            CCR3_H: u16,
        }),
        ///  capture/compare register 4
        CCR4: mmio.Mmio(packed struct(u32) {
            ///  Low Capture/Compare value
            CCR4_L: u16,
            ///  High Capture/Compare value
            CCR4_H: u16,
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
        ///  TIM5 option register
        OR: mmio.Mmio(packed struct(u32) {
            reserved10: u10,
            ///  Timer Input 4 remap
            ITR1_RMP: u2,
            padding: u20,
        }),
    };

    ///  General purpose timers
    pub const TIM3 = extern struct {
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
            padding: u22,
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
            reserved4: u1,
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
            padding: u16,
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
            ///  CC1S
            CC1S: u2,
            ///  OC1FE
            OC1FE: u1,
            ///  OC1PE
            OC1PE: u1,
            ///  OC1M
            OC1M: u3,
            ///  OC1CE
            OC1CE: u1,
            ///  CC2S
            CC2S: u2,
            ///  OC2FE
            OC2FE: u1,
            ///  OC2PE
            OC2PE: u1,
            ///  OC2M
            OC2M: u3,
            ///  OC2CE
            OC2CE: u1,
            padding: u16,
        }),
        ///  capture/compare mode register 2 (output mode)
        CCMR2_Output: mmio.Mmio(packed struct(u32) {
            ///  CC3S
            CC3S: u2,
            ///  OC3FE
            OC3FE: u1,
            ///  OC3PE
            OC3PE: u1,
            ///  OC3M
            OC3M: u3,
            ///  OC3CE
            OC3CE: u1,
            ///  CC4S
            CC4S: u2,
            ///  OC4FE
            OC4FE: u1,
            ///  OC4PE
            OC4PE: u1,
            ///  OC4M
            OC4M: u3,
            ///  O24CE
            O24CE: u1,
            padding: u16,
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
            ///  Capture/Compare 4 output Polarity
            CC4NP: u1,
            padding: u16,
        }),
        ///  counter
        CNT: mmio.Mmio(packed struct(u32) {
            ///  Low counter value
            CNT_L: u16,
            ///  High counter value
            CNT_H: u16,
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
            ARR_L: u16,
            ///  High Auto-reload value
            ARR_H: u16,
        }),
        reserved52: [4]u8,
        ///  capture/compare register 1
        CCR1: mmio.Mmio(packed struct(u32) {
            ///  Low Capture/Compare 1 value
            CCR1_L: u16,
            ///  High Capture/Compare 1 value
            CCR1_H: u16,
        }),
        ///  capture/compare register 2
        CCR2: mmio.Mmio(packed struct(u32) {
            ///  Low Capture/Compare 2 value
            CCR2_L: u16,
            ///  High Capture/Compare 2 value
            CCR2_H: u16,
        }),
        ///  capture/compare register 3
        CCR3: mmio.Mmio(packed struct(u32) {
            ///  Low Capture/Compare value
            CCR3_L: u16,
            ///  High Capture/Compare value
            CCR3_H: u16,
        }),
        ///  capture/compare register 4
        CCR4: mmio.Mmio(packed struct(u32) {
            ///  Low Capture/Compare value
            CCR4_L: u16,
            ///  High Capture/Compare value
            CCR4_H: u16,
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

    ///  USB on the go full speed
    pub const OTG_FS_GLOBAL = extern struct {
        ///  OTG_FS control and status register (OTG_FS_GOTGCTL)
        FS_GOTGCTL: mmio.Mmio(packed struct(u32) {
            ///  Session request success
            SRQSCS: u1,
            ///  Session request
            SRQ: u1,
            reserved8: u6,
            ///  Host negotiation success
            HNGSCS: u1,
            ///  HNP request
            HNPRQ: u1,
            ///  Host set HNP enable
            HSHNPEN: u1,
            ///  Device HNP enabled
            DHNPEN: u1,
            reserved16: u4,
            ///  Connector ID status
            CIDSTS: u1,
            ///  Long/short debounce time
            DBCT: u1,
            ///  A-session valid
            ASVLD: u1,
            ///  B-session valid
            BSVLD: u1,
            padding: u12,
        }),
        ///  OTG_FS interrupt register (OTG_FS_GOTGINT)
        FS_GOTGINT: mmio.Mmio(packed struct(u32) {
            reserved2: u2,
            ///  Session end detected
            SEDET: u1,
            reserved8: u5,
            ///  Session request success status change
            SRSSCHG: u1,
            ///  Host negotiation success status change
            HNSSCHG: u1,
            reserved17: u7,
            ///  Host negotiation detected
            HNGDET: u1,
            ///  A-device timeout change
            ADTOCHG: u1,
            ///  Debounce done
            DBCDNE: u1,
            padding: u12,
        }),
        ///  OTG_FS AHB configuration register (OTG_FS_GAHBCFG)
        FS_GAHBCFG: mmio.Mmio(packed struct(u32) {
            ///  Global interrupt mask
            GINT: u1,
            reserved7: u6,
            ///  TxFIFO empty level
            TXFELVL: u1,
            ///  Periodic TxFIFO empty level
            PTXFELVL: u1,
            padding: u23,
        }),
        ///  OTG_FS USB configuration register (OTG_FS_GUSBCFG)
        FS_GUSBCFG: mmio.Mmio(packed struct(u32) {
            ///  FS timeout calibration
            TOCAL: u3,
            reserved6: u3,
            ///  Full Speed serial transceiver select
            PHYSEL: u1,
            reserved8: u1,
            ///  SRP-capable
            SRPCAP: u1,
            ///  HNP-capable
            HNPCAP: u1,
            ///  USB turnaround time
            TRDT: u4,
            reserved29: u15,
            ///  Force host mode
            FHMOD: u1,
            ///  Force device mode
            FDMOD: u1,
            ///  Corrupt Tx packet
            CTXPKT: u1,
        }),
        ///  OTG_FS reset register (OTG_FS_GRSTCTL)
        FS_GRSTCTL: mmio.Mmio(packed struct(u32) {
            ///  Core soft reset
            CSRST: u1,
            ///  HCLK soft reset
            HSRST: u1,
            ///  Host frame counter reset
            FCRST: u1,
            reserved4: u1,
            ///  RxFIFO flush
            RXFFLSH: u1,
            ///  TxFIFO flush
            TXFFLSH: u1,
            ///  TxFIFO number
            TXFNUM: u5,
            reserved31: u20,
            ///  AHB master idle
            AHBIDL: u1,
        }),
        ///  OTG_FS core interrupt register (OTG_FS_GINTSTS)
        FS_GINTSTS: mmio.Mmio(packed struct(u32) {
            ///  Current mode of operation
            CMOD: u1,
            ///  Mode mismatch interrupt
            MMIS: u1,
            ///  OTG interrupt
            OTGINT: u1,
            ///  Start of frame
            SOF: u1,
            ///  RxFIFO non-empty
            RXFLVL: u1,
            ///  Non-periodic TxFIFO empty
            NPTXFE: u1,
            ///  Global IN non-periodic NAK effective
            GINAKEFF: u1,
            ///  Global OUT NAK effective
            GOUTNAKEFF: u1,
            reserved10: u2,
            ///  Early suspend
            ESUSP: u1,
            ///  USB suspend
            USBSUSP: u1,
            ///  USB reset
            USBRST: u1,
            ///  Enumeration done
            ENUMDNE: u1,
            ///  Isochronous OUT packet dropped interrupt
            ISOODRP: u1,
            ///  End of periodic frame interrupt
            EOPF: u1,
            reserved18: u2,
            ///  IN endpoint interrupt
            IEPINT: u1,
            ///  OUT endpoint interrupt
            OEPINT: u1,
            ///  Incomplete isochronous IN transfer
            IISOIXFR: u1,
            ///  Incomplete periodic transfer(Host mode)/Incomplete isochronous OUT transfer(Device mode)
            IPXFR_INCOMPISOOUT: u1,
            reserved24: u2,
            ///  Host port interrupt
            HPRTINT: u1,
            ///  Host channels interrupt
            HCINT: u1,
            ///  Periodic TxFIFO empty
            PTXFE: u1,
            reserved28: u1,
            ///  Connector ID status change
            CIDSCHG: u1,
            ///  Disconnect detected interrupt
            DISCINT: u1,
            ///  Session request/new session detected interrupt
            SRQINT: u1,
            ///  Resume/remote wakeup detected interrupt
            WKUPINT: u1,
        }),
        ///  OTG_FS interrupt mask register (OTG_FS_GINTMSK)
        FS_GINTMSK: mmio.Mmio(packed struct(u32) {
            reserved1: u1,
            ///  Mode mismatch interrupt mask
            MMISM: u1,
            ///  OTG interrupt mask
            OTGINT: u1,
            ///  Start of frame mask
            SOFM: u1,
            ///  Receive FIFO non-empty mask
            RXFLVLM: u1,
            ///  Non-periodic TxFIFO empty mask
            NPTXFEM: u1,
            ///  Global non-periodic IN NAK effective mask
            GINAKEFFM: u1,
            ///  Global OUT NAK effective mask
            GONAKEFFM: u1,
            reserved10: u2,
            ///  Early suspend mask
            ESUSPM: u1,
            ///  USB suspend mask
            USBSUSPM: u1,
            ///  USB reset mask
            USBRST: u1,
            ///  Enumeration done mask
            ENUMDNEM: u1,
            ///  Isochronous OUT packet dropped interrupt mask
            ISOODRPM: u1,
            ///  End of periodic frame interrupt mask
            EOPFM: u1,
            reserved17: u1,
            ///  Endpoint mismatch interrupt mask
            EPMISM: u1,
            ///  IN endpoints interrupt mask
            IEPINT: u1,
            ///  OUT endpoints interrupt mask
            OEPINT: u1,
            ///  Incomplete isochronous IN transfer mask
            IISOIXFRM: u1,
            ///  Incomplete periodic transfer mask(Host mode)/Incomplete isochronous OUT transfer mask(Device mode)
            IPXFRM_IISOOXFRM: u1,
            reserved24: u2,
            ///  Host port interrupt mask
            PRTIM: u1,
            ///  Host channels interrupt mask
            HCIM: u1,
            ///  Periodic TxFIFO empty mask
            PTXFEM: u1,
            reserved28: u1,
            ///  Connector ID status change mask
            CIDSCHGM: u1,
            ///  Disconnect detected interrupt mask
            DISCINT: u1,
            ///  Session request/new session detected interrupt mask
            SRQIM: u1,
            ///  Resume/remote wakeup detected interrupt mask
            WUIM: u1,
        }),
        ///  OTG_FS Receive status debug read(Device mode)
        FS_GRXSTSR_Device: mmio.Mmio(packed struct(u32) {
            ///  Endpoint number
            EPNUM: u4,
            ///  Byte count
            BCNT: u11,
            ///  Data PID
            DPID: u2,
            ///  Packet status
            PKTSTS: u4,
            ///  Frame number
            FRMNUM: u4,
            padding: u7,
        }),
        reserved36: [4]u8,
        ///  OTG_FS Receive FIFO size register (OTG_FS_GRXFSIZ)
        FS_GRXFSIZ: mmio.Mmio(packed struct(u32) {
            ///  RxFIFO depth
            RXFD: u16,
            padding: u16,
        }),
        ///  OTG_FS non-periodic transmit FIFO size register (Device mode)
        FS_GNPTXFSIZ_Device: mmio.Mmio(packed struct(u32) {
            ///  Endpoint 0 transmit RAM start address
            TX0FSA: u16,
            ///  Endpoint 0 TxFIFO depth
            TX0FD: u16,
        }),
        ///  OTG_FS non-periodic transmit FIFO/queue status register (OTG_FS_GNPTXSTS)
        FS_GNPTXSTS: mmio.Mmio(packed struct(u32) {
            ///  Non-periodic TxFIFO space available
            NPTXFSAV: u16,
            ///  Non-periodic transmit request queue space available
            NPTQXSAV: u8,
            ///  Top of the non-periodic transmit request queue
            NPTXQTOP: u7,
            padding: u1,
        }),
        reserved56: [8]u8,
        ///  OTG_FS general core configuration register (OTG_FS_GCCFG)
        FS_GCCFG: mmio.Mmio(packed struct(u32) {
            reserved16: u16,
            ///  Power down
            PWRDWN: u1,
            reserved18: u1,
            ///  Enable the VBUS sensing device
            VBUSASEN: u1,
            ///  Enable the VBUS sensing device
            VBUSBSEN: u1,
            ///  SOF output enable
            SOFOUTEN: u1,
            padding: u11,
        }),
        ///  core ID register
        FS_CID: mmio.Mmio(packed struct(u32) {
            ///  Product ID field
            PRODUCT_ID: u32,
        }),
        reserved256: [192]u8,
        ///  OTG_FS Host periodic transmit FIFO size register (OTG_FS_HPTXFSIZ)
        FS_HPTXFSIZ: mmio.Mmio(packed struct(u32) {
            ///  Host periodic TxFIFO start address
            PTXSA: u16,
            ///  Host periodic TxFIFO depth
            PTXFSIZ: u16,
        }),
        ///  OTG_FS device IN endpoint transmit FIFO size register (OTG_FS_DIEPTXF2)
        FS_DIEPTXF1: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint FIFO2 transmit RAM start address
            INEPTXSA: u16,
            ///  IN endpoint TxFIFO depth
            INEPTXFD: u16,
        }),
        ///  OTG_FS device IN endpoint transmit FIFO size register (OTG_FS_DIEPTXF3)
        FS_DIEPTXF2: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint FIFO3 transmit RAM start address
            INEPTXSA: u16,
            ///  IN endpoint TxFIFO depth
            INEPTXFD: u16,
        }),
        ///  OTG_FS device IN endpoint transmit FIFO size register (OTG_FS_DIEPTXF4)
        FS_DIEPTXF3: mmio.Mmio(packed struct(u32) {
            ///  IN endpoint FIFO4 transmit RAM start address
            INEPTXSA: u16,
            ///  IN endpoint TxFIFO depth
            INEPTXFD: u16,
        }),
    };

    ///  General-purpose-timers
    pub const TIM5 = extern struct {
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
            padding: u22,
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
            reserved4: u1,
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
            padding: u16,
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
            ///  CC1S
            CC1S: u2,
            ///  OC1FE
            OC1FE: u1,
            ///  OC1PE
            OC1PE: u1,
            ///  OC1M
            OC1M: u3,
            ///  OC1CE
            OC1CE: u1,
            ///  CC2S
            CC2S: u2,
            ///  OC2FE
            OC2FE: u1,
            ///  OC2PE
            OC2PE: u1,
            ///  OC2M
            OC2M: u3,
            ///  OC2CE
            OC2CE: u1,
            padding: u16,
        }),
        ///  capture/compare mode register 2 (output mode)
        CCMR2_Output: mmio.Mmio(packed struct(u32) {
            ///  CC3S
            CC3S: u2,
            ///  OC3FE
            OC3FE: u1,
            ///  OC3PE
            OC3PE: u1,
            ///  OC3M
            OC3M: u3,
            ///  OC3CE
            OC3CE: u1,
            ///  CC4S
            CC4S: u2,
            ///  OC4FE
            OC4FE: u1,
            ///  OC4PE
            OC4PE: u1,
            ///  OC4M
            OC4M: u3,
            ///  O24CE
            O24CE: u1,
            padding: u16,
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
            ///  Capture/Compare 4 output Polarity
            CC4NP: u1,
            padding: u16,
        }),
        ///  counter
        CNT: mmio.Mmio(packed struct(u32) {
            ///  Low counter value
            CNT_L: u16,
            ///  High counter value
            CNT_H: u16,
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
            ARR_L: u16,
            ///  High Auto-reload value
            ARR_H: u16,
        }),
        reserved52: [4]u8,
        ///  capture/compare register 1
        CCR1: mmio.Mmio(packed struct(u32) {
            ///  Low Capture/Compare 1 value
            CCR1_L: u16,
            ///  High Capture/Compare 1 value
            CCR1_H: u16,
        }),
        ///  capture/compare register 2
        CCR2: mmio.Mmio(packed struct(u32) {
            ///  Low Capture/Compare 2 value
            CCR2_L: u16,
            ///  High Capture/Compare 2 value
            CCR2_H: u16,
        }),
        ///  capture/compare register 3
        CCR3: mmio.Mmio(packed struct(u32) {
            ///  Low Capture/Compare value
            CCR3_L: u16,
            ///  High Capture/Compare value
            CCR3_H: u16,
        }),
        ///  capture/compare register 4
        CCR4: mmio.Mmio(packed struct(u32) {
            ///  Low Capture/Compare value
            CCR4_L: u16,
            ///  High Capture/Compare value
            CCR4_H: u16,
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
        ///  TIM5 option register
        OR: mmio.Mmio(packed struct(u32) {
            reserved6: u6,
            ///  Timer Input 4 remap
            IT4_RMP: u2,
            padding: u24,
        }),
    };

    ///  General purpose timers
    pub const TIM9 = extern struct {
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
            padding: u22,
        }),
        ///  control register 2
        CR2: mmio.Mmio(packed struct(u32) {
            reserved4: u4,
            ///  Master mode selection
            MMS: u3,
            padding: u25,
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
            padding: u24,
        }),
        ///  DMA/Interrupt enable register
        DIER: mmio.Mmio(packed struct(u32) {
            ///  Update interrupt enable
            UIE: u1,
            ///  Capture/Compare 1 interrupt enable
            CC1IE: u1,
            ///  Capture/Compare 2 interrupt enable
            CC2IE: u1,
            reserved6: u3,
            ///  Trigger interrupt enable
            TIE: u1,
            padding: u25,
        }),
        ///  status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Update interrupt flag
            UIF: u1,
            ///  Capture/compare 1 interrupt flag
            CC1IF: u1,
            ///  Capture/Compare 2 interrupt flag
            CC2IF: u1,
            reserved6: u3,
            ///  Trigger interrupt flag
            TIF: u1,
            reserved9: u2,
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
            reserved6: u3,
            ///  Trigger generation
            TG: u1,
            padding: u25,
        }),
        ///  capture/compare mode register 1 (output mode)
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
            padding: u17,
        }),
        reserved32: [4]u8,
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
            padding: u24,
        }),
        ///  counter
        CNT: mmio.Mmio(packed struct(u32) {
            ///  counter value
            CNT: u16,
            padding: u16,
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
        reserved52: [4]u8,
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
    };

    ///  Cryptographic processor
    pub const CRC = extern struct {
        ///  Data register
        DR: mmio.Mmio(packed struct(u32) {
            ///  Data Register
            DR: u32,
        }),
        ///  Independent Data register
        IDR: mmio.Mmio(packed struct(u32) {
            ///  Independent Data register
            IDR: u8,
            padding: u24,
        }),
        ///  Control register
        CR: mmio.Mmio(packed struct(u32) {
            ///  Control regidter
            CR: u1,
            padding: u31,
        }),
    };

    ///  General-purpose-timers
    pub const TIM10 = extern struct {
        ///  control register 1
        CR1: mmio.Mmio(packed struct(u32) {
            ///  Counter enable
            CEN: u1,
            ///  Update disable
            UDIS: u1,
            ///  Update request source
            URS: u1,
            reserved7: u4,
            ///  Auto-reload preload enable
            ARPE: u1,
            ///  Clock division
            CKD: u2,
            padding: u22,
        }),
        reserved12: [8]u8,
        ///  DMA/Interrupt enable register
        DIER: mmio.Mmio(packed struct(u32) {
            ///  Update interrupt enable
            UIE: u1,
            ///  Capture/Compare 1 interrupt enable
            CC1IE: u1,
            padding: u30,
        }),
        ///  status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Update interrupt flag
            UIF: u1,
            ///  Capture/compare 1 interrupt flag
            CC1IF: u1,
            reserved9: u7,
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
            padding: u30,
        }),
        ///  capture/compare mode register 1 (output mode)
        CCMR1_Output: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 selection
            CC1S: u2,
            ///  Output Compare 1 fast enable
            OC1FE: u1,
            ///  Output Compare 1 preload enable
            OC1PE: u1,
            ///  Output Compare 1 mode
            OC1M: u3,
            padding: u25,
        }),
        reserved32: [4]u8,
        ///  capture/compare enable register
        CCER: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 output enable
            CC1E: u1,
            ///  Capture/Compare 1 output Polarity
            CC1P: u1,
            reserved3: u1,
            ///  Capture/Compare 1 output Polarity
            CC1NP: u1,
            padding: u28,
        }),
        ///  counter
        CNT: mmio.Mmio(packed struct(u32) {
            ///  counter value
            CNT: u16,
            padding: u16,
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
        reserved52: [4]u8,
        ///  capture/compare register 1
        CCR1: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 value
            CCR1: u16,
            padding: u16,
        }),
    };

    ///  Ethernet: DMA controller operation
    pub const Ethernet_DMA = extern struct {
        ///  Ethernet DMA bus mode register
        DMABMR: mmio.Mmio(packed struct(u32) {
            ///  SR
            SR: u1,
            ///  DA
            DA: u1,
            ///  DSL
            DSL: u5,
            ///  EDFE
            EDFE: u1,
            ///  PBL
            PBL: u6,
            ///  RTPR
            RTPR: u2,
            ///  FB
            FB: u1,
            ///  RDP
            RDP: u6,
            ///  USP
            USP: u1,
            ///  FPM
            FPM: u1,
            ///  AAB
            AAB: u1,
            ///  MB
            MB: u1,
            padding: u5,
        }),
        ///  Ethernet DMA transmit poll demand register
        DMATPDR: mmio.Mmio(packed struct(u32) {
            ///  TPD
            TPD: u32,
        }),
        ///  EHERNET DMA receive poll demand register
        DMARPDR: mmio.Mmio(packed struct(u32) {
            ///  RPD
            RPD: u32,
        }),
        ///  Ethernet DMA receive descriptor list address register
        DMARDLAR: mmio.Mmio(packed struct(u32) {
            ///  SRL
            SRL: u32,
        }),
        ///  Ethernet DMA transmit descriptor list address register
        DMATDLAR: mmio.Mmio(packed struct(u32) {
            ///  STL
            STL: u32,
        }),
        ///  Ethernet DMA status register
        DMASR: mmio.Mmio(packed struct(u32) {
            ///  TS
            TS: u1,
            ///  TPSS
            TPSS: u1,
            ///  TBUS
            TBUS: u1,
            ///  TJTS
            TJTS: u1,
            ///  ROS
            ROS: u1,
            ///  TUS
            TUS: u1,
            ///  RS
            RS: u1,
            ///  RBUS
            RBUS: u1,
            ///  RPSS
            RPSS: u1,
            ///  PWTS
            PWTS: u1,
            ///  ETS
            ETS: u1,
            reserved13: u2,
            ///  FBES
            FBES: u1,
            ///  ERS
            ERS: u1,
            ///  AIS
            AIS: u1,
            ///  NIS
            NIS: u1,
            ///  RPS
            RPS: u3,
            ///  TPS
            TPS: u3,
            ///  EBS
            EBS: u3,
            reserved27: u1,
            ///  MMCS
            MMCS: u1,
            ///  PMTS
            PMTS: u1,
            ///  TSTS
            TSTS: u1,
            padding: u2,
        }),
        ///  Ethernet DMA operation mode register
        DMAOMR: mmio.Mmio(packed struct(u32) {
            reserved1: u1,
            ///  SR
            SR: u1,
            ///  OSF
            OSF: u1,
            ///  RTC
            RTC: u2,
            reserved6: u1,
            ///  FUGF
            FUGF: u1,
            ///  FEF
            FEF: u1,
            reserved13: u5,
            ///  ST
            ST: u1,
            ///  TTC
            TTC: u3,
            reserved20: u3,
            ///  FTF
            FTF: u1,
            ///  TSF
            TSF: u1,
            reserved24: u2,
            ///  DFRF
            DFRF: u1,
            ///  RSF
            RSF: u1,
            ///  DTCEFD
            DTCEFD: u1,
            padding: u5,
        }),
        ///  Ethernet DMA interrupt enable register
        DMAIER: mmio.Mmio(packed struct(u32) {
            ///  TIE
            TIE: u1,
            ///  TPSIE
            TPSIE: u1,
            ///  TBUIE
            TBUIE: u1,
            ///  TJTIE
            TJTIE: u1,
            ///  ROIE
            ROIE: u1,
            ///  TUIE
            TUIE: u1,
            ///  RIE
            RIE: u1,
            ///  RBUIE
            RBUIE: u1,
            ///  RPSIE
            RPSIE: u1,
            ///  RWTIE
            RWTIE: u1,
            ///  ETIE
            ETIE: u1,
            reserved13: u2,
            ///  FBEIE
            FBEIE: u1,
            ///  ERIE
            ERIE: u1,
            ///  AISE
            AISE: u1,
            ///  NISE
            NISE: u1,
            padding: u15,
        }),
        ///  Ethernet DMA missed frame and buffer overflow counter register
        DMAMFBOCR: mmio.Mmio(packed struct(u32) {
            ///  MFC
            MFC: u16,
            ///  OMFC
            OMFC: u1,
            ///  MFA
            MFA: u11,
            ///  OFOC
            OFOC: u1,
            padding: u3,
        }),
        ///  Ethernet DMA receive status watchdog timer register
        DMARSWTR: mmio.Mmio(packed struct(u32) {
            ///  RSWTC
            RSWTC: u8,
            padding: u24,
        }),
        reserved72: [32]u8,
        ///  Ethernet DMA current host transmit descriptor register
        DMACHTDR: mmio.Mmio(packed struct(u32) {
            ///  HTDAP
            HTDAP: u32,
        }),
        ///  Ethernet DMA current host receive descriptor register
        DMACHRDR: mmio.Mmio(packed struct(u32) {
            ///  HRDAP
            HRDAP: u32,
        }),
        ///  Ethernet DMA current host transmit buffer address register
        DMACHTBAR: mmio.Mmio(packed struct(u32) {
            ///  HTBAP
            HTBAP: u32,
        }),
        ///  Ethernet DMA current host receive buffer address register
        DMACHRBAR: mmio.Mmio(packed struct(u32) {
            ///  HRBAP
            HRBAP: u32,
        }),
    };

    ///  Ethernet: Precision time protocol
    pub const Ethernet_PTP = extern struct {
        ///  Ethernet PTP time stamp control register
        PTPTSCR: mmio.Mmio(packed struct(u32) {
            ///  TSE
            TSE: u1,
            ///  TSFCU
            TSFCU: u1,
            ///  TSSTI
            TSSTI: u1,
            ///  TSSTU
            TSSTU: u1,
            ///  TSITE
            TSITE: u1,
            ///  TTSARU
            TTSARU: u1,
            reserved8: u2,
            ///  TSSARFE
            TSSARFE: u1,
            ///  TSSSR
            TSSSR: u1,
            ///  TSPTPPSV2E
            TSPTPPSV2E: u1,
            ///  TSSPTPOEFE
            TSSPTPOEFE: u1,
            ///  TSSIPV6FE
            TSSIPV6FE: u1,
            ///  TSSIPV4FE
            TSSIPV4FE: u1,
            ///  TSSEME
            TSSEME: u1,
            ///  TSSMRME
            TSSMRME: u1,
            ///  TSCNT
            TSCNT: u2,
            ///  TSPFFMAE
            TSPFFMAE: u1,
            padding: u13,
        }),
        ///  Ethernet PTP subsecond increment register
        PTPSSIR: mmio.Mmio(packed struct(u32) {
            ///  STSSI
            STSSI: u8,
            padding: u24,
        }),
        ///  Ethernet PTP time stamp high register
        PTPTSHR: mmio.Mmio(packed struct(u32) {
            ///  STS
            STS: u32,
        }),
        ///  Ethernet PTP time stamp low register
        PTPTSLR: mmio.Mmio(packed struct(u32) {
            ///  STSS
            STSS: u31,
            ///  STPNS
            STPNS: u1,
        }),
        ///  Ethernet PTP time stamp high update register
        PTPTSHUR: mmio.Mmio(packed struct(u32) {
            ///  TSUS
            TSUS: u32,
        }),
        ///  Ethernet PTP time stamp low update register
        PTPTSLUR: mmio.Mmio(packed struct(u32) {
            ///  TSUSS
            TSUSS: u31,
            ///  TSUSS
            TSUPNS: u1,
        }),
        ///  Ethernet PTP time stamp addend register
        PTPTSAR: mmio.Mmio(packed struct(u32) {
            ///  TSA
            TSA: u32,
        }),
        ///  Ethernet PTP target time high register
        PTPTTHR: mmio.Mmio(packed struct(u32) {
            ///  0
            TTSH: u32,
        }),
        ///  Ethernet PTP target time low register
        PTPTTLR: mmio.Mmio(packed struct(u32) {
            ///  TTSL
            TTSL: u32,
        }),
        reserved40: [4]u8,
        ///  Ethernet PTP time stamp status register
        PTPTSSR: mmio.Mmio(packed struct(u32) {
            ///  TSSO
            TSSO: u1,
            ///  TSTTR
            TSTTR: u1,
            padding: u30,
        }),
        ///  Ethernet PTP PPS control register
        PTPPPSCR: mmio.Mmio(packed struct(u32) {
            ///  TSSO
            TSSO: u1,
            ///  TSTTR
            TSTTR: u1,
            padding: u30,
        }),
    };

    ///  General-purpose-timers
    pub const TIM11 = extern struct {
        ///  control register 1
        CR1: mmio.Mmio(packed struct(u32) {
            ///  Counter enable
            CEN: u1,
            ///  Update disable
            UDIS: u1,
            ///  Update request source
            URS: u1,
            reserved7: u4,
            ///  Auto-reload preload enable
            ARPE: u1,
            ///  Clock division
            CKD: u2,
            padding: u22,
        }),
        reserved12: [8]u8,
        ///  DMA/Interrupt enable register
        DIER: mmio.Mmio(packed struct(u32) {
            ///  Update interrupt enable
            UIE: u1,
            ///  Capture/Compare 1 interrupt enable
            CC1IE: u1,
            padding: u30,
        }),
        ///  status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Update interrupt flag
            UIF: u1,
            ///  Capture/compare 1 interrupt flag
            CC1IF: u1,
            reserved9: u7,
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
            padding: u30,
        }),
        ///  capture/compare mode register 1 (output mode)
        CCMR1_Output: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 selection
            CC1S: u2,
            ///  Output Compare 1 fast enable
            OC1FE: u1,
            ///  Output Compare 1 preload enable
            OC1PE: u1,
            ///  Output Compare 1 mode
            OC1M: u3,
            padding: u25,
        }),
        reserved32: [4]u8,
        ///  capture/compare enable register
        CCER: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 output enable
            CC1E: u1,
            ///  Capture/Compare 1 output Polarity
            CC1P: u1,
            reserved3: u1,
            ///  Capture/Compare 1 output Polarity
            CC1NP: u1,
            padding: u28,
        }),
        ///  counter
        CNT: mmio.Mmio(packed struct(u32) {
            ///  counter value
            CNT: u16,
            padding: u16,
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
        reserved52: [4]u8,
        ///  capture/compare register 1
        CCR1: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 value
            CCR1: u16,
            padding: u16,
        }),
        reserved80: [24]u8,
        ///  option register
        OR: mmio.Mmio(packed struct(u32) {
            ///  Input 1 remapping capability
            RMP: u2,
            padding: u30,
        }),
    };
};
