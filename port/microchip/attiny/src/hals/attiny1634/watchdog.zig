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
    microzig.interrupt.disable_interrupts();
    reset();

    // ATtiny1634 datasheet section 8.5.2, page 44: WDTCSR changes are
    // configuration-change protected and must follow the CCP signature write.
    // https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-8303-8-bit-AVR-Microcontroller-tinyAVR-ATtiny1634_Datasheet.pdf
    regs.write(regs.CCP, 0xD8);
    regs.write(regs.WDTCSR, control_value(mode, timeout));
    microzig.interrupt.enable_interrupts();
}

pub fn stop() void {
    microzig.interrupt.disable_interrupts();
    reset();
    // ATtiny1634 datasheet section 8.5.2, page 44: WDTCSR changes are
    // configuration-change protected and must follow the CCP signature write.
    // https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-8303-8-bit-AVR-Microcontroller-tinyAVR-ATtiny1634_Datasheet.pdf
    regs.write(regs.CCP, 0xD8);
    regs.write(regs.WDTCSR, 0);
    microzig.interrupt.enable_interrupts();
}

fn control_value(mode: Mode, timeout: Timeout) u8 {
    const raw: u4 = @intFromEnum(timeout);
    const prescaler = (@as(u8, raw & 0b0111)) |
        ((@as(u8, raw >> 3) & 0x1) << regs.watchdog_bits.wdp3);
    return prescaler | switch (mode) {
        .interrupt => regs.bit(regs.watchdog_bits.wdie),
        .reset => regs.bit(regs.watchdog_bits.wde),
        .interrupt_then_reset => regs.bit(regs.watchdog_bits.wdie) | regs.bit(regs.watchdog_bits.wde),
    };
}
