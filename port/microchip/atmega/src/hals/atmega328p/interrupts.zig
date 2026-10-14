//! Global interrupt control for the ATmega328P.

const microzig = @import("microzig");

// The generated `peripherals.CPU` is a pointer to address 0, so SREG gets its
// own pointer at its offset (see `spi.zig`).
const CPU_Regs = microzig.chip.types.peripherals.CPU;
const SREG: *volatile u8 = @ptrFromInt(@offsetOf(CPU_Regs, "SREG"));

/// Interrupt state saved by `enter_critical_section`.
pub const CriticalSection = struct {
    sreg: u8,

    /// Restores the interrupt state from before `enter_critical_section`.
    pub inline fn leave(section: CriticalSection) void {
        asm volatile ("" ::: .{ .memory = true });
        SREG.* = section.sreg;
    }
};

/// Disables interrupts until `leave` is called on the result. Memory accesses
/// aren't moved out of the section.
pub inline fn enter_critical_section() CriticalSection {
    const section: CriticalSection = .{ .sreg = SREG.* };
    asm volatile ("cli" ::: .{ .memory = true });
    return section;
}
