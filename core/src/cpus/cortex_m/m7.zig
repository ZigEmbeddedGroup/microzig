const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const SystemControlBlock = extern struct {
    /// CPUID Base Register
    CPUID: u32,
    /// Interrupt Control and State Register
    ICSR: mmio.Mmio(packed struct(u32) {
        VECTACTIVE: u9,
        reserved0: u2,
        RETTOBASE: u1,
        VECTPENDING: u9,
        reserved1: u1,
        ISRPENDING: u1,
        ISRPREEMPT: u1,
        reserved2: u1,
        PENDSTCLR: u1,
        PENDSTSET: u1,
        PENDSVCLR: u1,
        PENDSVSET: u1,
        reserved3: u2,
        NMIPENDSET: u1,
    }),
    /// Vector Table Offset Register
    VTOR: u32,
    /// Application Interrupt and Reset Control Register
    AIRCR: u32,
    /// System Control Register
    SCR: u32,
    /// Configuration Control Register
    CCR: mmio.Mmio(packed struct(u32) {
        NONBASETHRDENA: u1,
        USERSETMPEND: u1,
        reserved0: u1,
        UNALIGN_TRP: u1,
        DIV_0_TRP: u1,
        reserved1: u3,
        BFHFNMIGN: u1,
        STKALIGN: u1,
        padding: u22,
    }),
    /// System Handlers Priority Registers
    SHP: [3]u8,
    /// System Handler Contol and State Register
    SHCSR: u32,
    /// Configurable Fault Status Register
    CFSR: u32,
    /// MemManage Fault Status Register
    MMSR: u32,
    /// BusFault Status Register
    BFSR: u32,
    /// UsageFault Status Register
    UFSR: u32,
    /// HardFault Status Register
    HFSR: u32,
    /// MemManage Fault Address Register
    MMAR: u32,
    /// BusFault Address Register
    BFAR: u32,
    /// Auxiliary Fault Status Register not implemented
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
    /// Interrupt Set-enable Registers
    ISER: [7]u32,
    reserved0: [25]u32,
    /// Interrupt Clear-enable Registers
    ICER: [7]u32,
    reserved1: [25]u32,
    /// Interrupt Set-pending Registers
    ISPR: [7]u32,
    reserved2: [25]u32,
    /// Interrupt Clear-pending Registers
    ICPR: [7]u32,
    reserved3: [25]u32,
    /// Interrupt Active Bit Registers
    IABR: [7]u32,
    reserved4: [57]u32,
    /// Interrupt Priority Registers
    IP: [239]u8,
    reserved5: [2577]u8,
    /// Software Trigger Interrupt Register
    STIR: u32,
};

pub const MemoryProtectionUnit = extern struct {
    /// MPU Type Register
    TYPE: mmio.Mmio(packed struct(u32) {
        SEPARATE: u1,
        reserved0: u7,
        DREGION: u8,
        IREGION: u8,
        reserved1: u8,
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
        reserved0: u2,
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
        reserved1: u2,
        /// ATTRS.AP
        AP: u3,
        /// ATTRS.XN
        XN: u1,
        padding: u4,
    });
};

pub const DebugRegisters = extern struct {
    /// Debyg Halting Control and Status Register
    DHCSR: mmio.Mmio(packed struct {
        reserved0: u6,
        S_RESET_ST: u1,
        S_RETIRE_ST: u1,
        reserved1: u4,
        S_LOCKUP: u1,
        S_SLEEP: u1,
        S_HALT: u1,
        S_REGRDY: u1,
        reserved2: u10,
        C_SNAPSTALL: u1,
        reserved3: u1,
        C_MASKINTS: u1,
        C_STEP: u1,
        C_HALT: u1,
        C_DEBUGEN: u1,
    }),
    /// Debug Core Register Selector Register
    /// TODO: Reserved have values ? see armv7-m reference manual
    DCRSR: mmio.Mmio(packed struct {
        reserved0: u15,
        REGWnR: u1,
        reserved1: u9,
        REGSEL: u7,
    }),
    /// Debug Core Register Data Register
    DCRDR: mmio.Mmio(packed struct {
        DBGTMP: u32,
    }),
    /// Debug exception and Monitor Control Register
    DEMCR: mmio.Mmio(packed struct {
        reserved0: u7,
        TRCENA: u1,
        reserved1: u4,
        MON_REQ: u1,
        MON_STEP: u1,
        MON_PEND: u1,
        MON_EN: u1,
        reserved2: u5,
        VC_HARDERR: u1,
        VC_INTERR: u1,
        VC_BUSERR: u1,
        VC_STATERR: u1,
        VC_CHKERR: u1,
        VC_NOCPERR: u1,
        VC_MMERR: u1,
        reserved3: u3,
        VC_CORERESET: u1,
    }),
};

pub const ITM = extern struct {
    /// Stimulus Port Registers (0-255)
    STIM: [256]mmio.Mmio(packed union {
        WRITE_U8: u8,
        WRITE_U16: u16,
        WRITE_U32: u32,
        READ: packed struct(u32) {
            FIFOREADY: u1,
            reserved: u31,
        },
    }),

    reserved0: [640]u32, // Padding to 0xE00

    /// Trace Enable Registers (0-7)
    TER: [8]mmio.Mmio(packed struct(u32) {
        STIMENA: u32, // Enable bits for stimulus ports
    }),

    reserved1: [10]u32, // Padding to 0xE40

    /// Trace Privilege Register
    TPR: mmio.Mmio(packed struct(u32) {
        PRIVMASK: u32, // Privilege mask for stimulus ports
    }),

    reserved2: [15]u32, // Padding to 0xE80

    /// Trace Control Register
    TCR: mmio.Mmio(packed struct(u32) {
        ITMENA: u1, // ITM enable
        TSENA: u1, // Local timestamp enable
        SYNCENA: u1, // Sync packet enable
        TXENA: u1, // DWT packet forwarding enable
        SWOENA: u1, // Async clock enable
        reserved0: u3,
        TSPrescale: u2, // Local timestamp prescaler
        GTSFREQ: u2, // Global timestamp frequency
        reserved1: u4,
        TraceBusID: u7, // Trace bus ID
        BUSY: u1, // ITM busy flag
        reserved2: u8,
    }),
};

pub const TPIU = extern struct {
    /// Supported Parallel Port Sizes Register
    SSPSR: mmio.Mmio(packed struct(u32) {
        SWIDTH: u32,
    }),
    /// Current Parallel Port Size Register
    CSPSR: mmio.Mmio(packed struct(u32) {
        CWIDTH: u32,
    }),
    reserved0: [2]u32,
    /// Asynchronous Clock Prescaler Register
    ACPR: mmio.Mmio(packed struct(u32) {
        SWOSCALER: u16,
        padding: u16,
    }),
    reserved1: [55]u32,
    /// Selected Pin Protocol Register
    SPPR: mmio.Mmio(packed struct(u32) {
        TXMODE: u2,
        padding: u30,
    }),
    reserved2: [524]u32,
    /// TPIU Type Register
    TYPE: mmio.Mmio(packed struct(u32) {
        reserved0: u6,
        FIFOSZ: u3,
        PTINVALID: u1,
        MANCVALID: u1,
        NRZVALID: u1,
        implementation_defined0: u4,
        padding: u16,
    }),
    reserved3: [13]u32,
};
