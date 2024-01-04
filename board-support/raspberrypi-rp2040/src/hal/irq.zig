const microzig = @import("microzig");
const NVIC = microzig.chip.peripherals.NVIC;

// TODO: the register definitions are improved now, use them instead of raw
// writes/reads
fn get_interrupt_mask(comptime interrupt_name: []const u8) u32 {
    const offset = @offsetOf(microzig.chip.VectorTable, interrupt_name);

    return (1 << ((offset / 4) - 16));
}
pub fn enable(comptime interrupt_name: []const u8) void {
    const mask = comptime get_interrupt_mask(interrupt_name);
    NVIC.ICPR.raw = mask;
    NVIC.ISER.raw = mask;
}

pub fn disable(comptime interrupt_name: []const u8) void {
    const mask = comptime get_interrupt_mask(interrupt_name);
    NVIC.ICER.raw = mask;
}
