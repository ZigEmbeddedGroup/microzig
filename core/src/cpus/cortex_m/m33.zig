//! Related documentation:
//! - ARM Cortex-M33 Reference: https://developer.arm.com/documentation/100230/latest/
const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const PlatformOptions = struct {
    /// When true, interrupt vectors are moved to RAM so handlers can be set at runtime.
    ram_vectors: bool = false,
    /// When true, the RAM vectors are placed in section `ram_vectors`.
    has_ram_vectors_section: bool = false,
};

pub const SystemControlBlock = extern struct {
    /// CPUID Base Register.
    CPUID: u32,
    /// Interrupt Control and State Register.
    ICSR: u32,
    /// Vector Table Offset Register.
    VTOR: u32,
    /// Application Interrupt and Reset Control Register.
    AIRCR: u32,
    /// System Control Register.
    SCR: u32,
    /// Configuration and Control Register.
    CCR: mmio.Mmio(packed struct(u32) {
        reserved0: u1,
        /// User set pending determines if unpriviledged access to the STIR generates a fault.
        USERSETMPEND: u1,
        reserved1: u1,
        /// Unaligned trap controls trapping of unaligned word and half word accesses.
        UNALIGN_TRP: u1,
        /// Divide by zero trap controls generation of DIVBYZERO usage fault.
        DIV_0_TRP: u1,
        reserved2: u3,
        /// Determines effect of precise bus faults running on handlers at requested priority less than 0.
        BFHFNMIGN: u1,
        reserved3: u1,
        /// Controls effect of stack limit violation while executing at a requested priority less than 0.
        STKOFHFNMIGN: u1,
        reserved4: u5,
        /// Read as zero/write ignored.
        DC: u1,
        /// Read as zero/write ignored.
        IC: u1,
        /// Read as zero/write ignored.
        BP: u1,
        reserved5: u13,
    }),
    /// System Handler Priority Registers.
    SHPR: [12]u8,
    /// System Handler Control and State Register.
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
    reserved0: u32,
    /// MemManage Fault Address Register.
    MMFAR: u32,
    /// BusFault Address Register.
    BFAR: u32,
    /// Auxiliary Fault Status Register not implemented.
    _AFSR: u32,
    reserved1: [18]u32,
    /// Coprocessor Access Control Register.
    CPACR: u32,
    /// Non-secure Access Control Register.
    NSACR: u32,
};

pub const NestedVectorInterruptController = extern struct {
    /// Interrupt Set Registers.
    ISER: [16]u32,
    reserved0: [16]u32,
    /// Interrupt Clear Enable Registers.
    ICER: [16]u32,
    reserved1: [16]u32,
    /// Interrupt Set Pending Registers.
    ISPR: [16]u32,
    reserved2: [16]u32,
    /// Interrupt Clear Pending Registers.
    ICPR: [16]u32,
    reserved3: [16]u32,
    /// Interrupt Active Bit Registers.
    IABR: [16]u32,
    reserved4: [16]u32,
    /// Interrupt Target Non-secure Registers.
    ITNS: [16]u32,
    reserved5: [16]u32,
    /// Interrupt Priority Registers.
    IPR: [480]u8,
    reserved6: [584]u32,
    /// Software Trigger Interrupt Register.
    STIR: u32,
};

pub const SecurityAttributionUnit = extern struct {
    /// SAU Control Register.
    CTRL: u32,
    /// SAU Type Register.
    TYPE: u32,
    /// SAU Region Number Register.
    RNR: u32,
    /// SAU Region Base Address.
    RBAR: u32,
    /// SAU Region Limit Address.
    RLAR: u32,
    /// Secure Fault Status Register.
    SFSR: u32,
    /// Secure Fault Address Register.
    SFAR: u32,
};

pub const MemoryProtectionUnit = extern struct {
    /// MPU Type Register.
    TYPE: mmio.Mmio(packed struct(u32) {
        /// Indicates support for unified or separate instructions and data address regions.
        SEPARATE: u1,
        reserved0: u7,
        /// Number of data regions supported by the MPU.
        DREGION: u8,
        reserved1: u16,
    }),
    /// MPU Control Register.
    CTRL: mmio.Mmio(packed struct(u32) {
        /// Enables the MPU
        ENABLE: u1,
        /// Enables of operation of MPU during HardFault and MNIHandlers.
        HFNMIENA: u1,
        /// Enables priviledged software access to default memory map.
        PRIVDEFENA: u1,
        reserved0: u29,
    }),
    /// MPU Region Number Register.
    RNR: mmio.Mmio(packed struct(u32) {
        /// Indicates the memory region accessed by MPU RBAR and PMU RLAR.
        REGION: u8,
        reserved0: u24,
    }),
    /// MPU Region Base Address Register.
    RBAR: RBAR_Register,
    /// MPU Region Limit Address Register.
    RLAR: RLAR_Register,
    /// MPU Region Base Address Register Alias 1.
    RBAR_A1: RBAR_Register,
    /// MPU Region Base Address Register Alias 2.
    RBAR_A2: RBAR_Register,
    /// MPU Region Base Address Register Alias 3.
    RBAR_A3: RBAR_Register,
    /// MPU Region Limit Address Register Alias 1.
    RLAR_A1: RLAR_Register,
    /// MPU Region Base Address Register Alias 2.
    RLAR_A2: RLAR_Register,
    /// MPU Region Base Address Register Alias 3.
    RLAR_A3: RLAR_Register,
    reserved0: [20]u8,
    /// MPU Memory Addribute Indirection Register 0.
    MPU_MAIR0: u32,
    /// MPU Memory Addribute Indirection Register 1.
    MPU_MAIR1: u32,

    /// MPU Region Address Register format.
    pub const RBAR_Register = mmio.Mmio(packed struct(u32) {
        /// Execute Never defines if code can be executed from this region.
        XN: u1,
        /// Access permissions.
        AP: u2,
        /// Shareability.
        SH: u2,
        /// Contains bits[31:5] of the lower inclusive limit selectable of the selected MPU memory region. This value
        /// is zero extended to provide the base address to be checked against.
        BASE: u27,
    });

    /// MPU Region Limit Address Register format.
    pub const RLAR_Register = mmio.Mmio(packed struct(u32) {
        /// Enable the region.
        EN: u1,
        /// Attribue Index associates a set of attributes in the MPU MAIR0 and MPU MAIR1 fields.
        AttrIndx: u3,
        reserved0: u1,
        /// Limit Address contains bits [31:5] of the upper inclusive limit of the selected MPU memory region. This
        /// value is postfixed with 0x1F to provide the limit address to be checked against.
        LIMIT: u27,
    });
};
