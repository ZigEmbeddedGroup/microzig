const regs = @import("registers.zig");

pub const Prescaler = enum(u3) {
    stopped = 0b000,
    clk_1 = 0b001,
    clk_8 = 0b010,
    clk_64 = 0b011,
    clk_256 = 0b100,
    clk_1024 = 0b101,
};

pub const DynamicPwmConfig = struct {
    top: u16 = 255,
    prescaler: Prescaler = .clk_1,
};

pub fn configure_phase_correct_dynamic(config: DynamicPwmConfig) void {
    // ATtiny1634 datasheet section 12.9.3 and table 12-5, pages 105 and 113:
    // phase-correct PWM with ICR1 TOP gives runtime-adjustable PWM resolution.
    // https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-8303-8-bit-AVR-Microcontroller-tinyAVR-ATtiny1634_Datasheet.pdf

    regs.write(regs.TCCR1A, (1 << 7) | (1 << 5) | (1 << 1));
    regs.write(regs.TCCR1B, (1 << 4) | @as(u8, @intFromEnum(config.prescaler)));
    set_top(config.top);
}

pub inline fn set_top(value: u16) void {
    regs.mem16(regs.ICR1).* = value;
}

pub inline fn set_compare_a(value: u16) void {
    regs.mem16(regs.OCR1A).* = value;
}

pub inline fn set_compare_b(value: u16) void {
    regs.mem16(regs.OCR1B).* = value;
}

pub inline fn set_counter(value: u16) void {
    regs.mem16(regs.TCNT1).* = value;
}

pub inline fn counter() u16 {
    return regs.mem16(regs.TCNT1).*;
}
