const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

/// DFLT trigger mode. This bitfield is set and cleared by software. It is used to select the trigger mode of the DFLT0.
pub const ACQMOD = enum(u3) {
    /// Asynchronous continuous acquisition mode.
    AsynchronousContinuous = 0x0,
    /// Asynchronous single-shot acquisition mode
    AsynchronousSingleShot = 0x1,
    /// Synchronous continuous acquisition mode.
    SyncronousContinuous = 0x2,
    /// Synchronous single-shot acquisition mode.
    SyncronousSingleShot = 0x3,
    /// Window continuous acquisition mode.
    WindowContinuous = 0x4,
    _,
};

/// Bitstream selection. This bitfield is set and cleared by software. It is used to select the bitstream to be used by the DFLT0.
pub const BSSEL = enum(u5) {
    /// bsx_r provided to DFLTy (and SCDy).
    BS0_R = 0x0,
    /// bsx_f provided to DFLTy (and SCDy).
    BS0_F = 0x1,
    /// bsx_r provided to DFLTy (and SCDy).
    BS1_R = 0x2,
    /// bsx_f provided to DFLTy (and SCDy).
    BS1_F = 0x3,
    /// bsx_r provided to DFLTy (and SCDy).
    BS2_R = 0x4,
    /// bsx_f provided to DFLTy (and SCDy).
    BS2_F = 0x5,
    /// bsx_r provided to DFLTy (and SCDy).
    BS3_R = 0x6,
    /// bsx_f provided to DFLTy (and SCDy).
    BS3_F = 0x7,
    /// bsx_r provided to DFLTy (and SCDy).
    BS4_R = 0x8,
    /// bsx_f provided to DFLTy (and SCDy).
    BS4_F = 0x9,
    /// bsx_r provided to DFLTy (and SCDy).
    BS5_R = 0xa,
    /// bsx_f provided to DFLTy (and SCDy).
    BS5_F = 0xb,
    /// bsx_r provided to DFLTy (and SCDy).
    BS6_R = 0xc,
    /// bsx_f provided to DFLTy (and SCDy).
    BS6_F = 0xd,
    /// bsx_r provided to DFLTy (and SCDy).
    BS7_R = 0xe,
    /// bsx_f provided to DFLTy (and SCDy).
    BS7_F = 0xf,
    /// bsx_r provided to DFLTy (and SCDy).
    BS8_R = 0x10,
    /// bsx_f provided to DFLTy (and SCDy).
    BS8_F = 0x11,
    /// bsx_r provided to DFLTy (and SCDy).
    BS9_R = 0x12,
    /// bsx_f provided to DFLTy (and SCDy).
    BS9_F = 0x13,
    /// bsx_r provided to DFLTy (and SCDy).
    BS10_R = 0x14,
    /// bsx_f provided to DFLTy (and SCDy).
    BS10_F = 0x15,
    /// bsx_r provided to DFLTy (and SCDy).
    BS11_R = 0x16,
    /// bsx_f provided to DFLTy (and SCDy).
    BS11_F = 0x17,
    /// bsx_r provided to DFLTy (and SCDy).
    BS12_R = 0x18,
    /// bsx_f provided to DFLTy (and SCDy).
    BS12_F = 0x19,
    /// bsx_r provided to DFLTy (and SCDy).
    BS13_R = 0x1a,
    /// bsx_f provided to DFLTy (and SCDy).
    BS13_F = 0x1b,
    /// bsx_r provided to DFLTy (and SCDy).
    BS14_R = 0x1c,
    /// bsx_f provided to DFLTy (and SCDy).
    BS14_F = 0x1d,
    /// bsx_r provided to DFLTy (and SCDy).
    BS15_R = 0x1e,
    /// bsx_f provided to DFLTy (and SCDy).
    BS15_F = 0x1f,
};

/// CCK1 direction. This bit is set and reset by software. It is used to control the direction of the ADF_CCK1 pin.
pub const CCKDIR = enum(u1) {
    /// CCK is an input.
    Input = 0x0,
    /// CCK is an output.
    Output = 0x1,
};

