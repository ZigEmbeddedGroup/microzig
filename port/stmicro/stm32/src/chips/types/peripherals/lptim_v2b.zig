const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const types = @import("../../types.zig");

pub const CCP_Input = enum(u2) {
    Rising = 0x0,
    Falling = 0x1,
    Both = 0x3,
    _,
};

pub const CCP_Output = enum(u2) {
    ActiveHigh = 0x0,
    ActiveLow = 0x1,
    _,
};

pub const CCSEL = enum(u1) {
    /// channel is configured in output PWM mode
    OutputCompare = 0x0,
    /// channel is configured in input capture mode
    InputCapture = 0x1,
};

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

/// Low power timer with Output Compare
pub const LPTIM = extern struct {
    /// LPTIM interrupt and status register.
    /// offset: 0x00
    ISR: mmio.Mmio(packed struct(u32) {
        /// Compare 1 interrupt flag The CC1IF flag is set by hardware to inform application that LPTIM_CNT register value matches the compare register's value. The CC1IF flag can be cleared by writing 1 to the CC1CF bit in the LPTIM_ICR register.
        @"CCIF[0]": u1,
        /// Autoreload match ARRM is set by hardware to inform application that LPTIM_CNT register’s value reached the LPTIM_ARR register’s value. ARRM flag can be cleared by writing 1 to the ARRMCF bit in the LPTIM_ICR register.
        ARRM: u1,
        /// External trigger edge event EXTTRIG is set by hardware to inform application that a valid edge on the selected external trigger input has occurred. If the trigger is ignored because the timer has already started, then this flag is not set. EXTTRIG flag can be cleared by writing 1 to the EXTTRIGCF bit in the LPTIM_ICR register.
        EXTTRIG: u1,
        /// Compare register 1 update OK CMP1OK is set by hardware to inform application that the APB bus write operation to the LPTIM_CCR1 register has been successfully completed. CMP1OK flag can be cleared by writing 1 to the CMP1OKCF bit in the LPTIM_ICR register.
        @"CMPOK[0]": u1,
        /// Autoreload register update OK ARROK is set by hardware to inform application that the APB bus write operation to the LPTIM_ARR register has been successfully completed. ARROK flag can be cleared by writing 1 to the ARROKCF bit in the LPTIM_ICR register.
        ARROK: u1,
        /// Counter direction change down to up In Encoder mode, UP bit is set by hardware to inform application that the counter direction has changed from down to up. UP flag can be cleared by writing 1 to the UPCF bit in the LPTIM_ICR register. Note: If the LPTIM does not support encoder mode feature, this bit is reserved. Please refer to.
        UP: u1,
        /// Counter direction change up to down In Encoder mode, DOWN bit is set by hardware to inform application that the counter direction has changed from up to down. DOWN flag can be cleared by writing 1 to the DOWNCF bit in the LPTIM_ICR register. Note: If the LPTIM does not support encoder mode feature, this bit is reserved. Please refer to.
        DOWN: u1,
        /// LPTIM update event occurred UE is set by hardware to inform application that an update event was generated. UE flag can be cleared by writing 1 to the UECF bit in the LPTIM_ICR register.
        UE: u1,
        /// Repetition register update OK REPOK is set by hardware to inform application that the APB bus write operation to the LPTIM_RCR register has been successfully completed. REPOK flag can be cleared by writing 1 to the REPOKCF bit in the LPTIM_ICR register.
        REPOK: u1,
        /// Compare 1 interrupt flag The CC1IF flag is set by hardware to inform application that LPTIM_CNT register value matches the compare register's value. The CC1IF flag can be cleared by writing 1 to the CC1CF bit in the LPTIM_ICR register.
        @"CCIF[1]": u1,
        /// Compare 1 interrupt flag The CC1IF flag is set by hardware to inform application that LPTIM_CNT register value matches the compare register's value. The CC1IF flag can be cleared by writing 1 to the CC1CF bit in the LPTIM_ICR register.
        @"CCIF[2]": u1,
        /// Compare 1 interrupt flag The CC1IF flag is set by hardware to inform application that LPTIM_CNT register value matches the compare register's value. The CC1IF flag can be cleared by writing 1 to the CC1CF bit in the LPTIM_ICR register.
        @"CCIF[3]": u1,
        /// (1/4 of CCOF) Capture 1 over-capture flag This flag is set by hardware only when the corresponding channel is configured in input capture mode. It is cleared by software by writing 1 to the CC1OCF bit in the LPTIM_ICR register. Note: If LPTIM does not implement at least 1 channel this bit is reserved. Please refer to.
        @"CCOF[0]": u1,
        /// (2/4 of CCOF) Capture 1 over-capture flag This flag is set by hardware only when the corresponding channel is configured in input capture mode. It is cleared by software by writing 1 to the CC1OCF bit in the LPTIM_ICR register. Note: If LPTIM does not implement at least 1 channel this bit is reserved. Please refer to.
        @"CCOF[1]": u1,
        /// (3/4 of CCOF) Capture 1 over-capture flag This flag is set by hardware only when the corresponding channel is configured in input capture mode. It is cleared by software by writing 1 to the CC1OCF bit in the LPTIM_ICR register. Note: If LPTIM does not implement at least 1 channel this bit is reserved. Please refer to.
        @"CCOF[2]": u1,
        /// (4/4 of CCOF) Capture 1 over-capture flag This flag is set by hardware only when the corresponding channel is configured in input capture mode. It is cleared by software by writing 1 to the CC1OCF bit in the LPTIM_ICR register. Note: If LPTIM does not implement at least 1 channel this bit is reserved. Please refer to.
        @"CCOF[3]": u1,
        reserved19: u3 = 0,
        /// Compare register 1 update OK CMP1OK is set by hardware to inform application that the APB bus write operation to the LPTIM_CCR1 register has been successfully completed. CMP1OK flag can be cleared by writing 1 to the CMP1OKCF bit in the LPTIM_ICR register.
        @"CMPOK[1]": u1,
        /// Compare register 1 update OK CMP1OK is set by hardware to inform application that the APB bus write operation to the LPTIM_CCR1 register has been successfully completed. CMP1OK flag can be cleared by writing 1 to the CMP1OKCF bit in the LPTIM_ICR register.
        @"CMPOK[2]": u1,
        /// Compare register 1 update OK CMP1OK is set by hardware to inform application that the APB bus write operation to the LPTIM_CCR1 register has been successfully completed. CMP1OK flag can be cleared by writing 1 to the CMP1OKCF bit in the LPTIM_ICR register.
        @"CMPOK[3]": u1,
        reserved24: u2 = 0,
        /// Interrupt enable register update OK DIEROK is set by hardware to inform application that the APB bus write operation to the LPTIM_DIER register has been successfully completed. DIEROK flag can be cleared by writing 1 to the DIEROKCF bit in the LPTIM_ICR register.
        DIEROK: u1,
        padding: u7 = 0,
    }),
    /// LPTIM interrupt clear register.
    /// offset: 0x04
    ICR: mmio.Mmio(packed struct(u32) {
        /// Capture/compare 1 clear flag Writing 1 to this bit clears the CC1IF flag in the LPTIM_ISR register.
        @"CCCF[0]": u1,
        /// Autoreload match clear flag Writing 1 to this bit clears the ARRM flag in the LPTIM_ISR register.
        ARRMCF: u1,
        /// External trigger valid edge clear flag Writing 1 to this bit clears the EXTTRIG flag in the LPTIM_ISR register.
        EXTTRIGCF: u1,
        /// Compare register 1 update OK clear flag Writing 1 to this bit clears the CMP1OK flag in the LPTIM_ISR register.
        @"CMPOKCF[0]": u1,
        /// Autoreload register update OK clear flag Writing 1 to this bit clears the ARROK flag in the LPTIM_ISR register.
        ARROKCF: u1,
        /// Direction change to UP clear flag Writing 1 to this bit clear the UP flag in the LPTIM_ISR register. Note: If the LPTIM does not support encoder mode feature, this bit is reserved. Please refer to.
        UPCF: u1,
        /// Direction change to down clear flag Writing 1 to this bit clear the DOWN flag in the LPTIM_ISR register. Note: If the LPTIM does not support encoder mode feature, this bit is reserved. Please refer to.
        DOWNCF: u1,
        /// Update event clear flag Writing 1 to this bit clear the UE flag in the LPTIM_ISR register.
        UECF: u1,
        /// Repetition register update OK clear flag Writing 1 to this bit clears the REPOK flag in the LPTIM_ISR register.
        REPOKCF: u1,
        /// Capture/compare 1 clear flag Writing 1 to this bit clears the CC1IF flag in the LPTIM_ISR register.
        @"CCCF[1]": u1,
        /// Capture/compare 1 clear flag Writing 1 to this bit clears the CC1IF flag in the LPTIM_ISR register.
        @"CCCF[2]": u1,
        /// Capture/compare 1 clear flag Writing 1 to this bit clears the CC1IF flag in the LPTIM_ISR register.
        @"CCCF[3]": u1,
        /// (1/4 of CCOCF) Capture/compare 1 over-capture clear flag Writing 1 to this bit clears the CC1OF flag in the LPTIM_ISR register. Note: If LPTIM does not implement at least 1 channel this bit is reserved. Please refer to.
        @"CCOCF[0]": u1,
        /// (2/4 of CCOCF) Capture/compare 1 over-capture clear flag Writing 1 to this bit clears the CC1OF flag in the LPTIM_ISR register. Note: If LPTIM does not implement at least 1 channel this bit is reserved. Please refer to.
        @"CCOCF[1]": u1,
        /// (3/4 of CCOCF) Capture/compare 1 over-capture clear flag Writing 1 to this bit clears the CC1OF flag in the LPTIM_ISR register. Note: If LPTIM does not implement at least 1 channel this bit is reserved. Please refer to.
        @"CCOCF[2]": u1,
        /// (4/4 of CCOCF) Capture/compare 1 over-capture clear flag Writing 1 to this bit clears the CC1OF flag in the LPTIM_ISR register. Note: If LPTIM does not implement at least 1 channel this bit is reserved. Please refer to.
        @"CCOCF[3]": u1,
        reserved19: u3 = 0,
        /// Compare register 1 update OK clear flag Writing 1 to this bit clears the CMP1OK flag in the LPTIM_ISR register.
        @"CMPOKCF[1]": u1,
        /// Compare register 1 update OK clear flag Writing 1 to this bit clears the CMP1OK flag in the LPTIM_ISR register.
        @"CMPOKCF[2]": u1,
        /// Compare register 1 update OK clear flag Writing 1 to this bit clears the CMP1OK flag in the LPTIM_ISR register.
        @"CMPOKCF[3]": u1,
        reserved24: u2 = 0,
        /// Interrupt enable register update OK clear flag Writing 1 to this bit clears the DIEROK flag in the LPTIM_ISR register.
        DIEROKCF: u1,
        padding: u7 = 0,
    }),
    /// LPTIM interrupt enable register.
    /// offset: 0x08
    DIER: mmio.Mmio(packed struct(u32) {
        /// Capture/compare 1 interrupt enable.
        @"CCIE[0]": u1,
        /// Autoreload match Interrupt Enable.
        ARRMIE: u1,
        /// External trigger valid edge Interrupt Enable.
        EXTTRIGIE: u1,
        /// Compare register 1 update OK interrupt enable.
        @"CMPOKIE[0]": u1,
        /// Autoreload register update OK Interrupt Enable.
        ARROKIE: u1,
        /// Direction change to UP Interrupt Enable Note: If the LPTIM does not support encoder mode feature, this bit is reserved. Please refer to.
        UPIE: u1,
        /// Direction change to down Interrupt Enable Note: If the LPTIM does not support encoder mode feature, this bit is reserved. Please refer to.
        DOWNIE: u1,
        /// Update event interrupt enable.
        UEIE: u1,
        /// Repetition register update OK interrupt Enable.
        REPOKIE: u1,
        /// Capture/compare 1 interrupt enable.
        @"CCIE[1]": u1,
        /// Capture/compare 1 interrupt enable.
        @"CCIE[2]": u1,
        /// Capture/compare 1 interrupt enable.
        @"CCIE[3]": u1,
        /// (1/4 of CCOIE) Capture/compare 1 over-capture interrupt enable Note: If LPTIM does not implement at least 1 channel this bit is reserved. Please refer to.
        @"CCOIE[0]": u1,
        /// (2/4 of CCOIE) Capture/compare 1 over-capture interrupt enable Note: If LPTIM does not implement at least 1 channel this bit is reserved. Please refer to.
        @"CCOIE[1]": u1,
        /// (3/4 of CCOIE) Capture/compare 1 over-capture interrupt enable Note: If LPTIM does not implement at least 1 channel this bit is reserved. Please refer to.
        @"CCOIE[2]": u1,
        /// (4/4 of CCOIE) Capture/compare 1 over-capture interrupt enable Note: If LPTIM does not implement at least 1 channel this bit is reserved. Please refer to.
        @"CCOIE[3]": u1,
        /// Capture/compare 1 DMA request enable Note: If LPTIM does not implement at least 1 channel this bit is reserved. Please refer to.
        @"CCDE[0]": u1,
        reserved19: u2 = 0,
        /// Compare register 1 update OK interrupt enable.
        @"CMPOKIE[1]": u1,
        /// Compare register 1 update OK interrupt enable.
        @"CMPOKIE[2]": u1,
        /// Compare register 1 update OK interrupt enable.
        @"CMPOKIE[3]": u1,
        reserved25: u3 = 0,
        /// Capture/compare 1 DMA request enable Note: If LPTIM does not implement at least 1 channel this bit is reserved. Please refer to.
        @"CCDE[1]": u1,
        /// Capture/compare 1 DMA request enable Note: If LPTIM does not implement at least 1 channel this bit is reserved. Please refer to.
        @"CCDE[2]": u1,
        /// Capture/compare 1 DMA request enable Note: If LPTIM does not implement at least 1 channel this bit is reserved. Please refer to.
        @"CCDE[3]": u1,
        padding: u4 = 0,
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
        reserved22: u1 = 0,
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
        /// Counter reset This bit is set by software and cleared by hardware. When set to '1' this bit triggers a synchronous reset of the LPTIM_CNT counter register. Due to the synchronous nature of this reset, it only takes place after a synchronization delay of 3 LPTimer core clock cycles (LPTimer core clock may be different from APB clock). This bit can be set only when the LPTIM is enabled. It is automatically reset by hardware. COUNTRST must never be set to '1' by software before it is already cleared to '0' by hardware. Software should consequently check that COUNTRST bit is already cleared to '0' before attempting to set it to '1'.
        COUNTRST: u1,
        /// Reset after read enable This bit is set and cleared by software. When RSTARE is set to '1', any read access to LPTIM_CNT register asynchronously resets LPTIM_CNT register content. This bit can be set only when the LPTIM is enabled.
        RSTARE: u1,
        padding: u27 = 0,
    }),
    /// LPTIM compare register 1.
    /// offset: 0x14
    CCR: mmio.Mmio(packed struct(u32) {
        /// Capture/compare 1 value If channel CC1 is configured as output: CCR1 is the value to be loaded in the capture/compare 1 register. Depending on the PRELOAD option, the CCR1 register is immediately updated if the PRELOAD bit is reset and updated at next LPTIM update event if PREOAD bit is reset. The capture/compare register 1 contains the value to be compared to the counter LPTIM_CNT and signaled on OC1 output. If channel CC1 is configured as input: CCR1 contains the counter value transferred by the last input capture 1 event. The LPTIM_CCR1 register is read-only and cannot be programmed. If LPTIM does not implement any channel: The compare register 1 contains the value to be compared to the counter LPTIM_CNT and signaled on LPTIM output.
        CCR: u16,
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
    /// offset: 0x20
    reserved32: [4]u8,
    /// LPTIM configuration register 2.
    /// offset: 0x24
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// (1/2 of INSEL) LPTIM input 1 selection The IN1SEL bits control the LPTIM input 1 multiplexer, which connects LPTIM input 1 to one of the available inputs. For connection details refer to.
        @"INSEL[0]": u2,
        reserved4: u2 = 0,
        /// (2/2 of INSEL) LPTIM input 1 selection The IN1SEL bits control the LPTIM input 1 multiplexer, which connects LPTIM input 1 to one of the available inputs. For connection details refer to.
        @"INSEL[1]": u2,
        reserved16: u10 = 0,
        /// (1/2 of ICSEL) LPTIM input capture 1 selection The IC1SEL bits control the LPTIM Input capture 1 multiplexer, which connects LPTIM Input capture 1 to one of the available inputs. For connection details refer to.
        @"ICSEL[0]": u2,
        reserved20: u2 = 0,
        /// (2/2 of ICSEL) LPTIM input capture 1 selection The IC1SEL bits control the LPTIM Input capture 1 multiplexer, which connects LPTIM Input capture 1 to one of the available inputs. For connection details refer to.
        @"ICSEL[1]": u2,
        padding: u10 = 0,
    }),
    /// LPTIM repetition register.
    /// offset: 0x28
    RCR: mmio.Mmio(packed struct(u32) {
        /// Repetition register value REP is the repetition value for the LPTIM.
        REP: u8,
        padding: u24 = 0,
    }),
    /// LPTIM capture/compare mode register.
    /// offset: 0x2c
    CCMR: mmio.Mmio(packed struct(u32) {
        /// (1/2 of CCSEL) Capture/compare selection. This bitfield defines the direction of the channel input (capture) or output mode.
        @"CCSEL[0]": CCSEL,
        /// (1/2 of CCE) Capture/compare output enable. This bit determines if a capture of the counter value can actually be done into the input capture/compare register 1 (LPTIM_CCR1) or not.
        @"CCE[0]": u1,
        /// (1/2 of CCP_Input) Capture/compare output polarity. Only bit2 is used to set polarity when output mode is enabled, bit3 is don't care. This field is used to select the IC1 polarity for capture operations.
        @"CCP_Input[0]": CCP_Input,
        reserved8: u4 = 0,
        /// (1/2 of ICPSC) Input capture prescaler This bitfield defines the ratio of the prescaler acting on the CC1 input (IC1).
        @"ICPSC[0]": Filter,
        reserved12: u2 = 0,
        /// (1/2 of ICF) Input capture filter This bitfield defines the number of consecutive equal samples that should be detected when a level change occurs on an external input capture signal before it is considered as a valid level transition. An internal clock source must be present to use this feature.
        @"ICF[0]": Filter,
        reserved16: u2 = 0,
        /// (2/2 of CCSEL) Capture/compare selection. This bitfield defines the direction of the channel input (capture) or output mode.
        @"CCSEL[1]": CCSEL,
        /// (2/2 of CCE) Capture/compare output enable. This bit determines if a capture of the counter value can actually be done into the input capture/compare register 1 (LPTIM_CCR1) or not.
        @"CCE[1]": u1,
        /// (2/2 of CCP_Input) Capture/compare output polarity. Only bit2 is used to set polarity when output mode is enabled, bit3 is don't care. This field is used to select the IC1 polarity for capture operations.
        @"CCP_Input[1]": CCP_Input,
        reserved24: u4 = 0,
        /// (2/2 of ICPSC) Input capture prescaler This bitfield defines the ratio of the prescaler acting on the CC1 input (IC1).
        @"ICPSC[1]": Filter,
        reserved28: u2 = 0,
        /// (2/2 of ICF) Input capture filter This bitfield defines the number of consecutive equal samples that should be detected when a level change occurs on an external input capture signal before it is considered as a valid level transition. An internal clock source must be present to use this feature.
        @"ICF[1]": Filter,
        padding: u2 = 0,
    }),
};
