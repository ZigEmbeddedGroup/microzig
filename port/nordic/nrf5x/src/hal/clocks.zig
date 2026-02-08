const std = @import("std");

const microzig = @import("microzig");
const CLOCK = microzig.chip.peripherals.CLOCK;

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
        CLOCK.TASKS_HFCLKSTART.raw = 1;
        while (CLOCK.EVENTS_HFCLKSTARTED.raw == 0) {}
    }

    pub fn stop() void {
        CLOCK.TASKS_HFCLKSTOP.raw = 1;
    }
};

pub const lfclk = struct {
    const Source = union(enum(u2)) {
        RC = 0,
        Xtal: struct {
            external: bool,
            bypass: bool,
        } = 1,
        Synth = 2,
        fn validate(self: @This()) !void {
            // Valid settings:
            // SRC RC, External disabled, Bypass disabled
            // SRC Xtal, External disabled, Bypass disabled
            // SRC Xtal, External enabled, Bypass disabled
            // SRC Xtal, External enabled, Bypass enabled
            // SRC Synth, External disabled, Bypass disabled
            return switch (self) {
                .RC, .Synth => return,
                .Xtal => |v| if (v.bypass and !v.external) error.InvalidSource,
            };
        }
    };

    pub fn calibrate() void {
        CLOCK.TASKS_CAL.raw = 1;
        while (CLOCK.EVENTS_DONE.raw == 0) {}
    }

    pub fn set_source(comptime source: Source) void {
        switch (version) {
            .nrf51 => {
                CLOCK.LFCLKSRC.write(.{
                    .SRC = @enumFromInt(@intFromEnum(source)),
                });
            },
            .nrf52 => {
                comptime source.validate() catch {
                    @compileError("Invalid clock source");
                };
                switch (source) {
                    .RC => CLOCK.LFCLKSRC.write(
                        .{ .SRC = .RC, .BYPASS = .Disabled, .EXTERNAL = .Disabled },
                    ),
                    .Xtal => |x| {
                        CLOCK.LFCLKSRC.write(.{
                            .SRC = .Xtal,
                            .BYPASS = @enumFromInt(@intFromBool(x.bypass)),
                            .EXTERNAL = @enumFromInt(@intFromBool(x.external)),
                        });
                    },
                    .Synth => CLOCK.LFCLKSRC.write(
                        .{ .SRC = .Synth, .BYPASS = .Disabled, .EXTERNAL = .Disabled },
                    ),
                }
            },
        }
    }

    pub fn get_source() Source {
        const source = CLOCK.LFCLKSRC.read();
        switch (version) {
            .nrf51 => {
                return switch (source.SRC) {
                    .RC => .RC,
                    .Xtal => .{ .Xtal = .{ .bypass = false, .external = false } },
                    .Synth => .Synth,
                    else => unreachable,
                };
            },
            .nrf52 => {
                return switch (source.SRC) {
                    .RC => .RC,
                    .Xtal => .{ .Xtal = .{
                        .bypass = if (source.BYPASS == .Enabled) true else false,
                        .external = if (source.EXTERNAL == .Enabled) true else false,
                    } },
                    .Synth => .Synth,
                    else => unreachable,
                };
            },
        }
    }

    pub fn start() void {
        CLOCK.TASKS_LFCLKSTART.raw = 1;
        while (CLOCK.EVENTS_LFCLKSTARTED.raw == 0) {}
    }

    pub fn stop() void {
        CLOCK.TASKS_LFCLKSTOP.raw = 1;
    }
};
