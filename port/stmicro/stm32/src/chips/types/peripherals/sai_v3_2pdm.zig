const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const CKSTR = enum(u1) {
    /// Data strobing edge is falling edge of SCK
    FallingEdge = 0x0,
    /// Data strobing edge is rising edge of SCK
    RisingEdge = 0x1,
};

pub const CNRDY = enum(u1) {
    /// External AC’97 Codec is ready
    Ready = 0x0,
    /// External AC’97 Codec is not ready
    NotReady = 0x1,
};

pub const COMP = enum(u2) {
    /// No companding algorithm
    NoCompanding = 0x0,
    /// μ-Law algorithm
    MuLaw = 0x2,
    /// A-Law algorithm
    ALaw = 0x3,
    _,
};

pub const CPL = enum(u1) {
    /// 1’s complement representation
    OnesComplement = 0x0,
    /// 2’s complement representation
    TwosComplement = 0x1,
};

pub const DS = enum(u3) {
    /// 8 bits
    Bit8 = 0x2,
    /// 10 bits
    Bit10 = 0x3,
    /// 16 bits
    Bit16 = 0x4,
    /// 20 bits
    Bit20 = 0x5,
    /// 24 bits
    Bit24 = 0x6,
    /// 32 bits
    Bit32 = 0x7,
    _,
};

pub const FLVL = enum(u3) {
    /// FIFO empty
    Empty = 0x0,
    /// FIFO <= 1⁄4 but not empty
    Quarter1 = 0x1,
    /// 1⁄4 < FIFO <= 1⁄2
    Quarter2 = 0x2,
    /// 1⁄2 < FIFO <= 3⁄4
    Quarter3 = 0x3,
    /// 3⁄4 < FIFO but not full
    Quarter4 = 0x4,
    /// FIFO full
    Full = 0x5,
    _,
};

pub const FSOFF = enum(u1) {
    /// FS is asserted on the first bit of the slot 0
    OnFirst = 0x0,
    /// FS is asserted one bit before the first bit of the slot 0
    BeforeFirst = 0x1,
};

pub const FSPOL = enum(u1) {
    /// FS is active low (falling edge)
    FallingEdge = 0x0,
    /// FS is active high (rising edge)
    RisingEdge = 0x1,
};

pub const FTH = enum(u3) {
    /// FIFO empty
    Empty = 0x0,
    /// 1⁄4 FIFO
    Quarter1 = 0x1,
    /// 1⁄2 FIFO
    Quarter2 = 0x2,
    /// 3⁄4 FIFO
    Quarter3 = 0x3,
    /// FIFO full
    Full = 0x4,
    _,
};

pub const LSBFIRST = enum(u1) {
    /// Data are transferred with MSB first
    MsbFirst = 0x0,
    /// Data are transferred with LSB first
    LsbFirst = 0x1,
};

pub const MODE = enum(u2) {
    /// Master transmitter
    MasterTx = 0x0,
    /// Master receiver
    MasterRx = 0x1,
    /// Slave transmitter
    SlaveTx = 0x2,
    /// Slave receiver
    SlaveRx = 0x3,
};

pub const MONO = enum(u1) {
    /// Stereo mode
    Stereo = 0x0,
    /// Mono mode
    Mono = 0x1,
};

pub const MUTEVAL = enum(u1) {
    /// Bit value 0 is sent during the mute mode
    SendZero = 0x0,
    /// Last values are sent during the mute mode
    SendLast = 0x1,
};

pub const NODIV = enum(u1) {
    /// MCLK output is enabled. Forces the ratio between FS and MCLK to 256 or 512 according to the OSR value
    MasterClock = 0x0,
    /// MCLK output enable set by the MCKEN bit (where present, else 0). Ratio between FS and MCLK depends on FRL.
    NoDiv = 0x1,
};

pub const OUTDRIV = enum(u1) {
    /// Audio block output driven when SAIEN is set
    OnStart = 0x0,
    /// Audio block output driven immediately after the setting of this bit
    Immediately = 0x1,
};

pub const PRTCFG = enum(u2) {
    /// Free protocol. Free protocol allows to use the powerful configuration of the audio block to address a specific audio protocol
    Free = 0x0,
    /// SPDIF protocol
    Spdif = 0x1,
    /// AC’97 protocol
    Ac97 = 0x2,
    _,
};

