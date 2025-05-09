const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const CKPOL = enum(u2) {
    /// the rising edge is the active edge used for counting. If the LPTIM is configured in Encoder mode (ENC bit is set), the encoder sub-mode 1 is active.
    Rising = 0x0,
    /// the falling edge is the active edge used for counting. If the LPTIM is configured in Encoder mode (ENC bit is set), the encoder sub-mode 2 is active.
    Falling = 0x1,
    /// both edges are active edges. When both external clock signal edges are considered active ones, the LPTIM must also be clocked by an internal clock source with a frequency equal to at least four times the external clock frequency. If the LPTIM is configured in Encoder mode (ENC bit is set), the encoder sub-mode 3 is active.
    Both = 0x2,
    _,
};

pub const ClockSource = enum(u1) {
    /// clocked by internal clock source (APB clock or any of the embedded oscillators)
    Internal = 0x0,
    /// clocked by an external clock source through the LPTIM external Input1
    External = 0x1,
};

pub const Filter = enum(u2) {
    Count1 = 0x0,
    Count2 = 0x1,
    Count4 = 0x2,
    Count8 = 0x3,
};

pub const PRESC = enum(u3) {
    Div1 = 0x0,
    Div2 = 0x1,
    Div4 = 0x2,
    Div8 = 0x3,
    Div16 = 0x4,
    Div32 = 0x5,
    Div64 = 0x6,
    Div128 = 0x7,
};

pub const TRIGEN = enum(u2) {
    /// software trigger (counting start is initiated by software)
    Software = 0x0,
    /// rising edge is the active edge
    RisingEdge = 0x1,
    /// falling edge is the active edge
    FallingEdge = 0x2,
    /// both edges are active edges
    BothEdge = 0x3,
};

pub const WAVPOL = enum(u1) {
    /// The LPTIM output reflects the compare results between LPTIM_ARR and LPTIM_CMP registers.
    Positive = 0x0,
    /// The LPTIM output reflects the inverse of the compare results between LPTIM_ARR and LPTIM_CMP registers.
    Negative = 0x1,
};