/// Divider to control the CCK clock. This bit is set and reset by software. It is used to control the frequency of the bitstream clock on the CCK pin.
pub const CCKDIV = enum(u4) {
    /// The ADF_CCK clock is adf_proc_ck.
    DIV1 = 0x0,
    /// The ADF_CCK clock is adf_proc_ck divided by 2.
    DIV2 = 0x1,
    /// The ADF_CCK clock is adf_proc_ck divided by 3.
    DIV3 = 0x2,
    /// The ADF_CCK clock is adf_proc_ck divided by 4.
    DIV4 = 0x3,
    /// The ADF_CCK clock is adf_proc_ck divided by 5.
    DIV5 = 0x4,
    /// The ADF_CCK clock is adf_proc_ck divided by 6.
    DIV6 = 0x5,
    /// The ADF_CCK clock is adf_proc_ck divided by 7.
    DIV7 = 0x6,
    /// The ADF_CCK clock is adf_proc_ck divided by 8.
    DIV8 = 0x7,
    /// The ADF_CCK clock is adf_proc_ck divided by 9.
    DIV9 = 0x8,
    /// The ADF_CCK clock is adf_proc_ck divided by 10.
    DIV10 = 0x9,
    /// The ADF_CCK clock is adf_proc_ck divided by 11.
    DIV11 = 0xa,
    /// The ADF_CCK clock is adf_proc_ck divided by 12.
    DIV12 = 0xb,
    /// The ADF_CCK clock is adf_proc_ck divided by 13.
    DIV13 = 0xc,
    /// The ADF_CCK clock is adf_proc_ck divided by 14.
    DIV14 = 0xd,
    /// The ADF_CCK clock is adf_proc_ck divided by 15.
    DIV15 = 0xe,
    /// The ADF_CCK clock is adf_proc_ck divided by 16.
    DIV16 = 0xf,
};

/// CCK clock enable. This bit is set and reset by software. It is used to control the generation of the bitstream clock on the CCK pin.
pub const CCKEN = enum(u1) {
    /// Bitstream clock not generated.
    NotGenerated = 0x0,
    /// Bitstream clock generated on the CCK pin.
    Generated = 0x1,
};

/// Select the CIC order. This bitfield is set and cleared by software. It is used to select the MCIC order.
pub const CICMOD = enum(u3) {
    /// MCIC configured in single Sinc4 filter.
    SINC4 = 0x4,
    /// MCIC configured in single Sinc5 filter.
    SINC5 = 0x5,
    _,
};

/// Clock generator mode. This bit is set and reset by software. It is used to define the way the clock generator is enabled. This bit must not be changed if the filter is enabled (DFTEN = 1).
pub const CKGMOD = enum(u1) {
    /// The kernel clock is provided to the dividers as soon as CKGDEN is set to 1.
    Immediate = 0x0,
    /// The kernel clock is provided to the dividers when CKGDEN is set to 1 and the trigger condition met.
    Trigger = 0x1,
};

/// Data capture mode. This bitfield is set and cleared by software. It is used to define in which conditions, the samples provided by DLFT0 are stored into the memory.
pub const DATCAP = enum(u2) {
    /// Samples from DFLT0 not transfered into the memory.
    Disabled = 0x0,
    /// Samples from DFLT0 transfered into the memory when SAD is in DETECT state.
    OnDetected = 0x1,
    /// Samples from DFLT0 transfered into memory when SAD and DFLT0 are enabled.
    Enabled = 0x2,
    _,
};

/// Source data for the digital filter.
pub const DATSRC = enum(u2) {
    /// Stream coming from the BSMX selected
    BSMX = 0x0,
    /// Stream coming from the ADCITF1 selected
    ADCITF1 = 0x2,
    /// Stream coming from the ADCITF2 selected
    ADCITF2 = 0x3,
    _,
};

/// Sound trigger event configuration. This bit is set and cleared by software. It is used to define if the sddet_evt event is generated only when the SAD enters to MONITOR state or when the SAD enters or exits the DETECT state.
pub const DETCFG = enum(u1) {
    /// sddet_evt generated when SAD enters the MONITOR state.
    Monitor = 0x0,
    /// sddet_evt generated when SAD enters or exits the DETECT state.
    Detect = 0x1,
};

/// Frame size. This bitfield is set and cleared by software. it is used to define the size of one frame and also to define how many samples are taken into account to compute the short-term signal level.
pub const FRSIZE = enum(u3) {
    /// 8 sample.
    Samples8 = 0x0,
    /// 16 samples.
    Samples16 = 0x1,
    /// 32 samples.
    Samples32 = 0x2,
    /// 64 samples.
    Samples64 = 0x3,
    /// 128 samples.
    Samples128 = 0x4,
    /// 256 samples.
    Samples256 = 0x5,
    /// 512 samples.
    Samples512 = 0x6,
    _,
};

