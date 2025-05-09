const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const ALRMR_MSK = enum(u1) {
    /// Alarm set if the date/day match
    ToMatch = 0x0,
    /// Date/day don’t care in Alarm comparison
    NotMatch = 0x1,
};

pub const ALRMR_PM = enum(u1) {
    /// AM or 24-hour format
    AM = 0x0,
    /// PM
    PM = 0x1,
};

pub const ALRMR_WDSEL = enum(u1) {
    /// DU[3:0] represents the date units
    DateUnits = 0x0,
    /// DU[3:0] represents the week day. DT[1:0] is don’t care
    WeekDay = 0x1,
};

pub const AMPM = enum(u1) {
    /// AM or 24-hour format
    AM = 0x0,
    /// PM
    PM = 0x1,
};

pub const CALP = enum(u1) {
    /// No RTCCLK pulses are added
    NoChange = 0x0,
    /// One RTCCLK pulse is effectively inserted every 2^11 pulses (frequency increased by 488.5 ppm)
    IncreaseFreq = 0x1,
};

pub const CALW16 = enum(u1) {
    /// When CALW16 is set to ‘1’, the 16-second calibration cycle period is selected.This bit must not be set to ‘1’ if CALW8=1
    Sixteen_Second = 0x1,
    _,
};

pub const CALW8 = enum(u1) {
    /// When CALW8 is set to ‘1’, the 8-second calibration cycle period is selected
    Eight_Second = 0x1,
    _,
};

pub const COSEL = enum(u1) {
    /// Calibration output is 512 Hz (with default prescaler setting)
    CalFreq_512Hz = 0x0,
    /// Calibration output is 1 Hz (with default prescaler setting)
    CalFreq_1Hz = 0x1,
};

pub const FMT = enum(u1) {
    /// 24 hour/day format
    Twenty_Four_Hour = 0x0,
    /// AM/PM hour format
    AM_PM = 0x1,
};

pub const OSEL = enum(u2) {
    /// Output disabled
    Disabled = 0x0,
    /// Alarm A output enabled
    AlarmA = 0x1,
    /// Alarm B output enabled
    AlarmB = 0x2,
    /// Wakeup output enabled
    Wakeup = 0x3,
};

pub const POL = enum(u1) {
    /// The pin is high when ALRAF/ALRBF/WUTF is asserted (depending on OSEL[1:0])
    High = 0x0,
    /// The pin is low when ALRAF/ALRBF/WUTF is asserted (depending on OSEL[1:0])
    Low = 0x1,
};

pub const RECALPF = enum(u1) {
    /// The RECALPF status flag is automatically set to 1 when software writes to the RTC_CALR register, indicating that the RTC_CALR register is blocked. When the new calibration settings are taken into account, this bit returns to 0
    Pending = 0x1,
    _,
};

pub const TAMPFLT = enum(u2) {
    /// Tamper event is activated on edge of RTC_TAMPx input transitions to the active level (no internal pull-up on RTC_TAMPx input)
    Immediate = 0x0,
    /// Tamper event is activated after 2 consecutive samples at the active level
    Samples2 = 0x1,
    /// Tamper event is activated after 4 consecutive samples at the active level
    Samples4 = 0x2,
    /// Tamper event is activated after 8 consecutive samples at the active level
    Samples8 = 0x3,
};

pub const TAMPFREQ = enum(u3) {
    /// RTCCLK / 32768 (1 Hz when RTCCLK = 32768 Hz)
    Div32768 = 0x0,
    /// RTCCLK / 16384 (2 Hz when RTCCLK = 32768 Hz)
    Div16384 = 0x1,
    /// RTCCLK / 8192 (4 Hz when RTCCLK = 32768 Hz)
    Div8192 = 0x2,
    /// RTCCLK / 4096 (8 Hz when RTCCLK = 32768 Hz)
    Div4096 = 0x3,
    /// RTCCLK / 2048 (16 Hz when RTCCLK = 32768 Hz)
    Div2048 = 0x4,
    /// RTCCLK / 1024 (32 Hz when RTCCLK = 32768 Hz)
    Div1024 = 0x5,
    /// RTCCLK / 512 (64 Hz when RTCCLK = 32768 Hz)
    Div512 = 0x6,
    /// RTCCLK / 256 (128 Hz when RTCCLK = 32768 Hz)
    Div256 = 0x7,
};

