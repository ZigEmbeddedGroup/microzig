const micro = @import("microzig");
const mmio = micro.mmio;

pub const devices = struct {
    ///  CH32V20xxx View File
    pub const CH32V20xxx = struct {
        pub const peripherals = struct {
            ///  General purpose timer
            pub const TIM2 = @as(*volatile types.peripherals.TIM2, @ptrFromInt(0x40000000));
            ///  General purpose timer
            pub const TIM3 = @as(*volatile types.peripherals.TIM2, @ptrFromInt(0x40000400));
            ///  General purpose timer
            pub const TIM4 = @as(*volatile types.peripherals.TIM2, @ptrFromInt(0x40000800));
            ///  General purpose timer
            pub const TIM5 = @as(*volatile types.peripherals.TIM2, @ptrFromInt(0x40000c00));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const UART6 = @as(*volatile types.peripherals.USART1, @ptrFromInt(0x40001800));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const UART7 = @as(*volatile types.peripherals.USART1, @ptrFromInt(0x40001c00));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const UART8 = @as(*volatile types.peripherals.USART1, @ptrFromInt(0x40002000));
            ///  Real time clock
            pub const RTC = @as(*volatile types.peripherals.RTC, @ptrFromInt(0x40002800));
            ///  Window watchdog
            pub const WWDG = @as(*volatile types.peripherals.WWDG, @ptrFromInt(0x40002c00));
            ///  Independent watchdog
            pub const IWDG = @as(*volatile types.peripherals.IWDG, @ptrFromInt(0x40003000));
            ///  Serial peripheral interface
            pub const SPI2 = @as(*volatile types.peripherals.SPI2, @ptrFromInt(0x40003800));
            ///  Serial peripheral interface
            pub const SPI3 = @as(*volatile types.peripherals.SPI2, @ptrFromInt(0x40003c00));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const USART2 = @as(*volatile types.peripherals.USART1, @ptrFromInt(0x40004400));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const USART3 = @as(*volatile types.peripherals.USART1, @ptrFromInt(0x40004800));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const UART4 = @as(*volatile types.peripherals.USART1, @ptrFromInt(0x40004c00));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const UART5 = @as(*volatile types.peripherals.USART1, @ptrFromInt(0x40005000));
            ///  Inter integrated circuit
            pub const I2C1 = @as(*volatile types.peripherals.I2C1, @ptrFromInt(0x40005400));
            ///  Inter integrated circuit
            pub const I2C2 = @as(*volatile types.peripherals.I2C1, @ptrFromInt(0x40005800));
            ///  Universal serial bus full-speed device interface
            pub const USB = @as(*volatile types.peripherals.USB, @ptrFromInt(0x40005c00));
            ///  Controller area network
            pub const CAN1 = @as(*volatile types.peripherals.CAN1, @ptrFromInt(0x40006400));
            ///  Backup registers
            pub const BKP = @as(*volatile types.peripherals.BKP, @ptrFromInt(0x40006c00));
            ///  Power control
            pub const PWR = @as(*volatile types.peripherals.PWR, @ptrFromInt(0x40007000));
            ///  Digital to analog converter
            pub const DAC = @as(*volatile types.peripherals.DAC, @ptrFromInt(0x40007400));
            ///  Alternate function I/O
            pub const AFIO = @as(*volatile types.peripherals.AFIO, @ptrFromInt(0x40010000));
            ///  EXTI
            pub const EXTI = @as(*volatile types.peripherals.EXTI, @ptrFromInt(0x40010400));
            ///  General purpose I/O
            pub const GPIOA = @as(*volatile types.peripherals.GPIOA, @ptrFromInt(0x40010800));
            ///  General purpose I/O
            pub const GPIOB = @as(*volatile types.peripherals.GPIOA, @ptrFromInt(0x40010c00));
            ///  General purpose I/O
            pub const GPIOC = @as(*volatile types.peripherals.GPIOA, @ptrFromInt(0x40011000));
            ///  General purpose I/O
            pub const GPIOD = @as(*volatile types.peripherals.GPIOA, @ptrFromInt(0x40011400));
            ///  General purpose I/O
            pub const GPIOE = @as(*volatile types.peripherals.GPIOA, @ptrFromInt(0x40011800));
            ///  Analog to digital converter
            pub const ADC1 = @as(*volatile types.peripherals.ADC1, @ptrFromInt(0x40012400));
            ///  Analog to digital converter
            pub const ADC2 = @as(*volatile types.peripherals.ADC2, @ptrFromInt(0x40012800));
            ///  Advanced timer
            pub const TIM1 = @as(*volatile types.peripherals.TIM1, @ptrFromInt(0x40012c00));
            ///  Serial peripheral interface
            pub const SPI1 = @as(*volatile types.peripherals.SPI1, @ptrFromInt(0x40013000));
            ///  Advanced timer
            pub const TIM8 = @as(*volatile types.peripherals.TIM1, @ptrFromInt(0x40013400));
            ///  Universal synchronous asynchronous receiver transmitter
            pub const USART1 = @as(*volatile types.peripherals.USART1, @ptrFromInt(0x40013800));
            ///  Advanced timer
            pub const TIM9 = @as(*volatile types.peripherals.TIM1, @ptrFromInt(0x40014c00));
            ///  Advanced timer
            pub const TIM10 = @as(*volatile types.peripherals.TIM1, @ptrFromInt(0x40015000));
            ///  DMA1 controller
            pub const DMA1 = @as(*volatile types.peripherals.DMA1, @ptrFromInt(0x40020000));
            ///  Reset and clock control
            pub const RCC = @as(*volatile types.peripherals.RCC, @ptrFromInt(0x40021000));
            ///  FLASH
            pub const FLASH = @as(*volatile types.peripherals.FLASH, @ptrFromInt(0x40022000));
            ///  CRC calculation unit
            pub const CRC = @as(*volatile types.peripherals.CRC, @ptrFromInt(0x40023000));
            ///  USB register
            pub const USBHD_DEVICE = @as(*volatile types.peripherals.USBHD_DEVICE, @ptrFromInt(0x40023400));
            pub const USBHD_HOST = @as(*volatile types.peripherals.USBHD_HOST, @ptrFromInt(0x40023400));
            ///  Extend configuration
            pub const EXTEND = @as(*volatile types.peripherals.EXTEND, @ptrFromInt(0x40023800));
            ///  OPA configuration
            pub const OPA = @as(*volatile types.peripherals.OPA, @ptrFromInt(0x40023804));
            ///  Ethernet: media access control
            pub const ETHERNET_MAC = @as(*volatile types.peripherals.ETHERNET_MAC, @ptrFromInt(0x40028000));
            ///  Ethernet: MAC management counters
            pub const ETHERNET_MMC = @as(*volatile types.peripherals.ETHERNET_MMC, @ptrFromInt(0x40028100));
            ///  Ethernet: Precision time protocol
            pub const ETHERNET_PTP = @as(*volatile types.peripherals.ETHERNET_PTP, @ptrFromInt(0x40028700));
            ///  Ethernet: DMA controller operation
            pub const ETHERNET_DMA = @as(*volatile types.peripherals.ETHERNET_DMA, @ptrFromInt(0x40029000));
            ///  USB FS OTG register
            pub const USBFS_DEVICE = @as(*volatile types.peripherals.USBFS_DEVICE, @ptrFromInt(0x50000000));
            pub const USBFS_HOST = @as(*volatile types.peripherals.USBFS_HOST, @ptrFromInt(0x50000000));
            ///  Debug support
            pub const DBG = @as(*volatile types.peripherals.DBG, @ptrFromInt(0xe000d000));
            ///  Programmable Fast Interrupt Controller
            pub const PFIC = @as(*volatile types.peripherals.PFIC, @ptrFromInt(0xe000e000));
        };
    };
};