/// Hangover time window. This bitfield is set and cleared by software. It is used to select the hangover time window.
pub const HGOVR = enum(u3) {
    /// SAD back to MONITOR state if sound is below threshold for 4 frames.
    @"Frames 4" = 0x0,
    /// SAD back to MONITOR state if sound is below threshold for 4 frames.
    @"Frames 8" = 0x1,
    /// SAD back to MONITOR state if sound is below threshold for 4 frames.
    @"Frames 16" = 0x2,
    /// SAD back to MONITOR state if sound is below threshold for 4 frames.
    @"Frames 32" = 0x3,
    /// SAD back to MONITOR state if sound is below threshold for 4 frames.
    @"Frames 64" = 0x4,
    /// SAD back to MONITOR state if sound is below threshold for 4 frames.
    @"Frames 128" = 0x5,
    /// SAD back to MONITOR state if sound is below threshold for 4 frames.
    @"Frames 256" = 0x6,
    /// SAD back to MONITOR state if sound is below threshold for 4 frames.
    @"Frames 512" = 0x7,
};

/// High-pass filter cut-off frequency. This bitfield is set and cleared by software. it is used to select the cut-off frequency of the high-pass filter. F PCM represents the sampling frequency at HPF input.
pub const HPFC = enum(u2) {
    /// Cut-off frequency = 0.000625 x FPCM.
    Low = 0x0,
    /// Cut-off frequency = 0.00125 x FPCM.
    Medium = 0x1,
    /// Cut-off frequency = 0.00250 x FPCM
    High = 0x2,
    /// Cut-off frequency = 0.00950 x FPCM
    Maximum = 0x3,
};

/// LFRNB. This bitfield is set and cleared by software. It is used to define the number of learning frames to perform the first estimate of the noise level.
pub const LFRNB = enum(u3) {
    /// 2 samples.
    @"Frames 2" = 0x0,
    /// 4 samples.
    @"Frames 4" = 0x1,
    /// 8 samples.
    @"Frames 8" = 0x2,
    /// 16 samples.
    @"Frames 16" = 0x3,
    /// 32 samples.
    @"Frames 32" = 0x4,
    _,
};

/// Reshaper filter decimation ratio. This bitfield is set and cleared by software. It is used to select the decimation ratio of the reshaper filter.
pub const RSFLTD = enum(u1) {
    /// Decimation ratio is 4 (default value).
    Decimation4 = 0x0,
    /// Decimation ratio is 1.
    Decimation1 = 0x1,
};

/// RXFIFO threshold selection. This bitfield is set and cleared by software. It is used to select the RXFIFO threshold.
pub const RXFIFO = enum(u1) {
    /// RXFIFO threshold event generated when the RXFIFO is not empty
    NotEmpty = 0x0,
    /// RXFIFO threshold event generated when the RXFIFO is half-full
    HalfFull = 0x1,
};

/// SAD working mode. This bitfield is set and cleared by software. It is used to define the way the SAD works
pub const SADMOD = enum(u2) {
    /// Threshold value computed according to the estimated ambient noise. The SAD triggers when the sound level (SDLVL) is bigger than the defined threshold. In this mode, the SAD works like a voice activity detector.
    ThresholdEstimatedAmbientNoise = 0x0,
    /// Threshold value equal to ANMIN[12:0], multiplied by the gain selected by SNTHR[3:0] The SAD triggers when the sound level (SDLVL) is bigger than the defined threshold. In this mode, the SAD works like a sound detector.
    ThresholdMinimumNoiselevel = 0x1,
    /// Threshold value given by 4 x ANMIN[12:0]. The SAD triggers when the estimated ambient noise (ANLVL), multiplied by the gain selected by SNTHR[3:0] is bigger than the defined threshold. In this mode, the SAD is working like an ambient noise estimator. Hysteresis function cannot be used in this mode.
    ThresholdMinimumNoiselevelx4 = 0x2,
    _,
};

/// SAD state. This bitfield is set and cleared by hardware. It indicates the SAD state and is meaningful only when SADEN = 1.
pub const SADST = enum(u2) {
    /// SAD in LEARN state.
    Learn = 0x0,
    /// SAD in MONITOR state.
    Monitor = 0x1,
    /// SAD in DETECT state.
    Detect = 0x2,
    _,
};

/// Serial clock source. This bitfield is set and cleared by software. It is used to select the clock source of the serial interface.
pub const SCKSRC = enum(u2) {
    /// Serial clock source is CCK0.
    CCK0 = 0x0,
    /// Serial clock source is CCK1.
    CCK1 = 0x1,
    /// Serial clock source is CCI0.
    CKI0 = 0x2,
    /// Serial clock source is CCI1.
    CKI1 = 0x3,
};

