const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const SystemControlBlock = extern struct {
    /// CPUID Base Register
    CPUID: u32,
    /// Interrupt Control and State Register
    ICSR: mmio.Mmio(packed struct(u32) {
        VECTACTIVE: u9,
        reserved0: u2 = 0,
        RETTOBASE: u1,
        VECTPENDING: u9,
        reserved1: u1 = 0,
        ISRPENDING: u1,
        ISRPREEMPT: u1,
        reserved2: u1 = 0,
        PENDSTCLR: u1,
        PENDSTSET: u1,
        PENDSVCLR: u1,
        PENDSVSET: u1,
        reserved3: u2 = 0,
        NMIPENDSET: u1,
    }),
    /// Vector Table Offset Register
    VTOR: u32,
    /// Application Interrupt  and Reset Control Register
    AIRCR: u32,
    /// System Control Register
    SCR: u32,
    /// Configuration Control Register
    CCR: mmio.Mmio(packed struct(u32) {
        NONBASETHRDENA: u1,
        USERSETMPEND: u1,
        _reserved0: u1 = 0,
        UNALIGN_TRP: u1,
        DIV_0_TRP: u1,
        _reserved1: u3 = 0,
        BFHFNMIGN: u1,
        STKALIGN: u1,
        _padding: u22 = 0,
    }),
    /// System Handlers Priority Registers
    SHP: [12]u8,
    /// System Handler Contol and State Register
    SHCSR: u32,
    /// Configurable Fault Status Register
    CFSR: u32,
    /// HardFault Status Register
    HFSR: u32,
    /// Debug Fault Status Register
    DFSR: u32,
    /// MemManage Fault Address Register
    MMFAR: u32,
    /// BusFault Address Register
    BFAR: u32,
    /// Auxilary Feature Register
    AFSR: u32,
    /// Processor Feature Register
    PFR: [2]u32,
    /// Debug Feature Register
    DFR: u32,
    /// Auxilary Feature Register
    ADR: u32,
    /// Memory Model Feature Register
    MMFR: [4]u32,
    /// Instruction Set Attributes Register
    ISAR: [5]u32,
    RESERVED0: [5]u32,
    /// Coprocessor Access Control Register
    CPACR: u32,
};

pub const NestedVectorInterruptController = extern struct {
    ISER: [8]u32,
    _reserved0: [24]u32,
    ICER: [8]u32,
    _reserved1: [24]u32,
    ISPR: [8]u32,
    _reserved2: [24]u32,
    ICPR: [8]u32,
    _reserved3: [24]u32,
    IABR: [8]u32,
    _reserved4: [56]u32,
    IP: [240]u8,
    _reserved5: [644]u32,
    STIR: u32,
};

pub const MemoryProtectionUnit = extern struct {
    /// MPU Type Register
    TYPE: mmio.Mmio(packed struct(u32) {
        SEPARATE: u1,
        _reserved0: u7,
        DREGION: u8,
        IREGION: u8,
        _reserved1: u8,
    }),
    /// MPU Control Register
    CTRL: mmio.Mmio(packed struct(u32) {
        ENABLE: u1,
        HFNMIENA: u1,
        PRIVDEFENA: u1,
        padding: u29,
    }),
    /// MPU RNRber Register
    RNR: mmio.Mmio(packed struct(u32) {
        REGION: u8,
        padding: u24,
    }),
    /// MPU Region Base Address Register
    RBAR: RBAR,
    /// MPU Region Attribute and Size Register
    RASR: RASR,
    /// MPU Alias 1 Region Base Address Register
    RBAR_A1: RBAR,
    /// MPU Alias 1 Region Attribute and Size Register
    RASR_A1: RASR,
    /// MPU Alias 2 Region Base Address Register
    RBAR_A2: RBAR,
    /// MPU Alias 2 Region Attribute and Size Register
    RASR_A2: RASR,
    /// MPU Alias 3 Region Base Address Register
    RBAR_A3: RBAR,
    /// MPU Alias 3 Region Attribute and Size Register
    RASR_A3: RASR,

    pub const RBAR = mmio.Mmio(packed struct(u32) {
        REGION: u4,
        VALID: u1,
        ADDR: u27,
    });

    pub const RASR = mmio.Mmio(packed struct(u32) {
        /// Region enable bit
        ENABLE: u1,
        /// Region Size
        SIZE: u5,
        _reserved0: u2,
        /// Sub-Region Disable
        SRD: u8,
        /// ATTRS.B
        B: u1,
        /// ATTRS.C
        C: u1,
        /// ATTRS.S
        S: u1,
        /// ATTRS.TEX
        TEX: u3,
        _reserved1: u2,
        /// ATTRS.AP
        AP: u3,
        /// ATTRS.XN
        XN: u1,
        padding: u4,
    });
};
