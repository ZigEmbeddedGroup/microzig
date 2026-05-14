const microzig = @import("microzig");
const regs = @import("registers.zig");

pub const Timeout = enum(u4) {
    ms16 = 0b0000,
    ms32 = 0b0001,
    ms64 = 0b0010,
    ms125 = 0b0011,
    ms250 = 0b0100,
    ms500 = 0b0101,
    s1 = 0b0110,
    s2 = 0b0111,
    s4 = 0b1000,
    s8 = 0b1001,
};

pub const Mode = enum {
    interrupt,
    reset,
    interrupt_then_reset,
};

pub inline fn reset() void {
    asm volatile ("wdr" ::: .{ .memory = true });
}

pub fn configure(mode: Mode, timeout: Timeout) void {
    // ATtiny25/45/85 datasheet section 8.5.2, page 43: WDTCR writes use the
    // WDCE/WDE timed sequence. This mirrors avr-libc's protected update.
    // https://ww1.microchip.com/downloads/en/devicedoc/atmel-2586-avr-8-bit-microcontroller-attiny25-attiny45-attiny85_datasheet.pdf
    microzig.interrupt.disable_interrupts();
    reset();
    regs.setBits(regs.WDTCR, regs.bit(regs.watchdog_bits.wdce) | regs.bit(regs.watchdog_bits.wde));
    regs.write(regs.WDTCR, controlValue(mode, timeout));
    microzig.interrupt.enable_interrupts();
}

pub fn stop() void {
    microzig.interrupt.disable_interrupts();
    reset();
    regs.clearBits(regs.MCUSR, 1 << 3);
    regs.setBits(regs.WDTCR, regs.bit(regs.watchdog_bits.wdce) | regs.bit(regs.watchdog_bits.wde));
    regs.write(regs.WDTCR, 0);
    microzig.interrupt.enable_interrupts();
}

pub fn forceReset(timeout: Timeout) noreturn {
    microzig.interrupt.disable_interrupts();
    regs.write(regs.WDTCR, controlValue(.reset, timeout));
    microzig.interrupt.enable_interrupts();
    reset();
    while (true) asm volatile ("" ::: .{ .memory = true });
}

fn controlValue(mode: Mode, timeout: Timeout) u8 {
    const raw: u4 = @intFromEnum(timeout);
    const prescaler = (@as(u8, raw & 0b0111)) |
        ((@as(u8, raw >> 3) & 0x1) << regs.watchdog_bits.wdp3);
    return prescaler | switch (mode) {
        .interrupt => regs.bit(regs.watchdog_bits.wdie),
        .reset => regs.bit(regs.watchdog_bits.wde),
        .interrupt_then_reset => regs.bit(regs.watchdog_bits.wdie) | regs.bit(regs.watchdog_bits.wde),
    };
}
