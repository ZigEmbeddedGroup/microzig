const std = @import("std");
const microzig = @import("microzig");
const WATCHDOG = microzig.chip.peripherals.WATCHDOG;
const PSM = microzig.chip.peripherals.PSM;
const hw = @import("hw.zig");
const chip = @import("compatibility.zig").chip;

pub const Config =
    switch (chip) {
    .RP2040 => struct {
        // See errata RP2040-E1, duration ends up getting multiplied by 2 reducing the allowable delay range
        duration_us: u23,
        pause_during_debug: bool,
    },
    .RP2350 => struct {
        duration_us: u24,
        pause_during_debug: bool,
    },
};

var previous_watchdog_delay: ?u24 = null;

/// Configure and enable the watchdog timer
pub fn apply(config: Config) void {
    previous_watchdog_delay = config.duration_us;

    // Disable WD during changing settings
    disable();

    switch (chip) {
        .RP2040 => hw.set_alias(&PSM.WDSEL).write(.{
            .ROSC = 0,
            .XOSC = 0,
            .CLOCKS = 1,
            .RESETS = 1,
            .BUSFABRIC = 1,
            .ROM = 1,
            .SRAM0 = 1,
            .SRAM1 = 1,
            .SRAM2 = 1,
            .SRAM3 = 1,
            .SRAM4 = 1,
            .SRAM5 = 1,
            .XIP = 1,
            .VREG_AND_CHIP_RESET = 1,
            .SIO = 1,
            .PROC0 = 1,
            .PROC1 = 1,
            .padding = 0,
        }),
        .RP2350 => hw.set_alias(&PSM.WDSEL).write(.{
            .PROC_COLD = 1,
            .OTP = 1,
            .ROSC = 0,
            .XOSC = 0,
            .RESETS = 1,
            .CLOCKS = 1,
            .PSM_READY = 1,
            .BUSFABRIC = 1,
            .ROM = 1,
            .BOOTRAM = 1,
            .SRAM0 = 1,
            .SRAM1 = 1,
            .SRAM2 = 1,
            .SRAM3 = 1,
            .SRAM4 = 1,
            .SRAM5 = 1,
            .SRAM6 = 1,
            .SRAM7 = 1,
            .SRAM8 = 1,
            .SRAM9 = 1,
            .XIP = 1,
            .SIO = 1,
            .ACCESSCTRL = 1,
            .PROC0 = 1,
            .PROC1 = 1,
            .padding = 0,
        }),
    }
    // Tell RESETS hardware to reset everything except ROSC/XOSC on a watchdog reset

    // See errata RP2040-E1, duration needs to be multiplied by 2 for RP2040
    const duration: u24 = if (chip == .RP2040) @as(u24, config.duration_us) << 1 else config.duration_us;
    WATCHDOG.LOAD.write(.{
        .LOAD = duration,
        .padding = 0,
    });
    hw.set_alias(&WATCHDOG.CTRL).write(.{
        .TIME = 0,
        .PAUSE_JTAG = if (config.pause_during_debug) 1 else 0,
        .PAUSE_DBG0 = if (config.pause_during_debug) 1 else 0,
        .PAUSE_DBG1 = if (config.pause_during_debug) 1 else 0,
        .reserved30 = 0,
        .ENABLE = 0,
        .TRIGGER = 0,
    });

    enable();
}

/// Used in a scratch register to determine if the reboot was due to a user enabled
/// watchdog reset, or ROM code using the watchdog
const WATCHDOG_NON_REBOOT_MAGIC: usize = 0x6ab73121;

/// Enable (resume) the watchdog timer
pub fn enable() void {
    // Update scratch[4] to distinguish from both the magic number used for rebooting to a
    // specific address, or 0 used to reboot into regular flash path
    WATCHDOG.SCRATCH4.write(.{ .SCRATCH4 = WATCHDOG_NON_REBOOT_MAGIC });

    hw.set_alias(&WATCHDOG.CTRL).write(.{
        .TIME = 0,
        .PAUSE_JTAG = 0,
        .PAUSE_DBG0 = 0,
        .PAUSE_DBG1 = 0,
        .reserved30 = 0,
        .ENABLE = 1,
        .TRIGGER = 0,
    });
}

/// Disable (pause) the watchdog timer
pub inline fn disable() void {
    hw.clear_alias(&WATCHDOG.CTRL).write(.{
        .TIME = 0,
        .PAUSE_JTAG = 0,
        .PAUSE_DBG0 = 0,
        .PAUSE_DBG1 = 0,
        .reserved30 = 0,
        .ENABLE = 1,
        .TRIGGER = 0,
    });
}

/// Update the watchdog delay (pet the watchdog), this should be called periodically
/// to keep the watchdog from triggering
///
/// null for new_delay uses the previously configured delay from apply()
pub fn update(delay_us: ?u24) void {
    var duration_us: u24 = if (delay_us) |nd| nd else if (previous_watchdog_delay) |pd| pd else std.debug.panic("update() called before watchdog configured with apply()", .{});

    // See errata RP2040-E1, duration needs to be multiplied by 2 for RP2040
    if (chip == .RP2040) duration_us = duration_us << 1;
    WATCHDOG.LOAD.write(.{
        .LOAD = duration_us,
        .padding = 0,
    });
}

/// Force a watchdog processor reset to occur
///
/// WARNING: Will reset the MCU!
pub inline fn force() void {
    hw.set_alias(&WATCHDOG.CTRL).write(.{
        .TIME = 0,
        .PAUSE_JTAG = 0,
        .PAUSE_DBG0 = 0,
        .PAUSE_DBG1 = 0,
        .reserved30 = 0,
        .ENABLE = 0,
        .TRIGGER = 1,
    });
}

/// The remaining us until a watchdog triggers
///
/// NOTE: Due to a silicon bug on the RP2040 this always
///       just returns the configured ticks, NOT the remaining
///       ticks. RP2350 functions as expected.
pub fn remaining_us() u24 {
    const rd = WATCHDOG.CTRL.read();
    return switch (chip) {
        .RP2040 => rd.TIME / 2,
        .RP2350 => rd.TIME,
    };
}

const TriggerType = enum {
    UserInitiatedTimer,
    UserInitiatedForce,
    RomInitiatedTimer,
    RomInitiatedForce,
};

/// Check if the watchdog was the reason for the last reboot
///
/// TODO: RP2350 SDK masks this with a ROM function:
///       return watchdog_hw->reason && rom_get_last_boot_type() == BOOT_TYPE_NORMAL;
pub fn caused_reboot() ?TriggerType {
    const scratch4 = WATCHDOG.SCRATCH4.read();
    const reason = WATCHDOG.REASON.read();
    if (reason.TIMER == 0 and reason.FORCE == 0) return null;
    if (scratch4.SCRATCH4 == WATCHDOG_NON_REBOOT_MAGIC) {
        return if (reason.TIMER == 1) .UserInitiatedTimer else .UserInitiatedForce;
    } else {
        return if (reason.TIMER == 1) .RomInitiatedTimer else .RomInitiatedForce;
    }
}
