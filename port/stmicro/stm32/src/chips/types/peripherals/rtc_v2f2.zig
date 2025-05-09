const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

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
        reserved6: u1 = 0,
        /// Hour format
        FMT: u1,
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
        reserved20: u1 = 0,
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
        reserved4: u1 = 0,
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
        /// (1/1 of TAMPF) Tamper detection flag
        @"TAMPF[0]": u1,
        padding: u18 = 0,
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
    /// offset: 0x28
    reserved40: [8]u8,
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
    /// offset: 0x38
    reserved56: [8]u8,
    /// Tamper and alternate function configuration register
    /// offset: 0x40
    TAFCR: mmio.Mmio(packed struct(u32) {
        /// Tamper detection enable
        @"TAMPE[0]": u1,
        /// Active level for tamper
        @"TAMPTRG[0]": TAMPTRG,
        /// Tamper interrupt enable
        TAMPIE: u1,
        reserved16: u13 = 0,
        /// Tamper 1 mapping
        TAMP1INSEL: u1,
        /// Timestamp mapping
        TSINSEL: u1,
        /// AFO_ALARM output type
        ALARMOUTTYPE: u1,
        padding: u13 = 0,
    }),
    /// offset: 0x44
    reserved68: [12]u8,
    /// Backup register
    /// offset: 0x50
    BKPR: [20]mmio.Mmio(packed struct(u32) {
        /// BKP
        BKP: u32,
    }),
};
