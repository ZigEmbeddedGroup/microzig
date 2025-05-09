const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const BKBID = enum(u1) {
    /// Break input tim_brk in input mode
    Input = 0x0,
    /// Break input tim_brk in bidirectional mode
    Bidirectional = 0x1,
};

pub const BKDSRM = enum(u1) {
    /// Break input tim_brk is armed
    Armed = 0x0,
    /// Break input tim_brk is disarmed
    Disarmed = 0x1,
};

pub const BKINP = enum(u1) {
    /// input polarity is not inverted (active low if BKxP = 0, active high if BKxP = 1)
    NotInverted = 0x0,
    /// input polarity is inverted (active high if BKxP = 0, active low if BKxP = 1)
    Inverted = 0x1,
};

pub const BKP = enum(u1) {
    /// Break input tim_brk is active low
    ActiveLow = 0x0,
    /// Break input tim_brk is active high
    ActiveHigh = 0x1,
};

pub const CCDS = enum(u1) {
    /// CCx DMA request sent when CCx event occurs
    OnCompare = 0x0,
    /// CCx DMA request sent when update event occurs
    OnUpdate = 0x1,
};

pub const CCMR_Input_CCS = enum(u2) {
    /// CCx channel is configured as input, normal mapping: ICx mapped to TIx
    TI4 = 0x1,
    /// CCx channel is configured as input, alternate mapping (switches 1 with 2, 3 with 4)
    TI3 = 0x2,
    /// CCx channel is configured as input, ICx is mapped on TRC
    TRC = 0x3,
    _,
};

pub const CCMR_Output_CCS = enum(u2) {
    /// CCx channel is configured as output
    Output = 0x0,
    _,
};

pub const CKD = enum(u2) {
    /// t_DTS = t_CK_INT
    Div1 = 0x0,
    /// t_DTS = 2 × t_CK_INT
    Div2 = 0x1,
    /// t_DTS = 4 × t_CK_INT
    Div4 = 0x2,
    _,
};

pub const CMS = enum(u2) {
    /// The counter counts up or down depending on the direction bit
    EdgeAligned = 0x0,
    /// The counter counts up and down alternatively. Output compare interrupt flags are set only when the counter is counting down.
    CenterAligned1 = 0x1,
    /// The counter counts up and down alternatively. Output compare interrupt flags are set only when the counter is counting up.
    CenterAligned2 = 0x2,
    /// The counter counts up and down alternatively. Output compare interrupt flags are set both when the counter is counting up or down.
    CenterAligned3 = 0x3,
};

pub const DBSS = enum(u4) {
    /// Update
    Update = 0x1,
    /// CC1
    CC1 = 0x2,
    /// CC2
    CC2 = 0x3,
    /// CC3
    CC3 = 0x4,
    /// CC4
    CC4 = 0x5,
    /// COM
    COM = 0x6,
    /// Trigger
    Trigger = 0x7,
    _,
};

pub const DIR = enum(u1) {
    /// Counter used as upcounter
    Up = 0x0,
    /// Counter used as downcounter
    Down = 0x1,
};

pub const DTAE = enum(u1) {
    /// Deadtime on rising and falling edges are identical, and defined with DTG[7:0] register
    Identical = 0x0,
    /// Deadtime on rising edge is defined with DTG[7:0] register and deadtime on falling edge is defined with DTGF[7:0] bits.
    Distinct = 0x1,
};

pub const ETP = enum(u1) {
    /// ETR is noninverted, active at high level or rising edge
    NotInverted = 0x0,
    /// ETR is inverted, active at low level or falling edge
    Inverted = 0x1,
};

pub const ETPS = enum(u2) {
    /// Prescaler OFF
    Div1 = 0x0,
    /// ETRP frequency divided by 2
    Div2 = 0x1,
    /// ETRP frequency divided by 4
    Div4 = 0x2,
    /// ETRP frequency divided by 8
    Div8 = 0x3,
};

pub const FIDX = enum(u1) {
    /// Index is always active
    AlwaysActive = 0x0,
    /// the first Index only resets the counter
    FirstOnly = 0x1,
};

pub const FilterValue = enum(u4) {
    /// No filter, sampling is done at fDTS
    NoFilter = 0x0,
    /// fSAMPLING=fCK_INT, N=2
    FCK_INT_N2 = 0x1,
    /// fSAMPLING=fCK_INT, N=4
    FCK_INT_N4 = 0x2,
    /// fSAMPLING=fCK_INT, N=8
    FCK_INT_N8 = 0x3,
    /// fSAMPLING=fDTS/2, N=6
    FDTS_Div2_N6 = 0x4,
    /// fSAMPLING=fDTS/2, N=8
    FDTS_Div2_N8 = 0x5,
    /// fSAMPLING=fDTS/4, N=6
    FDTS_Div4_N6 = 0x6,
    /// fSAMPLING=fDTS/4, N=8
    FDTS_Div4_N8 = 0x7,
    /// fSAMPLING=fDTS/8, N=6
    FDTS_Div8_N6 = 0x8,
    /// fSAMPLING=fDTS/8, N=8
    FDTS_Div8_N8 = 0x9,
    /// fSAMPLING=fDTS/16, N=5
    FDTS_Div16_N5 = 0xa,
    /// fSAMPLING=fDTS/16, N=6
    FDTS_Div16_N6 = 0xb,
    /// fSAMPLING=fDTS/16, N=8
    FDTS_Div16_N8 = 0xc,
    /// fSAMPLING=fDTS/32, N=5
    FDTS_Div32_N5 = 0xd,
    /// fSAMPLING=fDTS/32, N=6
    FDTS_Div32_N6 = 0xe,
    /// fSAMPLING=fDTS/32, N=8
    FDTS_Div32_N8 = 0xf,
};

pub const GC5C = enum(u1) {
    /// No effect of TIM_OC5REF on TIM_OCxREFC (x=1-3)
    NoEffect = 0x0,
    /// TIM_OCxREFC is the logical AND of TIM_OCxREF and TIM_OC5REF
    LogicalAND = 0x1,
};

pub const IBLK = enum(u2) {
    /// Index always active
    AlwaysActive = 0x0,
    /// Index disabled when tim_ti3 input is active, as per CC3P bitfield
    CC3P = 0x1,
    /// Index disabled when tim_ti4 input is active, as per CC4P bitfield
    CC4P = 0x2,
    _,
};

pub const IDIR = enum(u2) {
    /// Index resets the counter whatever the direction
    Both = 0x0,
    /// Index resets the counter when up-counting only
    Up = 0x1,
    /// Index resets the counter when down-counting only
    Down = 0x2,
    _,
};

pub const LOCK = enum(u2) {
    /// No bit is write protected
    Disabled = 0x0,
    /// DTG bits in TIMx_BDTR register, OISx and OISxN bits in TIMx_CR2 register and BKBID/BKE/BKP/AOE bits in TIMx_BDTR register can no longer be written
    Level1 = 0x1,
    /// LOCK Level 1 + CC Polarity bits (CCxP/CCxNP bits in TIMx_CCER register, as long as the related channel is configured in output through the CCxS bits) as well as OSSR and OSSI bits can no longer be written.
    Level2 = 0x2,
    /// LOCK Level 2 + CC Control bits (OCxM and OCxPE bits in TIMx_CCMRx registers, as long as the related channel is configured in output through the CCxS bits) can no longer be written.
    Level3 = 0x3,
};

pub const MMS = enum(u4) {
    /// The UG bit from the TIMx_EGR register is used as trigger output
    Reset = 0x0,
    /// The counter enable signal, CNT_EN, is used as trigger output
    Enable = 0x1,
    /// The update event is selected as trigger output
    Update = 0x2,
    /// The trigger output send a positive pulse when the CC1IF flag it to be set, as soon as a capture or a compare match occurred
    ComparePulse = 0x3,
    /// OC1REF signal is used as trigger output
    CompareOC1 = 0x4,
    /// OC2REF signal is used as trigger output
    CompareOC2 = 0x5,
    /// OC3REF signal is used as trigger output
    CompareOC3 = 0x6,
    /// OC4REF signal is used as trigger output
    CompareOC4 = 0x7,
    /// The encoder clock signal is used as trigger output
    EncoderClockOutput = 0x8,
    _,
};

pub const MMS2 = enum(u4) {
    /// The UG bit from the TIMx_EGR register is used as TRGO2
    Reset = 0x0,
    /// The counter enable signal, CNT_EN, is used as TRGO2
    Enable = 0x1,
    /// The update event is selected as TRGO2
    Update = 0x2,
    /// TRGO2 send a positive pulse when the CC1IF flag it to be set, as soon as a capture or a compare match occurred
    ComparePulse = 0x3,
    /// OC1REF signal is used as TRGO2
    CompareOC1 = 0x4,
    /// OC2REF signal is used as TRGO2
    CompareOC2 = 0x5,
    /// OC3REF signal is used as TRGO2
    CompareOC3 = 0x6,
    /// OC4REF signal is used as TRGO2
    CompareOC4 = 0x7,
    /// OC5REF signal is used as TRGO2
    CompareOC5 = 0x8,
    /// OC6REF signal is used as TRGO2
    CompareOC6 = 0x9,
    /// OC4REF rising or falling edges generate pulses on TRGO2
    ComparePulse_OC4 = 0xa,
    /// OC6REF rising or falling edges generate pulses on TRGO2
    ComparePulse_OC6 = 0xb,
    /// OC4REF or OC6REF rising edges generate pulses on TRGO2
    ComparePulse_OC4_Or_OC6_Rising = 0xc,
    /// OC4REF rising or OC6REF falling edges generate pulses on TRGO2
    ComparePulse_OC4_Rising_Or_OC6_Falling = 0xd,
    /// OC5REF or OC6REF rising edges generate pulses on TRGO2
    ComparePulse_OC5_Or_OC6_Rising = 0xe,
    /// OC5REF rising or OC6REF falling edges generate pulses on TRGO2
    ComparePulse_OC5_Rising_Or_OC6_Falling = 0xf,
};

pub const MSM = enum(u1) {
    /// No action
    NoSync = 0x0,
    /// The effect of an event on the trigger input (TRGI) is delayed to allow a perfect synchronization between the current timer and its slaves (through TRGO). It is useful if we want to synchronize several timers on a single external event.
    Sync = 0x1,
};

pub const OCCS = enum(u1) {
    /// tim_ocref_clr_int is connected to the tim_ocref_clr input
    Input = 0x0,
    /// tim_ocref_clr_int is connected to tim_etrf
    ETRF = 0x1,
};

pub const OCM = enum(u4) {
    /// The comparison between the output compare register TIMx_CCRy and the counter TIMx_CNT has no effect on the outputs
    Frozen = 0x0,
    /// Set channel to active level on match. OCyREF signal is forced high when the counter matches the capture/compare register
    ActiveOnMatch = 0x1,
    /// Set channel to inactive level on match. OCyREF signal is forced low when the counter matches the capture/compare register
    InactiveOnMatch = 0x2,
    /// OCyREF toggles when TIMx_CNT=TIMx_CCRy
    Toggle = 0x3,
    /// OCyREF is forced low
    ForceInactive = 0x4,
    /// OCyREF is forced high
    ForceActive = 0x5,
    /// In upcounting, channel is active as long as TIMx_CNT<TIMx_CCRy else inactive. In downcounting, channel is inactive as long as TIMx_CNT>TIMx_CCRy else active
    PwmMode1 = 0x6,
    /// Inversely to PwmMode1
    PwmMode2 = 0x7,
    /// In up-counting mode, the channel is active until a trigger event is detected (on tim_trgi signal). Then, a comparison is performed as in PWM mode 1 and the channels becomes active again at the next update. In down-counting mode, the channel is inactive until a trigger event is detected (on tim_trgi signal). Then, a comparison is performed as in PWM mode 1 and the channels becomes inactive again at the next update.
    Retrigerrable_OPM_Mode_1 = 0x8,
    /// In up-counting mode, the channel is inactive until a trigger event is detected (on tim_trgi signal). Then, a comparison is performed as in PWM mode 2 and the channels becomes inactive again at the next update. In down- counting mode, the channel is active until a trigger event is detected (on tim_trgi signal). Then, a comparison is performed as in PWM mode 1 and the channels becomes active again at the next update.
    Retrigerrable_OPM_Mode_2 = 0x9,
    /// _reserved1
    _reserved1 = 0xa,
    /// _reserved2
    _reserved2 = 0xb,
    /// tim_oc1ref has the same behavior as in PWM mode 1. tim_oc1refc is the logical OR between tim_oc1ref and tim_oc2ref.
    Combined_PWM_Mode_1 = 0xc,
    /// tim_oc1ref has the same behavior as in PWM mode 2. tim_oc1refc is the logical AND between tim_oc1ref and tim_oc2ref.
    Combined_PWM_Mode_2 = 0xd,
    /// tim_oc1ref has the same behavior as in PWM mode 1. tim_oc1refc outputs tim_oc1ref when the counter is counting up, tim_oc2ref when it is counting down.
    Asymmetric_PWM_Mode_1 = 0xe,
    /// tim_oc1ref has the same behavior as in PWM mode 2. tim_oc1refc outputs tim_oc1ref when the counter is counting up, tim_oc2ref when it is counting down.
    Asymmetric_PWM_Mode_2 = 0xf,
};