/// Low power timer with Output Compare
pub const LPTIM = extern struct {
    /// LPTIM interrupt and status register.
    /// offset: 0x00
    ISR: mmio.Mmio(packed struct(u32) {
        /// (1/1 of CCIF) Compare 1 interrupt flag The CC1IF flag is set by hardware to inform application that LPTIM_CNT register value matches the compare register's value. The CC1IF flag can be cleared by writing 1 to the CC1CF bit in the LPTIM_ICR register.
        @"CCIF[0]": u1,
        /// Autoreload match ARRM is set by hardware to inform application that LPTIM_CNT register’s value reached the LPTIM_ARR register’s value. ARRM flag can be cleared by writing 1 to the ARRMCF bit in the LPTIM_ICR register.
        ARRM: u1,
        /// External trigger edge event EXTTRIG is set by hardware to inform application that a valid edge on the selected external trigger input has occurred. If the trigger is ignored because the timer has already started, then this flag is not set. EXTTRIG flag can be cleared by writing 1 to the EXTTRIGCF bit in the LPTIM_ICR register.
        EXTTRIG: u1,
        /// (1/1 of CMPOK) Compare register 1 update OK CMP1OK is set by hardware to inform application that the APB bus write operation to the LPTIM_CCR1 register has been successfully completed. CMP1OK flag can be cleared by writing 1 to the CMP1OKCF bit in the LPTIM_ICR register.
        @"CMPOK[0]": u1,
        /// Autoreload register update OK ARROK is set by hardware to inform application that the APB bus write operation to the LPTIM_ARR register has been successfully completed. ARROK flag can be cleared by writing 1 to the ARROKCF bit in the LPTIM_ICR register.
        ARROK: u1,
        /// Counter direction change down to up In Encoder mode, UP bit is set by hardware to inform application that the counter direction has changed from down to up. UP flag can be cleared by writing 1 to the UPCF bit in the LPTIM_ICR register. Note: If the LPTIM does not support encoder mode feature, this bit is reserved. Please refer to.
        UP: u1,
        /// Counter direction change up to down In Encoder mode, DOWN bit is set by hardware to inform application that the counter direction has changed from up to down. DOWN flag can be cleared by writing 1 to the DOWNCF bit in the LPTIM_ICR register. Note: If the LPTIM does not support encoder mode feature, this bit is reserved. Please refer to.
        DOWN: u1,
        padding: u25 = 0,
    }),
    /// LPTIM interrupt clear register.
    /// offset: 0x04
    ICR: mmio.Mmio(packed struct(u32) {
        /// (1/1 of CCCF) Capture/compare 1 clear flag Writing 1 to this bit clears the CC1IF flag in the LPTIM_ISR register.
        @"CCCF[0]": u1,
        /// Autoreload match clear flag Writing 1 to this bit clears the ARRM flag in the LPTIM_ISR register.
        ARRMCF: u1,
        /// External trigger valid edge clear flag Writing 1 to this bit clears the EXTTRIG flag in the LPTIM_ISR register.
        EXTTRIGCF: u1,
        /// (1/1 of CMPOKCF) Compare register 1 update OK clear flag Writing 1 to this bit clears the CMP1OK flag in the LPTIM_ISR register.
        @"CMPOKCF[0]": u1,
        /// Autoreload register update OK clear flag Writing 1 to this bit clears the ARROK flag in the LPTIM_ISR register.
        ARROKCF: u1,
        /// Direction change to UP clear flag Writing 1 to this bit clear the UP flag in the LPTIM_ISR register. Note: If the LPTIM does not support encoder mode feature, this bit is reserved. Please refer to.
        UPCF: u1,
        /// Direction change to down clear flag Writing 1 to this bit clear the DOWN flag in the LPTIM_ISR register. Note: If the LPTIM does not support encoder mode feature, this bit is reserved. Please refer to.
        DOWNCF: u1,
        padding: u25 = 0,
    }),
    /// LPTIM interrupt enable register.
    /// offset: 0x08
    IER: mmio.Mmio(packed struct(u32) {
        /// (1/1 of CCIE) Capture/compare 1 interrupt enable.
        @"CCIE[0]": u1,
        /// Autoreload match Interrupt Enable.
        ARRMIE: u1,
        /// External trigger valid edge Interrupt Enable.
        EXTTRIGIE: u1,
        /// (1/1 of CMPOKIE) Compare register 1 update OK interrupt enable.
        @"CMPOKIE[0]": u1,
        /// Autoreload register update OK Interrupt Enable.
        ARROKIE: u1,
        /// Direction change to UP Interrupt Enable Note: If the LPTIM does not support encoder mode feature, this bit is reserved. Please refer to.
        UPIE: u1,
        /// Direction change to down Interrupt Enable Note: If the LPTIM does not support encoder mode feature, this bit is reserved. Please refer to.
        DOWNIE: u1,
        padding: u25 = 0,
    }),
    /// LPTIM configuration register.
    /// offset: 0x0c
    CFGR: mmio.Mmio(packed struct(u32) {
        /// Clock selector The CKSEL bit selects which clock source the LPTIM uses:.
        CKSEL: ClockSource,
        /// Clock Polarity When the LPTIM is clocked by an external clock source, CKPOL bits is used to configure the active edge or edges used by the counter: If the LPTIM is configured in Encoder mode (ENC bit is set), the encoder sub-mode 1 is active. If the LPTIM is configured in Encoder mode (ENC bit is set), the encoder sub-mode 2 is active. Refer to for more details about Encoder mode sub-modes.
        CKPOL: CKPOL,
        /// Configurable digital filter for external clock The CKFLT value sets the number of consecutive equal samples that should be detected when a level change occurs on an external clock signal before it is considered as a valid level transition. An internal clock source must be present to use this feature.
        CKFLT: Filter,
        reserved6: u1 = 0,
        /// Configurable digital filter for trigger The TRGFLT value sets the number of consecutive equal samples that should be detected when a level change occurs on an internal trigger before it is considered as a valid level transition. An internal clock source must be present to use this feature.
        TRGFLT: Filter,
        reserved9: u1 = 0,
        /// Clock prescaler The PRESC bits configure the prescaler division factor. It can be one among the following division factors:.
        PRESC: PRESC,
        reserved13: u1 = 0,
        /// Trigger selector The TRIGSEL bits select the trigger source that serves as a trigger event for the LPTIM among the below 8 available sources: See for details.
        TRIGSEL: u3,
        reserved17: u1 = 0,
        /// Trigger enable and polarity The TRIGEN bits controls whether the LPTIM counter is started by an external trigger or not. If the external trigger option is selected, three configurations are possible for the trigger active edge:.
        TRIGEN: TRIGEN,
        /// Timeout enable The TIMOUT bit controls the Timeout feature.
        TIMOUT: u1,
        /// Waveform shape The WAVE bit controls the output shape.
        WAVE: u1,
        /// Waveform shape polarity The WAVEPOL bit controls the output polarity Note: If the LPTIM implements at least one capture/compare channel, this bit is reserved. Please refer to.
        WAVPOL: WAVPOL,
        /// Registers update mode The PRELOAD bit controls the LPTIM_ARR, LPTIM_RCR and the LPTIM_CCRx registers update modality.
        PRELOAD: u1,
        /// counter mode enabled The COUNTMODE bit selects which clock source is used by the LPTIM to clock the counter:.
        COUNTMODE: ClockSource,
        /// Encoder mode enable The ENC bit controls the Encoder mode Note: If the LPTIM does not support encoder mode feature, this bit is reserved. Please refer to.
        ENC: u1,
        padding: u7 = 0,
    }),
    /// LPTIM control register.
    /// offset: 0x10
    CR: mmio.Mmio(packed struct(u32) {
        /// LPTIM enable The ENABLE bit is set and cleared by software.
        ENABLE: u1,
        /// LPTIM start in Single mode This bit is set by software and cleared by hardware. In case of software start (TRIGEN[1:0] = ‘00’), setting this bit starts the LPTIM in single pulse mode. If the software start is disabled (TRIGEN[1:0] different than ‘00’), setting this bit starts the LPTIM in single pulse mode as soon as an external trigger is detected. If this bit is set when the LPTIM is in continuous counting mode, then the LPTIM stops at the following match between LPTIM_ARR and LPTIM_CNT registers. This bit can only be set when the LPTIM is enabled. It is automatically reset by hardware.
        SNGSTRT: u1,
        /// Timer start in Continuous mode This bit is set by software and cleared by hardware. In case of software start (TRIGEN[1:0] = ‘00’), setting this bit starts the LPTIM in Continuous mode. If the software start is disabled (TRIGEN[1:0] different than ‘00’), setting this bit starts the timer in Continuous mode as soon as an external trigger is detected. If this bit is set when a single pulse mode counting is ongoing, then the timer does not stop at the next match between the LPTIM_ARR and LPTIM_CNT registers and the LPTIM counter keeps counting in Continuous mode. This bit can be set only when the LPTIM is enabled. It is automatically reset by hardware.
        CNTSTRT: u1,
        padding: u29 = 0,
    }),
    /// LPTIM compare register 1.
    /// offset: 0x14
    CMP: mmio.Mmio(packed struct(u32) {
        /// Capture/compare 1 value If channel CC1 is configured as output: CCR1 is the value to be loaded in the capture/compare 1 register. Depending on the PRELOAD option, the CCR1 register is immediately updated if the PRELOAD bit is reset and updated at next LPTIM update event if PREOAD bit is reset. The capture/compare register 1 contains the value to be compared to the counter LPTIM_CNT and signaled on OC1 output. If channel CC1 is configured as input: CCR1 contains the counter value transferred by the last input capture 1 event. The LPTIM_CCR1 register is read-only and cannot be programmed. If LPTIM does not implement any channel: The compare register 1 contains the value to be compared to the counter LPTIM_CNT and signaled on LPTIM output.
        CMP: u16,
        padding: u16 = 0,
    }),
    /// LPTIM autoreload register.
    /// offset: 0x18
    ARR: mmio.Mmio(packed struct(u32) {
        /// Auto reload value ARR is the autoreload value for the LPTIM. This value must be strictly greater than the CCRx[15:0] value.
        ARR: u16,
        padding: u16 = 0,
    }),
    /// LPTIM counter register.
    /// offset: 0x1c
    CNT: mmio.Mmio(packed struct(u32) {
        /// Counter value When the LPTIM is running with an asynchronous clock, reading the LPTIM_CNT register may return unreliable values. So in this case it is necessary to perform two consecutive read accesses and verify that the two returned values are identical.
        CNT: u16,
        padding: u16 = 0,
    }),
};
