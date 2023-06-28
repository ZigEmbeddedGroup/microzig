const micro = @import("microzig");
const mmio = micro.mmio;

pub const devices = struct {
    pub const RP2040 = struct {
        pub const properties = struct {
            pub const @"cpu.nvic_prio_bits" = "2";
            pub const @"cpu.mpu" = "true";
            pub const @"cpu.fpu" = "false";
            pub const @"cpu.num_interrupts" = "26";
            pub const @"cpu.vtor" = "1";
            pub const @"cpu.revision" = "r0p1";
            pub const @"cpu.vendor_systick_config" = "false";
            pub const license =
                \\
                \\    Copyright (c) 2020 Raspberry Pi (Trading) Ltd. \n
                \\    \n
                \\    SPDX-License-Identifier: BSD-3-Clause
                \\  
            ;
            pub const @"cpu.name" = "CM0PLUS";
            pub const @"cpu.endian" = "little";
        };

        pub const VectorTable = extern struct {
            const Handler = micro.interrupt.Handler;
            const unhandled = micro.interrupt.unhandled;

            initial_stack_pointer: u32,
            Reset: Handler = unhandled,
            NMI: Handler = unhandled,
            HardFault: Handler = unhandled,
            reserved2: [7]u32 = undefined,
            SVCall: Handler = unhandled,
            reserved10: [2]u32 = undefined,
            PendSV: Handler = unhandled,
            SysTick: Handler = unhandled,
            TIMER_IRQ_0: Handler = unhandled,
            TIMER_IRQ_1: Handler = unhandled,
            TIMER_IRQ_2: Handler = unhandled,
            TIMER_IRQ_3: Handler = unhandled,
            PWM_IRQ_WRAP: Handler = unhandled,
            USBCTRL_IRQ: Handler = unhandled,
            XIP_IRQ: Handler = unhandled,
            PIO0_IRQ_0: Handler = unhandled,
            PIO0_IRQ_1: Handler = unhandled,
            PIO1_IRQ_0: Handler = unhandled,
            PIO1_IRQ_1: Handler = unhandled,
            DMA_IRQ_0: Handler = unhandled,
            DMA_IRQ_1: Handler = unhandled,
            IO_IRQ_BANK0: Handler = unhandled,
            IO_IRQ_QSPI: Handler = unhandled,
            SIO_IRQ_PROC0: Handler = unhandled,
            SIO_IRQ_PROC1: Handler = unhandled,
            CLOCKS_IRQ: Handler = unhandled,
            SPI0_IRQ: Handler = unhandled,
            SPI1_IRQ: Handler = unhandled,
            UART0_IRQ: Handler = unhandled,
            UART1_IRQ: Handler = unhandled,
            ADC_IRQ_FIFO: Handler = unhandled,
            I2C0_IRQ: Handler = unhandled,
            I2C1_IRQ: Handler = unhandled,
            RTC_IRQ: Handler = unhandled,
        };

        pub const peripherals = struct {
            ///  System Control Space
            pub const MPU = @as(*volatile types.peripherals.SCS, @ptrFromInt(0xd90));
            ///  QSPI flash execute-in-place block
            pub const XIP_CTRL = @as(*volatile types.peripherals.XIP_CTRL, @ptrFromInt(0x14000000));
            ///  DW_apb_ssi has the following features:
            ///  * APB interface – Allows for easy integration into a DesignWare Synthesizable Components for AMBA 2 implementation.
            ///  * APB3 and APB4 protocol support.
            ///  * Scalable APB data bus width – Supports APB data bus widths of 8, 16, and 32 bits.
            ///  * Serial-master or serial-slave operation – Enables serial communication with serial-master or serial-slave peripheral devices.
            ///  * Programmable Dual/Quad/Octal SPI support in Master Mode.
            ///  * Dual Data Rate (DDR) and Read Data Strobe (RDS) Support - Enables the DW_apb_ssi master to perform operations with the device in DDR and RDS modes when working in Dual/Quad/Octal mode of operation.
            ///  * Data Mask Support - Enables the DW_apb_ssi to selectively update the bytes in the device. This feature is applicable only in enhanced SPI modes.
            ///  * eXecute-In-Place (XIP) support - Enables the DW_apb_ssi master to behave as a memory mapped I/O and fetches the data from the device based on the APB read request. This feature is applicable only in enhanced SPI modes.
            ///  * DMA Controller Interface – Enables the DW_apb_ssi to interface to a DMA controller over the bus using a handshaking interface for transfer requests.
            ///  * Independent masking of interrupts – Master collision, transmit FIFO overflow, transmit FIFO empty, receive FIFO full, receive FIFO underflow, and receive FIFO overflow interrupts can all be masked independently.
            ///  * Multi-master contention detection – Informs the processor of multiple serial-master accesses on the serial bus.
            ///  * Bypass of meta-stability flip-flops for synchronous clocks – When the APB clock (pclk) and the DW_apb_ssi serial clock (ssi_clk) are synchronous, meta-stable flip-flops are not used when transferring control signals across these clock domains.
            ///  * Programmable delay on the sample time of the received serial data bit (rxd); enables programmable control of routing delays resulting in higher serial data-bit rates.
            ///  * Programmable features:
            ///  - Serial interface operation – Choice of Motorola SPI, Texas Instruments Synchronous Serial Protocol or National Semiconductor Microwire.
            ///  - Clock bit-rate – Dynamic control of the serial bit rate of the data transfer; used in only serial-master mode of operation.
            ///  - Data Item size (4 to 32 bits) – Item size of each data transfer under the control of the programmer.
            ///  * Configured features:
            ///  - FIFO depth – 16 words deep. The FIFO width is fixed at 32 bits.
            ///  - 1 slave select output.
            ///  - Hardware slave-select – Dedicated hardware slave-select line.
            ///  - Combined interrupt line - one combined interrupt line from the DW_apb_ssi to the interrupt controller.
            ///  - Interrupt polarity – active high interrupt lines.
            ///  - Serial clock polarity – low serial-clock polarity directly after reset.
            ///  - Serial clock phase – capture on first edge of serial-clock directly after reset.
            pub const XIP_SSI = @as(*volatile types.peripherals.XIP_SSI, @ptrFromInt(0x18000000));
            pub const SYSINFO = @as(*volatile types.peripherals.SYSINFO, @ptrFromInt(0x40000000));
            ///  Register block for various chip control signals
            pub const SYSCFG = @as(*volatile types.peripherals.SYSCFG, @ptrFromInt(0x40004000));
            pub const CLOCKS = @as(*volatile types.peripherals.CLOCKS, @ptrFromInt(0x40008000));
            pub const RESETS = @as(*volatile types.peripherals.RESETS, @ptrFromInt(0x4000c000));
            pub const PSM = @as(*volatile types.peripherals.PSM, @ptrFromInt(0x40010000));
            pub const IO_BANK0 = @as(*volatile types.peripherals.IO_BANK0, @ptrFromInt(0x40014000));
            pub const IO_QSPI = @as(*volatile types.peripherals.IO_QSPI, @ptrFromInt(0x40018000));
            pub const PADS_BANK0 = @as(*volatile types.peripherals.PADS_BANK0, @ptrFromInt(0x4001c000));
            pub const PADS_QSPI = @as(*volatile types.peripherals.PADS_QSPI, @ptrFromInt(0x40020000));
            ///  Controls the crystal oscillator
            pub const XOSC = @as(*volatile types.peripherals.XOSC, @ptrFromInt(0x40024000));
            pub const PLL_SYS = @as(*volatile types.peripherals.PLL_SYS, @ptrFromInt(0x40028000));
            pub const PLL_USB = @as(*volatile types.peripherals.PLL_SYS, @ptrFromInt(0x4002c000));
            ///  Register block for busfabric control signals and performance counters
            pub const BUSCTRL = @as(*volatile types.peripherals.BUSCTRL, @ptrFromInt(0x40030000));
            pub const UART0 = @as(*volatile types.peripherals.UART0, @ptrFromInt(0x40034000));
            pub const UART1 = @as(*volatile types.peripherals.UART0, @ptrFromInt(0x40038000));
            pub const SPI0 = @as(*volatile types.peripherals.SPI0, @ptrFromInt(0x4003c000));
            pub const SPI1 = @as(*volatile types.peripherals.SPI0, @ptrFromInt(0x40040000));
            ///  DW_apb_i2c address block
            ///  List of configuration constants for the Synopsys I2C hardware (you may see references to these in I2C register header; these are *fixed* values, set at hardware design time):
            ///  IC_ULTRA_FAST_MODE ................ 0x0
            ///  IC_UFM_TBUF_CNT_DEFAULT ........... 0x8
            ///  IC_UFM_SCL_LOW_COUNT .............. 0x0008
            ///  IC_UFM_SCL_HIGH_COUNT ............. 0x0006
            ///  IC_TX_TL .......................... 0x0
            ///  IC_TX_CMD_BLOCK ................... 0x1
            ///  IC_HAS_DMA ........................ 0x1
            ///  IC_HAS_ASYNC_FIFO ................. 0x0
            ///  IC_SMBUS_ARP ...................... 0x0
            ///  IC_FIRST_DATA_BYTE_STATUS ......... 0x1
            ///  IC_INTR_IO ........................ 0x1
            ///  IC_MASTER_MODE .................... 0x1
            ///  IC_DEFAULT_ACK_GENERAL_CALL ....... 0x1
            ///  IC_INTR_POL ....................... 0x1
            ///  IC_OPTIONAL_SAR ................... 0x0
            ///  IC_DEFAULT_TAR_SLAVE_ADDR ......... 0x055
            ///  IC_DEFAULT_SLAVE_ADDR ............. 0x055
            ///  IC_DEFAULT_HS_SPKLEN .............. 0x1
            ///  IC_FS_SCL_HIGH_COUNT .............. 0x0006
            ///  IC_HS_SCL_LOW_COUNT ............... 0x0008
            ///  IC_DEVICE_ID_VALUE ................ 0x0
            ///  IC_10BITADDR_MASTER ............... 0x0
            ///  IC_CLK_FREQ_OPTIMIZATION .......... 0x0
            ///  IC_DEFAULT_FS_SPKLEN .............. 0x7
            ///  IC_ADD_ENCODED_PARAMS ............. 0x0
            ///  IC_DEFAULT_SDA_HOLD ............... 0x000001
            ///  IC_DEFAULT_SDA_SETUP .............. 0x64
            ///  IC_AVOID_RX_FIFO_FLUSH_ON_TX_ABRT . 0x0
            ///  IC_CLOCK_PERIOD ................... 100
            ///  IC_EMPTYFIFO_HOLD_MASTER_EN ....... 1
            ///  IC_RESTART_EN ..................... 0x1
            ///  IC_TX_CMD_BLOCK_DEFAULT ........... 0x0
            ///  IC_BUS_CLEAR_FEATURE .............. 0x0
            ///  IC_CAP_LOADING .................... 100
            ///  IC_FS_SCL_LOW_COUNT ............... 0x000d
            ///  APB_DATA_WIDTH .................... 32
            ///  IC_SDA_STUCK_TIMEOUT_DEFAULT ...... 0xffffffff
            ///  IC_SLV_DATA_NACK_ONLY ............. 0x1
            ///  IC_10BITADDR_SLAVE ................ 0x0
            ///  IC_CLK_TYPE ....................... 0x0
            ///  IC_SMBUS_UDID_MSB ................. 0x0
            ///  IC_SMBUS_SUSPEND_ALERT ............ 0x0
            ///  IC_HS_SCL_HIGH_COUNT .............. 0x0006
            ///  IC_SLV_RESTART_DET_EN ............. 0x1
            ///  IC_SMBUS .......................... 0x0
            ///  IC_OPTIONAL_SAR_DEFAULT ........... 0x0
            ///  IC_PERSISTANT_SLV_ADDR_DEFAULT .... 0x0
            ///  IC_USE_COUNTS ..................... 0x0
            ///  IC_RX_BUFFER_DEPTH ................ 16
            ///  IC_SCL_STUCK_TIMEOUT_DEFAULT ...... 0xffffffff
            ///  IC_RX_FULL_HLD_BUS_EN ............. 0x1
            ///  IC_SLAVE_DISABLE .................. 0x1
            ///  IC_RX_TL .......................... 0x0
            ///  IC_DEVICE_ID ...................... 0x0
            ///  IC_HC_COUNT_VALUES ................ 0x0
            ///  I2C_DYNAMIC_TAR_UPDATE ............ 0
            ///  IC_SMBUS_CLK_LOW_MEXT_DEFAULT ..... 0xffffffff
            ///  IC_SMBUS_CLK_LOW_SEXT_DEFAULT ..... 0xffffffff
            ///  IC_HS_MASTER_CODE ................. 0x1
            ///  IC_SMBUS_RST_IDLE_CNT_DEFAULT ..... 0xffff
            ///  IC_SMBUS_UDID_LSB_DEFAULT ......... 0xffffffff
            ///  IC_SS_SCL_HIGH_COUNT .............. 0x0028
            ///  IC_SS_SCL_LOW_COUNT ............... 0x002f
            ///  IC_MAX_SPEED_MODE ................. 0x2
            ///  IC_STAT_FOR_CLK_STRETCH ........... 0x0
            ///  IC_STOP_DET_IF_MASTER_ACTIVE ...... 0x0
            ///  IC_DEFAULT_UFM_SPKLEN ............. 0x1
            ///  IC_TX_BUFFER_DEPTH ................ 16
            pub const I2C0 = @as(*volatile types.peripherals.I2C0, @ptrFromInt(0x40044000));
            ///  DW_apb_i2c address block
            ///  List of configuration constants for the Synopsys I2C hardware (you may see references to these in I2C register header; these are *fixed* values, set at hardware design time):
            ///  IC_ULTRA_FAST_MODE ................ 0x0
            ///  IC_UFM_TBUF_CNT_DEFAULT ........... 0x8
            ///  IC_UFM_SCL_LOW_COUNT .............. 0x0008
            ///  IC_UFM_SCL_HIGH_COUNT ............. 0x0006
            ///  IC_TX_TL .......................... 0x0
            ///  IC_TX_CMD_BLOCK ................... 0x1
            ///  IC_HAS_DMA ........................ 0x1
            ///  IC_HAS_ASYNC_FIFO ................. 0x0
            ///  IC_SMBUS_ARP ...................... 0x0
            ///  IC_FIRST_DATA_BYTE_STATUS ......... 0x1
            ///  IC_INTR_IO ........................ 0x1
            ///  IC_MASTER_MODE .................... 0x1
            ///  IC_DEFAULT_ACK_GENERAL_CALL ....... 0x1
            ///  IC_INTR_POL ....................... 0x1
            ///  IC_OPTIONAL_SAR ................... 0x0
            ///  IC_DEFAULT_TAR_SLAVE_ADDR ......... 0x055
            ///  IC_DEFAULT_SLAVE_ADDR ............. 0x055
            ///  IC_DEFAULT_HS_SPKLEN .............. 0x1
            ///  IC_FS_SCL_HIGH_COUNT .............. 0x0006
            ///  IC_HS_SCL_LOW_COUNT ............... 0x0008
            ///  IC_DEVICE_ID_VALUE ................ 0x0
            ///  IC_10BITADDR_MASTER ............... 0x0
            ///  IC_CLK_FREQ_OPTIMIZATION .......... 0x0
            ///  IC_DEFAULT_FS_SPKLEN .............. 0x7
            ///  IC_ADD_ENCODED_PARAMS ............. 0x0
            ///  IC_DEFAULT_SDA_HOLD ............... 0x000001
            ///  IC_DEFAULT_SDA_SETUP .............. 0x64
            ///  IC_AVOID_RX_FIFO_FLUSH_ON_TX_ABRT . 0x0
            ///  IC_CLOCK_PERIOD ................... 100
            ///  IC_EMPTYFIFO_HOLD_MASTER_EN ....... 1
            ///  IC_RESTART_EN ..................... 0x1
            ///  IC_TX_CMD_BLOCK_DEFAULT ........... 0x0
            ///  IC_BUS_CLEAR_FEATURE .............. 0x0
            ///  IC_CAP_LOADING .................... 100
            ///  IC_FS_SCL_LOW_COUNT ............... 0x000d
            ///  APB_DATA_WIDTH .................... 32
            ///  IC_SDA_STUCK_TIMEOUT_DEFAULT ...... 0xffffffff
            ///  IC_SLV_DATA_NACK_ONLY ............. 0x1
            ///  IC_10BITADDR_SLAVE ................ 0x0
            ///  IC_CLK_TYPE ....................... 0x0
            ///  IC_SMBUS_UDID_MSB ................. 0x0
            ///  IC_SMBUS_SUSPEND_ALERT ............ 0x0
            ///  IC_HS_SCL_HIGH_COUNT .............. 0x0006
            ///  IC_SLV_RESTART_DET_EN ............. 0x1
            ///  IC_SMBUS .......................... 0x0
            ///  IC_OPTIONAL_SAR_DEFAULT ........... 0x0
            ///  IC_PERSISTANT_SLV_ADDR_DEFAULT .... 0x0
            ///  IC_USE_COUNTS ..................... 0x0
            ///  IC_RX_BUFFER_DEPTH ................ 16
            ///  IC_SCL_STUCK_TIMEOUT_DEFAULT ...... 0xffffffff
            ///  IC_RX_FULL_HLD_BUS_EN ............. 0x1
            ///  IC_SLAVE_DISABLE .................. 0x1
            ///  IC_RX_TL .......................... 0x0
            ///  IC_DEVICE_ID ...................... 0x0
            ///  IC_HC_COUNT_VALUES ................ 0x0
            ///  I2C_DYNAMIC_TAR_UPDATE ............ 0
            ///  IC_SMBUS_CLK_LOW_MEXT_DEFAULT ..... 0xffffffff
            ///  IC_SMBUS_CLK_LOW_SEXT_DEFAULT ..... 0xffffffff
            ///  IC_HS_MASTER_CODE ................. 0x1
            ///  IC_SMBUS_RST_IDLE_CNT_DEFAULT ..... 0xffff
            ///  IC_SMBUS_UDID_LSB_DEFAULT ......... 0xffffffff
            ///  IC_SS_SCL_HIGH_COUNT .............. 0x0028
            ///  IC_SS_SCL_LOW_COUNT ............... 0x002f
            ///  IC_MAX_SPEED_MODE ................. 0x2
            ///  IC_STAT_FOR_CLK_STRETCH ........... 0x0
            ///  IC_STOP_DET_IF_MASTER_ACTIVE ...... 0x0
            ///  IC_DEFAULT_UFM_SPKLEN ............. 0x1
            ///  IC_TX_BUFFER_DEPTH ................ 16
            pub const I2C1 = @as(*volatile types.peripherals.I2C0, @ptrFromInt(0x40048000));
            ///  Control and data interface to SAR ADC
            pub const ADC = @as(*volatile types.peripherals.ADC, @ptrFromInt(0x4004c000));
            ///  Simple PWM
            pub const PWM = @as(*volatile types.peripherals.PWM, @ptrFromInt(0x40050000));
            ///  Controls time and alarms
            ///  time is a 64 bit value indicating the time in usec since power-on
            ///  timeh is the top 32 bits of time & timel is the bottom 32 bits
            ///  to change time write to timelw before timehw
            ///  to read time read from timelr before timehr
            ///  An alarm is set by setting alarm_enable and writing to the corresponding alarm register
            ///  When an alarm is pending, the corresponding alarm_running signal will be high
            ///  An alarm can be cancelled before it has finished by clearing the alarm_enable
            ///  When an alarm fires, the corresponding alarm_irq is set and alarm_running is cleared
            ///  To clear the interrupt write a 1 to the corresponding alarm_irq
            pub const TIMER = @as(*volatile types.peripherals.TIMER, @ptrFromInt(0x40054000));
            pub const WATCHDOG = @as(*volatile types.peripherals.WATCHDOG, @ptrFromInt(0x40058000));
            ///  Register block to control RTC
            pub const RTC = @as(*volatile types.peripherals.RTC, @ptrFromInt(0x4005c000));
            pub const ROSC = @as(*volatile types.peripherals.ROSC, @ptrFromInt(0x40060000));
            ///  control and status for on-chip voltage regulator and chip level reset subsystem
            pub const VREG_AND_CHIP_RESET = @as(*volatile types.peripherals.VREG_AND_CHIP_RESET, @ptrFromInt(0x40064000));
            ///  Testbench manager. Allows the programmer to know what platform their software is running on.
            pub const TBMAN = @as(*volatile types.peripherals.TBMAN, @ptrFromInt(0x4006c000));
            ///  DMA with separate read and write masters
            pub const DMA = @as(*volatile types.peripherals.DMA, @ptrFromInt(0x50000000));
            ///  DPRAM layout for USB device.
            pub const USBCTRL_DPRAM = @as(*volatile types.peripherals.USBCTRL_DPRAM, @ptrFromInt(0x50100000));
            ///  USB FS/LS controller device registers
            pub const USBCTRL_REGS = @as(*volatile types.peripherals.USBCTRL_REGS, @ptrFromInt(0x50110000));
            ///  Programmable IO block
            pub const PIO0 = @as(*volatile types.peripherals.PIO0, @ptrFromInt(0x50200000));
            ///  Programmable IO block
            pub const PIO1 = @as(*volatile types.peripherals.PIO0, @ptrFromInt(0x50300000));
            ///  Single-cycle IO block
            ///  Provides core-local and inter-core hardware for the two processors, with single-cycle access.
            pub const SIO = @as(*volatile types.peripherals.SIO, @ptrFromInt(0xd0000000));
            pub const PPB = @as(*volatile types.peripherals.PPB, @ptrFromInt(0xe0000000));
            ///  System Tick Timer
            pub const SysTick = @as(*volatile types.peripherals.SysTick, @ptrFromInt(0xe000e010));
            ///  System Control Space
            pub const NVIC = @as(*volatile types.peripherals.NVIC, @ptrFromInt(0xe000e100));
            ///  System Control Space
            pub const SCB = @as(*volatile types.peripherals.SCB, @ptrFromInt(0xe000ed00));
        };
    };
};

pub const types = struct {
    pub const peripherals = struct {
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

        ///  System Control Block
        pub const SCB = extern struct {
            CPUID: mmio.Mmio(packed struct(u32) {
                REVISION: u4,
                PARTNO: u12,
                ARCHITECTURE: u4,
                VARIANT: u4,
                IMPLEMENTER: u8,
            }),
            ///  Interrupt Control and State Register
            ICSR: mmio.Mmio(packed struct(u32) {
                VECTACTIVE: u9,
                reserved12: u3,
                VECTPENDING: u9,
                reserved22: u1,
                ISRPENDING: u1,
                ISRPREEMPT: u1,
                reserved25: u1,
                PENDSTCLR: u1,
                PENDSTSET: u1,
                PENDSVCLR: u1,
                PENDSVSET: u1,
                reserved31: u2,
                NMIPENDSET: u1,
            }),
            ///  Vector Table Offset Register
            VTOR: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                TBLOFF: u24,
            }),
            ///  Application Interrupt and Reset Control Register
            AIRCR: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                VECTCLRACTIVE: u1,
                SYSRESETREQ: u1,
                reserved15: u12,
                ENDIANESS: u1,
                VECTKEY: u16,
            }),
            ///  System Control Register
            SCR: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                SLEEPONEXIT: u1,
                SLEEPDEEP: u1,
                reserved4: u1,
                SEVONPEND: u1,
                padding: u27,
            }),
            ///  Configuration Control Register
            CCR: mmio.Mmio(packed struct(u32) {
                reserved3: u3,
                UNALIGN_TRP: u1,
                reserved9: u5,
                STKALIGN: u1,
                padding: u22,
            }),
            reserved28: [4]u8,
            ///  System Handlers Priority Registers. [0] is RESERVED
            SHP: u32,
            reserved36: [4]u8,
            ///  System Handler Control and State Register
            SHCSR: mmio.Mmio(packed struct(u32) {
                reserved15: u15,
                SVCALLPENDED: u1,
                padding: u16,
            }),
        };

        ///  Nested Vectored Interrupt Controller
        pub const NVIC = extern struct {
            ///  Interrupt Set Enable Register
            ISER: mmio.Mmio(packed struct(u32) {
                TIMER_IRQ_0: u1,
                TIMER_IRQ_1: u1,
                TIMER_IRQ_2: u1,
                TIMER_IRQ_3: u1,
                PWM_IRQ_WRAP: u1,
                USBCTRL_IRQ: u1,
                XIP_IRQ: u1,
                PIO0_IRQ_0: u1,
                PIO0_IRQ_1: u1,
                PIO1_IRQ_0: u1,
                PIO1_IRQ_1: u1,
                DMA_IRQ_0: u1,
                DMA_IRQ_1: u1,
                IO_IRQ_BANK0: u1,
                IO_IRQ_QSPI: u1,
                SIO_IRQ_PROC0: u1,
                SIO_IRQ_PROC1: u1,
                CLOCKS_IRQ: u1,
                SPI0_IRQ: u1,
                SPI1_IRQ: u1,
                UART0_IRQ: u1,
                UART1_IRQ: u1,
                ADC_IRQ_FIFO: u1,
                I2C0_IRQ: u1,
                I2C1_IRQ: u1,
                RTC_IRQ: u1,
                padding: u6,
            }),
            reserved128: [124]u8,
            ///  Interrupt Clear Enable Register
            ICER: mmio.Mmio(packed struct(u32) {
                TIMER_IRQ_0: u1,
                TIMER_IRQ_1: u1,
                TIMER_IRQ_2: u1,
                TIMER_IRQ_3: u1,
                PWM_IRQ_WRAP: u1,
                USBCTRL_IRQ: u1,
                XIP_IRQ: u1,
                PIO0_IRQ_0: u1,
                PIO0_IRQ_1: u1,
                PIO1_IRQ_0: u1,
                PIO1_IRQ_1: u1,
                DMA_IRQ_0: u1,
                DMA_IRQ_1: u1,
                IO_IRQ_BANK0: u1,
                IO_IRQ_QSPI: u1,
                SIO_IRQ_PROC0: u1,
                SIO_IRQ_PROC1: u1,
                CLOCKS_IRQ: u1,
                SPI0_IRQ: u1,
                SPI1_IRQ: u1,
                UART0_IRQ: u1,
                UART1_IRQ: u1,
                ADC_IRQ_FIFO: u1,
                I2C0_IRQ: u1,
                I2C1_IRQ: u1,
                RTC_IRQ: u1,
                padding: u6,
            }),
            reserved256: [124]u8,
            ///  Interrupt Set Pending Register
            ISPR: mmio.Mmio(packed struct(u32) {
                TIMER_IRQ_0: u1,
                TIMER_IRQ_1: u1,
                TIMER_IRQ_2: u1,
                TIMER_IRQ_3: u1,
                PWM_IRQ_WRAP: u1,
                USBCTRL_IRQ: u1,
                XIP_IRQ: u1,
                PIO0_IRQ_0: u1,
                PIO0_IRQ_1: u1,
                PIO1_IRQ_0: u1,
                PIO1_IRQ_1: u1,
                DMA_IRQ_0: u1,
                DMA_IRQ_1: u1,
                IO_IRQ_BANK0: u1,
                IO_IRQ_QSPI: u1,
                SIO_IRQ_PROC0: u1,
                SIO_IRQ_PROC1: u1,
                CLOCKS_IRQ: u1,
                SPI0_IRQ: u1,
                SPI1_IRQ: u1,
                UART0_IRQ: u1,
                UART1_IRQ: u1,
                ADC_IRQ_FIFO: u1,
                I2C0_IRQ: u1,
                I2C1_IRQ: u1,
                RTC_IRQ: u1,
                padding: u6,
            }),
            reserved384: [124]u8,
            ///  Interrupt Clear Pending Register
            ICPR: mmio.Mmio(packed struct(u32) {
                TIMER_IRQ_0: u1,
                TIMER_IRQ_1: u1,
                TIMER_IRQ_2: u1,
                TIMER_IRQ_3: u1,
                PWM_IRQ_WRAP: u1,
                USBCTRL_IRQ: u1,
                XIP_IRQ: u1,
                PIO0_IRQ_0: u1,
                PIO0_IRQ_1: u1,
                PIO1_IRQ_0: u1,
                PIO1_IRQ_1: u1,
                DMA_IRQ_0: u1,
                DMA_IRQ_1: u1,
                IO_IRQ_BANK0: u1,
                IO_IRQ_QSPI: u1,
                SIO_IRQ_PROC0: u1,
                SIO_IRQ_PROC1: u1,
                CLOCKS_IRQ: u1,
                SPI0_IRQ: u1,
                SPI1_IRQ: u1,
                UART0_IRQ: u1,
                UART1_IRQ: u1,
                ADC_IRQ_FIFO: u1,
                I2C0_IRQ: u1,
                I2C1_IRQ: u1,
                RTC_IRQ: u1,
                padding: u6,
            }),
            reserved768: [380]u8,
            ///  Interrupt Priority Register
            IPR0: mmio.Mmio(packed struct(u32) {
                reserved6: u6,
                TIMER_IRQ_0: u2,
                reserved14: u6,
                TIMER_IRQ_1: u2,
                reserved22: u6,
                TIMER_IRQ_2: u2,
                reserved30: u6,
                TIMER_IRQ_3: u2,
            }),
            ///  Interrupt Priority Register
            IPR1: mmio.Mmio(packed struct(u32) {
                reserved6: u6,
                PWM_IRQ_WRAP: u2,
                reserved14: u6,
                USBCTRL_IRQ: u2,
                reserved22: u6,
                XIP_IRQ: u2,
                reserved30: u6,
                PIO0_IRQ_0: u2,
            }),
            ///  Interrupt Priority Register
            IPR2: mmio.Mmio(packed struct(u32) {
                reserved6: u6,
                PIO0_IRQ_1: u2,
                reserved14: u6,
                PIO1_IRQ_0: u2,
                reserved22: u6,
                PIO1_IRQ_1: u2,
                reserved30: u6,
                DMA_IRQ_0: u2,
            }),
            ///  Interrupt Priority Register
            IPR3: mmio.Mmio(packed struct(u32) {
                reserved6: u6,
                DMA_IRQ_1: u2,
                reserved14: u6,
                IO_IRQ_BANK0: u2,
                reserved22: u6,
                IO_IRQ_QSPI: u2,
                reserved30: u6,
                SIO_IRQ_PROC0: u2,
            }),
            ///  Interrupt Priority Register
            IPR4: mmio.Mmio(packed struct(u32) {
                reserved6: u6,
                SIO_IRQ_PROC1: u2,
                reserved14: u6,
                CLOCKS_IRQ: u2,
                reserved22: u6,
                SPI0_IRQ: u2,
                reserved30: u6,
                SPI1_IRQ: u2,
            }),
            ///  Interrupt Priority Register
            IPR5: mmio.Mmio(packed struct(u32) {
                reserved6: u6,
                UART0_IRQ: u2,
                reserved14: u6,
                UART1_IRQ: u2,
                reserved22: u6,
                ADC_IRQ_FIFO: u2,
                reserved30: u6,
                I2C0_IRQ: u2,
            }),
            ///  Interrupt Priority Register
            IPR6: mmio.Mmio(packed struct(u32) {
                reserved6: u6,
                I2C1_IRQ: u2,
                reserved14: u6,
                RTC_IRQ: u2,
                padding: u16,
            }),
            ///  Interrupt Priority Register
            IPR7: u32,
        };

        ///  Memory Protection Unit
        pub const MPU = extern struct {
            ///  MPU Type Register
            TYPE: mmio.Mmio(packed struct(u32) {
                SEPARATE: u1,
                reserved8: u7,
                DREGION: u8,
                IREGION: u8,
                padding: u8,
            }),
            ///  MPU Control Register
            CTRL: mmio.Mmio(packed struct(u32) {
                ENABLE: u1,
                HFNMIENA: u1,
                PRIVDEFENA: u1,
                padding: u29,
            }),
            ///  MPU Region RNRber Register
            RNR: mmio.Mmio(packed struct(u32) {
                REGION: u8,
                padding: u24,
            }),
            ///  MPU Region Base Address Register
            RBAR: mmio.Mmio(packed struct(u32) {
                REGION: u4,
                VALID: u1,
                reserved8: u3,
                ADDR: u24,
            }),
            ///  MPU Region Attribute and Size Register
            RASR: mmio.Mmio(packed struct(u32) {
                ENABLE: u1,
                SIZE: u5,
                reserved8: u2,
                SRD: u8,
                B: u1,
                C: u1,
                S: u1,
                TEX: u3,
                reserved24: u2,
                AP: u3,
                reserved28: u1,
                XN: u1,
                padding: u3,
            }),
        };

        ///  QSPI flash execute-in-place block
        pub const XIP_CTRL = extern struct {
            ///  Cache control
            CTRL: mmio.Mmio(packed struct(u32) {
                ///  When 1, enable the cache. When the cache is disabled, all XIP accesses
                ///  will go straight to the flash, without querying the cache. When enabled,
                ///  cacheable XIP accesses will query the cache, and the flash will
                ///  not be accessed if the tag matches and the valid bit is set.
                ///  If the cache is enabled, cache-as-SRAM accesses have no effect on the
                ///  cache data RAM, and will produce a bus error response.
                EN: u1,
                ///  When 1, writes to any alias other than 0x0 (caching, allocating)
                ///  will produce a bus fault. When 0, these writes are silently ignored.
                ///  In either case, writes to the 0x0 alias will deallocate on tag match,
                ///  as usual.
                ERR_BADWRITE: u1,
                reserved3: u1,
                ///  When 1, the cache memories are powered down. They retain state,
                ///  but can not be accessed. This reduces static power dissipation.
                ///  Writing 1 to this bit forces CTRL_EN to 0, i.e. the cache cannot
                ///  be enabled when powered down.
                ///  Cache-as-SRAM accesses will produce a bus error response when
                ///  the cache is powered down.
                POWER_DOWN: u1,
                padding: u28,
            }),
            ///  Cache Flush control
            FLUSH: mmio.Mmio(packed struct(u32) {
                ///  Write 1 to flush the cache. This clears the tag memory, but
                ///  the data memory retains its contents. (This means cache-as-SRAM
                ///  contents is not affected by flush or reset.)
                ///  Reading will hold the bus (stall the processor) until the flush
                ///  completes. Alternatively STAT can be polled until completion.
                FLUSH: u1,
                padding: u31,
            }),
            ///  Cache Status
            STAT: mmio.Mmio(packed struct(u32) {
                ///  Reads as 0 while a cache flush is in progress, and 1 otherwise.
                ///  The cache is flushed whenever the XIP block is reset, and also
                ///  when requested via the FLUSH register.
                FLUSH_READY: u1,
                ///  When 1, indicates the XIP streaming FIFO is completely empty.
                FIFO_EMPTY: u1,
                ///  When 1, indicates the XIP streaming FIFO is completely full.
                ///  The streaming FIFO is 2 entries deep, so the full and empty
                ///  flag allow its level to be ascertained.
                FIFO_FULL: u1,
                padding: u29,
            }),
            ///  Cache Hit counter
            ///  A 32 bit saturating counter that increments upon each cache hit,
            ///  i.e. when an XIP access is serviced directly from cached data.
            ///  Write any value to clear.
            CTR_HIT: u32,
            ///  Cache Access counter
            ///  A 32 bit saturating counter that increments upon each XIP access,
            ///  whether the cache is hit or not. This includes noncacheable accesses.
            ///  Write any value to clear.
            CTR_ACC: u32,
            ///  FIFO stream address
            STREAM_ADDR: mmio.Mmio(packed struct(u32) {
                reserved2: u2,
                ///  The address of the next word to be streamed from flash to the streaming FIFO.
                ///  Increments automatically after each flash access.
                ///  Write the initial access address here before starting a streaming read.
                STREAM_ADDR: u30,
            }),
            ///  FIFO stream control
            STREAM_CTR: mmio.Mmio(packed struct(u32) {
                ///  Write a nonzero value to start a streaming read. This will then
                ///  progress in the background, using flash idle cycles to transfer
                ///  a linear data block from flash to the streaming FIFO.
                ///  Decrements automatically (1 at a time) as the stream
                ///  progresses, and halts on reaching 0.
                ///  Write 0 to halt an in-progress stream, and discard any in-flight
                ///  read, so that a new stream can immediately be started (after
                ///  draining the FIFO and reinitialising STREAM_ADDR)
                STREAM_CTR: u22,
                padding: u10,
            }),
            ///  FIFO stream data
            ///  Streamed data is buffered here, for retrieval by the system DMA.
            ///  This FIFO can also be accessed via the XIP_AUX slave, to avoid exposing
            ///  the DMA to bus stalls caused by other XIP traffic.
            STREAM_FIFO: u32,
        };

        ///  DW_apb_ssi has the following features:
        ///  * APB interface – Allows for easy integration into a DesignWare Synthesizable Components for AMBA 2 implementation.
        ///  * APB3 and APB4 protocol support.
        ///  * Scalable APB data bus width – Supports APB data bus widths of 8, 16, and 32 bits.
        ///  * Serial-master or serial-slave operation – Enables serial communication with serial-master or serial-slave peripheral devices.
        ///  * Programmable Dual/Quad/Octal SPI support in Master Mode.
        ///  * Dual Data Rate (DDR) and Read Data Strobe (RDS) Support - Enables the DW_apb_ssi master to perform operations with the device in DDR and RDS modes when working in Dual/Quad/Octal mode of operation.
        ///  * Data Mask Support - Enables the DW_apb_ssi to selectively update the bytes in the device. This feature is applicable only in enhanced SPI modes.
        ///  * eXecute-In-Place (XIP) support - Enables the DW_apb_ssi master to behave as a memory mapped I/O and fetches the data from the device based on the APB read request. This feature is applicable only in enhanced SPI modes.
        ///  * DMA Controller Interface – Enables the DW_apb_ssi to interface to a DMA controller over the bus using a handshaking interface for transfer requests.
        ///  * Independent masking of interrupts – Master collision, transmit FIFO overflow, transmit FIFO empty, receive FIFO full, receive FIFO underflow, and receive FIFO overflow interrupts can all be masked independently.
        ///  * Multi-master contention detection – Informs the processor of multiple serial-master accesses on the serial bus.
        ///  * Bypass of meta-stability flip-flops for synchronous clocks – When the APB clock (pclk) and the DW_apb_ssi serial clock (ssi_clk) are synchronous, meta-stable flip-flops are not used when transferring control signals across these clock domains.
        ///  * Programmable delay on the sample time of the received serial data bit (rxd); enables programmable control of routing delays resulting in higher serial data-bit rates.
        ///  * Programmable features:
        ///  - Serial interface operation – Choice of Motorola SPI, Texas Instruments Synchronous Serial Protocol or National Semiconductor Microwire.
        ///  - Clock bit-rate – Dynamic control of the serial bit rate of the data transfer; used in only serial-master mode of operation.
        ///  - Data Item size (4 to 32 bits) – Item size of each data transfer under the control of the programmer.
        ///  * Configured features:
        ///  - FIFO depth – 16 words deep. The FIFO width is fixed at 32 bits.
        ///  - 1 slave select output.
        ///  - Hardware slave-select – Dedicated hardware slave-select line.
        ///  - Combined interrupt line - one combined interrupt line from the DW_apb_ssi to the interrupt controller.
        ///  - Interrupt polarity – active high interrupt lines.
        ///  - Serial clock polarity – low serial-clock polarity directly after reset.
        ///  - Serial clock phase – capture on first edge of serial-clock directly after reset.
        pub const XIP_SSI = extern struct {
            ///  Control register 0
            CTRLR0: mmio.Mmio(packed struct(u32) {
                ///  Data frame size
                DFS: u4,
                ///  Frame format
                FRF: u2,
                ///  Serial clock phase
                SCPH: u1,
                ///  Serial clock polarity
                SCPOL: u1,
                ///  Transfer mode
                TMOD: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Both transmit and receive
                        TX_AND_RX = 0x0,
                        ///  Transmit only (not for FRF == 0, standard SPI mode)
                        TX_ONLY = 0x1,
                        ///  Receive only (not for FRF == 0, standard SPI mode)
                        RX_ONLY = 0x2,
                        ///  EEPROM read mode (TX then RX; RX starts after control data TX'd)
                        EEPROM_READ = 0x3,
                    },
                },
                ///  Slave output enable
                SLV_OE: u1,
                ///  Shift register loop (test mode)
                SRL: u1,
                ///  Control frame size
                ///  Value of n -> n+1 clocks per frame.
                CFS: u4,
                ///  Data frame size in 32b transfer mode
                ///  Value of n -> n+1 clocks per frame.
                DFS_32: u5,
                ///  SPI frame format
                SPI_FRF: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Standard 1-bit SPI frame format; 1 bit per SCK, full-duplex
                        STD = 0x0,
                        ///  Dual-SPI frame format; two bits per SCK, half-duplex
                        DUAL = 0x1,
                        ///  Quad-SPI frame format; four bits per SCK, half-duplex
                        QUAD = 0x2,
                        _,
                    },
                },
                reserved24: u1,
                ///  Slave select toggle enable
                SSTE: u1,
                padding: u7,
            }),
            ///  Master Control register 1
            CTRLR1: mmio.Mmio(packed struct(u32) {
                ///  Number of data frames
                NDF: u16,
                padding: u16,
            }),
            ///  SSI Enable
            SSIENR: mmio.Mmio(packed struct(u32) {
                ///  SSI enable
                SSI_EN: u1,
                padding: u31,
            }),
            ///  Microwire Control
            MWCR: mmio.Mmio(packed struct(u32) {
                ///  Microwire transfer mode
                MWMOD: u1,
                ///  Microwire control
                MDD: u1,
                ///  Microwire handshaking
                MHS: u1,
                padding: u29,
            }),
            ///  Slave enable
            SER: mmio.Mmio(packed struct(u32) {
                ///  For each bit:
                ///  0 -> slave not selected
                ///  1 -> slave selected
                SER: u1,
                padding: u31,
            }),
            ///  Baud rate
            BAUDR: mmio.Mmio(packed struct(u32) {
                ///  SSI clock divider
                SCKDV: u16,
                padding: u16,
            }),
            ///  TX FIFO threshold level
            TXFTLR: mmio.Mmio(packed struct(u32) {
                ///  Transmit FIFO threshold
                TFT: u8,
                padding: u24,
            }),
            ///  RX FIFO threshold level
            RXFTLR: mmio.Mmio(packed struct(u32) {
                ///  Receive FIFO threshold
                RFT: u8,
                padding: u24,
            }),
            ///  TX FIFO level
            TXFLR: mmio.Mmio(packed struct(u32) {
                ///  Transmit FIFO level
                TFTFL: u8,
                padding: u24,
            }),
            ///  RX FIFO level
            RXFLR: mmio.Mmio(packed struct(u32) {
                ///  Receive FIFO level
                RXTFL: u8,
                padding: u24,
            }),
            ///  Status register
            SR: mmio.Mmio(packed struct(u32) {
                ///  SSI busy flag
                BUSY: u1,
                ///  Transmit FIFO not full
                TFNF: u1,
                ///  Transmit FIFO empty
                TFE: u1,
                ///  Receive FIFO not empty
                RFNE: u1,
                ///  Receive FIFO full
                RFF: u1,
                ///  Transmission error
                TXE: u1,
                ///  Data collision error
                DCOL: u1,
                padding: u25,
            }),
            ///  Interrupt mask
            IMR: mmio.Mmio(packed struct(u32) {
                ///  Transmit FIFO empty interrupt mask
                TXEIM: u1,
                ///  Transmit FIFO overflow interrupt mask
                TXOIM: u1,
                ///  Receive FIFO underflow interrupt mask
                RXUIM: u1,
                ///  Receive FIFO overflow interrupt mask
                RXOIM: u1,
                ///  Receive FIFO full interrupt mask
                RXFIM: u1,
                ///  Multi-master contention interrupt mask
                MSTIM: u1,
                padding: u26,
            }),
            ///  Interrupt status
            ISR: mmio.Mmio(packed struct(u32) {
                ///  Transmit FIFO empty interrupt status
                TXEIS: u1,
                ///  Transmit FIFO overflow interrupt status
                TXOIS: u1,
                ///  Receive FIFO underflow interrupt status
                RXUIS: u1,
                ///  Receive FIFO overflow interrupt status
                RXOIS: u1,
                ///  Receive FIFO full interrupt status
                RXFIS: u1,
                ///  Multi-master contention interrupt status
                MSTIS: u1,
                padding: u26,
            }),
            ///  Raw interrupt status
            RISR: mmio.Mmio(packed struct(u32) {
                ///  Transmit FIFO empty raw interrupt status
                TXEIR: u1,
                ///  Transmit FIFO overflow raw interrupt status
                TXOIR: u1,
                ///  Receive FIFO underflow raw interrupt status
                RXUIR: u1,
                ///  Receive FIFO overflow raw interrupt status
                RXOIR: u1,
                ///  Receive FIFO full raw interrupt status
                RXFIR: u1,
                ///  Multi-master contention raw interrupt status
                MSTIR: u1,
                padding: u26,
            }),
            ///  TX FIFO overflow interrupt clear
            TXOICR: mmio.Mmio(packed struct(u32) {
                ///  Clear-on-read transmit FIFO overflow interrupt
                TXOICR: u1,
                padding: u31,
            }),
            ///  RX FIFO overflow interrupt clear
            RXOICR: mmio.Mmio(packed struct(u32) {
                ///  Clear-on-read receive FIFO overflow interrupt
                RXOICR: u1,
                padding: u31,
            }),
            ///  RX FIFO underflow interrupt clear
            RXUICR: mmio.Mmio(packed struct(u32) {
                ///  Clear-on-read receive FIFO underflow interrupt
                RXUICR: u1,
                padding: u31,
            }),
            ///  Multi-master interrupt clear
            MSTICR: mmio.Mmio(packed struct(u32) {
                ///  Clear-on-read multi-master contention interrupt
                MSTICR: u1,
                padding: u31,
            }),
            ///  Interrupt clear
            ICR: mmio.Mmio(packed struct(u32) {
                ///  Clear-on-read all active interrupts
                ICR: u1,
                padding: u31,
            }),
            ///  DMA control
            DMACR: mmio.Mmio(packed struct(u32) {
                ///  Receive DMA enable
                RDMAE: u1,
                ///  Transmit DMA enable
                TDMAE: u1,
                padding: u30,
            }),
            ///  DMA TX data level
            DMATDLR: mmio.Mmio(packed struct(u32) {
                ///  Transmit data watermark level
                DMATDL: u8,
                padding: u24,
            }),
            ///  DMA RX data level
            DMARDLR: mmio.Mmio(packed struct(u32) {
                ///  Receive data watermark level (DMARDLR+1)
                DMARDL: u8,
                padding: u24,
            }),
            ///  Identification register
            IDR: mmio.Mmio(packed struct(u32) {
                ///  Peripheral dentification code
                IDCODE: u32,
            }),
            ///  Version ID
            SSI_VERSION_ID: mmio.Mmio(packed struct(u32) {
                ///  SNPS component version (format X.YY)
                SSI_COMP_VERSION: u32,
            }),
            ///  Data Register 0 (of 36)
            DR0: mmio.Mmio(packed struct(u32) {
                ///  First data register of 36
                DR: u32,
            }),
            reserved240: [140]u8,
            ///  RX sample delay
            RX_SAMPLE_DLY: mmio.Mmio(packed struct(u32) {
                ///  RXD sample delay (in SCLK cycles)
                RSD: u8,
                padding: u24,
            }),
            ///  SPI control
            SPI_CTRLR0: mmio.Mmio(packed struct(u32) {
                ///  Address and instruction transfer format
                TRANS_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Command and address both in standard SPI frame format
                        @"1C1A" = 0x0,
                        ///  Command in standard SPI format, address in format specified by FRF
                        @"1C2A" = 0x1,
                        ///  Command and address both in format specified by FRF (e.g. Dual-SPI)
                        @"2C2A" = 0x2,
                        _,
                    },
                },
                ///  Address length (0b-60b in 4b increments)
                ADDR_L: u4,
                reserved8: u2,
                ///  Instruction length (0/4/8/16b)
                INST_L: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  No instruction
                        NONE = 0x0,
                        ///  4-bit instruction
                        @"4B" = 0x1,
                        ///  8-bit instruction
                        @"8B" = 0x2,
                        ///  16-bit instruction
                        @"16B" = 0x3,
                    },
                },
                reserved11: u1,
                ///  Wait cycles between control frame transmit and data reception (in SCLK cycles)
                WAIT_CYCLES: u5,
                ///  SPI DDR transfer enable
                SPI_DDR_EN: u1,
                ///  Instruction DDR transfer enable
                INST_DDR_EN: u1,
                ///  Read data strobe enable
                SPI_RXDS_EN: u1,
                reserved24: u5,
                ///  SPI Command to send in XIP mode (INST_L = 8-bit) or to append to Address (INST_L = 0-bit)
                XIP_CMD: u8,
            }),
            ///  TX drive edge
            TXD_DRIVE_EDGE: mmio.Mmio(packed struct(u32) {
                ///  TXD drive edge
                TDE: u8,
                padding: u24,
            }),
        };

        pub const SYSINFO = extern struct {
            ///  JEDEC JEP-106 compliant chip identifier.
            CHIP_ID: mmio.Mmio(packed struct(u32) {
                MANUFACTURER: u12,
                PART: u16,
                REVISION: u4,
            }),
            ///  Platform register. Allows software to know what environment it is running in.
            PLATFORM: mmio.Mmio(packed struct(u32) {
                FPGA: u1,
                ASIC: u1,
                padding: u30,
            }),
            reserved64: [56]u8,
            ///  Git hash of the chip source. Used to identify chip version.
            GITREF_RP2040: u32,
        };

        ///  Register block for various chip control signals
        pub const SYSCFG = extern struct {
            ///  Processor core 0 NMI source mask
            ///  Set a bit high to enable NMI from that IRQ
            PROC0_NMI_MASK: u32,
            ///  Processor core 1 NMI source mask
            ///  Set a bit high to enable NMI from that IRQ
            PROC1_NMI_MASK: u32,
            ///  Configuration for processors
            PROC_CONFIG: mmio.Mmio(packed struct(u32) {
                ///  Indication that proc0 has halted
                PROC0_HALTED: u1,
                ///  Indication that proc1 has halted
                PROC1_HALTED: u1,
                reserved24: u22,
                ///  Configure proc0 DAP instance ID.
                ///  Recommend that this is NOT changed until you require debug access in multi-chip environment
                ///  WARNING: do not set to 15 as this is reserved for RescueDP
                PROC0_DAP_INSTID: u4,
                ///  Configure proc1 DAP instance ID.
                ///  Recommend that this is NOT changed until you require debug access in multi-chip environment
                ///  WARNING: do not set to 15 as this is reserved for RescueDP
                PROC1_DAP_INSTID: u4,
            }),
            ///  For each bit, if 1, bypass the input synchronizer between that GPIO
            ///  and the GPIO input register in the SIO. The input synchronizers should
            ///  generally be unbypassed, to avoid injecting metastabilities into processors.
            ///  If you're feeling brave, you can bypass to save two cycles of input
            ///  latency. This register applies to GPIO 0...29.
            PROC_IN_SYNC_BYPASS: mmio.Mmio(packed struct(u32) {
                PROC_IN_SYNC_BYPASS: u30,
                padding: u2,
            }),
            ///  For each bit, if 1, bypass the input synchronizer between that GPIO
            ///  and the GPIO input register in the SIO. The input synchronizers should
            ///  generally be unbypassed, to avoid injecting metastabilities into processors.
            ///  If you're feeling brave, you can bypass to save two cycles of input
            ///  latency. This register applies to GPIO 30...35 (the QSPI IOs).
            PROC_IN_SYNC_BYPASS_HI: mmio.Mmio(packed struct(u32) {
                PROC_IN_SYNC_BYPASS_HI: u6,
                padding: u26,
            }),
            ///  Directly control the SWD debug port of either processor
            DBGFORCE: mmio.Mmio(packed struct(u32) {
                ///  Observe the value of processor 0 SWDIO output.
                PROC0_SWDO: u1,
                ///  Directly drive processor 0 SWDIO input, if PROC0_ATTACH is set
                PROC0_SWDI: u1,
                ///  Directly drive processor 0 SWCLK, if PROC0_ATTACH is set
                PROC0_SWCLK: u1,
                ///  Attach processor 0 debug port to syscfg controls, and disconnect it from external SWD pads.
                PROC0_ATTACH: u1,
                ///  Observe the value of processor 1 SWDIO output.
                PROC1_SWDO: u1,
                ///  Directly drive processor 1 SWDIO input, if PROC1_ATTACH is set
                PROC1_SWDI: u1,
                ///  Directly drive processor 1 SWCLK, if PROC1_ATTACH is set
                PROC1_SWCLK: u1,
                ///  Attach processor 1 debug port to syscfg controls, and disconnect it from external SWD pads.
                PROC1_ATTACH: u1,
                padding: u24,
            }),
            ///  Control power downs to memories. Set high to power down memories.
            ///  Use with extreme caution
            MEMPOWERDOWN: mmio.Mmio(packed struct(u32) {
                SRAM0: u1,
                SRAM1: u1,
                SRAM2: u1,
                SRAM3: u1,
                SRAM4: u1,
                SRAM5: u1,
                USB: u1,
                ROM: u1,
                padding: u24,
            }),
        };

        pub const CLOCKS = extern struct {
            ///  Clock control, can be changed on-the-fly (except for auxsrc)
            CLK_GPOUT0_CTRL: mmio.Mmio(packed struct(u32) {
                reserved5: u5,
                ///  Selects the auxiliary clock source, will glitch when switching
                AUXSRC: packed union {
                    raw: u4,
                    value: enum(u4) {
                        clksrc_pll_sys = 0x0,
                        clksrc_gpin0 = 0x1,
                        clksrc_gpin1 = 0x2,
                        clksrc_pll_usb = 0x3,
                        rosc_clksrc = 0x4,
                        xosc_clksrc = 0x5,
                        clk_sys = 0x6,
                        clk_usb = 0x7,
                        clk_adc = 0x8,
                        clk_rtc = 0x9,
                        clk_ref = 0xa,
                        _,
                    },
                },
                reserved10: u1,
                ///  Asynchronously kills the clock generator
                KILL: u1,
                ///  Starts and stops the clock generator cleanly
                ENABLE: u1,
                ///  Enables duty cycle correction for odd divisors
                DC50: u1,
                reserved16: u3,
                ///  This delays the enable signal by up to 3 cycles of the input clock
                ///  This must be set before the clock is enabled to have any effect
                PHASE: u2,
                reserved20: u2,
                ///  An edge on this signal shifts the phase of the output by 1 cycle of the input clock
                ///  This can be done at any time
                NUDGE: u1,
                padding: u11,
            }),
            ///  Clock divisor, can be changed on-the-fly
            CLK_GPOUT0_DIV: mmio.Mmio(packed struct(u32) {
                ///  Fractional component of the divisor
                FRAC: u8,
                ///  Integer component of the divisor, 0 -> divide by 2^16
                INT: u24,
            }),
            ///  Indicates which SRC is currently selected by the glitchless mux (one-hot).
            ///  This slice does not have a glitchless mux (only the AUX_SRC field is present, not SRC) so this register is hardwired to 0x1.
            CLK_GPOUT0_SELECTED: u32,
            ///  Clock control, can be changed on-the-fly (except for auxsrc)
            CLK_GPOUT1_CTRL: mmio.Mmio(packed struct(u32) {
                reserved5: u5,
                ///  Selects the auxiliary clock source, will glitch when switching
                AUXSRC: packed union {
                    raw: u4,
                    value: enum(u4) {
                        clksrc_pll_sys = 0x0,
                        clksrc_gpin0 = 0x1,
                        clksrc_gpin1 = 0x2,
                        clksrc_pll_usb = 0x3,
                        rosc_clksrc = 0x4,
                        xosc_clksrc = 0x5,
                        clk_sys = 0x6,
                        clk_usb = 0x7,
                        clk_adc = 0x8,
                        clk_rtc = 0x9,
                        clk_ref = 0xa,
                        _,
                    },
                },
                reserved10: u1,
                ///  Asynchronously kills the clock generator
                KILL: u1,
                ///  Starts and stops the clock generator cleanly
                ENABLE: u1,
                ///  Enables duty cycle correction for odd divisors
                DC50: u1,
                reserved16: u3,
                ///  This delays the enable signal by up to 3 cycles of the input clock
                ///  This must be set before the clock is enabled to have any effect
                PHASE: u2,
                reserved20: u2,
                ///  An edge on this signal shifts the phase of the output by 1 cycle of the input clock
                ///  This can be done at any time
                NUDGE: u1,
                padding: u11,
            }),
            ///  Clock divisor, can be changed on-the-fly
            CLK_GPOUT1_DIV: mmio.Mmio(packed struct(u32) {
                ///  Fractional component of the divisor
                FRAC: u8,
                ///  Integer component of the divisor, 0 -> divide by 2^16
                INT: u24,
            }),
            ///  Indicates which SRC is currently selected by the glitchless mux (one-hot).
            ///  This slice does not have a glitchless mux (only the AUX_SRC field is present, not SRC) so this register is hardwired to 0x1.
            CLK_GPOUT1_SELECTED: u32,
            ///  Clock control, can be changed on-the-fly (except for auxsrc)
            CLK_GPOUT2_CTRL: mmio.Mmio(packed struct(u32) {
                reserved5: u5,
                ///  Selects the auxiliary clock source, will glitch when switching
                AUXSRC: packed union {
                    raw: u4,
                    value: enum(u4) {
                        clksrc_pll_sys = 0x0,
                        clksrc_gpin0 = 0x1,
                        clksrc_gpin1 = 0x2,
                        clksrc_pll_usb = 0x3,
                        rosc_clksrc_ph = 0x4,
                        xosc_clksrc = 0x5,
                        clk_sys = 0x6,
                        clk_usb = 0x7,
                        clk_adc = 0x8,
                        clk_rtc = 0x9,
                        clk_ref = 0xa,
                        _,
                    },
                },
                reserved10: u1,
                ///  Asynchronously kills the clock generator
                KILL: u1,
                ///  Starts and stops the clock generator cleanly
                ENABLE: u1,
                ///  Enables duty cycle correction for odd divisors
                DC50: u1,
                reserved16: u3,
                ///  This delays the enable signal by up to 3 cycles of the input clock
                ///  This must be set before the clock is enabled to have any effect
                PHASE: u2,
                reserved20: u2,
                ///  An edge on this signal shifts the phase of the output by 1 cycle of the input clock
                ///  This can be done at any time
                NUDGE: u1,
                padding: u11,
            }),
            ///  Clock divisor, can be changed on-the-fly
            CLK_GPOUT2_DIV: mmio.Mmio(packed struct(u32) {
                ///  Fractional component of the divisor
                FRAC: u8,
                ///  Integer component of the divisor, 0 -> divide by 2^16
                INT: u24,
            }),
            ///  Indicates which SRC is currently selected by the glitchless mux (one-hot).
            ///  This slice does not have a glitchless mux (only the AUX_SRC field is present, not SRC) so this register is hardwired to 0x1.
            CLK_GPOUT2_SELECTED: u32,
            ///  Clock control, can be changed on-the-fly (except for auxsrc)
            CLK_GPOUT3_CTRL: mmio.Mmio(packed struct(u32) {
                reserved5: u5,
                ///  Selects the auxiliary clock source, will glitch when switching
                AUXSRC: packed union {
                    raw: u4,
                    value: enum(u4) {
                        clksrc_pll_sys = 0x0,
                        clksrc_gpin0 = 0x1,
                        clksrc_gpin1 = 0x2,
                        clksrc_pll_usb = 0x3,
                        rosc_clksrc_ph = 0x4,
                        xosc_clksrc = 0x5,
                        clk_sys = 0x6,
                        clk_usb = 0x7,
                        clk_adc = 0x8,
                        clk_rtc = 0x9,
                        clk_ref = 0xa,
                        _,
                    },
                },
                reserved10: u1,
                ///  Asynchronously kills the clock generator
                KILL: u1,
                ///  Starts and stops the clock generator cleanly
                ENABLE: u1,
                ///  Enables duty cycle correction for odd divisors
                DC50: u1,
                reserved16: u3,
                ///  This delays the enable signal by up to 3 cycles of the input clock
                ///  This must be set before the clock is enabled to have any effect
                PHASE: u2,
                reserved20: u2,
                ///  An edge on this signal shifts the phase of the output by 1 cycle of the input clock
                ///  This can be done at any time
                NUDGE: u1,
                padding: u11,
            }),
            ///  Clock divisor, can be changed on-the-fly
            CLK_GPOUT3_DIV: mmio.Mmio(packed struct(u32) {
                ///  Fractional component of the divisor
                FRAC: u8,
                ///  Integer component of the divisor, 0 -> divide by 2^16
                INT: u24,
            }),
            ///  Indicates which SRC is currently selected by the glitchless mux (one-hot).
            ///  This slice does not have a glitchless mux (only the AUX_SRC field is present, not SRC) so this register is hardwired to 0x1.
            CLK_GPOUT3_SELECTED: u32,
            ///  Clock control, can be changed on-the-fly (except for auxsrc)
            CLK_REF_CTRL: mmio.Mmio(packed struct(u32) {
                ///  Selects the clock source glitchlessly, can be changed on-the-fly
                SRC: packed union {
                    raw: u2,
                    value: enum(u2) {
                        rosc_clksrc_ph = 0x0,
                        clksrc_clk_ref_aux = 0x1,
                        xosc_clksrc = 0x2,
                        _,
                    },
                },
                reserved5: u3,
                ///  Selects the auxiliary clock source, will glitch when switching
                AUXSRC: packed union {
                    raw: u2,
                    value: enum(u2) {
                        clksrc_pll_usb = 0x0,
                        clksrc_gpin0 = 0x1,
                        clksrc_gpin1 = 0x2,
                        _,
                    },
                },
                padding: u25,
            }),
            ///  Clock divisor, can be changed on-the-fly
            CLK_REF_DIV: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  Integer component of the divisor, 0 -> divide by 2^16
                INT: u2,
                padding: u22,
            }),
            ///  Indicates which SRC is currently selected by the glitchless mux (one-hot).
            ///  The glitchless multiplexer does not switch instantaneously (to avoid glitches), so software should poll this register to wait for the switch to complete. This register contains one decoded bit for each of the clock sources enumerated in the CTRL SRC field. At most one of these bits will be set at any time, indicating that clock is currently present at the output of the glitchless mux. Whilst switching is in progress, this register may briefly show all-0s.
            CLK_REF_SELECTED: u32,
            ///  Clock control, can be changed on-the-fly (except for auxsrc)
            CLK_SYS_CTRL: mmio.Mmio(packed struct(u32) {
                ///  Selects the clock source glitchlessly, can be changed on-the-fly
                SRC: packed union {
                    raw: u1,
                    value: enum(u1) {
                        clk_ref = 0x0,
                        clksrc_clk_sys_aux = 0x1,
                    },
                },
                reserved5: u4,
                ///  Selects the auxiliary clock source, will glitch when switching
                AUXSRC: packed union {
                    raw: u3,
                    value: enum(u3) {
                        clksrc_pll_sys = 0x0,
                        clksrc_pll_usb = 0x1,
                        rosc_clksrc = 0x2,
                        xosc_clksrc = 0x3,
                        clksrc_gpin0 = 0x4,
                        clksrc_gpin1 = 0x5,
                        _,
                    },
                },
                padding: u24,
            }),
            ///  Clock divisor, can be changed on-the-fly
            CLK_SYS_DIV: mmio.Mmio(packed struct(u32) {
                ///  Fractional component of the divisor
                FRAC: u8,
                ///  Integer component of the divisor, 0 -> divide by 2^16
                INT: u24,
            }),
            ///  Indicates which SRC is currently selected by the glitchless mux (one-hot).
            ///  The glitchless multiplexer does not switch instantaneously (to avoid glitches), so software should poll this register to wait for the switch to complete. This register contains one decoded bit for each of the clock sources enumerated in the CTRL SRC field. At most one of these bits will be set at any time, indicating that clock is currently present at the output of the glitchless mux. Whilst switching is in progress, this register may briefly show all-0s.
            CLK_SYS_SELECTED: u32,
            ///  Clock control, can be changed on-the-fly (except for auxsrc)
            CLK_PERI_CTRL: mmio.Mmio(packed struct(u32) {
                reserved5: u5,
                ///  Selects the auxiliary clock source, will glitch when switching
                AUXSRC: packed union {
                    raw: u3,
                    value: enum(u3) {
                        clk_sys = 0x0,
                        clksrc_pll_sys = 0x1,
                        clksrc_pll_usb = 0x2,
                        rosc_clksrc_ph = 0x3,
                        xosc_clksrc = 0x4,
                        clksrc_gpin0 = 0x5,
                        clksrc_gpin1 = 0x6,
                        _,
                    },
                },
                reserved10: u2,
                ///  Asynchronously kills the clock generator
                KILL: u1,
                ///  Starts and stops the clock generator cleanly
                ENABLE: u1,
                padding: u20,
            }),
            reserved80: [4]u8,
            ///  Indicates which SRC is currently selected by the glitchless mux (one-hot).
            ///  This slice does not have a glitchless mux (only the AUX_SRC field is present, not SRC) so this register is hardwired to 0x1.
            CLK_PERI_SELECTED: u32,
            ///  Clock control, can be changed on-the-fly (except for auxsrc)
            CLK_USB_CTRL: mmio.Mmio(packed struct(u32) {
                reserved5: u5,
                ///  Selects the auxiliary clock source, will glitch when switching
                AUXSRC: packed union {
                    raw: u3,
                    value: enum(u3) {
                        clksrc_pll_usb = 0x0,
                        clksrc_pll_sys = 0x1,
                        rosc_clksrc_ph = 0x2,
                        xosc_clksrc = 0x3,
                        clksrc_gpin0 = 0x4,
                        clksrc_gpin1 = 0x5,
                        _,
                    },
                },
                reserved10: u2,
                ///  Asynchronously kills the clock generator
                KILL: u1,
                ///  Starts and stops the clock generator cleanly
                ENABLE: u1,
                reserved16: u4,
                ///  This delays the enable signal by up to 3 cycles of the input clock
                ///  This must be set before the clock is enabled to have any effect
                PHASE: u2,
                reserved20: u2,
                ///  An edge on this signal shifts the phase of the output by 1 cycle of the input clock
                ///  This can be done at any time
                NUDGE: u1,
                padding: u11,
            }),
            ///  Clock divisor, can be changed on-the-fly
            CLK_USB_DIV: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  Integer component of the divisor, 0 -> divide by 2^16
                INT: u2,
                padding: u22,
            }),
            ///  Indicates which SRC is currently selected by the glitchless mux (one-hot).
            ///  This slice does not have a glitchless mux (only the AUX_SRC field is present, not SRC) so this register is hardwired to 0x1.
            CLK_USB_SELECTED: u32,
            ///  Clock control, can be changed on-the-fly (except for auxsrc)
            CLK_ADC_CTRL: mmio.Mmio(packed struct(u32) {
                reserved5: u5,
                ///  Selects the auxiliary clock source, will glitch when switching
                AUXSRC: packed union {
                    raw: u3,
                    value: enum(u3) {
                        clksrc_pll_usb = 0x0,
                        clksrc_pll_sys = 0x1,
                        rosc_clksrc_ph = 0x2,
                        xosc_clksrc = 0x3,
                        clksrc_gpin0 = 0x4,
                        clksrc_gpin1 = 0x5,
                        _,
                    },
                },
                reserved10: u2,
                ///  Asynchronously kills the clock generator
                KILL: u1,
                ///  Starts and stops the clock generator cleanly
                ENABLE: u1,
                reserved16: u4,
                ///  This delays the enable signal by up to 3 cycles of the input clock
                ///  This must be set before the clock is enabled to have any effect
                PHASE: u2,
                reserved20: u2,
                ///  An edge on this signal shifts the phase of the output by 1 cycle of the input clock
                ///  This can be done at any time
                NUDGE: u1,
                padding: u11,
            }),
            ///  Clock divisor, can be changed on-the-fly
            CLK_ADC_DIV: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  Integer component of the divisor, 0 -> divide by 2^16
                INT: u2,
                padding: u22,
            }),
            ///  Indicates which SRC is currently selected by the glitchless mux (one-hot).
            ///  This slice does not have a glitchless mux (only the AUX_SRC field is present, not SRC) so this register is hardwired to 0x1.
            CLK_ADC_SELECTED: u32,
            ///  Clock control, can be changed on-the-fly (except for auxsrc)
            CLK_RTC_CTRL: mmio.Mmio(packed struct(u32) {
                reserved5: u5,
                ///  Selects the auxiliary clock source, will glitch when switching
                AUXSRC: packed union {
                    raw: u3,
                    value: enum(u3) {
                        clksrc_pll_usb = 0x0,
                        clksrc_pll_sys = 0x1,
                        rosc_clksrc_ph = 0x2,
                        xosc_clksrc = 0x3,
                        clksrc_gpin0 = 0x4,
                        clksrc_gpin1 = 0x5,
                        _,
                    },
                },
                reserved10: u2,
                ///  Asynchronously kills the clock generator
                KILL: u1,
                ///  Starts and stops the clock generator cleanly
                ENABLE: u1,
                reserved16: u4,
                ///  This delays the enable signal by up to 3 cycles of the input clock
                ///  This must be set before the clock is enabled to have any effect
                PHASE: u2,
                reserved20: u2,
                ///  An edge on this signal shifts the phase of the output by 1 cycle of the input clock
                ///  This can be done at any time
                NUDGE: u1,
                padding: u11,
            }),
            ///  Clock divisor, can be changed on-the-fly
            CLK_RTC_DIV: mmio.Mmio(packed struct(u32) {
                ///  Fractional component of the divisor
                FRAC: u8,
                ///  Integer component of the divisor, 0 -> divide by 2^16
                INT: u24,
            }),
            ///  Indicates which SRC is currently selected by the glitchless mux (one-hot).
            ///  This slice does not have a glitchless mux (only the AUX_SRC field is present, not SRC) so this register is hardwired to 0x1.
            CLK_RTC_SELECTED: u32,
            CLK_SYS_RESUS_CTRL: mmio.Mmio(packed struct(u32) {
                ///  This is expressed as a number of clk_ref cycles
                ///  and must be >= 2x clk_ref_freq/min_clk_tst_freq
                TIMEOUT: u8,
                ///  Enable resus
                ENABLE: u1,
                reserved12: u3,
                ///  Force a resus, for test purposes only
                FRCE: u1,
                reserved16: u3,
                ///  For clearing the resus after the fault that triggered it has been corrected
                CLEAR: u1,
                padding: u15,
            }),
            CLK_SYS_RESUS_STATUS: mmio.Mmio(packed struct(u32) {
                ///  Clock has been resuscitated, correct the error then send ctrl_clear=1
                RESUSSED: u1,
                padding: u31,
            }),
            ///  Reference clock frequency in kHz
            FC0_REF_KHZ: mmio.Mmio(packed struct(u32) {
                FC0_REF_KHZ: u20,
                padding: u12,
            }),
            ///  Minimum pass frequency in kHz. This is optional. Set to 0 if you are not using the pass/fail flags
            FC0_MIN_KHZ: mmio.Mmio(packed struct(u32) {
                FC0_MIN_KHZ: u25,
                padding: u7,
            }),
            ///  Maximum pass frequency in kHz. This is optional. Set to 0x1ffffff if you are not using the pass/fail flags
            FC0_MAX_KHZ: mmio.Mmio(packed struct(u32) {
                FC0_MAX_KHZ: u25,
                padding: u7,
            }),
            ///  Delays the start of frequency counting to allow the mux to settle
            ///  Delay is measured in multiples of the reference clock period
            FC0_DELAY: mmio.Mmio(packed struct(u32) {
                FC0_DELAY: u3,
                padding: u29,
            }),
            ///  The test interval is 0.98us * 2**interval, but let's call it 1us * 2**interval
            ///  The default gives a test interval of 250us
            FC0_INTERVAL: mmio.Mmio(packed struct(u32) {
                FC0_INTERVAL: u4,
                padding: u28,
            }),
            ///  Clock sent to frequency counter, set to 0 when not required
            ///  Writing to this register initiates the frequency count
            FC0_SRC: mmio.Mmio(packed struct(u32) {
                FC0_SRC: packed union {
                    raw: u8,
                    value: enum(u8) {
                        NULL = 0x0,
                        pll_sys_clksrc_primary = 0x1,
                        pll_usb_clksrc_primary = 0x2,
                        rosc_clksrc = 0x3,
                        rosc_clksrc_ph = 0x4,
                        xosc_clksrc = 0x5,
                        clksrc_gpin0 = 0x6,
                        clksrc_gpin1 = 0x7,
                        clk_ref = 0x8,
                        clk_sys = 0x9,
                        clk_peri = 0xa,
                        clk_usb = 0xb,
                        clk_adc = 0xc,
                        clk_rtc = 0xd,
                        _,
                    },
                },
                padding: u24,
            }),
            ///  Frequency counter status
            FC0_STATUS: mmio.Mmio(packed struct(u32) {
                ///  Test passed
                PASS: u1,
                reserved4: u3,
                ///  Test complete
                DONE: u1,
                reserved8: u3,
                ///  Test running
                RUNNING: u1,
                reserved12: u3,
                ///  Waiting for test clock to start
                WAITING: u1,
                reserved16: u3,
                ///  Test failed
                FAIL: u1,
                reserved20: u3,
                ///  Test clock slower than expected, only valid when status_done=1
                SLOW: u1,
                reserved24: u3,
                ///  Test clock faster than expected, only valid when status_done=1
                FAST: u1,
                reserved28: u3,
                ///  Test clock stopped during test
                DIED: u1,
                padding: u3,
            }),
            ///  Result of frequency measurement, only valid when status_done=1
            FC0_RESULT: mmio.Mmio(packed struct(u32) {
                FRAC: u5,
                KHZ: u25,
                padding: u2,
            }),
            ///  enable clock in wake mode
            WAKE_EN0: mmio.Mmio(packed struct(u32) {
                clk_sys_clocks: u1,
                clk_adc_adc: u1,
                clk_sys_adc: u1,
                clk_sys_busctrl: u1,
                clk_sys_busfabric: u1,
                clk_sys_dma: u1,
                clk_sys_i2c0: u1,
                clk_sys_i2c1: u1,
                clk_sys_io: u1,
                clk_sys_jtag: u1,
                clk_sys_vreg_and_chip_reset: u1,
                clk_sys_pads: u1,
                clk_sys_pio0: u1,
                clk_sys_pio1: u1,
                clk_sys_pll_sys: u1,
                clk_sys_pll_usb: u1,
                clk_sys_psm: u1,
                clk_sys_pwm: u1,
                clk_sys_resets: u1,
                clk_sys_rom: u1,
                clk_sys_rosc: u1,
                clk_rtc_rtc: u1,
                clk_sys_rtc: u1,
                clk_sys_sio: u1,
                clk_peri_spi0: u1,
                clk_sys_spi0: u1,
                clk_peri_spi1: u1,
                clk_sys_spi1: u1,
                clk_sys_sram0: u1,
                clk_sys_sram1: u1,
                clk_sys_sram2: u1,
                clk_sys_sram3: u1,
            }),
            ///  enable clock in wake mode
            WAKE_EN1: mmio.Mmio(packed struct(u32) {
                clk_sys_sram4: u1,
                clk_sys_sram5: u1,
                clk_sys_syscfg: u1,
                clk_sys_sysinfo: u1,
                clk_sys_tbman: u1,
                clk_sys_timer: u1,
                clk_peri_uart0: u1,
                clk_sys_uart0: u1,
                clk_peri_uart1: u1,
                clk_sys_uart1: u1,
                clk_sys_usbctrl: u1,
                clk_usb_usbctrl: u1,
                clk_sys_watchdog: u1,
                clk_sys_xip: u1,
                clk_sys_xosc: u1,
                padding: u17,
            }),
            ///  enable clock in sleep mode
            SLEEP_EN0: mmio.Mmio(packed struct(u32) {
                clk_sys_clocks: u1,
                clk_adc_adc: u1,
                clk_sys_adc: u1,
                clk_sys_busctrl: u1,
                clk_sys_busfabric: u1,
                clk_sys_dma: u1,
                clk_sys_i2c0: u1,
                clk_sys_i2c1: u1,
                clk_sys_io: u1,
                clk_sys_jtag: u1,
                clk_sys_vreg_and_chip_reset: u1,
                clk_sys_pads: u1,
                clk_sys_pio0: u1,
                clk_sys_pio1: u1,
                clk_sys_pll_sys: u1,
                clk_sys_pll_usb: u1,
                clk_sys_psm: u1,
                clk_sys_pwm: u1,
                clk_sys_resets: u1,
                clk_sys_rom: u1,
                clk_sys_rosc: u1,
                clk_rtc_rtc: u1,
                clk_sys_rtc: u1,
                clk_sys_sio: u1,
                clk_peri_spi0: u1,
                clk_sys_spi0: u1,
                clk_peri_spi1: u1,
                clk_sys_spi1: u1,
                clk_sys_sram0: u1,
                clk_sys_sram1: u1,
                clk_sys_sram2: u1,
                clk_sys_sram3: u1,
            }),
            ///  enable clock in sleep mode
            SLEEP_EN1: mmio.Mmio(packed struct(u32) {
                clk_sys_sram4: u1,
                clk_sys_sram5: u1,
                clk_sys_syscfg: u1,
                clk_sys_sysinfo: u1,
                clk_sys_tbman: u1,
                clk_sys_timer: u1,
                clk_peri_uart0: u1,
                clk_sys_uart0: u1,
                clk_peri_uart1: u1,
                clk_sys_uart1: u1,
                clk_sys_usbctrl: u1,
                clk_usb_usbctrl: u1,
                clk_sys_watchdog: u1,
                clk_sys_xip: u1,
                clk_sys_xosc: u1,
                padding: u17,
            }),
            ///  indicates the state of the clock enable
            ENABLED0: mmio.Mmio(packed struct(u32) {
                clk_sys_clocks: u1,
                clk_adc_adc: u1,
                clk_sys_adc: u1,
                clk_sys_busctrl: u1,
                clk_sys_busfabric: u1,
                clk_sys_dma: u1,
                clk_sys_i2c0: u1,
                clk_sys_i2c1: u1,
                clk_sys_io: u1,
                clk_sys_jtag: u1,
                clk_sys_vreg_and_chip_reset: u1,
                clk_sys_pads: u1,
                clk_sys_pio0: u1,
                clk_sys_pio1: u1,
                clk_sys_pll_sys: u1,
                clk_sys_pll_usb: u1,
                clk_sys_psm: u1,
                clk_sys_pwm: u1,
                clk_sys_resets: u1,
                clk_sys_rom: u1,
                clk_sys_rosc: u1,
                clk_rtc_rtc: u1,
                clk_sys_rtc: u1,
                clk_sys_sio: u1,
                clk_peri_spi0: u1,
                clk_sys_spi0: u1,
                clk_peri_spi1: u1,
                clk_sys_spi1: u1,
                clk_sys_sram0: u1,
                clk_sys_sram1: u1,
                clk_sys_sram2: u1,
                clk_sys_sram3: u1,
            }),
            ///  indicates the state of the clock enable
            ENABLED1: mmio.Mmio(packed struct(u32) {
                clk_sys_sram4: u1,
                clk_sys_sram5: u1,
                clk_sys_syscfg: u1,
                clk_sys_sysinfo: u1,
                clk_sys_tbman: u1,
                clk_sys_timer: u1,
                clk_peri_uart0: u1,
                clk_sys_uart0: u1,
                clk_peri_uart1: u1,
                clk_sys_uart1: u1,
                clk_sys_usbctrl: u1,
                clk_usb_usbctrl: u1,
                clk_sys_watchdog: u1,
                clk_sys_xip: u1,
                clk_sys_xosc: u1,
                padding: u17,
            }),
            ///  Raw Interrupts
            INTR: mmio.Mmio(packed struct(u32) {
                CLK_SYS_RESUS: u1,
                padding: u31,
            }),
            ///  Interrupt Enable
            INTE: mmio.Mmio(packed struct(u32) {
                CLK_SYS_RESUS: u1,
                padding: u31,
            }),
            ///  Interrupt Force
            INTF: mmio.Mmio(packed struct(u32) {
                CLK_SYS_RESUS: u1,
                padding: u31,
            }),
            ///  Interrupt status after masking & forcing
            INTS: mmio.Mmio(packed struct(u32) {
                CLK_SYS_RESUS: u1,
                padding: u31,
            }),
        };

        pub const RESETS = extern struct {
            ///  Reset control. If a bit is set it means the peripheral is in reset. 0 means the peripheral's reset is deasserted.
            RESET: mmio.Mmio(packed struct(u32) {
                adc: u1,
                busctrl: u1,
                dma: u1,
                i2c0: u1,
                i2c1: u1,
                io_bank0: u1,
                io_qspi: u1,
                jtag: u1,
                pads_bank0: u1,
                pads_qspi: u1,
                pio0: u1,
                pio1: u1,
                pll_sys: u1,
                pll_usb: u1,
                pwm: u1,
                rtc: u1,
                spi0: u1,
                spi1: u1,
                syscfg: u1,
                sysinfo: u1,
                tbman: u1,
                timer: u1,
                uart0: u1,
                uart1: u1,
                usbctrl: u1,
                padding: u7,
            }),
            ///  Watchdog select. If a bit is set then the watchdog will reset this peripheral when the watchdog fires.
            WDSEL: mmio.Mmio(packed struct(u32) {
                adc: u1,
                busctrl: u1,
                dma: u1,
                i2c0: u1,
                i2c1: u1,
                io_bank0: u1,
                io_qspi: u1,
                jtag: u1,
                pads_bank0: u1,
                pads_qspi: u1,
                pio0: u1,
                pio1: u1,
                pll_sys: u1,
                pll_usb: u1,
                pwm: u1,
                rtc: u1,
                spi0: u1,
                spi1: u1,
                syscfg: u1,
                sysinfo: u1,
                tbman: u1,
                timer: u1,
                uart0: u1,
                uart1: u1,
                usbctrl: u1,
                padding: u7,
            }),
            ///  Reset done. If a bit is set then a reset done signal has been returned by the peripheral. This indicates that the peripheral's registers are ready to be accessed.
            RESET_DONE: mmio.Mmio(packed struct(u32) {
                adc: u1,
                busctrl: u1,
                dma: u1,
                i2c0: u1,
                i2c1: u1,
                io_bank0: u1,
                io_qspi: u1,
                jtag: u1,
                pads_bank0: u1,
                pads_qspi: u1,
                pio0: u1,
                pio1: u1,
                pll_sys: u1,
                pll_usb: u1,
                pwm: u1,
                rtc: u1,
                spi0: u1,
                spi1: u1,
                syscfg: u1,
                sysinfo: u1,
                tbman: u1,
                timer: u1,
                uart0: u1,
                uart1: u1,
                usbctrl: u1,
                padding: u7,
            }),
        };

        pub const PSM = extern struct {
            ///  Force block out of reset (i.e. power it on)
            FRCE_ON: mmio.Mmio(packed struct(u32) {
                rosc: u1,
                xosc: u1,
                clocks: u1,
                resets: u1,
                busfabric: u1,
                rom: u1,
                sram0: u1,
                sram1: u1,
                sram2: u1,
                sram3: u1,
                sram4: u1,
                sram5: u1,
                xip: u1,
                vreg_and_chip_reset: u1,
                sio: u1,
                proc0: u1,
                proc1: u1,
                padding: u15,
            }),
            ///  Force into reset (i.e. power it off)
            FRCE_OFF: mmio.Mmio(packed struct(u32) {
                rosc: u1,
                xosc: u1,
                clocks: u1,
                resets: u1,
                busfabric: u1,
                rom: u1,
                sram0: u1,
                sram1: u1,
                sram2: u1,
                sram3: u1,
                sram4: u1,
                sram5: u1,
                xip: u1,
                vreg_and_chip_reset: u1,
                sio: u1,
                proc0: u1,
                proc1: u1,
                padding: u15,
            }),
            ///  Set to 1 if this peripheral should be reset when the watchdog fires.
            WDSEL: mmio.Mmio(packed struct(u32) {
                rosc: u1,
                xosc: u1,
                clocks: u1,
                resets: u1,
                busfabric: u1,
                rom: u1,
                sram0: u1,
                sram1: u1,
                sram2: u1,
                sram3: u1,
                sram4: u1,
                sram5: u1,
                xip: u1,
                vreg_and_chip_reset: u1,
                sio: u1,
                proc0: u1,
                proc1: u1,
                padding: u15,
            }),
            ///  Indicates the peripheral's registers are ready to access.
            DONE: mmio.Mmio(packed struct(u32) {
                rosc: u1,
                xosc: u1,
                clocks: u1,
                resets: u1,
                busfabric: u1,
                rom: u1,
                sram0: u1,
                sram1: u1,
                sram2: u1,
                sram3: u1,
                sram4: u1,
                sram5: u1,
                xip: u1,
                vreg_and_chip_reset: u1,
                sio: u1,
                proc0: u1,
                proc1: u1,
                padding: u15,
            }),
        };

        pub const IO_BANK0 = extern struct {
            ///  GPIO status
            GPIO0_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO0_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        jtag_tck = 0x0,
                        spi0_rx = 0x1,
                        uart0_tx = 0x2,
                        i2c0_sda = 0x3,
                        pwm_a_0 = 0x4,
                        sio_0 = 0x5,
                        pio0_0 = 0x6,
                        pio1_0 = 0x7,
                        usb_muxing_overcurr_detect = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO1_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO1_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        jtag_tms = 0x0,
                        spi0_ss_n = 0x1,
                        uart0_rx = 0x2,
                        i2c0_scl = 0x3,
                        pwm_b_0 = 0x4,
                        sio_1 = 0x5,
                        pio0_1 = 0x6,
                        pio1_1 = 0x7,
                        usb_muxing_vbus_detect = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO2_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO2_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        jtag_tdi = 0x0,
                        spi0_sclk = 0x1,
                        uart0_cts = 0x2,
                        i2c1_sda = 0x3,
                        pwm_a_1 = 0x4,
                        sio_2 = 0x5,
                        pio0_2 = 0x6,
                        pio1_2 = 0x7,
                        usb_muxing_vbus_en = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO3_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO3_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        jtag_tdo = 0x0,
                        spi0_tx = 0x1,
                        uart0_rts = 0x2,
                        i2c1_scl = 0x3,
                        pwm_b_1 = 0x4,
                        sio_3 = 0x5,
                        pio0_3 = 0x6,
                        pio1_3 = 0x7,
                        usb_muxing_overcurr_detect = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO4_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO4_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi0_rx = 0x1,
                        uart1_tx = 0x2,
                        i2c0_sda = 0x3,
                        pwm_a_2 = 0x4,
                        sio_4 = 0x5,
                        pio0_4 = 0x6,
                        pio1_4 = 0x7,
                        usb_muxing_vbus_detect = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO5_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO5_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi0_ss_n = 0x1,
                        uart1_rx = 0x2,
                        i2c0_scl = 0x3,
                        pwm_b_2 = 0x4,
                        sio_5 = 0x5,
                        pio0_5 = 0x6,
                        pio1_5 = 0x7,
                        usb_muxing_vbus_en = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO6_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO6_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi0_sclk = 0x1,
                        uart1_cts = 0x2,
                        i2c1_sda = 0x3,
                        pwm_a_3 = 0x4,
                        sio_6 = 0x5,
                        pio0_6 = 0x6,
                        pio1_6 = 0x7,
                        usb_muxing_extphy_softcon = 0x8,
                        usb_muxing_overcurr_detect = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO7_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO7_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi0_tx = 0x1,
                        uart1_rts = 0x2,
                        i2c1_scl = 0x3,
                        pwm_b_3 = 0x4,
                        sio_7 = 0x5,
                        pio0_7 = 0x6,
                        pio1_7 = 0x7,
                        usb_muxing_extphy_oe_n = 0x8,
                        usb_muxing_vbus_detect = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO8_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO8_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi1_rx = 0x1,
                        uart1_tx = 0x2,
                        i2c0_sda = 0x3,
                        pwm_a_4 = 0x4,
                        sio_8 = 0x5,
                        pio0_8 = 0x6,
                        pio1_8 = 0x7,
                        usb_muxing_extphy_rcv = 0x8,
                        usb_muxing_vbus_en = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO9_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO9_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi1_ss_n = 0x1,
                        uart1_rx = 0x2,
                        i2c0_scl = 0x3,
                        pwm_b_4 = 0x4,
                        sio_9 = 0x5,
                        pio0_9 = 0x6,
                        pio1_9 = 0x7,
                        usb_muxing_extphy_vp = 0x8,
                        usb_muxing_overcurr_detect = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO10_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO10_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi1_sclk = 0x1,
                        uart1_cts = 0x2,
                        i2c1_sda = 0x3,
                        pwm_a_5 = 0x4,
                        sio_10 = 0x5,
                        pio0_10 = 0x6,
                        pio1_10 = 0x7,
                        usb_muxing_extphy_vm = 0x8,
                        usb_muxing_vbus_detect = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO11_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO11_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi1_tx = 0x1,
                        uart1_rts = 0x2,
                        i2c1_scl = 0x3,
                        pwm_b_5 = 0x4,
                        sio_11 = 0x5,
                        pio0_11 = 0x6,
                        pio1_11 = 0x7,
                        usb_muxing_extphy_suspnd = 0x8,
                        usb_muxing_vbus_en = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO12_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO12_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi1_rx = 0x1,
                        uart0_tx = 0x2,
                        i2c0_sda = 0x3,
                        pwm_a_6 = 0x4,
                        sio_12 = 0x5,
                        pio0_12 = 0x6,
                        pio1_12 = 0x7,
                        usb_muxing_extphy_speed = 0x8,
                        usb_muxing_overcurr_detect = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO13_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO13_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi1_ss_n = 0x1,
                        uart0_rx = 0x2,
                        i2c0_scl = 0x3,
                        pwm_b_6 = 0x4,
                        sio_13 = 0x5,
                        pio0_13 = 0x6,
                        pio1_13 = 0x7,
                        usb_muxing_extphy_vpo = 0x8,
                        usb_muxing_vbus_detect = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO14_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO14_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi1_sclk = 0x1,
                        uart0_cts = 0x2,
                        i2c1_sda = 0x3,
                        pwm_a_7 = 0x4,
                        sio_14 = 0x5,
                        pio0_14 = 0x6,
                        pio1_14 = 0x7,
                        usb_muxing_extphy_vmo = 0x8,
                        usb_muxing_vbus_en = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO15_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO15_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi1_tx = 0x1,
                        uart0_rts = 0x2,
                        i2c1_scl = 0x3,
                        pwm_b_7 = 0x4,
                        sio_15 = 0x5,
                        pio0_15 = 0x6,
                        pio1_15 = 0x7,
                        usb_muxing_digital_dp = 0x8,
                        usb_muxing_overcurr_detect = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO16_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO16_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi0_rx = 0x1,
                        uart0_tx = 0x2,
                        i2c0_sda = 0x3,
                        pwm_a_0 = 0x4,
                        sio_16 = 0x5,
                        pio0_16 = 0x6,
                        pio1_16 = 0x7,
                        usb_muxing_digital_dm = 0x8,
                        usb_muxing_vbus_detect = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO17_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO17_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi0_ss_n = 0x1,
                        uart0_rx = 0x2,
                        i2c0_scl = 0x3,
                        pwm_b_0 = 0x4,
                        sio_17 = 0x5,
                        pio0_17 = 0x6,
                        pio1_17 = 0x7,
                        usb_muxing_vbus_en = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO18_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO18_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi0_sclk = 0x1,
                        uart0_cts = 0x2,
                        i2c1_sda = 0x3,
                        pwm_a_1 = 0x4,
                        sio_18 = 0x5,
                        pio0_18 = 0x6,
                        pio1_18 = 0x7,
                        usb_muxing_overcurr_detect = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO19_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO19_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi0_tx = 0x1,
                        uart0_rts = 0x2,
                        i2c1_scl = 0x3,
                        pwm_b_1 = 0x4,
                        sio_19 = 0x5,
                        pio0_19 = 0x6,
                        pio1_19 = 0x7,
                        usb_muxing_vbus_detect = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO20_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO20_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi0_rx = 0x1,
                        uart1_tx = 0x2,
                        i2c0_sda = 0x3,
                        pwm_a_2 = 0x4,
                        sio_20 = 0x5,
                        pio0_20 = 0x6,
                        pio1_20 = 0x7,
                        clocks_gpin_0 = 0x8,
                        usb_muxing_vbus_en = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO21_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO21_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi0_ss_n = 0x1,
                        uart1_rx = 0x2,
                        i2c0_scl = 0x3,
                        pwm_b_2 = 0x4,
                        sio_21 = 0x5,
                        pio0_21 = 0x6,
                        pio1_21 = 0x7,
                        clocks_gpout_0 = 0x8,
                        usb_muxing_overcurr_detect = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO22_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO22_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi0_sclk = 0x1,
                        uart1_cts = 0x2,
                        i2c1_sda = 0x3,
                        pwm_a_3 = 0x4,
                        sio_22 = 0x5,
                        pio0_22 = 0x6,
                        pio1_22 = 0x7,
                        clocks_gpin_1 = 0x8,
                        usb_muxing_vbus_detect = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO23_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO23_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi0_tx = 0x1,
                        uart1_rts = 0x2,
                        i2c1_scl = 0x3,
                        pwm_b_3 = 0x4,
                        sio_23 = 0x5,
                        pio0_23 = 0x6,
                        pio1_23 = 0x7,
                        clocks_gpout_1 = 0x8,
                        usb_muxing_vbus_en = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO24_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO24_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi1_rx = 0x1,
                        uart1_tx = 0x2,
                        i2c0_sda = 0x3,
                        pwm_a_4 = 0x4,
                        sio_24 = 0x5,
                        pio0_24 = 0x6,
                        pio1_24 = 0x7,
                        clocks_gpout_2 = 0x8,
                        usb_muxing_overcurr_detect = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO25_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO25_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi1_ss_n = 0x1,
                        uart1_rx = 0x2,
                        i2c0_scl = 0x3,
                        pwm_b_4 = 0x4,
                        sio_25 = 0x5,
                        pio0_25 = 0x6,
                        pio1_25 = 0x7,
                        clocks_gpout_3 = 0x8,
                        usb_muxing_vbus_detect = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO26_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO26_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi1_sclk = 0x1,
                        uart1_cts = 0x2,
                        i2c1_sda = 0x3,
                        pwm_a_5 = 0x4,
                        sio_26 = 0x5,
                        pio0_26 = 0x6,
                        pio1_26 = 0x7,
                        usb_muxing_vbus_en = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO27_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO27_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi1_tx = 0x1,
                        uart1_rts = 0x2,
                        i2c1_scl = 0x3,
                        pwm_b_5 = 0x4,
                        sio_27 = 0x5,
                        pio0_27 = 0x6,
                        pio1_27 = 0x7,
                        usb_muxing_overcurr_detect = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO28_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO28_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi1_rx = 0x1,
                        uart0_tx = 0x2,
                        i2c0_sda = 0x3,
                        pwm_a_6 = 0x4,
                        sio_28 = 0x5,
                        pio0_28 = 0x6,
                        pio1_28 = 0x7,
                        usb_muxing_vbus_detect = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO29_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO29_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        spi1_ss_n = 0x1,
                        uart0_rx = 0x2,
                        i2c0_scl = 0x3,
                        pwm_b_6 = 0x4,
                        sio_29 = 0x5,
                        pio0_29 = 0x6,
                        pio1_29 = 0x7,
                        usb_muxing_vbus_en = 0x9,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  Raw Interrupts
            INTR0: mmio.Mmio(packed struct(u32) {
                GPIO0_LEVEL_LOW: u1,
                GPIO0_LEVEL_HIGH: u1,
                GPIO0_EDGE_LOW: u1,
                GPIO0_EDGE_HIGH: u1,
                GPIO1_LEVEL_LOW: u1,
                GPIO1_LEVEL_HIGH: u1,
                GPIO1_EDGE_LOW: u1,
                GPIO1_EDGE_HIGH: u1,
                GPIO2_LEVEL_LOW: u1,
                GPIO2_LEVEL_HIGH: u1,
                GPIO2_EDGE_LOW: u1,
                GPIO2_EDGE_HIGH: u1,
                GPIO3_LEVEL_LOW: u1,
                GPIO3_LEVEL_HIGH: u1,
                GPIO3_EDGE_LOW: u1,
                GPIO3_EDGE_HIGH: u1,
                GPIO4_LEVEL_LOW: u1,
                GPIO4_LEVEL_HIGH: u1,
                GPIO4_EDGE_LOW: u1,
                GPIO4_EDGE_HIGH: u1,
                GPIO5_LEVEL_LOW: u1,
                GPIO5_LEVEL_HIGH: u1,
                GPIO5_EDGE_LOW: u1,
                GPIO5_EDGE_HIGH: u1,
                GPIO6_LEVEL_LOW: u1,
                GPIO6_LEVEL_HIGH: u1,
                GPIO6_EDGE_LOW: u1,
                GPIO6_EDGE_HIGH: u1,
                GPIO7_LEVEL_LOW: u1,
                GPIO7_LEVEL_HIGH: u1,
                GPIO7_EDGE_LOW: u1,
                GPIO7_EDGE_HIGH: u1,
            }),
            ///  Raw Interrupts
            INTR1: mmio.Mmio(packed struct(u32) {
                GPIO8_LEVEL_LOW: u1,
                GPIO8_LEVEL_HIGH: u1,
                GPIO8_EDGE_LOW: u1,
                GPIO8_EDGE_HIGH: u1,
                GPIO9_LEVEL_LOW: u1,
                GPIO9_LEVEL_HIGH: u1,
                GPIO9_EDGE_LOW: u1,
                GPIO9_EDGE_HIGH: u1,
                GPIO10_LEVEL_LOW: u1,
                GPIO10_LEVEL_HIGH: u1,
                GPIO10_EDGE_LOW: u1,
                GPIO10_EDGE_HIGH: u1,
                GPIO11_LEVEL_LOW: u1,
                GPIO11_LEVEL_HIGH: u1,
                GPIO11_EDGE_LOW: u1,
                GPIO11_EDGE_HIGH: u1,
                GPIO12_LEVEL_LOW: u1,
                GPIO12_LEVEL_HIGH: u1,
                GPIO12_EDGE_LOW: u1,
                GPIO12_EDGE_HIGH: u1,
                GPIO13_LEVEL_LOW: u1,
                GPIO13_LEVEL_HIGH: u1,
                GPIO13_EDGE_LOW: u1,
                GPIO13_EDGE_HIGH: u1,
                GPIO14_LEVEL_LOW: u1,
                GPIO14_LEVEL_HIGH: u1,
                GPIO14_EDGE_LOW: u1,
                GPIO14_EDGE_HIGH: u1,
                GPIO15_LEVEL_LOW: u1,
                GPIO15_LEVEL_HIGH: u1,
                GPIO15_EDGE_LOW: u1,
                GPIO15_EDGE_HIGH: u1,
            }),
            ///  Raw Interrupts
            INTR2: mmio.Mmio(packed struct(u32) {
                GPIO16_LEVEL_LOW: u1,
                GPIO16_LEVEL_HIGH: u1,
                GPIO16_EDGE_LOW: u1,
                GPIO16_EDGE_HIGH: u1,
                GPIO17_LEVEL_LOW: u1,
                GPIO17_LEVEL_HIGH: u1,
                GPIO17_EDGE_LOW: u1,
                GPIO17_EDGE_HIGH: u1,
                GPIO18_LEVEL_LOW: u1,
                GPIO18_LEVEL_HIGH: u1,
                GPIO18_EDGE_LOW: u1,
                GPIO18_EDGE_HIGH: u1,
                GPIO19_LEVEL_LOW: u1,
                GPIO19_LEVEL_HIGH: u1,
                GPIO19_EDGE_LOW: u1,
                GPIO19_EDGE_HIGH: u1,
                GPIO20_LEVEL_LOW: u1,
                GPIO20_LEVEL_HIGH: u1,
                GPIO20_EDGE_LOW: u1,
                GPIO20_EDGE_HIGH: u1,
                GPIO21_LEVEL_LOW: u1,
                GPIO21_LEVEL_HIGH: u1,
                GPIO21_EDGE_LOW: u1,
                GPIO21_EDGE_HIGH: u1,
                GPIO22_LEVEL_LOW: u1,
                GPIO22_LEVEL_HIGH: u1,
                GPIO22_EDGE_LOW: u1,
                GPIO22_EDGE_HIGH: u1,
                GPIO23_LEVEL_LOW: u1,
                GPIO23_LEVEL_HIGH: u1,
                GPIO23_EDGE_LOW: u1,
                GPIO23_EDGE_HIGH: u1,
            }),
            ///  Raw Interrupts
            INTR3: mmio.Mmio(packed struct(u32) {
                GPIO24_LEVEL_LOW: u1,
                GPIO24_LEVEL_HIGH: u1,
                GPIO24_EDGE_LOW: u1,
                GPIO24_EDGE_HIGH: u1,
                GPIO25_LEVEL_LOW: u1,
                GPIO25_LEVEL_HIGH: u1,
                GPIO25_EDGE_LOW: u1,
                GPIO25_EDGE_HIGH: u1,
                GPIO26_LEVEL_LOW: u1,
                GPIO26_LEVEL_HIGH: u1,
                GPIO26_EDGE_LOW: u1,
                GPIO26_EDGE_HIGH: u1,
                GPIO27_LEVEL_LOW: u1,
                GPIO27_LEVEL_HIGH: u1,
                GPIO27_EDGE_LOW: u1,
                GPIO27_EDGE_HIGH: u1,
                GPIO28_LEVEL_LOW: u1,
                GPIO28_LEVEL_HIGH: u1,
                GPIO28_EDGE_LOW: u1,
                GPIO28_EDGE_HIGH: u1,
                GPIO29_LEVEL_LOW: u1,
                GPIO29_LEVEL_HIGH: u1,
                GPIO29_EDGE_LOW: u1,
                GPIO29_EDGE_HIGH: u1,
                padding: u8,
            }),
            ///  Interrupt Enable for proc0
            PROC0_INTE0: mmio.Mmio(packed struct(u32) {
                GPIO0_LEVEL_LOW: u1,
                GPIO0_LEVEL_HIGH: u1,
                GPIO0_EDGE_LOW: u1,
                GPIO0_EDGE_HIGH: u1,
                GPIO1_LEVEL_LOW: u1,
                GPIO1_LEVEL_HIGH: u1,
                GPIO1_EDGE_LOW: u1,
                GPIO1_EDGE_HIGH: u1,
                GPIO2_LEVEL_LOW: u1,
                GPIO2_LEVEL_HIGH: u1,
                GPIO2_EDGE_LOW: u1,
                GPIO2_EDGE_HIGH: u1,
                GPIO3_LEVEL_LOW: u1,
                GPIO3_LEVEL_HIGH: u1,
                GPIO3_EDGE_LOW: u1,
                GPIO3_EDGE_HIGH: u1,
                GPIO4_LEVEL_LOW: u1,
                GPIO4_LEVEL_HIGH: u1,
                GPIO4_EDGE_LOW: u1,
                GPIO4_EDGE_HIGH: u1,
                GPIO5_LEVEL_LOW: u1,
                GPIO5_LEVEL_HIGH: u1,
                GPIO5_EDGE_LOW: u1,
                GPIO5_EDGE_HIGH: u1,
                GPIO6_LEVEL_LOW: u1,
                GPIO6_LEVEL_HIGH: u1,
                GPIO6_EDGE_LOW: u1,
                GPIO6_EDGE_HIGH: u1,
                GPIO7_LEVEL_LOW: u1,
                GPIO7_LEVEL_HIGH: u1,
                GPIO7_EDGE_LOW: u1,
                GPIO7_EDGE_HIGH: u1,
            }),
            ///  Interrupt Enable for proc0
            PROC0_INTE1: mmio.Mmio(packed struct(u32) {
                GPIO8_LEVEL_LOW: u1,
                GPIO8_LEVEL_HIGH: u1,
                GPIO8_EDGE_LOW: u1,
                GPIO8_EDGE_HIGH: u1,
                GPIO9_LEVEL_LOW: u1,
                GPIO9_LEVEL_HIGH: u1,
                GPIO9_EDGE_LOW: u1,
                GPIO9_EDGE_HIGH: u1,
                GPIO10_LEVEL_LOW: u1,
                GPIO10_LEVEL_HIGH: u1,
                GPIO10_EDGE_LOW: u1,
                GPIO10_EDGE_HIGH: u1,
                GPIO11_LEVEL_LOW: u1,
                GPIO11_LEVEL_HIGH: u1,
                GPIO11_EDGE_LOW: u1,
                GPIO11_EDGE_HIGH: u1,
                GPIO12_LEVEL_LOW: u1,
                GPIO12_LEVEL_HIGH: u1,
                GPIO12_EDGE_LOW: u1,
                GPIO12_EDGE_HIGH: u1,
                GPIO13_LEVEL_LOW: u1,
                GPIO13_LEVEL_HIGH: u1,
                GPIO13_EDGE_LOW: u1,
                GPIO13_EDGE_HIGH: u1,
                GPIO14_LEVEL_LOW: u1,
                GPIO14_LEVEL_HIGH: u1,
                GPIO14_EDGE_LOW: u1,
                GPIO14_EDGE_HIGH: u1,
                GPIO15_LEVEL_LOW: u1,
                GPIO15_LEVEL_HIGH: u1,
                GPIO15_EDGE_LOW: u1,
                GPIO15_EDGE_HIGH: u1,
            }),
            ///  Interrupt Enable for proc0
            PROC0_INTE2: mmio.Mmio(packed struct(u32) {
                GPIO16_LEVEL_LOW: u1,
                GPIO16_LEVEL_HIGH: u1,
                GPIO16_EDGE_LOW: u1,
                GPIO16_EDGE_HIGH: u1,
                GPIO17_LEVEL_LOW: u1,
                GPIO17_LEVEL_HIGH: u1,
                GPIO17_EDGE_LOW: u1,
                GPIO17_EDGE_HIGH: u1,
                GPIO18_LEVEL_LOW: u1,
                GPIO18_LEVEL_HIGH: u1,
                GPIO18_EDGE_LOW: u1,
                GPIO18_EDGE_HIGH: u1,
                GPIO19_LEVEL_LOW: u1,
                GPIO19_LEVEL_HIGH: u1,
                GPIO19_EDGE_LOW: u1,
                GPIO19_EDGE_HIGH: u1,
                GPIO20_LEVEL_LOW: u1,
                GPIO20_LEVEL_HIGH: u1,
                GPIO20_EDGE_LOW: u1,
                GPIO20_EDGE_HIGH: u1,
                GPIO21_LEVEL_LOW: u1,
                GPIO21_LEVEL_HIGH: u1,
                GPIO21_EDGE_LOW: u1,
                GPIO21_EDGE_HIGH: u1,
                GPIO22_LEVEL_LOW: u1,
                GPIO22_LEVEL_HIGH: u1,
                GPIO22_EDGE_LOW: u1,
                GPIO22_EDGE_HIGH: u1,
                GPIO23_LEVEL_LOW: u1,
                GPIO23_LEVEL_HIGH: u1,
                GPIO23_EDGE_LOW: u1,
                GPIO23_EDGE_HIGH: u1,
            }),
            ///  Interrupt Enable for proc0
            PROC0_INTE3: mmio.Mmio(packed struct(u32) {
                GPIO24_LEVEL_LOW: u1,
                GPIO24_LEVEL_HIGH: u1,
                GPIO24_EDGE_LOW: u1,
                GPIO24_EDGE_HIGH: u1,
                GPIO25_LEVEL_LOW: u1,
                GPIO25_LEVEL_HIGH: u1,
                GPIO25_EDGE_LOW: u1,
                GPIO25_EDGE_HIGH: u1,
                GPIO26_LEVEL_LOW: u1,
                GPIO26_LEVEL_HIGH: u1,
                GPIO26_EDGE_LOW: u1,
                GPIO26_EDGE_HIGH: u1,
                GPIO27_LEVEL_LOW: u1,
                GPIO27_LEVEL_HIGH: u1,
                GPIO27_EDGE_LOW: u1,
                GPIO27_EDGE_HIGH: u1,
                GPIO28_LEVEL_LOW: u1,
                GPIO28_LEVEL_HIGH: u1,
                GPIO28_EDGE_LOW: u1,
                GPIO28_EDGE_HIGH: u1,
                GPIO29_LEVEL_LOW: u1,
                GPIO29_LEVEL_HIGH: u1,
                GPIO29_EDGE_LOW: u1,
                GPIO29_EDGE_HIGH: u1,
                padding: u8,
            }),
            ///  Interrupt Force for proc0
            PROC0_INTF0: mmio.Mmio(packed struct(u32) {
                GPIO0_LEVEL_LOW: u1,
                GPIO0_LEVEL_HIGH: u1,
                GPIO0_EDGE_LOW: u1,
                GPIO0_EDGE_HIGH: u1,
                GPIO1_LEVEL_LOW: u1,
                GPIO1_LEVEL_HIGH: u1,
                GPIO1_EDGE_LOW: u1,
                GPIO1_EDGE_HIGH: u1,
                GPIO2_LEVEL_LOW: u1,
                GPIO2_LEVEL_HIGH: u1,
                GPIO2_EDGE_LOW: u1,
                GPIO2_EDGE_HIGH: u1,
                GPIO3_LEVEL_LOW: u1,
                GPIO3_LEVEL_HIGH: u1,
                GPIO3_EDGE_LOW: u1,
                GPIO3_EDGE_HIGH: u1,
                GPIO4_LEVEL_LOW: u1,
                GPIO4_LEVEL_HIGH: u1,
                GPIO4_EDGE_LOW: u1,
                GPIO4_EDGE_HIGH: u1,
                GPIO5_LEVEL_LOW: u1,
                GPIO5_LEVEL_HIGH: u1,
                GPIO5_EDGE_LOW: u1,
                GPIO5_EDGE_HIGH: u1,
                GPIO6_LEVEL_LOW: u1,
                GPIO6_LEVEL_HIGH: u1,
                GPIO6_EDGE_LOW: u1,
                GPIO6_EDGE_HIGH: u1,
                GPIO7_LEVEL_LOW: u1,
                GPIO7_LEVEL_HIGH: u1,
                GPIO7_EDGE_LOW: u1,
                GPIO7_EDGE_HIGH: u1,
            }),
            ///  Interrupt Force for proc0
            PROC0_INTF1: mmio.Mmio(packed struct(u32) {
                GPIO8_LEVEL_LOW: u1,
                GPIO8_LEVEL_HIGH: u1,
                GPIO8_EDGE_LOW: u1,
                GPIO8_EDGE_HIGH: u1,
                GPIO9_LEVEL_LOW: u1,
                GPIO9_LEVEL_HIGH: u1,
                GPIO9_EDGE_LOW: u1,
                GPIO9_EDGE_HIGH: u1,
                GPIO10_LEVEL_LOW: u1,
                GPIO10_LEVEL_HIGH: u1,
                GPIO10_EDGE_LOW: u1,
                GPIO10_EDGE_HIGH: u1,
                GPIO11_LEVEL_LOW: u1,
                GPIO11_LEVEL_HIGH: u1,
                GPIO11_EDGE_LOW: u1,
                GPIO11_EDGE_HIGH: u1,
                GPIO12_LEVEL_LOW: u1,
                GPIO12_LEVEL_HIGH: u1,
                GPIO12_EDGE_LOW: u1,
                GPIO12_EDGE_HIGH: u1,
                GPIO13_LEVEL_LOW: u1,
                GPIO13_LEVEL_HIGH: u1,
                GPIO13_EDGE_LOW: u1,
                GPIO13_EDGE_HIGH: u1,
                GPIO14_LEVEL_LOW: u1,
                GPIO14_LEVEL_HIGH: u1,
                GPIO14_EDGE_LOW: u1,
                GPIO14_EDGE_HIGH: u1,
                GPIO15_LEVEL_LOW: u1,
                GPIO15_LEVEL_HIGH: u1,
                GPIO15_EDGE_LOW: u1,
                GPIO15_EDGE_HIGH: u1,
            }),
            ///  Interrupt Force for proc0
            PROC0_INTF2: mmio.Mmio(packed struct(u32) {
                GPIO16_LEVEL_LOW: u1,
                GPIO16_LEVEL_HIGH: u1,
                GPIO16_EDGE_LOW: u1,
                GPIO16_EDGE_HIGH: u1,
                GPIO17_LEVEL_LOW: u1,
                GPIO17_LEVEL_HIGH: u1,
                GPIO17_EDGE_LOW: u1,
                GPIO17_EDGE_HIGH: u1,
                GPIO18_LEVEL_LOW: u1,
                GPIO18_LEVEL_HIGH: u1,
                GPIO18_EDGE_LOW: u1,
                GPIO18_EDGE_HIGH: u1,
                GPIO19_LEVEL_LOW: u1,
                GPIO19_LEVEL_HIGH: u1,
                GPIO19_EDGE_LOW: u1,
                GPIO19_EDGE_HIGH: u1,
                GPIO20_LEVEL_LOW: u1,
                GPIO20_LEVEL_HIGH: u1,
                GPIO20_EDGE_LOW: u1,
                GPIO20_EDGE_HIGH: u1,
                GPIO21_LEVEL_LOW: u1,
                GPIO21_LEVEL_HIGH: u1,
                GPIO21_EDGE_LOW: u1,
                GPIO21_EDGE_HIGH: u1,
                GPIO22_LEVEL_LOW: u1,
                GPIO22_LEVEL_HIGH: u1,
                GPIO22_EDGE_LOW: u1,
                GPIO22_EDGE_HIGH: u1,
                GPIO23_LEVEL_LOW: u1,
                GPIO23_LEVEL_HIGH: u1,
                GPIO23_EDGE_LOW: u1,
                GPIO23_EDGE_HIGH: u1,
            }),
            ///  Interrupt Force for proc0
            PROC0_INTF3: mmio.Mmio(packed struct(u32) {
                GPIO24_LEVEL_LOW: u1,
                GPIO24_LEVEL_HIGH: u1,
                GPIO24_EDGE_LOW: u1,
                GPIO24_EDGE_HIGH: u1,
                GPIO25_LEVEL_LOW: u1,
                GPIO25_LEVEL_HIGH: u1,
                GPIO25_EDGE_LOW: u1,
                GPIO25_EDGE_HIGH: u1,
                GPIO26_LEVEL_LOW: u1,
                GPIO26_LEVEL_HIGH: u1,
                GPIO26_EDGE_LOW: u1,
                GPIO26_EDGE_HIGH: u1,
                GPIO27_LEVEL_LOW: u1,
                GPIO27_LEVEL_HIGH: u1,
                GPIO27_EDGE_LOW: u1,
                GPIO27_EDGE_HIGH: u1,
                GPIO28_LEVEL_LOW: u1,
                GPIO28_LEVEL_HIGH: u1,
                GPIO28_EDGE_LOW: u1,
                GPIO28_EDGE_HIGH: u1,
                GPIO29_LEVEL_LOW: u1,
                GPIO29_LEVEL_HIGH: u1,
                GPIO29_EDGE_LOW: u1,
                GPIO29_EDGE_HIGH: u1,
                padding: u8,
            }),
            ///  Interrupt status after masking & forcing for proc0
            PROC0_INTS0: mmio.Mmio(packed struct(u32) {
                GPIO0_LEVEL_LOW: u1,
                GPIO0_LEVEL_HIGH: u1,
                GPIO0_EDGE_LOW: u1,
                GPIO0_EDGE_HIGH: u1,
                GPIO1_LEVEL_LOW: u1,
                GPIO1_LEVEL_HIGH: u1,
                GPIO1_EDGE_LOW: u1,
                GPIO1_EDGE_HIGH: u1,
                GPIO2_LEVEL_LOW: u1,
                GPIO2_LEVEL_HIGH: u1,
                GPIO2_EDGE_LOW: u1,
                GPIO2_EDGE_HIGH: u1,
                GPIO3_LEVEL_LOW: u1,
                GPIO3_LEVEL_HIGH: u1,
                GPIO3_EDGE_LOW: u1,
                GPIO3_EDGE_HIGH: u1,
                GPIO4_LEVEL_LOW: u1,
                GPIO4_LEVEL_HIGH: u1,
                GPIO4_EDGE_LOW: u1,
                GPIO4_EDGE_HIGH: u1,
                GPIO5_LEVEL_LOW: u1,
                GPIO5_LEVEL_HIGH: u1,
                GPIO5_EDGE_LOW: u1,
                GPIO5_EDGE_HIGH: u1,
                GPIO6_LEVEL_LOW: u1,
                GPIO6_LEVEL_HIGH: u1,
                GPIO6_EDGE_LOW: u1,
                GPIO6_EDGE_HIGH: u1,
                GPIO7_LEVEL_LOW: u1,
                GPIO7_LEVEL_HIGH: u1,
                GPIO7_EDGE_LOW: u1,
                GPIO7_EDGE_HIGH: u1,
            }),
            ///  Interrupt status after masking & forcing for proc0
            PROC0_INTS1: mmio.Mmio(packed struct(u32) {
                GPIO8_LEVEL_LOW: u1,
                GPIO8_LEVEL_HIGH: u1,
                GPIO8_EDGE_LOW: u1,
                GPIO8_EDGE_HIGH: u1,
                GPIO9_LEVEL_LOW: u1,
                GPIO9_LEVEL_HIGH: u1,
                GPIO9_EDGE_LOW: u1,
                GPIO9_EDGE_HIGH: u1,
                GPIO10_LEVEL_LOW: u1,
                GPIO10_LEVEL_HIGH: u1,
                GPIO10_EDGE_LOW: u1,
                GPIO10_EDGE_HIGH: u1,
                GPIO11_LEVEL_LOW: u1,
                GPIO11_LEVEL_HIGH: u1,
                GPIO11_EDGE_LOW: u1,
                GPIO11_EDGE_HIGH: u1,
                GPIO12_LEVEL_LOW: u1,
                GPIO12_LEVEL_HIGH: u1,
                GPIO12_EDGE_LOW: u1,
                GPIO12_EDGE_HIGH: u1,
                GPIO13_LEVEL_LOW: u1,
                GPIO13_LEVEL_HIGH: u1,
                GPIO13_EDGE_LOW: u1,
                GPIO13_EDGE_HIGH: u1,
                GPIO14_LEVEL_LOW: u1,
                GPIO14_LEVEL_HIGH: u1,
                GPIO14_EDGE_LOW: u1,
                GPIO14_EDGE_HIGH: u1,
                GPIO15_LEVEL_LOW: u1,
                GPIO15_LEVEL_HIGH: u1,
                GPIO15_EDGE_LOW: u1,
                GPIO15_EDGE_HIGH: u1,
            }),
            ///  Interrupt status after masking & forcing for proc0
            PROC0_INTS2: mmio.Mmio(packed struct(u32) {
                GPIO16_LEVEL_LOW: u1,
                GPIO16_LEVEL_HIGH: u1,
                GPIO16_EDGE_LOW: u1,
                GPIO16_EDGE_HIGH: u1,
                GPIO17_LEVEL_LOW: u1,
                GPIO17_LEVEL_HIGH: u1,
                GPIO17_EDGE_LOW: u1,
                GPIO17_EDGE_HIGH: u1,
                GPIO18_LEVEL_LOW: u1,
                GPIO18_LEVEL_HIGH: u1,
                GPIO18_EDGE_LOW: u1,
                GPIO18_EDGE_HIGH: u1,
                GPIO19_LEVEL_LOW: u1,
                GPIO19_LEVEL_HIGH: u1,
                GPIO19_EDGE_LOW: u1,
                GPIO19_EDGE_HIGH: u1,
                GPIO20_LEVEL_LOW: u1,
                GPIO20_LEVEL_HIGH: u1,
                GPIO20_EDGE_LOW: u1,
                GPIO20_EDGE_HIGH: u1,
                GPIO21_LEVEL_LOW: u1,
                GPIO21_LEVEL_HIGH: u1,
                GPIO21_EDGE_LOW: u1,
                GPIO21_EDGE_HIGH: u1,
                GPIO22_LEVEL_LOW: u1,
                GPIO22_LEVEL_HIGH: u1,
                GPIO22_EDGE_LOW: u1,
                GPIO22_EDGE_HIGH: u1,
                GPIO23_LEVEL_LOW: u1,
                GPIO23_LEVEL_HIGH: u1,
                GPIO23_EDGE_LOW: u1,
                GPIO23_EDGE_HIGH: u1,
            }),
            ///  Interrupt status after masking & forcing for proc0
            PROC0_INTS3: mmio.Mmio(packed struct(u32) {
                GPIO24_LEVEL_LOW: u1,
                GPIO24_LEVEL_HIGH: u1,
                GPIO24_EDGE_LOW: u1,
                GPIO24_EDGE_HIGH: u1,
                GPIO25_LEVEL_LOW: u1,
                GPIO25_LEVEL_HIGH: u1,
                GPIO25_EDGE_LOW: u1,
                GPIO25_EDGE_HIGH: u1,
                GPIO26_LEVEL_LOW: u1,
                GPIO26_LEVEL_HIGH: u1,
                GPIO26_EDGE_LOW: u1,
                GPIO26_EDGE_HIGH: u1,
                GPIO27_LEVEL_LOW: u1,
                GPIO27_LEVEL_HIGH: u1,
                GPIO27_EDGE_LOW: u1,
                GPIO27_EDGE_HIGH: u1,
                GPIO28_LEVEL_LOW: u1,
                GPIO28_LEVEL_HIGH: u1,
                GPIO28_EDGE_LOW: u1,
                GPIO28_EDGE_HIGH: u1,
                GPIO29_LEVEL_LOW: u1,
                GPIO29_LEVEL_HIGH: u1,
                GPIO29_EDGE_LOW: u1,
                GPIO29_EDGE_HIGH: u1,
                padding: u8,
            }),
            ///  Interrupt Enable for proc1
            PROC1_INTE0: mmio.Mmio(packed struct(u32) {
                GPIO0_LEVEL_LOW: u1,
                GPIO0_LEVEL_HIGH: u1,
                GPIO0_EDGE_LOW: u1,
                GPIO0_EDGE_HIGH: u1,
                GPIO1_LEVEL_LOW: u1,
                GPIO1_LEVEL_HIGH: u1,
                GPIO1_EDGE_LOW: u1,
                GPIO1_EDGE_HIGH: u1,
                GPIO2_LEVEL_LOW: u1,
                GPIO2_LEVEL_HIGH: u1,
                GPIO2_EDGE_LOW: u1,
                GPIO2_EDGE_HIGH: u1,
                GPIO3_LEVEL_LOW: u1,
                GPIO3_LEVEL_HIGH: u1,
                GPIO3_EDGE_LOW: u1,
                GPIO3_EDGE_HIGH: u1,
                GPIO4_LEVEL_LOW: u1,
                GPIO4_LEVEL_HIGH: u1,
                GPIO4_EDGE_LOW: u1,
                GPIO4_EDGE_HIGH: u1,
                GPIO5_LEVEL_LOW: u1,
                GPIO5_LEVEL_HIGH: u1,
                GPIO5_EDGE_LOW: u1,
                GPIO5_EDGE_HIGH: u1,
                GPIO6_LEVEL_LOW: u1,
                GPIO6_LEVEL_HIGH: u1,
                GPIO6_EDGE_LOW: u1,
                GPIO6_EDGE_HIGH: u1,
                GPIO7_LEVEL_LOW: u1,
                GPIO7_LEVEL_HIGH: u1,
                GPIO7_EDGE_LOW: u1,
                GPIO7_EDGE_HIGH: u1,
            }),
            ///  Interrupt Enable for proc1
            PROC1_INTE1: mmio.Mmio(packed struct(u32) {
                GPIO8_LEVEL_LOW: u1,
                GPIO8_LEVEL_HIGH: u1,
                GPIO8_EDGE_LOW: u1,
                GPIO8_EDGE_HIGH: u1,
                GPIO9_LEVEL_LOW: u1,
                GPIO9_LEVEL_HIGH: u1,
                GPIO9_EDGE_LOW: u1,
                GPIO9_EDGE_HIGH: u1,
                GPIO10_LEVEL_LOW: u1,
                GPIO10_LEVEL_HIGH: u1,
                GPIO10_EDGE_LOW: u1,
                GPIO10_EDGE_HIGH: u1,
                GPIO11_LEVEL_LOW: u1,
                GPIO11_LEVEL_HIGH: u1,
                GPIO11_EDGE_LOW: u1,
                GPIO11_EDGE_HIGH: u1,
                GPIO12_LEVEL_LOW: u1,
                GPIO12_LEVEL_HIGH: u1,
                GPIO12_EDGE_LOW: u1,
                GPIO12_EDGE_HIGH: u1,
                GPIO13_LEVEL_LOW: u1,
                GPIO13_LEVEL_HIGH: u1,
                GPIO13_EDGE_LOW: u1,
                GPIO13_EDGE_HIGH: u1,
                GPIO14_LEVEL_LOW: u1,
                GPIO14_LEVEL_HIGH: u1,
                GPIO14_EDGE_LOW: u1,
                GPIO14_EDGE_HIGH: u1,
                GPIO15_LEVEL_LOW: u1,
                GPIO15_LEVEL_HIGH: u1,
                GPIO15_EDGE_LOW: u1,
                GPIO15_EDGE_HIGH: u1,
            }),
            ///  Interrupt Enable for proc1
            PROC1_INTE2: mmio.Mmio(packed struct(u32) {
                GPIO16_LEVEL_LOW: u1,
                GPIO16_LEVEL_HIGH: u1,
                GPIO16_EDGE_LOW: u1,
                GPIO16_EDGE_HIGH: u1,
                GPIO17_LEVEL_LOW: u1,
                GPIO17_LEVEL_HIGH: u1,
                GPIO17_EDGE_LOW: u1,
                GPIO17_EDGE_HIGH: u1,
                GPIO18_LEVEL_LOW: u1,
                GPIO18_LEVEL_HIGH: u1,
                GPIO18_EDGE_LOW: u1,
                GPIO18_EDGE_HIGH: u1,
                GPIO19_LEVEL_LOW: u1,
                GPIO19_LEVEL_HIGH: u1,
                GPIO19_EDGE_LOW: u1,
                GPIO19_EDGE_HIGH: u1,
                GPIO20_LEVEL_LOW: u1,
                GPIO20_LEVEL_HIGH: u1,
                GPIO20_EDGE_LOW: u1,
                GPIO20_EDGE_HIGH: u1,
                GPIO21_LEVEL_LOW: u1,
                GPIO21_LEVEL_HIGH: u1,
                GPIO21_EDGE_LOW: u1,
                GPIO21_EDGE_HIGH: u1,
                GPIO22_LEVEL_LOW: u1,
                GPIO22_LEVEL_HIGH: u1,
                GPIO22_EDGE_LOW: u1,
                GPIO22_EDGE_HIGH: u1,
                GPIO23_LEVEL_LOW: u1,
                GPIO23_LEVEL_HIGH: u1,
                GPIO23_EDGE_LOW: u1,
                GPIO23_EDGE_HIGH: u1,
            }),
            ///  Interrupt Enable for proc1
            PROC1_INTE3: mmio.Mmio(packed struct(u32) {
                GPIO24_LEVEL_LOW: u1,
                GPIO24_LEVEL_HIGH: u1,
                GPIO24_EDGE_LOW: u1,
                GPIO24_EDGE_HIGH: u1,
                GPIO25_LEVEL_LOW: u1,
                GPIO25_LEVEL_HIGH: u1,
                GPIO25_EDGE_LOW: u1,
                GPIO25_EDGE_HIGH: u1,
                GPIO26_LEVEL_LOW: u1,
                GPIO26_LEVEL_HIGH: u1,
                GPIO26_EDGE_LOW: u1,
                GPIO26_EDGE_HIGH: u1,
                GPIO27_LEVEL_LOW: u1,
                GPIO27_LEVEL_HIGH: u1,
                GPIO27_EDGE_LOW: u1,
                GPIO27_EDGE_HIGH: u1,
                GPIO28_LEVEL_LOW: u1,
                GPIO28_LEVEL_HIGH: u1,
                GPIO28_EDGE_LOW: u1,
                GPIO28_EDGE_HIGH: u1,
                GPIO29_LEVEL_LOW: u1,
                GPIO29_LEVEL_HIGH: u1,
                GPIO29_EDGE_LOW: u1,
                GPIO29_EDGE_HIGH: u1,
                padding: u8,
            }),
            ///  Interrupt Force for proc1
            PROC1_INTF0: mmio.Mmio(packed struct(u32) {
                GPIO0_LEVEL_LOW: u1,
                GPIO0_LEVEL_HIGH: u1,
                GPIO0_EDGE_LOW: u1,
                GPIO0_EDGE_HIGH: u1,
                GPIO1_LEVEL_LOW: u1,
                GPIO1_LEVEL_HIGH: u1,
                GPIO1_EDGE_LOW: u1,
                GPIO1_EDGE_HIGH: u1,
                GPIO2_LEVEL_LOW: u1,
                GPIO2_LEVEL_HIGH: u1,
                GPIO2_EDGE_LOW: u1,
                GPIO2_EDGE_HIGH: u1,
                GPIO3_LEVEL_LOW: u1,
                GPIO3_LEVEL_HIGH: u1,
                GPIO3_EDGE_LOW: u1,
                GPIO3_EDGE_HIGH: u1,
                GPIO4_LEVEL_LOW: u1,
                GPIO4_LEVEL_HIGH: u1,
                GPIO4_EDGE_LOW: u1,
                GPIO4_EDGE_HIGH: u1,
                GPIO5_LEVEL_LOW: u1,
                GPIO5_LEVEL_HIGH: u1,
                GPIO5_EDGE_LOW: u1,
                GPIO5_EDGE_HIGH: u1,
                GPIO6_LEVEL_LOW: u1,
                GPIO6_LEVEL_HIGH: u1,
                GPIO6_EDGE_LOW: u1,
                GPIO6_EDGE_HIGH: u1,
                GPIO7_LEVEL_LOW: u1,
                GPIO7_LEVEL_HIGH: u1,
                GPIO7_EDGE_LOW: u1,
                GPIO7_EDGE_HIGH: u1,
            }),
            ///  Interrupt Force for proc1
            PROC1_INTF1: mmio.Mmio(packed struct(u32) {
                GPIO8_LEVEL_LOW: u1,
                GPIO8_LEVEL_HIGH: u1,
                GPIO8_EDGE_LOW: u1,
                GPIO8_EDGE_HIGH: u1,
                GPIO9_LEVEL_LOW: u1,
                GPIO9_LEVEL_HIGH: u1,
                GPIO9_EDGE_LOW: u1,
                GPIO9_EDGE_HIGH: u1,
                GPIO10_LEVEL_LOW: u1,
                GPIO10_LEVEL_HIGH: u1,
                GPIO10_EDGE_LOW: u1,
                GPIO10_EDGE_HIGH: u1,
                GPIO11_LEVEL_LOW: u1,
                GPIO11_LEVEL_HIGH: u1,
                GPIO11_EDGE_LOW: u1,
                GPIO11_EDGE_HIGH: u1,
                GPIO12_LEVEL_LOW: u1,
                GPIO12_LEVEL_HIGH: u1,
                GPIO12_EDGE_LOW: u1,
                GPIO12_EDGE_HIGH: u1,
                GPIO13_LEVEL_LOW: u1,
                GPIO13_LEVEL_HIGH: u1,
                GPIO13_EDGE_LOW: u1,
                GPIO13_EDGE_HIGH: u1,
                GPIO14_LEVEL_LOW: u1,
                GPIO14_LEVEL_HIGH: u1,
                GPIO14_EDGE_LOW: u1,
                GPIO14_EDGE_HIGH: u1,
                GPIO15_LEVEL_LOW: u1,
                GPIO15_LEVEL_HIGH: u1,
                GPIO15_EDGE_LOW: u1,
                GPIO15_EDGE_HIGH: u1,
            }),
            ///  Interrupt Force for proc1
            PROC1_INTF2: mmio.Mmio(packed struct(u32) {
                GPIO16_LEVEL_LOW: u1,
                GPIO16_LEVEL_HIGH: u1,
                GPIO16_EDGE_LOW: u1,
                GPIO16_EDGE_HIGH: u1,
                GPIO17_LEVEL_LOW: u1,
                GPIO17_LEVEL_HIGH: u1,
                GPIO17_EDGE_LOW: u1,
                GPIO17_EDGE_HIGH: u1,
                GPIO18_LEVEL_LOW: u1,
                GPIO18_LEVEL_HIGH: u1,
                GPIO18_EDGE_LOW: u1,
                GPIO18_EDGE_HIGH: u1,
                GPIO19_LEVEL_LOW: u1,
                GPIO19_LEVEL_HIGH: u1,
                GPIO19_EDGE_LOW: u1,
                GPIO19_EDGE_HIGH: u1,
                GPIO20_LEVEL_LOW: u1,
                GPIO20_LEVEL_HIGH: u1,
                GPIO20_EDGE_LOW: u1,
                GPIO20_EDGE_HIGH: u1,
                GPIO21_LEVEL_LOW: u1,
                GPIO21_LEVEL_HIGH: u1,
                GPIO21_EDGE_LOW: u1,
                GPIO21_EDGE_HIGH: u1,
                GPIO22_LEVEL_LOW: u1,
                GPIO22_LEVEL_HIGH: u1,
                GPIO22_EDGE_LOW: u1,
                GPIO22_EDGE_HIGH: u1,
                GPIO23_LEVEL_LOW: u1,
                GPIO23_LEVEL_HIGH: u1,
                GPIO23_EDGE_LOW: u1,
                GPIO23_EDGE_HIGH: u1,
            }),
            ///  Interrupt Force for proc1
            PROC1_INTF3: mmio.Mmio(packed struct(u32) {
                GPIO24_LEVEL_LOW: u1,
                GPIO24_LEVEL_HIGH: u1,
                GPIO24_EDGE_LOW: u1,
                GPIO24_EDGE_HIGH: u1,
                GPIO25_LEVEL_LOW: u1,
                GPIO25_LEVEL_HIGH: u1,
                GPIO25_EDGE_LOW: u1,
                GPIO25_EDGE_HIGH: u1,
                GPIO26_LEVEL_LOW: u1,
                GPIO26_LEVEL_HIGH: u1,
                GPIO26_EDGE_LOW: u1,
                GPIO26_EDGE_HIGH: u1,
                GPIO27_LEVEL_LOW: u1,
                GPIO27_LEVEL_HIGH: u1,
                GPIO27_EDGE_LOW: u1,
                GPIO27_EDGE_HIGH: u1,
                GPIO28_LEVEL_LOW: u1,
                GPIO28_LEVEL_HIGH: u1,
                GPIO28_EDGE_LOW: u1,
                GPIO28_EDGE_HIGH: u1,
                GPIO29_LEVEL_LOW: u1,
                GPIO29_LEVEL_HIGH: u1,
                GPIO29_EDGE_LOW: u1,
                GPIO29_EDGE_HIGH: u1,
                padding: u8,
            }),
            ///  Interrupt status after masking & forcing for proc1
            PROC1_INTS0: mmio.Mmio(packed struct(u32) {
                GPIO0_LEVEL_LOW: u1,
                GPIO0_LEVEL_HIGH: u1,
                GPIO0_EDGE_LOW: u1,
                GPIO0_EDGE_HIGH: u1,
                GPIO1_LEVEL_LOW: u1,
                GPIO1_LEVEL_HIGH: u1,
                GPIO1_EDGE_LOW: u1,
                GPIO1_EDGE_HIGH: u1,
                GPIO2_LEVEL_LOW: u1,
                GPIO2_LEVEL_HIGH: u1,
                GPIO2_EDGE_LOW: u1,
                GPIO2_EDGE_HIGH: u1,
                GPIO3_LEVEL_LOW: u1,
                GPIO3_LEVEL_HIGH: u1,
                GPIO3_EDGE_LOW: u1,
                GPIO3_EDGE_HIGH: u1,
                GPIO4_LEVEL_LOW: u1,
                GPIO4_LEVEL_HIGH: u1,
                GPIO4_EDGE_LOW: u1,
                GPIO4_EDGE_HIGH: u1,
                GPIO5_LEVEL_LOW: u1,
                GPIO5_LEVEL_HIGH: u1,
                GPIO5_EDGE_LOW: u1,
                GPIO5_EDGE_HIGH: u1,
                GPIO6_LEVEL_LOW: u1,
                GPIO6_LEVEL_HIGH: u1,
                GPIO6_EDGE_LOW: u1,
                GPIO6_EDGE_HIGH: u1,
                GPIO7_LEVEL_LOW: u1,
                GPIO7_LEVEL_HIGH: u1,
                GPIO7_EDGE_LOW: u1,
                GPIO7_EDGE_HIGH: u1,
            }),
            ///  Interrupt status after masking & forcing for proc1
            PROC1_INTS1: mmio.Mmio(packed struct(u32) {
                GPIO8_LEVEL_LOW: u1,
                GPIO8_LEVEL_HIGH: u1,
                GPIO8_EDGE_LOW: u1,
                GPIO8_EDGE_HIGH: u1,
                GPIO9_LEVEL_LOW: u1,
                GPIO9_LEVEL_HIGH: u1,
                GPIO9_EDGE_LOW: u1,
                GPIO9_EDGE_HIGH: u1,
                GPIO10_LEVEL_LOW: u1,
                GPIO10_LEVEL_HIGH: u1,
                GPIO10_EDGE_LOW: u1,
                GPIO10_EDGE_HIGH: u1,
                GPIO11_LEVEL_LOW: u1,
                GPIO11_LEVEL_HIGH: u1,
                GPIO11_EDGE_LOW: u1,
                GPIO11_EDGE_HIGH: u1,
                GPIO12_LEVEL_LOW: u1,
                GPIO12_LEVEL_HIGH: u1,
                GPIO12_EDGE_LOW: u1,
                GPIO12_EDGE_HIGH: u1,
                GPIO13_LEVEL_LOW: u1,
                GPIO13_LEVEL_HIGH: u1,
                GPIO13_EDGE_LOW: u1,
                GPIO13_EDGE_HIGH: u1,
                GPIO14_LEVEL_LOW: u1,
                GPIO14_LEVEL_HIGH: u1,
                GPIO14_EDGE_LOW: u1,
                GPIO14_EDGE_HIGH: u1,
                GPIO15_LEVEL_LOW: u1,
                GPIO15_LEVEL_HIGH: u1,
                GPIO15_EDGE_LOW: u1,
                GPIO15_EDGE_HIGH: u1,
            }),
            ///  Interrupt status after masking & forcing for proc1
            PROC1_INTS2: mmio.Mmio(packed struct(u32) {
                GPIO16_LEVEL_LOW: u1,
                GPIO16_LEVEL_HIGH: u1,
                GPIO16_EDGE_LOW: u1,
                GPIO16_EDGE_HIGH: u1,
                GPIO17_LEVEL_LOW: u1,
                GPIO17_LEVEL_HIGH: u1,
                GPIO17_EDGE_LOW: u1,
                GPIO17_EDGE_HIGH: u1,
                GPIO18_LEVEL_LOW: u1,
                GPIO18_LEVEL_HIGH: u1,
                GPIO18_EDGE_LOW: u1,
                GPIO18_EDGE_HIGH: u1,
                GPIO19_LEVEL_LOW: u1,
                GPIO19_LEVEL_HIGH: u1,
                GPIO19_EDGE_LOW: u1,
                GPIO19_EDGE_HIGH: u1,
                GPIO20_LEVEL_LOW: u1,
                GPIO20_LEVEL_HIGH: u1,
                GPIO20_EDGE_LOW: u1,
                GPIO20_EDGE_HIGH: u1,
                GPIO21_LEVEL_LOW: u1,
                GPIO21_LEVEL_HIGH: u1,
                GPIO21_EDGE_LOW: u1,
                GPIO21_EDGE_HIGH: u1,
                GPIO22_LEVEL_LOW: u1,
                GPIO22_LEVEL_HIGH: u1,
                GPIO22_EDGE_LOW: u1,
                GPIO22_EDGE_HIGH: u1,
                GPIO23_LEVEL_LOW: u1,
                GPIO23_LEVEL_HIGH: u1,
                GPIO23_EDGE_LOW: u1,
                GPIO23_EDGE_HIGH: u1,
            }),
            ///  Interrupt status after masking & forcing for proc1
            PROC1_INTS3: mmio.Mmio(packed struct(u32) {
                GPIO24_LEVEL_LOW: u1,
                GPIO24_LEVEL_HIGH: u1,
                GPIO24_EDGE_LOW: u1,
                GPIO24_EDGE_HIGH: u1,
                GPIO25_LEVEL_LOW: u1,
                GPIO25_LEVEL_HIGH: u1,
                GPIO25_EDGE_LOW: u1,
                GPIO25_EDGE_HIGH: u1,
                GPIO26_LEVEL_LOW: u1,
                GPIO26_LEVEL_HIGH: u1,
                GPIO26_EDGE_LOW: u1,
                GPIO26_EDGE_HIGH: u1,
                GPIO27_LEVEL_LOW: u1,
                GPIO27_LEVEL_HIGH: u1,
                GPIO27_EDGE_LOW: u1,
                GPIO27_EDGE_HIGH: u1,
                GPIO28_LEVEL_LOW: u1,
                GPIO28_LEVEL_HIGH: u1,
                GPIO28_EDGE_LOW: u1,
                GPIO28_EDGE_HIGH: u1,
                GPIO29_LEVEL_LOW: u1,
                GPIO29_LEVEL_HIGH: u1,
                GPIO29_EDGE_LOW: u1,
                GPIO29_EDGE_HIGH: u1,
                padding: u8,
            }),
            ///  Interrupt Enable for dormant_wake
            DORMANT_WAKE_INTE0: mmio.Mmio(packed struct(u32) {
                GPIO0_LEVEL_LOW: u1,
                GPIO0_LEVEL_HIGH: u1,
                GPIO0_EDGE_LOW: u1,
                GPIO0_EDGE_HIGH: u1,
                GPIO1_LEVEL_LOW: u1,
                GPIO1_LEVEL_HIGH: u1,
                GPIO1_EDGE_LOW: u1,
                GPIO1_EDGE_HIGH: u1,
                GPIO2_LEVEL_LOW: u1,
                GPIO2_LEVEL_HIGH: u1,
                GPIO2_EDGE_LOW: u1,
                GPIO2_EDGE_HIGH: u1,
                GPIO3_LEVEL_LOW: u1,
                GPIO3_LEVEL_HIGH: u1,
                GPIO3_EDGE_LOW: u1,
                GPIO3_EDGE_HIGH: u1,
                GPIO4_LEVEL_LOW: u1,
                GPIO4_LEVEL_HIGH: u1,
                GPIO4_EDGE_LOW: u1,
                GPIO4_EDGE_HIGH: u1,
                GPIO5_LEVEL_LOW: u1,
                GPIO5_LEVEL_HIGH: u1,
                GPIO5_EDGE_LOW: u1,
                GPIO5_EDGE_HIGH: u1,
                GPIO6_LEVEL_LOW: u1,
                GPIO6_LEVEL_HIGH: u1,
                GPIO6_EDGE_LOW: u1,
                GPIO6_EDGE_HIGH: u1,
                GPIO7_LEVEL_LOW: u1,
                GPIO7_LEVEL_HIGH: u1,
                GPIO7_EDGE_LOW: u1,
                GPIO7_EDGE_HIGH: u1,
            }),
            ///  Interrupt Enable for dormant_wake
            DORMANT_WAKE_INTE1: mmio.Mmio(packed struct(u32) {
                GPIO8_LEVEL_LOW: u1,
                GPIO8_LEVEL_HIGH: u1,
                GPIO8_EDGE_LOW: u1,
                GPIO8_EDGE_HIGH: u1,
                GPIO9_LEVEL_LOW: u1,
                GPIO9_LEVEL_HIGH: u1,
                GPIO9_EDGE_LOW: u1,
                GPIO9_EDGE_HIGH: u1,
                GPIO10_LEVEL_LOW: u1,
                GPIO10_LEVEL_HIGH: u1,
                GPIO10_EDGE_LOW: u1,
                GPIO10_EDGE_HIGH: u1,
                GPIO11_LEVEL_LOW: u1,
                GPIO11_LEVEL_HIGH: u1,
                GPIO11_EDGE_LOW: u1,
                GPIO11_EDGE_HIGH: u1,
                GPIO12_LEVEL_LOW: u1,
                GPIO12_LEVEL_HIGH: u1,
                GPIO12_EDGE_LOW: u1,
                GPIO12_EDGE_HIGH: u1,
                GPIO13_LEVEL_LOW: u1,
                GPIO13_LEVEL_HIGH: u1,
                GPIO13_EDGE_LOW: u1,
                GPIO13_EDGE_HIGH: u1,
                GPIO14_LEVEL_LOW: u1,
                GPIO14_LEVEL_HIGH: u1,
                GPIO14_EDGE_LOW: u1,
                GPIO14_EDGE_HIGH: u1,
                GPIO15_LEVEL_LOW: u1,
                GPIO15_LEVEL_HIGH: u1,
                GPIO15_EDGE_LOW: u1,
                GPIO15_EDGE_HIGH: u1,
            }),
            ///  Interrupt Enable for dormant_wake
            DORMANT_WAKE_INTE2: mmio.Mmio(packed struct(u32) {
                GPIO16_LEVEL_LOW: u1,
                GPIO16_LEVEL_HIGH: u1,
                GPIO16_EDGE_LOW: u1,
                GPIO16_EDGE_HIGH: u1,
                GPIO17_LEVEL_LOW: u1,
                GPIO17_LEVEL_HIGH: u1,
                GPIO17_EDGE_LOW: u1,
                GPIO17_EDGE_HIGH: u1,
                GPIO18_LEVEL_LOW: u1,
                GPIO18_LEVEL_HIGH: u1,
                GPIO18_EDGE_LOW: u1,
                GPIO18_EDGE_HIGH: u1,
                GPIO19_LEVEL_LOW: u1,
                GPIO19_LEVEL_HIGH: u1,
                GPIO19_EDGE_LOW: u1,
                GPIO19_EDGE_HIGH: u1,
                GPIO20_LEVEL_LOW: u1,
                GPIO20_LEVEL_HIGH: u1,
                GPIO20_EDGE_LOW: u1,
                GPIO20_EDGE_HIGH: u1,
                GPIO21_LEVEL_LOW: u1,
                GPIO21_LEVEL_HIGH: u1,
                GPIO21_EDGE_LOW: u1,
                GPIO21_EDGE_HIGH: u1,
                GPIO22_LEVEL_LOW: u1,
                GPIO22_LEVEL_HIGH: u1,
                GPIO22_EDGE_LOW: u1,
                GPIO22_EDGE_HIGH: u1,
                GPIO23_LEVEL_LOW: u1,
                GPIO23_LEVEL_HIGH: u1,
                GPIO23_EDGE_LOW: u1,
                GPIO23_EDGE_HIGH: u1,
            }),
            ///  Interrupt Enable for dormant_wake
            DORMANT_WAKE_INTE3: mmio.Mmio(packed struct(u32) {
                GPIO24_LEVEL_LOW: u1,
                GPIO24_LEVEL_HIGH: u1,
                GPIO24_EDGE_LOW: u1,
                GPIO24_EDGE_HIGH: u1,
                GPIO25_LEVEL_LOW: u1,
                GPIO25_LEVEL_HIGH: u1,
                GPIO25_EDGE_LOW: u1,
                GPIO25_EDGE_HIGH: u1,
                GPIO26_LEVEL_LOW: u1,
                GPIO26_LEVEL_HIGH: u1,
                GPIO26_EDGE_LOW: u1,
                GPIO26_EDGE_HIGH: u1,
                GPIO27_LEVEL_LOW: u1,
                GPIO27_LEVEL_HIGH: u1,
                GPIO27_EDGE_LOW: u1,
                GPIO27_EDGE_HIGH: u1,
                GPIO28_LEVEL_LOW: u1,
                GPIO28_LEVEL_HIGH: u1,
                GPIO28_EDGE_LOW: u1,
                GPIO28_EDGE_HIGH: u1,
                GPIO29_LEVEL_LOW: u1,
                GPIO29_LEVEL_HIGH: u1,
                GPIO29_EDGE_LOW: u1,
                GPIO29_EDGE_HIGH: u1,
                padding: u8,
            }),
            ///  Interrupt Force for dormant_wake
            DORMANT_WAKE_INTF0: mmio.Mmio(packed struct(u32) {
                GPIO0_LEVEL_LOW: u1,
                GPIO0_LEVEL_HIGH: u1,
                GPIO0_EDGE_LOW: u1,
                GPIO0_EDGE_HIGH: u1,
                GPIO1_LEVEL_LOW: u1,
                GPIO1_LEVEL_HIGH: u1,
                GPIO1_EDGE_LOW: u1,
                GPIO1_EDGE_HIGH: u1,
                GPIO2_LEVEL_LOW: u1,
                GPIO2_LEVEL_HIGH: u1,
                GPIO2_EDGE_LOW: u1,
                GPIO2_EDGE_HIGH: u1,
                GPIO3_LEVEL_LOW: u1,
                GPIO3_LEVEL_HIGH: u1,
                GPIO3_EDGE_LOW: u1,
                GPIO3_EDGE_HIGH: u1,
                GPIO4_LEVEL_LOW: u1,
                GPIO4_LEVEL_HIGH: u1,
                GPIO4_EDGE_LOW: u1,
                GPIO4_EDGE_HIGH: u1,
                GPIO5_LEVEL_LOW: u1,
                GPIO5_LEVEL_HIGH: u1,
                GPIO5_EDGE_LOW: u1,
                GPIO5_EDGE_HIGH: u1,
                GPIO6_LEVEL_LOW: u1,
                GPIO6_LEVEL_HIGH: u1,
                GPIO6_EDGE_LOW: u1,
                GPIO6_EDGE_HIGH: u1,
                GPIO7_LEVEL_LOW: u1,
                GPIO7_LEVEL_HIGH: u1,
                GPIO7_EDGE_LOW: u1,
                GPIO7_EDGE_HIGH: u1,
            }),
            ///  Interrupt Force for dormant_wake
            DORMANT_WAKE_INTF1: mmio.Mmio(packed struct(u32) {
                GPIO8_LEVEL_LOW: u1,
                GPIO8_LEVEL_HIGH: u1,
                GPIO8_EDGE_LOW: u1,
                GPIO8_EDGE_HIGH: u1,
                GPIO9_LEVEL_LOW: u1,
                GPIO9_LEVEL_HIGH: u1,
                GPIO9_EDGE_LOW: u1,
                GPIO9_EDGE_HIGH: u1,
                GPIO10_LEVEL_LOW: u1,
                GPIO10_LEVEL_HIGH: u1,
                GPIO10_EDGE_LOW: u1,
                GPIO10_EDGE_HIGH: u1,
                GPIO11_LEVEL_LOW: u1,
                GPIO11_LEVEL_HIGH: u1,
                GPIO11_EDGE_LOW: u1,
                GPIO11_EDGE_HIGH: u1,
                GPIO12_LEVEL_LOW: u1,
                GPIO12_LEVEL_HIGH: u1,
                GPIO12_EDGE_LOW: u1,
                GPIO12_EDGE_HIGH: u1,
                GPIO13_LEVEL_LOW: u1,
                GPIO13_LEVEL_HIGH: u1,
                GPIO13_EDGE_LOW: u1,
                GPIO13_EDGE_HIGH: u1,
                GPIO14_LEVEL_LOW: u1,
                GPIO14_LEVEL_HIGH: u1,
                GPIO14_EDGE_LOW: u1,
                GPIO14_EDGE_HIGH: u1,
                GPIO15_LEVEL_LOW: u1,
                GPIO15_LEVEL_HIGH: u1,
                GPIO15_EDGE_LOW: u1,
                GPIO15_EDGE_HIGH: u1,
            }),
            ///  Interrupt Force for dormant_wake
            DORMANT_WAKE_INTF2: mmio.Mmio(packed struct(u32) {
                GPIO16_LEVEL_LOW: u1,
                GPIO16_LEVEL_HIGH: u1,
                GPIO16_EDGE_LOW: u1,
                GPIO16_EDGE_HIGH: u1,
                GPIO17_LEVEL_LOW: u1,
                GPIO17_LEVEL_HIGH: u1,
                GPIO17_EDGE_LOW: u1,
                GPIO17_EDGE_HIGH: u1,
                GPIO18_LEVEL_LOW: u1,
                GPIO18_LEVEL_HIGH: u1,
                GPIO18_EDGE_LOW: u1,
                GPIO18_EDGE_HIGH: u1,
                GPIO19_LEVEL_LOW: u1,
                GPIO19_LEVEL_HIGH: u1,
                GPIO19_EDGE_LOW: u1,
                GPIO19_EDGE_HIGH: u1,
                GPIO20_LEVEL_LOW: u1,
                GPIO20_LEVEL_HIGH: u1,
                GPIO20_EDGE_LOW: u1,
                GPIO20_EDGE_HIGH: u1,
                GPIO21_LEVEL_LOW: u1,
                GPIO21_LEVEL_HIGH: u1,
                GPIO21_EDGE_LOW: u1,
                GPIO21_EDGE_HIGH: u1,
                GPIO22_LEVEL_LOW: u1,
                GPIO22_LEVEL_HIGH: u1,
                GPIO22_EDGE_LOW: u1,
                GPIO22_EDGE_HIGH: u1,
                GPIO23_LEVEL_LOW: u1,
                GPIO23_LEVEL_HIGH: u1,
                GPIO23_EDGE_LOW: u1,
                GPIO23_EDGE_HIGH: u1,
            }),
            ///  Interrupt Force for dormant_wake
            DORMANT_WAKE_INTF3: mmio.Mmio(packed struct(u32) {
                GPIO24_LEVEL_LOW: u1,
                GPIO24_LEVEL_HIGH: u1,
                GPIO24_EDGE_LOW: u1,
                GPIO24_EDGE_HIGH: u1,
                GPIO25_LEVEL_LOW: u1,
                GPIO25_LEVEL_HIGH: u1,
                GPIO25_EDGE_LOW: u1,
                GPIO25_EDGE_HIGH: u1,
                GPIO26_LEVEL_LOW: u1,
                GPIO26_LEVEL_HIGH: u1,
                GPIO26_EDGE_LOW: u1,
                GPIO26_EDGE_HIGH: u1,
                GPIO27_LEVEL_LOW: u1,
                GPIO27_LEVEL_HIGH: u1,
                GPIO27_EDGE_LOW: u1,
                GPIO27_EDGE_HIGH: u1,
                GPIO28_LEVEL_LOW: u1,
                GPIO28_LEVEL_HIGH: u1,
                GPIO28_EDGE_LOW: u1,
                GPIO28_EDGE_HIGH: u1,
                GPIO29_LEVEL_LOW: u1,
                GPIO29_LEVEL_HIGH: u1,
                GPIO29_EDGE_LOW: u1,
                GPIO29_EDGE_HIGH: u1,
                padding: u8,
            }),
            ///  Interrupt status after masking & forcing for dormant_wake
            DORMANT_WAKE_INTS0: mmio.Mmio(packed struct(u32) {
                GPIO0_LEVEL_LOW: u1,
                GPIO0_LEVEL_HIGH: u1,
                GPIO0_EDGE_LOW: u1,
                GPIO0_EDGE_HIGH: u1,
                GPIO1_LEVEL_LOW: u1,
                GPIO1_LEVEL_HIGH: u1,
                GPIO1_EDGE_LOW: u1,
                GPIO1_EDGE_HIGH: u1,
                GPIO2_LEVEL_LOW: u1,
                GPIO2_LEVEL_HIGH: u1,
                GPIO2_EDGE_LOW: u1,
                GPIO2_EDGE_HIGH: u1,
                GPIO3_LEVEL_LOW: u1,
                GPIO3_LEVEL_HIGH: u1,
                GPIO3_EDGE_LOW: u1,
                GPIO3_EDGE_HIGH: u1,
                GPIO4_LEVEL_LOW: u1,
                GPIO4_LEVEL_HIGH: u1,
                GPIO4_EDGE_LOW: u1,
                GPIO4_EDGE_HIGH: u1,
                GPIO5_LEVEL_LOW: u1,
                GPIO5_LEVEL_HIGH: u1,
                GPIO5_EDGE_LOW: u1,
                GPIO5_EDGE_HIGH: u1,
                GPIO6_LEVEL_LOW: u1,
                GPIO6_LEVEL_HIGH: u1,
                GPIO6_EDGE_LOW: u1,
                GPIO6_EDGE_HIGH: u1,
                GPIO7_LEVEL_LOW: u1,
                GPIO7_LEVEL_HIGH: u1,
                GPIO7_EDGE_LOW: u1,
                GPIO7_EDGE_HIGH: u1,
            }),
            ///  Interrupt status after masking & forcing for dormant_wake
            DORMANT_WAKE_INTS1: mmio.Mmio(packed struct(u32) {
                GPIO8_LEVEL_LOW: u1,
                GPIO8_LEVEL_HIGH: u1,
                GPIO8_EDGE_LOW: u1,
                GPIO8_EDGE_HIGH: u1,
                GPIO9_LEVEL_LOW: u1,
                GPIO9_LEVEL_HIGH: u1,
                GPIO9_EDGE_LOW: u1,
                GPIO9_EDGE_HIGH: u1,
                GPIO10_LEVEL_LOW: u1,
                GPIO10_LEVEL_HIGH: u1,
                GPIO10_EDGE_LOW: u1,
                GPIO10_EDGE_HIGH: u1,
                GPIO11_LEVEL_LOW: u1,
                GPIO11_LEVEL_HIGH: u1,
                GPIO11_EDGE_LOW: u1,
                GPIO11_EDGE_HIGH: u1,
                GPIO12_LEVEL_LOW: u1,
                GPIO12_LEVEL_HIGH: u1,
                GPIO12_EDGE_LOW: u1,
                GPIO12_EDGE_HIGH: u1,
                GPIO13_LEVEL_LOW: u1,
                GPIO13_LEVEL_HIGH: u1,
                GPIO13_EDGE_LOW: u1,
                GPIO13_EDGE_HIGH: u1,
                GPIO14_LEVEL_LOW: u1,
                GPIO14_LEVEL_HIGH: u1,
                GPIO14_EDGE_LOW: u1,
                GPIO14_EDGE_HIGH: u1,
                GPIO15_LEVEL_LOW: u1,
                GPIO15_LEVEL_HIGH: u1,
                GPIO15_EDGE_LOW: u1,
                GPIO15_EDGE_HIGH: u1,
            }),
            ///  Interrupt status after masking & forcing for dormant_wake
            DORMANT_WAKE_INTS2: mmio.Mmio(packed struct(u32) {
                GPIO16_LEVEL_LOW: u1,
                GPIO16_LEVEL_HIGH: u1,
                GPIO16_EDGE_LOW: u1,
                GPIO16_EDGE_HIGH: u1,
                GPIO17_LEVEL_LOW: u1,
                GPIO17_LEVEL_HIGH: u1,
                GPIO17_EDGE_LOW: u1,
                GPIO17_EDGE_HIGH: u1,
                GPIO18_LEVEL_LOW: u1,
                GPIO18_LEVEL_HIGH: u1,
                GPIO18_EDGE_LOW: u1,
                GPIO18_EDGE_HIGH: u1,
                GPIO19_LEVEL_LOW: u1,
                GPIO19_LEVEL_HIGH: u1,
                GPIO19_EDGE_LOW: u1,
                GPIO19_EDGE_HIGH: u1,
                GPIO20_LEVEL_LOW: u1,
                GPIO20_LEVEL_HIGH: u1,
                GPIO20_EDGE_LOW: u1,
                GPIO20_EDGE_HIGH: u1,
                GPIO21_LEVEL_LOW: u1,
                GPIO21_LEVEL_HIGH: u1,
                GPIO21_EDGE_LOW: u1,
                GPIO21_EDGE_HIGH: u1,
                GPIO22_LEVEL_LOW: u1,
                GPIO22_LEVEL_HIGH: u1,
                GPIO22_EDGE_LOW: u1,
                GPIO22_EDGE_HIGH: u1,
                GPIO23_LEVEL_LOW: u1,
                GPIO23_LEVEL_HIGH: u1,
                GPIO23_EDGE_LOW: u1,
                GPIO23_EDGE_HIGH: u1,
            }),
            ///  Interrupt status after masking & forcing for dormant_wake
            DORMANT_WAKE_INTS3: mmio.Mmio(packed struct(u32) {
                GPIO24_LEVEL_LOW: u1,
                GPIO24_LEVEL_HIGH: u1,
                GPIO24_EDGE_LOW: u1,
                GPIO24_EDGE_HIGH: u1,
                GPIO25_LEVEL_LOW: u1,
                GPIO25_LEVEL_HIGH: u1,
                GPIO25_EDGE_LOW: u1,
                GPIO25_EDGE_HIGH: u1,
                GPIO26_LEVEL_LOW: u1,
                GPIO26_LEVEL_HIGH: u1,
                GPIO26_EDGE_LOW: u1,
                GPIO26_EDGE_HIGH: u1,
                GPIO27_LEVEL_LOW: u1,
                GPIO27_LEVEL_HIGH: u1,
                GPIO27_EDGE_LOW: u1,
                GPIO27_EDGE_HIGH: u1,
                GPIO28_LEVEL_LOW: u1,
                GPIO28_LEVEL_HIGH: u1,
                GPIO28_EDGE_LOW: u1,
                GPIO28_EDGE_HIGH: u1,
                GPIO29_LEVEL_LOW: u1,
                GPIO29_LEVEL_HIGH: u1,
                GPIO29_EDGE_LOW: u1,
                GPIO29_EDGE_HIGH: u1,
                padding: u8,
            }),
        };

        pub const IO_QSPI = extern struct {
            ///  GPIO status
            GPIO_QSPI_SCLK_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO_QSPI_SCLK_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        xip_sclk = 0x0,
                        sio_30 = 0x5,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO_QSPI_SS_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO_QSPI_SS_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        xip_ss_n = 0x0,
                        sio_31 = 0x5,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO_QSPI_SD0_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO_QSPI_SD0_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        xip_sd0 = 0x0,
                        sio_32 = 0x5,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO_QSPI_SD1_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO_QSPI_SD1_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        xip_sd1 = 0x0,
                        sio_33 = 0x5,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO_QSPI_SD2_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO_QSPI_SD2_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        xip_sd2 = 0x0,
                        sio_34 = 0x5,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  GPIO status
            GPIO_QSPI_SD3_STATUS: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  output signal from selected peripheral, before register override is applied
                OUTFROMPERI: u1,
                ///  output signal to pad after register override is applied
                OUTTOPAD: u1,
                reserved12: u2,
                ///  output enable from selected peripheral, before register override is applied
                OEFROMPERI: u1,
                ///  output enable to pad after register override is applied
                OETOPAD: u1,
                reserved17: u3,
                ///  input signal from pad, before override is applied
                INFROMPAD: u1,
                reserved19: u1,
                ///  input signal to peripheral, after override is applied
                INTOPERI: u1,
                reserved24: u4,
                ///  interrupt from pad before override is applied
                IRQFROMPAD: u1,
                reserved26: u1,
                ///  interrupt to processors, after override is applied
                IRQTOPROC: u1,
                padding: u5,
            }),
            ///  GPIO control including function select and overrides.
            GPIO_QSPI_SD3_CTRL: mmio.Mmio(packed struct(u32) {
                ///  0-31 -> selects pin function according to the gpio table
                ///  31 == NULL
                FUNCSEL: packed union {
                    raw: u5,
                    value: enum(u5) {
                        xip_sd3 = 0x0,
                        sio_35 = 0x5,
                        null = 0x1f,
                        _,
                    },
                },
                reserved8: u3,
                OUTOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  drive output low
                        LOW = 0x2,
                        ///  drive output high
                        HIGH = 0x3,
                    },
                },
                reserved12: u2,
                OEOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  drive output enable from peripheral signal selected by funcsel
                        NORMAL = 0x0,
                        ///  drive output enable from inverse of peripheral signal selected by funcsel
                        INVERT = 0x1,
                        ///  disable output
                        DISABLE = 0x2,
                        ///  enable output
                        ENABLE = 0x3,
                    },
                },
                reserved16: u2,
                INOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the peri input
                        NORMAL = 0x0,
                        ///  invert the peri input
                        INVERT = 0x1,
                        ///  drive peri input low
                        LOW = 0x2,
                        ///  drive peri input high
                        HIGH = 0x3,
                    },
                },
                reserved28: u10,
                IRQOVER: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  don't invert the interrupt
                        NORMAL = 0x0,
                        ///  invert the interrupt
                        INVERT = 0x1,
                        ///  drive interrupt low
                        LOW = 0x2,
                        ///  drive interrupt high
                        HIGH = 0x3,
                    },
                },
                padding: u2,
            }),
            ///  Raw Interrupts
            INTR: mmio.Mmio(packed struct(u32) {
                GPIO_QSPI_SCLK_LEVEL_LOW: u1,
                GPIO_QSPI_SCLK_LEVEL_HIGH: u1,
                GPIO_QSPI_SCLK_EDGE_LOW: u1,
                GPIO_QSPI_SCLK_EDGE_HIGH: u1,
                GPIO_QSPI_SS_LEVEL_LOW: u1,
                GPIO_QSPI_SS_LEVEL_HIGH: u1,
                GPIO_QSPI_SS_EDGE_LOW: u1,
                GPIO_QSPI_SS_EDGE_HIGH: u1,
                GPIO_QSPI_SD0_LEVEL_LOW: u1,
                GPIO_QSPI_SD0_LEVEL_HIGH: u1,
                GPIO_QSPI_SD0_EDGE_LOW: u1,
                GPIO_QSPI_SD0_EDGE_HIGH: u1,
                GPIO_QSPI_SD1_LEVEL_LOW: u1,
                GPIO_QSPI_SD1_LEVEL_HIGH: u1,
                GPIO_QSPI_SD1_EDGE_LOW: u1,
                GPIO_QSPI_SD1_EDGE_HIGH: u1,
                GPIO_QSPI_SD2_LEVEL_LOW: u1,
                GPIO_QSPI_SD2_LEVEL_HIGH: u1,
                GPIO_QSPI_SD2_EDGE_LOW: u1,
                GPIO_QSPI_SD2_EDGE_HIGH: u1,
                GPIO_QSPI_SD3_LEVEL_LOW: u1,
                GPIO_QSPI_SD3_LEVEL_HIGH: u1,
                GPIO_QSPI_SD3_EDGE_LOW: u1,
                GPIO_QSPI_SD3_EDGE_HIGH: u1,
                padding: u8,
            }),
            ///  Interrupt Enable for proc0
            PROC0_INTE: mmio.Mmio(packed struct(u32) {
                GPIO_QSPI_SCLK_LEVEL_LOW: u1,
                GPIO_QSPI_SCLK_LEVEL_HIGH: u1,
                GPIO_QSPI_SCLK_EDGE_LOW: u1,
                GPIO_QSPI_SCLK_EDGE_HIGH: u1,
                GPIO_QSPI_SS_LEVEL_LOW: u1,
                GPIO_QSPI_SS_LEVEL_HIGH: u1,
                GPIO_QSPI_SS_EDGE_LOW: u1,
                GPIO_QSPI_SS_EDGE_HIGH: u1,
                GPIO_QSPI_SD0_LEVEL_LOW: u1,
                GPIO_QSPI_SD0_LEVEL_HIGH: u1,
                GPIO_QSPI_SD0_EDGE_LOW: u1,
                GPIO_QSPI_SD0_EDGE_HIGH: u1,
                GPIO_QSPI_SD1_LEVEL_LOW: u1,
                GPIO_QSPI_SD1_LEVEL_HIGH: u1,
                GPIO_QSPI_SD1_EDGE_LOW: u1,
                GPIO_QSPI_SD1_EDGE_HIGH: u1,
                GPIO_QSPI_SD2_LEVEL_LOW: u1,
                GPIO_QSPI_SD2_LEVEL_HIGH: u1,
                GPIO_QSPI_SD2_EDGE_LOW: u1,
                GPIO_QSPI_SD2_EDGE_HIGH: u1,
                GPIO_QSPI_SD3_LEVEL_LOW: u1,
                GPIO_QSPI_SD3_LEVEL_HIGH: u1,
                GPIO_QSPI_SD3_EDGE_LOW: u1,
                GPIO_QSPI_SD3_EDGE_HIGH: u1,
                padding: u8,
            }),
            ///  Interrupt Force for proc0
            PROC0_INTF: mmio.Mmio(packed struct(u32) {
                GPIO_QSPI_SCLK_LEVEL_LOW: u1,
                GPIO_QSPI_SCLK_LEVEL_HIGH: u1,
                GPIO_QSPI_SCLK_EDGE_LOW: u1,
                GPIO_QSPI_SCLK_EDGE_HIGH: u1,
                GPIO_QSPI_SS_LEVEL_LOW: u1,
                GPIO_QSPI_SS_LEVEL_HIGH: u1,
                GPIO_QSPI_SS_EDGE_LOW: u1,
                GPIO_QSPI_SS_EDGE_HIGH: u1,
                GPIO_QSPI_SD0_LEVEL_LOW: u1,
                GPIO_QSPI_SD0_LEVEL_HIGH: u1,
                GPIO_QSPI_SD0_EDGE_LOW: u1,
                GPIO_QSPI_SD0_EDGE_HIGH: u1,
                GPIO_QSPI_SD1_LEVEL_LOW: u1,
                GPIO_QSPI_SD1_LEVEL_HIGH: u1,
                GPIO_QSPI_SD1_EDGE_LOW: u1,
                GPIO_QSPI_SD1_EDGE_HIGH: u1,
                GPIO_QSPI_SD2_LEVEL_LOW: u1,
                GPIO_QSPI_SD2_LEVEL_HIGH: u1,
                GPIO_QSPI_SD2_EDGE_LOW: u1,
                GPIO_QSPI_SD2_EDGE_HIGH: u1,
                GPIO_QSPI_SD3_LEVEL_LOW: u1,
                GPIO_QSPI_SD3_LEVEL_HIGH: u1,
                GPIO_QSPI_SD3_EDGE_LOW: u1,
                GPIO_QSPI_SD3_EDGE_HIGH: u1,
                padding: u8,
            }),
            ///  Interrupt status after masking & forcing for proc0
            PROC0_INTS: mmio.Mmio(packed struct(u32) {
                GPIO_QSPI_SCLK_LEVEL_LOW: u1,
                GPIO_QSPI_SCLK_LEVEL_HIGH: u1,
                GPIO_QSPI_SCLK_EDGE_LOW: u1,
                GPIO_QSPI_SCLK_EDGE_HIGH: u1,
                GPIO_QSPI_SS_LEVEL_LOW: u1,
                GPIO_QSPI_SS_LEVEL_HIGH: u1,
                GPIO_QSPI_SS_EDGE_LOW: u1,
                GPIO_QSPI_SS_EDGE_HIGH: u1,
                GPIO_QSPI_SD0_LEVEL_LOW: u1,
                GPIO_QSPI_SD0_LEVEL_HIGH: u1,
                GPIO_QSPI_SD0_EDGE_LOW: u1,
                GPIO_QSPI_SD0_EDGE_HIGH: u1,
                GPIO_QSPI_SD1_LEVEL_LOW: u1,
                GPIO_QSPI_SD1_LEVEL_HIGH: u1,
                GPIO_QSPI_SD1_EDGE_LOW: u1,
                GPIO_QSPI_SD1_EDGE_HIGH: u1,
                GPIO_QSPI_SD2_LEVEL_LOW: u1,
                GPIO_QSPI_SD2_LEVEL_HIGH: u1,
                GPIO_QSPI_SD2_EDGE_LOW: u1,
                GPIO_QSPI_SD2_EDGE_HIGH: u1,
                GPIO_QSPI_SD3_LEVEL_LOW: u1,
                GPIO_QSPI_SD3_LEVEL_HIGH: u1,
                GPIO_QSPI_SD3_EDGE_LOW: u1,
                GPIO_QSPI_SD3_EDGE_HIGH: u1,
                padding: u8,
            }),
            ///  Interrupt Enable for proc1
            PROC1_INTE: mmio.Mmio(packed struct(u32) {
                GPIO_QSPI_SCLK_LEVEL_LOW: u1,
                GPIO_QSPI_SCLK_LEVEL_HIGH: u1,
                GPIO_QSPI_SCLK_EDGE_LOW: u1,
                GPIO_QSPI_SCLK_EDGE_HIGH: u1,
                GPIO_QSPI_SS_LEVEL_LOW: u1,
                GPIO_QSPI_SS_LEVEL_HIGH: u1,
                GPIO_QSPI_SS_EDGE_LOW: u1,
                GPIO_QSPI_SS_EDGE_HIGH: u1,
                GPIO_QSPI_SD0_LEVEL_LOW: u1,
                GPIO_QSPI_SD0_LEVEL_HIGH: u1,
                GPIO_QSPI_SD0_EDGE_LOW: u1,
                GPIO_QSPI_SD0_EDGE_HIGH: u1,
                GPIO_QSPI_SD1_LEVEL_LOW: u1,
                GPIO_QSPI_SD1_LEVEL_HIGH: u1,
                GPIO_QSPI_SD1_EDGE_LOW: u1,
                GPIO_QSPI_SD1_EDGE_HIGH: u1,
                GPIO_QSPI_SD2_LEVEL_LOW: u1,
                GPIO_QSPI_SD2_LEVEL_HIGH: u1,
                GPIO_QSPI_SD2_EDGE_LOW: u1,
                GPIO_QSPI_SD2_EDGE_HIGH: u1,
                GPIO_QSPI_SD3_LEVEL_LOW: u1,
                GPIO_QSPI_SD3_LEVEL_HIGH: u1,
                GPIO_QSPI_SD3_EDGE_LOW: u1,
                GPIO_QSPI_SD3_EDGE_HIGH: u1,
                padding: u8,
            }),
            ///  Interrupt Force for proc1
            PROC1_INTF: mmio.Mmio(packed struct(u32) {
                GPIO_QSPI_SCLK_LEVEL_LOW: u1,
                GPIO_QSPI_SCLK_LEVEL_HIGH: u1,
                GPIO_QSPI_SCLK_EDGE_LOW: u1,
                GPIO_QSPI_SCLK_EDGE_HIGH: u1,
                GPIO_QSPI_SS_LEVEL_LOW: u1,
                GPIO_QSPI_SS_LEVEL_HIGH: u1,
                GPIO_QSPI_SS_EDGE_LOW: u1,
                GPIO_QSPI_SS_EDGE_HIGH: u1,
                GPIO_QSPI_SD0_LEVEL_LOW: u1,
                GPIO_QSPI_SD0_LEVEL_HIGH: u1,
                GPIO_QSPI_SD0_EDGE_LOW: u1,
                GPIO_QSPI_SD0_EDGE_HIGH: u1,
                GPIO_QSPI_SD1_LEVEL_LOW: u1,
                GPIO_QSPI_SD1_LEVEL_HIGH: u1,
                GPIO_QSPI_SD1_EDGE_LOW: u1,
                GPIO_QSPI_SD1_EDGE_HIGH: u1,
                GPIO_QSPI_SD2_LEVEL_LOW: u1,
                GPIO_QSPI_SD2_LEVEL_HIGH: u1,
                GPIO_QSPI_SD2_EDGE_LOW: u1,
                GPIO_QSPI_SD2_EDGE_HIGH: u1,
                GPIO_QSPI_SD3_LEVEL_LOW: u1,
                GPIO_QSPI_SD3_LEVEL_HIGH: u1,
                GPIO_QSPI_SD3_EDGE_LOW: u1,
                GPIO_QSPI_SD3_EDGE_HIGH: u1,
                padding: u8,
            }),
            ///  Interrupt status after masking & forcing for proc1
            PROC1_INTS: mmio.Mmio(packed struct(u32) {
                GPIO_QSPI_SCLK_LEVEL_LOW: u1,
                GPIO_QSPI_SCLK_LEVEL_HIGH: u1,
                GPIO_QSPI_SCLK_EDGE_LOW: u1,
                GPIO_QSPI_SCLK_EDGE_HIGH: u1,
                GPIO_QSPI_SS_LEVEL_LOW: u1,
                GPIO_QSPI_SS_LEVEL_HIGH: u1,
                GPIO_QSPI_SS_EDGE_LOW: u1,
                GPIO_QSPI_SS_EDGE_HIGH: u1,
                GPIO_QSPI_SD0_LEVEL_LOW: u1,
                GPIO_QSPI_SD0_LEVEL_HIGH: u1,
                GPIO_QSPI_SD0_EDGE_LOW: u1,
                GPIO_QSPI_SD0_EDGE_HIGH: u1,
                GPIO_QSPI_SD1_LEVEL_LOW: u1,
                GPIO_QSPI_SD1_LEVEL_HIGH: u1,
                GPIO_QSPI_SD1_EDGE_LOW: u1,
                GPIO_QSPI_SD1_EDGE_HIGH: u1,
                GPIO_QSPI_SD2_LEVEL_LOW: u1,
                GPIO_QSPI_SD2_LEVEL_HIGH: u1,
                GPIO_QSPI_SD2_EDGE_LOW: u1,
                GPIO_QSPI_SD2_EDGE_HIGH: u1,
                GPIO_QSPI_SD3_LEVEL_LOW: u1,
                GPIO_QSPI_SD3_LEVEL_HIGH: u1,
                GPIO_QSPI_SD3_EDGE_LOW: u1,
                GPIO_QSPI_SD3_EDGE_HIGH: u1,
                padding: u8,
            }),
            ///  Interrupt Enable for dormant_wake
            DORMANT_WAKE_INTE: mmio.Mmio(packed struct(u32) {
                GPIO_QSPI_SCLK_LEVEL_LOW: u1,
                GPIO_QSPI_SCLK_LEVEL_HIGH: u1,
                GPIO_QSPI_SCLK_EDGE_LOW: u1,
                GPIO_QSPI_SCLK_EDGE_HIGH: u1,
                GPIO_QSPI_SS_LEVEL_LOW: u1,
                GPIO_QSPI_SS_LEVEL_HIGH: u1,
                GPIO_QSPI_SS_EDGE_LOW: u1,
                GPIO_QSPI_SS_EDGE_HIGH: u1,
                GPIO_QSPI_SD0_LEVEL_LOW: u1,
                GPIO_QSPI_SD0_LEVEL_HIGH: u1,
                GPIO_QSPI_SD0_EDGE_LOW: u1,
                GPIO_QSPI_SD0_EDGE_HIGH: u1,
                GPIO_QSPI_SD1_LEVEL_LOW: u1,
                GPIO_QSPI_SD1_LEVEL_HIGH: u1,
                GPIO_QSPI_SD1_EDGE_LOW: u1,
                GPIO_QSPI_SD1_EDGE_HIGH: u1,
                GPIO_QSPI_SD2_LEVEL_LOW: u1,
                GPIO_QSPI_SD2_LEVEL_HIGH: u1,
                GPIO_QSPI_SD2_EDGE_LOW: u1,
                GPIO_QSPI_SD2_EDGE_HIGH: u1,
                GPIO_QSPI_SD3_LEVEL_LOW: u1,
                GPIO_QSPI_SD3_LEVEL_HIGH: u1,
                GPIO_QSPI_SD3_EDGE_LOW: u1,
                GPIO_QSPI_SD3_EDGE_HIGH: u1,
                padding: u8,
            }),
            ///  Interrupt Force for dormant_wake
            DORMANT_WAKE_INTF: mmio.Mmio(packed struct(u32) {
                GPIO_QSPI_SCLK_LEVEL_LOW: u1,
                GPIO_QSPI_SCLK_LEVEL_HIGH: u1,
                GPIO_QSPI_SCLK_EDGE_LOW: u1,
                GPIO_QSPI_SCLK_EDGE_HIGH: u1,
                GPIO_QSPI_SS_LEVEL_LOW: u1,
                GPIO_QSPI_SS_LEVEL_HIGH: u1,
                GPIO_QSPI_SS_EDGE_LOW: u1,
                GPIO_QSPI_SS_EDGE_HIGH: u1,
                GPIO_QSPI_SD0_LEVEL_LOW: u1,
                GPIO_QSPI_SD0_LEVEL_HIGH: u1,
                GPIO_QSPI_SD0_EDGE_LOW: u1,
                GPIO_QSPI_SD0_EDGE_HIGH: u1,
                GPIO_QSPI_SD1_LEVEL_LOW: u1,
                GPIO_QSPI_SD1_LEVEL_HIGH: u1,
                GPIO_QSPI_SD1_EDGE_LOW: u1,
                GPIO_QSPI_SD1_EDGE_HIGH: u1,
                GPIO_QSPI_SD2_LEVEL_LOW: u1,
                GPIO_QSPI_SD2_LEVEL_HIGH: u1,
                GPIO_QSPI_SD2_EDGE_LOW: u1,
                GPIO_QSPI_SD2_EDGE_HIGH: u1,
                GPIO_QSPI_SD3_LEVEL_LOW: u1,
                GPIO_QSPI_SD3_LEVEL_HIGH: u1,
                GPIO_QSPI_SD3_EDGE_LOW: u1,
                GPIO_QSPI_SD3_EDGE_HIGH: u1,
                padding: u8,
            }),
            ///  Interrupt status after masking & forcing for dormant_wake
            DORMANT_WAKE_INTS: mmio.Mmio(packed struct(u32) {
                GPIO_QSPI_SCLK_LEVEL_LOW: u1,
                GPIO_QSPI_SCLK_LEVEL_HIGH: u1,
                GPIO_QSPI_SCLK_EDGE_LOW: u1,
                GPIO_QSPI_SCLK_EDGE_HIGH: u1,
                GPIO_QSPI_SS_LEVEL_LOW: u1,
                GPIO_QSPI_SS_LEVEL_HIGH: u1,
                GPIO_QSPI_SS_EDGE_LOW: u1,
                GPIO_QSPI_SS_EDGE_HIGH: u1,
                GPIO_QSPI_SD0_LEVEL_LOW: u1,
                GPIO_QSPI_SD0_LEVEL_HIGH: u1,
                GPIO_QSPI_SD0_EDGE_LOW: u1,
                GPIO_QSPI_SD0_EDGE_HIGH: u1,
                GPIO_QSPI_SD1_LEVEL_LOW: u1,
                GPIO_QSPI_SD1_LEVEL_HIGH: u1,
                GPIO_QSPI_SD1_EDGE_LOW: u1,
                GPIO_QSPI_SD1_EDGE_HIGH: u1,
                GPIO_QSPI_SD2_LEVEL_LOW: u1,
                GPIO_QSPI_SD2_LEVEL_HIGH: u1,
                GPIO_QSPI_SD2_EDGE_LOW: u1,
                GPIO_QSPI_SD2_EDGE_HIGH: u1,
                GPIO_QSPI_SD3_LEVEL_LOW: u1,
                GPIO_QSPI_SD3_LEVEL_HIGH: u1,
                GPIO_QSPI_SD3_EDGE_LOW: u1,
                GPIO_QSPI_SD3_EDGE_HIGH: u1,
                padding: u8,
            }),
        };

        pub const PADS_BANK0 = extern struct {
            ///  Voltage select. Per bank control
            VOLTAGE_SELECT: mmio.Mmio(packed struct(u32) {
                VOLTAGE_SELECT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Set voltage to 3.3V (DVDD >= 2V5)
                        @"3v3" = 0x0,
                        ///  Set voltage to 1.8V (DVDD <= 1V8)
                        @"1v8" = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Pad control register
            GPIO0: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO1: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO2: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO3: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO4: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO5: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO6: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO7: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO8: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO9: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO10: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO11: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO12: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO13: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO14: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO15: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO16: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO17: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO18: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO19: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO20: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO21: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO22: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO23: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO24: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO25: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO26: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO27: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO28: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO29: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            SWCLK: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            SWD: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
        };

        pub const PADS_QSPI = extern struct {
            ///  Voltage select. Per bank control
            VOLTAGE_SELECT: mmio.Mmio(packed struct(u32) {
                VOLTAGE_SELECT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Set voltage to 3.3V (DVDD >= 2V5)
                        @"3v3" = 0x0,
                        ///  Set voltage to 1.8V (DVDD <= 1V8)
                        @"1v8" = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  Pad control register
            GPIO_QSPI_SCLK: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO_QSPI_SD0: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO_QSPI_SD1: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO_QSPI_SD2: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO_QSPI_SD3: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
            ///  Pad control register
            GPIO_QSPI_SS: mmio.Mmio(packed struct(u32) {
                ///  Slew rate control. 1 = Fast, 0 = Slow
                SLEWFAST: u1,
                ///  Enable schmitt trigger
                SCHMITT: u1,
                ///  Pull down enable
                PDE: u1,
                ///  Pull up enable
                PUE: u1,
                ///  Drive strength.
                DRIVE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"2mA" = 0x0,
                        @"4mA" = 0x1,
                        @"8mA" = 0x2,
                        @"12mA" = 0x3,
                    },
                },
                ///  Input enable
                IE: u1,
                ///  Output disable. Has priority over output enable from peripherals
                OD: u1,
                padding: u24,
            }),
        };

        ///  Controls the crystal oscillator
        pub const XOSC = extern struct {
            ///  Crystal Oscillator Control
            CTRL: mmio.Mmio(packed struct(u32) {
                ///  Frequency range. This resets to 0xAA0 and cannot be changed.
                FREQ_RANGE: packed union {
                    raw: u12,
                    value: enum(u12) {
                        @"1_15MHZ" = 0xaa0,
                        RESERVED_1 = 0xaa1,
                        RESERVED_2 = 0xaa2,
                        RESERVED_3 = 0xaa3,
                        _,
                    },
                },
                ///  On power-up this field is initialised to DISABLE and the chip runs from the ROSC.
                ///  If the chip has subsequently been programmed to run from the XOSC then setting this field to DISABLE may lock-up the chip. If this is a concern then run the clk_ref from the ROSC and enable the clk_sys RESUS feature.
                ///  The 12-bit code is intended to give some protection against accidental writes. An invalid setting will enable the oscillator.
                ENABLE: packed union {
                    raw: u12,
                    value: enum(u12) {
                        DISABLE = 0xd1e,
                        ENABLE = 0xfab,
                        _,
                    },
                },
                padding: u8,
            }),
            ///  Crystal Oscillator Status
            STATUS: mmio.Mmio(packed struct(u32) {
                ///  The current frequency range setting, always reads 0
                FREQ_RANGE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"1_15MHZ" = 0x0,
                        RESERVED_1 = 0x1,
                        RESERVED_2 = 0x2,
                        RESERVED_3 = 0x3,
                    },
                },
                reserved12: u10,
                ///  Oscillator is enabled but not necessarily running and stable, resets to 0
                ENABLED: u1,
                reserved24: u11,
                ///  An invalid value has been written to CTRL_ENABLE or CTRL_FREQ_RANGE or DORMANT
                BADWRITE: u1,
                reserved31: u6,
                ///  Oscillator is running and stable
                STABLE: u1,
            }),
            ///  Crystal Oscillator pause control
            ///  This is used to save power by pausing the XOSC
            ///  On power-up this field is initialised to WAKE
            ///  An invalid write will also select WAKE
            ///  WARNING: stop the PLLs before selecting dormant mode
            ///  WARNING: setup the irq before selecting dormant mode
            DORMANT: u32,
            ///  Controls the startup delay
            STARTUP: mmio.Mmio(packed struct(u32) {
                ///  in multiples of 256*xtal_period. The reset value of 0xc4 corresponds to approx 50 000 cycles.
                DELAY: u14,
                reserved20: u6,
                ///  Multiplies the startup_delay by 4. This is of little value to the user given that the delay can be programmed directly.
                X4: u1,
                padding: u11,
            }),
            reserved28: [12]u8,
            ///  A down counter running at the xosc frequency which counts to zero and stops.
            ///  To start the counter write a non-zero value.
            ///  Can be used for short software pauses when setting up time sensitive hardware.
            COUNT: mmio.Mmio(packed struct(u32) {
                COUNT: u8,
                padding: u24,
            }),
        };

        pub const PLL_SYS = extern struct {
            ///  Control and Status
            ///  GENERAL CONSTRAINTS:
            ///  Reference clock frequency min=5MHz, max=800MHz
            ///  Feedback divider min=16, max=320
            ///  VCO frequency min=400MHz, max=1600MHz
            CS: mmio.Mmio(packed struct(u32) {
                ///  Divides the PLL input reference clock.
                ///  Behaviour is undefined for div=0.
                ///  PLL output will be unpredictable during refdiv changes, wait for lock=1 before using it.
                REFDIV: u6,
                reserved8: u2,
                ///  Passes the reference clock to the output instead of the divided VCO. The VCO continues to run so the user can switch between the reference clock and the divided VCO but the output will glitch when doing so.
                BYPASS: u1,
                reserved31: u22,
                ///  PLL is locked
                LOCK: u1,
            }),
            ///  Controls the PLL power modes.
            PWR: mmio.Mmio(packed struct(u32) {
                ///  PLL powerdown
                ///  To save power set high when PLL output not required.
                PD: u1,
                reserved2: u1,
                ///  PLL DSM powerdown
                ///  Nothing is achieved by setting this low.
                DSMPD: u1,
                ///  PLL post divider powerdown
                ///  To save power set high when PLL output not required or bypass=1.
                POSTDIVPD: u1,
                reserved5: u1,
                ///  PLL VCO powerdown
                ///  To save power set high when PLL output not required or bypass=1.
                VCOPD: u1,
                padding: u26,
            }),
            ///  Feedback divisor
            ///  (note: this PLL does not support fractional division)
            FBDIV_INT: mmio.Mmio(packed struct(u32) {
                ///  see ctrl reg description for constraints
                FBDIV_INT: u12,
                padding: u20,
            }),
            ///  Controls the PLL post dividers for the primary output
            ///  (note: this PLL does not have a secondary output)
            ///  the primary output is driven from VCO divided by postdiv1*postdiv2
            PRIM: mmio.Mmio(packed struct(u32) {
                reserved12: u12,
                ///  divide by 1-7
                POSTDIV2: u3,
                reserved16: u1,
                ///  divide by 1-7
                POSTDIV1: u3,
                padding: u13,
            }),
        };

        pub const PPB = extern struct {
            reserved57360: [57360]u8,
            ///  Use the SysTick Control and Status Register to enable the SysTick features.
            SYST_CSR: mmio.Mmio(packed struct(u32) {
                ///  Enable SysTick counter:
                ///  0 = Counter disabled.
                ///  1 = Counter enabled.
                ENABLE: u1,
                ///  Enables SysTick exception request:
                ///  0 = Counting down to zero does not assert the SysTick exception request.
                ///  1 = Counting down to zero to asserts the SysTick exception request.
                TICKINT: u1,
                ///  SysTick clock source. Always reads as one if SYST_CALIB reports NOREF.
                ///  Selects the SysTick timer clock source:
                ///  0 = External reference clock.
                ///  1 = Processor clock.
                CLKSOURCE: u1,
                reserved16: u13,
                ///  Returns 1 if timer counted to 0 since last time this was read. Clears on read by application or debugger.
                COUNTFLAG: u1,
                padding: u15,
            }),
            ///  Use the SysTick Reload Value Register to specify the start value to load into the current value register when the counter reaches 0. It can be any value between 0 and 0x00FFFFFF. A start value of 0 is possible, but has no effect because the SysTick interrupt and COUNTFLAG are activated when counting from 1 to 0. The reset value of this register is UNKNOWN.
            ///  To generate a multi-shot timer with a period of N processor clock cycles, use a RELOAD value of N-1. For example, if the SysTick interrupt is required every 100 clock pulses, set RELOAD to 99.
            SYST_RVR: mmio.Mmio(packed struct(u32) {
                ///  Value to load into the SysTick Current Value Register when the counter reaches 0.
                RELOAD: u24,
                padding: u8,
            }),
            ///  Use the SysTick Current Value Register to find the current value in the register. The reset value of this register is UNKNOWN.
            SYST_CVR: mmio.Mmio(packed struct(u32) {
                ///  Reads return the current value of the SysTick counter. This register is write-clear. Writing to it with any value clears the register to 0. Clearing this register also clears the COUNTFLAG bit of the SysTick Control and Status Register.
                CURRENT: u24,
                padding: u8,
            }),
            ///  Use the SysTick Calibration Value Register to enable software to scale to any required speed using divide and multiply.
            SYST_CALIB: mmio.Mmio(packed struct(u32) {
                ///  An optional Reload value to be used for 10ms (100Hz) timing, subject to system clock skew errors. If the value reads as 0, the calibration value is not known.
                TENMS: u24,
                reserved30: u6,
                ///  If reads as 1, the calibration value for 10ms is inexact (due to clock frequency).
                SKEW: u1,
                ///  If reads as 1, the Reference clock is not provided - the CLKSOURCE bit of the SysTick Control and Status register will be forced to 1 and cannot be cleared to 0.
                NOREF: u1,
            }),
            reserved57600: [224]u8,
            ///  Use the Interrupt Set-Enable Register to enable interrupts and determine which interrupts are currently enabled.
            ///  If a pending interrupt is enabled, the NVIC activates the interrupt based on its priority. If an interrupt is not enabled, asserting its interrupt signal changes the interrupt state to pending, but the NVIC never activates the interrupt, regardless of its priority.
            NVIC_ISER: mmio.Mmio(packed struct(u32) {
                ///  Interrupt set-enable bits.
                ///  Write:
                ///  0 = No effect.
                ///  1 = Enable interrupt.
                ///  Read:
                ///  0 = Interrupt disabled.
                ///  1 = Interrupt enabled.
                SETENA: u32,
            }),
            reserved57728: [124]u8,
            ///  Use the Interrupt Clear-Enable Registers to disable interrupts and determine which interrupts are currently enabled.
            NVIC_ICER: mmio.Mmio(packed struct(u32) {
                ///  Interrupt clear-enable bits.
                ///  Write:
                ///  0 = No effect.
                ///  1 = Disable interrupt.
                ///  Read:
                ///  0 = Interrupt disabled.
                ///  1 = Interrupt enabled.
                CLRENA: u32,
            }),
            reserved57856: [124]u8,
            ///  The NVIC_ISPR forces interrupts into the pending state, and shows which interrupts are pending.
            NVIC_ISPR: mmio.Mmio(packed struct(u32) {
                ///  Interrupt set-pending bits.
                ///  Write:
                ///  0 = No effect.
                ///  1 = Changes interrupt state to pending.
                ///  Read:
                ///  0 = Interrupt is not pending.
                ///  1 = Interrupt is pending.
                ///  Note: Writing 1 to the NVIC_ISPR bit corresponding to:
                ///  An interrupt that is pending has no effect.
                ///  A disabled interrupt sets the state of that interrupt to pending.
                SETPEND: u32,
            }),
            reserved57984: [124]u8,
            ///  Use the Interrupt Clear-Pending Register to clear pending interrupts and determine which interrupts are currently pending.
            NVIC_ICPR: mmio.Mmio(packed struct(u32) {
                ///  Interrupt clear-pending bits.
                ///  Write:
                ///  0 = No effect.
                ///  1 = Removes pending state and interrupt.
                ///  Read:
                ///  0 = Interrupt is not pending.
                ///  1 = Interrupt is pending.
                CLRPEND: u32,
            }),
            reserved58368: [380]u8,
            ///  Use the Interrupt Priority Registers to assign a priority from 0 to 3 to each of the available interrupts. 0 is the highest priority, and 3 is the lowest.
            ///  Note: Writing 1 to an NVIC_ICPR bit does not affect the active state of the corresponding interrupt.
            ///  These registers are only word-accessible
            NVIC_IPR0: mmio.Mmio(packed struct(u32) {
                reserved6: u6,
                ///  Priority of interrupt 0
                IP_0: u2,
                reserved14: u6,
                ///  Priority of interrupt 1
                IP_1: u2,
                reserved22: u6,
                ///  Priority of interrupt 2
                IP_2: u2,
                reserved30: u6,
                ///  Priority of interrupt 3
                IP_3: u2,
            }),
            ///  Use the Interrupt Priority Registers to assign a priority from 0 to 3 to each of the available interrupts. 0 is the highest priority, and 3 is the lowest.
            NVIC_IPR1: mmio.Mmio(packed struct(u32) {
                reserved6: u6,
                ///  Priority of interrupt 4
                IP_4: u2,
                reserved14: u6,
                ///  Priority of interrupt 5
                IP_5: u2,
                reserved22: u6,
                ///  Priority of interrupt 6
                IP_6: u2,
                reserved30: u6,
                ///  Priority of interrupt 7
                IP_7: u2,
            }),
            ///  Use the Interrupt Priority Registers to assign a priority from 0 to 3 to each of the available interrupts. 0 is the highest priority, and 3 is the lowest.
            NVIC_IPR2: mmio.Mmio(packed struct(u32) {
                reserved6: u6,
                ///  Priority of interrupt 8
                IP_8: u2,
                reserved14: u6,
                ///  Priority of interrupt 9
                IP_9: u2,
                reserved22: u6,
                ///  Priority of interrupt 10
                IP_10: u2,
                reserved30: u6,
                ///  Priority of interrupt 11
                IP_11: u2,
            }),
            ///  Use the Interrupt Priority Registers to assign a priority from 0 to 3 to each of the available interrupts. 0 is the highest priority, and 3 is the lowest.
            NVIC_IPR3: mmio.Mmio(packed struct(u32) {
                reserved6: u6,
                ///  Priority of interrupt 12
                IP_12: u2,
                reserved14: u6,
                ///  Priority of interrupt 13
                IP_13: u2,
                reserved22: u6,
                ///  Priority of interrupt 14
                IP_14: u2,
                reserved30: u6,
                ///  Priority of interrupt 15
                IP_15: u2,
            }),
            ///  Use the Interrupt Priority Registers to assign a priority from 0 to 3 to each of the available interrupts. 0 is the highest priority, and 3 is the lowest.
            NVIC_IPR4: mmio.Mmio(packed struct(u32) {
                reserved6: u6,
                ///  Priority of interrupt 16
                IP_16: u2,
                reserved14: u6,
                ///  Priority of interrupt 17
                IP_17: u2,
                reserved22: u6,
                ///  Priority of interrupt 18
                IP_18: u2,
                reserved30: u6,
                ///  Priority of interrupt 19
                IP_19: u2,
            }),
            ///  Use the Interrupt Priority Registers to assign a priority from 0 to 3 to each of the available interrupts. 0 is the highest priority, and 3 is the lowest.
            NVIC_IPR5: mmio.Mmio(packed struct(u32) {
                reserved6: u6,
                ///  Priority of interrupt 20
                IP_20: u2,
                reserved14: u6,
                ///  Priority of interrupt 21
                IP_21: u2,
                reserved22: u6,
                ///  Priority of interrupt 22
                IP_22: u2,
                reserved30: u6,
                ///  Priority of interrupt 23
                IP_23: u2,
            }),
            ///  Use the Interrupt Priority Registers to assign a priority from 0 to 3 to each of the available interrupts. 0 is the highest priority, and 3 is the lowest.
            NVIC_IPR6: mmio.Mmio(packed struct(u32) {
                reserved6: u6,
                ///  Priority of interrupt 24
                IP_24: u2,
                reserved14: u6,
                ///  Priority of interrupt 25
                IP_25: u2,
                reserved22: u6,
                ///  Priority of interrupt 26
                IP_26: u2,
                reserved30: u6,
                ///  Priority of interrupt 27
                IP_27: u2,
            }),
            ///  Use the Interrupt Priority Registers to assign a priority from 0 to 3 to each of the available interrupts. 0 is the highest priority, and 3 is the lowest.
            NVIC_IPR7: mmio.Mmio(packed struct(u32) {
                reserved6: u6,
                ///  Priority of interrupt 28
                IP_28: u2,
                reserved14: u6,
                ///  Priority of interrupt 29
                IP_29: u2,
                reserved22: u6,
                ///  Priority of interrupt 30
                IP_30: u2,
                reserved30: u6,
                ///  Priority of interrupt 31
                IP_31: u2,
            }),
            reserved60672: [2272]u8,
            ///  Read the CPU ID Base Register to determine: the ID number of the processor core, the version number of the processor core, the implementation details of the processor core.
            CPUID: mmio.Mmio(packed struct(u32) {
                ///  Minor revision number m in the rnpm revision status:
                ///  0x1 = Patch 1.
                REVISION: u4,
                ///  Number of processor within family: 0xC60 = Cortex-M0+
                PARTNO: u12,
                ///  Constant that defines the architecture of the processor:
                ///  0xC = ARMv6-M architecture.
                ARCHITECTURE: u4,
                ///  Major revision number n in the rnpm revision status:
                ///  0x0 = Revision 0.
                VARIANT: u4,
                ///  Implementor code: 0x41 = ARM
                IMPLEMENTER: u8,
            }),
            ///  Use the Interrupt Control State Register to set a pending Non-Maskable Interrupt (NMI), set or clear a pending PendSV, set or clear a pending SysTick, check for pending exceptions, check the vector number of the highest priority pended exception, check the vector number of the active exception.
            ICSR: mmio.Mmio(packed struct(u32) {
                ///  Active exception number field. Reset clears the VECTACTIVE field.
                VECTACTIVE: u9,
                reserved12: u3,
                ///  Indicates the exception number for the highest priority pending exception: 0 = no pending exceptions. Non zero = The pending state includes the effect of memory-mapped enable and mask registers. It does not include the PRIMASK special-purpose register qualifier.
                VECTPENDING: u9,
                reserved22: u1,
                ///  External interrupt pending flag
                ISRPENDING: u1,
                ///  The system can only access this bit when the core is halted. It indicates that a pending interrupt is to be taken in the next running cycle. If C_MASKINTS is clear in the Debug Halting Control and Status Register, the interrupt is serviced.
                ISRPREEMPT: u1,
                reserved25: u1,
                ///  SysTick exception clear-pending bit.
                ///  Write:
                ///  0 = No effect.
                ///  1 = Removes the pending state from the SysTick exception.
                ///  This bit is WO. On a register read its value is Unknown.
                PENDSTCLR: u1,
                ///  SysTick exception set-pending bit.
                ///  Write:
                ///  0 = No effect.
                ///  1 = Changes SysTick exception state to pending.
                ///  Read:
                ///  0 = SysTick exception is not pending.
                ///  1 = SysTick exception is pending.
                PENDSTSET: u1,
                ///  PendSV clear-pending bit.
                ///  Write:
                ///  0 = No effect.
                ///  1 = Removes the pending state from the PendSV exception.
                PENDSVCLR: u1,
                ///  PendSV set-pending bit.
                ///  Write:
                ///  0 = No effect.
                ///  1 = Changes PendSV exception state to pending.
                ///  Read:
                ///  0 = PendSV exception is not pending.
                ///  1 = PendSV exception is pending.
                ///  Writing 1 to this bit is the only way to set the PendSV exception state to pending.
                PENDSVSET: u1,
                reserved31: u2,
                ///  Setting this bit will activate an NMI. Since NMI is the highest priority exception, it will activate as soon as it is registered.
                ///  NMI set-pending bit.
                ///  Write:
                ///  0 = No effect.
                ///  1 = Changes NMI exception state to pending.
                ///  Read:
                ///  0 = NMI exception is not pending.
                ///  1 = NMI exception is pending.
                ///  Because NMI is the highest-priority exception, normally the processor enters the NMI
                ///  exception handler as soon as it detects a write of 1 to this bit. Entering the handler then clears
                ///  this bit to 0. This means a read of this bit by the NMI exception handler returns 1 only if the
                ///  NMI signal is reasserted while the processor is executing that handler.
                NMIPENDSET: u1,
            }),
            ///  The VTOR holds the vector table offset address.
            VTOR: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  Bits [31:8] of the indicate the vector table offset address.
                TBLOFF: u24,
            }),
            ///  Use the Application Interrupt and Reset Control Register to: determine data endianness, clear all active state information from debug halt mode, request a system reset.
            AIRCR: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Clears all active state information for fixed and configurable exceptions. This bit: is self-clearing, can only be set by the DAP when the core is halted. When set: clears all active exception status of the processor, forces a return to Thread mode, forces an IPSR of 0. A debugger must re-initialize the stack.
                VECTCLRACTIVE: u1,
                ///  Writing 1 to this bit causes the SYSRESETREQ signal to the outer system to be asserted to request a reset. The intention is to force a large system reset of all major components except for debug. The C_HALT bit in the DHCSR is cleared as a result of the system reset requested. The debugger does not lose contact with the device.
                SYSRESETREQ: u1,
                reserved15: u12,
                ///  Data endianness implemented:
                ///  0 = Little-endian.
                ENDIANESS: u1,
                ///  Register key:
                ///  Reads as Unknown
                ///  On writes, write 0x05FA to VECTKEY, otherwise the write is ignored.
                VECTKEY: u16,
            }),
            ///  System Control Register. Use the System Control Register for power-management functions: signal to the system when the processor can enter a low power state, control how the processor enters and exits low power states.
            SCR: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Indicates sleep-on-exit when returning from Handler mode to Thread mode:
                ///  0 = Do not sleep when returning to Thread mode.
                ///  1 = Enter sleep, or deep sleep, on return from an ISR to Thread mode.
                ///  Setting this bit to 1 enables an interrupt driven application to avoid returning to an empty main application.
                SLEEPONEXIT: u1,
                ///  Controls whether the processor uses sleep or deep sleep as its low power mode:
                ///  0 = Sleep.
                ///  1 = Deep sleep.
                SLEEPDEEP: u1,
                reserved4: u1,
                ///  Send Event on Pending bit:
                ///  0 = Only enabled interrupts or events can wakeup the processor, disabled interrupts are excluded.
                ///  1 = Enabled events and all interrupts, including disabled interrupts, can wakeup the processor.
                ///  When an event or interrupt becomes pending, the event signal wakes up the processor from WFE. If the
                ///  processor is not waiting for an event, the event is registered and affects the next WFE.
                ///  The processor also wakes up on execution of an SEV instruction or an external event.
                SEVONPEND: u1,
                padding: u27,
            }),
            ///  The Configuration and Control Register permanently enables stack alignment and causes unaligned accesses to result in a Hard Fault.
            CCR: mmio.Mmio(packed struct(u32) {
                reserved3: u3,
                ///  Always reads as one, indicates that all unaligned accesses generate a HardFault.
                UNALIGN_TRP: u1,
                reserved9: u5,
                ///  Always reads as one, indicates 8-byte stack alignment on exception entry. On exception entry, the processor uses bit[9] of the stacked PSR to indicate the stack alignment. On return from the exception it uses this stacked bit to restore the correct stack alignment.
                STKALIGN: u1,
                padding: u22,
            }),
            reserved60700: [4]u8,
            ///  System handlers are a special class of exception handler that can have their priority set to any of the priority levels. Use the System Handler Priority Register 2 to set the priority of SVCall.
            SHPR2: mmio.Mmio(packed struct(u32) {
                reserved30: u30,
                ///  Priority of system handler 11, SVCall
                PRI_11: u2,
            }),
            ///  System handlers are a special class of exception handler that can have their priority set to any of the priority levels. Use the System Handler Priority Register 3 to set the priority of PendSV and SysTick.
            SHPR3: mmio.Mmio(packed struct(u32) {
                reserved22: u22,
                ///  Priority of system handler 14, PendSV
                PRI_14: u2,
                reserved30: u6,
                ///  Priority of system handler 15, SysTick
                PRI_15: u2,
            }),
            ///  Use the System Handler Control and State Register to determine or clear the pending status of SVCall.
            SHCSR: mmio.Mmio(packed struct(u32) {
                reserved15: u15,
                ///  Reads as 1 if SVCall is Pending. Write 1 to set pending SVCall, write 0 to clear pending SVCall.
                SVCALLPENDED: u1,
                padding: u16,
            }),
            reserved60816: [104]u8,
            ///  Read the MPU Type Register to determine if the processor implements an MPU, and how many regions the MPU supports.
            MPU_TYPE: mmio.Mmio(packed struct(u32) {
                ///  Indicates support for separate instruction and data address maps. Reads as 0 as ARMv6-M only supports a unified MPU.
                SEPARATE: u1,
                reserved8: u7,
                ///  Number of regions supported by the MPU.
                DREGION: u8,
                ///  Instruction region. Reads as zero as ARMv6-M only supports a unified MPU.
                IREGION: u8,
                padding: u8,
            }),
            ///  Use the MPU Control Register to enable and disable the MPU, and to control whether the default memory map is enabled as a background region for privileged accesses, and whether the MPU is enabled for HardFaults and NMIs.
            MPU_CTRL: mmio.Mmio(packed struct(u32) {
                ///  Enables the MPU. If the MPU is disabled, privileged and unprivileged accesses use the default memory map.
                ///  0 = MPU disabled.
                ///  1 = MPU enabled.
                ENABLE: u1,
                ///  Controls the use of the MPU for HardFaults and NMIs. Setting this bit when ENABLE is clear results in UNPREDICTABLE behaviour.
                ///  When the MPU is enabled:
                ///  0 = MPU is disabled during HardFault and NMI handlers, regardless of the value of the ENABLE bit.
                ///  1 = the MPU is enabled during HardFault and NMI handlers.
                HFNMIENA: u1,
                ///  Controls whether the default memory map is enabled as a background region for privileged accesses. This bit is ignored when ENABLE is clear.
                ///  0 = If the MPU is enabled, disables use of the default memory map. Any memory access to a location not
                ///  covered by any enabled region causes a fault.
                ///  1 = If the MPU is enabled, enables use of the default memory map as a background region for privileged software accesses.
                ///  When enabled, the background region acts as if it is region number -1. Any region that is defined and enabled has priority over this default map.
                PRIVDEFENA: u1,
                padding: u29,
            }),
            ///  Use the MPU Region Number Register to select the region currently accessed by MPU_RBAR and MPU_RASR.
            MPU_RNR: mmio.Mmio(packed struct(u32) {
                ///  Indicates the MPU region referenced by the MPU_RBAR and MPU_RASR registers.
                ///  The MPU supports 8 memory regions, so the permitted values of this field are 0-7.
                REGION: u4,
                padding: u28,
            }),
            ///  Read the MPU Region Base Address Register to determine the base address of the region identified by MPU_RNR. Write to update the base address of said region or that of a specified region, with whose number MPU_RNR will also be updated.
            MPU_RBAR: mmio.Mmio(packed struct(u32) {
                ///  On writes, specifies the number of the region whose base address to update provided VALID is set written as 1. On reads, returns bits [3:0] of MPU_RNR.
                REGION: u4,
                ///  On writes, indicates whether the write must update the base address of the region identified by the REGION field, updating the MPU_RNR to indicate this new region.
                ///  Write:
                ///  0 = MPU_RNR not changed, and the processor:
                ///  Updates the base address for the region specified in the MPU_RNR.
                ///  Ignores the value of the REGION field.
                ///  1 = The processor:
                ///  Updates the value of the MPU_RNR to the value of the REGION field.
                ///  Updates the base address for the region specified in the REGION field.
                ///  Always reads as zero.
                VALID: u1,
                reserved8: u3,
                ///  Base address of the region.
                ADDR: u24,
            }),
            ///  Use the MPU Region Attribute and Size Register to define the size, access behaviour and memory type of the region identified by MPU_RNR, and enable that region.
            MPU_RASR: mmio.Mmio(packed struct(u32) {
                ///  Enables the region.
                ENABLE: u1,
                ///  Indicates the region size. Region size in bytes = 2^(SIZE+1). The minimum permitted value is 7 (b00111) = 256Bytes
                SIZE: u5,
                reserved8: u2,
                ///  Subregion Disable. For regions of 256 bytes or larger, each bit of this field controls whether one of the eight equal subregions is enabled.
                SRD: u8,
                ///  The MPU Region Attribute field. Use to define the region attribute control.
                ///  28 = XN: Instruction access disable bit:
                ///  0 = Instruction fetches enabled.
                ///  1 = Instruction fetches disabled.
                ///  26:24 = AP: Access permission field
                ///  18 = S: Shareable bit
                ///  17 = C: Cacheable bit
                ///  16 = B: Bufferable bit
                ATTRS: u16,
            }),
        };

        ///  Register block for busfabric control signals and performance counters
        pub const BUSCTRL = extern struct {
            ///  Set the priority of each master for bus arbitration.
            BUS_PRIORITY: mmio.Mmio(packed struct(u32) {
                ///  0 - low priority, 1 - high priority
                PROC0: u1,
                reserved4: u3,
                ///  0 - low priority, 1 - high priority
                PROC1: u1,
                reserved8: u3,
                ///  0 - low priority, 1 - high priority
                DMA_R: u1,
                reserved12: u3,
                ///  0 - low priority, 1 - high priority
                DMA_W: u1,
                padding: u19,
            }),
            ///  Bus priority acknowledge
            BUS_PRIORITY_ACK: mmio.Mmio(packed struct(u32) {
                ///  Goes to 1 once all arbiters have registered the new global priority levels.
                ///  Arbiters update their local priority when servicing a new nonsequential access.
                ///  In normal circumstances this will happen almost immediately.
                BUS_PRIORITY_ACK: u1,
                padding: u31,
            }),
            ///  Bus fabric performance counter 0
            PERFCTR0: mmio.Mmio(packed struct(u32) {
                ///  Busfabric saturating performance counter 0
                ///  Count some event signal from the busfabric arbiters.
                ///  Write any value to clear. Select an event to count using PERFSEL0
                PERFCTR0: u24,
                padding: u8,
            }),
            ///  Bus fabric performance event select for PERFCTR0
            PERFSEL0: mmio.Mmio(packed struct(u32) {
                ///  Select an event for PERFCTR0. Count either contested accesses, or all accesses, on a downstream port of the main crossbar.
                PERFSEL0: packed union {
                    raw: u5,
                    value: enum(u5) {
                        apb_contested = 0x0,
                        apb = 0x1,
                        fastperi_contested = 0x2,
                        fastperi = 0x3,
                        sram5_contested = 0x4,
                        sram5 = 0x5,
                        sram4_contested = 0x6,
                        sram4 = 0x7,
                        sram3_contested = 0x8,
                        sram3 = 0x9,
                        sram2_contested = 0xa,
                        sram2 = 0xb,
                        sram1_contested = 0xc,
                        sram1 = 0xd,
                        sram0_contested = 0xe,
                        sram0 = 0xf,
                        xip_main_contested = 0x10,
                        xip_main = 0x11,
                        rom_contested = 0x12,
                        rom = 0x13,
                        _,
                    },
                },
                padding: u27,
            }),
            ///  Bus fabric performance counter 1
            PERFCTR1: mmio.Mmio(packed struct(u32) {
                ///  Busfabric saturating performance counter 1
                ///  Count some event signal from the busfabric arbiters.
                ///  Write any value to clear. Select an event to count using PERFSEL1
                PERFCTR1: u24,
                padding: u8,
            }),
            ///  Bus fabric performance event select for PERFCTR1
            PERFSEL1: mmio.Mmio(packed struct(u32) {
                ///  Select an event for PERFCTR1. Count either contested accesses, or all accesses, on a downstream port of the main crossbar.
                PERFSEL1: packed union {
                    raw: u5,
                    value: enum(u5) {
                        apb_contested = 0x0,
                        apb = 0x1,
                        fastperi_contested = 0x2,
                        fastperi = 0x3,
                        sram5_contested = 0x4,
                        sram5 = 0x5,
                        sram4_contested = 0x6,
                        sram4 = 0x7,
                        sram3_contested = 0x8,
                        sram3 = 0x9,
                        sram2_contested = 0xa,
                        sram2 = 0xb,
                        sram1_contested = 0xc,
                        sram1 = 0xd,
                        sram0_contested = 0xe,
                        sram0 = 0xf,
                        xip_main_contested = 0x10,
                        xip_main = 0x11,
                        rom_contested = 0x12,
                        rom = 0x13,
                        _,
                    },
                },
                padding: u27,
            }),
            ///  Bus fabric performance counter 2
            PERFCTR2: mmio.Mmio(packed struct(u32) {
                ///  Busfabric saturating performance counter 2
                ///  Count some event signal from the busfabric arbiters.
                ///  Write any value to clear. Select an event to count using PERFSEL2
                PERFCTR2: u24,
                padding: u8,
            }),
            ///  Bus fabric performance event select for PERFCTR2
            PERFSEL2: mmio.Mmio(packed struct(u32) {
                ///  Select an event for PERFCTR2. Count either contested accesses, or all accesses, on a downstream port of the main crossbar.
                PERFSEL2: packed union {
                    raw: u5,
                    value: enum(u5) {
                        apb_contested = 0x0,
                        apb = 0x1,
                        fastperi_contested = 0x2,
                        fastperi = 0x3,
                        sram5_contested = 0x4,
                        sram5 = 0x5,
                        sram4_contested = 0x6,
                        sram4 = 0x7,
                        sram3_contested = 0x8,
                        sram3 = 0x9,
                        sram2_contested = 0xa,
                        sram2 = 0xb,
                        sram1_contested = 0xc,
                        sram1 = 0xd,
                        sram0_contested = 0xe,
                        sram0 = 0xf,
                        xip_main_contested = 0x10,
                        xip_main = 0x11,
                        rom_contested = 0x12,
                        rom = 0x13,
                        _,
                    },
                },
                padding: u27,
            }),
            ///  Bus fabric performance counter 3
            PERFCTR3: mmio.Mmio(packed struct(u32) {
                ///  Busfabric saturating performance counter 3
                ///  Count some event signal from the busfabric arbiters.
                ///  Write any value to clear. Select an event to count using PERFSEL3
                PERFCTR3: u24,
                padding: u8,
            }),
            ///  Bus fabric performance event select for PERFCTR3
            PERFSEL3: mmio.Mmio(packed struct(u32) {
                ///  Select an event for PERFCTR3. Count either contested accesses, or all accesses, on a downstream port of the main crossbar.
                PERFSEL3: packed union {
                    raw: u5,
                    value: enum(u5) {
                        apb_contested = 0x0,
                        apb = 0x1,
                        fastperi_contested = 0x2,
                        fastperi = 0x3,
                        sram5_contested = 0x4,
                        sram5 = 0x5,
                        sram4_contested = 0x6,
                        sram4 = 0x7,
                        sram3_contested = 0x8,
                        sram3 = 0x9,
                        sram2_contested = 0xa,
                        sram2 = 0xb,
                        sram1_contested = 0xc,
                        sram1 = 0xd,
                        sram0_contested = 0xe,
                        sram0 = 0xf,
                        xip_main_contested = 0x10,
                        xip_main = 0x11,
                        rom_contested = 0x12,
                        rom = 0x13,
                        _,
                    },
                },
                padding: u27,
            }),
        };

        pub const UART0 = extern struct {
            ///  Data Register, UARTDR
            UARTDR: mmio.Mmio(packed struct(u32) {
                ///  Receive (read) data character. Transmit (write) data character.
                DATA: u8,
                ///  Framing error. When set to 1, it indicates that the received character did not have a valid stop bit (a valid stop bit is 1). In FIFO mode, this error is associated with the character at the top of the FIFO.
                FE: u1,
                ///  Parity error. When set to 1, it indicates that the parity of the received data character does not match the parity that the EPS and SPS bits in the Line Control Register, UARTLCR_H. In FIFO mode, this error is associated with the character at the top of the FIFO.
                PE: u1,
                ///  Break error. This bit is set to 1 if a break condition was detected, indicating that the received data input was held LOW for longer than a full-word transmission time (defined as start, data, parity and stop bits). In FIFO mode, this error is associated with the character at the top of the FIFO. When a break occurs, only one 0 character is loaded into the FIFO. The next character is only enabled after the receive data input goes to a 1 (marking state), and the next valid start bit is received.
                BE: u1,
                ///  Overrun error. This bit is set to 1 if data is received and the receive FIFO is already full. This is cleared to 0 once there is an empty space in the FIFO and a new character can be written to it.
                OE: u1,
                padding: u20,
            }),
            ///  Receive Status Register/Error Clear Register, UARTRSR/UARTECR
            UARTRSR: mmio.Mmio(packed struct(u32) {
                ///  Framing error. When set to 1, it indicates that the received character did not have a valid stop bit (a valid stop bit is 1). This bit is cleared to 0 by a write to UARTECR. In FIFO mode, this error is associated with the character at the top of the FIFO.
                FE: u1,
                ///  Parity error. When set to 1, it indicates that the parity of the received data character does not match the parity that the EPS and SPS bits in the Line Control Register, UARTLCR_H. This bit is cleared to 0 by a write to UARTECR. In FIFO mode, this error is associated with the character at the top of the FIFO.
                PE: u1,
                ///  Break error. This bit is set to 1 if a break condition was detected, indicating that the received data input was held LOW for longer than a full-word transmission time (defined as start, data, parity, and stop bits). This bit is cleared to 0 after a write to UARTECR. In FIFO mode, this error is associated with the character at the top of the FIFO. When a break occurs, only one 0 character is loaded into the FIFO. The next character is only enabled after the receive data input goes to a 1 (marking state) and the next valid start bit is received.
                BE: u1,
                ///  Overrun error. This bit is set to 1 if data is received and the FIFO is already full. This bit is cleared to 0 by a write to UARTECR. The FIFO contents remain valid because no more data is written when the FIFO is full, only the contents of the shift register are overwritten. The CPU must now read the data, to empty the FIFO.
                OE: u1,
                padding: u28,
            }),
            reserved24: [16]u8,
            ///  Flag Register, UARTFR
            UARTFR: mmio.Mmio(packed struct(u32) {
                ///  Clear to send. This bit is the complement of the UART clear to send, nUARTCTS, modem status input. That is, the bit is 1 when nUARTCTS is LOW.
                CTS: u1,
                ///  Data set ready. This bit is the complement of the UART data set ready, nUARTDSR, modem status input. That is, the bit is 1 when nUARTDSR is LOW.
                DSR: u1,
                ///  Data carrier detect. This bit is the complement of the UART data carrier detect, nUARTDCD, modem status input. That is, the bit is 1 when nUARTDCD is LOW.
                DCD: u1,
                ///  UART busy. If this bit is set to 1, the UART is busy transmitting data. This bit remains set until the complete byte, including all the stop bits, has been sent from the shift register. This bit is set as soon as the transmit FIFO becomes non-empty, regardless of whether the UART is enabled or not.
                BUSY: u1,
                ///  Receive FIFO empty. The meaning of this bit depends on the state of the FEN bit in the UARTLCR_H Register. If the FIFO is disabled, this bit is set when the receive holding register is empty. If the FIFO is enabled, the RXFE bit is set when the receive FIFO is empty.
                RXFE: u1,
                ///  Transmit FIFO full. The meaning of this bit depends on the state of the FEN bit in the UARTLCR_H Register. If the FIFO is disabled, this bit is set when the transmit holding register is full. If the FIFO is enabled, the TXFF bit is set when the transmit FIFO is full.
                TXFF: u1,
                ///  Receive FIFO full. The meaning of this bit depends on the state of the FEN bit in the UARTLCR_H Register. If the FIFO is disabled, this bit is set when the receive holding register is full. If the FIFO is enabled, the RXFF bit is set when the receive FIFO is full.
                RXFF: u1,
                ///  Transmit FIFO empty. The meaning of this bit depends on the state of the FEN bit in the Line Control Register, UARTLCR_H. If the FIFO is disabled, this bit is set when the transmit holding register is empty. If the FIFO is enabled, the TXFE bit is set when the transmit FIFO is empty. This bit does not indicate if there is data in the transmit shift register.
                TXFE: u1,
                ///  Ring indicator. This bit is the complement of the UART ring indicator, nUARTRI, modem status input. That is, the bit is 1 when nUARTRI is LOW.
                RI: u1,
                padding: u23,
            }),
            reserved32: [4]u8,
            ///  IrDA Low-Power Counter Register, UARTILPR
            UARTILPR: mmio.Mmio(packed struct(u32) {
                ///  8-bit low-power divisor value. These bits are cleared to 0 at reset.
                ILPDVSR: u8,
                padding: u24,
            }),
            ///  Integer Baud Rate Register, UARTIBRD
            UARTIBRD: mmio.Mmio(packed struct(u32) {
                ///  The integer baud rate divisor. These bits are cleared to 0 on reset.
                BAUD_DIVINT: u16,
                padding: u16,
            }),
            ///  Fractional Baud Rate Register, UARTFBRD
            UARTFBRD: mmio.Mmio(packed struct(u32) {
                ///  The fractional baud rate divisor. These bits are cleared to 0 on reset.
                BAUD_DIVFRAC: u6,
                padding: u26,
            }),
            ///  Line Control Register, UARTLCR_H
            UARTLCR_H: mmio.Mmio(packed struct(u32) {
                ///  Send break. If this bit is set to 1, a low-level is continually output on the UARTTXD output, after completing transmission of the current character. For the proper execution of the break command, the software must set this bit for at least two complete frames. For normal use, this bit must be cleared to 0.
                BRK: u1,
                ///  Parity enable: 0 = parity is disabled and no parity bit added to the data frame 1 = parity checking and generation is enabled.
                PEN: u1,
                ///  Even parity select. Controls the type of parity the UART uses during transmission and reception: 0 = odd parity. The UART generates or checks for an odd number of 1s in the data and parity bits. 1 = even parity. The UART generates or checks for an even number of 1s in the data and parity bits. This bit has no effect when the PEN bit disables parity checking and generation.
                EPS: u1,
                ///  Two stop bits select. If this bit is set to 1, two stop bits are transmitted at the end of the frame. The receive logic does not check for two stop bits being received.
                STP2: u1,
                ///  Enable FIFOs: 0 = FIFOs are disabled (character mode) that is, the FIFOs become 1-byte-deep holding registers 1 = transmit and receive FIFO buffers are enabled (FIFO mode).
                FEN: u1,
                ///  Word length. These bits indicate the number of data bits transmitted or received in a frame as follows: b11 = 8 bits b10 = 7 bits b01 = 6 bits b00 = 5 bits.
                WLEN: u2,
                ///  Stick parity select. 0 = stick parity is disabled 1 = either: * if the EPS bit is 0 then the parity bit is transmitted and checked as a 1 * if the EPS bit is 1 then the parity bit is transmitted and checked as a 0. This bit has no effect when the PEN bit disables parity checking and generation.
                SPS: u1,
                padding: u24,
            }),
            ///  Control Register, UARTCR
            UARTCR: mmio.Mmio(packed struct(u32) {
                ///  UART enable: 0 = UART is disabled. If the UART is disabled in the middle of transmission or reception, it completes the current character before stopping. 1 = the UART is enabled. Data transmission and reception occurs for either UART signals or SIR signals depending on the setting of the SIREN bit.
                UARTEN: u1,
                ///  SIR enable: 0 = IrDA SIR ENDEC is disabled. nSIROUT remains LOW (no light pulse generated), and signal transitions on SIRIN have no effect. 1 = IrDA SIR ENDEC is enabled. Data is transmitted and received on nSIROUT and SIRIN. UARTTXD remains HIGH, in the marking state. Signal transitions on UARTRXD or modem status inputs have no effect. This bit has no effect if the UARTEN bit disables the UART.
                SIREN: u1,
                ///  SIR low-power IrDA mode. This bit selects the IrDA encoding mode. If this bit is cleared to 0, low-level bits are transmitted as an active high pulse with a width of 3 / 16th of the bit period. If this bit is set to 1, low-level bits are transmitted with a pulse width that is 3 times the period of the IrLPBaud16 input signal, regardless of the selected bit rate. Setting this bit uses less power, but might reduce transmission distances.
                SIRLP: u1,
                reserved7: u4,
                ///  Loopback enable. If this bit is set to 1 and the SIREN bit is set to 1 and the SIRTEST bit in the Test Control Register, UARTTCR is set to 1, then the nSIROUT path is inverted, and fed through to the SIRIN path. The SIRTEST bit in the test register must be set to 1 to override the normal half-duplex SIR operation. This must be the requirement for accessing the test registers during normal operation, and SIRTEST must be cleared to 0 when loopback testing is finished. This feature reduces the amount of external coupling required during system test. If this bit is set to 1, and the SIRTEST bit is set to 0, the UARTTXD path is fed through to the UARTRXD path. In either SIR mode or UART mode, when this bit is set, the modem outputs are also fed through to the modem inputs. This bit is cleared to 0 on reset, to disable loopback.
                LBE: u1,
                ///  Transmit enable. If this bit is set to 1, the transmit section of the UART is enabled. Data transmission occurs for either UART signals, or SIR signals depending on the setting of the SIREN bit. When the UART is disabled in the middle of transmission, it completes the current character before stopping.
                TXE: u1,
                ///  Receive enable. If this bit is set to 1, the receive section of the UART is enabled. Data reception occurs for either UART signals or SIR signals depending on the setting of the SIREN bit. When the UART is disabled in the middle of reception, it completes the current character before stopping.
                RXE: u1,
                ///  Data transmit ready. This bit is the complement of the UART data transmit ready, nUARTDTR, modem status output. That is, when the bit is programmed to a 1 then nUARTDTR is LOW.
                DTR: u1,
                ///  Request to send. This bit is the complement of the UART request to send, nUARTRTS, modem status output. That is, when the bit is programmed to a 1 then nUARTRTS is LOW.
                RTS: u1,
                ///  This bit is the complement of the UART Out1 (nUARTOut1) modem status output. That is, when the bit is programmed to a 1 the output is 0. For DTE this can be used as Data Carrier Detect (DCD).
                OUT1: u1,
                ///  This bit is the complement of the UART Out2 (nUARTOut2) modem status output. That is, when the bit is programmed to a 1, the output is 0. For DTE this can be used as Ring Indicator (RI).
                OUT2: u1,
                ///  RTS hardware flow control enable. If this bit is set to 1, RTS hardware flow control is enabled. Data is only requested when there is space in the receive FIFO for it to be received.
                RTSEN: u1,
                ///  CTS hardware flow control enable. If this bit is set to 1, CTS hardware flow control is enabled. Data is only transmitted when the nUARTCTS signal is asserted.
                CTSEN: u1,
                padding: u16,
            }),
            ///  Interrupt FIFO Level Select Register, UARTIFLS
            UARTIFLS: mmio.Mmio(packed struct(u32) {
                ///  Transmit interrupt FIFO level select. The trigger points for the transmit interrupt are as follows: b000 = Transmit FIFO becomes <= 1 / 8 full b001 = Transmit FIFO becomes <= 1 / 4 full b010 = Transmit FIFO becomes <= 1 / 2 full b011 = Transmit FIFO becomes <= 3 / 4 full b100 = Transmit FIFO becomes <= 7 / 8 full b101-b111 = reserved.
                TXIFLSEL: u3,
                ///  Receive interrupt FIFO level select. The trigger points for the receive interrupt are as follows: b000 = Receive FIFO becomes >= 1 / 8 full b001 = Receive FIFO becomes >= 1 / 4 full b010 = Receive FIFO becomes >= 1 / 2 full b011 = Receive FIFO becomes >= 3 / 4 full b100 = Receive FIFO becomes >= 7 / 8 full b101-b111 = reserved.
                RXIFLSEL: u3,
                padding: u26,
            }),
            ///  Interrupt Mask Set/Clear Register, UARTIMSC
            UARTIMSC: mmio.Mmio(packed struct(u32) {
                ///  nUARTRI modem interrupt mask. A read returns the current mask for the UARTRIINTR interrupt. On a write of 1, the mask of the UARTRIINTR interrupt is set. A write of 0 clears the mask.
                RIMIM: u1,
                ///  nUARTCTS modem interrupt mask. A read returns the current mask for the UARTCTSINTR interrupt. On a write of 1, the mask of the UARTCTSINTR interrupt is set. A write of 0 clears the mask.
                CTSMIM: u1,
                ///  nUARTDCD modem interrupt mask. A read returns the current mask for the UARTDCDINTR interrupt. On a write of 1, the mask of the UARTDCDINTR interrupt is set. A write of 0 clears the mask.
                DCDMIM: u1,
                ///  nUARTDSR modem interrupt mask. A read returns the current mask for the UARTDSRINTR interrupt. On a write of 1, the mask of the UARTDSRINTR interrupt is set. A write of 0 clears the mask.
                DSRMIM: u1,
                ///  Receive interrupt mask. A read returns the current mask for the UARTRXINTR interrupt. On a write of 1, the mask of the UARTRXINTR interrupt is set. A write of 0 clears the mask.
                RXIM: u1,
                ///  Transmit interrupt mask. A read returns the current mask for the UARTTXINTR interrupt. On a write of 1, the mask of the UARTTXINTR interrupt is set. A write of 0 clears the mask.
                TXIM: u1,
                ///  Receive timeout interrupt mask. A read returns the current mask for the UARTRTINTR interrupt. On a write of 1, the mask of the UARTRTINTR interrupt is set. A write of 0 clears the mask.
                RTIM: u1,
                ///  Framing error interrupt mask. A read returns the current mask for the UARTFEINTR interrupt. On a write of 1, the mask of the UARTFEINTR interrupt is set. A write of 0 clears the mask.
                FEIM: u1,
                ///  Parity error interrupt mask. A read returns the current mask for the UARTPEINTR interrupt. On a write of 1, the mask of the UARTPEINTR interrupt is set. A write of 0 clears the mask.
                PEIM: u1,
                ///  Break error interrupt mask. A read returns the current mask for the UARTBEINTR interrupt. On a write of 1, the mask of the UARTBEINTR interrupt is set. A write of 0 clears the mask.
                BEIM: u1,
                ///  Overrun error interrupt mask. A read returns the current mask for the UARTOEINTR interrupt. On a write of 1, the mask of the UARTOEINTR interrupt is set. A write of 0 clears the mask.
                OEIM: u1,
                padding: u21,
            }),
            ///  Raw Interrupt Status Register, UARTRIS
            UARTRIS: mmio.Mmio(packed struct(u32) {
                ///  nUARTRI modem interrupt status. Returns the raw interrupt state of the UARTRIINTR interrupt.
                RIRMIS: u1,
                ///  nUARTCTS modem interrupt status. Returns the raw interrupt state of the UARTCTSINTR interrupt.
                CTSRMIS: u1,
                ///  nUARTDCD modem interrupt status. Returns the raw interrupt state of the UARTDCDINTR interrupt.
                DCDRMIS: u1,
                ///  nUARTDSR modem interrupt status. Returns the raw interrupt state of the UARTDSRINTR interrupt.
                DSRRMIS: u1,
                ///  Receive interrupt status. Returns the raw interrupt state of the UARTRXINTR interrupt.
                RXRIS: u1,
                ///  Transmit interrupt status. Returns the raw interrupt state of the UARTTXINTR interrupt.
                TXRIS: u1,
                ///  Receive timeout interrupt status. Returns the raw interrupt state of the UARTRTINTR interrupt. a
                RTRIS: u1,
                ///  Framing error interrupt status. Returns the raw interrupt state of the UARTFEINTR interrupt.
                FERIS: u1,
                ///  Parity error interrupt status. Returns the raw interrupt state of the UARTPEINTR interrupt.
                PERIS: u1,
                ///  Break error interrupt status. Returns the raw interrupt state of the UARTBEINTR interrupt.
                BERIS: u1,
                ///  Overrun error interrupt status. Returns the raw interrupt state of the UARTOEINTR interrupt.
                OERIS: u1,
                padding: u21,
            }),
            ///  Masked Interrupt Status Register, UARTMIS
            UARTMIS: mmio.Mmio(packed struct(u32) {
                ///  nUARTRI modem masked interrupt status. Returns the masked interrupt state of the UARTRIINTR interrupt.
                RIMMIS: u1,
                ///  nUARTCTS modem masked interrupt status. Returns the masked interrupt state of the UARTCTSINTR interrupt.
                CTSMMIS: u1,
                ///  nUARTDCD modem masked interrupt status. Returns the masked interrupt state of the UARTDCDINTR interrupt.
                DCDMMIS: u1,
                ///  nUARTDSR modem masked interrupt status. Returns the masked interrupt state of the UARTDSRINTR interrupt.
                DSRMMIS: u1,
                ///  Receive masked interrupt status. Returns the masked interrupt state of the UARTRXINTR interrupt.
                RXMIS: u1,
                ///  Transmit masked interrupt status. Returns the masked interrupt state of the UARTTXINTR interrupt.
                TXMIS: u1,
                ///  Receive timeout masked interrupt status. Returns the masked interrupt state of the UARTRTINTR interrupt.
                RTMIS: u1,
                ///  Framing error masked interrupt status. Returns the masked interrupt state of the UARTFEINTR interrupt.
                FEMIS: u1,
                ///  Parity error masked interrupt status. Returns the masked interrupt state of the UARTPEINTR interrupt.
                PEMIS: u1,
                ///  Break error masked interrupt status. Returns the masked interrupt state of the UARTBEINTR interrupt.
                BEMIS: u1,
                ///  Overrun error masked interrupt status. Returns the masked interrupt state of the UARTOEINTR interrupt.
                OEMIS: u1,
                padding: u21,
            }),
            ///  Interrupt Clear Register, UARTICR
            UARTICR: mmio.Mmio(packed struct(u32) {
                ///  nUARTRI modem interrupt clear. Clears the UARTRIINTR interrupt.
                RIMIC: u1,
                ///  nUARTCTS modem interrupt clear. Clears the UARTCTSINTR interrupt.
                CTSMIC: u1,
                ///  nUARTDCD modem interrupt clear. Clears the UARTDCDINTR interrupt.
                DCDMIC: u1,
                ///  nUARTDSR modem interrupt clear. Clears the UARTDSRINTR interrupt.
                DSRMIC: u1,
                ///  Receive interrupt clear. Clears the UARTRXINTR interrupt.
                RXIC: u1,
                ///  Transmit interrupt clear. Clears the UARTTXINTR interrupt.
                TXIC: u1,
                ///  Receive timeout interrupt clear. Clears the UARTRTINTR interrupt.
                RTIC: u1,
                ///  Framing error interrupt clear. Clears the UARTFEINTR interrupt.
                FEIC: u1,
                ///  Parity error interrupt clear. Clears the UARTPEINTR interrupt.
                PEIC: u1,
                ///  Break error interrupt clear. Clears the UARTBEINTR interrupt.
                BEIC: u1,
                ///  Overrun error interrupt clear. Clears the UARTOEINTR interrupt.
                OEIC: u1,
                padding: u21,
            }),
            ///  DMA Control Register, UARTDMACR
            UARTDMACR: mmio.Mmio(packed struct(u32) {
                ///  Receive DMA enable. If this bit is set to 1, DMA for the receive FIFO is enabled.
                RXDMAE: u1,
                ///  Transmit DMA enable. If this bit is set to 1, DMA for the transmit FIFO is enabled.
                TXDMAE: u1,
                ///  DMA on error. If this bit is set to 1, the DMA receive request outputs, UARTRXDMASREQ or UARTRXDMABREQ, are disabled when the UART error interrupt is asserted.
                DMAONERR: u1,
                padding: u29,
            }),
            reserved4064: [3988]u8,
            ///  UARTPeriphID0 Register
            UARTPERIPHID0: mmio.Mmio(packed struct(u32) {
                ///  These bits read back as 0x11
                PARTNUMBER0: u8,
                padding: u24,
            }),
            ///  UARTPeriphID1 Register
            UARTPERIPHID1: mmio.Mmio(packed struct(u32) {
                ///  These bits read back as 0x0
                PARTNUMBER1: u4,
                ///  These bits read back as 0x1
                DESIGNER0: u4,
                padding: u24,
            }),
            ///  UARTPeriphID2 Register
            UARTPERIPHID2: mmio.Mmio(packed struct(u32) {
                ///  These bits read back as 0x4
                DESIGNER1: u4,
                ///  This field depends on the revision of the UART: r1p0 0x0 r1p1 0x1 r1p3 0x2 r1p4 0x2 r1p5 0x3
                REVISION: u4,
                padding: u24,
            }),
            ///  UARTPeriphID3 Register
            UARTPERIPHID3: mmio.Mmio(packed struct(u32) {
                ///  These bits read back as 0x00
                CONFIGURATION: u8,
                padding: u24,
            }),
            ///  UARTPCellID0 Register
            UARTPCELLID0: mmio.Mmio(packed struct(u32) {
                ///  These bits read back as 0x0D
                UARTPCELLID0: u8,
                padding: u24,
            }),
            ///  UARTPCellID1 Register
            UARTPCELLID1: mmio.Mmio(packed struct(u32) {
                ///  These bits read back as 0xF0
                UARTPCELLID1: u8,
                padding: u24,
            }),
            ///  UARTPCellID2 Register
            UARTPCELLID2: mmio.Mmio(packed struct(u32) {
                ///  These bits read back as 0x05
                UARTPCELLID2: u8,
                padding: u24,
            }),
            ///  UARTPCellID3 Register
            UARTPCELLID3: mmio.Mmio(packed struct(u32) {
                ///  These bits read back as 0xB1
                UARTPCELLID3: u8,
                padding: u24,
            }),
        };

        ///  Single-cycle IO block
        ///  Provides core-local and inter-core hardware for the two processors, with single-cycle access.
        pub const SIO = extern struct {
            ///  Processor core identifier
            ///  Value is 0 when read from processor core 0, and 1 when read from processor core 1.
            CPUID: u32,
            ///  Input value for GPIO pins
            GPIO_IN: mmio.Mmio(packed struct(u32) {
                ///  Input value for GPIO0...29
                GPIO_IN: u30,
                padding: u2,
            }),
            ///  Input value for QSPI pins
            GPIO_HI_IN: mmio.Mmio(packed struct(u32) {
                ///  Input value on QSPI IO in order 0..5: SCLK, SSn, SD0, SD1, SD2, SD3
                GPIO_HI_IN: u6,
                padding: u26,
            }),
            reserved16: [4]u8,
            ///  GPIO output value
            GPIO_OUT: mmio.Mmio(packed struct(u32) {
                ///  Set output level (1/0 -> high/low) for GPIO0...29.
                ///  Reading back gives the last value written, NOT the input value from the pins.
                ///  If core 0 and core 1 both write to GPIO_OUT simultaneously (or to a SET/CLR/XOR alias),
                ///  the result is as though the write from core 0 took place first,
                ///  and the write from core 1 was then applied to that intermediate result.
                GPIO_OUT: u30,
                padding: u2,
            }),
            ///  GPIO output value set
            GPIO_OUT_SET: mmio.Mmio(packed struct(u32) {
                ///  Perform an atomic bit-set on GPIO_OUT, i.e. `GPIO_OUT |= wdata`
                GPIO_OUT_SET: u30,
                padding: u2,
            }),
            ///  GPIO output value clear
            GPIO_OUT_CLR: mmio.Mmio(packed struct(u32) {
                ///  Perform an atomic bit-clear on GPIO_OUT, i.e. `GPIO_OUT &= ~wdata`
                GPIO_OUT_CLR: u30,
                padding: u2,
            }),
            ///  GPIO output value XOR
            GPIO_OUT_XOR: mmio.Mmio(packed struct(u32) {
                ///  Perform an atomic bitwise XOR on GPIO_OUT, i.e. `GPIO_OUT ^= wdata`
                GPIO_OUT_XOR: u30,
                padding: u2,
            }),
            ///  GPIO output enable
            GPIO_OE: mmio.Mmio(packed struct(u32) {
                ///  Set output enable (1/0 -> output/input) for GPIO0...29.
                ///  Reading back gives the last value written.
                ///  If core 0 and core 1 both write to GPIO_OE simultaneously (or to a SET/CLR/XOR alias),
                ///  the result is as though the write from core 0 took place first,
                ///  and the write from core 1 was then applied to that intermediate result.
                GPIO_OE: u30,
                padding: u2,
            }),
            ///  GPIO output enable set
            GPIO_OE_SET: mmio.Mmio(packed struct(u32) {
                ///  Perform an atomic bit-set on GPIO_OE, i.e. `GPIO_OE |= wdata`
                GPIO_OE_SET: u30,
                padding: u2,
            }),
            ///  GPIO output enable clear
            GPIO_OE_CLR: mmio.Mmio(packed struct(u32) {
                ///  Perform an atomic bit-clear on GPIO_OE, i.e. `GPIO_OE &= ~wdata`
                GPIO_OE_CLR: u30,
                padding: u2,
            }),
            ///  GPIO output enable XOR
            GPIO_OE_XOR: mmio.Mmio(packed struct(u32) {
                ///  Perform an atomic bitwise XOR on GPIO_OE, i.e. `GPIO_OE ^= wdata`
                GPIO_OE_XOR: u30,
                padding: u2,
            }),
            ///  QSPI output value
            GPIO_HI_OUT: mmio.Mmio(packed struct(u32) {
                ///  Set output level (1/0 -> high/low) for QSPI IO0...5.
                ///  Reading back gives the last value written, NOT the input value from the pins.
                ///  If core 0 and core 1 both write to GPIO_HI_OUT simultaneously (or to a SET/CLR/XOR alias),
                ///  the result is as though the write from core 0 took place first,
                ///  and the write from core 1 was then applied to that intermediate result.
                GPIO_HI_OUT: u6,
                padding: u26,
            }),
            ///  QSPI output value set
            GPIO_HI_OUT_SET: mmio.Mmio(packed struct(u32) {
                ///  Perform an atomic bit-set on GPIO_HI_OUT, i.e. `GPIO_HI_OUT |= wdata`
                GPIO_HI_OUT_SET: u6,
                padding: u26,
            }),
            ///  QSPI output value clear
            GPIO_HI_OUT_CLR: mmio.Mmio(packed struct(u32) {
                ///  Perform an atomic bit-clear on GPIO_HI_OUT, i.e. `GPIO_HI_OUT &= ~wdata`
                GPIO_HI_OUT_CLR: u6,
                padding: u26,
            }),
            ///  QSPI output value XOR
            GPIO_HI_OUT_XOR: mmio.Mmio(packed struct(u32) {
                ///  Perform an atomic bitwise XOR on GPIO_HI_OUT, i.e. `GPIO_HI_OUT ^= wdata`
                GPIO_HI_OUT_XOR: u6,
                padding: u26,
            }),
            ///  QSPI output enable
            GPIO_HI_OE: mmio.Mmio(packed struct(u32) {
                ///  Set output enable (1/0 -> output/input) for QSPI IO0...5.
                ///  Reading back gives the last value written.
                ///  If core 0 and core 1 both write to GPIO_HI_OE simultaneously (or to a SET/CLR/XOR alias),
                ///  the result is as though the write from core 0 took place first,
                ///  and the write from core 1 was then applied to that intermediate result.
                GPIO_HI_OE: u6,
                padding: u26,
            }),
            ///  QSPI output enable set
            GPIO_HI_OE_SET: mmio.Mmio(packed struct(u32) {
                ///  Perform an atomic bit-set on GPIO_HI_OE, i.e. `GPIO_HI_OE |= wdata`
                GPIO_HI_OE_SET: u6,
                padding: u26,
            }),
            ///  QSPI output enable clear
            GPIO_HI_OE_CLR: mmio.Mmio(packed struct(u32) {
                ///  Perform an atomic bit-clear on GPIO_HI_OE, i.e. `GPIO_HI_OE &= ~wdata`
                GPIO_HI_OE_CLR: u6,
                padding: u26,
            }),
            ///  QSPI output enable XOR
            GPIO_HI_OE_XOR: mmio.Mmio(packed struct(u32) {
                ///  Perform an atomic bitwise XOR on GPIO_HI_OE, i.e. `GPIO_HI_OE ^= wdata`
                GPIO_HI_OE_XOR: u6,
                padding: u26,
            }),
            ///  Status register for inter-core FIFOs (mailboxes).
            ///  There is one FIFO in the core 0 -> core 1 direction, and one core 1 -> core 0. Both are 32 bits wide and 8 words deep.
            ///  Core 0 can see the read side of the 1->0 FIFO (RX), and the write side of 0->1 FIFO (TX).
            ///  Core 1 can see the read side of the 0->1 FIFO (RX), and the write side of 1->0 FIFO (TX).
            ///  The SIO IRQ for each core is the logical OR of the VLD, WOF and ROE fields of its FIFO_ST register.
            FIFO_ST: mmio.Mmio(packed struct(u32) {
                ///  Value is 1 if this core's RX FIFO is not empty (i.e. if FIFO_RD is valid)
                VLD: u1,
                ///  Value is 1 if this core's TX FIFO is not full (i.e. if FIFO_WR is ready for more data)
                RDY: u1,
                ///  Sticky flag indicating the TX FIFO was written when full. This write was ignored by the FIFO.
                WOF: u1,
                ///  Sticky flag indicating the RX FIFO was read when empty. This read was ignored by the FIFO.
                ROE: u1,
                padding: u28,
            }),
            ///  Write access to this core's TX FIFO
            FIFO_WR: u32,
            ///  Read access to this core's RX FIFO
            FIFO_RD: u32,
            ///  Spinlock state
            ///  A bitmap containing the state of all 32 spinlocks (1=locked).
            ///  Mainly intended for debugging.
            SPINLOCK_ST: u32,
            ///  Divider unsigned dividend
            ///  Write to the DIVIDEND operand of the divider, i.e. the p in `p / q`.
            ///  Any operand write starts a new calculation. The results appear in QUOTIENT, REMAINDER.
            ///  UDIVIDEND/SDIVIDEND are aliases of the same internal register. The U alias starts an
            ///  unsigned calculation, and the S alias starts a signed calculation.
            DIV_UDIVIDEND: u32,
            ///  Divider unsigned divisor
            ///  Write to the DIVISOR operand of the divider, i.e. the q in `p / q`.
            ///  Any operand write starts a new calculation. The results appear in QUOTIENT, REMAINDER.
            ///  UDIVISOR/SDIVISOR are aliases of the same internal register. The U alias starts an
            ///  unsigned calculation, and the S alias starts a signed calculation.
            DIV_UDIVISOR: u32,
            ///  Divider signed dividend
            ///  The same as UDIVIDEND, but starts a signed calculation, rather than unsigned.
            DIV_SDIVIDEND: u32,
            ///  Divider signed divisor
            ///  The same as UDIVISOR, but starts a signed calculation, rather than unsigned.
            DIV_SDIVISOR: u32,
            ///  Divider result quotient
            ///  The result of `DIVIDEND / DIVISOR` (division). Contents undefined while CSR_READY is low.
            ///  For signed calculations, QUOTIENT is negative when the signs of DIVIDEND and DIVISOR differ.
            ///  This register can be written to directly, for context save/restore purposes. This halts any
            ///  in-progress calculation and sets the CSR_READY and CSR_DIRTY flags.
            ///  Reading from QUOTIENT clears the CSR_DIRTY flag, so should read results in the order
            ///  REMAINDER, QUOTIENT if CSR_DIRTY is used.
            DIV_QUOTIENT: u32,
            ///  Divider result remainder
            ///  The result of `DIVIDEND % DIVISOR` (modulo). Contents undefined while CSR_READY is low.
            ///  For signed calculations, REMAINDER is negative only when DIVIDEND is negative.
            ///  This register can be written to directly, for context save/restore purposes. This halts any
            ///  in-progress calculation and sets the CSR_READY and CSR_DIRTY flags.
            DIV_REMAINDER: u32,
            ///  Control and status register for divider.
            DIV_CSR: mmio.Mmio(packed struct(u32) {
                ///  Reads as 0 when a calculation is in progress, 1 otherwise.
                ///  Writing an operand (xDIVIDEND, xDIVISOR) will immediately start a new calculation, no
                ///  matter if one is already in progress.
                ///  Writing to a result register will immediately terminate any in-progress calculation
                ///  and set the READY and DIRTY flags.
                READY: u1,
                ///  Changes to 1 when any register is written, and back to 0 when QUOTIENT is read.
                ///  Software can use this flag to make save/restore more efficient (skip if not DIRTY).
                ///  If the flag is used in this way, it's recommended to either read QUOTIENT only,
                ///  or REMAINDER and then QUOTIENT, to prevent data loss on context switch.
                DIRTY: u1,
                padding: u30,
            }),
            reserved128: [4]u8,
            ///  Read/write access to accumulator 0
            INTERP0_ACCUM0: u32,
            ///  Read/write access to accumulator 1
            INTERP0_ACCUM1: u32,
            ///  Read/write access to BASE0 register.
            INTERP0_BASE0: u32,
            ///  Read/write access to BASE1 register.
            INTERP0_BASE1: u32,
            ///  Read/write access to BASE2 register.
            INTERP0_BASE2: u32,
            ///  Read LANE0 result, and simultaneously write lane results to both accumulators (POP).
            INTERP0_POP_LANE0: u32,
            ///  Read LANE1 result, and simultaneously write lane results to both accumulators (POP).
            INTERP0_POP_LANE1: u32,
            ///  Read FULL result, and simultaneously write lane results to both accumulators (POP).
            INTERP0_POP_FULL: u32,
            ///  Read LANE0 result, without altering any internal state (PEEK).
            INTERP0_PEEK_LANE0: u32,
            ///  Read LANE1 result, without altering any internal state (PEEK).
            INTERP0_PEEK_LANE1: u32,
            ///  Read FULL result, without altering any internal state (PEEK).
            INTERP0_PEEK_FULL: u32,
            ///  Control register for lane 0
            INTERP0_CTRL_LANE0: mmio.Mmio(packed struct(u32) {
                ///  Logical right-shift applied to accumulator before masking
                SHIFT: u5,
                ///  The least-significant bit allowed to pass by the mask (inclusive)
                MASK_LSB: u5,
                ///  The most-significant bit allowed to pass by the mask (inclusive)
                ///  Setting MSB < LSB may cause chip to turn inside-out
                MASK_MSB: u5,
                ///  If SIGNED is set, the shifted and masked accumulator value is sign-extended to 32 bits
                ///  before adding to BASE0, and LANE0 PEEK/POP appear extended to 32 bits when read by processor.
                SIGNED: u1,
                ///  If 1, feed the opposite lane's accumulator into this lane's shift + mask hardware.
                ///  Takes effect even if ADD_RAW is set (the CROSS_INPUT mux is before the shift+mask bypass)
                CROSS_INPUT: u1,
                ///  If 1, feed the opposite lane's result into this lane's accumulator on POP.
                CROSS_RESULT: u1,
                ///  If 1, mask + shift is bypassed for LANE0 result. This does not affect FULL result.
                ADD_RAW: u1,
                ///  ORed into bits 29:28 of the lane result presented to the processor on the bus.
                ///  No effect on the internal 32-bit datapath. Handy for using a lane to generate sequence
                ///  of pointers into flash or SRAM.
                FORCE_MSB: u2,
                ///  Only present on INTERP0 on each core. If BLEND mode is enabled:
                ///  - LANE1 result is a linear interpolation between BASE0 and BASE1, controlled
                ///  by the 8 LSBs of lane 1 shift and mask value (a fractional number between
                ///  0 and 255/256ths)
                ///  - LANE0 result does not have BASE0 added (yields only the 8 LSBs of lane 1 shift+mask value)
                ///  - FULL result does not have lane 1 shift+mask value added (BASE2 + lane 0 shift+mask)
                ///  LANE1 SIGNED flag controls whether the interpolation is signed or unsigned.
                BLEND: u1,
                reserved23: u1,
                ///  Indicates if any masked-off MSBs in ACCUM0 are set.
                OVERF0: u1,
                ///  Indicates if any masked-off MSBs in ACCUM1 are set.
                OVERF1: u1,
                ///  Set if either OVERF0 or OVERF1 is set.
                OVERF: u1,
                padding: u6,
            }),
            ///  Control register for lane 1
            INTERP0_CTRL_LANE1: mmio.Mmio(packed struct(u32) {
                ///  Logical right-shift applied to accumulator before masking
                SHIFT: u5,
                ///  The least-significant bit allowed to pass by the mask (inclusive)
                MASK_LSB: u5,
                ///  The most-significant bit allowed to pass by the mask (inclusive)
                ///  Setting MSB < LSB may cause chip to turn inside-out
                MASK_MSB: u5,
                ///  If SIGNED is set, the shifted and masked accumulator value is sign-extended to 32 bits
                ///  before adding to BASE1, and LANE1 PEEK/POP appear extended to 32 bits when read by processor.
                SIGNED: u1,
                ///  If 1, feed the opposite lane's accumulator into this lane's shift + mask hardware.
                ///  Takes effect even if ADD_RAW is set (the CROSS_INPUT mux is before the shift+mask bypass)
                CROSS_INPUT: u1,
                ///  If 1, feed the opposite lane's result into this lane's accumulator on POP.
                CROSS_RESULT: u1,
                ///  If 1, mask + shift is bypassed for LANE1 result. This does not affect FULL result.
                ADD_RAW: u1,
                ///  ORed into bits 29:28 of the lane result presented to the processor on the bus.
                ///  No effect on the internal 32-bit datapath. Handy for using a lane to generate sequence
                ///  of pointers into flash or SRAM.
                FORCE_MSB: u2,
                padding: u11,
            }),
            ///  Values written here are atomically added to ACCUM0
            ///  Reading yields lane 0's raw shift and mask value (BASE0 not added).
            INTERP0_ACCUM0_ADD: mmio.Mmio(packed struct(u32) {
                INTERP0_ACCUM0_ADD: u24,
                padding: u8,
            }),
            ///  Values written here are atomically added to ACCUM1
            ///  Reading yields lane 1's raw shift and mask value (BASE1 not added).
            INTERP0_ACCUM1_ADD: mmio.Mmio(packed struct(u32) {
                INTERP0_ACCUM1_ADD: u24,
                padding: u8,
            }),
            ///  On write, the lower 16 bits go to BASE0, upper bits to BASE1 simultaneously.
            ///  Each half is sign-extended to 32 bits if that lane's SIGNED flag is set.
            INTERP0_BASE_1AND0: u32,
            ///  Read/write access to accumulator 0
            INTERP1_ACCUM0: u32,
            ///  Read/write access to accumulator 1
            INTERP1_ACCUM1: u32,
            ///  Read/write access to BASE0 register.
            INTERP1_BASE0: u32,
            ///  Read/write access to BASE1 register.
            INTERP1_BASE1: u32,
            ///  Read/write access to BASE2 register.
            INTERP1_BASE2: u32,
            ///  Read LANE0 result, and simultaneously write lane results to both accumulators (POP).
            INTERP1_POP_LANE0: u32,
            ///  Read LANE1 result, and simultaneously write lane results to both accumulators (POP).
            INTERP1_POP_LANE1: u32,
            ///  Read FULL result, and simultaneously write lane results to both accumulators (POP).
            INTERP1_POP_FULL: u32,
            ///  Read LANE0 result, without altering any internal state (PEEK).
            INTERP1_PEEK_LANE0: u32,
            ///  Read LANE1 result, without altering any internal state (PEEK).
            INTERP1_PEEK_LANE1: u32,
            ///  Read FULL result, without altering any internal state (PEEK).
            INTERP1_PEEK_FULL: u32,
            ///  Control register for lane 0
            INTERP1_CTRL_LANE0: mmio.Mmio(packed struct(u32) {
                ///  Logical right-shift applied to accumulator before masking
                SHIFT: u5,
                ///  The least-significant bit allowed to pass by the mask (inclusive)
                MASK_LSB: u5,
                ///  The most-significant bit allowed to pass by the mask (inclusive)
                ///  Setting MSB < LSB may cause chip to turn inside-out
                MASK_MSB: u5,
                ///  If SIGNED is set, the shifted and masked accumulator value is sign-extended to 32 bits
                ///  before adding to BASE0, and LANE0 PEEK/POP appear extended to 32 bits when read by processor.
                SIGNED: u1,
                ///  If 1, feed the opposite lane's accumulator into this lane's shift + mask hardware.
                ///  Takes effect even if ADD_RAW is set (the CROSS_INPUT mux is before the shift+mask bypass)
                CROSS_INPUT: u1,
                ///  If 1, feed the opposite lane's result into this lane's accumulator on POP.
                CROSS_RESULT: u1,
                ///  If 1, mask + shift is bypassed for LANE0 result. This does not affect FULL result.
                ADD_RAW: u1,
                ///  ORed into bits 29:28 of the lane result presented to the processor on the bus.
                ///  No effect on the internal 32-bit datapath. Handy for using a lane to generate sequence
                ///  of pointers into flash or SRAM.
                FORCE_MSB: u2,
                reserved22: u1,
                ///  Only present on INTERP1 on each core. If CLAMP mode is enabled:
                ///  - LANE0 result is shifted and masked ACCUM0, clamped by a lower bound of
                ///  BASE0 and an upper bound of BASE1.
                ///  - Signedness of these comparisons is determined by LANE0_CTRL_SIGNED
                CLAMP: u1,
                ///  Indicates if any masked-off MSBs in ACCUM0 are set.
                OVERF0: u1,
                ///  Indicates if any masked-off MSBs in ACCUM1 are set.
                OVERF1: u1,
                ///  Set if either OVERF0 or OVERF1 is set.
                OVERF: u1,
                padding: u6,
            }),
            ///  Control register for lane 1
            INTERP1_CTRL_LANE1: mmio.Mmio(packed struct(u32) {
                ///  Logical right-shift applied to accumulator before masking
                SHIFT: u5,
                ///  The least-significant bit allowed to pass by the mask (inclusive)
                MASK_LSB: u5,
                ///  The most-significant bit allowed to pass by the mask (inclusive)
                ///  Setting MSB < LSB may cause chip to turn inside-out
                MASK_MSB: u5,
                ///  If SIGNED is set, the shifted and masked accumulator value is sign-extended to 32 bits
                ///  before adding to BASE1, and LANE1 PEEK/POP appear extended to 32 bits when read by processor.
                SIGNED: u1,
                ///  If 1, feed the opposite lane's accumulator into this lane's shift + mask hardware.
                ///  Takes effect even if ADD_RAW is set (the CROSS_INPUT mux is before the shift+mask bypass)
                CROSS_INPUT: u1,
                ///  If 1, feed the opposite lane's result into this lane's accumulator on POP.
                CROSS_RESULT: u1,
                ///  If 1, mask + shift is bypassed for LANE1 result. This does not affect FULL result.
                ADD_RAW: u1,
                ///  ORed into bits 29:28 of the lane result presented to the processor on the bus.
                ///  No effect on the internal 32-bit datapath. Handy for using a lane to generate sequence
                ///  of pointers into flash or SRAM.
                FORCE_MSB: u2,
                padding: u11,
            }),
            ///  Values written here are atomically added to ACCUM0
            ///  Reading yields lane 0's raw shift and mask value (BASE0 not added).
            INTERP1_ACCUM0_ADD: mmio.Mmio(packed struct(u32) {
                INTERP1_ACCUM0_ADD: u24,
                padding: u8,
            }),
            ///  Values written here are atomically added to ACCUM1
            ///  Reading yields lane 1's raw shift and mask value (BASE1 not added).
            INTERP1_ACCUM1_ADD: mmio.Mmio(packed struct(u32) {
                INTERP1_ACCUM1_ADD: u24,
                padding: u8,
            }),
            ///  On write, the lower 16 bits go to BASE0, upper bits to BASE1 simultaneously.
            ///  Each half is sign-extended to 32 bits if that lane's SIGNED flag is set.
            INTERP1_BASE_1AND0: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK0: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK1: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK2: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK3: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK4: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK5: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK6: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK7: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK8: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK9: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK10: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK11: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK12: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK13: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK14: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK15: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK16: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK17: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK18: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK19: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK20: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK21: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK22: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK23: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK24: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK25: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK26: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK27: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK28: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK29: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK30: u32,
            ///  Reading from a spinlock address will:
            ///  - Return 0 if lock is already locked
            ///  - Otherwise return nonzero, and simultaneously claim the lock
            ///  Writing (any value) releases the lock.
            ///  If core 0 and core 1 attempt to claim the same lock simultaneously, core 0 wins.
            ///  The value returned on success is 0x1 << lock number.
            SPINLOCK31: u32,
        };

        pub const SPI0 = extern struct {
            ///  Control register 0, SSPCR0 on page 3-4
            SSPCR0: mmio.Mmio(packed struct(u32) {
                ///  Data Size Select: 0000 Reserved, undefined operation. 0001 Reserved, undefined operation. 0010 Reserved, undefined operation. 0011 4-bit data. 0100 5-bit data. 0101 6-bit data. 0110 7-bit data. 0111 8-bit data. 1000 9-bit data. 1001 10-bit data. 1010 11-bit data. 1011 12-bit data. 1100 13-bit data. 1101 14-bit data. 1110 15-bit data. 1111 16-bit data.
                DSS: u4,
                ///  Frame format: 00 Motorola SPI frame format. 01 TI synchronous serial frame format. 10 National Microwire frame format. 11 Reserved, undefined operation.
                FRF: u2,
                ///  SSPCLKOUT polarity, applicable to Motorola SPI frame format only. See Motorola SPI frame format on page 2-10.
                SPO: u1,
                ///  SSPCLKOUT phase, applicable to Motorola SPI frame format only. See Motorola SPI frame format on page 2-10.
                SPH: u1,
                ///  Serial clock rate. The value SCR is used to generate the transmit and receive bit rate of the PrimeCell SSP. The bit rate is: F SSPCLK CPSDVSR x (1+SCR) where CPSDVSR is an even value from 2-254, programmed through the SSPCPSR register and SCR is a value from 0-255.
                SCR: u8,
                padding: u16,
            }),
            ///  Control register 1, SSPCR1 on page 3-5
            SSPCR1: mmio.Mmio(packed struct(u32) {
                ///  Loop back mode: 0 Normal serial port operation enabled. 1 Output of transmit serial shifter is connected to input of receive serial shifter internally.
                LBM: u1,
                ///  Synchronous serial port enable: 0 SSP operation disabled. 1 SSP operation enabled.
                SSE: u1,
                ///  Master or slave mode select. This bit can be modified only when the PrimeCell SSP is disabled, SSE=0: 0 Device configured as master, default. 1 Device configured as slave.
                MS: u1,
                ///  Slave-mode output disable. This bit is relevant only in the slave mode, MS=1. In multiple-slave systems, it is possible for an PrimeCell SSP master to broadcast a message to all slaves in the system while ensuring that only one slave drives data onto its serial output line. In such systems the RXD lines from multiple slaves could be tied together. To operate in such systems, the SOD bit can be set if the PrimeCell SSP slave is not supposed to drive the SSPTXD line: 0 SSP can drive the SSPTXD output in slave mode. 1 SSP must not drive the SSPTXD output in slave mode.
                SOD: u1,
                padding: u28,
            }),
            ///  Data register, SSPDR on page 3-6
            SSPDR: mmio.Mmio(packed struct(u32) {
                ///  Transmit/Receive FIFO: Read Receive FIFO. Write Transmit FIFO. You must right-justify data when the PrimeCell SSP is programmed for a data size that is less than 16 bits. Unused bits at the top are ignored by transmit logic. The receive logic automatically right-justifies.
                DATA: u16,
                padding: u16,
            }),
            ///  Status register, SSPSR on page 3-7
            SSPSR: mmio.Mmio(packed struct(u32) {
                ///  Transmit FIFO empty, RO: 0 Transmit FIFO is not empty. 1 Transmit FIFO is empty.
                TFE: u1,
                ///  Transmit FIFO not full, RO: 0 Transmit FIFO is full. 1 Transmit FIFO is not full.
                TNF: u1,
                ///  Receive FIFO not empty, RO: 0 Receive FIFO is empty. 1 Receive FIFO is not empty.
                RNE: u1,
                ///  Receive FIFO full, RO: 0 Receive FIFO is not full. 1 Receive FIFO is full.
                RFF: u1,
                ///  PrimeCell SSP busy flag, RO: 0 SSP is idle. 1 SSP is currently transmitting and/or receiving a frame or the transmit FIFO is not empty.
                BSY: u1,
                padding: u27,
            }),
            ///  Clock prescale register, SSPCPSR on page 3-8
            SSPCPSR: mmio.Mmio(packed struct(u32) {
                ///  Clock prescale divisor. Must be an even number from 2-254, depending on the frequency of SSPCLK. The least significant bit always returns zero on reads.
                CPSDVSR: u8,
                padding: u24,
            }),
            ///  Interrupt mask set or clear register, SSPIMSC on page 3-9
            SSPIMSC: mmio.Mmio(packed struct(u32) {
                ///  Receive overrun interrupt mask: 0 Receive FIFO written to while full condition interrupt is masked. 1 Receive FIFO written to while full condition interrupt is not masked.
                RORIM: u1,
                ///  Receive timeout interrupt mask: 0 Receive FIFO not empty and no read prior to timeout period interrupt is masked. 1 Receive FIFO not empty and no read prior to timeout period interrupt is not masked.
                RTIM: u1,
                ///  Receive FIFO interrupt mask: 0 Receive FIFO half full or less condition interrupt is masked. 1 Receive FIFO half full or less condition interrupt is not masked.
                RXIM: u1,
                ///  Transmit FIFO interrupt mask: 0 Transmit FIFO half empty or less condition interrupt is masked. 1 Transmit FIFO half empty or less condition interrupt is not masked.
                TXIM: u1,
                padding: u28,
            }),
            ///  Raw interrupt status register, SSPRIS on page 3-10
            SSPRIS: mmio.Mmio(packed struct(u32) {
                ///  Gives the raw interrupt state, prior to masking, of the SSPRORINTR interrupt
                RORRIS: u1,
                ///  Gives the raw interrupt state, prior to masking, of the SSPRTINTR interrupt
                RTRIS: u1,
                ///  Gives the raw interrupt state, prior to masking, of the SSPRXINTR interrupt
                RXRIS: u1,
                ///  Gives the raw interrupt state, prior to masking, of the SSPTXINTR interrupt
                TXRIS: u1,
                padding: u28,
            }),
            ///  Masked interrupt status register, SSPMIS on page 3-11
            SSPMIS: mmio.Mmio(packed struct(u32) {
                ///  Gives the receive over run masked interrupt status, after masking, of the SSPRORINTR interrupt
                RORMIS: u1,
                ///  Gives the receive timeout masked interrupt state, after masking, of the SSPRTINTR interrupt
                RTMIS: u1,
                ///  Gives the receive FIFO masked interrupt state, after masking, of the SSPRXINTR interrupt
                RXMIS: u1,
                ///  Gives the transmit FIFO masked interrupt state, after masking, of the SSPTXINTR interrupt
                TXMIS: u1,
                padding: u28,
            }),
            ///  Interrupt clear register, SSPICR on page 3-11
            SSPICR: mmio.Mmio(packed struct(u32) {
                ///  Clears the SSPRORINTR interrupt
                RORIC: u1,
                ///  Clears the SSPRTINTR interrupt
                RTIC: u1,
                padding: u30,
            }),
            ///  DMA control register, SSPDMACR on page 3-12
            SSPDMACR: mmio.Mmio(packed struct(u32) {
                ///  Receive DMA Enable. If this bit is set to 1, DMA for the receive FIFO is enabled.
                RXDMAE: u1,
                ///  Transmit DMA Enable. If this bit is set to 1, DMA for the transmit FIFO is enabled.
                TXDMAE: u1,
                padding: u30,
            }),
            reserved4064: [4024]u8,
            ///  Peripheral identification registers, SSPPeriphID0-3 on page 3-13
            SSPPERIPHID0: mmio.Mmio(packed struct(u32) {
                ///  These bits read back as 0x22
                PARTNUMBER0: u8,
                padding: u24,
            }),
            ///  Peripheral identification registers, SSPPeriphID0-3 on page 3-13
            SSPPERIPHID1: mmio.Mmio(packed struct(u32) {
                ///  These bits read back as 0x0
                PARTNUMBER1: u4,
                ///  These bits read back as 0x1
                DESIGNER0: u4,
                padding: u24,
            }),
            ///  Peripheral identification registers, SSPPeriphID0-3 on page 3-13
            SSPPERIPHID2: mmio.Mmio(packed struct(u32) {
                ///  These bits read back as 0x4
                DESIGNER1: u4,
                ///  These bits return the peripheral revision
                REVISION: u4,
                padding: u24,
            }),
            ///  Peripheral identification registers, SSPPeriphID0-3 on page 3-13
            SSPPERIPHID3: mmio.Mmio(packed struct(u32) {
                ///  These bits read back as 0x00
                CONFIGURATION: u8,
                padding: u24,
            }),
            ///  PrimeCell identification registers, SSPPCellID0-3 on page 3-16
            SSPPCELLID0: mmio.Mmio(packed struct(u32) {
                ///  These bits read back as 0x0D
                SSPPCELLID0: u8,
                padding: u24,
            }),
            ///  PrimeCell identification registers, SSPPCellID0-3 on page 3-16
            SSPPCELLID1: mmio.Mmio(packed struct(u32) {
                ///  These bits read back as 0xF0
                SSPPCELLID1: u8,
                padding: u24,
            }),
            ///  PrimeCell identification registers, SSPPCellID0-3 on page 3-16
            SSPPCELLID2: mmio.Mmio(packed struct(u32) {
                ///  These bits read back as 0x05
                SSPPCELLID2: u8,
                padding: u24,
            }),
            ///  PrimeCell identification registers, SSPPCellID0-3 on page 3-16
            SSPPCELLID3: mmio.Mmio(packed struct(u32) {
                ///  These bits read back as 0xB1
                SSPPCELLID3: u8,
                padding: u24,
            }),
        };

        ///  USB FS/LS controller device registers
        pub const USBCTRL_REGS = extern struct {
            ///  Device address and endpoint control
            ADDR_ENDP: mmio.Mmio(packed struct(u32) {
                ///  In device mode, the address that the device should respond to. Set in response to a SET_ADDR setup packet from the host. In host mode set to the address of the device to communicate with.
                ADDRESS: u7,
                reserved16: u9,
                ///  Device endpoint to send data to. Only valid for HOST mode.
                ENDPOINT: u4,
                padding: u12,
            }),
            ///  Interrupt endpoint 1. Only valid for HOST mode.
            ADDR_ENDP1: mmio.Mmio(packed struct(u32) {
                ///  Device address
                ADDRESS: u7,
                reserved16: u9,
                ///  Endpoint number of the interrupt endpoint
                ENDPOINT: u4,
                reserved25: u5,
                ///  Direction of the interrupt endpoint. In=0, Out=1
                INTEP_DIR: u1,
                ///  Interrupt EP requires preamble (is a low speed device on a full speed hub)
                INTEP_PREAMBLE: u1,
                padding: u5,
            }),
            ///  Interrupt endpoint 2. Only valid for HOST mode.
            ADDR_ENDP2: mmio.Mmio(packed struct(u32) {
                ///  Device address
                ADDRESS: u7,
                reserved16: u9,
                ///  Endpoint number of the interrupt endpoint
                ENDPOINT: u4,
                reserved25: u5,
                ///  Direction of the interrupt endpoint. In=0, Out=1
                INTEP_DIR: u1,
                ///  Interrupt EP requires preamble (is a low speed device on a full speed hub)
                INTEP_PREAMBLE: u1,
                padding: u5,
            }),
            ///  Interrupt endpoint 3. Only valid for HOST mode.
            ADDR_ENDP3: mmio.Mmio(packed struct(u32) {
                ///  Device address
                ADDRESS: u7,
                reserved16: u9,
                ///  Endpoint number of the interrupt endpoint
                ENDPOINT: u4,
                reserved25: u5,
                ///  Direction of the interrupt endpoint. In=0, Out=1
                INTEP_DIR: u1,
                ///  Interrupt EP requires preamble (is a low speed device on a full speed hub)
                INTEP_PREAMBLE: u1,
                padding: u5,
            }),
            ///  Interrupt endpoint 4. Only valid for HOST mode.
            ADDR_ENDP4: mmio.Mmio(packed struct(u32) {
                ///  Device address
                ADDRESS: u7,
                reserved16: u9,
                ///  Endpoint number of the interrupt endpoint
                ENDPOINT: u4,
                reserved25: u5,
                ///  Direction of the interrupt endpoint. In=0, Out=1
                INTEP_DIR: u1,
                ///  Interrupt EP requires preamble (is a low speed device on a full speed hub)
                INTEP_PREAMBLE: u1,
                padding: u5,
            }),
            ///  Interrupt endpoint 5. Only valid for HOST mode.
            ADDR_ENDP5: mmio.Mmio(packed struct(u32) {
                ///  Device address
                ADDRESS: u7,
                reserved16: u9,
                ///  Endpoint number of the interrupt endpoint
                ENDPOINT: u4,
                reserved25: u5,
                ///  Direction of the interrupt endpoint. In=0, Out=1
                INTEP_DIR: u1,
                ///  Interrupt EP requires preamble (is a low speed device on a full speed hub)
                INTEP_PREAMBLE: u1,
                padding: u5,
            }),
            ///  Interrupt endpoint 6. Only valid for HOST mode.
            ADDR_ENDP6: mmio.Mmio(packed struct(u32) {
                ///  Device address
                ADDRESS: u7,
                reserved16: u9,
                ///  Endpoint number of the interrupt endpoint
                ENDPOINT: u4,
                reserved25: u5,
                ///  Direction of the interrupt endpoint. In=0, Out=1
                INTEP_DIR: u1,
                ///  Interrupt EP requires preamble (is a low speed device on a full speed hub)
                INTEP_PREAMBLE: u1,
                padding: u5,
            }),
            ///  Interrupt endpoint 7. Only valid for HOST mode.
            ADDR_ENDP7: mmio.Mmio(packed struct(u32) {
                ///  Device address
                ADDRESS: u7,
                reserved16: u9,
                ///  Endpoint number of the interrupt endpoint
                ENDPOINT: u4,
                reserved25: u5,
                ///  Direction of the interrupt endpoint. In=0, Out=1
                INTEP_DIR: u1,
                ///  Interrupt EP requires preamble (is a low speed device on a full speed hub)
                INTEP_PREAMBLE: u1,
                padding: u5,
            }),
            ///  Interrupt endpoint 8. Only valid for HOST mode.
            ADDR_ENDP8: mmio.Mmio(packed struct(u32) {
                ///  Device address
                ADDRESS: u7,
                reserved16: u9,
                ///  Endpoint number of the interrupt endpoint
                ENDPOINT: u4,
                reserved25: u5,
                ///  Direction of the interrupt endpoint. In=0, Out=1
                INTEP_DIR: u1,
                ///  Interrupt EP requires preamble (is a low speed device on a full speed hub)
                INTEP_PREAMBLE: u1,
                padding: u5,
            }),
            ///  Interrupt endpoint 9. Only valid for HOST mode.
            ADDR_ENDP9: mmio.Mmio(packed struct(u32) {
                ///  Device address
                ADDRESS: u7,
                reserved16: u9,
                ///  Endpoint number of the interrupt endpoint
                ENDPOINT: u4,
                reserved25: u5,
                ///  Direction of the interrupt endpoint. In=0, Out=1
                INTEP_DIR: u1,
                ///  Interrupt EP requires preamble (is a low speed device on a full speed hub)
                INTEP_PREAMBLE: u1,
                padding: u5,
            }),
            ///  Interrupt endpoint 10. Only valid for HOST mode.
            ADDR_ENDP10: mmio.Mmio(packed struct(u32) {
                ///  Device address
                ADDRESS: u7,
                reserved16: u9,
                ///  Endpoint number of the interrupt endpoint
                ENDPOINT: u4,
                reserved25: u5,
                ///  Direction of the interrupt endpoint. In=0, Out=1
                INTEP_DIR: u1,
                ///  Interrupt EP requires preamble (is a low speed device on a full speed hub)
                INTEP_PREAMBLE: u1,
                padding: u5,
            }),
            ///  Interrupt endpoint 11. Only valid for HOST mode.
            ADDR_ENDP11: mmio.Mmio(packed struct(u32) {
                ///  Device address
                ADDRESS: u7,
                reserved16: u9,
                ///  Endpoint number of the interrupt endpoint
                ENDPOINT: u4,
                reserved25: u5,
                ///  Direction of the interrupt endpoint. In=0, Out=1
                INTEP_DIR: u1,
                ///  Interrupt EP requires preamble (is a low speed device on a full speed hub)
                INTEP_PREAMBLE: u1,
                padding: u5,
            }),
            ///  Interrupt endpoint 12. Only valid for HOST mode.
            ADDR_ENDP12: mmio.Mmio(packed struct(u32) {
                ///  Device address
                ADDRESS: u7,
                reserved16: u9,
                ///  Endpoint number of the interrupt endpoint
                ENDPOINT: u4,
                reserved25: u5,
                ///  Direction of the interrupt endpoint. In=0, Out=1
                INTEP_DIR: u1,
                ///  Interrupt EP requires preamble (is a low speed device on a full speed hub)
                INTEP_PREAMBLE: u1,
                padding: u5,
            }),
            ///  Interrupt endpoint 13. Only valid for HOST mode.
            ADDR_ENDP13: mmio.Mmio(packed struct(u32) {
                ///  Device address
                ADDRESS: u7,
                reserved16: u9,
                ///  Endpoint number of the interrupt endpoint
                ENDPOINT: u4,
                reserved25: u5,
                ///  Direction of the interrupt endpoint. In=0, Out=1
                INTEP_DIR: u1,
                ///  Interrupt EP requires preamble (is a low speed device on a full speed hub)
                INTEP_PREAMBLE: u1,
                padding: u5,
            }),
            ///  Interrupt endpoint 14. Only valid for HOST mode.
            ADDR_ENDP14: mmio.Mmio(packed struct(u32) {
                ///  Device address
                ADDRESS: u7,
                reserved16: u9,
                ///  Endpoint number of the interrupt endpoint
                ENDPOINT: u4,
                reserved25: u5,
                ///  Direction of the interrupt endpoint. In=0, Out=1
                INTEP_DIR: u1,
                ///  Interrupt EP requires preamble (is a low speed device on a full speed hub)
                INTEP_PREAMBLE: u1,
                padding: u5,
            }),
            ///  Interrupt endpoint 15. Only valid for HOST mode.
            ADDR_ENDP15: mmio.Mmio(packed struct(u32) {
                ///  Device address
                ADDRESS: u7,
                reserved16: u9,
                ///  Endpoint number of the interrupt endpoint
                ENDPOINT: u4,
                reserved25: u5,
                ///  Direction of the interrupt endpoint. In=0, Out=1
                INTEP_DIR: u1,
                ///  Interrupt EP requires preamble (is a low speed device on a full speed hub)
                INTEP_PREAMBLE: u1,
                padding: u5,
            }),
            ///  Main control register
            MAIN_CTRL: mmio.Mmio(packed struct(u32) {
                ///  Enable controller
                CONTROLLER_EN: u1,
                ///  Device mode = 0, Host mode = 1
                HOST_NDEVICE: u1,
                reserved31: u29,
                ///  Reduced timings for simulation
                SIM_TIMING: u1,
            }),
            ///  Set the SOF (Start of Frame) frame number in the host controller. The SOF packet is sent every 1ms and the host will increment the frame number by 1 each time.
            SOF_WR: mmio.Mmio(packed struct(u32) {
                COUNT: u11,
                padding: u21,
            }),
            ///  Read the last SOF (Start of Frame) frame number seen. In device mode the last SOF received from the host. In host mode the last SOF sent by the host.
            SOF_RD: mmio.Mmio(packed struct(u32) {
                COUNT: u11,
                padding: u21,
            }),
            ///  SIE control register
            SIE_CTRL: mmio.Mmio(packed struct(u32) {
                ///  Host: Start transaction
                START_TRANS: u1,
                ///  Host: Send Setup packet
                SEND_SETUP: u1,
                ///  Host: Send transaction (OUT from host)
                SEND_DATA: u1,
                ///  Host: Receive transaction (IN to host)
                RECEIVE_DATA: u1,
                ///  Host: Stop transaction
                STOP_TRANS: u1,
                reserved6: u1,
                ///  Host: Preable enable for LS device on FS hub
                PREAMBLE_EN: u1,
                reserved8: u1,
                ///  Host: Delay packet(s) until after SOF
                SOF_SYNC: u1,
                ///  Host: Enable SOF generation (for full speed bus)
                SOF_EN: u1,
                ///  Host: Enable keep alive packet (for low speed bus)
                KEEP_ALIVE_EN: u1,
                ///  Host: Enable VBUS
                VBUS_EN: u1,
                ///  Device: Remote wakeup. Device can initiate its own resume after suspend.
                RESUME: u1,
                ///  Host: Reset bus
                RESET_BUS: u1,
                reserved15: u1,
                ///  Host: Enable pull down resistors
                PULLDOWN_EN: u1,
                ///  Device: Enable pull up resistor
                PULLUP_EN: u1,
                ///  Device: Pull-up strength (0=1K2, 1=2k3)
                RPU_OPT: u1,
                ///  Power down bus transceiver
                TRANSCEIVER_PD: u1,
                reserved24: u5,
                ///  Direct control of DM
                DIRECT_DM: u1,
                ///  Direct control of DP
                DIRECT_DP: u1,
                ///  Direct bus drive enable
                DIRECT_EN: u1,
                ///  Device: Set bit in EP_STATUS_STALL_NAK when EP0 sends a NAK
                EP0_INT_NAK: u1,
                ///  Device: Set bit in BUFF_STATUS for every 2 buffers completed on EP0
                EP0_INT_2BUF: u1,
                ///  Device: Set bit in BUFF_STATUS for every buffer completed on EP0
                EP0_INT_1BUF: u1,
                ///  Device: EP0 single buffered = 0, double buffered = 1
                EP0_DOUBLE_BUF: u1,
                ///  Device: Set bit in EP_STATUS_STALL_NAK when EP0 sends a STALL
                EP0_INT_STALL: u1,
            }),
            ///  SIE status register
            SIE_STATUS: mmio.Mmio(packed struct(u32) {
                ///  Device: VBUS Detected
                VBUS_DETECTED: u1,
                reserved2: u1,
                ///  USB bus line state
                LINE_STATE: u2,
                ///  Bus in suspended state. Valid for device and host. Host and device will go into suspend if neither Keep Alive / SOF frames are enabled.
                SUSPENDED: u1,
                reserved8: u3,
                ///  Host: device speed. Disconnected = 00, LS = 01, FS = 10
                SPEED: u2,
                ///  VBUS over current detected
                VBUS_OVER_CURR: u1,
                ///  Host: Device has initiated a remote resume. Device: host has initiated a resume.
                RESUME: u1,
                reserved16: u4,
                ///  Device: connected
                CONNECTED: u1,
                ///  Device: Setup packet received
                SETUP_REC: u1,
                ///  Transaction complete.
                ///  Raised by device if:
                ///  * An IN or OUT packet is sent with the `LAST_BUFF` bit set in the buffer control register
                ///  Raised by host if:
                ///  * A setup packet is sent when no data in or data out transaction follows * An IN packet is received and the `LAST_BUFF` bit is set in the buffer control register * An IN packet is received with zero length * An OUT packet is sent and the `LAST_BUFF` bit is set
                TRANS_COMPLETE: u1,
                ///  Device: bus reset received
                BUS_RESET: u1,
                reserved24: u4,
                ///  CRC Error. Raised by the Serial RX engine.
                CRC_ERROR: u1,
                ///  Bit Stuff Error. Raised by the Serial RX engine.
                BIT_STUFF_ERROR: u1,
                ///  RX overflow is raised by the Serial RX engine if the incoming data is too fast.
                RX_OVERFLOW: u1,
                ///  RX timeout is raised by both the host and device if an ACK is not received in the maximum time specified by the USB spec.
                RX_TIMEOUT: u1,
                ///  Host: NAK received
                NAK_REC: u1,
                ///  Host: STALL received
                STALL_REC: u1,
                ///  ACK received. Raised by both host and device.
                ACK_REC: u1,
                ///  Data Sequence Error.
                ///  The device can raise a sequence error in the following conditions:
                ///  * A SETUP packet is received followed by a DATA1 packet (data phase should always be DATA0) * An OUT packet is received from the host but doesn't match the data pid in the buffer control register read from DPSRAM
                ///  The host can raise a data sequence error in the following conditions:
                ///  * An IN packet from the device has the wrong data PID
                DATA_SEQ_ERROR: u1,
            }),
            ///  interrupt endpoint control register
            INT_EP_CTRL: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Host: Enable interrupt endpoint 1 -> 15
                INT_EP_ACTIVE: u15,
                padding: u16,
            }),
            ///  Buffer status register. A bit set here indicates that a buffer has completed on the endpoint (if the buffer interrupt is enabled). It is possible for 2 buffers to be completed, so clearing the buffer status bit may instantly re set it on the next clock cycle.
            BUFF_STATUS: mmio.Mmio(packed struct(u32) {
                EP0_IN: u1,
                EP0_OUT: u1,
                EP1_IN: u1,
                EP1_OUT: u1,
                EP2_IN: u1,
                EP2_OUT: u1,
                EP3_IN: u1,
                EP3_OUT: u1,
                EP4_IN: u1,
                EP4_OUT: u1,
                EP5_IN: u1,
                EP5_OUT: u1,
                EP6_IN: u1,
                EP6_OUT: u1,
                EP7_IN: u1,
                EP7_OUT: u1,
                EP8_IN: u1,
                EP8_OUT: u1,
                EP9_IN: u1,
                EP9_OUT: u1,
                EP10_IN: u1,
                EP10_OUT: u1,
                EP11_IN: u1,
                EP11_OUT: u1,
                EP12_IN: u1,
                EP12_OUT: u1,
                EP13_IN: u1,
                EP13_OUT: u1,
                EP14_IN: u1,
                EP14_OUT: u1,
                EP15_IN: u1,
                EP15_OUT: u1,
            }),
            ///  Which of the double buffers should be handled. Only valid if using an interrupt per buffer (i.e. not per 2 buffers). Not valid for host interrupt endpoint polling because they are only single buffered.
            BUFF_CPU_SHOULD_HANDLE: mmio.Mmio(packed struct(u32) {
                EP0_IN: u1,
                EP0_OUT: u1,
                EP1_IN: u1,
                EP1_OUT: u1,
                EP2_IN: u1,
                EP2_OUT: u1,
                EP3_IN: u1,
                EP3_OUT: u1,
                EP4_IN: u1,
                EP4_OUT: u1,
                EP5_IN: u1,
                EP5_OUT: u1,
                EP6_IN: u1,
                EP6_OUT: u1,
                EP7_IN: u1,
                EP7_OUT: u1,
                EP8_IN: u1,
                EP8_OUT: u1,
                EP9_IN: u1,
                EP9_OUT: u1,
                EP10_IN: u1,
                EP10_OUT: u1,
                EP11_IN: u1,
                EP11_OUT: u1,
                EP12_IN: u1,
                EP12_OUT: u1,
                EP13_IN: u1,
                EP13_OUT: u1,
                EP14_IN: u1,
                EP14_OUT: u1,
                EP15_IN: u1,
                EP15_OUT: u1,
            }),
            ///  Device only: Can be set to ignore the buffer control register for this endpoint in case you would like to revoke a buffer. A NAK will be sent for every access to the endpoint until this bit is cleared. A corresponding bit in `EP_ABORT_DONE` is set when it is safe to modify the buffer control register.
            EP_ABORT: mmio.Mmio(packed struct(u32) {
                EP0_IN: u1,
                EP0_OUT: u1,
                EP1_IN: u1,
                EP1_OUT: u1,
                EP2_IN: u1,
                EP2_OUT: u1,
                EP3_IN: u1,
                EP3_OUT: u1,
                EP4_IN: u1,
                EP4_OUT: u1,
                EP5_IN: u1,
                EP5_OUT: u1,
                EP6_IN: u1,
                EP6_OUT: u1,
                EP7_IN: u1,
                EP7_OUT: u1,
                EP8_IN: u1,
                EP8_OUT: u1,
                EP9_IN: u1,
                EP9_OUT: u1,
                EP10_IN: u1,
                EP10_OUT: u1,
                EP11_IN: u1,
                EP11_OUT: u1,
                EP12_IN: u1,
                EP12_OUT: u1,
                EP13_IN: u1,
                EP13_OUT: u1,
                EP14_IN: u1,
                EP14_OUT: u1,
                EP15_IN: u1,
                EP15_OUT: u1,
            }),
            ///  Device only: Used in conjunction with `EP_ABORT`. Set once an endpoint is idle so the programmer knows it is safe to modify the buffer control register.
            EP_ABORT_DONE: mmio.Mmio(packed struct(u32) {
                EP0_IN: u1,
                EP0_OUT: u1,
                EP1_IN: u1,
                EP1_OUT: u1,
                EP2_IN: u1,
                EP2_OUT: u1,
                EP3_IN: u1,
                EP3_OUT: u1,
                EP4_IN: u1,
                EP4_OUT: u1,
                EP5_IN: u1,
                EP5_OUT: u1,
                EP6_IN: u1,
                EP6_OUT: u1,
                EP7_IN: u1,
                EP7_OUT: u1,
                EP8_IN: u1,
                EP8_OUT: u1,
                EP9_IN: u1,
                EP9_OUT: u1,
                EP10_IN: u1,
                EP10_OUT: u1,
                EP11_IN: u1,
                EP11_OUT: u1,
                EP12_IN: u1,
                EP12_OUT: u1,
                EP13_IN: u1,
                EP13_OUT: u1,
                EP14_IN: u1,
                EP14_OUT: u1,
                EP15_IN: u1,
                EP15_OUT: u1,
            }),
            ///  Device: this bit must be set in conjunction with the `STALL` bit in the buffer control register to send a STALL on EP0. The device controller clears these bits when a SETUP packet is received because the USB spec requires that a STALL condition is cleared when a SETUP packet is received.
            EP_STALL_ARM: mmio.Mmio(packed struct(u32) {
                EP0_IN: u1,
                EP0_OUT: u1,
                padding: u30,
            }),
            ///  Used by the host controller. Sets the wait time in microseconds before trying again if the device replies with a NAK.
            NAK_POLL: mmio.Mmio(packed struct(u32) {
                ///  NAK polling interval for a low speed device
                DELAY_LS: u10,
                reserved16: u6,
                ///  NAK polling interval for a full speed device
                DELAY_FS: u10,
                padding: u6,
            }),
            ///  Device: bits are set when the `IRQ_ON_NAK` or `IRQ_ON_STALL` bits are set. For EP0 this comes from `SIE_CTRL`. For all other endpoints it comes from the endpoint control register.
            EP_STATUS_STALL_NAK: mmio.Mmio(packed struct(u32) {
                EP0_IN: u1,
                EP0_OUT: u1,
                EP1_IN: u1,
                EP1_OUT: u1,
                EP2_IN: u1,
                EP2_OUT: u1,
                EP3_IN: u1,
                EP3_OUT: u1,
                EP4_IN: u1,
                EP4_OUT: u1,
                EP5_IN: u1,
                EP5_OUT: u1,
                EP6_IN: u1,
                EP6_OUT: u1,
                EP7_IN: u1,
                EP7_OUT: u1,
                EP8_IN: u1,
                EP8_OUT: u1,
                EP9_IN: u1,
                EP9_OUT: u1,
                EP10_IN: u1,
                EP10_OUT: u1,
                EP11_IN: u1,
                EP11_OUT: u1,
                EP12_IN: u1,
                EP12_OUT: u1,
                EP13_IN: u1,
                EP13_OUT: u1,
                EP14_IN: u1,
                EP14_OUT: u1,
                EP15_IN: u1,
                EP15_OUT: u1,
            }),
            ///  Where to connect the USB controller. Should be to_phy by default.
            USB_MUXING: mmio.Mmio(packed struct(u32) {
                TO_PHY: u1,
                TO_EXTPHY: u1,
                TO_DIGITAL_PAD: u1,
                SOFTCON: u1,
                padding: u28,
            }),
            ///  Overrides for the power signals in the event that the VBUS signals are not hooked up to GPIO. Set the value of the override and then the override enable to switch over to the override value.
            USB_PWR: mmio.Mmio(packed struct(u32) {
                VBUS_EN: u1,
                VBUS_EN_OVERRIDE_EN: u1,
                VBUS_DETECT: u1,
                VBUS_DETECT_OVERRIDE_EN: u1,
                OVERCURR_DETECT: u1,
                OVERCURR_DETECT_EN: u1,
                padding: u26,
            }),
            ///  This register allows for direct control of the USB phy. Use in conjunction with usbphy_direct_override register to enable each override bit.
            USBPHY_DIRECT: mmio.Mmio(packed struct(u32) {
                ///  Enable the second DP pull up resistor. 0 - Pull = Rpu2; 1 - Pull = Rpu1 + Rpu2
                DP_PULLUP_HISEL: u1,
                ///  DP pull up enable
                DP_PULLUP_EN: u1,
                ///  DP pull down enable
                DP_PULLDN_EN: u1,
                reserved4: u1,
                ///  Enable the second DM pull up resistor. 0 - Pull = Rpu2; 1 - Pull = Rpu1 + Rpu2
                DM_PULLUP_HISEL: u1,
                ///  DM pull up enable
                DM_PULLUP_EN: u1,
                ///  DM pull down enable
                DM_PULLDN_EN: u1,
                reserved8: u1,
                ///  Output enable. If TX_DIFFMODE=1, OE for DPP/DPM diff pair. 0 - DPP/DPM in Hi-Z state; 1 - DPP/DPM driving
                ///  If TX_DIFFMODE=0, OE for DPP only. 0 - DPP in Hi-Z state; 1 - DPP driving
                TX_DP_OE: u1,
                ///  Output enable. If TX_DIFFMODE=1, Ignored.
                ///  If TX_DIFFMODE=0, OE for DPM only. 0 - DPM in Hi-Z state; 1 - DPM driving
                TX_DM_OE: u1,
                ///  Output data. If TX_DIFFMODE=1, Drives DPP/DPM diff pair. TX_DP_OE=1 to enable drive. DPP=TX_DP, DPM=~TX_DP
                ///  If TX_DIFFMODE=0, Drives DPP only. TX_DP_OE=1 to enable drive. DPP=TX_DP
                TX_DP: u1,
                ///  Output data. TX_DIFFMODE=1, Ignored
                ///  TX_DIFFMODE=0, Drives DPM only. TX_DM_OE=1 to enable drive. DPM=TX_DM
                TX_DM: u1,
                ///  RX power down override (if override enable is set). 1 = powered down.
                RX_PD: u1,
                ///  TX power down override (if override enable is set). 1 = powered down.
                TX_PD: u1,
                ///  TX_FSSLEW=0: Low speed slew rate
                ///  TX_FSSLEW=1: Full speed slew rate
                TX_FSSLEW: u1,
                ///  TX_DIFFMODE=0: Single ended mode
                ///  TX_DIFFMODE=1: Differential drive mode (TX_DM, TX_DM_OE ignored)
                TX_DIFFMODE: u1,
                ///  Differential RX
                RX_DD: u1,
                ///  DPP pin state
                RX_DP: u1,
                ///  DPM pin state
                RX_DM: u1,
                ///  DP overcurrent
                DP_OVCN: u1,
                ///  DM overcurrent
                DM_OVCN: u1,
                ///  DP over voltage
                DP_OVV: u1,
                ///  DM over voltage
                DM_OVV: u1,
                padding: u9,
            }),
            ///  Override enable for each control in usbphy_direct
            USBPHY_DIRECT_OVERRIDE: mmio.Mmio(packed struct(u32) {
                DP_PULLUP_HISEL_OVERRIDE_EN: u1,
                DM_PULLUP_HISEL_OVERRIDE_EN: u1,
                DP_PULLUP_EN_OVERRIDE_EN: u1,
                DP_PULLDN_EN_OVERRIDE_EN: u1,
                DM_PULLDN_EN_OVERRIDE_EN: u1,
                TX_DP_OE_OVERRIDE_EN: u1,
                TX_DM_OE_OVERRIDE_EN: u1,
                TX_DP_OVERRIDE_EN: u1,
                TX_DM_OVERRIDE_EN: u1,
                RX_PD_OVERRIDE_EN: u1,
                TX_PD_OVERRIDE_EN: u1,
                TX_FSSLEW_OVERRIDE_EN: u1,
                DM_PULLUP_OVERRIDE_EN: u1,
                reserved15: u2,
                TX_DIFFMODE_OVERRIDE_EN: u1,
                padding: u16,
            }),
            ///  Used to adjust trim values of USB phy pull down resistors.
            USBPHY_TRIM: mmio.Mmio(packed struct(u32) {
                ///  Value to drive to USB PHY
                ///  DP pulldown resistor trim control
                ///  Experimental data suggests that the reset value will work, but this register allows adjustment if required
                DP_PULLDN_TRIM: u5,
                reserved8: u3,
                ///  Value to drive to USB PHY
                ///  DM pulldown resistor trim control
                ///  Experimental data suggests that the reset value will work, but this register allows adjustment if required
                DM_PULLDN_TRIM: u5,
                padding: u19,
            }),
            reserved140: [4]u8,
            ///  Raw Interrupts
            INTR: mmio.Mmio(packed struct(u32) {
                ///  Host: raised when a device is connected or disconnected (i.e. when SIE_STATUS.SPEED changes). Cleared by writing to SIE_STATUS.SPEED
                HOST_CONN_DIS: u1,
                ///  Host: raised when a device wakes up the host. Cleared by writing to SIE_STATUS.RESUME
                HOST_RESUME: u1,
                ///  Host: raised every time the host sends a SOF (Start of Frame). Cleared by reading SOF_RD
                HOST_SOF: u1,
                ///  Raised every time SIE_STATUS.TRANS_COMPLETE is set. Clear by writing to this bit.
                TRANS_COMPLETE: u1,
                ///  Raised when any bit in BUFF_STATUS is set. Clear by clearing all bits in BUFF_STATUS.
                BUFF_STATUS: u1,
                ///  Source: SIE_STATUS.DATA_SEQ_ERROR
                ERROR_DATA_SEQ: u1,
                ///  Source: SIE_STATUS.RX_TIMEOUT
                ERROR_RX_TIMEOUT: u1,
                ///  Source: SIE_STATUS.RX_OVERFLOW
                ERROR_RX_OVERFLOW: u1,
                ///  Source: SIE_STATUS.BIT_STUFF_ERROR
                ERROR_BIT_STUFF: u1,
                ///  Source: SIE_STATUS.CRC_ERROR
                ERROR_CRC: u1,
                ///  Source: SIE_STATUS.STALL_REC
                STALL: u1,
                ///  Source: SIE_STATUS.VBUS_DETECTED
                VBUS_DETECT: u1,
                ///  Source: SIE_STATUS.BUS_RESET
                BUS_RESET: u1,
                ///  Set when the device connection state changes. Cleared by writing to SIE_STATUS.CONNECTED
                DEV_CONN_DIS: u1,
                ///  Set when the device suspend state changes. Cleared by writing to SIE_STATUS.SUSPENDED
                DEV_SUSPEND: u1,
                ///  Set when the device receives a resume from the host. Cleared by writing to SIE_STATUS.RESUME
                DEV_RESUME_FROM_HOST: u1,
                ///  Device. Source: SIE_STATUS.SETUP_REC
                SETUP_REQ: u1,
                ///  Set every time the device receives a SOF (Start of Frame) packet. Cleared by reading SOF_RD
                DEV_SOF: u1,
                ///  Raised when any bit in ABORT_DONE is set. Clear by clearing all bits in ABORT_DONE.
                ABORT_DONE: u1,
                ///  Raised when any bit in EP_STATUS_STALL_NAK is set. Clear by clearing all bits in EP_STATUS_STALL_NAK.
                EP_STALL_NAK: u1,
                padding: u12,
            }),
            ///  Interrupt Enable
            INTE: mmio.Mmio(packed struct(u32) {
                ///  Host: raised when a device is connected or disconnected (i.e. when SIE_STATUS.SPEED changes). Cleared by writing to SIE_STATUS.SPEED
                HOST_CONN_DIS: u1,
                ///  Host: raised when a device wakes up the host. Cleared by writing to SIE_STATUS.RESUME
                HOST_RESUME: u1,
                ///  Host: raised every time the host sends a SOF (Start of Frame). Cleared by reading SOF_RD
                HOST_SOF: u1,
                ///  Raised every time SIE_STATUS.TRANS_COMPLETE is set. Clear by writing to this bit.
                TRANS_COMPLETE: u1,
                ///  Raised when any bit in BUFF_STATUS is set. Clear by clearing all bits in BUFF_STATUS.
                BUFF_STATUS: u1,
                ///  Source: SIE_STATUS.DATA_SEQ_ERROR
                ERROR_DATA_SEQ: u1,
                ///  Source: SIE_STATUS.RX_TIMEOUT
                ERROR_RX_TIMEOUT: u1,
                ///  Source: SIE_STATUS.RX_OVERFLOW
                ERROR_RX_OVERFLOW: u1,
                ///  Source: SIE_STATUS.BIT_STUFF_ERROR
                ERROR_BIT_STUFF: u1,
                ///  Source: SIE_STATUS.CRC_ERROR
                ERROR_CRC: u1,
                ///  Source: SIE_STATUS.STALL_REC
                STALL: u1,
                ///  Source: SIE_STATUS.VBUS_DETECTED
                VBUS_DETECT: u1,
                ///  Source: SIE_STATUS.BUS_RESET
                BUS_RESET: u1,
                ///  Set when the device connection state changes. Cleared by writing to SIE_STATUS.CONNECTED
                DEV_CONN_DIS: u1,
                ///  Set when the device suspend state changes. Cleared by writing to SIE_STATUS.SUSPENDED
                DEV_SUSPEND: u1,
                ///  Set when the device receives a resume from the host. Cleared by writing to SIE_STATUS.RESUME
                DEV_RESUME_FROM_HOST: u1,
                ///  Device. Source: SIE_STATUS.SETUP_REC
                SETUP_REQ: u1,
                ///  Set every time the device receives a SOF (Start of Frame) packet. Cleared by reading SOF_RD
                DEV_SOF: u1,
                ///  Raised when any bit in ABORT_DONE is set. Clear by clearing all bits in ABORT_DONE.
                ABORT_DONE: u1,
                ///  Raised when any bit in EP_STATUS_STALL_NAK is set. Clear by clearing all bits in EP_STATUS_STALL_NAK.
                EP_STALL_NAK: u1,
                padding: u12,
            }),
            ///  Interrupt Force
            INTF: mmio.Mmio(packed struct(u32) {
                ///  Host: raised when a device is connected or disconnected (i.e. when SIE_STATUS.SPEED changes). Cleared by writing to SIE_STATUS.SPEED
                HOST_CONN_DIS: u1,
                ///  Host: raised when a device wakes up the host. Cleared by writing to SIE_STATUS.RESUME
                HOST_RESUME: u1,
                ///  Host: raised every time the host sends a SOF (Start of Frame). Cleared by reading SOF_RD
                HOST_SOF: u1,
                ///  Raised every time SIE_STATUS.TRANS_COMPLETE is set. Clear by writing to this bit.
                TRANS_COMPLETE: u1,
                ///  Raised when any bit in BUFF_STATUS is set. Clear by clearing all bits in BUFF_STATUS.
                BUFF_STATUS: u1,
                ///  Source: SIE_STATUS.DATA_SEQ_ERROR
                ERROR_DATA_SEQ: u1,
                ///  Source: SIE_STATUS.RX_TIMEOUT
                ERROR_RX_TIMEOUT: u1,
                ///  Source: SIE_STATUS.RX_OVERFLOW
                ERROR_RX_OVERFLOW: u1,
                ///  Source: SIE_STATUS.BIT_STUFF_ERROR
                ERROR_BIT_STUFF: u1,
                ///  Source: SIE_STATUS.CRC_ERROR
                ERROR_CRC: u1,
                ///  Source: SIE_STATUS.STALL_REC
                STALL: u1,
                ///  Source: SIE_STATUS.VBUS_DETECTED
                VBUS_DETECT: u1,
                ///  Source: SIE_STATUS.BUS_RESET
                BUS_RESET: u1,
                ///  Set when the device connection state changes. Cleared by writing to SIE_STATUS.CONNECTED
                DEV_CONN_DIS: u1,
                ///  Set when the device suspend state changes. Cleared by writing to SIE_STATUS.SUSPENDED
                DEV_SUSPEND: u1,
                ///  Set when the device receives a resume from the host. Cleared by writing to SIE_STATUS.RESUME
                DEV_RESUME_FROM_HOST: u1,
                ///  Device. Source: SIE_STATUS.SETUP_REC
                SETUP_REQ: u1,
                ///  Set every time the device receives a SOF (Start of Frame) packet. Cleared by reading SOF_RD
                DEV_SOF: u1,
                ///  Raised when any bit in ABORT_DONE is set. Clear by clearing all bits in ABORT_DONE.
                ABORT_DONE: u1,
                ///  Raised when any bit in EP_STATUS_STALL_NAK is set. Clear by clearing all bits in EP_STATUS_STALL_NAK.
                EP_STALL_NAK: u1,
                padding: u12,
            }),
            ///  Interrupt status after masking & forcing
            INTS: mmio.Mmio(packed struct(u32) {
                ///  Host: raised when a device is connected or disconnected (i.e. when SIE_STATUS.SPEED changes). Cleared by writing to SIE_STATUS.SPEED
                HOST_CONN_DIS: u1,
                ///  Host: raised when a device wakes up the host. Cleared by writing to SIE_STATUS.RESUME
                HOST_RESUME: u1,
                ///  Host: raised every time the host sends a SOF (Start of Frame). Cleared by reading SOF_RD
                HOST_SOF: u1,
                ///  Raised every time SIE_STATUS.TRANS_COMPLETE is set. Clear by writing to this bit.
                TRANS_COMPLETE: u1,
                ///  Raised when any bit in BUFF_STATUS is set. Clear by clearing all bits in BUFF_STATUS.
                BUFF_STATUS: u1,
                ///  Source: SIE_STATUS.DATA_SEQ_ERROR
                ERROR_DATA_SEQ: u1,
                ///  Source: SIE_STATUS.RX_TIMEOUT
                ERROR_RX_TIMEOUT: u1,
                ///  Source: SIE_STATUS.RX_OVERFLOW
                ERROR_RX_OVERFLOW: u1,
                ///  Source: SIE_STATUS.BIT_STUFF_ERROR
                ERROR_BIT_STUFF: u1,
                ///  Source: SIE_STATUS.CRC_ERROR
                ERROR_CRC: u1,
                ///  Source: SIE_STATUS.STALL_REC
                STALL: u1,
                ///  Source: SIE_STATUS.VBUS_DETECTED
                VBUS_DETECT: u1,
                ///  Source: SIE_STATUS.BUS_RESET
                BUS_RESET: u1,
                ///  Set when the device connection state changes. Cleared by writing to SIE_STATUS.CONNECTED
                DEV_CONN_DIS: u1,
                ///  Set when the device suspend state changes. Cleared by writing to SIE_STATUS.SUSPENDED
                DEV_SUSPEND: u1,
                ///  Set when the device receives a resume from the host. Cleared by writing to SIE_STATUS.RESUME
                DEV_RESUME_FROM_HOST: u1,
                ///  Device. Source: SIE_STATUS.SETUP_REC
                SETUP_REQ: u1,
                ///  Set every time the device receives a SOF (Start of Frame) packet. Cleared by reading SOF_RD
                DEV_SOF: u1,
                ///  Raised when any bit in ABORT_DONE is set. Clear by clearing all bits in ABORT_DONE.
                ABORT_DONE: u1,
                ///  Raised when any bit in EP_STATUS_STALL_NAK is set. Clear by clearing all bits in EP_STATUS_STALL_NAK.
                EP_STALL_NAK: u1,
                padding: u12,
            }),
        };

        ///  DW_apb_i2c address block
        ///  List of configuration constants for the Synopsys I2C hardware (you may see references to these in I2C register header; these are *fixed* values, set at hardware design time):
        ///  IC_ULTRA_FAST_MODE ................ 0x0
        ///  IC_UFM_TBUF_CNT_DEFAULT ........... 0x8
        ///  IC_UFM_SCL_LOW_COUNT .............. 0x0008
        ///  IC_UFM_SCL_HIGH_COUNT ............. 0x0006
        ///  IC_TX_TL .......................... 0x0
        ///  IC_TX_CMD_BLOCK ................... 0x1
        ///  IC_HAS_DMA ........................ 0x1
        ///  IC_HAS_ASYNC_FIFO ................. 0x0
        ///  IC_SMBUS_ARP ...................... 0x0
        ///  IC_FIRST_DATA_BYTE_STATUS ......... 0x1
        ///  IC_INTR_IO ........................ 0x1
        ///  IC_MASTER_MODE .................... 0x1
        ///  IC_DEFAULT_ACK_GENERAL_CALL ....... 0x1
        ///  IC_INTR_POL ....................... 0x1
        ///  IC_OPTIONAL_SAR ................... 0x0
        ///  IC_DEFAULT_TAR_SLAVE_ADDR ......... 0x055
        ///  IC_DEFAULT_SLAVE_ADDR ............. 0x055
        ///  IC_DEFAULT_HS_SPKLEN .............. 0x1
        ///  IC_FS_SCL_HIGH_COUNT .............. 0x0006
        ///  IC_HS_SCL_LOW_COUNT ............... 0x0008
        ///  IC_DEVICE_ID_VALUE ................ 0x0
        ///  IC_10BITADDR_MASTER ............... 0x0
        ///  IC_CLK_FREQ_OPTIMIZATION .......... 0x0
        ///  IC_DEFAULT_FS_SPKLEN .............. 0x7
        ///  IC_ADD_ENCODED_PARAMS ............. 0x0
        ///  IC_DEFAULT_SDA_HOLD ............... 0x000001
        ///  IC_DEFAULT_SDA_SETUP .............. 0x64
        ///  IC_AVOID_RX_FIFO_FLUSH_ON_TX_ABRT . 0x0
        ///  IC_CLOCK_PERIOD ................... 100
        ///  IC_EMPTYFIFO_HOLD_MASTER_EN ....... 1
        ///  IC_RESTART_EN ..................... 0x1
        ///  IC_TX_CMD_BLOCK_DEFAULT ........... 0x0
        ///  IC_BUS_CLEAR_FEATURE .............. 0x0
        ///  IC_CAP_LOADING .................... 100
        ///  IC_FS_SCL_LOW_COUNT ............... 0x000d
        ///  APB_DATA_WIDTH .................... 32
        ///  IC_SDA_STUCK_TIMEOUT_DEFAULT ...... 0xffffffff
        ///  IC_SLV_DATA_NACK_ONLY ............. 0x1
        ///  IC_10BITADDR_SLAVE ................ 0x0
        ///  IC_CLK_TYPE ....................... 0x0
        ///  IC_SMBUS_UDID_MSB ................. 0x0
        ///  IC_SMBUS_SUSPEND_ALERT ............ 0x0
        ///  IC_HS_SCL_HIGH_COUNT .............. 0x0006
        ///  IC_SLV_RESTART_DET_EN ............. 0x1
        ///  IC_SMBUS .......................... 0x0
        ///  IC_OPTIONAL_SAR_DEFAULT ........... 0x0
        ///  IC_PERSISTANT_SLV_ADDR_DEFAULT .... 0x0
        ///  IC_USE_COUNTS ..................... 0x0
        ///  IC_RX_BUFFER_DEPTH ................ 16
        ///  IC_SCL_STUCK_TIMEOUT_DEFAULT ...... 0xffffffff
        ///  IC_RX_FULL_HLD_BUS_EN ............. 0x1
        ///  IC_SLAVE_DISABLE .................. 0x1
        ///  IC_RX_TL .......................... 0x0
        ///  IC_DEVICE_ID ...................... 0x0
        ///  IC_HC_COUNT_VALUES ................ 0x0
        ///  I2C_DYNAMIC_TAR_UPDATE ............ 0
        ///  IC_SMBUS_CLK_LOW_MEXT_DEFAULT ..... 0xffffffff
        ///  IC_SMBUS_CLK_LOW_SEXT_DEFAULT ..... 0xffffffff
        ///  IC_HS_MASTER_CODE ................. 0x1
        ///  IC_SMBUS_RST_IDLE_CNT_DEFAULT ..... 0xffff
        ///  IC_SMBUS_UDID_LSB_DEFAULT ......... 0xffffffff
        ///  IC_SS_SCL_HIGH_COUNT .............. 0x0028
        ///  IC_SS_SCL_LOW_COUNT ............... 0x002f
        ///  IC_MAX_SPEED_MODE ................. 0x2
        ///  IC_STAT_FOR_CLK_STRETCH ........... 0x0
        ///  IC_STOP_DET_IF_MASTER_ACTIVE ...... 0x0
        ///  IC_DEFAULT_UFM_SPKLEN ............. 0x1
        ///  IC_TX_BUFFER_DEPTH ................ 16
        pub const I2C0 = extern struct {
            ///  I2C Control Register. This register can be written only when the DW_apb_i2c is disabled, which corresponds to the IC_ENABLE[0] register being set to 0. Writes at other times have no effect.
            ///  Read/Write Access: - bit 10 is read only. - bit 11 is read only - bit 16 is read only - bit 17 is read only - bits 18 and 19 are read only.
            IC_CON: mmio.Mmio(packed struct(u32) {
                ///  This bit controls whether the DW_apb_i2c master is enabled.
                ///  NOTE: Software should ensure that if this bit is written with '1' then bit 6 should also be written with a '1'.
                MASTER_MODE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Master mode is disabled
                        DISABLED = 0x0,
                        ///  Master mode is enabled
                        ENABLED = 0x1,
                    },
                },
                ///  These bits control at which speed the DW_apb_i2c operates; its setting is relevant only if one is operating the DW_apb_i2c in master mode. Hardware protects against illegal values being programmed by software. These bits must be programmed appropriately for slave mode also, as it is used to capture correct value of spike filter as per the speed mode.
                ///  This register should be programmed only with a value in the range of 1 to IC_MAX_SPEED_MODE; otherwise, hardware updates this register with the value of IC_MAX_SPEED_MODE.
                ///  1: standard mode (100 kbit/s)
                ///  2: fast mode (<=400 kbit/s) or fast mode plus (<=1000Kbit/s)
                ///  3: high speed mode (3.4 Mbit/s)
                ///  Note: This field is not applicable when IC_ULTRA_FAST_MODE=1
                SPEED: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Standard Speed mode of operation
                        STANDARD = 0x1,
                        ///  Fast or Fast Plus mode of operation
                        FAST = 0x2,
                        ///  High Speed mode of operation
                        HIGH = 0x3,
                        _,
                    },
                },
                ///  When acting as a slave, this bit controls whether the DW_apb_i2c responds to 7- or 10-bit addresses. - 0: 7-bit addressing. The DW_apb_i2c ignores transactions that involve 10-bit addressing; for 7-bit addressing, only the lower 7 bits of the IC_SAR register are compared. - 1: 10-bit addressing. The DW_apb_i2c responds to only 10-bit addressing transfers that match the full 10 bits of the IC_SAR register.
                IC_10BITADDR_SLAVE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Slave 7Bit addressing
                        ADDR_7BITS = 0x0,
                        ///  Slave 10Bit addressing
                        ADDR_10BITS = 0x1,
                    },
                },
                ///  Controls whether the DW_apb_i2c starts its transfers in 7- or 10-bit addressing mode when acting as a master. - 0: 7-bit addressing - 1: 10-bit addressing
                IC_10BITADDR_MASTER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Master 7Bit addressing mode
                        ADDR_7BITS = 0x0,
                        ///  Master 10Bit addressing mode
                        ADDR_10BITS = 0x1,
                    },
                },
                ///  Determines whether RESTART conditions may be sent when acting as a master. Some older slaves do not support handling RESTART conditions; however, RESTART conditions are used in several DW_apb_i2c operations. When RESTART is disabled, the master is prohibited from performing the following functions: - Sending a START BYTE - Performing any high-speed mode operation - High-speed mode operation - Performing direction changes in combined format mode - Performing a read operation with a 10-bit address By replacing RESTART condition followed by a STOP and a subsequent START condition, split operations are broken down into multiple DW_apb_i2c transfers. If the above operations are performed, it will result in setting bit 6 (TX_ABRT) of the IC_RAW_INTR_STAT register.
                ///  Reset value: ENABLED
                IC_RESTART_EN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Master restart disabled
                        DISABLED = 0x0,
                        ///  Master restart enabled
                        ENABLED = 0x1,
                    },
                },
                ///  This bit controls whether I2C has its slave disabled, which means once the presetn signal is applied, then this bit is set and the slave is disabled.
                ///  If this bit is set (slave is disabled), DW_apb_i2c functions only as a master and does not perform any action that requires a slave.
                ///  NOTE: Software should ensure that if this bit is written with 0, then bit 0 should also be written with a 0.
                IC_SLAVE_DISABLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Slave mode is enabled
                        SLAVE_ENABLED = 0x0,
                        ///  Slave mode is disabled
                        SLAVE_DISABLED = 0x1,
                    },
                },
                ///  In slave mode: - 1'b1: issues the STOP_DET interrupt only when it is addressed. - 1'b0: issues the STOP_DET irrespective of whether it's addressed or not. Reset value: 0x0
                ///  NOTE: During a general call address, this slave does not issue the STOP_DET interrupt if STOP_DET_IF_ADDRESSED = 1'b1, even if the slave responds to the general call address by generating ACK. The STOP_DET interrupt is generated only when the transmitted address matches the slave address (SAR).
                STOP_DET_IFADDRESSED: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  slave issues STOP_DET intr always
                        DISABLED = 0x0,
                        ///  slave issues STOP_DET intr only if addressed
                        ENABLED = 0x1,
                    },
                },
                ///  This bit controls the generation of the TX_EMPTY interrupt, as described in the IC_RAW_INTR_STAT register.
                ///  Reset value: 0x0.
                TX_EMPTY_CTRL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Default behaviour of TX_EMPTY interrupt
                        DISABLED = 0x0,
                        ///  Controlled generation of TX_EMPTY interrupt
                        ENABLED = 0x1,
                    },
                },
                ///  This bit controls whether DW_apb_i2c should hold the bus when the Rx FIFO is physically full to its RX_BUFFER_DEPTH, as described in the IC_RX_FULL_HLD_BUS_EN parameter.
                ///  Reset value: 0x0.
                RX_FIFO_FULL_HLD_CTRL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Overflow when RX_FIFO is full
                        DISABLED = 0x0,
                        ///  Hold bus when RX_FIFO is full
                        ENABLED = 0x1,
                    },
                },
                ///  Master issues the STOP_DET interrupt irrespective of whether master is active or not
                STOP_DET_IF_MASTER_ACTIVE: u1,
                padding: u21,
            }),
            ///  I2C Target Address Register
            ///  This register is 12 bits wide, and bits 31:12 are reserved. This register can be written to only when IC_ENABLE[0] is set to 0.
            ///  Note: If the software or application is aware that the DW_apb_i2c is not using the TAR address for the pending commands in the Tx FIFO, then it is possible to update the TAR address even while the Tx FIFO has entries (IC_STATUS[2]= 0). - It is not necessary to perform any write to this register if DW_apb_i2c is enabled as an I2C slave only.
            IC_TAR: mmio.Mmio(packed struct(u32) {
                ///  This is the target address for any master transaction. When transmitting a General Call, these bits are ignored. To generate a START BYTE, the CPU needs to write only once into these bits.
                ///  If the IC_TAR and IC_SAR are the same, loopback exists but the FIFOs are shared between master and slave, so full loopback is not feasible. Only one direction loopback mode is supported (simplex), not duplex. A master cannot transmit to itself; it can transmit to only a slave.
                IC_TAR: u10,
                ///  If bit 11 (SPECIAL) is set to 1 and bit 13(Device-ID) is set to 0, then this bit indicates whether a General Call or START byte command is to be performed by the DW_apb_i2c. - 0: General Call Address - after issuing a General Call, only writes may be performed. Attempting to issue a read command results in setting bit 6 (TX_ABRT) of the IC_RAW_INTR_STAT register. The DW_apb_i2c remains in General Call mode until the SPECIAL bit value (bit 11) is cleared. - 1: START BYTE Reset value: 0x0
                GC_OR_START: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  GENERAL_CALL byte transmission
                        GENERAL_CALL = 0x0,
                        ///  START byte transmission
                        START_BYTE = 0x1,
                    },
                },
                ///  This bit indicates whether software performs a Device-ID or General Call or START BYTE command. - 0: ignore bit 10 GC_OR_START and use IC_TAR normally - 1: perform special I2C command as specified in Device_ID or GC_OR_START bit Reset value: 0x0
                SPECIAL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Disables programming of GENERAL_CALL or START_BYTE transmission
                        DISABLED = 0x0,
                        ///  Enables programming of GENERAL_CALL or START_BYTE transmission
                        ENABLED = 0x1,
                    },
                },
                padding: u20,
            }),
            ///  I2C Slave Address Register
            IC_SAR: mmio.Mmio(packed struct(u32) {
                ///  The IC_SAR holds the slave address when the I2C is operating as a slave. For 7-bit addressing, only IC_SAR[6:0] is used.
                ///  This register can be written only when the I2C interface is disabled, which corresponds to the IC_ENABLE[0] register being set to 0. Writes at other times have no effect.
                ///  Note: The default values cannot be any of the reserved address locations: that is, 0x00 to 0x07, or 0x78 to 0x7f. The correct operation of the device is not guaranteed if you program the IC_SAR or IC_TAR to a reserved value. Refer to <<table_I2C_firstbyte_bit_defs>> for a complete list of these reserved values.
                IC_SAR: u10,
                padding: u22,
            }),
            reserved16: [4]u8,
            ///  I2C Rx/Tx Data Buffer and Command Register; this is the register the CPU writes to when filling the TX FIFO and the CPU reads from when retrieving bytes from RX FIFO.
            ///  The size of the register changes as follows:
            ///  Write: - 11 bits when IC_EMPTYFIFO_HOLD_MASTER_EN=1 - 9 bits when IC_EMPTYFIFO_HOLD_MASTER_EN=0 Read: - 12 bits when IC_FIRST_DATA_BYTE_STATUS = 1 - 8 bits when IC_FIRST_DATA_BYTE_STATUS = 0 Note: In order for the DW_apb_i2c to continue acknowledging reads, a read command should be written for every byte that is to be received; otherwise the DW_apb_i2c will stop acknowledging.
            IC_DATA_CMD: mmio.Mmio(packed struct(u32) {
                ///  This register contains the data to be transmitted or received on the I2C bus. If you are writing to this register and want to perform a read, bits 7:0 (DAT) are ignored by the DW_apb_i2c. However, when you read this register, these bits return the value of data received on the DW_apb_i2c interface.
                ///  Reset value: 0x0
                DAT: u8,
                ///  This bit controls whether a read or a write is performed. This bit does not control the direction when the DW_apb_i2con acts as a slave. It controls only the direction when it acts as a master.
                ///  When a command is entered in the TX FIFO, this bit distinguishes the write and read commands. In slave-receiver mode, this bit is a 'don't care' because writes to this register are not required. In slave-transmitter mode, a '0' indicates that the data in IC_DATA_CMD is to be transmitted.
                ///  When programming this bit, you should remember the following: attempting to perform a read operation after a General Call command has been sent results in a TX_ABRT interrupt (bit 6 of the IC_RAW_INTR_STAT register), unless bit 11 (SPECIAL) in the IC_TAR register has been cleared. If a '1' is written to this bit after receiving a RD_REQ interrupt, then a TX_ABRT interrupt occurs.
                ///  Reset value: 0x0
                CMD: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Master Write Command
                        WRITE = 0x0,
                        ///  Master Read Command
                        READ = 0x1,
                    },
                },
                ///  This bit controls whether a STOP is issued after the byte is sent or received.
                ///  - 1 - STOP is issued after this byte, regardless of whether or not the Tx FIFO is empty. If the Tx FIFO is not empty, the master immediately tries to start a new transfer by issuing a START and arbitrating for the bus. - 0 - STOP is not issued after this byte, regardless of whether or not the Tx FIFO is empty. If the Tx FIFO is not empty, the master continues the current transfer by sending/receiving data bytes according to the value of the CMD bit. If the Tx FIFO is empty, the master holds the SCL line low and stalls the bus until a new command is available in the Tx FIFO. Reset value: 0x0
                STOP: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Don't Issue STOP after this command
                        DISABLE = 0x0,
                        ///  Issue STOP after this command
                        ENABLE = 0x1,
                    },
                },
                ///  This bit controls whether a RESTART is issued before the byte is sent or received.
                ///  1 - If IC_RESTART_EN is 1, a RESTART is issued before the data is sent/received (according to the value of CMD), regardless of whether or not the transfer direction is changing from the previous command; if IC_RESTART_EN is 0, a STOP followed by a START is issued instead.
                ///  0 - If IC_RESTART_EN is 1, a RESTART is issued only if the transfer direction is changing from the previous command; if IC_RESTART_EN is 0, a STOP followed by a START is issued instead.
                ///  Reset value: 0x0
                RESTART: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Don't Issue RESTART before this command
                        DISABLE = 0x0,
                        ///  Issue RESTART before this command
                        ENABLE = 0x1,
                    },
                },
                ///  Indicates the first data byte received after the address phase for receive transfer in Master receiver or Slave receiver mode.
                ///  Reset value : 0x0
                ///  NOTE: In case of APB_DATA_WIDTH=8,
                ///  1. The user has to perform two APB Reads to IC_DATA_CMD in order to get status on 11 bit.
                ///  2. In order to read the 11 bit, the user has to perform the first data byte read [7:0] (offset 0x10) and then perform the second read [15:8] (offset 0x11) in order to know the status of 11 bit (whether the data received in previous read is a first data byte or not).
                ///  3. The 11th bit is an optional read field, user can ignore 2nd byte read [15:8] (offset 0x11) if not interested in FIRST_DATA_BYTE status.
                FIRST_DATA_BYTE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Sequential data byte received
                        INACTIVE = 0x0,
                        ///  Non sequential data byte received
                        ACTIVE = 0x1,
                    },
                },
                padding: u20,
            }),
            ///  Standard Speed I2C Clock SCL High Count Register
            IC_SS_SCL_HCNT: mmio.Mmio(packed struct(u32) {
                ///  This register must be set before any I2C bus transaction can take place to ensure proper I/O timing. This register sets the SCL clock high-period count for standard speed. For more information, refer to 'IC_CLK Frequency Configuration'.
                ///  This register can be written only when the I2C interface is disabled which corresponds to the IC_ENABLE[0] register being set to 0. Writes at other times have no effect.
                ///  The minimum valid value is 6; hardware prevents values less than this being written, and if attempted results in 6 being set. For designs with APB_DATA_WIDTH = 8, the order of programming is important to ensure the correct operation of the DW_apb_i2c. The lower byte must be programmed first. Then the upper byte is programmed.
                ///  NOTE: This register must not be programmed to a value higher than 65525, because DW_apb_i2c uses a 16-bit counter to flag an I2C bus idle condition when this counter reaches a value of IC_SS_SCL_HCNT + 10.
                IC_SS_SCL_HCNT: u16,
                padding: u16,
            }),
            ///  Standard Speed I2C Clock SCL Low Count Register
            IC_SS_SCL_LCNT: mmio.Mmio(packed struct(u32) {
                ///  This register must be set before any I2C bus transaction can take place to ensure proper I/O timing. This register sets the SCL clock low period count for standard speed. For more information, refer to 'IC_CLK Frequency Configuration'
                ///  This register can be written only when the I2C interface is disabled which corresponds to the IC_ENABLE[0] register being set to 0. Writes at other times have no effect.
                ///  The minimum valid value is 8; hardware prevents values less than this being written, and if attempted, results in 8 being set. For designs with APB_DATA_WIDTH = 8, the order of programming is important to ensure the correct operation of DW_apb_i2c. The lower byte must be programmed first, and then the upper byte is programmed.
                IC_SS_SCL_LCNT: u16,
                padding: u16,
            }),
            ///  Fast Mode or Fast Mode Plus I2C Clock SCL High Count Register
            IC_FS_SCL_HCNT: mmio.Mmio(packed struct(u32) {
                ///  This register must be set before any I2C bus transaction can take place to ensure proper I/O timing. This register sets the SCL clock high-period count for fast mode or fast mode plus. It is used in high-speed mode to send the Master Code and START BYTE or General CALL. For more information, refer to 'IC_CLK Frequency Configuration'.
                ///  This register goes away and becomes read-only returning 0s if IC_MAX_SPEED_MODE = standard. This register can be written only when the I2C interface is disabled, which corresponds to the IC_ENABLE[0] register being set to 0. Writes at other times have no effect.
                ///  The minimum valid value is 6; hardware prevents values less than this being written, and if attempted results in 6 being set. For designs with APB_DATA_WIDTH == 8 the order of programming is important to ensure the correct operation of the DW_apb_i2c. The lower byte must be programmed first. Then the upper byte is programmed.
                IC_FS_SCL_HCNT: u16,
                padding: u16,
            }),
            ///  Fast Mode or Fast Mode Plus I2C Clock SCL Low Count Register
            IC_FS_SCL_LCNT: mmio.Mmio(packed struct(u32) {
                ///  This register must be set before any I2C bus transaction can take place to ensure proper I/O timing. This register sets the SCL clock low period count for fast speed. It is used in high-speed mode to send the Master Code and START BYTE or General CALL. For more information, refer to 'IC_CLK Frequency Configuration'.
                ///  This register goes away and becomes read-only returning 0s if IC_MAX_SPEED_MODE = standard.
                ///  This register can be written only when the I2C interface is disabled, which corresponds to the IC_ENABLE[0] register being set to 0. Writes at other times have no effect.
                ///  The minimum valid value is 8; hardware prevents values less than this being written, and if attempted results in 8 being set. For designs with APB_DATA_WIDTH = 8 the order of programming is important to ensure the correct operation of the DW_apb_i2c. The lower byte must be programmed first. Then the upper byte is programmed. If the value is less than 8 then the count value gets changed to 8.
                IC_FS_SCL_LCNT: u16,
                padding: u16,
            }),
            reserved44: [8]u8,
            ///  I2C Interrupt Status Register
            ///  Each bit in this register has a corresponding mask bit in the IC_INTR_MASK register. These bits are cleared by reading the matching interrupt clear register. The unmasked raw versions of these bits are available in the IC_RAW_INTR_STAT register.
            IC_INTR_STAT: mmio.Mmio(packed struct(u32) {
                ///  See IC_RAW_INTR_STAT for a detailed description of R_RX_UNDER bit.
                ///  Reset value: 0x0
                R_RX_UNDER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RX_UNDER interrupt is inactive
                        INACTIVE = 0x0,
                        ///  RX_UNDER interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  See IC_RAW_INTR_STAT for a detailed description of R_RX_OVER bit.
                ///  Reset value: 0x0
                R_RX_OVER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  R_RX_OVER interrupt is inactive
                        INACTIVE = 0x0,
                        ///  R_RX_OVER interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  See IC_RAW_INTR_STAT for a detailed description of R_RX_FULL bit.
                ///  Reset value: 0x0
                R_RX_FULL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  R_RX_FULL interrupt is inactive
                        INACTIVE = 0x0,
                        ///  R_RX_FULL interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  See IC_RAW_INTR_STAT for a detailed description of R_TX_OVER bit.
                ///  Reset value: 0x0
                R_TX_OVER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  R_TX_OVER interrupt is inactive
                        INACTIVE = 0x0,
                        ///  R_TX_OVER interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  See IC_RAW_INTR_STAT for a detailed description of R_TX_EMPTY bit.
                ///  Reset value: 0x0
                R_TX_EMPTY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  R_TX_EMPTY interrupt is inactive
                        INACTIVE = 0x0,
                        ///  R_TX_EMPTY interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  See IC_RAW_INTR_STAT for a detailed description of R_RD_REQ bit.
                ///  Reset value: 0x0
                R_RD_REQ: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  R_RD_REQ interrupt is inactive
                        INACTIVE = 0x0,
                        ///  R_RD_REQ interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  See IC_RAW_INTR_STAT for a detailed description of R_TX_ABRT bit.
                ///  Reset value: 0x0
                R_TX_ABRT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  R_TX_ABRT interrupt is inactive
                        INACTIVE = 0x0,
                        ///  R_TX_ABRT interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  See IC_RAW_INTR_STAT for a detailed description of R_RX_DONE bit.
                ///  Reset value: 0x0
                R_RX_DONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  R_RX_DONE interrupt is inactive
                        INACTIVE = 0x0,
                        ///  R_RX_DONE interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  See IC_RAW_INTR_STAT for a detailed description of R_ACTIVITY bit.
                ///  Reset value: 0x0
                R_ACTIVITY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  R_ACTIVITY interrupt is inactive
                        INACTIVE = 0x0,
                        ///  R_ACTIVITY interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  See IC_RAW_INTR_STAT for a detailed description of R_STOP_DET bit.
                ///  Reset value: 0x0
                R_STOP_DET: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  R_STOP_DET interrupt is inactive
                        INACTIVE = 0x0,
                        ///  R_STOP_DET interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  See IC_RAW_INTR_STAT for a detailed description of R_START_DET bit.
                ///  Reset value: 0x0
                R_START_DET: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  R_START_DET interrupt is inactive
                        INACTIVE = 0x0,
                        ///  R_START_DET interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  See IC_RAW_INTR_STAT for a detailed description of R_GEN_CALL bit.
                ///  Reset value: 0x0
                R_GEN_CALL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  R_GEN_CALL interrupt is inactive
                        INACTIVE = 0x0,
                        ///  R_GEN_CALL interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  See IC_RAW_INTR_STAT for a detailed description of R_RESTART_DET bit.
                ///  Reset value: 0x0
                R_RESTART_DET: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  R_RESTART_DET interrupt is inactive
                        INACTIVE = 0x0,
                        ///  R_RESTART_DET interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                padding: u19,
            }),
            ///  I2C Interrupt Mask Register.
            ///  These bits mask their corresponding interrupt status bits. This register is active low; a value of 0 masks the interrupt, whereas a value of 1 unmasks the interrupt.
            IC_INTR_MASK: mmio.Mmio(packed struct(u32) {
                ///  This bit masks the R_RX_UNDER interrupt in IC_INTR_STAT register.
                ///  Reset value: 0x1
                M_RX_UNDER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RX_UNDER interrupt is masked
                        ENABLED = 0x0,
                        ///  RX_UNDER interrupt is unmasked
                        DISABLED = 0x1,
                    },
                },
                ///  This bit masks the R_RX_OVER interrupt in IC_INTR_STAT register.
                ///  Reset value: 0x1
                M_RX_OVER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RX_OVER interrupt is masked
                        ENABLED = 0x0,
                        ///  RX_OVER interrupt is unmasked
                        DISABLED = 0x1,
                    },
                },
                ///  This bit masks the R_RX_FULL interrupt in IC_INTR_STAT register.
                ///  Reset value: 0x1
                M_RX_FULL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RX_FULL interrupt is masked
                        ENABLED = 0x0,
                        ///  RX_FULL interrupt is unmasked
                        DISABLED = 0x1,
                    },
                },
                ///  This bit masks the R_TX_OVER interrupt in IC_INTR_STAT register.
                ///  Reset value: 0x1
                M_TX_OVER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  TX_OVER interrupt is masked
                        ENABLED = 0x0,
                        ///  TX_OVER interrupt is unmasked
                        DISABLED = 0x1,
                    },
                },
                ///  This bit masks the R_TX_EMPTY interrupt in IC_INTR_STAT register.
                ///  Reset value: 0x1
                M_TX_EMPTY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  TX_EMPTY interrupt is masked
                        ENABLED = 0x0,
                        ///  TX_EMPTY interrupt is unmasked
                        DISABLED = 0x1,
                    },
                },
                ///  This bit masks the R_RD_REQ interrupt in IC_INTR_STAT register.
                ///  Reset value: 0x1
                M_RD_REQ: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RD_REQ interrupt is masked
                        ENABLED = 0x0,
                        ///  RD_REQ interrupt is unmasked
                        DISABLED = 0x1,
                    },
                },
                ///  This bit masks the R_TX_ABRT interrupt in IC_INTR_STAT register.
                ///  Reset value: 0x1
                M_TX_ABRT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  TX_ABORT interrupt is masked
                        ENABLED = 0x0,
                        ///  TX_ABORT interrupt is unmasked
                        DISABLED = 0x1,
                    },
                },
                ///  This bit masks the R_RX_DONE interrupt in IC_INTR_STAT register.
                ///  Reset value: 0x1
                M_RX_DONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RX_DONE interrupt is masked
                        ENABLED = 0x0,
                        ///  RX_DONE interrupt is unmasked
                        DISABLED = 0x1,
                    },
                },
                ///  This bit masks the R_ACTIVITY interrupt in IC_INTR_STAT register.
                ///  Reset value: 0x0
                M_ACTIVITY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  ACTIVITY interrupt is masked
                        ENABLED = 0x0,
                        ///  ACTIVITY interrupt is unmasked
                        DISABLED = 0x1,
                    },
                },
                ///  This bit masks the R_STOP_DET interrupt in IC_INTR_STAT register.
                ///  Reset value: 0x0
                M_STOP_DET: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  STOP_DET interrupt is masked
                        ENABLED = 0x0,
                        ///  STOP_DET interrupt is unmasked
                        DISABLED = 0x1,
                    },
                },
                ///  This bit masks the R_START_DET interrupt in IC_INTR_STAT register.
                ///  Reset value: 0x0
                M_START_DET: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  START_DET interrupt is masked
                        ENABLED = 0x0,
                        ///  START_DET interrupt is unmasked
                        DISABLED = 0x1,
                    },
                },
                ///  This bit masks the R_GEN_CALL interrupt in IC_INTR_STAT register.
                ///  Reset value: 0x1
                M_GEN_CALL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  GEN_CALL interrupt is masked
                        ENABLED = 0x0,
                        ///  GEN_CALL interrupt is unmasked
                        DISABLED = 0x1,
                    },
                },
                ///  This bit masks the R_RESTART_DET interrupt in IC_INTR_STAT register.
                ///  Reset value: 0x0
                M_RESTART_DET: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RESTART_DET interrupt is masked
                        ENABLED = 0x0,
                        ///  RESTART_DET interrupt is unmasked
                        DISABLED = 0x1,
                    },
                },
                padding: u19,
            }),
            ///  I2C Raw Interrupt Status Register
            ///  Unlike the IC_INTR_STAT register, these bits are not masked so they always show the true status of the DW_apb_i2c.
            IC_RAW_INTR_STAT: mmio.Mmio(packed struct(u32) {
                ///  Set if the processor attempts to read the receive buffer when it is empty by reading from the IC_DATA_CMD register. If the module is disabled (IC_ENABLE[0]=0), this bit keeps its level until the master or slave state machines go into idle, and when ic_en goes to 0, this interrupt is cleared.
                ///  Reset value: 0x0
                RX_UNDER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RX_UNDER interrupt is inactive
                        INACTIVE = 0x0,
                        ///  RX_UNDER interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  Set if the receive buffer is completely filled to IC_RX_BUFFER_DEPTH and an additional byte is received from an external I2C device. The DW_apb_i2c acknowledges this, but any data bytes received after the FIFO is full are lost. If the module is disabled (IC_ENABLE[0]=0), this bit keeps its level until the master or slave state machines go into idle, and when ic_en goes to 0, this interrupt is cleared.
                ///  Note: If bit 9 of the IC_CON register (RX_FIFO_FULL_HLD_CTRL) is programmed to HIGH, then the RX_OVER interrupt never occurs, because the Rx FIFO never overflows.
                ///  Reset value: 0x0
                RX_OVER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RX_OVER interrupt is inactive
                        INACTIVE = 0x0,
                        ///  RX_OVER interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  Set when the receive buffer reaches or goes above the RX_TL threshold in the IC_RX_TL register. It is automatically cleared by hardware when buffer level goes below the threshold. If the module is disabled (IC_ENABLE[0]=0), the RX FIFO is flushed and held in reset; therefore the RX FIFO is not full. So this bit is cleared once the IC_ENABLE bit 0 is programmed with a 0, regardless of the activity that continues.
                ///  Reset value: 0x0
                RX_FULL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RX_FULL interrupt is inactive
                        INACTIVE = 0x0,
                        ///  RX_FULL interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  Set during transmit if the transmit buffer is filled to IC_TX_BUFFER_DEPTH and the processor attempts to issue another I2C command by writing to the IC_DATA_CMD register. When the module is disabled, this bit keeps its level until the master or slave state machines go into idle, and when ic_en goes to 0, this interrupt is cleared.
                ///  Reset value: 0x0
                TX_OVER: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  TX_OVER interrupt is inactive
                        INACTIVE = 0x0,
                        ///  TX_OVER interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  The behavior of the TX_EMPTY interrupt status differs based on the TX_EMPTY_CTRL selection in the IC_CON register. - When TX_EMPTY_CTRL = 0: This bit is set to 1 when the transmit buffer is at or below the threshold value set in the IC_TX_TL register. - When TX_EMPTY_CTRL = 1: This bit is set to 1 when the transmit buffer is at or below the threshold value set in the IC_TX_TL register and the transmission of the address/data from the internal shift register for the most recently popped command is completed. It is automatically cleared by hardware when the buffer level goes above the threshold. When IC_ENABLE[0] is set to 0, the TX FIFO is flushed and held in reset. There the TX FIFO looks like it has no data within it, so this bit is set to 1, provided there is activity in the master or slave state machines. When there is no longer any activity, then with ic_en=0, this bit is set to 0.
                ///  Reset value: 0x0.
                TX_EMPTY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  TX_EMPTY interrupt is inactive
                        INACTIVE = 0x0,
                        ///  TX_EMPTY interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  This bit is set to 1 when DW_apb_i2c is acting as a slave and another I2C master is attempting to read data from DW_apb_i2c. The DW_apb_i2c holds the I2C bus in a wait state (SCL=0) until this interrupt is serviced, which means that the slave has been addressed by a remote master that is asking for data to be transferred. The processor must respond to this interrupt and then write the requested data to the IC_DATA_CMD register. This bit is set to 0 just after the processor reads the IC_CLR_RD_REQ register.
                ///  Reset value: 0x0
                RD_REQ: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RD_REQ interrupt is inactive
                        INACTIVE = 0x0,
                        ///  RD_REQ interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  This bit indicates if DW_apb_i2c, as an I2C transmitter, is unable to complete the intended actions on the contents of the transmit FIFO. This situation can occur both as an I2C master or an I2C slave, and is referred to as a 'transmit abort'. When this bit is set to 1, the IC_TX_ABRT_SOURCE register indicates the reason why the transmit abort takes places.
                ///  Note: The DW_apb_i2c flushes/resets/empties the TX_FIFO and RX_FIFO whenever there is a transmit abort caused by any of the events tracked by the IC_TX_ABRT_SOURCE register. The FIFOs remains in this flushed state until the register IC_CLR_TX_ABRT is read. Once this read is performed, the Tx FIFO is then ready to accept more data bytes from the APB interface.
                ///  Reset value: 0x0
                TX_ABRT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  TX_ABRT interrupt is inactive
                        INACTIVE = 0x0,
                        ///  TX_ABRT interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  When the DW_apb_i2c is acting as a slave-transmitter, this bit is set to 1 if the master does not acknowledge a transmitted byte. This occurs on the last byte of the transmission, indicating that the transmission is done.
                ///  Reset value: 0x0
                RX_DONE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RX_DONE interrupt is inactive
                        INACTIVE = 0x0,
                        ///  RX_DONE interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  This bit captures DW_apb_i2c activity and stays set until it is cleared. There are four ways to clear it: - Disabling the DW_apb_i2c - Reading the IC_CLR_ACTIVITY register - Reading the IC_CLR_INTR register - System reset Once this bit is set, it stays set unless one of the four methods is used to clear it. Even if the DW_apb_i2c module is idle, this bit remains set until cleared, indicating that there was activity on the bus.
                ///  Reset value: 0x0
                ACTIVITY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RAW_INTR_ACTIVITY interrupt is inactive
                        INACTIVE = 0x0,
                        ///  RAW_INTR_ACTIVITY interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  Indicates whether a STOP condition has occurred on the I2C interface regardless of whether DW_apb_i2c is operating in slave or master mode.
                ///  In Slave Mode: - If IC_CON[7]=1'b1 (STOP_DET_IFADDRESSED), the STOP_DET interrupt will be issued only if slave is addressed. Note: During a general call address, this slave does not issue a STOP_DET interrupt if STOP_DET_IF_ADDRESSED=1'b1, even if the slave responds to the general call address by generating ACK. The STOP_DET interrupt is generated only when the transmitted address matches the slave address (SAR). - If IC_CON[7]=1'b0 (STOP_DET_IFADDRESSED), the STOP_DET interrupt is issued irrespective of whether it is being addressed. In Master Mode: - If IC_CON[10]=1'b1 (STOP_DET_IF_MASTER_ACTIVE),the STOP_DET interrupt will be issued only if Master is active. - If IC_CON[10]=1'b0 (STOP_DET_IFADDRESSED),the STOP_DET interrupt will be issued irrespective of whether master is active or not. Reset value: 0x0
                STOP_DET: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  STOP_DET interrupt is inactive
                        INACTIVE = 0x0,
                        ///  STOP_DET interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  Indicates whether a START or RESTART condition has occurred on the I2C interface regardless of whether DW_apb_i2c is operating in slave or master mode.
                ///  Reset value: 0x0
                START_DET: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  START_DET interrupt is inactive
                        INACTIVE = 0x0,
                        ///  START_DET interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  Set only when a General Call address is received and it is acknowledged. It stays set until it is cleared either by disabling DW_apb_i2c or when the CPU reads bit 0 of the IC_CLR_GEN_CALL register. DW_apb_i2c stores the received data in the Rx buffer.
                ///  Reset value: 0x0
                GEN_CALL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  GEN_CALL interrupt is inactive
                        INACTIVE = 0x0,
                        ///  GEN_CALL interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                ///  Indicates whether a RESTART condition has occurred on the I2C interface when DW_apb_i2c is operating in Slave mode and the slave is being addressed. Enabled only when IC_SLV_RESTART_DET_EN=1.
                ///  Note: However, in high-speed mode or during a START BYTE transfer, the RESTART comes before the address field as per the I2C protocol. In this case, the slave is not the addressed slave when the RESTART is issued, therefore DW_apb_i2c does not generate the RESTART_DET interrupt.
                ///  Reset value: 0x0
                RESTART_DET: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  RESTART_DET interrupt is inactive
                        INACTIVE = 0x0,
                        ///  RESTART_DET interrupt is active
                        ACTIVE = 0x1,
                    },
                },
                padding: u19,
            }),
            ///  I2C Receive FIFO Threshold Register
            IC_RX_TL: mmio.Mmio(packed struct(u32) {
                ///  Receive FIFO Threshold Level.
                ///  Controls the level of entries (or above) that triggers the RX_FULL interrupt (bit 2 in IC_RAW_INTR_STAT register). The valid range is 0-255, with the additional restriction that hardware does not allow this value to be set to a value larger than the depth of the buffer. If an attempt is made to do that, the actual value set will be the maximum depth of the buffer. A value of 0 sets the threshold for 1 entry, and a value of 255 sets the threshold for 256 entries.
                RX_TL: u8,
                padding: u24,
            }),
            ///  I2C Transmit FIFO Threshold Register
            IC_TX_TL: mmio.Mmio(packed struct(u32) {
                ///  Transmit FIFO Threshold Level.
                ///  Controls the level of entries (or below) that trigger the TX_EMPTY interrupt (bit 4 in IC_RAW_INTR_STAT register). The valid range is 0-255, with the additional restriction that it may not be set to value larger than the depth of the buffer. If an attempt is made to do that, the actual value set will be the maximum depth of the buffer. A value of 0 sets the threshold for 0 entries, and a value of 255 sets the threshold for 255 entries.
                TX_TL: u8,
                padding: u24,
            }),
            ///  Clear Combined and Individual Interrupt Register
            IC_CLR_INTR: mmio.Mmio(packed struct(u32) {
                ///  Read this register to clear the combined interrupt, all individual interrupts, and the IC_TX_ABRT_SOURCE register. This bit does not clear hardware clearable interrupts but software clearable interrupts. Refer to Bit 9 of the IC_TX_ABRT_SOURCE register for an exception to clearing IC_TX_ABRT_SOURCE.
                ///  Reset value: 0x0
                CLR_INTR: u1,
                padding: u31,
            }),
            ///  Clear RX_UNDER Interrupt Register
            IC_CLR_RX_UNDER: mmio.Mmio(packed struct(u32) {
                ///  Read this register to clear the RX_UNDER interrupt (bit 0) of the IC_RAW_INTR_STAT register.
                ///  Reset value: 0x0
                CLR_RX_UNDER: u1,
                padding: u31,
            }),
            ///  Clear RX_OVER Interrupt Register
            IC_CLR_RX_OVER: mmio.Mmio(packed struct(u32) {
                ///  Read this register to clear the RX_OVER interrupt (bit 1) of the IC_RAW_INTR_STAT register.
                ///  Reset value: 0x0
                CLR_RX_OVER: u1,
                padding: u31,
            }),
            ///  Clear TX_OVER Interrupt Register
            IC_CLR_TX_OVER: mmio.Mmio(packed struct(u32) {
                ///  Read this register to clear the TX_OVER interrupt (bit 3) of the IC_RAW_INTR_STAT register.
                ///  Reset value: 0x0
                CLR_TX_OVER: u1,
                padding: u31,
            }),
            ///  Clear RD_REQ Interrupt Register
            IC_CLR_RD_REQ: mmio.Mmio(packed struct(u32) {
                ///  Read this register to clear the RD_REQ interrupt (bit 5) of the IC_RAW_INTR_STAT register.
                ///  Reset value: 0x0
                CLR_RD_REQ: u1,
                padding: u31,
            }),
            ///  Clear TX_ABRT Interrupt Register
            IC_CLR_TX_ABRT: mmio.Mmio(packed struct(u32) {
                ///  Read this register to clear the TX_ABRT interrupt (bit 6) of the IC_RAW_INTR_STAT register, and the IC_TX_ABRT_SOURCE register. This also releases the TX FIFO from the flushed/reset state, allowing more writes to the TX FIFO. Refer to Bit 9 of the IC_TX_ABRT_SOURCE register for an exception to clearing IC_TX_ABRT_SOURCE.
                ///  Reset value: 0x0
                CLR_TX_ABRT: u1,
                padding: u31,
            }),
            ///  Clear RX_DONE Interrupt Register
            IC_CLR_RX_DONE: mmio.Mmio(packed struct(u32) {
                ///  Read this register to clear the RX_DONE interrupt (bit 7) of the IC_RAW_INTR_STAT register.
                ///  Reset value: 0x0
                CLR_RX_DONE: u1,
                padding: u31,
            }),
            ///  Clear ACTIVITY Interrupt Register
            IC_CLR_ACTIVITY: mmio.Mmio(packed struct(u32) {
                ///  Reading this register clears the ACTIVITY interrupt if the I2C is not active anymore. If the I2C module is still active on the bus, the ACTIVITY interrupt bit continues to be set. It is automatically cleared by hardware if the module is disabled and if there is no further activity on the bus. The value read from this register to get status of the ACTIVITY interrupt (bit 8) of the IC_RAW_INTR_STAT register.
                ///  Reset value: 0x0
                CLR_ACTIVITY: u1,
                padding: u31,
            }),
            ///  Clear STOP_DET Interrupt Register
            IC_CLR_STOP_DET: mmio.Mmio(packed struct(u32) {
                ///  Read this register to clear the STOP_DET interrupt (bit 9) of the IC_RAW_INTR_STAT register.
                ///  Reset value: 0x0
                CLR_STOP_DET: u1,
                padding: u31,
            }),
            ///  Clear START_DET Interrupt Register
            IC_CLR_START_DET: mmio.Mmio(packed struct(u32) {
                ///  Read this register to clear the START_DET interrupt (bit 10) of the IC_RAW_INTR_STAT register.
                ///  Reset value: 0x0
                CLR_START_DET: u1,
                padding: u31,
            }),
            ///  Clear GEN_CALL Interrupt Register
            IC_CLR_GEN_CALL: mmio.Mmio(packed struct(u32) {
                ///  Read this register to clear the GEN_CALL interrupt (bit 11) of IC_RAW_INTR_STAT register.
                ///  Reset value: 0x0
                CLR_GEN_CALL: u1,
                padding: u31,
            }),
            ///  I2C Enable Register
            IC_ENABLE: mmio.Mmio(packed struct(u32) {
                ///  Controls whether the DW_apb_i2c is enabled. - 0: Disables DW_apb_i2c (TX and RX FIFOs are held in an erased state) - 1: Enables DW_apb_i2c Software can disable DW_apb_i2c while it is active. However, it is important that care be taken to ensure that DW_apb_i2c is disabled properly. A recommended procedure is described in 'Disabling DW_apb_i2c'.
                ///  When DW_apb_i2c is disabled, the following occurs: - The TX FIFO and RX FIFO get flushed. - Status bits in the IC_INTR_STAT register are still active until DW_apb_i2c goes into IDLE state. If the module is transmitting, it stops as well as deletes the contents of the transmit buffer after the current transfer is complete. If the module is receiving, the DW_apb_i2c stops the current transfer at the end of the current byte and does not acknowledge the transfer.
                ///  In systems with asynchronous pclk and ic_clk when IC_CLK_TYPE parameter set to asynchronous (1), there is a two ic_clk delay when enabling or disabling the DW_apb_i2c. For a detailed description on how to disable DW_apb_i2c, refer to 'Disabling DW_apb_i2c'
                ///  Reset value: 0x0
                ENABLE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  I2C is disabled
                        DISABLED = 0x0,
                        ///  I2C is enabled
                        ENABLED = 0x1,
                    },
                },
                ///  When set, the controller initiates the transfer abort. - 0: ABORT not initiated or ABORT done - 1: ABORT operation in progress The software can abort the I2C transfer in master mode by setting this bit. The software can set this bit only when ENABLE is already set; otherwise, the controller ignores any write to ABORT bit. The software cannot clear the ABORT bit once set. In response to an ABORT, the controller issues a STOP and flushes the Tx FIFO after completing the current transfer, then sets the TX_ABORT interrupt after the abort operation. The ABORT bit is cleared automatically after the abort operation.
                ///  For a detailed description on how to abort I2C transfers, refer to 'Aborting I2C Transfers'.
                ///  Reset value: 0x0
                ABORT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  ABORT operation not in progress
                        DISABLE = 0x0,
                        ///  ABORT operation in progress
                        ENABLED = 0x1,
                    },
                },
                ///  In Master mode: - 1'b1: Blocks the transmission of data on I2C bus even if Tx FIFO has data to transmit. - 1'b0: The transmission of data starts on I2C bus automatically, as soon as the first data is available in the Tx FIFO. Note: To block the execution of Master commands, set the TX_CMD_BLOCK bit only when Tx FIFO is empty (IC_STATUS[2]==1) and Master is in Idle state (IC_STATUS[5] == 0). Any further commands put in the Tx FIFO are not executed until TX_CMD_BLOCK bit is unset. Reset value: IC_TX_CMD_BLOCK_DEFAULT
                TX_CMD_BLOCK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Tx Command execution not blocked
                        NOT_BLOCKED = 0x0,
                        ///  Tx Command execution blocked
                        BLOCKED = 0x1,
                    },
                },
                padding: u29,
            }),
            ///  I2C Status Register
            ///  This is a read-only register used to indicate the current transfer status and FIFO status. The status register may be read at any time. None of the bits in this register request an interrupt.
            ///  When the I2C is disabled by writing 0 in bit 0 of the IC_ENABLE register: - Bits 1 and 2 are set to 1 - Bits 3 and 10 are set to 0 When the master or slave state machines goes to idle and ic_en=0: - Bits 5 and 6 are set to 0
            IC_STATUS: mmio.Mmio(packed struct(u32) {
                ///  I2C Activity Status. Reset value: 0x0
                ACTIVITY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  I2C is idle
                        INACTIVE = 0x0,
                        ///  I2C is active
                        ACTIVE = 0x1,
                    },
                },
                ///  Transmit FIFO Not Full. Set when the transmit FIFO contains one or more empty locations, and is cleared when the FIFO is full. - 0: Transmit FIFO is full - 1: Transmit FIFO is not full Reset value: 0x1
                TFNF: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Tx FIFO is full
                        FULL = 0x0,
                        ///  Tx FIFO not full
                        NOT_FULL = 0x1,
                    },
                },
                ///  Transmit FIFO Completely Empty. When the transmit FIFO is completely empty, this bit is set. When it contains one or more valid entries, this bit is cleared. This bit field does not request an interrupt. - 0: Transmit FIFO is not empty - 1: Transmit FIFO is empty Reset value: 0x1
                TFE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Tx FIFO not empty
                        NON_EMPTY = 0x0,
                        ///  Tx FIFO is empty
                        EMPTY = 0x1,
                    },
                },
                ///  Receive FIFO Not Empty. This bit is set when the receive FIFO contains one or more entries; it is cleared when the receive FIFO is empty. - 0: Receive FIFO is empty - 1: Receive FIFO is not empty Reset value: 0x0
                RFNE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Rx FIFO is empty
                        EMPTY = 0x0,
                        ///  Rx FIFO not empty
                        NOT_EMPTY = 0x1,
                    },
                },
                ///  Receive FIFO Completely Full. When the receive FIFO is completely full, this bit is set. When the receive FIFO contains one or more empty location, this bit is cleared. - 0: Receive FIFO is not full - 1: Receive FIFO is full Reset value: 0x0
                RFF: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Rx FIFO not full
                        NOT_FULL = 0x0,
                        ///  Rx FIFO is full
                        FULL = 0x1,
                    },
                },
                ///  Master FSM Activity Status. When the Master Finite State Machine (FSM) is not in the IDLE state, this bit is set. - 0: Master FSM is in IDLE state so the Master part of DW_apb_i2c is not Active - 1: Master FSM is not in IDLE state so the Master part of DW_apb_i2c is Active Note: IC_STATUS[0]-that is, ACTIVITY bit-is the OR of SLV_ACTIVITY and MST_ACTIVITY bits.
                ///  Reset value: 0x0
                MST_ACTIVITY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Master is idle
                        IDLE = 0x0,
                        ///  Master not idle
                        ACTIVE = 0x1,
                    },
                },
                ///  Slave FSM Activity Status. When the Slave Finite State Machine (FSM) is not in the IDLE state, this bit is set. - 0: Slave FSM is in IDLE state so the Slave part of DW_apb_i2c is not Active - 1: Slave FSM is not in IDLE state so the Slave part of DW_apb_i2c is Active Reset value: 0x0
                SLV_ACTIVITY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Slave is idle
                        IDLE = 0x0,
                        ///  Slave not idle
                        ACTIVE = 0x1,
                    },
                },
                padding: u25,
            }),
            ///  I2C Transmit FIFO Level Register This register contains the number of valid data entries in the transmit FIFO buffer. It is cleared whenever: - The I2C is disabled - There is a transmit abort - that is, TX_ABRT bit is set in the IC_RAW_INTR_STAT register - The slave bulk transmit mode is aborted The register increments whenever data is placed into the transmit FIFO and decrements when data is taken from the transmit FIFO.
            IC_TXFLR: mmio.Mmio(packed struct(u32) {
                ///  Transmit FIFO Level. Contains the number of valid data entries in the transmit FIFO.
                ///  Reset value: 0x0
                TXFLR: u5,
                padding: u27,
            }),
            ///  I2C Receive FIFO Level Register This register contains the number of valid data entries in the receive FIFO buffer. It is cleared whenever: - The I2C is disabled - Whenever there is a transmit abort caused by any of the events tracked in IC_TX_ABRT_SOURCE The register increments whenever data is placed into the receive FIFO and decrements when data is taken from the receive FIFO.
            IC_RXFLR: mmio.Mmio(packed struct(u32) {
                ///  Receive FIFO Level. Contains the number of valid data entries in the receive FIFO.
                ///  Reset value: 0x0
                RXFLR: u5,
                padding: u27,
            }),
            ///  I2C SDA Hold Time Length Register
            ///  The bits [15:0] of this register are used to control the hold time of SDA during transmit in both slave and master mode (after SCL goes from HIGH to LOW).
            ///  The bits [23:16] of this register are used to extend the SDA transition (if any) whenever SCL is HIGH in the receiver in either master or slave mode.
            ///  Writes to this register succeed only when IC_ENABLE[0]=0.
            ///  The values in this register are in units of ic_clk period. The value programmed in IC_SDA_TX_HOLD must be greater than the minimum hold time in each mode (one cycle in master mode, seven cycles in slave mode) for the value to be implemented.
            ///  The programmed SDA hold time during transmit (IC_SDA_TX_HOLD) cannot exceed at any time the duration of the low part of scl. Therefore the programmed value cannot be larger than N_SCL_LOW-2, where N_SCL_LOW is the duration of the low part of the scl period measured in ic_clk cycles.
            IC_SDA_HOLD: mmio.Mmio(packed struct(u32) {
                ///  Sets the required SDA hold time in units of ic_clk period, when DW_apb_i2c acts as a transmitter.
                ///  Reset value: IC_DEFAULT_SDA_HOLD[15:0].
                IC_SDA_TX_HOLD: u16,
                ///  Sets the required SDA hold time in units of ic_clk period, when DW_apb_i2c acts as a receiver.
                ///  Reset value: IC_DEFAULT_SDA_HOLD[23:16].
                IC_SDA_RX_HOLD: u8,
                padding: u8,
            }),
            ///  I2C Transmit Abort Source Register
            ///  This register has 32 bits that indicate the source of the TX_ABRT bit. Except for Bit 9, this register is cleared whenever the IC_CLR_TX_ABRT register or the IC_CLR_INTR register is read. To clear Bit 9, the source of the ABRT_SBYTE_NORSTRT must be fixed first; RESTART must be enabled (IC_CON[5]=1), the SPECIAL bit must be cleared (IC_TAR[11]), or the GC_OR_START bit must be cleared (IC_TAR[10]).
            ///  Once the source of the ABRT_SBYTE_NORSTRT is fixed, then this bit can be cleared in the same manner as other bits in this register. If the source of the ABRT_SBYTE_NORSTRT is not fixed before attempting to clear this bit, Bit 9 clears for one cycle and is then re-asserted.
            IC_TX_ABRT_SOURCE: mmio.Mmio(packed struct(u32) {
                ///  This field indicates that the Master is in 7-bit addressing mode and the address sent was not acknowledged by any slave.
                ///  Reset value: 0x0
                ///  Role of DW_apb_i2c: Master-Transmitter or Master-Receiver
                ABRT_7B_ADDR_NOACK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  This abort is not generated
                        INACTIVE = 0x0,
                        ///  This abort is generated because of NOACK for 7-bit address
                        ACTIVE = 0x1,
                    },
                },
                ///  This field indicates that the Master is in 10-bit address mode and the first 10-bit address byte was not acknowledged by any slave.
                ///  Reset value: 0x0
                ///  Role of DW_apb_i2c: Master-Transmitter or Master-Receiver
                ABRT_10ADDR1_NOACK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  This abort is not generated
                        INACTIVE = 0x0,
                        ///  Byte 1 of 10Bit Address not ACKed by any slave
                        ACTIVE = 0x1,
                    },
                },
                ///  This field indicates that the Master is in 10-bit address mode and that the second address byte of the 10-bit address was not acknowledged by any slave.
                ///  Reset value: 0x0
                ///  Role of DW_apb_i2c: Master-Transmitter or Master-Receiver
                ABRT_10ADDR2_NOACK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  This abort is not generated
                        INACTIVE = 0x0,
                        ///  Byte 2 of 10Bit Address not ACKed by any slave
                        ACTIVE = 0x1,
                    },
                },
                ///  This field indicates the master-mode only bit. When the master receives an acknowledgement for the address, but when it sends data byte(s) following the address, it did not receive an acknowledge from the remote slave(s).
                ///  Reset value: 0x0
                ///  Role of DW_apb_i2c: Master-Transmitter
                ABRT_TXDATA_NOACK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Transmitted data non-ACKed by addressed slave-scenario not present
                        ABRT_TXDATA_NOACK_VOID = 0x0,
                        ///  Transmitted data not ACKed by addressed slave
                        ABRT_TXDATA_NOACK_GENERATED = 0x1,
                    },
                },
                ///  This field indicates that DW_apb_i2c in master mode has sent a General Call and no slave on the bus acknowledged the General Call.
                ///  Reset value: 0x0
                ///  Role of DW_apb_i2c: Master-Transmitter
                ABRT_GCALL_NOACK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  GCALL not ACKed by any slave-scenario not present
                        ABRT_GCALL_NOACK_VOID = 0x0,
                        ///  GCALL not ACKed by any slave
                        ABRT_GCALL_NOACK_GENERATED = 0x1,
                    },
                },
                ///  This field indicates that DW_apb_i2c in the master mode has sent a General Call but the user programmed the byte following the General Call to be a read from the bus (IC_DATA_CMD[9] is set to 1).
                ///  Reset value: 0x0
                ///  Role of DW_apb_i2c: Master-Transmitter
                ABRT_GCALL_READ: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  GCALL is followed by read from bus-scenario not present
                        ABRT_GCALL_READ_VOID = 0x0,
                        ///  GCALL is followed by read from bus
                        ABRT_GCALL_READ_GENERATED = 0x1,
                    },
                },
                ///  This field indicates that the Master is in High Speed mode and the High Speed Master code was acknowledged (wrong behavior).
                ///  Reset value: 0x0
                ///  Role of DW_apb_i2c: Master
                ABRT_HS_ACKDET: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  HS Master code ACKed in HS Mode- scenario not present
                        ABRT_HS_ACK_VOID = 0x0,
                        ///  HS Master code ACKed in HS Mode
                        ABRT_HS_ACK_GENERATED = 0x1,
                    },
                },
                ///  This field indicates that the Master has sent a START Byte and the START Byte was acknowledged (wrong behavior).
                ///  Reset value: 0x0
                ///  Role of DW_apb_i2c: Master
                ABRT_SBYTE_ACKDET: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  ACK detected for START byte- scenario not present
                        ABRT_SBYTE_ACKDET_VOID = 0x0,
                        ///  ACK detected for START byte
                        ABRT_SBYTE_ACKDET_GENERATED = 0x1,
                    },
                },
                ///  This field indicates that the restart is disabled (IC_RESTART_EN bit (IC_CON[5]) =0) and the user is trying to use the master to transfer data in High Speed mode.
                ///  Reset value: 0x0
                ///  Role of DW_apb_i2c: Master-Transmitter or Master-Receiver
                ABRT_HS_NORSTRT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  User trying to switch Master to HS mode when RESTART disabled- scenario not present
                        ABRT_HS_NORSTRT_VOID = 0x0,
                        ///  User trying to switch Master to HS mode when RESTART disabled
                        ABRT_HS_NORSTRT_GENERATED = 0x1,
                    },
                },
                ///  To clear Bit 9, the source of the ABRT_SBYTE_NORSTRT must be fixed first; restart must be enabled (IC_CON[5]=1), the SPECIAL bit must be cleared (IC_TAR[11]), or the GC_OR_START bit must be cleared (IC_TAR[10]). Once the source of the ABRT_SBYTE_NORSTRT is fixed, then this bit can be cleared in the same manner as other bits in this register. If the source of the ABRT_SBYTE_NORSTRT is not fixed before attempting to clear this bit, bit 9 clears for one cycle and then gets reasserted. When this field is set to 1, the restart is disabled (IC_RESTART_EN bit (IC_CON[5]) =0) and the user is trying to send a START Byte.
                ///  Reset value: 0x0
                ///  Role of DW_apb_i2c: Master
                ABRT_SBYTE_NORSTRT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  User trying to send START byte when RESTART disabled- scenario not present
                        ABRT_SBYTE_NORSTRT_VOID = 0x0,
                        ///  User trying to send START byte when RESTART disabled
                        ABRT_SBYTE_NORSTRT_GENERATED = 0x1,
                    },
                },
                ///  This field indicates that the restart is disabled (IC_RESTART_EN bit (IC_CON[5]) =0) and the master sends a read command in 10-bit addressing mode.
                ///  Reset value: 0x0
                ///  Role of DW_apb_i2c: Master-Receiver
                ABRT_10B_RD_NORSTRT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Master not trying to read in 10Bit addressing mode when RESTART disabled
                        ABRT_10B_RD_VOID = 0x0,
                        ///  Master trying to read in 10Bit addressing mode when RESTART disabled
                        ABRT_10B_RD_GENERATED = 0x1,
                    },
                },
                ///  This field indicates that the User tries to initiate a Master operation with the Master mode disabled.
                ///  Reset value: 0x0
                ///  Role of DW_apb_i2c: Master-Transmitter or Master-Receiver
                ABRT_MASTER_DIS: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  User initiating master operation when MASTER disabled- scenario not present
                        ABRT_MASTER_DIS_VOID = 0x0,
                        ///  User initiating master operation when MASTER disabled
                        ABRT_MASTER_DIS_GENERATED = 0x1,
                    },
                },
                ///  This field specifies that the Master has lost arbitration, or if IC_TX_ABRT_SOURCE[14] is also set, then the slave transmitter has lost arbitration.
                ///  Reset value: 0x0
                ///  Role of DW_apb_i2c: Master-Transmitter or Slave-Transmitter
                ARB_LOST: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Master or Slave-Transmitter lost arbitration- scenario not present
                        ABRT_LOST_VOID = 0x0,
                        ///  Master or Slave-Transmitter lost arbitration
                        ABRT_LOST_GENERATED = 0x1,
                    },
                },
                ///  This field specifies that the Slave has received a read command and some data exists in the TX FIFO, so the slave issues a TX_ABRT interrupt to flush old data in TX FIFO.
                ///  Reset value: 0x0
                ///  Role of DW_apb_i2c: Slave-Transmitter
                ABRT_SLVFLUSH_TXFIFO: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Slave flushes existing data in TX-FIFO upon getting read command- scenario not present
                        ABRT_SLVFLUSH_TXFIFO_VOID = 0x0,
                        ///  Slave flushes existing data in TX-FIFO upon getting read command
                        ABRT_SLVFLUSH_TXFIFO_GENERATED = 0x1,
                    },
                },
                ///  This field indicates that a Slave has lost the bus while transmitting data to a remote master. IC_TX_ABRT_SOURCE[12] is set at the same time. Note: Even though the slave never 'owns' the bus, something could go wrong on the bus. This is a fail safe check. For instance, during a data transmission at the low-to-high transition of SCL, if what is on the data bus is not what is supposed to be transmitted, then DW_apb_i2c no longer own the bus.
                ///  Reset value: 0x0
                ///  Role of DW_apb_i2c: Slave-Transmitter
                ABRT_SLV_ARBLOST: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Slave lost arbitration to remote master- scenario not present
                        ABRT_SLV_ARBLOST_VOID = 0x0,
                        ///  Slave lost arbitration to remote master
                        ABRT_SLV_ARBLOST_GENERATED = 0x1,
                    },
                },
                ///  1: When the processor side responds to a slave mode request for data to be transmitted to a remote master and user writes a 1 in CMD (bit 8) of IC_DATA_CMD register.
                ///  Reset value: 0x0
                ///  Role of DW_apb_i2c: Slave-Transmitter
                ABRT_SLVRD_INTX: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Slave trying to transmit to remote master in read mode- scenario not present
                        ABRT_SLVRD_INTX_VOID = 0x0,
                        ///  Slave trying to transmit to remote master in read mode
                        ABRT_SLVRD_INTX_GENERATED = 0x1,
                    },
                },
                ///  This is a master-mode-only bit. Master has detected the transfer abort (IC_ENABLE[1])
                ///  Reset value: 0x0
                ///  Role of DW_apb_i2c: Master-Transmitter
                ABRT_USER_ABRT: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Transfer abort detected by master- scenario not present
                        ABRT_USER_ABRT_VOID = 0x0,
                        ///  Transfer abort detected by master
                        ABRT_USER_ABRT_GENERATED = 0x1,
                    },
                },
                reserved23: u6,
                ///  This field indicates the number of Tx FIFO Data Commands which are flushed due to TX_ABRT interrupt. It is cleared whenever I2C is disabled.
                ///  Reset value: 0x0
                ///  Role of DW_apb_i2c: Master-Transmitter or Slave-Transmitter
                TX_FLUSH_CNT: u9,
            }),
            ///  Generate Slave Data NACK Register
            ///  The register is used to generate a NACK for the data part of a transfer when DW_apb_i2c is acting as a slave-receiver. This register only exists when the IC_SLV_DATA_NACK_ONLY parameter is set to 1. When this parameter disabled, this register does not exist and writing to the register's address has no effect.
            ///  A write can occur on this register if both of the following conditions are met: - DW_apb_i2c is disabled (IC_ENABLE[0] = 0) - Slave part is inactive (IC_STATUS[6] = 0) Note: The IC_STATUS[6] is a register read-back location for the internal slv_activity signal; the user should poll this before writing the ic_slv_data_nack_only bit.
            IC_SLV_DATA_NACK_ONLY: mmio.Mmio(packed struct(u32) {
                ///  Generate NACK. This NACK generation only occurs when DW_apb_i2c is a slave-receiver. If this register is set to a value of 1, it can only generate a NACK after a data byte is received; hence, the data transfer is aborted and the data received is not pushed to the receive buffer.
                ///  When the register is set to a value of 0, it generates NACK/ACK, depending on normal criteria. - 1: generate NACK after data byte received - 0: generate NACK/ACK normally Reset value: 0x0
                NACK: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Slave receiver generates NACK normally
                        DISABLED = 0x0,
                        ///  Slave receiver generates NACK upon data reception only
                        ENABLED = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  DMA Control Register
            ///  The register is used to enable the DMA Controller interface operation. There is a separate bit for transmit and receive. This can be programmed regardless of the state of IC_ENABLE.
            IC_DMA_CR: mmio.Mmio(packed struct(u32) {
                ///  Receive DMA Enable. This bit enables/disables the receive FIFO DMA channel. Reset value: 0x0
                RDMAE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Receive FIFO DMA channel disabled
                        DISABLED = 0x0,
                        ///  Receive FIFO DMA channel enabled
                        ENABLED = 0x1,
                    },
                },
                ///  Transmit DMA Enable. This bit enables/disables the transmit FIFO DMA channel. Reset value: 0x0
                TDMAE: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  transmit FIFO DMA channel disabled
                        DISABLED = 0x0,
                        ///  Transmit FIFO DMA channel enabled
                        ENABLED = 0x1,
                    },
                },
                padding: u30,
            }),
            ///  DMA Transmit Data Level Register
            IC_DMA_TDLR: mmio.Mmio(packed struct(u32) {
                ///  Transmit Data Level. This bit field controls the level at which a DMA request is made by the transmit logic. It is equal to the watermark level; that is, the dma_tx_req signal is generated when the number of valid data entries in the transmit FIFO is equal to or below this field value, and TDMAE = 1.
                ///  Reset value: 0x0
                DMATDL: u4,
                padding: u28,
            }),
            ///  I2C Receive Data Level Register
            IC_DMA_RDLR: mmio.Mmio(packed struct(u32) {
                ///  Receive Data Level. This bit field controls the level at which a DMA request is made by the receive logic. The watermark level = DMARDL+1; that is, dma_rx_req is generated when the number of valid data entries in the receive FIFO is equal to or more than this field value + 1, and RDMAE =1. For instance, when DMARDL is 0, then dma_rx_req is asserted when 1 or more data entries are present in the receive FIFO.
                ///  Reset value: 0x0
                DMARDL: u4,
                padding: u28,
            }),
            ///  I2C SDA Setup Register
            ///  This register controls the amount of time delay (in terms of number of ic_clk clock periods) introduced in the rising edge of SCL - relative to SDA changing - when DW_apb_i2c services a read request in a slave-transmitter operation. The relevant I2C requirement is tSU:DAT (note 4) as detailed in the I2C Bus Specification. This register must be programmed with a value equal to or greater than 2.
            ///  Writes to this register succeed only when IC_ENABLE[0] = 0.
            ///  Note: The length of setup time is calculated using [(IC_SDA_SETUP - 1) * (ic_clk_period)], so if the user requires 10 ic_clk periods of setup time, they should program a value of 11. The IC_SDA_SETUP register is only used by the DW_apb_i2c when operating as a slave transmitter.
            IC_SDA_SETUP: mmio.Mmio(packed struct(u32) {
                ///  SDA Setup. It is recommended that if the required delay is 1000ns, then for an ic_clk frequency of 10 MHz, IC_SDA_SETUP should be programmed to a value of 11. IC_SDA_SETUP must be programmed with a minimum value of 2.
                SDA_SETUP: u8,
                padding: u24,
            }),
            ///  I2C ACK General Call Register
            ///  The register controls whether DW_apb_i2c responds with a ACK or NACK when it receives an I2C General Call address.
            ///  This register is applicable only when the DW_apb_i2c is in slave mode.
            IC_ACK_GENERAL_CALL: mmio.Mmio(packed struct(u32) {
                ///  ACK General Call. When set to 1, DW_apb_i2c responds with a ACK (by asserting ic_data_oe) when it receives a General Call. Otherwise, DW_apb_i2c responds with a NACK (by negating ic_data_oe).
                ACK_GEN_CALL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Generate NACK for a General Call
                        DISABLED = 0x0,
                        ///  Generate ACK for a General Call
                        ENABLED = 0x1,
                    },
                },
                padding: u31,
            }),
            ///  I2C Enable Status Register
            ///  The register is used to report the DW_apb_i2c hardware status when the IC_ENABLE[0] register is set from 1 to 0; that is, when DW_apb_i2c is disabled.
            ///  If IC_ENABLE[0] has been set to 1, bits 2:1 are forced to 0, and bit 0 is forced to 1.
            ///  If IC_ENABLE[0] has been set to 0, bits 2:1 is only be valid as soon as bit 0 is read as '0'.
            ///  Note: When IC_ENABLE[0] has been set to 0, a delay occurs for bit 0 to be read as 0 because disabling the DW_apb_i2c depends on I2C bus activities.
            IC_ENABLE_STATUS: mmio.Mmio(packed struct(u32) {
                ///  ic_en Status. This bit always reflects the value driven on the output port ic_en. - When read as 1, DW_apb_i2c is deemed to be in an enabled state. - When read as 0, DW_apb_i2c is deemed completely inactive. Note: The CPU can safely read this bit anytime. When this bit is read as 0, the CPU can safely read SLV_RX_DATA_LOST (bit 2) and SLV_DISABLED_WHILE_BUSY (bit 1).
                ///  Reset value: 0x0
                IC_EN: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  I2C disabled
                        DISABLED = 0x0,
                        ///  I2C enabled
                        ENABLED = 0x1,
                    },
                },
                ///  Slave Disabled While Busy (Transmit, Receive). This bit indicates if a potential or active Slave operation has been aborted due to the setting bit 0 of the IC_ENABLE register from 1 to 0. This bit is set when the CPU writes a 0 to the IC_ENABLE register while:
                ///  (a) DW_apb_i2c is receiving the address byte of the Slave-Transmitter operation from a remote master;
                ///  OR,
                ///  (b) address and data bytes of the Slave-Receiver operation from a remote master.
                ///  When read as 1, DW_apb_i2c is deemed to have forced a NACK during any part of an I2C transfer, irrespective of whether the I2C address matches the slave address set in DW_apb_i2c (IC_SAR register) OR if the transfer is completed before IC_ENABLE is set to 0 but has not taken effect.
                ///  Note: If the remote I2C master terminates the transfer with a STOP condition before the DW_apb_i2c has a chance to NACK a transfer, and IC_ENABLE[0] has been set to 0, then this bit will also be set to 1.
                ///  When read as 0, DW_apb_i2c is deemed to have been disabled when there is master activity, or when the I2C bus is idle.
                ///  Note: The CPU can safely read this bit when IC_EN (bit 0) is read as 0.
                ///  Reset value: 0x0
                SLV_DISABLED_WHILE_BUSY: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Slave is disabled when it is idle
                        INACTIVE = 0x0,
                        ///  Slave is disabled when it is active
                        ACTIVE = 0x1,
                    },
                },
                ///  Slave Received Data Lost. This bit indicates if a Slave-Receiver operation has been aborted with at least one data byte received from an I2C transfer due to the setting bit 0 of IC_ENABLE from 1 to 0. When read as 1, DW_apb_i2c is deemed to have been actively engaged in an aborted I2C transfer (with matching address) and the data phase of the I2C transfer has been entered, even though a data byte has been responded with a NACK.
                ///  Note: If the remote I2C master terminates the transfer with a STOP condition before the DW_apb_i2c has a chance to NACK a transfer, and IC_ENABLE[0] has been set to 0, then this bit is also set to 1.
                ///  When read as 0, DW_apb_i2c is deemed to have been disabled without being actively involved in the data phase of a Slave-Receiver transfer.
                ///  Note: The CPU can safely read this bit when IC_EN (bit 0) is read as 0.
                ///  Reset value: 0x0
                SLV_RX_DATA_LOST: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  Slave RX Data is not lost
                        INACTIVE = 0x0,
                        ///  Slave RX Data is lost
                        ACTIVE = 0x1,
                    },
                },
                padding: u29,
            }),
            ///  I2C SS, FS or FM+ spike suppression limit
            ///  This register is used to store the duration, measured in ic_clk cycles, of the longest spike that is filtered out by the spike suppression logic when the component is operating in SS, FS or FM+ modes. The relevant I2C requirement is tSP (table 4) as detailed in the I2C Bus Specification. This register must be programmed with a minimum value of 1.
            IC_FS_SPKLEN: mmio.Mmio(packed struct(u32) {
                ///  This register must be set before any I2C bus transaction can take place to ensure stable operation. This register sets the duration, measured in ic_clk cycles, of the longest spike in the SCL or SDA lines that will be filtered out by the spike suppression logic. This register can be written only when the I2C interface is disabled which corresponds to the IC_ENABLE[0] register being set to 0. Writes at other times have no effect. The minimum valid value is 1; hardware prevents values less than this being written, and if attempted results in 1 being set. or more information, refer to 'Spike Suppression'.
                IC_FS_SPKLEN: u8,
                padding: u24,
            }),
            reserved168: [4]u8,
            ///  Clear RESTART_DET Interrupt Register
            IC_CLR_RESTART_DET: mmio.Mmio(packed struct(u32) {
                ///  Read this register to clear the RESTART_DET interrupt (bit 12) of IC_RAW_INTR_STAT register.
                ///  Reset value: 0x0
                CLR_RESTART_DET: u1,
                padding: u31,
            }),
            reserved244: [72]u8,
            ///  Component Parameter Register 1
            ///  Note This register is not implemented and therefore reads as 0. If it was implemented it would be a constant read-only register that contains encoded information about the component's parameter settings. Fields shown below are the settings for those parameters
            IC_COMP_PARAM_1: mmio.Mmio(packed struct(u32) {
                ///  APB data bus width is 32 bits
                APB_DATA_WIDTH: u2,
                ///  MAX SPEED MODE = FAST MODE
                MAX_SPEED_MODE: u2,
                ///  Programmable count values for each mode.
                HC_COUNT_VALUES: u1,
                ///  COMBINED Interrupt outputs
                INTR_IO: u1,
                ///  DMA handshaking signals are enabled
                HAS_DMA: u1,
                ///  Encoded parameters not visible
                ADD_ENCODED_PARAMS: u1,
                ///  RX Buffer Depth = 16
                RX_BUFFER_DEPTH: u8,
                ///  TX Buffer Depth = 16
                TX_BUFFER_DEPTH: u8,
                padding: u8,
            }),
            ///  I2C Component Version Register
            IC_COMP_VERSION: mmio.Mmio(packed struct(u32) {
                IC_COMP_VERSION: u32,
            }),
            ///  I2C Component Type Register
            IC_COMP_TYPE: mmio.Mmio(packed struct(u32) {
                ///  Designware Component Type number = 0x44_57_01_40. This assigned unique hex value is constant and is derived from the two ASCII letters 'DW' followed by a 16-bit unsigned number.
                IC_COMP_TYPE: u32,
            }),
        };

        ///  Programmable IO block
        pub const PIO0 = extern struct {
            ///  PIO control register
            CTRL: mmio.Mmio(packed struct(u32) {
                ///  Enable/disable each of the four state machines by writing 1/0 to each of these four bits. When disabled, a state machine will cease executing instructions, except those written directly to SMx_INSTR by the system. Multiple bits can be set/cleared at once to run/halt multiple state machines simultaneously.
                SM_ENABLE: u4,
                ///  Write 1 to instantly clear internal SM state which may be otherwise difficult to access and will affect future execution.
                ///  Specifically, the following are cleared: input and output shift counters; the contents of the input shift register; the delay counter; the waiting-on-IRQ state; any stalled instruction written to SMx_INSTR or run by OUT/MOV EXEC; any pin write left asserted due to OUT_STICKY.
                SM_RESTART: u4,
                ///  Restart a state machine's clock divider from an initial phase of 0. Clock dividers are free-running, so once started, their output (including fractional jitter) is completely determined by the integer/fractional divisor configured in SMx_CLKDIV. This means that, if multiple clock dividers with the same divisor are restarted simultaneously, by writing multiple 1 bits to this field, the execution clocks of those state machines will run in precise lockstep.
                ///  Note that setting/clearing SM_ENABLE does not stop the clock divider from running, so once multiple state machines' clocks are synchronised, it is safe to disable/reenable a state machine, whilst keeping the clock dividers in sync.
                ///  Note also that CLKDIV_RESTART can be written to whilst the state machine is running, and this is useful to resynchronise clock dividers after the divisors (SMx_CLKDIV) have been changed on-the-fly.
                CLKDIV_RESTART: u4,
                padding: u20,
            }),
            ///  FIFO status register
            FSTAT: mmio.Mmio(packed struct(u32) {
                ///  State machine RX FIFO is full
                RXFULL: u4,
                reserved8: u4,
                ///  State machine RX FIFO is empty
                RXEMPTY: u4,
                reserved16: u4,
                ///  State machine TX FIFO is full
                TXFULL: u4,
                reserved24: u4,
                ///  State machine TX FIFO is empty
                TXEMPTY: u4,
                padding: u4,
            }),
            ///  FIFO debug register
            FDEBUG: mmio.Mmio(packed struct(u32) {
                ///  State machine has stalled on full RX FIFO during a blocking PUSH, or an IN with autopush enabled. This flag is also set when a nonblocking PUSH to a full FIFO took place, in which case the state machine has dropped data. Write 1 to clear.
                RXSTALL: u4,
                reserved8: u4,
                ///  RX FIFO underflow (i.e. read-on-empty by the system) has occurred. Write 1 to clear. Note that read-on-empty does not perturb the state of the FIFO in any way, but the data returned by reading from an empty FIFO is undefined, so this flag generally only becomes set due to some kind of software error.
                RXUNDER: u4,
                reserved16: u4,
                ///  TX FIFO overflow (i.e. write-on-full by the system) has occurred. Write 1 to clear. Note that write-on-full does not alter the state or contents of the FIFO in any way, but the data that the system attempted to write is dropped, so if this flag is set, your software has quite likely dropped some data on the floor.
                TXOVER: u4,
                reserved24: u4,
                ///  State machine has stalled on empty TX FIFO during a blocking PULL, or an OUT with autopull enabled. Write 1 to clear.
                TXSTALL: u4,
                padding: u4,
            }),
            ///  FIFO levels
            FLEVEL: mmio.Mmio(packed struct(u32) {
                TX0: u4,
                RX0: u4,
                TX1: u4,
                RX1: u4,
                TX2: u4,
                RX2: u4,
                TX3: u4,
                RX3: u4,
            }),
            ///  Direct write access to the TX FIFO for this state machine. Each write pushes one word to the FIFO. Attempting to write to a full FIFO has no effect on the FIFO state or contents, and sets the sticky FDEBUG_TXOVER error flag for this FIFO.
            TXF0: u32,
            ///  Direct write access to the TX FIFO for this state machine. Each write pushes one word to the FIFO. Attempting to write to a full FIFO has no effect on the FIFO state or contents, and sets the sticky FDEBUG_TXOVER error flag for this FIFO.
            TXF1: u32,
            ///  Direct write access to the TX FIFO for this state machine. Each write pushes one word to the FIFO. Attempting to write to a full FIFO has no effect on the FIFO state or contents, and sets the sticky FDEBUG_TXOVER error flag for this FIFO.
            TXF2: u32,
            ///  Direct write access to the TX FIFO for this state machine. Each write pushes one word to the FIFO. Attempting to write to a full FIFO has no effect on the FIFO state or contents, and sets the sticky FDEBUG_TXOVER error flag for this FIFO.
            TXF3: u32,
            ///  Direct read access to the RX FIFO for this state machine. Each read pops one word from the FIFO. Attempting to read from an empty FIFO has no effect on the FIFO state, and sets the sticky FDEBUG_RXUNDER error flag for this FIFO. The data returned to the system on a read from an empty FIFO is undefined.
            RXF0: u32,
            ///  Direct read access to the RX FIFO for this state machine. Each read pops one word from the FIFO. Attempting to read from an empty FIFO has no effect on the FIFO state, and sets the sticky FDEBUG_RXUNDER error flag for this FIFO. The data returned to the system on a read from an empty FIFO is undefined.
            RXF1: u32,
            ///  Direct read access to the RX FIFO for this state machine. Each read pops one word from the FIFO. Attempting to read from an empty FIFO has no effect on the FIFO state, and sets the sticky FDEBUG_RXUNDER error flag for this FIFO. The data returned to the system on a read from an empty FIFO is undefined.
            RXF2: u32,
            ///  Direct read access to the RX FIFO for this state machine. Each read pops one word from the FIFO. Attempting to read from an empty FIFO has no effect on the FIFO state, and sets the sticky FDEBUG_RXUNDER error flag for this FIFO. The data returned to the system on a read from an empty FIFO is undefined.
            RXF3: u32,
            ///  State machine IRQ flags register. Write 1 to clear. There are 8 state machine IRQ flags, which can be set, cleared, and waited on by the state machines. There's no fixed association between flags and state machines -- any state machine can use any flag.
            ///  Any of the 8 flags can be used for timing synchronisation between state machines, using IRQ and WAIT instructions. The lower four of these flags are also routed out to system-level interrupt requests, alongside FIFO status interrupts -- see e.g. IRQ0_INTE.
            IRQ: mmio.Mmio(packed struct(u32) {
                IRQ: u8,
                padding: u24,
            }),
            ///  Writing a 1 to each of these bits will forcibly assert the corresponding IRQ. Note this is different to the INTF register: writing here affects PIO internal state. INTF just asserts the processor-facing IRQ signal for testing ISRs, and is not visible to the state machines.
            IRQ_FORCE: mmio.Mmio(packed struct(u32) {
                IRQ_FORCE: u8,
                padding: u24,
            }),
            ///  There is a 2-flipflop synchronizer on each GPIO input, which protects PIO logic from metastabilities. This increases input delay, and for fast synchronous IO (e.g. SPI) these synchronizers may need to be bypassed. Each bit in this register corresponds to one GPIO.
            ///  0 -> input is synchronized (default)
            ///  1 -> synchronizer is bypassed
            ///  If in doubt, leave this register as all zeroes.
            INPUT_SYNC_BYPASS: u32,
            ///  Read to sample the pad output values PIO is currently driving to the GPIOs. On RP2040 there are 30 GPIOs, so the two most significant bits are hardwired to 0.
            DBG_PADOUT: u32,
            ///  Read to sample the pad output enables (direction) PIO is currently driving to the GPIOs. On RP2040 there are 30 GPIOs, so the two most significant bits are hardwired to 0.
            DBG_PADOE: u32,
            ///  The PIO hardware has some free parameters that may vary between chip products.
            ///  These should be provided in the chip datasheet, but are also exposed here.
            DBG_CFGINFO: mmio.Mmio(packed struct(u32) {
                ///  The depth of the state machine TX/RX FIFOs, measured in words.
                ///  Joining fifos via SHIFTCTRL_FJOIN gives one FIFO with double
                ///  this depth.
                FIFO_DEPTH: u6,
                reserved8: u2,
                ///  The number of state machines this PIO instance is equipped with.
                SM_COUNT: u4,
                reserved16: u4,
                ///  The size of the instruction memory, measured in units of one instruction
                IMEM_SIZE: u6,
                padding: u10,
            }),
            ///  Write-only access to instruction memory location 0
            INSTR_MEM0: mmio.Mmio(packed struct(u32) {
                INSTR_MEM0: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 1
            INSTR_MEM1: mmio.Mmio(packed struct(u32) {
                INSTR_MEM1: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 2
            INSTR_MEM2: mmio.Mmio(packed struct(u32) {
                INSTR_MEM2: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 3
            INSTR_MEM3: mmio.Mmio(packed struct(u32) {
                INSTR_MEM3: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 4
            INSTR_MEM4: mmio.Mmio(packed struct(u32) {
                INSTR_MEM4: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 5
            INSTR_MEM5: mmio.Mmio(packed struct(u32) {
                INSTR_MEM5: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 6
            INSTR_MEM6: mmio.Mmio(packed struct(u32) {
                INSTR_MEM6: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 7
            INSTR_MEM7: mmio.Mmio(packed struct(u32) {
                INSTR_MEM7: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 8
            INSTR_MEM8: mmio.Mmio(packed struct(u32) {
                INSTR_MEM8: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 9
            INSTR_MEM9: mmio.Mmio(packed struct(u32) {
                INSTR_MEM9: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 10
            INSTR_MEM10: mmio.Mmio(packed struct(u32) {
                INSTR_MEM10: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 11
            INSTR_MEM11: mmio.Mmio(packed struct(u32) {
                INSTR_MEM11: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 12
            INSTR_MEM12: mmio.Mmio(packed struct(u32) {
                INSTR_MEM12: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 13
            INSTR_MEM13: mmio.Mmio(packed struct(u32) {
                INSTR_MEM13: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 14
            INSTR_MEM14: mmio.Mmio(packed struct(u32) {
                INSTR_MEM14: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 15
            INSTR_MEM15: mmio.Mmio(packed struct(u32) {
                INSTR_MEM15: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 16
            INSTR_MEM16: mmio.Mmio(packed struct(u32) {
                INSTR_MEM16: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 17
            INSTR_MEM17: mmio.Mmio(packed struct(u32) {
                INSTR_MEM17: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 18
            INSTR_MEM18: mmio.Mmio(packed struct(u32) {
                INSTR_MEM18: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 19
            INSTR_MEM19: mmio.Mmio(packed struct(u32) {
                INSTR_MEM19: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 20
            INSTR_MEM20: mmio.Mmio(packed struct(u32) {
                INSTR_MEM20: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 21
            INSTR_MEM21: mmio.Mmio(packed struct(u32) {
                INSTR_MEM21: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 22
            INSTR_MEM22: mmio.Mmio(packed struct(u32) {
                INSTR_MEM22: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 23
            INSTR_MEM23: mmio.Mmio(packed struct(u32) {
                INSTR_MEM23: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 24
            INSTR_MEM24: mmio.Mmio(packed struct(u32) {
                INSTR_MEM24: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 25
            INSTR_MEM25: mmio.Mmio(packed struct(u32) {
                INSTR_MEM25: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 26
            INSTR_MEM26: mmio.Mmio(packed struct(u32) {
                INSTR_MEM26: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 27
            INSTR_MEM27: mmio.Mmio(packed struct(u32) {
                INSTR_MEM27: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 28
            INSTR_MEM28: mmio.Mmio(packed struct(u32) {
                INSTR_MEM28: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 29
            INSTR_MEM29: mmio.Mmio(packed struct(u32) {
                INSTR_MEM29: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 30
            INSTR_MEM30: mmio.Mmio(packed struct(u32) {
                INSTR_MEM30: u16,
                padding: u16,
            }),
            ///  Write-only access to instruction memory location 31
            INSTR_MEM31: mmio.Mmio(packed struct(u32) {
                INSTR_MEM31: u16,
                padding: u16,
            }),
            ///  Clock divisor register for state machine 0
            ///  Frequency = clock freq / (CLKDIV_INT + CLKDIV_FRAC / 256)
            SM0_CLKDIV: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  Fractional part of clock divisor
                FRAC: u8,
                ///  Effective frequency is sysclk/(int + frac/256).
                ///  Value of 0 is interpreted as 65536. If INT is 0, FRAC must also be 0.
                INT: u16,
            }),
            ///  Execution/behavioural settings for state machine 0
            SM0_EXECCTRL: mmio.Mmio(packed struct(u32) {
                ///  Comparison level for the MOV x, STATUS instruction
                STATUS_N: u4,
                ///  Comparison used for the MOV x, STATUS instruction.
                STATUS_SEL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  All-ones if TX FIFO level < N, otherwise all-zeroes
                        TXLEVEL = 0x0,
                        ///  All-ones if RX FIFO level < N, otherwise all-zeroes
                        RXLEVEL = 0x1,
                    },
                },
                reserved7: u2,
                ///  After reaching wrap_top, execution is wrapped to this address.
                WRAP_BOTTOM: u5,
                ///  After reaching this address, execution is wrapped to wrap_bottom.
                ///  If the instruction is a jump, and the jump condition is true, the jump takes priority.
                WRAP_TOP: u5,
                ///  Continuously assert the most recent OUT/SET to the pins
                OUT_STICKY: u1,
                ///  If 1, use a bit of OUT data as an auxiliary write enable
                ///  When used in conjunction with OUT_STICKY, writes with an enable of 0 will
                ///  deassert the latest pin write. This can create useful masking/override behaviour
                ///  due to the priority ordering of state machine pin writes (SM0 < SM1 < ...)
                INLINE_OUT_EN: u1,
                ///  Which data bit to use for inline OUT enable
                OUT_EN_SEL: u5,
                ///  The GPIO number to use as condition for JMP PIN. Unaffected by input mapping.
                JMP_PIN: u5,
                ///  If 1, side-set data is asserted to pin directions, instead of pin values
                SIDE_PINDIR: u1,
                ///  If 1, the MSB of the Delay/Side-set instruction field is used as side-set enable, rather than a side-set data bit. This allows instructions to perform side-set optionally, rather than on every instruction, but the maximum possible side-set width is reduced from 5 to 4. Note that the value of PINCTRL_SIDESET_COUNT is inclusive of this enable bit.
                SIDE_EN: u1,
                ///  If 1, an instruction written to SMx_INSTR is stalled, and latched by the state machine. Will clear to 0 once this instruction completes.
                EXEC_STALLED: u1,
            }),
            ///  Control behaviour of the input/output shift registers for state machine 0
            SM0_SHIFTCTRL: mmio.Mmio(packed struct(u32) {
                reserved16: u16,
                ///  Push automatically when the input shift register is filled, i.e. on an IN instruction which causes the input shift counter to reach or exceed PUSH_THRESH.
                AUTOPUSH: u1,
                ///  Pull automatically when the output shift register is emptied, i.e. on or following an OUT instruction which causes the output shift counter to reach or exceed PULL_THRESH.
                AUTOPULL: u1,
                ///  1 = shift input shift register to right (data enters from left). 0 = to left.
                IN_SHIFTDIR: u1,
                ///  1 = shift out of output shift register to right. 0 = to left.
                OUT_SHIFTDIR: u1,
                ///  Number of bits shifted into ISR before autopush, or conditional push (PUSH IFFULL), will take place.
                ///  Write 0 for value of 32.
                PUSH_THRESH: u5,
                ///  Number of bits shifted out of OSR before autopull, or conditional pull (PULL IFEMPTY), will take place.
                ///  Write 0 for value of 32.
                PULL_THRESH: u5,
                ///  When 1, TX FIFO steals the RX FIFO's storage, and becomes twice as deep.
                ///  RX FIFO is disabled as a result (always reads as both full and empty).
                ///  FIFOs are flushed when this bit is changed.
                FJOIN_TX: u1,
                ///  When 1, RX FIFO steals the TX FIFO's storage, and becomes twice as deep.
                ///  TX FIFO is disabled as a result (always reads as both full and empty).
                ///  FIFOs are flushed when this bit is changed.
                FJOIN_RX: u1,
            }),
            ///  Current instruction address of state machine 0
            SM0_ADDR: mmio.Mmio(packed struct(u32) {
                SM0_ADDR: u5,
                padding: u27,
            }),
            ///  Read to see the instruction currently addressed by state machine 0's program counter
            ///  Write to execute an instruction immediately (including jumps) and then resume execution.
            SM0_INSTR: mmio.Mmio(packed struct(u32) {
                SM0_INSTR: u16,
                padding: u16,
            }),
            ///  State machine pin control
            SM0_PINCTRL: mmio.Mmio(packed struct(u32) {
                ///  The lowest-numbered pin that will be affected by an OUT PINS, OUT PINDIRS or MOV PINS instruction. The data written to this pin will always be the least-significant bit of the OUT or MOV data.
                OUT_BASE: u5,
                ///  The lowest-numbered pin that will be affected by a SET PINS or SET PINDIRS instruction. The data written to this pin is the least-significant bit of the SET data.
                SET_BASE: u5,
                ///  The lowest-numbered pin that will be affected by a side-set operation. The MSBs of an instruction's side-set/delay field (up to 5, determined by SIDESET_COUNT) are used for side-set data, with the remaining LSBs used for delay. The least-significant bit of the side-set portion is the bit written to this pin, with more-significant bits written to higher-numbered pins.
                SIDESET_BASE: u5,
                ///  The pin which is mapped to the least-significant bit of a state machine's IN data bus. Higher-numbered pins are mapped to consecutively more-significant data bits, with a modulo of 32 applied to pin number.
                IN_BASE: u5,
                ///  The number of pins asserted by an OUT PINS, OUT PINDIRS or MOV PINS instruction. In the range 0 to 32 inclusive.
                OUT_COUNT: u6,
                ///  The number of pins asserted by a SET. In the range 0 to 5 inclusive.
                SET_COUNT: u3,
                ///  The number of MSBs of the Delay/Side-set instruction field which are used for side-set. Inclusive of the enable bit, if present. Minimum of 0 (all delay bits, no side-set) and maximum of 5 (all side-set, no delay).
                SIDESET_COUNT: u3,
            }),
            ///  Clock divisor register for state machine 1
            ///  Frequency = clock freq / (CLKDIV_INT + CLKDIV_FRAC / 256)
            SM1_CLKDIV: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  Fractional part of clock divisor
                FRAC: u8,
                ///  Effective frequency is sysclk/(int + frac/256).
                ///  Value of 0 is interpreted as 65536. If INT is 0, FRAC must also be 0.
                INT: u16,
            }),
            ///  Execution/behavioural settings for state machine 1
            SM1_EXECCTRL: mmio.Mmio(packed struct(u32) {
                ///  Comparison level for the MOV x, STATUS instruction
                STATUS_N: u4,
                ///  Comparison used for the MOV x, STATUS instruction.
                STATUS_SEL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  All-ones if TX FIFO level < N, otherwise all-zeroes
                        TXLEVEL = 0x0,
                        ///  All-ones if RX FIFO level < N, otherwise all-zeroes
                        RXLEVEL = 0x1,
                    },
                },
                reserved7: u2,
                ///  After reaching wrap_top, execution is wrapped to this address.
                WRAP_BOTTOM: u5,
                ///  After reaching this address, execution is wrapped to wrap_bottom.
                ///  If the instruction is a jump, and the jump condition is true, the jump takes priority.
                WRAP_TOP: u5,
                ///  Continuously assert the most recent OUT/SET to the pins
                OUT_STICKY: u1,
                ///  If 1, use a bit of OUT data as an auxiliary write enable
                ///  When used in conjunction with OUT_STICKY, writes with an enable of 0 will
                ///  deassert the latest pin write. This can create useful masking/override behaviour
                ///  due to the priority ordering of state machine pin writes (SM0 < SM1 < ...)
                INLINE_OUT_EN: u1,
                ///  Which data bit to use for inline OUT enable
                OUT_EN_SEL: u5,
                ///  The GPIO number to use as condition for JMP PIN. Unaffected by input mapping.
                JMP_PIN: u5,
                ///  If 1, side-set data is asserted to pin directions, instead of pin values
                SIDE_PINDIR: u1,
                ///  If 1, the MSB of the Delay/Side-set instruction field is used as side-set enable, rather than a side-set data bit. This allows instructions to perform side-set optionally, rather than on every instruction, but the maximum possible side-set width is reduced from 5 to 4. Note that the value of PINCTRL_SIDESET_COUNT is inclusive of this enable bit.
                SIDE_EN: u1,
                ///  If 1, an instruction written to SMx_INSTR is stalled, and latched by the state machine. Will clear to 0 once this instruction completes.
                EXEC_STALLED: u1,
            }),
            ///  Control behaviour of the input/output shift registers for state machine 1
            SM1_SHIFTCTRL: mmio.Mmio(packed struct(u32) {
                reserved16: u16,
                ///  Push automatically when the input shift register is filled, i.e. on an IN instruction which causes the input shift counter to reach or exceed PUSH_THRESH.
                AUTOPUSH: u1,
                ///  Pull automatically when the output shift register is emptied, i.e. on or following an OUT instruction which causes the output shift counter to reach or exceed PULL_THRESH.
                AUTOPULL: u1,
                ///  1 = shift input shift register to right (data enters from left). 0 = to left.
                IN_SHIFTDIR: u1,
                ///  1 = shift out of output shift register to right. 0 = to left.
                OUT_SHIFTDIR: u1,
                ///  Number of bits shifted into ISR before autopush, or conditional push (PUSH IFFULL), will take place.
                ///  Write 0 for value of 32.
                PUSH_THRESH: u5,
                ///  Number of bits shifted out of OSR before autopull, or conditional pull (PULL IFEMPTY), will take place.
                ///  Write 0 for value of 32.
                PULL_THRESH: u5,
                ///  When 1, TX FIFO steals the RX FIFO's storage, and becomes twice as deep.
                ///  RX FIFO is disabled as a result (always reads as both full and empty).
                ///  FIFOs are flushed when this bit is changed.
                FJOIN_TX: u1,
                ///  When 1, RX FIFO steals the TX FIFO's storage, and becomes twice as deep.
                ///  TX FIFO is disabled as a result (always reads as both full and empty).
                ///  FIFOs are flushed when this bit is changed.
                FJOIN_RX: u1,
            }),
            ///  Current instruction address of state machine 1
            SM1_ADDR: mmio.Mmio(packed struct(u32) {
                SM1_ADDR: u5,
                padding: u27,
            }),
            ///  Read to see the instruction currently addressed by state machine 1's program counter
            ///  Write to execute an instruction immediately (including jumps) and then resume execution.
            SM1_INSTR: mmio.Mmio(packed struct(u32) {
                SM1_INSTR: u16,
                padding: u16,
            }),
            ///  State machine pin control
            SM1_PINCTRL: mmio.Mmio(packed struct(u32) {
                ///  The lowest-numbered pin that will be affected by an OUT PINS, OUT PINDIRS or MOV PINS instruction. The data written to this pin will always be the least-significant bit of the OUT or MOV data.
                OUT_BASE: u5,
                ///  The lowest-numbered pin that will be affected by a SET PINS or SET PINDIRS instruction. The data written to this pin is the least-significant bit of the SET data.
                SET_BASE: u5,
                ///  The lowest-numbered pin that will be affected by a side-set operation. The MSBs of an instruction's side-set/delay field (up to 5, determined by SIDESET_COUNT) are used for side-set data, with the remaining LSBs used for delay. The least-significant bit of the side-set portion is the bit written to this pin, with more-significant bits written to higher-numbered pins.
                SIDESET_BASE: u5,
                ///  The pin which is mapped to the least-significant bit of a state machine's IN data bus. Higher-numbered pins are mapped to consecutively more-significant data bits, with a modulo of 32 applied to pin number.
                IN_BASE: u5,
                ///  The number of pins asserted by an OUT PINS, OUT PINDIRS or MOV PINS instruction. In the range 0 to 32 inclusive.
                OUT_COUNT: u6,
                ///  The number of pins asserted by a SET. In the range 0 to 5 inclusive.
                SET_COUNT: u3,
                ///  The number of MSBs of the Delay/Side-set instruction field which are used for side-set. Inclusive of the enable bit, if present. Minimum of 0 (all delay bits, no side-set) and maximum of 5 (all side-set, no delay).
                SIDESET_COUNT: u3,
            }),
            ///  Clock divisor register for state machine 2
            ///  Frequency = clock freq / (CLKDIV_INT + CLKDIV_FRAC / 256)
            SM2_CLKDIV: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  Fractional part of clock divisor
                FRAC: u8,
                ///  Effective frequency is sysclk/(int + frac/256).
                ///  Value of 0 is interpreted as 65536. If INT is 0, FRAC must also be 0.
                INT: u16,
            }),
            ///  Execution/behavioural settings for state machine 2
            SM2_EXECCTRL: mmio.Mmio(packed struct(u32) {
                ///  Comparison level for the MOV x, STATUS instruction
                STATUS_N: u4,
                ///  Comparison used for the MOV x, STATUS instruction.
                STATUS_SEL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  All-ones if TX FIFO level < N, otherwise all-zeroes
                        TXLEVEL = 0x0,
                        ///  All-ones if RX FIFO level < N, otherwise all-zeroes
                        RXLEVEL = 0x1,
                    },
                },
                reserved7: u2,
                ///  After reaching wrap_top, execution is wrapped to this address.
                WRAP_BOTTOM: u5,
                ///  After reaching this address, execution is wrapped to wrap_bottom.
                ///  If the instruction is a jump, and the jump condition is true, the jump takes priority.
                WRAP_TOP: u5,
                ///  Continuously assert the most recent OUT/SET to the pins
                OUT_STICKY: u1,
                ///  If 1, use a bit of OUT data as an auxiliary write enable
                ///  When used in conjunction with OUT_STICKY, writes with an enable of 0 will
                ///  deassert the latest pin write. This can create useful masking/override behaviour
                ///  due to the priority ordering of state machine pin writes (SM0 < SM1 < ...)
                INLINE_OUT_EN: u1,
                ///  Which data bit to use for inline OUT enable
                OUT_EN_SEL: u5,
                ///  The GPIO number to use as condition for JMP PIN. Unaffected by input mapping.
                JMP_PIN: u5,
                ///  If 1, side-set data is asserted to pin directions, instead of pin values
                SIDE_PINDIR: u1,
                ///  If 1, the MSB of the Delay/Side-set instruction field is used as side-set enable, rather than a side-set data bit. This allows instructions to perform side-set optionally, rather than on every instruction, but the maximum possible side-set width is reduced from 5 to 4. Note that the value of PINCTRL_SIDESET_COUNT is inclusive of this enable bit.
                SIDE_EN: u1,
                ///  If 1, an instruction written to SMx_INSTR is stalled, and latched by the state machine. Will clear to 0 once this instruction completes.
                EXEC_STALLED: u1,
            }),
            ///  Control behaviour of the input/output shift registers for state machine 2
            SM2_SHIFTCTRL: mmio.Mmio(packed struct(u32) {
                reserved16: u16,
                ///  Push automatically when the input shift register is filled, i.e. on an IN instruction which causes the input shift counter to reach or exceed PUSH_THRESH.
                AUTOPUSH: u1,
                ///  Pull automatically when the output shift register is emptied, i.e. on or following an OUT instruction which causes the output shift counter to reach or exceed PULL_THRESH.
                AUTOPULL: u1,
                ///  1 = shift input shift register to right (data enters from left). 0 = to left.
                IN_SHIFTDIR: u1,
                ///  1 = shift out of output shift register to right. 0 = to left.
                OUT_SHIFTDIR: u1,
                ///  Number of bits shifted into ISR before autopush, or conditional push (PUSH IFFULL), will take place.
                ///  Write 0 for value of 32.
                PUSH_THRESH: u5,
                ///  Number of bits shifted out of OSR before autopull, or conditional pull (PULL IFEMPTY), will take place.
                ///  Write 0 for value of 32.
                PULL_THRESH: u5,
                ///  When 1, TX FIFO steals the RX FIFO's storage, and becomes twice as deep.
                ///  RX FIFO is disabled as a result (always reads as both full and empty).
                ///  FIFOs are flushed when this bit is changed.
                FJOIN_TX: u1,
                ///  When 1, RX FIFO steals the TX FIFO's storage, and becomes twice as deep.
                ///  TX FIFO is disabled as a result (always reads as both full and empty).
                ///  FIFOs are flushed when this bit is changed.
                FJOIN_RX: u1,
            }),
            ///  Current instruction address of state machine 2
            SM2_ADDR: mmio.Mmio(packed struct(u32) {
                SM2_ADDR: u5,
                padding: u27,
            }),
            ///  Read to see the instruction currently addressed by state machine 2's program counter
            ///  Write to execute an instruction immediately (including jumps) and then resume execution.
            SM2_INSTR: mmio.Mmio(packed struct(u32) {
                SM2_INSTR: u16,
                padding: u16,
            }),
            ///  State machine pin control
            SM2_PINCTRL: mmio.Mmio(packed struct(u32) {
                ///  The lowest-numbered pin that will be affected by an OUT PINS, OUT PINDIRS or MOV PINS instruction. The data written to this pin will always be the least-significant bit of the OUT or MOV data.
                OUT_BASE: u5,
                ///  The lowest-numbered pin that will be affected by a SET PINS or SET PINDIRS instruction. The data written to this pin is the least-significant bit of the SET data.
                SET_BASE: u5,
                ///  The lowest-numbered pin that will be affected by a side-set operation. The MSBs of an instruction's side-set/delay field (up to 5, determined by SIDESET_COUNT) are used for side-set data, with the remaining LSBs used for delay. The least-significant bit of the side-set portion is the bit written to this pin, with more-significant bits written to higher-numbered pins.
                SIDESET_BASE: u5,
                ///  The pin which is mapped to the least-significant bit of a state machine's IN data bus. Higher-numbered pins are mapped to consecutively more-significant data bits, with a modulo of 32 applied to pin number.
                IN_BASE: u5,
                ///  The number of pins asserted by an OUT PINS, OUT PINDIRS or MOV PINS instruction. In the range 0 to 32 inclusive.
                OUT_COUNT: u6,
                ///  The number of pins asserted by a SET. In the range 0 to 5 inclusive.
                SET_COUNT: u3,
                ///  The number of MSBs of the Delay/Side-set instruction field which are used for side-set. Inclusive of the enable bit, if present. Minimum of 0 (all delay bits, no side-set) and maximum of 5 (all side-set, no delay).
                SIDESET_COUNT: u3,
            }),
            ///  Clock divisor register for state machine 3
            ///  Frequency = clock freq / (CLKDIV_INT + CLKDIV_FRAC / 256)
            SM3_CLKDIV: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  Fractional part of clock divisor
                FRAC: u8,
                ///  Effective frequency is sysclk/(int + frac/256).
                ///  Value of 0 is interpreted as 65536. If INT is 0, FRAC must also be 0.
                INT: u16,
            }),
            ///  Execution/behavioural settings for state machine 3
            SM3_EXECCTRL: mmio.Mmio(packed struct(u32) {
                ///  Comparison level for the MOV x, STATUS instruction
                STATUS_N: u4,
                ///  Comparison used for the MOV x, STATUS instruction.
                STATUS_SEL: packed union {
                    raw: u1,
                    value: enum(u1) {
                        ///  All-ones if TX FIFO level < N, otherwise all-zeroes
                        TXLEVEL = 0x0,
                        ///  All-ones if RX FIFO level < N, otherwise all-zeroes
                        RXLEVEL = 0x1,
                    },
                },
                reserved7: u2,
                ///  After reaching wrap_top, execution is wrapped to this address.
                WRAP_BOTTOM: u5,
                ///  After reaching this address, execution is wrapped to wrap_bottom.
                ///  If the instruction is a jump, and the jump condition is true, the jump takes priority.
                WRAP_TOP: u5,
                ///  Continuously assert the most recent OUT/SET to the pins
                OUT_STICKY: u1,
                ///  If 1, use a bit of OUT data as an auxiliary write enable
                ///  When used in conjunction with OUT_STICKY, writes with an enable of 0 will
                ///  deassert the latest pin write. This can create useful masking/override behaviour
                ///  due to the priority ordering of state machine pin writes (SM0 < SM1 < ...)
                INLINE_OUT_EN: u1,
                ///  Which data bit to use for inline OUT enable
                OUT_EN_SEL: u5,
                ///  The GPIO number to use as condition for JMP PIN. Unaffected by input mapping.
                JMP_PIN: u5,
                ///  If 1, side-set data is asserted to pin directions, instead of pin values
                SIDE_PINDIR: u1,
                ///  If 1, the MSB of the Delay/Side-set instruction field is used as side-set enable, rather than a side-set data bit. This allows instructions to perform side-set optionally, rather than on every instruction, but the maximum possible side-set width is reduced from 5 to 4. Note that the value of PINCTRL_SIDESET_COUNT is inclusive of this enable bit.
                SIDE_EN: u1,
                ///  If 1, an instruction written to SMx_INSTR is stalled, and latched by the state machine. Will clear to 0 once this instruction completes.
                EXEC_STALLED: u1,
            }),
            ///  Control behaviour of the input/output shift registers for state machine 3
            SM3_SHIFTCTRL: mmio.Mmio(packed struct(u32) {
                reserved16: u16,
                ///  Push automatically when the input shift register is filled, i.e. on an IN instruction which causes the input shift counter to reach or exceed PUSH_THRESH.
                AUTOPUSH: u1,
                ///  Pull automatically when the output shift register is emptied, i.e. on or following an OUT instruction which causes the output shift counter to reach or exceed PULL_THRESH.
                AUTOPULL: u1,
                ///  1 = shift input shift register to right (data enters from left). 0 = to left.
                IN_SHIFTDIR: u1,
                ///  1 = shift out of output shift register to right. 0 = to left.
                OUT_SHIFTDIR: u1,
                ///  Number of bits shifted into ISR before autopush, or conditional push (PUSH IFFULL), will take place.
                ///  Write 0 for value of 32.
                PUSH_THRESH: u5,
                ///  Number of bits shifted out of OSR before autopull, or conditional pull (PULL IFEMPTY), will take place.
                ///  Write 0 for value of 32.
                PULL_THRESH: u5,
                ///  When 1, TX FIFO steals the RX FIFO's storage, and becomes twice as deep.
                ///  RX FIFO is disabled as a result (always reads as both full and empty).
                ///  FIFOs are flushed when this bit is changed.
                FJOIN_TX: u1,
                ///  When 1, RX FIFO steals the TX FIFO's storage, and becomes twice as deep.
                ///  TX FIFO is disabled as a result (always reads as both full and empty).
                ///  FIFOs are flushed when this bit is changed.
                FJOIN_RX: u1,
            }),
            ///  Current instruction address of state machine 3
            SM3_ADDR: mmio.Mmio(packed struct(u32) {
                SM3_ADDR: u5,
                padding: u27,
            }),
            ///  Read to see the instruction currently addressed by state machine 3's program counter
            ///  Write to execute an instruction immediately (including jumps) and then resume execution.
            SM3_INSTR: mmio.Mmio(packed struct(u32) {
                SM3_INSTR: u16,
                padding: u16,
            }),
            ///  State machine pin control
            SM3_PINCTRL: mmio.Mmio(packed struct(u32) {
                ///  The lowest-numbered pin that will be affected by an OUT PINS, OUT PINDIRS or MOV PINS instruction. The data written to this pin will always be the least-significant bit of the OUT or MOV data.
                OUT_BASE: u5,
                ///  The lowest-numbered pin that will be affected by a SET PINS or SET PINDIRS instruction. The data written to this pin is the least-significant bit of the SET data.
                SET_BASE: u5,
                ///  The lowest-numbered pin that will be affected by a side-set operation. The MSBs of an instruction's side-set/delay field (up to 5, determined by SIDESET_COUNT) are used for side-set data, with the remaining LSBs used for delay. The least-significant bit of the side-set portion is the bit written to this pin, with more-significant bits written to higher-numbered pins.
                SIDESET_BASE: u5,
                ///  The pin which is mapped to the least-significant bit of a state machine's IN data bus. Higher-numbered pins are mapped to consecutively more-significant data bits, with a modulo of 32 applied to pin number.
                IN_BASE: u5,
                ///  The number of pins asserted by an OUT PINS, OUT PINDIRS or MOV PINS instruction. In the range 0 to 32 inclusive.
                OUT_COUNT: u6,
                ///  The number of pins asserted by a SET. In the range 0 to 5 inclusive.
                SET_COUNT: u3,
                ///  The number of MSBs of the Delay/Side-set instruction field which are used for side-set. Inclusive of the enable bit, if present. Minimum of 0 (all delay bits, no side-set) and maximum of 5 (all side-set, no delay).
                SIDESET_COUNT: u3,
            }),
            ///  Raw Interrupts
            INTR: mmio.Mmio(packed struct(u32) {
                SM0_RXNEMPTY: u1,
                SM1_RXNEMPTY: u1,
                SM2_RXNEMPTY: u1,
                SM3_RXNEMPTY: u1,
                SM0_TXNFULL: u1,
                SM1_TXNFULL: u1,
                SM2_TXNFULL: u1,
                SM3_TXNFULL: u1,
                SM0: u1,
                SM1: u1,
                SM2: u1,
                SM3: u1,
                padding: u20,
            }),
            ///  Interrupt Enable for irq0
            IRQ0_INTE: mmio.Mmio(packed struct(u32) {
                SM0_RXNEMPTY: u1,
                SM1_RXNEMPTY: u1,
                SM2_RXNEMPTY: u1,
                SM3_RXNEMPTY: u1,
                SM0_TXNFULL: u1,
                SM1_TXNFULL: u1,
                SM2_TXNFULL: u1,
                SM3_TXNFULL: u1,
                SM0: u1,
                SM1: u1,
                SM2: u1,
                SM3: u1,
                padding: u20,
            }),
            ///  Interrupt Force for irq0
            IRQ0_INTF: mmio.Mmio(packed struct(u32) {
                SM0_RXNEMPTY: u1,
                SM1_RXNEMPTY: u1,
                SM2_RXNEMPTY: u1,
                SM3_RXNEMPTY: u1,
                SM0_TXNFULL: u1,
                SM1_TXNFULL: u1,
                SM2_TXNFULL: u1,
                SM3_TXNFULL: u1,
                SM0: u1,
                SM1: u1,
                SM2: u1,
                SM3: u1,
                padding: u20,
            }),
            ///  Interrupt status after masking & forcing for irq0
            IRQ0_INTS: mmio.Mmio(packed struct(u32) {
                SM0_RXNEMPTY: u1,
                SM1_RXNEMPTY: u1,
                SM2_RXNEMPTY: u1,
                SM3_RXNEMPTY: u1,
                SM0_TXNFULL: u1,
                SM1_TXNFULL: u1,
                SM2_TXNFULL: u1,
                SM3_TXNFULL: u1,
                SM0: u1,
                SM1: u1,
                SM2: u1,
                SM3: u1,
                padding: u20,
            }),
            ///  Interrupt Enable for irq1
            IRQ1_INTE: mmio.Mmio(packed struct(u32) {
                SM0_RXNEMPTY: u1,
                SM1_RXNEMPTY: u1,
                SM2_RXNEMPTY: u1,
                SM3_RXNEMPTY: u1,
                SM0_TXNFULL: u1,
                SM1_TXNFULL: u1,
                SM2_TXNFULL: u1,
                SM3_TXNFULL: u1,
                SM0: u1,
                SM1: u1,
                SM2: u1,
                SM3: u1,
                padding: u20,
            }),
            ///  Interrupt Force for irq1
            IRQ1_INTF: mmio.Mmio(packed struct(u32) {
                SM0_RXNEMPTY: u1,
                SM1_RXNEMPTY: u1,
                SM2_RXNEMPTY: u1,
                SM3_RXNEMPTY: u1,
                SM0_TXNFULL: u1,
                SM1_TXNFULL: u1,
                SM2_TXNFULL: u1,
                SM3_TXNFULL: u1,
                SM0: u1,
                SM1: u1,
                SM2: u1,
                SM3: u1,
                padding: u20,
            }),
            ///  Interrupt status after masking & forcing for irq1
            IRQ1_INTS: mmio.Mmio(packed struct(u32) {
                SM0_RXNEMPTY: u1,
                SM1_RXNEMPTY: u1,
                SM2_RXNEMPTY: u1,
                SM3_RXNEMPTY: u1,
                SM0_TXNFULL: u1,
                SM1_TXNFULL: u1,
                SM2_TXNFULL: u1,
                SM3_TXNFULL: u1,
                SM0: u1,
                SM1: u1,
                SM2: u1,
                SM3: u1,
                padding: u20,
            }),
        };

        ///  Control and data interface to SAR ADC
        pub const ADC = extern struct {
            ///  ADC Control and Status
            CS: mmio.Mmio(packed struct(u32) {
                ///  Power on ADC and enable its clock.
                ///  1 - enabled. 0 - disabled.
                EN: u1,
                ///  Power on temperature sensor. 1 - enabled. 0 - disabled.
                TS_EN: u1,
                ///  Start a single conversion. Self-clearing. Ignored if start_many is asserted.
                START_ONCE: u1,
                ///  Continuously perform conversions whilst this bit is 1. A new conversion will start immediately after the previous finishes.
                START_MANY: u1,
                reserved8: u4,
                ///  1 if the ADC is ready to start a new conversion. Implies any previous conversion has completed.
                ///  0 whilst conversion in progress.
                READY: u1,
                ///  The most recent ADC conversion encountered an error; result is undefined or noisy.
                ERR: u1,
                ///  Some past ADC conversion encountered an error. Write 1 to clear.
                ERR_STICKY: u1,
                reserved12: u1,
                ///  Select analog mux input. Updated automatically in round-robin mode.
                AINSEL: u3,
                reserved16: u1,
                ///  Round-robin sampling. 1 bit per channel. Set all bits to 0 to disable.
                ///  Otherwise, the ADC will cycle through each enabled channel in a round-robin fashion.
                ///  The first channel to be sampled will be the one currently indicated by AINSEL.
                ///  AINSEL will be updated after each conversion with the newly-selected channel.
                RROBIN: u5,
                padding: u11,
            }),
            ///  Result of most recent ADC conversion
            RESULT: mmio.Mmio(packed struct(u32) {
                RESULT: u12,
                padding: u20,
            }),
            ///  FIFO control and status
            FCS: mmio.Mmio(packed struct(u32) {
                ///  If 1: write result to the FIFO after each conversion.
                EN: u1,
                ///  If 1: FIFO results are right-shifted to be one byte in size. Enables DMA to byte buffers.
                SHIFT: u1,
                ///  If 1: conversion error bit appears in the FIFO alongside the result
                ERR: u1,
                ///  If 1: assert DMA requests when FIFO contains data
                DREQ_EN: u1,
                reserved8: u4,
                EMPTY: u1,
                FULL: u1,
                ///  1 if the FIFO has been underflowed. Write 1 to clear.
                UNDER: u1,
                ///  1 if the FIFO has been overflowed. Write 1 to clear.
                OVER: u1,
                reserved16: u4,
                ///  The number of conversion results currently waiting in the FIFO
                LEVEL: u4,
                reserved24: u4,
                ///  DREQ/IRQ asserted when level >= threshold
                THRESH: u4,
                padding: u4,
            }),
            ///  Conversion result FIFO
            FIFO: mmio.Mmio(packed struct(u32) {
                VAL: u12,
                reserved15: u3,
                ///  1 if this particular sample experienced a conversion error. Remains in the same location if the sample is shifted.
                ERR: u1,
                padding: u16,
            }),
            ///  Clock divider. If non-zero, CS_START_MANY will start conversions
            ///  at regular intervals rather than back-to-back.
            ///  The divider is reset when either of these fields are written.
            ///  Total period is 1 + INT + FRAC / 256
            DIV: mmio.Mmio(packed struct(u32) {
                ///  Fractional part of clock divisor. First-order delta-sigma.
                FRAC: u8,
                ///  Integer part of clock divisor.
                INT: u16,
                padding: u8,
            }),
            ///  Raw Interrupts
            INTR: mmio.Mmio(packed struct(u32) {
                ///  Triggered when the sample FIFO reaches a certain level.
                ///  This level can be programmed via the FCS_THRESH field.
                FIFO: u1,
                padding: u31,
            }),
            ///  Interrupt Enable
            INTE: mmio.Mmio(packed struct(u32) {
                ///  Triggered when the sample FIFO reaches a certain level.
                ///  This level can be programmed via the FCS_THRESH field.
                FIFO: u1,
                padding: u31,
            }),
            ///  Interrupt Force
            INTF: mmio.Mmio(packed struct(u32) {
                ///  Triggered when the sample FIFO reaches a certain level.
                ///  This level can be programmed via the FCS_THRESH field.
                FIFO: u1,
                padding: u31,
            }),
            ///  Interrupt status after masking & forcing
            INTS: mmio.Mmio(packed struct(u32) {
                ///  Triggered when the sample FIFO reaches a certain level.
                ///  This level can be programmed via the FCS_THRESH field.
                FIFO: u1,
                padding: u31,
            }),
        };

        ///  Simple PWM
        pub const PWM = extern struct {
            ///  Control and status register
            CH0_CSR: mmio.Mmio(packed struct(u32) {
                ///  Enable the PWM channel.
                EN: u1,
                ///  1: Enable phase-correct modulation. 0: Trailing-edge
                PH_CORRECT: u1,
                ///  Invert output A
                A_INV: u1,
                ///  Invert output B
                B_INV: u1,
                DIVMODE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Free-running counting at rate dictated by fractional divider
                        div = 0x0,
                        ///  Fractional divider operation is gated by the PWM B pin.
                        level = 0x1,
                        ///  Counter advances with each rising edge of the PWM B pin.
                        rise = 0x2,
                        ///  Counter advances with each falling edge of the PWM B pin.
                        fall = 0x3,
                    },
                },
                ///  Retard the phase of the counter by 1 count, while it is running.
                ///  Self-clearing. Write a 1, and poll until low. Counter must be running.
                PH_RET: u1,
                ///  Advance the phase of the counter by 1 count, while it is running.
                ///  Self-clearing. Write a 1, and poll until low. Counter must be running
                ///  at less than full speed (div_int + div_frac / 16 > 1)
                PH_ADV: u1,
                padding: u24,
            }),
            ///  INT and FRAC form a fixed-point fractional number.
            ///  Counting rate is system clock frequency divided by this number.
            ///  Fractional division uses simple 1st-order sigma-delta.
            CH0_DIV: mmio.Mmio(packed struct(u32) {
                FRAC: u4,
                INT: u8,
                padding: u20,
            }),
            ///  Direct access to the PWM counter
            CH0_CTR: mmio.Mmio(packed struct(u32) {
                CH0_CTR: u16,
                padding: u16,
            }),
            ///  Counter compare values
            CH0_CC: mmio.Mmio(packed struct(u32) {
                A: u16,
                B: u16,
            }),
            ///  Counter wrap value
            CH0_TOP: mmio.Mmio(packed struct(u32) {
                CH0_TOP: u16,
                padding: u16,
            }),
            ///  Control and status register
            CH1_CSR: mmio.Mmio(packed struct(u32) {
                ///  Enable the PWM channel.
                EN: u1,
                ///  1: Enable phase-correct modulation. 0: Trailing-edge
                PH_CORRECT: u1,
                ///  Invert output A
                A_INV: u1,
                ///  Invert output B
                B_INV: u1,
                DIVMODE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Free-running counting at rate dictated by fractional divider
                        div = 0x0,
                        ///  Fractional divider operation is gated by the PWM B pin.
                        level = 0x1,
                        ///  Counter advances with each rising edge of the PWM B pin.
                        rise = 0x2,
                        ///  Counter advances with each falling edge of the PWM B pin.
                        fall = 0x3,
                    },
                },
                ///  Retard the phase of the counter by 1 count, while it is running.
                ///  Self-clearing. Write a 1, and poll until low. Counter must be running.
                PH_RET: u1,
                ///  Advance the phase of the counter by 1 count, while it is running.
                ///  Self-clearing. Write a 1, and poll until low. Counter must be running
                ///  at less than full speed (div_int + div_frac / 16 > 1)
                PH_ADV: u1,
                padding: u24,
            }),
            ///  INT and FRAC form a fixed-point fractional number.
            ///  Counting rate is system clock frequency divided by this number.
            ///  Fractional division uses simple 1st-order sigma-delta.
            CH1_DIV: mmio.Mmio(packed struct(u32) {
                FRAC: u4,
                INT: u8,
                padding: u20,
            }),
            ///  Direct access to the PWM counter
            CH1_CTR: mmio.Mmio(packed struct(u32) {
                CH1_CTR: u16,
                padding: u16,
            }),
            ///  Counter compare values
            CH1_CC: mmio.Mmio(packed struct(u32) {
                A: u16,
                B: u16,
            }),
            ///  Counter wrap value
            CH1_TOP: mmio.Mmio(packed struct(u32) {
                CH1_TOP: u16,
                padding: u16,
            }),
            ///  Control and status register
            CH2_CSR: mmio.Mmio(packed struct(u32) {
                ///  Enable the PWM channel.
                EN: u1,
                ///  1: Enable phase-correct modulation. 0: Trailing-edge
                PH_CORRECT: u1,
                ///  Invert output A
                A_INV: u1,
                ///  Invert output B
                B_INV: u1,
                DIVMODE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Free-running counting at rate dictated by fractional divider
                        div = 0x0,
                        ///  Fractional divider operation is gated by the PWM B pin.
                        level = 0x1,
                        ///  Counter advances with each rising edge of the PWM B pin.
                        rise = 0x2,
                        ///  Counter advances with each falling edge of the PWM B pin.
                        fall = 0x3,
                    },
                },
                ///  Retard the phase of the counter by 1 count, while it is running.
                ///  Self-clearing. Write a 1, and poll until low. Counter must be running.
                PH_RET: u1,
                ///  Advance the phase of the counter by 1 count, while it is running.
                ///  Self-clearing. Write a 1, and poll until low. Counter must be running
                ///  at less than full speed (div_int + div_frac / 16 > 1)
                PH_ADV: u1,
                padding: u24,
            }),
            ///  INT and FRAC form a fixed-point fractional number.
            ///  Counting rate is system clock frequency divided by this number.
            ///  Fractional division uses simple 1st-order sigma-delta.
            CH2_DIV: mmio.Mmio(packed struct(u32) {
                FRAC: u4,
                INT: u8,
                padding: u20,
            }),
            ///  Direct access to the PWM counter
            CH2_CTR: mmio.Mmio(packed struct(u32) {
                CH2_CTR: u16,
                padding: u16,
            }),
            ///  Counter compare values
            CH2_CC: mmio.Mmio(packed struct(u32) {
                A: u16,
                B: u16,
            }),
            ///  Counter wrap value
            CH2_TOP: mmio.Mmio(packed struct(u32) {
                CH2_TOP: u16,
                padding: u16,
            }),
            ///  Control and status register
            CH3_CSR: mmio.Mmio(packed struct(u32) {
                ///  Enable the PWM channel.
                EN: u1,
                ///  1: Enable phase-correct modulation. 0: Trailing-edge
                PH_CORRECT: u1,
                ///  Invert output A
                A_INV: u1,
                ///  Invert output B
                B_INV: u1,
                DIVMODE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Free-running counting at rate dictated by fractional divider
                        div = 0x0,
                        ///  Fractional divider operation is gated by the PWM B pin.
                        level = 0x1,
                        ///  Counter advances with each rising edge of the PWM B pin.
                        rise = 0x2,
                        ///  Counter advances with each falling edge of the PWM B pin.
                        fall = 0x3,
                    },
                },
                ///  Retard the phase of the counter by 1 count, while it is running.
                ///  Self-clearing. Write a 1, and poll until low. Counter must be running.
                PH_RET: u1,
                ///  Advance the phase of the counter by 1 count, while it is running.
                ///  Self-clearing. Write a 1, and poll until low. Counter must be running
                ///  at less than full speed (div_int + div_frac / 16 > 1)
                PH_ADV: u1,
                padding: u24,
            }),
            ///  INT and FRAC form a fixed-point fractional number.
            ///  Counting rate is system clock frequency divided by this number.
            ///  Fractional division uses simple 1st-order sigma-delta.
            CH3_DIV: mmio.Mmio(packed struct(u32) {
                FRAC: u4,
                INT: u8,
                padding: u20,
            }),
            ///  Direct access to the PWM counter
            CH3_CTR: mmio.Mmio(packed struct(u32) {
                CH3_CTR: u16,
                padding: u16,
            }),
            ///  Counter compare values
            CH3_CC: mmio.Mmio(packed struct(u32) {
                A: u16,
                B: u16,
            }),
            ///  Counter wrap value
            CH3_TOP: mmio.Mmio(packed struct(u32) {
                CH3_TOP: u16,
                padding: u16,
            }),
            ///  Control and status register
            CH4_CSR: mmio.Mmio(packed struct(u32) {
                ///  Enable the PWM channel.
                EN: u1,
                ///  1: Enable phase-correct modulation. 0: Trailing-edge
                PH_CORRECT: u1,
                ///  Invert output A
                A_INV: u1,
                ///  Invert output B
                B_INV: u1,
                DIVMODE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Free-running counting at rate dictated by fractional divider
                        div = 0x0,
                        ///  Fractional divider operation is gated by the PWM B pin.
                        level = 0x1,
                        ///  Counter advances with each rising edge of the PWM B pin.
                        rise = 0x2,
                        ///  Counter advances with each falling edge of the PWM B pin.
                        fall = 0x3,
                    },
                },
                ///  Retard the phase of the counter by 1 count, while it is running.
                ///  Self-clearing. Write a 1, and poll until low. Counter must be running.
                PH_RET: u1,
                ///  Advance the phase of the counter by 1 count, while it is running.
                ///  Self-clearing. Write a 1, and poll until low. Counter must be running
                ///  at less than full speed (div_int + div_frac / 16 > 1)
                PH_ADV: u1,
                padding: u24,
            }),
            ///  INT and FRAC form a fixed-point fractional number.
            ///  Counting rate is system clock frequency divided by this number.
            ///  Fractional division uses simple 1st-order sigma-delta.
            CH4_DIV: mmio.Mmio(packed struct(u32) {
                FRAC: u4,
                INT: u8,
                padding: u20,
            }),
            ///  Direct access to the PWM counter
            CH4_CTR: mmio.Mmio(packed struct(u32) {
                CH4_CTR: u16,
                padding: u16,
            }),
            ///  Counter compare values
            CH4_CC: mmio.Mmio(packed struct(u32) {
                A: u16,
                B: u16,
            }),
            ///  Counter wrap value
            CH4_TOP: mmio.Mmio(packed struct(u32) {
                CH4_TOP: u16,
                padding: u16,
            }),
            ///  Control and status register
            CH5_CSR: mmio.Mmio(packed struct(u32) {
                ///  Enable the PWM channel.
                EN: u1,
                ///  1: Enable phase-correct modulation. 0: Trailing-edge
                PH_CORRECT: u1,
                ///  Invert output A
                A_INV: u1,
                ///  Invert output B
                B_INV: u1,
                DIVMODE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Free-running counting at rate dictated by fractional divider
                        div = 0x0,
                        ///  Fractional divider operation is gated by the PWM B pin.
                        level = 0x1,
                        ///  Counter advances with each rising edge of the PWM B pin.
                        rise = 0x2,
                        ///  Counter advances with each falling edge of the PWM B pin.
                        fall = 0x3,
                    },
                },
                ///  Retard the phase of the counter by 1 count, while it is running.
                ///  Self-clearing. Write a 1, and poll until low. Counter must be running.
                PH_RET: u1,
                ///  Advance the phase of the counter by 1 count, while it is running.
                ///  Self-clearing. Write a 1, and poll until low. Counter must be running
                ///  at less than full speed (div_int + div_frac / 16 > 1)
                PH_ADV: u1,
                padding: u24,
            }),
            ///  INT and FRAC form a fixed-point fractional number.
            ///  Counting rate is system clock frequency divided by this number.
            ///  Fractional division uses simple 1st-order sigma-delta.
            CH5_DIV: mmio.Mmio(packed struct(u32) {
                FRAC: u4,
                INT: u8,
                padding: u20,
            }),
            ///  Direct access to the PWM counter
            CH5_CTR: mmio.Mmio(packed struct(u32) {
                CH5_CTR: u16,
                padding: u16,
            }),
            ///  Counter compare values
            CH5_CC: mmio.Mmio(packed struct(u32) {
                A: u16,
                B: u16,
            }),
            ///  Counter wrap value
            CH5_TOP: mmio.Mmio(packed struct(u32) {
                CH5_TOP: u16,
                padding: u16,
            }),
            ///  Control and status register
            CH6_CSR: mmio.Mmio(packed struct(u32) {
                ///  Enable the PWM channel.
                EN: u1,
                ///  1: Enable phase-correct modulation. 0: Trailing-edge
                PH_CORRECT: u1,
                ///  Invert output A
                A_INV: u1,
                ///  Invert output B
                B_INV: u1,
                DIVMODE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Free-running counting at rate dictated by fractional divider
                        div = 0x0,
                        ///  Fractional divider operation is gated by the PWM B pin.
                        level = 0x1,
                        ///  Counter advances with each rising edge of the PWM B pin.
                        rise = 0x2,
                        ///  Counter advances with each falling edge of the PWM B pin.
                        fall = 0x3,
                    },
                },
                ///  Retard the phase of the counter by 1 count, while it is running.
                ///  Self-clearing. Write a 1, and poll until low. Counter must be running.
                PH_RET: u1,
                ///  Advance the phase of the counter by 1 count, while it is running.
                ///  Self-clearing. Write a 1, and poll until low. Counter must be running
                ///  at less than full speed (div_int + div_frac / 16 > 1)
                PH_ADV: u1,
                padding: u24,
            }),
            ///  INT and FRAC form a fixed-point fractional number.
            ///  Counting rate is system clock frequency divided by this number.
            ///  Fractional division uses simple 1st-order sigma-delta.
            CH6_DIV: mmio.Mmio(packed struct(u32) {
                FRAC: u4,
                INT: u8,
                padding: u20,
            }),
            ///  Direct access to the PWM counter
            CH6_CTR: mmio.Mmio(packed struct(u32) {
                CH6_CTR: u16,
                padding: u16,
            }),
            ///  Counter compare values
            CH6_CC: mmio.Mmio(packed struct(u32) {
                A: u16,
                B: u16,
            }),
            ///  Counter wrap value
            CH6_TOP: mmio.Mmio(packed struct(u32) {
                CH6_TOP: u16,
                padding: u16,
            }),
            ///  Control and status register
            CH7_CSR: mmio.Mmio(packed struct(u32) {
                ///  Enable the PWM channel.
                EN: u1,
                ///  1: Enable phase-correct modulation. 0: Trailing-edge
                PH_CORRECT: u1,
                ///  Invert output A
                A_INV: u1,
                ///  Invert output B
                B_INV: u1,
                DIVMODE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        ///  Free-running counting at rate dictated by fractional divider
                        div = 0x0,
                        ///  Fractional divider operation is gated by the PWM B pin.
                        level = 0x1,
                        ///  Counter advances with each rising edge of the PWM B pin.
                        rise = 0x2,
                        ///  Counter advances with each falling edge of the PWM B pin.
                        fall = 0x3,
                    },
                },
                ///  Retard the phase of the counter by 1 count, while it is running.
                ///  Self-clearing. Write a 1, and poll until low. Counter must be running.
                PH_RET: u1,
                ///  Advance the phase of the counter by 1 count, while it is running.
                ///  Self-clearing. Write a 1, and poll until low. Counter must be running
                ///  at less than full speed (div_int + div_frac / 16 > 1)
                PH_ADV: u1,
                padding: u24,
            }),
            ///  INT and FRAC form a fixed-point fractional number.
            ///  Counting rate is system clock frequency divided by this number.
            ///  Fractional division uses simple 1st-order sigma-delta.
            CH7_DIV: mmio.Mmio(packed struct(u32) {
                FRAC: u4,
                INT: u8,
                padding: u20,
            }),
            ///  Direct access to the PWM counter
            CH7_CTR: mmio.Mmio(packed struct(u32) {
                CH7_CTR: u16,
                padding: u16,
            }),
            ///  Counter compare values
            CH7_CC: mmio.Mmio(packed struct(u32) {
                A: u16,
                B: u16,
            }),
            ///  Counter wrap value
            CH7_TOP: mmio.Mmio(packed struct(u32) {
                CH7_TOP: u16,
                padding: u16,
            }),
            ///  This register aliases the CSR_EN bits for all channels.
            ///  Writing to this register allows multiple channels to be enabled
            ///  or disabled simultaneously, so they can run in perfect sync.
            ///  For each channel, there is only one physical EN register bit,
            ///  which can be accessed through here or CHx_CSR.
            EN: mmio.Mmio(packed struct(u32) {
                CH0: u1,
                CH1: u1,
                CH2: u1,
                CH3: u1,
                CH4: u1,
                CH5: u1,
                CH6: u1,
                CH7: u1,
                padding: u24,
            }),
            ///  Raw Interrupts
            INTR: mmio.Mmio(packed struct(u32) {
                CH0: u1,
                CH1: u1,
                CH2: u1,
                CH3: u1,
                CH4: u1,
                CH5: u1,
                CH6: u1,
                CH7: u1,
                padding: u24,
            }),
            ///  Interrupt Enable
            INTE: mmio.Mmio(packed struct(u32) {
                CH0: u1,
                CH1: u1,
                CH2: u1,
                CH3: u1,
                CH4: u1,
                CH5: u1,
                CH6: u1,
                CH7: u1,
                padding: u24,
            }),
            ///  Interrupt Force
            INTF: mmio.Mmio(packed struct(u32) {
                CH0: u1,
                CH1: u1,
                CH2: u1,
                CH3: u1,
                CH4: u1,
                CH5: u1,
                CH6: u1,
                CH7: u1,
                padding: u24,
            }),
            ///  Interrupt status after masking & forcing
            INTS: mmio.Mmio(packed struct(u32) {
                CH0: u1,
                CH1: u1,
                CH2: u1,
                CH3: u1,
                CH4: u1,
                CH5: u1,
                CH6: u1,
                CH7: u1,
                padding: u24,
            }),
        };

        ///  Controls time and alarms
        ///  time is a 64 bit value indicating the time in usec since power-on
        ///  timeh is the top 32 bits of time & timel is the bottom 32 bits
        ///  to change time write to timelw before timehw
        ///  to read time read from timelr before timehr
        ///  An alarm is set by setting alarm_enable and writing to the corresponding alarm register
        ///  When an alarm is pending, the corresponding alarm_running signal will be high
        ///  An alarm can be cancelled before it has finished by clearing the alarm_enable
        ///  When an alarm fires, the corresponding alarm_irq is set and alarm_running is cleared
        ///  To clear the interrupt write a 1 to the corresponding alarm_irq
        pub const TIMER = extern struct {
            ///  Write to bits 63:32 of time
            ///  always write timelw before timehw
            TIMEHW: u32,
            ///  Write to bits 31:0 of time
            ///  writes do not get copied to time until timehw is written
            TIMELW: u32,
            ///  Read from bits 63:32 of time
            ///  always read timelr before timehr
            TIMEHR: u32,
            ///  Read from bits 31:0 of time
            TIMELR: u32,
            ///  Arm alarm 0, and configure the time it will fire.
            ///  Once armed, the alarm fires when TIMER_ALARM0 == TIMELR.
            ///  The alarm will disarm itself once it fires, and can
            ///  be disarmed early using the ARMED status register.
            ALARM0: u32,
            ///  Arm alarm 1, and configure the time it will fire.
            ///  Once armed, the alarm fires when TIMER_ALARM1 == TIMELR.
            ///  The alarm will disarm itself once it fires, and can
            ///  be disarmed early using the ARMED status register.
            ALARM1: u32,
            ///  Arm alarm 2, and configure the time it will fire.
            ///  Once armed, the alarm fires when TIMER_ALARM2 == TIMELR.
            ///  The alarm will disarm itself once it fires, and can
            ///  be disarmed early using the ARMED status register.
            ALARM2: u32,
            ///  Arm alarm 3, and configure the time it will fire.
            ///  Once armed, the alarm fires when TIMER_ALARM3 == TIMELR.
            ///  The alarm will disarm itself once it fires, and can
            ///  be disarmed early using the ARMED status register.
            ALARM3: u32,
            ///  Indicates the armed/disarmed status of each alarm.
            ///  A write to the corresponding ALARMx register arms the alarm.
            ///  Alarms automatically disarm upon firing, but writing ones here
            ///  will disarm immediately without waiting to fire.
            ARMED: mmio.Mmio(packed struct(u32) {
                ARMED: u4,
                padding: u28,
            }),
            ///  Raw read from bits 63:32 of time (no side effects)
            TIMERAWH: u32,
            ///  Raw read from bits 31:0 of time (no side effects)
            TIMERAWL: u32,
            ///  Set bits high to enable pause when the corresponding debug ports are active
            DBGPAUSE: mmio.Mmio(packed struct(u32) {
                reserved1: u1,
                ///  Pause when processor 0 is in debug mode
                DBG0: u1,
                ///  Pause when processor 1 is in debug mode
                DBG1: u1,
                padding: u29,
            }),
            ///  Set high to pause the timer
            PAUSE: mmio.Mmio(packed struct(u32) {
                PAUSE: u1,
                padding: u31,
            }),
            ///  Raw Interrupts
            INTR: mmio.Mmio(packed struct(u32) {
                ALARM_0: u1,
                ALARM_1: u1,
                ALARM_2: u1,
                ALARM_3: u1,
                padding: u28,
            }),
            ///  Interrupt Enable
            INTE: mmio.Mmio(packed struct(u32) {
                ALARM_0: u1,
                ALARM_1: u1,
                ALARM_2: u1,
                ALARM_3: u1,
                padding: u28,
            }),
            ///  Interrupt Force
            INTF: mmio.Mmio(packed struct(u32) {
                ALARM_0: u1,
                ALARM_1: u1,
                ALARM_2: u1,
                ALARM_3: u1,
                padding: u28,
            }),
            ///  Interrupt status after masking & forcing
            INTS: mmio.Mmio(packed struct(u32) {
                ALARM_0: u1,
                ALARM_1: u1,
                ALARM_2: u1,
                ALARM_3: u1,
                padding: u28,
            }),
        };

        pub const WATCHDOG = extern struct {
            ///  Watchdog control
            ///  The rst_wdsel register determines which subsystems are reset when the watchdog is triggered.
            ///  The watchdog can be triggered in software.
            CTRL: mmio.Mmio(packed struct(u32) {
                ///  Indicates the number of ticks / 2 (see errata RP2040-E1) before a watchdog reset will be triggered
                TIME: u24,
                ///  Pause the watchdog timer when JTAG is accessing the bus fabric
                PAUSE_JTAG: u1,
                ///  Pause the watchdog timer when processor 0 is in debug mode
                PAUSE_DBG0: u1,
                ///  Pause the watchdog timer when processor 1 is in debug mode
                PAUSE_DBG1: u1,
                reserved30: u3,
                ///  When not enabled the watchdog timer is paused
                ENABLE: u1,
                ///  Trigger a watchdog reset
                TRIGGER: u1,
            }),
            ///  Load the watchdog timer. The maximum setting is 0xffffff which corresponds to 0xffffff / 2 ticks before triggering a watchdog reset (see errata RP2040-E1).
            LOAD: mmio.Mmio(packed struct(u32) {
                LOAD: u24,
                padding: u8,
            }),
            ///  Logs the reason for the last reset. Both bits are zero for the case of a hardware reset.
            REASON: mmio.Mmio(packed struct(u32) {
                TIMER: u1,
                FORCE: u1,
                padding: u30,
            }),
            ///  Scratch register. Information persists through soft reset of the chip.
            SCRATCH0: u32,
            ///  Scratch register. Information persists through soft reset of the chip.
            SCRATCH1: u32,
            ///  Scratch register. Information persists through soft reset of the chip.
            SCRATCH2: u32,
            ///  Scratch register. Information persists through soft reset of the chip.
            SCRATCH3: u32,
            ///  Scratch register. Information persists through soft reset of the chip.
            SCRATCH4: u32,
            ///  Scratch register. Information persists through soft reset of the chip.
            SCRATCH5: u32,
            ///  Scratch register. Information persists through soft reset of the chip.
            SCRATCH6: u32,
            ///  Scratch register. Information persists through soft reset of the chip.
            SCRATCH7: u32,
            ///  Controls the tick generator
            TICK: mmio.Mmio(packed struct(u32) {
                ///  Total number of clk_tick cycles before the next tick.
                CYCLES: u9,
                ///  start / stop tick generation
                ENABLE: u1,
                ///  Is the tick generator running?
                RUNNING: u1,
                ///  Count down timer: the remaining number clk_tick cycles before the next tick is generated.
                COUNT: u9,
                padding: u12,
            }),
        };

        ///  Register block to control RTC
        pub const RTC = extern struct {
            ///  Divider minus 1 for the 1 second counter. Safe to change the value when RTC is not enabled.
            CLKDIV_M1: mmio.Mmio(packed struct(u32) {
                CLKDIV_M1: u16,
                padding: u16,
            }),
            ///  RTC setup register 0
            SETUP_0: mmio.Mmio(packed struct(u32) {
                ///  Day of the month (1..31)
                DAY: u5,
                reserved8: u3,
                ///  Month (1..12)
                MONTH: u4,
                ///  Year
                YEAR: u12,
                padding: u8,
            }),
            ///  RTC setup register 1
            SETUP_1: mmio.Mmio(packed struct(u32) {
                ///  Seconds
                SEC: u6,
                reserved8: u2,
                ///  Minutes
                MIN: u6,
                reserved16: u2,
                ///  Hours
                HOUR: u5,
                reserved24: u3,
                ///  Day of the week: 1-Monday...0-Sunday ISO 8601 mod 7
                DOTW: u3,
                padding: u5,
            }),
            ///  RTC Control and status
            CTRL: mmio.Mmio(packed struct(u32) {
                ///  Enable RTC
                RTC_ENABLE: u1,
                ///  RTC enabled (running)
                RTC_ACTIVE: u1,
                reserved4: u2,
                ///  Load RTC
                LOAD: u1,
                reserved8: u3,
                ///  If set, leapyear is forced off.
                ///  Useful for years divisible by 100 but not by 400
                FORCE_NOTLEAPYEAR: u1,
                padding: u23,
            }),
            ///  Interrupt setup register 0
            IRQ_SETUP_0: mmio.Mmio(packed struct(u32) {
                ///  Day of the month (1..31)
                DAY: u5,
                reserved8: u3,
                ///  Month (1..12)
                MONTH: u4,
                ///  Year
                YEAR: u12,
                ///  Enable day matching
                DAY_ENA: u1,
                ///  Enable month matching
                MONTH_ENA: u1,
                ///  Enable year matching
                YEAR_ENA: u1,
                reserved28: u1,
                ///  Global match enable. Don't change any other value while this one is enabled
                MATCH_ENA: u1,
                MATCH_ACTIVE: u1,
                padding: u2,
            }),
            ///  Interrupt setup register 1
            IRQ_SETUP_1: mmio.Mmio(packed struct(u32) {
                ///  Seconds
                SEC: u6,
                reserved8: u2,
                ///  Minutes
                MIN: u6,
                reserved16: u2,
                ///  Hours
                HOUR: u5,
                reserved24: u3,
                ///  Day of the week
                DOTW: u3,
                reserved28: u1,
                ///  Enable second matching
                SEC_ENA: u1,
                ///  Enable minute matching
                MIN_ENA: u1,
                ///  Enable hour matching
                HOUR_ENA: u1,
                ///  Enable day of the week matching
                DOTW_ENA: u1,
            }),
            ///  RTC register 1.
            RTC_1: mmio.Mmio(packed struct(u32) {
                ///  Day of the month (1..31)
                DAY: u5,
                reserved8: u3,
                ///  Month (1..12)
                MONTH: u4,
                ///  Year
                YEAR: u12,
                padding: u8,
            }),
            ///  RTC register 0
            ///  Read this before RTC 1!
            RTC_0: mmio.Mmio(packed struct(u32) {
                ///  Seconds
                SEC: u6,
                reserved8: u2,
                ///  Minutes
                MIN: u6,
                reserved16: u2,
                ///  Hours
                HOUR: u5,
                reserved24: u3,
                ///  Day of the week
                DOTW: u3,
                padding: u5,
            }),
            ///  Raw Interrupts
            INTR: mmio.Mmio(packed struct(u32) {
                RTC: u1,
                padding: u31,
            }),
            ///  Interrupt Enable
            INTE: mmio.Mmio(packed struct(u32) {
                RTC: u1,
                padding: u31,
            }),
            ///  Interrupt Force
            INTF: mmio.Mmio(packed struct(u32) {
                RTC: u1,
                padding: u31,
            }),
            ///  Interrupt status after masking & forcing
            INTS: mmio.Mmio(packed struct(u32) {
                RTC: u1,
                padding: u31,
            }),
        };

        pub const ROSC = extern struct {
            ///  Ring Oscillator control
            CTRL: mmio.Mmio(packed struct(u32) {
                ///  Controls the number of delay stages in the ROSC ring
                ///  LOW uses stages 0 to 7
                ///  MEDIUM uses stages 0 to 5
                ///  HIGH uses stages 0 to 3
                ///  TOOHIGH uses stages 0 to 1 and should not be used because its frequency exceeds design specifications
                ///  The clock output will not glitch when changing the range up one step at a time
                ///  The clock output will glitch when changing the range down
                ///  Note: the values here are gray coded which is why HIGH comes before TOOHIGH
                FREQ_RANGE: packed union {
                    raw: u12,
                    value: enum(u12) {
                        LOW = 0xfa4,
                        MEDIUM = 0xfa5,
                        HIGH = 0xfa7,
                        TOOHIGH = 0xfa6,
                        _,
                    },
                },
                ///  On power-up this field is initialised to ENABLE
                ///  The system clock must be switched to another source before setting this field to DISABLE otherwise the chip will lock up
                ///  The 12-bit code is intended to give some protection against accidental writes. An invalid setting will enable the oscillator.
                ENABLE: packed union {
                    raw: u12,
                    value: enum(u12) {
                        DISABLE = 0xd1e,
                        ENABLE = 0xfab,
                        _,
                    },
                },
                padding: u8,
            }),
            ///  The FREQA & FREQB registers control the frequency by controlling the drive strength of each stage
            ///  The drive strength has 4 levels determined by the number of bits set
            ///  Increasing the number of bits set increases the drive strength and increases the oscillation frequency
            ///  0 bits set is the default drive strength
            ///  1 bit set doubles the drive strength
            ///  2 bits set triples drive strength
            ///  3 bits set quadruples drive strength
            FREQA: mmio.Mmio(packed struct(u32) {
                ///  Stage 0 drive strength
                DS0: u3,
                reserved4: u1,
                ///  Stage 1 drive strength
                DS1: u3,
                reserved8: u1,
                ///  Stage 2 drive strength
                DS2: u3,
                reserved12: u1,
                ///  Stage 3 drive strength
                DS3: u3,
                reserved16: u1,
                ///  Set to 0x9696 to apply the settings
                ///  Any other value in this field will set all drive strengths to 0
                PASSWD: packed union {
                    raw: u16,
                    value: enum(u16) {
                        PASS = 0x9696,
                        _,
                    },
                },
            }),
            ///  For a detailed description see freqa register
            FREQB: mmio.Mmio(packed struct(u32) {
                ///  Stage 4 drive strength
                DS4: u3,
                reserved4: u1,
                ///  Stage 5 drive strength
                DS5: u3,
                reserved8: u1,
                ///  Stage 6 drive strength
                DS6: u3,
                reserved12: u1,
                ///  Stage 7 drive strength
                DS7: u3,
                reserved16: u1,
                ///  Set to 0x9696 to apply the settings
                ///  Any other value in this field will set all drive strengths to 0
                PASSWD: packed union {
                    raw: u16,
                    value: enum(u16) {
                        PASS = 0x9696,
                        _,
                    },
                },
            }),
            ///  Ring Oscillator pause control
            ///  This is used to save power by pausing the ROSC
            ///  On power-up this field is initialised to WAKE
            ///  An invalid write will also select WAKE
            ///  Warning: setup the irq before selecting dormant mode
            DORMANT: u32,
            ///  Controls the output divider
            DIV: mmio.Mmio(packed struct(u32) {
                ///  set to 0xaa0 + div where
                ///  div = 0 divides by 32
                ///  div = 1-31 divides by div
                ///  any other value sets div=31
                ///  this register resets to div=16
                DIV: packed union {
                    raw: u12,
                    value: enum(u12) {
                        PASS = 0xaa0,
                        _,
                    },
                },
                padding: u20,
            }),
            ///  Controls the phase shifted output
            PHASE: mmio.Mmio(packed struct(u32) {
                ///  phase shift the phase-shifted output by SHIFT input clocks
                ///  this can be changed on-the-fly
                ///  must be set to 0 before setting div=1
                SHIFT: u2,
                ///  invert the phase-shifted output
                ///  this is ignored when div=1
                FLIP: u1,
                ///  enable the phase-shifted output
                ///  this can be changed on-the-fly
                ENABLE: u1,
                ///  set to 0xaa
                ///  any other value enables the output with shift=0
                PASSWD: u8,
                padding: u20,
            }),
            ///  Ring Oscillator Status
            STATUS: mmio.Mmio(packed struct(u32) {
                reserved12: u12,
                ///  Oscillator is enabled but not necessarily running and stable
                ///  this resets to 0 but transitions to 1 during chip startup
                ENABLED: u1,
                reserved16: u3,
                ///  post-divider is running
                ///  this resets to 0 but transitions to 1 during chip startup
                DIV_RUNNING: u1,
                reserved24: u7,
                ///  An invalid value has been written to CTRL_ENABLE or CTRL_FREQ_RANGE or FREQA or FREQB or DIV or PHASE or DORMANT
                BADWRITE: u1,
                reserved31: u6,
                ///  Oscillator is running and stable
                STABLE: u1,
            }),
            ///  This just reads the state of the oscillator output so randomness is compromised if the ring oscillator is stopped or run at a harmonic of the bus frequency
            RANDOMBIT: mmio.Mmio(packed struct(u32) {
                RANDOMBIT: u1,
                padding: u31,
            }),
            ///  A down counter running at the ROSC frequency which counts to zero and stops.
            ///  To start the counter write a non-zero value.
            ///  Can be used for short software pauses when setting up time sensitive hardware.
            COUNT: mmio.Mmio(packed struct(u32) {
                COUNT: u8,
                padding: u24,
            }),
        };

        ///  control and status for on-chip voltage regulator and chip level reset subsystem
        pub const VREG_AND_CHIP_RESET = extern struct {
            ///  Voltage regulator control and status
            VREG: mmio.Mmio(packed struct(u32) {
                ///  enable
                ///  0=not enabled, 1=enabled
                EN: u1,
                ///  high impedance mode select
                ///  0=not in high impedance mode, 1=in high impedance mode
                HIZ: u1,
                reserved4: u2,
                ///  output voltage select
                ///  0000 to 0101 - 0.80V
                ///  0110 - 0.85V
                ///  0111 - 0.90V
                ///  1000 - 0.95V
                ///  1001 - 1.00V
                ///  1010 - 1.05V
                ///  1011 - 1.10V (default)
                ///  1100 - 1.15V
                ///  1101 - 1.20V
                ///  1110 - 1.25V
                ///  1111 - 1.30V
                VSEL: u4,
                reserved12: u4,
                ///  regulation status
                ///  0=not in regulation, 1=in regulation
                ROK: u1,
                padding: u19,
            }),
            ///  brown-out detection control
            BOD: mmio.Mmio(packed struct(u32) {
                ///  enable
                ///  0=not enabled, 1=enabled
                EN: u1,
                reserved4: u3,
                ///  threshold select
                ///  0000 - 0.473V
                ///  0001 - 0.516V
                ///  0010 - 0.559V
                ///  0011 - 0.602V
                ///  0100 - 0.645V
                ///  0101 - 0.688V
                ///  0110 - 0.731V
                ///  0111 - 0.774V
                ///  1000 - 0.817V
                ///  1001 - 0.860V (default)
                ///  1010 - 0.903V
                ///  1011 - 0.946V
                ///  1100 - 0.989V
                ///  1101 - 1.032V
                ///  1110 - 1.075V
                ///  1111 - 1.118V
                VSEL: u4,
                padding: u24,
            }),
            ///  Chip reset control and status
            CHIP_RESET: mmio.Mmio(packed struct(u32) {
                reserved8: u8,
                ///  Last reset was from the power-on reset or brown-out detection blocks
                HAD_POR: u1,
                reserved16: u7,
                ///  Last reset was from the RUN pin
                HAD_RUN: u1,
                reserved20: u3,
                ///  Last reset was from the debug port
                HAD_PSM_RESTART: u1,
                reserved24: u3,
                ///  This is set by psm_restart from the debugger.
                ///  Its purpose is to branch bootcode to a safe mode when the debugger has issued a psm_restart in order to recover from a boot lock-up.
                ///  In the safe mode the debugger can repair the boot code, clear this flag then reboot the processor.
                PSM_RESTART_FLAG: u1,
                padding: u7,
            }),
        };

        ///  Testbench manager. Allows the programmer to know what platform their software is running on.
        pub const TBMAN = extern struct {
            ///  Indicates the type of platform in use
            PLATFORM: mmio.Mmio(packed struct(u32) {
                ///  Indicates the platform is an ASIC
                ASIC: u1,
                ///  Indicates the platform is an FPGA
                FPGA: u1,
                padding: u30,
            }),
        };

        ///  DMA with separate read and write masters
        pub const DMA = extern struct {
            ///  DMA Channel 0 Read Address pointer
            ///  This register updates automatically each time a read completes. The current value is the next address to be read by this channel.
            CH0_READ_ADDR: u32,
            ///  DMA Channel 0 Write Address pointer
            ///  This register updates automatically each time a write completes. The current value is the next address to be written by this channel.
            CH0_WRITE_ADDR: u32,
            ///  DMA Channel 0 Transfer Count
            ///  Program the number of bus transfers a channel will perform before halting. Note that, if transfers are larger than one byte in size, this is not equal to the number of bytes transferred (see CTRL_DATA_SIZE).
            ///  When the channel is active, reading this register shows the number of transfers remaining, updating automatically each time a write transfer completes.
            ///  Writing this register sets the RELOAD value for the transfer counter. Each time this channel is triggered, the RELOAD value is copied into the live transfer counter. The channel can be started multiple times, and will perform the same number of transfers each time, as programmed by most recent write.
            ///  The RELOAD value can be observed at CHx_DBG_TCR. If TRANS_COUNT is used as a trigger, the written value is used immediately as the length of the new transfer sequence, as well as being written to RELOAD.
            CH0_TRANS_COUNT: u32,
            ///  DMA Channel 0 Control and Status
            CH0_CTRL_TRIG: mmio.Mmio(packed struct(u32) {
                ///  DMA Channel Enable.
                ///  When 1, the channel will respond to triggering events, which will cause it to become BUSY and start transferring data. When 0, the channel will ignore triggers, stop issuing transfers, and pause the current transfer sequence (i.e. BUSY will remain high if already high)
                EN: u1,
                ///  HIGH_PRIORITY gives a channel preferential treatment in issue scheduling: in each scheduling round, all high priority channels are considered first, and then only a single low priority channel, before returning to the high priority channels.
                ///  This only affects the order in which the DMA schedules channels. The DMA's bus priority is not changed. If the DMA is not saturated then a low priority channel will see no loss of throughput.
                HIGH_PRIORITY: u1,
                ///  Set the size of each bus transfer (byte/halfword/word). READ_ADDR and WRITE_ADDR advance by this amount (1/2/4 bytes) with each transfer.
                DATA_SIZE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        SIZE_BYTE = 0x0,
                        SIZE_HALFWORD = 0x1,
                        SIZE_WORD = 0x2,
                        _,
                    },
                },
                ///  If 1, the read address increments with each transfer. If 0, each read is directed to the same, initial address.
                ///  Generally this should be disabled for peripheral-to-memory transfers.
                INCR_READ: u1,
                ///  If 1, the write address increments with each transfer. If 0, each write is directed to the same, initial address.
                ///  Generally this should be disabled for memory-to-peripheral transfers.
                INCR_WRITE: u1,
                ///  Size of address wrap region. If 0, don't wrap. For values n > 0, only the lower n bits of the address will change. This wraps the address on a (1 << n) byte boundary, facilitating access to naturally-aligned ring buffers.
                ///  Ring sizes between 2 and 32768 bytes are possible. This can apply to either read or write addresses, based on value of RING_SEL.
                RING_SIZE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        RING_NONE = 0x0,
                        _,
                    },
                },
                ///  Select whether RING_SIZE applies to read or write addresses.
                ///  If 0, read addresses are wrapped on a (1 << RING_SIZE) boundary. If 1, write addresses are wrapped.
                RING_SEL: u1,
                ///  When this channel completes, it will trigger the channel indicated by CHAIN_TO. Disable by setting CHAIN_TO = _(this channel)_.
                CHAIN_TO: u4,
                ///  Select a Transfer Request signal.
                ///  The channel uses the transfer request signal to pace its data transfer rate. Sources for TREQ signals are internal (TIMERS) or external (DREQ, a Data Request from the system).
                ///  0x0 to 0x3a -> select DREQ n as TREQ
                TREQ_SEL: packed union {
                    raw: u6,
                    value: enum(u6) {
                        ///  Select Timer 0 as TREQ
                        TIMER0 = 0x3b,
                        ///  Select Timer 1 as TREQ
                        TIMER1 = 0x3c,
                        ///  Select Timer 2 as TREQ (Optional)
                        TIMER2 = 0x3d,
                        ///  Select Timer 3 as TREQ (Optional)
                        TIMER3 = 0x3e,
                        ///  Permanent request, for unpaced transfers.
                        PERMANENT = 0x3f,
                        _,
                    },
                },
                ///  In QUIET mode, the channel does not generate IRQs at the end of every transfer block. Instead, an IRQ is raised when NULL is written to a trigger register, indicating the end of a control block chain.
                ///  This reduces the number of interrupts to be serviced by the CPU when transferring a DMA chain of many small control blocks.
                IRQ_QUIET: u1,
                ///  Apply byte-swap transformation to DMA data.
                ///  For byte data, this has no effect. For halfword data, the two bytes of each halfword are swapped. For word data, the four bytes of each word are swapped to reverse order.
                BSWAP: u1,
                ///  If 1, this channel's data transfers are visible to the sniff hardware, and each transfer will advance the state of the checksum. This only applies if the sniff hardware is enabled, and has this channel selected.
                ///  This allows checksum to be enabled or disabled on a per-control- block basis.
                SNIFF_EN: u1,
                ///  This flag goes high when the channel starts a new transfer sequence, and low when the last transfer of that sequence completes. Clearing EN while BUSY is high pauses the channel, and BUSY will stay high while paused.
                ///  To terminate a sequence early (and clear the BUSY flag), see CHAN_ABORT.
                BUSY: u1,
                reserved29: u4,
                ///  If 1, the channel received a write bus error. Write one to clear.
                ///  WRITE_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 5 transfers later)
                WRITE_ERROR: u1,
                ///  If 1, the channel received a read bus error. Write one to clear.
                ///  READ_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 3 transfers later)
                READ_ERROR: u1,
                ///  Logical OR of the READ_ERROR and WRITE_ERROR flags. The channel halts when it encounters any bus error, and always raises its channel IRQ flag.
                AHB_ERROR: u1,
            }),
            ///  Alias for channel 0 CTRL register
            CH0_AL1_CTRL: u32,
            ///  Alias for channel 0 READ_ADDR register
            CH0_AL1_READ_ADDR: u32,
            ///  Alias for channel 0 WRITE_ADDR register
            CH0_AL1_WRITE_ADDR: u32,
            ///  Alias for channel 0 TRANS_COUNT register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH0_AL1_TRANS_COUNT_TRIG: u32,
            ///  Alias for channel 0 CTRL register
            CH0_AL2_CTRL: u32,
            ///  Alias for channel 0 TRANS_COUNT register
            CH0_AL2_TRANS_COUNT: u32,
            ///  Alias for channel 0 READ_ADDR register
            CH0_AL2_READ_ADDR: u32,
            ///  Alias for channel 0 WRITE_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH0_AL2_WRITE_ADDR_TRIG: u32,
            ///  Alias for channel 0 CTRL register
            CH0_AL3_CTRL: u32,
            ///  Alias for channel 0 WRITE_ADDR register
            CH0_AL3_WRITE_ADDR: u32,
            ///  Alias for channel 0 TRANS_COUNT register
            CH0_AL3_TRANS_COUNT: u32,
            ///  Alias for channel 0 READ_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH0_AL3_READ_ADDR_TRIG: u32,
            ///  DMA Channel 1 Read Address pointer
            ///  This register updates automatically each time a read completes. The current value is the next address to be read by this channel.
            CH1_READ_ADDR: u32,
            ///  DMA Channel 1 Write Address pointer
            ///  This register updates automatically each time a write completes. The current value is the next address to be written by this channel.
            CH1_WRITE_ADDR: u32,
            ///  DMA Channel 1 Transfer Count
            ///  Program the number of bus transfers a channel will perform before halting. Note that, if transfers are larger than one byte in size, this is not equal to the number of bytes transferred (see CTRL_DATA_SIZE).
            ///  When the channel is active, reading this register shows the number of transfers remaining, updating automatically each time a write transfer completes.
            ///  Writing this register sets the RELOAD value for the transfer counter. Each time this channel is triggered, the RELOAD value is copied into the live transfer counter. The channel can be started multiple times, and will perform the same number of transfers each time, as programmed by most recent write.
            ///  The RELOAD value can be observed at CHx_DBG_TCR. If TRANS_COUNT is used as a trigger, the written value is used immediately as the length of the new transfer sequence, as well as being written to RELOAD.
            CH1_TRANS_COUNT: u32,
            ///  DMA Channel 1 Control and Status
            CH1_CTRL_TRIG: mmio.Mmio(packed struct(u32) {
                ///  DMA Channel Enable.
                ///  When 1, the channel will respond to triggering events, which will cause it to become BUSY and start transferring data. When 0, the channel will ignore triggers, stop issuing transfers, and pause the current transfer sequence (i.e. BUSY will remain high if already high)
                EN: u1,
                ///  HIGH_PRIORITY gives a channel preferential treatment in issue scheduling: in each scheduling round, all high priority channels are considered first, and then only a single low priority channel, before returning to the high priority channels.
                ///  This only affects the order in which the DMA schedules channels. The DMA's bus priority is not changed. If the DMA is not saturated then a low priority channel will see no loss of throughput.
                HIGH_PRIORITY: u1,
                ///  Set the size of each bus transfer (byte/halfword/word). READ_ADDR and WRITE_ADDR advance by this amount (1/2/4 bytes) with each transfer.
                DATA_SIZE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        SIZE_BYTE = 0x0,
                        SIZE_HALFWORD = 0x1,
                        SIZE_WORD = 0x2,
                        _,
                    },
                },
                ///  If 1, the read address increments with each transfer. If 0, each read is directed to the same, initial address.
                ///  Generally this should be disabled for peripheral-to-memory transfers.
                INCR_READ: u1,
                ///  If 1, the write address increments with each transfer. If 0, each write is directed to the same, initial address.
                ///  Generally this should be disabled for memory-to-peripheral transfers.
                INCR_WRITE: u1,
                ///  Size of address wrap region. If 0, don't wrap. For values n > 0, only the lower n bits of the address will change. This wraps the address on a (1 << n) byte boundary, facilitating access to naturally-aligned ring buffers.
                ///  Ring sizes between 2 and 32768 bytes are possible. This can apply to either read or write addresses, based on value of RING_SEL.
                RING_SIZE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        RING_NONE = 0x0,
                        _,
                    },
                },
                ///  Select whether RING_SIZE applies to read or write addresses.
                ///  If 0, read addresses are wrapped on a (1 << RING_SIZE) boundary. If 1, write addresses are wrapped.
                RING_SEL: u1,
                ///  When this channel completes, it will trigger the channel indicated by CHAIN_TO. Disable by setting CHAIN_TO = _(this channel)_.
                CHAIN_TO: u4,
                ///  Select a Transfer Request signal.
                ///  The channel uses the transfer request signal to pace its data transfer rate. Sources for TREQ signals are internal (TIMERS) or external (DREQ, a Data Request from the system).
                ///  0x0 to 0x3a -> select DREQ n as TREQ
                TREQ_SEL: packed union {
                    raw: u6,
                    value: enum(u6) {
                        ///  Select Timer 0 as TREQ
                        TIMER0 = 0x3b,
                        ///  Select Timer 1 as TREQ
                        TIMER1 = 0x3c,
                        ///  Select Timer 2 as TREQ (Optional)
                        TIMER2 = 0x3d,
                        ///  Select Timer 3 as TREQ (Optional)
                        TIMER3 = 0x3e,
                        ///  Permanent request, for unpaced transfers.
                        PERMANENT = 0x3f,
                        _,
                    },
                },
                ///  In QUIET mode, the channel does not generate IRQs at the end of every transfer block. Instead, an IRQ is raised when NULL is written to a trigger register, indicating the end of a control block chain.
                ///  This reduces the number of interrupts to be serviced by the CPU when transferring a DMA chain of many small control blocks.
                IRQ_QUIET: u1,
                ///  Apply byte-swap transformation to DMA data.
                ///  For byte data, this has no effect. For halfword data, the two bytes of each halfword are swapped. For word data, the four bytes of each word are swapped to reverse order.
                BSWAP: u1,
                ///  If 1, this channel's data transfers are visible to the sniff hardware, and each transfer will advance the state of the checksum. This only applies if the sniff hardware is enabled, and has this channel selected.
                ///  This allows checksum to be enabled or disabled on a per-control- block basis.
                SNIFF_EN: u1,
                ///  This flag goes high when the channel starts a new transfer sequence, and low when the last transfer of that sequence completes. Clearing EN while BUSY is high pauses the channel, and BUSY will stay high while paused.
                ///  To terminate a sequence early (and clear the BUSY flag), see CHAN_ABORT.
                BUSY: u1,
                reserved29: u4,
                ///  If 1, the channel received a write bus error. Write one to clear.
                ///  WRITE_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 5 transfers later)
                WRITE_ERROR: u1,
                ///  If 1, the channel received a read bus error. Write one to clear.
                ///  READ_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 3 transfers later)
                READ_ERROR: u1,
                ///  Logical OR of the READ_ERROR and WRITE_ERROR flags. The channel halts when it encounters any bus error, and always raises its channel IRQ flag.
                AHB_ERROR: u1,
            }),
            ///  Alias for channel 1 CTRL register
            CH1_AL1_CTRL: u32,
            ///  Alias for channel 1 READ_ADDR register
            CH1_AL1_READ_ADDR: u32,
            ///  Alias for channel 1 WRITE_ADDR register
            CH1_AL1_WRITE_ADDR: u32,
            ///  Alias for channel 1 TRANS_COUNT register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH1_AL1_TRANS_COUNT_TRIG: u32,
            ///  Alias for channel 1 CTRL register
            CH1_AL2_CTRL: u32,
            ///  Alias for channel 1 TRANS_COUNT register
            CH1_AL2_TRANS_COUNT: u32,
            ///  Alias for channel 1 READ_ADDR register
            CH1_AL2_READ_ADDR: u32,
            ///  Alias for channel 1 WRITE_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH1_AL2_WRITE_ADDR_TRIG: u32,
            ///  Alias for channel 1 CTRL register
            CH1_AL3_CTRL: u32,
            ///  Alias for channel 1 WRITE_ADDR register
            CH1_AL3_WRITE_ADDR: u32,
            ///  Alias for channel 1 TRANS_COUNT register
            CH1_AL3_TRANS_COUNT: u32,
            ///  Alias for channel 1 READ_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH1_AL3_READ_ADDR_TRIG: u32,
            ///  DMA Channel 2 Read Address pointer
            ///  This register updates automatically each time a read completes. The current value is the next address to be read by this channel.
            CH2_READ_ADDR: u32,
            ///  DMA Channel 2 Write Address pointer
            ///  This register updates automatically each time a write completes. The current value is the next address to be written by this channel.
            CH2_WRITE_ADDR: u32,
            ///  DMA Channel 2 Transfer Count
            ///  Program the number of bus transfers a channel will perform before halting. Note that, if transfers are larger than one byte in size, this is not equal to the number of bytes transferred (see CTRL_DATA_SIZE).
            ///  When the channel is active, reading this register shows the number of transfers remaining, updating automatically each time a write transfer completes.
            ///  Writing this register sets the RELOAD value for the transfer counter. Each time this channel is triggered, the RELOAD value is copied into the live transfer counter. The channel can be started multiple times, and will perform the same number of transfers each time, as programmed by most recent write.
            ///  The RELOAD value can be observed at CHx_DBG_TCR. If TRANS_COUNT is used as a trigger, the written value is used immediately as the length of the new transfer sequence, as well as being written to RELOAD.
            CH2_TRANS_COUNT: u32,
            ///  DMA Channel 2 Control and Status
            CH2_CTRL_TRIG: mmio.Mmio(packed struct(u32) {
                ///  DMA Channel Enable.
                ///  When 1, the channel will respond to triggering events, which will cause it to become BUSY and start transferring data. When 0, the channel will ignore triggers, stop issuing transfers, and pause the current transfer sequence (i.e. BUSY will remain high if already high)
                EN: u1,
                ///  HIGH_PRIORITY gives a channel preferential treatment in issue scheduling: in each scheduling round, all high priority channels are considered first, and then only a single low priority channel, before returning to the high priority channels.
                ///  This only affects the order in which the DMA schedules channels. The DMA's bus priority is not changed. If the DMA is not saturated then a low priority channel will see no loss of throughput.
                HIGH_PRIORITY: u1,
                ///  Set the size of each bus transfer (byte/halfword/word). READ_ADDR and WRITE_ADDR advance by this amount (1/2/4 bytes) with each transfer.
                DATA_SIZE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        SIZE_BYTE = 0x0,
                        SIZE_HALFWORD = 0x1,
                        SIZE_WORD = 0x2,
                        _,
                    },
                },
                ///  If 1, the read address increments with each transfer. If 0, each read is directed to the same, initial address.
                ///  Generally this should be disabled for peripheral-to-memory transfers.
                INCR_READ: u1,
                ///  If 1, the write address increments with each transfer. If 0, each write is directed to the same, initial address.
                ///  Generally this should be disabled for memory-to-peripheral transfers.
                INCR_WRITE: u1,
                ///  Size of address wrap region. If 0, don't wrap. For values n > 0, only the lower n bits of the address will change. This wraps the address on a (1 << n) byte boundary, facilitating access to naturally-aligned ring buffers.
                ///  Ring sizes between 2 and 32768 bytes are possible. This can apply to either read or write addresses, based on value of RING_SEL.
                RING_SIZE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        RING_NONE = 0x0,
                        _,
                    },
                },
                ///  Select whether RING_SIZE applies to read or write addresses.
                ///  If 0, read addresses are wrapped on a (1 << RING_SIZE) boundary. If 1, write addresses are wrapped.
                RING_SEL: u1,
                ///  When this channel completes, it will trigger the channel indicated by CHAIN_TO. Disable by setting CHAIN_TO = _(this channel)_.
                CHAIN_TO: u4,
                ///  Select a Transfer Request signal.
                ///  The channel uses the transfer request signal to pace its data transfer rate. Sources for TREQ signals are internal (TIMERS) or external (DREQ, a Data Request from the system).
                ///  0x0 to 0x3a -> select DREQ n as TREQ
                TREQ_SEL: packed union {
                    raw: u6,
                    value: enum(u6) {
                        ///  Select Timer 0 as TREQ
                        TIMER0 = 0x3b,
                        ///  Select Timer 1 as TREQ
                        TIMER1 = 0x3c,
                        ///  Select Timer 2 as TREQ (Optional)
                        TIMER2 = 0x3d,
                        ///  Select Timer 3 as TREQ (Optional)
                        TIMER3 = 0x3e,
                        ///  Permanent request, for unpaced transfers.
                        PERMANENT = 0x3f,
                        _,
                    },
                },
                ///  In QUIET mode, the channel does not generate IRQs at the end of every transfer block. Instead, an IRQ is raised when NULL is written to a trigger register, indicating the end of a control block chain.
                ///  This reduces the number of interrupts to be serviced by the CPU when transferring a DMA chain of many small control blocks.
                IRQ_QUIET: u1,
                ///  Apply byte-swap transformation to DMA data.
                ///  For byte data, this has no effect. For halfword data, the two bytes of each halfword are swapped. For word data, the four bytes of each word are swapped to reverse order.
                BSWAP: u1,
                ///  If 1, this channel's data transfers are visible to the sniff hardware, and each transfer will advance the state of the checksum. This only applies if the sniff hardware is enabled, and has this channel selected.
                ///  This allows checksum to be enabled or disabled on a per-control- block basis.
                SNIFF_EN: u1,
                ///  This flag goes high when the channel starts a new transfer sequence, and low when the last transfer of that sequence completes. Clearing EN while BUSY is high pauses the channel, and BUSY will stay high while paused.
                ///  To terminate a sequence early (and clear the BUSY flag), see CHAN_ABORT.
                BUSY: u1,
                reserved29: u4,
                ///  If 1, the channel received a write bus error. Write one to clear.
                ///  WRITE_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 5 transfers later)
                WRITE_ERROR: u1,
                ///  If 1, the channel received a read bus error. Write one to clear.
                ///  READ_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 3 transfers later)
                READ_ERROR: u1,
                ///  Logical OR of the READ_ERROR and WRITE_ERROR flags. The channel halts when it encounters any bus error, and always raises its channel IRQ flag.
                AHB_ERROR: u1,
            }),
            ///  Alias for channel 2 CTRL register
            CH2_AL1_CTRL: u32,
            ///  Alias for channel 2 READ_ADDR register
            CH2_AL1_READ_ADDR: u32,
            ///  Alias for channel 2 WRITE_ADDR register
            CH2_AL1_WRITE_ADDR: u32,
            ///  Alias for channel 2 TRANS_COUNT register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH2_AL1_TRANS_COUNT_TRIG: u32,
            ///  Alias for channel 2 CTRL register
            CH2_AL2_CTRL: u32,
            ///  Alias for channel 2 TRANS_COUNT register
            CH2_AL2_TRANS_COUNT: u32,
            ///  Alias for channel 2 READ_ADDR register
            CH2_AL2_READ_ADDR: u32,
            ///  Alias for channel 2 WRITE_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH2_AL2_WRITE_ADDR_TRIG: u32,
            ///  Alias for channel 2 CTRL register
            CH2_AL3_CTRL: u32,
            ///  Alias for channel 2 WRITE_ADDR register
            CH2_AL3_WRITE_ADDR: u32,
            ///  Alias for channel 2 TRANS_COUNT register
            CH2_AL3_TRANS_COUNT: u32,
            ///  Alias for channel 2 READ_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH2_AL3_READ_ADDR_TRIG: u32,
            ///  DMA Channel 3 Read Address pointer
            ///  This register updates automatically each time a read completes. The current value is the next address to be read by this channel.
            CH3_READ_ADDR: u32,
            ///  DMA Channel 3 Write Address pointer
            ///  This register updates automatically each time a write completes. The current value is the next address to be written by this channel.
            CH3_WRITE_ADDR: u32,
            ///  DMA Channel 3 Transfer Count
            ///  Program the number of bus transfers a channel will perform before halting. Note that, if transfers are larger than one byte in size, this is not equal to the number of bytes transferred (see CTRL_DATA_SIZE).
            ///  When the channel is active, reading this register shows the number of transfers remaining, updating automatically each time a write transfer completes.
            ///  Writing this register sets the RELOAD value for the transfer counter. Each time this channel is triggered, the RELOAD value is copied into the live transfer counter. The channel can be started multiple times, and will perform the same number of transfers each time, as programmed by most recent write.
            ///  The RELOAD value can be observed at CHx_DBG_TCR. If TRANS_COUNT is used as a trigger, the written value is used immediately as the length of the new transfer sequence, as well as being written to RELOAD.
            CH3_TRANS_COUNT: u32,
            ///  DMA Channel 3 Control and Status
            CH3_CTRL_TRIG: mmio.Mmio(packed struct(u32) {
                ///  DMA Channel Enable.
                ///  When 1, the channel will respond to triggering events, which will cause it to become BUSY and start transferring data. When 0, the channel will ignore triggers, stop issuing transfers, and pause the current transfer sequence (i.e. BUSY will remain high if already high)
                EN: u1,
                ///  HIGH_PRIORITY gives a channel preferential treatment in issue scheduling: in each scheduling round, all high priority channels are considered first, and then only a single low priority channel, before returning to the high priority channels.
                ///  This only affects the order in which the DMA schedules channels. The DMA's bus priority is not changed. If the DMA is not saturated then a low priority channel will see no loss of throughput.
                HIGH_PRIORITY: u1,
                ///  Set the size of each bus transfer (byte/halfword/word). READ_ADDR and WRITE_ADDR advance by this amount (1/2/4 bytes) with each transfer.
                DATA_SIZE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        SIZE_BYTE = 0x0,
                        SIZE_HALFWORD = 0x1,
                        SIZE_WORD = 0x2,
                        _,
                    },
                },
                ///  If 1, the read address increments with each transfer. If 0, each read is directed to the same, initial address.
                ///  Generally this should be disabled for peripheral-to-memory transfers.
                INCR_READ: u1,
                ///  If 1, the write address increments with each transfer. If 0, each write is directed to the same, initial address.
                ///  Generally this should be disabled for memory-to-peripheral transfers.
                INCR_WRITE: u1,
                ///  Size of address wrap region. If 0, don't wrap. For values n > 0, only the lower n bits of the address will change. This wraps the address on a (1 << n) byte boundary, facilitating access to naturally-aligned ring buffers.
                ///  Ring sizes between 2 and 32768 bytes are possible. This can apply to either read or write addresses, based on value of RING_SEL.
                RING_SIZE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        RING_NONE = 0x0,
                        _,
                    },
                },
                ///  Select whether RING_SIZE applies to read or write addresses.
                ///  If 0, read addresses are wrapped on a (1 << RING_SIZE) boundary. If 1, write addresses are wrapped.
                RING_SEL: u1,
                ///  When this channel completes, it will trigger the channel indicated by CHAIN_TO. Disable by setting CHAIN_TO = _(this channel)_.
                CHAIN_TO: u4,
                ///  Select a Transfer Request signal.
                ///  The channel uses the transfer request signal to pace its data transfer rate. Sources for TREQ signals are internal (TIMERS) or external (DREQ, a Data Request from the system).
                ///  0x0 to 0x3a -> select DREQ n as TREQ
                TREQ_SEL: packed union {
                    raw: u6,
                    value: enum(u6) {
                        ///  Select Timer 0 as TREQ
                        TIMER0 = 0x3b,
                        ///  Select Timer 1 as TREQ
                        TIMER1 = 0x3c,
                        ///  Select Timer 2 as TREQ (Optional)
                        TIMER2 = 0x3d,
                        ///  Select Timer 3 as TREQ (Optional)
                        TIMER3 = 0x3e,
                        ///  Permanent request, for unpaced transfers.
                        PERMANENT = 0x3f,
                        _,
                    },
                },
                ///  In QUIET mode, the channel does not generate IRQs at the end of every transfer block. Instead, an IRQ is raised when NULL is written to a trigger register, indicating the end of a control block chain.
                ///  This reduces the number of interrupts to be serviced by the CPU when transferring a DMA chain of many small control blocks.
                IRQ_QUIET: u1,
                ///  Apply byte-swap transformation to DMA data.
                ///  For byte data, this has no effect. For halfword data, the two bytes of each halfword are swapped. For word data, the four bytes of each word are swapped to reverse order.
                BSWAP: u1,
                ///  If 1, this channel's data transfers are visible to the sniff hardware, and each transfer will advance the state of the checksum. This only applies if the sniff hardware is enabled, and has this channel selected.
                ///  This allows checksum to be enabled or disabled on a per-control- block basis.
                SNIFF_EN: u1,
                ///  This flag goes high when the channel starts a new transfer sequence, and low when the last transfer of that sequence completes. Clearing EN while BUSY is high pauses the channel, and BUSY will stay high while paused.
                ///  To terminate a sequence early (and clear the BUSY flag), see CHAN_ABORT.
                BUSY: u1,
                reserved29: u4,
                ///  If 1, the channel received a write bus error. Write one to clear.
                ///  WRITE_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 5 transfers later)
                WRITE_ERROR: u1,
                ///  If 1, the channel received a read bus error. Write one to clear.
                ///  READ_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 3 transfers later)
                READ_ERROR: u1,
                ///  Logical OR of the READ_ERROR and WRITE_ERROR flags. The channel halts when it encounters any bus error, and always raises its channel IRQ flag.
                AHB_ERROR: u1,
            }),
            ///  Alias for channel 3 CTRL register
            CH3_AL1_CTRL: u32,
            ///  Alias for channel 3 READ_ADDR register
            CH3_AL1_READ_ADDR: u32,
            ///  Alias for channel 3 WRITE_ADDR register
            CH3_AL1_WRITE_ADDR: u32,
            ///  Alias for channel 3 TRANS_COUNT register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH3_AL1_TRANS_COUNT_TRIG: u32,
            ///  Alias for channel 3 CTRL register
            CH3_AL2_CTRL: u32,
            ///  Alias for channel 3 TRANS_COUNT register
            CH3_AL2_TRANS_COUNT: u32,
            ///  Alias for channel 3 READ_ADDR register
            CH3_AL2_READ_ADDR: u32,
            ///  Alias for channel 3 WRITE_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH3_AL2_WRITE_ADDR_TRIG: u32,
            ///  Alias for channel 3 CTRL register
            CH3_AL3_CTRL: u32,
            ///  Alias for channel 3 WRITE_ADDR register
            CH3_AL3_WRITE_ADDR: u32,
            ///  Alias for channel 3 TRANS_COUNT register
            CH3_AL3_TRANS_COUNT: u32,
            ///  Alias for channel 3 READ_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH3_AL3_READ_ADDR_TRIG: u32,
            ///  DMA Channel 4 Read Address pointer
            ///  This register updates automatically each time a read completes. The current value is the next address to be read by this channel.
            CH4_READ_ADDR: u32,
            ///  DMA Channel 4 Write Address pointer
            ///  This register updates automatically each time a write completes. The current value is the next address to be written by this channel.
            CH4_WRITE_ADDR: u32,
            ///  DMA Channel 4 Transfer Count
            ///  Program the number of bus transfers a channel will perform before halting. Note that, if transfers are larger than one byte in size, this is not equal to the number of bytes transferred (see CTRL_DATA_SIZE).
            ///  When the channel is active, reading this register shows the number of transfers remaining, updating automatically each time a write transfer completes.
            ///  Writing this register sets the RELOAD value for the transfer counter. Each time this channel is triggered, the RELOAD value is copied into the live transfer counter. The channel can be started multiple times, and will perform the same number of transfers each time, as programmed by most recent write.
            ///  The RELOAD value can be observed at CHx_DBG_TCR. If TRANS_COUNT is used as a trigger, the written value is used immediately as the length of the new transfer sequence, as well as being written to RELOAD.
            CH4_TRANS_COUNT: u32,
            ///  DMA Channel 4 Control and Status
            CH4_CTRL_TRIG: mmio.Mmio(packed struct(u32) {
                ///  DMA Channel Enable.
                ///  When 1, the channel will respond to triggering events, which will cause it to become BUSY and start transferring data. When 0, the channel will ignore triggers, stop issuing transfers, and pause the current transfer sequence (i.e. BUSY will remain high if already high)
                EN: u1,
                ///  HIGH_PRIORITY gives a channel preferential treatment in issue scheduling: in each scheduling round, all high priority channels are considered first, and then only a single low priority channel, before returning to the high priority channels.
                ///  This only affects the order in which the DMA schedules channels. The DMA's bus priority is not changed. If the DMA is not saturated then a low priority channel will see no loss of throughput.
                HIGH_PRIORITY: u1,
                ///  Set the size of each bus transfer (byte/halfword/word). READ_ADDR and WRITE_ADDR advance by this amount (1/2/4 bytes) with each transfer.
                DATA_SIZE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        SIZE_BYTE = 0x0,
                        SIZE_HALFWORD = 0x1,
                        SIZE_WORD = 0x2,
                        _,
                    },
                },
                ///  If 1, the read address increments with each transfer. If 0, each read is directed to the same, initial address.
                ///  Generally this should be disabled for peripheral-to-memory transfers.
                INCR_READ: u1,
                ///  If 1, the write address increments with each transfer. If 0, each write is directed to the same, initial address.
                ///  Generally this should be disabled for memory-to-peripheral transfers.
                INCR_WRITE: u1,
                ///  Size of address wrap region. If 0, don't wrap. For values n > 0, only the lower n bits of the address will change. This wraps the address on a (1 << n) byte boundary, facilitating access to naturally-aligned ring buffers.
                ///  Ring sizes between 2 and 32768 bytes are possible. This can apply to either read or write addresses, based on value of RING_SEL.
                RING_SIZE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        RING_NONE = 0x0,
                        _,
                    },
                },
                ///  Select whether RING_SIZE applies to read or write addresses.
                ///  If 0, read addresses are wrapped on a (1 << RING_SIZE) boundary. If 1, write addresses are wrapped.
                RING_SEL: u1,
                ///  When this channel completes, it will trigger the channel indicated by CHAIN_TO. Disable by setting CHAIN_TO = _(this channel)_.
                CHAIN_TO: u4,
                ///  Select a Transfer Request signal.
                ///  The channel uses the transfer request signal to pace its data transfer rate. Sources for TREQ signals are internal (TIMERS) or external (DREQ, a Data Request from the system).
                ///  0x0 to 0x3a -> select DREQ n as TREQ
                TREQ_SEL: packed union {
                    raw: u6,
                    value: enum(u6) {
                        ///  Select Timer 0 as TREQ
                        TIMER0 = 0x3b,
                        ///  Select Timer 1 as TREQ
                        TIMER1 = 0x3c,
                        ///  Select Timer 2 as TREQ (Optional)
                        TIMER2 = 0x3d,
                        ///  Select Timer 3 as TREQ (Optional)
                        TIMER3 = 0x3e,
                        ///  Permanent request, for unpaced transfers.
                        PERMANENT = 0x3f,
                        _,
                    },
                },
                ///  In QUIET mode, the channel does not generate IRQs at the end of every transfer block. Instead, an IRQ is raised when NULL is written to a trigger register, indicating the end of a control block chain.
                ///  This reduces the number of interrupts to be serviced by the CPU when transferring a DMA chain of many small control blocks.
                IRQ_QUIET: u1,
                ///  Apply byte-swap transformation to DMA data.
                ///  For byte data, this has no effect. For halfword data, the two bytes of each halfword are swapped. For word data, the four bytes of each word are swapped to reverse order.
                BSWAP: u1,
                ///  If 1, this channel's data transfers are visible to the sniff hardware, and each transfer will advance the state of the checksum. This only applies if the sniff hardware is enabled, and has this channel selected.
                ///  This allows checksum to be enabled or disabled on a per-control- block basis.
                SNIFF_EN: u1,
                ///  This flag goes high when the channel starts a new transfer sequence, and low when the last transfer of that sequence completes. Clearing EN while BUSY is high pauses the channel, and BUSY will stay high while paused.
                ///  To terminate a sequence early (and clear the BUSY flag), see CHAN_ABORT.
                BUSY: u1,
                reserved29: u4,
                ///  If 1, the channel received a write bus error. Write one to clear.
                ///  WRITE_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 5 transfers later)
                WRITE_ERROR: u1,
                ///  If 1, the channel received a read bus error. Write one to clear.
                ///  READ_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 3 transfers later)
                READ_ERROR: u1,
                ///  Logical OR of the READ_ERROR and WRITE_ERROR flags. The channel halts when it encounters any bus error, and always raises its channel IRQ flag.
                AHB_ERROR: u1,
            }),
            ///  Alias for channel 4 CTRL register
            CH4_AL1_CTRL: u32,
            ///  Alias for channel 4 READ_ADDR register
            CH4_AL1_READ_ADDR: u32,
            ///  Alias for channel 4 WRITE_ADDR register
            CH4_AL1_WRITE_ADDR: u32,
            ///  Alias for channel 4 TRANS_COUNT register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH4_AL1_TRANS_COUNT_TRIG: u32,
            ///  Alias for channel 4 CTRL register
            CH4_AL2_CTRL: u32,
            ///  Alias for channel 4 TRANS_COUNT register
            CH4_AL2_TRANS_COUNT: u32,
            ///  Alias for channel 4 READ_ADDR register
            CH4_AL2_READ_ADDR: u32,
            ///  Alias for channel 4 WRITE_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH4_AL2_WRITE_ADDR_TRIG: u32,
            ///  Alias for channel 4 CTRL register
            CH4_AL3_CTRL: u32,
            ///  Alias for channel 4 WRITE_ADDR register
            CH4_AL3_WRITE_ADDR: u32,
            ///  Alias for channel 4 TRANS_COUNT register
            CH4_AL3_TRANS_COUNT: u32,
            ///  Alias for channel 4 READ_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH4_AL3_READ_ADDR_TRIG: u32,
            ///  DMA Channel 5 Read Address pointer
            ///  This register updates automatically each time a read completes. The current value is the next address to be read by this channel.
            CH5_READ_ADDR: u32,
            ///  DMA Channel 5 Write Address pointer
            ///  This register updates automatically each time a write completes. The current value is the next address to be written by this channel.
            CH5_WRITE_ADDR: u32,
            ///  DMA Channel 5 Transfer Count
            ///  Program the number of bus transfers a channel will perform before halting. Note that, if transfers are larger than one byte in size, this is not equal to the number of bytes transferred (see CTRL_DATA_SIZE).
            ///  When the channel is active, reading this register shows the number of transfers remaining, updating automatically each time a write transfer completes.
            ///  Writing this register sets the RELOAD value for the transfer counter. Each time this channel is triggered, the RELOAD value is copied into the live transfer counter. The channel can be started multiple times, and will perform the same number of transfers each time, as programmed by most recent write.
            ///  The RELOAD value can be observed at CHx_DBG_TCR. If TRANS_COUNT is used as a trigger, the written value is used immediately as the length of the new transfer sequence, as well as being written to RELOAD.
            CH5_TRANS_COUNT: u32,
            ///  DMA Channel 5 Control and Status
            CH5_CTRL_TRIG: mmio.Mmio(packed struct(u32) {
                ///  DMA Channel Enable.
                ///  When 1, the channel will respond to triggering events, which will cause it to become BUSY and start transferring data. When 0, the channel will ignore triggers, stop issuing transfers, and pause the current transfer sequence (i.e. BUSY will remain high if already high)
                EN: u1,
                ///  HIGH_PRIORITY gives a channel preferential treatment in issue scheduling: in each scheduling round, all high priority channels are considered first, and then only a single low priority channel, before returning to the high priority channels.
                ///  This only affects the order in which the DMA schedules channels. The DMA's bus priority is not changed. If the DMA is not saturated then a low priority channel will see no loss of throughput.
                HIGH_PRIORITY: u1,
                ///  Set the size of each bus transfer (byte/halfword/word). READ_ADDR and WRITE_ADDR advance by this amount (1/2/4 bytes) with each transfer.
                DATA_SIZE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        SIZE_BYTE = 0x0,
                        SIZE_HALFWORD = 0x1,
                        SIZE_WORD = 0x2,
                        _,
                    },
                },
                ///  If 1, the read address increments with each transfer. If 0, each read is directed to the same, initial address.
                ///  Generally this should be disabled for peripheral-to-memory transfers.
                INCR_READ: u1,
                ///  If 1, the write address increments with each transfer. If 0, each write is directed to the same, initial address.
                ///  Generally this should be disabled for memory-to-peripheral transfers.
                INCR_WRITE: u1,
                ///  Size of address wrap region. If 0, don't wrap. For values n > 0, only the lower n bits of the address will change. This wraps the address on a (1 << n) byte boundary, facilitating access to naturally-aligned ring buffers.
                ///  Ring sizes between 2 and 32768 bytes are possible. This can apply to either read or write addresses, based on value of RING_SEL.
                RING_SIZE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        RING_NONE = 0x0,
                        _,
                    },
                },
                ///  Select whether RING_SIZE applies to read or write addresses.
                ///  If 0, read addresses are wrapped on a (1 << RING_SIZE) boundary. If 1, write addresses are wrapped.
                RING_SEL: u1,
                ///  When this channel completes, it will trigger the channel indicated by CHAIN_TO. Disable by setting CHAIN_TO = _(this channel)_.
                CHAIN_TO: u4,
                ///  Select a Transfer Request signal.
                ///  The channel uses the transfer request signal to pace its data transfer rate. Sources for TREQ signals are internal (TIMERS) or external (DREQ, a Data Request from the system).
                ///  0x0 to 0x3a -> select DREQ n as TREQ
                TREQ_SEL: packed union {
                    raw: u6,
                    value: enum(u6) {
                        ///  Select Timer 0 as TREQ
                        TIMER0 = 0x3b,
                        ///  Select Timer 1 as TREQ
                        TIMER1 = 0x3c,
                        ///  Select Timer 2 as TREQ (Optional)
                        TIMER2 = 0x3d,
                        ///  Select Timer 3 as TREQ (Optional)
                        TIMER3 = 0x3e,
                        ///  Permanent request, for unpaced transfers.
                        PERMANENT = 0x3f,
                        _,
                    },
                },
                ///  In QUIET mode, the channel does not generate IRQs at the end of every transfer block. Instead, an IRQ is raised when NULL is written to a trigger register, indicating the end of a control block chain.
                ///  This reduces the number of interrupts to be serviced by the CPU when transferring a DMA chain of many small control blocks.
                IRQ_QUIET: u1,
                ///  Apply byte-swap transformation to DMA data.
                ///  For byte data, this has no effect. For halfword data, the two bytes of each halfword are swapped. For word data, the four bytes of each word are swapped to reverse order.
                BSWAP: u1,
                ///  If 1, this channel's data transfers are visible to the sniff hardware, and each transfer will advance the state of the checksum. This only applies if the sniff hardware is enabled, and has this channel selected.
                ///  This allows checksum to be enabled or disabled on a per-control- block basis.
                SNIFF_EN: u1,
                ///  This flag goes high when the channel starts a new transfer sequence, and low when the last transfer of that sequence completes. Clearing EN while BUSY is high pauses the channel, and BUSY will stay high while paused.
                ///  To terminate a sequence early (and clear the BUSY flag), see CHAN_ABORT.
                BUSY: u1,
                reserved29: u4,
                ///  If 1, the channel received a write bus error. Write one to clear.
                ///  WRITE_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 5 transfers later)
                WRITE_ERROR: u1,
                ///  If 1, the channel received a read bus error. Write one to clear.
                ///  READ_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 3 transfers later)
                READ_ERROR: u1,
                ///  Logical OR of the READ_ERROR and WRITE_ERROR flags. The channel halts when it encounters any bus error, and always raises its channel IRQ flag.
                AHB_ERROR: u1,
            }),
            ///  Alias for channel 5 CTRL register
            CH5_AL1_CTRL: u32,
            ///  Alias for channel 5 READ_ADDR register
            CH5_AL1_READ_ADDR: u32,
            ///  Alias for channel 5 WRITE_ADDR register
            CH5_AL1_WRITE_ADDR: u32,
            ///  Alias for channel 5 TRANS_COUNT register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH5_AL1_TRANS_COUNT_TRIG: u32,
            ///  Alias for channel 5 CTRL register
            CH5_AL2_CTRL: u32,
            ///  Alias for channel 5 TRANS_COUNT register
            CH5_AL2_TRANS_COUNT: u32,
            ///  Alias for channel 5 READ_ADDR register
            CH5_AL2_READ_ADDR: u32,
            ///  Alias for channel 5 WRITE_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH5_AL2_WRITE_ADDR_TRIG: u32,
            ///  Alias for channel 5 CTRL register
            CH5_AL3_CTRL: u32,
            ///  Alias for channel 5 WRITE_ADDR register
            CH5_AL3_WRITE_ADDR: u32,
            ///  Alias for channel 5 TRANS_COUNT register
            CH5_AL3_TRANS_COUNT: u32,
            ///  Alias for channel 5 READ_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH5_AL3_READ_ADDR_TRIG: u32,
            ///  DMA Channel 6 Read Address pointer
            ///  This register updates automatically each time a read completes. The current value is the next address to be read by this channel.
            CH6_READ_ADDR: u32,
            ///  DMA Channel 6 Write Address pointer
            ///  This register updates automatically each time a write completes. The current value is the next address to be written by this channel.
            CH6_WRITE_ADDR: u32,
            ///  DMA Channel 6 Transfer Count
            ///  Program the number of bus transfers a channel will perform before halting. Note that, if transfers are larger than one byte in size, this is not equal to the number of bytes transferred (see CTRL_DATA_SIZE).
            ///  When the channel is active, reading this register shows the number of transfers remaining, updating automatically each time a write transfer completes.
            ///  Writing this register sets the RELOAD value for the transfer counter. Each time this channel is triggered, the RELOAD value is copied into the live transfer counter. The channel can be started multiple times, and will perform the same number of transfers each time, as programmed by most recent write.
            ///  The RELOAD value can be observed at CHx_DBG_TCR. If TRANS_COUNT is used as a trigger, the written value is used immediately as the length of the new transfer sequence, as well as being written to RELOAD.
            CH6_TRANS_COUNT: u32,
            ///  DMA Channel 6 Control and Status
            CH6_CTRL_TRIG: mmio.Mmio(packed struct(u32) {
                ///  DMA Channel Enable.
                ///  When 1, the channel will respond to triggering events, which will cause it to become BUSY and start transferring data. When 0, the channel will ignore triggers, stop issuing transfers, and pause the current transfer sequence (i.e. BUSY will remain high if already high)
                EN: u1,
                ///  HIGH_PRIORITY gives a channel preferential treatment in issue scheduling: in each scheduling round, all high priority channels are considered first, and then only a single low priority channel, before returning to the high priority channels.
                ///  This only affects the order in which the DMA schedules channels. The DMA's bus priority is not changed. If the DMA is not saturated then a low priority channel will see no loss of throughput.
                HIGH_PRIORITY: u1,
                ///  Set the size of each bus transfer (byte/halfword/word). READ_ADDR and WRITE_ADDR advance by this amount (1/2/4 bytes) with each transfer.
                DATA_SIZE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        SIZE_BYTE = 0x0,
                        SIZE_HALFWORD = 0x1,
                        SIZE_WORD = 0x2,
                        _,
                    },
                },
                ///  If 1, the read address increments with each transfer. If 0, each read is directed to the same, initial address.
                ///  Generally this should be disabled for peripheral-to-memory transfers.
                INCR_READ: u1,
                ///  If 1, the write address increments with each transfer. If 0, each write is directed to the same, initial address.
                ///  Generally this should be disabled for memory-to-peripheral transfers.
                INCR_WRITE: u1,
                ///  Size of address wrap region. If 0, don't wrap. For values n > 0, only the lower n bits of the address will change. This wraps the address on a (1 << n) byte boundary, facilitating access to naturally-aligned ring buffers.
                ///  Ring sizes between 2 and 32768 bytes are possible. This can apply to either read or write addresses, based on value of RING_SEL.
                RING_SIZE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        RING_NONE = 0x0,
                        _,
                    },
                },
                ///  Select whether RING_SIZE applies to read or write addresses.
                ///  If 0, read addresses are wrapped on a (1 << RING_SIZE) boundary. If 1, write addresses are wrapped.
                RING_SEL: u1,
                ///  When this channel completes, it will trigger the channel indicated by CHAIN_TO. Disable by setting CHAIN_TO = _(this channel)_.
                CHAIN_TO: u4,
                ///  Select a Transfer Request signal.
                ///  The channel uses the transfer request signal to pace its data transfer rate. Sources for TREQ signals are internal (TIMERS) or external (DREQ, a Data Request from the system).
                ///  0x0 to 0x3a -> select DREQ n as TREQ
                TREQ_SEL: packed union {
                    raw: u6,
                    value: enum(u6) {
                        ///  Select Timer 0 as TREQ
                        TIMER0 = 0x3b,
                        ///  Select Timer 1 as TREQ
                        TIMER1 = 0x3c,
                        ///  Select Timer 2 as TREQ (Optional)
                        TIMER2 = 0x3d,
                        ///  Select Timer 3 as TREQ (Optional)
                        TIMER3 = 0x3e,
                        ///  Permanent request, for unpaced transfers.
                        PERMANENT = 0x3f,
                        _,
                    },
                },
                ///  In QUIET mode, the channel does not generate IRQs at the end of every transfer block. Instead, an IRQ is raised when NULL is written to a trigger register, indicating the end of a control block chain.
                ///  This reduces the number of interrupts to be serviced by the CPU when transferring a DMA chain of many small control blocks.
                IRQ_QUIET: u1,
                ///  Apply byte-swap transformation to DMA data.
                ///  For byte data, this has no effect. For halfword data, the two bytes of each halfword are swapped. For word data, the four bytes of each word are swapped to reverse order.
                BSWAP: u1,
                ///  If 1, this channel's data transfers are visible to the sniff hardware, and each transfer will advance the state of the checksum. This only applies if the sniff hardware is enabled, and has this channel selected.
                ///  This allows checksum to be enabled or disabled on a per-control- block basis.
                SNIFF_EN: u1,
                ///  This flag goes high when the channel starts a new transfer sequence, and low when the last transfer of that sequence completes. Clearing EN while BUSY is high pauses the channel, and BUSY will stay high while paused.
                ///  To terminate a sequence early (and clear the BUSY flag), see CHAN_ABORT.
                BUSY: u1,
                reserved29: u4,
                ///  If 1, the channel received a write bus error. Write one to clear.
                ///  WRITE_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 5 transfers later)
                WRITE_ERROR: u1,
                ///  If 1, the channel received a read bus error. Write one to clear.
                ///  READ_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 3 transfers later)
                READ_ERROR: u1,
                ///  Logical OR of the READ_ERROR and WRITE_ERROR flags. The channel halts when it encounters any bus error, and always raises its channel IRQ flag.
                AHB_ERROR: u1,
            }),
            ///  Alias for channel 6 CTRL register
            CH6_AL1_CTRL: u32,
            ///  Alias for channel 6 READ_ADDR register
            CH6_AL1_READ_ADDR: u32,
            ///  Alias for channel 6 WRITE_ADDR register
            CH6_AL1_WRITE_ADDR: u32,
            ///  Alias for channel 6 TRANS_COUNT register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH6_AL1_TRANS_COUNT_TRIG: u32,
            ///  Alias for channel 6 CTRL register
            CH6_AL2_CTRL: u32,
            ///  Alias for channel 6 TRANS_COUNT register
            CH6_AL2_TRANS_COUNT: u32,
            ///  Alias for channel 6 READ_ADDR register
            CH6_AL2_READ_ADDR: u32,
            ///  Alias for channel 6 WRITE_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH6_AL2_WRITE_ADDR_TRIG: u32,
            ///  Alias for channel 6 CTRL register
            CH6_AL3_CTRL: u32,
            ///  Alias for channel 6 WRITE_ADDR register
            CH6_AL3_WRITE_ADDR: u32,
            ///  Alias for channel 6 TRANS_COUNT register
            CH6_AL3_TRANS_COUNT: u32,
            ///  Alias for channel 6 READ_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH6_AL3_READ_ADDR_TRIG: u32,
            ///  DMA Channel 7 Read Address pointer
            ///  This register updates automatically each time a read completes. The current value is the next address to be read by this channel.
            CH7_READ_ADDR: u32,
            ///  DMA Channel 7 Write Address pointer
            ///  This register updates automatically each time a write completes. The current value is the next address to be written by this channel.
            CH7_WRITE_ADDR: u32,
            ///  DMA Channel 7 Transfer Count
            ///  Program the number of bus transfers a channel will perform before halting. Note that, if transfers are larger than one byte in size, this is not equal to the number of bytes transferred (see CTRL_DATA_SIZE).
            ///  When the channel is active, reading this register shows the number of transfers remaining, updating automatically each time a write transfer completes.
            ///  Writing this register sets the RELOAD value for the transfer counter. Each time this channel is triggered, the RELOAD value is copied into the live transfer counter. The channel can be started multiple times, and will perform the same number of transfers each time, as programmed by most recent write.
            ///  The RELOAD value can be observed at CHx_DBG_TCR. If TRANS_COUNT is used as a trigger, the written value is used immediately as the length of the new transfer sequence, as well as being written to RELOAD.
            CH7_TRANS_COUNT: u32,
            ///  DMA Channel 7 Control and Status
            CH7_CTRL_TRIG: mmio.Mmio(packed struct(u32) {
                ///  DMA Channel Enable.
                ///  When 1, the channel will respond to triggering events, which will cause it to become BUSY and start transferring data. When 0, the channel will ignore triggers, stop issuing transfers, and pause the current transfer sequence (i.e. BUSY will remain high if already high)
                EN: u1,
                ///  HIGH_PRIORITY gives a channel preferential treatment in issue scheduling: in each scheduling round, all high priority channels are considered first, and then only a single low priority channel, before returning to the high priority channels.
                ///  This only affects the order in which the DMA schedules channels. The DMA's bus priority is not changed. If the DMA is not saturated then a low priority channel will see no loss of throughput.
                HIGH_PRIORITY: u1,
                ///  Set the size of each bus transfer (byte/halfword/word). READ_ADDR and WRITE_ADDR advance by this amount (1/2/4 bytes) with each transfer.
                DATA_SIZE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        SIZE_BYTE = 0x0,
                        SIZE_HALFWORD = 0x1,
                        SIZE_WORD = 0x2,
                        _,
                    },
                },
                ///  If 1, the read address increments with each transfer. If 0, each read is directed to the same, initial address.
                ///  Generally this should be disabled for peripheral-to-memory transfers.
                INCR_READ: u1,
                ///  If 1, the write address increments with each transfer. If 0, each write is directed to the same, initial address.
                ///  Generally this should be disabled for memory-to-peripheral transfers.
                INCR_WRITE: u1,
                ///  Size of address wrap region. If 0, don't wrap. For values n > 0, only the lower n bits of the address will change. This wraps the address on a (1 << n) byte boundary, facilitating access to naturally-aligned ring buffers.
                ///  Ring sizes between 2 and 32768 bytes are possible. This can apply to either read or write addresses, based on value of RING_SEL.
                RING_SIZE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        RING_NONE = 0x0,
                        _,
                    },
                },
                ///  Select whether RING_SIZE applies to read or write addresses.
                ///  If 0, read addresses are wrapped on a (1 << RING_SIZE) boundary. If 1, write addresses are wrapped.
                RING_SEL: u1,
                ///  When this channel completes, it will trigger the channel indicated by CHAIN_TO. Disable by setting CHAIN_TO = _(this channel)_.
                CHAIN_TO: u4,
                ///  Select a Transfer Request signal.
                ///  The channel uses the transfer request signal to pace its data transfer rate. Sources for TREQ signals are internal (TIMERS) or external (DREQ, a Data Request from the system).
                ///  0x0 to 0x3a -> select DREQ n as TREQ
                TREQ_SEL: packed union {
                    raw: u6,
                    value: enum(u6) {
                        ///  Select Timer 0 as TREQ
                        TIMER0 = 0x3b,
                        ///  Select Timer 1 as TREQ
                        TIMER1 = 0x3c,
                        ///  Select Timer 2 as TREQ (Optional)
                        TIMER2 = 0x3d,
                        ///  Select Timer 3 as TREQ (Optional)
                        TIMER3 = 0x3e,
                        ///  Permanent request, for unpaced transfers.
                        PERMANENT = 0x3f,
                        _,
                    },
                },
                ///  In QUIET mode, the channel does not generate IRQs at the end of every transfer block. Instead, an IRQ is raised when NULL is written to a trigger register, indicating the end of a control block chain.
                ///  This reduces the number of interrupts to be serviced by the CPU when transferring a DMA chain of many small control blocks.
                IRQ_QUIET: u1,
                ///  Apply byte-swap transformation to DMA data.
                ///  For byte data, this has no effect. For halfword data, the two bytes of each halfword are swapped. For word data, the four bytes of each word are swapped to reverse order.
                BSWAP: u1,
                ///  If 1, this channel's data transfers are visible to the sniff hardware, and each transfer will advance the state of the checksum. This only applies if the sniff hardware is enabled, and has this channel selected.
                ///  This allows checksum to be enabled or disabled on a per-control- block basis.
                SNIFF_EN: u1,
                ///  This flag goes high when the channel starts a new transfer sequence, and low when the last transfer of that sequence completes. Clearing EN while BUSY is high pauses the channel, and BUSY will stay high while paused.
                ///  To terminate a sequence early (and clear the BUSY flag), see CHAN_ABORT.
                BUSY: u1,
                reserved29: u4,
                ///  If 1, the channel received a write bus error. Write one to clear.
                ///  WRITE_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 5 transfers later)
                WRITE_ERROR: u1,
                ///  If 1, the channel received a read bus error. Write one to clear.
                ///  READ_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 3 transfers later)
                READ_ERROR: u1,
                ///  Logical OR of the READ_ERROR and WRITE_ERROR flags. The channel halts when it encounters any bus error, and always raises its channel IRQ flag.
                AHB_ERROR: u1,
            }),
            ///  Alias for channel 7 CTRL register
            CH7_AL1_CTRL: u32,
            ///  Alias for channel 7 READ_ADDR register
            CH7_AL1_READ_ADDR: u32,
            ///  Alias for channel 7 WRITE_ADDR register
            CH7_AL1_WRITE_ADDR: u32,
            ///  Alias for channel 7 TRANS_COUNT register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH7_AL1_TRANS_COUNT_TRIG: u32,
            ///  Alias for channel 7 CTRL register
            CH7_AL2_CTRL: u32,
            ///  Alias for channel 7 TRANS_COUNT register
            CH7_AL2_TRANS_COUNT: u32,
            ///  Alias for channel 7 READ_ADDR register
            CH7_AL2_READ_ADDR: u32,
            ///  Alias for channel 7 WRITE_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH7_AL2_WRITE_ADDR_TRIG: u32,
            ///  Alias for channel 7 CTRL register
            CH7_AL3_CTRL: u32,
            ///  Alias for channel 7 WRITE_ADDR register
            CH7_AL3_WRITE_ADDR: u32,
            ///  Alias for channel 7 TRANS_COUNT register
            CH7_AL3_TRANS_COUNT: u32,
            ///  Alias for channel 7 READ_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH7_AL3_READ_ADDR_TRIG: u32,
            ///  DMA Channel 8 Read Address pointer
            ///  This register updates automatically each time a read completes. The current value is the next address to be read by this channel.
            CH8_READ_ADDR: u32,
            ///  DMA Channel 8 Write Address pointer
            ///  This register updates automatically each time a write completes. The current value is the next address to be written by this channel.
            CH8_WRITE_ADDR: u32,
            ///  DMA Channel 8 Transfer Count
            ///  Program the number of bus transfers a channel will perform before halting. Note that, if transfers are larger than one byte in size, this is not equal to the number of bytes transferred (see CTRL_DATA_SIZE).
            ///  When the channel is active, reading this register shows the number of transfers remaining, updating automatically each time a write transfer completes.
            ///  Writing this register sets the RELOAD value for the transfer counter. Each time this channel is triggered, the RELOAD value is copied into the live transfer counter. The channel can be started multiple times, and will perform the same number of transfers each time, as programmed by most recent write.
            ///  The RELOAD value can be observed at CHx_DBG_TCR. If TRANS_COUNT is used as a trigger, the written value is used immediately as the length of the new transfer sequence, as well as being written to RELOAD.
            CH8_TRANS_COUNT: u32,
            ///  DMA Channel 8 Control and Status
            CH8_CTRL_TRIG: mmio.Mmio(packed struct(u32) {
                ///  DMA Channel Enable.
                ///  When 1, the channel will respond to triggering events, which will cause it to become BUSY and start transferring data. When 0, the channel will ignore triggers, stop issuing transfers, and pause the current transfer sequence (i.e. BUSY will remain high if already high)
                EN: u1,
                ///  HIGH_PRIORITY gives a channel preferential treatment in issue scheduling: in each scheduling round, all high priority channels are considered first, and then only a single low priority channel, before returning to the high priority channels.
                ///  This only affects the order in which the DMA schedules channels. The DMA's bus priority is not changed. If the DMA is not saturated then a low priority channel will see no loss of throughput.
                HIGH_PRIORITY: u1,
                ///  Set the size of each bus transfer (byte/halfword/word). READ_ADDR and WRITE_ADDR advance by this amount (1/2/4 bytes) with each transfer.
                DATA_SIZE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        SIZE_BYTE = 0x0,
                        SIZE_HALFWORD = 0x1,
                        SIZE_WORD = 0x2,
                        _,
                    },
                },
                ///  If 1, the read address increments with each transfer. If 0, each read is directed to the same, initial address.
                ///  Generally this should be disabled for peripheral-to-memory transfers.
                INCR_READ: u1,
                ///  If 1, the write address increments with each transfer. If 0, each write is directed to the same, initial address.
                ///  Generally this should be disabled for memory-to-peripheral transfers.
                INCR_WRITE: u1,
                ///  Size of address wrap region. If 0, don't wrap. For values n > 0, only the lower n bits of the address will change. This wraps the address on a (1 << n) byte boundary, facilitating access to naturally-aligned ring buffers.
                ///  Ring sizes between 2 and 32768 bytes are possible. This can apply to either read or write addresses, based on value of RING_SEL.
                RING_SIZE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        RING_NONE = 0x0,
                        _,
                    },
                },
                ///  Select whether RING_SIZE applies to read or write addresses.
                ///  If 0, read addresses are wrapped on a (1 << RING_SIZE) boundary. If 1, write addresses are wrapped.
                RING_SEL: u1,
                ///  When this channel completes, it will trigger the channel indicated by CHAIN_TO. Disable by setting CHAIN_TO = _(this channel)_.
                CHAIN_TO: u4,
                ///  Select a Transfer Request signal.
                ///  The channel uses the transfer request signal to pace its data transfer rate. Sources for TREQ signals are internal (TIMERS) or external (DREQ, a Data Request from the system).
                ///  0x0 to 0x3a -> select DREQ n as TREQ
                TREQ_SEL: packed union {
                    raw: u6,
                    value: enum(u6) {
                        ///  Select Timer 0 as TREQ
                        TIMER0 = 0x3b,
                        ///  Select Timer 1 as TREQ
                        TIMER1 = 0x3c,
                        ///  Select Timer 2 as TREQ (Optional)
                        TIMER2 = 0x3d,
                        ///  Select Timer 3 as TREQ (Optional)
                        TIMER3 = 0x3e,
                        ///  Permanent request, for unpaced transfers.
                        PERMANENT = 0x3f,
                        _,
                    },
                },
                ///  In QUIET mode, the channel does not generate IRQs at the end of every transfer block. Instead, an IRQ is raised when NULL is written to a trigger register, indicating the end of a control block chain.
                ///  This reduces the number of interrupts to be serviced by the CPU when transferring a DMA chain of many small control blocks.
                IRQ_QUIET: u1,
                ///  Apply byte-swap transformation to DMA data.
                ///  For byte data, this has no effect. For halfword data, the two bytes of each halfword are swapped. For word data, the four bytes of each word are swapped to reverse order.
                BSWAP: u1,
                ///  If 1, this channel's data transfers are visible to the sniff hardware, and each transfer will advance the state of the checksum. This only applies if the sniff hardware is enabled, and has this channel selected.
                ///  This allows checksum to be enabled or disabled on a per-control- block basis.
                SNIFF_EN: u1,
                ///  This flag goes high when the channel starts a new transfer sequence, and low when the last transfer of that sequence completes. Clearing EN while BUSY is high pauses the channel, and BUSY will stay high while paused.
                ///  To terminate a sequence early (and clear the BUSY flag), see CHAN_ABORT.
                BUSY: u1,
                reserved29: u4,
                ///  If 1, the channel received a write bus error. Write one to clear.
                ///  WRITE_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 5 transfers later)
                WRITE_ERROR: u1,
                ///  If 1, the channel received a read bus error. Write one to clear.
                ///  READ_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 3 transfers later)
                READ_ERROR: u1,
                ///  Logical OR of the READ_ERROR and WRITE_ERROR flags. The channel halts when it encounters any bus error, and always raises its channel IRQ flag.
                AHB_ERROR: u1,
            }),
            ///  Alias for channel 8 CTRL register
            CH8_AL1_CTRL: u32,
            ///  Alias for channel 8 READ_ADDR register
            CH8_AL1_READ_ADDR: u32,
            ///  Alias for channel 8 WRITE_ADDR register
            CH8_AL1_WRITE_ADDR: u32,
            ///  Alias for channel 8 TRANS_COUNT register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH8_AL1_TRANS_COUNT_TRIG: u32,
            ///  Alias for channel 8 CTRL register
            CH8_AL2_CTRL: u32,
            ///  Alias for channel 8 TRANS_COUNT register
            CH8_AL2_TRANS_COUNT: u32,
            ///  Alias for channel 8 READ_ADDR register
            CH8_AL2_READ_ADDR: u32,
            ///  Alias for channel 8 WRITE_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH8_AL2_WRITE_ADDR_TRIG: u32,
            ///  Alias for channel 8 CTRL register
            CH8_AL3_CTRL: u32,
            ///  Alias for channel 8 WRITE_ADDR register
            CH8_AL3_WRITE_ADDR: u32,
            ///  Alias for channel 8 TRANS_COUNT register
            CH8_AL3_TRANS_COUNT: u32,
            ///  Alias for channel 8 READ_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH8_AL3_READ_ADDR_TRIG: u32,
            ///  DMA Channel 9 Read Address pointer
            ///  This register updates automatically each time a read completes. The current value is the next address to be read by this channel.
            CH9_READ_ADDR: u32,
            ///  DMA Channel 9 Write Address pointer
            ///  This register updates automatically each time a write completes. The current value is the next address to be written by this channel.
            CH9_WRITE_ADDR: u32,
            ///  DMA Channel 9 Transfer Count
            ///  Program the number of bus transfers a channel will perform before halting. Note that, if transfers are larger than one byte in size, this is not equal to the number of bytes transferred (see CTRL_DATA_SIZE).
            ///  When the channel is active, reading this register shows the number of transfers remaining, updating automatically each time a write transfer completes.
            ///  Writing this register sets the RELOAD value for the transfer counter. Each time this channel is triggered, the RELOAD value is copied into the live transfer counter. The channel can be started multiple times, and will perform the same number of transfers each time, as programmed by most recent write.
            ///  The RELOAD value can be observed at CHx_DBG_TCR. If TRANS_COUNT is used as a trigger, the written value is used immediately as the length of the new transfer sequence, as well as being written to RELOAD.
            CH9_TRANS_COUNT: u32,
            ///  DMA Channel 9 Control and Status
            CH9_CTRL_TRIG: mmio.Mmio(packed struct(u32) {
                ///  DMA Channel Enable.
                ///  When 1, the channel will respond to triggering events, which will cause it to become BUSY and start transferring data. When 0, the channel will ignore triggers, stop issuing transfers, and pause the current transfer sequence (i.e. BUSY will remain high if already high)
                EN: u1,
                ///  HIGH_PRIORITY gives a channel preferential treatment in issue scheduling: in each scheduling round, all high priority channels are considered first, and then only a single low priority channel, before returning to the high priority channels.
                ///  This only affects the order in which the DMA schedules channels. The DMA's bus priority is not changed. If the DMA is not saturated then a low priority channel will see no loss of throughput.
                HIGH_PRIORITY: u1,
                ///  Set the size of each bus transfer (byte/halfword/word). READ_ADDR and WRITE_ADDR advance by this amount (1/2/4 bytes) with each transfer.
                DATA_SIZE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        SIZE_BYTE = 0x0,
                        SIZE_HALFWORD = 0x1,
                        SIZE_WORD = 0x2,
                        _,
                    },
                },
                ///  If 1, the read address increments with each transfer. If 0, each read is directed to the same, initial address.
                ///  Generally this should be disabled for peripheral-to-memory transfers.
                INCR_READ: u1,
                ///  If 1, the write address increments with each transfer. If 0, each write is directed to the same, initial address.
                ///  Generally this should be disabled for memory-to-peripheral transfers.
                INCR_WRITE: u1,
                ///  Size of address wrap region. If 0, don't wrap. For values n > 0, only the lower n bits of the address will change. This wraps the address on a (1 << n) byte boundary, facilitating access to naturally-aligned ring buffers.
                ///  Ring sizes between 2 and 32768 bytes are possible. This can apply to either read or write addresses, based on value of RING_SEL.
                RING_SIZE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        RING_NONE = 0x0,
                        _,
                    },
                },
                ///  Select whether RING_SIZE applies to read or write addresses.
                ///  If 0, read addresses are wrapped on a (1 << RING_SIZE) boundary. If 1, write addresses are wrapped.
                RING_SEL: u1,
                ///  When this channel completes, it will trigger the channel indicated by CHAIN_TO. Disable by setting CHAIN_TO = _(this channel)_.
                CHAIN_TO: u4,
                ///  Select a Transfer Request signal.
                ///  The channel uses the transfer request signal to pace its data transfer rate. Sources for TREQ signals are internal (TIMERS) or external (DREQ, a Data Request from the system).
                ///  0x0 to 0x3a -> select DREQ n as TREQ
                TREQ_SEL: packed union {
                    raw: u6,
                    value: enum(u6) {
                        ///  Select Timer 0 as TREQ
                        TIMER0 = 0x3b,
                        ///  Select Timer 1 as TREQ
                        TIMER1 = 0x3c,
                        ///  Select Timer 2 as TREQ (Optional)
                        TIMER2 = 0x3d,
                        ///  Select Timer 3 as TREQ (Optional)
                        TIMER3 = 0x3e,
                        ///  Permanent request, for unpaced transfers.
                        PERMANENT = 0x3f,
                        _,
                    },
                },
                ///  In QUIET mode, the channel does not generate IRQs at the end of every transfer block. Instead, an IRQ is raised when NULL is written to a trigger register, indicating the end of a control block chain.
                ///  This reduces the number of interrupts to be serviced by the CPU when transferring a DMA chain of many small control blocks.
                IRQ_QUIET: u1,
                ///  Apply byte-swap transformation to DMA data.
                ///  For byte data, this has no effect. For halfword data, the two bytes of each halfword are swapped. For word data, the four bytes of each word are swapped to reverse order.
                BSWAP: u1,
                ///  If 1, this channel's data transfers are visible to the sniff hardware, and each transfer will advance the state of the checksum. This only applies if the sniff hardware is enabled, and has this channel selected.
                ///  This allows checksum to be enabled or disabled on a per-control- block basis.
                SNIFF_EN: u1,
                ///  This flag goes high when the channel starts a new transfer sequence, and low when the last transfer of that sequence completes. Clearing EN while BUSY is high pauses the channel, and BUSY will stay high while paused.
                ///  To terminate a sequence early (and clear the BUSY flag), see CHAN_ABORT.
                BUSY: u1,
                reserved29: u4,
                ///  If 1, the channel received a write bus error. Write one to clear.
                ///  WRITE_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 5 transfers later)
                WRITE_ERROR: u1,
                ///  If 1, the channel received a read bus error. Write one to clear.
                ///  READ_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 3 transfers later)
                READ_ERROR: u1,
                ///  Logical OR of the READ_ERROR and WRITE_ERROR flags. The channel halts when it encounters any bus error, and always raises its channel IRQ flag.
                AHB_ERROR: u1,
            }),
            ///  Alias for channel 9 CTRL register
            CH9_AL1_CTRL: u32,
            ///  Alias for channel 9 READ_ADDR register
            CH9_AL1_READ_ADDR: u32,
            ///  Alias for channel 9 WRITE_ADDR register
            CH9_AL1_WRITE_ADDR: u32,
            ///  Alias for channel 9 TRANS_COUNT register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH9_AL1_TRANS_COUNT_TRIG: u32,
            ///  Alias for channel 9 CTRL register
            CH9_AL2_CTRL: u32,
            ///  Alias for channel 9 TRANS_COUNT register
            CH9_AL2_TRANS_COUNT: u32,
            ///  Alias for channel 9 READ_ADDR register
            CH9_AL2_READ_ADDR: u32,
            ///  Alias for channel 9 WRITE_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH9_AL2_WRITE_ADDR_TRIG: u32,
            ///  Alias for channel 9 CTRL register
            CH9_AL3_CTRL: u32,
            ///  Alias for channel 9 WRITE_ADDR register
            CH9_AL3_WRITE_ADDR: u32,
            ///  Alias for channel 9 TRANS_COUNT register
            CH9_AL3_TRANS_COUNT: u32,
            ///  Alias for channel 9 READ_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH9_AL3_READ_ADDR_TRIG: u32,
            ///  DMA Channel 10 Read Address pointer
            ///  This register updates automatically each time a read completes. The current value is the next address to be read by this channel.
            CH10_READ_ADDR: u32,
            ///  DMA Channel 10 Write Address pointer
            ///  This register updates automatically each time a write completes. The current value is the next address to be written by this channel.
            CH10_WRITE_ADDR: u32,
            ///  DMA Channel 10 Transfer Count
            ///  Program the number of bus transfers a channel will perform before halting. Note that, if transfers are larger than one byte in size, this is not equal to the number of bytes transferred (see CTRL_DATA_SIZE).
            ///  When the channel is active, reading this register shows the number of transfers remaining, updating automatically each time a write transfer completes.
            ///  Writing this register sets the RELOAD value for the transfer counter. Each time this channel is triggered, the RELOAD value is copied into the live transfer counter. The channel can be started multiple times, and will perform the same number of transfers each time, as programmed by most recent write.
            ///  The RELOAD value can be observed at CHx_DBG_TCR. If TRANS_COUNT is used as a trigger, the written value is used immediately as the length of the new transfer sequence, as well as being written to RELOAD.
            CH10_TRANS_COUNT: u32,
            ///  DMA Channel 10 Control and Status
            CH10_CTRL_TRIG: mmio.Mmio(packed struct(u32) {
                ///  DMA Channel Enable.
                ///  When 1, the channel will respond to triggering events, which will cause it to become BUSY and start transferring data. When 0, the channel will ignore triggers, stop issuing transfers, and pause the current transfer sequence (i.e. BUSY will remain high if already high)
                EN: u1,
                ///  HIGH_PRIORITY gives a channel preferential treatment in issue scheduling: in each scheduling round, all high priority channels are considered first, and then only a single low priority channel, before returning to the high priority channels.
                ///  This only affects the order in which the DMA schedules channels. The DMA's bus priority is not changed. If the DMA is not saturated then a low priority channel will see no loss of throughput.
                HIGH_PRIORITY: u1,
                ///  Set the size of each bus transfer (byte/halfword/word). READ_ADDR and WRITE_ADDR advance by this amount (1/2/4 bytes) with each transfer.
                DATA_SIZE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        SIZE_BYTE = 0x0,
                        SIZE_HALFWORD = 0x1,
                        SIZE_WORD = 0x2,
                        _,
                    },
                },
                ///  If 1, the read address increments with each transfer. If 0, each read is directed to the same, initial address.
                ///  Generally this should be disabled for peripheral-to-memory transfers.
                INCR_READ: u1,
                ///  If 1, the write address increments with each transfer. If 0, each write is directed to the same, initial address.
                ///  Generally this should be disabled for memory-to-peripheral transfers.
                INCR_WRITE: u1,
                ///  Size of address wrap region. If 0, don't wrap. For values n > 0, only the lower n bits of the address will change. This wraps the address on a (1 << n) byte boundary, facilitating access to naturally-aligned ring buffers.
                ///  Ring sizes between 2 and 32768 bytes are possible. This can apply to either read or write addresses, based on value of RING_SEL.
                RING_SIZE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        RING_NONE = 0x0,
                        _,
                    },
                },
                ///  Select whether RING_SIZE applies to read or write addresses.
                ///  If 0, read addresses are wrapped on a (1 << RING_SIZE) boundary. If 1, write addresses are wrapped.
                RING_SEL: u1,
                ///  When this channel completes, it will trigger the channel indicated by CHAIN_TO. Disable by setting CHAIN_TO = _(this channel)_.
                CHAIN_TO: u4,
                ///  Select a Transfer Request signal.
                ///  The channel uses the transfer request signal to pace its data transfer rate. Sources for TREQ signals are internal (TIMERS) or external (DREQ, a Data Request from the system).
                ///  0x0 to 0x3a -> select DREQ n as TREQ
                TREQ_SEL: packed union {
                    raw: u6,
                    value: enum(u6) {
                        ///  Select Timer 0 as TREQ
                        TIMER0 = 0x3b,
                        ///  Select Timer 1 as TREQ
                        TIMER1 = 0x3c,
                        ///  Select Timer 2 as TREQ (Optional)
                        TIMER2 = 0x3d,
                        ///  Select Timer 3 as TREQ (Optional)
                        TIMER3 = 0x3e,
                        ///  Permanent request, for unpaced transfers.
                        PERMANENT = 0x3f,
                        _,
                    },
                },
                ///  In QUIET mode, the channel does not generate IRQs at the end of every transfer block. Instead, an IRQ is raised when NULL is written to a trigger register, indicating the end of a control block chain.
                ///  This reduces the number of interrupts to be serviced by the CPU when transferring a DMA chain of many small control blocks.
                IRQ_QUIET: u1,
                ///  Apply byte-swap transformation to DMA data.
                ///  For byte data, this has no effect. For halfword data, the two bytes of each halfword are swapped. For word data, the four bytes of each word are swapped to reverse order.
                BSWAP: u1,
                ///  If 1, this channel's data transfers are visible to the sniff hardware, and each transfer will advance the state of the checksum. This only applies if the sniff hardware is enabled, and has this channel selected.
                ///  This allows checksum to be enabled or disabled on a per-control- block basis.
                SNIFF_EN: u1,
                ///  This flag goes high when the channel starts a new transfer sequence, and low when the last transfer of that sequence completes. Clearing EN while BUSY is high pauses the channel, and BUSY will stay high while paused.
                ///  To terminate a sequence early (and clear the BUSY flag), see CHAN_ABORT.
                BUSY: u1,
                reserved29: u4,
                ///  If 1, the channel received a write bus error. Write one to clear.
                ///  WRITE_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 5 transfers later)
                WRITE_ERROR: u1,
                ///  If 1, the channel received a read bus error. Write one to clear.
                ///  READ_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 3 transfers later)
                READ_ERROR: u1,
                ///  Logical OR of the READ_ERROR and WRITE_ERROR flags. The channel halts when it encounters any bus error, and always raises its channel IRQ flag.
                AHB_ERROR: u1,
            }),
            ///  Alias for channel 10 CTRL register
            CH10_AL1_CTRL: u32,
            ///  Alias for channel 10 READ_ADDR register
            CH10_AL1_READ_ADDR: u32,
            ///  Alias for channel 10 WRITE_ADDR register
            CH10_AL1_WRITE_ADDR: u32,
            ///  Alias for channel 10 TRANS_COUNT register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH10_AL1_TRANS_COUNT_TRIG: u32,
            ///  Alias for channel 10 CTRL register
            CH10_AL2_CTRL: u32,
            ///  Alias for channel 10 TRANS_COUNT register
            CH10_AL2_TRANS_COUNT: u32,
            ///  Alias for channel 10 READ_ADDR register
            CH10_AL2_READ_ADDR: u32,
            ///  Alias for channel 10 WRITE_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH10_AL2_WRITE_ADDR_TRIG: u32,
            ///  Alias for channel 10 CTRL register
            CH10_AL3_CTRL: u32,
            ///  Alias for channel 10 WRITE_ADDR register
            CH10_AL3_WRITE_ADDR: u32,
            ///  Alias for channel 10 TRANS_COUNT register
            CH10_AL3_TRANS_COUNT: u32,
            ///  Alias for channel 10 READ_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH10_AL3_READ_ADDR_TRIG: u32,
            ///  DMA Channel 11 Read Address pointer
            ///  This register updates automatically each time a read completes. The current value is the next address to be read by this channel.
            CH11_READ_ADDR: u32,
            ///  DMA Channel 11 Write Address pointer
            ///  This register updates automatically each time a write completes. The current value is the next address to be written by this channel.
            CH11_WRITE_ADDR: u32,
            ///  DMA Channel 11 Transfer Count
            ///  Program the number of bus transfers a channel will perform before halting. Note that, if transfers are larger than one byte in size, this is not equal to the number of bytes transferred (see CTRL_DATA_SIZE).
            ///  When the channel is active, reading this register shows the number of transfers remaining, updating automatically each time a write transfer completes.
            ///  Writing this register sets the RELOAD value for the transfer counter. Each time this channel is triggered, the RELOAD value is copied into the live transfer counter. The channel can be started multiple times, and will perform the same number of transfers each time, as programmed by most recent write.
            ///  The RELOAD value can be observed at CHx_DBG_TCR. If TRANS_COUNT is used as a trigger, the written value is used immediately as the length of the new transfer sequence, as well as being written to RELOAD.
            CH11_TRANS_COUNT: u32,
            ///  DMA Channel 11 Control and Status
            CH11_CTRL_TRIG: mmio.Mmio(packed struct(u32) {
                ///  DMA Channel Enable.
                ///  When 1, the channel will respond to triggering events, which will cause it to become BUSY and start transferring data. When 0, the channel will ignore triggers, stop issuing transfers, and pause the current transfer sequence (i.e. BUSY will remain high if already high)
                EN: u1,
                ///  HIGH_PRIORITY gives a channel preferential treatment in issue scheduling: in each scheduling round, all high priority channels are considered first, and then only a single low priority channel, before returning to the high priority channels.
                ///  This only affects the order in which the DMA schedules channels. The DMA's bus priority is not changed. If the DMA is not saturated then a low priority channel will see no loss of throughput.
                HIGH_PRIORITY: u1,
                ///  Set the size of each bus transfer (byte/halfword/word). READ_ADDR and WRITE_ADDR advance by this amount (1/2/4 bytes) with each transfer.
                DATA_SIZE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        SIZE_BYTE = 0x0,
                        SIZE_HALFWORD = 0x1,
                        SIZE_WORD = 0x2,
                        _,
                    },
                },
                ///  If 1, the read address increments with each transfer. If 0, each read is directed to the same, initial address.
                ///  Generally this should be disabled for peripheral-to-memory transfers.
                INCR_READ: u1,
                ///  If 1, the write address increments with each transfer. If 0, each write is directed to the same, initial address.
                ///  Generally this should be disabled for memory-to-peripheral transfers.
                INCR_WRITE: u1,
                ///  Size of address wrap region. If 0, don't wrap. For values n > 0, only the lower n bits of the address will change. This wraps the address on a (1 << n) byte boundary, facilitating access to naturally-aligned ring buffers.
                ///  Ring sizes between 2 and 32768 bytes are possible. This can apply to either read or write addresses, based on value of RING_SEL.
                RING_SIZE: packed union {
                    raw: u4,
                    value: enum(u4) {
                        RING_NONE = 0x0,
                        _,
                    },
                },
                ///  Select whether RING_SIZE applies to read or write addresses.
                ///  If 0, read addresses are wrapped on a (1 << RING_SIZE) boundary. If 1, write addresses are wrapped.
                RING_SEL: u1,
                ///  When this channel completes, it will trigger the channel indicated by CHAIN_TO. Disable by setting CHAIN_TO = _(this channel)_.
                CHAIN_TO: u4,
                ///  Select a Transfer Request signal.
                ///  The channel uses the transfer request signal to pace its data transfer rate. Sources for TREQ signals are internal (TIMERS) or external (DREQ, a Data Request from the system).
                ///  0x0 to 0x3a -> select DREQ n as TREQ
                TREQ_SEL: packed union {
                    raw: u6,
                    value: enum(u6) {
                        ///  Select Timer 0 as TREQ
                        TIMER0 = 0x3b,
                        ///  Select Timer 1 as TREQ
                        TIMER1 = 0x3c,
                        ///  Select Timer 2 as TREQ (Optional)
                        TIMER2 = 0x3d,
                        ///  Select Timer 3 as TREQ (Optional)
                        TIMER3 = 0x3e,
                        ///  Permanent request, for unpaced transfers.
                        PERMANENT = 0x3f,
                        _,
                    },
                },
                ///  In QUIET mode, the channel does not generate IRQs at the end of every transfer block. Instead, an IRQ is raised when NULL is written to a trigger register, indicating the end of a control block chain.
                ///  This reduces the number of interrupts to be serviced by the CPU when transferring a DMA chain of many small control blocks.
                IRQ_QUIET: u1,
                ///  Apply byte-swap transformation to DMA data.
                ///  For byte data, this has no effect. For halfword data, the two bytes of each halfword are swapped. For word data, the four bytes of each word are swapped to reverse order.
                BSWAP: u1,
                ///  If 1, this channel's data transfers are visible to the sniff hardware, and each transfer will advance the state of the checksum. This only applies if the sniff hardware is enabled, and has this channel selected.
                ///  This allows checksum to be enabled or disabled on a per-control- block basis.
                SNIFF_EN: u1,
                ///  This flag goes high when the channel starts a new transfer sequence, and low when the last transfer of that sequence completes. Clearing EN while BUSY is high pauses the channel, and BUSY will stay high while paused.
                ///  To terminate a sequence early (and clear the BUSY flag), see CHAN_ABORT.
                BUSY: u1,
                reserved29: u4,
                ///  If 1, the channel received a write bus error. Write one to clear.
                ///  WRITE_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 5 transfers later)
                WRITE_ERROR: u1,
                ///  If 1, the channel received a read bus error. Write one to clear.
                ///  READ_ADDR shows the approximate address where the bus error was encountered (will not to be earlier, or more than 3 transfers later)
                READ_ERROR: u1,
                ///  Logical OR of the READ_ERROR and WRITE_ERROR flags. The channel halts when it encounters any bus error, and always raises its channel IRQ flag.
                AHB_ERROR: u1,
            }),
            ///  Alias for channel 11 CTRL register
            CH11_AL1_CTRL: u32,
            ///  Alias for channel 11 READ_ADDR register
            CH11_AL1_READ_ADDR: u32,
            ///  Alias for channel 11 WRITE_ADDR register
            CH11_AL1_WRITE_ADDR: u32,
            ///  Alias for channel 11 TRANS_COUNT register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH11_AL1_TRANS_COUNT_TRIG: u32,
            ///  Alias for channel 11 CTRL register
            CH11_AL2_CTRL: u32,
            ///  Alias for channel 11 TRANS_COUNT register
            CH11_AL2_TRANS_COUNT: u32,
            ///  Alias for channel 11 READ_ADDR register
            CH11_AL2_READ_ADDR: u32,
            ///  Alias for channel 11 WRITE_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH11_AL2_WRITE_ADDR_TRIG: u32,
            ///  Alias for channel 11 CTRL register
            CH11_AL3_CTRL: u32,
            ///  Alias for channel 11 WRITE_ADDR register
            CH11_AL3_WRITE_ADDR: u32,
            ///  Alias for channel 11 TRANS_COUNT register
            CH11_AL3_TRANS_COUNT: u32,
            ///  Alias for channel 11 READ_ADDR register
            ///  This is a trigger register (0xc). Writing a nonzero value will
            ///  reload the channel counter and start the channel.
            CH11_AL3_READ_ADDR_TRIG: u32,
            reserved1024: [256]u8,
            ///  Interrupt Status (raw)
            INTR: mmio.Mmio(packed struct(u32) {
                ///  Raw interrupt status for DMA Channels 0..15. Bit n corresponds to channel n. Ignores any masking or forcing. Channel interrupts can be cleared by writing a bit mask to INTR, INTS0 or INTS1.
                ///  Channel interrupts can be routed to either of two system-level IRQs based on INTE0 and INTE1.
                ///  This can be used vector different channel interrupts to different ISRs: this might be done to allow NVIC IRQ preemption for more time-critical channels, or to spread IRQ load across different cores.
                ///  It is also valid to ignore this behaviour and just use INTE0/INTS0/IRQ 0.
                INTR: u16,
                padding: u16,
            }),
            ///  Interrupt Enables for IRQ 0
            INTE0: mmio.Mmio(packed struct(u32) {
                ///  Set bit n to pass interrupts from channel n to DMA IRQ 0.
                INTE0: u16,
                padding: u16,
            }),
            ///  Force Interrupts
            INTF0: mmio.Mmio(packed struct(u32) {
                ///  Write 1s to force the corresponding bits in INTE0. The interrupt remains asserted until INTF0 is cleared.
                INTF0: u16,
                padding: u16,
            }),
            ///  Interrupt Status for IRQ 0
            INTS0: mmio.Mmio(packed struct(u32) {
                ///  Indicates active channel interrupt requests which are currently causing IRQ 0 to be asserted.
                ///  Channel interrupts can be cleared by writing a bit mask here.
                INTS0: u16,
                padding: u16,
            }),
            reserved1044: [4]u8,
            ///  Interrupt Enables for IRQ 1
            INTE1: mmio.Mmio(packed struct(u32) {
                ///  Set bit n to pass interrupts from channel n to DMA IRQ 1.
                INTE1: u16,
                padding: u16,
            }),
            ///  Force Interrupts for IRQ 1
            INTF1: mmio.Mmio(packed struct(u32) {
                ///  Write 1s to force the corresponding bits in INTE0. The interrupt remains asserted until INTF0 is cleared.
                INTF1: u16,
                padding: u16,
            }),
            ///  Interrupt Status (masked) for IRQ 1
            INTS1: mmio.Mmio(packed struct(u32) {
                ///  Indicates active channel interrupt requests which are currently causing IRQ 1 to be asserted.
                ///  Channel interrupts can be cleared by writing a bit mask here.
                INTS1: u16,
                padding: u16,
            }),
            ///  Pacing (X/Y) Fractional Timer
            ///  The pacing timer produces TREQ assertions at a rate set by ((X/Y) * sys_clk). This equation is evaluated every sys_clk cycles and therefore can only generate TREQs at a rate of 1 per sys_clk (i.e. permanent TREQ) or less.
            TIMER0: mmio.Mmio(packed struct(u32) {
                ///  Pacing Timer Divisor. Specifies the Y value for the (X/Y) fractional timer.
                Y: u16,
                ///  Pacing Timer Dividend. Specifies the X value for the (X/Y) fractional timer.
                X: u16,
            }),
            ///  Pacing (X/Y) Fractional Timer
            ///  The pacing timer produces TREQ assertions at a rate set by ((X/Y) * sys_clk). This equation is evaluated every sys_clk cycles and therefore can only generate TREQs at a rate of 1 per sys_clk (i.e. permanent TREQ) or less.
            TIMER1: mmio.Mmio(packed struct(u32) {
                ///  Pacing Timer Divisor. Specifies the Y value for the (X/Y) fractional timer.
                Y: u16,
                ///  Pacing Timer Dividend. Specifies the X value for the (X/Y) fractional timer.
                X: u16,
            }),
            ///  Pacing (X/Y) Fractional Timer
            ///  The pacing timer produces TREQ assertions at a rate set by ((X/Y) * sys_clk). This equation is evaluated every sys_clk cycles and therefore can only generate TREQs at a rate of 1 per sys_clk (i.e. permanent TREQ) or less.
            TIMER2: mmio.Mmio(packed struct(u32) {
                ///  Pacing Timer Divisor. Specifies the Y value for the (X/Y) fractional timer.
                Y: u16,
                ///  Pacing Timer Dividend. Specifies the X value for the (X/Y) fractional timer.
                X: u16,
            }),
            ///  Pacing (X/Y) Fractional Timer
            ///  The pacing timer produces TREQ assertions at a rate set by ((X/Y) * sys_clk). This equation is evaluated every sys_clk cycles and therefore can only generate TREQs at a rate of 1 per sys_clk (i.e. permanent TREQ) or less.
            TIMER3: mmio.Mmio(packed struct(u32) {
                ///  Pacing Timer Divisor. Specifies the Y value for the (X/Y) fractional timer.
                Y: u16,
                ///  Pacing Timer Dividend. Specifies the X value for the (X/Y) fractional timer.
                X: u16,
            }),
            ///  Trigger one or more channels simultaneously
            MULTI_CHAN_TRIGGER: mmio.Mmio(packed struct(u32) {
                ///  Each bit in this register corresponds to a DMA channel. Writing a 1 to the relevant bit is the same as writing to that channel's trigger register; the channel will start if it is currently enabled and not already busy.
                MULTI_CHAN_TRIGGER: u16,
                padding: u16,
            }),
            ///  Sniffer Control
            SNIFF_CTRL: mmio.Mmio(packed struct(u32) {
                ///  Enable sniffer
                EN: u1,
                ///  DMA channel for Sniffer to observe
                DMACH: u4,
                CALC: packed union {
                    raw: u4,
                    value: enum(u4) {
                        ///  Calculate a CRC-32 (IEEE802.3 polynomial)
                        CRC32 = 0x0,
                        ///  Calculate a CRC-32 (IEEE802.3 polynomial) with bit reversed data
                        CRC32R = 0x1,
                        ///  Calculate a CRC-16-CCITT
                        CRC16 = 0x2,
                        ///  Calculate a CRC-16-CCITT with bit reversed data
                        CRC16R = 0x3,
                        ///  XOR reduction over all data. == 1 if the total 1 population count is odd.
                        EVEN = 0xe,
                        ///  Calculate a simple 32-bit checksum (addition with a 32 bit accumulator)
                        SUM = 0xf,
                        _,
                    },
                },
                ///  Locally perform a byte reverse on the sniffed data, before feeding into checksum.
                ///  Note that the sniff hardware is downstream of the DMA channel byteswap performed in the read master: if channel CTRL_BSWAP and SNIFF_CTRL_BSWAP are both enabled, their effects cancel from the sniffer's point of view.
                BSWAP: u1,
                ///  If set, the result appears bit-reversed when read. This does not affect the way the checksum is calculated; the result is transformed on-the-fly between the result register and the bus.
                OUT_REV: u1,
                ///  If set, the result appears inverted (bitwise complement) when read. This does not affect the way the checksum is calculated; the result is transformed on-the-fly between the result register and the bus.
                OUT_INV: u1,
                padding: u20,
            }),
            ///  Data accumulator for sniff hardware
            ///  Write an initial seed value here before starting a DMA transfer on the channel indicated by SNIFF_CTRL_DMACH. The hardware will update this register each time it observes a read from the indicated channel. Once the channel completes, the final result can be read from this register.
            SNIFF_DATA: u32,
            reserved1088: [4]u8,
            ///  Debug RAF, WAF, TDF levels
            FIFO_LEVELS: mmio.Mmio(packed struct(u32) {
                ///  Current Transfer-Data-FIFO fill level
                TDF_LVL: u8,
                ///  Current Write-Address-FIFO fill level
                WAF_LVL: u8,
                ///  Current Read-Address-FIFO fill level
                RAF_LVL: u8,
                padding: u8,
            }),
            ///  Abort an in-progress transfer sequence on one or more channels
            CHAN_ABORT: mmio.Mmio(packed struct(u32) {
                ///  Each bit corresponds to a channel. Writing a 1 aborts whatever transfer sequence is in progress on that channel. The bit will remain high until any in-flight transfers have been flushed through the address and data FIFOs.
                ///  After writing, this register must be polled until it returns all-zero. Until this point, it is unsafe to restart the channel.
                CHAN_ABORT: u16,
                padding: u16,
            }),
            ///  The number of channels this DMA instance is equipped with. This DMA supports up to 16 hardware channels, but can be configured with as few as one, to minimise silicon area.
            N_CHANNELS: mmio.Mmio(packed struct(u32) {
                N_CHANNELS: u5,
                padding: u27,
            }),
            reserved2048: [948]u8,
            ///  Read: get channel DREQ counter (i.e. how many accesses the DMA expects it can perform on the peripheral without overflow/underflow. Write any value: clears the counter, and cause channel to re-initiate DREQ handshake.
            CH0_DBG_CTDREQ: mmio.Mmio(packed struct(u32) {
                CH0_DBG_CTDREQ: u6,
                padding: u26,
            }),
            ///  Read to get channel TRANS_COUNT reload value, i.e. the length of the next transfer
            CH0_DBG_TCR: u32,
            reserved2112: [56]u8,
            ///  Read: get channel DREQ counter (i.e. how many accesses the DMA expects it can perform on the peripheral without overflow/underflow. Write any value: clears the counter, and cause channel to re-initiate DREQ handshake.
            CH1_DBG_CTDREQ: mmio.Mmio(packed struct(u32) {
                CH1_DBG_CTDREQ: u6,
                padding: u26,
            }),
            ///  Read to get channel TRANS_COUNT reload value, i.e. the length of the next transfer
            CH1_DBG_TCR: u32,
            reserved2176: [56]u8,
            ///  Read: get channel DREQ counter (i.e. how many accesses the DMA expects it can perform on the peripheral without overflow/underflow. Write any value: clears the counter, and cause channel to re-initiate DREQ handshake.
            CH2_DBG_CTDREQ: mmio.Mmio(packed struct(u32) {
                CH2_DBG_CTDREQ: u6,
                padding: u26,
            }),
            ///  Read to get channel TRANS_COUNT reload value, i.e. the length of the next transfer
            CH2_DBG_TCR: u32,
            reserved2240: [56]u8,
            ///  Read: get channel DREQ counter (i.e. how many accesses the DMA expects it can perform on the peripheral without overflow/underflow. Write any value: clears the counter, and cause channel to re-initiate DREQ handshake.
            CH3_DBG_CTDREQ: mmio.Mmio(packed struct(u32) {
                CH3_DBG_CTDREQ: u6,
                padding: u26,
            }),
            ///  Read to get channel TRANS_COUNT reload value, i.e. the length of the next transfer
            CH3_DBG_TCR: u32,
            reserved2304: [56]u8,
            ///  Read: get channel DREQ counter (i.e. how many accesses the DMA expects it can perform on the peripheral without overflow/underflow. Write any value: clears the counter, and cause channel to re-initiate DREQ handshake.
            CH4_DBG_CTDREQ: mmio.Mmio(packed struct(u32) {
                CH4_DBG_CTDREQ: u6,
                padding: u26,
            }),
            ///  Read to get channel TRANS_COUNT reload value, i.e. the length of the next transfer
            CH4_DBG_TCR: u32,
            reserved2368: [56]u8,
            ///  Read: get channel DREQ counter (i.e. how many accesses the DMA expects it can perform on the peripheral without overflow/underflow. Write any value: clears the counter, and cause channel to re-initiate DREQ handshake.
            CH5_DBG_CTDREQ: mmio.Mmio(packed struct(u32) {
                CH5_DBG_CTDREQ: u6,
                padding: u26,
            }),
            ///  Read to get channel TRANS_COUNT reload value, i.e. the length of the next transfer
            CH5_DBG_TCR: u32,
            reserved2432: [56]u8,
            ///  Read: get channel DREQ counter (i.e. how many accesses the DMA expects it can perform on the peripheral without overflow/underflow. Write any value: clears the counter, and cause channel to re-initiate DREQ handshake.
            CH6_DBG_CTDREQ: mmio.Mmio(packed struct(u32) {
                CH6_DBG_CTDREQ: u6,
                padding: u26,
            }),
            ///  Read to get channel TRANS_COUNT reload value, i.e. the length of the next transfer
            CH6_DBG_TCR: u32,
            reserved2496: [56]u8,
            ///  Read: get channel DREQ counter (i.e. how many accesses the DMA expects it can perform on the peripheral without overflow/underflow. Write any value: clears the counter, and cause channel to re-initiate DREQ handshake.
            CH7_DBG_CTDREQ: mmio.Mmio(packed struct(u32) {
                CH7_DBG_CTDREQ: u6,
                padding: u26,
            }),
            ///  Read to get channel TRANS_COUNT reload value, i.e. the length of the next transfer
            CH7_DBG_TCR: u32,
            reserved2560: [56]u8,
            ///  Read: get channel DREQ counter (i.e. how many accesses the DMA expects it can perform on the peripheral without overflow/underflow. Write any value: clears the counter, and cause channel to re-initiate DREQ handshake.
            CH8_DBG_CTDREQ: mmio.Mmio(packed struct(u32) {
                CH8_DBG_CTDREQ: u6,
                padding: u26,
            }),
            ///  Read to get channel TRANS_COUNT reload value, i.e. the length of the next transfer
            CH8_DBG_TCR: u32,
            reserved2624: [56]u8,
            ///  Read: get channel DREQ counter (i.e. how many accesses the DMA expects it can perform on the peripheral without overflow/underflow. Write any value: clears the counter, and cause channel to re-initiate DREQ handshake.
            CH9_DBG_CTDREQ: mmio.Mmio(packed struct(u32) {
                CH9_DBG_CTDREQ: u6,
                padding: u26,
            }),
            ///  Read to get channel TRANS_COUNT reload value, i.e. the length of the next transfer
            CH9_DBG_TCR: u32,
            reserved2688: [56]u8,
            ///  Read: get channel DREQ counter (i.e. how many accesses the DMA expects it can perform on the peripheral without overflow/underflow. Write any value: clears the counter, and cause channel to re-initiate DREQ handshake.
            CH10_DBG_CTDREQ: mmio.Mmio(packed struct(u32) {
                CH10_DBG_CTDREQ: u6,
                padding: u26,
            }),
            ///  Read to get channel TRANS_COUNT reload value, i.e. the length of the next transfer
            CH10_DBG_TCR: u32,
            reserved2752: [56]u8,
            ///  Read: get channel DREQ counter (i.e. how many accesses the DMA expects it can perform on the peripheral without overflow/underflow. Write any value: clears the counter, and cause channel to re-initiate DREQ handshake.
            CH11_DBG_CTDREQ: mmio.Mmio(packed struct(u32) {
                CH11_DBG_CTDREQ: u6,
                padding: u26,
            }),
            ///  Read to get channel TRANS_COUNT reload value, i.e. the length of the next transfer
            CH11_DBG_TCR: u32,
        };

        ///  DPRAM layout for USB device.
        pub const USBCTRL_DPRAM = extern struct {
            ///  Bytes 0-3 of the SETUP packet from the host.
            SETUP_PACKET_LOW: mmio.Mmio(packed struct(u32) {
                BMREQUESTTYPE: u8,
                BREQUEST: u8,
                WVALUE: u16,
            }),
            ///  Bytes 4-7 of the setup packet from the host.
            SETUP_PACKET_HIGH: mmio.Mmio(packed struct(u32) {
                WINDEX: u16,
                WLENGTH: u16,
            }),
            EP1_IN_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP1_OUT_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP2_IN_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP2_OUT_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP3_IN_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP3_OUT_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP4_IN_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP4_OUT_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP5_IN_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP5_OUT_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP6_IN_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP6_OUT_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP7_IN_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP7_OUT_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP8_IN_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP8_OUT_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP9_IN_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP9_OUT_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP10_IN_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP10_OUT_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP11_IN_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP11_OUT_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP12_IN_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP12_OUT_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP13_IN_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP13_OUT_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP14_IN_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP14_OUT_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP15_IN_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            EP15_OUT_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  64 byte aligned buffer address for this EP (bits 0-5 are ignored). Relative to the start of the DPRAM.
                BUFFER_ADDRESS: u16,
                ///  Trigger an interrupt if a NAK is sent. Intended for debug only.
                INTERRUPT_ON_NAK: u1,
                ///  Trigger an interrupt if a STALL is sent. Intended for debug only.
                INTERRUPT_ON_STALL: u1,
                reserved26: u8,
                ENDPOINT_TYPE: packed union {
                    raw: u2,
                    value: enum(u2) {
                        Control = 0x0,
                        Isochronous = 0x1,
                        Bulk = 0x2,
                        Interrupt = 0x3,
                    },
                },
                ///  Trigger an interrupt each time both buffers are done. Only valid in double buffered mode.
                INTERRUPT_PER_DOUBLE_BUFF: u1,
                ///  Trigger an interrupt each time a buffer is done.
                INTERRUPT_PER_BUFF: u1,
                ///  This endpoint is double buffered.
                DOUBLE_BUFFERED: u1,
                ///  Enable this endpoint. The device will not reply to any packets for this endpoint if this bit is not set.
                ENABLE: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP0_IN_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP0_OUT_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP1_IN_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP1_OUT_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP2_IN_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP2_OUT_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP3_IN_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP3_OUT_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP4_IN_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP4_OUT_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP5_IN_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP5_OUT_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP6_IN_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP6_OUT_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP7_IN_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP7_OUT_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP8_IN_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP8_OUT_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP9_IN_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP9_OUT_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP10_IN_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP10_OUT_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP11_IN_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP11_OUT_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP12_IN_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP12_OUT_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP13_IN_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP13_OUT_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP14_IN_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP14_OUT_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP15_IN_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
            ///  Buffer control for both buffers of an endpoint. Fields ending in a _1 are for buffer 1.
            ///  Fields ending in a _0 are for buffer 0. Buffer 1 controls are only valid if the endpoint is in double buffered mode.
            EP15_OUT_BUFFER_CONTROL: mmio.Mmio(packed struct(u32) {
                ///  The length of the data in buffer 0.
                LENGTH_0: u10,
                ///  Buffer 0 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_0: u1,
                ///  Reply with a stall (valid for both buffers).
                STALL: u1,
                ///  Reset the buffer selector to buffer 0.
                RESET: u1,
                ///  The data pid of buffer 0.
                PID_0: u1,
                ///  Buffer 0 is the last buffer of the transfer.
                LAST_0: u1,
                ///  Buffer 0 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_0: u1,
                ///  The length of the data in buffer 1.
                LENGTH_1: u10,
                ///  Buffer 1 is available. This bit is set to indicate the buffer can be used by the controller. The controller clears the available bit when writing the status back.
                AVAILABLE_1: u1,
                ///  The number of bytes buffer 1 is offset from buffer 0 in Isochronous mode. Only valid in double buffered mode for an Isochronous endpoint.
                ///  For a non Isochronous endpoint the offset is always 64 bytes.
                DOUBLE_BUFFER_ISO_OFFSET: packed union {
                    raw: u2,
                    value: enum(u2) {
                        @"128" = 0x0,
                        @"256" = 0x1,
                        @"512" = 0x2,
                        @"1024" = 0x3,
                    },
                },
                ///  The data pid of buffer 1.
                PID_1: u1,
                ///  Buffer 1 is the last buffer of the transfer.
                LAST_1: u1,
                ///  Buffer 1 is full. For an IN transfer (TX to the host) the bit is set to indicate the data is valid. For an OUT transfer (RX from the host) this bit should be left as a 0. The host will set it when it has filled the buffer with data.
                FULL_1: u1,
            }),
        };
    };
};
