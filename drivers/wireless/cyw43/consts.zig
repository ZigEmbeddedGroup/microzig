// Register addresses
pub const REG_BUS_CTRL: u32 = 0x0;
pub const REG_BUS_RESPONSE_DELAY: u32 = 0x1;
pub const REG_BUS_STATUS_ENABLE: u32 = 0x2;
pub const REG_BUS_INTERRUPT: u32 = 0x04; // 16 bits - Interrupt status
pub const REG_BUS_INTERRUPT_ENABLE: u32 = 0x06; // 16 bits - Interrupt mask
pub const REG_BUS_STATUS: u32 = 0x8;
pub const REG_BUS_TEST_RO: u32 = 0x14;
pub const REG_BUS_TEST_RW: u32 = 0x18;
pub const REG_BUS_RESP_DELAY: u32 = 0x1c;

// SPI_BUS_CONTROL Bits
pub const WORD_LENGTH_32: u32 = 0x1;
pub const ENDIAN_BIG: u32 = 0x2;
pub const CLOCK_PHASE: u32 = 0x4;
pub const CLOCK_POLARITY: u32 = 0x8;
pub const HIGH_SPEED: u32 = 0x10;
pub const INTERRUPT_POLARITY_HIGH: u32 = 0x20;
pub const WAKE_UP: u32 = 0x80;

// SPI_STATUS_ENABLE bits
pub const STATUS_ENABLE: u32 = 0x01;
pub const INTR_WITH_STATUS: u32 = 0x02;
pub const RESP_DELAY_ALL: u32 = 0x04;
pub const DWORD_PKT_LEN_EN: u32 = 0x08;
pub const CMD_ERR_CHK_EN: u32 = 0x20;
pub const DATA_ERR_CHK_EN: u32 = 0x40;

// SPI_STATUS_REGISTER bits
pub const STATUS_DATA_NOT_AVAILABLE: u32 = 0x00000001;
pub const STATUS_UNDERFLOW: u32 = 0x00000002;
pub const STATUS_OVERFLOW: u32 = 0x00000004;
pub const STATUS_F2_INTR: u32 = 0x00000008;
pub const STATUS_F3_INTR: u32 = 0x00000010;
pub const STATUS_F2_RX_READY: u32 = 0x00000020;
pub const STATUS_F3_RX_READY: u32 = 0x00000040;
pub const STATUS_HOST_CMD_DATA_ERR: u32 = 0x00000080;
pub const STATUS_F2_PKT_AVAILABLE: u32 = 0x00000100;
pub const STATUS_F2_PKT_LEN_MASK: u32 = 0x000FFE00;
pub const STATUS_F2_PKT_LEN_SHIFT: u32 = 9;
pub const STATUS_F3_PKT_AVAILABLE: u32 = 0x00100000;
pub const STATUS_F3_PKT_LEN_MASK: u32 = 0xFFE00000;
pub const STATUS_F3_PKT_LEN_SHIFT: u32 = 21;

pub const REG_BACKPLANE_GPIO_SELECT: u32 = 0x10005;
pub const REG_BACKPLANE_GPIO_OUTPUT: u32 = 0x10006;
pub const REG_BACKPLANE_GPIO_ENABLE: u32 = 0x10007;
pub const REG_BACKPLANE_FUNCTION2_WATERMARK: u32 = 0x10008;
pub const REG_BACKPLANE_DEVICE_CONTROL: u32 = 0x10009;
pub const REG_BACKPLANE_BACKPLANE_ADDRESS_LOW: u32 = 0x1000A;
pub const REG_BACKPLANE_BACKPLANE_ADDRESS_MID: u32 = 0x1000B;
pub const REG_BACKPLANE_BACKPLANE_ADDRESS_HIGH: u32 = 0x1000C;
pub const REG_BACKPLANE_FRAME_CONTROL: u32 = 0x1000D;
pub const REG_BACKPLANE_CHIP_CLOCK_CSR: u32 = 0x1000E;
pub const REG_BACKPLANE_PULL_UP: u32 = 0x1000F;
pub const REG_BACKPLANE_READ_FRAME_BC_LOW: u32 = 0x1001B;
pub const REG_BACKPLANE_READ_FRAME_BC_HIGH: u32 = 0x1001C;
pub const REG_BACKPLANE_WAKEUP_CTRL: u32 = 0x1001E;
pub const REG_BACKPLANE_SLEEP_CSR: u32 = 0x1001F;

