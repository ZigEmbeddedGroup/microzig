const regs = @import("registers.zig");

pub const Mode = enum(u2) {
    idle = 0b00,
    adc_noise_reduction = 0b01,
    power_down = 0b10,
};

pub inline fn set_mode(mode: Mode) void {
    const mask = regs.bit(regs.sleep_bits.sm1) | regs.bit(regs.sleep_bits.sm0);
    regs.write(regs.MCUCR, (regs.read(regs.MCUCR) & ~mask) |
        (@as(u8, @intFromEnum(mode)) << regs.sleep_bits.sm0));
}

pub inline fn enable() void {
    regs.set_bits(regs.MCUCR, regs.bit(regs.sleep_bits.se));
}

pub inline fn disable() void {
    regs.clear_bits(regs.MCUCR, regs.bit(regs.sleep_bits.se));
}

pub inline fn cpu() void {
    asm volatile ("sleep" ::: .{ .memory = true });
}

pub inline fn enter(mode: Mode) void {
    set_mode(mode);
    enable();
    cpu();
    disable();
}

pub inline fn bod_disable() void {
    // ATtiny25/45/85 datasheet, section 7.2: BODS must be set and BODSE
    // cleared in a timed sequence immediately before SLEEP.
    const mask = regs.bit(regs.sleep_bits.bods) | regs.bit(regs.sleep_bits.bodse);
    regs.set_bits(regs.MCUCR, mask);
    regs.write(regs.MCUCR, regs.read(regs.MCUCR) & ~regs.bit(regs.sleep_bits.bodse));
}
