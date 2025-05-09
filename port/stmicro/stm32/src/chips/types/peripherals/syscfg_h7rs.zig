const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("../../types.zig");

pub const AXIRAM_WS = enum(u1) {
    /// No wait state added when accessing any AXIRAM with ECC = 0.
    Ws0 = 0x0,
    /// One wait state added when accessing any AXIRAM with ECC = 0. In this case, Fmax = 500 MHz is not guaranteed. (TBC).
    Ws1 = 0x1,
};

pub const DBGCFG_LOCK = enum(u8) {
    /// Writes to SBS_DBGCR allowed (default).
    Unlock = 0xb4,
    _,
};

pub const DBG_AUTH_HDPL = enum(u8) {
    /// HDPL1.
    HDPL1 = 0x51,
    /// HDPL3.
    HDPL3 = 0x6f,
    /// HDPL2.
    HDPL2 = 0x8a,
    _,
};

pub const ETH_SEL_PHY = enum(u3) {
    /// GMII or MII
    MII_GMII = 0x0,
    /// RMII
    RMII = 0x4,
    _,
};

pub const HDPL = enum(u8) {
    /// HDPL1.
    HDPL1 = 0x51,
    /// HDPL2.
    HDPL2 = 0x8a,
    /// HDPL0, corresponding to ST-RSS (default when device is close).
    HDPL0 = 0xb4,
    _,
};

