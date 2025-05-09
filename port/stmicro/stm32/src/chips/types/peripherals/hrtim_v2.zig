const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const ACTIVEEFFECT = enum(u1) {
    /// Timer event has no effect
    NoEffect = 0x0,
    /// Timer event forces the output to its active state
    SetActive = 0x1,
};

pub const BRSTDMA = enum(u2) {
    /// Update done independently from the DMA burst transfer completion
    Independent = 0x0,
    /// Update done when the DMA burst transfer is completed
    Completion = 0x1,
    /// Update done on master timer roll-over following a DMA burst transfer completion
    Rollover = 0x2,
    _,
};

pub const CAPTUREEFFECT = enum(u1) {
    /// Timer event has no effect
    NoEffect = 0x0,
    /// Timer event triggers capture
    TriggerCapture = 0x1,
};

pub const CPPSTAT = enum(u1) {
    /// Signal applied on output 1 and output 2 forced inactive
    Output1Active = 0x0,
    /// Signal applied on output 2 and output 1 forced inactive
    Output2Active = 0x1,
};

pub const DACSYNC = enum(u2) {
    /// No DAC trigger generated
    Disabled = 0x0,
    /// Trigger generated on DACSync1
    DACSync1 = 0x1,
    /// Trigger generated on DACSync2
    DACSync2 = 0x2,
    /// Trigger generated on DACSync3
    DACSync3 = 0x3,
};

pub const DELCMP = enum(u2) {
    /// CMP register is always active (standard compare mode)
    Standard = 0x0,
    /// CMP is recomputed and is active following a capture 1 event
    Capture1 = 0x1,
    /// CMP is recomputed and is active following a capture 1 event or a Compare 1 match
    CaptureX_Compare1 = 0x2,
    /// CMP is recomputed and is active following a capture 1 event or a Compare 3 match
    CaptureX_Compare3 = 0x3,
};

pub const DLYPRT = enum(u3) {
    /// Output 1 delayed idle on external event 6
    Output1_EE6 = 0x0,
    /// Output 2 delayed idle on external event 6
    Output2_EE6 = 0x1,
    /// Output 1 and 2 delayed idle on external event 6
    Output1_2_EE6 = 0x2,
    /// Balanced idle on external event 6
    Balanced_EE6 = 0x3,
    /// Output 1 delayed idle on external event 7
    Output1_EE7 = 0x4,
    /// Output 2 delayed idle on external event 7
    Output2_EE7 = 0x5,
    /// Output 1 and 2 delayed idle on external event 7
    Output1_2_EE7 = 0x6,
    /// Balanced idle on external event 7
    Balanced_EE7 = 0x7,
};

pub const EEFLTR = enum(u4) {
    /// No filtering
    Disabled = 0x0,
    /// Blanking from counter reset/roll-over to Compare 1
    BlankResetToCompare1 = 0x1,
    /// Blanking from counter reset/roll-over to Compare 2
    BlankResetToCompare2 = 0x2,
    /// Blanking from counter reset/roll-over to Compare 3
    BlankResetToCompare3 = 0x3,
    /// Blanking from counter reset/roll-over to Compare 4
    BlankResetToCompare4 = 0x4,
    /// Blanking from another timing unit: TIMFLTR1 source
    BlankTIMFLTR1 = 0x5,
    /// Blanking from another timing unit: TIMFLTR2 source
    BlankTIMFLTR2 = 0x6,
    /// Blanking from another timing unit: TIMFLTR3 source
    BlankTIMFLTR3 = 0x7,
    /// Blanking from another timing unit: TIMFLTR4 source
    BlankTIMFLTR4 = 0x8,
    /// Blanking from another timing unit: TIMFLTR5 source
    BlankTIMFLTR5 = 0x9,
    /// Blanking from another timing unit: TIMFLTR6 source
    BlankTIMFLTR6 = 0xa,
    /// Blanking from another timing unit: TIMFLTR7 source
    BlankTIMFLTR7 = 0xb,
    /// Blanking from another timing unit: TIMFLTR8 source
    BlankTIMFLTR8 = 0xc,
    /// Windowing from counter reset/roll-over to compare 2
    WindowResetToCompare2 = 0xd,
    /// Windowing from counter reset/roll-over to compare 3
    WindowResetToCompare3 = 0xe,
    /// Windowing from another timing unit: TIMWIN source
    WindowTIMWIN = 0xf,
};

pub const FAULT = enum(u2) {
    /// No action: the output is not affected by the fault input and stays in run mode
    Disabled = 0x0,
    /// Output goes to active state after a fault event
    SetActive = 0x1,
    /// Output goes to inactive state after a fault event
    SetInactive = 0x2,
    /// Output goes to high-z state after a fault event
    SetHighZ = 0x3,
};

pub const FLTEN = enum(u1) {
    /// Fault input ignored
    Ignored = 0x0,
    /// Fault input is active and can disable HRTIM outputs
    Active = 0x1,
};

pub const INACTIVEEFFECT = enum(u1) {
    /// Timer event has no effect
    NoEffect = 0x0,
    /// Timer event forces the output to its inactive state
    SetInactive = 0x1,
};

pub const IPPSTAT = enum(u1) {
    /// Protection occurred when the output 1 was active and output 2 forced inactive
    Output1Active = 0x0,
    /// Protection occurred when the output 2 was active and output 1 forced inactive
    Output2Active = 0x1,
};

pub const OUTPUTSTATE = enum(u1) {
    /// Output is or was inactive
    Inactive = 0x0,
    /// Output is or was active
    Active = 0x1,
};

pub const POL = enum(u1) {
    /// Positive polarity (output active high)
    ActiveHigh = 0x0,
    /// Negative polarity (output active low)
    ActiveLow = 0x1,
};

pub const RESETEFFECT = enum(u1) {
    /// Timer Y compare Z event has no effect
    NoEffect = 0x0,
    /// Timer X counter is reset upon timer Y compare Z event
    ResetCounter = 0x1,
};

pub const SDTF = enum(u1) {
    /// Positive deadtime on falling edge
    Positive = 0x0,
    /// Negative deadtime on falling edge
    Negative = 0x1,
};

pub const SDTR = enum(u1) {
    /// Positive deadtime on rising edge
    Positive = 0x0,
    /// Negative deadtime on rising edge
    Negative = 0x1,
};

pub const SYNCIN = enum(u2) {
    /// Disabled. HRTIM is not synchronized and runs in standalone mode
    Disabled = 0x0,
    /// Internal event: the HRTIM is synchronized with the on-chip timer
    Internal = 0x2,
    /// External event: a positive pulse on HRTIM_SCIN input triggers the HRTIM
    External = 0x3,
    _,
};

pub const SYNCOUT = enum(u2) {
    /// Disabled
    Disabled = 0x0,
    /// Positive pulse on SCOUT output (16x f_HRTIM clock cycles)
    PositivePulse = 0x2,
    /// Negative pulse on SCOUT output (16x f_HRTIM clock cycles)
    NegativePulse = 0x3,
    _,
};

pub const SYNCRST = enum(u1) {
    /// Synchronization event has no effect on Timer x
    Disabled = 0x0,
    /// Synchronization event resets Timer x
    Reset = 0x1,
};

pub const SYNCSRC = enum(u2) {
    /// Master timer Start
    MasterStart = 0x0,
    /// Master timer Compare 1 event
    MasterCompare1 = 0x1,
    /// Timer A start/reset
    TimerAStart = 0x2,
    /// Timer A Compare 1 event
    TimerACompare1 = 0x3,
};

pub const SYNCSTRT = enum(u1) {
    /// Synchronization event has no effect on Timer x
    Disabled = 0x0,
    /// Synchronization event starts Timer x
    Start = 0x1,
};

pub const TIMAISR_DLYPRT = enum(u1) {
    /// Not in delayed idle or balanced idle mode
    Inactive = 0x0,
    /// Delayed idle or balanced idle mode entry
    Active = 0x1,
};

pub const UPDGAT = enum(u4) {
    /// Update occurs independently from the DMA burst transfer
    Independent = 0x0,
    /// Update occurs when the DMA burst transfer is completed
    DMABurst = 0x1,
    /// Update occurs on the update event following DMA burst transfer completion
    DMABurst_Update = 0x2,
    /// Update occurs on a rising edge of HRTIM update enable input 1
    Input1 = 0x3,
    /// Update occurs on a rising edge of HRTIM update enable input 2
    Input2 = 0x4,
    /// Update occurs on a rising edge of HRTIM update enable input 3
    Input3 = 0x5,
    /// Update occurs on the update event following a rising edge of HRTIM update enable input 1
    Input1_Update = 0x6,
    /// Update occurs on the update event following a rising edge of HRTIM update enable input 2
    Input2_Update = 0x7,
    /// Update occurs on the update event following a rising edge of HRTIM update enable input 3
    Input3_Update = 0x8,
    _,
};