pub const OSSI = enum(u1) {
    /// When inactive, OC/OCN outputs are disabled
    Disabled = 0x0,
    /// When inactive, OC/OCN outputs are forced to idle level
    IdleLevel = 0x1,
};

pub const OSSR = enum(u1) {
    /// When inactive, OC/OCN outputs are disabled
    Disabled = 0x0,
    /// When inactive, OC/OCN outputs are enabled with their inactive level
    IdleLevel = 0x1,
};

pub const SMS = enum(u4) {
    /// Slave mode disabled - if CEN = '1' then the prescaler is clocked directly by the internal clock.
    Disabled = 0x0,
    /// Encoder mode 1 - Counter counts up/down on TI2FP1 edge depending on TI1FP2 level.
    Encoder_Mode_1 = 0x1,
    /// Encoder mode 2 - Counter counts up/down on TI1FP2 edge depending on TI2FP1 level.
    Encoder_Mode_2 = 0x2,
    /// Encoder mode 3 - Counter counts up/down on both TI1FP1 and TI2FP2 edges depending on the level of the other input.
    Encoder_Mode_3 = 0x3,
    /// Reset Mode - Rising edge of the selected trigger input (TRGI) reinitializes the counter and generates an update of the registers.
    Reset_Mode = 0x4,
    /// Gated Mode - The counter clock is enabled when the trigger input (TRGI) is high. The counter stops (but is not reset) as soon as the trigger becomes low. Both start and stop of the counter are controlled.
    Gated_Mode = 0x5,
    /// Trigger Mode - The counter starts at a rising edge of the trigger TRGI (but it is not reset). Only the start of the counter is controlled.
    Trigger_Mode = 0x6,
    /// External Clock Mode 1 - Rising edges of the selected trigger (TRGI) clock the counter.
    Ext_Clock_Mode = 0x7,
    /// Rising edge of the selected trigger input (tim_trgi) reinitializes the counter, generates an update of the registers and starts the counter.
    Combined_Reset_Trigger = 0x8,
    /// The counter clock is enabled when the trigger input (tim_trgi) is high. The counter stops and is reset) as soon as the trigger becomes low. Both start and stop of the counter are controlled.
    Combined_Gated_Trigger = 0x9,
    /// Encoder mode, Clock plus direction, x2 mode.
    Encoder_Up_X2 = 0xa,
    /// Encoder mode, Clock plus direction, x1 mode, tim_ti2fp2 edge sensitivity is set by CC2P
    Encoder_Up_X1 = 0xb,
    /// Encoder mode, Directional Clock, x2 mode.
    Encoder_Dir_X2 = 0xc,
    /// Encoder mode, Directional Clock, x1 mode, tim_ti1fp1 and tim_ti2fp2 edge sensitivity is set by CC1P and CC2P.
    Encoder_Dir_X1 = 0xd,
    /// Quadrature encoder mode, x1 mode, counting on tim_ti1fp1 edges only, edge sensitivity is set by CC1P.
    Quadrature_Encoder_Mode_X1_TI1PF1 = 0xe,
    /// Quadrature encoder mode, x1 mode, counting on tim_ti2fp2 edges only, edge sensitivity is set by CC2P.
    Quadrature_Encoder_Mode_X1_TI2PF2 = 0xf,
};

pub const SMSPS = enum(u1) {
    /// The transfer is triggered by the Timer’s Update event
    Update = 0x0,
    /// The transfer is triggered by the Index event
    Index = 0x1,
};

pub const TI1S = enum(u1) {
    /// The TIMx_CH1 pin is connected to TI1 input
    Normal = 0x0,
    /// The TIMx_CH1, CH2, CH3 pins are connected to TI1 input
    XOR = 0x1,
};

pub const TS = enum(u5) {
    /// Internal Trigger 0
    ITR0 = 0x0,
    /// Internal Trigger 1
    ITR1 = 0x1,
    /// Internal Trigger 2
    ITR2 = 0x2,
    /// Internal Trigger 3
    ITR3 = 0x3,
    /// TI1 Edge Detector
    TI1F_ED = 0x4,
    /// Filtered Timer Input 1
    TI1FP1 = 0x5,
    /// Filtered Timer Input 2
    TI2FP2 = 0x6,
    /// External Trigger input
    ETRF = 0x7,
    /// Internal Trigger 4
    ITR4 = 0x8,
    /// Internal Trigger 5
    ITR5 = 0x9,
    /// Internal Trigger 6
    ITR6 = 0xa,
    /// Internal Trigger 7
    ITR7 = 0xb,
    /// Internal Trigger 8
    ITR8 = 0xc,
    /// Internal Trigger 9
    ITR9 = 0xd,
    /// Internal Trigger 10
    ITR10 = 0xe,
    /// Internal Trigger 11
    ITR11 = 0xf,
    /// Internal Trigger 12
    ITR12 = 0x10,
    /// Internal Trigger 13
    ITR13 = 0x11,
    /// Internal Trigger 14
    ITR14 = 0x12,
    /// Internal Trigger 15
    ITR15 = 0x13,
    _,
};

pub const URS = enum(u1) {
    /// Any of counter overflow/underflow, setting UG, or update through slave mode, generates an update interrupt or DMA request
    AnyEvent = 0x0,
    /// Only counter overflow/underflow generates an update interrupt or DMA request
    CounterOnly = 0x1,
};

