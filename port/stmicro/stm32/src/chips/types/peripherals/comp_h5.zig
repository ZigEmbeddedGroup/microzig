const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const BLANKING = enum(u4) {
    NoBlanking = 0x0,
    Tim1Oc5 = 0x1,
    Tim2Oc3 = 0x2,
    Tim3Oc3 = 0x3,
    Tim3Oc4 = 0x4,
    Lptim1Ch2 = 0x5,
    Lptim2Ch2 = 0x6,
    _,
};

pub const HYST = enum(u2) {
    None = 0x0,
    Low = 0x1,
    Medium = 0x2,
    High = 0x3,
};

pub const INMSEL = enum(u4) {
    VRef_1over4 = 0x0,
    VRef_1over2 = 0x1,
    VRef_3over4 = 0x2,
    VRef = 0x3,
    Dac1Out1 = 0x4,
    Inm1 = 0x5,
    Inm2 = 0x6,
    Inm3 = 0x7,
    VSense = 0x8,
    VBat_1over4 = 0x9,
    _,
};

pub const PWRMODE = enum(u2) {
    /// High speed / full power
    High = 0x0,
    /// Medium speed / medium power
    Medium = 0x1,
    /// Medium speed / medium power
    MediumEither = 0x2,
    /// Ultra low power / ultra-low-power
    Low = 0x3,
};

/// Comparator.
pub const COMP = extern struct {
    /// Comparator status register.
    /// offset: 0x00
    SR: mmio.Mmio(packed struct(u32) {
        /// (1/1 of CVAL) COMP Channel1 output status bit This bit is read-only. It reflects the current COMP Channel1 output taking into account POLARITY and BLANKING bits effect.
        @"CVAL[0]": u1,
        reserved16: u15 = 0,
        /// (1/1 of CIF) COMP Channel1 interrupt flag This bit is set by hardware when the COMP Channel1 output is set This bit is cleared by software writing 1 the CC1IF bit in the COMP_ICFR register.
        @"CIF[0]": u1,
        padding: u15 = 0,
    }),
    /// Comparator interrupt clear flag register.
    /// offset: 0x04
    ICFR: mmio.Mmio(packed struct(u32) {
        reserved16: u16 = 0,
        /// (1/1 of CCIF) Clear COMP Channel1 interrupt flag Writing 1 clears the C1IF flag in the COMP_SR register.
        @"CCIF[0]": u1,
        padding: u15 = 0,
    }),
    /// offset: 0x08
    reserved8: [4]u8,
    /// Comparator configuration register 1.
    /// offset: 0x0c
    CFGR1: mmio.Mmio(packed struct(u32) {
        /// COMP Channel1 enable This bit is set and cleared by software (only if LOCK not set). It enables the COMP-Channel1.
        EN: u1,
        /// Scaler bridge enable This bit is set and cleared by software (only if LOCK not set). This bit enables the bridge of the scaler. If SCALEN is set and BRGEN is reset, all four scaler outputs provide the same level V<sub>REF_COMP</sub> (similar to V<sub>REFINT</sub>). If SCALEN and BRGEN are set, the four scaler outputs provide V<sub>REF_COMP</sub>, 3/4-V<sub>REF_COMP</sub>, 1/2-V<sub>REF_COMP</sub> and 1/4-V<sub>REF_COMP</sub> levels, respectively.
        BRGEN: u1,
        /// Voltage scaler enable This bit is set and cleared by software (only if LOCK not set). This bit enables the V<sub>REFINT</sub> scaler for the COMP channels.
        SCALEN: u1,
        /// COMP channel1 polarity selection This bit is set and cleared by software (only if LOCK not set). It inverts COMP channel1 polarity.
        POLARITY: u1,
        reserved6: u2 = 0,
        /// COMP channel1 interrupt enable This bit is set and cleared by software (only if LOCK not set). This bit enable the interrupt generation of the COMP channel1.
        ITEN: u1,
        reserved8: u1 = 0,
        /// COMP channel1 hysteresis selection These bits are set and cleared by software (only if LOCK not set). They select the hysteresis voltage of the COMP channel1.
        HYST: HYST,
        reserved12: u2 = 0,
        /// Power mode of the COMP channel1 These bits are set and cleared by software (only if LOCK not set). They control the power/speed of the COMP channel1.
        PWRMODE: PWRMODE,
        reserved16: u2 = 0,
        /// COMP channel1 inverting input selection These bits are set and cleared by software (only if LOCK not set). They select which input is connected to the input minus of the COMP channel. Note: See Table-146: COMP1 inverting input assignment for more details.
        INMSEL: INMSEL,
        /// COMP noninverting input selection This bit is set and cleared by software (only if LOCK not set). They select which input is connected to the positive input of COMP channel. Note: See Table-145: COMP1 noninverting input assignment for more details.
        INPSEL1: u1,
        reserved22: u1 = 0,
        /// COMP noninverting input selection This bit is set and cleared by software (only if LOCK not set). They select which input is connected to the positive input of the COMP channel. See Table-145: COMP1 noninverting input assignment for more details.
        INPSEL2: u1,
        reserved24: u1 = 0,
        /// COMP Channel1 blanking source selection Bits of this field are set and cleared by software (only if LOCK not set). The field selects the input source for COMP Channel1 output blanking: All other values: reserved.
        BLANKING: BLANKING,
        reserved31: u3 = 0,
        /// Lock This bit is set by software and cleared by a hardware system reset. It locks the whole content of the COMP Channel1 configuration register COMP_CFGR1[31:0].
        LOCK: u1,
    }),
    /// Comparator configuration register 2.
    /// offset: 0x10
    CFGR2: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// COMP non-inverting input selection This bit is set and cleared by software (only if LOCK not set). They select which input is connected to the positive input of COMP channel. See Table-145: COMP1 noninverting input assignment for more details.
        INPSEL0: u1,
        reserved31: u26 = 0,
        /// Lock This bit is set by software and cleared by a hardware system reset. It locks the whole content of the COMP Channel1 configuration register COMP_CFGR2[31:0].
        LOCK: u1,
    }),
};
