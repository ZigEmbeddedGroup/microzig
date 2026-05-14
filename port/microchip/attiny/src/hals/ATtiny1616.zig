pub const registers = @import("attiny1616/registers.zig");
pub const gpio = @import("attiny1616/gpio.zig");
pub const clock = @import("attiny1616/clock.zig");
pub const tca0 = @import("attiny1616/tca0.zig");
pub const rtc_pit = @import("attiny1616/rtc_pit.zig");
pub const adc = @import("attiny1616/adc.zig");
pub const pcint = @import("attiny1616/pcint.zig");
pub const watchdog = @import("attiny1616/watchdog.zig");
pub const eeprom = @import("attiny1616/eeprom.zig");
pub const progmem = @import("attiny85/progmem.zig");

pub const memory = struct {
    pub const flash_size = 16 * 1024;
    pub const eeprom_size = 256;
    pub const sram_size = 2048;
};
