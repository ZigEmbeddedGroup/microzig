const regs = @import("registers.zig");
const clock = @import("clock.zig");

pub const Period = enum(u8) {
    off = 0x00,
    cycles8 = 0x01,
    cycles16 = 0x02,
    cycles32 = 0x03,
    cycles64 = 0x04,
    cycles128 = 0x05,
    cycles256 = 0x06,
    cycles512 = 0x07,
    cycles1k = 0x08,
    cycles2k = 0x09,
    cycles4k = 0x0A,
    cycles8k = 0x0B,
};

pub fn reset() void {
    asm volatile ("wdr");
}

pub fn configure(period: Period) void {
    while (busy()) {}
    clock.protected_write(regs.wdt_ctrla, @intFromEnum(period));
}

pub fn stop() void {
    configure(.off);
}

pub fn busy() bool {
    return (regs.read(regs.wdt_status) & regs.bit(regs.wdt_bits.syncbusy)) != 0;
}
