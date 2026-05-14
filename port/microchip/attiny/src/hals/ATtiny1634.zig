pub const registers = @import("attiny1634/registers.zig");

pub const gpio = @import("attiny1634/gpio.zig");
pub const timer0 = @import("attiny1634/timer0.zig");
pub const timer1 = @import("attiny1634/timer1.zig");
pub const adc = @import("attiny1634/adc.zig");
pub const watchdog = @import("attiny1634/watchdog.zig");
pub const pcint = @import("attiny1634/pcint.zig");
pub const eeprom = @import("attiny1634/eeprom.zig");
pub const progmem = @import("attiny85/progmem.zig");

pub const memory = struct {
    pub const flash_size = 16 * 1024;
    pub const eeprom_size = 256;
    pub const sram_size = 1024;
};
