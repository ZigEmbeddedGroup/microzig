const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

/// Digital temperature sensor.
pub const DTS = extern struct {
    /// Temperature sensor configuration register 1.
    /// offset: 0x00
    CFGR1: mmio.Mmio(packed struct(u32) {
        /// Temperature sensor 1 enable bit This bit is set and cleared by software. Note: Once enabled, the temperature sensor is active after a specific delay time. The TS1_RDY flag will be set when the sensor is ready.
        EN: u1,
        reserved4: u3 = 0,
        /// Start frequency measurement on temperature sensor 1 This bit is set and cleared by software.
        START: u1,
        reserved8: u3 = 0,
        /// Input trigger selection bit for temperature sensor 1 These bits are set and cleared by software. They select which input triggers a temperature measurement. Refer to Section 19.3.10: Trigger input.
        INTRIG_SEL: u4,
        reserved16: u4 = 0,
        /// Sampling time for temperature sensor 1 These bits allow increasing the sampling time to improve measurement precision. When the PCLK clock is selected as reference clock (REFCLK_SEL = 0), the measurement will be performed at TS1_SMP_TIME period of CLK_PTAT. When the LSE is selected as reference clock (REFCLK_SEL =1), the measurement will be performed at TS1_SMP_TIME period of LSE.
        SMP_TIME: u4,
        /// Reference clock selection bit This bit is set and cleared by software. It indicates whether the reference clock is the high speed clock (PCLK) or the low speed clock (LSE).
        REFCLK_SEL: u1,
        /// Quick measurement option bit This bit is set and cleared by software. It is used to increase the measurement speed by suppressing the calibration step. It is effective only when the LSE clock is used as reference clock (REFCLK_SEL=1).
        Q_MEAS_OPT: u1,
        reserved24: u2 = 0,
        /// High speed clock division ratio These bits are set and cleared by software. They can be used to define the division ratio for the main clock in order to obtain the internal frequency lower than 1 MHz required for the calibration. They are applicable only for calibration when PCLK is selected as reference clock (REFCLK_SEL=0). ...
        HSREF_CLK_DIV: u7,
        padding: u1 = 0,
    }),
    /// offset: 0x04
    reserved4: [4]u8,
    /// Temperature sensor T0 value register 1.
    /// offset: 0x08
    T0VALR1: mmio.Mmio(packed struct(u32) {
        /// Engineering value of the frequency measured at T0 for. temperature sensor 1 This value is expressed in 0.1 kHz.
        FMT0: u16,
        /// Engineering value of the T0 temperature for temperature sensor 1. Others: Reserved, must not be used.
        T0: u2,
        padding: u14 = 0,
    }),
    /// offset: 0x0c
    reserved12: [4]u8,
    /// Temperature sensor ramp value register.
    /// offset: 0x10
    RAMPVALR: mmio.Mmio(packed struct(u32) {
        /// Engineering value of the ramp coefficient for the temperature sensor 1. This value is expressed in Hz/�C.
        RAMP_COEFF: u16,
        padding: u16 = 0,
    }),
    /// Temperature sensor interrupt threshold register 1.
    /// offset: 0x14
    ITR1: mmio.Mmio(packed struct(u32) {
        /// Low interrupt threshold for temperature sensor 1 These bits are set and cleared by software. They indicate the lowest value than can be reached before raising an interrupt signal.
        LITTHD: u16,
        /// High interrupt threshold for temperature sensor 1 These bits are set and cleared by software. They indicate the highest value than can be reached before raising an interrupt signal.
        HITTHD: u16,
    }),
    /// offset: 0x18
    reserved24: [4]u8,
    /// Temperature sensor data register.
    /// offset: 0x1c
    DR: mmio.Mmio(packed struct(u32) {
        /// Value of the counter output value for temperature sensor 1.
        MFREQ: u16,
        padding: u16 = 0,
    }),
    /// Temperature sensor status register.
    /// offset: 0x20
    SR: mmio.Mmio(packed struct(u32) {
        /// Interrupt flag for end of measurement on temperature sensor 1, synchronized on PCLK. This bit is set by hardware when a temperature measure is done. It is cleared by software by writing 1 to the TS2_CITEF bit in the DTS_ICIFR register. Note: This bit is active only when the TS1_ITEFEN bit is set.
        ITEF: u1,
        /// Interrupt flag for low threshold on temperature sensor 1, synchronized on PCLK. This bit is set by hardware when the low threshold is set and reached. It is cleared by software by writing 1 to the TS1_CITLF bit in the DTS_ICIFR register. Note: This bit is active only when the TS1_ITLFEN bit is set.
        ITLF: u1,
        /// Interrupt flag for high threshold on temperature sensor 1, synchronized on PCLK This bit is set by hardware when the high threshold is set and reached. It is cleared by software by writing 1 to the TS1_CITHF bit in the DTS_ICIFR register. Note: This bit is active only when the TS1_ITHFEN bit is set.
        ITHF: u1,
        reserved4: u1 = 0,
        /// Asynchronous interrupt flag for end of measure on temperature sensor 1 This bit is set by hardware when a temperature measure is done. It is cleared by software by writing 1 to the TS1_CAITEF bit in the DTS_ICIFR register. Note: This bit is active only when the TS1_AITEFEN bit is set.
        AITEF: u1,
        /// Asynchronous interrupt flag for low threshold on temperature sensor 1 This bit is set by hardware when the low threshold is reached. It is cleared by software by writing 1 to the TS1_CAITLF bit in the DTS_ICIFR register. Note: This bit is active only when the TS1_AITLFEN bit is set.
        AITLF: u1,
        /// Asynchronous interrupt flag for high threshold on temperature sensor 1 This bit is set by hardware when the high threshold is reached. It is cleared by software by writing 1 to the TS1_CAITHF bit in the DTS_ICIFR register. Note: This bit is active only when the TS1_AITHFEN bit is set.
        AITHF: u1,
        reserved15: u8 = 0,
        /// Temperature sensor 1 ready flag This bit is set and reset by hardware. It indicates that a measurement is ongoing.
        RDY: u1,
        padding: u16 = 0,
    }),
    /// Temperature sensor interrupt enable register.
    /// offset: 0x24
    ITENR: mmio.Mmio(packed struct(u32) {
        /// Interrupt enable flag for end of measurement on temperature sensor 1, synchronized on PCLK. This bit are set and cleared by software. It enables the synchronous interrupt for end of measurement.
        ITEEN: u1,
        /// Interrupt enable flag for low threshold on temperature sensor 1, synchronized on PCLK. This bit are set and cleared by software. It enables the synchronous interrupt when the measure reaches or is below the low threshold.
        ITLEN: u1,
        /// Interrupt enable flag for high threshold on temperature sensor 1, synchronized on PCLK. This bit are set and cleared by software. It enables the interrupt when the measure reaches or is above the high threshold.
        ITHEN: u1,
        reserved4: u1 = 0,
        /// Asynchronous interrupt enable flag for end of measurement on temperature sensor 1 This bit are set and cleared by software. It enables the asynchronous interrupt for end of measurement (only when REFCLK_SEL = 1).
        AITEEN: u1,
        /// Asynchronous interrupt enable flag for low threshold on temperature sensor 1. This bit are set and cleared by software. It enables the asynchronous interrupt when the temperature is below the low threshold (only when REFCLK_SEL= 1).
        AITLEN: u1,
        /// Asynchronous interrupt enable flag on high threshold for temperature sensor 1. This bit are set and cleared by software. It enables the asynchronous interrupt when the temperature is above the high threshold (only when REFCLK_SEL= 1’’).
        AITHEN: u1,
        padding: u25 = 0,
    }),
    /// Temperature sensor clear interrupt flag register.
    /// offset: 0x28
    ICIFR: mmio.Mmio(packed struct(u32) {
        /// Interrupt clear flag for end of measurement on temperature sensor 1 Writing 1 to this bit clears the TS1_ITEF flag in the DTS_SR register.
        CITEF: u1,
        /// Interrupt clear flag for low threshold on temperature sensor 1 Writing 1 to this bit clears the TS1_ITLF flag in the DTS_SR register.
        CITLF: u1,
        /// Interrupt clear flag for high threshold on temperature sensor 1 Writing this bit to 1 clears the TS1_ITHF flag in the DTS_SR register.
        CITHF: u1,
        reserved4: u1 = 0,
        /// Write once bit. Clear the asynchronous IT flag for End Of Measure for thermal sensor 1. Writing 1 clears the TS1_AITEF flag of the DTS_SR register.
        CAITEF: u1,
        /// Asynchronous interrupt clear flag for low threshold on temperature sensor 1 Writing 1 to this bit clears the TS1_AITLF flag in the DTS_SR register.
        CAITLF: u1,
        /// Asynchronous interrupt clear flag for high threshold on temperature sensor 1 Writing 1 to this bit clears the TS1_AITHF flag in the DTS_SR register.
        CAITHF: u1,
        padding: u25 = 0,
    }),
    /// Temperature sensor option register.
    /// offset: 0x2c
    OR: mmio.Mmio(packed struct(u32) {
        /// (1/32 of OP) general purpose option bits.
        @"OP[0]": u1,
        /// (2/32 of OP) general purpose option bits.
        @"OP[1]": u1,
        /// (3/32 of OP) general purpose option bits.
        @"OP[2]": u1,
        /// (4/32 of OP) general purpose option bits.
        @"OP[3]": u1,
        /// (5/32 of OP) general purpose option bits.
        @"OP[4]": u1,
        /// (6/32 of OP) general purpose option bits.
        @"OP[5]": u1,
        /// (7/32 of OP) general purpose option bits.
        @"OP[6]": u1,
        /// (8/32 of OP) general purpose option bits.
        @"OP[7]": u1,
        /// (9/32 of OP) general purpose option bits.
        @"OP[8]": u1,
        /// (10/32 of OP) general purpose option bits.
        @"OP[9]": u1,
        /// (11/32 of OP) general purpose option bits.
        @"OP[10]": u1,
        /// (12/32 of OP) general purpose option bits.
        @"OP[11]": u1,
        /// (13/32 of OP) general purpose option bits.
        @"OP[12]": u1,
        /// (14/32 of OP) general purpose option bits.
        @"OP[13]": u1,
        /// (15/32 of OP) general purpose option bits.
        @"OP[14]": u1,
        /// (16/32 of OP) general purpose option bits.
        @"OP[15]": u1,
        /// (17/32 of OP) general purpose option bits.
        @"OP[16]": u1,
        /// (18/32 of OP) general purpose option bits.
        @"OP[17]": u1,
        /// (19/32 of OP) general purpose option bits.
        @"OP[18]": u1,
        /// (20/32 of OP) general purpose option bits.
        @"OP[19]": u1,
        /// (21/32 of OP) general purpose option bits.
        @"OP[20]": u1,
        /// (22/32 of OP) general purpose option bits.
        @"OP[21]": u1,
        /// (23/32 of OP) general purpose option bits.
        @"OP[22]": u1,
        /// (24/32 of OP) general purpose option bits.
        @"OP[23]": u1,
        /// (25/32 of OP) general purpose option bits.
        @"OP[24]": u1,
        /// (26/32 of OP) general purpose option bits.
        @"OP[25]": u1,
        /// (27/32 of OP) general purpose option bits.
        @"OP[26]": u1,
        /// (28/32 of OP) general purpose option bits.
        @"OP[27]": u1,
        /// (29/32 of OP) general purpose option bits.
        @"OP[28]": u1,
        /// (30/32 of OP) general purpose option bits.
        @"OP[29]": u1,
        /// (31/32 of OP) general purpose option bits.
        @"OP[30]": u1,
        /// (32/32 of OP) general purpose option bits.
        @"OP[31]": u1,
    }),
};
