const std = @import("std");
const micro = @import("microzig.zig");
const chip = @import("chip");

/// An enumeration of clock sources.
pub const Source = enum {
    none,
    application,
    board,
    chip,
    cpu,
};

/// A struct containing the frequency in hertz for each clock domain
pub const Clocks = std.enums.EnumFieldStruct(chip.clock.Domain, u32, null);

/// Is `true` when microzig has a clock frequency available.
/// Clock can be provided by several clock sources
pub const has_clock = (clock_source_type != void);

/// Returns `true` when the frequency can change at runtime.
pub const is_dynamic = has_clock and !@typeInfo(@TypeOf(&@field(clock_source_type, freq_decl_name))).Pointer.is_const;

/// Contains the source which provides microzig with clock information.
pub const source: Source = switch (clock_source_type) {
    micro.app => .application,
    micro.board => .board,
    micro.chip => .chip,
    micro.cpu => .cpu,
    no_clock_source_type => .none,
    else => unreachable,
};

/// Ensures that microzig has a clock available. This will @compileError when no clock is available, otherwise, it will be a no-op.
pub fn ensure() void {
    if (!has_clock)
        @compileError("microzig requires the clock frequency to perform this operation. Please export a const or var clock_frequencies from your root file that contains the clock frequency for all chip clock domains in hertz!");
}

/// Returns the Clocks struct, with all clock domains frequencies in hertz.
pub inline fn get() Clocks {
    ensure();
    return @field(clock_source_type, freq_decl_name);
}

const freq_decl_name = "clock_frequencies";

const no_clock_source_type = opaque {};
const clock_source_type = if (@hasDecl(micro.app, freq_decl_name))
    micro.app
else if (micro.config.has_board and @hasDecl(micro.board, freq_decl_name))
    micro.board
else if (@hasDecl(micro.chip, freq_decl_name))
    micro.chip
else if (@hasDecl(micro.cpu, freq_decl_name))
    micro.cpu
else
    no_clock_source_type;

comptime {
    if (source != .application) {
        if (is_dynamic)
            @compileError("clock source " ++ @tagName(source) ++ " is not allowed to be dynamic. Only the application (root file) is allowed to provide a dynamic clock frequency!");
    }
}