pub const TAMPPRCH = enum(u2) {
    /// 1 RTCCLK cycle
    Cycles1 = 0x0,
    /// 2 RTCCLK cycles
    Cycles2 = 0x1,
    /// 4 RTCCLK cycles
    Cycles4 = 0x2,
    /// 8 RTCCLK cycles
    Cycles8 = 0x3,
};

pub const TAMPPUDIS = enum(u1) {
    /// Precharge RTC_TAMPx pins before sampling (enable internal pull-up)
    Enabled = 0x0,
    /// Disable precharge of RTC_TAMPx pins
    Disabled = 0x1,
};

pub const TAMPTRG = enum(u1) {
    /// If TAMPFLT = 00: RTC_TAMPx input rising edge triggers a tamper detection event. If TAMPFLT ≠ 00: RTC_TAMPx input staying low triggers a tamper detection event.
    RisingEdge = 0x0,
    /// If TAMPFLT = 00: RTC_TAMPx input staying high triggers a tamper detection event. If TAMPFLT ≠ 00: RTC_TAMPx input falling edge triggers a tamper detection event
    FallingEdge = 0x1,
};

pub const TSEDGE = enum(u1) {
    /// RTC_TS input rising edge generates a time-stamp event
    RisingEdge = 0x0,
    /// RTC_TS input falling edge generates a time-stamp event
    FallingEdge = 0x1,
};

pub const WUCKSEL = enum(u3) {
    /// RTC/16 clock is selected
    Div16 = 0x0,
    /// RTC/8 clock is selected
    Div8 = 0x1,
    /// RTC/4 clock is selected
    Div4 = 0x2,
    /// RTC/2 clock is selected
    Div2 = 0x3,
    /// ck_spre (usually 1 Hz) clock is selected
    ClockSpare = 0x4,
    /// ck_spre (usually 1 Hz) clock is selected and 2^16 is added to the WUT counter value
    ClockSpareWithOffset = 0x6,
    _,
};

