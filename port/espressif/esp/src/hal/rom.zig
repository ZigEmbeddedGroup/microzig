const compatibility = @import("compatibility.zig");

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

        pub extern fn esp_rom_regi2c_read(block: u8, host_id: u8, reg_add: u8) callconv(.c) u8;
        pub extern fn esp_rom_regi2c_read_mask(block: u8, host_id: u8, reg_add: u8, msb: u8, lsb: u8) callconv(.c) u8;
        pub extern fn esp_rom_regi2c_write(block: u8, host_id: u8, reg_add: u8, data: u8) callconv(.c) void;
        pub extern fn esp_rom_regi2c_write_mask(block: u8, host_id: u8, reg_add: u8, msb: u8, lsb: u8, data: u8) callconv(.c) void;

        pub extern fn Cache_Enable_ICache(autoload: u32) callconv(.c) void;
    },
};
