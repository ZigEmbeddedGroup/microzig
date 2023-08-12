const micro = @import("microzig");
const mmio = micro.mmio;

pub const devices = struct {
    ///  STM32F103
    pub const STM32F103 = struct {
        pub const properties = struct {
            pub const @"cpu.nvic_prio_bits" = "4";
            pub const @"cpu.mpu" = "false";
            pub const @"cpu.fpu" = "false";
            pub const @"cpu.revision" = "r1p1";
            pub const @"cpu.vendor_systick_config" = "false";
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
            ///  Window Watchdog interrupt
            WWDG: Handler = unhandled,
            ///  PVD through EXTI line detection interrupt
            PVD: Handler = unhandled,
            ///  Tamper interrupt
            TAMPER: Handler = unhandled,
            ///  RTC global interrupt
            RTC: Handler = unhandled,
            ///  Flash global interrupt
            FLASH: Handler = unhandled,
            ///  RCC global interrupt
            RCC: Handler = unhandled,
            reserved20: [5]u32 = undefined,
            ///  DMA1 Channel1 global interrupt
            DMA1_Channel1: Handler = unhandled,
            reserved26: [6]u32 = undefined,
            ///  ADC1 and ADC2 global interrupt
            ADC1_2: Handler = unhandled,
            ///  USB High Priority or CAN TX interrupts
            USB_HP_CAN_TX: Handler = unhandled,
            reserved34: [1]u32 = undefined,
            ///  CAN RX1 interrupt
            CAN_RX1: Handler = unhandled,
            reserved36: [2]u32 = undefined,
            ///  TIM1 Break interrupt
            TIM1_BRK: Handler = unhandled,
            ///  TIM1 Update interrupt
            TIM1_UP: Handler = unhandled,
            ///  TIM1 Trigger and Commutation interrupts
            TIM1_TRG_COM: Handler = unhandled,
            reserved41: [1]u32 = undefined,
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
            reserved54: [3]u32 = undefined,
            ///  TIM8 Break interrupt
            TIM8_BRK: Handler = unhandled,
            reserved58: [3]u32 = undefined,
            ///  ADC3 global interrupt
            ADC3: Handler = unhandled,
            ///  FSMC global interrupt
            FSMC: Handler = unhandled,
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
            ///  TIM6 global interrupt
            TIM6: Handler = unhandled,
            ///  TIM7 global interrupt
            TIM7: Handler = unhandled,
            ///  DMA2 Channel1 global interrupt
            DMA2_Channel1: Handler = unhandled,
        };

        pub const peripherals = struct {
            ///  General purpose timer
            pub const TIM2 = @as(*volatile types.TIM2, @ptrFromInt(0x40000000));
            ///  General purpose timer
            pub const TIM3 = @as(*volatile types.TIM2, @ptrFromInt(0x40000400));
            ///  General purpose timer
            pub const TIM4 = @as(*volatile types.TIM2, @ptrFromInt(0x40000800));
            ///  General purpose timer
            pub const TIM5 = @as(*volatile types.TIM2, @ptrFromInt(0x40000c00));
            ///  Basic timer
            pub const TIM6 = @as(*volatile types.TIM6, @ptrFromInt(0x40001000));
            ///  Basic timer
            pub const TIM7 = @as(*volatile types.TIM6, @ptrFromInt(0x40001400));
            ///  General purpose timer
            pub const TIM12 = @as(*volatile types.TIM9, @ptrFromInt(0x40001800));
            ///  General purpose timer
            pub const TIM13 = @as(*volatile types.TIM10, @ptrFromInt(0x40001c00));
            ///  General purpose timer
            pub const TIM14 = @as(*volatile types.TIM10, @ptrFromInt(0x40002000));
            ///  Real time clock
            pub const RTC = @as(*volatile types.RTC, @ptrFromInt(0x40002800));
            ///  Window watchdog
            pub const WWDG = @as(*volatile types.WWDG, @ptrFromInt(0x40002c00));
            ///  Independent watchdog
            pub const IWDG = @as(*volatile types.IWDG, @ptrFromInt(0x40003000));
            ///  Serial peripheral interface
            pub const SPI2 = @as(*volatile types.SPI1, @ptrFromInt(0x40003800));
            ///  Serial peripheral interface
            pub const SPI3 = @as(*volatile types.SPI1, @ptrFromInt(0x40003c00));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const USART2 = @as(*volatile types.USART1, @ptrFromInt(0x40004400));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const USART3 = @as(*volatile types.USART1, @ptrFromInt(0x40004800));
            ///  Universal asynchronous receiver transmitter
            pub const UART4 = @as(*volatile types.UART4, @ptrFromInt(0x40004c00));
            ///  Universal asynchronous receiver transmitter
            pub const UART5 = @as(*volatile types.UART5, @ptrFromInt(0x40005000));
            ///  Inter integrated circuit
            pub const I2C1 = @as(*volatile types.I2C1, @ptrFromInt(0x40005400));
            ///  Inter integrated circuit
            pub const I2C2 = @as(*volatile types.I2C1, @ptrFromInt(0x40005800));
            ///  Universal serial bus full-speed device interface
            pub const USB = @as(*volatile types.USB, @ptrFromInt(0x40005c00));
            ///  Controller area network
            pub const CAN1 = @as(*volatile types.CAN1, @ptrFromInt(0x40006400));
            ///  Controller area network
            pub const CAN2 = @as(*volatile types.CAN1, @ptrFromInt(0x40006800));
            ///  Backup registers
            pub const BKP = @as(*volatile types.BKP, @ptrFromInt(0x40006c00));
            ///  Power control
            pub const PWR = @as(*volatile types.PWR, @ptrFromInt(0x40007000));
            ///  Digital to analog converter
            pub const DAC = @as(*volatile types.DAC, @ptrFromInt(0x40007400));
            ///  Alternate function I/O
            pub const AFIO = @as(*volatile types.AFIO, @ptrFromInt(0x40010000));
            ///  EXTI
            pub const EXTI = @as(*volatile types.EXTI, @ptrFromInt(0x40010400));
            ///  General purpose I/O
            pub const GPIOA = @as(*volatile types.GPIOA, @ptrFromInt(0x40010800));
            ///  General purpose I/O
            pub const GPIOB = @as(*volatile types.GPIOA, @ptrFromInt(0x40010c00));
            ///  General purpose I/O
            pub const GPIOC = @as(*volatile types.GPIOA, @ptrFromInt(0x40011000));
            ///  General purpose I/O
            pub const GPIOD = @as(*volatile types.GPIOA, @ptrFromInt(0x40011400));
            ///  General purpose I/O
            pub const GPIOE = @as(*volatile types.GPIOA, @ptrFromInt(0x40011800));
            ///  General purpose I/O
            pub const GPIOF = @as(*volatile types.GPIOA, @ptrFromInt(0x40011c00));
            ///  General purpose I/O
            pub const GPIOG = @as(*volatile types.GPIOA, @ptrFromInt(0x40012000));
            ///  Analog to digital converter
            pub const ADC1 = @as(*volatile types.ADC1, @ptrFromInt(0x40012400));
            ///  Analog to digital converter
            pub const ADC2 = @as(*volatile types.ADC2, @ptrFromInt(0x40012800));
            ///  Advanced timer
            pub const TIM1 = @as(*volatile types.TIM1, @ptrFromInt(0x40012c00));
            ///  Serial peripheral interface
            pub const SPI1 = @as(*volatile types.SPI1, @ptrFromInt(0x40013000));
            ///  Advanced timer
            pub const TIM8 = @as(*volatile types.TIM1, @ptrFromInt(0x40013400));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const USART1 = @as(*volatile types.USART1, @ptrFromInt(0x40013800));
            ///  Analog to digital converter
            pub const ADC3 = @as(*volatile types.ADC2, @ptrFromInt(0x40013c00));
            ///  General purpose timer
            pub const TIM9 = @as(*volatile types.TIM9, @ptrFromInt(0x40014c00));
            ///  General purpose timer
            pub const TIM10 = @as(*volatile types.TIM10, @ptrFromInt(0x40015000));
            ///  General purpose timer
            pub const TIM11 = @as(*volatile types.TIM10, @ptrFromInt(0x40015400));
            ///  Secure digital input/output interface
            pub const SDIO = @as(*volatile types.SDIO, @ptrFromInt(0x40018000));
            ///  DMA controller
            pub const DMA1 = @as(*volatile types.DMA1, @ptrFromInt(0x40020000));
            ///  DMA controller
            pub const DMA2 = @as(*volatile types.DMA1, @ptrFromInt(0x40020400));
            ///  Reset and clock control
            pub const RCC = @as(*volatile types.RCC, @ptrFromInt(0x40021000));
            ///  FLASH
            pub const FLASH = @as(*volatile types.FLASH, @ptrFromInt(0x40022000));
            ///  CRC calculation unit
            pub const CRC = @as(*volatile types.CRC, @ptrFromInt(0x40023000));
            ///  Ethernet: media access control
            pub const ETHERNET_MAC = @as(*volatile types.ETHERNET_MAC, @ptrFromInt(0x40028000));
            ///  Ethernet: MAC management counters
            pub const ETHERNET_MMC = @as(*volatile types.ETHERNET_MMC, @ptrFromInt(0x40028100));
            ///  Ethernet: Precision time protocol
            pub const ETHERNET_PTP = @as(*volatile types.ETHERNET_PTP, @ptrFromInt(0x40028700));
            ///  Ethernet: DMA controller operation
            pub const ETHERNET_DMA = @as(*volatile types.ETHERNET_DMA, @ptrFromInt(0x40029000));
            ///  USB on the go full speed
            pub const OTG_FS_GLOBAL = @as(*volatile types.OTG_FS_GLOBAL, @ptrFromInt(0x50000000));
            ///  USB on the go full speed
            pub const OTG_FS_HOST = @as(*volatile types.OTG_FS_HOST, @ptrFromInt(0x50000400));
            ///  USB on the go full speed
            pub const OTG_FS_DEVICE = @as(*volatile types.OTG_FS_DEVICE, @ptrFromInt(0x50000800));
            ///  USB on the go full speed
            pub const OTG_FS_PWRCLK = @as(*volatile types.OTG_FS_PWRCLK, @ptrFromInt(0x50000e00));
            ///  Flexible static memory controller
            pub const FSMC = @as(*volatile types.FSMC, @ptrFromInt(0xa0000000));
            ///  System control block ACTLR
            pub const SCB_ACTRL = @as(*volatile types.SCB_ACTRL, @ptrFromInt(0xe000e008));
            ///  SysTick timer
            pub const STK = @as(*volatile types.STK, @ptrFromInt(0xe000e010));
            ///  Nested Vectored Interrupt Controller
            pub const NVIC = @as(*volatile types.NVIC, @ptrFromInt(0xe000e100));
            ///  System control block
            pub const SCB = @as(*volatile types.SCB, @ptrFromInt(0xe000ed00));
            ///  Memory protection unit
            pub const MPU = @as(*volatile types.MPU, @ptrFromInt(0xe000ed90));
            ///  Nested vectored interrupt controller
            pub const NVIC_STIR = @as(*volatile types.NVIC_STIR, @ptrFromInt(0xe000ef00));
            ///  Debug support
            pub const DBG = @as(*volatile types.DBG, @ptrFromInt(0xe0042000));
        };
    };
};

