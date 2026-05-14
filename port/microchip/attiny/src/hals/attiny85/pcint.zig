const regs = @import("registers.zig");

pub const PinChange = enum(u3) {
    pcint0 = 0,
    pcint1 = 1,
    pcint2 = 2,
    pcint3 = 3,
    pcint4 = 4,
    pcint5 = 5,
};

pub inline fn enablePin(pin: PinChange) void {
    regs.setBits(regs.PCMSK, regs.bit(@intFromEnum(pin)));
}

pub inline fn disablePin(pin: PinChange) void {
    regs.clearBits(regs.PCMSK, regs.bit(@intFromEnum(pin)));
}

pub inline fn enable() void {
    regs.setBits(regs.GIMSK, 1 << 5);
}

pub inline fn disable() void {
    regs.clearBits(regs.GIMSK, 1 << 5);
}

pub inline fn clearFlag() void {
    regs.setBits(regs.GIFR, 1 << 5);
}
