const regs = @import("registers.zig");

pub const Channel = enum(u8) {
    ain0 = 0x00,
    ain1 = 0x01,
    ain2 = 0x02,
    ain3 = 0x03,
    ain4 = 0x04,
    ain5 = 0x05,
    ain6 = 0x06,
    ain7 = 0x07,
    ain8 = 0x08,
    ain9 = 0x09,
    ain10 = 0x0A,
    ain11 = 0x0B,
    dac0 = 0x1C,
    internal_reference = 0x1D,
    temperature = 0x1E,
    ground = 0x1F,
};

pub const Reference = enum(u8) {
    vdd = 0x00,
    internal_0v55 = 0x10,
    internal_1v1 = 0x20,
    internal_2v5 = 0x30,
    internal_4v3 = 0x40,
    internal_1v5 = 0x50,
};

pub const SampleCount = enum(u8) {
    samples1 = 0x00,
    samples2 = 0x01,
    samples4 = 0x02,
    samples8 = 0x03,
    samples16 = 0x04,
    samples32 = 0x05,
    samples64 = 0x06,
};

pub const Prescaler = enum(u8) {
    div2 = 0x00,
    div4 = 0x01,
    div8 = 0x02,
    div16 = 0x03,
    div32 = 0x04,
    div64 = 0x05,
    div128 = 0x06,
    div256 = 0x07,
};

pub const InitialDelay = enum(u8) {
    cycles0 = 0x00,
    cycles16 = 0x20,
    cycles32 = 0x40,
    cycles64 = 0x60,
    cycles128 = 0x80,
    cycles256 = 0xA0,
};

pub const Config = struct {
    channel: Channel = .ain0,
    reference: Reference = .vdd,
    sample_count: SampleCount = .samples1,
    prescaler: Prescaler = .div16,
    initial_delay: InitialDelay = .cycles0,
    sample_capacitance: bool = false,
    freerun: bool = false,
    run_standby: bool = false,
    sample_control: u8 = 0,
};

pub fn configure(config: Config) void {
    regs.write(regs.adc0_ctrla, 0);
    regs.write(regs.vref_ctrla, @intFromEnum(config.reference));
    regs.write(regs.adc0_muxpos, @intFromEnum(config.channel));
    regs.write(regs.adc0_ctrlb, @intFromEnum(config.sample_count));
    regs.write(regs.adc0_ctrlc, @intFromEnum(config.prescaler) | if (config.sample_capacitance) regs.bit(regs.adc_bits.sample_capacitance) else 0);
    regs.write(regs.adc0_ctrld, @intFromEnum(config.initial_delay));
    regs.write(regs.adc0_sampctrl, config.sample_control);

    var ctrla = regs.bit(regs.adc_bits.enable);
    if (config.freerun) ctrla |= regs.bit(regs.adc_bits.freerun);
    if (config.run_standby) ctrla |= regs.bit(regs.adc_bits.runstby);
    regs.write(regs.adc0_ctrla, ctrla);
}

pub fn start() void {
    regs.write(regs.adc0_command, regs.bit(regs.adc_bits.start));
}

pub fn stop() void {
    regs.clearBits(regs.adc0_ctrla, regs.bit(regs.adc_bits.enable));
}

pub fn resultReady() bool {
    return (regs.read(regs.adc0_intflags) & regs.bit(regs.adc_bits.resrdy)) != 0;
}

pub fn clearResultReady() void {
    regs.write(regs.adc0_intflags, regs.bit(regs.adc_bits.resrdy));
}

pub fn enableResultReadyInterrupt() void {
    regs.setBits(regs.adc0_intctrl, regs.bit(regs.adc_bits.resrdy));
}

pub fn disableResultReadyInterrupt() void {
    regs.clearBits(regs.adc0_intctrl, regs.bit(regs.adc_bits.resrdy));
}

pub fn readRaw16() u16 {
    return regs.mem16(regs.adc0_res).*;
}
