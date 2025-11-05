const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const CPU_Options = struct {
    /// When true, the vector table lives in RAM.
    ram_vector_table: bool = false,
};

pub const scb_base_offset = 0x0d00;

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
    /// Application Interrupt and Reset Control Register
    AIRCR: mmio.Mmio(packed struct(u32) {
        /// Reserved for Debug use. Must be written as 0.
        VECTRESET: u1, // WO
        /// Reserved for Debug use. Must be written as 0.
        VECTCLRACTIVE: u1, // WO
        /// System reset request
        SYSRESETREQ: u1, // WO
        reserved0: u5 = 0, // [7:3] Reserved
        /// Interrupt priority grouping
        PRIGROUP: u3, // RW
        reserved1: u4 = 0, // [14:11] Reserved
        /// Endianness: 0 = Little, 1 = Big
        ENDIANNESS: u1, // RO
        /// VECTKEY (write) / VECTKEYSTAT (read)
        VECTKEY: u16, // RW (write 0x5FA to update)
    }),
    /// System Control Register
    SCR: u32,
    /// Configuration Control Register
    CCR: mmio.Mmio(packed struct(u32) {
        NONBASETHRDENA: u1,
        USERSETMPEND: u1,
        reserved0: u1 = 0,
        UNALIGN_TRP: u1,
        DIV_0_TRP: u1,
        reserved1: u3 = 0,
        BFHFNMIGN: u1,
        STKALIGN: u1,
        reserved16: u6 = 0,
        /// DC
        DC: u1,
        /// IC
        IC: u1,
        /// BP
        BP: u1,
        padding: u13 = 0,
    }),

    /// System Handler Priority Register 1 (SHPR1)
    SHPR1: mmio.Mmio(packed struct(u32) {
        /// Priority of system handler 4, MemManage
        PRI_4: u8,
        /// Priority of system handler 5, BusFault
        PRI_5: u8,
        /// Priority of system handler 6, UsageFault
        PRI_6: u8,
        /// Reserved bits [31:24]
        reserved0: u8 = 0,
    }),

    /// System Handler Priority Register 2 (SHPR2)
    SHPR2: mmio.Mmio(packed struct(u32) {
        /// Reserved bits [23:0]
        reserved0: u24 = 0,
        /// Priority of system handler 11, SVCall
        PRI_11: u8,
    }),

    /// System Handler Priority Register 3 (SHPR3)
    SHPR3: mmio.Mmio(packed struct(u32) {
        /// Reserved bits [15:0]
        reserved0: u16 = 0,
        /// Priority of system handler 14, PendSV
        PRI_14: u8,
        /// Priority of system handler 15, SysTick
        PRI_15: u8,
    }),

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
    RESERVED0: [1]u32,
    /// Offset: 0x078 (R/ )  Cache Level ID register
    CLIDR: u32,
    /// Offset: 0x07C (R/ )  Cache Type register
    CTR: u32,
    /// Offset: 0x080 (R/ )  Cache Size ID Register
    CCSIDR: u32,
    /// Offset: 0x084 (R/W)  Cache Size Selection Register
    CSSELR: u32,
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
    IPR: [239]u8,
    reserved5: [2577]u8,
    /// Software Trigger Interrupt Register
    STIR: u32,
};

pub const MemoryProtectionUnit = extern struct {
    /// MPU Type Register
    TYPE: mmio.Mmio(packed struct(u32) {
        SEPARATE: u1,
        reserved0: u7 = 0,
        DREGION: u8,
        IREGION: u8,
        reserved1: u8 = 0,
    }),
    /// MPU Control Register
    CTRL: mmio.Mmio(packed struct(u32) {
        ENABLE: u1,
        HFNMIENA: u1,
        PRIVDEFENA: u1,
        padding: u29 = 0,
    }),
    /// MPU RNRber Register
    RNR: mmio.Mmio(packed struct(u32) {
        REGION: u8,
        padding: u24 = 0,
    }),
    /// MPU Region Base Address Register
    RBAR: RBAR_Register,
    /// MPU Region Attribute and Size Register
    RASR: RASR_Register,
    /// MPU Alias 1 Region Base Address Register
    RBAR_A1: RBAR_Register,
    /// MPU Alias 1 Region Attribute and Size Register
    RASR_A1: RASR_Register,
    /// MPU Alias 2 Region Base Address Register
    RBAR_A2: RBAR_Register,
    /// MPU Alias 2 Region Attribute and Size Register
    RASR_A2: RASR_Register,
    /// MPU Alias 3 Region Base Address Register
    RBAR_A3: RBAR_Register,
    /// MPU Alias 3 Region Attribute and Size Register
    RASR_A3: RASR_Register,

    pub const RBAR_Register = mmio.Mmio(packed struct(u32) {
        REGION: u4,
        VALID: u1,
        ADDR: u27,
    });

    pub const RASR_Register = mmio.Mmio(packed struct(u32) {
        /// Region enable bit
        ENABLE: u1,
        /// Region Size
        SIZE: u5,
        reserved0: u2 = 0,
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
        reserved1: u2 = 0,
        /// ATTRS.AP
        AP: u3,
        /// ATTRS.XN
        XN: u1,
        padding: u4 = 0,
    });
};

