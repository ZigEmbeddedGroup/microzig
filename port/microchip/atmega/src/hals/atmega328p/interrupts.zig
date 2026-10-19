//! Global interrupt control for the ATmega328P.

const microzig = @import("microzig");

const SREG = &microzig.chip.peripherals.CPU.SREG;

/// Interrupt state saved by `enter_critical_section`.
pub const CriticalSection = struct {
    sreg: u8,

    /// Restores the interrupt state from before `enter_critical_section`.
    pub inline fn leave(section: CriticalSection) void {
        asm volatile ("" ::: .{ .memory = true });
        SREG.write_raw(section.sreg);
    }
};

/// Disables interrupts until `leave` is called on the result. Memory accesses
/// aren't moved out of the section.
pub inline fn enter_critical_section() CriticalSection {
    const section: CriticalSection = .{ .sreg = SREG.raw };
    asm volatile ("cli" ::: .{ .memory = true });
    return section;
}
