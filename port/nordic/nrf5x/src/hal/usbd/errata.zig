//! Errata workarounds
//!
//! References:
//! * https://github.com/nordicsemi/nrfx/blob/nrfx-1.x/master/drivers/src/nrfx_usbd.c
//! * https://github.com/nordicsemi/nrfx/blob/nrfx-1.x/master/mdk/nrf52_erratas.h
//! * https://github.com/nrf-rs/nrf-usbd/blob/main/src/errata.rs

const microzig = @import("microzig");
const compatibility = microzig.hal.compatibility;

const version: enum {
    nrf52833,
    nrf52840,
} = switch (compatibility.chip) {
    .nrf52833 => .nrf52833,
    .nrf52840 => .nrf52840,
    else => compatibility.unsupported_chip("usbd"),
};

inline fn reg(addr: usize) *volatile u32 {
    return @ptrFromInt(addr);
}

pub fn pre_enable() void {
    if (errata_187_applies()) {
        if (reg(0x4006EC00).* == 0x00000000) {
            reg(0x4006EC00).* = 0x00009375;
            reg(0x4006ED14).* = 0x00000003;
            reg(0x4006EC00).* = 0x00009375;
        } else {
            reg(0x4006ED14).* = 0x00000003;
        }
    }

    pre_wakeup();
}

pub fn post_enable() void {
    post_wakeup();

    if (errata_187_applies()) {
        if (reg(0x4006EC00).* == 0x00000000) {
            reg(0x4006EC00).* = 0x00009375;
            reg(0x4006ED14).* = 0x00000000;
            reg(0x4006EC00).* = 0x00009375;
        } else {
            reg(0x4006ED14).* = 0x00000000;
        }
    }
}

pub fn pre_wakeup() void {
    if (errata_171_applies()) {
        if (reg(0x4006EC00).* == 0x00000000) {
            reg(0x4006EC00).* = 0x00009375;
            reg(0x4006EC14).* = 0x000000C0;
            reg(0x4006EC00).* = 0x00009375;
        } else {
            reg(0x4006EC14).* = 0x000000C0;
        }
    }
}

pub fn post_wakeup() void {
    if (errata_171_applies()) {
        if (reg(0x4006EC00).* == 0x00000000) {
            reg(0x4006EC00).* = 0x00009375;
            reg(0x4006EC14).* = 0x00000000;
            reg(0x4006EC00).* = 0x00009375;
        } else {
            reg(0x4006EC14).* = 0x00000000;
        }
    }
}

/// Applies to nRF52840
inline fn errata_171_applies() bool {
    return switch (version) {
        .nrf52840 => true,
        else => false,
    };
}

// Applies to:
// - nRF52833
// - nRF52840 0x01..0x05 and unknown future variants
inline fn errata_187_applies() bool {
    const variant = @as(*volatile u32, @ptrFromInt(0x10000134)).*;
    return switch (version) {
        .nrf52833 => true,
        .nrf52840 => variant != 0x00,
    };
}