pub const I_HMB_SW_MASK: u32 = 0x000000f0;
pub const I_HMB_FC_CHANGE: u32 = 1 << 5;
pub const SDIO_INT_STATUS: u32 = 0x20;
pub const SDIO_INT_HOST_MASK: u32 = 0x24;

pub const SPI_F2_WATERMARK: u8 = 0x20;

pub const BACKPLANE_WINDOW_SIZE: usize = 0x8000;
pub const BACKPLANE_ADDRESS_MASK: u32 = 0x7FFF;
pub const BACKPLANE_ADDRESS_32BIT_FLAG: u32 = 0x08000;
pub const BACKPLANE_MAX_TRANSFER_SIZE: usize = 64;
// Active Low Power (ALP) clock constants
pub const BACKPLANE_ALP_AVAIL_REQ: u8 = 0x08;
pub const BACKPLANE_ALP_AVAIL: u8 = 0x40;

// Broadcom AMBA (Advanced Microcontroller Bus Architecture) Interconnect
// (AI) pub (crate) constants
pub const AI_IOCTRL_OFFSET: u32 = 0x408;
pub const AI_IOCTRL_BIT_FGC: u8 = 0x0002;
pub const AI_IOCTRL_BIT_CLOCK_EN: u8 = 0x0001;
pub const AI_IOCTRL_BIT_CPUHALT: u8 = 0x0020;

pub const AI_RESETCTRL_OFFSET: u32 = 0x800;
pub const AI_RESETCTRL_BIT_RESET: u8 = 1;

pub const AI_RESETSTATUS_OFFSET: u32 = 0x804;

pub const TEST_PATTERN: u32 = 0x12345678;
pub const FEEDBEAD: u32 = 0xFEEDBEAD;

// SPI_INTERRUPT_REGISTER and SPI_INTERRUPT_ENABLE_REGISTER Bits
pub const IRQ_DATA_UNAVAILABLE: u16 = 0x0001; // Requested data not available; Clear by writing a "1"
pub const IRQ_F2_F3_FIFO_RD_UNDERFLOW: u16 = 0x0002;
pub const IRQ_F2_F3_FIFO_WR_OVERFLOW: u16 = 0x0004;
pub const IRQ_COMMAND_ERROR: u16 = 0x0008; // Cleared by writing 1
pub const IRQ_DATA_ERROR: u16 = 0x0010; // Cleared by writing 1
pub const IRQ_F2_PACKET_AVAILABLE: u16 = 0x0020;
pub const IRQ_F3_PACKET_AVAILABLE: u16 = 0x0040;
pub const IRQ_F1_OVERFLOW: u16 = 0x0080; // Due to last write. Bkplane has pending write requests
pub const IRQ_MISC_INTR0: u16 = 0x0100;
pub const IRQ_MISC_INTR1: u16 = 0x0200;
pub const IRQ_MISC_INTR2: u16 = 0x0400;
pub const IRQ_MISC_INTR3: u16 = 0x0800;
pub const IRQ_MISC_INTR4: u16 = 0x1000;
pub const IRQ_F1_INTR: u16 = 0x2000;
pub const IRQ_F2_INTR: u16 = 0x4000;
pub const IRQ_F3_INTR: u16 = 0x8000;

// Bluetooth constants.
pub const SPI_RESP_DELAY_F1: u32 = 0x001d;
pub const WHD_BUS_SPI_BACKPLANE_READ_PADD_SIZE: u8 = 4;
