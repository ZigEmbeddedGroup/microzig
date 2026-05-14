const regs = @import("registers.zig");

pub const size = 512;

// Type-safe wrapper for raw EEPROM byte offsets.
pub const Address = enum(u16) {
    _,
};

pub inline fn address(value: u16) Address {
    return @enumFromInt(value);
}

pub inline fn is_ready() bool {
    return (regs.read(regs.EECR) & regs.bit(regs.eeprom_bits.eepe)) == 0;
}

pub inline fn busy_wait() void {
    while (!is_ready()) {}
}

pub fn read_byte(addr: Address) u8 {
    busy_wait();
    set_address(addr);
    regs.set_bits(regs.EECR, regs.bit(regs.eeprom_bits.eere));
    return regs.read(regs.EEDR);
}

pub fn write_byte(addr: Address, value: u8) void {
    busy_wait();
    set_address(addr);
    regs.write(regs.EEDR, value);

    // ATtiny25/45/85 datasheet section 5.3.3, page 22: EEMPE must be followed
    // by EEPE within four cycles, matching avr-libc's byte-write primitive.
    // https://ww1.microchip.com/downloads/en/devicedoc/atmel-2586-avr-8-bit-microcontroller-attiny25-attiny45-attiny85_datasheet.pdf
    regs.set_bits(regs.EECR, regs.bit(regs.eeprom_bits.eempe));
    regs.set_bits(regs.EECR, regs.bit(regs.eeprom_bits.eepe));
}

pub fn update_byte(addr: Address, value: u8) void {
    if (read_byte(addr) != value) write_byte(addr, value);
}

pub fn read_slice(addr: Address, dest: []u8) void {
    const base = @intFromEnum(addr);
    for (dest, 0..) |*byte, i| {
        byte.* = read_byte(address(base + @as(u16, @intCast(i))));
    }
}

pub fn update_slice(addr: Address, src: []const u8) void {
    const base = @intFromEnum(addr);
    for (src, 0..) |byte, i| {
        update_byte(address(base + @as(u16, @intCast(i))), byte);
    }
}

fn set_address(addr: Address) void {
    const raw: u16 = @intFromEnum(addr);
    regs.write(regs.EEARL, @truncate(raw));
    regs.write(regs.EEARH, @truncate(raw >> 8));
}