pub const types = struct {
    ///  Flexible static memory controller
    pub const FSMC = extern struct {
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
            padding: u12,
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
            ///  Attribute memory x setup time
            ATTSETx: u8,
            ///  Attribute memory x wait time
            ATTWAITx: u8,
            ///  Attribute memory x hold time
            ATTHOLDx: u8,
            ///  Attribute memory x databus HiZ time
            ATTHIZx: u8,
        }),
        reserved116: [4]u8,
        ///  ECC result register 2
        ECCR2: mmio.Mmio(packed struct(u32) {
            ///  ECC result
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
        reserved276: [4]u8,
        ///  SRAM/NOR-Flash write timing registers 3
        BWTR3: mmio.Mmio(packed struct(u32) {
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
        reserved284: [4]u8,
        ///  SRAM/NOR-Flash write timing registers 4
        BWTR4: mmio.Mmio(packed struct(u32) {
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
    };

    ///  Power control
    pub const PWR = extern struct {
        ///  Power control register (PWR_CR)
        CR: mmio.Mmio(packed struct(u32) {
            ///  Low Power Deep Sleep
            LPDS: u1,
            ///  Power Down Deep Sleep
            PDDS: u1,
            ///  Clear Wake-up Flag
            CWUF: u1,
            ///  Clear STANDBY Flag
            CSBF: u1,
            ///  Power Voltage Detector Enable
            PVDE: u1,
            ///  PVD Level Selection
            PLS: u3,
            ///  Disable Backup Domain write protection
            DBP: u1,
            padding: u23,
        }),
        ///  Power control register (PWR_CR)
        CSR: mmio.Mmio(packed struct(u32) {
            ///  Wake-Up Flag
            WUF: u1,
            ///  STANDBY Flag
            SBF: u1,
            ///  PVD Output
            PVDO: u1,
            reserved8: u5,
            ///  Enable WKUP pin
            EWUP: u1,
            padding: u23,
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
            ///  APB High speed prescaler (APB2)
            PPRE2: u3,
            ///  ADC prescaler
            ADCPRE: u2,
            ///  PLL entry clock source
            PLLSRC: u1,
            ///  HSE divider for PLL entry
            PLLXTPRE: u1,
            ///  PLL Multiplication Factor
            PLLMUL: u4,
            ///  USB OTG FS prescaler
            OTGFSPRE: u1,
            reserved24: u1,
            ///  Microcontroller clock output
            MCO: u3,
            padding: u5,
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
            ///  Alternate function I/O reset
            AFIORST: u1,
            reserved2: u1,
            ///  IO port A reset
            IOPARST: u1,
            ///  IO port B reset
            IOPBRST: u1,
            ///  IO port C reset
            IOPCRST: u1,
            ///  IO port D reset
            IOPDRST: u1,
            ///  IO port E reset
            IOPERST: u1,
            ///  IO port F reset
            IOPFRST: u1,
            ///  IO port G reset
            IOPGRST: u1,
            ///  ADC 1 interface reset
            ADC1RST: u1,
            ///  ADC 2 interface reset
            ADC2RST: u1,
            ///  TIM1 timer reset
            TIM1RST: u1,
            ///  SPI 1 reset
            SPI1RST: u1,
            ///  TIM8 timer reset
            TIM8RST: u1,
            ///  USART1 reset
            USART1RST: u1,
            ///  ADC 3 interface reset
            ADC3RST: u1,
            reserved19: u3,
            ///  TIM9 timer reset
            TIM9RST: u1,
            ///  TIM10 timer reset
            TIM10RST: u1,
            ///  TIM11 timer reset
            TIM11RST: u1,
            padding: u10,
        }),
        ///  APB1 peripheral reset register (RCC_APB1RSTR)
        APB1RSTR: mmio.Mmio(packed struct(u32) {
            ///  Timer 2 reset
            TIM2RST: u1,
            ///  Timer 3 reset
            TIM3RST: u1,
            ///  Timer 4 reset
            TIM4RST: u1,
            ///  Timer 5 reset
            TIM5RST: u1,
            ///  Timer 6 reset
            TIM6RST: u1,
            ///  Timer 7 reset
            TIM7RST: u1,
            ///  Timer 12 reset
            TIM12RST: u1,
            ///  Timer 13 reset
            TIM13RST: u1,
            ///  Timer 14 reset
            TIM14RST: u1,
            reserved11: u2,
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
            ///  USART 3 reset
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
            reserved27: u1,
            ///  Backup interface reset
            BKPRST: u1,
            ///  Power interface reset
            PWRRST: u1,
            ///  DAC interface reset
            DACRST: u1,
            padding: u2,
        }),
        ///  AHB Peripheral Clock enable register (RCC_AHBENR)
        AHBENR: mmio.Mmio(packed struct(u32) {
            ///  DMA1 clock enable
            DMA1EN: u1,
            ///  DMA2 clock enable
            DMA2EN: u1,
            ///  SRAM interface clock enable
            SRAMEN: u1,
            reserved4: u1,
            ///  FLITF clock enable
            FLITFEN: u1,
            reserved6: u1,
            ///  CRC clock enable
            CRCEN: u1,
            reserved8: u1,
            ///  FSMC clock enable
            FSMCEN: u1,
            reserved10: u1,
            ///  SDIO clock enable
            SDIOEN: u1,
            padding: u21,
        }),
        ///  APB2 peripheral clock enable register (RCC_APB2ENR)
        APB2ENR: mmio.Mmio(packed struct(u32) {
            ///  Alternate function I/O clock enable
            AFIOEN: u1,
            reserved2: u1,
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
            ///  ADC 1 interface clock enable
            ADC1EN: u1,
            ///  ADC 2 interface clock enable
            ADC2EN: u1,
            ///  TIM1 Timer clock enable
            TIM1EN: u1,
            ///  SPI 1 clock enable
            SPI1EN: u1,
            ///  TIM8 Timer clock enable
            TIM8EN: u1,
            ///  USART1 clock enable
            USART1EN: u1,
            ///  ADC3 interface clock enable
            ADC3EN: u1,
            reserved19: u3,
            ///  TIM9 Timer clock enable
            TIM9EN: u1,
            ///  TIM10 Timer clock enable
            TIM10EN: u1,
            ///  TIM11 Timer clock enable
            TIM11EN: u1,
            padding: u10,
        }),
        ///  APB1 peripheral clock enable register (RCC_APB1ENR)
        APB1ENR: mmio.Mmio(packed struct(u32) {
            ///  Timer 2 clock enable
            TIM2EN: u1,
            ///  Timer 3 clock enable
            TIM3EN: u1,
            ///  Timer 4 clock enable
            TIM4EN: u1,
            ///  Timer 5 clock enable
            TIM5EN: u1,
            ///  Timer 6 clock enable
            TIM6EN: u1,
            ///  Timer 7 clock enable
            TIM7EN: u1,
            ///  Timer 12 clock enable
            TIM12EN: u1,
            ///  Timer 13 clock enable
            TIM13EN: u1,
            ///  Timer 14 clock enable
            TIM14EN: u1,
            reserved11: u2,
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
            ///  UART 4 clock enable
            UART4EN: u1,
            ///  UART 5 clock enable
            UART5EN: u1,
            ///  I2C 1 clock enable
            I2C1EN: u1,
            ///  I2C 2 clock enable
            I2C2EN: u1,
            ///  USB clock enable
            USBEN: u1,
            reserved25: u1,
            ///  CAN clock enable
            CANEN: u1,
            reserved27: u1,
            ///  Backup interface clock enable
            BKPEN: u1,
            ///  Power interface clock enable
            PWREN: u1,
            ///  DAC interface clock enable
            DACEN: u1,
            padding: u2,
        }),
        ///  Backup domain control register (RCC_BDCR)
        BDCR: mmio.Mmio(packed struct(u32) {
            ///  External Low Speed oscillator enable
            LSEON: u1,
            ///  External Low Speed oscillator ready
            LSERDY: u1,
            ///  External Low Speed oscillator bypass
            LSEBYP: u1,
            reserved8: u5,
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
            reserved26: u1,
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
    };

    ///  General purpose I/O
    pub const GPIOA = extern struct {
        ///  Port configuration register low (GPIOn_CRL)
        CRL: mmio.Mmio(packed struct(u32) {
            ///  Port n.0 mode bits
            MODE0: u2,
            ///  Port n.0 configuration bits
            CNF0: u2,
            ///  Port n.1 mode bits
            MODE1: u2,
            ///  Port n.1 configuration bits
            CNF1: u2,
            ///  Port n.2 mode bits
            MODE2: u2,
            ///  Port n.2 configuration bits
            CNF2: u2,
            ///  Port n.3 mode bits
            MODE3: u2,
            ///  Port n.3 configuration bits
            CNF3: u2,
            ///  Port n.4 mode bits
            MODE4: u2,
            ///  Port n.4 configuration bits
            CNF4: u2,
            ///  Port n.5 mode bits
            MODE5: u2,
            ///  Port n.5 configuration bits
            CNF5: u2,
            ///  Port n.6 mode bits
            MODE6: u2,
            ///  Port n.6 configuration bits
            CNF6: u2,
            ///  Port n.7 mode bits
            MODE7: u2,
            ///  Port n.7 configuration bits
            CNF7: u2,
        }),
        ///  Port configuration register high (GPIOn_CRL)
        CRH: mmio.Mmio(packed struct(u32) {
            ///  Port n.8 mode bits
            MODE8: u2,
            ///  Port n.8 configuration bits
            CNF8: u2,
            ///  Port n.9 mode bits
            MODE9: u2,
            ///  Port n.9 configuration bits
            CNF9: u2,
            ///  Port n.10 mode bits
            MODE10: u2,
            ///  Port n.10 configuration bits
            CNF10: u2,
            ///  Port n.11 mode bits
            MODE11: u2,
            ///  Port n.11 configuration bits
            CNF11: u2,
            ///  Port n.12 mode bits
            MODE12: u2,
            ///  Port n.12 configuration bits
            CNF12: u2,
            ///  Port n.13 mode bits
            MODE13: u2,
            ///  Port n.13 configuration bits
            CNF13: u2,
            ///  Port n.14 mode bits
            MODE14: u2,
            ///  Port n.14 configuration bits
            CNF14: u2,
            ///  Port n.15 mode bits
            MODE15: u2,
            ///  Port n.15 configuration bits
            CNF15: u2,
        }),
        ///  Port input data register (GPIOn_IDR)
        IDR: mmio.Mmio(packed struct(u32) {
            ///  Port input data
            IDR0: u1,
            ///  Port input data
            IDR1: u1,
            ///  Port input data
            IDR2: u1,
            ///  Port input data
            IDR3: u1,
            ///  Port input data
            IDR4: u1,
            ///  Port input data
            IDR5: u1,
            ///  Port input data
            IDR6: u1,
            ///  Port input data
            IDR7: u1,
            ///  Port input data
            IDR8: u1,
            ///  Port input data
            IDR9: u1,
            ///  Port input data
            IDR10: u1,
            ///  Port input data
            IDR11: u1,
            ///  Port input data
            IDR12: u1,
            ///  Port input data
            IDR13: u1,
            ///  Port input data
            IDR14: u1,
            ///  Port input data
            IDR15: u1,
            padding: u16,
        }),
        ///  Port output data register (GPIOn_ODR)
        ODR: mmio.Mmio(packed struct(u32) {
            ///  Port output data
            ODR0: u1,
            ///  Port output data
            ODR1: u1,
            ///  Port output data
            ODR2: u1,
            ///  Port output data
            ODR3: u1,
            ///  Port output data
            ODR4: u1,
            ///  Port output data
            ODR5: u1,
            ///  Port output data
            ODR6: u1,
            ///  Port output data
            ODR7: u1,
            ///  Port output data
            ODR8: u1,
            ///  Port output data
            ODR9: u1,
            ///  Port output data
            ODR10: u1,
            ///  Port output data
            ODR11: u1,
            ///  Port output data
            ODR12: u1,
            ///  Port output data
            ODR13: u1,
            ///  Port output data
            ODR14: u1,
            ///  Port output data
            ODR15: u1,
            padding: u16,
        }),
        ///  Port bit set/reset register (GPIOn_BSRR)
        BSRR: mmio.Mmio(packed struct(u32) {
            ///  Set bit 0
            BS0: u1,
            ///  Set bit 1
            BS1: u1,
            ///  Set bit 1
            BS2: u1,
            ///  Set bit 3
            BS3: u1,
            ///  Set bit 4
            BS4: u1,
            ///  Set bit 5
            BS5: u1,
            ///  Set bit 6
            BS6: u1,
            ///  Set bit 7
            BS7: u1,
            ///  Set bit 8
            BS8: u1,
            ///  Set bit 9
            BS9: u1,
            ///  Set bit 10
            BS10: u1,
            ///  Set bit 11
            BS11: u1,
            ///  Set bit 12
            BS12: u1,
            ///  Set bit 13
            BS13: u1,
            ///  Set bit 14
            BS14: u1,
            ///  Set bit 15
            BS15: u1,
            ///  Reset bit 0
            BR0: u1,
            ///  Reset bit 1
            BR1: u1,
            ///  Reset bit 2
            BR2: u1,
            ///  Reset bit 3
            BR3: u1,
            ///  Reset bit 4
            BR4: u1,
            ///  Reset bit 5
            BR5: u1,
            ///  Reset bit 6
            BR6: u1,
            ///  Reset bit 7
            BR7: u1,
            ///  Reset bit 8
            BR8: u1,
            ///  Reset bit 9
            BR9: u1,
            ///  Reset bit 10
            BR10: u1,
            ///  Reset bit 11
            BR11: u1,
            ///  Reset bit 12
            BR12: u1,
            ///  Reset bit 13
            BR13: u1,
            ///  Reset bit 14
            BR14: u1,
            ///  Reset bit 15
            BR15: u1,
        }),
        ///  Port bit reset register (GPIOn_BRR)
        BRR: mmio.Mmio(packed struct(u32) {
            ///  Reset bit 0
            BR0: u1,
            ///  Reset bit 1
            BR1: u1,
            ///  Reset bit 1
            BR2: u1,
            ///  Reset bit 3
            BR3: u1,
            ///  Reset bit 4
            BR4: u1,
            ///  Reset bit 5
            BR5: u1,
            ///  Reset bit 6
            BR6: u1,
            ///  Reset bit 7
            BR7: u1,
            ///  Reset bit 8
            BR8: u1,
            ///  Reset bit 9
            BR9: u1,
            ///  Reset bit 10
            BR10: u1,
            ///  Reset bit 11
            BR11: u1,
            ///  Reset bit 12
            BR12: u1,
            ///  Reset bit 13
            BR13: u1,
            ///  Reset bit 14
            BR14: u1,
            ///  Reset bit 15
            BR15: u1,
            padding: u16,
        }),
        ///  Port configuration lock register
        LCKR: mmio.Mmio(packed struct(u32) {
            ///  Port A Lock bit 0
            LCK0: u1,
            ///  Port A Lock bit 1
            LCK1: u1,
            ///  Port A Lock bit 2
            LCK2: u1,
            ///  Port A Lock bit 3
            LCK3: u1,
            ///  Port A Lock bit 4
            LCK4: u1,
            ///  Port A Lock bit 5
            LCK5: u1,
            ///  Port A Lock bit 6
            LCK6: u1,
            ///  Port A Lock bit 7
            LCK7: u1,
            ///  Port A Lock bit 8
            LCK8: u1,
            ///  Port A Lock bit 9
            LCK9: u1,
            ///  Port A Lock bit 10
            LCK10: u1,
            ///  Port A Lock bit 11
            LCK11: u1,
            ///  Port A Lock bit 12
            LCK12: u1,
            ///  Port A Lock bit 13
            LCK13: u1,
            ///  Port A Lock bit 14
            LCK14: u1,
            ///  Port A Lock bit 15
            LCK15: u1,
            ///  Lock key
            LCKK: u1,
            padding: u15,
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
        LOAD_: mmio.Mmio(packed struct(u32) {
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
            padding: u8,
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
            ///  IACCVIOL
            IACCVIOL: u1,
            ///  DACCVIOL
            DACCVIOL: u1,
            reserved3: u1,
            ///  MUNSTKERR
            MUNSTKERR: u1,
            ///  MSTKERR
            MSTKERR: u1,
            ///  MLSPERR
            MLSPERR: u1,
            reserved7: u1,
            ///  MMARVALID
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

    ///  System control block ACTLR
    pub const SCB_ACTRL = extern struct {
        ///  Auxiliary control register
        ACTRL: mmio.Mmio(packed struct(u32) {
            reserved2: u2,
            ///  DISFOLD
            DISFOLD: u1,
            reserved10: u7,
            ///  FPEXCODIS
            FPEXCODIS: u1,
            ///  DISRAMODE
            DISRAMODE: u1,
            ///  DISITMATBFLUSH
            DISITMATBFLUSH: u1,
            padding: u19,
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
        reserved128: [120]u8,
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
        reserved256: [120]u8,
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
        reserved384: [120]u8,
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
        reserved512: [120]u8,
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
        reserved768: [248]u8,
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
    };

    ///  Alternate function I/O
    pub const AFIO = extern struct {
        ///  Event Control Register (AFIO_EVCR)
        EVCR: mmio.Mmio(packed struct(u32) {
            ///  Pin selection
            PIN: u4,
            ///  Port selection
            PORT: u3,
            ///  Event Output Enable
            EVOE: u1,
            padding: u24,
        }),
        ///  AF remap and debug I/O configuration register (AFIO_MAPR)
        MAPR: mmio.Mmio(packed struct(u32) {
            ///  SPI1 remapping
            SPI1_REMAP: u1,
            ///  I2C1 remapping
            I2C1_REMAP: u1,
            ///  USART1 remapping
            USART1_REMAP: u1,
            ///  USART2 remapping
            USART2_REMAP: u1,
            ///  USART3 remapping
            USART3_REMAP: u2,
            ///  TIM1 remapping
            TIM1_REMAP: u2,
            ///  TIM2 remapping
            TIM2_REMAP: u2,
            ///  TIM3 remapping
            TIM3_REMAP: u2,
            ///  TIM4 remapping
            TIM4_REMAP: u1,
            ///  CAN1 remapping
            CAN_REMAP: u2,
            ///  Port D0/Port D1 mapping on OSCIN/OSCOUT
            PD01_REMAP: u1,
            ///  Set and cleared by software
            TIM5CH4_IREMAP: u1,
            ///  ADC 1 External trigger injected conversion remapping
            ADC1_ETRGINJ_REMAP: u1,
            ///  ADC 1 external trigger regular conversion remapping
            ADC1_ETRGREG_REMAP: u1,
            ///  ADC 2 external trigger injected conversion remapping
            ADC2_ETRGINJ_REMAP: u1,
            ///  ADC 2 external trigger regular conversion remapping
            ADC2_ETRGREG_REMAP: u1,
            reserved24: u3,
            ///  Serial wire JTAG configuration
            SWJ_CFG: u3,
            padding: u5,
        }),
        ///  External interrupt configuration register 1 (AFIO_EXTICR1)
        EXTICR1: mmio.Mmio(packed struct(u32) {
            ///  EXTI0 configuration
            EXTI0: u4,
            ///  EXTI1 configuration
            EXTI1: u4,
            ///  EXTI2 configuration
            EXTI2: u4,
            ///  EXTI3 configuration
            EXTI3: u4,
            padding: u16,
        }),
        ///  External interrupt configuration register 2 (AFIO_EXTICR2)
        EXTICR2: mmio.Mmio(packed struct(u32) {
            ///  EXTI4 configuration
            EXTI4: u4,
            ///  EXTI5 configuration
            EXTI5: u4,
            ///  EXTI6 configuration
            EXTI6: u4,
            ///  EXTI7 configuration
            EXTI7: u4,
            padding: u16,
        }),
        ///  External interrupt configuration register 3 (AFIO_EXTICR3)
        EXTICR3: mmio.Mmio(packed struct(u32) {
            ///  EXTI8 configuration
            EXTI8: u4,
            ///  EXTI9 configuration
            EXTI9: u4,
            ///  EXTI10 configuration
            EXTI10: u4,
            ///  EXTI11 configuration
            EXTI11: u4,
            padding: u16,
        }),
        ///  External interrupt configuration register 4 (AFIO_EXTICR4)
        EXTICR4: mmio.Mmio(packed struct(u32) {
            ///  EXTI12 configuration
            EXTI12: u4,
            ///  EXTI13 configuration
            EXTI13: u4,
            ///  EXTI14 configuration
            EXTI14: u4,
            ///  EXTI15 configuration
            EXTI15: u4,
            padding: u16,
        }),
        reserved28: [4]u8,
        ///  AF remap and debug I/O configuration register
        MAPR2: mmio.Mmio(packed struct(u32) {
            reserved5: u5,
            ///  TIM9 remapping
            TIM9_REMAP: u1,
            ///  TIM10 remapping
            TIM10_REMAP: u1,
            ///  TIM11 remapping
            TIM11_REMAP: u1,
            ///  TIM13 remapping
            TIM13_REMAP: u1,
            ///  TIM14 remapping
            TIM14_REMAP: u1,
            ///  NADV connect/disconnect
            FSMC_NADV: u1,
            padding: u21,
        }),
    };

    ///  EXTI
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
            padding: u13,
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
            padding: u13,
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
            padding: u13,
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
            padding: u13,
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
            padding: u13,
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
            padding: u13,
        }),
    };

    ///  DMA controller
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

    ///  Ethernet: DMA controller operation
    pub const ETHERNET_DMA = extern struct {
        ///  Ethernet DMA bus mode register
        DMABMR: mmio.Mmio(packed struct(u32) {
            ///  Software reset
            SR: u1,
            ///  DMA Arbitration
            DA: u1,
            ///  Descriptor skip length
            DSL: u5,
            reserved8: u1,
            ///  Programmable burst length
            PBL: u6,
            ///  Rx Tx priority ratio
            RTPR: u2,
            ///  Fixed burst
            FB: u1,
            ///  Rx DMA PBL
            RDP: u6,
            ///  Use separate PBL
            USP: u1,
            ///  4xPBL mode
            FPM: u1,
            ///  Address-aligned beats
            AAB: u1,
            padding: u6,
        }),
        ///  Ethernet DMA transmit poll demand register
        DMATPDR: mmio.Mmio(packed struct(u32) {
            ///  Transmit poll demand
            TPD: u32,
        }),
        ///  EHERNET DMA receive poll demand register
        DMARPDR: mmio.Mmio(packed struct(u32) {
            ///  Receive poll demand
            RPD: u32,
        }),
        ///  Ethernet DMA receive descriptor list address register
        DMARDLAR: mmio.Mmio(packed struct(u32) {
            ///  Start of receive list
            SRL: u32,
        }),
        ///  Ethernet DMA transmit descriptor list address register
        DMATDLAR: mmio.Mmio(packed struct(u32) {
            ///  Start of transmit list
            STL: u32,
        }),
        ///  Ethernet DMA status register
        DMASR: mmio.Mmio(packed struct(u32) {
            ///  Transmit status
            TS: u1,
            ///  Transmit process stopped status
            TPSS: u1,
            ///  Transmit buffer unavailable status
            TBUS: u1,
            ///  Transmit jabber timeout status
            TJTS: u1,
            ///  Receive overflow status
            ROS: u1,
            ///  Transmit underflow status
            TUS: u1,
            ///  Receive status
            RS: u1,
            ///  Receive buffer unavailable status
            RBUS: u1,
            ///  Receive process stopped status
            RPSS: u1,
            ///  Receive watchdog timeout status
            PWTS: u1,
            ///  Early transmit status
            ETS: u1,
            reserved13: u2,
            ///  Fatal bus error status
            FBES: u1,
            ///  Early receive status
            ERS: u1,
            ///  Abnormal interrupt summary
            AIS: u1,
            ///  Normal interrupt summary
            NIS: u1,
            ///  Receive process state
            RPS: u3,
            ///  Transmit process state
            TPS: u3,
            ///  Error bits status
            EBS: u3,
            reserved27: u1,
            ///  MMC status
            MMCS: u1,
            ///  PMT status
            PMTS: u1,
            ///  Time stamp trigger status
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
            ///  Transmit interrupt enable
            TIE: u1,
            ///  Transmit process stopped interrupt enable
            TPSIE: u1,
            ///  Transmit buffer unavailable interrupt enable
            TBUIE: u1,
            ///  Transmit jabber timeout interrupt enable
            TJTIE: u1,
            ///  Overflow interrupt enable
            ROIE: u1,
            ///  Underflow interrupt enable
            TUIE: u1,
            ///  Receive interrupt enable
            RIE: u1,
            ///  Receive buffer unavailable interrupt enable
            RBUIE: u1,
            ///  Receive process stopped interrupt enable
            RPSIE: u1,
            ///  receive watchdog timeout interrupt enable
            RWTIE: u1,
            ///  Early transmit interrupt enable
            ETIE: u1,
            reserved13: u2,
            ///  Fatal bus error interrupt enable
            FBEIE: u1,
            ///  Early receive interrupt enable
            ERIE: u1,
            ///  Abnormal interrupt summary enable
            AISE: u1,
            ///  Normal interrupt summary enable
            NISE: u1,
            padding: u15,
        }),
        ///  Ethernet DMA missed frame and buffer overflow counter register
        DMAMFBOCR: mmio.Mmio(packed struct(u32) {
            ///  Missed frames by the controller
            MFC: u16,
            ///  Overflow bit for missed frame counter
            OMFC: u1,
            ///  Missed frames by the application
            MFA: u11,
            ///  Overflow bit for FIFO overflow counter
            OFOC: u1,
            padding: u3,
        }),
        reserved72: [36]u8,
        ///  Ethernet DMA current host transmit descriptor register
        DMACHTDR: mmio.Mmio(packed struct(u32) {
            ///  Host transmit descriptor address pointer
            HTDAP: u32,
        }),
        ///  Ethernet DMA current host receive descriptor register
        DMACHRDR: mmio.Mmio(packed struct(u32) {
            ///  Host receive descriptor address pointer
            HRDAP: u32,
        }),
        ///  Ethernet DMA current host transmit buffer address register
        DMACHTBAR: mmio.Mmio(packed struct(u32) {
            ///  Host transmit buffer address pointer
            HTBAP: u32,
        }),
        ///  Ethernet DMA current host receive buffer address register
        DMACHRBAR: mmio.Mmio(packed struct(u32) {
            ///  Host receive buffer address pointer
            HRBAP: u32,
        }),
    };

    ///  Secure digital input/output interface
    pub const SDIO = extern struct {
        ///  Bits 1:0 = PWRCTRL: Power supply control bits
        POWER: mmio.Mmio(packed struct(u32) {
            ///  PWRCTRL
            PWRCTRL: u2,
            padding: u30,
        }),
        ///  SDI clock control register (SDIO_CLKCR)
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
        ///  Bits 31:0 = : Command argument
        ARG: mmio.Mmio(packed struct(u32) {
            ///  Command argument
            CMDARG: u32,
        }),
        ///  SDIO command register (SDIO_CMD)
        CMD: mmio.Mmio(packed struct(u32) {
            ///  CMDINDEX
            CMDINDEX: u6,
            ///  WAITRESP
            WAITRESP: u2,
            ///  WAITINT
            WAITINT: u1,
            ///  WAITPEND
            WAITPEND: u1,
            ///  CPSMEN
            CPSMEN: u1,
            ///  SDIOSuspend
            SDIOSuspend: u1,
            ///  ENCMDcompl
            ENCMDcompl: u1,
            ///  nIEN
            nIEN: u1,
            ///  CE_ATACMD
            CE_ATACMD: u1,
            padding: u17,
        }),
        ///  SDIO command register
        RESPCMD: mmio.Mmio(packed struct(u32) {
            ///  RESPCMD
            RESPCMD: u6,
            padding: u26,
        }),
        ///  Bits 31:0 = CARDSTATUS1
        RESPI1: mmio.Mmio(packed struct(u32) {
            ///  CARDSTATUS1
            CARDSTATUS1: u32,
        }),
        ///  Bits 31:0 = CARDSTATUS2
        RESP2: mmio.Mmio(packed struct(u32) {
            ///  CARDSTATUS2
            CARDSTATUS2: u32,
        }),
        ///  Bits 31:0 = CARDSTATUS3
        RESP3: mmio.Mmio(packed struct(u32) {
            ///  CARDSTATUS3
            CARDSTATUS3: u32,
        }),
        ///  Bits 31:0 = CARDSTATUS4
        RESP4: mmio.Mmio(packed struct(u32) {
            ///  CARDSTATUS4
            CARDSTATUS4: u32,
        }),
        ///  Bits 31:0 = DATATIME: Data timeout period
        DTIMER: mmio.Mmio(packed struct(u32) {
            ///  Data timeout period
            DATATIME: u32,
        }),
        ///  Bits 24:0 = DATALENGTH: Data length value
        DLEN: mmio.Mmio(packed struct(u32) {
            ///  Data length value
            DATALENGTH: u25,
            padding: u7,
        }),
        ///  SDIO data control register (SDIO_DCTRL)
        DCTRL: mmio.Mmio(packed struct(u32) {
            ///  DTEN
            DTEN: u1,
            ///  DTDIR
            DTDIR: u1,
            ///  DTMODE
            DTMODE: u1,
            ///  DMAEN
            DMAEN: u1,
            ///  DBLOCKSIZE
            DBLOCKSIZE: u4,
            ///  PWSTART
            PWSTART: u1,
            ///  PWSTOP
            PWSTOP: u1,
            ///  RWMOD
            RWMOD: u1,
            ///  SDIOEN
            SDIOEN: u1,
            padding: u20,
        }),
        ///  Bits 24:0 = DATACOUNT: Data count value
        DCOUNT: mmio.Mmio(packed struct(u32) {
            ///  Data count value
            DATACOUNT: u25,
            padding: u7,
        }),
        ///  SDIO status register (SDIO_STA)
        STA: mmio.Mmio(packed struct(u32) {
            ///  CCRCFAIL
            CCRCFAIL: u1,
            ///  DCRCFAIL
            DCRCFAIL: u1,
            ///  CTIMEOUT
            CTIMEOUT: u1,
            ///  DTIMEOUT
            DTIMEOUT: u1,
            ///  TXUNDERR
            TXUNDERR: u1,
            ///  RXOVERR
            RXOVERR: u1,
            ///  CMDREND
            CMDREND: u1,
            ///  CMDSENT
            CMDSENT: u1,
            ///  DATAEND
            DATAEND: u1,
            ///  STBITERR
            STBITERR: u1,
            ///  DBCKEND
            DBCKEND: u1,
            ///  CMDACT
            CMDACT: u1,
            ///  TXACT
            TXACT: u1,
            ///  RXACT
            RXACT: u1,
            ///  TXFIFOHE
            TXFIFOHE: u1,
            ///  RXFIFOHF
            RXFIFOHF: u1,
            ///  TXFIFOF
            TXFIFOF: u1,
            ///  RXFIFOF
            RXFIFOF: u1,
            ///  TXFIFOE
            TXFIFOE: u1,
            ///  RXFIFOE
            RXFIFOE: u1,
            ///  TXDAVL
            TXDAVL: u1,
            ///  RXDAVL
            RXDAVL: u1,
            ///  SDIOIT
            SDIOIT: u1,
            ///  CEATAEND
            CEATAEND: u1,
            padding: u8,
        }),
        ///  SDIO interrupt clear register (SDIO_ICR)
        ICR: mmio.Mmio(packed struct(u32) {
            ///  CCRCFAILC
            CCRCFAILC: u1,
            ///  DCRCFAILC
            DCRCFAILC: u1,
            ///  CTIMEOUTC
            CTIMEOUTC: u1,
            ///  DTIMEOUTC
            DTIMEOUTC: u1,
            ///  TXUNDERRC
            TXUNDERRC: u1,
            ///  RXOVERRC
            RXOVERRC: u1,
            ///  CMDRENDC
            CMDRENDC: u1,
            ///  CMDSENTC
            CMDSENTC: u1,
            ///  DATAENDC
            DATAENDC: u1,
            ///  STBITERRC
            STBITERRC: u1,
            ///  DBCKENDC
            DBCKENDC: u1,
            reserved22: u11,
            ///  SDIOITC
            SDIOITC: u1,
            ///  CEATAENDC
            CEATAENDC: u1,
            padding: u8,
        }),
        ///  SDIO mask register (SDIO_MASK)
        MASK: mmio.Mmio(packed struct(u32) {
            ///  CCRCFAILIE
            CCRCFAILIE: u1,
            ///  DCRCFAILIE
            DCRCFAILIE: u1,
            ///  CTIMEOUTIE
            CTIMEOUTIE: u1,
            ///  DTIMEOUTIE
            DTIMEOUTIE: u1,
            ///  TXUNDERRIE
            TXUNDERRIE: u1,
            ///  RXOVERRIE
            RXOVERRIE: u1,
            ///  CMDRENDIE
            CMDRENDIE: u1,
            ///  CMDSENTIE
            CMDSENTIE: u1,
            ///  DATAENDIE
            DATAENDIE: u1,
            ///  STBITERRIE
            STBITERRIE: u1,
            ///  DBACKENDIE
            DBACKENDIE: u1,
            ///  CMDACTIE
            CMDACTIE: u1,
            ///  TXACTIE
            TXACTIE: u1,
            ///  RXACTIE
            RXACTIE: u1,
            ///  TXFIFOHEIE
            TXFIFOHEIE: u1,
            ///  RXFIFOHFIE
            RXFIFOHFIE: u1,
            ///  TXFIFOFIE
            TXFIFOFIE: u1,
            ///  RXFIFOFIE
            RXFIFOFIE: u1,
            ///  TXFIFOEIE
            TXFIFOEIE: u1,
            ///  RXFIFOEIE
            RXFIFOEIE: u1,
            ///  TXDAVLIE
            TXDAVLIE: u1,
            ///  RXDAVLIE
            RXDAVLIE: u1,
            ///  SDIOITIE
            SDIOITIE: u1,
            ///  CEATENDIE
            CEATENDIE: u1,
            padding: u8,
        }),
        reserved72: [8]u8,
        ///  Bits 23:0 = FIFOCOUNT: Remaining number of words to be written to or read from the FIFO
        FIFOCNT: mmio.Mmio(packed struct(u32) {
            ///  FIF0COUNT
            FIF0COUNT: u24,
            padding: u8,
        }),
        reserved128: [52]u8,
        ///  bits 31:0 = FIFOData: Receive and transmit FIFO data
        FIFO: mmio.Mmio(packed struct(u32) {
            ///  FIFOData
            FIFOData: u32,
        }),
    };

    ///  Real time clock
    pub const RTC = extern struct {
        ///  RTC Control Register High
        CRH: mmio.Mmio(packed struct(u32) {
            ///  Second interrupt Enable
            SECIE: u1,
            ///  Alarm interrupt Enable
            ALRIE: u1,
            ///  Overflow interrupt Enable
            OWIE: u1,
            padding: u29,
        }),
        ///  RTC Control Register Low
        CRL: mmio.Mmio(packed struct(u32) {
            ///  Second Flag
            SECF: u1,
            ///  Alarm Flag
            ALRF: u1,
            ///  Overflow Flag
            OWF: u1,
            ///  Registers Synchronized Flag
            RSF: u1,
            ///  Configuration Flag
            CNF: u1,
            ///  RTC operation OFF
            RTOFF: u1,
            padding: u26,
        }),
        ///  RTC Prescaler Load Register High
        PRLH: mmio.Mmio(packed struct(u32) {
            ///  RTC Prescaler Load Register High
            PRLH: u4,
            padding: u28,
        }),
        ///  RTC Prescaler Load Register Low
        PRLL: mmio.Mmio(packed struct(u32) {
            ///  RTC Prescaler Divider Register Low
            PRLL: u16,
            padding: u16,
        }),
        ///  RTC Prescaler Divider Register High
        DIVH: mmio.Mmio(packed struct(u32) {
            ///  RTC prescaler divider register high
            DIVH: u4,
            padding: u28,
        }),
        ///  RTC Prescaler Divider Register Low
        DIVL: mmio.Mmio(packed struct(u32) {
            ///  RTC prescaler divider register Low
            DIVL: u16,
            padding: u16,
        }),
        ///  RTC Counter Register High
        CNTH: mmio.Mmio(packed struct(u32) {
            ///  RTC counter register high
            CNTH: u16,
            padding: u16,
        }),
        ///  RTC Counter Register Low
        CNTL: mmio.Mmio(packed struct(u32) {
            ///  RTC counter register Low
            CNTL: u16,
            padding: u16,
        }),
        ///  RTC Alarm Register High
        ALRH: mmio.Mmio(packed struct(u32) {
            ///  RTC alarm register high
            ALRH: u16,
            padding: u16,
        }),
        ///  RTC Alarm Register Low
        ALRL: mmio.Mmio(packed struct(u32) {
            ///  RTC alarm register low
            ALRL: u16,
            padding: u16,
        }),
    };

    ///  Backup registers
    pub const BKP = extern struct {
        ///  Backup data register (BKP_DR)
        DR1: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D1: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR2: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D2: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR3: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D3: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR4: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D4: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR5: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D5: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR6: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D6: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR7: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D7: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR8: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D8: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR9: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D9: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR10: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D10: u16,
            padding: u16,
        }),
        ///  RTC clock calibration register (BKP_RTCCR)
        RTCCR: mmio.Mmio(packed struct(u32) {
            ///  Calibration value
            CAL: u7,
            ///  Calibration Clock Output
            CCO: u1,
            ///  Alarm or second output enable
            ASOE: u1,
            ///  Alarm or second output selection
            ASOS: u1,
            padding: u22,
        }),
        ///  Backup control register (BKP_CR)
        CR: mmio.Mmio(packed struct(u32) {
            ///  Tamper pin enable
            TPE: u1,
            ///  Tamper pin active level
            TPAL: u1,
            padding: u30,
        }),
        ///  BKP_CSR control/status register (BKP_CSR)
        CSR: mmio.Mmio(packed struct(u32) {
            ///  Clear Tamper event
            CTE: u1,
            ///  Clear Tamper Interrupt
            CTI: u1,
            ///  Tamper Pin interrupt enable
            TPIE: u1,
            reserved8: u5,
            ///  Tamper Event Flag
            TEF: u1,
            ///  Tamper Interrupt Flag
            TIF: u1,
            padding: u22,
        }),
        reserved60: [8]u8,
        ///  Backup data register (BKP_DR)
        DR11: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            DR11: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR12: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            DR12: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR13: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            DR13: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR14: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D14: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR15: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D15: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR16: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D16: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR17: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D17: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR18: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D18: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR19: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D19: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR20: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D20: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR21: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D21: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR22: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D22: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR23: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D23: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR24: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D24: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR25: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D25: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR26: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D26: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR27: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D27: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR28: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D28: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR29: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D29: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR30: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D30: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR31: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D31: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR32: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D32: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR33: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D33: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR34: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D34: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR35: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D35: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR36: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D36: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR37: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D37: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR38: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D38: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR39: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D39: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR40: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D40: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR41: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D41: u16,
            padding: u16,
        }),
        ///  Backup data register (BKP_DR)
        DR42: mmio.Mmio(packed struct(u32) {
            ///  Backup data
            D42: u16,
            padding: u16,
        }),
    };

    ///  Independent watchdog
    pub const IWDG = extern struct {
        ///  Key register (IWDG_KR)
        KR: mmio.Mmio(packed struct(u32) {
            ///  Key value
            KEY: u16,
            padding: u16,
        }),
        ///  Prescaler register (IWDG_PR)
        PR: mmio.Mmio(packed struct(u32) {
            ///  Prescaler divider
            PR: u3,
            padding: u29,
        }),
        ///  Reload register (IWDG_RLR)
        RLR: mmio.Mmio(packed struct(u32) {
            ///  Watchdog counter reload value
            RL: u12,
            padding: u20,
        }),
        ///  Status register (IWDG_SR)
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
        ///  Control register (WWDG_CR)
        CR: mmio.Mmio(packed struct(u32) {
            ///  7-bit counter (MSB to LSB)
            T: u7,
            ///  Activation bit
            WDGA: u1,
            padding: u24,
        }),
        ///  Configuration register (WWDG_CFR)
        CFR: mmio.Mmio(packed struct(u32) {
            ///  7-bit window value
            W: u7,
            ///  Timer Base
            WDGTB: u2,
            ///  Early Wakeup Interrupt
            EWI: u1,
            padding: u22,
        }),
        ///  Status register (WWDG_SR)
        SR: mmio.Mmio(packed struct(u32) {
            ///  Early Wakeup Interrupt
            EWI: u1,
            padding: u31,
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
            padding: u16,
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

    ///  Ethernet: Precision time protocol
    pub const ETHERNET_PTP = extern struct {
        ///  Ethernet PTP time stamp control register (ETH_PTPTSCR)
        PTPTSCR: mmio.Mmio(packed struct(u32) {
            ///  Time stamp enable
            TSE: u1,
            ///  Time stamp fine or coarse update
            TSFCU: u1,
            ///  Time stamp system time initialize
            TSSTI: u1,
            ///  Time stamp system time update
            TSSTU: u1,
            ///  Time stamp interrupt trigger enable
            TSITE: u1,
            ///  Time stamp addend register update
            TSARU: u1,
            padding: u26,
        }),
        ///  Ethernet PTP subsecond increment register
        PTPSSIR: mmio.Mmio(packed struct(u32) {
            ///  System time subsecond increment
            STSSI: u8,
            padding: u24,
        }),
        ///  Ethernet PTP time stamp high register
        PTPTSHR: mmio.Mmio(packed struct(u32) {
            ///  System time second
            STS: u32,
        }),
        ///  Ethernet PTP time stamp low register (ETH_PTPTSLR)
        PTPTSLR: mmio.Mmio(packed struct(u32) {
            ///  System time subseconds
            STSS: u31,
            ///  System time positive or negative sign
            STPNS: u1,
        }),
        ///  Ethernet PTP time stamp high update register
        PTPTSHUR: mmio.Mmio(packed struct(u32) {
            ///  Time stamp update second
            TSUS: u32,
        }),
        ///  Ethernet PTP time stamp low update register (ETH_PTPTSLUR)
        PTPTSLUR: mmio.Mmio(packed struct(u32) {
            ///  Time stamp update subseconds
            TSUSS: u31,
            ///  Time stamp update positive or negative sign
            TSUPNS: u1,
        }),
        ///  Ethernet PTP time stamp addend register
        PTPTSAR: mmio.Mmio(packed struct(u32) {
            ///  Time stamp addend
            TSA: u32,
        }),
        ///  Ethernet PTP target time high register
        PTPTTHR: mmio.Mmio(packed struct(u32) {
            ///  Target time stamp high
            TTSH: u32,
        }),
        ///  Ethernet PTP target time low register
        PTPTTLR: mmio.Mmio(packed struct(u32) {
            ///  Target time stamp low
            TTSL: u32,
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
            O24CE: u1,
            padding: u16,
        }),
        ///  capture/compare enable register
        CCER: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 output enable
            CC1E: u1,
            ///  Capture/Compare 1 output Polarity
            CC1P: u1,
            reserved4: u2,
            ///  Capture/Compare 2 output enable
            CC2E: u1,
            ///  Capture/Compare 2 output Polarity
            CC2P: u1,
            reserved8: u2,
            ///  Capture/Compare 3 output enable
            CC3E: u1,
            ///  Capture/Compare 3 output Polarity
            CC3P: u1,
            reserved12: u2,
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

    ///  Ethernet: media access control
    pub const ETHERNET_MAC = extern struct {
        ///  Ethernet MAC configuration register (ETH_MACCR)
        MACCR: mmio.Mmio(packed struct(u32) {
            reserved2: u2,
            ///  Receiver enable
            RE: u1,
            ///  Transmitter enable
            TE: u1,
            ///  Deferral check
            DC: u1,
            ///  Back-off limit
            BL: u2,
            ///  Automatic pad/CRC stripping
            APCS: u1,
            reserved9: u1,
            ///  Retry disable
            RD: u1,
            ///  IPv4 checksum offload
            IPCO: u1,
            ///  Duplex mode
            DM: u1,
            ///  Loopback mode
            LM: u1,
            ///  Receive own disable
            ROD: u1,
            ///  Fast Ethernet speed
            FES: u1,
            reserved16: u1,
            ///  Carrier sense disable
            CSD: u1,
            ///  Interframe gap
            IFG: u3,
            reserved22: u2,
            ///  Jabber disable
            JD: u1,
            ///  Watchdog disable
            WD: u1,
            padding: u8,
        }),
        ///  Ethernet MAC frame filter register (ETH_MACCFFR)
        MACFFR: mmio.Mmio(packed struct(u32) {
            ///  Promiscuous mode
            PM: u1,
            ///  Hash unicast
            HU: u1,
            ///  Hash multicast
            HM: u1,
            ///  Destination address inverse filtering
            DAIF: u1,
            ///  Pass all multicast
            PAM: u1,
            ///  Broadcast frames disable
            BFD: u1,
            ///  Pass control frames
            PCF: u2,
            ///  Source address inverse filtering
            SAIF: u1,
            ///  Source address filter
            SAF: u1,
            ///  Hash or perfect filter
            HPF: u1,
            reserved31: u20,
            ///  Receive all
            RA: u1,
        }),
        ///  Ethernet MAC hash table high register
        MACHTHR: mmio.Mmio(packed struct(u32) {
            ///  Hash table high
            HTH: u32,
        }),
        ///  Ethernet MAC hash table low register
        MACHTLR: mmio.Mmio(packed struct(u32) {
            ///  Hash table low
            HTL: u32,
        }),
        ///  Ethernet MAC MII address register (ETH_MACMIIAR)
        MACMIIAR: mmio.Mmio(packed struct(u32) {
            ///  MII busy
            MB: u1,
            ///  MII write
            MW: u1,
            ///  Clock range
            CR: u3,
            reserved6: u1,
            ///  MII register
            MR: u5,
            ///  PHY address
            PA: u5,
            padding: u16,
        }),
        ///  Ethernet MAC MII data register (ETH_MACMIIDR)
        MACMIIDR: mmio.Mmio(packed struct(u32) {
            ///  MII data
            MD: u16,
            padding: u16,
        }),
        ///  Ethernet MAC flow control register (ETH_MACFCR)
        MACFCR: mmio.Mmio(packed struct(u32) {
            ///  Flow control busy/back pressure activate
            FCB_BPA: u1,
            ///  Transmit flow control enable
            TFCE: u1,
            ///  Receive flow control enable
            RFCE: u1,
            ///  Unicast pause frame detect
            UPFD: u1,
            ///  Pause low threshold
            PLT: u2,
            reserved7: u1,
            ///  Zero-quanta pause disable
            ZQPD: u1,
            reserved16: u8,
            ///  Pass control frames
            PT: u16,
        }),
        ///  Ethernet MAC VLAN tag register (ETH_MACVLANTR)
        MACVLANTR: mmio.Mmio(packed struct(u32) {
            ///  VLAN tag identifier (for receive frames)
            VLANTI: u16,
            ///  12-bit VLAN tag comparison
            VLANTC: u1,
            padding: u15,
        }),
        reserved40: [8]u8,
        ///  Ethernet MAC remote wakeup frame filter register (ETH_MACRWUFFR)
        MACRWUFFR: u32,
        ///  Ethernet MAC PMT control and status register (ETH_MACPMTCSR)
        MACPMTCSR: mmio.Mmio(packed struct(u32) {
            ///  Power down
            PD: u1,
            ///  Magic Packet enable
            MPE: u1,
            ///  Wakeup frame enable
            WFE: u1,
            reserved5: u2,
            ///  Magic packet received
            MPR: u1,
            ///  Wakeup frame received
            WFR: u1,
            reserved9: u2,
            ///  Global unicast
            GU: u1,
            reserved31: u21,
            ///  Wakeup frame filter register pointer reset
            WFFRPR: u1,
        }),
        reserved56: [8]u8,
        ///  Ethernet MAC interrupt status register (ETH_MACSR)
        MACSR: mmio.Mmio(packed struct(u32) {
            reserved3: u3,
            ///  PMT status
            PMTS: u1,
            ///  MMC status
            MMCS: u1,
            ///  MMC receive status
            MMCRS: u1,
            ///  MMC transmit status
            MMCTS: u1,
            reserved9: u2,
            ///  Time stamp trigger status
            TSTS: u1,
            padding: u22,
        }),
        ///  Ethernet MAC interrupt mask register (ETH_MACIMR)
        MACIMR: mmio.Mmio(packed struct(u32) {
            reserved3: u3,
            ///  PMT interrupt mask
            PMTIM: u1,
            reserved9: u5,
            ///  Time stamp trigger interrupt mask
            TSTIM: u1,
            padding: u22,
        }),
        ///  Ethernet MAC address 0 high register (ETH_MACA0HR)
        MACA0HR: mmio.Mmio(packed struct(u32) {
            ///  MAC address0 high
            MACA0H: u16,
            reserved31: u15,
            ///  Always 1
            MO: u1,
        }),
        ///  Ethernet MAC address 0 low register
        MACA0LR: mmio.Mmio(packed struct(u32) {
            ///  MAC address0 low
            MACA0L: u32,
        }),
        ///  Ethernet MAC address 1 high register (ETH_MACA1HR)
        MACA1HR: mmio.Mmio(packed struct(u32) {
            ///  MAC address1 high
            MACA1H: u16,
            reserved24: u8,
            ///  Mask byte control
            MBC: u6,
            ///  Source address
            SA: u1,
            ///  Address enable
            AE: u1,
        }),
        ///  Ethernet MAC address1 low register
        MACA1LR: mmio.Mmio(packed struct(u32) {
            ///  MAC address1 low
            MACA1L: u32,
        }),
        ///  Ethernet MAC address 2 high register (ETH_MACA2HR)
        MACA2HR: mmio.Mmio(packed struct(u32) {
            ///  Ethernet MAC address 2 high register
            ETH_MACA2HR: u16,
            reserved24: u8,
            ///  Mask byte control
            MBC: u6,
            ///  Source address
            SA: u1,
            ///  Address enable
            AE: u1,
        }),
        ///  Ethernet MAC address 2 low register
        MACA2LR: mmio.Mmio(packed struct(u32) {
            ///  MAC address2 low
            MACA2L: u31,
            padding: u1,
        }),
        ///  Ethernet MAC address 3 high register (ETH_MACA3HR)
        MACA3HR: mmio.Mmio(packed struct(u32) {
            ///  MAC address3 high
            MACA3H: u16,
            reserved24: u8,
            ///  Mask byte control
            MBC: u6,
            ///  Source address
            SA: u1,
            ///  Address enable
            AE: u1,
        }),
        ///  Ethernet MAC address 3 low register
        MACA3LR: mmio.Mmio(packed struct(u32) {
            ///  MAC address3 low
            MBCA3L: u32,
        }),
    };

    ///  Ethernet: MAC management counters
    pub const ETHERNET_MMC = extern struct {
        ///  Ethernet MMC control register (ETH_MMCCR)
        MMCCR: mmio.Mmio(packed struct(u32) {
            ///  Counter reset
            CR: u1,
            ///  Counter stop rollover
            CSR: u1,
            ///  Reset on read
            ROR: u1,
            reserved31: u28,
            ///  MMC counter freeze
            MCF: u1,
        }),
        ///  Ethernet MMC receive interrupt register (ETH_MMCRIR)
        MMCRIR: mmio.Mmio(packed struct(u32) {
            reserved5: u5,
            ///  Received frames CRC error status
            RFCES: u1,
            ///  Received frames alignment error status
            RFAES: u1,
            reserved17: u10,
            ///  Received Good Unicast Frames Status
            RGUFS: u1,
            padding: u14,
        }),
        ///  Ethernet MMC transmit interrupt register (ETH_MMCTIR)
        MMCTIR: mmio.Mmio(packed struct(u32) {
            reserved14: u14,
            ///  Transmitted good frames single collision status
            TGFSCS: u1,
            ///  Transmitted good frames more single collision status
            TGFMSCS: u1,
            reserved21: u5,
            ///  Transmitted good frames status
            TGFS: u1,
            padding: u10,
        }),
        ///  Ethernet MMC receive interrupt mask register (ETH_MMCRIMR)
        MMCRIMR: mmio.Mmio(packed struct(u32) {
            reserved5: u5,
            ///  Received frame CRC error mask
            RFCEM: u1,
            ///  Received frames alignment error mask
            RFAEM: u1,
            reserved17: u10,
            ///  Received good unicast frames mask
            RGUFM: u1,
            padding: u14,
        }),
        ///  Ethernet MMC transmit interrupt mask register (ETH_MMCTIMR)
        MMCTIMR: mmio.Mmio(packed struct(u32) {
            reserved14: u14,
            ///  Transmitted good frames single collision mask
            TGFSCM: u1,
            ///  Transmitted good frames more single collision mask
            TGFMSCM: u1,
            reserved21: u5,
            ///  Transmitted good frames mask
            TGFM: u1,
            padding: u10,
        }),
        reserved76: [56]u8,
        ///  Ethernet MMC transmitted good frames after a single collision counter
        MMCTGFSCCR: mmio.Mmio(packed struct(u32) {
            ///  Transmitted good frames after a single collision counter
            TGFSCC: u32,
        }),
        ///  Ethernet MMC transmitted good frames after more than a single collision
        MMCTGFMSCCR: mmio.Mmio(packed struct(u32) {
            ///  Transmitted good frames after more than a single collision counter
            TGFMSCC: u32,
        }),
        reserved104: [20]u8,
        ///  Ethernet MMC transmitted good frames counter register
        MMCTGFCR: mmio.Mmio(packed struct(u32) {
            ///  Transmitted good frames counter
            TGFC: u32,
        }),
        reserved148: [40]u8,
        ///  Ethernet MMC received frames with CRC error counter register
        MMCRFCECR: mmio.Mmio(packed struct(u32) {
            ///  Received frames with CRC error counter
            RFCFC: u32,
        }),
        ///  Ethernet MMC received frames with alignment error counter register
        MMCRFAECR: mmio.Mmio(packed struct(u32) {
            ///  Received frames with alignment error counter
            RFAEC: u32,
        }),
        reserved196: [40]u8,
        ///  MMC received good unicast frames counter register
        MMCRGUFCR: mmio.Mmio(packed struct(u32) {
            ///  Received good unicast frames counter
            RGUFC: u32,
        }),
    };

    ///  USB on the go full speed
    pub const OTG_FS_PWRCLK = extern struct {
        ///  OTG_FS power and clock gating control register
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

    ///  General purpose timer
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

    ///  General purpose timer
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
        ///  capture/compare mode register (output mode)
        CCMR1_Output: mmio.Mmio(packed struct(u32) {
            ///  Capture/Compare 1 selection
            CC1S: u2,
            reserved3: u1,
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

    ///  Universal serial bus full-speed device interface
    pub const USB = extern struct {
        ///  endpoint 0 register
        EP0R: mmio.Mmio(packed struct(u32) {
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
        EP1R: mmio.Mmio(packed struct(u32) {
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
        EP2R: mmio.Mmio(packed struct(u32) {
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
        EP3R: mmio.Mmio(packed struct(u32) {
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
        EP4R: mmio.Mmio(packed struct(u32) {
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
        EP5R: mmio.Mmio(packed struct(u32) {
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
        EP6R: mmio.Mmio(packed struct(u32) {
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
        EP7R: mmio.Mmio(packed struct(u32) {
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
        CNTR: mmio.Mmio(packed struct(u32) {
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
            ADD: u7,
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

    ///  Basic timer
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

    ///  FLASH
    pub const FLASH = extern struct {
        ///  Flash access control register
        ACR: mmio.Mmio(packed struct(u32) {
            ///  Latency
            LATENCY: u3,
            ///  Flash half cycle access enable
            HLFCYA: u1,
            ///  Prefetch buffer enable
            PRFTBE: u1,
            ///  Prefetch buffer status
            PRFTBS: u1,
            padding: u26,
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
            ///  Busy
            BSY: u1,
            reserved2: u1,
            ///  Programming error
            PGERR: u1,
            reserved4: u1,
            ///  Write protection error
            WRPRTERR: u1,
            ///  End of operation
            EOP: u1,
            padding: u26,
        }),
        ///  Control register
        CR: mmio.Mmio(packed struct(u32) {
            ///  Programming
            PG: u1,
            ///  Page Erase
            PER: u1,
            ///  Mass Erase
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
            padding: u19,
        }),
        ///  Flash address register
        AR: mmio.Mmio(packed struct(u32) {
            ///  Flash Address
            FAR: u32,
        }),
        reserved28: [4]u8,
        ///  Option byte register
        OBR: mmio.Mmio(packed struct(u32) {
            ///  Option byte error
            OPTERR: u1,
            ///  Read protection
            RDPRT: u1,
            ///  WDG_SW
            WDG_SW: u1,
            ///  nRST_STOP
            nRST_STOP: u1,
            ///  nRST_STDBY
            nRST_STDBY: u1,
            reserved10: u5,
            ///  Data0
            Data0: u8,
            ///  Data1
            Data1: u8,
            padding: u6,
        }),
        ///  Write protection register
        WRPR: mmio.Mmio(packed struct(u32) {
            ///  Write protect
            WRP: u32,
        }),
    };

    ///  Inter integrated circuit
    pub const I2C1 = extern struct {
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
    };

    ///  CRC calculation unit
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
            ///  Reset bit
            RESET: u1,
            padding: u31,
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
            reserved5: u2,
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
            padding: u24,
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

    ///  Universal asynchronous receiver transmitter
    pub const UART5 = extern struct {
        ///  UART4_SR
        SR: mmio.Mmio(packed struct(u32) {
            ///  PE
            PE: u1,
            ///  FE
            FE: u1,
            ///  NE
            NE: u1,
            ///  ORE
            ORE: u1,
            ///  IDLE
            IDLE: u1,
            ///  RXNE
            RXNE: u1,
            ///  TC
            TC: u1,
            ///  TXE
            TXE: u1,
            ///  LBD
            LBD: u1,
            padding: u23,
        }),
        ///  UART4_DR
        DR: mmio.Mmio(packed struct(u32) {
            ///  DR
            DR: u9,
            padding: u23,
        }),
        ///  UART4_BRR
        BRR: mmio.Mmio(packed struct(u32) {
            ///  DIV_Fraction
            DIV_Fraction: u4,
            ///  DIV_Mantissa
            DIV_Mantissa: u12,
            padding: u16,
        }),
        ///  UART4_CR1
        CR1: mmio.Mmio(packed struct(u32) {
            ///  SBK
            SBK: u1,
            ///  RWU
            RWU: u1,
            ///  RE
            RE: u1,
            ///  TE
            TE: u1,
            ///  IDLEIE
            IDLEIE: u1,
            ///  RXNEIE
            RXNEIE: u1,
            ///  TCIE
            TCIE: u1,
            ///  TXEIE
            TXEIE: u1,
            ///  PEIE
            PEIE: u1,
            ///  PS
            PS: u1,
            ///  PCE
            PCE: u1,
            ///  WAKE
            WAKE: u1,
            ///  M
            M: u1,
            ///  UE
            UE: u1,
            padding: u18,
        }),
        ///  UART4_CR2
        CR2: mmio.Mmio(packed struct(u32) {
            ///  ADD
            ADD: u4,
            reserved5: u1,
            ///  LBDL
            LBDL: u1,
            ///  LBDIE
            LBDIE: u1,
            reserved12: u5,
            ///  STOP
            STOP: u2,
            ///  LINEN
            LINEN: u1,
            padding: u17,
        }),
        ///  UART4_CR3
        CR3: mmio.Mmio(packed struct(u32) {
            ///  Error interrupt enable
            EIE: u1,
            ///  IrDA mode enable
            IREN: u1,
            ///  IrDA low-power
            IRLP: u1,
            ///  Half-duplex selection
            HDSEL: u1,
            reserved7: u3,
            ///  DMA enable transmitter
            DMAT: u1,
            padding: u24,
        }),
    };

    ///  Universal asynchronous receiver transmitter
    pub const UART4 = extern struct {
        ///  UART4_SR
        SR: mmio.Mmio(packed struct(u32) {
            ///  Parity error
            PE: u1,
            ///  Framing error
            FE: u1,
            ///  Noise error flag
            NE: u1,
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
        ///  UART4_DR
        DR: mmio.Mmio(packed struct(u32) {
            ///  DR
            DR: u9,
            padding: u23,
        }),
        ///  UART4_BRR
        BRR: mmio.Mmio(packed struct(u32) {
            ///  DIV_Fraction
            DIV_Fraction: u4,
            ///  DIV_Mantissa
            DIV_Mantissa: u12,
            padding: u16,
        }),
        ///  UART4_CR1
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
            padding: u18,
        }),
        ///  UART4_CR2
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
        ///  UART4_CR3
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
            padding: u24,
        }),
    };

    ///  Universal synchronous asynchronous receiver transmitter
    pub const USART1 = extern struct {
        ///  Status register
        SR: mmio.Mmio(packed struct(u32) {
            ///  Parity error
            PE: u1,
            ///  Framing error
            FE: u1,
            ///  Noise error flag
            NE: u1,
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
            padding: u18,
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
            padding: u21,
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

    ///  Debug support
    pub const DBG = extern struct {
        ///  DBGMCU_IDCODE
        IDCODE: mmio.Mmio(packed struct(u32) {
            ///  DEV_ID
            DEV_ID: u12,
            reserved16: u4,
            ///  REV_ID
            REV_ID: u16,
        }),
        ///  DBGMCU_CR
        CR: mmio.Mmio(packed struct(u32) {
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
            ///  DBG_IWDG_STOP
            DBG_IWDG_STOP: u1,
            ///  DBG_WWDG_STOP
            DBG_WWDG_STOP: u1,
            ///  DBG_TIM1_STOP
            DBG_TIM1_STOP: u1,
            ///  DBG_TIM2_STOP
            DBG_TIM2_STOP: u1,
            ///  DBG_TIM3_STOP
            DBG_TIM3_STOP: u1,
            ///  DBG_TIM4_STOP
            DBG_TIM4_STOP: u1,
            ///  DBG_CAN1_STOP
            DBG_CAN1_STOP: u1,
            ///  DBG_I2C1_SMBUS_TIMEOUT
            DBG_I2C1_SMBUS_TIMEOUT: u1,
            ///  DBG_I2C2_SMBUS_TIMEOUT
            DBG_I2C2_SMBUS_TIMEOUT: u1,
            ///  DBG_TIM8_STOP
            DBG_TIM8_STOP: u1,
            ///  DBG_TIM5_STOP
            DBG_TIM5_STOP: u1,
            ///  DBG_TIM6_STOP
            DBG_TIM6_STOP: u1,
            ///  DBG_TIM7_STOP
            DBG_TIM7_STOP: u1,
            ///  DBG_CAN2_STOP
            DBG_CAN2_STOP: u1,
            padding: u10,
        }),
    };

    ///  Digital to analog converter
    pub const DAC = extern struct {
        ///  Control register (DAC_CR)
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
            reserved16: u3,
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
            padding: u3,
        }),
        ///  DAC software trigger register (DAC_SWTRIGR)
        SWTRIGR: mmio.Mmio(packed struct(u32) {
            ///  DAC channel1 software trigger
            SWTRIG1: u1,
            ///  DAC channel2 software trigger
            SWTRIG2: u1,
            padding: u30,
        }),
        ///  DAC channel1 12-bit right-aligned data holding register(DAC_DHR12R1)
        DHR12R1: mmio.Mmio(packed struct(u32) {
            ///  DAC channel1 12-bit right-aligned data
            DACC1DHR: u12,
            padding: u20,
        }),
        ///  DAC channel1 12-bit left aligned data holding register (DAC_DHR12L1)
        DHR12L1: mmio.Mmio(packed struct(u32) {
            reserved4: u4,
            ///  DAC channel1 12-bit left-aligned data
            DACC1DHR: u12,
            padding: u16,
        }),
        ///  DAC channel1 8-bit right aligned data holding register (DAC_DHR8R1)
        DHR8R1: mmio.Mmio(packed struct(u32) {
            ///  DAC channel1 8-bit right-aligned data
            DACC1DHR: u8,
            padding: u24,
        }),
        ///  DAC channel2 12-bit right aligned data holding register (DAC_DHR12R2)
        DHR12R2: mmio.Mmio(packed struct(u32) {
            ///  DAC channel2 12-bit right-aligned data
            DACC2DHR: u12,
            padding: u20,
        }),
        ///  DAC channel2 12-bit left aligned data holding register (DAC_DHR12L2)
        DHR12L2: mmio.Mmio(packed struct(u32) {
            reserved4: u4,
            ///  DAC channel2 12-bit left-aligned data
            DACC2DHR: u12,
            padding: u16,
        }),
        ///  DAC channel2 8-bit right-aligned data holding register (DAC_DHR8R2)
        DHR8R2: mmio.Mmio(packed struct(u32) {
            ///  DAC channel2 8-bit right-aligned data
            DACC2DHR: u8,
            padding: u24,
        }),
        ///  Dual DAC 12-bit right-aligned data holding register (DAC_DHR12RD), Bits 31:28 Reserved, Bits 15:12 Reserved
        DHR12RD: mmio.Mmio(packed struct(u32) {
            ///  DAC channel1 12-bit right-aligned data
            DACC1DHR: u12,
            reserved16: u4,
            ///  DAC channel2 12-bit right-aligned data
            DACC2DHR: u12,
            padding: u4,
        }),
        ///  DUAL DAC 12-bit left aligned data holding register (DAC_DHR12LD), Bits 19:16 Reserved, Bits 3:0 Reserved
        DHR12LD: mmio.Mmio(packed struct(u32) {
            reserved4: u4,
            ///  DAC channel1 12-bit left-aligned data
            DACC1DHR: u12,
            reserved20: u4,
            ///  DAC channel2 12-bit right-aligned data
            DACC2DHR: u12,
        }),
        ///  DUAL DAC 8-bit right aligned data holding register (DAC_DHR8RD), Bits 31:16 Reserved
        DHR8RD: mmio.Mmio(packed struct(u32) {
            ///  DAC channel1 8-bit right-aligned data
            DACC1DHR: u8,
            ///  DAC channel2 8-bit right-aligned data
            DACC2DHR: u8,
            padding: u16,
        }),
        ///  DAC channel1 data output register (DAC_DOR1)
        DOR1: mmio.Mmio(packed struct(u32) {
            ///  DAC channel1 data output
            DACC1DOR: u12,
            padding: u20,
        }),
        ///  DAC channel2 data output register (DAC_DOR2)
        DOR2: mmio.Mmio(packed struct(u32) {
            ///  DAC channel2 data output
            DACC2DOR: u12,
            padding: u20,
        }),
    };

    ///  Analog to digital converter
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
            padding: u27,
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
            ///  Dual mode selection
            DUALMOD: u4,
            reserved22: u2,
            ///  Analog watchdog enable on injected channels
            JAWDEN: u1,
            ///  Analog watchdog enable on regular channels
            AWDEN: u1,
            padding: u8,
        }),
        ///  control register 2
        CR2: mmio.Mmio(packed struct(u32) {
            ///  A/D converter ON / OFF
            ADON: u1,
            ///  Continuous conversion
            CONT: u1,
            ///  A/D calibration
            CAL: u1,
            ///  Reset calibration
            RSTCAL: u1,
            reserved8: u4,
            ///  Direct memory access mode
            DMA: u1,
            reserved11: u2,
            ///  Data alignment
            ALIGN: u1,
            ///  External event select for injected group
            JEXTSEL: u3,
            ///  External trigger conversion mode for injected channels
            JEXTTRIG: u1,
            reserved17: u1,
            ///  External event select for regular group
            EXTSEL: u3,
            ///  External trigger conversion mode for regular channels
            EXTTRIG: u1,
            ///  Start conversion of injected channels
            JSWSTART: u1,
            ///  Start conversion of regular channels
            SWSTART: u1,
            ///  Temperature sensor and VREFINT enable
            TSVREFE: u1,
            padding: u8,
        }),
        ///  sample time register 1
        SMPR1: mmio.Mmio(packed struct(u32) {
            ///  Channel 10 sample time selection
            SMP10: u3,
            ///  Channel 11 sample time selection
            SMP11: u3,
            ///  Channel 12 sample time selection
            SMP12: u3,
            ///  Channel 13 sample time selection
            SMP13: u3,
            ///  Channel 14 sample time selection
            SMP14: u3,
            ///  Channel 15 sample time selection
            SMP15: u3,
            ///  Channel 16 sample time selection
            SMP16: u3,
            ///  Channel 17 sample time selection
            SMP17: u3,
            padding: u8,
        }),
        ///  sample time register 2
        SMPR2: mmio.Mmio(packed struct(u32) {
            ///  Channel 0 sample time selection
            SMP0: u3,
            ///  Channel 1 sample time selection
            SMP1: u3,
            ///  Channel 2 sample time selection
            SMP2: u3,
            ///  Channel 3 sample time selection
            SMP3: u3,
            ///  Channel 4 sample time selection
            SMP4: u3,
            ///  Channel 5 sample time selection
            SMP5: u3,
            ///  Channel 6 sample time selection
            SMP6: u3,
            ///  Channel 7 sample time selection
            SMP7: u3,
            ///  Channel 8 sample time selection
            SMP8: u3,
            ///  Channel 9 sample time selection
            SMP9: u3,
            padding: u2,
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
            ///  ADC2 data
            ADC2DATA: u16,
        }),
    };

    ///  Analog to digital converter
    pub const ADC2 = extern struct {
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
            padding: u27,
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
            padding: u8,
        }),
        ///  control register 2
        CR2: mmio.Mmio(packed struct(u32) {
            ///  A/D converter ON / OFF
            ADON: u1,
            ///  Continuous conversion
            CONT: u1,
            ///  A/D calibration
            CAL: u1,
            ///  Reset calibration
            RSTCAL: u1,
            reserved8: u4,
            ///  Direct memory access mode
            DMA: u1,
            reserved11: u2,
            ///  Data alignment
            ALIGN: u1,
            ///  External event select for injected group
            JEXTSEL: u3,
            ///  External trigger conversion mode for injected channels
            JEXTTRIG: u1,
            reserved17: u1,
            ///  External event select for regular group
            EXTSEL: u3,
            ///  External trigger conversion mode for regular channels
            EXTTRIG: u1,
            ///  Start conversion of injected channels
            JSWSTART: u1,
            ///  Start conversion of regular channels
            SWSTART: u1,
            ///  Temperature sensor and VREFINT enable
            TSVREFE: u1,
            padding: u8,
        }),
        ///  sample time register 1
        SMPR1: mmio.Mmio(packed struct(u32) {
            ///  Channel 10 sample time selection
            SMP10: u3,
            ///  Channel 11 sample time selection
            SMP11: u3,
            ///  Channel 12 sample time selection
            SMP12: u3,
            ///  Channel 13 sample time selection
            SMP13: u3,
            ///  Channel 14 sample time selection
            SMP14: u3,
            ///  Channel 15 sample time selection
            SMP15: u3,
            ///  Channel 16 sample time selection
            SMP16: u3,
            ///  Channel 17 sample time selection
            SMP17: u3,
            padding: u8,
        }),
        ///  sample time register 2
        SMPR2: mmio.Mmio(packed struct(u32) {
            ///  Channel 0 sample time selection
            SMP0: u3,
            ///  Channel 1 sample time selection
            SMP1: u3,
            ///  Channel 2 sample time selection
            SMP2: u3,
            ///  Channel 3 sample time selection
            SMP3: u3,
            ///  Channel 4 sample time selection
            SMP4: u3,
            ///  Channel 5 sample time selection
            SMP5: u3,
            ///  Channel 6 sample time selection
            SMP6: u3,
            ///  Channel 7 sample time selection
            SMP7: u3,
            ///  Channel 8 sample time selection
            SMP8: u3,
            ///  Channel 9 sample time selection
            SMP9: u3,
            padding: u2,
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

    ///  Controller area network
    pub const CAN1 = extern struct {
        ///  CAN_MCR
        CAN_MCR: mmio.Mmio(packed struct(u32) {
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
        ///  CAN_MSR
        CAN_MSR: mmio.Mmio(packed struct(u32) {
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
        ///  CAN_TSR
        CAN_TSR: mmio.Mmio(packed struct(u32) {
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
        ///  CAN_RF0R
        CAN_RF0R: mmio.Mmio(packed struct(u32) {
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
        ///  CAN_RF1R
        CAN_RF1R: mmio.Mmio(packed struct(u32) {
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
        ///  CAN_IER
        CAN_IER: mmio.Mmio(packed struct(u32) {
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
        ///  CAN_ESR
        CAN_ESR: mmio.Mmio(packed struct(u32) {
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
        ///  CAN_BTR
        CAN_BTR: mmio.Mmio(packed struct(u32) {
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
        ///  CAN_TI0R
        CAN_TI0R: mmio.Mmio(packed struct(u32) {
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
        ///  CAN_TDT0R
        CAN_TDT0R: mmio.Mmio(packed struct(u32) {
            ///  DLC
            DLC: u4,
            reserved8: u4,
            ///  TGT
            TGT: u1,
            reserved16: u7,
            ///  TIME
            TIME: u16,
        }),
        ///  CAN_TDL0R
        CAN_TDL0R: mmio.Mmio(packed struct(u32) {
            ///  DATA0
            DATA0: u8,
            ///  DATA1
            DATA1: u8,
            ///  DATA2
            DATA2: u8,
            ///  DATA3
            DATA3: u8,
        }),
        ///  CAN_TDH0R
        CAN_TDH0R: mmio.Mmio(packed struct(u32) {
            ///  DATA4
            DATA4: u8,
            ///  DATA5
            DATA5: u8,
            ///  DATA6
            DATA6: u8,
            ///  DATA7
            DATA7: u8,
        }),
        ///  CAN_TI1R
        CAN_TI1R: mmio.Mmio(packed struct(u32) {
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
        ///  CAN_TDT1R
        CAN_TDT1R: mmio.Mmio(packed struct(u32) {
            ///  DLC
            DLC: u4,
            reserved8: u4,
            ///  TGT
            TGT: u1,
            reserved16: u7,
            ///  TIME
            TIME: u16,
        }),
        ///  CAN_TDL1R
        CAN_TDL1R: mmio.Mmio(packed struct(u32) {
            ///  DATA0
            DATA0: u8,
            ///  DATA1
            DATA1: u8,
            ///  DATA2
            DATA2: u8,
            ///  DATA3
            DATA3: u8,
        }),
        ///  CAN_TDH1R
        CAN_TDH1R: mmio.Mmio(packed struct(u32) {
            ///  DATA4
            DATA4: u8,
            ///  DATA5
            DATA5: u8,
            ///  DATA6
            DATA6: u8,
            ///  DATA7
            DATA7: u8,
        }),
        ///  CAN_TI2R
        CAN_TI2R: mmio.Mmio(packed struct(u32) {
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
        ///  CAN_TDT2R
        CAN_TDT2R: mmio.Mmio(packed struct(u32) {
            ///  DLC
            DLC: u4,
            reserved8: u4,
            ///  TGT
            TGT: u1,
            reserved16: u7,
            ///  TIME
            TIME: u16,
        }),
        ///  CAN_TDL2R
        CAN_TDL2R: mmio.Mmio(packed struct(u32) {
            ///  DATA0
            DATA0: u8,
            ///  DATA1
            DATA1: u8,
            ///  DATA2
            DATA2: u8,
            ///  DATA3
            DATA3: u8,
        }),
        ///  CAN_TDH2R
        CAN_TDH2R: mmio.Mmio(packed struct(u32) {
            ///  DATA4
            DATA4: u8,
            ///  DATA5
            DATA5: u8,
            ///  DATA6
            DATA6: u8,
            ///  DATA7
            DATA7: u8,
        }),
        ///  CAN_RI0R
        CAN_RI0R: mmio.Mmio(packed struct(u32) {
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
        ///  CAN_RDT0R
        CAN_RDT0R: mmio.Mmio(packed struct(u32) {
            ///  DLC
            DLC: u4,
            reserved8: u4,
            ///  FMI
            FMI: u8,
            ///  TIME
            TIME: u16,
        }),
        ///  CAN_RDL0R
        CAN_RDL0R: mmio.Mmio(packed struct(u32) {
            ///  DATA0
            DATA0: u8,
            ///  DATA1
            DATA1: u8,
            ///  DATA2
            DATA2: u8,
            ///  DATA3
            DATA3: u8,
        }),
        ///  CAN_RDH0R
        CAN_RDH0R: mmio.Mmio(packed struct(u32) {
            ///  DATA4
            DATA4: u8,
            ///  DATA5
            DATA5: u8,
            ///  DATA6
            DATA6: u8,
            ///  DATA7
            DATA7: u8,
        }),
        ///  CAN_RI1R
        CAN_RI1R: mmio.Mmio(packed struct(u32) {
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
        ///  CAN_RDT1R
        CAN_RDT1R: mmio.Mmio(packed struct(u32) {
            ///  DLC
            DLC: u4,
            reserved8: u4,
            ///  FMI
            FMI: u8,
            ///  TIME
            TIME: u16,
        }),
        ///  CAN_RDL1R
        CAN_RDL1R: mmio.Mmio(packed struct(u32) {
            ///  DATA0
            DATA0: u8,
            ///  DATA1
            DATA1: u8,
            ///  DATA2
            DATA2: u8,
            ///  DATA3
            DATA3: u8,
        }),
        ///  CAN_RDH1R
        CAN_RDH1R: mmio.Mmio(packed struct(u32) {
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
        ///  CAN_FMR
        CAN_FMR: mmio.Mmio(packed struct(u32) {
            ///  FINIT
            FINIT: u1,
            padding: u31,
        }),
        ///  CAN_FM1R
        CAN_FM1R: mmio.Mmio(packed struct(u32) {
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
            padding: u18,
        }),
        reserved524: [4]u8,
        ///  CAN_FS1R
        CAN_FS1R: mmio.Mmio(packed struct(u32) {
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
            padding: u18,
        }),
        reserved532: [4]u8,
        ///  CAN_FFA1R
        CAN_FFA1R: mmio.Mmio(packed struct(u32) {
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
            padding: u18,
        }),
        reserved540: [4]u8,
        ///  CAN_FA1R
        CAN_FA1R: mmio.Mmio(packed struct(u32) {
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
            padding: u18,
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
    };
};