/// 1-channel timers
pub const TIM_1CH = extern struct {
    /// control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Counter enable
        CEN: u1,
        /// Update disable
        UDIS: u1,
        /// Update request source
        URS: URS,
        /// One-pulse mode enbaled
        OPM: u1,
        reserved7: u3 = 0,
        /// Auto-reload preload enable
        ARPE: u1,
        /// Clock division
        CKD: CKD,
        reserved11: u1 = 0,
        /// UIF status bit remapping enable
        UIFREMAP: u1,
        /// Dithering enable
        DITHEN: u1,
        padding: u19 = 0,
    }),
    /// offset: 0x04
    reserved4: [8]u8,
    /// DMA/Interrupt enable register
    /// offset: 0x0c
    DIER: mmio.Mmio(packed struct(u32) {
        /// Update interrupt enable
        UIE: u1,
        /// (1/1 of CCIE) Capture/Compare x (x=1) interrupt enable
        @"CCIE[0]": u1,
        padding: u30 = 0,
    }),
    /// status register
    /// offset: 0x10
    SR: mmio.Mmio(packed struct(u32) {
        /// Update interrupt flag
        UIF: u1,
        /// (1/1 of CCIF) Capture/compare x (x=1) interrupt flag
        @"CCIF[0]": u1,
        reserved9: u7 = 0,
        /// (1/1 of CCOF) Capture/Compare x (x=1) overcapture flag
        @"CCOF[0]": u1,
        padding: u22 = 0,
    }),
    /// event generation register
    /// offset: 0x14
    EGR: mmio.Mmio(packed struct(u32) {
        /// Update generation
        UG: u1,
        /// (1/1 of CCG) Capture/compare x (x=1) generation
        @"CCG[0]": u1,
        padding: u30 = 0,
    }),
    /// capture/compare mode register 1 (input mode)
    /// offset: 0x18
    CCMR_Input: [1]mmio.Mmio(packed struct(u32) {
        /// (1/1 of CCS) Capture/Compare y selection
        @"CCS[0]": CCMR_Input_CCS,
        /// (1/1 of ICPSC) Input capture y prescaler
        @"ICPSC[0]": u2,
        /// (1/1 of ICF) Input capture y filter
        @"ICF[0]": FilterValue,
        padding: u24 = 0,
    }),
    /// offset: 0x1c
    reserved28: [4]u8,
    /// capture/compare enable register
    /// offset: 0x20
    CCER: mmio.Mmio(packed struct(u32) {
        /// (1/1 of CCE) Capture/Compare x (x=1) output enable
        @"CCE[0]": u1,
        /// (1/1 of CCP) Capture/Compare x (x=1) output Polarity
        @"CCP[0]": u1,
        reserved3: u1 = 0,
        /// (1/1 of CCNP) Capture/Compare x (x=1) output Polarity
        @"CCNP[0]": u1,
        padding: u28 = 0,
    }),
    /// counter
    /// offset: 0x24
    CNT: mmio.Mmio(packed struct(u32) {
        /// counter value
        CNT: u16,
        reserved31: u15 = 0,
        /// UIF copy
        UIFCPY: u1,
    }),
    /// prescaler
    /// offset: 0x28
    PSC: u32,
    /// auto-reload register (Dither mode disabled)
    /// offset: 0x2c
    ARR: mmio.Mmio(packed struct(u32) {
        /// Auto-reload value
        ARR: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x30
    reserved48: [4]u8,
    /// capture/compare register x (x=1) (Dither mode disabled)
    /// offset: 0x34
    CCR: [1]mmio.Mmio(packed struct(u32) {
        /// capture/compare x (x=1-4,6) value
        CCR: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x38
    reserved56: [36]u8,
    /// input selection register
    /// offset: 0x5c
    TISEL: mmio.Mmio(packed struct(u32) {
        /// (1/1 of TISEL) Selects TIM_TIx (x=1) input
        @"TISEL[0]": u4,
        padding: u28 = 0,
    }),
    /// offset: 0x60
    reserved96: [8]u8,
    /// Option register 1 Note: Check Reference Manual to parse this register content
    /// offset: 0x68
    OR: u32,
};

/// 1-channel with one complementary output timers
pub const TIM_1CH_CMP = extern struct {
    /// control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Counter enable
        CEN: u1,
        /// Update disable
        UDIS: u1,
        /// Update request source
        URS: URS,
        /// One-pulse mode enbaled
        OPM: u1,
        reserved7: u3 = 0,
        /// Auto-reload preload enable
        ARPE: u1,
        /// Clock division
        CKD: CKD,
        reserved11: u1 = 0,
        /// UIF status bit remapping enable
        UIFREMAP: u1,
        /// Dithering enable
        DITHEN: u1,
        padding: u19 = 0,
    }),
    /// control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        /// Capture/compare preloaded control
        CCPC: u1,
        reserved2: u1 = 0,
        /// Capture/compare control update selection
        CCUS: u1,
        /// Capture/compare DMA selection
        CCDS: CCDS,
        reserved8: u4 = 0,
        /// (1/1 of OIS) Output Idle state x (x=1)
        @"OIS[0]": u1,
        /// (1/1 of OISN) Output Idle state x (x=1)
        @"OISN[0]": u1,
        padding: u22 = 0,
    }),
    /// offset: 0x08
    reserved8: [4]u8,
    /// DMA/Interrupt enable register
    /// offset: 0x0c
    DIER: mmio.Mmio(packed struct(u32) {
        /// Update interrupt enable
        UIE: u1,
        /// (1/1 of CCIE) Capture/Compare x (x=1) interrupt enable
        @"CCIE[0]": u1,
        reserved5: u3 = 0,
        /// COM interrupt enable
        COMIE: u1,
        reserved7: u1 = 0,
        /// Break interrupt enable
        BIE: u1,
        /// Update DMA request enable
        UDE: u1,
        /// (1/1 of CCDE) Capture/Compare x (x=1) DMA request enable
        @"CCDE[0]": u1,
        padding: u22 = 0,
    }),
    /// status register
    /// offset: 0x10
    SR: mmio.Mmio(packed struct(u32) {
        /// Update interrupt flag
        UIF: u1,
        /// (1/1 of CCIF) Capture/compare x (x=1) interrupt flag
        @"CCIF[0]": u1,
        reserved5: u3 = 0,
        /// COM interrupt flag
        COMIF: u1,
        reserved7: u1 = 0,
        /// (1/1 of BIF) Break x (x=1) interrupt flag
        @"BIF[0]": u1,
        reserved9: u1 = 0,
        /// (1/1 of CCOF) Capture/Compare x (x=1) overcapture flag
        @"CCOF[0]": u1,
        padding: u22 = 0,
    }),
    /// event generation register
    /// offset: 0x14
    EGR: mmio.Mmio(packed struct(u32) {
        /// Update generation
        UG: u1,
        /// (1/1 of CCG) Capture/compare x (x=1) generation
        @"CCG[0]": u1,
        reserved5: u3 = 0,
        /// Capture/Compare control update generation
        COMG: u1,
        reserved7: u1 = 0,
        /// (1/1 of BG) Break x (x=1) generation
        @"BG[0]": u1,
        padding: u24 = 0,
    }),
    /// capture/compare mode register 1 (input mode)
    /// offset: 0x18
    CCMR_Input: [1]mmio.Mmio(packed struct(u32) {
        /// (1/1 of CCS) Capture/Compare y selection
        @"CCS[0]": CCMR_Input_CCS,
        /// (1/1 of ICPSC) Input capture y prescaler
        @"ICPSC[0]": u2,
        /// (1/1 of ICF) Input capture y filter
        @"ICF[0]": FilterValue,
        padding: u24 = 0,
    }),
    /// offset: 0x1c
    reserved28: [4]u8,
    /// capture/compare enable register
    /// offset: 0x20
    CCER: mmio.Mmio(packed struct(u32) {
        /// (1/1 of CCE) Capture/Compare x (x=1) output enable
        @"CCE[0]": u1,
        /// (1/1 of CCP) Capture/Compare x (x=1) output Polarity
        @"CCP[0]": u1,
        /// (1/1 of CCNE) Capture/Compare x (x=1) complementary output enable
        @"CCNE[0]": u1,
        /// (1/1 of CCNP) Capture/Compare x (x=1) output Polarity
        @"CCNP[0]": u1,
        padding: u28 = 0,
    }),
    /// counter
    /// offset: 0x24
    CNT: mmio.Mmio(packed struct(u32) {
        /// counter value
        CNT: u16,
        reserved31: u15 = 0,
        /// UIF copy
        UIFCPY: u1,
    }),
    /// prescaler
    /// offset: 0x28
    PSC: u32,
    /// auto-reload register (Dither mode disabled)
    /// offset: 0x2c
    ARR: mmio.Mmio(packed struct(u32) {
        /// Auto-reload value
        ARR: u16,
        padding: u16 = 0,
    }),
    /// repetition counter register
    /// offset: 0x30
    RCR: mmio.Mmio(packed struct(u32) {
        /// Repetition counter value
        REP: u8,
        padding: u24 = 0,
    }),
    /// capture/compare register x (x=1) (Dither mode disabled)
    /// offset: 0x34
    CCR: [1]mmio.Mmio(packed struct(u32) {
        /// capture/compare x (x=1-4,6) value
        CCR: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x38
    reserved56: [12]u8,
    /// break and dead-time register
    /// offset: 0x44
    BDTR: mmio.Mmio(packed struct(u32) {
        /// Dead-time generator setup
        DTG: u8,
        /// Lock configuration
        LOCK: LOCK,
        /// Off-state selection for Idle mode
        OSSI: OSSI,
        /// Off-state selection for Run mode
        OSSR: OSSR,
        /// (1/1 of BKE) Break x (x=1) enable
        @"BKE[0]": u1,
        /// (1/1 of BKP) Break x (x=1) polarity
        @"BKP[0]": BKP,
        /// Automatic output enable
        AOE: u1,
        /// Main output enable
        MOE: u1,
        /// (1/1 of BKF) Break x (x=1) filter
        @"BKF[0]": FilterValue,
        reserved26: u6 = 0,
        /// (1/1 of BKDSRM) Break x (x=1) Disarm
        @"BKDSRM[0]": BKDSRM,
        reserved28: u1 = 0,
        /// (1/1 of BKBID) Break x (x=1) bidirectional
        @"BKBID[0]": BKBID,
        padding: u3 = 0,
    }),
    /// offset: 0x48
    reserved72: [12]u8,
    /// break and dead-time register
    /// offset: 0x54
    DTR2: mmio.Mmio(packed struct(u32) {
        /// Dead-time falling edge generator setup
        DTGF: u8,
        reserved16: u8 = 0,
        /// Deadtime asymmetric enable
        DTAE: DTAE,
        /// Deadtime preload enable
        DTPE: u1,
        padding: u14 = 0,
    }),
    /// offset: 0x58
    reserved88: [4]u8,
    /// input selection register
    /// offset: 0x5c
    TISEL: mmio.Mmio(packed struct(u32) {
        /// (1/1 of TISEL) Selects TIM_TIx (x=1) input
        @"TISEL[0]": u4,
        padding: u28 = 0,
    }),
    /// alternate function register 1
    /// offset: 0x60
    AF1: mmio.Mmio(packed struct(u32) {
        /// TIMx_BKIN input enable
        BKINE: u1,
        /// (1/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[0]": u1,
        /// (2/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[1]": u1,
        /// (3/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[2]": u1,
        /// (4/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[3]": u1,
        /// (5/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[4]": u1,
        /// (6/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[5]": u1,
        /// (7/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[6]": u1,
        /// (8/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[7]": u1,
        /// TIMx_BKIN input polarity
        BKINP: BKINP,
        /// (1/4 of BKCMPP) TIM_BRK_CMPx (x=1-4) input polarity
        @"BKCMPP[0]": BKINP,
        /// (2/4 of BKCMPP) TIM_BRK_CMPx (x=1-4) input polarity
        @"BKCMPP[1]": BKINP,
        /// (3/4 of BKCMPP) TIM_BRK_CMPx (x=1-4) input polarity
        @"BKCMPP[2]": BKINP,
        /// (4/4 of BKCMPP) TIM_BRK_CMPx (x=1-4) input polarity
        @"BKCMPP[3]": BKINP,
        padding: u18 = 0,
    }),
    /// alternate function register 2
    /// offset: 0x64
    AF2: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// ocref_clr source selection
        OCRSEL: u3,
        padding: u13 = 0,
    }),
    /// Option register 1 Note: Check Reference Manual to parse this register content
    /// offset: 0x68
    OR: u32,
    /// offset: 0x6c
    reserved108: [880]u8,
    /// DMA control register
    /// offset: 0x3dc
    DCR: mmio.Mmio(packed struct(u32) {
        /// DMA base address
        DBA: u5,
        reserved8: u3 = 0,
        /// DMA burst length
        DBL: u5,
        reserved16: u3 = 0,
        /// DMA burst source selection
        DBSS: DBSS,
        padding: u12 = 0,
    }),
    /// DMA address for full transfer
    /// offset: 0x3e0
    DMAR: u32,
};

