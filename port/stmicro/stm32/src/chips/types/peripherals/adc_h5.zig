const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const ADCALDIF = enum(u1) {
    /// Calibration for single-ended mode
    SingleEnded = 0x0,
    /// Calibration for differential mode
    Differential = 0x1,
};

pub const ALIGN = enum(u1) {
    /// Right alignment
    Right = 0x0,
    /// Left alignment
    Left = 0x1,
};

pub const AWD1SGL = enum(u1) {
    /// Analog watchdog 1 enabled on all channels
    All = 0x0,
    /// Analog watchdog 1 enabled on single channel selected in AWD1CH
    Single = 0x1,
};

pub const DMACFG = enum(u1) {
    /// DMA One Shot mode selected
    OneShot = 0x0,
    /// DMA Circular mode selected
    Circular = 0x1,
};

pub const EXTEN = enum(u2) {
    /// Hardware trigger detection disabled (conversions can be launched by software)
    Disabled = 0x0,
    /// Hardware trigger detection on the rising edge
    RisingEdge = 0x1,
    /// Hardware trigger detection on the falling edge
    FallingEdge = 0x2,
    /// Hardware trigger detection on both the rising and falling edge
    BothEdges = 0x3,
};

pub const JQM = enum(u1) {
    /// JSQR Mode 0: Queue maintains the last written configuration into JSQR
    Mode0 = 0x0,
    /// JSQR Mode 1: An empty queue disables software and hardware triggers of the injected sequence
    Mode1 = 0x1,
};

pub const OFFSETPOS = enum(u1) {
    /// Negative offset
    Negative = 0x0,
    /// Positive offset
    Positive = 0x1,
};

pub const OVRMOD = enum(u1) {
    /// Preserve DR register when an overrun is detected
    Preserve = 0x0,
    /// Overwrite DR register when an overrun is detected
    Overwrite = 0x1,
};

pub const OVSR = enum(u3) {
    x2 = 0x0,
    x4 = 0x1,
    x8 = 0x2,
    x16 = 0x3,
    x32 = 0x4,
    x64 = 0x5,
    x128 = 0x6,
    x256 = 0x7,
};

pub const RES = enum(u2) {
    /// 12-bit resolution
    Bits12 = 0x0,
    /// 10-bit resolution
    Bits10 = 0x1,
    /// 8-bit resolution
    Bits8 = 0x2,
    /// 6-bit resolution
    Bits6 = 0x3,
};

pub const ROVSM = enum(u1) {
    /// Oversampling is temporary stopped and continued after injection sequence
    Continued = 0x0,
    /// Oversampling is aborted and resumed from start after injection sequence
    Resumed = 0x1,
};

pub const SAMPLE_TIME = enum(u3) {
    /// 2.5 ADC clock cycles
    Cycles2_5 = 0x0,
    /// 6.5 ADC clock cycles
    Cycles6_5 = 0x1,
    /// 12.5 ADC clock cycles
    Cycles12_5 = 0x2,
    /// 24.5 ADC clock cycles
    Cycles24_5 = 0x3,
    /// 47.5 ADC clock cycles
    Cycles47_5 = 0x4,
    /// 92.5 ADC clock cycles
    Cycles92_5 = 0x5,
    /// 247.5 ADC clock cycles
    Cycles247_5 = 0x6,
    /// 640.5 ADC clock cycles
    Cycles640_5 = 0x7,
};

pub const SMPPLUS = enum(u1) {
    /// The sampling time remains set to 2.5 ADC clock cycles remains
    Cycles2_5 = 0x0,
    /// 2.5 ADC clock cycle sampling time becomes 3.5 ADC clock cycles for the ADC_SMPR1 and ADC_SMPR2 registers.
    Cycles3_5 = 0x1,
};

pub const SWTRIG = enum(u1) {
    /// Software trigger starts the conversion for sampling time control trigger mode
    Conversion = 0x0,
    /// Software trigger starts the sampling for sampling time control trigger mode
    Sampling = 0x1,
};

pub const TROVS = enum(u1) {
    /// All oversampled conversions for a channel are run following a trigger
    Automatic = 0x0,
    /// Each oversampled conversion for a channel needs a new trigger
    Triggered = 0x1,
};

