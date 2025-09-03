const std = @import("std");
const assert = std.debug.assert;

const microzig = @import("microzig");
const peripherals = microzig.chip.peripherals;
const CLOCK = peripherals.CLOCK;

const compatibility = microzig.hal.compatibility;

const version: enum {
    nrf51,
    nrf52,
} = switch (compatibility.chip) {
    .nrf51 => .nrf51,
    .nrf52, .nrf52833, .nrf52840 => .nrf52,
    else => compatibility.unsupported_chip("clocks"),
};

pub const hfxo = struct {
    pub fn start() void {
        switch (version) {
            .nrf51 => {
                CLOCK.TASKS_HFCLKSTART = 1;
                while (CLOCK.EVENTS_HFCLKSTARTED == 0) {}
            },
            .nrf52 => {
                CLOCK.TASKS_HFCLKSTART.write_raw(1);
                while (CLOCK.EVENTS_HFCLKSTARTED.raw == 0) {}
            },
        }
    }

    pub fn stop() void {
        switch (version) {
            .nrf51 => {
                CLOCK.TASKS_HFCLKSTOP = 1;
            },
            .nrf52 => {
                CLOCK.TASKS_HFCLKSTOP.write_raw(1);
            },
        }
    }
};

pub const lfclk = struct {
    const Source = enum(u2) {
        RC = 0,
        Xtal = 1,
        Synth = 2,
    };

    pub fn calibrate() void {
        switch (version) {
            .nrf51 => {
                CLOCK.TASKS_CAL = 1;
                while (CLOCK.EVENTS_DONE == 0) {}
            },
            .nrf52 => {
                CLOCK.TASKS_CAL.write_raw(1);
                // TODO: Check for timeout?
                while (CLOCK.EVENTS_DONE.raw == 0) {}
            },
        }
    }

    pub fn set_source(source: Source) void {
        switch (version) {
            .nrf51 => {
                CLOCK.LFCLKSRC.write(.{
                    .SRC = @enumFromInt(@intFromEnum(source)),
                });
            },
            .nrf52 => {
                CLOCK.LFCLKSRC.write(.{
                    .SRC = @enumFromInt(@intFromEnum(source)),
                    // TODO: Set if external is set?
                    .BYPASS = .Disabled,
                    // .BYPASS = if (source == .Xtal) .Enabled else .Disabled,
                    .EXTERNAL = if (source == .Xtal) .Enabled else .Disabled,
                });
            },
        }
    }

    pub fn get_source() Source {
        return @enumFromInt(@intFromEnum(CLOCK.LFCLKSRC.read().SRC));
    }

    pub fn start() void {
        switch (version) {
            .nrf51 => {
                CLOCK.TASKS_LFCLKSTART = 1;
                while (CLOCK.EVENTS_LFCLKSTARTED == 0) {}
            },
            .nrf52 => {
                CLOCK.TASKS_LFCLKSTART.write_raw(1);
                while (CLOCK.EVENTS_LFCLKSTARTED.raw == 0) {}
            },
        }
    }

    pub fn stop() void {
        switch (version) {
            .nrf51 => {
                CLOCK.TASKS_LFCLKSTOP = 1;
            },
            .nrf52 => {
                CLOCK.TASKS_LFCLKSTOP.write_raw(1);
            },
        }
    }
};