/// 2-channel timers
pub const TIM_2CH = extern struct {
    /// control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Counter enable
        CEN: u1,
        /// Update disable
        UDIS: u1,
        /// Update request source
        URS: URS,
        /// One-pulse mode enbaled
        OPM: u1,
        reserved7: u3 = 0,
        /// Auto-reload preload enable
        ARPE: u1,
        /// Clock division
        CKD: CKD,
        reserved11: u1 = 0,
        /// UIF status bit remapping enable
        UIFREMAP: u1,
        /// Dithering enable
        DITHEN: u1,
        padding: u19 = 0,
    }),
    /// control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// Master mode selection
        MMS: u3,
        /// TI1 selection
        TI1S: TI1S,
        reserved25: u17 = 0,
        /// Master mode selection
        MMS_CONT: u1,
        padding: u6 = 0,
    }),
    /// slave mode control register
    /// offset: 0x08
    SMCR: mmio.Mmio(packed struct(u32) {
        /// Slave mode selection
        SMS: u3,
        reserved4: u1 = 0,
        /// Trigger selection
        TS: u3,
        /// Master/Slave mode
        MSM: MSM,
        reserved16: u8 = 0,
        /// Slave mode selection
        SMS_CONT: u1,
        reserved20: u3 = 0,
        /// Trigger selection
        TS_CONT: u2,
        padding: u10 = 0,
    }),
    /// DMA/Interrupt enable register
    /// offset: 0x0c
    DIER: mmio.Mmio(packed struct(u32) {
        /// Update interrupt enable
        UIE: u1,
        /// (1/2 of CCIE) Capture/Compare x (x=1-2) interrupt enable
        @"CCIE[0]": u1,
        /// (2/2 of CCIE) Capture/Compare x (x=1-2) interrupt enable
        @"CCIE[1]": u1,
        reserved6: u3 = 0,
        /// Trigger interrupt enable
        TIE: u1,
        padding: u25 = 0,
    }),
    /// status register
    /// offset: 0x10
    SR: mmio.Mmio(packed struct(u32) {
        /// Update interrupt flag
        UIF: u1,
        /// (1/2 of CCIF) Capture/compare x (x=1-2) interrupt flag
        @"CCIF[0]": u1,
        /// (2/2 of CCIF) Capture/compare x (x=1-2) interrupt flag
        @"CCIF[1]": u1,
        reserved6: u3 = 0,
        /// Trigger interrupt flag
        TIF: u1,
        reserved9: u2 = 0,
        /// (1/2 of CCOF) Capture/Compare x (x=1-2) overcapture flag
        @"CCOF[0]": u1,
        /// (2/2 of CCOF) Capture/Compare x (x=1-2) overcapture flag
        @"CCOF[1]": u1,
        padding: u21 = 0,
    }),
    /// event generation register
    /// offset: 0x14
    EGR: mmio.Mmio(packed struct(u32) {
        /// Update generation
        UG: u1,
        /// (1/2 of CCG) Capture/compare x (x=1-2) generation
        @"CCG[0]": u1,
        /// (2/2 of CCG) Capture/compare x (x=1-2) generation
        @"CCG[1]": u1,
        reserved6: u3 = 0,
        /// Trigger generation
        TG: u1,
        padding: u25 = 0,
    }),
    /// capture/compare mode register 1 (input mode)
    /// offset: 0x18
    CCMR_Input: [1]mmio.Mmio(packed struct(u32) {
        /// (1/2 of CCS) Capture/Compare y selection
        @"CCS[0]": CCMR_Input_CCS,
        /// (1/2 of ICPSC) Input capture y prescaler
        @"ICPSC[0]": u2,
        /// (1/2 of ICF) Input capture y filter
        @"ICF[0]": FilterValue,
        /// (2/2 of CCS) Capture/Compare y selection
        @"CCS[1]": CCMR_Input_CCS,
        /// (2/2 of ICPSC) Input capture y prescaler
        @"ICPSC[1]": u2,
        /// (2/2 of ICF) Input capture y filter
        @"ICF[1]": FilterValue,
        padding: u16 = 0,
    }),
    /// offset: 0x1c
    reserved28: [4]u8,
    /// capture/compare enable register
    /// offset: 0x20
    CCER: mmio.Mmio(packed struct(u32) {
        /// (1/2 of CCE) Capture/Compare x (x=1-2) output enable
        @"CCE[0]": u1,
        /// (1/2 of CCP) Capture/Compare x (x=1-2) output Polarity
        @"CCP[0]": u1,
        reserved3: u1 = 0,
        /// (1/2 of CCNP) Capture/Compare x (x=1-2) output Polarity
        @"CCNP[0]": u1,
        /// (2/2 of CCE) Capture/Compare x (x=1-2) output enable
        @"CCE[1]": u1,
        /// (2/2 of CCP) Capture/Compare x (x=1-2) output Polarity
        @"CCP[1]": u1,
        reserved7: u1 = 0,
        /// (2/2 of CCNP) Capture/Compare x (x=1-2) output Polarity
        @"CCNP[1]": u1,
        padding: u24 = 0,
    }),
    /// counter
    /// offset: 0x24
    CNT: mmio.Mmio(packed struct(u32) {
        /// counter value
        CNT: u16,
        reserved31: u15 = 0,
        /// UIF copy
        UIFCPY: u1,
    }),
    /// prescaler
    /// offset: 0x28
    PSC: u32,
    /// auto-reload register (Dither mode disabled)
    /// offset: 0x2c
    ARR: mmio.Mmio(packed struct(u32) {
        /// Auto-reload value
        ARR: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x30
    reserved48: [4]u8,
    /// capture/compare register x (x=1-2) (Dither mode disabled)
    /// offset: 0x34
    CCR: [2]mmio.Mmio(packed struct(u32) {
        /// capture/compare x (x=1-4,6) value
        CCR: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x3c
    reserved60: [32]u8,
    /// input selection register
    /// offset: 0x5c
    TISEL: mmio.Mmio(packed struct(u32) {
        /// (1/2 of TISEL) Selects TIM_TIx (x=1-2) input
        @"TISEL[0]": u4,
        reserved8: u4 = 0,
        /// (2/2 of TISEL) Selects TIM_TIx (x=1-2) input
        @"TISEL[1]": u4,
        padding: u20 = 0,
    }),
    /// offset: 0x60
    reserved96: [8]u8,
    /// Option register 1 Note: Check Reference Manual to parse this register content
    /// offset: 0x68
    OR: u32,
};

/// 2-channel with one complementary output timers
pub const TIM_2CH_CMP = extern struct {
    /// control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Counter enable
        CEN: u1,
        /// Update disable
        UDIS: u1,
        /// Update request source
        URS: URS,
        /// One-pulse mode enbaled
        OPM: u1,
        reserved7: u3 = 0,
        /// Auto-reload preload enable
        ARPE: u1,
        /// Clock division
        CKD: CKD,
        reserved11: u1 = 0,
        /// UIF status bit remapping enable
        UIFREMAP: u1,
        /// Dithering enable
        DITHEN: u1,
        padding: u19 = 0,
    }),
    /// control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        /// Capture/compare preloaded control
        CCPC: u1,
        reserved2: u1 = 0,
        /// Capture/compare control update selection
        CCUS: u1,
        /// Capture/compare DMA selection
        CCDS: CCDS,
        /// Master mode selection
        MMS: u3,
        /// TI1 selection
        TI1S: TI1S,
        /// (1/2 of OIS) Output Idle state x (x=1,2)
        @"OIS[0]": u1,
        /// (1/1 of OISN) Output Idle state x (x=1)
        @"OISN[0]": u1,
        /// (2/2 of OIS) Output Idle state x (x=1,2)
        @"OIS[1]": u1,
        reserved25: u14 = 0,
        /// Master mode selection
        MMS_CONT: u1,
        padding: u6 = 0,
    }),
    /// slave mode control register
    /// offset: 0x08
    SMCR: mmio.Mmio(packed struct(u32) {
        /// Slave mode selection
        SMS: u3,
        reserved4: u1 = 0,
        /// Trigger selection
        TS: u3,
        /// Master/Slave mode
        MSM: MSM,
        reserved16: u8 = 0,
        /// Slave mode selection
        SMS_CONT: u1,
        reserved20: u3 = 0,
        /// Trigger selection
        TS_CONT: u2,
        reserved24: u2 = 0,
        /// SMS preload enable
        SMSPE: u1,
        padding: u7 = 0,
    }),
    /// DMA/Interrupt enable register
    /// offset: 0x0c
    DIER: mmio.Mmio(packed struct(u32) {
        /// Update interrupt enable
        UIE: u1,
        /// (1/1 of CCIE) Capture/Compare x (x=1) interrupt enable
        @"CCIE[0]": u1,
        reserved5: u3 = 0,
        /// COM interrupt enable
        COMIE: u1,
        /// Trigger interrupt enable
        TIE: u1,
        /// Break interrupt enable
        BIE: u1,
        /// Update DMA request enable
        UDE: u1,
        /// (1/1 of CCDE) Capture/Compare x (x=1) DMA request enable
        @"CCDE[0]": u1,
        reserved13: u3 = 0,
        /// COM DMA request enable
        COMDE: u1,
        /// Trigger DMA request enable
        TDE: u1,
        padding: u17 = 0,
    }),
    /// status register
    /// offset: 0x10
    SR: mmio.Mmio(packed struct(u32) {
        /// Update interrupt flag
        UIF: u1,
        /// (1/2 of CCIF) Capture/compare x (x=1,2) interrupt flag
        @"CCIF[0]": u1,
        /// (2/2 of CCIF) Capture/compare x (x=1,2) interrupt flag
        @"CCIF[1]": u1,
        reserved5: u2 = 0,
        /// COM interrupt flag
        COMIF: u1,
        /// Trigger interrupt flag
        TIF: u1,
        /// (1/1 of BIF) Break x (x=1) interrupt flag
        @"BIF[0]": u1,
        reserved9: u1 = 0,
        /// (1/2 of CCOF) Capture/Compare x (x=1,2) overcapture flag
        @"CCOF[0]": u1,
        /// (2/2 of CCOF) Capture/Compare x (x=1,2) overcapture flag
        @"CCOF[1]": u1,
        padding: u21 = 0,
    }),
    /// event generation register
    /// offset: 0x14
    EGR: mmio.Mmio(packed struct(u32) {
        /// Update generation
        UG: u1,
        /// (1/2 of CCG) Capture/compare x (x=1,2) generation
        @"CCG[0]": u1,
        /// (2/2 of CCG) Capture/compare x (x=1,2) generation
        @"CCG[1]": u1,
        reserved5: u2 = 0,
        /// Capture/Compare control update generation
        COMG: u1,
        /// Trigger generation
        TG: u1,
        /// (1/1 of BG) Break x (x=1) generation
        @"BG[0]": u1,
        padding: u24 = 0,
    }),
    /// capture/compare mode register 1 (input mode)
    /// offset: 0x18
    CCMR_Input: [2]mmio.Mmio(packed struct(u32) {
        /// (1/1 of CCS) Capture/Compare y selection
        @"CCS[0]": CCMR_Input_CCS,
        /// (1/1 of ICPSC) Input capture y prescaler
        @"ICPSC[0]": u2,
        /// (1/1 of ICF) Input capture y filter
        @"ICF[0]": FilterValue,
        padding: u24 = 0,
    }),
    /// capture/compare enable register
    /// offset: 0x20
    CCER: mmio.Mmio(packed struct(u32) {
        /// (1/2 of CCE) Capture/Compare x (x=1-2) output enable
        @"CCE[0]": u1,
        /// (1/2 of CCP) Capture/Compare x (x=1-2) output Polarity
        @"CCP[0]": u1,
        /// (1/1 of CCNE) Capture/Compare x (x=1) complementary output enable
        @"CCNE[0]": u1,
        /// (1/2 of CCNP) Capture/Compare x (x=1-2) output Polarity
        @"CCNP[0]": u1,
        /// (2/2 of CCE) Capture/Compare x (x=1-2) output enable
        @"CCE[1]": u1,
        /// (2/2 of CCP) Capture/Compare x (x=1-2) output Polarity
        @"CCP[1]": u1,
        reserved7: u1 = 0,
        /// (2/2 of CCNP) Capture/Compare x (x=1-2) output Polarity
        @"CCNP[1]": u1,
        padding: u24 = 0,
    }),
    /// counter
    /// offset: 0x24
    CNT: mmio.Mmio(packed struct(u32) {
        /// counter value
        CNT: u16,
        reserved31: u15 = 0,
        /// UIF copy
        UIFCPY: u1,
    }),
    /// prescaler
    /// offset: 0x28
    PSC: u32,
    /// auto-reload register (Dither mode disabled)
    /// offset: 0x2c
    ARR: mmio.Mmio(packed struct(u32) {
        /// Auto-reload value
        ARR: u16,
        padding: u16 = 0,
    }),
    /// repetition counter register
    /// offset: 0x30
    RCR: mmio.Mmio(packed struct(u32) {
        /// Repetition counter value
        REP: u8,
        padding: u24 = 0,
    }),
    /// capture/compare register x (x=1-2)
    /// offset: 0x34
    CCR: [2]mmio.Mmio(packed struct(u32) {
        /// capture/compare x (x=1-4,6) value
        CCR: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x3c
    reserved60: [8]u8,
    /// break and dead-time register
    /// offset: 0x44
    BDTR: mmio.Mmio(packed struct(u32) {
        /// Dead-time generator setup
        DTG: u8,
        /// Lock configuration
        LOCK: LOCK,
        /// Off-state selection for Idle mode
        OSSI: OSSI,
        /// Off-state selection for Run mode
        OSSR: OSSR,
        /// (1/1 of BKE) Break x (x=1) enable
        @"BKE[0]": u1,
        /// (1/1 of BKP) Break x (x=1) polarity
        @"BKP[0]": BKP,
        /// Automatic output enable
        AOE: u1,
        /// Main output enable
        MOE: u1,
        /// (1/1 of BKF) Break x (x=1) filter
        @"BKF[0]": FilterValue,
        reserved26: u6 = 0,
        /// (1/1 of BKDSRM) Break x (x=1) Disarm
        @"BKDSRM[0]": BKDSRM,
        reserved28: u1 = 0,
        /// (1/1 of BKBID) Break x (x=1) bidirectional
        @"BKBID[0]": BKBID,
        padding: u3 = 0,
    }),
    /// offset: 0x48
    reserved72: [12]u8,
    /// break and dead-time register
    /// offset: 0x54
    DTR2: mmio.Mmio(packed struct(u32) {
        /// Dead-time falling edge generator setup
        DTGF: u8,
        reserved16: u8 = 0,
        /// Deadtime asymmetric enable
        DTAE: DTAE,
        /// Deadtime preload enable
        DTPE: u1,
        padding: u14 = 0,
    }),
    /// offset: 0x58
    reserved88: [4]u8,
    /// input selection register
    /// offset: 0x5c
    TISEL: mmio.Mmio(packed struct(u32) {
        /// (1/2 of TISEL) Selects TIM_TIx (x=1-2) input
        @"TISEL[0]": u4,
        reserved8: u4 = 0,
        /// (2/2 of TISEL) Selects TIM_TIx (x=1-2) input
        @"TISEL[1]": u4,
        padding: u20 = 0,
    }),
    /// alternate function register 1
    /// offset: 0x60
    AF1: mmio.Mmio(packed struct(u32) {
        /// TIMx_BKIN input enable
        BKINE: u1,
        /// (1/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[0]": u1,
        /// (2/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[1]": u1,
        /// (3/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[2]": u1,
        /// (4/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[3]": u1,
        /// (5/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[4]": u1,
        /// (6/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[5]": u1,
        /// (7/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[6]": u1,
        /// (8/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[7]": u1,
        /// TIMx_BKIN input polarity
        BKINP: BKINP,
        /// (1/4 of BKCMPP) TIM_BRK_CMPx (x=1-4) input polarity
        @"BKCMPP[0]": BKINP,
        /// (2/4 of BKCMPP) TIM_BRK_CMPx (x=1-4) input polarity
        @"BKCMPP[1]": BKINP,
        /// (3/4 of BKCMPP) TIM_BRK_CMPx (x=1-4) input polarity
        @"BKCMPP[2]": BKINP,
        /// (4/4 of BKCMPP) TIM_BRK_CMPx (x=1-4) input polarity
        @"BKCMPP[3]": BKINP,
        padding: u18 = 0,
    }),
    /// alternate function register 2
    /// offset: 0x64
    AF2: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// ocref_clr source selection
        OCRSEL: u3,
        padding: u13 = 0,
    }),
    /// Option register 1 Note: Check Reference Manual to parse this register content
    /// offset: 0x68
    OR: u32,
    /// offset: 0x6c
    reserved108: [880]u8,
    /// DMA control register
    /// offset: 0x3dc
    DCR: mmio.Mmio(packed struct(u32) {
        /// DMA base address
        DBA: u5,
        reserved8: u3 = 0,
        /// DMA burst length
        DBL: u5,
        reserved16: u3 = 0,
        /// DMA burst source selection
        DBSS: DBSS,
        padding: u12 = 0,
    }),
    /// DMA address for full transfer
    /// offset: 0x3e0
    DMAR: u32,
};

