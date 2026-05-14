const regs = @import("registers.zig");

pub const Prescaler = enum(u3) {
    stopped = 0b000,
    clk_1 = 0b001,
    clk_8 = 0b010,
    clk_64 = 0b011,
    clk_256 = 0b100,
    clk_1024 = 0b101,
};

pub fn configure_phase_correct_pwm_a(prescaler: Prescaler) void {
    // ATtiny1634 datasheet section 11.7.3, page 83: phase-correct PWM on OC0A.
    // https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-8303-8-bit-AVR-Microcontroller-tinyAVR-ATtiny1634_Datasheet.pdf
    regs.write(regs.TCCR0A, (1 << 7) | (1 << 0));
    regs.write(regs.TCCR0B, @intFromEnum(prescaler));
}

pub inline fn set_compare_a(value: u8) void {
    regs.write(regs.OCR0A, value);
}
