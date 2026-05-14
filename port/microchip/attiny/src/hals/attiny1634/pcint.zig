const regs = @import("registers.zig");

pub const Group = enum {
    pcint0_7,
    pcint8_11,
    pcint12_17,
};

pub inline fn enable_group(group: Group) void {
    regs.set_bits(regs.GIMSK, switch (group) {
        .pcint0_7 => 1 << 4,
        .pcint8_11 => 1 << 5,
        .pcint12_17 => 1 << 6,
    });
}

pub inline fn enable_pin(group: Group, bit: u3) void {
    // ATtiny1634 datasheet section 9.3.6, page 53: set PCMSKn plus the
    // corresponding PCIEn group bit in GIMSK to enable a pin-change source.
    // https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-8303-8-bit-AVR-Microcontroller-tinyAVR-ATtiny1634_Datasheet.pdf
    regs.set_bits(mask_register(group), regs.bit(bit));
}

fn mask_register(group: Group) u16 {
    return switch (group) {
        .pcint0_7 => regs.PCMSK0,
        .pcint8_11 => regs.PCMSK1,
        .pcint12_17 => regs.PCMSK2,
    };
}
