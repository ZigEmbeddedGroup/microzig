const microzig = @import("microzig");
const root = @import("root");

const riscv32_common = @import("riscv32-common");

pub const interrupt = struct {
    pub inline fn enable_interrupts() void {
        asm volatile ("csrsi mstatus, 0b1000");
    }

    pub inline fn disable_interrupts() void {
        asm volatile ("csrci mstatus, 0b1000");
    }
};

pub inline fn wfi() void {
    asm volatile ("wfi");
}

pub inline fn wfe() void {
    const PFIC = microzig.chip.peripherals.PFIC;
    // Treats the subsequent wfi instruction as wfe
    PFIC.SCTLR.modify(.{ .WFITOWFE = 1 });
    asm volatile ("wfi");
}
