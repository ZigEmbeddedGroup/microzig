const microzig = @import("microzig");
const mmio = microzig.mmio;

pub const SystemControlBlock = extern struct {
    /// CPUID Base Register
    CPUID: u32,
    /// Interrupt Control and State Register
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
    reserved0: u32,
    /// Application Interrupt  and Reset Control Register
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
    reserved1: u32,
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