pub const SLOTEN = enum(u16) {
    /// Inactive slot
    Inactive = 0x0,
    /// Active slot
    Active = 0x1,
    _,
};

pub const SLOTSZ = enum(u2) {
    /// The slot size is equivalent to the data size (specified in DS[3:0] in the SAI_xCR1 register)
    DataSize = 0x0,
    /// 16-bit
    Bit16 = 0x1,
    /// 32-bit
    Bit32 = 0x2,
    _,
};

pub const SYNCEN = enum(u2) {
    /// audio sub-block in asynchronous mode
    Asynchronous = 0x0,
    /// audio sub-block is synchronous with the other internal audio sub-block. In this case, the audio sub-block must be configured in slave mode
    Internal = 0x1,
    /// audio sub-block is synchronous with an external SAI embedded peripheral. In this case the audio sub-block should be configured in Slave mode
    External = 0x2,
    _,
};

pub const WCKCFG = enum(u1) {
    /// Clock configuration is correct
    Correct = 0x0,
    /// Clock configuration does not respect the rule concerning the frame length specification
    Wrong = 0x1,
};

/// Cluster CH%s, containing ?CR1, ?CR2, ?FRCR, ?SLOTR, ?IM, ?SR, ?CLRFR, ?DR
pub const CH = extern struct {
    /// Configuration register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// SAIx audio block mode immediately
        MODE: MODE,
        /// Protocol configuration. These bits are set and cleared by software. These bits have to be configured when the audio block is disabled.
        PRTCFG: PRTCFG,
        reserved5: u1 = 0,
        /// Data size. These bits are set and cleared by software. These bits are ignored when the SPDIF protocols are selected (bit PRTCFG[1:0]), because the frame and the data size are fixed in such case. When the companding mode is selected through COMP[1:0] bits, DS[1:0] are ignored since the data size is fixed to 8 bits by the algorithm. These bits must be configured when the audio block is disabled.
        DS: DS,
        /// Least significant bit first. This bit is set and cleared by software. It must be configured when the audio block is disabled. This bit has no meaning in AC97 audio protocol since AC97 data are always transferred with the MSB first. This bit has no meaning in SPDIF audio protocol since in SPDIF data are always transferred with LSB first.
        LSBFIRST: LSBFIRST,
        /// Clock strobing edge. This bit is set and cleared by software. It must be configured when the audio block is disabled. This bit has no meaning in SPDIF audio protocol.
        CKSTR: CKSTR,
        /// Synchronization enable. These bits are set and cleared by software. They must be configured when the audio sub-block is disabled. Note: The audio sub-block should be configured as asynchronous when SPDIF mode is enabled.
        SYNCEN: SYNCEN,
        /// Mono mode. This bit is set and cleared by software. It is meaningful only when the number of slots is equal to 2. When the mono mode is selected, slot 0 data are duplicated on slot 1 when the audio block operates as a transmitter. In reception mode, the slot1 is discarded and only the data received from slot 0 are stored. Refer to Section: Mono/stereo mode for more details.
        MONO: MONO,
        /// Output drive. This bit is set and cleared by software. Note: This bit has to be set before enabling the audio block and after the audio block configuration.
        OUTDRIV: OUTDRIV,
        reserved16: u2 = 0,
        /// Audio block enable where x is A or B. This bit is set by software. To switch off the audio block, the application software must program this bit to 0 and poll the bit till it reads back 0, meaning that the block is completely disabled. Before setting this bit to 1, check that it is set to 0, otherwise the enable command will not be taken into account. This bit allows to control the state of SAIx audio block. If it is disabled when an audio frame transfer is ongoing, the ongoing transfer completes and the cell is fully disabled at the end of this audio frame transfer. Note: When SAIx block is configured in master mode, the clock must be present on the input of SAIx before setting SAIXEN bit.
        SAIEN: u1,
        /// DMA enable. This bit is set and cleared by software. Note: Since the audio block defaults to operate as a transmitter after reset, the MODE[1:0] bits must be configured before setting DMAEN to avoid a DMA request in receiver mode.
        DMAEN: u1,
        reserved19: u1 = 0,
        /// No fixed divider between MCLK and FS
        NODIV: NODIV,
        /// Master clock divider. These bits are set and cleared by software. These bits are meaningless when the audio block operates in slave mode. They have to be configured when the audio block is disabled. Others: the master clock frequency is calculated accordingly to the following formula:
        MCKDIV: u6,
        /// Oversampling ratio for master clock
        OSR: u1,
        padding: u5 = 0,
    }),
    /// Configuration register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        /// FIFO threshold. This bit is set and cleared by software.
        FTH: FTH,
        /// FIFO flush. This bit is set by software. It is always read as 0. This bit should be configured when the SAI is disabled.
        FFLUSH: u1,
        /// Tristate management on data line. This bit is set and cleared by software. It is meaningful only if the audio block is configured as a transmitter. This bit is not used when the audio block is configured in SPDIF mode. It should be configured when SAI is disabled. Refer to Section: Output data line management on an inactive slot for more details.
        TRIS: u1,
        /// Mute. This bit is set and cleared by software. It is meaningful only when the audio block operates as a transmitter. The MUTE value is linked to value of MUTEVAL if the number of slots is lower or equal to 2, or equal to 0 if it is greater than 2. Refer to Section: Mute mode for more details. Note: This bit is meaningless and should not be used for SPDIF audio blocks.
        MUTE: u1,
        /// Mute value. This bit is set and cleared by software.It must be written before enabling the audio block: SAIXEN. This bit is meaningful only when the audio block operates as a transmitter, the number of slots is lower or equal to 2 and the MUTE bit is set. If more slots are declared, the bit value sent during the transmission in mute mode is equal to 0, whatever the value of MUTEVAL. if the number of slot is lower or equal to 2 and MUTEVAL = 1, the MUTE value transmitted for each slot is the one sent during the previous frame. Refer to Section: Mute mode for more details. Note: This bit is meaningless and should not be used for SPDIF audio blocks.
        MUTEVAL: MUTEVAL,
        /// Mute counter. These bits are set and cleared by software. They are used only in reception mode. The value set in these bits is compared to the number of consecutive mute frames detected in reception. When the number of mute frames is equal to this value, the flag MUTEDET will be set and an interrupt will be generated if bit MUTEDETIE is set. Refer to Section: Mute mode for more details.
        MUTECNT: u6,
        /// Complement bit. This bit is set and cleared by software. It defines the type of complement to be used for companding mode Note: This bit has effect only when the companding mode is -Law algorithm or A-Law algorithm.
        CPL: CPL,
        /// Companding mode. These bits are set and cleared by software. The -Law and the A-Law log are a part of the CCITT G.711 recommendation, the type of complement that will be used depends on CPL bit. The data expansion or data compression are determined by the state of bit MODE[0]. The data compression is applied if the audio block is configured as a transmitter. The data expansion is automatically applied when the audio block is configured as a receiver. Refer to Section: Companding mode for more details. Note: Companding mode is applicable only when TDM is selected.
        COMP: COMP,
        padding: u16 = 0,
    }),
    /// This register has no meaning in AC97 and SPDIF audio protocol
    /// offset: 0x08
    FRCR: mmio.Mmio(packed struct(u32) {
        /// Frame length. These bits are set and cleared by software. They define the audio frame length expressed in number of SCK clock cycles: the number of bits in the frame is equal to FRL[7:0] + 1. The minimum number of bits to transfer in an audio frame must be equal to 8, otherwise the audio block will behaves in an unexpected way. This is the case when the data size is 8 bits and only one slot 0 is defined in NBSLOT[4:0] of SAI_xSLOTR register (NBSLOT[3:0] = 0000). In master mode, if the master clock (available on MCLK_x pin) is used, the frame length should be aligned with a number equal to a power of 2, ranging from 8 to 256. When the master clock is not used (NODIV = 1), it is recommended to program the frame length to an value ranging from 8 to 256. These bits are meaningless and are not used in AC97 or SPDIF audio block configuration.
        FRL: u8,
        /// Frame synchronization active level length. These bits are set and cleared by software. They specify the length in number of bit clock (SCK) + 1 (FSALL[6:0] + 1) of the active level of the FS signal in the audio frame These bits are meaningless and are not used in AC97 or SPDIF audio block configuration. They must be configured when the audio block is disabled.
        FSALL: u7,
        reserved16: u1 = 0,
        /// Frame synchronization definition. This bit is set and cleared by software. When the bit is set, the number of slots defined in the SAI_xSLOTR register has to be even. It means that half of this number of slots will be dedicated to the left channel and the other slots for the right channel (e.g: this bit has to be set for I2S or MSB/LSB-justified protocols...). This bit is meaningless and is not used in AC97 or SPDIF audio block configuration. It must be configured when the audio block is disabled.
        FSDEF: u1,
        /// Frame synchronization polarity. This bit is set and cleared by software. It is used to configure the level of the start of frame on the FS signal. It is meaningless and is not used in AC97 or SPDIF audio block configuration. This bit must be configured when the audio block is disabled.
        FSPOL: FSPOL,
        /// Frame synchronization offset. This bit is set and cleared by software. It is meaningless and is not used in AC97 or SPDIF audio block configuration. This bit must be configured when the audio block is disabled.
        FSOFF: FSOFF,
        padding: u13 = 0,
    }),
    /// This register has no meaning in AC97 and SPDIF audio protocol
    /// offset: 0x0c
    SLOTR: mmio.Mmio(packed struct(u32) {
        /// First bit offset These bits are set and cleared by software. The value set in this bitfield defines the position of the first data transfer bit in the slot. It represents an offset value. In transmission mode, the bits outside the data field are forced to 0. In reception mode, the extra received bits are discarded. These bits must be set when the audio block is disabled. They are ignored in AC97 or SPDIF mode.
        FBOFF: u5,
        reserved6: u1 = 0,
        /// Slot size This bits is set and cleared by software. The slot size must be higher or equal to the data size. If this condition is not respected, the behavior of the SAI will be undetermined. Refer to Section: Output data line management on an inactive slot for information on how to drive SD line. These bits must be set when the audio block is disabled. They are ignored in AC97 or SPDIF mode.
        SLOTSZ: SLOTSZ,
        /// Number of slots in an audio frame. These bits are set and cleared by software. The value set in this bitfield represents the number of slots + 1 in the audio frame (including the number of inactive slots). The maximum number of slots is 16. The number of slots should be even if FSDEF bit in the SAI_xFRCR register is set. The number of slots must be configured when the audio block is disabled. They are ignored in AC97 or SPDIF mode.
        NBSLOT: u4,
        reserved16: u4 = 0,
        /// Slot enable. These bits are set and cleared by software. Each SLOTEN bit corresponds to a slot position from 0 to 15 (maximum 16 slots). The slot must be enabled when the audio block is disabled. They are ignored in AC97 or SPDIF mode.
        SLOTEN: SLOTEN,
    }),
    /// Interrupt mask register 2
    /// offset: 0x10
    IM: mmio.Mmio(packed struct(u32) {
        /// Overrun/underrun interrupt enable. This bit is set and cleared by software. When this bit is set, an interrupt is generated if the OVRUDR bit in the SAI_xSR register is set.
        OVRUDRIE: u1,
        /// Mute detection interrupt enable. This bit is set and cleared by software. When this bit is set, an interrupt is generated if the MUTEDET bit in the SAI_xSR register is set. This bit has a meaning only if the audio block is configured in receiver mode.
        MUTEDETIE: u1,
        /// Wrong clock configuration interrupt enable. This bit is set and cleared by software. This bit is taken into account only if the audio block is configured as a master (MODE[1] = 0) and NODIV = 0. It generates an interrupt if the WCKCFG flag in the SAI_xSR register is set. Note: This bit is used only in TDM mode and is meaningless in other modes.
        WCKCFGIE: u1,
        /// FIFO request interrupt enable. This bit is set and cleared by software. When this bit is set, an interrupt is generated if the FREQ bit in the SAI_xSR register is set. Since the audio block defaults to operate as a transmitter after reset, the MODE bit must be configured before setting FREQIE to avoid a parasitic interruption in receiver mode,
        FREQIE: u1,
        /// Codec not ready interrupt enable (AC97). This bit is set and cleared by software. When the interrupt is enabled, the audio block detects in the slot 0 (tag0) of the AC97 frame if the Codec connected to this line is ready or not. If it is not ready, the CNRDY flag in the SAI_xSR register is set and an interruption i generated. This bit has a meaning only if the AC97 mode is selected through PRTCFG[1:0] bits and the audio block is operates as a receiver.
        CNRDYIE: u1,
        /// Anticipated frame synchronization detection interrupt enable. This bit is set and cleared by software. When this bit is set, an interrupt will be generated if the AFSDET bit in the SAI_xSR register is set. This bit is meaningless in AC97, SPDIF mode or when the audio block operates as a master.
        AFSDETIE: u1,
        /// Late frame synchronization detection interrupt enable. This bit is set and cleared by software. When this bit is set, an interrupt will be generated if the LFSDET bit is set in the SAI_xSR register. This bit is meaningless in AC97, SPDIF mode or when the audio block operates as a master.
        LFSDETIE: u1,
        padding: u25 = 0,
    }),
    /// Status register
    /// offset: 0x14
    SR: mmio.Mmio(packed struct(u32) {
        /// Overrun / underrun. This bit is read only. The overrun and underrun conditions can occur only when the audio block is configured as a receiver and a transmitter, respectively. It can generate an interrupt if OVRUDRIE bit is set in SAI_xIM register. This flag is cleared when the software sets COVRUDR bit in SAI_xCLRFR register.
        OVRUDR: u1,
        /// Mute detection. This bit is read only. This flag is set if consecutive 0 values are received in each slot of a given audio frame and for a consecutive number of audio frames (set in the MUTECNT bit in the SAI_xCR2 register). It can generate an interrupt if MUTEDETIE bit is set in SAI_xIM register. This flag is cleared when the software sets bit CMUTEDET in the SAI_xCLRFR register.
        MUTEDET: u1,
        /// Wrong clock configuration flag. This bit is read only. This bit is used only when the audio block operates in master mode (MODE[1] = 0) and NODIV = 0. It can generate an interrupt if WCKCFGIE bit is set in SAI_xIM register. This flag is cleared when the software sets CWCKCFG bit in SAI_xCLRFR register.
        WCKCFG: WCKCFG,
        /// FIFO request. This bit is read only. The request depends on the audio block configuration: If the block is configured in transmission mode, the FIFO request is related to a write request operation in the SAI_xDR. If the block configured in reception, the FIFO request related to a read request operation from the SAI_xDR. This flag can generate an interrupt if FREQIE bit is set in SAI_xIM register.
        FREQ: u1,
        /// Codec not ready. This bit is read only. This bit is used only when the AC97 audio protocol is selected in the SAI_xCR1 register and configured in receiver mode. It can generate an interrupt if CNRDYIE bit is set in SAI_xIM register. This flag is cleared when the software sets CCNRDY bit in SAI_xCLRFR register.
        CNRDY: CNRDY,
        /// Anticipated frame synchronization detection. This bit is read only. This flag can be set only if the audio block is configured in slave mode. It is not used in AC97or SPDIF mode. It can generate an interrupt if AFSDETIE bit is set in SAI_xIM register. This flag is cleared when the software sets CAFSDET bit in SAI_xCLRFR register.
        AFSDET: u1,
        /// Late frame synchronization detection. This bit is read only. This flag can be set only if the audio block is configured in slave mode. It is not used in AC97 or SPDIF mode. It can generate an interrupt if LFSDETIE bit is set in the SAI_xIM register. This flag is cleared when the software sets bit CLFSDET in SAI_xCLRFR register
        LFSDET: u1,
        reserved16: u9 = 0,
        /// FIFO level threshold. This bit is read only. The FIFO level threshold flag is managed only by hardware and its setting depends on SAI block configuration (transmitter or receiver mode). If the SAI block is configured as transmitter: If SAI block is configured as receiver:
        FLVL: FLVL,
        padding: u13 = 0,
    }),
    /// Clear flag register
    /// offset: 0x18
    CLRFR: mmio.Mmio(packed struct(u32) {
        /// Clear overrun / underrun. This bit is write only. Programming this bit to 1 clears the OVRUDR flag in the SAI_xSR register. Reading this bit always returns the value 0.
        COVRUDR: u1,
        /// Mute detection flag. This bit is write only. Programming this bit to 1 clears the MUTEDET flag in the SAI_xSR register. Reading this bit always returns the value 0.
        CMUTEDET: u1,
        /// Clear wrong clock configuration flag. This bit is write only. Programming this bit to 1 clears the WCKCFG flag in the SAI_xSR register. This bit is used only when the audio block is set as master (MODE[1] = 0) and NODIV = 0 in the SAI_xCR1 register. Reading this bit always returns the value 0.
        CWCKCFG: u1,
        reserved4: u1 = 0,
        /// Clear Codec not ready flag. This bit is write only. Programming this bit to 1 clears the CNRDY flag in the SAI_xSR register. This bit is used only when the AC97 audio protocol is selected in the SAI_xCR1 register. Reading this bit always returns the value 0.
        CCNRDY: u1,
        /// Clear anticipated frame synchronization detection flag. This bit is write only. Programming this bit to 1 clears the AFSDET flag in the SAI_xSR register. It is not used in AC97or SPDIF mode. Reading this bit always returns the value 0.
        CAFSDET: u1,
        /// Clear late frame synchronization detection flag. This bit is write only. Programming this bit to 1 clears the LFSDET flag in the SAI_xSR register. This bit is not used in AC97or SPDIF mode Reading this bit always returns the value 0.
        CLFSDET: u1,
        padding: u25 = 0,
    }),
    /// Data register
    /// offset: 0x1c
    DR: mmio.Mmio(packed struct(u32) {
        /// Data A write to this register loads the FIFO provided the FIFO is not full. A read from this register empties the FIFO if the FIFO is not empty.
        DATA: u32,
    }),
};

