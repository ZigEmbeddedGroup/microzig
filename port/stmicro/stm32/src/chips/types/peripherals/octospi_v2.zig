const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const FlashSelect = enum(u1) {
    /// FLASH 1 selected (data exchanged over IO[3:0])
    FlashOne = 0x0,
    /// FLASH 2 selected (data exchanged over IO[7:4])
    FlashTwo = 0x1,
};

pub const FunctionalMode = enum(u2) {
    /// Indirect-write mode
    IndirectWrite = 0x0,
    /// Indirect-read mode
    IndirectRead = 0x1,
    /// Automatic status-polling mode
    AutoStatusPolling = 0x2,
    /// Memory-mapped mode
    MemoryMapped = 0x3,
};

pub const LatencyMode = enum(u1) {
    /// Variable initial latency
    Variable = 0x0,
    /// Fixed latency
    Fixed = 0x1,
};

pub const MatchMode = enum(u1) {
    /// AND-match mode, SMF is set if all the unmasked bits received from the device match the corresponding bits in the match register.
    MatchAnd = 0x0,
    /// OR-match mode, SMF is set if any of the unmasked bits received from the device matches its corresponding bit in the match register.
    MatchOr = 0x1,
};

pub const MemType = enum(u3) {
    /// Micron mode, D0/D1 ordering in DTR 8-data-bit mode. Regular-command protocol in Single-, Dual-, Quad- and Octal-SPI modes.
    Micron = 0x0,
    /// Macronix mode, D1/D0 ordering in DTR 8-data-bit mode. Regular-command protocol in Single-, Dual-, Quad- and Octal-SPI modes.
    Macronix = 0x1,
    /// Standard mode
    B_Standard = 0x2,
    /// Macronix RAM mode, D1/D0 ordering in DTR 8-data-bit mode. Regular-command protocol in Single-, Dual-, Quad- and Octal-SPI modes with dedicated address mapping.
    MacronixRam = 0x3,
    /// HyperBus memory mode, the protocol follows the HyperBus specification. 8-data-bit DTR mode must be selected.
    HyperBusMemory = 0x4,
    /// HyperBus register mode, addressing register space. The memory-mapped accesses in. this mode must be non-cacheable, or Indirect read/write modes must be used.
    HyperBusRegister = 0x5,
    _,
};

pub const PhaseMode = enum(u3) {
    /// No alternate bytes
    None = 0x0,
    /// Alternate bytes on a single line
    OneLine = 0x1,
    /// Alternate bytes on two lines
    TwoLines = 0x2,
    /// Alternate bytes on four lines
    FourLines = 0x3,
    /// Alternate bytes on eight lines
    EightLines = 0x4,
    _,
};

pub const SampleShift = enum(u1) {
    /// No shift
    None = 0x0,
    /// 1/2 cycle shift
    HalfCycle = 0x1,
};

pub const SizeInBits = enum(u2) {
    /// 8-bit alternate bytes
    @"8Bit" = 0x0,
    /// 16-bit alternate bytes
    @"16Bit" = 0x1,
    /// 24-bit alternate bytes
    @"24Bit" = 0x2,
    /// 32-bit alternate bytes
    @"32Bit" = 0x3,
};

pub const Threshold = enum(u5) {
    /// FTF is set if there are one or more free bytes available to be written to in the FIFO in Indirect-write mode, or if there are one or more valid bytes can be read from the FIFO in Indirect-read mode.
    NeedOneByte = 0x0,
    /// FTF is set if there are two or more free bytes available to be written to in the FIFO in Indirect‑write mode, or if there are two or more valid bytes can be read from the FIFO in Indirect-read mode.
    NeedTwoBytes = 0x1,
    /// FTF is set if there are 32 free bytes available to be written to in the FIFO in Indirect-write mode, or if there are 32 valid bytes can be read from the FIFO in Indirect-read mode.
    NeedThirtyTwoBytes = 0x1f,
    _,
};

