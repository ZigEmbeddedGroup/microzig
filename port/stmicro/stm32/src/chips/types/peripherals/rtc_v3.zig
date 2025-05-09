const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const ALRF = enum(u1) {
    /// This flag is set by hardware when the time/date registers (RTC_TR and RTC_DR) match the Alarm A register (RTC_ALRMAR)
    Match = 0x1,
    _,
};

pub const ALRMF = enum(u1) {
    /// This flag is set by hardware when the time/date registers (RTC_TR and RTC_DR) match the Alarm A register (RTC_ALRMAR)
    Match = 0x1,
    _,
};

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
    /// DU[3:0] represents the week day. DT[1:0] is don’t care.
    WeekDay = 0x1,
};

pub const ALRMSSR_SSCLR = enum(u1) {
    /// The synchronous binary counter (SS[31:0] in RTC_SSR) is free-running
    FreeRunning = 0x0,
    /// The synchronous binary counter (SS[31:0] in RTC_SSR) is running from 0xFFFF FFFF to RTC_ALRMABINR → SS[31:0] value and is automatically reloaded with 0xFFFF FFFF when reaching RTC_ALRMABINR → SS[31:0]
    ALRMBINR = 0x1,
};

pub const AMPM = enum(u1) {
    /// AM or 24-hour format
    AM = 0x0,
    /// PM
    PM = 0x1,
};

pub const BCDU = enum(u3) {
    /// 1s increment each time SS[7:0]=0
    Bit7 = 0x0,
    /// 1s increment each time SS[8:0]=0
    Bit8 = 0x1,
    /// 1s increment each time SS[9:0]=0
    Bit9 = 0x2,
    /// 1s increment each time SS[10:0]=0
    Bit10 = 0x3,
    /// 1s increment each time SS[11:0]=0
    Bit11 = 0x4,
    /// 1s increment each time SS[12:0]=0
    Bit12 = 0x5,
    /// 1s increment each time SS[13:0]=0
    Bit13 = 0x6,
    /// 1s increment each time SS[14:0]=0
    Bit14 = 0x7,
};

pub const BIN = enum(u2) {
    /// Free running BCD calendar mode (Binary mode disabled)
    BCD = 0x0,
    /// Free running Binary mode (BCD mode disabled)
    Binary = 0x1,
    /// Free running BCD calendar and Binary modes
    BinBCD = 0x2,
    /// Free running BCD calendar and Binary modes
    BinBCD2 = 0x3,
};

pub const CALP = enum(u1) {
    /// No RTCCLK pulses are added
    NoChange = 0x0,
    /// One RTCCLK pulse is effectively inserted every 2^11 pulses (frequency increased by 488.5 ppm)
    IncreaseFreq = 0x1,
};

pub const CALRF = enum(u1) {
    /// Clear interrupt flag by writing 1
    Clear = 0x1,
    _,
};

pub const CALW16 = enum(u1) {
    /// When CALW16 is set to ‘1’, the 16-second calibration cycle period is selected.This bit must not be set to ‘1’ if CALW8=1
    SixteenSeconds = 0x1,
    _,
};

pub const CALW8 = enum(u1) {
    /// When CALW8 is set to ‘1’, the 8-second calibration cycle period is selected
    EightSeconds = 0x1,
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
    TwentyFourHour = 0x0,
    /// AM/PM hour format
    AmPm = 0x1,
};

pub const ITSF = enum(u1) {
    /// This flag is set by hardware when a timestamp on the internal event occurs
    TimestampEvent = 0x1,
    _,
};

pub const ITSMF = enum(u1) {
    /// This flag is set by hardware when a timestamp on the internal event occurs
    TimestampEvent = 0x1,
    _,
};

pub const KEY = enum(u8) {
    /// Activate write protection (any value that is not the keys)
    Activate = 0x0,
    /// Key 2
    Deactivate2 = 0x53,
    /// Key 1
    Deactivate1 = 0xca,
    _,
};

