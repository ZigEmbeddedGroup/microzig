const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const CPUOptions = struct {
    /// When true, interrupt vectors are moved to RAM so handlers can be set at runtime.
    ram_vectors: bool = false,
    /// When true, the RAM vectors are placed in section `ram_vectors`.
    has_ram_vectors_section: bool = false,
};

pub const SystemControlBlock = extern struct {
    /// CPUID Base Register.
    CPUID: u32,
    /// Interrupt Control and State Register.
    ICSR: mmio.Mmio(packed struct(u32) {
        VECTACTIVE: u9,
        reserved0: u2 = 0,
        RETTOBASE: u1,
        VECTPENDING: u6,
        reserved1: u4 = 0,
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
    /// Vector Table Offset Register.
    VTOR: u32,
    /// Application Interrupt and Reset Control Register.
    AIRCR: mmio.Mmio(packed struct {
        VECTRESET: u1,
        VECTCLRACTIVE: u1,
        SYSRESETREQ: u1,
        reserved0: u5 = 0,
        PRIGROUP: u3,
        reserved1: u4 = 0,
        ENDIANNESS: u1,
        VECTKEY: u16,
    }),
    /// System Control Register.
    SCR: mmio.Mmio(packed struct {
        reserved0: u1 = 0,
        SLEEPONEXIT: u1,
        SLEEPDEEP: u1,
        reserved1: u1 = 0,
        SEVONPEND: u1,
        reserved2: u27 = 0,
    }),
    /// Configuration Control Register.
    CCR: mmio.Mmio(packed struct(u32) {
        NONBASETHRDENA: u1,
        USERSETMPEND: u1,
        reserved0: u1 = 0,
        UNALIGN_TRP: u1,
        DIV_0_TRP: u1,
        reserved1: u3 = 0,
        BFHFNMIGN: u1,
        STKALIGN: u1,
        reserved2: u22 = 0,
    }),
    /// System Handlers Priority Registers.
    SHP: [12]u8,
    /// System Handler Contol and State Register.
    SHCSR: u32,
    /// Configurable Fault Status Register.
    CFSR: mmio.Mmio(packed struct(u32) {
        /// MemManage Fault Register.
        MMFSR: u8,
        /// BusFault Status Register.
        BFSR: u8,
        /// Usage Fault Status Register.
        UFSR: u16,
    }),
    /// HardFault Status Register.
    HFSR: u32,
    /// Debug Fault Status Register.
    DFSR: u32,
    /// MemManage Fault Address Register.
    MMFAR: u32,
    /// BusFault Address Register.
    BFAR: u32,
    /// Auxilary Feature Register.
    AFSR: u32,
};

pub const NestedVectorInterruptController = extern struct {
    /// Interrupt Set-Enable Registers.
    ISER: [8]u32,
    reserved0: [24]u32,
    /// Interrupt Clear-Enable Registers.
    ICER: [8]u32,
    reserved1: [24]u32,
    /// Interrupt Set-Pending Registers.
    ISPR: [8]u32,
    reserved2: [24]u32,
    /// Interrupt Clear-Pending Registers.
    ICPR: [8]u32,
    reserved3: [24]u32,
    /// Interrupt Active Bit Registers.
    IABR: [8]u32,
    reserved4: [56]u32,
    /// Interrupt Priority Registers.
    IPR: [240]u8,
    reserved5: [644]u32,
    /// Software Trigger Interrupt Registers.
    STIR: u32,
};

pub const MemoryProtectionUnit = extern struct {
    /// MPU Type Register.
    TYPE: mmio.Mmio(packed struct(u32) {
        /// Indicates support for unified or separate instructions and data address regions.
        SEPARATE: u1,
        reserved0: u7 = 0,
        /// Number of data regions supported by the MPU.
        DREGION: u8,
        /// Number of instruction regions supported by the MPU.
        IREGION: u8,
        reserved1: u8 = 0,
    }),
    /// MPU Control Register.
    CTRL: mmio.Mmio(packed struct(u32) {
        /// Enables the MPU.
        ENABLE: u1,
        /// Enables of operation of MPU during HardFault and MNIHandlers.
        HFNMIENA: u1,
        /// Enables priviledged software access to default memory map.
        PRIVDEFENA: u1,
        reserved0: u29 = 0,
    }),
    /// MPU Region Number Register.
    RNR: mmio.Mmio(packed struct(u32) {
        /// Indicates the memory region accessed by MPU RBAR and PMU RLAR.
        REGION: u8,
        reserved0: u24 = 0,
    }),
    /// MPU Region Base Address Register.
    RBAR: RBAR_Register,
    /// MPU Region Attribute and Size Register.
    RASR: RASR_Register,
    /// MPU Alias 1 Region Base Address Register.
    RBAR_A1: RBAR_Register,
    /// MPU Alias 1 Region Attribute and Size Register.
    RASR_A1: RASR_Register,
    /// MPU Alias 2 Region Base Address Register.
    RBAR_A2: RBAR_Register,
    /// MPU Alias 2 Region Attribute and Size Register.
    RASR_A2: RASR_Register,
    /// MPU Alias 3 Region Base Address Register.
    RBAR_A3: RBAR_Register,
    /// MPU Alias 3 Region Attribute and Size Register.
    RASR_A3: RASR_Register,

    pub const RBAR_Register = mmio.Mmio(packed struct(u32) {
        /// MPU region field.
        REGION: u4,
        /// MPU region number valid bit.
        VALID: u1,
        /// Region base address field.
        ADDR: u27,
    });

    pub const RASR_Register = mmio.Mmio(packed struct(u32) {
        /// Region enable bit.
        ENABLE: u1,
        /// Specifies the size of the MPU protection region.
        SIZE: u5,
        reserved0: u2 = 0,
        /// Subregion disable bits.
        SRD: u8,
        /// Shareable bit.
        S: u1,
        /// Memory Access Attribute.
        B: u1,
        /// Memory Access Attribute.
        C: u1,
        /// Memory Access Attribute.
        TEX: u3,
        reserved1: u2 = 0,
        /// Access permission field.
        AP: u3,
        /// Instruction access disable bit.
        XN: u1,
        reserved2: u3 = 0,
    });
};