/// Real-time clock
pub const RTC = extern struct {
    /// Time register
    /// offset: 0x00
    TR: mmio.Mmio(packed struct(u32) {
        /// Second units in BCD format
        SU: u4,
        /// Second tens in BCD format
        ST: u3,
        reserved8: u1 = 0,
        /// Minute units in BCD format
        MNU: u4,
        /// Minute tens in BCD format
        MNT: u3,
        reserved16: u1 = 0,
        /// Hour units in BCD format
        HU: u4,
        /// Hour tens in BCD format
        HT: u2,
        /// AM/PM notation
        PM: AMPM,
        padding: u9 = 0,
    }),
    /// Date register
    /// offset: 0x04
    DR: mmio.Mmio(packed struct(u32) {
        /// Date units in BCD format
        DU: u4,
        /// Date tens in BCD format
        DT: u2,
        reserved8: u2 = 0,
        /// Month units in BCD format
        MU: u4,
        /// Month tens in BCD format
        MT: u1,
        /// Week day units
        WDU: u3,
        /// Year units in BCD format
        YU: u4,
        /// Year tens in BCD format
        YT: u4,
        padding: u8 = 0,
    }),
    /// Control register
    /// offset: 0x08
    CR: mmio.Mmio(packed struct(u32) {
        /// Wakeup clock selection
        WUCKSEL: WUCKSEL,
        /// Timestamp event active edge
        TSEDGE: TSEDGE,
        /// Reference clock detection enable (50 or 60 Hz)
        REFCKON: u1,
        /// Bypass the shadow registers
        BYPSHAD: u1,
        /// Hour format
        FMT: FMT,
        /// Coarse digital calibration enable
        DCE: u1,
        /// (1/2 of ALRE) Alarm enable
        @"ALRE[0]": u1,
        /// (2/2 of ALRE) Alarm enable
        @"ALRE[1]": u1,
        /// Wakeup timer enable
        WUTE: u1,
        /// Timestamp enable
        TSE: u1,
        /// (1/2 of ALRIE) Alarm interrupt enable
        @"ALRIE[0]": u1,
        /// (2/2 of ALRIE) Alarm interrupt enable
        @"ALRIE[1]": u1,
        /// Wakeup timer interrupt enable
        WUTIE: u1,
        /// Timestamp interrupt enable
        TSIE: u1,
        /// Add 1 hour (summer time change)
        ADD1H: u1,
        /// Subtract 1 hour (winter time change)
        SUB1H: u1,
        /// Backup
        BKP: u1,
        /// Calibration output selection
        COSEL: COSEL,
        /// Output polarity
        POL: POL,
        /// Output selection
        OSEL: OSEL,
        /// Calibration output enable
        COE: u1,
        padding: u8 = 0,
    }),
    /// Initialization and status register
    /// offset: 0x0c
    ISR: mmio.Mmio(packed struct(u32) {
        /// (1/2 of ALRWF) Alarm write enabled
        @"ALRWF[0]": u1,
        /// (2/2 of ALRWF) Alarm write enabled
        @"ALRWF[1]": u1,
        /// Wakeup timer write enabled
        WUTWF: u1,
        /// Shift operation pending
        SHPF: u1,
        /// Initialization status flag
        INITS: u1,
        /// Registers synchronization flag
        RSF: u1,
        /// Initialization flag
        INITF: u1,
        /// Enter Initialization mode
        INIT: u1,
        /// (1/2 of ALRF) Alarm flag
        @"ALRF[0]": u1,
        /// (2/2 of ALRF) Alarm flag
        @"ALRF[1]": u1,
        /// Wakeup timer flag
        WUTF: u1,
        /// Timestamp flag
        TSF: u1,
        /// Timestamp overflow flag
        TSOVF: u1,
        /// (1/3 of TAMPF) Tamper detection flag
        @"TAMPF[0]": u1,
        /// (2/3 of TAMPF) Tamper detection flag
        @"TAMPF[1]": u1,
        /// (3/3 of TAMPF) Tamper detection flag
        @"TAMPF[2]": u1,
        /// Recalibration pending flag
        RECALPF: RECALPF,
        padding: u15 = 0,
    }),
    /// Prescaler register
    /// offset: 0x10
    PRER: mmio.Mmio(packed struct(u32) {
        /// Synchronous prescaler factor
        PREDIV_S: u15,
        reserved16: u1 = 0,
        /// Asynchronous prescaler factor
        PREDIV_A: u7,
        padding: u9 = 0,
    }),
    /// Wakeup timer register
    /// offset: 0x14
    WUTR: mmio.Mmio(packed struct(u32) {
        /// Wakeup auto-reload value bits
        WUT: u16,
        padding: u16 = 0,
    }),
    /// Calibration register
    /// offset: 0x18
    CALIBR: mmio.Mmio(packed struct(u32) {
        /// Digital calibration
        DC: u5,
        reserved7: u2 = 0,
        /// Digital calibration sign
        DCS: u1,
        padding: u24 = 0,
    }),
    /// Alarm register
    /// offset: 0x1c
    ALRMR: [2]mmio.Mmio(packed struct(u32) {
        /// Second units in BCD format
        SU: u4,
        /// Second tens in BCD format
        ST: u3,
        /// Alarm seconds mask
        MSK1: ALRMR_MSK,
        /// Minute units in BCD format
        MNU: u4,
        /// Minute tens in BCD format
        MNT: u3,
        /// Alarm minutes mask
        MSK2: ALRMR_MSK,
        /// Hour units in BCD format
        HU: u4,
        /// Hour tens in BCD format
        HT: u2,
        /// AM/PM notation
        PM: ALRMR_PM,
        /// Alarm hours mask
        MSK3: ALRMR_MSK,
        /// Date units or day in BCD format
        DU: u4,
        /// Date tens in BCD format
        DT: u2,
        /// Week day selection
        WDSEL: ALRMR_WDSEL,
        /// Alarm date mask
        MSK4: ALRMR_MSK,
    }),
    /// Write protection register
    /// offset: 0x24
    WPR: mmio.Mmio(packed struct(u32) {
        /// Write protection key
        KEY: u8,
        padding: u24 = 0,
    }),
    /// Sub second register
    /// offset: 0x28
    SSR: mmio.Mmio(packed struct(u32) {
        /// Sub second value
        SS: u16,
        padding: u16 = 0,
    }),
    /// Shift control register
    /// offset: 0x2c
    SHIFTR: mmio.Mmio(packed struct(u32) {
        /// Subtract a fraction of a second
        SUBFS: u15,
        reserved31: u16 = 0,
        /// Add one second
        ADD1S: u1,
    }),
    /// Timestamp time register
    /// offset: 0x30
    TSTR: mmio.Mmio(packed struct(u32) {
        /// Second units in BCD format
        SU: u4,
        /// Second tens in BCD format
        ST: u3,
        reserved8: u1 = 0,
        /// Minute units in BCD format
        MNU: u4,
        /// Minute tens in BCD format
        MNT: u3,
        reserved16: u1 = 0,
        /// Hour units in BCD format
        HU: u4,
        /// Hour tens in BCD format
        HT: u2,
        /// AM/PM notation
        PM: AMPM,
        padding: u9 = 0,
    }),
    /// Timestamp date register
    /// offset: 0x34
    TSDR: mmio.Mmio(packed struct(u32) {
        /// Date units in BCD format
        DU: u4,
        /// Date tens in BCD format
        DT: u2,
        reserved8: u2 = 0,
        /// Month units in BCD format
        MU: u4,
        /// Month tens in BCD format
        MT: u1,
        /// Week day units
        WDU: u3,
        padding: u16 = 0,
    }),
    /// Timestamp sub second register
    /// offset: 0x38
    TSSSR: mmio.Mmio(packed struct(u32) {
        /// Sub second value
        SS: u16,
        padding: u16 = 0,
    }),
    /// Calibration register
    /// offset: 0x3c
    CALR: mmio.Mmio(packed struct(u32) {
        /// Calibration minus
        CALM: u9,
        reserved13: u4 = 0,
        /// Use a 16-second calibration cycle period
        CALW16: CALW16,
        /// Use an 8-second calibration cycle period
        CALW8: CALW8,
        /// Increase frequency of RTC by 488.5 ppm
        CALP: CALP,
        padding: u16 = 0,
    }),
    /// Tamper and alternate function configuration register
    /// offset: 0x40
    TAFCR: mmio.Mmio(packed struct(u32) {
        /// Tamper detection enable
        @"TAMPE[0]": u1,
        /// Active level for tamper
        @"TAMPTRG[0]": TAMPTRG,
        /// Tamper interrupt enable
        TAMPIE: u1,
        /// Tamper detection enable
        @"TAMPE[1]": u1,
        /// Active level for tamper
        @"TAMPTRG[1]": TAMPTRG,
        /// Tamper detection enable
        @"TAMPE[2]": u1,
        /// Active level for tamper
        @"TAMPTRG[2]": TAMPTRG,
        /// Activate timestamp on tamper detection event
        TAMPTS: u1,
        /// Tamper sampling frequency
        TAMPFREQ: TAMPFREQ,
        /// Tamper filter count
        TAMPFLT: TAMPFLT,
        /// Tamper precharge duration
        TAMPPRCH: TAMPPRCH,
        /// Tamper pull-up disable
        TAMPPUDIS: TAMPPUDIS,
        reserved18: u2 = 0,
        /// AFO_ALARM output type
        ALARMOUTTYPE: u1,
        padding: u13 = 0,
    }),
    /// Alarm sub second register
    /// offset: 0x44
    ALRMSSR: [2]mmio.Mmio(packed struct(u32) {
        /// Sub seconds value
        SS: u15,
        reserved24: u9 = 0,
        /// Mask the most-significant bits starting at this bit
        MASKSS: u4,
        padding: u4 = 0,
    }),
    /// offset: 0x4c
    reserved76: [4]u8,
    /// Backup register
    /// offset: 0x50
    BKPR: [32]mmio.Mmio(packed struct(u32) {
        /// BKP
        BKP: u32,
    }),
};