pub const types = struct {
    pub const peripherals = struct {
        ///  Universal serial bus full-speed device interface
        pub const USB = extern struct {
            ///  endpoint 0 register
            EP0R: mmio.Mmio(packed struct(u16) {
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
            }),
            reserved4: [2]u8,
            ///  endpoint 1 register
            EP1R: mmio.Mmio(packed struct(u16) {
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
            }),
            reserved8: [2]u8,
            ///  endpoint 2 register
            EP2R: mmio.Mmio(packed struct(u16) {
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
            }),
            reserved12: [2]u8,
            ///  endpoint 3 register
            EP3R: mmio.Mmio(packed struct(u16) {
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
            }),
            reserved16: [2]u8,
            ///  endpoint 4 register
            EP4R: mmio.Mmio(packed struct(u16) {
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
            }),
            reserved20: [2]u8,
            ///  endpoint 5 register
            EP5R: mmio.Mmio(packed struct(u16) {
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
            }),
            reserved24: [2]u8,
            ///  endpoint 6 register
            EP6R: mmio.Mmio(packed struct(u16) {
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
            }),
            reserved28: [2]u8,
            ///  endpoint 7 register
            EP7R: mmio.Mmio(packed struct(u16) {
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
            }),
            reserved64: [34]u8,
            ///  control register
            CNTR: mmio.Mmio(packed struct(u16) {
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
            }),
            reserved68: [2]u8,
            ///  interrupt status register
            ISTR: mmio.Mmio(packed struct(u16) {
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
            }),
            reserved72: [2]u8,
            ///  frame number register
            FNR: mmio.Mmio(packed struct(u16) {
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
            }),
            reserved76: [2]u8,
            ///  device address
            DADDR: mmio.Mmio(packed struct(u16) {
                ///  Device address
                ADD: u7,
                ///  Enable function
                EF: u1,
                padding: u8,
            }),
            reserved80: [2]u8,
            ///  Buffer table address
            BTABLE: mmio.Mmio(packed struct(u32) {
                reserved3: u3,
                ///  Buffer table
                BTABLE: u13,
                padding: u16,
            }),
        };

        ///  Controller area network
        pub const CAN1 = extern struct {
            ///  CAN Master control register
            CTLR: mmio.Mmio(packed struct(u32) {
                ///  Initialization request
                INRQ: u1,
                ///  Sleep mode request
                SLEEP: u1,
                ///  Transmit FIFO priority
                TXFP: u1,
                ///  Receive FIFO locked mode
                RFLM: u1,
                ///  No automatic retransmission
                NART: u1,
                ///  Automatic wakeup mode
                AWUM: u1,
                ///  Automatic bus-off management
                ABOM: u1,
                ///  Time triggered communication mode
                TTCM: u1,
                reserved15: u7,
                ///  Software master reset
                RESET: u1,
                ///  Debug freeze
                DBF: u1,
                padding: u15,
            }),
            ///  CAN master status register
            STATR: mmio.Mmio(packed struct(u32) {
                ///  Initialization acknowledge
                INAK: u1,
                ///  Sleep acknowledge
                SLAK: u1,
                ///  Error interrupt
                ERRI: u1,
                ///  Wakeup interrupt
                WKUI: u1,
                ///  Sleep acknowledge interrupt
                SLAKI: u1,
                reserved8: u3,
                ///  Transmit mode
                TXM: u1,
                ///  Receive mode
                RXM: u1,
                ///  Last sample point
                SAMP: u1,
                ///  Rx signal
                RX: u1,
                padding: u20,
            }),
            ///  CAN transmit status register
            TSTATR: mmio.Mmio(packed struct(u32) {
                ///  Request completed mailbox0
                RQCP0: u1,
                ///  Transmission OK of mailbox0
                TXOK0: u1,
                ///  Arbitration lost for mailbox0
                ALST0: u1,
                ///  Transmission error of mailbox0
                TERR0: u1,
                reserved7: u3,
                ///  Abort request for mailbox0
                ABRQ0: u1,
                ///  Request completed mailbox1
                RQCP1: u1,
                ///  Transmission OK of mailbox1
                TXOK1: u1,
                ///  Arbitration lost for mailbox1
                ALST1: u1,
                ///  Transmission error of mailbox1
                TERR1: u1,
                reserved15: u3,
                ///  Abort request for mailbox 1
                ABRQ1: u1,
                ///  Request completed mailbox2
                RQCP2: u1,
                ///  Transmission OK of mailbox 2
                TXOK2: u1,
                ///  Arbitration lost for mailbox 2
                ALST2: u1,
                ///  Transmission error of mailbox 2
                TERR2: u1,
                reserved23: u3,
                ///  Abort request for mailbox 2
                ABRQ2: u1,
                ///  Mailbox code
                CODE: u2,
                ///  Transmit mailbox 0 empty
                TME0: u1,
                ///  Transmit mailbox 1 empty
                TME1: u1,
                ///  Transmit mailbox 2 empty
                TME2: u1,
                ///  Lowest priority flag for mailbox 0
                LOW0: u1,
                ///  Lowest priority flag for mailbox 1
                LOW1: u1,
                ///  Lowest priority flag for mailbox 2
                LOW2: u1,
            }),
            ///  CAN receive FIFO 0 register
            RFIFO0: mmio.Mmio(packed struct(u32) {
                ///  FIFO 0 message pending
                FMP0: u2,
                reserved3: u1,
                ///  FIFO 0 full
                FULL0: u1,
                ///  FIFO 0 overrun
                FOVR0: u1,
                ///  Release FIFO 0 output mailbox
                RFOM0: u1,
                padding: u26,
            }),
            ///  CAN receive FIFO 1 register
            RFIFO1: mmio.Mmio(packed struct(u32) {
                ///  FIFO 1 message pending
                FMP1: u2,
                reserved3: u1,
                ///  FIFO 1 full
                FULL1: u1,
                ///  FIFO 1 overrun
                FOVR1: u1,
                ///  Release FIFO 1 output mailbox
                RFOM1: u1,
                padding: u26,
            }),
            ///  CAN interrupt enable register
            INTENR: mmio.Mmio(packed struct(u32) {
                ///  Transmit mailbox empty interrupt enable
                TMEIE: u1,
                ///  FIFO message pending interrupt enable
                FMPIE0: u1,
                ///  FIFO full interrupt enable
                FFIE0: u1,
                ///  FIFO overrun interrupt enable
                FOVIE0: u1,
                ///  FIFO message pending interrupt enable
                FMPIE1: u1,
                ///  FIFO full interrupt enable
                FFIE1: u1,
                ///  FIFO overrun interrupt enable
                FOVIE1: u1,
                reserved8: u1,
                ///  Error warning interrupt enable
                EWGIE: u1,
                ///  Error passive interrupt enable
                EPVIE: u1,
                ///  Bus-off interrupt enable
                BOFIE: u1,
                ///  Last error code interrupt enable
                LECIE: u1,
                reserved15: u3,
                ///  Error interrupt enable
                ERRIE: u1,
                ///  Wakeup interrupt enable
                WKUIE: u1,
                ///  Sleep interrupt enable
                SLKIE: u1,
                padding: u14,
            }),
            ///  CAN error status register
            ERRSR: mmio.Mmio(packed struct(u32) {
                ///  Error warning flag
                EWGF: u1,
                ///  Error passive flag
                EPVF: u1,
                ///  Bus-off flag
                BOFF: u1,
                reserved4: u1,
                ///  Last error code
                LEC: u3,
                reserved16: u9,
                ///  Least significant byte of the 9-bit transmit error counter
                TEC: u8,
                ///  Receive error counter
                REC: u8,
            }),
            ///  CAN bit timing register
            BTIMR: mmio.Mmio(packed struct(u32) {
                ///  Baud rate prescaler
                BRP: u10,
                reserved16: u6,
                ///  Time segment 1
                TS1: u4,
                ///  Time segment 2
                TS2: u3,
                reserved24: u1,
                ///  Resynchronization jump width
                SJW: u2,
                reserved30: u4,
                ///  Loop back mode (debug)
                LBKM: u1,
                ///  Silent mode (debug)
                SILM: u1,
            }),
            reserved384: [352]u8,
            ///  CAN TX mailbox identifier register
            TXMIR0: mmio.Mmio(packed struct(u32) {
                ///  Transmit mailbox request
                TXRQ: u1,
                ///  Remote transmission request
                RTR: u1,
                ///  Identifier extension
                IDE: u1,
                ///  extended identifier
                EXID: u18,
                ///  Standard identifier
                STID: u11,
            }),
            ///  CAN mailbox data length control and time stamp register
            TXMDTR0: mmio.Mmio(packed struct(u32) {
                ///  Data length code
                DLC: u4,
                reserved8: u4,
                ///  Transmit global time
                TGT: u1,
                reserved16: u7,
                ///  Message time stamp
                TIME: u16,
            }),
            ///  CAN mailbox data low register
            TXMDLR0: mmio.Mmio(packed struct(u32) {
                ///  Data byte 0
                DATA0: u8,
                ///  Data byte 1
                DATA1: u8,
                ///  Data byte 2
                DATA2: u8,
                ///  Data byte 3
                DATA3: u8,
            }),
            ///  CAN mailbox data high register
            TXMDHR0: mmio.Mmio(packed struct(u32) {
                ///  Data byte 4
                DATA4: u8,
                ///  Data byte 5
                DATA5: u8,
                ///  Data byte 6
                DATA6: u8,
                ///  Data byte 7
                DATA7: u8,
            }),
            ///  CAN TX mailbox identifier register
            TXMIR1: mmio.Mmio(packed struct(u32) {
                ///  Transmit mailbox request
                TXRQ: u1,
                ///  Remote transmission request
                RTR: u1,
                ///  Identifier extension
                IDE: u1,
                ///  extended identifier
                EXID: u18,
                ///  Standard identifier
                STID: u11,
            }),
            ///  CAN mailbox data length control and time stamp register
            TXMDTR1: mmio.Mmio(packed struct(u32) {
                ///  Data length code
                DLC: u4,
                reserved8: u4,
                ///  Transmit global time
                TGT: u1,
                reserved16: u7,
                ///  Message time stamp
                TIME: u16,
            }),
            ///  CAN mailbox data low register
            TXMDLR1: mmio.Mmio(packed struct(u32) {
                ///  Data byte 0
                DATA0: u8,
                ///  Data byte 1
                DATA1: u8,
                ///  Data byte 2
                DATA2: u8,
                ///  Data byte 3
                DATA3: u8,
            }),
            ///  CAN mailbox data high register
            TXMDHR1: mmio.Mmio(packed struct(u32) {
                ///  Data byte 4
                DATA4: u8,
                ///  Data byte 5
                DATA5: u8,
                ///  Data byte 6
                DATA6: u8,
                ///  Data byte 7
                DATA7: u8,
            }),
            ///  CAN TX mailbox identifier register
            TXMIR2: mmio.Mmio(packed struct(u32) {
                ///  Transmit mailbox request
                TXRQ: u1,
                ///  Remote transmission request
                RTR: u1,
                ///  Identifier extension
                IDE: u1,
                ///  extended identifier
                EXID: u18,
                ///  Standard identifier
                STID: u11,
            }),
            ///  CAN mailbox data length control and time stamp register
            TXMDTR2: mmio.Mmio(packed struct(u32) {
                ///  Data length code
                DLC: u4,
                reserved8: u4,
                ///  Transmit global time
                TGT: u1,
                reserved16: u7,
                ///  Message time stamp
                TIME: u16,
            }),
            ///  CAN mailbox data low register
            TXMDLR2: mmio.Mmio(packed struct(u32) {
                ///  Data byte 0
                DATA0: u8,
                ///  Data byte 1
                DATA1: u8,
                ///  Data byte 2
                DATA2: u8,
                ///  Data byte 3
                DATA3: u8,
            }),
            ///  CAN mailbox data high register
            TXMDHR2: mmio.Mmio(packed struct(u32) {
                ///  Data byte 4
                DATA4: u8,
                ///  Data byte 5
                DATA5: u8,
                ///  Data byte 6
                DATA6: u8,
                ///  Data byte 7
                DATA7: u8,
            }),
            ///  CAN receive FIFO mailbox identifier register
            RXMIR0: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Remote transmission request
                RTR: u1,
                ///  Identifier extension
                IDE: u1,
                ///  extended identifier
                EXID: u18,
                ///  Standard identifier
                STID: u11,
            }),
            ///  CAN receive FIFO mailbox data length control and time stamp register
            RXMDTR0: mmio.Mmio(packed struct(u32) {
                ///  Data length code
                DLC: u4,
                reserved8: u4,
                ///  Filter match index
                FMI: u8,
                ///  Message time stamp
                TIME: u16,
            }),
            ///  CAN receive FIFO mailbox data low register
            RXMDLR0: mmio.Mmio(packed struct(u32) {
                ///  Data Byte 0
                DATA0: u8,
                ///  Data Byte 1
                DATA1: u8,
                ///  Data Byte 2
                DATA2: u8,
                ///  Data Byte 3
                DATA3: u8,
            }),
            ///  CAN receive FIFO mailbox data high register
            RXMDHR0: mmio.Mmio(packed struct(u32) {
                ///  DATA4
                DATA4: u8,
                ///  DATA5
                DATA5: u8,
                ///  DATA6
                DATA6: u8,
                ///  DATA7
                DATA7: u8,
            }),
            ///  CAN receive FIFO mailbox identifier register
            RXMIR1: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Remote transmission request
                RTR: u1,
                ///  Identifier extension
                IDE: u1,
                ///  extended identifier
                EXID: u18,
                ///  Standard identifier
                STID: u11,
            }),
            ///  CAN receive FIFO mailbox data length control and time stamp register
            RXMDTR1: mmio.Mmio(packed struct(u32) {
                ///  Data length code
                DLC: u4,
                reserved8: u4,
                ///  Filter match index
                FMI: u8,
                ///  Message time stamp
                TIME: u16,
            }),
            ///  CAN receive FIFO mailbox data low register
            RXMDLR1: mmio.Mmio(packed struct(u32) {
                ///  Data Byte 0
                DATA0: u8,
                ///  Data Byte 1
                DATA1: u8,
                ///  Data Byte 2
                DATA2: u8,
                ///  Data Byte 3
                DATA3: u8,
            }),
            ///  CAN receive FIFO mailbox data high register
            RXMDHR1: mmio.Mmio(packed struct(u32) {
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
            ///  CAN filter master register
            FCTLR: mmio.Mmio(packed struct(u32) {
                ///  Filter init mode
                FINIT: u1,
                padding: u31,
            }),
            ///  CAN filter mode register
            FMCFGR: mmio.Mmio(packed struct(u32) {
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
            ///  CAN filter scale register
            FSCFGR: mmio.Mmio(packed struct(u32) {
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
            ///  CAN filter FIFO assignment register
            FAFIFOR: mmio.Mmio(packed struct(u32) {
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
            ///  CAN filter activation register
            FWR: mmio.Mmio(packed struct(u32) {
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

        ///  Ethernet: media access control
        pub const ETHERNET_MAC = extern struct {
            ///  Ethernet MAC configuration register (ETH_MACCR)
            MACCR: mmio.Mmio(packed struct(u32) {
                ///  Send clock selection bit
                TCES: u1,
                ///  Send clock reversal
                TCF: u1,
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
                ///  10MPHY 50Ω set
                IRE: u1,
                ///  10MPHY TX DRIVER bisa current
                PDI: u1,
                ///  Jabber disable
                JD: u1,
                ///  Watchdog disable
                WD: u1,
                reserved29: u5,
                ///  SEND clock delay
                TCD: u3,
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
                reserved31: u1,
                ///  10MPHY Physical layer variation
                IPLS: u1,
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
                reserved31: u14,
                ///  10M Physical layer connection
                IPLE: u1,
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

        ///  Digital to analog converter
        pub const DAC = extern struct {
            ///  Control register (DAC_CR)
            CTLR: mmio.Mmio(packed struct(u32) {
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
            SWTR: mmio.Mmio(packed struct(u32) {
                ///  DAC channel1 software trigger
                SWTRIG1: u1,
                ///  DAC channel2 software trigger
                SWTRIG2: u1,
                padding: u30,
            }),
            ///  DAC channel1 12-bit right-aligned data holding register(DAC_DHR12R1)
            R12BDHR1: mmio.Mmio(packed struct(u32) {
                ///  DAC channel1 12-bit right-aligned data
                DACC1DHR: u12,
                padding: u20,
            }),
            ///  DAC channel1 12-bit left aligned data holding register (DAC_DHR12L1)
            L12BDHR1: mmio.Mmio(packed struct(u32) {
                reserved4: u4,
                ///  DAC channel1 12-bit left-aligned data
                DACC1DHR: u12,
                padding: u16,
            }),
            ///  DAC channel1 8-bit right aligned data holding register (DAC_DHR8R1)
            R8BDHR1: mmio.Mmio(packed struct(u32) {
                ///  DAC channel1 8-bit right-aligned data
                DACC1DHR: u8,
                padding: u24,
            }),
            ///  DAC channel2 12-bit right aligned data holding register (DAC_DHR12R2)
            R12BDHR2: mmio.Mmio(packed struct(u32) {
                ///  DAC channel2 12-bit right-aligned data
                DACC2DHR: u12,
                padding: u20,
            }),
            ///  DAC channel2 12-bit left aligned data holding register (DAC_DHR12L2)
            L12BDHR2: mmio.Mmio(packed struct(u32) {
                reserved4: u4,
                ///  DAC channel2 12-bit left-aligned data
                DACC2DHR: u12,
                padding: u16,
            }),
            ///  DAC channel2 8-bit right-aligned data holding register (DAC_DHR8R2)
            R8BDHR2: mmio.Mmio(packed struct(u32) {
                ///  DAC channel2 8-bit right-aligned data
                DACC2DHR: u8,
                padding: u24,
            }),
            ///  Dual DAC 12-bit right-aligned data holding register (DAC_DHR12RD), Bits 31:28 Reserved, Bits 15:12 Reserved
            RD12BDHR: mmio.Mmio(packed struct(u32) {
                ///  DAC channel1 12-bit right-aligned data
                DACC1DHR: u12,
                reserved16: u4,
                ///  DAC channel2 12-bit right-aligned data
                DACC2DHR: u12,
                padding: u4,
            }),
            ///  DUAL DAC 12-bit left aligned data holding register (DAC_DHR12LD), Bits 19:16 Reserved, Bits 3:0 Reserved
            LD12BDHR: mmio.Mmio(packed struct(u32) {
                reserved4: u4,
                ///  DAC channel1 12-bit left-aligned data
                DACC1DHR: u12,
                reserved20: u4,
                ///  DAC channel2 12-bit right-aligned data
                DACC2DHR: u12,
            }),
            ///  DUAL DAC 8-bit right aligned data holding register (DAC_DHR8RD), Bits 31:16 Reserved
            RD8BDHR: mmio.Mmio(packed struct(u32) {
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

        ///  Power control
        pub const PWR = extern struct {
            ///  Power control register (PWR_CTRL)
            CTLR: mmio.Mmio(packed struct(u32) {
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
                reserved16: u7,
                ///  standby 2k ram enable
                R2K_STYEN: u1,
                ///  standby 30k ram enable
                R30K_STYEN: u1,
                ///  VBAT 30k ram enable
                R2K_VBATEN: u1,
                ///  VBAT 30k ram enable
                R30K_VBATEN: u1,
                ///  Ram LV Enable
                RAM_LVEN: u1,
                padding: u11,
            }),
            ///  Power control register (PWR_CSR)
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
            CTLR: mmio.Mmio(packed struct(u32) {
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
            ///  Clock configuration register (RCC_CFGR0)
            CFGR0: mmio.Mmio(packed struct(u32) {
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
                ///  USB prescaler
                USBPRE: u2,
                ///  Microcontroller clock output
                MCO: u4,
                ///  ETH prescaler
                ETHPRE: u1,
                reserved31: u2,
                ///  ADC clock ADJ
                ADC_CLK_ADJ: u1,
            }),
            ///  Clock interrupt register (RCC_INTR)
            INTR: mmio.Mmio(packed struct(u32) {
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
            ///  APB2 peripheral reset register (RCC_APB2PRSTR)
            APB2PRSTR: mmio.Mmio(packed struct(u32) {
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
                reserved9: u2,
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
                reserved19: u4,
                ///  TIM9 timer reset
                TIM9RST: u1,
                ///  TIM10 timer reset
                TIM10RST: u1,
                padding: u11,
            }),
            ///  APB1 peripheral reset register (RCC_APB1PRSTR)
            APB1PRSTR: mmio.Mmio(packed struct(u32) {
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
                ///  UART 6 reset
                UART6RST: u1,
                ///  UART 7 reset
                UART7RST: u1,
                ///  UART 8 reset
                UART8RST: u1,
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
                ///  USART 4 reset
                USART4RST: u1,
                ///  USART 5 reset
                USART5RST: u1,
                ///  I2C1 reset
                I2C1RST: u1,
                ///  I2C2 reset
                I2C2RST: u1,
                ///  USBD reset
                USBDRST: u1,
                reserved25: u1,
                ///  CAN1 reset
                CAN1RST: u1,
                ///  CAN2 reset
                CAN2RST: u1,
                ///  Backup interface reset
                BKPRST: u1,
                ///  Power interface reset
                PWRRST: u1,
                ///  DAC interface reset
                DACRST: u1,
                padding: u2,
            }),
            ///  AHB Peripheral Clock enable register (RCC_AHBPCENR)
            AHBPCENR: mmio.Mmio(packed struct(u32) {
                ///  DMA clock enable
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
                ///  TRNG clock enable
                TRNG_EN: u1,
                ///  SDIO clock enable
                SDIOEN: u1,
                ///  USBHS clock enable
                USBHS_EN: u1,
                ///  OTG clock enable
                OTG_EN: u1,
                ///  DVP clock enable
                DVP_EN: u1,
                ///  Ethernet MAC clock enable
                ETHMACEN: u1,
                ///  Ethernet MAC TX clock enable
                ETHMACTXEN: u1,
                ///  Ethernet MAC RX clock enable
                ETHMACRXEN: u1,
                padding: u15,
            }),
            ///  APB2 peripheral clock enable register (RCC_APB2PCENR)
            APB2PCENR: mmio.Mmio(packed struct(u32) {
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
                reserved9: u2,
                ///  ADC1 interface clock enable
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
                reserved19: u4,
                ///  TIM9 Timer clock enable
                TIM9_EN: u1,
                ///  TIM10 Timer clock enable
                TIM10_EN: u1,
                padding: u11,
            }),
            ///  APB1 peripheral clock enable register (RCC_APB1PCENR)
            APB1PCENR: mmio.Mmio(packed struct(u32) {
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
                ///  USART 6 clock enable
                USART6_EN: u1,
                ///  USART 7 clock enable
                USART7_EN: u1,
                ///  USART 8 clock enable
                USART8_EN: u1,
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
                ///  USBD clock enable
                USBDEN: u1,
                reserved25: u1,
                ///  CAN1 clock enable
                CAN1EN: u1,
                ///  CAN2 clock enable
                CAN2EN: u1,
                ///  Backup interface clock enable
                BKPEN: u1,
                ///  Power interface clock enable
                PWREN: u1,
                ///  DAC interface clock enable
                DACEN: u1,
                padding: u2,
            }),
            ///  Backup domain control register (RCC_BDCTLR)
            BDCTLR: mmio.Mmio(packed struct(u32) {
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
            ///  Control/status register (RCC_RSTSCKR)
            RSTSCKR: mmio.Mmio(packed struct(u32) {
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
            ///  AHB reset register (RCC_APHBRSTR)
            AHBRSTR: mmio.Mmio(packed struct(u32) {
                reserved12: u12,
                /// OTF FS reset
                OTGFSRST: u1,
                ///  DVP reset
                DVPRST: u1,
                ///  Ethernet MAC reset
                ETHMACRST: u1,
                padding: u17,
            }),
            ///  Clock configuration register2 (RCC_CFGR2)
            CFGR2: mmio.Mmio(packed struct(u32) {
                ///  PREDIV1 division factor
                PREDIV1: u4,
                ///  PREDIV2 division factor
                PREDIV2: u4,
                ///  PLL2 Multiplication Factor
                PLL2MUL: u4,
                ///  PLL3 Multiplication Factor
                PLL3MUL: u4,
                ///  PREDIV1 entry clock source
                PREDIV1SRC: u1,
                ///  I2S2 clock source
                I2S2SRC: u1,
                ///  I2S3 clock source
                I2S3SRC: u1,
                ///  TRNG clock source
                TRNG_SRC: u1,
                ///  ETH1G clock source
                ETH1G_SRC: u2,
                ///  ETH1G _125M clock enable
                ETH1G_125M_EN: u1,
                reserved24: u1,
                ///  USB HS PREDIV division factor
                USBHS_PREDIY: u3,
                ///  USB HS Multiplication Factor clock source
                USBHS_PLL_SRC: u1,
                ///  USB HS Peference Clock source
                USBHS_CKPEF_SEL: u2,
                ///  USB HS Multiplication control
                USBHS_PLLALIVE: u1,
                ///  USB HS clock source
                USBHS_CLK_SRC: u1,
            }),
        };

        ///  Extend configuration
        pub const EXTEND = extern struct {
            ///  EXTEND register
            EXTEND_CTR: mmio.Mmio(packed struct(u32) {
                ///  USBD Lowspeed Enable
                USBDLS: u1,
                ///  USBD pullup Enable
                USBDPU: u1,
                ///  ETH 10M Enable
                ETH_10M_EN: u1,
                ///  ETH RGMII Enable
                ETH_RGMII_EN: u1,
                ///  Whether HSI is divided
                PLL_HSI_PRE: u1,
                reserved6: u1,
                ///  LOCKUP_Eable
                LOCKUP_EN: u1,
                ///  LOCKUP RESET
                LOCKUP_RSTF: u1,
                ///  ULLDO_TRIM
                ULLDO_TRIM: u2,
                ///  LDO_TRIM
                LDO_TRIM: u2,
                ///  HSE_KEEP_LP
                HSE_KEEP_LP: u1,
                padding: u19,
            }),
        };

        ///  OPA configuration
        pub const OPA = extern struct {
            ///  Control register
            CR: mmio.Mmio(packed struct(u32) {
                ///  OPA Enable1
                EN1: u1,
                ///  OPA MODE1
                MODE1: u1,
                ///  OPA NSEL1
                NSEL1: u1,
                ///  OPA PSEL1
                PSEL1: u1,
                ///  OPA Enable2
                EN2: u1,
                ///  OPA MODE2
                MODE2: u1,
                ///  OPA NSEL2
                NSEL2: u1,
                ///  OPA PSEL2
                PSEL2: u1,
                ///  OPA Eable3
                EN3: u1,
                ///  OPA MODE3
                MODE3: u1,
                ///  OPA NSEL3
                NSEL3: u1,
                ///  OPA PSEL3
                PSEL3: u1,
                ///  OPA Enable4
                EN4: u1,
                ///  OPA MODE4
                MODE4: u1,
                ///  OPA NSEL4
                NSEL4: u1,
                ///  OPA PSEL4
                PSEL4: u1,
                padding: u16,
            }),
        };

        ///  General purpose I/O
        pub const GPIOA = extern struct {
            ///  Port configuration register low (GPIOn_CFGLR)
            CFGLR: mmio.Mmio(packed struct(u32) {
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
            ///  Port configuration register high (GPIOn_CFGHR)
            CFGHR: mmio.Mmio(packed struct(u32) {
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
            ///  Port input data register (GPIOn_INDR)
            INDR: mmio.Mmio(packed struct(u32) {
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
            ///  Port output data register (GPIOn_OUTDR)
            OUTDR: mmio.Mmio(packed struct(u32) {
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
            ///  Port bit set/reset register (GPIOn_BSHR)
            BSHR: mmio.Mmio(packed struct(u32) {
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
            ///  Port bit reset register (GPIOn_BCR)
            BCR: mmio.Mmio(packed struct(u32) {
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

        ///  Programmable Fast Interrupt Controller
        pub const PFIC = extern struct {
            ///  Interrupt Status Register
            ISR1: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  Interrupt ID Status
                INTENSTA2_3: u2,
                reserved12: u8,
                ///  Interrupt ID Status
                INTENSTA12_31: u20,
            }),
            ///  Interrupt Status Register
            ISR2: mmio.Mmio(packed struct(u32) {
                ///  Interrupt ID Status
                INTENSTA: u32,
            }),
            ///  Interrupt Status Register
            ISR3: mmio.Mmio(packed struct(u32) {
                ///  Interrupt ID Status
                INTENSTA: u32,
            }),
            ///  Interrupt Status Register
            ISR4: mmio.Mmio(packed struct(u32) {
                ///  Interrupt ID Status
                INTENSTA: u8,
                padding: u24,
            }),
            reserved32: [16]u8,
            ///  Interrupt Pending Register
            IPR1: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  PENDSTA
                PENDSTA2_3: u2,
                reserved12: u8,
                ///  PENDSTA
                PENDSTA12_31: u20,
            }),
            ///  Interrupt Pending Register
            IPR2: mmio.Mmio(packed struct(u32) {
                ///  PENDSTA
                PENDSTA: u32,
            }),
            ///  Interrupt Pending Register
            IPR3: mmio.Mmio(packed struct(u32) {
                ///  PENDSTA
                PENDSTA: u32,
            }),
            ///  Interrupt Pending Register
            IPR4: mmio.Mmio(packed struct(u32) {
                ///  PENDSTA
                PENDSTA: u8,
                padding: u24,
            }),
            reserved64: [16]u8,
            ///  Interrupt Priority Register
            ITHRESDR: mmio.Mmio(packed struct(u32) {
                ///  THRESHOLD
                THRESHOLD: u8,
                padding: u24,
            }),
            reserved72: [4]u8,
            ///  Interrupt Config Register
            CFGR: mmio.Mmio(packed struct(u32) {
                reserved7: u7,
                ///  RESETSYS
                RESETSYS: u1,
                reserved16: u8,
                ///  KEYCODE
                KEYCODE: u16,
            }),
            ///  Interrupt Global Register
            GISR: mmio.Mmio(packed struct(u32) {
                ///  NESTSTA
                NESTSTA: u8,
                ///  GACTSTA
                GACTSTA: u1,
                ///  GPENDSTA
                GPENDSTA: u1,
                padding: u22,
            }),
            ///  ID Config Register
            VTFIDR: mmio.Mmio(packed struct(u32) {
                ///  VTFID0
                VTFID0: u8,
                ///  VTFID1
                VTFID1: u8,
                ///  VTFID2
                VTFID2: u8,
                ///  VTFID3
                VTFID3: u8,
            }),
            reserved96: [12]u8,
            ///  Interrupt 0 address Register
            VTFADDRR0: mmio.Mmio(packed struct(u32) {
                ///  VTF0EN
                VTF0EN: u1,
                ///  ADDR0
                ADDR0: u31,
            }),
            ///  Interrupt 1 address Register
            VTFADDRR1: mmio.Mmio(packed struct(u32) {
                ///  VTF1EN
                VTF1EN: u1,
                ///  ADDR1
                ADDR1: u31,
            }),
            ///  Interrupt 2 address Register
            VTFADDRR2: mmio.Mmio(packed struct(u32) {
                ///  VTF2EN
                VTF2EN: u1,
                ///  ADDR2
                ADDR2: u31,
            }),
            ///  Interrupt 3 address Register
            VTFADDRR3: mmio.Mmio(packed struct(u32) {
                ///  VTF3EN
                VTF3EN: u1,
                ///  ADDR3
                ADDR3: u31,
            }),
            reserved256: [144]u8,
            ///  Interrupt Setting Register
            IENR1: mmio.Mmio(packed struct(u32) {
                reserved12: u12,
                ///  INTEN
                INTEN: u20,
            }),
            ///  Interrupt Setting Register
            IENR2: mmio.Mmio(packed struct(u32) {
                ///  INTEN
                INTEN: u32,
            }),
            ///  Interrupt Setting Register
            IENR3: mmio.Mmio(packed struct(u32) {
                ///  INTEN
                INTEN: u32,
            }),
            ///  Interrupt Setting Register
            IENR4: mmio.Mmio(packed struct(u32) {
                ///  INTEN
                INTEN: u8,
                padding: u24,
            }),
            reserved384: [112]u8,
            ///  Interrupt Clear Register
            IRER1: mmio.Mmio(packed struct(u32) {
                reserved12: u12,
                ///  INTRSET
                INTRSET: u20,
            }),
            ///  Interrupt Clear Register
            IRER2: mmio.Mmio(packed struct(u32) {
                ///  INTRSET
                INTRSET: u32,
            }),
            ///  Interrupt Clear Register
            IRER3: mmio.Mmio(packed struct(u32) {
                ///  INTRSET
                INTRSET: u32,
            }),
            ///  Interrupt Clear Register
            IRER4: mmio.Mmio(packed struct(u32) {
                ///  INTRSET
                INTRSET: u8,
                padding: u24,
            }),
            reserved512: [112]u8,
            ///  Interrupt Pending Register
            IPSR1: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  PENDSET
                PENDSET2_3: u2,
                reserved12: u8,
                ///  PENDSET
                PENDSET12_31: u20,
            }),
            ///  Interrupt Pending Register
            IPSR2: mmio.Mmio(packed struct(u32) {
                ///  PENDSET
                PENDSET: u32,
            }),
            ///  Interrupt Pending Register
            IPSR3: mmio.Mmio(packed struct(u32) {
                ///  PENDSET
                PENDSET: u32,
            }),
            ///  Interrupt Pending Register
            IPSR4: mmio.Mmio(packed struct(u32) {
                ///  PENDSET
                PENDSET: u8,
                padding: u24,
            }),
            reserved640: [112]u8,
            ///  Interrupt Pending Clear Register
            IPRR1: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  PENDRESET
                PENDRESET2_3: u2,
                reserved12: u8,
                ///  PENDRESET
                PENDRESET12_31: u20,
            }),
            ///  Interrupt Pending Clear Register
            IPRR2: mmio.Mmio(packed struct(u32) {
                ///  PENDRESET
                PENDRESET: u32,
            }),
            ///  Interrupt Pending Clear Register
            IPRR3: mmio.Mmio(packed struct(u32) {
                ///  PENDRESET
                PENDRESET: u32,
            }),
            ///  Interrupt Pending Clear Register
            IPRR4: mmio.Mmio(packed struct(u32) {
                ///  PENDRESET
                PENDRESET: u8,
                padding: u24,
            }),
            reserved768: [112]u8,
            ///  Interrupt ACTIVE Register
            IACTR1: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  IACTS
                IACTS2_3: u2,
                reserved12: u8,
                ///  IACTS
                IACTS12_31: u20,
            }),
            ///  Interrupt ACTIVE Register
            IACTR2: mmio.Mmio(packed struct(u32) {
                ///  IACTS
                IACTS: u32,
            }),
            ///  Interrupt ACTIVE Register
            IACTR3: mmio.Mmio(packed struct(u32) {
                ///  IACTS
                IACTS: u32,
            }),
            ///  Interrupt ACTIVE Register
            IACTR4: mmio.Mmio(packed struct(u32) {
                ///  IACTS
                IACTS: u8,
                padding: u24,
            }),
            reserved1024: [240]u8,
            ///  Interrupt Priority Register
            IPRIOR0: u8,
            ///  Interrupt Priority Register
            IPRIOR1: u8,
            ///  Interrupt Priority Register
            IPRIOR2: u8,
            ///  Interrupt Priority Register
            IPRIOR3: u8,
            ///  Interrupt Priority Register
            IPRIOR4: u8,
            ///  Interrupt Priority Register
            IPRIOR5: u8,
            ///  Interrupt Priority Register
            IPRIOR6: u8,
            ///  Interrupt Priority Register
            IPRIOR7: u8,
            ///  Interrupt Priority Register
            IPRIOR8: u8,
            ///  Interrupt Priority Register
            IPRIOR9: u8,
            ///  Interrupt Priority Register
            IPRIOR10: u8,
            ///  Interrupt Priority Register
            IPRIOR11: u8,
            ///  Interrupt Priority Register
            IPRIOR12: u8,
            ///  Interrupt Priority Register
            IPRIOR13: u8,
            ///  Interrupt Priority Register
            IPRIOR14: u8,
            ///  Interrupt Priority Register
            IPRIOR15: u8,
            ///  Interrupt Priority Register
            IPRIOR16: u8,
            ///  Interrupt Priority Register
            IPRIOR17: u8,
            ///  Interrupt Priority Register
            IPRIOR18: u8,
            ///  Interrupt Priority Register
            IPRIOR19: u8,
            ///  Interrupt Priority Register
            IPRIOR20: u8,
            ///  Interrupt Priority Register
            IPRIOR21: u8,
            ///  Interrupt Priority Register
            IPRIOR22: u8,
            ///  Interrupt Priority Register
            IPRIOR23: u8,
            ///  Interrupt Priority Register
            IPRIOR24: u8,
            ///  Interrupt Priority Register
            IPRIOR25: u8,
            ///  Interrupt Priority Register
            IPRIOR26: u8,
            ///  Interrupt Priority Register
            IPRIOR27: u8,
            ///  Interrupt Priority Register
            IPRIOR28: u8,
            ///  Interrupt Priority Register
            IPRIOR29: u8,
            ///  Interrupt Priority Register
            IPRIOR30: u8,
            ///  Interrupt Priority Register
            IPRIOR31: u8,
            ///  Interrupt Priority Register
            IPRIOR32: u8,
            ///  Interrupt Priority Register
            IPRIOR33: u8,
            ///  Interrupt Priority Register
            IPRIOR34: u8,
            ///  Interrupt Priority Register
            IPRIOR35: u8,
            ///  Interrupt Priority Register
            IPRIOR36: u8,
            ///  Interrupt Priority Register
            IPRIOR37: u8,
            ///  Interrupt Priority Register
            IPRIOR38: u8,
            ///  Interrupt Priority Register
            IPRIOR39: u8,
            ///  Interrupt Priority Register
            IPRIOR40: u8,
            ///  Interrupt Priority Register
            IPRIOR41: u8,
            ///  Interrupt Priority Register
            IPRIOR42: u8,
            ///  Interrupt Priority Register
            IPRIOR43: u8,
            ///  Interrupt Priority Register
            IPRIOR44: u8,
            ///  Interrupt Priority Register
            IPRIOR45: u8,
            ///  Interrupt Priority Register
            IPRIOR46: u8,
            ///  Interrupt Priority Register
            IPRIOR47: u8,
            ///  Interrupt Priority Register
            IPRIOR48: u8,
            ///  Interrupt Priority Register
            IPRIOR49: u8,
            ///  Interrupt Priority Register
            IPRIOR50: u8,
            ///  Interrupt Priority Register
            IPRIOR51: u8,
            ///  Interrupt Priority Register
            IPRIOR52: u8,
            ///  Interrupt Priority Register
            IPRIOR53: u8,
            ///  Interrupt Priority Register
            IPRIOR54: u8,
            ///  Interrupt Priority Register
            IPRIOR55: u8,
            ///  Interrupt Priority Register
            IPRIOR56: u8,
            ///  Interrupt Priority Register
            IPRIOR57: u8,
            ///  Interrupt Priority Register
            IPRIOR58: u8,
            ///  Interrupt Priority Register
            IPRIOR59: u8,
            ///  Interrupt Priority Register
            IPRIOR60: u8,
            ///  Interrupt Priority Register
            IPRIOR61: u8,
            ///  Interrupt Priority Register
            IPRIOR62: u8,
            ///  Interrupt Priority Register
            IPRIOR63: u8,
            ///  Interrupt Priority Register
            IPRIOR64: u8,
            ///  Interrupt Priority Register
            IPRIOR65: u8,
            ///  Interrupt Priority Register
            IPRIOR66: u8,
            ///  Interrupt Priority Register
            IPRIOR67: u8,
            ///  Interrupt Priority Register
            IPRIOR68: u8,
            ///  Interrupt Priority Register
            IPRIOR69: u8,
            ///  Interrupt Priority Register
            IPRIOR70: u8,
            ///  Interrupt Priority Register
            IPRIOR71: u8,
            ///  Interrupt Priority Register
            IPRIOR72: u8,
            ///  Interrupt Priority Register
            IPRIOR73: u8,
            ///  Interrupt Priority Register
            IPRIOR74: u8,
            ///  Interrupt Priority Register
            IPRIOR75: u8,
            ///  Interrupt Priority Register
            IPRIOR76: u8,
            ///  Interrupt Priority Register
            IPRIOR77: u8,
            ///  Interrupt Priority Register
            IPRIOR78: u8,
            ///  Interrupt Priority Register
            IPRIOR79: u8,
            ///  Interrupt Priority Register
            IPRIOR80: u8,
            ///  Interrupt Priority Register
            IPRIOR81: u8,
            ///  Interrupt Priority Register
            IPRIOR82: u8,
            ///  Interrupt Priority Register
            IPRIOR83: u8,
            ///  Interrupt Priority Register
            IPRIOR84: u8,
            ///  Interrupt Priority Register
            IPRIOR85: u8,
            ///  Interrupt Priority Register
            IPRIOR86: u8,
            ///  Interrupt Priority Register
            IPRIOR87: u8,
            ///  Interrupt Priority Register
            IPRIOR88: u8,
            ///  Interrupt Priority Register
            IPRIOR89: u8,
            ///  Interrupt Priority Register
            IPRIOR90: u8,
            ///  Interrupt Priority Register
            IPRIOR91: u8,
            ///  Interrupt Priority Register
            IPRIOR92: u8,
            ///  Interrupt Priority Register
            IPRIOR93: u8,
            ///  Interrupt Priority Register
            IPRIOR94: u8,
            ///  Interrupt Priority Register
            IPRIOR95: u8,
            ///  Interrupt Priority Register
            IPRIOR96: u8,
            ///  Interrupt Priority Register
            IPRIOR97: u8,
            ///  Interrupt Priority Register
            IPRIOR98: u8,
            ///  Interrupt Priority Register
            IPRIOR99: u8,
            ///  Interrupt Priority Register
            IPRIOR100: u8,
            ///  Interrupt Priority Register
            IPRIOR101: u8,
            ///  Interrupt Priority Register
            IPRIOR102: u8,
            ///  Interrupt Priority Register
            IPRIOR103: u8,
            ///  Interrupt Priority Register
            IPRIOR104: u8,
            ///  Interrupt Priority Register
            IPRIOR105: u8,
            ///  Interrupt Priority Register
            IPRIOR106: u8,
            ///  Interrupt Priority Register
            IPRIOR107: u8,
            ///  Interrupt Priority Register
            IPRIOR108: u8,
            ///  Interrupt Priority Register
            IPRIOR109: u8,
            ///  Interrupt Priority Register
            IPRIOR110: u8,
            ///  Interrupt Priority Register
            IPRIOR111: u8,
            ///  Interrupt Priority Register
            IPRIOR112: u8,
            ///  Interrupt Priority Register
            IPRIOR113: u8,
            ///  Interrupt Priority Register
            IPRIOR114: u8,
            ///  Interrupt Priority Register
            IPRIOR115: u8,
            ///  Interrupt Priority Register
            IPRIOR116: u8,
            ///  Interrupt Priority Register
            IPRIOR117: u8,
            ///  Interrupt Priority Register
            IPRIOR118: u8,
            ///  Interrupt Priority Register
            IPRIOR119: u8,
            ///  Interrupt Priority Register
            IPRIOR120: u8,
            ///  Interrupt Priority Register
            IPRIOR121: u8,
            ///  Interrupt Priority Register
            IPRIOR122: u8,
            ///  Interrupt Priority Register
            IPRIOR123: u8,
            ///  Interrupt Priority Register
            IPRIOR124: u8,
            ///  Interrupt Priority Register
            IPRIOR125: u8,
            ///  Interrupt Priority Register
            IPRIOR126: u8,
            ///  Interrupt Priority Register
            IPRIOR127: u8,
            ///  Interrupt Priority Register
            IPRIOR128: u8,
            ///  Interrupt Priority Register
            IPRIOR129: u8,
            ///  Interrupt Priority Register
            IPRIOR130: u8,
            ///  Interrupt Priority Register
            IPRIOR131: u8,
            ///  Interrupt Priority Register
            IPRIOR132: u8,
            ///  Interrupt Priority Register
            IPRIOR133: u8,
            ///  Interrupt Priority Register
            IPRIOR134: u8,
            ///  Interrupt Priority Register
            IPRIOR135: u8,
            ///  Interrupt Priority Register
            IPRIOR136: u8,
            ///  Interrupt Priority Register
            IPRIOR137: u8,
            ///  Interrupt Priority Register
            IPRIOR138: u8,
            ///  Interrupt Priority Register
            IPRIOR139: u8,
            ///  Interrupt Priority Register
            IPRIOR140: u8,
            ///  Interrupt Priority Register
            IPRIOR141: u8,
            ///  Interrupt Priority Register
            IPRIOR142: u8,
            ///  Interrupt Priority Register
            IPRIOR143: u8,
            ///  Interrupt Priority Register
            IPRIOR144: u8,
            ///  Interrupt Priority Register
            IPRIOR145: u8,
            ///  Interrupt Priority Register
            IPRIOR146: u8,
            ///  Interrupt Priority Register
            IPRIOR147: u8,
            ///  Interrupt Priority Register
            IPRIOR148: u8,
            ///  Interrupt Priority Register
            IPRIOR149: u8,
            ///  Interrupt Priority Register
            IPRIOR150: u8,
            ///  Interrupt Priority Register
            IPRIOR151: u8,
            ///  Interrupt Priority Register
            IPRIOR152: u8,
            ///  Interrupt Priority Register
            IPRIOR153: u8,
            ///  Interrupt Priority Register
            IPRIOR154: u8,
            ///  Interrupt Priority Register
            IPRIOR155: u8,
            ///  Interrupt Priority Register
            IPRIOR156: u8,
            ///  Interrupt Priority Register
            IPRIOR157: u8,
            ///  Interrupt Priority Register
            IPRIOR158: u8,
            ///  Interrupt Priority Register
            IPRIOR159: u8,
            ///  Interrupt Priority Register
            IPRIOR160: u8,
            ///  Interrupt Priority Register
            IPRIOR161: u8,
            ///  Interrupt Priority Register
            IPRIOR162: u8,
            ///  Interrupt Priority Register
            IPRIOR163: u8,
            ///  Interrupt Priority Register
            IPRIOR164: u8,
            ///  Interrupt Priority Register
            IPRIOR165: u8,
            ///  Interrupt Priority Register
            IPRIOR166: u8,
            ///  Interrupt Priority Register
            IPRIOR167: u8,
            ///  Interrupt Priority Register
            IPRIOR168: u8,
            ///  Interrupt Priority Register
            IPRIOR169: u8,
            ///  Interrupt Priority Register
            IPRIOR170: u8,
            ///  Interrupt Priority Register
            IPRIOR171: u8,
            ///  Interrupt Priority Register
            IPRIOR172: u8,
            ///  Interrupt Priority Register
            IPRIOR173: u8,
            ///  Interrupt Priority Register
            IPRIOR174: u8,
            ///  Interrupt Priority Register
            IPRIOR175: u8,
            ///  Interrupt Priority Register
            IPRIOR176: u8,
            ///  Interrupt Priority Register
            IPRIOR177: u8,
            ///  Interrupt Priority Register
            IPRIOR178: u8,
            ///  Interrupt Priority Register
            IPRIOR179: u8,
            ///  Interrupt Priority Register
            IPRIOR180: u8,
            ///  Interrupt Priority Register
            IPRIOR181: u8,
            ///  Interrupt Priority Register
            IPRIOR182: u8,
            ///  Interrupt Priority Register
            IPRIOR183: u8,
            ///  Interrupt Priority Register
            IPRIOR184: u8,
            ///  Interrupt Priority Register
            IPRIOR185: u8,
            ///  Interrupt Priority Register
            IPRIOR186: u8,
            ///  Interrupt Priority Register
            IPRIOR187: u8,
            ///  Interrupt Priority Register
            IPRIOR188: u8,
            ///  Interrupt Priority Register
            IPRIOR189: u8,
            ///  Interrupt Priority Register
            IPRIOR190: u8,
            ///  Interrupt Priority Register
            IPRIOR191: u8,
            ///  Interrupt Priority Register
            IPRIOR192: u8,
            ///  Interrupt Priority Register
            IPRIOR193: u8,
            ///  Interrupt Priority Register
            IPRIOR194: u8,
            ///  Interrupt Priority Register
            IPRIOR195: u8,
            ///  Interrupt Priority Register
            IPRIOR196: u8,
            ///  Interrupt Priority Register
            IPRIOR197: u8,
            ///  Interrupt Priority Register
            IPRIOR198: u8,
            ///  Interrupt Priority Register
            IPRIOR199: u8,
            ///  Interrupt Priority Register
            IPRIOR200: u8,
            ///  Interrupt Priority Register
            IPRIOR201: u8,
            ///  Interrupt Priority Register
            IPRIOR202: u8,
            ///  Interrupt Priority Register
            IPRIOR203: u8,
            ///  Interrupt Priority Register
            IPRIOR204: u8,
            ///  Interrupt Priority Register
            IPRIOR205: u8,
            ///  Interrupt Priority Register
            IPRIOR206: u8,
            ///  Interrupt Priority Register
            IPRIOR207: u8,
            ///  Interrupt Priority Register
            IPRIOR208: u8,
            ///  Interrupt Priority Register
            IPRIOR209: u8,
            ///  Interrupt Priority Register
            IPRIOR210: u8,
            ///  Interrupt Priority Register
            IPRIOR211: u8,
            ///  Interrupt Priority Register
            IPRIOR212: u8,
            ///  Interrupt Priority Register
            IPRIOR213: u8,
            ///  Interrupt Priority Register
            IPRIOR214: u8,
            ///  Interrupt Priority Register
            IPRIOR215: u8,
            ///  Interrupt Priority Register
            IPRIOR216: u8,
            ///  Interrupt Priority Register
            IPRIOR217: u8,
            ///  Interrupt Priority Register
            IPRIOR218: u8,
            ///  Interrupt Priority Register
            IPRIOR219: u8,
            ///  Interrupt Priority Register
            IPRIOR220: u8,
            ///  Interrupt Priority Register
            IPRIOR221: u8,
            ///  Interrupt Priority Register
            IPRIOR222: u8,
            ///  Interrupt Priority Register
            IPRIOR223: u8,
            ///  Interrupt Priority Register
            IPRIOR224: u8,
            ///  Interrupt Priority Register
            IPRIOR225: u8,
            ///  Interrupt Priority Register
            IPRIOR226: u8,
            ///  Interrupt Priority Register
            IPRIOR227: u8,
            ///  Interrupt Priority Register
            IPRIOR228: u8,
            ///  Interrupt Priority Register
            IPRIOR229: u8,
            ///  Interrupt Priority Register
            IPRIOR230: u8,
            ///  Interrupt Priority Register
            IPRIOR231: u8,
            ///  Interrupt Priority Register
            IPRIOR232: u8,
            ///  Interrupt Priority Register
            IPRIOR233: u8,
            ///  Interrupt Priority Register
            IPRIOR234: u8,
            ///  Interrupt Priority Register
            IPRIOR235: u8,
            ///  Interrupt Priority Register
            IPRIOR236: u8,
            ///  Interrupt Priority Register
            IPRIOR237: u8,
            ///  Interrupt Priority Register
            IPRIOR238: u8,
            ///  Interrupt Priority Register
            IPRIOR239: u8,
            ///  Interrupt Priority Register
            IPRIOR240: u8,
            ///  Interrupt Priority Register
            IPRIOR241: u8,
            ///  Interrupt Priority Register
            IPRIOR242: u8,
            ///  Interrupt Priority Register
            IPRIOR243: u8,
            ///  Interrupt Priority Register
            IPRIOR244: u8,
            ///  Interrupt Priority Register
            IPRIOR245: u8,
            ///  Interrupt Priority Register
            IPRIOR246: u8,
            ///  Interrupt Priority Register
            IPRIOR247: u8,
            ///  Interrupt Priority Register
            IPRIOR248: u8,
            ///  Interrupt Priority Register
            IPRIOR249: u8,
            ///  Interrupt Priority Register
            IPRIOR250: u8,
            ///  Interrupt Priority Register
            IPRIOR251: u8,
            ///  Interrupt Priority Register
            IPRIOR252: u8,
            ///  Interrupt Priority Register
            IPRIOR253: u8,
            ///  Interrupt Priority Register
            IPRIOR254: u8,
            ///  Interrupt Priority Register
            IPRIOR255: u8,
            reserved3344: [2064]u8,
            ///  System Control Register
            SCTLR: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  SLEEPONEXIT
                SLEEPONEXIT: u1,
                ///  SLEEPDEEP
                SLEEPDEEP: u1,
                ///  WFITOWFE
                WFITOWFE: u1,
                ///  SEVONPEND
                SEVONPEND: u1,
                ///  SETEVENT
                SETEVENT: u1,
                reserved31: u25,
                ///  SYSRESET
                SYSRESET: u1,
            }),
            reserved4096: [748]u8,
            ///  System counter control register
            STK_CTLR: mmio.Mmio(packed struct(u32) {
                ///  System counter enable
                STE: u1,
                ///  System counter interrupt enable
                STIE: u1,
                ///  System selects the clock source
                STCLK: u1,
                ///  System reload register
                STRE: u1,
                ///  System Mode
                MODE: u1,
                ///  System Initialization update
                INIT: u1,
                reserved31: u25,
                ///  System software triggered interrupts enable
                SWIE: u1,
            }),
            ///  System START
            STK_SR: mmio.Mmio(packed struct(u32) {
                ///  CNTIF
                CNTIF: u1,
                padding: u31,
            }),
            ///  System counter low register
            STK_CNTL: mmio.Mmio(packed struct(u32) {
                ///  CNTL
                CNTL: u32,
            }),
            ///  System counter high register
            STK_CNTH: mmio.Mmio(packed struct(u32) {
                ///  CNTH
                CNTH: u32,
            }),
            ///  System compare low register
            STK_CMPLR: mmio.Mmio(packed struct(u32) {
                ///  CMPL
                CMPL: u32,
            }),
            ///  System compare high register
            STK_CMPHR: mmio.Mmio(packed struct(u32) {
                ///  CMPH
                CMPH: u32,
            }),
        };

        ///  USB FS OTG register
        pub const USBFS_DEVICE = extern struct {
            ///  USB base control
            USBHD_BASE_CTRL: mmio.Mmio(packed struct(u8) {
                ///  DMA enable and DMA interrupt enable for USB
                USBHD_UC_DMA_EN: u1,
                ///  force clear FIFO and count of USB
                USBHD_UC_CLR_ALL: u1,
                ///  force reset USB SIE, need software clear
                USBHD_UC_RESET_SIE: u1,
                ///  enable automatic responding busy for device mode or automatic pause for host mode during interrupt flag UIF_TRANSFER valid
                USBHD_UC_INT_BUSY: u1,
                ///  USB device enable and internal pullup resistance enable
                USBHD_UC_SYS_CTRL_MASK: u2,
                ///  enable USB low speed: 0=12Mbps, 1=1.5Mbps
                USBHD_UC_LOW_SPEED: u1,
                ///  enable USB host mode: 0=device mode, 1=host mode
                RB_UC_HOST_MODE: u1,
            }),
            ///  USB device physical prot control
            USBHD_UDEV_CTRL: mmio.Mmio(packed struct(u8) {
                ///  enable USB port: 0=disable, 1=enable port, automatic disabled if USB device detached
                USBHD_UD_PORT_EN: u1,
                ///  general purpose flag
                USBHD_UD_GP_BIT: u1,
                ///  enable USB port low speed: 0=full speed, 1=low speed
                USBHD_UD_LOW_SPEED: u1,
                reserved4: u1,
                ///  ReadOnly: indicate current UDM pin level
                USBHD_UD_DM_PIN: u1,
                ///  USB device enable and internal pullup resistance enable
                USBHD_UD_DP_PIN: u1,
                reserved7: u1,
                ///  disable USB UDP/UDM pulldown resistance: 0=enable pulldown, 1=disable
                USBHD_UD_PD_DIS: u1,
            }),
            ///  USB interrupt enable
            R8_USB_INT_EN: mmio.Mmio(packed struct(u8) {
                ///  enable interrupt for USB bus reset event for USB device mode
                USBHD_UIE_BUS_RST: u1,
                ///  enable interrupt for USB transfer completion
                USBHD_UIE_TRANSFER: u1,
                ///  enable interrupt for USB suspend or resume event
                USBHD_UIE_SUSPEND: u1,
                ///  enable interrupt for host SOF timer action for USB host mode
                USBHD_UIE_HST_SOF: u1,
                ///  enable interrupt for FIFO overflow
                USBHD_UIE_FIFO_OV: u1,
                reserved6: u1,
                ///  enable interrupt for NAK responded for USB device mode
                USBHD_UIE_DEV_NAK: u1,
                ///  enable interrupt for SOF received for USB device mode
                USBHD_UIE_DEV_SOF: u1,
            }),
            ///  USB device address
            R8_USB_DEV_AD: mmio.Mmio(packed struct(u8) {
                ///  bit mask for USB device address
                MASK_USB_ADDR: u7,
                ///  general purpose bit
                RB_UDA_GP_BIT: u1,
            }),
            reserved5: [1]u8,
            ///  USB miscellaneous status
            R8_USB_MIS_ST: mmio.Mmio(packed struct(u8) {
                ///  RO, indicate device attached status on USB host
                RB_UMS_DEV_ATTACH: u1,
                ///  RO, indicate UDM level saved at device attached to USB host
                RB_UMS_DM_LEVEL: u1,
                ///  RO, indicate USB suspend status
                RB_UMS_SUSPEND: u1,
                ///  RO, indicate USB bus reset status
                RB_UMS_BUS_RESET: u1,
                ///  RO, indicate USB receiving FIFO ready status (not empty)
                RB_UMS_R_FIFO_RDY: u1,
                ///  RO, indicate USB SIE free status
                RB_UMS_SIE_FREE: u1,
                ///  RO, indicate host SOF timer action status for USB host
                RB_UMS_SOF_ACT: u1,
                ///  RO, indicate host SOF timer presage status
                RB_UMS_SOF_PRES: u1,
            }),
            ///  USB interrupt flag
            R8_USB_INT_FG: mmio.Mmio(packed struct(u8) {
                ///  bus reset event interrupt flag for USB device mode, direct bit address clear or write 1 to clear
                RB_UIF_BUS_RST: u1,
                ///  USB transfer completion interrupt flag, direct bit address clear or write 1 to clear
                RB_UIF_TRANSFER: u1,
                ///  USB suspend or resume event interrupt flag, direct bit address clear or write 1 to clear
                RB_UIF_SUSPEND: u1,
                ///  host SOF timer interrupt flag for USB host, direct bit address clear or write 1 to clear
                RB_UIF_HST_SOF: u1,
                ///  FIFO overflow interrupt flag for USB, direct bit address clear or write 1 to clear
                RB_UIF_FIFO_OV: u1,
                ///  RO, indicate USB SIE free status
                RB_U_SIE_FREE: u1,
                ///  RO, indicate current USB transfer toggle is OK
                RB_U_TOG_OK: u1,
                ///  RO, indicate current USB transfer is NAK received
                RB_U_IS_NAK: u1,
            }),
            ///  USB interrupt status
            R8_USB_INT_ST: mmio.Mmio(packed struct(u8) {
                ///  RO, bit mask of current transfer handshake response for USB host mode: 0000=no response, time out from device, others=handshake response PID received
                MASK_UIS_ENDP: u4,
                ///  RO, bit mask of current token PID code received for USB device mode
                MASK_UIS_TOKEN: u2,
                ///  RO, indicate current USB transfer toggle is OK
                RB_UIS_TOG_OK: u1,
                ///  RO, indicate current USB transfer is NAK received for USB device mode
                RB_UIS_IS_NAK: u1,
            }),
            ///  USB receiving length
            R16_USB_RX_LEN: u16,
            reserved12: [2]u8,
            ///  endpoint 4/1 mode
            R8_UEP4_1_MOD: mmio.Mmio(packed struct(u8) {
                reserved2: u2,
                ///  enable USB endpoint 4 transmittal (IN)
                RB_UEP4_TX_EN: u1,
                ///  enable USB endpoint 4 receiving (OUT)
                RB_UEP4_RX_EN: u1,
                ///  buffer mode of USB endpoint 1
                RB_UEP1_BUF_MOD: u1,
                reserved6: u1,
                ///  enable USB endpoint 1 transmittal (IN)
                RB_UEP1_TX_EN: u1,
                ///  enable USB endpoint 1 receiving (OUT)
                RB_UEP1_RX_EN: u1,
            }),
            ///  endpoint 2/3 mode
            R8_UEP2_3_MOD: mmio.Mmio(packed struct(u8) {
                ///  buffer mode of USB endpoint 2
                RB_UEP2_BUF_MOD: u1,
                reserved2: u1,
                ///  enable USB endpoint 2 transmittal (IN)
                RB_UEP2_TX_EN: u1,
                ///  enable USB endpoint 2 receiving (OUT)
                RB_UEP2_RX_EN: u1,
                ///  buffer mode of USB endpoint 3
                RB_UEP3_BUF_MOD: u1,
                reserved6: u1,
                ///  enable USB endpoint 3 transmittal (IN)
                RB_UEP3_TX_EN: u1,
                ///  enable USB endpoint 3 receiving (OUT)
                RB_UEP3_RX_EN: u1,
            }),
            ///  endpoint 5/6 mode
            R8_UEP5_6_MOD: mmio.Mmio(packed struct(u8) {
                ///  buffer mode of USB endpoint 5
                RB_UEP5_BUF_MOD: u1,
                reserved2: u1,
                ///  enable USB endpoint 5 transmittal (IN)
                RB_UEP5_TX_EN: u1,
                ///  enable USB endpoint 5 receiving (OUT)
                RB_UEP5_RX_EN: u1,
                ///  buffer mode of USB endpoint 6
                RB_UEP6_BUF_MOD: u1,
                reserved6: u1,
                ///  enable USB endpoint 6 transmittal (IN)
                RB_UEP6_TX_EN: u1,
                ///  enable USB endpoint 6 receiving (OUT)
                RB_UEP3_RX_EN: u1,
            }),
            ///  endpoint 7 mode
            R8_UEP7_MOD: mmio.Mmio(packed struct(u8) {
                ///  buffer mode of USB endpoint 7
                RB_UEP7_BUF_MOD: u1,
                reserved2: u1,
                ///  enable USB endpoint 7 transmittal (IN)
                RB_UEP7_TX_EN: u1,
                ///  enable USB endpoint 7 receiving (OUT)
                RB_UEP7_RX_EN: u1,
                padding: u4,
            }),
            ///  endpoint 0 DMA buffer address
            R32_UEP0_DMA: u32,
            ///  endpoint 1 DMA buffer address
            R32_UEP1_DMA: u32,
            ///  endpoint 2 DMA buffer address
            R32_UEP2_DMA: u32,
            ///  endpoint 3 DMA buffer address
            R32_UEP3_DMA: u32,
            ///  endpoint 4 DMA buffer address
            R32_UEP4_DMA: u32,
            ///  endpoint 5 DMA buffer address
            R32_UEP5_DMA: u32,
            ///  endpoint 6 DMA buffer address
            R32_UEP6_DMA: u32,
            ///  endpoint 7 DMA buffer address
            R32_UEP7_DMA: u32,
            ///  endpoint 0 transmittal length
            R8_UEP0_T_LEN: u8,
            reserved50: [1]u8,
            ///  endpoint 0 control
            R8_UEP0_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                USBHD_UEP_T_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 0 control
            R8_UEP0_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                USBHD_UEP_R_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 1 transmittal length
            R8_UEP1_T_LEN: u8,
            reserved54: [1]u8,
            ///  endpoint 1 control
            R8_UEP1_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                USBHD_UEP_T_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                reserved6: u2,
                ///  USB host automatic SOF enable
                USBHD_UH_SOF_EN: u1,
                ///  USB host PRE PID enable for low speed device via hub
                USBHD_UH_PRE_PID_EN: u1,
            }),
            ///  endpoint 1 control
            R8_UEP1_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                USBHD_UEP_R_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 2 transmittal length
            R8_UEP2_T_LEN: u8,
            reserved58: [1]u8,
            ///  endpoint 2 control
            R8_UEP2_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                USBHD_UEP_T_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 2 control
            R8_UEP2_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                USBHD_UEP_R_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 3 transmittal length
            /// The max length for endpoint 3 is 64 bytes as a device. But the max size of thw packet is 1024 bytes as host and this registor is R16.
            R16_UEP3_T_LEN: u16,
            ///  endpoint 3 control
            R8_UEP3_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                USBHD_UEP_T_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 3 control
            R8_UEP3_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                USBHD_UEP_R_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 4 transmittal length
            R8_UEP4_T_LEN: u8,
            reserved66: [1]u8,
            ///  endpoint 4 control
            R8_UEP4_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                USBHD_UEP_T_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 4 control
            R8_UEP4_R_CTRL_: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                USBHD_UEP_R_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 5 transmittal length
            R8_UEP5_T_LEN: u8,
            reserved70: [1]u8,
            ///  endpoint 5 control
            R8_UEP5_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                USBHD_UEP_T_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 5 control
            R8_UEP5_R_CTRL_: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                USBHD_UEP_R_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 6 transmittal length
            R8_UEP6_T_LEN: u8,
            reserved74: [1]u8,
            ///  endpoint 6 control
            R8_UEP6_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                USBHD_UEP_T_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 6 control
            R8_UEP6_R_CTRL_: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                USBHD_UEP_R_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 7 transmittal length
            R8_UEP7_T_LEN: u8,
            reserved78: [1]u8,
            ///  endpoint 7 control
            R8_UEP7_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                USBHD_UEP_T_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 7 control
            R8_UEP7_R_CTRL_: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                USBHD_UEP_R_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
        };

        pub const USBFS_HOST = extern struct {
            ///  USB base control
            USBHD_BASE_CTRL: mmio.Mmio(packed struct(u8) {
                ///  DMA enable and DMA interrupt enable for USB
                USBHD_UC_DMA_EN: u1,
                ///  force clear FIFO and count of USB
                USBHD_UC_CLR_ALL: u1,
                ///  force reset USB SIE, need software clear
                USBHD_UC_RESET_SIE: u1,
                ///  enable automatic responding busy for device mode or automatic pause for host mode during interrupt flag UIF_TRANSFER valid
                USBHD_UC_INT_BUSY: u1,
                ///  USB device enable and internal pullup resistance enable
                USBHD_UC_SYS_CTRL_MASK: u2,
                ///  enable USB low speed: 0=12Mbps, 1=1.5Mbps
                USBHD_UC_LOW_SPEED: u1,
                ///  enable USB host mode: 0=device mode, 1=host mode
                RB_UC_HOST_MODE: u1,
            }),
            ///  USB device/host physical prot control
            USBHD_UDEV_CTRL__USBHD_UHOST_CTRL: mmio.Mmio(packed struct(u8) {
                ///  enable USB port: 0=disable, 1=enable port, automatic disabled if USB device detached
                USBHD_UH_PORT_EN__USBHD_UD_PORT_EN: u1,
                ///  force clear FIFO and count of USB
                USBHD_UH_BUS_RESET__USBHD_UD_GP_BIT: u1,
                ///  enable USB port low speed: 0=full speed, 1=low speed
                USBHD_UH_LOW_SPEED__USBHD_UD_LOW_SPEED: u1,
                reserved4: u1,
                ///  ReadOnly: indicate current UDM pin level
                USBHD_UH_DM_PIN__USBHD_UD_DM_PIN: u1,
                ///  USB device enable and internal pullup resistance enable
                USBHD_UH_DP_PIN__USBHD_UD_DP_PIN: u1,
                reserved7: u1,
                ///  disable USB UDP/UDM pulldown resistance: 0=enable pulldown, 1=disable
                USBHD_UH_PD_DIS__USBHD_UD_PD_DIS: u1,
            }),
            ///  USB interrupt enable
            R8_USB_INT_EN: mmio.Mmio(packed struct(u8) {
                ///  enable interrupt for USB bus reset event for USB device mode
                USBHD_UIE_BUS_RST__USBHD_UIE_DETECT: u1,
                ///  enable interrupt for USB transfer completion
                USBHD_UIE_TRANSFER: u1,
                ///  enable interrupt for USB suspend or resume event
                USBHD_UIE_SUSPEND: u1,
                ///  enable interrupt for host SOF timer action for USB host mode
                USBHD_UIE_HST_SOF: u1,
                ///  enable interrupt for FIFO overflow
                USBHD_UIE_FIFO_OV: u1,
                reserved6: u1,
                ///  enable interrupt for NAK responded for USB device mode
                USBHD_UIE_DEV_NAK: u1,
                ///  enable interrupt for SOF received for USB device mode
                USBHD_UIE_DEV_SOF: u1,
            }),
            ///  USB device address
            R8_USB_DEV_AD: mmio.Mmio(packed struct(u8) {
                ///  bit mask for USB device address
                MASK_USB_ADDR: u7,
                ///  general purpose bit
                RB_UDA_GP_BIT: u1,
            }),
            reserved5: [1]u8,
            ///  USB miscellaneous status
            R8_USB_MIS_ST: mmio.Mmio(packed struct(u8) {
                ///  RO, indicate device attached status on USB host
                RB_UMS_DEV_ATTACH: u1,
                ///  RO, indicate UDM level saved at device attached to USB host
                RB_UMS_DM_LEVEL: u1,
                ///  RO, indicate USB suspend status
                RB_UMS_SUSPEND: u1,
                ///  RO, indicate USB bus reset status
                RB_UMS_BUS_RESET: u1,
                ///  RO, indicate USB receiving FIFO ready status (not empty)
                RB_UMS_R_FIFO_RDY: u1,
                ///  RO, indicate USB SIE free status
                RB_UMS_SIE_FREE: u1,
                ///  RO, indicate host SOF timer action status for USB host
                RB_UMS_SOF_ACT: u1,
                ///  RO, indicate host SOF timer presage status
                RB_UMS_SOF_PRES: u1,
            }),
            ///  USB interrupt flag
            R8_USB_INT_FG: mmio.Mmio(packed struct(u8) {
                ///  bus reset event interrupt flag for USB device mode, direct bit address clear or write 1 to clear;device detected event interrupt flag for USB host mode, direct bit address clear or write 1 to clear
                RB_UIF_BUS_RST__RB_UIF_DETECT: u1,
                ///  USB transfer completion interrupt flag, direct bit address clear or write 1 to clear
                RB_UIF_TRANSFER: u1,
                ///  USB suspend or resume event interrupt flag, direct bit address clear or write 1 to clear
                RB_UIF_SUSPEND: u1,
                ///  host SOF timer interrupt flag for USB host, direct bit address clear or write 1 to clear
                RB_UIF_HST_SOF: u1,
                ///  FIFO overflow interrupt flag for USB, direct bit address clear or write 1 to clear
                RB_UIF_FIFO_OV: u1,
                ///  RO, indicate USB SIE free status
                RB_U_SIE_FREE: u1,
                ///  RO, indicate current USB transfer toggle is OK
                RB_U_TOG_OK: u1,
                ///  RO, indicate current USB transfer is NAK received
                RB_U_IS_NAK: u1,
            }),
            ///  USB interrupt status
            R8_USB_INT_ST: mmio.Mmio(packed struct(u8) {
                ///  RO, bit mask of current transfer handshake response for USB host mode: 0000=no response, time out from device, others=handshake response PID received;RO, bit mask of current transfer endpoint number for USB device mode
                MASK_UIS_H_RES__MASK_UIS_ENDP: u4,
                ///  RO, bit mask of current token PID code received for USB device mode
                MASK_UIS_TOKEN: u2,
                ///  RO, indicate current USB transfer toggle is OK
                RB_UIS_TOG_OK: u1,
                ///  RO, indicate current USB transfer is NAK received for USB device mode
                RB_UIS_IS_NAK: u1,
            }),
            ///  USB receiving length
            R16_USB_RX_LEN: u16,
            reserved12: [2]u8,
            ///  endpoint 4/1 mode
            R8_UEP4_1_MOD: mmio.Mmio(packed struct(u8) {
                reserved2: u2,
                ///  enable USB endpoint 4 transmittal (IN)
                RB_UEP4_TX_EN: u1,
                ///  enable USB endpoint 4 receiving (OUT)
                RB_UEP4_RX_EN: u1,
                ///  buffer mode of USB endpoint 1
                RB_UEP1_BUF_MOD: u1,
                reserved6: u1,
                ///  enable USB endpoint 1 transmittal (IN)
                RB_UEP1_TX_EN: u1,
                ///  enable USB endpoint 1 receiving (OUT)
                RB_UEP1_RX_EN: u1,
            }),
            ///  endpoint 2/3 mode;host endpoint mode
            R8_UEP2_3_MOD__R8_UH_EP_MOD: mmio.Mmio(packed struct(u8) {
                ///  buffer mode of USB endpoint 2;buffer mode of USB host IN endpoint
                RB_UEP2_BUF_MOD__RB_UH_EP_RBUF_MOD: u1,
                reserved2: u1,
                ///  enable USB endpoint 2 transmittal (IN)
                RB_UEP2_TX_EN: u1,
                ///  enable USB endpoint 2 receiving (OUT);enable USB host IN endpoint receiving
                RB_UEP2_RX_EN__RB_UH_EP_RX_EN: u1,
                ///  buffer mode of USB endpoint 3;buffer mode of USB host OUT endpoint
                RB_UEP3_BUF_MOD__RB_UH_EP_TBUF_MOD: u1,
                reserved6: u1,
                ///  enable USB endpoint 3 transmittal (IN);enable USB host OUT endpoint transmittal
                RB_UEP3_TX_EN__RB_UH_EP_TX_EN: u1,
                ///  enable USB endpoint 3 receiving (OUT)
                RB_UEP3_RX_EN: u1,
            }),
            ///  endpoint 5/6 mode
            R8_UEP5_6_MOD: mmio.Mmio(packed struct(u8) {
                ///  buffer mode of USB endpoint 5
                RB_UEP5_BUF_MOD: u1,
                reserved2: u1,
                ///  enable USB endpoint 5 transmittal (IN)
                RB_UEP5_TX_EN: u1,
                ///  enable USB endpoint 5 receiving (OUT)
                RB_UEP5_RX_EN: u1,
                ///  buffer mode of USB endpoint 6
                RB_UEP6_BUF_MOD: u1,
                reserved6: u1,
                ///  enable USB endpoint 6 transmittal (IN)
                RB_UEP6_TX_EN: u1,
                ///  enable USB endpoint 6 receiving (OUT)
                RB_UEP3_RX_EN: u1,
            }),
            ///  endpoint 7 mode
            R8_UEP7_MOD: mmio.Mmio(packed struct(u8) {
                ///  buffer mode of USB endpoint 7
                RB_UEP7_BUF_MOD: u1,
                reserved2: u1,
                ///  enable USB endpoint 7 transmittal (IN)
                RB_UEP7_TX_EN: u1,
                ///  enable USB endpoint 7 receiving (OUT)
                RB_UEP7_RX_EN: u1,
                padding: u4,
            }),
            ///  endpoint 0 DMA buffer address
            R32_UEP0_DMA: u32,
            ///  endpoint 1 DMA buffer address
            R32_UEP1_DMA: u32,
            ///  endpoint 2 DMA buffer address;host rx endpoint buffer high address
            R32_UEP2_DMA__R32_UH_RX_DMA: u32,
            ///  endpoint 3 DMA buffer address;host tx endpoint buffer high address
            R32_UEP3_DMA__R32_UH_TX_DMA: u32,
            ///  endpoint 4 DMA buffer address
            R32_UEP4_DMA: u32,
            ///  endpoint 5 DMA buffer address
            R32_UEP5_DMA: u32,
            ///  endpoint 6 DMA buffer address
            R32_UEP6_DMA: u32,
            ///  endpoint 7 DMA buffer address
            R32_UEP7_DMA: u32,
            ///  endpoint 0 transmittal length
            R8_UEP0_T_LEN: u8,
            reserved50: [1]u8,
            ///  endpoint 0 control
            R8_UEP0_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                USBHD_UEP_T_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 0 control
            R8_UEP0_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                USBHD_UEP_R_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 1 transmittal length
            R8_UEP1_T_LEN: u8,
            reserved54: [1]u8,
            ///  endpoint 1 control
            R8_UEP1_T_CTRL___USBHD_UH_SETUP: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                USBHD_UEP_T_TOG_: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                reserved6: u2,
                ///  USB host automatic SOF enable
                USBHD_UH_SOF_EN: u1,
                ///  USB host PRE PID enable for low speed device via hub
                USBHD_UH_PRE_PID_EN: u1,
            }),
            ///  endpoint 1 control
            R8_UEP1_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                USBHD_UEP_R_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 2 transmittal length
            R8_UEP2_T_LEN__USBHD_UH_EP_PID: mmio.Mmio(packed struct(u8) {
                ///  bit mask of endpoint number for USB host transfer
                USBHD_UH_ENDP_MASK: u4,
                ///  bit mask of token PID for USB host transfer
                USBHD_UH_TOKEN_MASK: u4,
            }),
            reserved58: [1]u8,
            ///  endpoint 2 control
            R8_UEP2_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                USBHD_UEP_T_TOG_: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 2 control
            R8_UEP2_R_CTRL__USBHD_UH_RX_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES___USBHD_UH_R_RES: u2,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                USBHD_UEP_R_TOG___USBHD_UH_R_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG___USBHD_UH_R_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 3 transmittal length
            R8_UEP3_T_LEN__USBHD_UH_TX_LEN: u8,
            reserved62: [1]u8,
            ///  endpoint 3 control
            R8_UEP3_T_CTRL__USBHD_UH_TX_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES___USBHD_UH_T_RES: u2,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                USBHD_UEP_T_TOG___USBHD_UH_T_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG__USBHD_UH_T_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 3 control
            R8_UEP3_R_CTRL_: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                USBHD_UEP_R_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 4 transmittal length
            R8_UEP4_T_LEN: u8,
            reserved66: [1]u8,
            ///  endpoint 4 control
            R8_UEP4_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                USBHD_UEP_T_TOG___USBHD_UH_T_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG__USBHD_UH_T_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 4 control
            R8_UEP4_R_CTRL_: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                USBHD_UEP_R_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 5 transmittal length
            R8_UEP5_T_LEN: u8,
            reserved70: [1]u8,
            ///  endpoint 5 control
            R8_UEP5_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                USBHD_UEP_T_TOG___USBHD_UH_T_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG__USBHD_UH_T_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 5 control
            R8_UEP5_R_CTRL_: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                USBHD_UEP_R_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 6 transmittal length
            R8_UEP6_T_LEN: u8,
            reserved74: [1]u8,
            ///  endpoint 6 control
            R8_UEP6_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                USBHD_UEP_T_TOG___USBHD_UH_T_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG__USBHD_UH_T_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 6 control
            R8_UEP6_R_CTRL_: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                USBHD_UEP_R_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 7 transmittal length
            R8_UEP7_T_LEN: u8,
            reserved78: [1]u8,
            ///  endpoint 7 control
            R8_UEP7_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X transmittal (IN)
                MASK_UEP_T_RES: u2,
                ///  prepared data toggle flag of USB endpoint X transmittal (IN): 0=DATA0, 1=DATA1
                USBHD_UEP_T_TOG___USBHD_UH_T_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG__USBHD_UH_T_AUTO_TOG: u1,
                padding: u4,
            }),
            ///  endpoint 7 control
            R8_UEP7_R_CTRL_: mmio.Mmio(packed struct(u8) {
                ///  bit mask of handshake response type for USB endpoint X receiving (OUT)
                MASK_UEP_R_RES: u2,
                ///  expected data toggle flag of USB endpoint X receiving (OUT): 0=DATA0, 1=DATA1
                USBHD_UEP_R_TOG: u1,
                ///  enable automatic toggle after successful transfer completion on endpoint 1/2/3: 0=manual toggle, 1=automatic toggle
                USBHD_UEP_AUTO_TOG: u1,
                padding: u4,
            }),
        };

        ///  FLASH
        pub const FLASH = extern struct {
            reserved4: [4]u8,
            ///  Flash key register
            KEYR: mmio.Mmio(packed struct(u32) {
                ///  FPEC key
                KEYR: u32,
            }),
            ///  Flash option key register
            OBKEYR: mmio.Mmio(packed struct(u32) {
                ///  Option byte key
                OPTKEY: u32,
            }),
            ///  Status register
            STATR: mmio.Mmio(packed struct(u32) {
                ///  Busy
                BSY: u1,
                ///  Quick page programming
                WR_BSY: u1,
                reserved4: u2,
                ///  Write protection error
                WRPRTERR: u1,
                ///  End of operation
                EOP: u1,
                reserved7: u1,
                ///  Enhance mode start
                ENHANCE_MOD_STA: u1,
                padding: u24,
            }),
            ///  Control register
            CTLR: mmio.Mmio(packed struct(u32) {
                ///  Programming
                PG: u1,
                ///  Page Erase
                PER: u1,
                ///  Mass Erase
                MER: u1,
                reserved4: u1,
                ///  Option byte programming
                OBPG: u1,
                ///  Option byte erase
                OBER: u1,
                ///  Start
                STRT: u1,
                ///  Lock
                LOCK: u1,
                reserved9: u1,
                ///  Option bytes write enable
                OBWRE: u1,
                ///  Error interrupt enable
                ERRIE: u1,
                reserved12: u1,
                ///  End of operation interrupt enable
                EOPIE: u1,
                reserved15: u2,
                ///  Fast programmable lock
                FLOCK: u1,
                ///  Fast programming
                PAGE_PG: u1,
                ///  Fast erase
                PAGE_ER: u1,
                ///  Block Erase 32K
                BER32: u1,
                ///  Block Erase 64K
                BER64: u1,
                reserved21: u1,
                ///  Page Programming Start
                PGSTART: u1,
                ///  Reset Flash Enhance read mode
                RSENACT: u1,
                reserved24: u1,
                ///  Flash Enhance read mode
                ENHANCEMODE: u1,
                ///  Flash SCK mode
                SCKMODE: u1,
                padding: u6,
            }),
            ///  Flash address register
            ADDR: mmio.Mmio(packed struct(u32) {
                ///  Flash Address
                FAR: u32,
            }),
            reserved28: [4]u8,
            ///  Option byte register
            OBR: mmio.Mmio(packed struct(u32) {
                ///  Option byte error
                OBERR: u1,
                ///  Read protection
                RDPRT: u1,
                ///  IWDG_SW
                IWDG_SW: u1,
                ///  STOP_RST
                STOP_RST: u1,
                ///  STANDY_RST
                STANDY_RST: u1,
                reserved8: u3,
                ///  SRAM_CODE_MODE
                SRAM_CODE_MODE: u2,
                padding: u22,
            }),
            ///  Write protection register
            WPR: mmio.Mmio(packed struct(u32) {
                ///  Write protect
                WRP: u32,
            }),
            ///  Mode select register
            MODEKEYR: mmio.Mmio(packed struct(u32) {
                ///  Mode select
                MODEKEYR: u32,
            }),
        };

        ///  CRC calculation unit
        pub const CRC = extern struct {
            ///  Data register
            DATAR: mmio.Mmio(packed struct(u32) {
                ///  Data Register
                DR: u32,
            }),
            ///  Independent Data register
            IDATAR: mmio.Mmio(packed struct(u32) {
                ///  Independent Data register
                IDR: u8,
                padding: u24,
            }),
            ///  Control register
            CTLR: mmio.Mmio(packed struct(u32) {
                ///  Reset bit
                RESET: u1,
                padding: u31,
            }),
        };

        ///  Alternate function I/O
        pub const AFIO = extern struct {
            ///  Event Control Register (AFIO_ECR)
            ECR: mmio.Mmio(packed struct(u32) {
                ///  Pin selection
                PIN: u4,
                ///  Port selection
                PORT: u3,
                ///  Event Output Enable
                EVOE: u1,
                padding: u24,
            }),
            ///  AF remap and debug I/O configuration register (AFIO_PCFR)
            PCFR: mmio.Mmio(packed struct(u32) {
                ///  SPI1 remapping
                SPI1RM: u1,
                ///  I2C1 remapping
                I2C1RM: u1,
                ///  USART1 remapping
                USART1RM: u1,
                ///  USART2 remapping
                USART2RM: u1,
                ///  USART3 remapping
                USART3RM: u2,
                ///  TIM1 remapping
                TIM1RM: u2,
                ///  TIM2 remapping
                TIM2RM: u2,
                ///  TIM3 remapping
                TIM3RM: u2,
                ///  TIM4 remapping
                TIM4RM: u1,
                ///  CAN1 remapping
                CAN1RM: u2,
                ///  Port D0/Port D1 mapping on OSCIN/OSCOUT
                PD01RM: u1,
                ///  TIM5 channel4 internal remap
                TIM5CH4RM: u1,
                ///  ADC 1 External trigger injected conversion remapping
                ADC1_ETRGINJ_RM: u1,
                ///  ADC 1 external trigger regular conversion remapping
                ADC1_ETRGREG_RM: u1,
                ///  ADC 2 External trigger injected conversion remapping
                ADC2_ETRGINJ_RM: u1,
                ///  ADC 2 external trigger regular conversion remapping
                ADC2_ETRGREG_RM: u1,
                ///  Ethernet remapping
                ETHRM: u1,
                ///  CAN2 remapping
                CAN2RM: u1,
                ///  MII_RMII_SEL
                MII_RMII_SEL: u1,
                ///  Serial wire JTAG configuration
                SWCFG: u3,
                reserved28: u1,
                ///  SPI3 remapping
                SPI3_RM: u1,
                ///  TIM2 internally triggers 1 remapping
                TIM2ITRA_RM: u1,
                ///  Ethernet PTP_PPS remapping
                PTP_PPSP_RM: u1,
                padding: u1,
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
            ///  AF remap and debug I/O configuration register (AFIO_PCFR2)
            PCFR2: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  TIM8 remapping
                TIM8_REMAP: u1,
                ///  TIM9 remapping
                TIM9_REMAP: u2,
                ///  TIM10 remapping
                TIM10_REMAP: u2,
                reserved10: u3,
                ///  FSMC_NADV
                FSMC_NADV: u1,
                reserved16: u5,
                ///  UART4 remapping
                UART4_REMAP: u2,
                ///  UART5 remapping
                UART5_REMAP: u2,
                ///  UART6 remapping
                UART6_REMAP: u2,
                ///  UART7 remapping
                UART7_REMAP: u2,
                ///  UART8 remapping
                UART8_REMAP: u2,
                ///  UART1 remapping
                UART1_REMAP2: u1,
                padding: u5,
            }),
        };

        ///  EXTI
        pub const EXTI = extern struct {
            ///  Interrupt mask register (EXTI_INTENR)
            INTENR: mmio.Mmio(packed struct(u32) {
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
                padding: u12,
            }),
            ///  Event mask register (EXTI_EVENR)
            EVENR: mmio.Mmio(packed struct(u32) {
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
                padding: u12,
            }),
            ///  Rising Trigger selection register (EXTI_RTENR)
            RTENR: mmio.Mmio(packed struct(u32) {
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
                padding: u12,
            }),
            ///  Falling Trigger selection register (EXTI_FTENR)
            FTENR: mmio.Mmio(packed struct(u32) {
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
                padding: u12,
            }),
            ///  Software interrupt event register (EXTI_SWIEVR)
            SWIEVR: mmio.Mmio(packed struct(u32) {
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
                padding: u12,
            }),
            ///  Pending register (EXTI_INTFR)
            INTFR: mmio.Mmio(packed struct(u32) {
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
                padding: u12,
            }),
        };

        ///  DMA1 controller
        pub const DMA1 = extern struct {
            ///  DMA interrupt status register (DMA_INTFR)
            INTFR: mmio.Mmio(packed struct(u32) {
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
                ///  Channel 8 Global interrupt flag use in ch32v20_D8/D8W/D6
                GIF8: u1,
                ///  Channel 8 Transfer Complete flag use in ch32v20_D8/D8W/D6
                TCIF8: u1,
                ///  Channel 8 Half Transfer Complete flag use in ch32v20_D8/D8W/D6
                HTIF8: u1,
                ///  Channel 8 Transfer Error flag use in ch32v20_D8/D8W/D6
                TEIF8: u1,
            }),
            ///  DMA interrupt flag clear register (DMA_INTFCR)
            INTFCR: mmio.Mmio(packed struct(u32) {
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
                ///  Channel 8 Global interrupt clear use in ch32v20_D8/D8W/D6
                CGIF8: u1,
                ///  Channel 8 Transfer Complete clear use in ch32v20_D8/D8W/D6
                CTCIF8: u1,
                ///  Channel 8 Half Transfer clear use in ch32v20_D8/D8W/D6
                CHTIF8: u1,
                ///  Channel 8 Transfer Error clear use in ch32v20_D8/D8W/D6
                CTEIF8: u1,
            }),
            ///  DMA channel configuration register (DMA_CFGR)
            CFGR1: mmio.Mmio(packed struct(u32) {
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
            CNTR1: mmio.Mmio(packed struct(u32) {
                ///  Number of data to transfer
                NDT: u16,
                padding: u16,
            }),
            ///  DMA channel 1 peripheral address register
            PADDR1: mmio.Mmio(packed struct(u32) {
                ///  Peripheral address
                PA: u32,
            }),
            ///  DMA channel 1 memory address register
            MADDR1: mmio.Mmio(packed struct(u32) {
                ///  Memory address
                MA: u32,
            }),
            reserved28: [4]u8,
            ///  DMA channel configuration register (DMA_CFGR)
            CFGR2: mmio.Mmio(packed struct(u32) {
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
            CNTR2: mmio.Mmio(packed struct(u32) {
                ///  Number of data to transfer
                NDT: u16,
                padding: u16,
            }),
            ///  DMA channel 2 peripheral address register
            PADDR2: mmio.Mmio(packed struct(u32) {
                ///  Peripheral address
                PA: u32,
            }),
            ///  DMA channel 2 memory address register
            MADDR2: mmio.Mmio(packed struct(u32) {
                ///  Memory address
                MA: u32,
            }),
            reserved48: [4]u8,
            ///  DMA channel configuration register (DMA_CFGR)
            CFGR3: mmio.Mmio(packed struct(u32) {
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
            CNTR3: mmio.Mmio(packed struct(u32) {
                ///  Number of data to transfer
                NDT: u16,
                padding: u16,
            }),
            ///  DMA channel 3 peripheral address register
            PADDR3: mmio.Mmio(packed struct(u32) {
                ///  Peripheral address
                PA: u32,
            }),
            ///  DMA channel 3 memory address register
            MADDR3: mmio.Mmio(packed struct(u32) {
                ///  Memory address
                MA: u32,
            }),
            reserved68: [4]u8,
            ///  DMA channel configuration register (DMA_CFGR)
            CFGR4: mmio.Mmio(packed struct(u32) {
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
            CNTR4: mmio.Mmio(packed struct(u32) {
                ///  Number of data to transfer
                NDT: u16,
                padding: u16,
            }),
            ///  DMA channel 4 peripheral address register
            PADDR4: mmio.Mmio(packed struct(u32) {
                ///  Peripheral address
                PA: u32,
            }),
            ///  DMA channel 4 memory address register
            MADDR4: mmio.Mmio(packed struct(u32) {
                ///  Memory address
                MA: u32,
            }),
            reserved88: [4]u8,
            ///  DMA channel configuration register (DMA_CFGR)
            CFGR5: mmio.Mmio(packed struct(u32) {
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
            CNTR5: mmio.Mmio(packed struct(u32) {
                ///  Number of data to transfer
                NDT: u16,
                padding: u16,
            }),
            ///  DMA channel 5 peripheral address register
            PADDR5: mmio.Mmio(packed struct(u32) {
                ///  Peripheral address
                PA: u32,
            }),
            ///  DMA channel 5 memory address register
            MADDR5: mmio.Mmio(packed struct(u32) {
                ///  Memory address
                MA: u32,
            }),
            reserved108: [4]u8,
            ///  DMA channel configuration register (DMA_CFGR)
            CFGR6: mmio.Mmio(packed struct(u32) {
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
            CNTR6: mmio.Mmio(packed struct(u32) {
                ///  Number of data to transfer
                NDT: u16,
                padding: u16,
            }),
            ///  DMA channel 6 peripheral address register
            PADDR6: mmio.Mmio(packed struct(u32) {
                ///  Peripheral address
                PA: u32,
            }),
            ///  DMA channel 6 memory address register
            MADDR6: mmio.Mmio(packed struct(u32) {
                ///  Memory address
                MA: u32,
            }),
            reserved128: [4]u8,
            ///  DMA channel configuration register (DMA_CFGR)
            CFGR7: mmio.Mmio(packed struct(u32) {
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
            CNTR7: mmio.Mmio(packed struct(u32) {
                ///  Number of data to transfer
                NDT: u16,
                padding: u16,
            }),
            ///  DMA channel 7 peripheral address register
            PADDR7: mmio.Mmio(packed struct(u32) {
                ///  Peripheral address
                PA: u32,
            }),
            ///  DMA channel 7 memory address register
            MADDR7: mmio.Mmio(packed struct(u32) {
                ///  Memory address
                MA: u32,
            }),
            reserved148: [4]u8,
            ///  DMA channel configuration register (DMA_CFGR) use in ch32v20_D8/D8W/D6
            CFGR8: mmio.Mmio(packed struct(u32) {
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
            ///  DMA channel 8 number of data register use in ch32v20_D8/D8W/D6
            CNTR8: mmio.Mmio(packed struct(u32) {
                ///  Number of data to transfer
                NDT: u16,
                padding: u16,
            }),
            ///  DMA channel 8 peripheral address register use in ch32v20_D8/D8W/D6
            PADDR8: mmio.Mmio(packed struct(u32) {
                ///  Peripheral address
                PA: u32,
            }),
            ///  DMA channel 8 memory address register use in ch32v20_D8/D8W/D6
            MADDR8: mmio.Mmio(packed struct(u32) {
                ///  Memory address
                MA: u32,
            }),
        };

        ///  Real time clock
        pub const RTC = extern struct {
            ///  RTC Control Register High
            CTLRH: mmio.Mmio(packed struct(u32) {
                ///  Second interrupt Enable
                SECIE: u1,
                ///  Alarm interrupt Enable
                ALRIE: u1,
                ///  Overflow interrupt Enable
                OWIE: u1,
                padding: u29,
            }),
            ///  RTC Control Register Low
            CTLRL: mmio.Mmio(packed struct(u32) {
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
            PSCRH: mmio.Mmio(packed struct(u32) {
                ///  RTC Prescaler Load Register High
                PRLH: u4,
                padding: u28,
            }),
            ///  RTC Prescaler Load Register Low
            PSCRL: mmio.Mmio(packed struct(u32) {
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
            ALRMH: mmio.Mmio(packed struct(u32) {
                ///  RTC alarm register high
                ALRH: u16,
                padding: u16,
            }),
            ///  RTC Alarm Register Low
            ALRML: mmio.Mmio(packed struct(u32) {
                ///  RTC alarm register low
                ALRL: u16,
                padding: u16,
            }),
        };

        ///  Backup registers
        pub const BKP = extern struct {
            reserved4: [4]u8,
            ///  Backup data register (BKP_DR)
            DATAR1: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D1: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR2: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D2: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR3: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D3: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR4: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D4: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR5: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D5: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR6: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D6: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR7: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D7: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR8: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D8: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR9: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D9: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR10: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D10: u16,
                padding: u16,
            }),
            ///  RTC clock calibration register (BKP_OCTLR)
            OCTLR: mmio.Mmio(packed struct(u32) {
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
            ///  Backup control register (BKP_TPCTLR)
            TPCTLR: mmio.Mmio(packed struct(u32) {
                ///  Tamper pin enable
                TPE: u1,
                ///  Tamper pin active level
                TPAL: u1,
                padding: u30,
            }),
            ///  BKP_TPCSR control/status register (BKP_CSR)
            TPCSR: mmio.Mmio(packed struct(u32) {
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
            reserved64: [8]u8,
            ///  Backup data register (BKP_DR)
            DATAR11: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                DR11: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR12: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                DR12: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR13: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                DR13: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR14: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D14: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR15: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D15: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR16: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D16: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR17: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D17: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR18: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D18: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR19: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D19: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR20: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D20: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR21: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D21: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR22: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D22: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR23: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D23: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR24: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D24: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR25: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D25: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR26: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D26: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR27: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D27: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR28: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D28: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR29: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D29: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR30: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D30: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR31: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D31: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR32: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D32: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR33: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D33: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR34: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D34: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR35: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D35: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR36: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D36: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR37: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D37: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR38: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D38: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR39: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D39: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR40: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D40: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR41: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D41: u16,
                padding: u16,
            }),
            ///  Backup data register (BKP_DR)
            DATAR42: mmio.Mmio(packed struct(u32) {
                ///  Backup data
                D42: u16,
                padding: u16,
            }),
        };

        ///  Independent watchdog
        pub const IWDG = extern struct {
            ///  Key register (IWDG_CTLR)
            CTLR: mmio.Mmio(packed struct(u32) {
                ///  Key value
                KEY: u16,
                padding: u16,
            }),
            ///  Prescaler register (IWDG_PSCR)
            PSCR: mmio.Mmio(packed struct(u32) {
                ///  Prescaler divider
                PR: u3,
                padding: u29,
            }),
            ///  Reload register (IWDG_RLDR)
            RLDR: mmio.Mmio(packed struct(u32) {
                ///  Watchdog counter reload value
                RL: u12,
                padding: u20,
            }),
            ///  Status register (IWDG_SR)
            STATR: mmio.Mmio(packed struct(u32) {
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
            CTLR: mmio.Mmio(packed struct(u32) {
                ///  7-bit counter (MSB to LSB)
                T: u7,
                ///  Activation bit
                WDGA: u1,
                padding: u24,
            }),
            ///  Configuration register (WWDG_CFR)
            CFGR: mmio.Mmio(packed struct(u32) {
                ///  7-bit window value
                W: u7,
                ///  Timer Base
                WDGTB: u2,
                ///  Early Wakeup Interrupt
                EWI: u1,
                padding: u22,
            }),
            ///  Status register (WWDG_SR)
            STATR: mmio.Mmio(packed struct(u32) {
                ///  Early Wakeup Interrupt Flag
                WEIF: u1,
                padding: u31,
            }),
        };

        ///  Advanced timer
        pub const TIM1 = extern struct {
            ///  control register 1
            CTLR1: mmio.Mmio(packed struct(u32) {
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
            CTLR2: mmio.Mmio(packed struct(u32) {
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
            SMCFGR: mmio.Mmio(packed struct(u32) {
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
            DMAINTENR: mmio.Mmio(packed struct(u32) {
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
            INTFR: mmio.Mmio(packed struct(u32) {
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
            SWEVGR: mmio.Mmio(packed struct(u32) {
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
            CHCTLR1_Output: mmio.Mmio(packed struct(u32) {
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
            CHCTLR2_Output: mmio.Mmio(packed struct(u32) {
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
            ATRLR: mmio.Mmio(packed struct(u32) {
                ///  Auto-reload value
                ATRLR: u16,
                padding: u16,
            }),
            ///  repetition counter register
            RPTCR: mmio.Mmio(packed struct(u32) {
                ///  Repetition counter value
                RPTCR: u8,
                padding: u24,
            }),
            ///  capture/compare register 1
            CH1CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare 1 value
                CH1CVR: u16,
                padding: u16,
            }),
            ///  capture/compare register 2
            CH2CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare 2 value
                CH2CVR: u16,
                padding: u16,
            }),
            ///  capture/compare register 3
            CH3CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare value
                CH3CVR: u16,
                padding: u16,
            }),
            ///  capture/compare register 4
            CH4CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare value
                CH4CVR: u16,
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
            DMACFGR: mmio.Mmio(packed struct(u32) {
                ///  DMA base address
                DBA: u5,
                reserved8: u3,
                ///  DMA burst length
                DBL: u5,
                padding: u19,
            }),
            ///  DMA address for full transfer
            DMAADR: mmio.Mmio(packed struct(u32) {
                ///  DMA register for burst accesses
                DMAADR: u16,
                padding: u16,
            }),
        };

        ///  USB register
        pub const USBHD_DEVICE = extern struct {
            ///  USB base control
            USB_CTRL: mmio.Mmio(packed struct(u8) {
                ///  DMA enable and DMA interrupt enable for USB
                RB_UC_DMA_EN: u1,
                ///  force clear FIFO and count of USB
                RB_UC_CLR_ALL: u1,
                ///  force reset USB SIE, need software clear
                RB_UC_RESET_SIE: u1,
                ///  enable automatic responding busy for device mode or automatic pause for host mode during interrupt flag UIF_TRANSFER valid
                RB_UC_INT_BUSY: u1,
                ///  USB device enable and internal pullup resistance enable
                RB_UC_DEV_PU_EN: u1,
                ///  enable USB low speed: 00=full speed, 01=high speed, 10 =low speed
                RB_UC_SPEED_TYPE: u2,
                ///  enable USB host mode: 0=device mode, 1=host mode
                RB_UC_HOST_MODE: u1,
            }),
            reserved1: [1]u8,
            ///  USB interrupt enable
            USB_INT_EN: mmio.Mmio(packed struct(u8) {
                ///  enable interrupt for USB bus reset event for USB device mode
                RB_UIE_BUS_RST: u1,
                ///  enable interrupt for USB transfer completion
                RB_UIE_TRANSFER: u1,
                ///  enable interrupt for USB suspend or resume event
                RB_UIE_SUSPEND: u1,
                ///  indicate host SOF timer action status for USB host
                RB_UIE_SOF_ACT: u1,
                ///  enable interrupt for FIFO overflow
                RB_UIE_FIFO_OV: u1,
                ///  indicate host SETUP timer action status for USB host
                RB_UIE_SETUP_ACT: u1,
                ///  enable interrupt for NAK responded for USB device mode
                RB_UIE_ISO_ACT: u1,
                ///  enable interrupt for NAK responded for USB device mode
                RB_UIE_DEV_NAK: u1,
            }),
            ///  USB device address
            USB_DEV_AD: mmio.Mmio(packed struct(u8) {
                ///  bit mask for USB device address
                MASK_USB_ADDR: u7,
                ///  general purpose bit
                RB_UDA_GP_BIT: u1,
            }),
            ///  USB_FRAME_NO
            USB_FRAME_NO: mmio.Mmio(packed struct(u16) {
                ///  USB_FRAME_NO
                USB_FRAME_NO: u16,
            }),
            ///  indicate USB suspend status
            USB_USB_SUSPEND: mmio.Mmio(packed struct(u8) {
                ///  USB_SYS_MOD
                USB_SYS_MOD: u2,
                ///  remote resume
                USB_WAKEUP: u1,
                reserved4: u1,
                ///  USB_LINESTATE
                USB_LINESTATE: u2,
                padding: u2,
            }),
            reserved8: [1]u8,
            ///  USB_SPEED_TYPE
            USB_SPEED_TYPE: mmio.Mmio(packed struct(u8) {
                ///  USB_SPEED_TYPE
                USB_SPEED_TYPE: u2,
                padding: u6,
            }),
            ///  USB miscellaneous status
            USB_MIS_ST: mmio.Mmio(packed struct(u8) {
                ///  RO, indicate device attached status on USB host
                RB_UMS_SPLIT_CAN: u1,
                ///  RO, indicate UDM level saved at device attached to USB host
                RB_UMS_ATTACH: u1,
                ///  RO, indicate USB suspend status
                RB_UMS_SUSPEND: u1,
                ///  RO, indicate USB bus reset status
                RB_UMS_BUS_RESET: u1,
                ///  RO, indicate USB receiving FIFO ready status (not empty)
                RB_UMS_R_FIFO_RDY: u1,
                ///  RO, indicate USB SIE free status
                RB_UMS_SIE_FREE: u1,
                ///  RO, indicate host SOF timer action status for USB host
                RB_UMS_SOF_ACT: u1,
                ///  RO, indicate host SOF timer presage status
                RB_UMS_SOF_PRES: u1,
            }),
            ///  USB interrupt flag
            USB_INT_FG: mmio.Mmio(packed struct(u8) {
                ///  RB_UIF_BUS_RST
                RB_UIF_BUS_RST: u1,
                ///  USB transfer completion interrupt flag, direct bit address clear or write 1 to clear
                RB_UIF_TRANSFER: u1,
                ///  USB suspend or resume event interrupt flag, direct bit address clear or write 1 to clear
                RB_UIF_SUSPEND: u1,
                ///  host SOF timer interrupt flag for USB host, direct bit address clear or write 1 to clear
                RB_UIF_HST_SOF: u1,
                ///  FIFO overflow interrupt flag for USB, direct bit address clear or write 1 to clear
                RB_UIF_FIFO_OV: u1,
                ///  USB_SETUP_ACT
                RB_U_SETUP_ACT: u1,
                ///  UIF_ISO_ACT
                UIF_ISO_ACT: u1,
                ///  RO, indicate current USB transfer is NAK received
                RB_U_IS_NAK: u1,
            }),
            ///  USB interrupt status
            USB_INT_ST: mmio.Mmio(packed struct(u8) {
                ///  RO, bit mask of current transfer handshake response for USB host mode: 0000=no response, time out from device, others=handshake response PID received;RO, bit mask of current transfer endpoint number for USB device mode
                MASK_UIS_H_RES: u4,
                ///  RO, bit mask of current token PID code received for USB device mode
                MASK_UIS_TOKEN: u2,
                ///  RO, indicate current USB transfer toggle is OK
                RB_UIS_TOG_OK: u1,
                ///  RO, indicate current USB transfer is NAK received for USB device mode
                RB_UIS_IS_NAK: u1,
            }),
            ///  USB receiving length
            USB_RX_LEN: mmio.Mmio(packed struct(u16) {
                ///  length of received bytes
                R16_USB_RX_LEN: u16,
            }),
            reserved16: [2]u8,
            ///  USB endpoint configuration
            UEP_CONFIG: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  endpoint TX enable
                bUEP_T_EN: u15,
                reserved17: u1,
                ///  endpoint RX enable
                bUEP_R_EN: u15,
            }),
            ///  USB endpoint type
            UEP_TYPE: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  endpoint TX type
                bUEP_T_TYPE: u15,
                reserved17: u1,
                ///  endpoint RX type
                bUEP_R_TYPE: u15,
            }),
            ///  USB endpoint buffer mode
            UEP_BUF_MOD: mmio.Mmio(packed struct(u32) {
                ///  buffer mode of USB endpoint
                bUEP_BUF_MOD: u16,
                ///  buffer mode of USB endpoint
                bUEP_ISO_BUF_MOD: u16,
            }),
            ///  USB endpoint 0 DMA buffer address
            UEP0_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 0 DMA buffer address
                UEP0_DMA: u16,
            }),
            reserved32: [2]u8,
            ///  endpoint 1 DMA RX buffer address
            UEP1_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 1 DMA buffer address
                UEP1_RX_DMA: u16,
            }),
            reserved36: [2]u8,
            ///  endpoint 2 DMA RX buffer address
            UEP2_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 2 DMA buffer address
                UEP2_RX_DMA: u16,
            }),
            reserved40: [2]u8,
            ///  endpoint 3 DMA RX buffer address
            UEP3_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 3 DMA buffer address
                UEP3_RX_DMA: u16,
            }),
            reserved44: [2]u8,
            ///  endpoint 4 DMA RX buffer address
            UEP4_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 4 DMA buffer address
                UEP4_RX_DMA: u16,
            }),
            reserved48: [2]u8,
            ///  endpoint 5 DMA RX buffer address
            UEP5_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 5 DMA buffer address
                UEP5_DMA: u16,
            }),
            reserved52: [2]u8,
            ///  endpoint 6 DMA RX buffer address
            UEP6_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 6 DMA buffer address
                UEP6_RX_DMA: u16,
            }),
            reserved56: [2]u8,
            ///  endpoint 7 DMA RX buffer address
            UEP7_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 7 DMA buffer address
                UEP7_RX_DMA: u16,
            }),
            reserved60: [2]u8,
            ///  endpoint 8 DMA RX buffer address
            UEP8_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 8 DMA buffer address
                UEP8_RX_DMA: u16,
            }),
            reserved64: [2]u8,
            ///  endpoint 9 DMA RX buffer address
            UEP9_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 9 DMA buffer address
                UEP9_RX_DMA: u16,
            }),
            reserved68: [2]u8,
            ///  endpoint 10 DMA RX buffer address
            UEP10_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 10 DMA buffer address
                UEP10_RX_DMA: u16,
            }),
            reserved72: [2]u8,
            ///  endpoint 11 DMA RX buffer address
            UEP11_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 11 DMA buffer address
                UEP11_RX_DMA: u16,
            }),
            reserved76: [2]u8,
            ///  endpoint 12 DMA RX buffer address
            UEP12_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 12 DMA buffer address
                UEP12_RX_DMA: u16,
            }),
            reserved80: [2]u8,
            ///  endpoint 13 DMA RX buffer address
            UEP13_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 13 DMA buffer address
                UEP13_RX_DMA: u16,
            }),
            reserved84: [2]u8,
            ///  endpoint 14 DMA RX buffer address
            UEP14_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 14 DMA buffer address
                UEP14_RX_DMA: u16,
            }),
            reserved88: [2]u8,
            ///  endpoint 15 DMA RX buffer address
            UEP15_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 15 DMA buffer address
                UEP15_RX_DMA: u16,
            }),
            reserved92: [2]u8,
            ///  endpoint 1 DMA TX buffer address
            UEP1_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 1 DMA buffer address
                UEP1_TX_DMA: u16,
            }),
            reserved96: [2]u8,
            ///  endpoint 2 DMA TX buffer address
            UEP2_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 2 DMA buffer address
                UEP2_TX_DMA: u16,
            }),
            reserved100: [2]u8,
            ///  endpoint 3 DMA TX buffer address
            UEP3_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 3 DMA buffer address
                UEP3_TX_DMA: u16,
            }),
            reserved104: [2]u8,
            ///  endpoint 4 DMA TX buffer address
            UEP4_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 4 DMA buffer address
                UEP4_TX_DMA: u16,
            }),
            reserved108: [2]u8,
            ///  endpoint 5 DMA TX buffer address
            UEP5_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 5 DMA buffer address
                UEP5_TX_DMA: u16,
            }),
            reserved112: [2]u8,
            ///  endpoint 6 DMA TX buffer address
            UEP6_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 6 DMA buffer address
                UEP6_TX_DMA: u16,
            }),
            reserved116: [2]u8,
            ///  endpoint 7 DMA TX buffer address
            UEP7_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 7 DMA buffer address
                UEP7_TX_DMA: u16,
            }),
            reserved120: [2]u8,
            ///  endpoint 8 DMA TX buffer address
            UEP8_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 8 DMA buffer address
                UEP8_TX_DMA: u16,
            }),
            reserved124: [2]u8,
            ///  endpoint 9 DMA TX buffer address
            UEP9_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 9 DMA buffer address
                UEP9_TX_DMA: u16,
            }),
            reserved128: [2]u8,
            ///  endpoint 10 DMA TX buffer address
            UEP10_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 10 DMA buffer address
                UEP10_TX_DMA: u16,
            }),
            reserved132: [2]u8,
            ///  endpoint 11 DMA TX buffer address
            UEP11_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 11 DMA buffer address
                UEP11_TX_DMA: u16,
            }),
            reserved136: [2]u8,
            ///  endpoint 12 DMA TX buffer address
            UEP12_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 12 DMA buffer address
                UEP12_TX_DMA: u16,
            }),
            reserved140: [2]u8,
            ///  endpoint 13 DMA TX buffer address
            UEP13_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 13 DMA buffer address
                UEP13_TX_DMA: u16,
            }),
            reserved144: [2]u8,
            ///  endpoint 14 DMA TX buffer address
            UEP14_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 14 DMA buffer address
                UEP14_TX_DMA: u16,
            }),
            reserved148: [2]u8,
            ///  endpoint 15 DMA TX buffer address
            UEP15_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 15 DMA buffer address
                UEP15_TX_DMA: u16,
            }),
            reserved152: [2]u8,
            ///  endpoint 0 max acceptable length
            UEP0_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 0 max acceptable length
                UEP0_MAX_LEN: u11,
                padding: u5,
            }),
            reserved156: [2]u8,
            ///  endpoint 1 max acceptable length
            UEP1_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 1 max acceptable length
                UEP1_MAX_LEN: u11,
                padding: u5,
            }),
            reserved160: [2]u8,
            ///  endpoint 2 max acceptable length
            UEP2_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 2 max acceptable length
                UEP2_MAX_LEN: u11,
                padding: u5,
            }),
            reserved164: [2]u8,
            ///  endpoint 3 MAX_LEN TX
            UEP3_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 3 max acceptable length
                UEP3_MAX_LEN: u11,
                padding: u5,
            }),
            reserved168: [2]u8,
            ///  endpoint 4 max acceptable length
            UEP4_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 4 max acceptable length
                UEP4_MAX_LEN: u11,
                padding: u5,
            }),
            reserved172: [2]u8,
            ///  endpoint 5 max acceptable length
            UEP5_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 5 max acceptable length
                UEP5_MAX_LEN: u11,
                padding: u5,
            }),
            reserved176: [2]u8,
            ///  endpoint 6 max acceptable length
            UEP6_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 6 max acceptable length
                UEP6_MAX_LEN: u11,
                padding: u5,
            }),
            reserved180: [2]u8,
            ///  endpoint 7 max acceptable length
            UEP7_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 7 max acceptable length
                UEP7_MAX_LEN: u11,
                padding: u5,
            }),
            reserved184: [2]u8,
            ///  endpoint 8 max acceptable length
            UEP8_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 8 max acceptable length
                UEP8_MAX_LEN: u11,
                padding: u5,
            }),
            reserved188: [2]u8,
            ///  endpoint 9 max acceptable length
            UEP9_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 9 max acceptable length
                UEP9_MAX_LEN: u11,
                padding: u5,
            }),
            reserved192: [2]u8,
            ///  endpoint 10 max acceptable length
            UEP10_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 10 max acceptable length
                UEP10_MAX_LEN: u11,
                padding: u5,
            }),
            reserved196: [2]u8,
            ///  endpoint 11 max acceptable length
            UEP11_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 11 max acceptable length
                UEP11_MAX_LEN: u11,
                padding: u5,
            }),
            reserved200: [2]u8,
            ///  endpoint 12 max acceptable length
            UEP12_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 12 max acceptable length
                UEP12_MAX_LEN: u11,
                padding: u5,
            }),
            reserved204: [2]u8,
            ///  endpoint 13 max acceptable length
            UEP13_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 13 max acceptable length
                UEP13_MAX_LEN: u11,
                padding: u5,
            }),
            reserved208: [2]u8,
            ///  endpoint 14 max acceptable length
            UEP14_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 14 max acceptable length
                UEP14_MAX_LEN: u11,
                padding: u5,
            }),
            reserved212: [2]u8,
            ///  endpoint 15 max acceptable length
            UEP15_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 15 max acceptable length
                UEP15_MAX_LEN: u11,
                padding: u5,
            }),
            reserved216: [2]u8,
            ///  endpoint 0 send the length
            UEP0_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 0 send the length
                UEP0_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 0 send control
            UEP0_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 0 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 0 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 0 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 0 send control
            UEP0_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 0 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 0 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 0 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 1 send the length
            UEP1_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 1 send the length
                UEP1_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 1 send control
            UEP1_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 1 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 1 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 1 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 1 send control
            UEP1_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 1 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 1 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 1 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 2 send the length
            UEP2_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 2 send the length
                UEP2_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 2 send control
            UEP2_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 2 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 2 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 2 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 2 send control
            UEP2_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 2 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 2 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 2 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 3 send the length
            UEP3_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 3 send the length
                UEP3_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 3 send control
            UEP3_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 3 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 3 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 3 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 3 send control
            UEP3_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 3 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 3 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 3 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 4 send the length
            UEP4_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 0 send the length
                UEP4_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 4 send control
            UEP4_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 4 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 4 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 4 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 4 send control
            UEP4_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 4 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 4 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 4 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 5 send the length
            UEP5_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 5 send the length
                UEP5_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 5 send control
            UEP5_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 5 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 5 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 5 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 5 send control
            UEP5_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 5 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 5 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 5 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 6 send the length
            UEP6_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 6 send the length
                UEP6_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 6 send control
            UEP6_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 6 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 6 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 6 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 6 send control
            UEP6_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 6 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 6 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 6 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 7 send the length
            UEP7_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 7 send the length
                UEP7_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 7 send control
            UEP7_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 7 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 7 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 7 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 7 send control
            UEP7_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 7 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 7 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 7 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 8 send the length
            UEP8_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 8 send the length
                UEP8_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 8 send control
            UEP8_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 8 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 8 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 8 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 8 send control
            UEP8_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 8 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 8 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 8 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint9 send the length
            UEP9_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 9 send the length
                UEP9_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 9 send control
            UEP9_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 9 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 9 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 9 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 9 send control
            UEP9_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 9 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 9 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 9 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 10 send the length
            UEP10_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 10 send the length
                UEP10_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 10 send control
            UEP10_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 10 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 10 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 10 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 10 send control
            UEP10_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 10 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 10 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 10 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 11 send the length
            UEP11_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 11 send the length
                UEP0_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 11 send control
            UEP11_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 11 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 11 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 11 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 11 send control
            UEP11_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 11 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 11 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 11 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 12 send the length
            UEP12_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 12 send the length
                UEP0_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 12 send control
            UEP12_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 12 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 12 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 12 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 12 send control
            UEP12_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 12 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 12 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 12 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 13 send the length
            UEP13_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 13 send the length
                UEP13_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 13 send control
            UEP13_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 13 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 13 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 13 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 13 send control
            UEP13_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 13 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 13 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 13 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 14 send the length
            UEP14_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 14 send the length
                UEP14_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 14 send control
            UEP14_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 14 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 14 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 14 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 14 send control
            UEP14_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 14 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 14 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 14 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 15 send the length
            UEP15_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 15 send the length
                UEP0_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 15 send control
            UEP15_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 15 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 15 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 15 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 15 send control
            UEP15_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 15 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 15 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 15 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
        };

        pub const USBHD_HOST = extern struct {
            ///  USB base control
            USB_CTRL: mmio.Mmio(packed struct(u8) {
                ///  DMA enable and DMA interrupt enable for USB
                RB_UC_DMA_EN: u1,
                ///  force clear FIFO and count of USB
                RB_UC_CLR_ALL: u1,
                ///  force reset USB SIE, need software clear
                RB_UC_RESET_SIE: u1,
                ///  enable automatic responding busy for device mode or automatic pause for host mode during interrupt flag UIF_TRANSFER valid
                RB_UC_INT_BUSY: u1,
                ///  USB device enable and internal pullup resistance enable
                RB_UC_DEV_PU_EN: u1,
                ///  enable USB low speed: 00=full speed, 01=high speed, 10 =low speed
                RB_UC_SPEED_TYPE: u2,
                ///  enable USB host mode: 0=device mode, 1=host mode
                RB_UC_HOST_MODE: u1,
            }),
            ///  USB HOST control
            UHOST_CTRL: mmio.Mmio(packed struct(u8) {
                ///  USB host bus reset status
                bUH_TX_BUS_RESET: u1,
                ///  the host sends hang sigal
                bUH_TX_BUS_SUSPEND: u1,
                ///  host wake up device
                bUH_TX_BUS_RESUME: u1,
                ///  the remoke wake-up
                bUH_REMOTE_WKUP: u1,
                ///  USB-PHY thesuspended state the internal USB-PLL is turned off
                bUH_PHY_SUSPENDM: u1,
                reserved6: u1,
                ///  the bus is idle
                bUH_SOF_FREE: u1,
                ///  automatically generate the SOF packet enabling control bit
                bUH_SOF_EN: u1,
            }),
            ///  USB interrupt enable
            USB_INT_EN: mmio.Mmio(packed struct(u8) {
                ///  enable interrupt for USB bus reset event for USB device mode;enable interrupt for USB device detected event for USB host mode
                RB_UIE_BUS_RST__RB_UIE_DETECT: u1,
                ///  enable interrupt for USB transfer completion
                RB_UIE_TRANSFER: u1,
                ///  enable interrupt for USB suspend or resume event
                RB_UIE_SUSPEND: u1,
                ///  indicate host SOF timer action status for USB host
                RB_UIE_SOF_ACT: u1,
                ///  enable interrupt for FIFO overflow
                RB_UIE_FIFO_OV: u1,
                ///  indicate host SETUP timer action status for USB host
                RB_UIE_SETUP_ACT: u1,
                ///  enable interrupt for NAK responded for USB device mode
                RB_UIE_ISO_ACT: u1,
                ///  enable interrupt for NAK responded for USB device mode
                RB_UIE_DEV_NAK: u1,
            }),
            ///  USB device address
            USB_DEV_AD: mmio.Mmio(packed struct(u8) {
                ///  bit mask for USB device address
                MASK_USB_ADDR: u7,
                ///  general purpose bit
                RB_UDA_GP_BIT: u1,
            }),
            ///  USB_FRAME_NO
            USB_FRAME_NO: mmio.Mmio(packed struct(u16) {
                ///  USB_FRAME_NO
                USB_FRAME_NO: u16,
            }),
            ///  indicate USB suspend status
            USB_USB_SUSPEND: mmio.Mmio(packed struct(u8) {
                ///  USB_SYS_MOD
                USB_SYS_MOD: u2,
                ///  remote resume
                USB_WAKEUP: u1,
                reserved4: u1,
                ///  USB_LINESTATE
                USB_LINESTATE: u2,
                padding: u2,
            }),
            reserved8: [1]u8,
            ///  USB_SPEED_TYPE
            USB_SPEED_TYPE: mmio.Mmio(packed struct(u8) {
                ///  USB_SPEED_TYPE
                USB_SPEED_TYPE: u2,
                padding: u6,
            }),
            ///  USB miscellaneous status
            USB_MIS_ST: mmio.Mmio(packed struct(u8) {
                ///  RO, indicate device attached status on USB host
                RB_UMS_SPLIT_CAN: u1,
                ///  RO, indicate UDM level saved at device attached to USB host
                RB_UMS_ATTACH: u1,
                ///  RO, indicate USB suspend status
                RB_UMS_SUSPEND: u1,
                ///  RO, indicate USB bus reset status
                RB_UMS_BUS_RESET: u1,
                ///  RO, indicate USB receiving FIFO ready status (not empty)
                RB_UMS_R_FIFO_RDY: u1,
                ///  RO, indicate USB SIE free status
                RB_UMS_SIE_FREE: u1,
                ///  RO, indicate host SOF timer action status for USB host
                RB_UMS_SOF_ACT: u1,
                ///  RO, indicate host SOF timer presage status
                RB_UMS_SOF_PRES: u1,
            }),
            ///  USB interrupt flag
            USB_INT_FG: mmio.Mmio(packed struct(u8) {
                ///  RB_UIF_BUS_RST
                RB_UIF_BUS_RST: u1,
                ///  USB transfer completion interrupt flag, direct bit address clear or write 1 to clear
                RB_UIF_TRANSFER: u1,
                ///  USB suspend or resume event interrupt flag, direct bit address clear or write 1 to clear
                RB_UIF_SUSPEND: u1,
                ///  host SOF timer interrupt flag for USB host, direct bit address clear or write 1 to clear
                RB_UIF_HST_SOF: u1,
                ///  FIFO overflow interrupt flag for USB, direct bit address clear or write 1 to clear
                RB_UIF_FIFO_OV: u1,
                ///  USB_SETUP_ACT
                RB_U_SETUP_ACT: u1,
                ///  UIF_ISO_ACT
                UIF_ISO_ACT: u1,
                ///  RO, indicate current USB transfer is NAK received
                RB_U_IS_NAK: u1,
            }),
            ///  USB interrupt status
            USB_INT_ST: mmio.Mmio(packed struct(u8) {
                ///  RO, bit mask of current transfer handshake response for USB host mode: 0000=no response, time out from device, others=handshake response PID received;RO, bit mask of current transfer endpoint number for USB device mode
                MASK_UIS_H_RES__MASK_UIS_ENDP: u4,
                ///  RO, bit mask of current token PID code received for USB device mode
                MASK_UIS_TOKEN: u2,
                ///  RO, indicate current USB transfer toggle is OK
                RB_UIS_TOG_OK: u1,
                ///  RO, indicate current USB transfer is NAK received for USB device mode
                RB_UIS_IS_NAK: u1,
            }),
            ///  USB receiving length
            USB_RX_LEN: mmio.Mmio(packed struct(u16) {
                ///  length of received bytes
                R16_USB_RX_LEN: u16,
            }),
            reserved16: [2]u8,
            ///  USB endpoint configuration
            UEP_CONFIG: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  endpoint TX enable/bUH_TX_EN
                bUEP_T_EN_bUH_TX_EN: u15,
                reserved17: u1,
                ///  endpoint RX enable/bUH_TX_EN
                bUEP_R_EN__UH_EP_MOD: u15,
            }),
            ///  USB endpoint type
            UEP_TYPE: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  endpoint TX type
                bUEP_T_TYPE: u15,
                reserved17: u1,
                ///  endpoint RX type
                bUEP_R_TYPE: u15,
            }),
            ///  USB endpoint buffer mode
            UEP_BUF_MOD: mmio.Mmio(packed struct(u32) {
                ///  buffer mode of USB endpoint
                bUEP_BUF_MOD: u16,
                ///  buffer mode of USB endpoint
                bUEP_ISO_BUF_MOD: u16,
            }),
            ///  USB endpoint 0 DMA buffer address
            UEP0_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 0 DMA buffer address
                UEP0_DMA: u16,
            }),
            reserved32: [2]u8,
            ///  endpoint 1 DMA RX buffer address
            UEP1_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 1 DMA buffer address
                UEP1_RX_DMA: u16,
            }),
            reserved36: [2]u8,
            ///  endpoint 2 DMA RX buffer address/UH_RX_DMA
            UEP2_RX_DMA__UH_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 2 DMA buffer address
                UEP2_RX_DMA__UH_RX_DMA: u16,
            }),
            reserved40: [2]u8,
            ///  endpoint 3 DMA RX buffer address
            UEP3_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 3 DMA buffer address
                UEP3_RX_DMA: u16,
            }),
            reserved44: [2]u8,
            ///  endpoint 4 DMA RX buffer address
            UEP4_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 4 DMA buffer address
                UEP4_RX_DMA: u16,
            }),
            reserved48: [2]u8,
            ///  endpoint 5 DMA RX buffer address
            UEP5_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 5 DMA buffer address
                UEP5_DMA: u16,
            }),
            reserved52: [2]u8,
            ///  endpoint 6 DMA RX buffer address
            UEP6_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 6 DMA buffer address
                UEP6_RX_DMA: u16,
            }),
            reserved56: [2]u8,
            ///  endpoint 7 DMA RX buffer address
            UEP7_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 7 DMA buffer address
                UEP7_RX_DMA: u16,
            }),
            reserved60: [2]u8,
            ///  endpoint 8 DMA RX buffer address
            UEP8_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 8 DMA buffer address
                UEP8_RX_DMA: u16,
            }),
            reserved64: [2]u8,
            ///  endpoint 9 DMA RX buffer address
            UEP9_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 9 DMA buffer address
                UEP9_RX_DMA: u16,
            }),
            reserved68: [2]u8,
            ///  endpoint 10 DMA RX buffer address
            UEP10_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 10 DMA buffer address
                UEP10_RX_DMA: u16,
            }),
            reserved72: [2]u8,
            ///  endpoint 11 DMA RX buffer address
            UEP11_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 11 DMA buffer address
                UEP11_RX_DMA: u16,
            }),
            reserved76: [2]u8,
            ///  endpoint 12 DMA RX buffer address
            UEP12_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 12 DMA buffer address
                UEP12_RX_DMA: u16,
            }),
            reserved80: [2]u8,
            ///  endpoint 13 DMA RX buffer address
            UEP13_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 13 DMA buffer address
                UEP13_RX_DMA: u16,
            }),
            reserved84: [2]u8,
            ///  endpoint 14 DMA RX buffer address
            UEP14_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 14 DMA buffer address
                UEP14_RX_DMA: u16,
            }),
            reserved88: [2]u8,
            ///  endpoint 15 DMA RX buffer address
            UEP15_RX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 15 DMA buffer address
                UEP15_RX_DMA: u16,
            }),
            reserved92: [2]u8,
            ///  endpoint 1 DMA TX buffer address
            UEP1_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 1 DMA buffer address
                UEP1_TX_DMA: u16,
            }),
            reserved96: [2]u8,
            ///  endpoint 2 DMA TX buffer address
            UEP2_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 2 DMA buffer address
                UEP2_TX_DMA: u16,
            }),
            reserved100: [2]u8,
            ///  endpoint 3 DMA TX buffer address
            UEP3_TX_DMA__UH_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 3 DMA buffer address
                UEP3_TX_DMA__UH_TX_DMA: u16,
            }),
            reserved104: [2]u8,
            ///  endpoint 4 DMA TX buffer address
            UEP4_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 4 DMA buffer address
                UEP4_TX_DMA: u16,
            }),
            reserved108: [2]u8,
            ///  endpoint 5 DMA TX buffer address
            UEP5_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 5 DMA buffer address
                UEP5_TX_DMA: u16,
            }),
            reserved112: [2]u8,
            ///  endpoint 6 DMA TX buffer address
            UEP6_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 6 DMA buffer address
                UEP6_TX_DMA: u16,
            }),
            reserved116: [2]u8,
            ///  endpoint 7 DMA TX buffer address
            UEP7_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 7 DMA buffer address
                UEP7_TX_DMA: u16,
            }),
            reserved120: [2]u8,
            ///  endpoint 8 DMA TX buffer address
            UEP8_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 8 DMA buffer address
                UEP8_TX_DMA: u16,
            }),
            reserved124: [2]u8,
            ///  endpoint 9 DMA TX buffer address
            UEP9_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 9 DMA buffer address
                UEP9_TX_DMA: u16,
            }),
            reserved128: [2]u8,
            ///  endpoint 10 DMA TX buffer address
            UEP10_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 10 DMA buffer address
                UEP10_TX_DMA: u16,
            }),
            reserved132: [2]u8,
            ///  endpoint 11 DMA TX buffer address
            UEP11_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 11 DMA buffer address
                UEP11_TX_DMA: u16,
            }),
            reserved136: [2]u8,
            ///  endpoint 12 DMA TX buffer address
            UEP12_TX_DMA____UH_SPLIT_DATA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 12 DMA buffer address
                UEP12_TX_DMA___UH_SPLIT_DATA: u16,
            }),
            reserved140: [2]u8,
            ///  endpoint 13 DMA TX buffer address
            UEP13_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 13 DMA buffer address
                UEP13_TX_DMA: u16,
            }),
            reserved144: [2]u8,
            ///  endpoint 14 DMA TX buffer address
            UEP14_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 14 DMA buffer address
                UEP14_TX_DMA: u16,
            }),
            reserved148: [2]u8,
            ///  endpoint 15 DMA TX buffer address
            UEP15_TX_DMA: mmio.Mmio(packed struct(u16) {
                ///  endpoint 15 DMA buffer address
                UEP15_TX_DMA: u16,
            }),
            reserved152: [2]u8,
            ///  endpoint 0 max acceptable length
            UEP0_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 0 max acceptable length
                UEP0_MAX_LEN: u11,
                padding: u5,
            }),
            reserved156: [2]u8,
            ///  endpoint 1 max acceptable length
            UEP1_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 1 max acceptable length
                UEP1_MAX_LEN: u11,
                padding: u5,
            }),
            reserved160: [2]u8,
            ///  endpoint 2 max acceptable length
            UEP2_MAX_LEN__UH_RX_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 2 max acceptable length
                UEP2_MAX_LEN__UH_RX_MAX_LEN: u11,
                padding: u5,
            }),
            reserved164: [2]u8,
            ///  endpoint 3 MAX_LEN TX
            UEP3_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 3 max acceptable length
                UEP3_MAX_LEN: u11,
                padding: u5,
            }),
            reserved168: [2]u8,
            ///  endpoint 4 max acceptable length
            UEP4_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 4 max acceptable length
                UEP4_MAX_LEN: u11,
                padding: u5,
            }),
            reserved172: [2]u8,
            ///  endpoint 5 max acceptable length
            UEP5_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 5 max acceptable length
                UEP5_MAX_LEN: u11,
                padding: u5,
            }),
            reserved176: [2]u8,
            ///  endpoint 6 max acceptable length
            UEP6_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 6 max acceptable length
                UEP6_MAX_LEN: u11,
                padding: u5,
            }),
            reserved180: [2]u8,
            ///  endpoint 7 max acceptable length
            UEP7_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 7 max acceptable length
                UEP7_MAX_LEN: u11,
                padding: u5,
            }),
            reserved184: [2]u8,
            ///  endpoint 8 max acceptable length
            UEP8_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 8 max acceptable length
                UEP8_MAX_LEN: u11,
                padding: u5,
            }),
            reserved188: [2]u8,
            ///  endpoint 9 max acceptable length
            UEP9_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 9 max acceptable length
                UEP9_MAX_LEN: u11,
                padding: u5,
            }),
            reserved192: [2]u8,
            ///  endpoint 10 max acceptable length
            UEP10_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 10 max acceptable length
                UEP10_MAX_LEN: u11,
                padding: u5,
            }),
            reserved196: [2]u8,
            ///  endpoint 11 max acceptable length
            UEP11_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 11 max acceptable length
                UEP11_MAX_LEN: u11,
                padding: u5,
            }),
            reserved200: [2]u8,
            ///  endpoint 12 max acceptable length
            UEP12_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 12 max acceptable length
                UEP12_MAX_LEN: u11,
                padding: u5,
            }),
            reserved204: [2]u8,
            ///  endpoint 13 max acceptable length
            UEP13_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 13 max acceptable length
                UEP13_MAX_LEN: u11,
                padding: u5,
            }),
            reserved208: [2]u8,
            ///  endpoint 14 max acceptable length
            UEP14_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 14 max acceptable length
                UEP14_MAX_LEN: u11,
                padding: u5,
            }),
            reserved212: [2]u8,
            ///  endpoint 15 max acceptable length
            UEP15_MAX_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 15 max acceptable length
                UEP15_MAX_LEN: u11,
                padding: u5,
            }),
            reserved216: [2]u8,
            ///  endpoint 0 send the length
            UEP0_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 0 send the length
                UEP0_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 0 send control
            UEP0_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 0 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 0 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 0 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 0 send control
            UEP0_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 0 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 0 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 0 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 1 send the length
            UEP1_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 1 send the length
                UEP1_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 1 send control
            UEP1_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 1 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 1 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 1 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 1 send control
            UEP1_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 1 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 1 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 1 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 2 send the length
            UEP2_T_LEN__UH_EP_PID: mmio.Mmio(packed struct(u16) {
                ///  endpoint 2 send the length
                UEP2_T_LEN__MASK_UH_ENDP__MASK_UH_TOKEN: u11,
                padding: u5,
            }),
            ///  endpoint 2 send control
            UEP2_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 2 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 2 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 2 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 2 send control
            UEP2_R_CTRL__UH_RX_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 2 control of the accept response to OUT transactions
                MASK_UEP_R_RES__MASK_UH_R_RES: u2,
                ///  bUH_R_RES_NO
                bUH_R_RES_NO: u1,
                ///  endpoint 2 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG__MASK_UH_R_TOG: u2,
                ///  endpoint 2 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO__bUH_R_AUTO_TOG: u1,
                ///  bUH_R_DATA_NO
                bUH_R_DATA_NO: u1,
                padding: u1,
            }),
            ///  endpoint 3 send the length
            UEP3_T_LEN___UH_TX_LEN_H: mmio.Mmio(packed struct(u16) {
                ///  endpoint 3 send the length
                UEP3_T_LEN___UH_TX_LEN_H: u11,
                padding: u5,
            }),
            ///  endpoint 3 send control
            UEP3_T_CTRL___UH_TX_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 3 control of the send response to IN transactions
                MASK_UEP_T_RES_____MASK_UH_T_RES: u2,
                ///  bUH_T_RES_NO
                bUH_T_RES_NO: u1,
                ///  endpoint 3 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG____MASK_UH_T_TOG: u2,
                ///  endpoint 3 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO____bUH_T_AUTO_TOG: u1,
                ///  bUH_T_DATA_NO
                bUH_T_DATA_NO: u1,
                padding: u1,
            }),
            ///  endpoint 3 send control
            UEP3_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 3 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 3 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 3 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 4 send the length
            UEP4_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 0 send the length
                UEP4_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 4 send control
            UEP4_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 4 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 4 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 4 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 4 send control
            UEP4_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 4 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 4 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 4 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 5 send the length
            UEP5_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 5 send the length
                UEP5_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 5 send control
            UEP5_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 5 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 5 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 5 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 5 send control
            UEP5_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 5 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 5 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 5 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 6 send the length
            UEP6_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 6 send the length
                UEP6_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 6 send control
            UEP6_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 6 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 6 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 6 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 6 send control
            UEP6_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 6 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 6 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 6 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 7 send the length
            UEP7_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 7 send the length
                UEP7_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 7 send control
            UEP7_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 7 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 7 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 7 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 7 send control
            UEP7_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 7 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 7 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 7 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 8 send the length
            UEP8_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 8 send the length
                UEP8_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 8 send control
            UEP8_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 8 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 8 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 8 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 8 send control
            UEP8_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 8 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 8 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 8 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint9 send the length
            UEP9_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 9 send the length
                UEP9_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 9 send control
            UEP9_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 9 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 9 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 9 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 9 send control
            UEP9_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 9 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 9 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 9 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 10 send the length
            UEP10_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 10 send the length
                UEP10_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 10 send control
            UEP10_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 10 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 10 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 10 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 10 send control
            UEP10_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 10 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 10 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 10 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 11 send the length
            UEP11_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 11 send the length
                UEP0_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 11 send control
            UEP11_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 11 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 11 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 11 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 11 send control
            UEP11_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 11 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 11 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 11 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 12 send the length
            UEP12_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 12 send the length
                UEP0_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 12 send control
            UEP12_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 12 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 12 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 12 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 12 send control
            UEP12_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 12 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 12 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 12 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 13 send the length
            UEP13_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 13 send the length
                UEP13_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 13 send control
            UEP13_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 13 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 13 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 13 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 13 send control
            UEP13_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 13 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 13 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 13 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 14 send the length
            UEP14_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 14 send the length
                UEP14_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 14 send control
            UEP14_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 14 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 14 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 14 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 14 send control
            UEP14_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 14 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 14 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 14 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 15 send the length
            UEP15_T_LEN: mmio.Mmio(packed struct(u16) {
                ///  endpoint 15 send the length
                UEP0_T_LEN: u11,
                padding: u5,
            }),
            ///  endpoint 15 send control
            UEP15_T_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 15 control of the send response to IN transactions
                MASK_UEP_T_RES: u2,
                reserved3: u1,
                ///  endpoint 15 synchronous trigger bit for the sender to prepare
                MASK_UEP_T_TOG: u2,
                ///  endpoint 15 synchronous trigger bit automatic filp enables the control bit
                bUEP_T_TOG_AUTO: u1,
                padding: u2,
            }),
            ///  endpoint 15 send control
            UEP15_R_CTRL: mmio.Mmio(packed struct(u8) {
                ///  endpoint 15 control of the accept response to OUT transactions
                MASK_UEP_R_RES: u2,
                reserved3: u1,
                ///  endpoint 15 synchronous trigger bit for the accept to prepare
                MASK_UEP_R_TOG: u2,
                ///  endpoint 15 synchronous trigger bit automatic filp enables the control bit
                bUEP_R_TOG_AUTO: u1,
                padding: u2,
            }),
        };

        ///  Debug support
        pub const DBG = extern struct {
            ///  DBGMCU_CFGR1
            CFGR1: mmio.Mmio(packed struct(u32) {
                ///  DEG_IWDG
                DEG_IWDG: u1,
                ///  DEG_WWDG
                DEG_WWDG: u1,
                ///  DEG_I2C1
                DEG_I2C1: u1,
                ///  DEG_I2C2
                DEG_I2C2: u1,
                ///  DEG_TIM1
                DEG_TIM1: u1,
                ///  DEG_TIM2
                DEG_TIM2: u1,
                ///  DEG_TIM3
                DEG_TIM3: u1,
                ///  DEG_TIM4
                DEG_TIM4: u1,
                padding: u24,
            }),
            ///  DBGMCU_CFGR2
            CFGR2: mmio.Mmio(packed struct(u32) {
                ///  DBG_SLEEP
                DBG_SLEEP: u1,
                ///  DBG_STOP
                DBG_STOP: u1,
                ///  DBG_STANDBY
                DBG_STANDBY: u1,
                padding: u29,
            }),
        };

        ///  Analog to digital converter
        pub const ADC2 = extern struct {
            ///  status register
            STATR: mmio.Mmio(packed struct(u32) {
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
            ///  control register 1/TKEY_V_CTLR
            CTLR1: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog channel select bits
                AWDCH: u5,
                ///  Interrupt enable for EOC
                EOCIE: u1,
                ///  Analog watchdog interrupt enable
                AWDIE: u1,
                ///  Interrupt enable for injected channels
                JEOCIE: u1,
                ///  Scan mode enable
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
                ///  TKEY enable, including TKEY_F and TKEY_V
                TKEYEN: u1,
                ///  TKEY_I enable
                TKITUNE: u1,
                ///  TKEY_BUF_Enable
                BUFEN: u1,
                ///  ADC_PGA
                PGA: u2,
                padding: u3,
            }),
            ///  control register 2
            CTLR2: mmio.Mmio(packed struct(u32) {
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
            SAMPTR1_CHARGE1: mmio.Mmio(packed struct(u32) {
                ///  Channel 10 sample time selection
                SMP10_TKCG10: u3,
                ///  Channel 11 sample time selection
                SMP11_TKCG11: u3,
                ///  Channel 12 sample time selection
                SMP12_TKCG12: u3,
                ///  Channel 13 sample time selection
                SMP13_TKCG13: u3,
                ///  Channel 14 sample time selection
                SMP14_TKCG14: u3,
                ///  Channel 15 sample time selection
                SMP15_TKCG15: u3,
                ///  Channel 16 sample time selection
                SMP16_TKCG16: u3,
                ///  Channel 17 sample time selection
                SMP17_TKCG17: u3,
                padding: u8,
            }),
            ///  sample time register 2
            SAMPTR2_CHARGE2: mmio.Mmio(packed struct(u32) {
                ///  Channel 0 sample time selection
                SMP0_TKCG0: u3,
                ///  Channel 1 sample time selection
                SMP1_TKCG1: u3,
                ///  Channel 2 sample time selection
                SMP2_TKCG2: u3,
                ///  Channel 3 sample time selection
                SMP3_TKCG3: u3,
                ///  Channel 4 sample time selection
                SMP4_TKCG4: u3,
                ///  Channel 5 sample time selection
                SMP5_TKCG5: u3,
                ///  Channel 6 sample time selection
                SMP6_TKCG6: u3,
                ///  Channel 7 sample time selection
                SMP7_TKCG7: u3,
                ///  Channel 8 sample time selection
                SMP8_TKCG8: u3,
                ///  Channel 9 sample time selection
                SMP9_TKCG9: u3,
                padding: u2,
            }),
            ///  injected channel data offset register x
            IOFR1: mmio.Mmio(packed struct(u32) {
                ///  Data offset for injected channel x
                JOFFSET1: u12,
                padding: u20,
            }),
            ///  injected channel data offset register x
            IOFR2: mmio.Mmio(packed struct(u32) {
                ///  Data offset for injected channel x
                JOFFSET2: u12,
                padding: u20,
            }),
            ///  injected channel data offset register x
            IOFR3: mmio.Mmio(packed struct(u32) {
                ///  Data offset for injected channel x
                JOFFSET3: u12,
                padding: u20,
            }),
            ///  injected channel data offset register x
            IOFR4: mmio.Mmio(packed struct(u32) {
                ///  Data offset for injected channel x
                JOFFSET4: u12,
                padding: u20,
            }),
            ///  watchdog higher threshold register
            WDHTR: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog higher threshold
                HT: u12,
                padding: u20,
            }),
            ///  watchdog lower threshold register
            WDLTR: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog lower threshold
                LT: u12,
                padding: u20,
            }),
            ///  regular sequence register 1
            RSQR1: mmio.Mmio(packed struct(u32) {
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
            RSQR2: mmio.Mmio(packed struct(u32) {
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
            ///  regular sequence register 3;TKEY_V_CHANNEL
            RSQR3__CHANNEL: mmio.Mmio(packed struct(u32) {
                ///  1st conversion in regular sequence;TKDY_V channel select
                SQ1__CHSEL: u5,
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
            ISQR: mmio.Mmio(packed struct(u32) {
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
            ///  injected data register x_Charge data offset for injected channel x
            IDATAR1_CHGOFFSET: mmio.Mmio(packed struct(u32) {
                ///  Injected data_Touch key charge data offset for injected channel x
                IDATA0_7_TKCGOFFSET: u8,
                ///  Injected data
                IDATA8_15: u8,
                padding: u16,
            }),
            ///  injected data register x
            IDATAR2: mmio.Mmio(packed struct(u32) {
                ///  Injected data
                JDATA: u16,
                padding: u16,
            }),
            ///  injected data register x
            IDATAR3: mmio.Mmio(packed struct(u32) {
                ///  Injected data
                JDATA: u16,
                padding: u16,
            }),
            ///  injected data register x
            IDATAR4: mmio.Mmio(packed struct(u32) {
                ///  Injected data
                JDATA: u16,
                padding: u16,
            }),
            ///  regular data register_start and discharge time register
            RDATAR_DR_ACT_DCG: mmio.Mmio(packed struct(u32) {
                ///  Regular data_Touch key start and discharge time register
                DATA0_7_TKACT_DCG: u8,
                ///  Regular data
                DATA8_15: u8,
                padding: u16,
            }),
        };

        ///  General purpose timer
        pub const TIM2 = extern struct {
            ///  control register 1
            CTLR1: mmio.Mmio(packed struct(u32) {
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
            CTLR2: mmio.Mmio(packed struct(u32) {
                ///  Compare selection
                CCPC: u1,
                reserved2: u1,
                ///  Update selection
                CCUS: u1,
                ///  Capture/compare DMA selection
                CCDS: u1,
                ///  Master mode selection
                MMS: u3,
                ///  TI1 selection
                TI1S: u1,
                padding: u24,
            }),
            ///  slave mode control register
            SMCFGR: mmio.Mmio(packed struct(u32) {
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
            DMAINTENR: mmio.Mmio(packed struct(u32) {
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
                ///  COM DMA request enable
                COMDE: u1,
                ///  Trigger DMA request enable
                TDE: u1,
                padding: u17,
            }),
            ///  status register
            INTFR: mmio.Mmio(packed struct(u32) {
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
            SWEVGR: mmio.Mmio(packed struct(u32) {
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
                ///  Capture/compare generation
                COMG: u1,
                ///  Trigger generation
                TG: u1,
                ///  Brake generation
                BG: u1,
                padding: u24,
            }),
            ///  capture/compare mode register 1 (output mode)
            CHCTLR1_Output: mmio.Mmio(packed struct(u32) {
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
            CHCTLR2_Output: mmio.Mmio(packed struct(u32) {
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
            ATRLR: mmio.Mmio(packed struct(u32) {
                ///  Auto-reload value
                ATRLR: u16,
                padding: u16,
            }),
            reserved52: [4]u8,
            ///  capture/compare register 1
            CH1CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare 1 value
                CH1CVR: u16,
                padding: u16,
            }),
            ///  capture/compare register 2
            CH2CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare 2 value
                CH2CVR: u16,
                padding: u16,
            }),
            ///  capture/compare register 3
            CH3CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare value
                CH3CVR: u16,
                padding: u16,
            }),
            ///  capture/compare register 4
            CH4CVR: mmio.Mmio(packed struct(u32) {
                ///  Capture/Compare value
                CH4CVR: u16,
                padding: u16,
            }),
            reserved72: [4]u8,
            ///  DMA control register
            DMACFGR: mmio.Mmio(packed struct(u32) {
                ///  DMA base address
                DBA: u5,
                reserved8: u3,
                ///  DMA burst length
                DBL: u5,
                padding: u19,
            }),
            ///  DMA address for full transfer
            DMAADR: mmio.Mmio(packed struct(u32) {
                ///  DMA register for burst accesses
                DMAADR: u16,
                padding: u16,
            }),
        };

        ///  Analog to digital converter
        pub const ADC1 = extern struct {
            ///  status register
            STATR: mmio.Mmio(packed struct(u32) {
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
            ///  control register 1/TKEY_V_CTLR
            CTLR1: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog channel select bits
                AWDCH: u5,
                ///  Interrupt enable for EOC
                EOCIE: u1,
                ///  Analog watchdog interrupt enable
                AWDIE: u1,
                ///  Interrupt enable for injected channels
                JEOCIE: u1,
                ///  Scan mode enable
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
                ///  TKEY enable, including TKEY_F and TKEY_V
                TKEYEN: u1,
                ///  TKEY_I enable
                TKITUNE: u1,
                ///  TKEY_BUF_Enable
                BUFEN: u1,
                ///  ADC_PGA
                PGA: u2,
                padding: u3,
            }),
            ///  control register 2
            CTLR2: mmio.Mmio(packed struct(u32) {
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
            SAMPTR1_CHARGE1: mmio.Mmio(packed struct(u32) {
                ///  Channel 10 sample time selection
                SMP10_TKCG10: u3,
                ///  Channel 11 sample time selection
                SMP11_TKCG11: u3,
                ///  Channel 12 sample time selection
                SMP12_TKCG12: u3,
                ///  Channel 13 sample time selection
                SMP13_TKCG13: u3,
                ///  Channel 14 sample time selection
                SMP14_TKCG14: u3,
                ///  Channel 15 sample time selection
                SMP15_TKCG15: u3,
                ///  Channel 16 sample time selection
                SMP16_TKCG16: u3,
                ///  Channel 17 sample time selection
                SMP17_TKCG17: u3,
                padding: u8,
            }),
            ///  sample time register 2
            SAMPTR2_CHARGE2: mmio.Mmio(packed struct(u32) {
                ///  Channel 0 sample time selection
                SMP0_TKCG0: u3,
                ///  Channel 1 sample time selection
                SMP1_TKCG1: u3,
                ///  Channel 2 sample time selection
                SMP2_TKCG2: u3,
                ///  Channel 3 sample time selection
                SMP3_TKCG3: u3,
                ///  Channel 4 sample time selection
                SMP4_TKCG4: u3,
                ///  Channel 5 sample time selection
                SMP5_TKCG5: u3,
                ///  Channel 6 sample time selection
                SMP6_TKCG6: u3,
                ///  Channel 7 sample time selection
                SMP7_TKCG7: u3,
                ///  Channel 8 sample time selection
                SMP8_TKCG8: u3,
                ///  Channel 9 sample time selection
                SMP9_TKCG9: u3,
                padding: u2,
            }),
            ///  injected channel data offset register x
            IOFR1: mmio.Mmio(packed struct(u32) {
                ///  Data offset for injected channel x
                JOFFSET1: u12,
                padding: u20,
            }),
            ///  injected channel data offset register x
            IOFR2: mmio.Mmio(packed struct(u32) {
                ///  Data offset for injected channel x
                JOFFSET2: u12,
                padding: u20,
            }),
            ///  injected channel data offset register x
            IOFR3: mmio.Mmio(packed struct(u32) {
                ///  Data offset for injected channel x
                JOFFSET3: u12,
                padding: u20,
            }),
            ///  injected channel data offset register x
            IOFR4: mmio.Mmio(packed struct(u32) {
                ///  Data offset for injected channel x
                JOFFSET4: u12,
                padding: u20,
            }),
            ///  watchdog higher threshold register
            WDHTR: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog higher threshold
                HT: u12,
                padding: u20,
            }),
            ///  watchdog lower threshold register
            WDLTR: mmio.Mmio(packed struct(u32) {
                ///  Analog watchdog lower threshold
                LT: u12,
                padding: u20,
            }),
            ///  regular sequence register 1
            RSQR1: mmio.Mmio(packed struct(u32) {
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
            RSQR2: mmio.Mmio(packed struct(u32) {
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
            ///  regular sequence register 3;TKEY_V_CHANNEL
            RSQR3__CHANNEL: mmio.Mmio(packed struct(u32) {
                ///  1st conversion in regular sequence;TKDY_V channel select
                SQ1__CHSEL: u5,
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
            ISQR: mmio.Mmio(packed struct(u32) {
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
            ///  injected data register x_Charge data offset for injected channel x
            IDATAR1_CHGOFFSET: mmio.Mmio(packed struct(u32) {
                ///  Injected data_Touch key charge data offset for injected channel x
                IDATA0_7_TKCGOFFSET: u8,
                ///  Injected data
                IDATA8_15: u8,
                padding: u16,
            }),
            ///  injected data register x
            IDATAR2: mmio.Mmio(packed struct(u32) {
                ///  Injected data
                JDATA: u16,
                padding: u16,
            }),
            ///  injected data register x
            IDATAR3: mmio.Mmio(packed struct(u32) {
                ///  Injected data
                JDATA: u16,
                padding: u16,
            }),
            ///  injected data register x
            IDATAR4: mmio.Mmio(packed struct(u32) {
                ///  Injected data
                JDATA: u16,
                padding: u16,
            }),
            ///  regular data register_start and discharge time register
            RDATAR_DR_ACT_DCG: mmio.Mmio(packed struct(u32) {
                ///  Regular data_Touch key start and discharge time register
                DATA0_7_TKACT_DCG: u8,
                ///  Regular data
                DATA8_15: u8,
                padding: u16,
            }),
        };

        ///  Serial peripheral interface
        pub const SPI1 = extern struct {
            ///  control register 1
            CTLR1: mmio.Mmio(packed struct(u32) {
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
            CTLR2: mmio.Mmio(packed struct(u32) {
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
            STATR: mmio.Mmio(packed struct(u32) {
                ///  Receive buffer not empty
                RXNE: u1,
                ///  Transmit buffer empty
                TXE: u1,
                ///  Channel side
                CHSID: u1,
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
            DATAR: mmio.Mmio(packed struct(u32) {
                ///  Data register
                DATAR: u16,
                padding: u16,
            }),
            ///  CRCR polynomial register
            CRCR: mmio.Mmio(packed struct(u32) {
                ///  CRC polynomial register
                CRCPOLY: u16,
                padding: u16,
            }),
            ///  RX CRC register
            RCRCR: mmio.Mmio(packed struct(u32) {
                ///  Rx CRC register
                RXCRC: u16,
                padding: u16,
            }),
            ///  send CRC register
            TCRCR: mmio.Mmio(packed struct(u32) {
                ///  Tx CRC register
                TXCRC: u16,
                padding: u16,
            }),
            ///  SPI_I2S configure register
            SPI_I2S_CFGR: mmio.Mmio(packed struct(u32) {
                ///  Channel length (number of bits per audio channel)
                CHLEN: u1,
                ///  DATLEN[1:0] bits (Data length to be transferred)
                DATLEN: u2,
                ///  steady state clock polarity
                CKPOL: u1,
                ///  I2SSTD[1:0] bits (I2S standard selection)
                I2SSTD: u2,
                reserved7: u1,
                ///  PCM frame synchronization
                PCMSYNC: u1,
                ///  I2SCFG[1:0] bits (I2S configuration mode)
                I2SCFG: u2,
                ///  I2S Enable
                I2SE: u1,
                ///  I2S mode selection
                I2SMOD: u1,
                padding: u20,
            }),
            reserved36: [4]u8,
            ///  high speed control register
            HSCR: mmio.Mmio(packed struct(u32) {
                ///  High speed mode read enable
                HSRXEN: u1,
                padding: u31,
            }),
        };

        ///  Serial peripheral interface
        pub const SPI2 = extern struct {
            ///  control register 1
            CTLR1: mmio.Mmio(packed struct(u32) {
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
            CTLR2: mmio.Mmio(packed struct(u32) {
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
            STATR: mmio.Mmio(packed struct(u32) {
                ///  Receive buffer not empty
                RXNE: u1,
                ///  Transmit buffer empty
                TXE: u1,
                reserved4: u2,
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
            DATAR: mmio.Mmio(packed struct(u32) {
                ///  Data register
                DATAR: u16,
                padding: u16,
            }),
            ///  CRCR polynomial register
            CRCR: mmio.Mmio(packed struct(u32) {
                ///  CRC polynomial register
                CRCPOLY: u16,
                padding: u16,
            }),
            ///  RX CRC register
            RCRCR: mmio.Mmio(packed struct(u32) {
                ///  Rx CRC register
                RXCRC: u16,
                padding: u16,
            }),
            ///  TX CRC register
            TCRCR: mmio.Mmio(packed struct(u32) {
                ///  Tx CRC register
                TXCRC: u16,
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
            ///  high speed control register
            HSCR: mmio.Mmio(packed struct(u32) {
                ///  High speed mode read enable
                HSRXEN: u1,
                padding: u31,
            }),
        };

        ///  Inter integrated circuit
        pub const I2C1 = extern struct {
            ///  Control register 1
            CTLR1: mmio.Mmio(packed struct(u32) {
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
            CTLR2: mmio.Mmio(packed struct(u32) {
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
            OADDR1: mmio.Mmio(packed struct(u32) {
                ///  Interface address
                ADD0: u1,
                ///  Interface address
                ADD7_1: u7,
                ///  Interface address
                ADD9_8: u2,
                reserved14: u4,
                ///  Must be 1
                MUST1: u1,
                ///  Addressing mode (slave mode)
                ADDMODE: u1,
                padding: u16,
            }),
            ///  Own address register 2
            OADDR2: mmio.Mmio(packed struct(u32) {
                ///  Dual addressing mode enable
                ENDUAL: u1,
                ///  Interface address
                ADD2: u7,
                padding: u24,
            }),
            ///  Data register
            DATAR: mmio.Mmio(packed struct(u32) {
                ///  8-bit data register
                DATAR: u8,
                padding: u24,
            }),
            ///  Status register 1
            STAR1: mmio.Mmio(packed struct(u32) {
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
            STAR2: mmio.Mmio(packed struct(u32) {
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
            CKCFGR: mmio.Mmio(packed struct(u32) {
                ///  Clock control register in Fast/Standard mode (Master mode)
                CCR: u12,
                reserved14: u2,
                ///  Fast mode duty cycle
                DUTY: u1,
                ///  I2C master mode selection
                F_S: u1,
                padding: u16,
            }),
            ///  Raise time register
            RTR: mmio.Mmio(packed struct(u32) {
                ///  Maximum rise time in Fast/Standard mode (Master mode)
                TRISE: u6,
                padding: u26,
            }),
        };

        ///  Universal synchronous asynchronous receiver transmitter
        pub const USART1 = extern struct {
            ///  Status register
            STATR: mmio.Mmio(packed struct(u32) {
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
            DATAR: mmio.Mmio(packed struct(u32) {
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
            CTLR1: mmio.Mmio(packed struct(u32) {
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
            CTLR2: mmio.Mmio(packed struct(u32) {
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
            CTLR3: mmio.Mmio(packed struct(u32) {
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
            GPR: mmio.Mmio(packed struct(u32) {
                ///  Prescaler value
                PSC: u8,
                ///  Guard time value
                GT: u8,
                padding: u16,
            }),
        };
    };
};
