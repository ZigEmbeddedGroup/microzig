const std = @import("std");
const microzig = @import("microzig");

pub const esp_image = @import("esp_image");

pub const RTOS = @import("hal/RTOS.zig");
pub const cache = @import("hal/cache.zig");
pub const clocks = @import("hal/clocks.zig");
pub const compatibility = @import("hal/compatibility.zig");
pub const drivers = @import("hal/drivers.zig");
pub const gpio = @import("hal/gpio.zig");
pub const efuse = @import("hal/efuse.zig");
pub const i2c = @import("hal/i2c.zig");
pub const radio = @import("hal/radio.zig");
pub const ledc = @import("hal/ledc.zig");
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
    info: struct {
        project_name: []const u8 = "Untitled Project",
        secure_version: u32 = 0,
        version: []const u8 = "0.0.0",
    } = .{},
    rtos: RTOS.Options = .{},
    radio: radio.Options = .{},
};

/// Clock config applied by the default `init()` function of the hal.
pub const clock_config: clocks.Config = .init_comptime(80_000_000);

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

    time.init();
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

// Don't change the name of this export, it is checked by espflash tool. Only
// these fields are populated here. The others will be set by elf2image.
export const esp_app_desc: esp_image.AppDesc linksection(".app_desc") = .{
    .secure_version = microzig.options.hal.info.secure_version,
    .version = str(32, microzig.options.hal.info.version),
    .project_name = str(32, microzig.options.hal.info.project_name),
};

fn str(comptime l: usize, comptime s: []const u8) [l]u8 {
    // l - 1 because we need to add a null byte at the end
    if (s.len > l - 1) {
        @compileError(std.fmt.comptimePrint("string `{s}` doesn't fit in buffer with len {d}", .{ s, l }));
    }

    var buf = std.mem.zeroes([l]u8);
    std.mem.copyForwards(u8, buf[0..s.len], s);
    return buf;
}