pub const DebugRegisters = extern struct {
    /// Debyg Halting Control and Status Register
    DHCSR: mmio.Mmio(packed struct {
        reserved0: u6 = 0,
        S_RESET_ST: u1,
        S_RETIRE_ST: u1,
        reserved1: u4 = 0,
        S_LOCKUP: u1,
        S_SLEEP: u1,
        S_HALT: u1,
        S_REGRDY: u1,
        reserved2: u10 = 0,
        C_SNAPSTALL: u1,
        reserved3: u1 = 0,
        C_MASKINTS: u1,
        C_STEP: u1,
        C_HALT: u1,
        C_DEBUGEN: u1,
    }),
    /// Debug Core Register Selector Register
    /// TODO: Reserved have values ? see armv7-m reference manual
    DCRSR: mmio.Mmio(packed struct {
        reserved0: u15 = 0,
        REGWnR: u1,
        reserved1: u9 = 0,
        REGSEL: u7,
    }),
    /// Debug Core Register Data Register
    DCRDR: mmio.Mmio(packed struct {
        DBGTMP: u32,
    }),
    /// Debug exception and Monitor Control Register
    DEMCR: mmio.Mmio(packed struct {
        reserved0: u7 = 0,
        TRCENA: u1,
        reserved1: u4 = 0,
        MON_REQ: u1,
        MON_STEP: u1,
        MON_PEND: u1,
        MON_EN: u1,
        reserved2: u5 = 0,
        VC_HARDERR: u1,
        VC_INTERR: u1,
        VC_BUSERR: u1,
        VC_STATERR: u1,
        VC_CHKERR: u1,
        VC_NOCPERR: u1,
        VC_MMERR: u1,
        reserved3: u3 = 0,
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
            reserved: u31 = 0,
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
        reserved0: u3 = 0,
        TSPrescale: u2, // Local timestamp prescaler
        GTSFREQ: u2, // Global timestamp frequency
        reserved1: u4 = 0,
        TraceBusID: u7, // Trace bus ID
        BUSY: u1, // ITM busy flag
        reserved2: u8 = 0,
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
        padding: u16 = 0,
    }),
    reserved1: [55]u32,
    /// Selected Pin Protocol Register
    SPPR: mmio.Mmio(packed struct(u32) {
        TXMODE: u2,
        padding: u30 = 0,
    }),
    reserved2: [524]u32,
    /// TPIU Type Register
    TYPE: mmio.Mmio(packed struct(u32) {
        reserved0: u6 = 0,
        FIFOSZ: u3,
        PTINVALID: u1,
        MANCVALID: u1,
        NRZVALID: u1,
        implementation_defined0: u4,
        padding: u16 = 0,
    }),
    reserved3: [13]u32,
};

pub const FloatingPointUnit = extern struct {
    FPCCR: mmio.Mmio(packed struct(u32) {
        LSPACT: u1,
        USER: u1,
        S: u1,
        THREAD: u1,
        HFRDY: u1,
        MMRDY: u1,
        BFRDY: u1,
        SFRDY: u1,
        MONRDY: u1,
        SPLIMVIOL: u1,
        UFRDY: u1,
        reserved0: u15 = 0,
        TS: u1,
        CLRONRETS: u1,
        CLRONRET: u1,
        LSPENS: u1,
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
