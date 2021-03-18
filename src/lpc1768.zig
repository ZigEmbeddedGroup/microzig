pub const GPIO = extern struct {
    dir: u32, // 0x00
    pad: [3]u32,
    mask: u32, // 0x10
    pin: u32, // 0x14,
    set: u32, // 0x18,
    clr: u32, // 0x1C,
};

pub const gpio = @intToPtr([*]volatile GPIO, 0x2009_C000);
