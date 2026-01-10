pub const xosc_freq = 12_000_000;

const microzig = @import("microzig");
const hal = microzig.hal;
const pins = hal.pins;

pub const bootrom = @import("shared/rp2040_bootrom.zig");

comptime {
    _ = bootrom;
}

pub const pin_config = pins.GlobalConfiguration{
    .GPIO25 = .{
        .name = "led",
        .function = .SIO,
    },
};
