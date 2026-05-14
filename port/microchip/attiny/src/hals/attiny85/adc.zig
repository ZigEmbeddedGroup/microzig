const regs = @import("registers.zig");
const sleep = @import("sleep.zig");

pub const Reference = enum(u3) {
    vcc = 0b000,
    internal_1v1 = 0b100,
    internal_2v56 = 0b110,
};

pub const Channel = enum(u4) {
    adc0 = 0b0000,
    adc1 = 0b0001,
    adc2 = 0b0010,
    adc3 = 0b0011,
    vcc_1v1 = 0b1100,
    temperature = 0b1111,
};

pub const Prescaler = enum(u3) {
    div2 = 0b001,
    div4 = 0b010,
    div8 = 0b011,
    div16 = 0b100,
    div32 = 0b101,
    div64 = 0b110,
    div128 = 0b111,
};

pub const Config = struct {
    reference: Reference = .internal_1v1,
    channel: Channel,
    prescaler: Prescaler = .div128,
    left_adjust: bool = true,
    auto_trigger: bool = true,
    interrupt: bool = false,
};

pub fn apply(config: Config) void {
    // ATtiny25/45/85 datasheet, section 17.13.1: ADMUX packs reference,
    // left-adjust, and channel selection in one register.
    regs.write(regs.ADMUX, (@as(u8, @intFromEnum(config.reference)) << 4) |
        (@as(u8, @intFromBool(config.left_adjust)) << 5) |
        @as(u8, @intFromEnum(config.channel)));

    regs.write(regs.ADCSRA, regs.bit(regs.adc_bits.aden) |
        (@as(u8, @intFromBool(config.auto_trigger)) << regs.adc_bits.adate) |
        (@as(u8, @intFromBool(config.interrupt)) << regs.adc_bits.adie) |
        @as(u8, @intFromEnum(config.prescaler)));
}

pub inline fn use_adc_noise_reduction_sleep() void {
    sleep.set_mode(.adc_noise_reduction);
}

pub inline fn start() void {
    regs.set_bits(regs.ADCSRA, regs.bit(regs.adc_bits.adsc));
}

pub inline fn stop() void {
    regs.clear_bits(regs.ADCSRA, regs.bit(regs.adc_bits.aden));
}

pub inline fn conversion_running() bool {
    return (regs.read(regs.ADCSRA) & regs.bit(regs.adc_bits.adsc)) != 0;
}

pub inline fn enable_digital_input(channel: Channel, enabled: bool) void {
    const mask: u8 = switch (channel) {
        .adc0 => 1 << 5,
        .adc1 => 1 << 2,
        .adc2 => 1 << 4,
        .adc3 => 1 << 3,
        else => 0,
    };
    if (enabled) regs.clear_bits(regs.DIDR0, mask) else regs.set_bits(regs.DIDR0, mask);
}

pub inline fn read_left_adjusted10() u16 {
    const low = regs.read(regs.ADCL);
    const high = regs.read(regs.ADCH);
    return (@as(u16, high) << 2) | (@as(u16, low) >> 6);
}

pub inline fn read_raw16() u16 {
    const low = regs.read(regs.ADCL);
    const high = regs.read(regs.ADCH);
    return (@as(u16, high) << 8) | low;
}

pub inline fn clear_interrupt_flag() void {
    regs.set_bits(regs.ADCSRA, regs.bit(regs.adc_bits.adif));
}