/// Advanced Control timers
pub const TIM_ADV = extern struct {
    /// control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Counter enable
        CEN: u1,
        /// Update disable
        UDIS: u1,
        /// Update request source
        URS: URS,
        /// One-pulse mode enbaled
        OPM: u1,
        /// Direction
        DIR: DIR,
        /// Center-aligned mode selection
        CMS: CMS,
        /// Auto-reload preload enable
        ARPE: u1,
        /// Clock division
        CKD: CKD,
        reserved11: u1 = 0,
        /// UIF status bit remapping enable
        UIFREMAP: u1,
        /// Dithering enable
        DITHEN: u1,
        padding: u19 = 0,
    }),
    /// control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        /// Capture/compare preloaded control
        CCPC: u1,
        reserved2: u1 = 0,
        /// Capture/compare control update selection
        CCUS: u1,
        /// Capture/compare DMA selection
        CCDS: CCDS,
        /// Master mode selection
        MMS: u3,
        /// TI1 selection
        TI1S: TI1S,
        /// (1/6 of OIS) Output Idle state x (x=1-6)
        @"OIS[0]": u1,
        /// (1/4 of OISN) Output Idle state x N x (x=1-4)
        @"OISN[0]": u1,
        /// (2/6 of OIS) Output Idle state x (x=1-6)
        @"OIS[1]": u1,
        /// (2/4 of OISN) Output Idle state x N x (x=1-4)
        @"OISN[1]": u1,
        /// (3/6 of OIS) Output Idle state x (x=1-6)
        @"OIS[2]": u1,
        /// (3/4 of OISN) Output Idle state x N x (x=1-4)
        @"OISN[2]": u1,
        /// (4/6 of OIS) Output Idle state x (x=1-6)
        @"OIS[3]": u1,
        /// (4/4 of OISN) Output Idle state x N x (x=1-4)
        @"OISN[3]": u1,
        /// (5/6 of OIS) Output Idle state x (x=1-6)
        @"OIS[4]": u1,
        reserved18: u1 = 0,
        /// (6/6 of OIS) Output Idle state x (x=1-6)
        @"OIS[5]": u1,
        reserved20: u1 = 0,
        /// Master mode selection 2
        MMS2: MMS2,
        reserved25: u1 = 0,
        /// Master mode selection
        MMS_CONT: u1,
        padding: u6 = 0,
    }),
    /// slave mode control register
    /// offset: 0x08
    SMCR: mmio.Mmio(packed struct(u32) {
        /// Slave mode selection
        SMS: u3,
        /// OCREF clear selection
        OCCS: OCCS,
        /// Trigger selection
        TS: u3,
        /// Master/Slave mode
        MSM: MSM,
        /// External trigger filter
        ETF: FilterValue,
        /// External trigger prescaler
        ETPS: ETPS,
        /// External clock mode 2 enable
        ECE: u1,
        /// External trigger polarity
        ETP: ETP,
        /// Slave mode selection
        SMS_CONT: u1,
        reserved20: u3 = 0,
        /// Trigger selection
        TS_CONT: u2,
        reserved24: u2 = 0,
        /// SMS preload enable
        SMSPE: u1,
        /// SMS preload source
        SMSPS: SMSPS,
        padding: u6 = 0,
    }),
    /// DMA/Interrupt enable register
    /// offset: 0x0c
    DIER: mmio.Mmio(packed struct(u32) {
        /// Update interrupt enable
        UIE: u1,
        /// (1/4 of CCIE) Capture/Compare x (x=1-4) interrupt enable
        @"CCIE[0]": u1,
        /// (2/4 of CCIE) Capture/Compare x (x=1-4) interrupt enable
        @"CCIE[1]": u1,
        /// (3/4 of CCIE) Capture/Compare x (x=1-4) interrupt enable
        @"CCIE[2]": u1,
        /// (4/4 of CCIE) Capture/Compare x (x=1-4) interrupt enable
        @"CCIE[3]": u1,
        /// COM interrupt enable
        COMIE: u1,
        /// Trigger interrupt enable
        TIE: u1,
        /// Break interrupt enable
        BIE: u1,
        /// Update DMA request enable
        UDE: u1,
        /// (1/4 of CCDE) Capture/Compare x (x=1) DMA request enable
        @"CCDE[0]": u1,
        /// (2/4 of CCDE) Capture/Compare x (x=1) DMA request enable
        @"CCDE[1]": u1,
        /// (3/4 of CCDE) Capture/Compare x (x=1) DMA request enable
        @"CCDE[2]": u1,
        /// (4/4 of CCDE) Capture/Compare x (x=1) DMA request enable
        @"CCDE[3]": u1,
        /// COM DMA request enable
        COMDE: u1,
        /// Trigger DMA request enable
        TDE: u1,
        reserved20: u5 = 0,
        /// Index interrupt enable
        IDXIE: u1,
        /// Direction change interrupt enable
        DIRIE: u1,
        /// Index error interrupt enable
        IERRIE: u1,
        /// Transition error interrupt enable
        TERRIE: u1,
        padding: u8 = 0,
    }),
    /// status register
    /// offset: 0x10
    SR: mmio.Mmio(packed struct(u32) {
        /// Update interrupt flag
        UIF: u1,
        /// (1/4 of CCIF) Capture/compare x (x=1-4) interrupt flag
        @"CCIF[0]": u1,
        /// (2/4 of CCIF) Capture/compare x (x=1-4) interrupt flag
        @"CCIF[1]": u1,
        /// (3/4 of CCIF) Capture/compare x (x=1-4) interrupt flag
        @"CCIF[2]": u1,
        /// (4/4 of CCIF) Capture/compare x (x=1-4) interrupt flag
        @"CCIF[3]": u1,
        /// COM interrupt flag
        COMIF: u1,
        /// Trigger interrupt flag
        TIF: u1,
        /// (1/2 of BIF) Break x (x=1,2) interrupt flag
        @"BIF[0]": u1,
        /// (2/2 of BIF) Break x (x=1,2) interrupt flag
        @"BIF[1]": u1,
        /// (1/4 of CCOF) Capture/Compare x (x=1-4) overcapture flag
        @"CCOF[0]": u1,
        /// (2/4 of CCOF) Capture/Compare x (x=1-4) overcapture flag
        @"CCOF[1]": u1,
        /// (3/4 of CCOF) Capture/Compare x (x=1-4) overcapture flag
        @"CCOF[2]": u1,
        /// (4/4 of CCOF) Capture/Compare x (x=1-4) overcapture flag
        @"CCOF[3]": u1,
        /// System break interrupt flag
        SBIF: u1,
        reserved16: u2 = 0,
        /// Capture/compare 5 interrupt flag
        CCIF5: u1,
        /// Capture/compare 6 interrupt flag
        CCIF6: u1,
        reserved20: u2 = 0,
        /// Index interrupt flag
        IDXIF: u1,
        /// Direction change interrupt flag
        DIRIF: u1,
        /// Index error interrupt flag
        IERRIF: u1,
        /// Transition error interrupt flag
        TERRIF: u1,
        padding: u8 = 0,
    }),
    /// event generation register
    /// offset: 0x14
    EGR: mmio.Mmio(packed struct(u32) {
        /// Update generation
        UG: u1,
        /// (1/4 of CCG) Capture/compare x (x=1-4) generation
        @"CCG[0]": u1,
        /// (2/4 of CCG) Capture/compare x (x=1-4) generation
        @"CCG[1]": u1,
        /// (3/4 of CCG) Capture/compare x (x=1-4) generation
        @"CCG[2]": u1,
        /// (4/4 of CCG) Capture/compare x (x=1-4) generation
        @"CCG[3]": u1,
        /// Capture/Compare control update generation
        COMG: u1,
        /// Trigger generation
        TG: u1,
        /// (1/2 of BG) Break x (x=1-2) generation
        @"BG[0]": u1,
        /// (2/2 of BG) Break x (x=1-2) generation
        @"BG[1]": u1,
        padding: u23 = 0,
    }),
    /// capture/compare mode register 1-2 (input mode)
    /// offset: 0x18
    CCMR_Input: [2]mmio.Mmio(packed struct(u32) {
        /// (1/2 of CCS) Capture/Compare y selection
        @"CCS[0]": CCMR_Input_CCS,
        /// (1/2 of ICPSC) Input capture y prescaler
        @"ICPSC[0]": u2,
        /// (1/2 of ICF) Input capture y filter
        @"ICF[0]": FilterValue,
        /// (2/2 of CCS) Capture/Compare y selection
        @"CCS[1]": CCMR_Input_CCS,
        /// (2/2 of ICPSC) Input capture y prescaler
        @"ICPSC[1]": u2,
        /// (2/2 of ICF) Input capture y filter
        @"ICF[1]": FilterValue,
        padding: u16 = 0,
    }),
    /// capture/compare enable register
    /// offset: 0x20
    CCER: mmio.Mmio(packed struct(u32) {
        /// (1/6 of CCE) Capture/Compare x (x=1-6) output enable
        @"CCE[0]": u1,
        /// (1/6 of CCP) Capture/Compare x (x=1-6) output Polarity
        @"CCP[0]": u1,
        /// (1/4 of CCNE) Capture/Compare x (x=1-4) complementary output enable
        @"CCNE[0]": u1,
        /// (1/4 of CCNP) Capture/Compare x (x=1-4) output Polarity
        @"CCNP[0]": u1,
        /// (2/6 of CCE) Capture/Compare x (x=1-6) output enable
        @"CCE[1]": u1,
        /// (2/6 of CCP) Capture/Compare x (x=1-6) output Polarity
        @"CCP[1]": u1,
        /// (2/4 of CCNE) Capture/Compare x (x=1-4) complementary output enable
        @"CCNE[1]": u1,
        /// (2/4 of CCNP) Capture/Compare x (x=1-4) output Polarity
        @"CCNP[1]": u1,
        /// (3/6 of CCE) Capture/Compare x (x=1-6) output enable
        @"CCE[2]": u1,
        /// (3/6 of CCP) Capture/Compare x (x=1-6) output Polarity
        @"CCP[2]": u1,
        /// (3/4 of CCNE) Capture/Compare x (x=1-4) complementary output enable
        @"CCNE[2]": u1,
        /// (3/4 of CCNP) Capture/Compare x (x=1-4) output Polarity
        @"CCNP[2]": u1,
        /// (4/6 of CCE) Capture/Compare x (x=1-6) output enable
        @"CCE[3]": u1,
        /// (4/6 of CCP) Capture/Compare x (x=1-6) output Polarity
        @"CCP[3]": u1,
        /// (4/4 of CCNE) Capture/Compare x (x=1-4) complementary output enable
        @"CCNE[3]": u1,
        /// (4/4 of CCNP) Capture/Compare x (x=1-4) output Polarity
        @"CCNP[3]": u1,
        /// (5/6 of CCE) Capture/Compare x (x=1-6) output enable
        @"CCE[4]": u1,
        /// (5/6 of CCP) Capture/Compare x (x=1-6) output Polarity
        @"CCP[4]": u1,
        reserved20: u2 = 0,
        /// (6/6 of CCE) Capture/Compare x (x=1-6) output enable
        @"CCE[5]": u1,
        /// (6/6 of CCP) Capture/Compare x (x=1-6) output Polarity
        @"CCP[5]": u1,
        padding: u10 = 0,
    }),
    /// counter
    /// offset: 0x24
    CNT: mmio.Mmio(packed struct(u32) {
        /// counter value
        CNT: u16,
        reserved31: u15 = 0,
        /// UIF copy
        UIFCPY: u1,
    }),
    /// prescaler
    /// offset: 0x28
    PSC: u32,
    /// auto-reload register (Dither mode disabled)
    /// offset: 0x2c
    ARR: mmio.Mmio(packed struct(u32) {
        /// Auto-reload value
        ARR: u16,
        padding: u16 = 0,
    }),
    /// repetition counter register
    /// offset: 0x30
    RCR: mmio.Mmio(packed struct(u32) {
        /// Repetition counter value
        REP: u16,
        padding: u16 = 0,
    }),
    /// capture/compare register x (x=1-2) (Dither mode enabled)
    /// offset: 0x34
    CCR_DITHER: [2]mmio.Mmio(packed struct(u32) {
        /// capture/compare x (x=1-4,6) value
        DITHER: u4,
        /// capture/compare x (x=1-4,6) value
        CCR: u16,
        padding: u12 = 0,
    }),
    /// offset: 0x3c
    reserved60: [8]u8,
    /// break and dead-time register
    /// offset: 0x44
    BDTR: mmio.Mmio(packed struct(u32) {
        /// Dead-time generator setup
        DTG: u8,
        /// Lock configuration
        LOCK: LOCK,
        /// Off-state selection for Idle mode
        OSSI: OSSI,
        /// Off-state selection for Run mode
        OSSR: OSSR,
        /// (1/2 of BKE) Break x (x=1,2) enable
        @"BKE[0]": u1,
        /// (1/2 of BKP) Break x (x=1,2) polarity
        @"BKP[0]": BKP,
        /// Automatic output enable
        AOE: u1,
        /// Main output enable
        MOE: u1,
        /// (1/2 of BKF) Break x (x=1,2) filter
        @"BKF[0]": FilterValue,
        /// (2/2 of BKF) Break x (x=1,2) filter
        @"BKF[1]": FilterValue,
        /// (2/2 of BKE) Break x (x=1,2) enable
        @"BKE[1]": u1,
        /// (2/2 of BKP) Break x (x=1,2) polarity
        @"BKP[1]": BKP,
        /// (1/2 of BKDSRM) Break x (x=1,2) Disarm
        @"BKDSRM[0]": BKDSRM,
        /// (2/2 of BKDSRM) Break x (x=1,2) Disarm
        @"BKDSRM[1]": BKDSRM,
        /// (1/2 of BKBID) Break x (x=1,2) bidirectional
        @"BKBID[0]": BKBID,
        /// (2/2 of BKBID) Break x (x=1,2) bidirectional
        @"BKBID[1]": BKBID,
        padding: u2 = 0,
    }),
    /// capture/compare register 5 (Dither mode disabled)
    /// offset: 0x48
    CCR5: mmio.Mmio(packed struct(u32) {
        /// capture/compare x (x=1-4,6) value
        CCR: u16,
        reserved29: u13 = 0,
        /// (1/3 of GC5C) Group channel 5 and channel x (x=1-3)
        @"GC5C[0]": GC5C,
        /// (2/3 of GC5C) Group channel 5 and channel x (x=1-3)
        @"GC5C[1]": GC5C,
        /// (3/3 of GC5C) Group channel 5 and channel x (x=1-3)
        @"GC5C[2]": GC5C,
    }),
    /// capture/compare register 6 (Dither mode disabled)
    /// offset: 0x4c
    CCR6: mmio.Mmio(packed struct(u32) {
        /// capture/compare x (x=1-4,6) value
        CCR: u16,
        padding: u16 = 0,
    }),
    /// capture/compare mode register 3
    /// offset: 0x50
    CCMR3: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// (1/2 of OCFE) Output compare x (x=5,6) fast enable
        @"OCFE[0]": u1,
        /// (1/2 of OCPE) Output compare x (x=5,6) preload enable
        @"OCPE[0]": u1,
        /// (1/2 of OCM) Output compare x (x=5,6) mode
        @"OCM[0]": u3,
        /// (1/2 of OCCE) Output compare x (x=5,6) clear enable
        @"OCCE[0]": u1,
        reserved10: u2 = 0,
        /// (2/2 of OCFE) Output compare x (x=5,6) fast enable
        @"OCFE[1]": u1,
        /// (2/2 of OCPE) Output compare x (x=5,6) preload enable
        @"OCPE[1]": u1,
        /// (2/2 of OCM) Output compare x (x=5,6) mode
        @"OCM[1]": u3,
        /// (2/2 of OCCE) Output compare x (x=5,6) clear enable
        @"OCCE[1]": u1,
        /// (1/2 of OCM_CONT) Output compare x (x=5,6) mode
        @"OCM_CONT[0]": u1,
        reserved24: u7 = 0,
        /// (2/2 of OCM_CONT) Output compare x (x=5,6) mode
        @"OCM_CONT[1]": u1,
        padding: u7 = 0,
    }),
    /// break and dead-time register
    /// offset: 0x54
    DTR2: mmio.Mmio(packed struct(u32) {
        /// Dead-time falling edge generator setup
        DTGF: u8,
        reserved16: u8 = 0,
        /// Deadtime asymmetric enable
        DTAE: DTAE,
        /// Deadtime preload enable
        DTPE: u1,
        padding: u14 = 0,
    }),
    /// encoder control register
    /// offset: 0x58
    ECR: mmio.Mmio(packed struct(u32) {
        /// Index enable
        IE: u1,
        /// Index direction
        IDIR: IDIR,
        /// Index blanking
        IBLK: IBLK,
        /// First index
        FIDX: FIDX,
        /// Index positioning
        IPOS: u2,
        reserved16: u8 = 0,
        /// Pulse width
        PW: u8,
        /// Pulse width prescaler
        PWPRSC: u2,
        padding: u6 = 0,
    }),
    /// input selection register
    /// offset: 0x5c
    TISEL: mmio.Mmio(packed struct(u32) {
        /// (1/4 of TISEL) Selects TIM_TIx (x=1-4) input
        @"TISEL[0]": u4,
        reserved8: u4 = 0,
        /// (2/4 of TISEL) Selects TIM_TIx (x=1-4) input
        @"TISEL[1]": u4,
        reserved16: u4 = 0,
        /// (3/4 of TISEL) Selects TIM_TIx (x=1-4) input
        @"TISEL[2]": u4,
        reserved24: u4 = 0,
        /// (4/4 of TISEL) Selects TIM_TIx (x=1-4) input
        @"TISEL[3]": u4,
        padding: u4 = 0,
    }),
    /// alternate function register 1
    /// offset: 0x60
    AF1: mmio.Mmio(packed struct(u32) {
        /// TIMx_BKIN input enable
        BKINE: u1,
        /// (1/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[0]": u1,
        /// (2/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[1]": u1,
        /// (3/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[2]": u1,
        /// (4/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[3]": u1,
        /// (5/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[4]": u1,
        /// (6/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[5]": u1,
        /// (7/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[6]": u1,
        /// (8/8 of BKCMPE) TIM_BRK_CMPx (x=1-8) enable
        @"BKCMPE[7]": u1,
        /// TIMx_BKIN input polarity
        BKINP: BKINP,
        /// (1/4 of BKCMPP) TIM_BRK_CMPx (x=1-4) input polarity
        @"BKCMPP[0]": BKINP,
        /// (2/4 of BKCMPP) TIM_BRK_CMPx (x=1-4) input polarity
        @"BKCMPP[1]": BKINP,
        /// (3/4 of BKCMPP) TIM_BRK_CMPx (x=1-4) input polarity
        @"BKCMPP[2]": BKINP,
        /// (4/4 of BKCMPP) TIM_BRK_CMPx (x=1-4) input polarity
        @"BKCMPP[3]": BKINP,
        /// etr_in source selection
        ETRSEL: u4,
        padding: u14 = 0,
    }),
    /// alternate function register 2
    /// offset: 0x64
    AF2: mmio.Mmio(packed struct(u32) {
        /// TIMx_BKIN2 input enable
        BK2INE: u1,
        /// (1/8 of BK2CMPE) TIM_BRK2_CMPx (x=1-8) enable
        @"BK2CMPE[0]": u1,
        /// (2/8 of BK2CMPE) TIM_BRK2_CMPx (x=1-8) enable
        @"BK2CMPE[1]": u1,
        /// (3/8 of BK2CMPE) TIM_BRK2_CMPx (x=1-8) enable
        @"BK2CMPE[2]": u1,
        /// (4/8 of BK2CMPE) TIM_BRK2_CMPx (x=1-8) enable
        @"BK2CMPE[3]": u1,
        /// (5/8 of BK2CMPE) TIM_BRK2_CMPx (x=1-8) enable
        @"BK2CMPE[4]": u1,
        /// (6/8 of BK2CMPE) TIM_BRK2_CMPx (x=1-8) enable
        @"BK2CMPE[5]": u1,
        /// (7/8 of BK2CMPE) TIM_BRK2_CMPx (x=1-8) enable
        @"BK2CMPE[6]": u1,
        /// (8/8 of BK2CMPE) TIM_BRK2_CMPx (x=1-8) enable
        @"BK2CMPE[7]": u1,
        /// TIMx_BK2IN input polarity
        BK2INP: BKINP,
        /// (1/4 of BK2CMPP) TIM_BRK2_CMPx (x=1-4) input polarity
        @"BK2CMPP[0]": BKINP,
        /// (2/4 of BK2CMPP) TIM_BRK2_CMPx (x=1-4) input polarity
        @"BK2CMPP[1]": BKINP,
        /// (3/4 of BK2CMPP) TIM_BRK2_CMPx (x=1-4) input polarity
        @"BK2CMPP[2]": BKINP,
        /// (4/4 of BK2CMPP) TIM_BRK2_CMPx (x=1-4) input polarity
        @"BK2CMPP[3]": BKINP,
        reserved16: u2 = 0,
        /// ocref_clr source selection
        OCRSEL: u3,
        padding: u13 = 0,
    }),
    /// Option register 1 Note: Check Reference Manual to parse this register content
    /// offset: 0x68
    OR: u32,
    /// offset: 0x6c
    reserved108: [880]u8,
    /// DMA control register
    /// offset: 0x3dc
    DCR: mmio.Mmio(packed struct(u32) {
        /// DMA base address
        DBA: u5,
        reserved8: u3 = 0,
        /// DMA burst length
        DBL: u5,
        reserved16: u3 = 0,
        /// DMA burst source selection
        DBSS: DBSS,
        padding: u12 = 0,
    }),
    /// DMA address for full transfer
    /// offset: 0x3e0
    DMAR: u32,
};

