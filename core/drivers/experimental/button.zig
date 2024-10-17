const std = @import("std");
const micro = @import("microzig");

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

pub fn Button(
    /// The GPIO pin the button is connected to. Will be initialized when calling Button.init
    comptime gpio: type,
    /// The active state for the button. Use `.high` for active-high, `.low` for active-low.
    comptime active_state: micro.gpio.State,
    /// Optional filter depth for debouncing. If `null` is passed, 16 samples are used to debounce the button,
    /// otherwise the given number of samples is used.
    comptime filter_depth: ?comptime_int,
) type {
    return struct {
        const Self = @This();
        const DebounceFilter = std.meta.Int(.unsigned, filter_depth orelse 16);

        debounce: DebounceFilter,
        state: micro.gpio.State,

        pub fn init() Self {
            gpio.init();
            return Self{
                .debounce = 0,
                .state = gpio.read(),
            };
        }

        /// Polls for the button state. Returns the change event for the button if any.
        pub fn poll(self: *Self) Event {
            const state = gpio.read();
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
        pub fn is_pressed(self: *Self) bool {
            return (self.debounce != 0);
        }
    };
}