/// System configuration, boot and security.
pub const SYSCFG = extern struct {
    /// SBS boot status register.
    /// offset: 0x00
    BOOTSR: mmio.Mmio(packed struct(u32) {
        /// initial vector for Cortex-M7 This register includes the physical boot address used by the Cortex-M7 after reset.
        INITVTOR: u32,
    }),
    /// offset: 0x04
    reserved4: [12]u8,
    /// SBS hide protection control register.
    /// offset: 0x10
    HDPLCR: mmio.Mmio(packed struct(u32) {
        /// increment HDPL Write 0x6A to increment device HDPL by one. After a write, the register value reverts to its default value (0xB4).
        INCR_HDPL: u8,
        padding: u24 = 0,
    }),
    /// SBS hide protection status register.
    /// offset: 0x14
    HDPLSR: mmio.Mmio(packed struct(u32) {
        /// hide protection level This bitfield returns the current HDPL of the device. 0x6F and other codes: HDPL3, corresponding to non-boot application. Note: The device state (open/close) is defined in FLASH_NVSTATER register of the embedded Flash memory.
        HDPL: HDPL,
        padding: u24 = 0,
    }),
    /// offset: 0x18
    reserved24: [8]u8,
    /// SBS debug control register.
    /// offset: 0x20
    DBGCR: mmio.Mmio(packed struct(u32) {
        /// access port unlock Write 0xB4 to this bitfield to open the device access port.
        AP_UNLOCK: u8,
        /// debug unlock Write 0xB4 to this bitfield to open the debug when HDPL in SBS_HDPLSR equals to DBG_AUTH_HDPL in this register.
        DBG_UNLOCK: u8,
        /// authenticated debug hide protection level Writing to this bitfield defines at which HDPL the authenticated debug opens. Note: Writing any other values is ignored. Reading any other value means the authenticated debug always fails.
        DBG_AUTH_HDPL: DBG_AUTH_HDPL,
        padding: u8 = 0,
    }),
    /// SBS debug lock register.
    /// offset: 0x24
    DBGLOCKR: mmio.Mmio(packed struct(u32) {
        /// debug configuration lock Reading this bitfield returns 0x6A if the bitfield value is different from 0xB4. Other: Writes to SBS_DBGCR ignored Note: 0xC3 is the recommended value to lock the debug configuration using this bitfield.
        DBGCFG_LOCK: DBGCFG_LOCK,
        padding: u24 = 0,
    }),
    /// offset: 0x28
    reserved40: [12]u8,
    /// SBS RSS command register.
    /// offset: 0x34
    RSSCMDR: mmio.Mmio(packed struct(u32) {
        /// RSS command The application can use this bitfield to pass on a command to the RSS, executed at the next reset.
        RSSCMD: u16,
        padding: u16 = 0,
    }),
    /// offset: 0x38
    reserved56: [200]u8,
    /// SBS product mode and configuration register.
    /// offset: 0x100
    PMCR: mmio.Mmio(packed struct(u32) {
        reserved4: u4 = 0,
        /// Fast-mode Plus on PB(6).
        FMPLUS_PB6: u1,
        /// Fast-mode Plus on PB(7).
        FMPLUS_PB7: u1,
        /// Fast-mode Plus on PB(8).
        FMPLUS_PB8: u1,
        /// Fast-mode Plus on PB(9).
        FMPLUS_PB9: u1,
        /// booster enable Set this bit to reduce the THD of the analog switches when the supply voltage is below 2.7 V. guaranteeing the same performance as with the full voltage range. To avoid current consumption due to booster activation when V<sub>DDA</sub> < 2.7 V and V<sub>DD</sub> > 2.7 V, V<sub>DD</sub> can be selected as supply voltage for analog switches by setting BOOSTVDDSEL bit in SBS_PMCR. In this case, the BOOSTEN bit must be cleared to avoid unwanted power consumption.
        BOOSTEN: u1,
        /// booster V<sub>DD</sub> selection This bit selects the analog switch supply voltage, between V<sub>DD</sub>, V<sub>DDA</sub> and booster. To avoid current consumption due to booster activation when V<sub>DDA</sub> < 2.7 V and V<sub>DD</sub> > 2.7 V, V<sub>DD</sub> can be selected as supply voltage for analog switches. In this case, the BOOSTEN bit must be cleared to avoid unwanted power consumption. When both V<sub>DD and </sub>V<sub>DDA</sub> are below 2.7 V, the booster is still needed to obtain full AC performances from the I/O analog switches.
        BOOSTVDDSEL: u1,
        reserved21: u11 = 0,
        /// Ethernet PHY interface selection.
        ETH_SEL_PHY: ETH_SEL_PHY,
        reserved28: u4 = 0,
        /// AXIRAM wait state Set this bit to add one wait state to all AXIRAMs when ECC = 0. When ECC = 1 there is one wait state by default.
        AXIRAM_WS: AXIRAM_WS,
        padding: u3 = 0,
    }),
    /// SBS FPU interrupt mask register.
    /// offset: 0x104
    FPUIMR: mmio.Mmio(packed struct(u32) {
        /// FPU interrupt enable Set and cleared by software to enable the Cortex-M7 FPU interrupts xxxxx1: Invalid operation interrupt enabled (xxxxx0 to disable) xxxx1x: Divide-by-zero interrupt enabled (xxxx0x to disable) xxx1xx: Underflow interrupt enabled (xxx0xx to disable) xx1xxx: Overflow interrupt enabled (xx0xxx to disable) x1xxxx: Input denormal interrupt enabled (x0xxxx to disable) 1xxxxx: Inexact interrupt enabled (0xxxxx to disable), disabled by default.
        FPU_IE: u6,
        padding: u26 = 0,
    }),
    /// SBS memory erase status register.
    /// offset: 0x108
    MESR: mmio.Mmio(packed struct(u32) {
        /// memory erase flag This bit is set by hardware when BKPRAM and PKA SRAM erase is ongoing after a POWER ON reset or one tamper event (see Section 50: Tamper and backup registers (TAMP) for details). This bit is cleared when the erase is done.
        MEF: u1,
        padding: u31 = 0,
    }),
    /// offset: 0x10c
    reserved268: [4]u8,
    /// SBS I/O compensation cell control and status register.
    /// offset: 0x110
    CCCSR: mmio.Mmio(packed struct(u32) {
        /// Compensation cell enable Set this bit to enable the compensation cell.
        COMP_EN: u1,
        /// Compensation cell code selection This bit selects the code to be applied for the I/O compensation cell.
        COMP_CODESEL: u1,
        /// XSPIM_P1 compensation cell enable Set this bit to enable the XSPIM_P1 compensation cell.
        OCTO1_COMP_EN: u1,
        /// XSPIM_P1 compensation cell code selection This bit selects the code to be applied for the XSPIM_P1 I/O compensation cell.
        OCTO1_COMP_CODESEL: u1,
        /// XSPIM_P2 compensation cell enable Set this bit to enable the XSPIM_P2 compensation cell.
        OCTO2_COMP_EN: u1,
        /// XSPIM_P2 compensation cell code selection This bit selects the code to be applied for the XSPIM_P2 I/O compensation cell.
        OCTO2_COMP_CODESEL: u1,
        reserved8: u2 = 0,
        /// Compensation cell ready This bit provides the status of the compensation cell.
        COMP_RDY: u1,
        /// XSPIM_P1 compensation cell ready This bit provides the status of the XSPIM_P1 compensation cell.
        OCTO1_COMP_RDY: u1,
        /// XSPIM_P2 compensation cell ready This bit provides the status of the XSPIM_P2 compensation cell.
        OCTO2_COMP_RDY: u1,
        reserved16: u5 = 0,
        /// I/O high speed at low voltage When this bit is set, the speed of the I/Os is optimized when the device voltage is low. This bit is active only if VDDIO_HSLV user option bit is set in FLASH. It must be used only if the device supply voltage is below 2.7 V. Setting this bit when V<sub>DD</sub> is higher than 2.7 V may be destructive.
        IOHSLV: u1,
        /// XSPIM_P1 I/O high speed at low voltage When this bit is set, the speed of the XSPIM_P1 I/Os is optimized when the device voltage is low. This bit is active only if OCTO1_HSLV user option bit is set in FLASH. This bit must be used only if the device supply voltage is below 2.7 V. Setting this bit when V<sub>DD</sub> is higher than 2.7 V may be destructive.
        OCTO1_IOHSLV: u1,
        /// XSPIM_P2 I/O high speed at low voltage When this bit is set, the speed of the XSPIM_P2 I/Os is optimized when the device voltage is low. This bit is active only if OCTO2_HSLV user option bit is set in FLASH. This bit must be used only if the device supply voltage is below 2.7 V. Setting this bit when V<sub>DD</sub> is higher than 2.7 V may be destructive.
        OCTO2_IOHSLV: u1,
        padding: u13 = 0,
    }),
    /// SBS compensation cell for I/Os value register.
    /// offset: 0x114
    CCVALR: mmio.Mmio(packed struct(u32) {
        /// NMOS transistors slew-rate compensation This bitfield returns the NMOS transistors slew-rate compensation value computed by the cell. It is interpreted to compensate the NMOS transistors slew rate in the functional range if COMP_CODESEL = 0 in SBS_CCCSR register.
        NSRC: u4,
        /// PMOS transistors slew-rate compensation This bitfield returns the PMOS transistors slew-rate compensation value computed by the cell. It is interpreted to compensate the PMOS transistors slew rate in the functional range if COMP_CODESEL = 0 in SBS_CCCSR register.
        PSRC: u4,
        /// XSPIM_P1 NMOS transistors slew-rate compensation This bitfield returns the NMOS transistors slew-rate compensation value computed by the cell. It is interpreted by XSPIM_P1 to compensate the NMOS transistors slew rate in the functional range if OCTO1_COMP_CODESEL = 0 in SBS_CCCSR register.
        OCTO1_NSRC: u4,
        /// XSPIM_P1 PMOS transistors slew-rate compensation This bitfield returns the PMOS transistors slew-rate compensation value computed by the cell. It is interpreted by XSPIM_P1 to compensate the PMOS transistors slew rate in the functional range if OCTO1_COMP_CODESEL = 0 in SBS_CCCSR register.
        OCTO1_PSRC: u4,
        /// XSPIM_P2 NMOS transistors slew-rate compensation This bitfield returns the NMOS transistors slew-rate compensation value computed by the cell. It is interpreted by XSPIM_P2 to compensate the NMOS transistors slew rate in the functional range if OCTO2_COMP_CODESEL = 0 in SBS_CCCSR register.
        OCTO2_NSRC: u4,
        /// XSPIM_P2 PMOS transistors slew-rate compensation This bitfield returns the PMOS transistors slew-rate compensation value computed by the cell. It is interpreted by XSPIM_P2 to compensate the PMOS transistors slew rate in the functional range if OCTO2_COMP_CODESEL = 0 in SBS_CCCSR register.
        OCTO2_PSRC: u4,
        padding: u8 = 0,
    }),
    /// SBS compensation cell for I/Os software value register.
    /// offset: 0x118
    CCSWVALR: mmio.Mmio(packed struct(u32) {
        /// Software NMOS transistors slew-rate compensation This bitfield returns the NMOS transistors slew-rate compensation value computed by the cell. It is interpreted to compensate the NMOS transistors slew rate in the functional range if COMP_CODESEL = 1 in SBS_CCCSR register.
        SW_NSRC: u4,
        /// Software PMOS transistors slew-rate compensation This bitfield returns the PMOS transistors slew-rate compensation value computed by the cell. It is interpreted to compensate the PMOS transistors slew rate in the functional range if COMP_CODESEL = 1 in SBS_CCCSR register.
        SW_PSRC: u4,
        /// XSPIM_P1 software NMOS transistors slew-rate compensation This bitfield returns the NMOS transistors slew -ate compensation value computed by the cell. It is interpreted by XSPIM_P1 to compensate the NMOS transistors slew rate in the functional range if OCTO1_COMP_CODESEL = 1 in SBS_CCCSR register.
        OCTO1_SW_NSRC: u4,
        /// XSPIM_P1 software PMOS transistors slew-rate compensation This bitfield returns the PMOS transistors slew-rate compensation value computed by the cell. It is interpreted by XSPIM_P1 to compensate the PMOS transistors slew rate in the functional range if OCTO1_COMP_CODESEL = 1 in SBS_CCCSR register.
        OCTO1_SW_PSRC: u4,
        /// XSPIM_P2 software NMOS transistors slew-rate compensation This bitfield returns the NMOS transistors slew-rate compensation value computed by the cell. It is interpreted by XSPIM_P2 to compensate the NMOS transistors slew rate in the functional range if OCTO2_COMP_CODESEL = 1 in SBS_CCCSR register.
        OCTO2_SW_NSRC: u4,
        /// XSPIM_P2 software PMOS transistors slew-rate compensation This bitfield returns the PMOS transistors slew-rate compensation value computed by the cell. It is interpreted by XSPIM_P2 to compensate the PMOS transistors slew rate in the functional range if OCTO2_COMP_CODESEL = 1 in SBS_CCCSR register.
        OCTO2_SW_PSRC: u4,
        padding: u8 = 0,
    }),
    /// offset: 0x11c
    reserved284: [4]u8,
    /// SBS break lockup register.
    /// offset: 0x120
    BKLOCKR: mmio.Mmio(packed struct(u32) {
        reserved2: u2 = 0,
        /// PVD break lock This bit is set by SW and cleared only by a system reset. it can be used to enable and lock the connection to TIM1/8/15/16/17Break input as well as the PVDE and PLS[2:0] bitfields in the PWR_CR1 register. Once set, this bit is cleared only by a system reset.
        PVD_BL: u1,
        /// Flash ECC error break lock Set this bit to enable and lock the connection between embedded flash memory ECC double error detection flag and break inputs of TIM1/15/16/17 peripherals. Once set, this bit is cleared only by a system reset.
        FLASHECC_BL: u1,
        reserved6: u2 = 0,
        /// Cortex-M7 lockup break lock Set this bit to enable and lock the connection between the Cortex-M7 lockup (HardFault) output and break inputs of TIM1/15/16/17 peripherals. Once set, this bit is cleared only by a system reset.
        CM7LCKUP_BL: u1,
        /// Backup RAM ECC error break lock Set this bit to enable and lock the connection between backup RAM ECC double error detection flag and break inputs of TIM1/15/16/17 peripherals. Once set, this bit is cleared only by a system reset.
        BKRAMECC_BL: u1,
        reserved13: u5 = 0,
        /// DTCM ECC error break lock Set this bit to enable and lock the connection between DTCM ECC double error detection flag and break inputs of TIM1/15/16/17 peripherals. Once set, this bit is cleared only by a system reset. Note: The DTCM0 and DTCM1 are Ored to give DTCMECC.
        DTCMECC_BL: u1,
        /// ITCM ECC error break lock Set this bit to enable and lock the connection between ITCM ECC double error detection flag and break inputs of TIM1/15/16/17 peripherals. Once set, this bit is cleared only by a system reset.
        ITCMECC_BL: u1,
        reserved21: u6 = 0,
        /// AXIRAM3 ECC error break lock Set this bit to enable and lock the connection between AXIRAM3 ECC double error detection flag and break inputs of TIM1/15/16/17 peripherals. Once set this bit is cleared only by a system reset.
        ARAM3ECC_BL: u1,
        reserved23: u1 = 0,
        /// AXIRAM1 ECC error break lock Set this bit to enable and lock the connection between AXIRAM1 ECC double error detection flag and break inputs of TIM1/15/16/17 peripherals. Once set, this bit is cleared only by a system reset.
        ARAM1ECC_BL: u1,
        padding: u8 = 0,
    }),
    /// offset: 0x124
    reserved292: [12]u8,
    /// external interrupt configuration register
    /// offset: 0x130
    EXTICR: [4]mmio.Mmio(packed struct(u32) {
        /// (1/4 of EXTI) EXTI x configuration (x = 4 to 7)
        @"EXTI[0]": u4,
        /// (2/4 of EXTI) EXTI x configuration (x = 4 to 7)
        @"EXTI[1]": u4,
        /// (3/4 of EXTI) EXTI x configuration (x = 4 to 7)
        @"EXTI[2]": u4,
        /// (4/4 of EXTI) EXTI x configuration (x = 4 to 7)
        @"EXTI[3]": u4,
        padding: u16 = 0,
    }),
};