/// OctoSPI
pub const OCTOSPI = extern struct {
    /// control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// Enable This bit enables the OCTOSPI. Note: The DMA request can be aborted without having received the ACK in case this EN bit is cleared during the operation. In case. this bit is set to 0 during a DMA transfer, the REQ signal to DMA returns to inactive state without waiting for the ACK signal from DMA to be active.
        EN: u1,
        /// Abort request. This bit aborts the ongoing command sequence. It is automatically reset once the abort is completed. This bit stops the current transfer. Note: This bit is always read as 0.
        ABORT: u1,
        /// DMA enable In Indirect mode, the DMA can be used to input or output data via DR. DMA transfers are initiated when FTF is set. Note: Resetting the DMAEN bit while a DMA transfer is ongoing, breaks the handshake with the DMA. Do not write. this bit during DMA operation.
        DMAEN: u1,
        /// Timeout counter enable. This bit is valid only when the Memory-mapped mode (FMODE[1:0] = 11) is selected. This bit enables the timeout counter.
        TCEN: u1,
        reserved6: u2 = 0,
        /// Dual-memory configuration. This bit activates the dual-memory configuration, where two external devices are used simultaneously to double the throughput and the capacity
        DMM: u1,
        /// Flash select. This bit selects the Flash memory to be addressed in Single-, Dual-, Quad-SPI mode in single-memory configuration (when DMM = 0). This bit is ignored when DMM = 1 or when Octal-SPI mode is selected.
        FSEL: FlashSelect,
        /// FIFO threshold level. This field defines, in Indirect mode, the threshold number of bytes in the FIFO that causes the FIFO threshold flag FTF in SR, to be set. ... Note: If DMAEN = 1, the DMA controller for the corresponding channel must be disabled before changing the FTHRES[4:0] value.
        FTHRES: Threshold,
        reserved16: u3 = 0,
        /// Transfer error interrupt enable. This bit enables the transfer error interrupt.
        TEIE: u1,
        /// Transfer complete interrupt enable. This bit enables the transfer complete interrupt.
        TCIE: u1,
        /// FIFO threshold interrupt enable. This bit enables the FIFO threshold interrupt.
        FTIE: u1,
        /// Status match interrupt enable. This bit enables the status match interrupt.
        SMIE: u1,
        /// Timeout interrupt enable. This bit enables the timeout interrupt.
        TOIE: u1,
        reserved22: u1 = 0,
        /// Automatic status-polling mode stop. This bit determines if the Automatic status-polling mode is stopped after a match.
        APMS: u1,
        /// Polling match mode. This bit indicates which method must be used to determine a match during the Automatic status-polling mode.
        PMM: MatchMode,
        reserved28: u4 = 0,
        /// Functional mode. This field defines the OCTOSPI functional mode of operation. If DMAEN = 1 already, then the DMA controller for the corresponding channel must be disabled before changing the FMODE[1:0] value. If FMODE[1:0] and FTHRES[4:0] are wrongly updated while DMAEN = 1, the DMA request signal automatically goes to inactive state.
        FMODE: FunctionalMode,
        padding: u2 = 0,
    }),
    /// offset: 0x04
    reserved4: [4]u8,
    /// device configuration register 1
    /// offset: 0x08
    DCR1: mmio.Mmio(packed struct(u32) {
        /// Mode 0/Mode 3 This bit indicates the level taken by the CLK between commands (when NCS = 1).
        CKMODE: u1,
        /// Free running clock. This bit configures the free running clock.
        FRCK: u1,
        reserved3: u1 = 0,
        /// Delay block bypass
        DLYBYP: u1,
        reserved8: u4 = 0,
        /// Chip-select high time CSHT + 1 defines the minimum number of CLK cycles where the chip-select (NCS) must remain high between commands issued to the external device. ...
        CSHT: u6,
        reserved16: u2 = 0,
        /// Device size. This field defines the size of the external device using the following formula: Number of bytes in device = 2[DEVSIZE+1]. DEVSIZE+1 is effectively the number of address bits required to address the external device. The device capacity can be up to 4 Gbytes (addressed using 32-bits) in Indirect mode, but the addressable space in Memory-mapped mode is limited to 256 Mbytes. In Regular-command protocol, if DMM = 1, DEVSIZE[4:0] indicates the total capacity of the two devices together.
        DEVSIZE: u5,
        reserved24: u3 = 0,
        /// Memory type. This bit indicates the type of memory to be supported. Note: In. this mode, DQS signal polarity is inverted with respect to the memory clock signal. This is the default value and care must be taken to change MTYP[2:0] for memories different from Micron. Others: Reserved
        MTYP: MemType,
        padding: u5 = 0,
    }),
    /// device configuration register 2
    /// offset: 0x0c
    DCR2: mmio.Mmio(packed struct(u32) {
        /// Clock prescaler. This field defines the scaler factor for generating the CLK based on the kernel clock (value + 1). 2: FCLK = FKERNEL/3 ... 255: FCLK = FKERNEL/256 For odd clock division factors, the CLK duty cycle is not 50 %. The clock signal remains low one cycle longer than it stays high.
        PRESCALER: u8,
        reserved16: u8 = 0,
        /// Wrap size. This field indicates the wrap size to which the memory is configured. For memories which have a separate command for wrapped instructions, this field indicates the wrap-size associated with the command held in the OCTOSPI1_WPIR register. 110-111: Reserved
        WRAPSIZE: u3,
        padding: u13 = 0,
    }),
    /// device configuration register 3
    /// offset: 0x10
    DCR3: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// NCS boundary. This field enables the transaction boundary feature. When active, a minimum value of 3 is recommended. The NCS is released on each boundary of 2CSBOUND bytes. others: NCS boundary set to 2CSBOUND bytes
        CSBOUND: u5,
        padding: u11 = 0,
    }),
    /// device configuration register 4
    /// offset: 0x14
    DCR4: mmio.Mmio(packed struct(u32) {
        /// Refresh rate. This field enables the refresh rate feature. The NCS is released every REFRESH + 1 clock cycles for writes, and REFRESH + 4 clock cycles for reads. Note: These two values can be extended with few clock cycles when refresh occurs during a byte transmission in Single-, Dual- or Quad-SPI mode, because the byte transmission must be completed. others: Maximum communication length is set to REFRESH + 1 clock cycles.
        REFRESH: u32,
    }),
    /// offset: 0x18
    reserved24: [8]u8,
    /// status register
    /// offset: 0x20
    SR: mmio.Mmio(packed struct(u32) {
        /// Transfer error flag. This bit is set in Indirect mode when an invalid address is being accessed in Indirect mode. It is cleared by writing 1 to CTEF.
        TEF: u1,
        /// Transfer complete flag. This bit is set in Indirect mode when the programmed number of data has been transferred or in any mode when the transfer has been aborted.It is cleared by writing 1 to CTCF.
        TCF: u1,
        /// FIFO threshold flag In Indirect mode, this bit is set when the FIFO threshold has been reached, or if there is any data left in the FIFO after the reads from the external device are complete. It is cleared automatically as soon as the threshold condition is no longer true. In Automatic status-polling mode, this bit is set every time the status register is read, and the bit is cleared when the data register is read.
        FTF: u1,
        /// Status match flag. This bit is set in Automatic status-polling mode when the unmasked received data matches the corresponding bits in the match register (PSMAR). It is cleared by writing 1 to CSMF.
        SMF: u1,
        /// Timeout flag. This bit is set when timeout occurs. It is cleared by writing 1 to CTOF.
        TOF: u1,
        /// Busy. This bit is set when an operation is ongoing. It is cleared automatically when the operation with the external device is finished and the FIFO is empty.
        BUSY: u1,
        reserved8: u2 = 0,
        /// FIFO level. This field gives the number of valid bytes that are being held in the FIFO. FLEVEL = 0 when the FIFO is empty, and 32 when it is full. In Automatic status-polling mode, FLEVEL is zero.
        FLEVEL: u6,
        padding: u18 = 0,
    }),
    /// flag clear register
    /// offset: 0x24
    FCR: mmio.Mmio(packed struct(u32) {
        /// Clear transfer error flag Writing 1 clears the TEF flag in the SR register.
        CTEF: u1,
        /// Clear transfer complete flag Writing 1 clears the TCF flag in the SR register.
        CTCF: u1,
        reserved3: u1 = 0,
        /// Clear status match flag Writing 1 clears the SMF flag in the SR register.
        CSMF: u1,
        /// Clear timeout flag Writing 1 clears the TOF flag in the SR register.
        CTOF: u1,
        padding: u27 = 0,
    }),
    /// offset: 0x28
    reserved40: [24]u8,
    /// data length register
    /// offset: 0x40
    DLR: mmio.Mmio(packed struct(u32) {
        /// [31: 0]: Data length Number of data to be retrieved (value+1) in Indirect and Automatic status-polling modes. A value not greater than three (indicating 4 bytes) must be used for Automatic status-polling mode. All 1’s in Indirect mode means undefined length, where OCTOSPI continues until the end of the memory, as defined by DEVSIZE. 0x0000_0000: 1 byte is to be transferred. 0x0000_0001: 2 bytes are to be transferred. 0x0000_0002: 3 bytes are to be transferred. 0x0000_0003: 4 bytes are to be transferred. ... 0xFFFF_FFFD: 4,294,967,294 (4G-2) bytes are to be transferred. 0xFFFF_FFFE: 4,294,967,295 (4G-1) bytes are to be transferred. 0xFFFF_FFFF: undefined length; all bytes, until the end of the external device, (as defined by DEVSIZE) are to be transferred. Continue reading indefinitely if DEVSIZE = 0x1F. DL[0] is stuck at 1 in dual-memory configuration (DMM = 1) even when 0 is written to. this bit, thus assuring that each access transfers an even number of bytes. This field has no effect in Memory-mapped mode.
        DL: u32,
    }),
    /// offset: 0x44
    reserved68: [4]u8,
    /// address register
    /// offset: 0x48
    AR: mmio.Mmio(packed struct(u32) {
        /// Address to be sent to the external device. In HyperBus protocol, this field must be even as this protocol is 16-bit word oriented. In dual-memory configuration, AR[0] is forced to 1. Writes to. this field are ignored when BUSY = 1 or when FMODE = 11 (Memory-mapped mode).
        ADDRESS: u32,
    }),
    /// offset: 0x4c
    reserved76: [4]u8,
    /// data register
    /// offset: 0x50
    DR: mmio.Mmio(packed struct(u32) {
        /// [31: 0]: Data Data to be sent/received to/from the external SPI device In Indirect-write mode, data written to this register is stored on the FIFO before it is sent to the external device during the data phase. If the FIFO is too full, a write operation is stalled until the FIFO has enough space to accept the amount of data being written. In Indirect-read mode, reading this register gives (via the FIFO) the data that was received from the external device. If the FIFO does not have as many bytes as requested by the read operation and if BUSY = 1, the read operation is stalled until enough data is present or until the transfer is complete, whichever happens first. In Automatic status-polling mode, this register contains the last data read from the external device (without masking). Word, half-word, and byte accesses to this register are supported. In Indirect-write mode, a byte write adds 1 byte to the FIFO, a half-word write 2 bytes, and a word write 4 bytes. Similarly, in Indirect-read mode, a byte read removes 1 byte from the FIFO, a halfword read 2 bytes, and a word read 4 bytes. Accesses in Indirect mode must be aligned to the bottom of. this register: A byte read must read DATA[7:0] and a half-word read must read DATA[15:0].
        DATA: u32,
    }),
    /// offset: 0x54
    reserved84: [44]u8,
    /// polling status mask register
    /// offset: 0x80
    PSMKR: mmio.Mmio(packed struct(u32) {
        /// Status mask Mask to be applied to the status bytes received in Automatic status-polling mode For bit n:
        MASK: u32,
    }),
    /// offset: 0x84
    reserved132: [4]u8,
    /// polling status match register
    /// offset: 0x88
    PSMAR: mmio.Mmio(packed struct(u32) {
        /// [31: 0]: Status match Value to be compared with the masked status register to get a match
        MATCH: u32,
    }),
    /// offset: 0x8c
    reserved140: [4]u8,
    /// polling interval register
    /// offset: 0x90
    PIR: mmio.Mmio(packed struct(u32) {
        /// [15: 0]: Polling interval Number of CLK cycle between a read during the Automatic status-polling phases
        INTERVAL: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x94
    reserved148: [108]u8,
    /// communication configuration register
    /// offset: 0x100
    CCR: mmio.Mmio(packed struct(u32) {
        /// Instruction mode. This field defines the instruction phase mode of operation. 101-111: Reserved
        IMODE: PhaseMode,
        /// Instruction double transfer rate. This bit sets the DTR mode for the instruction phase.
        IDTR: u1,
        /// Instruction size. This bit defines instruction size.
        ISIZE: SizeInBits,
        reserved8: u2 = 0,
        /// Address mode. This field defines the address phase mode of operation. 101-111: Reserved
        ADMODE: PhaseMode,
        /// Address double transfer rate. This bit sets the DTR mode for the address phase.
        ADDTR: u1,
        /// Address size. This field defines address size.
        ADSIZE: SizeInBits,
        reserved16: u2 = 0,
        /// Alternate-byte mode. This field defines the alternate-byte phase mode of operation. 101-111: Reserved
        ABMODE: PhaseMode,
        /// Alternate bytes double transfer rate. This bit sets the DTR mode for the alternate bytes phase. This field can be written only when BUSY = 0.
        ABDTR: u1,
        /// Alternate bytes size. This bit defines alternate bytes size.
        ABSIZE: SizeInBits,
        reserved24: u2 = 0,
        /// Data mode. This field defines the data phase mode of operation. 101-111: Reserved
        DMODE: PhaseMode,
        /// Data double transfer rate. This bit sets the DTR mode for the data phase.
        DDTR: u1,
        reserved29: u1 = 0,
        /// DQS enable. This bit enables the data strobe management.
        DQSE: u1,
        reserved31: u1 = 0,
        /// Send instruction only once mode. This bit has no effect when IMODE = 00 (see ).
        SIOO: u1,
    }),
    /// offset: 0x104
    reserved260: [4]u8,
    /// timing configuration register
    /// offset: 0x108
    TCR: mmio.Mmio(packed struct(u32) {
        /// Number of dummy cycles. This field defines the duration of the dummy phase. In both SDR and DTR modes, it specifies a number of CLK cycles (0-31). It is recommended to have at least six dummy cycles when using memories with DQS activated.
        DCYC: u5,
        reserved28: u23 = 0,
        /// Delay hold quarter cycle
        DHQC: u1,
        reserved30: u1 = 0,
        /// Sample shift By default, the OCTOSPI samples data 1/2 of a CLK cycle after the data is driven by the external device. This bit allows the data to be sampled later in order to consider the external signal delays. The software must ensure that SSHIFT = 0 when the data phase is configured in DTR mode (when DDTR = 1.)
        SSHIFT: SampleShift,
        padding: u1 = 0,
    }),
    /// offset: 0x10c
    reserved268: [4]u8,
    /// instruction register
    /// offset: 0x110
    IR: mmio.Mmio(packed struct(u32) {
        /// Instruction to be sent to the external SPI device
        INSTRUCTION: u32,
    }),
    /// offset: 0x114
    reserved276: [12]u8,
    /// alternate bytes register
    /// offset: 0x120
    ABR: mmio.Mmio(packed struct(u32) {
        /// Alternate bytes
        ALTERNATE: u32,
    }),
    /// offset: 0x124
    reserved292: [12]u8,
    /// low-power timeout register
    /// offset: 0x130
    LPTR: mmio.Mmio(packed struct(u32) {
        /// [15: 0]: Timeout period After each access in Memory-mapped mode, the OCTOSPI prefetches the subsequent bytes and hold them in the FIFO. This field indicates how many CLK cycles the OCTOSPI waits after the clock becomes inactive and until it raises the NCS, putting the external device in a lower-consumption state.
        TIMEOUT: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x134
    reserved308: [12]u8,
    /// wrap communication configuration register
    /// offset: 0x140
    WPCCR: mmio.Mmio(packed struct(u32) {
        /// Instruction mode. This field defines the instruction phase mode of operation. 101-111: Reserved
        IMODE: PhaseMode,
        /// Instruction double transfer rate. This bit sets the DTR mode for the instruction phase.
        IDTR: u1,
        /// Instruction size. This field defines instruction size.
        ISIZE: SizeInBits,
        reserved8: u2 = 0,
        /// Address mode. This field defines the address phase mode of operation. 101-111: Reserved
        ADMODE: PhaseMode,
        /// Address double transfer rate. This bit sets the DTR mode for the address phase.
        ADDTR: u1,
        /// Address size. This field defines address size.
        ADSIZE: SizeInBits,
        reserved16: u2 = 0,
        /// Alternate-byte mode. This field defines the alternate byte phase mode of operation. 101-111: Reserved
        ABMODE: PhaseMode,
        /// Alternate bytes double transfer rate. This bit sets the DTR mode for the alternate bytes phase.
        ABDTR: u1,
        /// Alternate bytes size. This bit defines alternate bytes size.
        ABSIZE: SizeInBits,
        reserved24: u2 = 0,
        /// Data mode. This field defines the data phase mode of operation. 101-111: Reserved
        DMODE: PhaseMode,
        /// Data double transfer rate. This bit sets the DTR mode for the data phase.
        DDTR: u1,
        reserved29: u1 = 0,
        /// DQS enable. This bit enables the data strobe management.
        DQSE: u1,
        padding: u2 = 0,
    }),
    /// offset: 0x144
    reserved324: [4]u8,
    /// wrap timing configuration register
    /// offset: 0x148
    WPTCR: mmio.Mmio(packed struct(u32) {
        /// Number of dummy cycles. This field defines the duration of the dummy phase. In both SDR and DTR modes, it specifies a number of CLK cycles (0-31). It is recommended to have at least 5 dummy cycles when using memories with DQS activated.
        DCYC: u5,
        reserved28: u23 = 0,
        /// Delay hold quarter cycle. Add a quarter cycle delay on the outputs in DTR communication to match hold requirement.
        DHQC: u1,
        reserved30: u1 = 0,
        /// Sample shift By default, the OCTOSPI samples data 1/2 of a CLK cycle after the data is driven by the external device. This bit allows the data to be sampled later in order to consider the external signal delays. The firmware must assure that SSHIFT=0 when the data phase is configured in DTR mode (when DDTR = 1).
        SSHIFT: SampleShift,
        padding: u1 = 0,
    }),
    /// offset: 0x14c
    reserved332: [4]u8,
    /// wrap instruction register
    /// offset: 0x150
    WPIR: mmio.Mmio(packed struct(u32) {
        /// [31: 0]: Instruction Instruction to be sent to the external SPI device
        INSTRUCTION: u32,
    }),
    /// offset: 0x154
    reserved340: [12]u8,
    /// wrap alternate bytes register
    /// offset: 0x160
    WPABR: mmio.Mmio(packed struct(u32) {
        /// [31: 0]: Alternate bytes Optional data to be sent to the external SPI device right after the address
        ALTERNATE: u32,
    }),
    /// offset: 0x164
    reserved356: [28]u8,
    /// write communication configuration register
    /// offset: 0x180
    WCCR: mmio.Mmio(packed struct(u32) {
        /// Instruction mode. This field defines the instruction phase mode of operation. 101-111: Reserved
        IMODE: PhaseMode,
        /// Instruction double transfer rate. This bit sets the DTR mode for the instruction phase.
        IDTR: u1,
        /// Instruction size. This bit defines instruction size:
        ISIZE: SizeInBits,
        reserved8: u2 = 0,
        /// Address mode. This field defines the address phase mode of operation. 101-111: Reserved
        ADMODE: PhaseMode,
        /// Address double transfer rate. This bit sets the DTR mode for the address phase.
        ADDTR: u1,
        /// Address size. This field defines address size.
        ADSIZE: SizeInBits,
        reserved16: u2 = 0,
        /// Alternate-byte mode. This field defines the alternate-byte phase mode of operation. 101-111: Reserved
        ABMODE: PhaseMode,
        /// Alternate bytes double transfer rate. This bit sets the DTR mode for the alternate-bytes phase.
        ABDTR: u1,
        /// Alternate bytes size. This field defines alternate bytes size:
        ABSIZE: SizeInBits,
        reserved24: u2 = 0,
        /// Data mode. This field defines the data phase mode of operation. 101-111: Reserved
        DMODE: PhaseMode,
        /// data double transfer rate. This bit sets the DTR mode for the data phase.
        DDTR: u1,
        reserved29: u1 = 0,
        /// DQS enable. This bit enables the data strobe management.
        DQSE: u1,
        padding: u2 = 0,
    }),
    /// offset: 0x184
    reserved388: [4]u8,
    /// write timing configuration register
    /// offset: 0x188
    WTCR: mmio.Mmio(packed struct(u32) {
        /// Number of dummy cycles. This field defines the duration of the dummy phase. In both SDR and DTR modes, it specifies a number of CLK cycles (0-31). It is recommended to have at least 5 dummy cycles when using memories with DQS activated.
        DCYC: u5,
        padding: u27 = 0,
    }),
    /// offset: 0x18c
    reserved396: [4]u8,
    /// write instruction register
    /// offset: 0x190
    WIR: mmio.Mmio(packed struct(u32) {
        /// Instruction Instruction to be sent to the external SPI device
        INSTRUCTION: u32,
    }),
    /// offset: 0x194
    reserved404: [12]u8,
    /// write alternate bytes register
    /// offset: 0x1a0
    WABR: mmio.Mmio(packed struct(u32) {
        /// [31: 0]: Alternate bytes. Optional data to be sent to the external SPI device right after the address
        ALTERNATE: u32,
    }),
    /// offset: 0x1a4
    reserved420: [92]u8,
    /// OCTOSPI HyperBus latency configuration register
    /// offset: 0x200
    HLCR: mmio.Mmio(packed struct(u32) {
        /// Latency mode. This bit selects the Latency mode.
        LM: LatencyMode,
        /// Write zero latency. This bit enables zero latency on write operations.
        WZL: u1,
        reserved8: u6 = 0,
        /// [7: 0]: Access time. Device access time expressed in number of communication clock cycles
        TACC: u8,
        /// Read write recovery time Device read write recovery time expressed in number of communication clock cycles
        TRWR: u8,
        padding: u8 = 0,
    }),
};
