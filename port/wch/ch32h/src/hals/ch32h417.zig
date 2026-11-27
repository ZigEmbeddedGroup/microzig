const microzig = @import("microzig");

pub const peripherals = microzig.chip.peripherals;

pub const drivers = struct {};

pub fn init() void {}

pub const Peripherals = @import("Peripherals.zig");
pub const gpio = @import("gpio.zig");
pub const afio = @import("afio.zig");
pub const clocks = @import("clocks.zig");
pub const time = @import("time.zig");
pub const dma = @import("dma.zig");
pub const usart = @import("usart.zig");
pub const spi = @import("spi.zig");
