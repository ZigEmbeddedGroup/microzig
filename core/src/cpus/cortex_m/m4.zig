const microzig = @import("microzig");
const mmio = microzig.mmio;

const shared = @import("shared_types.zig");

pub const CPU_Options = shared.options.Ram_Vector_Options;

pub const scb_base_offset = 0x0d00;

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
    SHCSR: mmio.Mmio(shared.scb.SHCSR),
    /// Configurable Fault Status Register.
    CFSR: mmio.Mmio(packed struct(u32) {
        /// MemManage Fault Register.
        MMFSR: shared.scb.MMFSR,
        /// BusFault Status Register.
        BFSR: shared.scb.BFSR,
        /// Usage Fault Status Register.
        UFSR: shared.scb.UFSR,
    }),
    /// HardFault Status Register.
    HFSR: mmio.Mmio(shared.scb.HFSR),
    /// Debug Fault Status Register.
    DFSR: u32,
    /// MemManage Fault Address Register.
    MMFAR: u32,
    /// BusFault Address Register.
    BFAR: u32,
    /// Auxilary Feature Register.
    AFSR: u32,
    reserved0: [18]u32,
    CPACR: mmio.Mmio(packed struct(u32) {
        reserved0: u20,
        CP10: Privilege,
        CP11: Privilege,
        reserved1: u8,

        pub const Privilege = enum(u2) {
            /// Access denied. Any attempted access generates a NOCP UsageFault.
            access_denied = 0b00,
            /// Privileged access only. An unprivileged access generates a NOCP UsageFault.
            priviledged_access_only = 0b01,
            reserved = 0b10,
            /// Full access.
            full_access = 0b11,
        };
    }),
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

pub const FloatingPointUnit = extern struct {
    FPCCR: mmio.Mmio(packed struct(u32) {
        LSPACT: u1,
        USER: u1,
        reserved0: u1 = 0,
        THREAD: u1,
        HFRDY: u1,
        MMRDY: u1,
        BFRDY: u1,
        reserved1: u1 = 0,
        MONRDY: u1,
        reserved2: u21 = 0,
        /// Automatic state preservation enable. Enables lazy context save of
        /// floating-point state. The possible values of this bit are:
        /// 0 = Disable automatic lazy context save.
        /// 1 = Enable automatic lazy state preservation for floating-point
        /// context.
        ///
        /// Writes to this bit from Non-secure state are ignored if LSPENS is
        /// set to one.
        LSPEN: u1,
        /// Automatic state preservation enable. Enables CONTROL.FPCA setting
        /// on execution of a floating-point instruction. This results in
        /// automatic hardware state preservation and restoration, for
        /// floating-point context, on exception entry and exit. The possible
        /// values of this bit are:
        /// 1 = Enable CONTROL.FPCA setting on execution of a floating-point
        /// instruction.
        /// 0 = Disable CONTROL.FPCA setting on execution of a
        /// floating-point instruction.
        ASPEN: u1,
    }),
    FPCAR: u32,
    FPDSCR: u32,
};