pub const LPCAL = enum(u1) {
    /// Calibration window is 220 RTCCLK, which is a high-consumption mode. This mode should be set only when less than 32s calibration window is required
    RTCCLK = 0x0,
    /// Calibration window is 220 ck_apre, which is the required configuration for ultra-low consumption mode
    CkApre = 0x1,
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

pub const SSRUF = enum(u1) {
    /// This flag is set by hardware when the SSR rolls under 0. SSRUF is not set when SSCLR=1
    Underflow = 0x1,
    _,
};

pub const SSRUMF = enum(u1) {
    /// This flag is set by hardware when the SSR rolls under 0. SSRUF is not set when SSCLR=1
    Underflow = 0x1,
    _,
};

pub const TAMPALRM_TYPE = enum(u1) {
    /// TAMPALRM is push-pull output
    PushPull = 0x0,
    /// TAMPALRM is open-drain output
    OpenDrain = 0x1,
};

pub const TSEDGE = enum(u1) {
    /// RTC_TS input rising edge generates a time-stamp event
    RisingEdge = 0x0,
    /// RTC_TS input falling edge generates a time-stamp event
    FallingEdge = 0x1,
};

pub const TSF = enum(u1) {
    /// This flag is set by hardware when a time-stamp event occurs
    TimestampEvent = 0x1,
    _,
};

pub const TSMF = enum(u1) {
    /// This flag is set by hardware when a time-stamp event occurs
    TimestampEvent = 0x1,
    _,
};

pub const TSOVF = enum(u1) {
    /// This flag is set by hardware when a time-stamp event occurs while TSF is already set
    Overflow = 0x1,
    _,
};

pub const TSOVMF = enum(u1) {
    /// This flag is set by hardware when a time-stamp event occurs while TSF is already set
    Overflow = 0x1,
    _,
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

pub const WUTF = enum(u1) {
    /// This flag is set by hardware when the wakeup auto-reload counter reaches 0
    Zero = 0x1,
    _,
};

pub const WUTMF = enum(u1) {
    /// This flag is set by hardware when the wakeup auto-reload counter reaches 0
    Zero = 0x1,
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
    /// Sub second register
    /// offset: 0x08
    SSR: mmio.Mmio(packed struct(u32) {
        /// Synchronous binary counter
        SS: u32,
    }),
    /// Initialization control and status register
    /// offset: 0x0c
    ICSR: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
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
        /// Binary mode
        BIN: BIN,
        /// BCD update
        BCDU: BCDU,
        reserved16: u3 = 0,
        /// Recalibration pending Flag
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
        /// Wakeup auto-reload output clear value
        WUTOCLR: u16,
    }),
    /// Control register
    /// offset: 0x18
    CR: mmio.Mmio(packed struct(u32) {
        /// Wakeup clock selection
        WUCKSEL: WUCKSEL,
        /// Timestamp event active edge
        TSEDGE: TSEDGE,
        /// RTC_REFIN reference clock detection enable (50 or 60 Hz)
        REFCKON: u1,
        /// Bypass the shadow registers
        BYPSHAD: u1,
        /// Hour format
        FMT: FMT,
        /// SSR underflow interrupt enable
        SSRUIE: u1,
        /// (1/2 of ALRE) Alarm enable
        @"ALRE[0]": u1,
        /// (2/2 of ALRE) Alarm enable
        @"ALRE[1]": u1,
        /// Wakeup timer enable
        WUTE: u1,
        /// Timestamp enable
        TSE: u1,
        /// (1/2 of ALRAIE) Alarm interrupt enable
        @"ALRAIE[0]": u1,
        /// (2/2 of ALRAIE) Alarm interrupt enable
        @"ALRAIE[1]": u1,
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
        /// Timestamp on internal event enable
        ITSE: u1,
        /// Activate timestamp on tamper detection event
        TAMPTS: u1,
        /// Tamper detection output enable on TAMPALRM
        TAMPOE: u1,
        reserved29: u2 = 0,
        /// TAMPALRM pull-up enable
        TAMPALRM_PU: u1,
        /// TAMPALRM output type
        TAMPALRM_TYPE: TAMPALRM_TYPE,
        /// RTC_OUT2 output enable
        OUT2EN: u1,
    }),
    /// offset: 0x1c
    reserved28: [8]u8,
    /// Write protection register
    /// offset: 0x24
    WPR: mmio.Mmio(packed struct(u32) {
        /// Write protection key
        KEY: KEY,
        padding: u24 = 0,
    }),
    /// Calibration register
    /// offset: 0x28
    CALR: mmio.Mmio(packed struct(u32) {
        /// Calibration minus
        CALM: u9,
        reserved12: u3 = 0,
        /// Calibration low-power mode
        LPCAL: LPCAL,
        /// Use a 16-second calibration cycle period
        CALW16: CALW16,
        /// Use an 8-second calibration cycle period
        CALW8: CALW8,
        /// Increase frequency of RTC by 488.5 ppm
        CALP: CALP,
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
        PM: u1,
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
        SS: u32,
    }),
    /// offset: 0x3c
    reserved60: [4]u8,
    /// Alarm register
    /// offset: 0x40
    ALRMR: mmio.Mmio(packed struct(u32) {
        /// Second units in BCD format
        SU: u4,
        /// Second tens in BCD format
        ST: u3,
        /// Alarm A seconds mask
        MSK1: ALRMR_MSK,
        /// Minute units in BCD format
        MNU: u4,
        /// Minute tens in BCD format
        MNT: u3,
        /// Alarm A minutes mask
        MSK2: ALRMR_MSK,
        /// Hour units in BCD format
        HU: u4,
        /// Hour tens in BCD format
        HT: u2,
        /// AM/PM notation
        PM: ALRMR_PM,
        /// Alarm A hours mask
        MSK3: ALRMR_MSK,
        /// Date units or day in BCD format
        DU: u4,
        /// Date tens in BCD format
        DT: u2,
        /// Week day selection
        WDSEL: ALRMR_WDSEL,
        /// Alarm A date mask
        MSK4: ALRMR_MSK,
    }),
    /// Alarm sub second register
    /// offset: 0x44
    ALRMSSR: mmio.Mmio(packed struct(u32) {
        /// Sub seconds value
        SS: u15,
        reserved24: u9 = 0,
        /// Mask the most-significant bits starting at this bit
        MASKSS: u6,
        reserved31: u1 = 0,
        /// Clear synchronous counter on alarm (Binary mode only)
        SSCLR: ALRMSSR_SSCLR,
    }),
    /// offset: 0x48
    reserved72: [8]u8,
    /// Status register
    /// offset: 0x50
    SR: mmio.Mmio(packed struct(u32) {
        /// (1/2 of ALRF) Alarm flag
        @"ALRF[0]": ALRF,
        /// (2/2 of ALRF) Alarm flag
        @"ALRF[1]": ALRF,
        /// Wakeup timer flag
        WUTF: WUTF,
        /// Timestamp flag
        TSF: TSF,
        /// Timestamp overflow flag
        TSOVF: TSOVF,
        /// Internal timestamp flag
        ITSF: ITSF,
        /// SSR underflow flag
        SSRUF: SSRUF,
        padding: u25 = 0,
    }),
    /// Masked interrupt status register
    /// offset: 0x54
    MISR: mmio.Mmio(packed struct(u32) {
        /// (1/2 of ALRMF) Alarm masked flag
        @"ALRMF[0]": ALRMF,
        /// (2/2 of ALRMF) Alarm masked flag
        @"ALRMF[1]": ALRMF,
        /// Wakeup timer masked flag
        WUTMF: WUTMF,
        /// Timestamp masked flag
        TSMF: TSMF,
        /// Timestamp overflow masked flag
        TSOVMF: TSOVMF,
        /// Internal timestamp masked flag
        ITSMF: ITSMF,
        /// SSR underflow masked flag
        SSRUMF: SSRUMF,
        padding: u25 = 0,
    }),
    /// offset: 0x58
    reserved88: [4]u8,
    /// Status clear register
    /// offset: 0x5c
    SCR: mmio.Mmio(packed struct(u32) {
        /// (1/2 of CALRF) Clear alarm A flag
        @"CALRF[0]": CALRF,
        /// (2/2 of CALRF) Clear alarm A flag
        @"CALRF[1]": CALRF,
        /// Clear wakeup timer flag
        CWUTF: CALRF,
        /// Clear timestamp flag
        CTSF: CALRF,
        /// Clear timestamp overflow flag
        CTSOVF: CALRF,
        /// Clear internal timestamp flag
        CITSF: CALRF,
        /// Clear SSR underflow flag
        CSSRUF: CALRF,
        padding: u25 = 0,
    }),
    /// offset: 0x60
    reserved96: [16]u8,
    /// Alarm binary mode register
    /// offset: 0x70
    ALRBINR: [2]mmio.Mmio(packed struct(u32) {
        /// Synchronous counter alarm value in Binary mode
        SS: u32,
    }),
};
