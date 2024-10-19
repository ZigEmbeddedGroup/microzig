const std = @import("std");
const hal = @import("hal");
const app = struct {}; // workaround for error: no package named 'app' available within package 'root.microzig'
const board = @import("board");
const cpu = @import("cpu");
const config = @import("config");

/// An enumeration of clock sources.
pub const Source = enum {
    none,
    application,
    board,
    hal,
    cpu,
};

/// A struct containing the frequency in hertz for each clock domain
pub const Clocks = std.enums.EnumFieldStruct(hal.clock.Domain, u32, null);

/// Is `true` when microzig has a clock frequency available.
/// Clock can be provided by several clock sources
pub const has_clock = (clock_source_type != void);

/// Returns `true` when the frequency can change at runtime.
pub const is_dynamic = has_clock and !@typeInfo(@TypeOf(&@field(clock_source_type, freq_decl_name))).Pointer.is_const;

/// Contains the source which provides microzig with clock information.
pub const source: Source = switch (clock_source_type) {
    app => .application,
    board => .board,
    hal => .hal,
    cpu => .cpu,
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
const clock_source_type = if (@hasDecl(app, freq_decl_name))
    app
else if (config.has_board and @hasDecl(board, freq_decl_name))
    board
else if (@hasDecl(hal, freq_decl_name))
    hal
else if (@hasDecl(cpu, freq_decl_name))
    cpu
else
    no_clock_source_type;

comptime {
    if (source != .application) {
        if (is_dynamic)
            @compileError("clock source " ++ @tagName(source) ++ " is not allowed to be dynamic. Only the application (root file) is allowed to provide a dynamic clock frequency!");
    }
}