/// Basic timers
pub const TIM_BASIC = extern struct {
    /// control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Counter enable
        CEN: u1,
        /// Update disable
        UDIS: u1,
        /// Update request source
        URS: URS,
        /// One-pulse mode enbaled
        OPM: u1,
        reserved7: u3 = 0,
        /// Auto-reload preload enable
        ARPE: u1,
        reserved11: u3 = 0,
        /// UIF status bit remapping enable
        UIFREMAP: u1,
        /// Dithering enable
        DITHEN: u1,
        padding: u19 = 0,
    }),
    /// control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// Master mode selection
        MMS: u3,
        reserved25: u18 = 0,
        /// Master mode selection
        MMS_CONT: u1,
        padding: u6 = 0,
    }),
    /// offset: 0x08
    reserved8: [4]u8,
    /// DMA/Interrupt enable register
    /// offset: 0x0c
    DIER: mmio.Mmio(packed struct(u32) {
        /// Update interrupt enable
        UIE: u1,
        reserved8: u7 = 0,
        /// Update DMA request enable
        UDE: u1,
        padding: u23 = 0,
    }),
    /// status register
    /// offset: 0x10
    SR: mmio.Mmio(packed struct(u32) {
        /// Update interrupt flag
        UIF: u1,
        padding: u31 = 0,
    }),
    /// event generation register
    /// offset: 0x14
    EGR: mmio.Mmio(packed struct(u32) {
        /// Update generation
        UG: u1,
        padding: u31 = 0,
    }),
    /// offset: 0x18
    reserved24: [12]u8,
    /// counter
    /// offset: 0x24
    CNT: mmio.Mmio(packed struct(u32) {
        /// counter value
        CNT: u16,
        reserved31: u15 = 0,
        /// UIF copy
        UIFCPY: u1,
    }),
    /// prescaler
    /// offset: 0x28
    PSC: u32,
    /// auto-reload register (Dither mode disabled)
    /// offset: 0x2c
    ARR: mmio.Mmio(packed struct(u32) {
        /// Auto-reload value
        ARR: u16,
        padding: u16 = 0,
    }),
};

/// Virtual Basic timers without CR2 register for common part of TIM_BASIC and TIM_1CH_CMP
pub const TIM_BASIC_NO_CR2 = extern struct {
    /// control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Counter enable
        CEN: u1,
        /// Update disable
        UDIS: u1,
        /// Update request source
        URS: URS,
        /// One-pulse mode enbaled
        OPM: u1,
        reserved7: u3 = 0,
        /// Auto-reload preload enable
        ARPE: u1,
        reserved11: u3 = 0,
        /// UIF status bit remapping enable
        UIFREMAP: u1,
        /// Dithering enable
        DITHEN: u1,
        padding: u19 = 0,
    }),
    /// offset: 0x04
    reserved4: [8]u8,
    /// DMA/Interrupt enable register
    /// offset: 0x0c
    DIER: mmio.Mmio(packed struct(u32) {
        /// Update interrupt enable
        UIE: u1,
        reserved8: u7 = 0,
        /// Update DMA request enable
        UDE: u1,
        padding: u23 = 0,
    }),
    /// status register
    /// offset: 0x10
    SR: mmio.Mmio(packed struct(u32) {
        /// Update interrupt flag
        UIF: u1,
        padding: u31 = 0,
    }),
    /// event generation register
    /// offset: 0x14
    EGR: mmio.Mmio(packed struct(u32) {
        /// Update generation
        UG: u1,
        padding: u31 = 0,
    }),
    /// offset: 0x18
    reserved24: [12]u8,
    /// counter
    /// offset: 0x24
    CNT: mmio.Mmio(packed struct(u32) {
        /// counter value
        CNT: u16,
        reserved31: u15 = 0,
        /// UIF copy
        UIFCPY: u1,
    }),
    /// prescaler
    /// offset: 0x28
    PSC: u32,
    /// auto-reload register (Dither mode disabled)
    /// offset: 0x2c
    ARR: mmio.Mmio(packed struct(u32) {
        /// Auto-reload value
        ARR: u16,
        padding: u16 = 0,
    }),
};

