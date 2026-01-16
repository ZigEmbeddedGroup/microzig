/// Exports for the lwip
/// Required from modules/network/src/include/arch.cc#L26
const std = @import("std");
const microzig = @import("microzig");
const hal = microzig.hal;

/// Time since boot in milliseconds.
export fn lwip_sys_now() u32 {
    const ts = hal.time.get_time_since_boot();
    return @truncate(ts.to_us() / 1000);
}

var rng: ?hal.rand.Ascon = null;

export fn lwip_rand() u32 {
    return switch (hal.compatibility.chip) {
        .RP2350 => hal.rand.trng.random_blocking(),
        .RP2040 => brk: {
            if (rng == null) {
                rng = .init();
            }
            var val: u32 = 0;
            rng.?.fill(std.mem.asBytes(&val));
            break :brk val;
        },
    };
}
