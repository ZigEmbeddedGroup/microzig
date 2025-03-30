pub const ets_delay_us: *const fn (us: u32) callconv(.c) void = @ptrFromInt(0x40000050);
pub const ets_update_cpu_frequency: *const fn (ticks_per_us: u32) callconv(.c) void = @ptrFromInt(0x40000588);
pub const rom_i2c_readReg: *const fn (block: u8, block_hostid: u8, reg_add: u8) callconv(.c) u8 = @ptrFromInt(0x40001954);
pub const rom_i2c_writeReg: *const fn (block: u8, block_hostid: u8, reg_add: u8, indata: u8) callconv(.c) void = @ptrFromInt(0x4000195c);