/// Virtual timer for common part of TIM_BASIC and TIM_1CH
pub const TIM_CORE = extern struct {
    /// control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Counter enable
        CEN: u1,
        /// Update disable
        UDIS: u1,
        /// Update request source
        URS: URS,
        /// One-pulse mode enbaled
        OPM: u1,
        reserved7: u3 = 0,
        /// Auto-reload preload enable
        ARPE: u1,
        reserved11: u3 = 0,
        /// UIF status bit remapping enable
        UIFREMAP: u1,
        /// Dithering enable
        DITHEN: u1,
        padding: u19 = 0,
    }),
    /// offset: 0x04
    reserved4: [8]u8,
    /// DMA/Interrupt enable register
    /// offset: 0x0c
    DIER: mmio.Mmio(packed struct(u32) {
        /// Update interrupt enable
        UIE: u1,
        padding: u31 = 0,
    }),
    /// status register
    /// offset: 0x10
    SR: mmio.Mmio(packed struct(u32) {
        /// Update interrupt flag
        UIF: u1,
        padding: u31 = 0,
    }),
    /// event generation register
    /// offset: 0x14
    EGR: mmio.Mmio(packed struct(u32) {
        /// Update generation
        UG: u1,
        padding: u31 = 0,
    }),
    /// offset: 0x18
    reserved24: [12]u8,
    /// counter
    /// offset: 0x24
    CNT: mmio.Mmio(packed struct(u32) {
        /// counter value
        CNT: u16,
        reserved31: u15 = 0,
        /// UIF copy
        UIFCPY: u1,
    }),
    /// prescaler
    /// offset: 0x28
    PSC: u32,
    /// auto-reload register (Dither mode disabled)
    /// offset: 0x2c
    ARR: mmio.Mmio(packed struct(u32) {
        /// Auto-reload value
        ARR: u16,
        padding: u16 = 0,
    }),
};

