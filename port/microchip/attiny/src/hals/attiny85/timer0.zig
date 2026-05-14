const regs = @import("registers.zig");

pub const CompareOutput = enum(u2) {
    disconnected = 0b00,
    toggle = 0b01,
    clear = 0b10,
    set = 0b11,
};

pub const Waveform = enum(u3) {
    normal = 0b000,
    phase_correct_pwm_top_0xff = 0b001,
    ctc = 0b010,
    fast_pwm_top_0xff = 0b011,
    phase_correct_pwm_top_ocra = 0b101,
    fast_pwm_top_ocra = 0b111,
};

pub const Prescaler = enum(u3) {
    stopped = 0b000,
    clk_1 = 0b001,
    clk_8 = 0b010,
    clk_64 = 0b011,
    clk_256 = 0b100,
    clk_1024 = 0b101,
    external_falling = 0b110,
    external_rising = 0b111,
};

pub const Config = struct {
    waveform: Waveform = .normal,
    compare_a: CompareOutput = .disconnected,
    compare_b: CompareOutput = .disconnected,
    prescaler: Prescaler = .stopped,
};

pub fn apply(config: Config) void {
    const wgm: u3 = @intFromEnum(config.waveform);
    regs.write(regs.TCCR0A, (@as(u8, @intFromEnum(config.compare_a)) << 6) |
        (@as(u8, @intFromEnum(config.compare_b)) << 4) |
        (@as(u8, wgm) & 0b011));
    regs.write(regs.TCCR0B, ((@as(u8, wgm) & 0b100) << 1) |
        @as(u8, @intFromEnum(config.prescaler)));
}

pub inline fn setCompareA(value: u8) void {
    regs.write(regs.OCR0A, value);
}

pub inline fn setCompareB(value: u8) void {
    regs.write(regs.OCR0B, value);
}

pub inline fn counter() u8 {
    return regs.read(regs.TCNT0);
}

pub inline fn setCounter(value: u8) void {
    regs.write(regs.TCNT0, value);
}
