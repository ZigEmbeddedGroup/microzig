const regs = @import("registers.zig");

pub const Prescaler = enum(u8) {
    disabled = 0x00,
    div2 = 0x01,
    div4 = 0x03,
    div6 = 0x11,
    div8 = 0x05,
    div10 = 0x13,
    div12 = 0x15,
    div16 = 0x07,
    div24 = 0x17,
    div32 = 0x09,
    div48 = 0x19,
    div64 = 0x0B,
};

pub fn protected_write(comptime address: u16, value: u8) void {
    // ATtiny1614/1616/1617 DS40002204A section 8.5.7.1, page 55:
    // protected I/O writes require CPU.CCP=IOREG and the register write
    // within four instructions.
    // https://ww1.microchip.com/downloads/en/DeviceDoc/ATtiny1614-16-17-DataSheet-DS40002204A.pdf
    regs.write(regs.ccp, regs.ccp_ioreg_signature);
    regs.write(address, value);
}

pub fn set_prescaler(prescaler: Prescaler) void {
    protected_write(regs.clkctrl_mclkctrlb, @intFromEnum(prescaler));
}

pub fn use_default20_m_hz_div2() void {
    set_prescaler(.div2);
}

pub fn oscillator_changing() bool {
    return (regs.read(regs.clkctrl_mclkstatus) & regs.bit(0)) != 0;
}
