pub const SystemControlBlock = @compileError("TODO");

pub const NestedVectorInterruptController = extern struct {
    /// Interrupt set registers.
    ISER: u32,
    _reserved0: [31]u32,
    /// Interrupt clear enable registers.
    ICER: u32,
    _reserved1: [31]u32,
    /// Interrupt set pending registers.
    ISPR: u32,
    _reserved2: [31]u32,
    /// Interrupt clear pending registers.
    ICPR: u32,
    _reserved3: [31]u32,
    /// Interrupt priority registers.
    IPR: [28]u8,
};

pub const MemoryProtectionUnit = @compileError("TODO");
