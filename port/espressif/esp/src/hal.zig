const microzig = @import("microzig");

pub const cache = @import("hal/cache.zig");
pub const clocks = @import("hal/clocks.zig");
pub const compatibility = @import("hal/compatibility.zig");
pub const drivers = @import("hal/drivers.zig");
pub const gpio = @import("hal/gpio.zig");
pub const i2c = @import("hal/i2c.zig");
pub const radio = @import("hal/radio.zig");
pub const rng = @import("hal/rng.zig");
pub const rom = @import("hal/rom.zig");
pub const spi = @import("hal/spi.zig");
pub const system = @import("hal/system.zig");
pub const systimer = @import("hal/systimer.zig");
pub const time = @import("hal/time.zig");
pub const uart = @import("hal/uart.zig");
pub const usb_serial_jtag = @import("hal/usb_serial_jtag.zig");

comptime {
    // export atomic intrinsics
    _ = @import("hal/atomic.zig");
}

pub const HAL_Options = struct {
    radio: ?radio.Options = null,
};

/// Clock config applied by the default `init()` function of the hal.
pub const clock_config: clocks.Config = .init_comptime(160_000_000);

pub fn init() void {
    init_sequence(clock_config);
}

/// Allows you to easily swap the clock config while using the recommended init sequence. To be used
/// with a custom `init()` function.
pub fn init_sequence(clock_cfg: clocks.Config) void {
    cache.init();

    // TODO: disable watchdogs in a more elegant way (with a hal).
    disable_watchdogs();

    clock_cfg.apply();

    system.init();

    time.initialize();
}

// NOTE: might be esp32c3 specific only + temporary until timers hal.
fn disable_watchdogs() void {
    const peripherals = microzig.chip.peripherals;
    const TIMG0 = peripherals.TIMG0;
    const RTC_CNTL = peripherals.RTC_CNTL;

    const dogfood = 0x50D83AA1;
    const super_dogfood = 0x8F1D312A;

    // Feed and disable watchdog 0
    TIMG0.WDTWPROTECT.raw = dogfood;
    TIMG0.WDTCONFIG0.raw = 0;
    TIMG0.WDTWPROTECT.raw = 0;

    // Feed and disable rtc watchdog
    RTC_CNTL.WDTWPROTECT.raw = dogfood;
    RTC_CNTL.WDTCONFIG0.raw = 0;
    RTC_CNTL.WDTWPROTECT.raw = 0;

    // Feed and disable rtc super watchdog
    RTC_CNTL.SWD_WPROTECT.raw = super_dogfood;
    RTC_CNTL.SWD_CONF.modify(.{ .SWD_DISABLE = 1 });
    RTC_CNTL.SWD_WPROTECT.raw = 0;
}
