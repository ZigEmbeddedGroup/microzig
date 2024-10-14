const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const SystemControlBlock = extern struct {
    /// Auxiliary Control Base Register
    ACTLR: mmio.Mmio(packed struct(u32) {
        DISMCYCINT: u1,
        DISDEFWBUF: u1,
        DISFOLD: u1,
        _reserved0: u6 = 0,
        DISFPCA: u1,
        DISOOFP: u1,
        _reserved1: u21 = 0,
    }),
    /// CPUID Base Register
    CPUID: u32,
    /// Interrupt Control and State Register
    ICSR: u32,
    /// Vector Table Offset Register
    VTOR: u32,
    /// Application Interrupt and Reset Control Register
    AIRCR: u32,
    /// System Control Register
    SCR: u32,
    /// Configuration and Control Register
    CCR: mmio.Mmio(packed struct(u32) {
        _reserved0: u1 = 0,
        USERSETMPEND: u1,
        _reserved1: u1 = 0,
        UNALIGN_TRP: u1,
        DIV_0_TRP: u1,
        _reserved2: u3 = 0,
        BFHFNMIGN: u1,
        _reserved3: u1 = 0,
        STKOFHFNMIGN: u1,
        _reserved4: u5 = 0,
        DC: u1,
        IC: u1,
        BP: u1,
        _reserved5: u13 = 0,
    }),
    /// System Handler Priority Registers
    SHPR: [12]u8,
    /// System Handler Control and State Register
    SHCSR: u32,
    /// Configurable Fault Status Register
    CFSR: mmio.Mmio(packed struct(u32) {
        /// MemManage Fault Register
        MMFSR: u8,
        /// BusFault Status Register
        BFSR: u8,
        /// Usage Fault Status Register
        UFSR: u16,
    }),
    /// HardFault Status Register
    HFSR: u32,
    _reserved0: [2]u32,
    /// MemManage Fault Address Register
    MMFAR: u32,
    /// BusFault Address Register
    BFAR: u32,
    /// Auxiliary Fault Status Register not implemented
    _AFSR: u32,
    _reserved1: [19]u32,
    /// Non-secure Access Control Register
    NSACR: u32,
};

pub const NestedVectorInterruptController = extern struct {
    ISER: [16]u32,
    _reserved0: [2]u32,
    ICER: [16]u32,
    _reserved1: [2]u32,
    ISPR: [16]u32,
    _reserved2: [2]u32,
    ICPR: [16]u32,
    _reserved3: [2]u32,
    IABR: [16]u32,
    _reserved4: [2]u32,
    ITNS: [16]u32,
    _reserved5: [2]u32,
    IPR: [480]u8,
    _reserved6: [73]u32,
    STIR: u32,
};

pub const SecurityAttributionUnit = extern struct {
    /// SAU Control Register
    CTRL: u32,
    /// SAU Type Register
    TYPE: u32,
    /// SAU Region Number Register
    RNR: u32,
    /// SAU Region Base Address
    RBAR: u32,
    /// SAU Region Limit Address
    RLAR: u32,
    /// Secure Fault Status Register
    SFSR: u32,
    /// Secure Fault Address Register
    SFAR: u32,
};

pub const MemoryProtectionUnit = extern struct {
    /// MPU Type Register
    TYPE: mmio.Mmio(packed struct(u32) {
        SEPARATE: u1,
        _reserved0: u7,
        DREGION: u8,
        _reserved1: u16,
    }),
    /// MPU Control Register
    CTRL: mmio.Mmio(packed struct(u32) {
        ENABLE: u1,
        HFNMIENA: u1,
        PRIVDEFENA: u1,
        _reserved0: u29,
    }),
    /// MPU Region Number Register
    RNR: mmio.Mmio(packed struct(u32) {
        REGION: u8,
        _reserved0: u24,
    }),
    /// MPU Region Base Address Register
    RBAR: RBAR,
    /// MPU Region Limit Address Register
    RLAR: RLAR,
    /// MPU Region Base Address Register Alias 1
    RBAR_A1: RBAR,
    /// MPU Region Base Address Register Alias 2
    RBAR_A2: RBAR,
    /// MPU Region Base Address Register Alias 3
    RBAR_A3: RBAR,
    /// MPU Region Limit Address Register Alias 1
    RLAR_A1: RLAR,
    /// MPU Region Base Address Register Alias 2
    RLAR_A2: RLAR,
    /// MPU Region Base Address Register Alias 3
    RLAR_A3: RLAR,
    _reserved0: [20]u8,
    /// MPU Memory Addribute Indirection Register 0
    MPU_MAIR0: u32,
    /// MPU Memory Addribute Indirection Register 1
    MPU_MAIR1: u32,

    pub const RBAR = mmio.Mmio(packed struct(u32) {
        XN: u1,
        AP: u2,
        SH: u2,
        BASE: u27,
    });

    pub const RLAR = mmio.Mmio(packed struct(u32) {
        EN: u1,
        AttrIndx: u3,
        _reserved0: u1,
        LIMIT: u27,
    });
};
