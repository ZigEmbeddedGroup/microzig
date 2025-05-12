const microzig = @import("microzig");
const compatibility = microzig.hal.compatibility;

/// Microsecond delay using rom function.
pub fn delay_us(us: u32) void {
    switch (compatibility.chip) {
        .esp32_c3 => functions.ets_delay_us(us),
    }
}

pub const functions = switch (compatibility.chip) {
    .esp32_c3 => struct {
        pub extern fn ets_delay_us(us: u32) callconv(.c) void;
        pub extern fn ets_update_cpu_frequency(ticks_per_us: u32) callconv(.c) void;
        pub extern fn rom_i2c_readReg(block: u8, block_hostid: u8, reg_add: u8) callconv(.c) u8;
        pub extern fn rom_i2c_writeReg(block: u8, block_hostid: u8, reg_add: u8, indata: u8) callconv(.c) void;
    },
};