/// Serial interface mode. This bitfield is set and cleared by software. It is used to select the serial interface mode.
pub const SITFMOD = enum(u2) {
    /// LF_MASTER SPI mode.
    MasterSPI = 0x0,
    /// Normal SPI mode.
    NormalSPI = 0x1,
    /// Manchester mode rising edge = logic 0, falling edge = logic 1.
    ManchesterFalling = 0x2,
    /// Manchester mode rising edge = logic 1, falling edge = logic 0.
    ManchesterRising = 0x3,
};

/// SNTHR. This bitfield is set and cleared by software. It is used to select the gain to be applied at CIC output. If the application attempts to write a new gain value while the previous one is not yet applied, this new gain value is ignored. Reading back this bitfield informs the application on the current gain value.
pub const SNTHR = enum(u4) {
    /// Threshold is 3.5 dB higher than ANLVL
    @"NOISE PLUS 3_5" = 0x0,
    /// Threshold is 6.0 dB higher than ANLVL
    @"NOISE PLUS 6_0" = 0x1,
    /// Threshold is 9.5 dB higher than ANLVL
    @"NOISE PLUS 9_5" = 0x2,
    /// Threshold is 12 dB higher than ANLVL
    @"NOISE PLUS 12" = 0x3,
    /// Threshold is 15.6 dB higher than ANLVL
    @"NOISE PLUS 15_6" = 0x4,
    /// Threshold is 18 dB higher than ANLVL
    @"NOISE PLUS 18" = 0x5,
    /// Threshold is 21.6 dB higher than ANLVL
    @"NOISE PLUS 21_6" = 0x6,
    /// Threshold is 24.1 dB higher than ANLVL
    @"NOISE PLUS 24_1" = 0x7,
    /// Threshold is 27.6 dB higher than ANLVL
    @"NOISE PLUS 27_6" = 0x8,
    /// Threshold is 30.1 dB higher than ANLVL
    @"NOISE PLUS 30_1" = 0x9,
    _,
};

/// CKGEN trigger sensitivity selection. This bit is set and cleared by software. It is used to select the trigger sensitivity of the trigger signals. This bit is not significant if the CKGMOD = 0.
pub const TRGSENS = enum(u1) {
    /// A rising edge event triggers the activation of CKGEN dividers.
    RisingEdge = 0x0,
    /// A falling edge even triggers the activation of CKGEN dividers.
    FallingEdge = 0x1,
};

/// Digital filter trigger signal selection.
pub const TRGSRC = enum(u4) {
    /// TRGO Selected.
    TRGO = 0x0,
    /// adf_trg1 selected.
    TRG1 = 0x2,
    _,
};

