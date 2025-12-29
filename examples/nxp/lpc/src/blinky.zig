const std = @import("std");
const microzig = @import("microzig");

const chip = microzig.chip;

// LED-1: P1.18
// LED-2: P1.20
// LED-3: P1.21
// LED-4: P1.23

const conn = chip.peripherals.PINCONNECT;
const gpio: *volatile [5]PatchedGpio = @ptrCast(@alignCast(chip.peripherals.GPIO));

const led_mask = [4]u32{
    (1 << 18),
    (1 << 20),
    (1 << 21),
    (1 << 23),
};
const all_mask = led_mask[0] | led_mask[1] | led_mask[2] | led_mask[3];

pub fn main() !void {
    conn.PINSEL3.modify(.{
        .P1_18 = .GPIO_P1,
        .P1_20 = .GPIO_P1,
        .P1_21 = .GPIO_P1,
        .P1_23 = .GPIO_P1,
    });

    const p1 = &gpio[1];

    p1.dir = all_mask;

    while (true) {
        for (led_mask) |mask| {
            p1.pin_clr = (all_mask & ~mask);
            p1.pin_set = mask;
            busy_sleep(100_000);
        }
    }
}

const PatchedGpio = extern struct {
    dir: u32, // 0x2009 C000
    __padding0: u32, // 0x2009 C004
    __padding1: u32, // 0x2009 C008
    __padding2: u32, // 0x2009 C00C
    mask: u32, // 0x2009 C010
    pin: u32, // 0x2009 C014
    pin_set: u32, // 0x2009 C018
    pin_clr: u32, // 0x2009 C01C

    comptime {
        std.debug.assert(@sizeOf(PatchedGpio) == 0x20);
    }
};

pub fn busy_sleep(comptime limit: comptime_int) void {
    if (limit <= 0) @compileError("limit must be non-negative!");

    comptime var bits = 0;
    inline while ((1 << bits) <= limit) {
        bits += 1;
    }

    const I = std.meta.Int(.unsigned, bits);

    var i: I = 0;
    while (i < limit) : (i += 1) {
        @import("std").mem.doNotOptimizeAway(i);
    }
}
