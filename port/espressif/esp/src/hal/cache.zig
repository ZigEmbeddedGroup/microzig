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
        // The esp32c6 has a single unified L1 cache that the rom bootloader already brings up
        // before it hands control to a flash mapped image, so there is nothing to enable here.
        // Only make sure none of the buses are shut or bypassed.
        .esp32_c6 => {
            EXTMEM.L1_BYPASS_CACHE_CONF.modify(.{
                .BYPASS_L1_ICACHE0_EN = 0,
                .BYPASS_L1_DCACHE_EN = 0,
            });

            EXTMEM.L1_ICACHE_CTRL.modify(.{
                .L1_ICACHE_SHUT_IBUS0 = 0,
                .L1_ICACHE_SHUT_IBUS1 = 0,
            });

            EXTMEM.L1_CACHE_CTRL.modify(.{
                .L1_CACHE_SHUT_BUS0 = 0,
                .L1_CACHE_SHUT_BUS1 = 0,
            });
        },
    }
}
