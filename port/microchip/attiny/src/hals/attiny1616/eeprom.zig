const regs = @import("registers.zig");

pub const size = 256;
pub const data_start: u16 = 0x1400;

const command_page_erase_write = 0x03;

// Type-safe wrapper for raw EEPROM byte offsets.
pub const Address = enum(u8) {
    _,

    pub fn from_int(value: u8) Address {
        return @enumFromInt(value);
    }
};

pub fn read_byte(address: Address) u8 {
    return regs.mem8(data_start + @as(u16, @intFromEnum(address))).*;
}

pub fn write_byte(address: Address, value: u8) void {
    busy_wait();
    regs.mem8(data_start + @as(u16, @intFromEnum(address))).* = value;
    execute_command(command_page_erase_write);
}

pub fn update_byte(address: Address, value: u8) void {
    if (read_byte(address) != value) write_byte(address, value);
}

pub fn read_slice(comptime len: usize, start: Address) [len]u8 {
    var out: [len]u8 = undefined;
    for (&out, 0..) |*byte, offset| {
        byte.* = read_byte(@enumFromInt(@intFromEnum(start) + offset));
    }
    return out;
}

pub fn busy_wait() void {
    while ((regs.read(regs.nvmctrl_status) & regs.bit(regs.nvm_bits.eebusy)) != 0) {}
}

fn execute_command(command: u8) void {
    // ATtiny1614/1616/1617 DS40002204A section 9.3.2.4, page 63:
    // write EEPROM through the mapped page buffer, unlock NVMCTRL.CTRLA with
    // CPU.CCP=SPM, then issue the command within four instructions.
    // https://ww1.microchip.com/downloads/en/DeviceDoc/ATtiny1614-16-17-DataSheet-DS40002204A.pdf
    regs.write(regs.ccp, regs.ccp_spm_signature);
    regs.write(regs.nvmctrl_ctrla, command);
}