/// General purpose 16-bit timers
pub const TIM_GP16 = extern struct {
    /// control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Counter enable
        CEN: u1,
        /// Update disable
        UDIS: u1,
        /// Update request source
        URS: URS,
        /// One-pulse mode enbaled
        OPM: u1,
        /// Direction
        DIR: DIR,
        /// Center-aligned mode selection
        CMS: CMS,
        /// Auto-reload preload enable
        ARPE: u1,
        /// Clock division
        CKD: CKD,
        reserved11: u1 = 0,
        /// UIF status bit remapping enable
        UIFREMAP: u1,
        /// Dithering enable
        DITHEN: u1,
        padding: u19 = 0,
    }),
    /// control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// Capture/compare DMA selection
        CCDS: CCDS,
        /// Master mode selection
        MMS: u3,
        /// TI1 selection
        TI1S: TI1S,
        reserved25: u17 = 0,
        /// Master mode selection
        MMS_CONT: u1,
        padding: u6 = 0,
    }),
    /// slave mode control register
    /// offset: 0x08
    SMCR: mmio.Mmio(packed struct(u32) {
        /// Slave mode selection
        SMS: u3,
        reserved4: u1 = 0,
        /// Trigger selection
        TS: u3,
        /// Master/Slave mode
        MSM: MSM,
        /// External trigger filter
        ETF: FilterValue,
        /// External trigger prescaler
        ETPS: ETPS,
        /// External clock mode 2 enable
        ECE: u1,
        /// External trigger polarity
        ETP: ETP,
        /// Slave mode selection
        SMS_CONT: u1,
        reserved20: u3 = 0,
        /// Trigger selection
        TS_CONT: u2,
        reserved24: u2 = 0,
        /// SMS preload enable
        SMSPE: u1,
        /// SMS preload source
        SMSPS: SMSPS,
        padding: u6 = 0,
    }),
    /// DMA/Interrupt enable register
    /// offset: 0x0c
    DIER: mmio.Mmio(packed struct(u32) {
        /// Update interrupt enable
        UIE: u1,
        /// (1/4 of CCIE) Capture/Compare x (x=1-4) interrupt enable
        @"CCIE[0]": u1,
        /// (2/4 of CCIE) Capture/Compare x (x=1-4) interrupt enable
        @"CCIE[1]": u1,
        /// (3/4 of CCIE) Capture/Compare x (x=1-4) interrupt enable
        @"CCIE[2]": u1,
        /// (4/4 of CCIE) Capture/Compare x (x=1-4) interrupt enable
        @"CCIE[3]": u1,
        reserved6: u1 = 0,
        /// Trigger interrupt enable
        TIE: u1,
        reserved8: u1 = 0,
        /// Update DMA request enable
        UDE: u1,
        /// (1/4 of CCDE) Capture/Compare x (x=1-4) DMA request enable
        @"CCDE[0]": u1,
        /// (2/4 of CCDE) Capture/Compare x (x=1-4) DMA request enable
        @"CCDE[1]": u1,
        /// (3/4 of CCDE) Capture/Compare x (x=1-4) DMA request enable
        @"CCDE[2]": u1,
        /// (4/4 of CCDE) Capture/Compare x (x=1-4) DMA request enable
        @"CCDE[3]": u1,
        reserved14: u1 = 0,
        /// Trigger DMA request enable
        TDE: u1,
        reserved20: u5 = 0,
        /// Index interrupt enable
        IDXIE: u1,
        /// Direction change interrupt enable
        DIRIE: u1,
        /// Index error interrupt enable
        IERRIE: u1,
        /// Transition error interrupt enable
        TERRIE: u1,
        padding: u8 = 0,
    }),
    /// status register
    /// offset: 0x10
    SR: mmio.Mmio(packed struct(u32) {
        /// Update interrupt flag
        UIF: u1,
        /// (1/4 of CCIF) Capture/compare x (x=1-4) interrupt flag
        @"CCIF[0]": u1,
        /// (2/4 of CCIF) Capture/compare x (x=1-4) interrupt flag
        @"CCIF[1]": u1,
        /// (3/4 of CCIF) Capture/compare x (x=1-4) interrupt flag
        @"CCIF[2]": u1,
        /// (4/4 of CCIF) Capture/compare x (x=1-4) interrupt flag
        @"CCIF[3]": u1,
        reserved6: u1 = 0,
        /// Trigger interrupt flag
        TIF: u1,
        reserved9: u2 = 0,
        /// (1/4 of CCOF) Capture/Compare x (x=1-4) overcapture flag
        @"CCOF[0]": u1,
        /// (2/4 of CCOF) Capture/Compare x (x=1-4) overcapture flag
        @"CCOF[1]": u1,
        /// (3/4 of CCOF) Capture/Compare x (x=1-4) overcapture flag
        @"CCOF[2]": u1,
        /// (4/4 of CCOF) Capture/Compare x (x=1-4) overcapture flag
        @"CCOF[3]": u1,
        reserved20: u7 = 0,
        /// Index interrupt flag
        IDXIF: u1,
        /// Direction change interrupt flag
        DIRIF: u1,
        /// Index error interrupt flag
        IERRIF: u1,
        /// Transition error interrupt flag
        TERRIF: u1,
        padding: u8 = 0,
    }),
    /// event generation register
    /// offset: 0x14
    EGR: mmio.Mmio(packed struct(u32) {
        /// Update generation
        UG: u1,
        /// (1/4 of CCG) Capture/compare x (x=1-4) generation
        @"CCG[0]": u1,
        /// (2/4 of CCG) Capture/compare x (x=1-4) generation
        @"CCG[1]": u1,
        /// (3/4 of CCG) Capture/compare x (x=1-4) generation
        @"CCG[2]": u1,
        /// (4/4 of CCG) Capture/compare x (x=1-4) generation
        @"CCG[3]": u1,
        reserved6: u1 = 0,
        /// Trigger generation
        TG: u1,
        padding: u25 = 0,
    }),
    /// capture/compare mode register 1-2 (input mode)
    /// offset: 0x18
    CCMR_Input: [2]mmio.Mmio(packed struct(u32) {
        /// (1/2 of CCS) Capture/Compare y selection
        @"CCS[0]": CCMR_Input_CCS,
        /// (1/2 of ICPSC) Input capture y prescaler
        @"ICPSC[0]": u2,
        /// (1/2 of ICF) Input capture y filter
        @"ICF[0]": FilterValue,
        /// (2/2 of CCS) Capture/Compare y selection
        @"CCS[1]": CCMR_Input_CCS,
        /// (2/2 of ICPSC) Input capture y prescaler
        @"ICPSC[1]": u2,
        /// (2/2 of ICF) Input capture y filter
        @"ICF[1]": FilterValue,
        padding: u16 = 0,
    }),
    /// capture/compare enable register
    /// offset: 0x20
    CCER: mmio.Mmio(packed struct(u32) {
        /// (1/4 of CCE) Capture/Compare x (x=1-4) output enable
        @"CCE[0]": u1,
        /// (1/4 of CCP) Capture/Compare x (x=1-4) output Polarity
        @"CCP[0]": u1,
        reserved3: u1 = 0,
        /// (1/4 of CCNP) Capture/Compare x (x=1-4) output Polarity
        @"CCNP[0]": u1,
        /// (2/4 of CCE) Capture/Compare x (x=1-4) output enable
        @"CCE[1]": u1,
        /// (2/4 of CCP) Capture/Compare x (x=1-4) output Polarity
        @"CCP[1]": u1,
        reserved7: u1 = 0,
        /// (2/4 of CCNP) Capture/Compare x (x=1-4) output Polarity
        @"CCNP[1]": u1,
        /// (3/4 of CCE) Capture/Compare x (x=1-4) output enable
        @"CCE[2]": u1,
        /// (3/4 of CCP) Capture/Compare x (x=1-4) output Polarity
        @"CCP[2]": u1,
        reserved11: u1 = 0,
        /// (3/4 of CCNP) Capture/Compare x (x=1-4) output Polarity
        @"CCNP[2]": u1,
        /// (4/4 of CCE) Capture/Compare x (x=1-4) output enable
        @"CCE[3]": u1,
        /// (4/4 of CCP) Capture/Compare x (x=1-4) output Polarity
        @"CCP[3]": u1,
        reserved15: u1 = 0,
        /// (4/4 of CCNP) Capture/Compare x (x=1-4) output Polarity
        @"CCNP[3]": u1,
        padding: u16 = 0,
    }),
    /// counter
    /// offset: 0x24
    CNT: mmio.Mmio(packed struct(u32) {
        /// counter value
        CNT: u16,
        reserved31: u15 = 0,
        /// UIF copy
        UIFCPY: u1,
    }),
    /// prescaler
    /// offset: 0x28
    PSC: u32,
    /// auto-reload register (Dither mode disabled)
    /// offset: 0x2c
    ARR: mmio.Mmio(packed struct(u32) {
        /// Auto-reload value
        ARR: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x30
    reserved48: [4]u8,
    /// capture/compare register x (x=1-4) (Dither mode disabled)
    /// offset: 0x34
    CCR: [4]mmio.Mmio(packed struct(u32) {
        /// capture/compare x (x=1-4,6) value
        CCR: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x44
    reserved68: [20]u8,
    /// encoder control register
    /// offset: 0x58
    ECR: mmio.Mmio(packed struct(u32) {
        /// Index enable
        IE: u1,
        /// Index direction
        IDIR: IDIR,
        /// Index blanking
        IBLK: IBLK,
        /// First index
        FIDX: FIDX,
        /// Index positioning
        IPOS: u2,
        reserved16: u8 = 0,
        /// Pulse width
        PW: u8,
        /// Pulse width prescaler
        PWPRSC: u2,
        padding: u6 = 0,
    }),
    /// input selection register
    /// offset: 0x5c
    TISEL: mmio.Mmio(packed struct(u32) {
        /// (1/4 of TISEL) Selects TIM_TIx (x=1-4) input
        @"TISEL[0]": u4,
        reserved8: u4 = 0,
        /// (2/4 of TISEL) Selects TIM_TIx (x=1-4) input
        @"TISEL[1]": u4,
        reserved16: u4 = 0,
        /// (3/4 of TISEL) Selects TIM_TIx (x=1-4) input
        @"TISEL[2]": u4,
        reserved24: u4 = 0,
        /// (4/4 of TISEL) Selects TIM_TIx (x=1-4) input
        @"TISEL[3]": u4,
        padding: u4 = 0,
    }),
    /// alternate function register 1
    /// offset: 0x60
    AF1: mmio.Mmio(packed struct(u32) {
        reserved14: u14 = 0,
        /// etr_in source selection
        ETRSEL: u4,
        padding: u14 = 0,
    }),
    /// alternate function register 2
    /// offset: 0x64
    AF2: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// ocref_clr source selection
        OCRSEL: u3,
        padding: u13 = 0,
    }),
    /// Option register 1 Note: Check Reference Manual to parse this register content
    /// offset: 0x68
    OR: u32,
    /// offset: 0x6c
    reserved108: [880]u8,
    /// DMA control register
    /// offset: 0x3dc
    DCR: mmio.Mmio(packed struct(u32) {
        /// DMA base address
        DBA: u5,
        reserved8: u3 = 0,
        /// DMA burst length
        DBL: u5,
        reserved16: u3 = 0,
        /// DMA burst source selection
        DBSS: DBSS,
        padding: u12 = 0,
    }),
    /// DMA address for full transfer
    /// offset: 0x3e0
    DMAR: u32,
};

/// General purpose 32-bit timers
pub const TIM_GP32 = extern struct {
    /// control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Counter enable
        CEN: u1,
        /// Update disable
        UDIS: u1,
        /// Update request source
        URS: URS,
        /// One-pulse mode enbaled
        OPM: u1,
        /// Direction
        DIR: DIR,
        /// Center-aligned mode selection
        CMS: CMS,
        /// Auto-reload preload enable
        ARPE: u1,
        /// Clock division
        CKD: CKD,
        reserved11: u1 = 0,
        /// UIF status bit remapping enable
        UIFREMAP: u1,
        /// Dithering enable
        DITHEN: u1,
        padding: u19 = 0,
    }),
    /// control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// Capture/compare DMA selection
        CCDS: CCDS,
        /// Master mode selection
        MMS: u3,
        /// TI1 selection
        TI1S: TI1S,
        reserved25: u17 = 0,
        /// Master mode selection
        MMS_CONT: u1,
        padding: u6 = 0,
    }),
    /// slave mode control register
    /// offset: 0x08
    SMCR: mmio.Mmio(packed struct(u32) {
        /// Slave mode selection
        SMS: u3,
        reserved4: u1 = 0,
        /// Trigger selection
        TS: u3,
        /// Master/Slave mode
        MSM: MSM,
        /// External trigger filter
        ETF: FilterValue,
        /// External trigger prescaler
        ETPS: ETPS,
        /// External clock mode 2 enable
        ECE: u1,
        /// External trigger polarity
        ETP: ETP,
        /// Slave mode selection
        SMS_CONT: u1,
        reserved20: u3 = 0,
        /// Trigger selection
        TS_CONT: u2,
        reserved24: u2 = 0,
        /// SMS preload enable
        SMSPE: u1,
        /// SMS preload source
        SMSPS: SMSPS,
        padding: u6 = 0,
    }),
    /// DMA/Interrupt enable register
    /// offset: 0x0c
    DIER: mmio.Mmio(packed struct(u32) {
        /// Update interrupt enable
        UIE: u1,
        /// (1/4 of CCIE) Capture/Compare x (x=1-4) interrupt enable
        @"CCIE[0]": u1,
        /// (2/4 of CCIE) Capture/Compare x (x=1-4) interrupt enable
        @"CCIE[1]": u1,
        /// (3/4 of CCIE) Capture/Compare x (x=1-4) interrupt enable
        @"CCIE[2]": u1,
        /// (4/4 of CCIE) Capture/Compare x (x=1-4) interrupt enable
        @"CCIE[3]": u1,
        reserved6: u1 = 0,
        /// Trigger interrupt enable
        TIE: u1,
        reserved8: u1 = 0,
        /// Update DMA request enable
        UDE: u1,
        /// (1/4 of CCDE) Capture/Compare x (x=1-4) DMA request enable
        @"CCDE[0]": u1,
        /// (2/4 of CCDE) Capture/Compare x (x=1-4) DMA request enable
        @"CCDE[1]": u1,
        /// (3/4 of CCDE) Capture/Compare x (x=1-4) DMA request enable
        @"CCDE[2]": u1,
        /// (4/4 of CCDE) Capture/Compare x (x=1-4) DMA request enable
        @"CCDE[3]": u1,
        reserved14: u1 = 0,
        /// Trigger DMA request enable
        TDE: u1,
        reserved20: u5 = 0,
        /// Index interrupt enable
        IDXIE: u1,
        /// Direction change interrupt enable
        DIRIE: u1,
        /// Index error interrupt enable
        IERRIE: u1,
        /// Transition error interrupt enable
        TERRIE: u1,
        padding: u8 = 0,
    }),
    /// status register
    /// offset: 0x10
    SR: mmio.Mmio(packed struct(u32) {
        /// Update interrupt flag
        UIF: u1,
        /// (1/4 of CCIF) Capture/compare x (x=1-4) interrupt flag
        @"CCIF[0]": u1,
        /// (2/4 of CCIF) Capture/compare x (x=1-4) interrupt flag
        @"CCIF[1]": u1,
        /// (3/4 of CCIF) Capture/compare x (x=1-4) interrupt flag
        @"CCIF[2]": u1,
        /// (4/4 of CCIF) Capture/compare x (x=1-4) interrupt flag
        @"CCIF[3]": u1,
        reserved6: u1 = 0,
        /// Trigger interrupt flag
        TIF: u1,
        reserved9: u2 = 0,
        /// (1/4 of CCOF) Capture/Compare x (x=1-4) overcapture flag
        @"CCOF[0]": u1,
        /// (2/4 of CCOF) Capture/Compare x (x=1-4) overcapture flag
        @"CCOF[1]": u1,
        /// (3/4 of CCOF) Capture/Compare x (x=1-4) overcapture flag
        @"CCOF[2]": u1,
        /// (4/4 of CCOF) Capture/Compare x (x=1-4) overcapture flag
        @"CCOF[3]": u1,
        reserved20: u7 = 0,
        /// Index interrupt flag
        IDXIF: u1,
        /// Direction change interrupt flag
        DIRIF: u1,
        /// Index error interrupt flag
        IERRIF: u1,
        /// Transition error interrupt flag
        TERRIF: u1,
        padding: u8 = 0,
    }),
    /// event generation register
    /// offset: 0x14
    EGR: mmio.Mmio(packed struct(u32) {
        /// Update generation
        UG: u1,
        /// (1/4 of CCG) Capture/compare x (x=1-4) generation
        @"CCG[0]": u1,
        /// (2/4 of CCG) Capture/compare x (x=1-4) generation
        @"CCG[1]": u1,
        /// (3/4 of CCG) Capture/compare x (x=1-4) generation
        @"CCG[2]": u1,
        /// (4/4 of CCG) Capture/compare x (x=1-4) generation
        @"CCG[3]": u1,
        reserved6: u1 = 0,
        /// Trigger generation
        TG: u1,
        padding: u25 = 0,
    }),
    /// capture/compare mode register 1-2 (input mode)
    /// offset: 0x18
    CCMR_Input: [2]mmio.Mmio(packed struct(u32) {
        /// (1/2 of CCS) Capture/Compare y selection
        @"CCS[0]": CCMR_Input_CCS,
        /// (1/2 of ICPSC) Input capture y prescaler
        @"ICPSC[0]": u2,
        /// (1/2 of ICF) Input capture y filter
        @"ICF[0]": FilterValue,
        /// (2/2 of CCS) Capture/Compare y selection
        @"CCS[1]": CCMR_Input_CCS,
        /// (2/2 of ICPSC) Input capture y prescaler
        @"ICPSC[1]": u2,
        /// (2/2 of ICF) Input capture y filter
        @"ICF[1]": FilterValue,
        padding: u16 = 0,
    }),
    /// capture/compare enable register
    /// offset: 0x20
    CCER: mmio.Mmio(packed struct(u32) {
        /// (1/4 of CCE) Capture/Compare x (x=1-4) output enable
        @"CCE[0]": u1,
        /// (1/4 of CCP) Capture/Compare x (x=1-4) output Polarity
        @"CCP[0]": u1,
        reserved3: u1 = 0,
        /// (1/4 of CCNP) Capture/Compare x (x=1-4) output Polarity
        @"CCNP[0]": u1,
        /// (2/4 of CCE) Capture/Compare x (x=1-4) output enable
        @"CCE[1]": u1,
        /// (2/4 of CCP) Capture/Compare x (x=1-4) output Polarity
        @"CCP[1]": u1,
        reserved7: u1 = 0,
        /// (2/4 of CCNP) Capture/Compare x (x=1-4) output Polarity
        @"CCNP[1]": u1,
        /// (3/4 of CCE) Capture/Compare x (x=1-4) output enable
        @"CCE[2]": u1,
        /// (3/4 of CCP) Capture/Compare x (x=1-4) output Polarity
        @"CCP[2]": u1,
        reserved11: u1 = 0,
        /// (3/4 of CCNP) Capture/Compare x (x=1-4) output Polarity
        @"CCNP[2]": u1,
        /// (4/4 of CCE) Capture/Compare x (x=1-4) output enable
        @"CCE[3]": u1,
        /// (4/4 of CCP) Capture/Compare x (x=1-4) output Polarity
        @"CCP[3]": u1,
        reserved15: u1 = 0,
        /// (4/4 of CCNP) Capture/Compare x (x=1-4) output Polarity
        @"CCNP[3]": u1,
        padding: u16 = 0,
    }),
    /// counter (Dither mode disabled)
    /// offset: 0x24
    CNT: u32,
    /// prescaler
    /// offset: 0x28
    PSC: u32,
    /// auto-reload register (Dither mode disabled)
    /// offset: 0x2c
    ARR: u32,
    /// offset: 0x30
    reserved48: [4]u8,
    /// capture/compare register x (x=1-4) (Dither mode disabled)
    /// offset: 0x34
    CCR: [4]u32,
    /// offset: 0x44
    reserved68: [20]u8,
    /// encoder control register
    /// offset: 0x58
    ECR: mmio.Mmio(packed struct(u32) {
        /// Index enable
        IE: u1,
        /// Index direction
        IDIR: IDIR,
        /// Index blanking
        IBLK: IBLK,
        /// First index
        FIDX: FIDX,
        /// Index positioning
        IPOS: u2,
        reserved16: u8 = 0,
        /// Pulse width
        PW: u8,
        /// Pulse width prescaler
        PWPRSC: u2,
        padding: u6 = 0,
    }),
    /// input selection register
    /// offset: 0x5c
    TISEL: mmio.Mmio(packed struct(u32) {
        /// (1/4 of TISEL) Selects TIM_TIx (x=1-4) input
        @"TISEL[0]": u4,
        reserved8: u4 = 0,
        /// (2/4 of TISEL) Selects TIM_TIx (x=1-4) input
        @"TISEL[1]": u4,
        reserved16: u4 = 0,
        /// (3/4 of TISEL) Selects TIM_TIx (x=1-4) input
        @"TISEL[2]": u4,
        reserved24: u4 = 0,
        /// (4/4 of TISEL) Selects TIM_TIx (x=1-4) input
        @"TISEL[3]": u4,
        padding: u4 = 0,
    }),
    /// alternate function register 1
    /// offset: 0x60
    AF1: mmio.Mmio(packed struct(u32) {
        reserved14: u14 = 0,
        /// etr_in source selection
        ETRSEL: u4,
        padding: u14 = 0,
    }),
    /// alternate function register 2
    /// offset: 0x64
    AF2: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// ocref_clr source selection
        OCRSEL: u3,
        padding: u13 = 0,
    }),
    /// Option register 1 Note: Check Reference Manual to parse this register content
    /// offset: 0x68
    OR: u32,
    /// offset: 0x6c
    reserved108: [880]u8,
    /// DMA control register
    /// offset: 0x3dc
    DCR: mmio.Mmio(packed struct(u32) {
        /// DMA base address
        DBA: u5,
        reserved8: u3 = 0,
        /// DMA burst length
        DBL: u5,
        reserved16: u3 = 0,
        /// DMA burst source selection
        DBSS: DBSS,
        padding: u12 = 0,
    }),
    /// DMA address for full transfer
    /// offset: 0x3e0
    DMAR: u32,
};