/// Analog to digital converter
pub const ADC = extern struct {
    /// interrupt and status register
    /// offset: 0x00
    ISR: mmio.Mmio(packed struct(u32) {
        /// ready This bit is set by hardware after the ADC has been enabled (ADEN = 1) and when the ADC reaches a state where it is ready to accept conversion requests. It is cleared by software writing 1 to it
        ADRDY: u1,
        /// End of sampling flag This bit is set by hardware during the conversion of any channel (only for regular channels), at the end of the sampling phase
        EOSMP: u1,
        /// End of conversion flag This bit is set by hardware at the end of each regular conversion of a channel when a new data is available in the ADC_DR register. It is cleared by software writing 1 to it or by reading the ADC_DR register
        EOC: u1,
        /// End of regular sequence flag This bit is set by hardware at the end of the conversions of a regular sequence of channels. It is cleared by software writing 1 to it
        EOS: u1,
        /// overrun This bit is set by hardware when an overrun occurs on a regular channel, meaning that a new conversion has completed while the EOC flag was already set. It is cleared by software writing 1 to it
        OVR: u1,
        /// Injected channel end of conversion flag This bit is set by hardware at the end of each injected conversion of a channel when a new data is available in the corresponding ADC_JDRy register. It is cleared by software writing 1 to it or by reading the corresponding ADC_JDRy register
        JEOC: u1,
        /// Injected channel end of sequence flag This bit is set by hardware at the end of the conversions of all injected channels in the group. It is cleared by software writing 1 to it
        JEOS: u1,
        /// (1/3 of AWD) Analog watchdog 1-3 flags. Set by hardware when the converted voltage crosses the values programmed in the corresponding fields LT and HT fields of the relevant TR register. It is cleared by software.
        @"AWD[0]": u1,
        /// (2/3 of AWD) Analog watchdog 1-3 flags. Set by hardware when the converted voltage crosses the values programmed in the corresponding fields LT and HT fields of the relevant TR register. It is cleared by software.
        @"AWD[1]": u1,
        /// (3/3 of AWD) Analog watchdog 1-3 flags. Set by hardware when the converted voltage crosses the values programmed in the corresponding fields LT and HT fields of the relevant TR register. It is cleared by software.
        @"AWD[2]": u1,
        /// Injected context queue overflow This bit is set by hardware when an Overflow of the Injected Queue of Context occurs. It is cleared by software writing 1 to it. Refer to for more information
        JQOVF: u1,
        padding: u21 = 0,
    }),
    /// interrupt enable register
    /// offset: 0x04
    IER: mmio.Mmio(packed struct(u32) {
        /// ADC ready interrupt enable This bit is set and cleared by software to enable/disable the ADC Ready interrupt. Note: The software is allowed to write this bit only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        ADRDYIE: u1,
        /// End of sampling flag interrupt enable for regular conversions This bit is set and cleared by software to enable/disable the end of the sampling phase interrupt for regular conversions. Note: The software is allowed to write this bit only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        EOSMPIE: u1,
        /// End of regular conversion interrupt enable This bit is set and cleared by software to enable/disable the end of a regular conversion interrupt. Note: The software is allowed to write this bit only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        EOCIE: u1,
        /// End of regular sequence of conversions interrupt enable This bit is set and cleared by software to enable/disable the end of regular sequence of conversions interrupt. Note: The software is allowed to write this bit only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        EOSIE: u1,
        /// Overrun interrupt enable This bit is set and cleared by software to enable/disable the Overrun interrupt of a regular conversion. Note: The software is allowed to write this bit only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        OVRIE: u1,
        /// End of injected conversion interrupt enable This bit is set and cleared by software to enable/disable the end of an injected conversion interrupt. Note: The software is allowed to write this bit only when JADSTART = 0 (which ensures that no injected conversion is ongoing).
        JEOCIE: u1,
        /// End of injected sequence of conversions interrupt enable This bit is set and cleared by software to enable/disable the end of injected sequence of conversions interrupt. Note: The software is allowed to write this bit only when JADSTART = 0 (which ensures that no injected conversion is ongoing).
        JEOSIE: u1,
        /// (1/3 of AWDIE) Analog watchdog 1-3 interrupt enable. This bit is set and cleared by software to enable/disable the analog watchdog 1-3 interrupts. Note: The software is allowed to write this bit only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        @"AWDIE[0]": u1,
        /// (2/3 of AWDIE) Analog watchdog 1-3 interrupt enable. This bit is set and cleared by software to enable/disable the analog watchdog 1-3 interrupts. Note: The software is allowed to write this bit only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        @"AWDIE[1]": u1,
        /// (3/3 of AWDIE) Analog watchdog 1-3 interrupt enable. This bit is set and cleared by software to enable/disable the analog watchdog 1-3 interrupts. Note: The software is allowed to write this bit only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        @"AWDIE[2]": u1,
        /// Injected context queue overflow interrupt enable This bit is set and cleared by software to enable/disable the Injected Context Queue Overflow interrupt. Note: The software is allowed to write this bit only when JADSTART = 0 (which ensures that no injected conversion is ongoing).
        JQOVFIE: u1,
        padding: u21 = 0,
    }),
    /// control register
    /// offset: 0x08
    CR: mmio.Mmio(packed struct(u32) {
        /// ADC enable control This bit is set by software to enable the ADC. The ADC is effectively ready to operate once the flag ADRDY has been set. It is cleared by hardware when the ADC is disabled, after the execution of the ADDIS command. Note: The software is allowed to set ADEN only when all bits of ADC_CR registers are 0 (ADCAL = 0, JADSTART = 0, ADSTART = 0, ADSTP = 0, ADDIS = 0 and ADEN = 0) except for bit ADVREGEN which must be 1 (and the software must have wait for the startup time of the voltage regulator).
        ADEN: u1,
        /// ADC disable command This bit is set by software to disable the ADC (ADDIS command) and put it into power-down state (OFF state). It is cleared by hardware once the ADC is effectively disabled (ADEN is also cleared by hardware at this time). Note: The software is allowed to set ADDIS only when ADEN = 1 and both ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        ADDIS: u1,
        /// ADC start of regular conversion This bit is set by software to start ADC conversion of regular channels. Depending on the configuration bits EXTEN, a conversion immediately starts (software trigger configuration) or once a regular hardware trigger event occurs (hardware trigger configuration). It is cleared by hardware: in Single conversion mode when software trigger is selected (EXTSEL = 0x0): at the assertion of the End of Regular Conversion Sequence (EOS) flag. in all cases: after the execution of the ADSTP command, at the same time that ADSTP is cleared by hardware. Note: The software is allowed to set ADSTART only when ADEN = 1 and ADDIS = 0 (ADC is enabled and there is no pending request to disable the ADC) In auto-injection mode (JAUTO = 1), regular and auto-injected conversions are started by setting bit ADSTART (JADSTART must be kept cleared).
        ADSTART: u1,
        /// ADC start of injected conversion This bit is set by software to start ADC conversion of injected channels. Depending on the configuration bits JEXTEN, a conversion immediately starts (software trigger configuration) or once an injected hardware trigger event occurs (hardware trigger configuration). It is cleared by hardware: in Single conversion mode when software trigger is selected (JEXTSEL = 0x0): at the assertion of the End of Injected Conversion Sequence (JEOS) flag. in all cases: after the execution of the JADSTP command, at the same time that JADSTP is cleared by hardware. Note: The software is allowed to set JADSTART only when ADEN = 1 and ADDIS = 0 (ADC is enabled and there is no pending request to disable the ADC). In auto-injection mode (JAUTO = 1), regular and auto-injected conversions are started by setting bit ADSTART (JADSTART must be kept cleared).
        JADSTART: u1,
        /// ADC stop of regular conversion command This bit is set by software to stop and discard an ongoing regular conversion (ADSTP Command). It is cleared by hardware when the conversion is effectively discarded and the ADC regular sequence and triggers can be re-configured. The ADC is then ready to accept a new start of regular conversions (ADSTART command). Note: The software is allowed to set ADSTP only when ADSTART = 1 and ADDIS = 0 (ADC is enabled and eventually converting a regular conversion and there is no pending request to disable the ADC). In auto-injection mode (JAUTO = 1), setting ADSTP bit aborts both regular and injected conversions (do not use JADSTP).
        ADSTP: u1,
        /// ADC stop of injected conversion command This bit is set by software to stop and discard an ongoing injected conversion (JADSTP Command). It is cleared by hardware when the conversion is effectively discarded and the ADC injected sequence and triggers can be re-configured. The ADC is then ready to accept a new start of injected conversions (JADSTART command). Note: The software is allowed to set JADSTP only when JADSTART = 1 and ADDIS = 0 (ADC is enabled and eventually converting an injected conversion and there is no pending request to disable the ADC) In Auto-injection mode (JAUTO = 1), setting ADSTP bit aborts both regular and injected conversions (do not use JADSTP).
        JADSTP: u1,
        reserved28: u22 = 0,
        /// voltage regulator enable This bits is set by software to enable the ADC voltage regulator. Before performing any operation such as launching a calibration or enabling the ADC, the ADC voltage regulator must first be enabled and the software must wait for the regulator start-up time. For more details about the ADC voltage regulator enable and disable sequences, refer to (ADVREGEN). The software can program this bit field only when the ADC is disabled (ADCAL = 0, JADSTART = 0, ADSTART = 0, ADSTP = 0, ADDIS = 0 and ADEN = 0)
        ADVREGEN: u1,
        /// Deep-power-down enable This bit is set and cleared by software to put the ADC in Deep-power-down mode. Note: The software is allowed to write this bit only when the ADC is disabled (ADCAL = 0, JADSTART = 0, JADSTP = 0, ADSTART = 0, ADSTP = 0, ADDIS = 0 and ADEN = 0).
        DEEPPWD: u1,
        /// Differential mode for calibration This bit is set and cleared by software to configure the Single-ended or Differential inputs mode for the calibration. Note: The software is allowed to write this bit only when the ADC is disabled and is not calibrating (ADCAL = 0, JADSTART = 0, JADSTP = 0, ADSTART = 0, ADSTP = 0, ADDIS = 0 and ADEN = 0).
        ADCALDIF: ADCALDIF,
        /// ADC calibration This bit is set by software to start the calibration of the ADC. Program first the bit ADCALDIF to determine if this calibration applies for Single-ended or Differential inputs mode. It is cleared by hardware after calibration is complete. Note: The software is allowed to launch a calibration by setting ADCAL only when ADEN = 0. The software is allowed to update the calibration factor by writing ADC_CALFACT only when ADEN = 1 and ADSTART = 0 and JADSTART = 0 (ADC enabled and no conversion is ongoing).
        ADCAL: u1,
    }),
    /// configuration register
    /// offset: 0x0c
    CFGR: mmio.Mmio(packed struct(u32) {
        /// Direct memory access enable This bit is set and cleared by software to enable the generation of DMA requests. This allows to use the DMA to manage automatically the converted data. For more details, refer to conversions using the DMA. Note: The software is allowed to write this bit only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        DMAEN: u1,
        /// Direct memory access configuration This bit is set and cleared by software to select between two DMA modes of operation and is effective only when DMAEN = 1. For more details, refer to Note: The software is allowed to write this bit only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        DMACFG: DMACFG,
        reserved3: u1 = 0,
        /// Data resolution These bits are written by software to select the resolution of the conversion. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        RES: RES,
        /// (1/5 of EXTSEL) External trigger selection for regular group These bits select the external event used to trigger the start of conversion of a regular group: ... Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"EXTSEL[0]": u1,
        /// (2/5 of EXTSEL) External trigger selection for regular group These bits select the external event used to trigger the start of conversion of a regular group: ... Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"EXTSEL[1]": u1,
        /// (3/5 of EXTSEL) External trigger selection for regular group These bits select the external event used to trigger the start of conversion of a regular group: ... Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"EXTSEL[2]": u1,
        /// (4/5 of EXTSEL) External trigger selection for regular group These bits select the external event used to trigger the start of conversion of a regular group: ... Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"EXTSEL[3]": u1,
        /// (5/5 of EXTSEL) External trigger selection for regular group These bits select the external event used to trigger the start of conversion of a regular group: ... Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"EXTSEL[4]": u1,
        /// External trigger enable and polarity selection for regular channels These bits are set and cleared by software to select the external trigger polarity and enable the trigger of a regular group. Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        EXTEN: EXTEN,
        /// Overrun mode This bit is set and cleared by software and configure the way data overrun is managed. Note: The software is allowed to write this bit only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        OVRMOD: OVRMOD,
        /// Single / Continuous conversion mode for regular conversions This bit is set and cleared by software. If it is set, regular conversion takes place continuously until it is cleared. Note: It is not possible to have both Discontinuous mode and Continuous mode enabled: it is forbidden to set both DISCEN = 1 and CONT = 1. The software is allowed to write this bit only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        CONT: u1,
        /// Delayed conversion mode This bit is set and cleared by software to enable/disable the Auto Delayed Conversion mode.. Note: The software is allowed to write this bit only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        AUTDLY: u1,
        /// Data alignment This bit is set and cleared by software to select right or left alignment. Refer to register, data alignment and offset (ADC_DR, OFFSET, OFFSET_CH, ALIGN). Note: The software is allowed to write this bit only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        ALIGN: ALIGN,
        /// Discontinuous mode for regular channels This bit is set and cleared by software to enable/disable Discontinuous mode for regular channels. Note: It is not possible to have both Discontinuous mode and Continuous mode enabled: it is forbidden to set both DISCEN = 1 and CONT = 1. It is not possible to use both auto-injected mode and Discontinuous mode simultaneously: the bits DISCEN and JDISCEN must be kept cleared by software when JAUTO is set. The software is allowed to write this bit only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        DISCEN: u1,
        /// Discontinuous mode channel count These bits are written by software to define the number of regular channels to be converted in Discontinuous mode, after receiving an external trigger. ... Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        DISCNUM: u3,
        /// Discontinuous mode on injected channels This bit is set and cleared by software to enable/disable Discontinuous mode on the injected channels of a group. Note: The software is allowed to write this bit only when JADSTART = 0 (which ensures that no injected conversion is ongoing). It is not possible to use both auto-injected mode and Discontinuous mode simultaneously: the bits DISCEN and JDISCEN must be kept cleared by software when JAUTO is set.
        JDISCEN: u1,
        /// JSQR queue mode This bit is set and cleared by software. It defines how an empty Queue is managed. Refer to for more information. Note: The software is allowed to write this bit only when JADSTART = 0 (which ensures that no injected conversion is ongoing).
        JQM: JQM,
        /// Enable the watchdog 1 on a single channel or on all channels This bit is set and cleared by software to enable the analog watchdog on the channel identified by the AWD1CH[4:0] bits or on all the channels Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        AWD1SGL: AWD1SGL,
        /// Analog watchdog 1 enable on regular channels This bit is set and cleared by software Note: The software is allowed to write this bit only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        AWD1EN: u1,
        /// Analog watchdog 1 enable on injected channels This bit is set and cleared by software Note: The software is allowed to write this bit only when JADSTART = 0 (which ensures that no injected conversion is ongoing).
        JAWD1EN: u1,
        /// Automatic injected group conversion This bit is set and cleared by software to enable/disable automatic injected group conversion after regular group conversion. Note: The software is allowed to write this bit only when ADSTART = 0 and JADSTART = 0 (which ensures that no regular nor injected conversion is ongoing).
        JAUTO: u1,
        /// Analog watchdog 1 channel selection These bits are set and cleared by software. They select the input channel to be guarded by the analog watchdog. ..... others: reserved, must not be used Note: Some channels are not connected physically. Keep the corresponding AWD1CH[4:0] setting to the reset value. The channel selected by AWD1CH must be also selected into the SQRi or JSQRi registers. The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        AWD1CH: u5,
        /// Injected Queue disable These bits are set and cleared by software to disable the Injected Queue mechanism : Note: The software is allowed to write this bit only when ADSTART = 0 and JADSTART = 0 (which ensures that no regular nor injected conversion is ongoing). A set or reset of JQDIS bit causes the injected queue to be flushed and the JSQR register is cleared.
        JQDIS: u1,
    }),
    /// configuration register 2
    /// offset: 0x10
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// Regular Oversampling Enable This bit is set and cleared by software to enable regular oversampling. Note: The software is allowed to write this bit only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        ROVSE: u1,
        /// Injected Oversampling Enable This bit is set and cleared by software to enable injected oversampling. Note: The software is allowed to write this bit only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        JOVSE: u1,
        /// Oversampling ratio This bitfield is set and cleared by software to define the oversampling ratio. Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no conversion is ongoing).
        OVSR: OVSR,
        /// Oversampling shift This bitfield is set and cleared by software to define the right shifting applied to the raw oversampling result. Other codes reserved Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no conversion is ongoing).
        OVSS: u4,
        /// Triggered Regular Oversampling This bit is set and cleared by software to enable triggered oversampling Note: The software is allowed to write this bit only when ADSTART = 0 (which ensures that no conversion is ongoing).
        TROVS: TROVS,
        /// Regular Oversampling mode This bit is set and cleared by software to select the regular oversampling mode. Note: The software is allowed to write this bit only when ADSTART = 0 (which ensures that no conversion is ongoing).
        ROVSM: ROVSM,
        reserved25: u14 = 0,
        /// Software trigger bit for sampling time control trigger mode This bit is set and cleared by software to enable the bulb sampling mode. Note: The software is allowed to write this bit only when ADSTART = 0 (which ensures that no conversion is ongoing).
        SWTRIG: SWTRIG,
        /// Bulb sampling mode This bit is set and cleared by software to enable the bulb sampling mode. SAMPTRIG bit must not be set when the BULB bit is set. The very first ADC conversion is performed with the sampling time specified in SMPx bits. Note: The software is allowed to write this bit only when ADSTART = 0 (which ensures that no conversion is ongoing).
        BULB: u1,
        /// Sampling time control trigger mode This bit is set and cleared by software to enable the sampling time control trigger mode. The sampling time starts on the trigger rising edge, and the conversion on the trigger falling edge. EXTEN bit should be set to 01. BULB bit must not be set when the SMPTRIG bit is set. When EXTEN bit is set to 00, set SWTRIG to start the sampling and clear SWTRIG bit to start the conversion. Note: The software is allowed to write this bit only when ADSTART = 0 (which ensures that no conversion is ongoing).
        SMPTRIG: u1,
        padding: u4 = 0,
    }),
    /// sample time register 1
    /// offset: 0x14
    SMPR1: mmio.Mmio(packed struct(u32) {
        /// (1/10 of SMP) Channel 0-9 sampling time selection These bits are written by software to select the sampling time individually for each channel. During sample cycles, the channel selection bits must remain unchanged. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically. Keep the corresponding SMPx[2:0] setting to the reset value.
        @"SMP[0]": SAMPLE_TIME,
        /// (2/10 of SMP) Channel 0-9 sampling time selection These bits are written by software to select the sampling time individually for each channel. During sample cycles, the channel selection bits must remain unchanged. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically. Keep the corresponding SMPx[2:0] setting to the reset value.
        @"SMP[1]": SAMPLE_TIME,
        /// (3/10 of SMP) Channel 0-9 sampling time selection These bits are written by software to select the sampling time individually for each channel. During sample cycles, the channel selection bits must remain unchanged. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically. Keep the corresponding SMPx[2:0] setting to the reset value.
        @"SMP[2]": SAMPLE_TIME,
        /// (4/10 of SMP) Channel 0-9 sampling time selection These bits are written by software to select the sampling time individually for each channel. During sample cycles, the channel selection bits must remain unchanged. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically. Keep the corresponding SMPx[2:0] setting to the reset value.
        @"SMP[3]": SAMPLE_TIME,
        /// (5/10 of SMP) Channel 0-9 sampling time selection These bits are written by software to select the sampling time individually for each channel. During sample cycles, the channel selection bits must remain unchanged. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically. Keep the corresponding SMPx[2:0] setting to the reset value.
        @"SMP[4]": SAMPLE_TIME,
        /// (6/10 of SMP) Channel 0-9 sampling time selection These bits are written by software to select the sampling time individually for each channel. During sample cycles, the channel selection bits must remain unchanged. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically. Keep the corresponding SMPx[2:0] setting to the reset value.
        @"SMP[5]": SAMPLE_TIME,
        /// (7/10 of SMP) Channel 0-9 sampling time selection These bits are written by software to select the sampling time individually for each channel. During sample cycles, the channel selection bits must remain unchanged. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically. Keep the corresponding SMPx[2:0] setting to the reset value.
        @"SMP[6]": SAMPLE_TIME,
        /// (8/10 of SMP) Channel 0-9 sampling time selection These bits are written by software to select the sampling time individually for each channel. During sample cycles, the channel selection bits must remain unchanged. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically. Keep the corresponding SMPx[2:0] setting to the reset value.
        @"SMP[7]": SAMPLE_TIME,
        /// (9/10 of SMP) Channel 0-9 sampling time selection These bits are written by software to select the sampling time individually for each channel. During sample cycles, the channel selection bits must remain unchanged. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically. Keep the corresponding SMPx[2:0] setting to the reset value.
        @"SMP[8]": SAMPLE_TIME,
        /// (10/10 of SMP) Channel 0-9 sampling time selection These bits are written by software to select the sampling time individually for each channel. During sample cycles, the channel selection bits must remain unchanged. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically. Keep the corresponding SMPx[2:0] setting to the reset value.
        @"SMP[9]": SAMPLE_TIME,
        reserved31: u1 = 0,
        /// Addition of one clock cycle to the sampling time. To make sure no conversion is ongoing, the software is allowed to write this bit only when ADSTART = 0 and JADSTART = 0
        SMPPLUS: SMPPLUS,
    }),
    /// sample time register 2
    /// offset: 0x18
    SMPR2: mmio.Mmio(packed struct(u32) {
        /// (1/10 of SMP) Channel 10-19 sampling time selection These bits are written by software to select the sampling time individually for each channel. During sample cycles, the channel selection bits must remain unchanged. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically. Keep the corresponding SMPx[2:0] setting to the reset value.
        @"SMP[0]": SAMPLE_TIME,
        /// (2/10 of SMP) Channel 10-19 sampling time selection These bits are written by software to select the sampling time individually for each channel. During sample cycles, the channel selection bits must remain unchanged. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically. Keep the corresponding SMPx[2:0] setting to the reset value.
        @"SMP[1]": SAMPLE_TIME,
        /// (3/10 of SMP) Channel 10-19 sampling time selection These bits are written by software to select the sampling time individually for each channel. During sample cycles, the channel selection bits must remain unchanged. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically. Keep the corresponding SMPx[2:0] setting to the reset value.
        @"SMP[2]": SAMPLE_TIME,
        /// (4/10 of SMP) Channel 10-19 sampling time selection These bits are written by software to select the sampling time individually for each channel. During sample cycles, the channel selection bits must remain unchanged. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically. Keep the corresponding SMPx[2:0] setting to the reset value.
        @"SMP[3]": SAMPLE_TIME,
        /// (5/10 of SMP) Channel 10-19 sampling time selection These bits are written by software to select the sampling time individually for each channel. During sample cycles, the channel selection bits must remain unchanged. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically. Keep the corresponding SMPx[2:0] setting to the reset value.
        @"SMP[4]": SAMPLE_TIME,
        /// (6/10 of SMP) Channel 10-19 sampling time selection These bits are written by software to select the sampling time individually for each channel. During sample cycles, the channel selection bits must remain unchanged. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically. Keep the corresponding SMPx[2:0] setting to the reset value.
        @"SMP[5]": SAMPLE_TIME,
        /// (7/10 of SMP) Channel 10-19 sampling time selection These bits are written by software to select the sampling time individually for each channel. During sample cycles, the channel selection bits must remain unchanged. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically. Keep the corresponding SMPx[2:0] setting to the reset value.
        @"SMP[6]": SAMPLE_TIME,
        /// (8/10 of SMP) Channel 10-19 sampling time selection These bits are written by software to select the sampling time individually for each channel. During sample cycles, the channel selection bits must remain unchanged. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically. Keep the corresponding SMPx[2:0] setting to the reset value.
        @"SMP[7]": SAMPLE_TIME,
        /// (9/10 of SMP) Channel 10-19 sampling time selection These bits are written by software to select the sampling time individually for each channel. During sample cycles, the channel selection bits must remain unchanged. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically. Keep the corresponding SMPx[2:0] setting to the reset value.
        @"SMP[8]": SAMPLE_TIME,
        /// (10/10 of SMP) Channel 10-19 sampling time selection These bits are written by software to select the sampling time individually for each channel. During sample cycles, the channel selection bits must remain unchanged. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically. Keep the corresponding SMPx[2:0] setting to the reset value.
        @"SMP[9]": SAMPLE_TIME,
        padding: u2 = 0,
    }),
    /// offset: 0x1c
    reserved28: [4]u8,
    /// watchdog threshold register 1
    /// offset: 0x20
    TR1: mmio.Mmio(packed struct(u32) {
        /// Analog watchdog 1 lower threshold These bits are written by software to define the lower threshold for the analog watchdog 1. Refer to AWD2CH, AWD3CH, AWD_HTx, AWD_LTx, AWDx) Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        LT1: u12,
        /// Analog watchdog filtering parameter This bit is set and cleared by software. ... Note: The software is allowed to write this bit only when ADSTART = 0 (which ensures that no conversion is ongoing).
        AWDFILT: u3,
        reserved16: u1 = 0,
        /// Analog watchdog 1 higher threshold These bits are written by software to define the higher threshold for the analog watchdog 1. Refer to AWD2CH, AWD3CH, AWD_HTx, AWD_LTx, AWDx) Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        HT1: u12,
        padding: u4 = 0,
    }),
    /// watchdog threshold register 2
    /// offset: 0x24
    TR2: mmio.Mmio(packed struct(u32) {
        /// Analog watchdog 2 lower threshold These bits are written by software to define the lower threshold for the analog watchdog 2. Refer to AWD2CH, AWD3CH, AWD_HTx, AWD_LTx, AWDx) Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        LT2: u8,
        reserved16: u8 = 0,
        /// Analog watchdog 2 higher threshold These bits are written by software to define the higher threshold for the analog watchdog 2. Refer to AWD2CH, AWD3CH, AWD_HTx, AWD_LTx, AWDx) Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        HT2: u8,
        padding: u8 = 0,
    }),
    /// watchdog threshold register 3
    /// offset: 0x28
    TR3: mmio.Mmio(packed struct(u32) {
        /// Analog watchdog 3 lower threshold These bits are written by software to define the lower threshold for the analog watchdog 3. This watchdog compares the 8-bit of LT3 with the 8 MSB of the converted data. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        LT3: u8,
        reserved16: u8 = 0,
        /// Analog watchdog 3 higher threshold These bits are written by software to define the higher threshold for the analog watchdog 3. Refer to AWD2CH, AWD3CH, AWD_HTx, AWD_LTx, AWDx) Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        HT3: u8,
        padding: u8 = 0,
    }),
    /// offset: 0x2c
    reserved44: [4]u8,
    /// regular sequence register 1
    /// offset: 0x30
    SQR1: mmio.Mmio(packed struct(u32) {
        /// Regular channel sequence length These bits are written by software to define the total number of conversions in the regular channel conversion sequence. ... Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        L: u4,
        reserved6: u2 = 0,
        /// (1/4 of SQ) 1st-4th conversions in regular sequence These bits are written by software with the channel number (0 to 19) assigned as the 1st-4th in the regular conversion sequence. Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"SQ[0]": u5,
        reserved12: u1 = 0,
        /// (2/4 of SQ) 1st-4th conversions in regular sequence These bits are written by software with the channel number (0 to 19) assigned as the 1st-4th in the regular conversion sequence. Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"SQ[1]": u5,
        reserved18: u1 = 0,
        /// (3/4 of SQ) 1st-4th conversions in regular sequence These bits are written by software with the channel number (0 to 19) assigned as the 1st-4th in the regular conversion sequence. Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"SQ[2]": u5,
        reserved24: u1 = 0,
        /// (4/4 of SQ) 1st-4th conversions in regular sequence These bits are written by software with the channel number (0 to 19) assigned as the 1st-4th in the regular conversion sequence. Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"SQ[3]": u5,
        padding: u3 = 0,
    }),
    /// regular sequence register 2
    /// offset: 0x34
    SQR2: mmio.Mmio(packed struct(u32) {
        /// (1/5 of SQ) 5th-9th conversions in regular sequence These bits are written by software with the channel number (0 to 19) assigned as the 5th-9th in the regular conversion sequence. Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"SQ[0]": u5,
        reserved6: u1 = 0,
        /// (2/5 of SQ) 5th-9th conversions in regular sequence These bits are written by software with the channel number (0 to 19) assigned as the 5th-9th in the regular conversion sequence. Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"SQ[1]": u5,
        reserved12: u1 = 0,
        /// (3/5 of SQ) 5th-9th conversions in regular sequence These bits are written by software with the channel number (0 to 19) assigned as the 5th-9th in the regular conversion sequence. Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"SQ[2]": u5,
        reserved18: u1 = 0,
        /// (4/5 of SQ) 5th-9th conversions in regular sequence These bits are written by software with the channel number (0 to 19) assigned as the 5th-9th in the regular conversion sequence. Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"SQ[3]": u5,
        reserved24: u1 = 0,
        /// (5/5 of SQ) 5th-9th conversions in regular sequence These bits are written by software with the channel number (0 to 19) assigned as the 5th-9th in the regular conversion sequence. Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"SQ[4]": u5,
        padding: u3 = 0,
    }),
    /// regular sequence register 3
    /// offset: 0x38
    SQR3: mmio.Mmio(packed struct(u32) {
        /// (1/5 of SQ) 10th-14th conversions in regular sequence These bits are written by software with the channel number (0 to 19) assigned as the 10th-14th in the regular conversion sequence. Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"SQ[0]": u5,
        reserved6: u1 = 0,
        /// (2/5 of SQ) 10th-14th conversions in regular sequence These bits are written by software with the channel number (0 to 19) assigned as the 10th-14th in the regular conversion sequence. Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"SQ[1]": u5,
        reserved12: u1 = 0,
        /// (3/5 of SQ) 10th-14th conversions in regular sequence These bits are written by software with the channel number (0 to 19) assigned as the 10th-14th in the regular conversion sequence. Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"SQ[2]": u5,
        reserved18: u1 = 0,
        /// (4/5 of SQ) 10th-14th conversions in regular sequence These bits are written by software with the channel number (0 to 19) assigned as the 10th-14th in the regular conversion sequence. Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"SQ[3]": u5,
        reserved24: u1 = 0,
        /// (5/5 of SQ) 10th-14th conversions in regular sequence These bits are written by software with the channel number (0 to 19) assigned as the 10th-14th in the regular conversion sequence. Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"SQ[4]": u5,
        padding: u3 = 0,
    }),
    /// regular sequence register 4
    /// offset: 0x3c
    SQR4: mmio.Mmio(packed struct(u32) {
        /// (1/2 of SQ) 15th-16th conversions in regular sequence These bits are written by software with the channel number (0 to 19) assigned as the 15th-16th in the regular conversion sequence. Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"SQ[0]": u5,
        reserved6: u1 = 0,
        /// (2/2 of SQ) 15th-16th conversions in regular sequence These bits are written by software with the channel number (0 to 19) assigned as the 15th-16th in the regular conversion sequence. Note: The software is allowed to write these bits only when ADSTART = 0 (which ensures that no regular conversion is ongoing).
        @"SQ[1]": u5,
        padding: u21 = 0,
    }),
    /// regular data register
    /// offset: 0x40
    DR: mmio.Mmio(packed struct(u32) {
        /// Regular data converted These bits are read-only. They contain the conversion result from the last converted regular channel. The data are left- or right-aligned as described in
        RDATA: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x44
    reserved68: [8]u8,
    /// injected sequence register
    /// offset: 0x4c
    JSQR: mmio.Mmio(packed struct(u32) {
        /// Injected channel sequence length These bits are written by software to define the total number of conversions in the injected channel conversion sequence. Note: The software is allowed to write these bits only when JADSTART = 0 (which ensures that no injected conversion is ongoing).
        JL: u2,
        /// External Trigger Selection for injected group These bits select the external event used to trigger the start of conversion of an injected group: ... Note: The software is allowed to write these bits only when JADSTART = 0 (which ensures that no injected conversion is ongoing).
        JEXTSEL: u5,
        /// External trigger enable and polarity selection for injected channels These bits are set and cleared by software to select the external trigger polarity and enable the trigger of an injected group. Note: The software is allowed to write these bits only when JADSTART = 0 (which ensures that no injected conversion is ongoing). If JQM = 1 and if the Queue of Context becomes empty, the software and hardware triggers of the injected sequence are both internally disabled (refer to Queue of context for injected conversions).
        JEXTEN: EXTEN,
        /// (1/4 of JSQ) 1st-4th conversions in the injected sequence These bits are written by software with the channel number (0 to 19) assigned as the 1st-4th in the injected conversion sequence. Note: The software is allowed to write these bits only when JADSTART = 0 (which ensures that no injected conversion is ongoing).
        @"JSQ[0]": u5,
        reserved15: u1 = 0,
        /// (2/4 of JSQ) 1st-4th conversions in the injected sequence These bits are written by software with the channel number (0 to 19) assigned as the 1st-4th in the injected conversion sequence. Note: The software is allowed to write these bits only when JADSTART = 0 (which ensures that no injected conversion is ongoing).
        @"JSQ[1]": u5,
        reserved21: u1 = 0,
        /// (3/4 of JSQ) 1st-4th conversions in the injected sequence These bits are written by software with the channel number (0 to 19) assigned as the 1st-4th in the injected conversion sequence. Note: The software is allowed to write these bits only when JADSTART = 0 (which ensures that no injected conversion is ongoing).
        @"JSQ[2]": u5,
        reserved27: u1 = 0,
        /// (4/4 of JSQ) 1st-4th conversions in the injected sequence These bits are written by software with the channel number (0 to 19) assigned as the 1st-4th in the injected conversion sequence. Note: The software is allowed to write these bits only when JADSTART = 0 (which ensures that no injected conversion is ongoing).
        @"JSQ[3]": u5,
    }),
    /// offset: 0x50
    reserved80: [16]u8,
    /// offset 1-4 register
    /// offset: 0x60
    OFR: [4]mmio.Mmio(packed struct(u32) {
        /// Data offset y for the channel programmed into bits OFFSET_CH[4:0] These bits are written by software to define the offset to be subtracted from the raw converted data when converting a channel (can be regular or injected). The channel to which applies the data offset must be programmed in the bits OFFSET_CH[4:0]. The conversion result can be read from in the ADC_DR (regular conversion) or from in the ADC_JDRyi registers (injected conversion). Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). If several offset (OFFSET) point to the same channel, only the offset with the lowest x value is considered for the subtraction. Ex: if OFFSET1_CH[4:0] = 4 and OFFSET2_CH[4:0] = 4, this is OFFSET1[11:0] which is subtracted when converting channel 4.
        OFFSET: u12,
        reserved24: u12 = 0,
        /// Positive offset This bit is set and cleared by software to enable the positive offset. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        OFFSETPOS: OFFSETPOS,
        /// Saturation enable This bit is set and cleared by software to enable the saturation at 0x000 and 0xFFF for the offset function. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        SATEN: u1,
        /// Channel selection for the data offset y These bits are written by software to define the channel to which the offset programmed into bits OFFSET[11:0] applies. Note: The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically and must not be selected for the data offset y. If OFFSET_EN is set, it is not allowed to select the same channel for different ADC_OFRy registers.
        OFFSET_CH: u5,
        /// Offset y enable This bit is written by software to enable or disable the offset programmed into bits OFFSET[11:0]. Note: The software is allowed to write this bit only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing).
        OFFSET_EN: u1,
    }),
    /// offset: 0x70
    reserved112: [16]u8,
    /// injected channel 1-4 register
    /// offset: 0x80
    JDR: [4]mmio.Mmio(packed struct(u32) {
        /// Injected data These bits are read-only. They contain the conversion result from injected channel y. The data are left -or right-aligned as described in
        JDATA: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x90
    reserved144: [16]u8,
    /// Analog Watchdog 2 Configuration Register
    /// offset: 0xa0
    AWD2CR: mmio.Mmio(packed struct(u32) {
        /// Analog watchdog 2 channel selection These bits are set and cleared by software. They enable and select the input channels to be guarded by the analog watchdog 2. AWD2CH[i] = 0: analog input channel i is not monitored by AWD2 AWD2CH[i] = 1: analog input channel i is monitored by AWD2 When AWD2CH[19:0] = 000..0, the analog Watchdog 2 is disabled Note: The channels selected by AWD2CH must be also selected into the SQRi or JSQRi registers. The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically and must not be selected for the analog watchdog.
        AWD2CH: u20,
        padding: u12 = 0,
    }),
    /// Analog Watchdog 3 Configuration Register
    /// offset: 0xa4
    AWD3CR: mmio.Mmio(packed struct(u32) {
        /// Analog watchdog 3 channel selection These bits are set and cleared by software. They enable and select the input channels to be guarded by the analog watchdog 3. AWD3CH[i] = 0: analog input channel i is not monitored by AWD3 AWD3CH[i] = 1: analog input channel i is monitored by AWD3 When AWD3CH[19:0] = 000..0, the analog Watchdog 3 is disabled Note: The channels selected by AWD3CH must be also selected into the SQRi or JSQRi registers. The software is allowed to write these bits only when ADSTART = 0 and JADSTART = 0 (which ensures that no conversion is ongoing). Some channels are not connected physically and must not be selected for the analog watchdog.
        AWD3CH: u20,
        padding: u12 = 0,
    }),
    /// offset: 0xa8
    reserved168: [8]u8,
    /// Differential mode Selection Register
    /// offset: 0xb0
    DIFSEL: mmio.Mmio(packed struct(u32) {
        /// Differential mode for channels 19 to 0. These bits are set and cleared by software. They allow to select if a channel is configured as Single-ended or Differential mode. DIFSEL[i] = 0: analog input channel is configured in Single-ended mode DIFSEL[i] = 1: analog input channel i is configured in Differential mode Note: The DIFSEL bits corresponding to channels that are either connected to a single-ended I/O port or to an internal channel must be kept their reset value (Single-ended input mode). The software is allowed to write these bits only when the ADC is disabled (ADCAL = 0, JADSTART = 0, JADSTP = 0, ADSTART = 0, ADSTP = 0, ADDIS = 0 and ADEN = 0).
        DIFSEL: u20,
        padding: u12 = 0,
    }),
    /// Calibration Factors
    /// offset: 0xb4
    CALFACT: mmio.Mmio(packed struct(u32) {
        /// Calibration Factors In Single-ended mode These bits are written by hardware or by software. Once a single-ended inputs calibration is complete, they are updated by hardware with the calibration factors. Software can write these bits with a new calibration factor. If the new calibration factor is different from the current one stored into the analog ADC, it is then applied once a new single-ended calibration is launched. Note: The software is allowed to write these bits only when ADEN = 1, ADSTART = 0 and JADSTART = 0 (ADC is enabled and no calibration is ongoing and no conversion is ongoing).
        CALFACT_S: u7,
        reserved16: u9 = 0,
        /// Calibration Factors in differential mode These bits are written by hardware or by software. Once a differential inputs calibration is complete, they are updated by hardware with the calibration factors. Software can write these bits with a new calibration factor. If the new calibration factor is different from the current one stored into the analog ADC, it is then applied once a new differential calibration is launched. Note: The software is allowed to write these bits only when ADEN = 1, ADSTART = 0 and JADSTART = 0 (ADC is enabled and no calibration is ongoing and no conversion is ongoing).
        CALFACT_D: u7,
        padding: u9 = 0,
    }),
    /// offset: 0xb8
    reserved184: [16]u8,
    /// option register
    /// offset: 0xc8
    OR: mmio.Mmio(packed struct(u32) {
        /// Option bit 0
        OP0: u1,
        /// Option bit 1. Note - not documented for H562/H563/H573
        OP1: u1,
        padding: u30 = 0,
    }),
};
