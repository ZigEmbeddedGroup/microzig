const regs = @import("registers.zig");

pub const Period = enum(u8) {
    off = 0x00,
    cycles4 = 0x08,
    cycles8 = 0x10,
    cycles16 = 0x18,
    cycles32 = 0x20,
    cycles64 = 0x28,
    cycles128 = 0x30,
    cycles256 = 0x38,
    cycles512 = 0x40,
    cycles1024 = 0x48,
    cycles2048 = 0x50,
    cycles4096 = 0x58,
    cycles8192 = 0x60,
    cycles16384 = 0x68,
    cycles32768 = 0x70,
};

pub fn configure(period: Period, interrupt: bool) void {
    // ATtiny1614/1616/1617 DS40002204A section 23.5.1, page 296:
    // check PIT synchronization, set PI if needed, select PERIOD, then set PITEN.
    // https://ww1.microchip.com/downloads/en/DeviceDoc/ATtiny1614-16-17-DataSheet-DS40002204A.pdf
    while (busy()) {}
    regs.write(regs.rtc_pitctrla, @intFromEnum(period) | regs.bit(regs.rtc_bits.piten));
    regs.write(regs.rtc_pitintctrl, if (interrupt) regs.bit(regs.rtc_bits.pi) else 0);
}

pub fn stop() void {
    while (busy()) {}
    regs.write(regs.rtc_pitctrla, 0);
}

pub fn busy() bool {
    return (regs.read(regs.rtc_pitstatus) & regs.bit(regs.rtc_bits.ctrlbusy)) != 0;
}

pub fn clearInterruptFlag() void {
    regs.write(regs.rtc_pitintflags, regs.bit(regs.rtc_bits.pi));
}
