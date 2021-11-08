const std = @import("std");
const micro = @import("microzig.zig");
const chip = @import("chip");
const board = @import("board");

/// Returns a type that will manage the Pin defined by `spec`.
/// Spec is either the pin as named in the datasheet of the chip
/// or, if a board is present, as named on the board.
///
/// When a name conflict happens, pin names can be prefixed with `board:`
/// to force-select a pin from the board and with `chip:` to force-select
/// the pin from the chip.
pub fn Pin(comptime spec: []const u8) type {
    // TODO: Depened on board and chip here

    // Pins can be namespaced with "Board:" for board and "Chip:" for chip
    const pin = if (std.mem.startsWith(u8, spec, "board:"))
        chip.parsePin(@field(board.pin_map, spec))
    else if (std.mem.startsWith(u8, spec, "chip:"))
        chip.parsePin(spec)
    else if (micro.config.has_board and @hasField(@TypeOf(board.pin_map), spec))
        chip.parsePin(@field(board.pin_map, spec))
    else
        chip.parsePin(spec);

    return struct {
        pub const name = spec;
        pub const source_pin = pin;

        pub fn route(comptime target: pin.Targets) void {
            chip.routePin(source_pin, target);
        }
    };
}
