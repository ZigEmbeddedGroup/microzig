//!
//! Implements a simple polling button driver that uses a debouncing technique.
//!

const std = @import("std");
const mdf = @import("../framework.zig");

pub const Event = enum {
    /// Nothing has changed.
    idle,

    /// The button was pressed. Will only trigger once per press.
    /// Use `Button.isPressed()` to check if the button is currently held.
    pressed,

    /// The button was released. Will only trigger once per release.
    /// Use `Button.isPressed()` to check if the button is currently held.
    released,
};

pub fn DebouncedButton(
    /// The active state for the button. Use `.high` for active-high, `.low` for active-low.
    comptime active_state: mdf.DigitalIO.State,
    /// Optional filter depth for debouncing. If `null` is passed, 16 samples are used to debounce the button,
    /// otherwise the given number of samples is used.
    comptime filter_depth: ?comptime_int,
) type {
    return DebouncedButton_Generic(mdf.DigitalIO, active_state, filter_depth);
}

pub fn DebouncedButton_Generic(
    /// The GPIO pin the button is connected to. Will be initialized when calling Button.init
    comptime DigitalIO: type,
    /// The active state for the button. Use `.high` for active-high, `.low` for active-low.
    comptime active_state: mdf.DigitalIO.State,
    /// Optional filter depth for debouncing. If `null` is passed, 16 samples are used to debounce the button,
    /// otherwise the given number of samples is used.
    comptime filter_depth: ?comptime_int,
) type {
    return struct {
        const Button = @This();
        const DebounceFilter = std.meta.Int(.unsigned, filter_depth orelse 16);

        io: DigitalIO,
        debounce: DebounceFilter,
        state: mdf.DigitalIO.State,

        pub fn init(io: DigitalIO) !Button {
            try io.setBias(active_state.invert());
            try io.setDirection(.input);
            return Button{
                .io = io,
                .debounce = 0,
                .state = try io.read(),
            };
        }

        /// Polls for the button state. Returns the change event for the button if any.
        pub fn poll(self: *Button) !Event {
            const state = try self.io.read();
            const active_unfiltered = (state == active_state);

            const previous_debounce = self.debounce;
            self.debounce <<= 1;
            if (active_unfiltered) {
                self.debounce |= 1;
            }

            if (active_unfiltered and previous_debounce == 0) {
                return .pressed;
            } else if (!active_unfiltered and self.debounce == 0 and previous_debounce != 0) {
                return .released;
            } else {
                return .idle;
            }
        }

        /// Returns `true` when the button is pressed.
        /// Will only be updated when `poll` is regularly called.
        pub fn is_pressed(self: *Button) bool {
            return (self.debounce != 0);
        }
    };
}
