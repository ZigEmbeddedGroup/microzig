const std = @import("std");
const microzig = @import("microzig");

const gpio = microzig.hal.gpio;
const Peripherals = microzig.hal.Peripherals;

pub const Pin = struct {
    port: Peripherals.GPIO,
    number: u4,
    af: u4,
};

pub inline fn pin(port: Peripherals.GPIO, number: u4, af: u4) Pin {
    return .{ .port = port, .number = number, .af = af };
}

/// One row of a peripheral's alternate-function table.
pub fn Group(comptime Instance: type, comptime Function: type) type {
    return struct {
        instance: Instance,
        function: Function,
        pins: []const Pin,
    };
}

/// Shared comptime scan over a grouped AF table.
pub fn af_for(comptime table: anytype, comptime instance: anytype, comptime pin_: gpio.Pin, comptime function: anytype) u4 {
    @setEvalBranchQuota(10_000);
    inline for (table) |group| {
        if (group.instance == instance and group.function == function) {
            inline for (group.pins) |entry| {
                if (entry.port == pin_.gpio and entry.number == pin_.number)
                    return entry.af;
            }
        }
    }
    @compileError(std.fmt.comptimePrint(
        "afio: alternate function mapping not yet implemented for {s}.{s} on {s}{d}",
        .{ @tagName(instance), @tagName(function), @tagName(pin_.gpio), pin_.number },
    ));
}
