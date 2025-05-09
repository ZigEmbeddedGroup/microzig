const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const LPMS = enum(u3) {
    /// Stop 0 mode
    Stop0 = 0x0,
    /// Stop 1 mode
    Stop1 = 0x1,
    /// Stop 2 mode
    Stop2 = 0x2,
    /// Standby mode
    Standby = 0x3,
    _,
};

pub const PLS = enum(u3) {
    /// V<sub>PVD0</sub> around 2.01V
    B_0x0 = 0x0,
    /// V<sub>PVD1</sub> around 2.21V
    B_0x1 = 0x1,
    /// V<sub>PVD2</sub> around 2.41V
    B_0x2 = 0x2,
    /// V<sub>PVD3</sub> around 2.51V
    B_0x3 = 0x3,
    /// V<sub>PVD4</sub> around 2.61V
    B_0x4 = 0x4,
    /// V<sub>PVD5</sub> around 2.81V
    B_0x5 = 0x5,
    /// V<sub>PVD6</sub> around 2.91V
    B_0x6 = 0x6,
    /// External input analog voltage PVD_IN (compared internally to VREFINT)
    B_0x7 = 0x7,
};

pub const STOPF = enum(u3) {
    /// The device did not enter any Stop mode.
    None = 0x0,
    /// The device entered in Stop 0 mode.
    Stop0 = 0x4,
    /// The device entered in Stop 1 mode.
    Stop1 = 0x5,
    /// The device entered in Stop 2 mode.
    Stop2 = 0x6,
    _,
};

pub const VOS = enum(u2) {
    /// Range 1
    Range1 = 0x1,
    /// Range 2
    Range2 = 0x2,
    _,
};

