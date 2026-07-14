const regs = @import("registers.zig");

pub const PinChange = enum(u3) {
    pcint0 = 0,
    pcint1 = 1,
    pcint2 = 2,
    pcint3 = 3,
    pcint4 = 4,
    pcint5 = 5,
};

pub inline fn enable_pin(pin: PinChange) void {
    regs.set_bits(regs.PCMSK, regs.bit(@intFromEnum(pin)));
}

pub inline fn disable_pin(pin: PinChange) void {
    regs.clear_bits(regs.PCMSK, regs.bit(@intFromEnum(pin)));
}

pub inline fn enable() void {
    regs.set_bits(regs.GIMSK, 1 << 5);
}

pub inline fn disable() void {
    regs.clear_bits(regs.GIMSK, 1 << 5);
}

pub inline fn clear_flag() void {
    regs.set_bits(regs.GIFR, 1 << 5);
}
