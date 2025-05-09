const microzig = @import("microzig");
const mmio = microzig.mmio;

const types = @import("types.zig");

pub const CS = enum(u1) {
    /// Code from the cell (available in SBS_CCVR)
    Cell = 0x0,
    /// Code from SBS_CCCR
    Software = 0x1,
};

pub const DBGCFG_LOCK = enum(u8) {
    /// Writes to SBS_DBGCR allowed (default)
    B_0xB4 = 0xb4,
    _,
};

pub const DBG_AUTH_HDPL = enum(u8) {
    /// HDPL1
    B_0x51 = 0x51,
    /// HDPL3
    B_0x6F = 0x6f,
    /// HDPL2
    B_0x8A = 0x8a,
    _,
};

pub const HDPL = enum(u8) {
    /// HDPL1, iRoT
    B_0x51 = 0x51,
    /// HDPL3, application
    B_0x6F = 0x6f,
    /// HDPL2, uRoT
    B_0x8A = 0x8a,
    /// HDPL0, RSS
    B_0xB4 = 0xb4,
    _,
};

pub const INCR_HDPL = enum(u8) {
    /// recommended value to increment HDPL level by one
    B_0x6A = 0x6a,
    /// no increment
    B_0xB4 = 0xb4,
    _,
};

/// System configuration, boot and security
pub const SYSCFG = extern struct {
    /// offset: 0x00
    reserved0: [16]u8,
    /// SBS temporal isolation control register
    /// offset: 0x10
    HDPLCR: mmio.Mmio(packed struct(u32) {
        /// increment HDPL value Other: all other values allow a HDPL level increment.
        INCR_HDPL: INCR_HDPL,
        padding: u24 = 0,
    }),
    /// SBS temporal isolation status register
    /// offset: 0x14
    HDPLSR: mmio.Mmio(packed struct(u32) {
        /// temporal isolation level This bitfield returns the current temporal isolation level.
        HDPL: HDPL,
        padding: u24 = 0,
    }),
    /// offset: 0x18
    reserved24: [8]u8,
    /// SBS debug control register
    /// offset: 0x20
    DBGCR: mmio.Mmio(packed struct(u32) {
        /// access port unlock Write 0xB4 to this bitfield to open the device access port.
        AP_UNLOCK: u8,
        /// debug unlock when DBG_AUTH_HDPL is reached Write 0xB4 to this bitfield to open the debug when HDPL in SBS_HDPLSR equals to DBG_AUTH_HDPL in this register.
        DBG_UNLOCK: u8,
        /// authenticated debug temporal isolation level Writing to this bitfield defines at which HDPL the authenticated debug opens. Note: Writing any other values is ignored. Reading any other value means the debug never opens.
        DBG_AUTH_HDPL: DBG_AUTH_HDPL,
        padding: u8 = 0,
    }),
    /// SBS debug lock register
    /// offset: 0x24
    DBGLOCKR: mmio.Mmio(packed struct(u32) {
        /// debug configuration lock Reading this bitfield returns 0x6A if the bitfield value is different from 0xB4. 0xC3 is the recommended value to lock the debug configuration using this bitfield. Other: Writes to SBS_DBGCR ignored
        DBGCFG_LOCK: DBGCFG_LOCK,
        padding: u24 = 0,
    }),
    /// offset: 0x28
    reserved40: [216]u8,
    /// SBS product mode and configuration register
    /// offset: 0x100
    PMCR: mmio.Mmio(packed struct(u32) {
        reserved8: u8 = 0,
        /// booster enable Set this bit to reduce the total harmonic distortion of the analog switch when the processor supply is below 2.7 V. The booster can be activated to guaranty AC performance on analog switch when the supply is below 2.7 V. When the booster is activated, the analog switch performances are the same as with the full voltage range.
        BOOSTEN: u1,
        /// booster V<sub>DD</sub> selection Note: Booster must not be used when V<sub>DDA</sub> < 2.7 V, but V<sub>DD</sub> > 2.7 V (add current consumption). Note: When both V<sub>DD</sub> < 2.7 V and V<sub>DDA</sub> < 2.7 V, booster is needed to get full AC performances from I/O analog switches.
        BOOSTVDDSEL: u1,
        reserved16: u6 = 0,
        /// Fast-mode Plus command on PB(6)
        PB6_FMPLUS: u1,
        /// Fast-mode Plus command on PB(7)
        PB7_FMPLUS: u1,
        /// Fast-mode Plus command on PB(8)
        PB8_FMPLUS: u1,
        padding: u13 = 0,
    }),
    /// SBS FPU interrupt mask register
    /// offset: 0x104
    FPUIMR: mmio.Mmio(packed struct(u32) {
        /// FPU interrupt enable Set and cleared by software to enable the Cortex-M33 FPU interrupts FPU_IE[5]: inexact interrupt enable (interrupt disabled at reset) FPU_IE[4]: input abnormal interrupt enable FPU_IE[3]: overflow interrupt enable FPU_IE[2]: underflow interrupt enable FPU_IE[1]: divide-by-zero interrupt enable FPU_IE[0]: invalid operation interrupt enable
        FPU_IE: u6,
        padding: u26 = 0,
    }),
    /// SBS memory erase status register
    /// offset: 0x108
    MESR: mmio.Mmio(packed struct(u32) {
        /// erase after reset status This bit shows the status of the protection for SRAM2, BKPRAM, ICACHE, ICACHE. It is set by hardware and reset by software
        MCLR: u1,
        reserved16: u15 = 0,
        /// end-of-erase status for ICACHE This bit shows the status of the protection for ICACHE. It is set by hardware and reset by software.
        IPMEE: u1,
        padding: u15 = 0,
    }),
    /// offset: 0x10c
    reserved268: [4]u8,
    /// SBS compensation cell for I/Os control and status register
    /// offset: 0x110
    CCCSR: mmio.Mmio(packed struct(u32) {
        /// (1/2 of EN) enable compensation cell for VDDIO power rail This bit enables the I/O compensation cell.
        @"EN[0]": u1,
        /// (1/2 of CS) code selection for VDDIO power rail (reset value set to 1) This bit selects the code to be applied for the I/O compensation cell.
        @"CS[0]": CS,
        /// (2/2 of EN) enable compensation cell for VDDIO power rail This bit enables the I/O compensation cell.
        @"EN[1]": u1,
        /// (2/2 of CS) code selection for VDDIO power rail (reset value set to 1) This bit selects the code to be applied for the I/O compensation cell.
        @"CS[1]": CS,
        reserved8: u4 = 0,
        /// (1/2 of RDY) VDDIO compensation cell ready flag This bit provides the status of the compensation cell.
        @"RDY[0]": u1,
        /// (2/2 of RDY) VDDIO compensation cell ready flag This bit provides the status of the compensation cell.
        @"RDY[1]": u1,
        padding: u22 = 0,
    }),
    /// SBS compensation cell for I/Os value register
    /// offset: 0x114
    CCVALR: mmio.Mmio(packed struct(u32) {
        /// compensation value for the NMOS transistor This value is provided by the cell and must be interpreted by the processor to compensate the slew rate in the functional range.
        ANSRC1: u4,
        /// compensation value for the PMOS transistor This value is provided by the cell and must be interpreted by the processor to compensate the slew rate in the functional range.
        APSRC1: u4,
        /// Compensation value for the NMOS transistor This value is provided by the cell and must be interpreted by the processor to compensate the slew rate in the functional range.
        ANSRC2: u4,
        /// compensation value for the PMOS transistor This value is provided by the cell and must be interpreted by the processor to compensate the slew rate in the functional range.
        APSRC2: u4,
        padding: u16 = 0,
    }),
    /// SBS compensation cell for I/Os software code register
    /// offset: 0x118
    CCSWCR: mmio.Mmio(packed struct(u32) {
        /// NMOS compensation code for VDD power rails This bitfield is written by software to define an I/O compensation cell code for NMOS transistors of the VDD power rail. This code is applied to the I/O when CS1 is set in SBS_CCSR.
        SW_ANSRC1: u4,
        /// PMOS compensation code for the VDD power rails This bitfield is written by software to define an I/O compensation cell code for PMOS transistors of the VDDIO power rail. This code is applied to the I/O when CS1 is set in SBS_CCSR.
        SW_APSRC1: u4,
        /// NMOS compensation code for VDDIO power rails This bitfield is written by software to define an I/O compensation cell code for NMOS transistors of the VDD power rail. This code is applied to the I/O when CS2 is set in SBS_CCSR.
        SW_ANSRC2: u4,
        /// PMOS compensation code for the V<sub>DDIO</sub> power rails This bitfield is written by software to define an I/O compensation cell code for PMOS transistors of the VDDIO power rail. This code is applied to the I/O when CS2 is set in SBS_CCSR.
        SW_APSRC2: u4,
        padding: u16 = 0,
    }),
    /// offset: 0x11c
    reserved284: [4]u8,
    /// SBS Class B register
    /// offset: 0x120
    CFGR2: mmio.Mmio(packed struct(u32) {
        /// core lockup lock This bit is set by software and cleared only by a system reset. It can be used to enable and lock the lockup (HardFault) output of Cortex-M33 with TIM1 break inputs.
        CLL: u1,
        /// SRAM ECC error lock This bit is set by software and cleared only by a system reset. It can be used to enable and lock the SRAM double ECC error signal with break input of TIM1.
        SEL: u1,
        /// PVD lock This bit is set by software and cleared only by a system reset. It can be used to enable and lock the PVD connection with TIM1 break inputs.
        PVDL: u1,
        /// ECC lock This bit is set and cleared by software. It can be used to enable and lock the Flash memory double ECC error with break input of TIM1.
        ECCL: u1,
        padding: u28 = 0,
    }),
    /// offset: 0x124
    reserved292: [32]u8,
    /// SBS CPU lock register
    /// offset: 0x144
    CNSLCKR: mmio.Mmio(packed struct(u32) {
        /// VTOR_NS register lock This bit is set by software and cleared only by a system reset.
        LOCKNSVTOR: u1,
        /// MPU register lock This bit is set by software and cleared only by a system reset. When set, this bit disables write access to MPU_CTRL_NS, MPU_RNR_NS and MPU_RBAR_NS registers.
        LOCKNSMPU: u1,
        padding: u30 = 0,
    }),
    /// offset: 0x148
    reserved328: [4]u8,
    /// SBS flift ECC NMI mask register
    /// offset: 0x14c
    ECCNMIR: mmio.Mmio(packed struct(u32) {
        /// NMI behavior setup when a double ECC error occurs on flitf data part
        ECCNMI_MASK_EN: u1,
        padding: u31 = 0,
    }),
};
