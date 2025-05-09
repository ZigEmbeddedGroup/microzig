const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const DS_EE_KOFF = enum(u1) {
    /// NVM woken up when exiting from Deepsleep mode even if the bit RUN_PD is set
    NVMWakeUp = 0x0,
    /// NVM not woken up when exiting from low-power mode (if the bit RUN_PD is set)
    NVMSleep = 0x1,
};

pub const MODE = enum(u1) {
    /// Voltage regulator in Main mode
    MAIN_MODE = 0x0,
    /// Voltage regulator switches to low-power mode
    LOW_POWER_MODE = 0x1,
};

pub const PDDS = enum(u1) {
    /// Enter Stop mode when the CPU enters deepsleep
    STOP_MODE = 0x0,
    /// Enter Standby mode when the CPU enters deepsleep
    STANDBY_MODE = 0x1,
};

pub const PLS = enum(u3) {
    /// 1.9 V
    V1_9 = 0x0,
    /// 2.1 V
    V2_1 = 0x1,
    /// 2.3 V
    V2_3 = 0x2,
    /// 2.5 V
    V2_5 = 0x3,
    /// 2.7 V
    V2_7 = 0x4,
    /// 2.9 V
    V2_9 = 0x5,
    /// 3.1 V
    V3_1 = 0x6,
    /// External input analog voltage (Compare internally to VREFINT)
    External = 0x7,
};

pub const VOS = enum(u2) {
    /// 1.8 V (range 1)
    Range1 = 0x1,
    /// 1.5 V (range 2)
    Range2 = 0x2,
    /// 1.2 V (range 3)
    Range3 = 0x3,
    _,
};

/// Power control
pub const PWR = extern struct {
    /// power control register
    /// offset: 0x00
    CR: mmio.Mmio(packed struct(u32) {
        /// Low-power deepsleep/Sleep/Low-power run
        LPSDSR: MODE,
        /// Power down deepsleep
        PDDS: PDDS,
        /// Clear wakeup flag
        CWUF: u1,
        /// Clear standby flag
        CSBF: u1,
        /// Power voltage detector enable
        PVDE: u1,
        /// PVD level selection
        PLS: PLS,
        /// Disable backup domain write protection
        DBP: u1,
        /// Ultra-low-power mode
        ULP: u1,
        /// Fast wakeup
        FWU: u1,
        /// Voltage scaling range selection
        VOS: VOS,
        /// Deep sleep mode with Flash memory kept off
        DS_EE_KOFF: DS_EE_KOFF,
        /// Low power run mode
        LPRUN: MODE,
        reserved16: u1 = 0,
        /// Regulator in Low-power deepsleep mode
        LPDS: MODE,
        padding: u15 = 0,
    }),
    /// power control/status register
    /// offset: 0x04
    CSR: mmio.Mmio(packed struct(u32) {
        /// Wakeup flag
        WUF: u1,
        /// Standby flag
        SBF: u1,
        /// PVD output
        PVDO: u1,
        /// Internal voltage reference ready flag
        VREFINTRDYF: u1,
        /// Voltage Scaling select flag
        VOSF: u1,
        /// Regulator LP flag
        REGLPF: u1,
        reserved8: u2 = 0,
        /// Enable WKUP pin 1
        EWUP1: u1,
        /// Enable WKUP pin 2
        EWUP2: u1,
        /// Enable WKUP pin 3
        EWUP3: u1,
        padding: u21 = 0,
    }),
};
