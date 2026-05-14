pub const registers = @import("attiny85/registers.zig");

pub const gpio = @import("attiny85/gpio.zig");
pub const timer0 = @import("attiny85/timer0.zig");
pub const timer1 = @import("attiny85/timer1.zig");
pub const adc = @import("attiny85/adc.zig");
pub const watchdog = @import("attiny85/watchdog.zig");
pub const sleep = @import("attiny85/sleep.zig");
pub const pcint = @import("attiny85/pcint.zig");
pub const eeprom = @import("attiny85/eeprom.zig");
pub const progmem = @import("attiny85/progmem.zig");

pub const memory = struct {
    pub const flash_size = 8 * 1024;
    pub const eeprom_size = 512;
    pub const sram_size = 512;
};
