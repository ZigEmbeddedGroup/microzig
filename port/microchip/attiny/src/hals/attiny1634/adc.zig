const regs = @import("registers.zig");

pub const Channel = enum(u4) {
    adc0 = 0,
    adc1 = 1,
    adc2 = 2,
    adc3 = 3,
    adc4 = 4,
    adc5 = 5,
    adc6 = 6,
    adc7 = 7,
    adc8 = 8,
    adc9 = 9,
    adc10 = 10,
    adc11 = 11,
    vcc_1v1 = 13,
    temperature = 14,
};

pub const Prescaler = enum(u3) {
    div2 = 1,
    div4 = 2,
    div8 = 3,
    div16 = 4,
    div32 = 5,
    div64 = 6,
    div128 = 7,
};

pub fn configureInternal1v1(channel: Channel, prescaler: Prescaler) void {
    // ATtiny1634 datasheet section 17.13.1, page 177: ADMUX selects reference
    // and channel; ADCSRA starts/enables auto-triggered conversions.
    // https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-8303-8-bit-AVR-Microcontroller-tinyAVR-ATtiny1634_Datasheet.pdf
    regs.write(regs.ADMUX, 0b1000_0000 | @as(u8, @intFromEnum(channel)));
    regs.write(regs.ADCSRB, 1 << 4);
    regs.write(regs.ADCSRA, (1 << 7) | (1 << 5) | (1 << 3) | @as(u8, @intFromEnum(prescaler)));
}

pub inline fn start() void {
    regs.setBits(regs.ADCSRA, 1 << 6);
}

pub inline fn stop() void {
    regs.clearBits(regs.ADCSRA, 1 << 7);
}

pub inline fn readRaw16() u16 {
    const low = regs.read(regs.ADCL);
    const high = regs.read(regs.ADCH);
    return (@as(u16, high) << 8) | low;
}