/// Serial audio interface
pub const SAI = extern struct {
    /// Global configuration register
    /// offset: 0x00
    GCR: mmio.Mmio(packed struct(u32) {
        /// Synchronization inputs
        SYNCIN: u2,
        reserved4: u2 = 0,
        /// Synchronization outputs These bits are set and cleared by software.
        SYNCOUT: u2,
        padding: u26 = 0,
    }),
    /// Cluster CH%s, containing ?CR1, ?CR2, ?FRCR, ?SLOTR, ?IM, ?SR, ?CLRFR, ?DR
    /// offset: 0x04
    CH: u32,
    /// offset: 0x08
    reserved8: [60]u8,
    /// PDM control register
    /// offset: 0x44
    PDMCR: mmio.Mmio(packed struct(u32) {
        /// PDM enable
        PDMEN: u1,
        reserved4: u3 = 0,
        /// Number of microphones
        MICNBR: u2,
        reserved8: u2 = 0,
        /// (1/2 of CKEN) Clock enable of bitstream clock number 1
        @"CKEN[0]": u1,
        /// (2/2 of CKEN) Clock enable of bitstream clock number 1
        @"CKEN[1]": u1,
        padding: u22 = 0,
    }),
    /// PDM delay register
    /// offset: 0x48
    PDMDLY: mmio.Mmio(packed struct(u32) {
        /// (1/4 of DLYML) Delay line adjust for first microphone of pair 1
        @"DLYML[0]": u3,
        reserved4: u1 = 0,
        /// (1/4 of DLYMR) Delay line adjust for second microphone of pair 1
        @"DLYMR[0]": u3,
        reserved8: u1 = 0,
        /// (2/4 of DLYML) Delay line adjust for first microphone of pair 1
        @"DLYML[1]": u3,
        reserved12: u1 = 0,
        /// (2/4 of DLYMR) Delay line adjust for second microphone of pair 1
        @"DLYMR[1]": u3,
        reserved16: u1 = 0,
        /// (3/4 of DLYML) Delay line adjust for first microphone of pair 1
        @"DLYML[2]": u3,
        reserved20: u1 = 0,
        /// (3/4 of DLYMR) Delay line adjust for second microphone of pair 1
        @"DLYMR[2]": u3,
        reserved24: u1 = 0,
        /// (4/4 of DLYML) Delay line adjust for first microphone of pair 1
        @"DLYML[3]": u3,
        reserved28: u1 = 0,
        /// (4/4 of DLYMR) Delay line adjust for second microphone of pair 1
        @"DLYMR[3]": u3,
        padding: u1 = 0,
    }),
};
