const regs = @import("registers.zig");

pub const ClockSelect = enum(u8) {
    div1 = 0x00,
    div2 = 0x02,
    div4 = 0x04,
    div8 = 0x06,
    div16 = 0x08,
    div64 = 0x0A,
    div256 = 0x0C,
    div1024 = 0x0E,
};

pub const Waveform = enum(u8) {
    normal = 0x0,
    frequency = 0x1,
    single_slope = 0x3,
    dual_slope_top = 0x5,
    dual_slope_top_bottom = 0x6,
    dual_slope_bottom = 0x7,
};

pub const PwmConfig = struct {
    top: u16 = 255,
    compare0: u16 = 0,
    compare1: u16 = 0,
    enable_compare0: bool = true,
    enable_compare1: bool = true,
    waveform: Waveform = .dual_slope_bottom,
    clock: ClockSelect = .div1,
};

// ATtiny1614/1616/1617 DS40002204A section 20.3.3.4.4, page 183:
// dual-slope PWM uses PER as TOP and CMPn as duty cycle. Buffered PER/CMP
// writes keep active PWM updates clean for dual-channel LED drivers.
// https://ww1.microchip.com/downloads/en/DeviceDoc/ATtiny1614-16-17-DataSheet-DS40002204A.pdf
pub fn configurePwm(config: PwmConfig) void {
    regs.write(regs.tca0_single_ctrla, 0);
    setTop(config.top);
    setCompare0(config.compare0);
    setCompare1(config.compare1);

    var ctrlb: u8 = @intFromEnum(config.waveform);
    if (config.enable_compare0) ctrlb |= regs.bit(regs.tca_bits.cmp0en);
    if (config.enable_compare1) ctrlb |= regs.bit(regs.tca_bits.cmp1en);

    regs.write(regs.tca0_single_ctrlb, ctrlb);
    regs.write(regs.tca0_single_ctrla, @intFromEnum(config.clock) | regs.bit(regs.tca_bits.enable));
}

pub fn stop() void {
    regs.clearBits(regs.tca0_single_ctrla, regs.bit(regs.tca_bits.enable));
}

pub fn setTop(value: u16) void {
    regs.mem16(regs.tca0_single_perbuf).* = value;
}

pub fn setCompare0(value: u16) void {
    regs.mem16(regs.tca0_single_cmp0buf).* = value;
}

pub fn setCompare1(value: u16) void {
    regs.mem16(regs.tca0_single_cmp1buf).* = value;
}

pub fn setCounter(value: u16) void {
    regs.mem16(regs.tca0_single_cnt).* = value;
}

pub fn enableOverflowInterrupt() void {
    regs.setBits(regs.tca0_single_intctrl, regs.bit(regs.tca_bits.ovf));
}

pub fn clearOverflowFlag() void {
    regs.write(regs.tca0_single_intflags, regs.bit(regs.tca_bits.ovf));
}
