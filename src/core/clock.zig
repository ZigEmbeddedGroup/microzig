const std = @import("std");
const root = @import("root");
const micro = @import("microzig.zig");

/// An enumeration of clock sources.
pub const Source = enum {
    none,
    application,
    board,
    chip,
    cpu,
};

/// Is `true` when microzig has a clock frequency available.
/// Clock can be provided by several clock sources
pub const has_clock = (clock_source_type != void);

/// Returns `true` when the frequency can change at runtime.
pub const is_dynamic = has_clock and !@typeInfo(@TypeOf(&@field(clock_source_type, freq_decl_name))).Pointer.is_const;

/// Contains the source which provides microzig with clock information.
pub const source: Source = switch (clock_source_type) {
    root => .application,
    micro.board => .board,
    micro.chip => .chip,
    micro.cpu => .cpu,
    no_clock_source_type => .none,
    else => unreachable,
};

/// Ensures that microzig has a clock available. This will @compileError when no clock is available, otherwise, it will be a no-op.
pub fn ensure() void {
    if (!has_clock)
        @compileError("microzig requires the clock frequency to perform this operation. Please export a const or var cpu_frequency from your root file that contains the cpu frequency in hertz!");
}

/// Returns the current cpu frequency in hertz.
pub inline fn get() u32 {
    ensure();
    return @field(clock_source_type, freq_decl_name);
}

const freq_decl_name = "cpu_frequency";

const no_clock_source_type = opaque {};
const clock_source_type = if (@hasDecl(root, freq_decl_name))
    root
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