/// PWR register block
pub const PWR = extern struct {
    /// Power control register 1
    /// offset: 0x00
    CR1: mmio.Mmio(packed struct(u32) {
        /// Low-power mode selection These bits select the low-power mode entered when CPU enters the deepsleep mode. 1xx: Shutdown mode Note: If LPR bit is set, Stop 2 mode cannot be selected and Stop 1 mode shall be entered instead of Stop 2. Note: In Standby mode, SRAM2 can be preserved or not, depending on RRS bit configuration in PWR_CR3.
        LPMS: LPMS,
        /// Flash memory powered down during Stop mode. This bit determines whether the flash memory is put in power-down mode or remains in idle mode when the device enters Stop mode.
        FPD_STOP: u1,
        /// Flash memory powered down during Low-power run mode. This bit determines whether the flash memory is put in power-down mode or remains in idle mode when the device enters Low-power sleep mode.
        FPD_LPRUN: u1,
        /// Flash memory powered down during Low-power sleep mode. This bit determines whether the flash memory is put in power-down mode or remains in idle mode when the device enters Low-power sleep mode.
        FPD_LPSLP: u1,
        reserved8: u2 = 0,
        /// Disable backup domain write protection In reset state, the RTC and backup registers are protected against parasitic write access. This bit must be set to enable write access to these registers.
        DBP: u1,
        /// Voltage scaling range selection
        VOS: VOS,
        reserved14: u3 = 0,
        /// Low-power run When this bit is set, the regulator is switched from main mode (MR) to low-power mode (LPR). Note: Stop 2 mode cannot be entered when LPR bit is set. Stop 1 is entered instead.
        LPR: u1,
        padding: u17 = 0,
    }),
    /// Power control register 2
    /// offset: 0x04
    CR2: mmio.Mmio(packed struct(u32) {
        /// Programmable voltage detector enable Note: This bit is write-protected when the bit PVDL (PVD Lock) is set in the SYSCFG_CBR register. Note: This bit is reset only by a system reset.
        PVDE: u1,
        /// Programmable voltage detector level selection. These bits select the voltage threshold detected by the programmable voltage detector: Note: These bits are write-protected when the bit PVDL (PVD Lock) is set in the SYSCFG_CBR register. Note: These bits are reset only by a system reset.
        PLS: PLS,
        /// Peripheral voltage monitoring 1 enable: V<sub>DDUSB</sub> vs. 1.21V
        PVME1: u1,
        /// Peripheral voltage monitoring 3 enable: V<sub>DDA</sub> vs. 1.621V
        PVME3: u1,
        /// Peripheral voltage monitoring 4 enable: V<sub>DDA</sub> vs. 1.861V
        PVME4: u1,
        reserved10: u3 = 0,
        /// V<sub>DDUSB</sub> USB supply valid This bit is used to validate the V<sub>DDUSB</sub> supply for electrical and logical isolation purpose. Setting this bit is mandatory to use the USB FS peripheral. If V<sub>DDUSB</sub> is not always present in the application, the PVM can be used to determine whether this supply is ready or not.
        USV: u1,
        padding: u21 = 0,
    }),
    /// Power control register 3
    /// offset: 0x08
    CR3: mmio.Mmio(packed struct(u32) {
        /// Enable Wake-up pin WKUP1 When this bit is set, the external wake-up pin WKUP1 is enabled and triggers a wake-up from Standby or Shutdown event when a rising or a falling edge occurs. The active edge is configured via the WP1 bit in the PWR_CR4 register.
        EWUP1: u1,
        /// Enable Wake-up pin WKUP2 When this bit is set, the external wake-up pin WKUP2 is enabled and triggers a wake-up from Standby or Shutdown event when a rising or a falling edge occurs. The active edge is configured via the WP2 bit in the PWR_CR4 register.
        EWUP2: u1,
        /// Enable Wake-up pin WKUP3 When this bit is set, the external wake-up pin WKUP3 is enabled and triggers a wake-up from Standby or Shutdown event when a rising or a falling edge occurs. The active edge is configured via the WP3 bit in the PWR_CR4 register.
        EWUP3: u1,
        /// Enable Wake-up pin WKUP4 When this bit is set, the external wake-up pin WKUP4 is enabled and triggers a wake-up from Standby or Shutdown event when a rising or a falling edge occurs. The active edge is configured via the WP4 bit in the PWR_CR4 register.
        EWUP4: u1,
        /// Enable Wake-up pin WKUP5 When this bit is set, the external wake-up pin WKUP5 is enabled and triggers a wake-up from Standby or Shutdown event when a rising or a falling edge occurs.The active edge is configured via the WP5 bit in the PWR_CR4 register.
        EWUP5: u1,
        reserved6: u1 = 0,
        /// Enable Wake-up pin WKUP7. When this bit is set, the external wake-up pin WKUP7 is enabled and triggers a wake-up from Standby or Shutdown event when a rising or a falling edge occurs.The active edge is configured via the WP7 bit in the PWR_CR4 register.
        EWUP7: u1,
        reserved8: u1 = 0,
        /// SRAM2 retention in Standby mode
        RRS: u1,
        /// Enable ULP sampling When this bit is set, the BORL, BORH and PVD are periodically sampled instead continuous monitoring to reduce power consumption. Fast supply drop between two sample/compare phases is not detected in this mode. This bit has impact only on STOP2, Standby and shutdown low power modes.
        ENULP: u1,
        /// Apply pull-up and pull-down configuration When this bit is set, the I/O pull-up and pull-down configurations defined in the PWR_PUCRx and PWR_PDCRx registers are applied. When this bit is cleared, the PWR_PUCRx and PWR_PDCRx registers are not applied to the I/Os, instead the I/Os are in floating mode during Standby or configured according GPIO controller GPIOx_PUPDR register during RUN mode.
        APC: u1,
        reserved15: u4 = 0,
        /// Enable internal wake-up line
        EIWUL: u1,
        padding: u16 = 0,
    }),
    /// Power control register 4
    /// offset: 0x0c
    CR4: mmio.Mmio(packed struct(u32) {
        /// Wake-up pin WKUP1 polarity This bit defines the polarity used for an event detection on external wake-up pin, WKUP1
        WP1: u1,
        /// Wake-up pin WKUP2 polarity This bit defines the polarity used for an event detection on external wake-up pin, WKUP2
        WP2: u1,
        /// Wake-up pin WKUP3 polarity This bit defines the polarity used for an event detection on external wake-up pin, WKUP3
        WP3: u1,
        /// Wake-up pin WKUP4 polarity This bit defines the polarity used for an event detection on external wake-up pin, WKUP4
        WP4: u1,
        /// Wake-up pin WKUP5 polarity This bit defines the polarity used for an event detection on external wake-up pin, WKUP5
        WP5: u1,
        reserved6: u1 = 0,
        /// Wake-up pin WKUP7 polarity This bit defines the polarity used for an event detection on external wake-up pin, WKUP7
        WP7: u1,
        reserved8: u1 = 0,
        /// V<sub>BAT</sub> battery charging enable
        VBE: u1,
        /// V<sub>BAT</sub> battery charging resistor selection
        VBRS: u1,
        padding: u22 = 0,
    }),
    /// Power status register 1
    /// offset: 0x10
    SR1: mmio.Mmio(packed struct(u32) {
        /// Wake-up flag 1 This bit is set when a wake-up event is detected on wake-up pin, WKUP1. It is cleared by writing 1 in the CWUF1 bit of the PWR_SCR register.
        WUF1: u1,
        /// Wake-up flag 2 This bit is set when a wake-up event is detected on wake-up pin, WKUP2. It is cleared by writing 1 in the CWUF2 bit of the PWR_SCR register.
        WUF2: u1,
        /// Wake-up flag 3 This bit is set when a wake-up event is detected on wake-up pin, WKUP3. It is cleared by writing 1 in the CWUF3 bit of the PWR_SCR register.
        WUF3: u1,
        /// Wake-up flag 4 This bit is set when a wake-up event is detected on wake-up pin,WKUP4. It is cleared by writing 1 in the CWUF4 bit of the PWR_SCR register.
        WUF4: u1,
        /// Wake-up flag 5 This bit is set when a wake-up event is detected on wake-up pin, WKUP5. It is cleared by writing 1 in the CWUF5 bit of the PWR_SCR register.
        WUF5: u1,
        reserved6: u1 = 0,
        /// Wake-up flag 7 This bit is set when a wake-up event is detected on wake-up pin, WKUP7. It is cleared by writing 1 in the CWUF7 bit of the PWR_SCR register.
        WUF7: u1,
        reserved8: u1 = 0,
        /// Standby flag This bit is set by hardware when the device enters the Standby mode and is cleared by setting the CSBF bit in the PWR_SCR register, or by a power-on reset. It is not cleared by the system reset.
        SBF: u1,
        /// Stop Flags These bits are set by hardware when the device enters any stop mode and are cleared by setting the CSBF bit in the PWR_SCR register, or by a power-on reset. It is not cleared by the system reset.
        STOPF: STOPF,
        reserved15: u3 = 0,
        /// Wake-up flag internal This bit is set when a wake-up is detected on the internal wake-up line. It is cleared when all internal wake-up sources are cleared.
        WUFI: u1,
        padding: u16 = 0,
    }),
    /// Power status register 2
    /// offset: 0x14
    SR2: mmio.Mmio(packed struct(u32) {
        reserved7: u7 = 0,
        /// Flash ready flag This bit is set by hardware to indicate when the flash memory is readey to be accessed after wake-up from power-down. To place the flash memory in power-down, set either FPD_LPRUN, FPD_LPSLP or FPD_STP bits. Note : If the system boots from SRAM, the user application must wait until the FLASH_RDY bit is set, prior to jumping to flash memory.
        FLASH_RDY: u1,
        /// Low-power regulator started This bit provides the information whether the low-power regulator is ready after a power-on reset or a Standby/Shutdown. If the Standby mode is entered while REGLPS bit is still cleared, the wake-up from Standby mode time may be increased.
        REGLPS: u1,
        /// Low-power regulator flag This bit is set by hardware when the MCU is in Low-power run mode. When the MCU exits from the Low-power run mode, this bit remains at 1 until the regulator is ready in main mode. A polling on this bit must be done before increasing the product frequency. This bit is cleared by hardware when the regulator is ready.
        REGLPF: u1,
        /// Voltage scaling flag A delay is required for the internal regulator to be ready after the voltage scaling has been changed. VOSF indicates that the regulator reached the voltage level defined with VOS bits of the PWR_CR1 register.
        VOSF: u1,
        /// Programmable voltage detector output
        PVDO: u1,
        /// Peripheral voltage monitoring output: V<sub>DDUSB</sub> vs. 1.2 V Note: PVMO1 is cleared when PVM1 is disabled (PVME1 = 0). After enabling PVM1, the PVM1 output is valid after the PVM1 wake-up time.
        PVMO1: u1,
        reserved14: u1 = 0,
        /// Peripheral voltage monitoring output: V<sub>DDA</sub> vs. 1.621V Note: PVMO3 is cleared when PVM3 is disabled (PVME3 = 0). After enabling PVM3, the PVM3 output is valid after the PVM3 wake-up time.
        PVMO3: u1,
        /// Peripheral voltage monitoring output: V<sub>DDA</sub> vs. 2.21V Note: PVMO4 is cleared when PVM4 is disabled (PVME4 = 0). After enabling PVM4, the PVM4 output is valid after the PVM4 wake-up time.
        PVMO4: u1,
        padding: u16 = 0,
    }),
    /// Power status clear register
    /// offset: 0x18
    SCR: mmio.Mmio(packed struct(u32) {
        /// Clear wake-up flag 1 Setting this bit clears the WUF1 flag in the PWR_SR1 register.
        CWUF1: u1,
        /// Clear wake-up flag 2 Setting this bit clears the WUF2 flag in the PWR_SR1 register.
        CWUF2: u1,
        /// Clear wake-up flag 3 Setting this bit clears the WUF3 flag in the PWR_SR1 register.
        CWUF3: u1,
        /// Clear wake-up flag 4 Setting this bit clears the WUF4 flag in the PWR_SR1 register.
        CWUF4: u1,
        /// Clear wake-up flag 5 Setting this bit clears the WUF5 flag in the PWR_SR1 register.
        CWUF5: u1,
        reserved6: u1 = 0,
        /// Clear wake-up flag 7 Setting this bit clears the WUF7 flag in the PWR_SR1 register.
        CWUF7: u1,
        reserved8: u1 = 0,
        /// Clear standby flag Setting this bit clears the SBF flag in the PWR_SR1 register.
        CSBF: u1,
        padding: u23 = 0,
    }),
    /// offset: 0x1c
    reserved28: [4]u8,
    /// Power Port A pull-up control register
    /// offset: 0x20
    PUCRA: mmio.Mmio(packed struct(u32) {
        /// Port A pull-up bit y (y1=115 to 0) When set, this bit activates the pull-up on PA[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU0: u1,
        /// Port A pull-up bit y (y1=115 to 0) When set, this bit activates the pull-up on PA[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU1: u1,
        /// Port A pull-up bit y (y1=115 to 0) When set, this bit activates the pull-up on PA[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU2: u1,
        /// Port A pull-up bit y (y1=115 to 0) When set, this bit activates the pull-up on PA[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU3: u1,
        /// Port A pull-up bit y (y1=115 to 0) When set, this bit activates the pull-up on PA[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU4: u1,
        /// Port A pull-up bit y (y1=115 to 0) When set, this bit activates the pull-up on PA[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU5: u1,
        /// Port A pull-up bit y (y1=115 to 0) When set, this bit activates the pull-up on PA[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU6: u1,
        /// Port A pull-up bit y (y1=115 to 0) When set, this bit activates the pull-up on PA[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU7: u1,
        /// Port A pull-up bit y (y1=115 to 0) When set, this bit activates the pull-up on PA[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU8: u1,
        /// Port A pull-up bit y (y1=115 to 0) When set, this bit activates the pull-up on PA[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU9: u1,
        /// Port A pull-up bit y (y1=115 to 0) When set, this bit activates the pull-up on PA[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU10: u1,
        /// Port A pull-up bit y (y1=115 to 0) When set, this bit activates the pull-up on PA[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU11: u1,
        /// Port A pull-up bit y (y1=115 to 0) When set, this bit activates the pull-up on PA[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU12: u1,
        /// Port A pull-up bit y (y1=115 to 0) When set, this bit activates the pull-up on PA[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU13: u1,
        /// Port A pull-up bit y (y1=115 to 0) When set, this bit activates the pull-up on PA[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU14: u1,
        /// Port A pull-up bit y (y1=115 to 0) When set, this bit activates the pull-up on PA[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU15: u1,
        padding: u16 = 0,
    }),
    /// Power Port A pull-down control register
    /// offset: 0x24
    PDCRA: mmio.Mmio(packed struct(u32) {
        /// Port A pull-down bit y When set, this bit activates the pull-down on PA[y] when APC bit is set in PWR_CR3 register.
        PD0: u1,
        /// Port A pull-down bit y When set, this bit activates the pull-down on PA[y] when APC bit is set in PWR_CR3 register.
        PD1: u1,
        /// Port A pull-down bit y When set, this bit activates the pull-down on PA[y] when APC bit is set in PWR_CR3 register.
        PD2: u1,
        /// Port A pull-down bit y When set, this bit activates the pull-down on PA[y] when APC bit is set in PWR_CR3 register.
        PD3: u1,
        /// Port A pull-down bit y When set, this bit activates the pull-down on PA[y] when APC bit is set in PWR_CR3 register.
        PD4: u1,
        /// Port A pull-down bit y When set, this bit activates the pull-down on PA[y] when APC bit is set in PWR_CR3 register.
        PD5: u1,
        /// Port A pull-down bit y When set, this bit activates the pull-down on PA[y] when APC bit is set in PWR_CR3 register.
        PD6: u1,
        /// Port A pull-down bit y When set, this bit activates the pull-down on PA[y] when APC bit is set in PWR_CR3 register.
        PD7: u1,
        /// Port A pull-down bit y When set, this bit activates the pull-down on PA[y] when APC bit is set in PWR_CR3 register.
        PD8: u1,
        /// Port A pull-down bit y When set, this bit activates the pull-down on PA[y] when APC bit is set in PWR_CR3 register.
        PD9: u1,
        /// Port A pull-down bit y When set, this bit activates the pull-down on PA[y] when APC bit is set in PWR_CR3 register.
        PD10: u1,
        /// Port A pull-down bit y When set, this bit activates the pull-down on PA[y] when APC bit is set in PWR_CR3 register.
        PD11: u1,
        /// Port A pull-down bit y When set, this bit activates the pull-down on PA[y] when APC bit is set in PWR_CR3 register.
        PD12: u1,
        /// Port A pull-down bit y When set, this bit activates the pull-down on PA[y] when APC bit is set in PWR_CR3 register.
        PD13: u1,
        /// Port A pull-down bit y When set, this bit activates the pull-down on PA[y] when APC bit is set in PWR_CR3 register.
        PD14: u1,
        /// Port A pull-down bit y When set, this bit activates the pull-down on PA[y] when APC bit is set in PWR_CR3 register.
        PD15: u1,
        padding: u16 = 0,
    }),
    /// Power Port B pull-up control register
    /// offset: 0x28
    PUCRB: mmio.Mmio(packed struct(u32) {
        /// Port B pull-up bit y When set, this bit activates the pull-up on PB[y] when APC bit is set in PWR_CR3 register.
        PU0: u1,
        /// Port B pull-up bit y When set, this bit activates the pull-up on PB[y] when APC bit is set in PWR_CR3 register.
        PU1: u1,
        /// Port B pull-up bit y When set, this bit activates the pull-up on PB[y] when APC bit is set in PWR_CR3 register.
        PU2: u1,
        /// Port B pull-up bit y When set, this bit activates the pull-up on PB[y] when APC bit is set in PWR_CR3 register.
        PU3: u1,
        /// Port B pull-up bit y When set, this bit activates the pull-up on PB[y] when APC bit is set in PWR_CR3 register.
        PU4: u1,
        /// Port B pull-up bit y When set, this bit activates the pull-up on PB[y] when APC bit is set in PWR_CR3 register.
        PU5: u1,
        /// Port B pull-up bit y When set, this bit activates the pull-up on PB[y] when APC bit is set in PWR_CR3 register.
        PU6: u1,
        /// Port B pull-up bit y When set, this bit activates the pull-up on PB[y] when APC bit is set in PWR_CR3 register.
        PU7: u1,
        /// Port B pull-up bit y When set, this bit activates the pull-up on PB[y] when APC bit is set in PWR_CR3 register.
        PU8: u1,
        /// Port B pull-up bit y When set, this bit activates the pull-up on PB[y] when APC bit is set in PWR_CR3 register.
        PU9: u1,
        /// Port B pull-up bit y When set, this bit activates the pull-up on PB[y] when APC bit is set in PWR_CR3 register.
        PU10: u1,
        /// Port B pull-up bit y When set, this bit activates the pull-up on PB[y] when APC bit is set in PWR_CR3 register.
        PU11: u1,
        /// Port B pull-up bit y When set, this bit activates the pull-up on PB[y] when APC bit is set in PWR_CR3 register.
        PU12: u1,
        /// Port B pull-up bit y When set, this bit activates the pull-up on PB[y] when APC bit is set in PWR_CR3 register.
        PU13: u1,
        /// Port B pull-up bit y When set, this bit activates the pull-up on PB[y] when APC bit is set in PWR_CR3 register.
        PU14: u1,
        /// Port B pull-up bit y When set, this bit activates the pull-up on PB[y] when APC bit is set in PWR_CR3 register.
        PU15: u1,
        padding: u16 = 0,
    }),
    /// Power Port B pull-down control register
    /// offset: 0x2c
    PDCRB: mmio.Mmio(packed struct(u32) {
        /// Port B pull-down bit y When set, this bit activates the pull-down on PB[y] when APC bit is set in PWR_CR3 register.
        PD0: u1,
        /// Port B pull-down bit y When set, this bit activates the pull-down on PB[y] when APC bit is set in PWR_CR3 register.
        PD1: u1,
        /// Port B pull-down bit y When set, this bit activates the pull-down on PB[y] when APC bit is set in PWR_CR3 register.
        PD2: u1,
        /// Port B pull-down bit y When set, this bit activates the pull-down on PB[y] when APC bit is set in PWR_CR3 register.
        PD3: u1,
        /// Port B pull-down bit y When set, this bit activates the pull-down on PB[y] when APC bit is set in PWR_CR3 register.
        PD4: u1,
        /// Port B pull-down bit y When set, this bit activates the pull-down on PB[y] when APC bit is set in PWR_CR3 register.
        PD5: u1,
        /// Port B pull-down bit y When set, this bit activates the pull-down on PB[y] when APC bit is set in PWR_CR3 register.
        PD6: u1,
        /// Port B pull-down bit y When set, this bit activates the pull-down on PB[y] when APC bit is set in PWR_CR3 register.
        PD7: u1,
        /// Port B pull-down bit y When set, this bit activates the pull-down on PB[y] when APC bit is set in PWR_CR3 register.
        PD8: u1,
        /// Port B pull-down bit y When set, this bit activates the pull-down on PB[y] when APC bit is set in PWR_CR3 register.
        PD9: u1,
        /// Port B pull-down bit y When set, this bit activates the pull-down on PB[y] when APC bit is set in PWR_CR3 register.
        PD10: u1,
        /// Port B pull-down bit y When set, this bit activates the pull-down on PB[y] when APC bit is set in PWR_CR3 register.
        PD11: u1,
        /// Port B pull-down bit y When set, this bit activates the pull-down on PB[y] when APC bit is set in PWR_CR3 register.
        PD12: u1,
        /// Port B pull-down bit y When set, this bit activates the pull-down on PB[y] when APC bit is set in PWR_CR3 register.
        PD13: u1,
        /// Port B pull-down bit y When set, this bit activates the pull-down on PB[y] when APC bit is set in PWR_CR3 register.
        PD14: u1,
        /// Port B pull-down bit y When set, this bit activates the pull-down on PB[y] when APC bit is set in PWR_CR3 register.
        PD15: u1,
        padding: u16 = 0,
    }),
    /// Power Port C pull-up control register
    /// offset: 0x30
    PUCRC: mmio.Mmio(packed struct(u32) {
        /// Port C pull-up bit y When set, this bit activates the pull-up on PC[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU0: u1,
        /// Port C pull-up bit y When set, this bit activates the pull-up on PC[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU1: u1,
        /// Port C pull-up bit y When set, this bit activates the pull-up on PC[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU2: u1,
        /// Port C pull-up bit y When set, this bit activates the pull-up on PC[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU3: u1,
        /// Port C pull-up bit y When set, this bit activates the pull-up on PC[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU4: u1,
        /// Port C pull-up bit y When set, this bit activates the pull-up on PC[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU5: u1,
        /// Port C pull-up bit y When set, this bit activates the pull-up on PC[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU6: u1,
        /// Port C pull-up bit y When set, this bit activates the pull-up on PC[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU7: u1,
        /// Port C pull-up bit y When set, this bit activates the pull-up on PC[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU8: u1,
        /// Port C pull-up bit y When set, this bit activates the pull-up on PC[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU9: u1,
        /// Port C pull-up bit y When set, this bit activates the pull-up on PC[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU10: u1,
        /// Port C pull-up bit y When set, this bit activates the pull-up on PC[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU11: u1,
        /// Port C pull-up bit y When set, this bit activates the pull-up on PC[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU12: u1,
        /// Port C pull-up bit y When set, this bit activates the pull-up on PC[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU13: u1,
        /// Port C pull-up bit y When set, this bit activates the pull-up on PC[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU14: u1,
        /// Port C pull-up bit y When set, this bit activates the pull-up on PC[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU15: u1,
        padding: u16 = 0,
    }),
    /// Power Port C pull-down control register
    /// offset: 0x34
    PDCRC: mmio.Mmio(packed struct(u32) {
        /// Port C pull-down bit y When set, this bit activates the pull-down on PC[y] when APC bit is set in PWR_CR3 register.
        PD0: u1,
        /// Port C pull-down bit y When set, this bit activates the pull-down on PC[y] when APC bit is set in PWR_CR3 register.
        PD1: u1,
        /// Port C pull-down bit y When set, this bit activates the pull-down on PC[y] when APC bit is set in PWR_CR3 register.
        PD2: u1,
        /// Port C pull-down bit y When set, this bit activates the pull-down on PC[y] when APC bit is set in PWR_CR3 register.
        PD3: u1,
        /// Port C pull-down bit y When set, this bit activates the pull-down on PC[y] when APC bit is set in PWR_CR3 register.
        PD4: u1,
        /// Port C pull-down bit y When set, this bit activates the pull-down on PC[y] when APC bit is set in PWR_CR3 register.
        PD5: u1,
        /// Port C pull-down bit y When set, this bit activates the pull-down on PC[y] when APC bit is set in PWR_CR3 register.
        PD6: u1,
        /// Port C pull-down bit y When set, this bit activates the pull-down on PC[y] when APC bit is set in PWR_CR3 register.
        PD7: u1,
        /// Port C pull-down bit y When set, this bit activates the pull-down on PC[y] when APC bit is set in PWR_CR3 register.
        PD8: u1,
        /// Port C pull-down bit y When set, this bit activates the pull-down on PC[y] when APC bit is set in PWR_CR3 register.
        PD9: u1,
        /// Port C pull-down bit y When set, this bit activates the pull-down on PC[y] when APC bit is set in PWR_CR3 register.
        PD10: u1,
        /// Port C pull-down bit y When set, this bit activates the pull-down on PC[y] when APC bit is set in PWR_CR3 register.
        PD11: u1,
        /// Port C pull-down bit y When set, this bit activates the pull-down on PC[y] when APC bit is set in PWR_CR3 register.
        PD12: u1,
        /// Port C pull-down bit y When set, this bit activates the pull-down on PC[y] when APC bit is set in PWR_CR3 register.
        PD13: u1,
        /// Port C pull-down bit y When set, this bit activates the pull-down on PC[y] when APC bit is set in PWR_CR3 register.
        PD14: u1,
        /// Port C pull-down bit y When set, this bit activates the pull-down on PC[y] when APC bit is set in PWR_CR3 register.
        PD15: u1,
        padding: u16 = 0,
    }),
    /// Power Port D pull-up control register
    /// offset: 0x38
    PUCRD: mmio.Mmio(packed struct(u32) {
        /// Port D pull-up bit y When set, this bit activates the pull-up on PD[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU0: u1,
        /// Port D pull-up bit y When set, this bit activates the pull-up on PD[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU1: u1,
        /// Port D pull-up bit y When set, this bit activates the pull-up on PD[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU2: u1,
        /// Port D pull-up bit y When set, this bit activates the pull-up on PD[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU3: u1,
        /// Port D pull-up bit y When set, this bit activates the pull-up on PD[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU4: u1,
        /// Port D pull-up bit y When set, this bit activates the pull-up on PD[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU5: u1,
        /// Port D pull-up bit y When set, this bit activates the pull-up on PD[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU6: u1,
        reserved8: u1 = 0,
        /// Port D pull-up bit y When set, this bit activates the pull-up on PD[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU8: u1,
        /// Port D pull-up bit y When set, this bit activates the pull-up on PD[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU9: u1,
        /// Port D pull-up bit y When set, this bit activates the pull-up on PD[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU10: u1,
        /// Port D pull-up bit y When set, this bit activates the pull-up on PD[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU11: u1,
        /// Port D pull-up bit y When set, this bit activates the pull-up on PD[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU12: u1,
        /// Port D pull-up bit y When set, this bit activates the pull-up on PD[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU13: u1,
        padding: u18 = 0,
    }),
    /// Power Port D pull-down control register
    /// offset: 0x3c
    PDCRD: mmio.Mmio(packed struct(u32) {
        /// Port D pull-down bit y When set, this bit activates the pull-down on PD[y] when APC bit is set in PWR_CR3 register.
        PD0: u1,
        /// Port D pull-down bit y When set, this bit activates the pull-down on PD[y] when APC bit is set in PWR_CR3 register.
        PD1: u1,
        /// Port D pull-down bit y When set, this bit activates the pull-down on PD[y] when APC bit is set in PWR_CR3 register.
        PD2: u1,
        /// Port D pull-down bit y When set, this bit activates the pull-down on PD[y] when APC bit is set in PWR_CR3 register.
        PD3: u1,
        /// Port D pull-down bit y When set, this bit activates the pull-down on PD[y] when APC bit is set in PWR_CR3 register.
        PD4: u1,
        /// Port D pull-down bit y When set, this bit activates the pull-down on PD[y] when APC bit is set in PWR_CR3 register.
        PD5: u1,
        /// Port D pull-down bit y When set, this bit activates the pull-down on PD[y] when APC bit is set in PWR_CR3 register.
        PD6: u1,
        reserved8: u1 = 0,
        /// Port D pull-down bit y When set, this bit activates the pull-down on PD[y] when APC bit is set in PWR_CR3 register.
        PD8: u1,
        /// Port D pull-down bit y When set, this bit activates the pull-down on PD[y] when APC bit is set in PWR_CR3 register.
        PD9: u1,
        /// Port D pull-down bit y When set, this bit activates the pull-down on PD[y] when APC bit is set in PWR_CR3 register.
        PD10: u1,
        /// Port D pull-down bit y When set, this bit activates the pull-down on PD[y] when APC bit is set in PWR_CR3 register.
        PD11: u1,
        /// Port D pull-down bit y When set, this bit activates the pull-down on PD[y] when APC bit is set in PWR_CR3 register.
        PD12: u1,
        /// Port D pull-down bit y When set, this bit activates the pull-down on PD[y] when APC bit is set in PWR_CR3 register.
        PD13: u1,
        padding: u18 = 0,
    }),
    /// Power Port E pull-up control register
    /// offset: 0x40
    PUCRE: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// Port E pull-up bit 3 When set, this bit activates the pull-up on PE[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU3: u1,
        reserved7: u3 = 0,
        /// Port E pull-up bit y When set, this bit activates the pull-up on PE[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU7: u1,
        /// Port E pull-up bit y When set, this bit activates the pull-up on PE[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU8: u1,
        /// Port E pull-up bit y When set, this bit activates the pull-up on PE[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU9: u1,
        padding: u22 = 0,
    }),
    /// Power Port E pull-down control register
    /// offset: 0x44
    PDCRE: mmio.Mmio(packed struct(u32) {
        reserved3: u3 = 0,
        /// Port E pull-down bit 3 When set, this bit activates the pull-down on PE[y] when APC bit is set in PWR_CR3 register.
        PD3: u1,
        reserved7: u3 = 0,
        /// Port E pull-down bit y When set, this bit activates the pull-down on PE[y] when APC bit is set in PWR_CR3 register.
        PD7: u1,
        /// Port E pull-down bit y When set, this bit activates the pull-down on PE[y] when APC bit is set in PWR_CR3 register.
        PD8: u1,
        /// Port E pull-down bit y When set, this bit activates the pull-down on PE[y] when APC bit is set in PWR_CR3 register.
        PD9: u1,
        padding: u22 = 0,
    }),
    /// Power Port F pull-up control register
    /// offset: 0x48
    PUCRF: mmio.Mmio(packed struct(u32) {
        /// Port F pull-up bit y When set, this bit activates the pull-up on PH[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU0: u1,
        /// Port F pull-up bit y When set, this bit activates the pull-up on PH[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU1: u1,
        /// Port F pull-up bit y When set, this bit activates the pull-up on PH[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU2: u1,
        /// Port F pull-up bit y When set, this bit activates the pull-up on PH[y] when APC bit is set in PWR_CR3 register. If the corresponding PDy bit is also set, the pull-up is not activated and the pull-down is activated instead with highest priority.
        PU3: u1,
        padding: u28 = 0,
    }),
    /// Power Port F pull-down control register
    /// offset: 0x4c
    PDCRF: mmio.Mmio(packed struct(u32) {
        /// Port F pull-down bit y When set, this bit activates the pull-down on PH[y] when APC bit is set in PWR_CR3 register.
        PD0: u1,
        /// Port F pull-down bit y When set, this bit activates the pull-down on PH[y] when APC bit is set in PWR_CR3 register.
        PD1: u1,
        /// Port F pull-down bit y When set, this bit activates the pull-down on PH[y] when APC bit is set in PWR_CR3 register.
        PD2: u1,
        /// Port F pull-down bit y When set, this bit activates the pull-down on PH[y] when APC bit is set in PWR_CR3 register.
        PD3: u1,
        padding: u28 = 0,
    }),
};
