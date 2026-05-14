const regs = @import("registers.zig");

pub const size = 256;
// Type-safe wrapper for raw EEPROM byte offsets.
pub const Address = enum(u8) { _ };

pub inline fn address(value: u8) Address {
    return @enumFromInt(value);
}

pub inline fn busyWait() void {
    while ((regs.read(regs.EECR) & regs.bit(regs.eeprom_bits.eepe)) != 0) {}
}

pub fn readByte(addr: Address) u8 {
    busyWait();
    regs.write(regs.EEARL, @intFromEnum(addr));
    regs.write(regs.EEARH, 0);
    regs.setBits(regs.EECR, regs.bit(regs.eeprom_bits.eere));
    return regs.read(regs.EEDR);
}

pub fn updateByte(addr: Address, value: u8) void {
    if (readByte(addr) == value) return;
    busyWait();
    regs.write(regs.EEDR, value);

    // ATtiny1634 datasheet section 5.3.4, page 23: EEMPE must be followed by
    // EEPE within four cycles or the byte write is ignored.
    // https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-8303-8-bit-AVR-Microcontroller-tinyAVR-ATtiny1634_Datasheet.pdf
    regs.setBits(regs.EECR, regs.bit(regs.eeprom_bits.eempe));
    regs.setBits(regs.EECR, regs.bit(regs.eeprom_bits.eepe));
}
