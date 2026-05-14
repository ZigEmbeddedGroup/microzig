const regs = @import("registers.zig");

pub const Prescaler = enum(u4) {
    stopped = 0b0000,
    pck_1 = 0b0001,
    pck_2 = 0b0010,
    pck_4 = 0b0011,
    pck_8 = 0b0100,
    pck_16 = 0b0101,
    pck_32 = 0b0110,
    pck_64 = 0b0111,
    pck_128 = 0b1000,
    pck_256 = 0b1001,
    pck_512 = 0b1010,
    pck_1024 = 0b1011,
    pck_2048 = 0b1100,
    pck_4096 = 0b1101,
    pck_8192 = 0b1110,
    pck_16384 = 0b1111,
};

pub const CompareOutput = enum(u2) {
    disconnected = 0b00,
    toggle = 0b01,
    clear = 0b10,
    set = 0b11,
};

pub const PwmOutput = enum {
    a,
    b,
};

pub const Interrupt = enum(u8) {
    overflow = 1 << 2,
    compare_a = 1 << 6,
    compare_b = 1 << 5,
};

pub const FastPwmConfig = struct {
    output: PwmOutput,
    prescaler: Prescaler = .pck_1,
    compare: CompareOutput = .clear,
    top: u8 = 255,
};

pub fn configureFastPwm(config: FastPwmConfig) void {
    // ATtiny25/45/85 datasheet, sections 12.2 and 12.3: OCR1C is TOP for
    // Timer/Counter1 PWM and Timer1 register writes are synchronized.
    regs.write(regs.OCR1C, config.top);

    switch (config.output) {
        .a => {
            regs.write(regs.TCCR1, 0x40 |
                (@as(u8, @intFromEnum(config.compare)) << 4) |
                @as(u8, @intFromEnum(config.prescaler)));
            regs.clearBits(regs.GTCCR, 0b0111_0000);
        },
        .b => {
            regs.write(regs.TCCR1, @as(u8, @intFromEnum(config.prescaler)));
            regs.write(regs.GTCCR, 0x40 | (@as(u8, @intFromEnum(config.compare)) << 4));
        },
    }
}

pub inline fn setCompareA(value: u8) void {
    regs.write(regs.OCR1A, value);
}

pub inline fn setCompareB(value: u8) void {
    regs.write(regs.OCR1B, value);
}

pub inline fn setTop(value: u8) void {
    regs.write(regs.OCR1C, value);
}

pub inline fn counter() u8 {
    return regs.read(regs.TCNT1);
}

pub inline fn enableInterrupt(interrupt: Interrupt) void {
    regs.setBits(regs.TIMSK, @intFromEnum(interrupt));
}

pub inline fn disableInterrupt(interrupt: Interrupt) void {
    regs.clearBits(regs.TIMSK, @intFromEnum(interrupt));
}
