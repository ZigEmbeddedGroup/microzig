const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const SystemControlBlock = extern struct {
    /// CPUID Base Register
    CPUID: u32,
    /// Interrupt Control And State Register
    ICSR: mmio.Mmio(packed struct(u32) {
        VECTACTIVE: u6,
        reserved0: u6 = 0,
        VECTPENDING: u6,
        reserved1: u4 = 0,
        ISRPENDING: u1,
        reserved2: u2 = 0,
        PENDSTCLR: u1,
        PENDSTSET: u1,
        PENDSVCLR: u1,
        PENDSVSET: u1,
        reserved3: u2 = 0,
        NMIPENDSET: u1,
    }),
    /// Vector Table Offset Register
    VTOR: u32,
    /// Application Interrupt And Reset Control Register
    AIRCR: u32,
    /// System Control Register
    SCR: u32,
    /// Configuration Control Register
    CCR: mmio.Mmio(packed struct(u32) {
        reserved0: u3 = 0,
        UNALIGN_TRP: u1,
        reserved1: u5 = 0,
        STKALIGN: u1,
        padding: u22 = 0,
    }),
    reserved0: u32,
    /// System Handlers Priority Register 2
    SHPR2: u32,
    /// System Handlers Priority Register 3
    SHPR3: u32,
};

pub const NestedVectorInterruptController = extern struct {
    // Interrupt Set-Enable Register
    ISER: u32,
    reserved0: [31]u32,
    // Interrupt Clear-Enable Register
    ICER: u32,
    reserved1: [31]u32,
    /// Interrupt Set-Pending Register
    ISPR: u32,
    reserved2: [31]u32,
    /// Interrupt Clear-Pending Register
    ICPR: u32,
    reserved3: [95]u32,
    /// Interrupt Priority Registers
    IPR: [8]u32,
};

pub const MemoryProtectionUnit = extern struct {
    /// MPU Type Register
    TYPE: mmio.Mmio(packed struct(u32) {
        /// Indicates support for unified or separate instructions and data address regions.
        SEPARATE: u1,
        reserved0: u7,
        /// Number of data regions supported by the MPU.
        DREGION: u8,
        /// Number of instruction regions supported by the MPU.
        IREGION: u8,
        padding: u8,
    }),
    /// MPU Control Register
    CTRL: mmio.Mmio(packed struct(u32) {
        /// Enables the MPU
        ENABLE: u1,
        /// Enables of operation of MPU during HardFault and MNIHandlers.
        HFNMIENA: u1,
        /// Enables priviledged software access to default memory map.
        PRIVDEFENA: u1,
        _reserved0: u29,
    }),
    /// MPU Region Number Register
    RNR: mmio.Mmio(packed struct(u32) {
        /// Indicates the memory region accessed by MPU RBAR and PMU RLAR.
        REGION: u8,
        _reserved0: u24,
    }),
    /// MPU Region Base Address Register
    RBAR: mmio.Mmio(packed struct(u32) {
        /// MPU region field.
        REGION: u4,
        /// MPU region number valid bit.
        VALID: u1,
        /// Region base address field.
        ADDR: u27,
    }),
    /// MPU Attribute and Size Register
    RASR: mmio.Mmio(packed struct(u32) {
        /// Region enable bit.
        ENABLE: u1,
        /// Specifies the size of the MPU region. The minimum permitted value is 7 (b00111).
        SIZE: u5,
        reserved0: u2,
        /// Subregion disable bits.
        SRD: u3,
        /// Bufferable bit.
        B: u1,
        /// Cacheable bit.
        C: u1,
        /// Shareable bit.
        S: u1,
        reserved1: u5,
        /// Access permission field.
        AP: u3,
        reserved2: u1,
        /// Instruction access disable bit.
        XN: u1,
        padding: u3,
    }),
};
