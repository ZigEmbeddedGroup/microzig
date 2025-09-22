const microzig = @import("microzig");
const EXTMEM = microzig.chip.peripherals.EXTMEM;

const compatibility = @import("compatibility.zig");
const rom = @import("rom.zig");

pub fn init() void {
    switch (compatibility.chip) {
        .esp32_c3 => {
            const CACHE_LL_L1_ICACHE_AUTOLOAD = 1 << 2;

            rom.functions.Cache_Enable_ICache(if (EXTMEM.ICACHE_AUTOLOAD_CTRL.read().ICACHE_AUTOLOAD_ENA != 0)
                CACHE_LL_L1_ICACHE_AUTOLOAD
            else
                0);

            EXTMEM.ICACHE_CTRL1.modify(.{
                .ICACHE_SHUT_IBUS = 0,
                .ICACHE_SHUT_DBUS = 0,
            });
        },
    }
}