/// ADF.
pub const ADF = extern struct {
    /// ADF Global Control Register.
    /// offset: 0x00
    GCR: mmio.Mmio(packed struct(u32) {
        /// Trigger output control Set by software and reset by.
        TRGO: u1,
        padding: u31 = 0,
    }),
    /// ADF clock generator control register.
    /// offset: 0x04
    CKGCR: mmio.Mmio(packed struct(u32) {
        /// Clock generator dividers enable.
        CKGDEN: u1,
        /// CCK0 clock enable. This bit is set and reset by software. It is used to control the generation of the bitstream clock on the CCK pin.
        CCK0EN: CCKEN,
        /// CCK1 clock enable. This bit is set and reset by software. It is used to control the generation of the bitstream clock on the CCK pin.
        CCK1EN: CCKEN,
        reserved4: u1 = 0,
        /// Clock generator mode. This bit is set and reset by software. It is used to define the way the clock generator is enabled. This bit must not be changed if the filter is enabled (DFTEN = 1).
        CKGMOD: CKGMOD,
        /// CCK0 direction. This bit is set and reset by software. It is used to control the direction of the ADF_CCK0 pin.
        CCK0DIR: CCKDIR,
        /// CCK1 direction. This bit is set and reset by software. It is used to control the direction of the ADF_CCK1 pin.
        CCK1DIR: CCKDIR,
        reserved8: u1 = 0,
        /// CKGEN trigger sensitivity selection. This bit is set and cleared by software. It is used to select the trigger sensitivity of the trigger signals. This bit is not significant if the CKGMOD = 0.
        TRGSENS: TRGSENS,
        reserved12: u3 = 0,
        /// Digital filter trigger signal selection. This bit is set and cleared by software. It is used to select the trigger signal for the digital filter. This bit is not significant if the CKGMOD = 0.
        TRGSRC: TRGSRC,
        /// Divider to control the CCK clock.
        CCKDIV: CCKDIV,
        reserved24: u4 = 0,
        /// Divider to control the serial interface clock.
        PROCDIV: u7,
        /// Clock generator active flag.
        CKGACTIVE: u1,
    }),
    /// offset: 0x08
    reserved8: [120]u8,
    /// ADF serial interface control register 0.
    /// offset: 0x80
    SITFCR: mmio.Mmio(packed struct(u32) {
        SITFEN: u1,
        SCKSRC: SCKSRC,
        reserved4: u1 = 0,
        SITFMOD: SITFMOD,
        reserved8: u2 = 0,
        /// Manchester symbol threshold/SPI threshold. This bitfield is set and cleared by software. It is used for Manchester mode to define the expected symbol threshold levels (seer to Manchester mode for details on computation). In addition this bitfield is used to define the timeout value for the clock absence detection in Normal SPI mode. STH[4:0] values lower than four are invalid.
        STH: u5,
        reserved31: u18 = 0,
        /// SITFACTIVE.
        SITFACTIVE: u1,
    }),
    /// ADF bitstream matrix control register 0.
    /// offset: 0x84
    BSMXCR: mmio.Mmio(packed struct(u32) {
        /// Bitstream selection.
        BSSEL: BSSEL,
        reserved31: u26 = 0,
        /// BSMX active flag. This bit is set and cleared by hardware. It is used by the application to check if the BSMX is effectively enabled (active) or not. BSSEL[4:0] can only be updated when BSMXACTIVE is set to 0. This BSMXACTIVE flag cannot go to 0 if DFLT0 is enabled.
        BSMXACTIVE: u1,
    }),
    /// ADF digital filter control register 0.
    /// offset: 0x88
    DFLTCR: mmio.Mmio(packed struct(u32) {
        /// DFLT enable. This bit is set and reset by software. It is used to enable the digital filter.
        DFLTEN: u1,
        /// DMA requests enable. This bit is set and reset by software. It is used to control the generation of DMA request to transfer the processed samples into the memory.
        DMAEN: u1,
        /// RXFIFO threshold selection.
        FTH: RXFIFO,
        reserved4: u1 = 0,
        /// DFLT trigger mode.
        ACQMOD: ACQMOD,
        reserved12: u5 = 0,
        /// DFLT trigger signal selection.
        TRGSRC: u4,
        reserved20: u4 = 0,
        /// Number of samples to be discarded.
        NBDIS: u8,
        reserved30: u2 = 0,
        /// DFLT run status flag.
        DFLTRUN: u1,
        /// DFLT active flag.
        DFLTACTIVE: u1,
    }),
    /// ADF digital filer configuration register 0.
    /// offset: 0x8c
    DFLTCICR: mmio.Mmio(packed struct(u32) {
        /// Source data for the digital filter.
        DATSRC: DATSRC,
        reserved4: u2 = 0,
        /// Select the CIC order.
        CICMOD: CICMOD,
        reserved8: u1 = 0,
        /// CIC decimation ratio selection. This bitfield is set and cleared by software.It is used to select the CIC decimation ratio. A decimation ratio smaller than two is not allowed. The decimation ratio is given by (CICDEC+1).
        MCICD: u9,
        reserved20: u3 = 0,
        /// Scaling factor selection. This bitfield is set and cleared by software. It is used to select the gain to be applied at CIC output. If the application attempts to write a new gain value while the previous one is not yet applied, this new gain value is ignored. Reading back this bitfield informs the application on the current gain value.
        SCALE: u6,
        padding: u6 = 0,
    }),
    /// ADF reshape filter configuration register 0.
    /// offset: 0x90
    DFLTRSFR: mmio.Mmio(packed struct(u32) {
        /// Reshaper filter bypass.
        RSFLTBYP: u1,
        reserved4: u3 = 0,
        /// Reshaper filter decimation ratio.
        RSFLTD: RSFLTD,
        reserved7: u2 = 0,
        /// High-pass filter bypass. This bit is set and cleared by software. It is used to bypass the high-pass filter.
        HPFBYP: u1,
        /// High-pass filter cut-off frequency. This bitfield is set and cleared by software. it is used to select the cut-off frequency of the high-pass filter. F PCM represents the sampling frequency at HPF input.
        HPFC: HPFC,
        padding: u22 = 0,
    }),
    /// offset: 0x94
    reserved148: [16]u8,
    /// ADF delay control register 0.
    /// offset: 0xa4
    DLYCR: mmio.Mmio(packed struct(u32) {
        /// Delay to apply to a bitstream. This bitfield is set and cleared by software. It defines the number of input samples that are skipped. Skipping is applied immediately after writing to this bitfield, if SKPBF = 0 and DFLTEN = 1. If SKPBF = 1, the value written into the register is ignored by the delay state machine.
        SKPDLY: u7,
        reserved31: u24 = 0,
        /// Skip busy flag.
        SKPBF: u1,
    }),
    /// offset: 0xa8
    reserved168: [4]u8,
    /// ADF DFLT0 interrupt enable register.
    /// offset: 0xac
    DFLTIER: mmio.Mmio(packed struct(u32) {
        /// RXFIFO threshold interrupt enable.
        FTHIE: u1,
        /// Data overflow interrupt enable.
        DOVRIE: u1,
        reserved9: u7 = 0,
        /// Saturation detection interrupt enable.
        SATIE: u1,
        /// Clock absence detection interrupt enable.
        CKABIE: u1,
        /// Reshape filter overrun interrupt enable.
        RFOVRIE: u1,
        /// Sound activity detection interrupt enable.
        SDDETIE: u1,
        /// SAD sound-level value ready enable.
        SDLVLIE: u1,
        padding: u18 = 0,
    }),
    /// ADF DFLT0 interrupt status register 0.
    /// offset: 0xb0
    DFLTISR: mmio.Mmio(packed struct(u32) {
        /// RXFIFO threshold flag.
        FTHF: u1,
        /// Data overflow flag.
        DOVRF: u1,
        reserved3: u1 = 0,
        /// RXFIFO not empty flag.
        RXNEF: u1,
        reserved9: u5 = 0,
        /// Saturation detection flag.
        SATF: u1,
        /// Clock absence detection flag.
        CKABF: u1,
        /// Reshape filter overrun detection flag.
        RFOVRF: u1,
        /// Sound activity detection flag.
        SDDETF: u1,
        /// Sound level value ready flag.
        SDLVLF: u1,
        padding: u18 = 0,
    }),
    /// offset: 0xb4
    reserved180: [4]u8,
    /// ADF SAD control register.
    /// offset: 0xb8
    SADCR: mmio.Mmio(packed struct(u32) {
        /// Sound activity detector enable.
        SADEN: u1,
        /// Data capture mode.
        DATCAP: DATCAP,
        /// Sound trigger event configuration.
        DETCFG: DETCFG,
        /// SAD state.
        SADST: SADST,
        reserved7: u1 = 0,
        /// Hysteresis enable.
        HYSTEN: u1,
        /// Frame size.
        FRSIZE: FRSIZE,
        reserved12: u1 = 0,
        /// Sound activity detector working mode.
        SADMOD: SADMOD,
        reserved31: u17 = 0,
        /// SAD Active flag.
        SADACTIVE: u1,
    }),
    /// ADF SAD configuration register.
    /// offset: 0xbc
    SADCFGR: mmio.Mmio(packed struct(u32) {
        /// SNTHR.
        SNTHR: SNTHR,
        /// ANSLP.
        ANSLP: u3,
        reserved8: u1 = 0,
        /// LFRNB.
        LFRNB: LFRNB,
        reserved12: u1 = 0,
        /// Hangover time window.
        HGOVR: HGOVR,
        reserved16: u1 = 0,
        /// ANMIN.
        ANMIN: u13,
        padding: u3 = 0,
    }),
    /// ADF SAD sound level register.
    /// offset: 0xc0
    SADSDLVR: mmio.Mmio(packed struct(u32) {
        /// Short term sound level. This bitfield is set by hardware. It contains the latest sound level computed by the SAD. To refresh this value, SDLVLF must be cleared.
        SDLVL: u15,
        padding: u17 = 0,
    }),
    /// ADF SAD ambient noise level register.
    /// offset: 0xc4
    SADANLVR: mmio.Mmio(packed struct(u32) {
        /// ANLVL.
        ANLVL: u15,
        padding: u17 = 0,
    }),
    /// offset: 0xc8
    reserved200: [40]u8,
    /// ADF digital filter data register 0.
    /// offset: 0xf0
    DFLTDR: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// DR. Data processed by DFT
        DR: u24,
    }),
};
