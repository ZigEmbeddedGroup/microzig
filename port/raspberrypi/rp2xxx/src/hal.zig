const builtin = @import("builtin");
const std = @import("std");
const microzig = @import("microzig");
const SIO = microzig.chip.peripherals.SIO;

pub const adc = @import("hal/adc.zig");
pub const bootmeta = @import("hal/bootmeta.zig");
pub const clocks = @import("hal/clocks.zig");
pub const compatibility = @import("hal/compatibility.zig");
pub const cyw43 = @import("hal/cyw43.zig");
pub const cyw49_pio_spi = @import("hal/cyw43_pio_spi.zig");
pub const dcp = switch (compatibility.chip) {
    .RP2040 => @compileError("RP2040 doesn't support DCP"),
    .RP2350 => switch (compatibility.arch) {
        .arm => @import("hal/dcp.zig"),
        .riscv => @compileError("RP2350 riscv doesn't support DCP"),
    },
};
pub const dma = @import("hal/dma.zig");
pub const drivers = @import("hal/drivers.zig");
pub const flash = @import("hal/flash.zig");
pub const gpio = @import("hal/gpio.zig");
pub const multicore = @import("hal/multicore.zig");
pub const mutex = @import("hal/mutex.zig");
pub const pins = @import("hal/pins.zig");
pub const pio = @import("hal/pio.zig");
pub const pwm = @import("hal/pwm.zig");
pub const rand = @import("hal/random.zig");
pub const resets = @import("hal/resets.zig");
pub const rom = @import("hal/rom.zig");
pub const rtc = switch (compatibility.chip) {
    .RP2040 => @import("hal/rtc.zig"),
    .RP2350 => @import("hal/always_on_timer.zig"),
};
pub const spi = @import("hal/spi.zig");
pub const system_timer = @import("hal/system_timer.zig");
pub const i2c = @import("hal/i2c.zig");
pub const time = @import("hal/time.zig");
pub const uart = @import("hal/uart.zig");
pub const usb = @import("hal/usb.zig");
pub const watchdog = @import("hal/watchdog.zig");

comptime {
    // HACK: tests can't access microzig. maybe there's a better way to do this.
    if (!builtin.is_test and compatibility.chip == .RP2350) {
        _ = bootmeta;
    }

    // On the RP2040, we need to import the `atomic.zig` file to export some global
    // functions that are used by the atomic builtins. Other chips have hardware
    // atomics, so we don't need to export those functions for them.
    if (!builtin.is_test and compatibility.chip == .RP2040) {
        _ = @import("hal/atomic.zig");
    }
}

pub const HAL_Options = switch (compatibility.chip) {
    .RP2040 => struct {},
    .RP2350 => struct {
        bootmeta: struct {
            image_def_exe_security: bootmeta.ImageDef.ImageTypeFlags.ExeSecurity = .secure,

            /// Next metadata block to link after image_def. **Last block in
            /// the chain must link back to the first one** (to
            /// `bootmeta.image_def_block`).
            next_block: ?*const anyopaque = null,
        } = .{},

        /// Enable the DCP and export intrinsics. Leads to faster double
        /// precision floating point arithmetic. Ignored on riscv.
        use_dcp: bool = true,
    },
};

/// A default clock configuration with sensible defaults that will work
/// for the majority of use cases. Use this unless you have a specific
/// clock configuration use case that this wont work for (for instance a custom
/// board that does NOT use an external oscillator XOSC as the clock source).
///
/// Users will have to provide their own init() function to override init() below
/// to provide their own custom clock config.
pub const clock_config = clocks.config.preset.default();

pub inline fn init() void {
    init_sequence(clock_config);
}

/// Allows user to easily swap in their own clock config while still
/// using the recommended initialization sequence
pub fn init_sequence(comptime clock_cfg: clocks.config.Global) void {
    if (compatibility.chip == .RP2350 and compatibility.arch == .arm and
        microzig.options.hal.use_dcp)
    {
        // Export double floating point intrinsics
        _ = dcp;

        enable_dcp();
    }

    // Disable the watchdog as a soft reset doesn't disable the WD automatically!
    watchdog.disable();

    // Clear all spinlocks as they may be left in a locked state following a
    // soft reset

    for (0..32) |i| {
        multicore.Spinlock.init(@as(u5, @intCast(i))).unlock();
    }

    // Reset all peripherals to put system into a known state, - except
    // for QSPI pads and the XIP IO bank, as this is fatal if running from
    // flash - and the PLLs, as this is fatal if clock muxing has not been
    // reset on this boot - and USB, syscfg, as this disturbs USB-to-SWD
    // on core 1
    resets.reset_block(resets.masks.init);

    // Remove reset from peripherals which are clocked only by clk_sys and
    // clk_ref. Other peripherals stay in reset until we've configured
    // clocks.
    resets.unreset_block_wait(resets.masks.clocked_by_sys_and_ref);

    clocks.default_startup_procedure(clock_cfg);

    // Peripheral clocks should now all be running
    resets.unreset_block_wait(resets.masks.all);
}

/// Enables dcp on RP2350 arm.
///
/// NOTE: Called automatically in the hal startup sequence and in core1
/// startup.
pub inline fn enable_dcp() void {
    if (!(compatibility.chip == .RP2350 and compatibility.arch == .arm)) {
        @compileError("DCP is only available on RP2350 arm");
    }

    // enable the DCP for the current core
    microzig.cpu.peripherals.scb.CPACR.modify(.{
        .CP4 = .full_access,
    });
}

pub fn get_cpu_id() u32 {
    return SIO.CPUID.read().CPUID;
}

var board_id: ?[8]u8 = null;

/// Unique board identifier.
/// On an RP2040-based board, the unique identifier is retrieved from the
/// external NOR flash device
/// On an RP2350-based board, the unique identifier is retrieved from OTP
/// memory.
pub fn get_board_id() [8]u8 {
    if (board_id) |b| {
        return b;
    }
    board_id = switch (compatibility.chip) {
        .RP2040 => flash.id(),
        .RP2350 => rom.get_board_id(),
    };
    return board_id.?;
}

test "hal tests" {
    _ = pio;
    _ = usb;
    _ = i2c;
    _ = uart;
    _ = mutex;
}