/// High Resolution Timer
pub const HRTIM = extern struct {
    /// Master Timer Control Register
    /// offset: 0x00
    MCR: mmio.Mmio(packed struct(u32) {
        /// HRTIM Master Clock prescaler
        CKPSC: u3,
        /// Master Continuous mode
        CONT: u1,
        /// Master Re-triggerable mode
        RETRIG: u1,
        /// Half mode enable
        HALF: u1,
        reserved8: u2 = 0,
        /// Synchronization input
        SYNCIN: SYNCIN,
        /// Synchronization Resets Master
        SYNCRSTM: u1,
        /// Synchronization Starts Master
        SYNCSTRTM: u1,
        /// Synchronization output
        SYNCOUT: SYNCOUT,
        /// Synchronization source
        SYNCSRC: SYNCSRC,
        /// Master Counter enable
        MCEN: u1,
        /// (1/5 of TCEN) Timer X counter enable
        @"TCEN[0]": u1,
        /// (2/5 of TCEN) Timer X counter enable
        @"TCEN[1]": u1,
        /// (3/5 of TCEN) Timer X counter enable
        @"TCEN[2]": u1,
        /// (4/5 of TCEN) Timer X counter enable
        @"TCEN[3]": u1,
        /// (5/5 of TCEN) Timer X counter enable
        @"TCEN[4]": u1,
        reserved25: u3 = 0,
        /// AC Synchronization
        DACSYNC: DACSYNC,
        /// Preload enable
        PREEN: u1,
        reserved29: u1 = 0,
        /// Master Timer Repetition update
        MREPU: u1,
        /// Burst DMA Update
        BRSTDMA: BRSTDMA,
    }),
    /// Master Timer Interrupt Status Register
    /// offset: 0x04
    MISR: mmio.Mmio(packed struct(u32) {
        /// (1/4 of MCMP) Master Compare X Interrupt Flag
        @"MCMP[0]": u1,
        /// (2/4 of MCMP) Master Compare X Interrupt Flag
        @"MCMP[1]": u1,
        /// (3/4 of MCMP) Master Compare X Interrupt Flag
        @"MCMP[2]": u1,
        /// (4/4 of MCMP) Master Compare X Interrupt Flag
        @"MCMP[3]": u1,
        /// Master Repetition Interrupt Flag
        MREP: u1,
        /// Sync Input Interrupt Flag
        SYNC: u1,
        /// Master Update Interrupt Flag
        MUPD: u1,
        padding: u25 = 0,
    }),
    /// Master Timer Interrupt Clear Register
    /// offset: 0x08
    MICR: mmio.Mmio(packed struct(u32) {
        /// (1/4 of MCMPC) Master Compare X Interrupt flag clear
        @"MCMPC[0]": u1,
        /// (2/4 of MCMPC) Master Compare X Interrupt flag clear
        @"MCMPC[1]": u1,
        /// (3/4 of MCMPC) Master Compare X Interrupt flag clear
        @"MCMPC[2]": u1,
        /// (4/4 of MCMPC) Master Compare X Interrupt flag clear
        @"MCMPC[3]": u1,
        /// Repetition Interrupt flag clear
        MREPC: u1,
        /// Sync Input Interrupt flag clear
        SYNCC: u1,
        /// Master update Interrupt flag clear
        MUPDC: u1,
        padding: u25 = 0,
    }),
    /// Master Timer DMA / Interrupt Enable Register
    /// offset: 0x0c
    MDIER: mmio.Mmio(packed struct(u32) {
        /// (1/4 of MCMPIE) Master Compare X Interrupt Enable
        @"MCMPIE[0]": u1,
        /// (2/4 of MCMPIE) Master Compare X Interrupt Enable
        @"MCMPIE[1]": u1,
        /// (3/4 of MCMPIE) Master Compare X Interrupt Enable
        @"MCMPIE[2]": u1,
        /// (4/4 of MCMPIE) Master Compare X Interrupt Enable
        @"MCMPIE[3]": u1,
        /// Master Repetition Interrupt Enable
        MREPIE: u1,
        /// Sync Input Interrupt Enable
        SYNCIE: u1,
        /// Master Update Interrupt Enable
        MUPDIE: u1,
        reserved16: u9 = 0,
        /// (1/4 of MCMPDE) Master Compare X DMA request Enable
        @"MCMPDE[0]": u1,
        /// (2/4 of MCMPDE) Master Compare X DMA request Enable
        @"MCMPDE[1]": u1,
        /// (3/4 of MCMPDE) Master Compare X DMA request Enable
        @"MCMPDE[2]": u1,
        /// (4/4 of MCMPDE) Master Compare X DMA request Enable
        @"MCMPDE[3]": u1,
        /// Master Repetition DMA request Enable
        MREPDE: u1,
        /// Sync Input DMA request Enable
        SYNCDE: u1,
        /// Master Update DMA request Enable
        MUPDDE: u1,
        padding: u9 = 0,
    }),
    /// Master Timer Counter Register
    /// offset: 0x10
    MCNTR: mmio.Mmio(packed struct(u32) {
        /// Counter value
        MCNT: u16,
        padding: u16 = 0,
    }),
    /// Master Timer Period Register
    /// offset: 0x14
    MPER: mmio.Mmio(packed struct(u32) {
        /// Master Timer Period value
        MPER: u16,
        padding: u16 = 0,
    }),
    /// Master Timer Repetition Register
    /// offset: 0x18
    MREP: mmio.Mmio(packed struct(u32) {
        /// Master Timer Repetition counter value
        MREP: u8,
        padding: u24 = 0,
    }),
    /// Master Timer Compare X Register
    /// offset: 0x1c
    MCMP: mmio.Mmio(packed struct(u32) {
        /// Master Timer Compare X value
        MCMP: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x20
    reserved32: [96]u8,
    /// High Resolution Timer: Timing Unit
    /// offset: 0x80
    TIM: u32,
    /// offset: 0x84
    reserved132: [764]u8,
    /// High Resolution Timer: Control Register 1
    /// offset: 0x380
    CR1: mmio.Mmio(packed struct(u32) {
        /// Master Update Disable
        MUDIS: u1,
        /// (1/5 of TUDIS) Timer X Update Disable
        @"TUDIS[0]": u1,
        /// (2/5 of TUDIS) Timer X Update Disable
        @"TUDIS[1]": u1,
        /// (3/5 of TUDIS) Timer X Update Disable
        @"TUDIS[2]": u1,
        /// (4/5 of TUDIS) Timer X Update Disable
        @"TUDIS[3]": u1,
        /// (5/5 of TUDIS) Timer X Update Disable
        @"TUDIS[4]": u1,
        reserved16: u10 = 0,
        /// (1/4 of ADUSRC) ADC Trigger X Update Source
        @"ADUSRC[0]": u3,
        /// (2/4 of ADUSRC) ADC Trigger X Update Source
        @"ADUSRC[1]": u3,
        /// (3/4 of ADUSRC) ADC Trigger X Update Source
        @"ADUSRC[2]": u3,
        /// (4/4 of ADUSRC) ADC Trigger X Update Source
        @"ADUSRC[3]": u3,
        padding: u4 = 0,
    }),
    /// High Resolution Timer: Control Register 2
    /// offset: 0x384
    CR2: mmio.Mmio(packed struct(u32) {
        /// Master Timer Software Update
        MSWU: u1,
        /// (1/5 of TSWU) Timer X Software Update
        @"TSWU[0]": u1,
        /// (2/5 of TSWU) Timer X Software Update
        @"TSWU[1]": u1,
        /// (3/5 of TSWU) Timer X Software Update
        @"TSWU[2]": u1,
        /// (4/5 of TSWU) Timer X Software Update
        @"TSWU[3]": u1,
        /// (5/5 of TSWU) Timer X Software Update
        @"TSWU[4]": u1,
        reserved8: u2 = 0,
        /// Master Counter Software Reset
        MRST: u1,
        /// (1/5 of TRST) Timer X Counter Software Reset
        @"TRST[0]": u1,
        /// (2/5 of TRST) Timer X Counter Software Reset
        @"TRST[1]": u1,
        /// (3/5 of TRST) Timer X Counter Software Reset
        @"TRST[2]": u1,
        /// (4/5 of TRST) Timer X Counter Software Reset
        @"TRST[3]": u1,
        /// (5/5 of TRST) Timer X Counter Software Reset
        @"TRST[4]": u1,
        padding: u18 = 0,
    }),
    /// High Resolution Timer: Interrupt Status Register
    /// offset: 0x388
    ISR: mmio.Mmio(packed struct(u32) {
        /// (1/5 of FLT) Fault X Interrupt Flag
        @"FLT[0]": u1,
        /// (2/5 of FLT) Fault X Interrupt Flag
        @"FLT[1]": u1,
        /// (3/5 of FLT) Fault X Interrupt Flag
        @"FLT[2]": u1,
        /// (4/5 of FLT) Fault X Interrupt Flag
        @"FLT[3]": u1,
        /// (5/5 of FLT) Fault X Interrupt Flag
        @"FLT[4]": u1,
        /// System Fault Interrupt Flag
        SYSFLT: u1,
        reserved16: u10 = 0,
        /// DLL Ready Interrupt Flag
        DLLRDY: u1,
        /// Burst Mode Period Interrupt Flag
        BMPER: u1,
        padding: u14 = 0,
    }),
    /// High Resolution Timer: Interrupt Clear Register
    /// offset: 0x38c
    ICR: mmio.Mmio(packed struct(u32) {
        /// (1/5 of FLT) Fault X Interrupt Flag Clear
        @"FLT[0]": u1,
        /// (2/5 of FLT) Fault X Interrupt Flag Clear
        @"FLT[1]": u1,
        /// (3/5 of FLT) Fault X Interrupt Flag Clear
        @"FLT[2]": u1,
        /// (4/5 of FLT) Fault X Interrupt Flag Clear
        @"FLT[3]": u1,
        /// (5/5 of FLT) Fault X Interrupt Flag Clear
        @"FLT[4]": u1,
        /// System Fault Interrupt Flag Clear
        SYSFLT: u1,
        reserved16: u10 = 0,
        /// DLL Ready Interrupt Flag Clear
        DLLRDY: u1,
        /// Burst Mode Period Interrupt Flag Clear
        BMPER: u1,
        padding: u14 = 0,
    }),
    /// High Resolution Timer: Interrupt Enable Register
    /// offset: 0x390
    IER: mmio.Mmio(packed struct(u32) {
        /// (1/5 of FLT) Fault X Interrupt Flag Enable
        @"FLT[0]": u1,
        /// (2/5 of FLT) Fault X Interrupt Flag Enable
        @"FLT[1]": u1,
        /// (3/5 of FLT) Fault X Interrupt Flag Enable
        @"FLT[2]": u1,
        /// (4/5 of FLT) Fault X Interrupt Flag Enable
        @"FLT[3]": u1,
        /// (5/5 of FLT) Fault X Interrupt Flag Enable
        @"FLT[4]": u1,
        /// System Fault Interrupt Flag Enable
        SYSFLT: u1,
        reserved16: u10 = 0,
        /// DLL Ready Interrupt Flag Enable
        DLLRDY: u1,
        /// Burst Mode Period Interrupt Flag Enable
        BMPER: u1,
        padding: u14 = 0,
    }),
    /// High Resolution Timer: Output Enable Register
    /// offset: 0x394
    OENR: mmio.Mmio(packed struct(u32) {
        /// Timer X Output Enable
        @"T1OEN[0]": u1,
        /// Timer X Complementary Output Enable
        @"T2OEN[0]": u1,
        /// Timer X Output Enable
        @"T1OEN[1]": u1,
        /// Timer X Complementary Output Enable
        @"T2OEN[1]": u1,
        /// Timer X Output Enable
        @"T1OEN[2]": u1,
        /// Timer X Complementary Output Enable
        @"T2OEN[2]": u1,
        /// Timer X Output Enable
        @"T1OEN[3]": u1,
        /// Timer X Complementary Output Enable
        @"T2OEN[3]": u1,
        /// Timer X Output Enable
        @"T1OEN[4]": u1,
        /// Timer X Complementary Output Enable
        @"T2OEN[4]": u1,
        padding: u22 = 0,
    }),
    /// High Resolution Timer: Output Disable Register
    /// offset: 0x398
    ODISR: mmio.Mmio(packed struct(u32) {
        /// Timer X Output Disable
        @"T1ODIS[0]": u1,
        /// Timer X Complementary Output Disable
        @"T2ODIS[0]": u1,
        /// Timer X Output Disable
        @"T1ODIS[1]": u1,
        /// Timer X Complementary Output Disable
        @"T2ODIS[1]": u1,
        /// Timer X Output Disable
        @"T1ODIS[2]": u1,
        /// Timer X Complementary Output Disable
        @"T2ODIS[2]": u1,
        /// Timer X Output Disable
        @"T1ODIS[3]": u1,
        /// Timer X Complementary Output Disable
        @"T2ODIS[3]": u1,
        /// Timer X Output Disable
        @"T1ODIS[4]": u1,
        /// Timer X Complementary Output Disable
        @"T2ODIS[4]": u1,
        padding: u22 = 0,
    }),
    /// High Resolution Timer: Output Disable Status Register
    /// offset: 0x39c
    ODSR: mmio.Mmio(packed struct(u32) {
        /// Timer X Output Disable Status
        @"T1ODIS[0]": u1,
        /// Timer X Complementary Output Disable Status
        @"T2ODIS[0]": u1,
        /// Timer X Output Disable Status
        @"T1ODIS[1]": u1,
        /// Timer X Complementary Output Disable Status
        @"T2ODIS[1]": u1,
        /// Timer X Output Disable Status
        @"T1ODIS[2]": u1,
        /// Timer X Complementary Output Disable Status
        @"T2ODIS[2]": u1,
        /// Timer X Output Disable Status
        @"T1ODIS[3]": u1,
        /// Timer X Complementary Output Disable Status
        @"T2ODIS[3]": u1,
        /// Timer X Output Disable Status
        @"T1ODIS[4]": u1,
        /// Timer X Complementary Output Disable Status
        @"T2ODIS[4]": u1,
        padding: u22 = 0,
    }),
    /// High Resolution Timer: Burst Mode Control Register
    /// offset: 0x3a0
    BMCR: mmio.Mmio(packed struct(u32) {
        /// Burst Mode Enable
        BME: u1,
        /// Burst Mode Operating Mode
        BMOM: u1,
        /// Burst Mode Clock source
        BMCLK: u3,
        reserved6: u1 = 0,
        /// Burst Mode Prescaler
        BMPRSC: u3,
        reserved10: u1 = 0,
        /// Burst Mode Preload Enable
        BMPREN: u1,
        reserved16: u5 = 0,
        /// Master Timer Burst Mode
        MTBM: u1,
        /// (1/5 of TBM) Timer X Burst Mode
        @"TBM[0]": u1,
        /// (2/5 of TBM) Timer X Burst Mode
        @"TBM[1]": u1,
        /// (3/5 of TBM) Timer X Burst Mode
        @"TBM[2]": u1,
        /// (4/5 of TBM) Timer X Burst Mode
        @"TBM[3]": u1,
        /// (5/5 of TBM) Timer X Burst Mode
        @"TBM[4]": u1,
        reserved31: u9 = 0,
        BMSTAT: u1,
    }),
    /// High Resolution Timer: Burst Mode Trigger Register
    /// offset: 0x3a4
    BMTRGR: mmio.Mmio(packed struct(u32) {
        /// Software start
        SW: u1,
        /// Master reset or roll-over
        MSTRST: u1,
        /// Master repetition
        MSTREP: u1,
        /// (1/4 of MSTCMP) Master Compare X
        @"MSTCMP[0]": u1,
        /// (2/4 of MSTCMP) Master Compare X
        @"MSTCMP[1]": u1,
        /// (3/4 of MSTCMP) Master Compare X
        @"MSTCMP[2]": u1,
        /// (4/4 of MSTCMP) Master Compare X
        @"MSTCMP[3]": u1,
        /// Timer X reset or roll-over
        @"TRST[0]": u1,
        /// Timer X repetition
        @"TREP[0]": u1,
        /// Timer X compare 1 event
        @"TCMP1[0]": u1,
        /// Timer X compare 2 event
        @"TCMP2[0]": u1,
        /// Timer X reset or roll-over
        @"TRST[1]": u1,
        /// Timer X repetition
        @"TREP[1]": u1,
        /// Timer X compare 1 event
        @"TCMP1[1]": u1,
        /// Timer X compare 2 event
        @"TCMP2[1]": u1,
        /// Timer X reset or roll-over
        @"TRST[2]": u1,
        /// Timer X repetition
        @"TREP[2]": u1,
        /// Timer X compare 1 event
        @"TCMP1[2]": u1,
        /// Timer X compare 2 event
        @"TCMP2[2]": u1,
        /// Timer X reset or roll-over
        @"TRST[3]": u1,
        /// Timer X repetition
        @"TREP[3]": u1,
        /// Timer X compare 1 event
        @"TCMP1[3]": u1,
        /// Timer X compare 2 event
        @"TCMP2[3]": u1,
        /// Timer X reset or roll-over
        @"TRST[4]": u1,
        /// Timer X repetition
        @"TREP[4]": u1,
        /// Timer X compare 1 event
        @"TCMP1[4]": u1,
        /// Timer X compare 2 event
        @"TCMP2[4]": u1,
        padding: u5 = 0,
    }),
    /// High Resolution Timer: Burst Mode Compare Register
    /// offset: 0x3a8
    BMCMPR: mmio.Mmio(packed struct(u32) {
        /// Burst mode compare value
        BMCMP: u16,
        padding: u16 = 0,
    }),
    /// High Resolution Timer: Burst Mode Period Register
    /// offset: 0x3ac
    BMPER: mmio.Mmio(packed struct(u32) {
        /// Burst mode period value
        BMPER: u16,
        padding: u16 = 0,
    }),
    /// High Resolution Timer: External Event Control Register 1
    /// offset: 0x3b0
    EECR1: mmio.Mmio(packed struct(u32) {
        /// External Event X Source
        @"EESRC[0]": u2,
        /// External Event X Polarity
        @"EEPOL[0]": u1,
        /// External Event X Sensitivity
        @"EESNS[0]": u2,
        /// External Event X Fast Mode
        @"EEFAST[0]": u2,
        // skipped overlapping field EESRC[1] at offset 6 bits
        reserved8: u1 = 0,
        /// External Event X Polarity
        @"EEPOL[1]": u1,
        /// External Event X Sensitivity
        @"EESNS[1]": u2,
        /// External Event X Fast Mode
        @"EEFAST[1]": u2,
        // skipped overlapping field EESRC[2] at offset 12 bits
        reserved14: u1 = 0,
        /// External Event X Polarity
        @"EEPOL[2]": u1,
        /// External Event X Sensitivity
        @"EESNS[2]": u2,
        /// External Event X Fast Mode
        @"EEFAST[2]": u2,
        // skipped overlapping field EESRC[3] at offset 18 bits
        reserved20: u1 = 0,
        /// External Event X Polarity
        @"EEPOL[3]": u1,
        /// External Event X Sensitivity
        @"EESNS[3]": u2,
        /// External Event X Fast Mode
        @"EEFAST[3]": u2,
        // skipped overlapping field EESRC[4] at offset 24 bits
        reserved26: u1 = 0,
        /// External Event X Polarity
        @"EEPOL[4]": u1,
        /// External Event X Sensitivity
        @"EESNS[4]": u2,
        /// External Event X Fast Mode
        @"EEFAST[4]": u2,
        padding: u1 = 0,
    }),
    /// High Resolution Timer: External Event Control Register 2
    /// offset: 0x3b4
    EECR2: mmio.Mmio(packed struct(u32) {
        /// External Event X Source
        @"EESRC[0]": u2,
        /// External Event X Polarity
        @"EEPOL[0]": u1,
        /// External Event X Sensitivity
        @"EESNS[0]": u2,
        reserved6: u1 = 0,
        /// External Event X Source
        @"EESRC[1]": u2,
        /// External Event X Polarity
        @"EEPOL[1]": u1,
        /// External Event X Sensitivity
        @"EESNS[1]": u2,
        reserved12: u1 = 0,
        /// External Event X Source
        @"EESRC[2]": u2,
        /// External Event X Polarity
        @"EEPOL[2]": u1,
        /// External Event X Sensitivity
        @"EESNS[2]": u2,
        reserved18: u1 = 0,
        /// External Event X Source
        @"EESRC[3]": u2,
        /// External Event X Polarity
        @"EEPOL[3]": u1,
        /// External Event X Sensitivity
        @"EESNS[3]": u2,
        reserved24: u1 = 0,
        /// External Event X Source
        @"EESRC[4]": u2,
        /// External Event X Polarity
        @"EEPOL[4]": u1,
        /// External Event X Sensitivity
        @"EESNS[4]": u2,
        padding: u3 = 0,
    }),
    /// High Resolution Timer: External Event Control Register 3
    /// offset: 0x3b8
    EECR3: mmio.Mmio(packed struct(u32) {
        /// External Event X filter
        @"EEF[0]": u3,
        reserved6: u3 = 0,
        /// External Event X filter
        @"EEF[1]": u3,
        reserved12: u3 = 0,
        /// External Event X filter
        @"EEF[2]": u3,
        reserved18: u3 = 0,
        /// External Event X filter
        @"EEF[3]": u3,
        reserved24: u3 = 0,
        /// External Event X filter
        @"EEF[4]": u3,
        reserved30: u3 = 0,
        /// External Event Sampling Clock Division
        EEVSD: u2,
    }),
    /// High Resolution Timer: ADC Trigger [1, 3] Register
    /// offset: 0x3bc
    ADC1R: mmio.Mmio(packed struct(u32) {
        /// (1/4 of ADCMC) ADC trigger X on Master Compare Y
        @"ADCMC[0]": u1,
        /// (2/4 of ADCMC) ADC trigger X on Master Compare Y
        @"ADCMC[1]": u1,
        /// (3/4 of ADCMC) ADC trigger X on Master Compare Y
        @"ADCMC[2]": u1,
        /// (4/4 of ADCMC) ADC trigger X on Master Compare Y
        @"ADCMC[3]": u1,
        /// ADC trigger X on Master Period
        ADCMPER: u1,
        /// (1/5 of ADCEEV) ADC trigger X on External Event Y
        @"ADCEEV[0]": u1,
        /// (2/5 of ADCEEV) ADC trigger X on External Event Y
        @"ADCEEV[1]": u1,
        /// (3/5 of ADCEEV) ADC trigger X on External Event Y
        @"ADCEEV[2]": u1,
        /// (4/5 of ADCEEV) ADC trigger X on External Event Y
        @"ADCEEV[3]": u1,
        /// (5/5 of ADCEEV) ADC trigger X on External Event Y
        @"ADCEEV[4]": u1,
        /// ADC trigger X on Timer Y Compare 2
        @"ADCTC2[0]": u1,
        /// ADC trigger X on Timer Y Compare 3
        @"ADCTC3[0]": u1,
        /// ADC trigger X on Timer Y Compare 3
        @"ADCTC4[0]": u1,
        /// ADC trigger X on Timer Y Period
        @"ADCTPER[0]": u1,
        /// ADC trigger X on Timer Y Reset
        @"ADCTRST[0]": u1,
        reserved16: u1 = 0,
        /// ADC trigger X on Timer Y Compare 3
        @"ADCTC3[1]": u1,
        /// ADC trigger X on Timer Y Compare 3
        @"ADCTC4[1]": u1,
        /// ADC trigger X on Timer Y Period
        @"ADCTPER[1]": u1,
        /// ADC trigger X on Timer Y Reset
        @"ADCTRST[1]": u1,
        /// ADC trigger X on Timer Y Compare 3
        @"ADCTC4[5]": u1,
        /// ADC trigger X on Timer Y Compare 3
        @"ADCTC3[2]": u1,
        /// ADC trigger X on Timer Y Compare 3
        @"ADCTC4[2]": u1,
        /// ADC trigger X on Timer Y Period
        @"ADCTPER[2]": u1,
        reserved25: u1 = 0,
        /// ADC trigger X on Timer Y Compare 3
        @"ADCTC3[3]": u1,
        /// ADC trigger X on Timer Y Compare 3
        @"ADCTC4[3]": u1,
        /// ADC trigger X on Timer Y Period
        @"ADCTPER[3]": u1,
        /// ADC trigger X on Timer Y Reset
        @"ADCTRST[2]": u1,
        /// ADC trigger X on Timer Y Compare 3
        @"ADCTC3[4]": u1,
        /// ADC trigger X on Timer Y Compare 3
        @"ADCTC4[4]": u1,
        /// ADC trigger X on Timer Y Period
        @"ADCTPER[4]": u1,
    }),
    /// High Resolution Timer: ADC Trigger [2, 4] Register
    /// offset: 0x3c0
    ADC2R: mmio.Mmio(packed struct(u32) {
        /// (1/4 of ADCMC) ADC trigger X on Master Compare Y
        @"ADCMC[0]": u1,
        /// (2/4 of ADCMC) ADC trigger X on Master Compare Y
        @"ADCMC[1]": u1,
        /// (3/4 of ADCMC) ADC trigger X on Master Compare Y
        @"ADCMC[2]": u1,
        /// (4/4 of ADCMC) ADC trigger X on Master Compare Y
        @"ADCMC[3]": u1,
        /// ADC trigger X on Master Period
        ADCMPER: u1,
        /// (1/5 of ADCEEV) ADC trigger X on External Event Y
        @"ADCEEV[0]": u1,
        /// (2/5 of ADCEEV) ADC trigger X on External Event Y
        @"ADCEEV[1]": u1,
        /// (3/5 of ADCEEV) ADC trigger X on External Event Y
        @"ADCEEV[2]": u1,
        /// (4/5 of ADCEEV) ADC trigger X on External Event Y
        @"ADCEEV[3]": u1,
        /// (5/5 of ADCEEV) ADC trigger X on External Event Y
        @"ADCEEV[4]": u1,
        /// ADC trigger X on Timer Y Compare 2
        @"ADCTC2[0]": u1,
        /// ADC trigger X on Timer Y Compare 2
        @"ADCTC2[5]": u1,
        /// ADC trigger X on Timer Y Compare 3
        @"ADCTC4[0]": u1,
        /// ADC trigger X on Timer Y Period
        @"ADCTPER[0]": u1,
        /// ADC trigger X on Timer Y Compare 2
        @"ADCTC2[1]": u1,
        /// ADC trigger X on Timer Y Compare 3
        @"ADCTC3[1]": u1,
        /// ADC trigger X on Timer Y Compare 3
        @"ADCTC4[1]": u1,
        /// ADC trigger X on Timer Y Period
        @"ADCTPER[1]": u1,
        /// ADC trigger X on Timer Y Compare 2
        @"ADCTC2[2]": u1,
        reserved20: u1 = 0,
        /// ADC trigger X on Timer Y Compare 3
        @"ADCTC4[2]": u1,
        /// ADC trigger X on Timer Y Period
        @"ADCTPER[2]": u1,
        /// ADC trigger X on Timer Y Reset
        @"ADCTRST[0]": u1,
        /// ADC trigger X on Timer Y Compare 2
        @"ADCTC2[3]": u1,
        /// ADC trigger X on Timer Y Period
        @"ADCTPER[4]": u1,
        /// ADC trigger X on Timer Y Compare 3
        @"ADCTC4[3]": u1,
        /// ADC trigger X on Timer Y Period
        @"ADCTPER[3]": u1,
        /// ADC trigger X on Timer Y Reset
        @"ADCTRST[1]": u1,
        /// ADC trigger X on Timer Y Compare 2
        @"ADCTC2[4]": u1,
        /// ADC trigger X on Timer Y Compare 3
        @"ADCTC3[0]": u1,
        /// ADC trigger X on Timer Y Compare 3
        @"ADCTC4[4]": u1,
        /// ADC trigger X on Timer Y Reset
        @"ADCTRST[2]": u1,
    }),
    /// offset: 0x3c4
    reserved964: [8]u8,
    /// High Resolution Timer: DLL Control Register
    /// offset: 0x3cc
    DLLCR: mmio.Mmio(packed struct(u32) {
        /// DLL Calibration Start
        CAL: u1,
        /// DLL Calibration Enable
        CALEN: u1,
        /// DLL Calibration Rate
        CALRTE: u2,
        padding: u28 = 0,
    }),
    /// High Resolution Timer: Fault Input Register 1
    /// offset: 0x3d0
    FLTINR1: mmio.Mmio(packed struct(u32) {
        /// Fault X enable
        @"FLTE[0]": u1,
        /// Fault X polarity
        @"FLTP[0]": u1,
        /// Fault X source
        @"FLTSRC[0]": u1,
        /// Fault X filter
        @"FLTF[0]": u4,
        /// Fault X Lock
        @"FLTLCK[0]": u1,
        /// Fault X enable
        @"FLTE[1]": u1,
        /// Fault X polarity
        @"FLTP[1]": u1,
        /// Fault X source
        @"FLTSRC[1]": u1,
        /// Fault X filter
        @"FLTF[1]": u4,
        /// Fault X Lock
        @"FLTLCK[1]": u1,
        /// Fault X enable
        @"FLTE[2]": u1,
        /// Fault X polarity
        @"FLTP[2]": u1,
        /// Fault X source
        @"FLTSRC[2]": u1,
        /// Fault X filter
        @"FLTF[2]": u4,
        /// Fault X Lock
        @"FLTLCK[2]": u1,
        /// Fault X enable
        @"FLTE[3]": u1,
        /// Fault X polarity
        @"FLTP[3]": u1,
        /// Fault X source
        @"FLTSRC[3]": u1,
        /// Fault X filter
        @"FLTF[3]": u4,
        /// Fault X Lock
        @"FLTLCK[3]": u1,
    }),
    /// offset: 0x3d4
    reserved980: [4]u8,
    /// High Resolution Timer: Burst DMA Master timer update Register
    /// offset: 0x3d8
    BDMUPR: mmio.Mmio(packed struct(u32) {
        /// MCR register update enable
        MCR: u1,
        /// MICR register update enable
        MICR: u1,
        /// MDIER register update enable
        MDIER: u1,
        /// MCNT register update enable
        MCNT: u1,
        /// MPER register update enable
        MPER: u1,
        /// MREP register update enable
        MREP: u1,
        /// (1/4 of MCMP) MCMP register X update enable
        @"MCMP[0]": u1,
        /// (2/4 of MCMP) MCMP register X update enable
        @"MCMP[1]": u1,
        /// (3/4 of MCMP) MCMP register X update enable
        @"MCMP[2]": u1,
        /// (4/4 of MCMP) MCMP register X update enable
        @"MCMP[3]": u1,
        padding: u22 = 0,
    }),
    /// High Resolution Timer: Burst DMA Timer X update Register
    /// offset: 0x3dc
    BDTUPR: [5]mmio.Mmio(packed struct(u32) {
        /// CR register update enable
        CR: u1,
        /// ICR register update enable
        ICR: u1,
        /// DIER register update enable
        DIER: u1,
        /// CNT register update enable
        CNT: u1,
        /// PER register update enable
        PER: u1,
        /// REP register update enable
        REP: u1,
        /// (1/4 of CMP) CMP register X update enable
        @"CMP[0]": u1,
        /// (2/4 of CMP) CMP register X update enable
        @"CMP[1]": u1,
        /// (3/4 of CMP) CMP register X update enable
        @"CMP[2]": u1,
        /// (4/4 of CMP) CMP register X update enable
        @"CMP[3]": u1,
        padding: u22 = 0,
    }),
    /// High Resolution Timer: Burst DMA Data Register
    /// offset: 0x3f0
    BDMADR: mmio.Mmio(packed struct(u32) {
        /// Burst DMA Data register
        BDMADR: u31,
        padding: u1 = 0,
    }),
};

/// High Resolution Timer: Timing Unit
pub const HRTIM_TIMX = extern struct {
    /// Timer X Control Register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// HRTIM Timer x Clock prescaler
        CKPSC: u3,
        /// Continuous mode
        CONT: u1,
        /// Re-triggerable mode
        RETRIG: u1,
        /// Half mode enable
        HALF: u1,
        /// Push-Pull mode enable
        PSHPLL: u1,
        reserved10: u3 = 0,
        /// Synchronization Resets Timer X
        SYNCRST: SYNCRST,
        /// Synchronization Starts Timer X
        SYNCSTRT: SYNCSTRT,
        /// Delayed CMP2 mode
        DELCMP2: DELCMP,
        /// Delayed CMP4 mode
        DELCMP4: DELCMP,
        reserved17: u1 = 0,
        /// Timer X Repetition update
        REPU: u1,
        /// Timer X reset update
        RSTU: u1,
        /// Timer A update
        TAU: u1,
        /// Timer B update
        TBU: u1,
        /// Timer C update
        TCU: u1,
        /// Timer D update
        TDU: u1,
        /// Timer E update
        TEU: u1,
        /// Master Timer update
        MSTU: u1,
        /// AC Synchronization
        DACSYNC: DACSYNC,
        /// Preload enable
        PREEN: u1,
        /// Update Gating
        UPDGAT: UPDGAT,
    }),
    /// Timer X Interrupt Status Register
    /// offset: 0x04
    ISR: mmio.Mmio(packed struct(u32) {
        /// (1/4 of CMP) Compare X Interrupt Flag
        @"CMP[0]": u1,
        /// (2/4 of CMP) Compare X Interrupt Flag
        @"CMP[1]": u1,
        /// (3/4 of CMP) Compare X Interrupt Flag
        @"CMP[2]": u1,
        /// (4/4 of CMP) Compare X Interrupt Flag
        @"CMP[3]": u1,
        /// Repetition Interrupt Flag
        REP: u1,
        reserved6: u1 = 0,
        /// Update Interrupt Flag
        UPD: u1,
        /// (1/2 of CPT) Capture X Interrupt Flag
        @"CPT[0]": u1,
        /// (2/2 of CPT) Capture X Interrupt Flag
        @"CPT[1]": u1,
        /// Output X Set Interrupt Flag
        @"SETR[0]": u1,
        /// Output X Reset Interrupt Flag
        @"RSTR[0]": u1,
        /// Output X Set Interrupt Flag
        @"SETR[1]": u1,
        /// Output X Reset Interrupt Flag
        @"RSTR[1]": u1,
        /// Reset Interrupt Flag
        RST: u1,
        /// Delayed Protection Flag
        DLYPRT: TIMAISR_DLYPRT,
        reserved16: u1 = 0,
        /// Current Push Pull Status
        CPPSTAT: CPPSTAT,
        /// Idle Push Pull Status
        IPPSTAT: IPPSTAT,
        /// (1/2 of OSTAT) Output X State
        @"OSTAT[0]": OUTPUTSTATE,
        /// (2/2 of OSTAT) Output X State
        @"OSTAT[1]": OUTPUTSTATE,
        /// (1/2 of OCPY) Output X Copy
        @"OCPY[0]": OUTPUTSTATE,
        /// (2/2 of OCPY) Output X Copy
        @"OCPY[1]": OUTPUTSTATE,
        padding: u10 = 0,
    }),
    /// Timer X Interrupt Clear Register
    /// offset: 0x08
    ICR: mmio.Mmio(packed struct(u32) {
        /// (1/4 of CMPC) Compare X Interrupt flag Clear
        @"CMPC[0]": u1,
        /// (2/4 of CMPC) Compare X Interrupt flag Clear
        @"CMPC[1]": u1,
        /// (3/4 of CMPC) Compare X Interrupt flag Clear
        @"CMPC[2]": u1,
        /// (4/4 of CMPC) Compare X Interrupt flag Clear
        @"CMPC[3]": u1,
        /// Repetition Interrupt flag Clear
        REPC: u1,
        reserved6: u1 = 0,
        /// Update Interrupt flag Clear
        UPDC: u1,
        /// (1/2 of CPTC) Capture X Interrupt flag Clear
        @"CPTC[0]": u1,
        /// (2/2 of CPTC) Capture X Interrupt flag Clear
        @"CPTC[1]": u1,
        /// Output X Set flag Clear
        @"SETRC[0]": u1,
        /// Output X Reset flag Clear
        @"RSTRC[0]": u1,
        /// Output X Set flag Clear
        @"SETRC[1]": u1,
        /// Output X Reset flag Clear
        @"RSTRC[1]": u1,
        /// Reset Interrupt flag Clear
        RSTC: u1,
        /// Delayed Protection Flag Clear
        DLYPRTC: u1,
        padding: u17 = 0,
    }),
    /// Timer X DMA / Interrupt Enable Register
    /// offset: 0x0c
    DIER: mmio.Mmio(packed struct(u32) {
        /// (1/4 of CMPIE) Compare X Interrupt Enable
        @"CMPIE[0]": u1,
        /// (2/4 of CMPIE) Compare X Interrupt Enable
        @"CMPIE[1]": u1,
        /// (3/4 of CMPIE) Compare X Interrupt Enable
        @"CMPIE[2]": u1,
        /// (4/4 of CMPIE) Compare X Interrupt Enable
        @"CMPIE[3]": u1,
        /// Repetition Interrupt Enable
        REPIE: u1,
        reserved6: u1 = 0,
        /// Update Interrupt Enable
        UPDIE: u1,
        /// (1/2 of CPTIE) Capture Interrupt Enable
        @"CPTIE[0]": u1,
        /// (2/2 of CPTIE) Capture Interrupt Enable
        @"CPTIE[1]": u1,
        /// Output X Set Interrupt Enable
        @"SETRIE[0]": u1,
        /// Output X Reset Interrupt Enable
        @"RSTRIE[0]": u1,
        /// Output X Set Interrupt Enable
        @"SETRIE[1]": u1,
        /// Output X Reset Interrupt Enable
        @"RSTRIE[1]": u1,
        /// Reset/roll-over Interrupt Enable
        RSTIE: u1,
        /// Delayed Protection Interrupt Enable
        DLYPRTIE: u1,
        reserved16: u1 = 0,
        /// (1/4 of CMPDE) Compare X DMA request Enable
        @"CMPDE[0]": u1,
        /// (2/4 of CMPDE) Compare X DMA request Enable
        @"CMPDE[1]": u1,
        /// (3/4 of CMPDE) Compare X DMA request Enable
        @"CMPDE[2]": u1,
        /// (4/4 of CMPDE) Compare X DMA request Enable
        @"CMPDE[3]": u1,
        /// Repetition DMA request Enable
        REPDE: u1,
        reserved22: u1 = 0,
        /// Update DMA request Enable
        UPDDE: u1,
        /// (1/2 of CPTDE) Capture X DMA request Enable
        @"CPTDE[0]": u1,
        /// (2/2 of CPTDE) Capture X DMA request Enable
        @"CPTDE[1]": u1,
        /// Output X Set DMA request Enable
        @"SETRDE[0]": u1,
        /// Output X Reset DMA request Enable
        @"RSTRDE[0]": u1,
        /// Output X Set DMA request Enable
        @"SETRDE[1]": u1,
        /// Output X Reset DMA request Enable
        @"RSTRDE[1]": u1,
        /// Reset/roll-over DMA request Enable
        RSTDE: u1,
        /// Delayed Protection DMA request Enable
        DLYPRTDE: u1,
        padding: u1 = 0,
    }),
    /// Timer X Counter Register
    /// offset: 0x10
    CNT: mmio.Mmio(packed struct(u32) {
        /// Timerx Counter value
        CNT: u16,
        padding: u16 = 0,
    }),
    /// Timer X Period Register
    /// offset: 0x14
    PER: mmio.Mmio(packed struct(u32) {
        /// Timerx Period value
        PER: u16,
        padding: u16 = 0,
    }),
    /// Timer X Repetition Register
    /// offset: 0x18
    REP: mmio.Mmio(packed struct(u32) {
        /// Timerx Repetition counter value
        REP: u8,
        padding: u24 = 0,
    }),
    /// Timer X Compare X Register
    /// offset: 0x1c
    CMP: mmio.Mmio(packed struct(u32) {
        /// Timerx Compare X value
        CMP: u16,
        padding: u16 = 0,
    }),
    /// Timer X Compare X Compound Register
    /// offset: 0x20
    CMPC: mmio.Mmio(packed struct(u32) {
        /// Timerx Compare X value
        CMP: u16,
        /// Timerx Repetition value (aliased from HRTIM_REPx register)
        REP: u8,
        padding: u8 = 0,
    }),
    /// offset: 0x24
    reserved36: [12]u8,
    /// Timer X Capture X Register
    /// offset: 0x30
    CPT: [2]mmio.Mmio(packed struct(u32) {
        /// Timerx Capture X value
        CPT: u16,
        padding: u16 = 0,
    }),
    /// Timer X Deadtime Register
    /// offset: 0x38
    DT: mmio.Mmio(packed struct(u32) {
        /// Deadtime Rising value
        DTR: u9,
        /// Sign Deadtime Rising value
        SDTR: SDTR,
        /// Deadtime Prescaler
        DTPRSC: u3,
        reserved14: u1 = 0,
        /// Deadtime Rising Sign Lock
        DTRSLK: u1,
        /// Deadtime Rising Lock
        DTRLK: u1,
        /// Deadtime Falling value
        DTF: u9,
        /// Sign Deadtime Falling value
        SDTF: SDTF,
        reserved30: u4 = 0,
        /// Deadtime Falling Sign Lock
        DTFSLK: u1,
        /// Deadtime Falling Lock
        DTFLK: u1,
    }),
    /// Timer X Output X Set Register
    /// offset: 0x3c
    SETR: mmio.Mmio(packed struct(u32) {
        /// Software Set trigger
        SST: ACTIVEEFFECT,
        /// Timer X resynchronizaton
        RESYNC: ACTIVEEFFECT,
        /// Timer X Period
        PER: ACTIVEEFFECT,
        /// (1/4 of CMP) Timer X compare X
        @"CMP[0]": ACTIVEEFFECT,
        /// (2/4 of CMP) Timer X compare X
        @"CMP[1]": ACTIVEEFFECT,
        /// (3/4 of CMP) Timer X compare X
        @"CMP[2]": ACTIVEEFFECT,
        /// (4/4 of CMP) Timer X compare X
        @"CMP[3]": ACTIVEEFFECT,
        /// Master Period
        MSTPER: ACTIVEEFFECT,
        /// (1/4 of MSTCMPX) Master Compare X
        @"MSTCMPX[0]": ACTIVEEFFECT,
        /// (2/4 of MSTCMPX) Master Compare X
        @"MSTCMPX[1]": ACTIVEEFFECT,
        /// (3/4 of MSTCMPX) Master Compare X
        @"MSTCMPX[2]": ACTIVEEFFECT,
        /// (4/4 of MSTCMPX) Master Compare X
        @"MSTCMPX[3]": ACTIVEEFFECT,
        /// (1/9 of TIMEVNT) Timer Event X
        @"TIMEVNT[0]": ACTIVEEFFECT,
        /// (2/9 of TIMEVNT) Timer Event X
        @"TIMEVNT[1]": ACTIVEEFFECT,
        /// (3/9 of TIMEVNT) Timer Event X
        @"TIMEVNT[2]": ACTIVEEFFECT,
        /// (4/9 of TIMEVNT) Timer Event X
        @"TIMEVNT[3]": ACTIVEEFFECT,
        /// (5/9 of TIMEVNT) Timer Event X
        @"TIMEVNT[4]": ACTIVEEFFECT,
        /// (6/9 of TIMEVNT) Timer Event X
        @"TIMEVNT[5]": ACTIVEEFFECT,
        /// (7/9 of TIMEVNT) Timer Event X
        @"TIMEVNT[6]": ACTIVEEFFECT,
        /// (8/9 of TIMEVNT) Timer Event X
        @"TIMEVNT[7]": ACTIVEEFFECT,
        /// (9/9 of TIMEVNT) Timer Event X
        @"TIMEVNT[8]": ACTIVEEFFECT,
        /// (1/10 of EXTEVNT) External Event X
        @"EXTEVNT[0]": ACTIVEEFFECT,
        /// (2/10 of EXTEVNT) External Event X
        @"EXTEVNT[1]": ACTIVEEFFECT,
        /// (3/10 of EXTEVNT) External Event X
        @"EXTEVNT[2]": ACTIVEEFFECT,
        /// (4/10 of EXTEVNT) External Event X
        @"EXTEVNT[3]": ACTIVEEFFECT,
        /// (5/10 of EXTEVNT) External Event X
        @"EXTEVNT[4]": ACTIVEEFFECT,
        /// (6/10 of EXTEVNT) External Event X
        @"EXTEVNT[5]": ACTIVEEFFECT,
        /// (7/10 of EXTEVNT) External Event X
        @"EXTEVNT[6]": ACTIVEEFFECT,
        /// (8/10 of EXTEVNT) External Event X
        @"EXTEVNT[7]": ACTIVEEFFECT,
        /// (9/10 of EXTEVNT) External Event X
        @"EXTEVNT[8]": ACTIVEEFFECT,
        /// (10/10 of EXTEVNT) External Event X
        @"EXTEVNT[9]": ACTIVEEFFECT,
        /// Registers update (transfer preload to active)
        UPDATE: ACTIVEEFFECT,
    }),
    /// Timer X Output X Reset Register
    /// offset: 0x40
    RSTR: mmio.Mmio(packed struct(u32) {
        /// Software Reset trigger
        SRT: INACTIVEEFFECT,
        /// Timer X resynchronizaton
        RESYNC: INACTIVEEFFECT,
        /// Timer X Period
        PER: INACTIVEEFFECT,
        /// (1/4 of CMP) Timer X compare X
        @"CMP[0]": INACTIVEEFFECT,
        /// (2/4 of CMP) Timer X compare X
        @"CMP[1]": INACTIVEEFFECT,
        /// (3/4 of CMP) Timer X compare X
        @"CMP[2]": INACTIVEEFFECT,
        /// (4/4 of CMP) Timer X compare X
        @"CMP[3]": INACTIVEEFFECT,
        /// Master Period
        MSTPER: INACTIVEEFFECT,
        /// (1/4 of MSTCMP) Master Compare X
        @"MSTCMP[0]": INACTIVEEFFECT,
        /// (2/4 of MSTCMP) Master Compare X
        @"MSTCMP[1]": INACTIVEEFFECT,
        /// (3/4 of MSTCMP) Master Compare X
        @"MSTCMP[2]": INACTIVEEFFECT,
        /// (4/4 of MSTCMP) Master Compare X
        @"MSTCMP[3]": INACTIVEEFFECT,
        /// (1/9 of TIMEVNT) Timer Event X
        @"TIMEVNT[0]": INACTIVEEFFECT,
        /// (2/9 of TIMEVNT) Timer Event X
        @"TIMEVNT[1]": INACTIVEEFFECT,
        /// (3/9 of TIMEVNT) Timer Event X
        @"TIMEVNT[2]": INACTIVEEFFECT,
        /// (4/9 of TIMEVNT) Timer Event X
        @"TIMEVNT[3]": INACTIVEEFFECT,
        /// (5/9 of TIMEVNT) Timer Event X
        @"TIMEVNT[4]": INACTIVEEFFECT,
        /// (6/9 of TIMEVNT) Timer Event X
        @"TIMEVNT[5]": INACTIVEEFFECT,
        /// (7/9 of TIMEVNT) Timer Event X
        @"TIMEVNT[6]": INACTIVEEFFECT,
        /// (8/9 of TIMEVNT) Timer Event X
        @"TIMEVNT[7]": INACTIVEEFFECT,
        /// (9/9 of TIMEVNT) Timer Event X
        @"TIMEVNT[8]": INACTIVEEFFECT,
        /// (1/10 of EXTEVNT) External Event X
        @"EXTEVNT[0]": INACTIVEEFFECT,
        /// (2/10 of EXTEVNT) External Event X
        @"EXTEVNT[1]": INACTIVEEFFECT,
        /// (3/10 of EXTEVNT) External Event X
        @"EXTEVNT[2]": INACTIVEEFFECT,
        /// (4/10 of EXTEVNT) External Event X
        @"EXTEVNT[3]": INACTIVEEFFECT,
        /// (5/10 of EXTEVNT) External Event X
        @"EXTEVNT[4]": INACTIVEEFFECT,
        /// (6/10 of EXTEVNT) External Event X
        @"EXTEVNT[5]": INACTIVEEFFECT,
        /// (7/10 of EXTEVNT) External Event X
        @"EXTEVNT[6]": INACTIVEEFFECT,
        /// (8/10 of EXTEVNT) External Event X
        @"EXTEVNT[7]": INACTIVEEFFECT,
        /// (9/10 of EXTEVNT) External Event X
        @"EXTEVNT[8]": INACTIVEEFFECT,
        /// (10/10 of EXTEVNT) External Event X
        @"EXTEVNT[9]": INACTIVEEFFECT,
        /// Registers update (transfer preload to active)
        UPDATE: INACTIVEEFFECT,
    }),
    /// offset: 0x44
    reserved68: [8]u8,
    /// Timer X External Event Filtering Register 1
    /// offset: 0x4c
    EEF: mmio.Mmio(packed struct(u32) {
        /// (1/5 of LTCH) External Event X latch
        @"LTCH[0]": u1,
        /// (1/5 of FLTR) External Event X filter
        @"FLTR[0]": EEFLTR,
        reserved6: u1 = 0,
        /// (2/5 of LTCH) External Event X latch
        @"LTCH[1]": u1,
        /// (2/5 of FLTR) External Event X filter
        @"FLTR[1]": EEFLTR,
        reserved12: u1 = 0,
        /// (3/5 of LTCH) External Event X latch
        @"LTCH[2]": u1,
        /// (3/5 of FLTR) External Event X filter
        @"FLTR[2]": EEFLTR,
        reserved18: u1 = 0,
        /// (4/5 of LTCH) External Event X latch
        @"LTCH[3]": u1,
        /// (4/5 of FLTR) External Event X filter
        @"FLTR[3]": EEFLTR,
        reserved24: u1 = 0,
        /// (5/5 of LTCH) External Event X latch
        @"LTCH[4]": u1,
        /// (5/5 of FLTR) External Event X filter
        @"FLTR[4]": EEFLTR,
        padding: u3 = 0,
    }),
    /// offset: 0x50
    reserved80: [4]u8,
    /// Timer X Reset Register
    /// offset: 0x54
    RST: mmio.Mmio(packed struct(u32) {
        /// Timer X compare 1 event
        @"TCMP1[4]": RESETEFFECT,
        /// Timer X Update reset
        UPDT: RESETEFFECT,
        /// (1/2 of CMP) Timer X compare X reset
        @"CMP[0]": RESETEFFECT,
        /// (2/2 of CMP) Timer X compare X reset
        @"CMP[1]": RESETEFFECT,
        /// Master timer Period
        MSTPER: RESETEFFECT,
        /// (1/4 of MSTCMP) Master compare X
        @"MSTCMP[0]": RESETEFFECT,
        /// (2/4 of MSTCMP) Master compare X
        @"MSTCMP[1]": RESETEFFECT,
        /// (3/4 of MSTCMP) Master compare X
        @"MSTCMP[2]": RESETEFFECT,
        /// (4/4 of MSTCMP) Master compare X
        @"MSTCMP[3]": RESETEFFECT,
        /// (1/10 of EXTEVNT) External Event X
        @"EXTEVNT[0]": RESETEFFECT,
        /// (2/10 of EXTEVNT) External Event X
        @"EXTEVNT[1]": RESETEFFECT,
        /// (3/10 of EXTEVNT) External Event X
        @"EXTEVNT[2]": RESETEFFECT,
        /// (4/10 of EXTEVNT) External Event X
        @"EXTEVNT[3]": RESETEFFECT,
        /// (5/10 of EXTEVNT) External Event X
        @"EXTEVNT[4]": RESETEFFECT,
        /// (6/10 of EXTEVNT) External Event X
        @"EXTEVNT[5]": RESETEFFECT,
        /// (7/10 of EXTEVNT) External Event X
        @"EXTEVNT[6]": RESETEFFECT,
        /// (8/10 of EXTEVNT) External Event X
        @"EXTEVNT[7]": RESETEFFECT,
        /// (9/10 of EXTEVNT) External Event X
        @"EXTEVNT[8]": RESETEFFECT,
        /// (10/10 of EXTEVNT) External Event X
        @"EXTEVNT[9]": RESETEFFECT,
        /// Timer X compare 1 event
        @"TCMP1[0]": RESETEFFECT,
        /// Timer X compare 2 event
        @"TCMP2[0]": RESETEFFECT,
        /// Timer X compare 4 event
        @"TCMP4[0]": RESETEFFECT,
        /// Timer X compare 1 event
        @"TCMP1[1]": RESETEFFECT,
        /// Timer X compare 2 event
        @"TCMP2[1]": RESETEFFECT,
        /// Timer X compare 4 event
        @"TCMP4[1]": RESETEFFECT,
        /// Timer X compare 1 event
        @"TCMP1[2]": RESETEFFECT,
        /// Timer X compare 2 event
        @"TCMP2[2]": RESETEFFECT,
        /// Timer X compare 4 event
        @"TCMP4[2]": RESETEFFECT,
        /// Timer X compare 1 event
        @"TCMP1[3]": RESETEFFECT,
        /// Timer X compare 2 event
        @"TCMP2[3]": RESETEFFECT,
        /// Timer X compare 4 event
        @"TCMP4[3]": RESETEFFECT,
        /// Timer X compare 2 event
        @"TCMP2[4]": RESETEFFECT,
    }),
    /// Timer X Chopper Register
    /// offset: 0x58
    CHP: mmio.Mmio(packed struct(u32) {
        /// Timerx carrier frequency value
        CARFRQ: u4,
        /// Timerx chopper duty cycle value
        CARDTY: u3,
        /// Timerx start pulsewidth
        STRTPW: u4,
        padding: u21 = 0,
    }),
    /// Timer X Capture X Control Register
    /// offset: 0x5c
    CCR: mmio.Mmio(packed struct(u32) {
        /// Software Capture
        SWCPT: CAPTUREEFFECT,
        /// Update Capture
        UPDCPT: CAPTUREEFFECT,
        /// (1/10 of EXEVCPT) External Event X Capture
        @"EXEVCPT[0]": CAPTUREEFFECT,
        /// (2/10 of EXEVCPT) External Event X Capture
        @"EXEVCPT[1]": CAPTUREEFFECT,
        /// (3/10 of EXEVCPT) External Event X Capture
        @"EXEVCPT[2]": CAPTUREEFFECT,
        /// (4/10 of EXEVCPT) External Event X Capture
        @"EXEVCPT[3]": CAPTUREEFFECT,
        /// (5/10 of EXEVCPT) External Event X Capture
        @"EXEVCPT[4]": CAPTUREEFFECT,
        /// (6/10 of EXEVCPT) External Event X Capture
        @"EXEVCPT[5]": CAPTUREEFFECT,
        /// (7/10 of EXEVCPT) External Event X Capture
        @"EXEVCPT[6]": CAPTUREEFFECT,
        /// (8/10 of EXEVCPT) External Event X Capture
        @"EXEVCPT[7]": CAPTUREEFFECT,
        /// (9/10 of EXEVCPT) External Event X Capture
        @"EXEVCPT[8]": CAPTUREEFFECT,
        /// (10/10 of EXEVCPT) External Event X Capture
        @"EXEVCPT[9]": CAPTUREEFFECT,
        reserved16: u4 = 0,
        /// Timer X output Set
        TXSET: CAPTUREEFFECT,
        /// Timer X output Reset
        TXRST: CAPTUREEFFECT,
        /// (1/2 of TXCMP) Timer X Compare X
        @"TXCMP[0]": CAPTUREEFFECT,
        /// (2/2 of TXCMP) Timer X Compare X
        @"TXCMP[1]": CAPTUREEFFECT,
        /// Timer Y output Set
        TYSET: CAPTUREEFFECT,
        /// Timer Y output Reset
        TYRST: CAPTUREEFFECT,
        /// (1/2 of TYCMP) Timer Y Compare X
        @"TYCMP[0]": CAPTUREEFFECT,
        /// (2/2 of TYCMP) Timer Y Compare X
        @"TYCMP[1]": CAPTUREEFFECT,
        /// Timer Z output Set
        TZSET: CAPTUREEFFECT,
        /// Timer Z output Reset
        TZRST: CAPTUREEFFECT,
        /// (1/2 of TZCMP) Timer Z Compare X
        @"TZCMP[0]": CAPTUREEFFECT,
        /// (2/2 of TZCMP) Timer Z Compare X
        @"TZCMP[1]": CAPTUREEFFECT,
        /// Timer T output Set
        TTSET: CAPTUREEFFECT,
        /// Timer T output Reset
        TTRST: CAPTUREEFFECT,
        /// (1/2 of TTCMP) Timer T Compare X
        @"TTCMP[0]": CAPTUREEFFECT,
        /// (2/2 of TTCMP) Timer T Compare X
        @"TTCMP[1]": CAPTUREEFFECT,
    }),
    /// offset: 0x60
    reserved96: [4]u8,
    /// Timer X Output Register
    /// offset: 0x64
    OUTR: mmio.Mmio(packed struct(u32) {
        reserved1: u1 = 0,
        /// Output 1 polarity
        @"POL[0]": POL,
        /// Output X Idle mode
        @"IDLEM[0]": u1,
        /// Output X Idle State
        @"IDLES[0]": u1,
        /// Output X Fault state
        @"FAULTX[0]": FAULT,
        /// Output X Chopper enable
        @"CHP[0]": u1,
        /// Output X Deadtime upon burst mode Idle entry
        @"DIDL[0]": u1,
        /// Deadtime enable
        DTEN: u1,
        /// Delayed Protection Enable
        DLYPRTEN: u1,
        /// Delayed Protection
        DLYPRT: DLYPRT,
        reserved17: u4 = 0,
        /// Output 1 polarity
        @"POL[1]": POL,
        /// Output X Idle mode
        @"IDLEM[1]": u1,
        /// Output X Idle State
        @"IDLES[1]": u1,
        /// Output X Fault state
        @"FAULTX[1]": FAULT,
        /// Output X Chopper enable
        @"CHP[1]": u1,
        /// Output X Deadtime upon burst mode Idle entry
        @"DIDL[1]": u1,
        padding: u8 = 0,
    }),
    /// Timer X Fault Register
    /// offset: 0x68
    FLT: mmio.Mmio(packed struct(u32) {
        /// (1/5 of FLTEN) Fault X enable
        @"FLTEN[0]": FLTEN,
        /// (2/5 of FLTEN) Fault X enable
        @"FLTEN[1]": FLTEN,
        /// (3/5 of FLTEN) Fault X enable
        @"FLTEN[2]": FLTEN,
        /// (4/5 of FLTEN) Fault X enable
        @"FLTEN[3]": FLTEN,
        /// (5/5 of FLTEN) Fault X enable
        @"FLTEN[4]": FLTEN,
        reserved31: u26 = 0,
        /// Fault sources Lock
        FLTLCK: u1,
    }),
};
